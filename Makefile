CC = gcc
CFLAG = -std=c11 -O2 -Wall

TARGET = main
SRCS = main.c
OBJS = main.o

INPUT_DIR = testcase/
INPUTS = $(wildcard $(INPUT_DIR)*.in)
OUTPUT_DIR = output/
OUTPUTS = $(patsubst $(INPUT_DIR)%.in,$(OUTPUT_DIR)%.out,$(INPUTS))
.PHONY: all, test, mk_parent_dir

all: $(TARGET)

mk_parent_dir:
	@mkdir -p $(OUTPUT_DIR)

$(TARGET): $(OBJS)
	$(CC) $(CFLAG) -o $(TARGET) $(OBJS)

%.o: %.c
	$(CC) $(CFLAG) -c $(SRCS) -o $(OBJS)

test: mk_parent_dir $(OUTPUTS)

$(OUTPUT_DIR)%.out: $(INPUT_DIR)%.in $(TARGET)
	./$(TARGET) < $< > $@
	@cat $< $@

clean:
	rm -rf $(OBJS) $(TARGET) $(OUTPUT_DIR)
