FROM node:lts-alpine as build
WORKDIR /ops
ENV PATH /ops/node_modules/.bin:$PATH
COPY package.json ./
RUN npm install -g npm@8.19.1
RUN npm i --silent
COPY . ./

RUN npm run build



FROM nginx:1.21
RUN apt-get update \
    && apt-get install -y wget \
    && rm -rf /var/lib/apt/lists/*
RUN rm -rf /usr/share/nginx/html/*
RUN addgroup --system django \
    && adduser --system --ingroup django django
COPY --chown=django:django ./nginx/nginx.conf /etc/nginx/conf.d/configfile.template
COPY --from=build /ops/nginx/nginx.conf /etc/nginx/conf.d/default.conf:ro
COPY --from=build /ops/dist /usr/share/nginx/html

USER django

ENV PORT 8080
ENV HOST 0.0.0.0

ENTRYPOINT []


CMD sh -c "envsubst '\$PORT' < /etc/nginx/conf.d/configfile.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"