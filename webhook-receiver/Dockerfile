FROM nginx:latest

# install packages
RUN apt update
RUN apt install -y docker.io
RUN apt install -y fcgiwrap spawn-fcgi
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# set fcgiwrap env
COPY etc/default/fcgiwrap /etc/default/fcgiwrap

COPY etc/nginx/nginx.conf /etc/nginx/nginx.conf

# init /srv/cgi-bin
COPY srv/cgi-bin/start-runner.sh /srv/cgi-bin/start-runner.sh
RUN chown -R nginx:nginx /srv/cgi-bin
RUN chmod +x /srv/cgi-bin/start-runner.sh

COPY docker-entrypoint.d/40-fcgiwrap.start.sh /docker-entrypoint.d/40-fcgiwrap.start.sh
RUN chmod +x /docker-entrypoint.d/40-fcgiwrap.start.sh

COPY docker-entrypoint.d/50-init-docker.sh /docker-entrypoint.d/50-init-docker.sh
RUN chmod +x /docker-entrypoint.d/50-init-docker.sh

COPY docker-entrypoint.d/60-init-env.sh /docker-entrypoint.d/60-init-env.sh
RUN chmod +x /docker-entrypoint.d/60-init-env.sh

COPY etc/nginx/ssl/nginx-selfsigned.crt /etc/nginx/ssl/nginx-selfsigned.crt
COPY etc/nginx/ssl/nginx-selfsigned.key /etc/nginx/ssl/nginx-selfsigned.key
