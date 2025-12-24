FROM ubuntu:latest

ARG TARGETARCH
RUN echo "arch=$TARGETARCH"
# install curl
RUN apt update
RUN apt install -y curl libicu-dev jq openssh-client gettext-base

# install docker
RUN apt-get update
RUN apt-get install ca-certificates curl
RUN install -m 0755 -d /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
RUN chmod a+r /etc/apt/keyrings/docker.asc
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update
RUN apt-get install -y docker-ce-cli

# install JDK
WORKDIR /opt
RUN apt-get install -y libavformat-dev libavdevice-dev python3-av
RUN if [ $TARGETARCH = "arm64" ]; then \
        curl -o graalvm-community.tar.gz -L https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-21.0.2/graalvm-community-jdk-21.0.2_linux-aarch64_bin.tar.gz \
    ; fi
RUN if [ $TARGETARCH = "amd64" ]; then \
        curl -o graalvm-community.tar.gz -L https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-21.0.2/graalvm-community-jdk-21.0.2_linux-x64_bin.tar.gz \
    ; fi
RUN tar -xzf graalvm-community.tar.gz
RUN rm -rf graalvm-community.tar.gz
RUN mv graalvm-community* jdk
ENV JAVA_HOME=/opt/jdk
ENV PATH=/opt/jdk/bin:$PATH
COPY intermediate.der /opt/jdk/
RUN keytool -importcert -alias home -keystore $JAVA_HOME/lib/security/cacerts -storepass changeit -file /opt/jdk/intermediate.der -noprompt
RUN rm -rf /opt/jdk/intermediate.der

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /home/ubuntu
USER ubuntu

# install github runner
RUN mkdir actions-runner
WORKDIR /home/ubuntu/actions-runner
RUN if [ $TARGETARCH = "arm64" ]; then \
        curl -o actions-runner-osx-arm64-2.329.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.329.0/actions-runner-osx-arm64-2.329.0.tar.gz && \
        echo "50c0d409040cc52e701ac1d5afb4672cb7803a65c1292a30e96c42051dfa690f actions-runner-osx-arm64-2.329.0.tar.gz" | sha256sum -c && \
        tar xzf ./actions-runner-osx-arm64-2.329.0.tar.gz && \
        rm -rf actions-runner-osx-arm64-2.329.0.tar.gz \
    ; fi
RUN if [ $TARGETARCH = "amd64" ]; then \
        curl -o actions-runner-linux-x64-2.329.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.329.0/actions-runner-linux-x64-2.329.0.tar.gz && \
        echo "194f1e1e4bd02f80b7e9633fc546084d8d4e19f3928a324d512ea53430102e1d actions-runner-linux-x64-2.329.0.tar.gz" | sha256sum -c && \
        tar xzf ./actions-runner-linux-x64-2.329.0.tar.gz && \
        rm -rf actions-runner-linux-x64-2.329.0.tar.gz \
    ; fi
COPY home/ubuntu/actions-runner/add-runner.sh /home/ubuntu/actions-runner/add-runner.sh

# Download gradle
WORKDIR /home/ubuntu
COPY --chown=ubuntu home/ubuntu/gradle-template/ gradle-template/
WORKDIR /home/ubuntu/gradle-template
# RUN ./gradlew --version
RUN ./gradlew wrapper --gradle-version 8.13
RUN ./gradlew wrapper
# Install playwright
USER root
RUN cp -r /home/ubuntu/.gradle /root/.gradle
RUN ./gradlew playwright --args="install --with-deps"
RUN rm -rf /home/ubuntu/gradle-template
# Copy downloaded browsers to ubuntu user to avoid download twice
RUN cp -r /root/.cache /home/ubuntu/.cache
RUN chown -R ubuntu:ubuntu /home/ubuntu/.cache
USER ubuntu


WORKDIR /home/ubuntu/actions-runner

CMD ["./add-runner.sh"]
