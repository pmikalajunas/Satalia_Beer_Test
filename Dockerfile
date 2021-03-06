# Base Image
FROM python:3.6

# create and set working directory
RUN mkdir /app
WORKDIR /app

# Add current directory code to working directory
ADD . /app/

# set default environment variables
ENV PYTHONUNBUFFERED 1
ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive 

ENV PORT=8888

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        tzdata \
        python3-setuptools \
        python3-pip \
        python3-dev \
        python3-venv \
        git \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# install environment dependencies
RUN pip3 install --upgrade pip 
RUN pip3 install pipenv

# Install project dependencies
RUN pipenv install --skip-lock --system --dev
# Setup database
RUN python manage.py makemigrations
RUN python manage.py migrate

EXPOSE 8888
CMD gunicorn beer_test.wsgi:application --bind 0.0.0.0:$PORT

# Run docker with the following command:
# docker run -it -p 8888:8888 satalia_beer_test


#docker tag satalia-beer-test pmikalajunas/satalia-beer-test:satalia-beer-test
#docker push pmikalajunas/satalia-beer-test:satalia-beer-test

# Build docker image:
# docker build -t satalia_beer_test -f Dockerfile .