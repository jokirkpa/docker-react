# Build Phase
# The "AS" defines this phase as "builder"
FROM node:16-alpine AS builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build



# Run Phase
FROM nginx
EXPOSE 80
# Here we can specify that we want to copy from the predefined builder phase
# We then specify the build directory of node, and palce it into the html 
# directory of nginx
COPY --from=builder /app/build /usr/share/nginx/html