FROM    golang:1.12

LABEL   org.label-schema.name = "Response Router Service"
LABEL   org.label-schema.description = "This is a router, powered by Caddyserver offering the ability to access all services from one endpoint."
LABEL   org.label-schema.url = "https://github.com/lavrahq/response" 
LABEL   org.label-schema.vcs-url = "https://github.com/lavrahq/response-router"
LABEL   org.label-schema.vendor = "Lavra"
LABEL   org.label-schema.schema-version = "1.0"
LABEL   io.lavra.stack.supported = "true"

RUN     mkdir /app
WORKDIR /app

COPY    go.mod .
COPY    go.sum .

RUN     go mod download

COPY    . .

RUN     go build -o app

ENV     HOST=0.0.0.0
ENV     PORT=80
ENV     RESPONSE_DATA_URL=data:8080
ENV     RESPONSE_AUTH_URL=auth:8090
ENV     RESPONSE_API_URL=api:8100

EXPOSE  ${PORT}

ENTRYPOINT [ "./app", "-agree"]