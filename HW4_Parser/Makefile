# Makefile for HW#4 - Recursive Descent Parser
# Based on Section 4.4.1 with control flow extensions

CC = gcc
CFLAGS = -Wall -Wextra -std=c99 -g
TARGET = parser
SOURCE = parser.c
INPUT_FILE = parser_input.txt

# Default target
all: $(TARGET)

# Compile the parser
$(TARGET): $(SOURCE)
	$(CC) $(CFLAGS) -o $(TARGET) $(SOURCE)

# Clean build artifacts
clean:
	rm -f $(TARGET) *.o $(INPUT_FILE)

# Test correct case 1 (if-else and while statements)
test-correct-1: $(TARGET)
	@echo "Testing correct case 1: if-else and while statements"
	@cp test_correct_1.txt $(INPUT_FILE)
	@./$(TARGET)

# Test correct case 2 (for and do-while statements)
test-correct-2: $(TARGET)
	@echo "Testing correct case 2: for and do-while statements"
	@cp test_correct_2.txt $(INPUT_FILE)
	@./$(TARGET)

# Test incorrect case 1 (missing semicolon)
test-incorrect-1: $(TARGET)
	@echo "Testing incorrect case 1: missing semicolon"
	@cp test_incorrect_1.txt $(INPUT_FILE)
	@./$(TARGET) || echo "Error caught as expected"

# Test incorrect case 2 (missing parenthesis)
test-incorrect-2: $(TARGET)
	@echo "Testing incorrect case 2: missing parenthesis"
	@cp test_incorrect_2.txt $(INPUT_FILE)
	@./$(TARGET) || echo "Error caught as expected"

# Run all tests
test-all: test-correct-1 test-correct-2 test-incorrect-1 test-incorrect-2
	@echo "All parser tests completed!"

# Interactive mode - create empty input file for manual testing
interactive: $(TARGET)
	@echo "Creating empty input file for manual testing..."
	@touch $(INPUT_FILE)
	@echo "Edit $(INPUT_FILE) with your test program, then run './$(TARGET)'"

# Help target
help:
	@echo "Available targets:"
	@echo "  all              - Build the parser"
	@echo "  clean            - Remove build artifacts"
	@echo "  test-correct-1   - Test correct case 1 (if-else, while)"
	@echo "  test-correct-2   - Test correct case 2 (for, do-while)"
	@echo "  test-incorrect-1 - Test incorrect case 1 (missing semicolon)"
	@echo "  test-incorrect-2 - Test incorrect case 2 (missing parenthesis)"
	@echo "  test-all         - Run all tests"
	@echo "  interactive      - Set up for manual testing"
	@echo "  help             - Show this help message"

.PHONY: all clean test-correct-1 test-correct-2 test-incorrect-1 test-incorrect-2 test-all interactive help 