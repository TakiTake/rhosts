RHosts
====

hosts file manager

# Description

rhosts is a command that facilitates the management of the host file.

# Usage
## show all hosts
```
$ rhosts
rhosts> all
### actives
127.0.0.1
  localhost
  dev-www.example.com

127.0.0.2
  stg-www.example.com

### inactives
127.0.0.1
  stg-www.example.com

```

## show active hosts
```
rhosts> actives
### actives
127.0.0.1
  localhost
  dev-www.example.com

127.0.0.2
  stg-www.example.com

```

## show inactive hosts
```
rhosts> inactives
### inactives
127.0.0.1
  stg-www.example.com

```

## map specific host
```
$ rhosts
rhosts> actives
### actives
127.0.0.1
  localhost
  dev-www.example.com

127.0.0.2
  stg-www.example.com

rhosts> map "dev-www.example.co.jp" => "127.0.0.1"
rhosts> actives
### actives
127.0.0.1
  localhost
  dev-www.example.com
  dev-www.example.co.jp

127.0.0.2
  stg-www.example.com

```

## unmap specific host
```
$ rhosts
rhosts> actives
### actives
127.0.0.1
  localhost
  dev-www.example.com

127.0.0.2
  stg-www.example.com

rhosts> unmap "dev-www.example.com" => "127.0.0.1"
rhosts> actives
### actives
127.0.0.1
  localhost

127.0.0.2
  stg-www.example.com

```
