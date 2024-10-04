# Cкрипты
1. npm run dev - для запуска локально
2. npm run build - для сборки
3. npm run preview - предпросмотр сборки


# Зависимости
1. React, React-Router, Redux, React-Redux, Redux-Toolkit --- экосистема react
2. axios, js-cookie --- для запросов/для работы с cookie
3. konva, react-konva --- основная либо для конструктора и самого интерфейса склада


# Список остальных зависимостей так же есть в файле package.json

# Дополнительно
1. При запуске в режиме разработки в терминале генерируется Qr-код для запуска и тестирования на других устройствах
2. В файле axios.js редактируется base-url для api

# Развертывание образа (production)
1. Тянем на сервак все с репозитория и запускаем команду "docker build -t front-app ." в той же директории
2. Установить nginx и создать nginx конфиг для фронта. (обычно путь /etc/nginx/sites-available) или редачим дефолтный
   
       server {
        listen 80;
        server_name ТУТ_IP_АДРЕСС_ИЛИ_ДОМЕН;
   
        location / {
            proxy_pass http://127.0.0.1:8080;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }
       }
   
4. Далее перезапуск nginx "sudo systemctl restart nginx" или "sudo service restart nginx"
5. Далее запускаем "docker run -p 8080:4173 -d front-app"
6. Если 80 порт закрыт - открываем

# При внесении обновлений
## Если вносились правки и изменения в проект нужно пересобрать контейнер
1.  стянуть все с репозитория
2.  docker stop <container_id>
3.  docker rm <container_id>
4.  docker build -t front-app .
5.  docker run -p 8080:4173 -d front-app

