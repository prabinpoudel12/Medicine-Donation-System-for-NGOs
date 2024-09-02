FROM python:3.8-alpine AS base

RUN apk add --update gcc libc-dev

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

FROM python:3.8-alpine

COPY --from=base /usr/local/lib/python3.8/site-packages/ /usr/local/lib/python3.8/site-packages/

COPY --from=base /usr/local/bin/ /usr/local/bin

WORKDIR /app

COPY . .

EXPOSE 8000

ENTRYPOINT [ "/app/entrypoint.sh" ]