NEBULA_VERSION := "v1.8.2"
MANIFEST_NAME := "talos-nebula-extension"

# List all available targets
default:
    just --list

# Build all platform images
build-all: 
    podman manifest rm {{MANIFEST_NAME}} || true
    podman manifest create {{MANIFEST_NAME}}
    podman build --platform linux/amd64,linux/arm64,linux/arm --no-cache --build-arg=VERSION={{NEBULA_VERSION}} --manifest {{MANIFEST_NAME}} .

# Push all platform images
push-all: build-all
    podman manifest push {{MANIFEST_NAME}} quay.io/mastercactapus/talos-nebula-extension:{{NEBULA_VERSION}}
