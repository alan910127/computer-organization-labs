CC = g++
CFLAGS = -I./include

TARGET = main
OBJECTS = main.o direct_mapped_cache.o set_associative_cache.o

.PHONY: all clean

all: ${TARGET}

${TARGET}: ${OBJECTS}
	$(CC) $(CFLAGS) $^ -o ${TARGET}

%.o: %.cpp
	$(CC) $(CFLAGS) $< -c -o $@

clean:
	-rm -f *.o
	-rm -f ${TARGET}
