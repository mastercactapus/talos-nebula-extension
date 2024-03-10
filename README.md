# Nebula Extension

## Installation

To install a system extension in Talos (as of 1.6.x) you need to build a custom Talos image with the extension included.

### Building an installer image to upgrade an existing cluster

The easist way is to use the imager container, this example will build an image for Talos `v1.6.6` with th Nebula extension version `v1.8.2`.

```bash
# Build the installer image into the local "out/" directory
mkdir -p out
docker run --rm -v $(pwd)/out:/out -v /dev:/dev --privileged "ghcr.io/siderolabs/imager:v1.6.6" --arch amd64 --base-installer-image ghcr.io/siderolabs/installer:v1.6.6 --system-extension-image quay.io/mastercactapus/talos-nebula-extension:v1.8.2 installer

# Load the image into the local Docker daemon
docker load -i out/installer-amd64.tar

# You will see the embedded tag in the output, e.g.: Loaded image(s): ghcr.io/siderolabs/installer:v1.6.6

# Re-tag the image for your registry
docker tag ghcr.io/siderolabs/installer:v1.6.6 quay.io/mastercactapus/talos-installer:v1.6.6

# Push the image to your registry
docker push quay.io/mastercactapus/talos-installer:v1.6.6

# Upgrade your cluster
talosctl upgrade -n 192.168.1.100 -i quay.io/mastercactapus/talos-installer:v1.6.6

```

Note: You can simplify the `load`, `tag`, and `push` steps by using the [crane](https://github.com/google/go-containerregistry/blob/main/cmd/crane/README.md) tool to push directly to your registry.

```bash
crane push ./out/installer-amd64.tar quay.io/mastercactapus/talos-installer:v1.6.6
```



## Usage

Configure the extension via `.machine.files`. All files must be placed in `/var/etc/nebula`.

```yaml
machine:
  files:
    - path: /var/etc/nebula/config.yml
      permissions: 0o600
      op: create
      content: |
        pki:
          ca: ca.crt
          cert: host.crt
          key: host.key
        static_host_map:
          ...
    - path: /var/etc/nebula/ca.crt
      permissions: 0o600
      op: create
      content: |
          -----BEGIN NEBULA CERTIFICATE-----
          ...
          -----END NEBULA CERTIFICATE-----
    - path: /var/etc/nebula/host.crt
      permissions: 0o600
      op: create
      content: |
          -----BEGIN NEBULA CERTIFICATE-----
          ...
          -----END NEBULA CERTIFICATE-----
    - path: /var/etc/nebula/host.key
      permissions: 0o600
      op: create
      content: |
          -----BEGIN NEBULA X25519 PRIVATE KEY-----
          ...
          -----END NEBULA X25519 PRIVATE KEY-----

## Building
