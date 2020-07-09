FROM ubuntu:18.04
RUN apt-get update && apt-get install -y \
    curl \
    jq
COPY entrypoint.sh /entrypoint.sh
# ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]