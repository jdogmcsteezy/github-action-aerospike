FROM docker:stable

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN echo $(ls -al $GITHUB_WORKSPACE)
RUN echo "------"
RUN echo $(ls -al)

ENTRYPOINT ["/entrypoint.sh"]