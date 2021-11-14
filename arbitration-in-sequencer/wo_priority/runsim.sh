#!/bin/sh

vsim work.tb_top -c -do "run -all; exit" +UVM_TESTNAME=seq_arb_fifo_test &&\
vsim work.tb_top -c -do "run -all; exit" +UVM_TESTNAME=seq_arb_weighted_test &&\
vsim work.tb_top -c -do "run -all; exit" +UVM_TESTNAME=seq_arb_random_test &&\
vsim work.tb_top -c -do "run -all; exit" +UVM_TESTNAME=seq_arb_strict_fifo_test &&\
vsim work.tb_top -c -do "run -all; exit" +UVM_TESTNAME=seq_arb_strict_random_test
