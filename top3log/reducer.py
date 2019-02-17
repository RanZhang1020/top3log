#!/usr/bin/python
import sys
from operator import itemgetter

#df=open('out.log')
dict_ip_count = {}
for line in sys.stdin :
    line = line.strip()
    ip, num = line.split('\t')
    try:
        num = int(num)
        dict_ip_count[ip] = dict_ip_count.get(ip,0) + num
    except ValueError:
        pass
sorted_dict_ip_count = sorted(dict_ip_count.items(),key=itemgetter(0))    

time_ip_count={}
for i in range(len(sorted_dict_ip_count)):
    time=sorted_dict_ip_count[i][0][0:2]
    ip=sorted_dict_ip_count[i][0][2:]
    count=sorted_dict_ip_count[i][1]
    if time not in time_ip_count:
         time_ip_count[time]=[]
    time_ip_count[time].append((ip,count))
for i, b in time_ip_count.items():
    time_ip_count[i]=sorted(b,key=itemgetter(1),reverse=True)[0:3]
time_ip_count=sorted(time_ip_count.items(),key=itemgetter(0))

print(time_ip_count)
for s,j in time_ip_count:    
    for ss in j:
        print('[%s:00]\t%s\t%s' %(s,ss[0],ss[1]))