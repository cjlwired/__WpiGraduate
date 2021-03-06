// Carlos Lazo
// ECE574
// Project 2

// DataPath Design
// DataPort Definition

`timescale 1ns/100ps

// The DataPort is being designed in such a way that it is
// independant of any clock or reset input.

module DataPort (input  [7:0] data_in,
                 input  data_on_bus,
                 output [7:0] data_out,
                 output ready);

  // Asserting the ready signal will be based on whether the router
  // has acknowledged that it is ready to start receiving data.
  // The ready signal will remain 1 until the router transitions
  // into the Forward state of operation.

  assign ready    = data_on_bus ? 1'b1 : 0'b0;
  
  // The data coming into the port will always be available on the output.
  
  assign data_out = data_in;
  
endmodule