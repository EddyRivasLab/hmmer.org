WEBHOST  =  seddy@hmmer.org
WEBDIR   =  /var/www/hmmer.org/public_html

# 'make all' updates the live site.
#
all:  
	rsync -Cavuz site/ ${WEBHOST}:${WEBDIR}/

