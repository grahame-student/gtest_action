FROM alpine:3.16.0

RUN apk --no-cache add build-base \
                       cmake \
                       gtest \
                       gtest-dev \
                       gcovr
RUN mkdir /workdir

COPY entrypoint.sh /entrypoint.sh
COPY CMakeLists.txt /CMakeLists.txt

ENTRYPOINT ["/entrypoint.sh"]
