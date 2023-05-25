# Using Elastic stack (ELK) on Docker to input random words in english with a dockerized python scropt

The objective of this project was to learn some Docker and Elastic Search + Kibana. My initial approach was pulling the Elastic Search and the Kibana images and then uniting them, but this method proved very fast to be a hassle. Elastic Search wrote a very verbose output where inbetween there was the password that Kibana needed in order to communicate with ES(Elastic Search)

## tl;dr

```sh
docker-compose up setup
```

```sh
docker-compose up
```

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

