General Execution Notes
-------------------
-copy and paste the foolowing commends in command line

javac kmeans.java
java kmeans 3 data.txt output.txt 


Program Description
-------------------

kmeans.java is the java file.
data.txt is the input file.
output.txt is the output file generated containing the desired output.
Please open the files in Wordpad for proper indented output.


OUTPUT containing SSE values for different number of clusters:
--------------------------------------------------------------

{cslinux2:~/MLHome} javac kmeans.java
{cslinux2:~/MLHome} java kmeans 3 data.txt output.txt 
SSE 1.9106917060670061
{cslinux2:~/MLHome} java kmeans 5 data.txt output1.txt 
SSE 1.5117607098152743
{cslinux2:~/MLHome} java kmeans 7 data.txt output2.txt 
SSE 1.0994297128722732
{cslinux2:~/MLHome} java kmeans 9 data.txt output3.txt 
SSE 1.0108151762422366
{cslinux2:~/MLHome} java kmeans 11 data.txt output4.txt 
SSE 0.6964700391774891

