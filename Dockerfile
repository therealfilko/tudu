# Build
FROM golang:1.26.1-alpine3.23 AS build

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN go build -o main cmd/api/main.go


# Run
FROM alpine:3.23 AS prod

WORKDIR /app

COPY --from=build /app/main /app/main

EXPOSE 9000

CMD [ "./main" ]

