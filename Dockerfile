FROM python:3.12-slim

# tk = tkinter's C lib, not in slim base
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-tk \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app/ .

CMD ["python", "main.py"]
