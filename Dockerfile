FROM --platform=linux/amd64 busybox as builder

## Install Zig
ARG ZIG_VERSION=0.8.0
ARG ZIG_SHA256SUM=502625d3da3ae595c5f44a809a87714320b7a40e6dff4a895b5fa7df3391d01e
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
