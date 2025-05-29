# Makefile for HW#4 - Recursive Descent Parser
# Delegates to the HW4_Parser folder

.PHONY: all clean test-all help

# Default target - build the parser
all:
	@$(MAKE) -C HW4_Parser all

# Clean build artifacts
clean:
	@$(MAKE) -C HW4_Parser clean

# Test all cases
test-all:
	@$(MAKE) -C HW4_Parser test-all

# Test individual cases
test-correct-1:
	@$(MAKE) -C HW4_Parser test-correct-1

test-correct-2:
	@$(MAKE) -C HW4_Parser test-correct-2

test-incorrect-1:
	@$(MAKE) -C HW4_Parser test-incorrect-1

test-incorrect-2:
	@$(MAKE) -C HW4_Parser test-incorrect-2

# Interactive mode
interactive:
	@$(MAKE) -C HW4_Parser interactive

# Help
help:
	@echo "HW#4 - Recursive Descent Parser"
	@echo "Available targets:"
	@echo "  all              - Build the parser"
	@echo "  clean            - Clean build artifacts"
	@echo "  test-all         - Run all tests"
	@echo "  test-correct-1   - Test correct case 1 (if-else, while)"
	@echo "  test-correct-2   - Test correct case 2 (for, do-while)"
	@echo "  test-incorrect-1 - Test incorrect case 1 (missing semicolon)"
	@echo "  test-incorrect-2 - Test incorrect case 2 (missing parenthesis)"
	@echo "  interactive      - Set up for manual testing"
	@echo "  help             - Show this help message" 