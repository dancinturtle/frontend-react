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
# copy the build folder from build phase
COPY --from=builder /app/build /usr/share/nginx/html
# nginx image already contains command to run nginx