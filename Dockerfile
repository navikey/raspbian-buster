FROM raspbian/stretch:latest

LABEL maintainer="Mikhail Snetkov <msnetkov@navikey.ru>"

RUN true \
	export DEBIAN_FRONTEND=noninteractive \
	# Do not start daemons after installation.
	&& echo -e '#!/bin/sh\nexit 101' > /usr/sbin/policy-rc.d \
	&& chmod +x /usr/sbin/policy-rc.d \
	# Update all packages.
	&& apt-get update \
	&& apt-get upgrade -y \
	&& apt-get full-upgrade -y \
	&& apt-get autoremove --purge -y \
	&& apt-get clean -y \
	# Switch to Buster repository.
	&& sed -i 's/stretch/buster/g' /etc/apt/sources.list \
	# Update all packages.
	&& apt-get update \
	&& apt-get upgrade -y \
	&& apt-get full-upgrade -y \
	&& apt-get autoremove --purge -y \
	&& apt-get clean -y \
	# Remove files outside image.
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -f /usr/sbin/policy-rc.d \
	# Unset changed env variables.
	&& unset DEBIAN_FRONTEND
