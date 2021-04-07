FROM infonova/keepalived-exporter:0.4.0-bearingpoint-1 AS exporter

FROM centos:7 AS builder

WORKDIR /

#RUN yum install -y gcc make automake autoconf openssl-devel libnl3-devel iptables-devel ipset-devel file-devel net-snmp-devel glib2-devel pcre2-devel libnftnl-devel libmnl-devel systemd-devel && \
RUN yum -y install curl gcc make autoconf automake openssl-devel libnl3-devel \
    iptables-devel ipset-devel net-snmp-devel libnfnetlink-devel file-devel

RUN curl -LO https://www.keepalived.org/software/keepalived-2.2.2.tar.gz && \
  tar -xzvf keepalived-2.2.2.tar.gz

WORKDIR /keepalived-2.2.2

RUN ./build_setup && \
  ./configure --prefix=/usr && \
  make && \
  make install

FROM openshift/origin-keepalived-ipfailover:v3.11.0

COPY --from=exporter /keepalived_exporter /usr/local/bin/
COPY --from=exporter /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

COPY --from=builder /usr/sbin/keepalived /usr/sbin/keepalived

COPY files/config-generators.sh /var/lib/ipfailover/keepalived/lib/
COPY files/failover-functions.sh /var/lib/ipfailover/keepalived/lib/
