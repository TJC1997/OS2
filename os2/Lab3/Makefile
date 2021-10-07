#
# R Jesse Chaney
# 

CC = gcc
DEBUG = -g
DEFINES =
DEFINES += -DCHECK

CFLAGS = $(DEBUG) -Wall -Wshadow -Wunreachable-code -Wredundant-decls \
        -Wmissing-declarations -Wold-style-definition -Wmissing-prototypes \
        -Wdeclaration-after-statement $(DEFINES)
PROG = goal


all: $(PROG)


goal: mystat.c
	$(CC) $(CFLAGS) mystat.c -o mystat
	chmod a+rx,g-w mystat

clean:
	rm -rf a.out mystat





