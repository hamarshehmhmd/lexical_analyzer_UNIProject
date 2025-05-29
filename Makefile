# Makefile for Extended Lexical Analyzer
# University Project - Compiler Design

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
	@echo "All tests completed!"

# Development target with debugging symbols
debug: CFLAGS += -DDEBUG
debug: $(TARGET)

# Install (copy to system directory)
install: $(TARGET)
	cp $(TARGET) /usr/local/bin/

# Uninstall
uninstall:
	rm -f /usr/local/bin/$(TARGET)

# Check code style (requires astyle)
style:
	@if command -v astyle >/dev/null 2>&1; then \
		astyle --style=kr --indent=spaces=4 $(SOURCE); \
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
memcheck: $(TARGET)
	@if command -v valgrind >/dev/null 2>&1; then \
		echo "Running memory check..."; \
		valgrind --leak-check=full --show-leak-kinds=all ./$(TARGET); \
	else \
		echo "valgrind not found. Please install valgrind for memory checking."; \
	fi

# Help target
help:
	@echo "Available targets:"
	@echo "  all          - Build the lexical analyzer"
	@echo "  clean        - Remove build artifacts"
	@echo "  run          - Run the lexical analyzer"
	@echo "  test-section42 - Test Section 4.2 compatibility"
	@echo "  test-reserved  - Test reserved words"
	@echo "  test-floats    - Test floating-point literals"
	@echo "  test-comments  - Test comment handling"
	@echo "  test-all       - Run all tests"
	@echo "  debug          - Build with debugging symbols"
	@echo "  install        - Install to system directory"
	@echo "  uninstall      - Remove from system directory"
	@echo "  style          - Format code (requires astyle)"
	@echo "  docs           - Generate documentation (requires doxygen)"
	@echo "  memcheck       - Run memory check (requires valgrind)"
	@echo "  help           - Show this help message"

.PHONY: all clean run test-section42 test-reserved test-floats test-comments test-all debug install uninstall style docs memcheck help 