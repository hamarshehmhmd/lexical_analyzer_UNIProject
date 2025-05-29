# Makefile for HW#3 - Extended Lexical Analyzer
# Based on Section 4.2 with extensions

CC = gcc
CFLAGS = -Wall -Wextra -std=c99 -g
TARGET = front_extended
SOURCE = front_extended.c
INPUT_FILE = front.in

# Default target
all: $(TARGET)

# Compile the lexical analyzer
$(TARGET): $(SOURCE)
	$(CC) $(CFLAGS) -o $(TARGET) $(SOURCE)

# Clean build artifacts
clean:
	rm -f $(TARGET) *.o

# Run the lexical analyzer
run: $(TARGET)
	./$(TARGET)

# Test with Section 4.2 example
test-section42: $(TARGET)
	@echo "Testing Section 4.2 compatibility..."
	@echo "(sum + 47) / total" > $(INPUT_FILE)
	@./$(TARGET)

# Test reserved words
test-reserved: $(TARGET)
	@echo "Testing reserved words..."
	@cp test_reserved.in $(INPUT_FILE)
	@./$(TARGET)

# Test floating-point literals
test-floats: $(TARGET)
	@echo "Testing floating-point literals..."
	@cp test_floats.in $(INPUT_FILE)
	@./$(TARGET)

# Test comments
test-comments: $(TARGET)
	@echo "Testing comment handling..."
	@echo "/* block comment */ x + y // line comment" > $(INPUT_FILE)
	@echo "z - 5" >> $(INPUT_FILE)
	@./$(TARGET)

# Run all tests
test-all: test-section42 test-reserved test-floats test-comments
	@echo "All lexical analyzer tests completed!"

# Help target
help:
	@echo "Available targets:"
	@echo "  all            - Build the lexical analyzer"
	@echo "  clean          - Remove build artifacts"
	@echo "  run            - Run the lexical analyzer"
	@echo "  test-section42 - Test Section 4.2 compatibility"
	@echo "  test-reserved  - Test reserved words"
	@echo "  test-floats    - Test floating-point literals"
	@echo "  test-comments  - Test comment handling"
	@echo "  test-all       - Run all tests"
	@echo "  help           - Show this help message"

.PHONY: all clean run test-section42 test-reserved test-floats test-comments test-all help 