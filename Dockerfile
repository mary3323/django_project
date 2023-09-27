FROM python:3.11

ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY mysite/requirements.txt requirements.txt

RUN pip install --upgrade pip "poetry==1.6.1"
RUN pip install -r requirements.txt
COPY mysite/pyproject.toml poetry.lock ./
RUN poetry install


COPY mysite/mysite .

CMD ["gunicorn", "mysite.wsgi:application", "--bind", "0.0.0.0:8000"]
