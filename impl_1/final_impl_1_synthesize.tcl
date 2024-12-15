if {[catch {

# define run engine funtion
source [file join {C:/lscc/radiant/2023.1} scripts tcl flow run_engine.tcl]
# define global variables
global para
set para(gui_mode) 1
set para(prj_dir) "Z:/my_designs/final"
# synthesize IPs
# synthesize VMs
# propgate constraints
file delete -force -- final_impl_1_cpe.ldc
run_engine_newmsg cpe -f "final_impl_1.cprj" "mypll.cprj" -a "iCE40UP"  -o final_impl_1_cpe.ldc
# synthesize top design
file delete -force -- final_impl_1.vm final_impl_1.ldc
run_engine_newmsg synthesis -f "final_impl_1_lattice.synproj"
run_postsyn [list -a iCE40UP -p iCE40UP5K -t SG48 -sp High-Performance_1.2V -oc Industrial -top -w -o final_impl_1_syn.udb final_impl_1.vm] "Z:/my_designs/final/impl_1/final_impl_1.ldc"

} out]} {
   runtime_log $out
   exit 1
}
