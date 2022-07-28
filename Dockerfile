FROM python:3.8.10-slim as builder

WORKDIR /usr/src/app
ENV FLASK_APP=app

# COPY /app/requirements.txt ./

# RUN pip install --upgrade pip
# RUN pip install -r requirements.txt

# POETRY_VIRTUALENVS_IN_PROJECT=true
ENV PYTHONUNBUFFERED=1 \
    POETRY_HOME="/opt/poetry" \
    POETRY_VIRTUALENVS_CREATE=false
ENV PATH="$POETRY_HOME/bin:$PATH"

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        curl \
        build-essential \
        git \
        cmake

COPY pyproject.toml poetry.lock ./

RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python

RUN poetry install

# FROM python:3.8.10-slim
# COPY --from=builder /app/.venv /app/.venv 
# ENV PATH=/app/.venv/bin:$PATH
