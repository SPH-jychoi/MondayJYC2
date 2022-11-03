#현재 젠킨스 설정을 하지 않았기 때문에 docker file 내에서 빌드 설정 
FROM node:16.14.2 as builder
WORKDIR /app
COPY package.json /app/package.json
RUN npm install --legacy-peer-deps
COPY . /app

RUN npm run build
FROM nginx:1.21.1
#COPY build /usr/share/nginx/html
COPY --from=builder /app/build /usr/share/nginx/html
COPY default.conf /etc/nginx/conf.d/default.conf
EXPOSE 90
