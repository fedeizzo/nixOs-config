#!/usr/bin/env bash
SOPS_AGE_KEY_FILE=/var/lib/sops/keys.txt sops secrets.yaml
