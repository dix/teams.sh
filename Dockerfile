FROM alpine:3.22

# Install bash, curl, and jq
RUN apk add --no-cache bash curl jq

# Copy teams.sh and make it executable
COPY teams.sh /usr/local/bin/teams.sh
RUN chmod +x /usr/local/bin/teams.sh

# Set bash as default shell
SHELL ["/bin/bash", "-c"]