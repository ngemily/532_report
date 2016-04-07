Modelsim do file
----------------
\label{app:do}

```
file mkdir out

vlib work

vlog src/connected_components.v
vlog src/location_generator.v
vlog src/mem.v
vlog src/sobel.v
vlog src/util.v

vlog +define+RTL_SIM src/top.v
vlog +define+RTL_SIM src/tb.sv

vsim work.tb
run 2 ms

mem save -o out/merge_table.mem -f mti -data hex -addr hex \
    -startaddress 0 -endaddress 255 -wordsperline 1 /tb/dut/U2/MERGE_TABLE/mem

mem save -o out/data_table.mem -f mti -data hex -addr hex \
    -startaddress 0 -endaddress 255 -wordsperline 1 /tb/dut/U2/DATA_TABLE/mem

run -all

exit
```
