FROM ubuntu:latest

# install packages
RUN apt update
RUN apt install -y curl libicu-dev jq
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /home/ubuntu
USER ubuntu

# copied from github install runner
RUN mkdir actions-runner && cd actions-runner
RUN curl -o actions-runner-linux-arm64-2.316.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.316.1/actions-runner-linux-arm64-2.316.1.tar.gz
RUN echo "4f506deac376013a95683fd5873e9c40f27e5790895147ccaa24d7c970532249  actions-runner-linux-arm64-2.316.1.tar.gz" | sha256sum -c
RUN tar xzf ./actions-runner-linux-arm64-2.316.1.tar.gz
COPY add-runner-arm64.sh /home/ubuntu/add-runner-arm64.sh

CMD ["./add-runner-arm64.sh"]
