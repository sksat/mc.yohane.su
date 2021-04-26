FROM openjdk:11-jdk as builder
LABEL maintainer "sksat <sksat@sksat.net>"

# Build PaperMC
WORKDIR /work
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y  git patch maven time
RUN git config --global user.name sksat && git config --global user.email sksat@sksat
RUN git clone https://github.com/PaperMC/Paper
RUN cd Paper && time ./paper jar

# Run
FROM gcr.io/distroless/java:11-debug
WORKDIR /app
COPY --from=builder /work/Paper/paperclip.jar /bin/
#ENTRYPOINT ["/busybox/sh", "-c", "mkfifo /app/stdin; java -jar /app/paperclip.jar --nogui < /app/stdin"]
CMD ["/bin/paperclip.jar"]
