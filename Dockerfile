FROM archivebox/archivebox:latest
LABEL name="archivebox-reddit" \
	maintainer="FracturedCode <gabe@fracturedcode.net>" \
	description="An extension of archivebox for automatically archiving posts/comments from reddit saved"

RUN su -c "curl https://raw.githubusercontent.com/FracturedCode/archivebox-reddit/master/install.sh | /bin/bash" archivebox