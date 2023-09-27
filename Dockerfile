FROM python:3.11

ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY requirements.txt requirements.txt


RUN pip install --upgrade pip "poetry==1.6.1"
RUN poetry config virtualenvs.create false --local
COPY pyproject.toml poetry.lock ./
RUN poetry install


COPY mysite/mysite .

CMD ["gunicorn", "wsgi:application", "--bind", "0.0.0.0:8000"]
