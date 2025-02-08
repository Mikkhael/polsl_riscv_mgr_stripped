@if not exist "summaries" mkdir "summaries"
make sa pat="vector factorial" opt="0 3" var="0 1" next="none" nextid="none jump jumpret" sumout="summaries/test_summaries.txt"
make sa pat="vector factorial" opt="0 3" var="1"   next="btb"  nextid="none"    pmarg="4_3 4_2 10_2" sumout="summaries/test_summaries.txt" sumapp=1
make sa pat="vector factorial" opt="0 3"           next="bht"  nextid="jumpret" pmarg="10_2_8_2" sumout="summaries/test_summaries.txt" sumapp=1