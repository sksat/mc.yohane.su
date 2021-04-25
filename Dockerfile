FROM openjdk:11-jdk as builder
LABEL maintainer "sksat <sksat@sksat.net>"

# Build PaperMC
WORKDIR /work
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y  git patch maven time
RUN git config --global user.name sksat && git config --global user.email sksat@sksat
RUN git clone https://github.com/PaperMC/Paper
RUN cd Paper && time ./paper jar
RUN cd Paper && ls -la

FROM gcr.io/distroless/java:11
WORKDIR /app
COPY --from=builder /work/Paper/paperclip.jar /app
CMD ["/app/paperclip.jar", "--nogui"]
