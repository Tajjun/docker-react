# the as builder mean that everything below it will be refered to as builder

FROM node:alpine as builder

WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build <--- all the stuff we care about

# Phase 2 of nginx

FROM nginx
EXPOSE 80
# command to copy over the folder from the previous container
COPY --from=builder /app/build /usr/share/nginx/html