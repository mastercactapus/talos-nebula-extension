FROM alpine as builder

COPY download-nebula.sh /
ARG VERSION=v1.8.2
RUN /download-nebula.sh $VERSION /out

FROM scratch

COPY manifest.yaml /
COPY nebula.yaml /rootfs/usr/local/etc/containers/
COPY --from=builder /out/nebula /rootfs/usr/local/lib/containers/nebula/
