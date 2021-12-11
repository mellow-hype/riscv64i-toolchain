FROM arm64v8/ubuntu:focal
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update && apt install -y \
	clang \
	llvm \
	llvm-dev \
	lld-10 \
	build-essential \
	vim \
	git \
	cmake

RUN mkdir -p /opt/riscv

WORKDIR /opt/riscv
RUN git clone https://github.com/mellow-hype/riscv64i-toolchain.git toolchain && \
	cd toolchain && \
	make

VOLUME ["/opt/riscv/data"]
WORKDIR /opt/riscv

ENTRYPOINT ["/bin/bash"]
