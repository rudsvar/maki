# Maki

This is just a proof of concept, and not intended for serious use.

## Why?
I was simply wondering why specifying sources other than the program entry point in cmake and make was required.

## What does it do?
Like clang or gcc can generate a makefile that specifies header dependencies of each file, this project also does so for *.c and *.cpp files.
The program assumes that if declarations are in foo.h or foo.hpp, then the implementation is in foo.c or foo.cpp if they exist.

## Installation with Nix
To install it into your environment

```nix
nix-env -f "https://github.com/rudsvar/maki/archive/v0.1.tar.gz" -i maki
```

To test it in a `nix-shell`, clone the repository, enter it, and run `nix-shell shell.nix`.

## Uninstalling
```nix
nix-env -e maki
```
