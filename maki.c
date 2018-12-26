#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Split an include-statement into the base and extension
bool splitinc(char *filename, char base[], char ext[]) {
  char *regex = "#include \"%32[a-z0-9].%32[a-z0-9]\"";
  return sscanf(filename, regex, base, ext) == 2;
}

// Split a file into the base and the extension
bool splitfilename(char *filename, char base[], char ext[]) {
  char *regex = "%32[a-z0-9].%32[a-z0-9]";
  return sscanf(filename, regex, base, ext) == 2;
}

// Return true if the extension is h or hpp
bool isheaderext(char *ext) {
  return strcmp(ext, "h") == 0 || strcmp(ext, "hpp") == 0;
}

// Check if the given file exists
bool exists(char *filename) {
  FILE *fp = fopen(filename, "r");
  bool result = fp != NULL;
  fclose(fp);
  return result;
}

// Given an executable, input filename and a file,
// generate all dependencies of the file.
bool maki(char *exe, char *ifname) {
  char line[256], ibase[32], iext[32];

  FILE *input = fopen(ifname, "r");
  if (!input) {
    return false;
  }

  bool res = splitfilename(ifname, ibase, iext);

  // If this is a c/cpp file
  if (!isheaderext(iext)) {
    // exe: ifname.o
    printf("%s: %s.o\n", exe, ibase);
    if (res) {
      // ifname.o: ifname.c
      printf("%s.o: %s.%s\n", ibase, ibase, iext);
    }
  }

  // Add includes, and recurse
  while (fgets(line, sizeof(line), input)) {

    // The include file
    char base[32], ext[32];

    // Ignore non-includes
    if (!splitinc(line, base, ext)) {
      continue;
    }

    // Visit deps
    char next_name[32] = "";
    strcat(next_name, base);
    strcat(next_name, ".");
    strcat(next_name, ext);

    // Depend on dep
    if (isheaderext(iext)) {
      printf("%s: %s\n", ifname, next_name);
    } else {
      printf("%s.o: %s\n", ibase, next_name);
    }

    // If is impl, don't go to header
    if (!isheaderext(ext) || strcmp(base, ibase) != 0) {
      maki(exe, next_name);
    }

    if (isheaderext(iext)) {
      char cfile[32] = "";
      strcat(cfile, ibase);
      strcat(cfile, ".c");
      maki(exe, cfile);

      char cppfile[32] = "";
      strcat(cppfile, ibase);
      strcat(cppfile, ".cpp");
      maki(exe, cppfile);
    }
  }

  fclose(input);
  return true;
}

int main(int argc, char *argv[]) {

  // Check argument count
  if (argc < 2) {
    printf("Usage: %s <main.(c|cpp)>\n", argv[0]);
    exit(EXIT_FAILURE);
  }

  char *ifname = argv[1];

  char exe[32] = "";
  sscanf(ifname, "%32[a-z0-9].", exe);
  maki(exe, ifname);

  return 0;
}
