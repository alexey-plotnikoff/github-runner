# What this project for?

If you want to use self-hosted GitHub Runners. Currently works only on **MacOS with ARM processor**.



# Idea

You have a free time and you want to code a little you own project. So you only need:
1. start Docker or [OrbStack](https://orbstack.dev/);
2. run single `nginx-webhook-receiver` container for receive GitHub's webhooks;
3. each webhook starts a new `github-runner-ubuntu` container to execute your [workflow](https://docs.github.com/en/actions/learn-github-actions/understanding-github-actions#workflows) that connects to GitHub;
4. each `github-runner-ubuntu` container will destroy after finish workflow job;
5. stop `nginx-webhook-receiver` container when you finish (via `CTRL+C` in terminal).



# Setup

1. Generate your personal [access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens).
2. Set `GITHUB_TOKEN` environment variable with your access token value.
3. Set correct `ORGANIZATION` and `REPO` values in `env` file.
4. Build runner image (based on `ubuntu:latest`)
```
cd runner
docker build -t github-runner-ubuntu .
```
5. Build webhook receiver image (based on `nginx:latest`)
```
cd ../webhook-receiver
docker build -t nginx-webhook-receiver .
```
6. Run web webhook receiver (default port is `10000` or pass your own port number as additional parameter)
```
cd ..
./run-webhook-receiver.sh
```
For run self-hosted GitHub runner just visit:
```
curl -v http://127.0.0.1:10000/cgi-bin/start-runner.sh
```
7. [Create webhook](https://docs.github.com/en/webhooks/using-webhooks/creating-webhooks)
8. Setup port forwarding on your router to your macbook
9. If you not in home (for example in cafe) you can skip steps 4-7 and only run (you must run this manually on each push to your repository)
```
docker run --rm -d -e GITHUB_TOKEN=$GITHUB_TOKEN -e ORGANIZATION=$ORGANIZATION -e REPO=$REPO --group-add $(stat -c '%g' /var/run/docker.sock) -v /var/run/docker.sock:/var/run/docker.sock github-runner-ubuntu:latest
```
