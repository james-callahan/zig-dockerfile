FROM --platform=linux/amd64 busybox as builder

## Install Zig
ARG ZIG_VERSION=0.7.1
ARG ZIG_SHA256SUM=18c7b9b200600f8bcde1cd8d7f1f578cbc3676241ce36d771937ce19a8159b8d
RUN cd /tmp && \
    wget https://ziglang.org/download/${ZIG_VERSION}/zig-linux-x86_64-${ZIG_VERSION}.tar.xz && \
    (printf '%s  %s' ${ZIG_SHA256SUM} zig-linux-x86_64-${ZIG_VERSION}.tar.xz | sha256sum -c) && \
    tar -xJf zig-linux-x86_64-${ZIG_VERSION}.tar.xz && \
    mkdir -p /usr/local/bin /usr/local/lib && \
    mv zig-linux-x86_64-${ZIG_VERSION}/zig /usr/local/bin/ && \
    mv zig-linux-x86_64-${ZIG_VERSION}/lib/ /usr/local/lib/zig && \
    rm -rf zig-linux-x86_64-${ZIG_VERSION}/ zig-linux-x86_64-${ZIG_VERSION}.tar.xz

## Avoid building as root
RUN adduser -D user
USER user
WORKDIR /home/user/
