FROM infonova/keepalived-exporter:0.4.0-bearingpoint-1 AS exporter


FROM openshift/origin-keepalived-ipfailover:v3.11.0

COPY --from=exporter /keepalived_exporter /usr/local/bin/
COPY --from=exporter /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

COPY files/config-generators.sh /var/lib/ipfailover/keepalived/lib/
COPY files/failover-functions.sh /var/lib/ipfailover/keepalived/lib/
