all: pteditor ptedit.o example header tests

header: module/pteditor.c module/pteditor.h ptedit.c ptedit.h
	cat module/pteditor.h ptedit.h ptedit.c | sed 's/#include ".*"//g' > ptedit_header.h

pteditor: module/pteditor.c
	cd module && make

example: example.c header
	gcc -Wall -Wextra example.c -g -o example

demos: header pteditor
	cd demos && make

tests: header pteditor
	cd test && make

deb:
	dpkg-buildpackage

clean:
	cd module && make clean
	cd demos && make clean
	cd test && make clean
	rm -f example *.o
