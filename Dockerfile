FROM python:3.9

RUN mkdir -p /root/hr_system
WORKDIR /root/hr_system

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN apt-get update && \
    apt-get install postgresql postgresql-contrib && \
    createdb hr

CMD rm -rf tests

#ENTRYPOINT [ "python", "src/hr_system/cli.py" ]