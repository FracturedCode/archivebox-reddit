FROM archivebox/archivebox:latest
LABEL name="archivebox-reddit" \
	maintainer="FracturedCode <gabe@fracturedcode.net>" \
	description="An extension of archivebox for automatically archiving posts/comments from reddit saved"

COPY export-saved-reddit/export_saved.py export-saved-reddit/
COPY export-saved-reddit/requirements.txt export-saved-reddit/
COPY install.sh .
COPY shared.sh .
COPY reddit_saved_imports.sh .
COPY cookies-libredd-it.txt .
COPY .env .

RUN ./install.sh --dockerfile
