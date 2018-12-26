# Maki

This is just a proof of concept, and not intended for serious use.
I was simply wondering why specifying sources other than the program entry point in cmake and make was required.

Like clang or gcc can generate a makefile that specifies header dependencies of each file, this project also does so for *.c and *.cpp files.
The program assumes that if declarations are in foo.h or foo.hpp, then the implementation is in foo.c or foo.cpp if they exist.
