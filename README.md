# sbtest

This repo contains a Dockerfile specifying an image with Verible, Verilator (v5.018), and Icarus Verilog (v12.0) preinstalled.

The image can be built and released through GitHub Actions by pushing a tag starting with `v`.  For example, if you want to build and release version 0.1.2 of this image:

```shell
$ git tag v0.1.2
$ git push origin v0.1.2
```

This will kick off a build on GitHub Actions, which may take some time.  After it completes, the image will be released here: https://github.com/zeroasiccorp/sbtest/pkgs/container/sbtest.

You can use this Docker image just like images from DockerHub.  For example, if you want to open a shell in the latest version of this image, type:

```shell
docker run --rm -it ghcr.io/zeroasiccorp/sbtest:latest /bin/bash
```

You can also run other GitHub Actions within this container by filling in the `container` field for a job description.  For example,

```yaml
jobs:
  sbtest:
    name: Switchboard Test
    runs-on: ubuntu-latest
    container:
      image: ghcr.io/zeroasiccorp/sbtest:latest
    steps:
      # fill in your steps here
```

## License

[Apache 2.0](LICENSE)

## Contributing

sbtest is an open-source project and welcomes contributions. To find out how to contribute to the project, see our
[Contributing Guidelines](CONTRIBUTING.md).

## Issues / Bugs

We use [GitHub Issues](https://github.com/zeroasiccorp/sbtest/issues) for tracking requests and bugs.
