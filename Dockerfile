# IA 462 Lab 4 - digest-pinned base image (Week 8 slide: pin, don't float)
FROM python:3.15-slim@sha256:65a65fc7b30b06cb6df4930fd4650697cb23f4c2698ab81fc87e4b031bc36928

LABEL maintainer="awolf11@emich.edu"
LABEL description="IA 462 Lab 4 - Supply-Chain-Hardened App"

#update zlib for trivy scan
RUN apt-get update \
    && apt-get install -y --only-upgrade zlib1g \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd --system appgroup && \
    useradd  --system --gid appgroup --home /app --shell /usr/sbin/nologin appuser

WORKDIR /tmp
COPY --chown=appuser:appgroup updateSetupTools.lock .
RUN pip install  --no-cache-dir --upgrade --force-reinstall --require-hashes -r updateSetupTools.lock
RUN rm -rf /tmp

WORKDIR /app
COPY --chown=appuser:appgroup requirements.lock ./requirements.txt
RUN pip install --no-cache-dir --require-hashes -r requirements.txt
COPY --chown=appuser:appgroup app/ ./app/

USER appuser
EXPOSE 5000
CMD ["python3", "app/app.py"]
