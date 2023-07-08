FROM alpine:latest

# 建立工作目錄
WORKDIR /usr/src/app

# 時區
ENV TZ=Asia/Taipei

# 安裝&更新所需的套件
RUN apk update
RUN apk upgrade --no-cache
RUN apk add --no-cache nodejs npm icu-data-full tzdata
RUN echo "${TZ}" > /etc/timezone 
RUN ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime 
RUN rm /var/cache/apk/*

# Install app dependencies
# 把目錄下的程式碼直接復制到容器中
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./
RUN npm install 
COPY . .

# 指定使用的端口
EXPOSE 3095
EXPOSE 3094 

# 容器啟動時
CMD [ "npm", "start" ]