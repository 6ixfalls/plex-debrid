## Buildstage ##
FROM ghcr.io/linuxserver/baseimage-alpine:3.20 as buildstage

RUN \
  echo "**** install packages ****" && \
  apk add --no-cache \
    curl && \
  echo "**** grab rclone ****" && \
  mkdir -p /root-layer && \
  curl -o \
    /root-layer/rclone -L \
    "https://github.com/itsToggle/rclone_RD/releases/download/v1.58.1-rd.2.2/rclone-linux" && \
  chmod u+x /root-layer/rclone

# copy local files
COPY root/ /root-layer/

## Single layer deployed image ##
FROM scratch

# Add files from buildstage
COPY --from=buildstage /root-layer/ /
