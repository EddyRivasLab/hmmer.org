# Public installation site; where we'll rsync and ssh to: 
WEBHOST  =  seddy@96.126.110.11
WEBDIR   =  /var/www/hmmer.org/public_html

# hmmer.org makes crossreferences to our publications, on lab web site rooted at:
LABWEB   =  http://eddylab.org

# Building hmmer.org pages also requires a local git working copy of "labbib", at:
LABBIB   =  ${HOME}/labbib

# Building hmmer.org pages is coordinated with the lab web pages, in
# this same git repo one level up.
LABDIR   =  ${HOME}/web/eddylab.org


# 'make all' updates the live site.
# The -C option to rsync makes it not copy .svn stuff.
#
all:    site/publications-inc.html
	rsync -Cavuz site/ ${WEBHOST}:${WEBDIR}/
	ssh ${WEBHOST} chmod +x ${WEBDIR}/publications.html

# Install/update the test site
# Having everything in site/ lets us do one rsync.
#
test:    site/publications-inc.html
	ssh ${WEBHOST} mkdir -p ${TESTDIR}
	rsync -Cavuz site/ ${WEBHOST}:${TESTDIR}/
	ssh ${WEBHOST} chmod +x ${TESTDIR}/publications.html

# Below is an example of using the boolean search with keywords. It will search for all entries
# tagged with 'hmmer', but not 'lab'.
# ~/labbib/publications.pl -k 'hmmer NOT lab' ~/labbib/master.bib > site/others-publications-inc.html
site/publications-inc.html:   ${LABBIB}/lab.bib ${LABBIB}/master.bib
	rm -f site/publications
	ln -s ${LABDIR}/site/publications site/publications
	~/labbib/publications.pl -n -k 'hmmer' --template=selab.tt            > site/publications-inc.html
	~/labbib/publications.pl    -k 'hmmer' --template=selab.tt master.bib > site/others-publications-inc.html
	rm -f site/publications

# Clean up this source directory
#
clean:
	rm -f *~ \
		site/*~ \
		site/publications-inc.html \
		site/others-publications-inc.html

# Delete the test site.
#
testdelete:
	ssh ${WEBHOST} rm -rf ${TESTDIR}


