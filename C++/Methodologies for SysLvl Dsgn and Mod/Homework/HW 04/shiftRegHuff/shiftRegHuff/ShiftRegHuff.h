// Carlos Lazo
// ECE579D
// Homework 04

#include "logicPrimitives.h"

// Define the ShiftRegHuff Class

class ShiftRegHuff {

  public: 

    // Declare all private member variables of the Shift Register:

    char din   [9]; // Parallel input
    char pout  [9]; // Parallel output
    char clk, rst, m1, m0, sri, sli;
    
    wire w_clk, w_rst;

    int t_Delay;
    int t_Power;

    string in_str;  // Stores input string for printing
    string pr_dff;  // Stores previous flip flop values

    dff    reg [8]; // DFF's that make up Shift Register 
    wire dTemp [9]; // Define temp DFF wires for computation

  public:

    // Public functions that will be executed in order:

    ShiftRegHuff();      // Default Constructor

    void load_input (string);   // Parse input string into private member variables

    void set_output();          // Set all DFF's, based on clock and reset signals.
    string output_reg();        // Formatted output generated for the Shift Register.

};

// Simple class to contain combinational logic for ShiftRegister

class CombLogic {

  public:
    void update_reg(ShiftRegHuff&);
};