FROM archivebox/archivebox:latest
LABEL name="archivebox-reddit" \
	maintainer="FracturedCode <gabe@fracturedcode.net>" \
	description="An extension of archivebox for automatically archiving posts/comments from reddit saved"

COPY export-saved-reddit/AccountDetails.py .
RUN curl https://raw.githubusercontent.com/FracturedCode/archivebox-reddit/master/install.sh | /bin/bash