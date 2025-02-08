@if not exist "summaries" mkdir "summaries"
make sa name="fizzbuzz" opt="0" var="100" next="none" nextid="none jump jumpret" runfor=500000 sumout="summaries/fizzbuz.txt"
@REM make sa name="fizzbuzz" opt="0" var="100" next="btb" pmarg="2_2 3_2 4_2 5_2 6_2 7_2 8_2 16_2"  runfor=500000 sumout="summaries/fizzbuz.txt" sumapp=1
@REM make sa name="fizzbuzz" opt="0" var="100" next="btb" pmarg="2_1 2_2 2_3 2_4 2_5"  runfor=500000 sumout="summaries/fizzbuz.txt" sumapp=1
@REM make sa name="fizzbuzz" opt="0" var="100" next="btb" pmarg="3_1 3_2 3_3 3_4 3_5"  runfor=500000 sumout="summaries/fizzbuz.txt" sumapp=1
@REM make sa name="fizzbuzz" opt="0" var="100" next="btb" pmarg="4_1 4_2 4_3 4_4 4_5"  runfor=500000 sumout="summaries/fizzbuz.txt" sumapp=1
@REM make sa name="fizzbuzz" opt="0" var="100" next="btb" pmarg="5_1 5_2 5_3 5_4 5_5"  runfor=500000 sumout="summaries/fizzbuz.txt" sumapp=1
@REM make sa name="fizzbuzz" opt="0" var="100" next="btb" pmarg="6_1 6_2 6_3 6_4 6_5"  runfor=500000 sumout="summaries/fizzbuz.txt" sumapp=1
@REM make sa name="fizzbuzz" opt="0" var="100" next="btb" pmarg="7_1 7_2 7_3 7_4 7_5"  runfor=500000 sumout="summaries/fizzbuz.txt" sumapp=1
@REM make sa name="fizzbuzz" opt="0" var="100" next="btb" pmarg="8_1 8_2 8_3 8_4 8_5"  runfor=500000 sumout="summaries/fizzbuz.txt" sumapp=1

@REM make sa name="fizzbuzz" opt="0" var="100" next="bht" pmarg="2_2_1_2 2_2_2_2 2_2_3_2 2_2_4_2 2_2_6_2 2_2_8_2 2_2_12_2 2_2_16_2 2_2_24_2"  runfor=500000 sumout="summaries/fizzbuz.txt" sumapp=1
@REM make sa name="fizzbuzz" opt="0" var="100" next="bht" pmarg="4_2_1_2 4_2_2_2 4_2_3_2 4_2_4_2 4_2_6_2 4_2_8_2 4_2_12_2 4_2_16_2 4_2_24_2"  runfor=500000 sumout="summaries/fizzbuz.txt" sumapp=1
@REM make sa name="fizzbuzz" opt="0" var="100" next="bht" pmarg="6_2_1_2 6_2_2_2 6_2_3_2 6_2_4_2 6_2_6_2 6_2_8_2 6_2_12_2 6_2_16_2 6_2_24_2"  runfor=500000 sumout="summaries/fizzbuz.txt" sumapp=1
@REM make sa name="fizzbuzz" opt="0" var="100" next="bht" pmarg="8_2_1_2 8_2_2_2 8_2_3_2 8_2_4_2 8_2_6_2 8_2_8_2 8_2_12_2 8_2_16_2 8_2_24_2"  runfor=500000 sumout="summaries/fizzbuz.txt" sumapp=1


make sa name="fizzbuzz" opt="0" var="100" next="btb"    pmarg="2_2 3_2 4_2 5_2 6_2 7_2 8_2" runfor=500000 sumout="summaries/fizzbuz.txt" sumapp=1
make sa name="fizzbuzz" opt="0" var="100" next="bhtret" pmarg="2_2_24_2_1 3_2_24_2_1 4_2_24_2_1 5_2_24_2_1 6_2_24_2_1 7_2_24_2_1 8_2_24_2_1"  runfor=500000 sumout="summaries/fizzbuz.txt" sumapp=1
make sa name="fizzbuzz" opt="0" var="100" next="bhtret" pmarg="2_2_24_2_2 3_2_24_2_2 4_2_24_2_2 5_2_24_2_2 6_2_24_2_2 7_2_24_2_2 8_2_24_2_2"  runfor=500000 sumout="summaries/fizzbuz.txt" sumapp=1
make sa name="fizzbuzz" opt="0" var="100" next="bhtret" pmarg="2_2_24_2_3 3_2_24_2_3 4_2_24_2_3 5_2_24_2_3 6_2_24_2_3 7_2_24_2_3 8_2_24_2_3"  runfor=500000 sumout="summaries/fizzbuz.txt" sumapp=1


@REM make sa name="fizzbuzz_m" opt="0" var="100" next="btb" pmarg="2_2 4_2 6_2 8_2" runfor=500000 sumout="summaries/fizzbuz.txt" sumapp=1
@REM make sa name="fizzbuzz_m" opt="0" var="100" next="bht" pmarg="2_2_1_2 2_2_2_2 2_2_3_2 2_2_4_2 2_2_6_2 2_2_8_2 2_2_12_2 2_2_16_2 2_2_24_2"  runfor=500000 sumout="summaries/fizzbuz.txt" sumapp=1
@REM make sa name="fizzbuzz_m" opt="0" var="100" next="bht" pmarg="4_2_1_2 4_2_2_2 4_2_3_2 4_2_4_2 4_2_6_2 4_2_8_2 4_2_12_2 4_2_16_2 4_2_24_2"  runfor=500000 sumout="summaries/fizzbuz.txt" sumapp=1
@REM make sa name="fizzbuzz_m" opt="0" var="100" next="bht" pmarg="6_2_1_2 6_2_2_2 6_2_3_2 6_2_4_2 6_2_6_2 6_2_8_2 6_2_12_2 6_2_16_2 6_2_24_2"  runfor=500000 sumout="summaries/fizzbuz.txt" sumapp=1
@REM make sa name="fizzbuzz_m" opt="0" var="100" next="bht" pmarg="8_2_1_2 8_2_2_2 8_2_3_2 8_2_4_2 8_2_6_2 8_2_8_2 8_2_12_2 8_2_16_2 8_2_24_2"  runfor=500000 sumout="summaries/fizzbuz.txt" sumapp=1


@REM make sac opt="0 3" var="100" next="btb" nextid="none" pmarg="4_3 4_1 4_2 1_2 2_2 8_2" sumout="summaries/main.txt" sumapp=1