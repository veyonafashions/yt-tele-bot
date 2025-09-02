FROM golang:1.22 AS builder
WORKDIR /app/
COPY go.mod go.sum /app/
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -v

FROM python:alpine
RUN apk update && apk upgrade && apk add --no-cache ffmpeg
COPY --from=builder /app/yt-dlp-telegram-bot /app/yt-dlp-telegram-bot
COPY --from=builder /app/yt-dlp.conf /root/yt-dlp.conf

ENTRYPOINT ["/app/yt-dlp-telegram-bot"]
ENV API_ID=29022127 API_HASH=8b68aad5214f849b218de0952ac3c885 BOT_TOKEN=8465147830:AAEVmLvLzGYXFW08i3MRrt3xcvQVB7zrZSY ALLOWED_USERIDS= ADMIN_USERIDS=946242331 ALLOWED_GROUPIDS= YTDLP_COOKIES=
