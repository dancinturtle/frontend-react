# build phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# run phase
# the next FROM indicates this is another phase
FROM nginx
# in most environments, EXPOSE is meant to just communicate between developers, it doesn't actually do anything
# but in elastic beanstalk, EXPOSE will map this port
EXPOSE 80
# copy the build folder from build phase
COPY --from=builder /app/build /usr/share/nginx/html
# nginx image already contains command to run nginx