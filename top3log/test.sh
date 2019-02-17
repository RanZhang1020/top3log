#!/bin/sh
../../start.sh
/usr/local/hadoop/bin/hdfs dfs -rm -r /top3log/input/
/usr/local/hadoop/bin/hdfs dfs -rm -r /top3log/output/
/usr/local/hadoop/bin/hdfs dfs -mkdir -p /top3log/input/
/usr/local/hadoop/bin/hdfs dfs -copyFromLocal ../../mapreduce-test-data/access.log /top3log/input/
/usr/local/hadoop/bin/hadoop jar /usr/local/hadoop/share/hadoop/tools/lib/hadoop-streaming-2.9.2.jar \
-file ../../mapreduce-test-python/top3log/mapper.py -mapper ../../mapreduce-test-python/top3log/mapper.py \
-file ../../mapreduce-test-python/top3log/reducer.py -reducer ../../mapreduce-test-python/top3log/reducer.py \
-input /top3log/input/* -output /logstatlab/output/
/usr/local/hadoop/bin/hdfs dfs -cat /top3log/output/part-00000
/usr/local/hadoop/bin/hdfs dfs -rm -r /top3log/input/
/usr/local/hadoop/bin/hdfs dfs -rm -r /top3log/output/
../../stop.sh
