module test_halfadder;
    reg a, b;
    wire sum, carry;
    halfadder i_halfadder(a, b, sum, carry);
    initial begin
        $dumpvars();
        a = 0; b = 0;
        #10
        a = 0; b = 1;
        #10
        a = 1; b = 0;
        #10
        a = 1; b = 1;
        $finish();
    end
endmodule
