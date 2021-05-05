FROM openjdk:11-jdk as builder
LABEL maintainer "sksat <sksat@sksat.net>"

# Build PaperMC
WORKDIR /build
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y  git patch maven time
RUN git config --global user.name sksat && git config --global user.email sksat@sksat
RUN git clone https://github.com/PaperMC/Paper
RUN cd Paper && time ./paper jar

# Run
FROM gcr.io/distroless/java:11
WORKDIR /app
COPY --from=builder /build/Paper/paperclip.jar /bin/
COPY --from=builder /build/Paper/LICENSE.md /licenses/Paper/
COPY --from=builder /build/Paper/licenses /licenses/Paper/licenses
#SHELL ["/busybox/sh", "-c"]
#RUN ls /licenses/Paper/licenses

CMD ["/bin/paperclip.jar"]
