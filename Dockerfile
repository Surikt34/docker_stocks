# Указываем базовый образ с установленным Python
FROM python:3.11-slim

# Устанавливаем рабочую директорию внутри контейнера
WORKDIR /app

# Копируем файл зависимостей
COPY requirements.txt /app/

# Устанавливаем зависимости
RUN pip install --no-cache-dir -r requirements.txt

# Копируем проект в контейнер
COPY . /app/

# Устанавливаем переменные среды
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Выполняем миграции и собираем статические файлы
RUN python manage.py collectstatic --noinput
RUN python manage.py migrate

# Открываем порт, который будет использоваться
EXPOSE 8000

# Запускаем Django сервер
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]