General Execution Notes
-------------------
-copy and paste the foolowing commends in command line

javac TweetsKmean.java
java TweetsKmean 25 InitialSeeds.txt Tweets.json tweets-k-means-output.txt
SSE  4.358260504363955


Program Description
-------------------

TweetsKmean.java is the java file.
InitialSeeds.txt, Tweets.json are the input files.
tweets-k-means-output.txt is the output file generated containing the desired output.
Please open the files in Wordpad for proper indented output.


OUTPUT containing SSE values for different number of clusters:
--------------------------------------------------------------

{cslinux2:~/MLHome} javac TweetsKmean.java
{cslinux2:~/MLHome} java TweetsKmean 25 InitialSeeds.txt Tweets.json tweets-k-means-output.txt
SSE  9.966181973961865