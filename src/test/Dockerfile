FROM python:2.7.18-stretch
COPY requirments.txt .
RUN pip install -r requirments.txt
COPY e2e .
COPY sanity .
COPY e2e_test.py .
# ENTRYPOINT python2 e2e_test.py app:8080 sanity 5 
ENTRYPOINT python2 e2e_test.py app:8083 e2e 5 
