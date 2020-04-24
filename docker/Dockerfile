FROM existing:latest

ARG ca_pem

RUN echo "${ca_pem}" > custom.pem \
  && mv custom.pem /usr/local/share/ca-certificates/custom.crt \
  && update-ca-certificates