# sbtest

This repo contains a Dockerfile specifying an image with Verilator (v5.012), Icarus Verilog (v11), and RISC-V tools (2023.01.04) preinstalled.

The image can be built and released through GitHub Actions by pushing a tag tag starting with `v`.  For example, if you want to build and release version 0.1.2 of this image:

```shell
> git tag v0.1.2
> git push origin main
> git push origin v0.1.2
```

This will kick off a build on GitHub Actions, which may take some time.  After it completes, the image will be released here: https://github.com/zeroasiccorp/sbtest/pkgs/container/sbtest (only accessible to `zeroasiccorp`).

You can use this Docker image just like images from DockerHub.  For example, if you want to open a shell in a new instance of version 0.0.1 of this image, type:

```shell
> docker run --rm -it ghcr.io/zeroasiccorp/sbtest:0.0.1 /bin/bash
```

You can also run other GitHub Actions within this container by filling in the `container` field for a job description.  For example,

```yaml
jobs:
  sbtest:
    name: Switchboard Test
    runs-on: ubuntu-latest
    container:
      image: ghcr.io/zeroasiccorp/sbtest:0.0.1
      credentials:
      username: ${{ secrets.ZA_ACTOR }}
      password: ${{ secrets.ZA_TOKEN }}
    steps:
      # fill in your steps here
```

The `image` field specifies the exact version of the image that should be used.  `ZA_ACTOR` and `ZA_TOKEN` are organization-wide GitHub Secrets that are preconfigured to provide the correct permissions and are accessible from any repository in the `zeroasiccorp` org.
