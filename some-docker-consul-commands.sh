docker --host=192.168.33.40 run \
    -d \
    --name=consul \
    --mount source=/etc/consul.d/,target=/consul/config \
     -p 8300:8300 \
     -p 8301:8301 \
     -p 8301:8301/udp \
     -p 8302:8302 \
     -p 8302:8302/udp \
     -p 8400:8400 \
     -p 8500:8500 \
     -p 53:53/udp \
    consul agent -ui

docker run     -d     --name=consul     -v /consul/config:/consul/config      -p 8300:8300      -p 8301:8301      -p 8301:8301/udp      -p 8302:8302      -p 8302:8302/udp
      -p 8400:8400      -p 8500:8500      -p 53:53/udp     consul agent -ui

docker run \
    -d \
    --name=consul \
    --mount source=/etc/consul.d/,target=/consul/config \
     -p 8300:8300 \
     -p 8301:8301 \
     -p 8301:8301/udp \
     -p 8302:8302 \
     -p 8302:8302/udp \
     -p 8400:8400 \
     -p 8500:8500 \
     -p 53:53/udp \
    consul agent -ui


docker --host=192.168.33.40 run \
      -d \
      --name=consul \
      -e CONSUL_LOCAL_CONFIG='{
       "datacenter":"alpha",
       "advertise_addr": "192.168.33.40",
       "client_addr": "0.0.0.0",
       "node_name": "consul_1",
       "server":true,
       "enable_debug":true,
      "skip_leave_on_interrupt": true,
      "rejoin_after_leave": true,
      "retry_interval": "30s",
       "bootstrap_expect": 1
       }' \
       -p 8300:8300 \
       -p 8301:8301 \
       -p 8301:8301/udp \
       -p 8302:8302 \
       -p 8302:8302/udp \
       -p 8400:8400 \
       -p 8500:8500 \
       -p 53:53/udp \
      consul agent -ui

--- second server
docker --host=192.168.33.20 run \
      -d \
      --name=consul \
      -e CONSUL_LOCAL_CONFIG='{
       "datacenter":"alpha",
       "advertise_addr": "192.168.33.20",
       "client_addr": "0.0.0.0",
       "node_name": "consul_2",
       "server":true,
       "enable_debug":true,
       "retry_join": [
         "192.168.33.40"
        ]
       }' \
       -p 8300:8300 \
       -p 8301:8301 \
       -p 8301:8301/udp \
       -p 8302:8302 \
       -p 8302:8302/udp \
       -p 8400:8400 \
       -p 8500:8500 \
       -p 53:53/udp \
      consul agent

-----
   docker run \
      -d \
      --name=consul \
      -e CONSUL_LOCAL_CONFIG='{
       "datacenter":"alpha",
       "advertise_addr": "192.168.33.40",
       "server":true,
       "enable_debug":true
       }' \
       -p 8300:8300 \
       -p 8301:8301 \
       -p 8301:8301/udp \
       -p 8302:8302 \
       -p 8302:8302/udp \
       -p 8400:8400 \
       -p 8500:8500 \
       -p 53:53/udp \
      consul agent -server -ui -advertise=192.168.33.40 -client="0.0.0.0" -bootstrap-expect=1
