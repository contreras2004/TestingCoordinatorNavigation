FROM node:8.11.3

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm install --production

COPY . .

CMD npm start