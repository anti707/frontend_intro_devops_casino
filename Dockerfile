FROM node:20-slim as build

WORKDIR /usr/src/app

COPY package.json package-lock.json* ./
RUN npm install

COPY . ./
RUN npm run build -- --configuration production

FROM nginx:alpine as runtime
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /usr/src/app/dist/casino-frontend/browser/ /usr/share/nginx/html/

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
