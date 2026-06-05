FROM golang:1.25-alpine AS builder
WORKDIR /app
RUN apk add --no-cache git
RUN go install github.com/swaggo/swag/cmd/swag@latest
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN swag init -g cmd/api/main.go --output docs 2>/dev/null || true
RUN CGO_ENABLED=0 GOOS=linux go build -o main ./cmd/api/

FROM alpine:latest
RUN apk --no-cache add ca-certificates wget
WORKDIR /app
COPY --from=builder /app/main .
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD wget -qO- http://localhost:8080/ping || exit 1
CMD ["./main"]
