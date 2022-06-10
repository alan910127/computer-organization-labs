CC = g++
CFLAGS = -I./include -std=c++17 

TARGET = main.o
SOURCES = $(wildcard *.cpp)
OBJECTS = $(SOURCES:.cpp=.obj)

.PHONY: all clean

all: ${TARGET}

${TARGET}: ${OBJECTS}
	$(CC) $(CFLAGS) $^ -o ${TARGET}

%.obj: %.cpp
	$(CC) $(CFLAGS) $< -c -o $@

clean:
	-rm -f ${TARGET} ${OBJECTS}
