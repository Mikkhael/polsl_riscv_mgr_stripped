@if not exist "summaries" mkdir "summaries"

make pat="test_call_chain%%" nextid="jumpret jump" sa sumout="summaries/ras.txt"
make pat="factorial" opt="0 1 3" var="1" nextid="jumpret jump" sa sumout="summaries/ras.txt" sumapp=1