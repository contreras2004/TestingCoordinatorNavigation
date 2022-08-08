FROM java:alpine

WORKDIR /wiremock

COPY . .

CMD java -jar wiremock.jar --root-dir data --port=${WIREMOCK_PORT} --verbose
