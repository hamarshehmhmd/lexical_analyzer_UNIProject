# Makefile for Extended Lexical Analyzer and Parser
# University Project - Compiler Design

CC = gcc
CFLAGS = -Wall -Wextra -std=c99 -g
TARGET = front_extended
PARSER_TARGET = parser
SOURCE = front_extended.c
PARSER_SOURCE = parser.c
INPUT_FILE = front.in

# Default target
all: $(TARGET) $(PARSER_TARGET)

# Compile the lexical analyzer
$(TARGET): $(SOURCE)
	$(CC) $(CFLAGS) -o $(TARGET) $(SOURCE)

# Compile the parser
$(PARSER_TARGET): $(PARSER_SOURCE)
	$(CC) $(CFLAGS) -o $(PARSER_TARGET) $(PARSER_SOURCE)

# Clean build artifacts
clean:
	rm -f $(TARGET) $(PARSER_TARGET) *.o

# Run the lexical analyzer
run: $(TARGET)
	./$(TARGET)

# Run the parser
run-parser: $(PARSER_TARGET)
	./$(PARSER_TARGET)

# Test parser with correct cases
test-parser-correct: $(PARSER_TARGET)
	@echo "=== Testing Parser - Correct Case 1 ==="
	@cp test_correct_1.txt parser_input.txt
	@./$(PARSER_TARGET)
	@echo ""
	@echo "=== Testing Parser - Correct Case 2 ==="
	@cp test_correct_2.txt parser_input.txt
	@./$(PARSER_TARGET)

# Test parser with incorrect cases  
test-parser-incorrect: $(PARSER_TARGET)
	@echo "=== Testing Parser - Incorrect Case 1 ==="
	@cp test_incorrect_1.txt parser_input.txt
	@-./$(PARSER_TARGET)
	@echo ""
	@echo "=== Testing Parser - Incorrect Case 2 ==="
	@cp test_incorrect_2.txt parser_input.txt
	@-./$(PARSER_TARGET)

# Test all parser cases
test-parser-all: test-parser-correct test-parser-incorrect

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

# Run all lexer tests
test-lexer-all: test-section42 test-reserved test-floats test-comments
	@echo "All lexer tests completed!"

# Run all tests (lexer and parser)
test-all: test-lexer-all test-parser-all
	@echo "All tests completed!"

# Development target with debugging symbols
debug: CFLAGS += -DDEBUG
debug: $(TARGET) $(PARSER_TARGET)

# Install (copy to system directory)
install: $(TARGET) $(PARSER_TARGET)
	cp $(TARGET) /usr/local/bin/
	cp $(PARSER_TARGET) /usr/local/bin/

# Uninstall
uninstall:
	rm -f /usr/local/bin/$(TARGET)
	rm -f /usr/local/bin/$(PARSER_TARGET)

# Check code style (requires astyle)
style:
	@if command -v astyle >/dev/null 2>&1; then \
		astyle --style=kr --indent=spaces=4 $(SOURCE) $(PARSER_SOURCE); \
	else \
		echo "astyle not found. Please install astyle for code formatting."; \
	fi

# Generate documentation (requires doxygen)
docs:
	@if command -v doxygen >/dev/null 2>&1; then \
		doxygen Doxyfile; \
	else \
		echo "doxygen not found. Please install doxygen for documentation generation."; \
	fi

# Memory check (requires valgrind)
memcheck: $(TARGET) $(PARSER_TARGET)
	@if command -v valgrind >/dev/null 2>&1; then \
		echo "Running memory check on lexer..."; \
		valgrind --leak-check=full --show-leak-kinds=all ./$(TARGET); \
		echo "Running memory check on parser..."; \
		valgrind --leak-check=full --show-leak-kinds=all ./$(PARSER_TARGET); \
	else \
		echo "valgrind not found. Please install valgrind for memory checking."; \
	fi

# Help target
help:
	@echo "Available targets:"
	@echo "  all          - Build the lexical analyzer and parser"
	@echo "  clean        - Remove build artifacts"
	@echo "  run          - Run the lexical analyzer"
	@echo "  run-parser   - Run the parser"
	@echo "  test-section42 - Test Section 4.2 compatibility"
	@echo "  test-reserved  - Test reserved words"
	@echo "  test-floats    - Test floating-point literals"
	@echo "  test-comments  - Test comment handling"
	@echo "  test-lexer-all - Run all lexer tests"
	@echo "  test-parser-correct - Test parser with correct cases"
	@echo "  test-parser-incorrect - Test parser with incorrect cases"
	@echo "  test-parser-all - Test all parser cases"
	@echo "  test-all       - Run all tests (lexer and parser)"
	@echo "  debug          - Build with debugging symbols"
	@echo "  install        - Install to system directory"
	@echo "  uninstall      - Remove from system directory"
	@echo "  style          - Format code (requires astyle)"
	@echo "  docs           - Generate documentation (requires doxygen)"
	@echo "  memcheck       - Run memory check (requires valgrind)"
	@echo "  help           - Show this help message"

.PHONY: all clean run run-parser test-section42 test-reserved test-floats test-comments test-lexer-all test-parser-correct test-parser-incorrect test-parser-all test-all debug install uninstall style docs memcheck help 