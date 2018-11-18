for t in {1..10};
do
 curl -s http://8.8.8.8/ \
 | grep "Hostname:" \
 | cut -d" " -f2;
done \
 | sort \
 | uniq -c