# Cherry

A fork of the [Charybdis](https://github.com/charybdis-ircd/charybdis) IRCv3
server for Upnet. This is meant to be used with the
[Apple](https://sherlock.naughtysysadmins.com/upnet/apple) IRC network services.

## Supported Platforms

  * Debian

## Dependencies

  * `automake`
  * `bison`
  * `bsdmainutils`
  * `build-essential`
  * `flex`
  * `git`
  * `libssl-dev`
  * `libtool`
  * `openssl`
  * `zlib1g-dev`

## Building from Source

```
./autogen.sh
./configure
make
sudo make install
```
