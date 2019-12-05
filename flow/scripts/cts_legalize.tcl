if {[info exists standalone] && !$standalone} {
  # Do nothing
} else {
  # Read process files
  foreach libFile $::env(LIB_FILES) {
    read_liberty $libFile
  }
  read_lef $::env(OBJECTS_DIR)/merged_padded.lef

  # Read design files
  read_def $::env(RESULTS_DIR)/run/cts_no_dummies.def
}

legalize_placement

if {[info exists standalone] && !$standalone} {
  # Do nothing
} else {
  # write output
  write_def $::env(RESULTS_DIR)/run/cts_final.def
  exit
}