FROM python:3
ADD requirements.txt /
RUN pip install -r requirements.txt
ADD main.py /
ENV PYTHONUNBUFFERED=1
CMD [ "python", "-u", "./main.py" ]