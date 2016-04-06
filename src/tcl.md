Vivado tcl
----------

```
set srcDir "src"
set outDir "proj"

create_project detectinator $outDir -part xc7a100tcsg324-1 -force

add_files -fileset sources_1 -norecurse $srcDir/connected_components.v
add_files -fileset sources_1 -norecurse $srcDir/location_generator.v
add_files -fileset sources_1 -norecurse $srcDir/mem.v
add_files -fileset sources_1 -norecurse $srcDir/sobel.v
add_files -fileset sources_1 -norecurse $srcDir/util.v
add_files -fileset sources_1 -norecurse $srcDir/top.v
add_files -fileset constrs_1 -norecurse $srcDir/timing.xdc

update_compile_order -fileset sources_1

reset_run synth_1
launch_runs synth_1
wait_on_run synth_1
open_run synth_1 -name netlist_1
write_verilog -mode funcsim $origin_dir/top_synth.vo -force

reset_run impl_1
launch_runs impl_1
wait_on_run impl_1
open_run impl_1 -name netlist_2
write_verilog -mode funcsim $origin_dir/top_impl.vo -force
```
