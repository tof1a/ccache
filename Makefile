
prefix=/usr/local
exec_prefix=${prefix}
bindir=${exec_prefix}/bin
mandir=${prefix}/man
INSTALLCMD=/usr/bin/install -c

CC=gcc
CFLAGS=-g -O2 -Wall -W

OBJS= ccache.o mdfour.o hash.o execute.o util.o args.o stats.o cleanup.o snprintf.o
HEADERS = ccache.h mdfour.h

all: ccache ccache.1

ccache: $(OBJS) $(HEADERS)
	$(CC) $(CFLAGS) -o $@ $(OBJS)

ccache.1: ccache.yo
	yodl2man -o ccache.1 ccache.yo
	yodl2html -o web/ccache-man.html ccache.yo

install:
	${INSTALLCMD} -m 755 ccache ${bindir}
	${INSTALLCMD} -m 644 ccache.1 ${mandir}

clean:
	/bin/rm -f $(OBJS) *~ ccache
