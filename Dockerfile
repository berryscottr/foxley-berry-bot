FROM golang:1.20-alpine

ARG BOT_TOKEN
ARG PLAID_CLIENT_ID
ARG PLAID_SANDBOX_KEY
ENV BOT_TOKEN=$BOT_TOKEN
ENV PLAID_CLIENT_ID=$PLAID_CLIENT_ID
ENV PLAID_SANDBOX_KEY=$PLAID_SANDBOX_KEY

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY *.go ./

RUN mkdir -p /app/pkg/bot
WORKDIR /app/pkg/bot
COPY pkg/bot/*.go ./

WORKDIR /app

RUN go build main.go

EXPOSE 8080

CMD [ "./main" ]