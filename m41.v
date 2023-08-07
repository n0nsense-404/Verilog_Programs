module and_gate(
    output wire a,
    input wire b, c, d
);
    assign a = b & c & d;
endmodule

module not_gate(
    output wire f,
    input wire e
);
    assign f = ~e;
endmodule

module or_gate(
    output wire l,
    input wire m, n, o, p
);
    assign l = m | n | o | p;
endmodule

module m41(
    output wire out,
    output wire T1, T2, T3, T4, s0bar, s1bar,
    input wire a, b, c, d, s0, s1
);
    // ...
    not_gate u1(.f(s1bar), .e(s1));
    not_gate u2(.f(s0bar), .e(s0));
    and_gate u3(.a(T1), .b(a), .c(s0bar), .d(s1bar));
    and_gate u4(.a(T2), .b(b), .c(s0), .d(s1bar));
    and_gate u5(.a(T3), .b(c), .c(s0bar), .d(s1));
    and_gate u6(.a(T4), .b(d), .c(s0), .d(s1));
    or_gate u7(.l(out), .m(T1), .n(T2), .o(T3), .p(T4));
endmodule

module top;
    wire out, T1, T2, T3, T4, s0bar, s1bar; // Declare intermediate signals
    reg a, b, c, d, s0, s1;
    
    m41 name(
        .out(out), .a(a), .b(b), .c(c), .d(d), .s0(s0), .s1(s1),
        .T1(T1), .T2(T2), .T3(T3), .T4(T4), .s0bar(s0bar), .s1bar(s1bar) // Connect intermediate signals
    );
    
    initial begin
        $dumpfile("xyz_m41.vcd");
        $dumpvars(0, top); // Dump all variables in the 'top' module
        a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b0;
        s0 = 1'b0; s1 = 1'b0;
        #500 $finish;
    end
    
    always #40 a = ~a;
    always #20 b = ~b;
    always #10 c = ~c;
    always #5 d = ~d;
    always #80 s0 = ~s0;
    always #160 s1 = ~s1;
    
    always @(a or b or c or d or s0 or s1) begin
        $display("At time = %t, Output = %d", $time, out);
    end
endmodule
