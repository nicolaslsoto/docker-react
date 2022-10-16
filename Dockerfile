# temporary container to build the application
FROM node:16-alpine AS builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build 

# final container to serve the application from an nginx server.
# here we are grabbing the build folder from app directory and copying to the default nginx path.
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
