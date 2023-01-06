FROM python:2.7
COPY requirments.txt .
RUN pip install -r requirments.txt
COPY . .
ENV FILE=e2e1
ENTRYPOINT python2 e2e_test.py app:8080 ${FILE} 2
# ENTRYPOINT python e2e_test.py app:8080 e2e 5 
