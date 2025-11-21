# Using Elastic stack (ELK) on Docker to input random words in english with a dockerized python script

## Creation Process

### First Trial

The objective of this project was to learn some Docker and Elastic Search + Kibana. My initial approach was pulling the Elastic Search and the Kibana images and then uniting them, but this method proved very fast to be a hassle. Elastic Search wrote a very verbose output where inbetween there was the password that Kibana needed in order to communicate with ES(Elastic Search).

### The new approach

This new version uses instead an already done Docker Compose setup with Elastic Search, Kibana and Logstash, which I initially didn't think on using. After checking it out, and seeing that it works in an awesome way, I decided to go through Docker Fundamentals, to see what I could build on top. The resource I used to learn, which is super-great is the following: [Introduction to Containers](https://container.training/intro-selfpaced.yml.html#1)

After going through some hundreds of slides, I decided to write a python script that generates random words in english, and to try to create an image that executes it. After that, to try to capture the words and send them to Elastic Search, so I can see them with kibana. The script can be found at /image-creator-word-generator/main.py

After creating an image with the Dockerfile, I uploaded the image to Dockerhub, you can see it at [cristik24/word-generator](https://hub.docker.com/r/cristik24/word-generator)

Then, I could use it as any other image, so i created "/word-generator" and pulled the image with a dockerfile, which worked after adding it to the docker compose!

The thing now was, how should I send the output of the word-generator container to ElasticSearch? I tried to find a clean way to capture the output and use `netcat -q0 localhost 50000` to send the information to Logstash, which would store the information in Elastic Search and then Kibana would get that information when checking the new information in Elastic Search. I had some ideas:

1. Recreating the image `word-generator` to make it send the python command to `netcat -q0 localhost 50000` with a pipe. This was the cleanest so fast, but I wanted to impose the restriction of not modifying the image, since it would not always be possible in images made by others

2. The dirty way, sending the whole output of the `docker-compose up > output.exe`. This way it would send any error to elastic search, that is something I wanted to do too.

I went to number 2, though the best would have been finding a way to redirect the output from inside the /docker-compose.yml to the netcat. If someone know how to do it, feel free to open an issue ^^

So at the end, after having the file output.exe with all the names, I wrote a little script that gets the tail from it and sends it to the netcat every 2 secons. It's the script in /putter.sh

So, with this all together, i could test it all, and it worked!

## How to install it?

First of all, clone this repo:

```
git clone https://github.com/CRiSTiK24/ELK-docker-fork.git
```
Then set up the docker compose:
```sh
docker-compose up setup
```
Give execution permissions to the shell script
```sh
chmod +x putter.sh
```

## How to start it?


First, we want all the output of the docker compose to be put intro a file
```sh
docker-compose up > output.txt
```
Then, we start the script that will read the file and upload it.
```sh
./putter.sh
```
After this, we leave some minutes the kibana to start. Once you have waited enough, you'll be able to open a browser and open it at localhost with port 5601!

The name and password is at the end of this file. You will find the words at Obervability>Logs>Stream

![If you read this, the Kibana image has not loaded](https://i.imgur.com/CjyHU60.png)

# From down below, the readme is a simplified version of the original repo i Forked

![Animated demo](https://user-images.githubusercontent.com/3299086/155972072-0c89d6db-707a-47a1-818b-5f976565f95a.gif)

---
By default, the stack exposes the following ports:

* 5044: Logstash Beats input
* 50000: Logstash TCP input
* 9600: Logstash monitoring API
* 9200: Elasticsearch HTTP
* 9300: Elasticsearch TCP transport
* 5601: Kibana


### Bringing up the stack

Clone this repository onto the Docker host that will run the stack with the command below:

```sh
git clone https://github.com/deviantony/docker-elk.git
```

Then, initialize the Elasticsearch users and groups required by docker-elk by executing the command:

```sh
docker-compose up setup
```

If everything went well and the setup completed without error, start the other stack components:

```sh
docker-compose up
```

> **Note**  
> You can also run all services in the background (detached mode) by appending the `-d` flag to the above command.

Give Kibana about a minute to initialize, then access the Kibana web UI by opening <http://localhost:5601> in a web
browser and use the following (default) credentials to log in:

* user: *elastic*
* password: *changeme*

