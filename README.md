# docker-compose の調査

### settings

| yml file name        | format    | network | links   |
| -------------------- | --------- | ------- | ------- |
| v1.yml               | version 1 | default | enable  |
| v2.yml               | version 2 | default | disable |
| v2-ext-net.yml       | version 2 | pingnet | disable |
| v2-ext-net-links.yml | version 2 | pingnet | enable  |

Version 1 is deprecated in a future.

### result

- `Version 2` はデフォルトのネットワークは使わないで新しいネットワークを使う。
- `Version 2` は環境変数が設定されない？
- docker 1.10 以降（要確認）はデフォルト以外のネットワークを使う場合に hosts ではなく内部 DNS を利用する

| yml file name        | network         | ping | hosts | environment | etc |
| -------------------- | --------------- | ---- | ----- | ----------- | --- |
| v1.yml               | bridge(default) | ✔    | ✔     | ✔           |     |
| v2.yml               | nettest_default | ✔    | ✗     |  ✗          | DNS |
| v2-ext-net.yml       | nettest_pingnet | ✔    | ✗     |  ✗          | DNS |
| v2-ext-net-links.yml | nettest_pingnet | ✔    | ✗     |  ✗          | DNS |

```console
[mapk0y@kona:~/local/docker/compose/net-test]$ docker-compose version
docker-compose version 1.7.0, build 0d7bf73
docker-py version: 1.8.0
CPython version: 2.7.9
OpenSSL version: OpenSSL 1.0.1e 11 Feb 2013

[mapk0y@kona:~/local/docker/compose/net-test]$ ./test_script.sh
=== ./v1.yml ===
Creating nettest_pingdst_1
Creating nettest_pingsrc_1
Attaching to nettest_pingdst_1, nettest_pingsrc_1
pingsrc_1  | 127.0.0.1  localhost
pingsrc_1  | ::1        localhost ip6-localhost ip6-loopback
pingsrc_1  | fe00::0    ip6-localnet
pingsrc_1  | ff00::0    ip6-mcastprefix
pingsrc_1  | ff02::1    ip6-allnodes
pingsrc_1  | ff02::2    ip6-allrouters
pingsrc_1  | 172.17.0.2 nettest_pingdst_1 26a0505173c7
pingsrc_1  | 172.17.0.2 pingdst 26a0505173c7 nettest_pingdst_1
pingsrc_1  | 172.17.0.2 pingdst_1 26a0505173c7 nettest_pingdst_1
pingsrc_1  | 172.17.0.3 b8c043da0e5a
pingsrc_1  |
pingsrc_1  | HOSTNAME=b8c043da0e5a
pingsrc_1  | PINGDST_1_NAME=/nettest_pingsrc_1/pingdst_1
pingsrc_1  | HOME=/root
pingsrc_1  | PINGDST_NAME=/nettest_pingsrc_1/pingdst
pingsrc_1  | TERM=xterm
pingsrc_1  | PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
pingsrc_1  | PWD=/
pingsrc_1  | NETTEST_PINGDST_1_NAME=/nettest_pingsrc_1/nettest_pingdst_1
pingsrc_1  |
pingsrc_1  | PING pingdst (172.17.0.2): 56 data bytes
pingsrc_1  | 64 bytes from 172.17.0.2: icmp_seq=0 ttl=64 time=0.082 ms
pingsrc_1  | 64 bytes from 172.17.0.2: icmp_seq=1 ttl=64 time=0.044 ms
pingsrc_1  | 64 bytes from 172.17.0.2: icmp_seq=2 ttl=64 time=0.043 ms
pingsrc_1  | 64 bytes from 172.17.0.2: icmp_seq=3 ttl=64 time=0.063 ms
^CGracefully stopping... (press Ctrl+C again to force)
Stopping nettest_pingsrc_1 ...
Stopping nettest_pingdst_1 ...
Killing nettest_pingsrc_1 ... done
Killing nettest_pingdst_1 ... done
Going to remove nettest_pingsrc_1, nettest_pingdst_1
Removing nettest_pingsrc_1 ... done
Removing nettest_pingdst_1 ... done
=== ./v2-ext-net-links.yml ===
Creating nettest_pingdst_1
Creating nettest_pingsrc_1
Attaching to nettest_pingdst_1, nettest_pingsrc_1
pingsrc_1  | 127.0.0.1  localhost
pingsrc_1  | ::1        localhost ip6-localhost ip6-loopback
pingsrc_1  | fe00::0    ip6-localnet
pingsrc_1  | ff00::0    ip6-mcastprefix
pingsrc_1  | ff02::1    ip6-allnodes
pingsrc_1  | ff02::2    ip6-allrouters
pingsrc_1  | 172.19.0.3 6eb2cb95bed0
pingsrc_1  |
pingsrc_1  | HOSTNAME=6eb2cb95bed0
pingsrc_1  | HOME=/root
pingsrc_1  | TERM=xterm
pingsrc_1  | PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
pingsrc_1  | PWD=/
pingsrc_1  |
pingsrc_1  | PING pingdst (172.19.0.2): 56 data bytes
pingsrc_1  | 64 bytes from 172.19.0.2: icmp_seq=0 ttl=64 time=0.066 ms
pingsrc_1  | 64 bytes from 172.19.0.2: icmp_seq=1 ttl=64 time=0.041 ms
pingsrc_1  | 64 bytes from 172.19.0.2: icmp_seq=2 ttl=64 time=0.040 ms
pingsrc_1  | 64 bytes from 172.19.0.2: icmp_seq=3 ttl=64 time=0.049 ms
pingsrc_1  | 64 bytes from 172.19.0.2: icmp_seq=4 ttl=64 time=0.043 ms
^CGracefully stopping... (press Ctrl+C again to force)
Stopping nettest_pingsrc_1 ...
Stopping nettest_pingdst_1 ...
Killing nettest_pingsrc_1 ... done
Killing nettest_pingdst_1 ... done
Going to remove nettest_pingsrc_1, nettest_pingdst_1
Removing nettest_pingsrc_1 ... done
Removing nettest_pingdst_1 ... done
=== ./v2-ext-net.yml ===
Creating nettest_pingsrc_1
Creating nettest_pingdst_1
Attaching to nettest_pingsrc_1, nettest_pingdst_1
pingsrc_1  | 127.0.0.1  localhost
pingsrc_1  | ::1        localhost ip6-localhost ip6-loopback
pingsrc_1  | fe00::0    ip6-localnet
pingsrc_1  | ff00::0    ip6-mcastprefix
pingsrc_1  | ff02::1    ip6-allnodes
pingsrc_1  | ff02::2    ip6-allrouters
pingsrc_1  | 172.19.0.2 8a0e900ea4d4
pingsrc_1  |
pingsrc_1  | HOSTNAME=8a0e900ea4d4
pingsrc_1  | HOME=/root
pingsrc_1  | TERM=xterm
pingsrc_1  | PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
pingsrc_1  | PWD=/
pingsrc_1  |
pingsrc_1  | PING pingdst (172.19.0.3): 56 data bytes
pingsrc_1  | 64 bytes from 172.19.0.3: icmp_seq=0 ttl=64 time=999.258 ms
pingsrc_1  | 64 bytes from 172.19.0.3: icmp_seq=1 ttl=64 time=0.044 ms
pingsrc_1  | 64 bytes from 172.19.0.3: icmp_seq=2 ttl=64 time=0.041 ms
pingsrc_1  | 64 bytes from 172.19.0.3: icmp_seq=3 ttl=64 time=0.041 ms
^CGracefully stopping... (press Ctrl+C again to force)
Stopping nettest_pingdst_1 ...
Stopping nettest_pingsrc_1 ...
Killing nettest_pingdst_1 ... done
Killing nettest_pingsrc_1 ... done
Going to remove nettest_pingdst_1, nettest_pingsrc_1
Removing nettest_pingdst_1 ... done
Removing nettest_pingsrc_1 ... done
=== ./v2.yml ===
Creating nettest_pingsrc_1
Creating nettest_pingdst_1
Attaching to nettest_pingsrc_1, nettest_pingdst_1
pingsrc_1  | 127.0.0.1  localhost
pingsrc_1  | ::1        localhost ip6-localhost ip6-loopback
pingsrc_1  | fe00::0    ip6-localnet
pingsrc_1  | ff00::0    ip6-mcastprefix
pingsrc_1  | ff02::1    ip6-allnodes
pingsrc_1  | ff02::2    ip6-allrouters
pingsrc_1  | 172.20.0.2 28be50a117a9
pingsrc_1  |
pingsrc_1  | HOSTNAME=28be50a117a9
pingsrc_1  | HOME=/root
pingsrc_1  | TERM=xterm
pingsrc_1  | PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
pingsrc_1  | PWD=/
pingsrc_1  |
pingsrc_1  | PING pingdst (172.20.0.3): 56 data bytes
pingsrc_1  | 64 bytes from 172.20.0.3: icmp_seq=0 ttl=64 time=0.072 ms
pingsrc_1  | 64 bytes from 172.20.0.3: icmp_seq=1 ttl=64 time=0.043 ms
pingsrc_1  | 64 bytes from 172.20.0.3: icmp_seq=2 ttl=64 time=0.043 ms
^CGracefully stopping... (press Ctrl+C again to force)
Stopping nettest_pingdst_1 ...
Stopping nettest_pingsrc_1 ...
Killing nettest_pingdst_1 ... done
Killing nettest_pingsrc_1 ... done
Going to remove nettest_pingdst_1, nettest_pingsrc_1
Removing nettest_pingdst_1 ... done
Removing nettest_pingsrc_1 ... done
[mapk0y@kona:~/local/docker/compose/net-test]$
```
