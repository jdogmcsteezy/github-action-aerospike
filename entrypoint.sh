#!/bin/sh
set -e
ls $GITHUB_WORKSPACE

mount=""
if [ -n "$3" ] || [ -n "$4" ]; then
  config_dir="$GITHUB_WORKSPACE/$(dirname $3)"
  echo $config_dir
  ls -la $config_dir
  mount="-v /var/run/docker.sock:/var/run/docker.sock --mount type=bind,src=$config_dir,dst=/etc/aerospike"
fi

# if [ -n "$4" ]; then
  # feature_key_file=$(basename $4)
  # image="-e \"FEATURE_KEY_FILE=/opt/aerospike/etc/$feature_key_file\" aerospike/aerospike-server-enterprise:$2"
# else
  # image="aerospike/aerospike-server:$2"
# fi
image="aerospike/aerospike-server:$2"

if [ -n "$3" ]; then
  config_file=$(basename $3)
  docker_cmd="docker run -d --privileged --name gha_aerospike -p $1:3000 -p 3001:3001 -p 3002:3002 -p 3003:3003 \
  $mount $image --config-file /etc/aerospike/$config_file"
else
  docker_cmd="docker run -d --name gha_aerospike -p $1:3000 -p 3001:3001 -p 3002:3002 -p 3003:3003 $image"
fi

echo $docker_cmd

sh -c "$docker_cmd"