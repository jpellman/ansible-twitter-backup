#!/bin/sh
# Simple Twitter backup script

if [ -z "$1" ] || [ -z "$2" ];
then
	echo Missing argument.
	exit 1
fi
export HANDLE=$1
export BACKUPSDIR=$2
export DAY=`date +'%Y-%m-%d'`

echo "Backing up tweets..."
t timeline ${HANDLE} --csv --number 3000 > ${BACKUPSDIR}/tweets-$DAY.csv
COUNT_TWEET=$(wc -l ${BACKUPSDIR}/tweets-$DAY.csv|cut -d" " -f 1)
cat -n ${BACKUPSDIR}/tweets.csv ${BACKUPSDIR}/tweets-$DAY.csv | sort -uk2 | sort -nk1 | cut -f2- > ${BACKUPSDIR}/tweets.csv.tmp
mv ${BACKUPSDIR}/tweets.csv.tmp ${BACKUPSDIR}/tweets.csv
rm ${BACKUPSDIR}/tweets-$DAY.csv 

echo "Backing up retweets..."
t retweets --csv --number 3000 > ${BACKUPSDIR}/retweets-$DAY.csv
COUNT_RETWEET=$(wc -l ${BACKUPSDIR}/retweets-$DAY.csv|cut -d" " -f 1)
cat -n ${BACKUPSDIR}/retweets.csv ${BACKUPSDIR}/retweets-$DAY.csv | sort -uk2 | sort -nk1 | cut -f2- > ${BACKUPSDIR}/retweets.csv.tmp
mv ${BACKUPSDIR}/retweets.csv.tmp ${BACKUPSDIR}/retweets.csv
rm ${BACKUPSDIR}/retweets-$DAY.csv 

echo "Backing up mentions..."
t mentions --csv --number 3000 > ${BACKUPSDIR}/mentions-$DAY.csv
COUNT_MENTIONS=$(wc -l ${BACKUPSDIR}/mentions-$DAY.csv|cut -d" " -f 1)
cat -n ${BACKUPSDIR}/mentions.csv ${BACKUPSDIR}/mentions-$DAY.csv | sort -uk2 | sort -nk1 | cut -f2- > ${BACKUPSDIR}/mentions.csv.tmp
mv ${BACKUPSDIR}/mentions.csv.tmp ${BACKUPSDIR}/mentions.csv
rm ${BACKUPSDIR}/mentions-$DAY.csv 

echo "Backing up favorites..."
t favorites --csv --number 3000 > ${BACKUPSDIR}/favorites-$DAY.csv
COUNT_FAVORITES=$(wc -l ${BACKUPSDIR}/favorites-$DAY.csv|cut -d" " -f 1)
cat -n ${BACKUPSDIR}/favorites.csv ${BACKUPSDIR}/favorites-$DAY.csv | sort -uk2 | sort -nk1 | cut -f2- > ${BACKUPSDIR}/favorites.csv.tmp
mv ${BACKUPSDIR}/favorites.csv.tmp ${BACKUPSDIR}/favorites.csv
rm ${BACKUPSDIR}/favorites-$DAY.csv 

echo "Backing up DM received..."
t direct_messages --csv --number 3000 > ${BACKUPSDIR}/dm_received-$DAY.csv
COUNT_DM_RECEIVED=$(wc -l ${BACKUPSDIR}/dm_received-$DAY.csv|cut -d" " -f 1)
cat -n ${BACKUPSDIR}/dm_received.csv ${BACKUPSDIR}/dm_received-$DAY.csv | sort -uk2 | sort -nk1 | cut -f2- > ${BACKUPSDIR}/dm_received.csv.tmp
mv ${BACKUPSDIR}/dm_received.csv.tmp ${BACKUPSDIR}/dm_received.csv
rm ${BACKUPSDIR}/dm_received-$DAY.csv 

echo "Backing up DM sent..."
t direct_messages_sent --csv --number 3000 > ${BACKUPSDIR}/dm_sent-$DAY.csv
COUNT_DM_SENT=$(wc -l ${BACKUPSDIR}/dm_sent-$DAY.csv|cut -d" " -f 1)
cat -n ${BACKUPSDIR}/dm_sent.csv ${BACKUPSDIR}/dm_sent-$DAY.csv | sort -uk2 | sort -nk1 | cut -f2- > ${BACKUPSDIR}/dm_sent.csv.tmp
mv ${BACKUPSDIR}/dm_sent.csv.tmp ${BACKUPSDIR}/dm_sent.csv
rm ${BACKUPSDIR}/dm_sent-$DAY.csv 

echo "Backing up followings..."
t followings --csv > ${BACKUPSDIR}/followings-$DAY.csv
COUNT_FOLLOWINGS=$(wc -l ${BACKUPSDIR}/followings-$DAY.csv|cut -d" " -f 1)
cat -n ${BACKUPSDIR}/followings.csv ${BACKUPSDIR}/followings-$DAY.csv | sort -uk2 | sort -nk1 | cut -f2- > ${BACKUPSDIR}/followings.csv.tmp
mv ${BACKUPSDIR}/followings.csv.tmp ${BACKUPSDIR}/followings.csv
rm ${BACKUPSDIR}/followings-$DAY.csv 

echo -e "\nBacked up the following:"
echo -e "- ${COUNT_TWEET} tweets"
echo -e "- ${COUNT_RETWEET} reweets"
echo -e "- ${COUNT_MENTIONS} mentions"
echo -e "- ${COUNT_FAVORITES} favorites"
echo -e "- ${COUNT_DM_RECEIVED} DMs received"
echo -e "- ${COUNT_DM_SENT} DMs sent"
echo -e "- ${COUNT_FOLLOWINGS} followings"

echo -e "\nDone\n"
