onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /fsm_tb/s_clk
add wave -noupdate /fsm_tb/s_btn_P
add wave -noupdate /fsm_tb/s_btn_S
add wave -noupdate /fsm_tb/s_normalState
add wave -noupdate /fsm_tb/s_acertMState
add wave -noupdate /fsm_tb/s_acertHState
add wave -noupdate /fsm_tb/s_selAcerOrProg
add wave -noupdate /fsm_tb/s_SelStateProg
add wave -noupdate /fsm_tb/s_proGelState
add wave -noupdate /fsm_tb/s_proLuaState
add wave -noupdate /fsm_tb/s_proSolState
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {21370 ps} {871872 ps}
