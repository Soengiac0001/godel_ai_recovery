# Spiral Gödel AI Makefile
CC = gcc
CFLAGS = -Wall -g
LISP_DIR = lisp
SRC_DIR = src
BUILD_DIR = build

# Output binary
TARGET = $(BUILD_DIR)/godel_ai

# C source files
C_SOURCES := $(wildcard $(SRC_DIR)/*.c)
OBJECTS := $(patsubst $(SRC_DIR)/%.c,$(BUILD_DIR)/%.o,$(C_SOURCES))

# Default target
all: $(TARGET)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) -o $@ $^

clean:
	rm -rf $(BUILD_DIR)

run: all
	@echo "[🧠] Running Gödel AI Core"
	./$(TARGET)

