FROM existing:latest

ARG ca_pem

RUN echo "${ca_pem}" > /usr/local/share/ca-certificates/custom.crt \
  && update-ca-certificates