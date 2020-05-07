clean:
	rm -r csrc
	rm -r simv.daidir
	rm -f ucli.key
	rm -f simv
compile:
	vcs -full64 -sverilog +lint=all -debug_all -timescale=1ns/10ps ../src/aes_sbox.v ../src/subBytes_top.v ../src/shiftRows_top.v ../src/matrix_mult.v ../src/MixCol_top.v ../src/AddRndKey_top.v ../src/KeySchedule_top.v ../src/AESCore.v ../src/AEScntx.v ../src/AES_top.v ../src/tb_aes.sv
sim:
	./simv
all: clean compile sim
