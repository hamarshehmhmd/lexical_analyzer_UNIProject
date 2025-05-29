# Compiler Project - Main Branch
# Switch to homework branches to work on specific assignments

.PHONY: help hw3 hw4 status

# Default target - show help
help:
	@echo "Compiler Project - University Coursework"
	@echo "========================================"
	@echo ""
	@echo "This repository uses branches for homework organization:"
	@echo ""
	@echo "Available branches:"
	@echo "  hw3-lexical-analyzer  - HW#3: Extended Lexical Analyzer" 
	@echo "  hw4-parser           - HW#4: Recursive Descent Parser"
	@echo ""
	@echo "Usage:"
	@echo "  make hw3     - Switch to HW#3 branch"
	@echo "  make hw4     - Switch to HW#4 branch"
	@echo "  make status  - Show current branch and available branches"
	@echo "  make help    - Show this help message"
	@echo ""
	@echo "Each homework branch contains:"
	@echo "  - Complete implementation"
	@echo "  - Test files and cases"
	@echo "  - Detailed README"
	@echo "  - Build automation (Makefile)"

# Switch to HW#3 branch
hw3:
	@echo "Switching to HW#3 - Lexical Analyzer branch..."
	@git checkout hw3-lexical-analyzer

# Switch to HW#4 branch  
hw4:
	@echo "Switching to HW#4 - Parser branch..."
	@git checkout hw4-parser

# Show branch status
status:
	@echo "Current branch: $$(git branch --show-current)"
	@echo ""
	@echo "Available branches:"
	@git branch -l | grep -E "(hw3|hw4|main)" | sed 's/^/  /'
	@echo ""
	@echo "Use 'make hw3' or 'make hw4' to switch branches" 