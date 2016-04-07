Post-syn and Post-impl sim using Modelsim
-----------------------------------------
\label{app:simlib}

>The following method for setting up post-synthesis and post-implementation
simulation is adapted from Aldec \cite{aldec}.

While RTL sim is usually a good indicator of design correctness, some
discrepancies can arise as the design is synthesized and implemented.  It is
generally a good practice to perform testing at each of the stages show in
Figure \ref{fig:testing}.  To do so, however, requires a little more setup.

As the design is compiled through Vivado, primitives are added to the user's
netlist.  This new, more low level netlist need to be exported.  Then, these
primitives need to have their behaviour defined in order for Modelsim to
simulate it.  The following commands detail how to do this.

\begin{figure}[htbp]
    \centering
    \includegraphics[scale=0.5]{imgs/testing.png}
    \caption{Stages of compilation and testing.}
    \label{fig:testing}
\end{figure}

Run the following command in Vivado's tcl console[^1]:

    compile_simlib -simulator modelsim -family artix7 -library unisim -language verilog

After synthesis or implementation, export the the Verilog netlist.  This can be
done from the Vivado console using:

    reset_run synth_1
    launch_runs synth_1
    wait_on_run synth_1
    open_run synth_1 -name netlist_1
    write_verilog -mode funcsim $origin_dir/top_synth.vo -force

When running Modelsim, link the libraries.

    vsim -gui -L secureip -L unisims_ver work.tb work.glbl


[^1]: Modelsim ASE's installation must be modified slightly for this to work.
In the Modelsim ASE install directory, perform `ln -s linuxaloem linuxpe`
