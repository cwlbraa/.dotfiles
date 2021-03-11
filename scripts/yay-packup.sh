#!/usr/bin/env bash
set -euo pipefail

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

pkglist="$dir/../pkglist.txt"
yay -Qeq > ${pkglist}

git add -p ${pkglist}
