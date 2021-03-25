FROM golang:1.12 as builder
WORKDIR /gowork/github.com/fxdgg/seq-db.git
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags '-w -s' -a -o seq-db .

FROM alpine:latest
WORKDIR /gowork/see
COPY --from=builder /gowork/github.com/fxdgg/seq-db/seq ./
COPY --from=builder /gowork/github.com/fxdgg/seq-db/config.yml ./
RUN apk add --no-cache tzdata
ENV TZ "Asia/Shanghai"
EXPOSE 8000
ENTRYPOINT ["./seq-db"]
