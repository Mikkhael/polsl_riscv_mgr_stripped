@if not exist "summaries" mkdir "summaries"
make sa next="none btb bht bhtret" nextid="none jumpret" name=vectors pmarg="15_2_4_2_10"  opt=0 var="0" sumout="summaries/bht_vector.txt"
make sa next="none btb bht bhtret" nextid="none jumpret" name=vectors pmarg="2_2_2_2_2"    opt=0 var="0" sumout="summaries/bht_vector.txt" sumapp=1
make sa next="bhtret"              nextid="jumpret"      name=vectors pmarg="15_2_10_2_10" opt=0 var="0" sumout="summaries/bht_vector.txt" sumapp=1
make sa next="bhtret"              nextid="jumpret"      name=vectors pmarg="15_2_3_2_10"  opt=0 var="0" sumout="summaries/bht_vector.txt" sumapp=1