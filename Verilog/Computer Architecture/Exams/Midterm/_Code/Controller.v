// Carlos Lazo
// ECE505
// Homework 03

// Controller of 16-bit CPU

`define Reset   2'b00
`define Fetch   2'b01
`define Execute 2'b10
`define Halt    2'b11

`timescale 1ns/100ps

module Controller (
    input [2:0] op_code,
    input clk, reset, zero, multbusy,
    output reg [1:0] ALU_op,
    output reg ACC_ON_DBUS, enACC, enIR, enMC, enMP, enPC, MuxAsel, MuxBsel, multstart,
               rd_mem, wr_mem, st_LSB, st_MSB);
    
  // Define state variables and internal counter:
  
  reg [1:0] present_state, next_state;
  
  reg  [5:0] count = 0;
  
  // Define logic to change state, with a synchronous reset variable:
  
  always @ (posedge clk) begin
    if (reset) present_state <= `Reset;
    else       present_state <= next_state;
      
    if (op_code == 3'b111 || count == 21)
      count = count + 1;
      
    // Once the multiplication process has started, deassert start.
      
    if (count == 2 )
      multstart = 0;
    
    // Always check to see where the BoothMultiplier is in the multiplication process.
    // If the count has exceeded the # of expected states of multiplication, then store
    // both the LSB's and MSB's in memory in specified memory locations in successive clocks.
      
    if (count == 21) begin
      
      rd_mem = 0; st_LSB =  1;  wr_mem = 1; ACC_ON_DBUS = 1; MuxAsel = 1;
      
    end
    
    if (count == 22) begin
      
      st_LSB =  0; rd_mem = 0;
      
      st_MSB =  1; ACC_ON_DBUS = 1; MuxAsel = 1; wr_mem = 1;
                
      next_state = `Fetch;
      
    end
      
  end
  
  // Implement all Controller logic and set all appropriate signals:
  
  always @ (present_state or reset) begin
    
    // Initialize all signals to 0 to prevent latches:
    
    ALU_op = 2'bz; ACC_ON_DBUS = 0; enACC = 0;
    enIR = 0; enMC = 0; enMP = 0; enPC = 0; MuxAsel = 0; MuxBsel = 0;
    rd_mem = 0; wr_mem = 0; st_LSB = 0; st_MSB = 0;
    
    multstart = 0;
    
    case (present_state)

      // Define Reset (idle) state. While Reset == 1, stay in Reset state.
      // Begin fetching instructions once Reset deasserts (becomes 0).      
      
      `Reset : next_state = reset ? `Reset : `Fetch;
          
      // Define Fetch state.  Place the PC address on the addr_bus.
      // By setting rd_mem = 1, place information from mem[PC_addr] on data_bus.
      // Load the 16'b received into the IR, and increment PC by 1.
      
      `Fetch : begin
        
        next_state = `Execute;
        MuxAsel = 0;
        rd_mem  = 1;
        count   = 0;
        
        #2; // Necessary delay needed for memory reading.
    
        enIR = 1;
  
        #1;
        
        MuxAsel = 0; MuxBsel = 1; ALU_op = 2'b11;
        
        #1;
        
        enPC = 1;
      end
        
      // Define Execute state. Perform data analysis based on the op_code.
      
      `Execute: begin
        
        next_state = `Fetch;  // Will always be true, unless `Halt or Opcode = 111 is seen.
        
        case (op_code)
          
          // Define signals for the Load ACC operation.
          
          // Place the IR information on the addr_bus, then read mem[addr_bus]
          // into data_bus. Place data_bus on MuxB, and have it pass through
          // the ALU, then load it into the ACC.
          
          3'b000: begin
            
            MuxAsel = 1;
            rd_mem = 1;
        
            #2; // Necessary delay needed for memory reading.
            
            MuxBsel = 0;
            ALU_op = 2'b00;
            
            #1; // Necessary for ALU resolution.
                      
            enACC = 1;
            
          end
          
          // Define signals for the Store ACC opertion.
          
          // Place current ACC data onto the data_bus.  Place IR data onto the
          // addr_bus.  Write into mem[addr_bus].
          
          3'b001: begin
            
            ACC_ON_DBUS = 1; MuxAsel = 1; wr_mem = 1;
            
          end
          
          // Define signals for adding addressed memory to ACC operation.
          
          // Place the IR information on the addr_bus, then read mem[addr_bus]
          // into the data_bus.  Place data_bus on MuxB, and add it to the current
          // contents of ACC.  Then store results back into ACC.
          
          3'b010: begin
            
            MuxAsel = 1;
            rd_mem = 1;
            
            #2; // Necessary delay needed for memory reading.
            
            MuxBsel = 0; ALU_op = 2'b10;
            
            #1; // Necessary for ALU resolution.
            
            enACC = 1;
            
          end
          
          // Define signals for subtracting addressed memory from ACC operation.
          
          // Place the IR information on the addr_bus, then read mem[addr_bus]
          // into the data_bus.  Place data_bus on MuxB, and subtract it from the 
          // current contents of ACC.  Then store results back into ACC.
          
          3'b011: begin
            
            MuxAsel = 1; rd_mem = 1;
            
            #2; // Necessary delay needed for memory reading.
            
            MuxBsel = 0; ALU_op = 2'b01;
            
            #1; // Necessary for ALU resolution.
            
            enACC = 1; 
            
          end
          
          // Define signals for the unconditional direct jump operation.
          
          // Place the IR information on the addr_bus.  Place addr_bus on MuxB,
          // then pass it through and store it into PC.
          
          3'b100: begin
            MuxAsel = 1;
            
            #1; // Necessary for bus resolution.
            
            MuxBsel = 1; ALU_op = 2'b00;
            
            #1; // Necessary for ALU resolution.
            
            enPC = 1; 
          end
          
          // Define signals for the conditional direct jump operation.
          
          // If the ACC is 0 (based on zero signal), place the IR information
          // on the addr_bus.  Place addr_bus on MuxB, then pass it through and store it into PC.
          
          3'b101: 
          
            if (zero) begin
              
              MuxAsel = 1;
            
              #1; // Necessary for bus resolution.
            
              MuxBsel = 1; ALU_op = 2'b00;
            
              #1; // Necessary for ALU resolution.
            
              enPC = 1;
                
            end
 
          // Define signals for the halt operation.
          
          // If this instruction is seen, the next state is the halt state.
          
          3'b110: next_state = `Halt;
          
          // Define signals for the multiplication operation.
          
          // If this instruction is seen, place data referenced in the IR on the data_bus.
          // Read this data into a register, then multiply it and the ACC.  Store results
          // once the multiplication is done, then proceed back to the execute state.
          
          3'b111: begin
            
            // If this is the first time we are beginning the multiplication operation,
            // setup all registers and control signals accordingly.
            
            if (multbusy == 0 && count < 16) begin
            
              enMC = 1;
              multstart = 1;
            
              MuxAsel = 1;
              rd_mem = 1;
            
              #2; // Necessary delay needed for memory reading.
              
              enMP = 1;
              
            end
            
            
      
              

            // If the count is less than the specified # of expected states of multiplication,
            // continue back to the `Execute state.
              
            if (count < 16) begin
              next_state = `Execute;
            end                  
            
          end    
        endcase
      end
      
      // Define Halt state.  Stay in this state until reset = 1.
      
      `Halt : next_state = reset ? `Reset : `Halt;
      
    endcase
    
  end
  
endmodule