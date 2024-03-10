# Nebula Extension

## Installation

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
