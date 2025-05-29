# Makefile for HW#3 - Extended Lexical Analyzer
# Delegates to the HW3_Lexical_Analyzer folder

.PHONY: all clean run test-all help

# Default target - build the lexical analyzer
all:
	@$(MAKE) -C HW3_Lexical_Analyzer all

# Clean build artifacts
clean:
	@$(MAKE) -C HW3_Lexical_Analyzer clean

# Run the lexical analyzer
run:
	@$(MAKE) -C HW3_Lexical_Analyzer run

# Test all features
test-all:
	@$(MAKE) -C HW3_Lexical_Analyzer test-all

# Test individual features
test-section42:
	@$(MAKE) -C HW3_Lexical_Analyzer test-section42

test-reserved:
	@$(MAKE) -C HW3_Lexical_Analyzer test-reserved

test-floats:
	@$(MAKE) -C HW3_Lexical_Analyzer test-floats

test-comments:
	@$(MAKE) -C HW3_Lexical_Analyzer test-comments

# Help
help:
	@echo "HW#3 - Extended Lexical Analyzer"
	@echo "Available targets:"
	@echo "  all              - Build the lexical analyzer"
	@echo "  clean            - Clean build artifacts"
	@echo "  run              - Run the lexical analyzer"
	@echo "  test-all         - Run all tests"
	@echo "  test-section42   - Test Section 4.2 compatibility"
	@echo "  test-reserved    - Test reserved words"
	@echo "  test-floats      - Test floating-point literals"
	@echo "  test-comments    - Test comment handling"
	@echo "  help             - Show this help message" 