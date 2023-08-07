//full adder code: structural model
`timescale 1ns/100ps //optional
module fa ( a, b, c, sum, carry);
input a, b, c;
output sum, carry ;
wire s1, c1, c2; //internal
xor(s1, a, b);
xor(sum, s1, c);
and(c2, s1, c);
and(c1, a, b);
or(carry, c1, c2);
endmodule

//***Testbench Module***
module testb;
reg a, b, c;
wire sum, carry;
fa uut ( .a(a), .b(b),.c(c), .sum(sum), .carry(carry));
initial
begin
$dumpfile("test1_full_adder.vcd");
$dumpvars(); //for gtkwave display
$monitor("a=%b, b=%b, c=%b, carry=%b, sum=%b \n", a, b, c, carry, sum);
a=0; b=0; c=0; //input signals for full adder
#10 a=0; b=0; c=1;
#10 a=0; b=1; c=0;
#10 a=0; b=1; c=1;
#10 a=1; b=0; c=0;
#10 a=1; b=0; c=1;
#10 a=1; b=1; c=0;
#10 a=1; b=1; c=1;
#10 a=0; b=0; c=0;
#10 $finish;
end
endmodule
