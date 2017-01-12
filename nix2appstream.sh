#!/usr/bin/env sh

if [ "$#" -lt 1 ]; then
    cat <<EOF
Usage: $0 pkg
For example:
$ $0 wireshark-gtk
<?xml version="1.0"?>
<components version="0.10">
  <component type="application">
    <id>wireshark.desktop</id>
    <pkgname>wireshark-gtk</pkgname>
...
EOF

    exit 1
fi

expr="with import <nixpkgs> {}; with import ./. {}; nix2appstream [ pkgs.$1 ]"

out=$(nix-store --no-gc-warning -r $(nix-instantiate --no-gc-warning -E "$expr"))

cat $out
