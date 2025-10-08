docker:
	docker-compose up

import-khomp:
	docker-compose run --rm --entrypoint sh --user root chirpstack -c '\
	apk add --no-cache git && \
	git clone https://github.com/support-khomp/khomp-lorawan-devices.git /tmp/lorawan-devices && \
	chirpstack -c /etc/chirpstack import-legacy-lorawan-devices-repository -d /tmp/lorawan-devices'

import-lorawan-devices:
	docker-compose run --rm --entrypoint sh --user root chirpstack -c '\
		apk add --no-cache git && \
		git clone https://github.com/brocaar/lorawan-devices /tmp/lorawan-devices && \
		chirpstack -c /etc/chirpstack import-legacy-lorawan-devices-repository -d /tmp/lorawan-devices'