# Build phase
FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install

# copy all source code in directly. Not dynamicas with volumes
COPY . . 
# build the npm image
RUN npm run build

# Run phase. Second from means you can drop the previous phase's images. Each "FROM" statement terminates the previous block
FROM nginx
# copy the contents of an /app/build from the previous phase (builder) into the current phase in the location specified (the given directory is the default for html with nginx)
COPY --from=builder /app/build /usr/share/nginx/html
# DONT need to specify start command since nginx's default command is "Start nginx"


