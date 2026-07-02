FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN echo 'VITE_SUPABASE_URL=https://qcooyglsncljsojebfld.supabase.co' > .env && \
    echo 'VITE_SUPABASE_PUBLISHABLE_KEY=sb_publishable_8rhHDQeH5KW9R5xN5dZHaA_3dMrRhGL' >> .env
RUN npm run build

FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
