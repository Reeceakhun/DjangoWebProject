FROM python:3.7 AS base

WORKDIR /code

# Allows docker to cache installed dependencies between builds
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Mounts the application code to the image
COPY . .

FROM python:3.7-alpine

WORKDIR /code

# copy the installed dependency

COPY --from=base /code /code
EXPOSE 8000

# runs the production server
ENTRYPOINT ["python", "manage.py"]
CMD ["runserver", "0.0.0.0:8000"]