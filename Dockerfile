FROM centos:centos7 AS base-dependencies
LABEL maintainer="Abdelrahman Hosny <abdelrahman_hosny@brown.edu>"

RUN yum group install -y "Development Tools" && \
    yum update -y && yum install -y libffi-devel python3 tcl-devel which time && \
    yum localinstall https://www.klayout.org/downloads/CentOS_7/klayout-0.26.4-0.x86_64.rpm -y

RUN yum install -y libXft libXScrnSaver

WORKDIR /OpenROAD-flow
RUN mkdir -p /OpenROAD-flow

COPY --from=openroad /OpenROAD/build ./tools/build/OpenROAD
COPY --from=openroad/yosys /build ./tools/build/yosys
COPY --from=openroad/tritonroute /build ./tools/build/TritonRoute
COPY ./setup_env.sh .
COPY ./flow ./flow

RUN mkdir /alpha-release && cd /alpha-release && git clone https://github.com/bespoke-silicon-group/bsg_fakeram.git && cd bsg_fakeram && make tools
RUN chmod o+rw -R /alpha-release
RUN chmod o+rw -R /OpenROAD-flow/flow
