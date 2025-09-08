//And Logic
module AND_Logic(branch, zero, out);
input branch, zero;
output out;

assign out = branch & zero;

endmodule
