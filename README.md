# Maki

This is just a proof of concept, and not intended for serious use.

## Why?
I was simply wondering why specifying sources other than the program entry point in cmake and make was required.

## What does it do?
Like clang or gcc can generate a makefile that specifies header dependencies of each file, this project also does so for *.c and *.cpp files.
The program assumes that if declarations are in foo.h or foo.hpp, then the implementation is in foo.c or foo.cpp if they exist.

## Installation with Nix
To install it into your environment

```bash
nix-env -f "https://github.com/rudsvar/maki/archive/master.tar.gz" -i maki
```

You can also try it in `nix-shell` by entering the cloned repository and typing `nix-shell`.

## Uninstalling
```bash
nix-env -e maki
```

## Example
Given the files

main.c
```c
#include "foo.h"

int main(void) {
  foo();
  return 0;
}
...
```

foo.h
```c
#pragma once

void foo();
```

foo.c
```c
#include "foo.h"
#include <stdio.h>

void foo() {
  puts("foo() was called");
}
```

Running `maki main.c` will yield the following result.

```
main: main.o
main.o: main.c
main.o: foo.h
main: foo.o
foo.o: foo.c
foo.o: foo.h
```

You can then use it to compile the project with the following command.

```make
maki main.c > maki.out && make -f maki.out
```
