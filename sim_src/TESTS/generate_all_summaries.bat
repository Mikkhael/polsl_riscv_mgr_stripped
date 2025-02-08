@if not exist "summaries" mkdir "summaries"
make sac opt="0 3" var="1" next="none" nextid="none jump jumpret" sumout="summaries/main.txt"
make sac opt="0 3" var="1" next="btb" nextid="none" pmarg="4_3 4_1 4_2 1_2 2_2 8_2" sumout="summaries/main.txt" sumapp=1