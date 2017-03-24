#! /bin/bash
# launch with ./zz.sh <2 or 3 digit channel>
# you need to have 'jq' json parser installed for this to work


#change mediaplayer to 'vlc' if you want to use it instead. server is set to random NA.
#change site variable to reflect the service you use. 
#Mystreams/usport=viewms Live247=view247, Starstreams=viewss, MMA-TV/Myshout=viewmma, Streamtvnow=viewstvn
site=view247

username=dumbfred
password=hasabadpassword
server=dna
mediaplayer=mpv


if [[ $2 == vlc ]]; then
  mediaplayer=vlc
fi
len=${#1}
if [[ $len -ne 2 && $len -ne 3 ]]; then
  echo "Bad channel number. Enter 1,2,3 as 01,02,03 etc."
  exit 1 
fi
urlkey=$(curl "http://auth.smoothstreams.tv/hash_api.php?site=$site&username=$username&password=$password" | jq -r .hash)
url=rtmp://$server.smoothstreams.tv:3615/$site?wmsAuthSign=$urlkey/ch$1q1.stream
$mediaplayer $url
