from lyrahgames/cpp-build-tools:latest

label maintainer="markuspawellek@gmail.com"

arg VCS_REF
arg BUILD_DATE
label \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="https://github.com/lyrahgames/docker-cpp-test-tools.git"

# install latest doctest unit testing framework
workdir /tmp
run git clone https://github.com/onqtam/doctest.git --depth=1 --branch master --single-branch
workdir doctest/build
run \
  cmake -D CMAKE_BUILD_TYPE=Release .. && \
  cmake --build . && \
  cmake --build . --target install
workdir /
run rm -rf /tmp/doctest

# install latest trompeloeil mocking framework
workdir /tmp
run git clone https://github.com/rollbear/trompeloeil.git --depth=1 --branch master --single-branch
workdir trompeloeil/build
run \
  cmake -D CMAKE_BUILD_TYPE=Release .. && \
  cmake --build . && \
  cmake --build . --target install
workdir /
run rm -rf /tmp/trompeloeil

# install latest kcov code coverage tool
# dependencies
run \
  apt-get update && \
  apt-get install -y \
    binutils-dev \
    # libcurl4-openssl-dev \
    # zlib1g-dev \
    libdw-dev \
    libiberty-dev \
  && rm -rf /var/lib/apt/lists/*
# building
workdir /tmp
run git clone https://github.com/SimonKagstrom/kcov.git --depth=1 --branch master --single-branch
workdir kcov/build
run \
  cmake -D CMAKE_BUILD_TYPE=Release .. && \
  cmake --build . && \
  cmake --build . --target install
workdir /
run rm -rf /tmp/kcov