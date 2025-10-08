# ChirpStack + Khomp - Adaptado para utilizar RabbitMQ ao invés de Mosquitto

Este é um fork de https://github.com/support-khomp/chirpstack-docker.

Adaptações/Alterações:
- Substituição do Mosquitto (MQTT) pelo RabbitMQ (com usuário e senha)
- Ativada integração AMQP para comunicação com RabbitMQ via filas
  (Para consumir deve criar um binding no exchange "amq.topic" veja abaixo)
- Atualizado com a versão mais recente do projeto original (Porém mantido apenas a região au915_0 e removido bacicstation) (https://github.com/chirpstack/chirpstack-docker/)
- Utilizando .env para configurar usuário e senhas

**Importante**: antes de executar o projeto, crie um arquivo `.env`, copiando o conteúdo do arquivo `.env.example` e alterando as variáveis conforme necessário.

## Consumindo mensagens do RabbitMQ

Após configurar gateways, tiver uma aplicação e dispositivos conectados no ChirpStack (Ver https://docs.khomp.com/wikidocs/images/7/74/Tutorial_Chirpstack_ITG_-_PT_v5.pdf), as mensagens enviadas pelos dispositivos (já decodificadas pelo codec caso tenha) serão publicadas no exchange "amq.topic" com routing key no formato:

```
application.{{application_id}}.device.{{dev_eui}}.event.{{event}}
```

Portanto se você quer receber todas as mensagens de uma applicação, deve criar um binding no exchange "amq.topic" com a routing key (Application ID pode ser visto na interface web do ChirpStack):

```
application.{{application_id}}.#
```
> Via interface do RabbitMQ, após já ter criado um queue, Vá Exchanges -> amq.topic -> Bindings -> Add binding.


Segue o README do projeto original:
# ChirpStack Docker example

This repository contains a skeleton to setup the [ChirpStack](https://www.chirpstack.io)
open-source LoRaWAN Network Server (v4) using [Docker Compose](https://docs.docker.com/compose/).

**Note:** Please use this `docker-compose.yml` file as a starting point for testing
but keep in mind that for production usage it might need modifications. 

## Directory layout

* `docker-compose.yml`: the docker-compose file containing the services
* `configuration/chirpstack`: directory containing the ChirpStack configuration files
* `configuration/chirpstack-gateway-bridge`: directory containing the ChirpStack Gateway Bridge configuration
* `configuration/mosquitto`: directory containing the Mosquitto (MQTT broker) configuration
* `configuration/postgresql/initdb/`: directory containing PostgreSQL initialization scripts

## Configuration

This setup is pre-configured for **AU915** region. 

This setup comes with a ChirpStack Gateway Bridge instance which is configured to the
au915 topic prefix. You can connect your **ITG 200** UDP packet-forwarder based gateway to **port 1700**.

* You must prefix the MQTT topic with the region.
  Please see the region configuration files in the `configuration/chirpstack` for a list
  of topic prefixes (e.g. eu868, us915_0, au915_0, as923_2, ...).
* The protobuf marshaler is configured.

# Data persistence

PostgreSQL and Redis data is persisted in Docker volumes, see the `docker-compose.yml`
`volumes` definition.

## Requirements

Before using this `docker-compose.yml` file, make sure you have [Docker](https://www.docker.com/community-edition)
installed.


## Importing Khomp LoRaWAN Device repository

To import the [khomp-lorawan-devices](https://github.com/support-khomp/khomp-lorawan-devices)

## Importing device repository

To import the [lorawan-devices](https://github.com/TheThingsNetwork/lorawan-devices)

repository (optional step), run the following command:

```bash
make import-khomp
```

This will clone the `khomp-lorawan-devices` repository. Please note that for this step, you need to have the `git` and `make`
commands installed.

**Note:** an older snapshot of the `lorawan-devices` repository is cloned as the
latest revision no longer contains a `LICENSE` file.

## Usage

To start the ChirpStack simply run:

```bash
$ make docker
```

or

```bash
$ docker-compose up
```

After all the components have been initialized and started, you should be able
to open http://localhost:8080/ in your browser.

##

The example includes the [ChirpStack REST API](https://github.com/chirpstack/chirpstack-rest-api).
You should be able to access the UI by opening http://localhost:8090 in your browser.

**Note:** It is recommended to use the [gRPC](https://www.chirpstack.io/docs/chirpstack/api/grpc.html)
interface over the [REST](https://www.chirpstack.io/docs/chirpstack/api/rest.html) interface.
