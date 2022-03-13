variable "BASE_SLUG" {
  default = "sparanoid/umami"
}

variable "BASE_TAG" {
  default = "postgresql-latest"
}

variable "DEFAULT_TAG" {
  default = [
    # Only build :local for postgresql-latest
    equal("postgresql-latest", BASE_TAG) ? "${BASE_SLUG}:local" : "",
    "${BASE_SLUG}:${BASE_TAG}-local"
  ]
}

# Special target: https://github.com/docker/metadata-action#bake-definition
target "docker-metadata-action" {
  tags = "${DEFAULT_TAG}"
  args = {
    BASE_TAG = "${BASE_TAG}"
  }
}

# Default target if none specified
group "default" {
  targets = ["build-local"]
}

target "build" {
  inherits = ["docker-metadata-action"]
}

target "build-local" {
  inherits = ["build"]
  output = ["type=docker"]
}

target "build-all" {
  inherits = ["build"]
  platforms = [
    "linux/amd64",
  ]
}
