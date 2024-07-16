FROM alpine:latest


RUN apk add --no-cache lighttpd git &&\
 adduser -DH www &&\
 mkdir -p /var/www/servers/

COPY ./lighttpd.conf /etc/lighttpd/

COPY ./entrypoint.sh /var/www/servers/

CMD [ "chmod", "+x", "/var/www/servers/entrypoint.sh"]

WORKDIR /var/www/servers/

VOLUME /etc/lighttpd/
VOLUME /var/www/

EXPOSE 80

# Check every minute if lighttpd responds within 1 second and update
# container health status accordingly.
#--no-verbose - Turn off verbose without being completely quiet (use -q for that), which means that error messages and basic information still get printed.
# --tries=1 - If not set, some wget implementations will retry indefinitely when HTTP 200 response is not returned.
# --spider - Behave as a Web spider, which means that it will not download the pages, just check that they are there.
HEALTHCHECK --interval=1m --timeout=1s \
  CMD wget --no-verbose --tries=1 --spider http://127.0.0.1:80/ || exit 1


ENTRYPOINT [ "sh","entrypoint.sh" ]