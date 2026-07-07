FROM node:20-slim as build

WORKDIR /usr/src/app

COPY package.json package-lock.json* ./
RUN npm install

COPY . ./
RUN npm run build -- --configuration production

FROM nginx:alpine as runtime
COPY --from=build /usr/src/app/dist/casino-frontend /usr/share/nginx/html/

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
