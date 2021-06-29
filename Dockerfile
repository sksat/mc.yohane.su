FROM openjdk:16.0.1-jdk-slim as builder
LABEL maintainer "sksat <sksat@sksat.net>"

# Build PaperMC
WORKDIR /build
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y  git patch time
RUN git config --global user.name sksat && git config --global user.email sksat@sksat
RUN git clone https://github.com/PaperMC/Paper
RUN cd Paper && git checkout 1d194e56053e0ed4867661cadebc223ea2b690f9

RUN cd Paper && ./gradlew tasks
RUN cd Paper && time ./gradlew applyPatches && time ./gradlew paperclipJar

RUN find Paper | grep jar
RUN ls Paper/build/libs -lh
RUN cp Paper/build/libs/Paper-1.17-R0.1-SNAPSHOT.jar Paper/paperclip.jar

# Run
FROM adoptopenjdk/openjdk16:alpine-jre
WORKDIR /app
COPY --from=builder /build/Paper/paperclip.jar /bin/
COPY --from=builder /build/Paper/LICENSE.md /licenses/Paper/
COPY --from=builder /build/Paper/licenses /licenses/Paper/licenses
#RUN ls /licenses/Paper/licenses

CMD ["java", "-jar", "/bin/paperclip.jar"]
