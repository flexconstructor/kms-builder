Kurento media server Docker image
=================================

[![GitHub release](https://img.shields.io/github/release/flexconstructor/kms-builder.svg)](https://github.com/flexconstructor/kms-builder/releases) [![Build Status](https://travis-ci.org/flexconstructor/kms-builder.svg?branch=master)](https://travis-ci.org/flexconstructor/kms-builder) [![Docker Pulls](https://img.shields.io/docker/pulls/flexconstructor/kms-builder.svg)](https://hub.docker.com/r/flexconstructor/kms-builder)


This image contains all the tools and dependencies that are needed to build a Kurento media server from source.

## What is Kurento media server?

Kurento is an open source software project providing a platform suitable for creating modular applications with advanced real-time communication capabilities. 

Kurento is part of [FIWARE]. For further information on the relationship of FIWARE and Kurento check the [Kurento FIWARE Catalog Entry]

Kurento is part of the [NUBOMEDIA] research initiative.

[FIWARE]: http://www.fiware.org
[Kurento FIWARE Catalog Entry]: http://catalogue.fiware.org/enablers/stream-oriented-kurento
[NUBOMEDIA]: http://www.nubomedia.eu

> [www.kurento.org](http://www.kurento.org)

> [github.com/kurento](https://github.com/kurento)

![Kurento Logo](http://www.kurento.org/sites/default/files/kurento.png)




## Documentation

The Kurento project provides detailed documentation including tutorials, installation and development guides. A simplified version of the documentation can be found on [readthedocs.org][1]. The [Open API specification][2] a.k.a. Kurento Protocol is also available on [apiary.io][3].




## How to use this image

### Build Kurento-media-server

To build the Kurento-media-server from source, you need to take a few simple steps:

Clone the kurento-omni-build project:

```
git clone https://github.com/Kurento/kms-omni-build.git
```

Enter the kurento-omni-build project directory:

```
cd kms-omni-build/
```

Update kurento-omni-build project sub modules:

```
git submodule update --init --recursive
git submodule update --remote

```

Run the Kurento-media-server build in the Dockerized environment:

```
docker run --rm -v $(PWD):/.kms -e TYPE=Debug flexconstructor/kms-builder:latest
```


### Run unit tests

```
docker run --rm -v $(PWD):/.kms -e TYPE=Debug -w /.kms/build_Debug flexconstructor/kms-builder:latest make check
```

### Build submodules:

```
docker run --rm  -v $(PWD):/.kms  -w /.kms/$(module-name) flexconstructor/kms-builder:latest compile_project.py --base_url https://github.com/Kurento compile 
```


## Environment variables


### `TYPE`

Project build type. CMake accepts the following build types: `Debug`, `Release`, `RelWithDebInfo`. 
So, for a Release build, you would run TYPE=Release instead of TYPE=Debug.

Default: Debug


### `GST_DEBUG`

Can be used to set the debug level of Kurento logs.

Default: `3,Kurento*:3,kms*:3,sdp*:3,webrtc*:4,*rtpendpoint:4,rtp*handler:4,rtpsynchronizer:4,agnosticbin:4`

### `DEB_BUILD_OPTIONS`

You can export is DEB_BUILD_OPTIONS, in order to disable any of unit testing, doc generation (which at the Debian level is mostly nothing, this doesn’t refer to the whole Kurento project documentation site), and binary stripping. For example:
 
```

docker run --rm  -v $(PWD):/.kms  -w /.kms/$(module-name) -e DEB_BUILD_OPTIONS="nocheck nodoc nostrip" flexconstructor/kms-builder:latest compile_project.py --base_url https://github.com/Kurento compile 

```

## Image versions


### `X`

Latest version of major `X` Kurento branch.


### `X.Y`

Latest version of minor `X.Y` Kurento branch.


### `X.Y.Z`

Latest build of concrete `X.Y.Z` version of Kurento.


### `X.Y.Z-rN`

Concrete `N` build of concrete `X.Y.Z` version of Kurento.

## License

Kurento itself is licensed under [Apache 2.0 license][91].

Kurento Docker image is licensed under [MIT license][92].




## Issues
[GitHub issue]: https://github.com/flexconstructor/kms-builder/issues

We can't notice comments in the DockerHub so don't use them for reporting issue or asking question.

If you have any problems with or questions about this image, please contact us through a [GitHub issue].





[1]: https://kurento.readthedocs.io/en/stable/
[2]: https://doc-kurento.readthedocs.io/en/stable/features/kurento_protocol.html
[3]: https://streamoriented.docs.apiary.io/#reference/json-rpc-messages-format
[4]: https://doc-kurento.readthedocs.io/en/stable/user/faq.html#install-coturn-turn-stun-server
[91]: https://github.com/Kurento/kurento-media-server/blob/master/LICENSE
[92]: https://github.com/instrumentisto/kurento-docker-image/blob/master/LICENSE.md
