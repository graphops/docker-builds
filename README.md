# docker-builds

This repository contains a collection of Dockerfiles, with an automated build and publishing pipeline.

## Repository Structure

The repository is organized as follows:

- `/.github/workflows/` - Contains CI/CD workflows
- `/scripts/` - Contains build utility scripts
- `/dockerfiles/` - Contains individual directories for each Docker image:
  - `init-toolbox`
  - `graph-toolbox`
  - `init-stream-download`
  - ...

## Build Process

### Build Triggers

Builds are automatically triggered on:
- Pushes to `main` branch
- Pull requests to `main` (that modify the build workflow)
- Manual triggers via workflow_dispatch

### Version Management

- Versions are automatically extracted from `ARG *_VERSION=` declarations in each Dockerfile
- The `extract-versions.sh` script processes these into a JSON format
- Version strings are concatenated with hyphens to create unique image tags (e.g. `1.2.3-7.8.9-2.1.0`), with versions appearing in the order they are declared in the Dockerfile

### Image Building and Tagging

Images are:
- Built using Docker Buildx for linux/amd64 platform
- Pushed to GitHub Container Registry (ghcr.io)
- Tagged with:
  - Version-based tags combining all component versions (e.g. `1.2.3-1.0.0`), in the order they appear in the Dockerfile
  - SHA-based tags for pull requests
  - `latest` tag when merged to main
  - Branch-based tags
- Labeled with standardized OCI metadata

### Security Features

- GitHub's built-in authentication for package registry
- Images are only pushed on non-PR events
- SHA-pinned base images for reproducibility

## Usage

To pull an image from the GitHub Container Registry:

```bash
docker pull ghcr.io/graphops/docker-builds/<image-name>:<tag>
```

Replace `<image-name>` with one of the available images and `<tag>` with either a specific version or `latest`.