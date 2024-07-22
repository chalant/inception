# Use the official Alpine image as a base
FROM alpine:3.19

# Set environment variables
ENV REDIS_VERSION=7.2

# Install Redis and other dependencies
RUN apk add --no-cache tzdata bash redis
#  && wget http://download.redis.io/releases/redis-${REDIS_VERSION}.tar.gz \
#  && tar xzf redis-${REDIS_VERSION}.tar.gz \
#  && cd redis-${REDIS_VERSION} \
#  && make \
#  && make install \
#  && cd .. \
#  && rm -rf redis-${REDIS_VERSION} redis-${REDIS_VERSION}.tar.gz \
#  && apk del .build-deps

EXPOSE 6379

COPY conf/redis.conf /usr/local/etc/redis/redis.conf
CMD ["redis-server", "/usr/local/etc/redis/redis.conf", "--protected-mode", "no"]