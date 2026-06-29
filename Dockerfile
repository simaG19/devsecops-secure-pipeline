FROM python:3.11-alpine
WORKDIR /usr/src/app
RUN pip install --no-cache-dir --upgrade pip setuptools wheel
COPY app/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY app/ ./
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

EXPOSE 5000
CMD ["python", "app.py"]