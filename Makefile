X11INC = /usr/X11R6/include
X11LIB = /usr/X11R6/lib

XINERAMALIBS  = -lXinerama
XINERAMAFLAGS = -DXINERAMA

FREETYPELIBS = -lfontconfig -lXft
FREETYPEINC = /usr/include/freetype2

INCS = -I${X11INC} -I${FREETYPEINC}
LIBS = -L${X11LIB} -lX11 ${XINERAMALIBS} ${FREETYPELIBS}

CPPFLAGS = -D_DEFAULT_SOURCE -D_BSD_SOURCE -D_XOPEN_SOURCE=700 -D_POSIX_C_SOURCE=200809L -DVERSION=\"0.0\" ${XINERAMAFLAGS}
CFLAGS   = -std=c99 -pedantic -Wall -Os ${INCS} ${CPPFLAGS}
LDFLAGS  = -s ${LIBS}

CC = cc

SRC = drw.c dmenu.c stest.c util.c
OBJ = ${SRC:.c=.o}

all: dmenu

.c.o:
	@echo CC $<
	@${CC} -c ${CFLAGS} $<

${OBJ}: arg.h config.h drw.h

dmenu: dmenu.o drw.o util.o
	@echo CC -o $@
	@${CC} -o $@ dmenu.o drw.o util.o ${LDFLAGS}

install:
	mkdir -p $(DESTDIR)$(PREFIX)/bin/
	cp -f dmenu $(DESTDIR)$(PREFIX)/bin/
	cp -f script/dmenu_path $(DESTDIR)$(PREFIX)/bin/
	cp -f script/dmenu_run $(DESTDIR)$(PREFIX)/bin/

