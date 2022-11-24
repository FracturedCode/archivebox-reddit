FROM archivebox/archivebox:latest
LABEL name="archivebox-reddit" \
	maintainer="FracturedCode <gabe@fracturedcode.net>" \
	description="An extension of archivebox for automatically archiving posts/comments from reddit saved"

COPY export-saved-reddit/export_saved.py .
COPY export-saved-reddit/requirements.txt .
COPY install.sh .
COPY shared.sh .
COPY reddit_saved_imports.sh .
COPY yt-dlp.sh .
COPY format_csv.py .
COPY docker/archivebox_reddit_entrypoint.sh .

RUN ./install.sh --dockerfile