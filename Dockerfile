FROM alpine:latest
RUN apk update
RUN apk upgrade
RUN apk add --no-cache ca-certificates

MAINTAINER Fith

# Extras
RUN apk add --no-cache curl

# Timezone (TZ)
RUN apk update && apk add --no-cache tzdata
ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Add Bash shell & dependancies
RUN apk add --no-cache bash busybox-suid su-exec

# Volumes
VOLUME /config
VOLUME /root/.xteve
VOLUME /tmp/xteve

# Add ffmpeg and vlc
RUN apk add ffmpeg
RUN apk add vlc
RUN sed -i 's/geteuid/getppid/' /usr/bin/vlc

# Add xTeve and guide2go
RUN wget https://github.com/xteve-project/xTeVe-Downloads/raw/master/xteve_linux_amd64.zip -O temp.zip; unzip temp.zip -d /usr/bin/; rm temp.zip

# Expose Port
EXPOSE 34401
