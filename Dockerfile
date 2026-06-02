FROM nginx:alpine

RUN apk add --no-cache postgresql-client bash

RUN rm /etc/nginx/conf.d/default.conf

COPY web/nginx.conf /etc/nginx/conf.d/default.conf

COPY web/index.html /usr/share/nginx/html/index.html

# Ожидание PostgreSQL
COPY wait-for-postgres.sh /wait-for-postgres.sh
RUN chmod +x /wait-for-postgres.sh

ENTRYPOINT ["/wait-for-postgres.sh"]
CMD ["nginx", "-g", "daemon off;"]