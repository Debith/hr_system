FROM ubuntu:21.04
ENV DEBIAN_FRONTEND=noninteractive

RUN mkdir -p /root/hr_system
WORKDIR /root/hr_system

RUN apt-get update && apt-get install -y \ 
    python3.9 python3-pip \
    postgresql-13 postgresql-client-13 postgresql-contrib-13

COPY . .
COPY ./data/pg_hba.conf /etc/postgresql/13/main/pg_hba.conf

RUN pip install --no-cache-dir -r requirements.txt
RUN /etc/init.d/postgresql start && \
    createuser -U postgres hruser

CMD rm -rf tests

#ENTRYPOINT [ "python", "src/hr_system/cli.py" ]