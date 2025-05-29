# HW#3 - Extended Lexical Analyzer

[![Language](https://img.shields.io/badge/language-C-blue.svg)](https://en.wikipedia.org/wiki/C_(programming_language))
[![Standard](https://img.shields.io/badge/standard-C99-green.svg)](https://en.wikipedia.org/wiki/C99)

Extended lexical analyzer based on Section 4.2 of compiler design textbook.

## Features

- **Section 4.2 Compatibility**: Perfect match with textbook example
- **C-style Comments**: Block (`/* */`) and line (`//`) comment recognition  
- **Floating-point Literals**: Pattern `[+|-]d{d}.d{d}[e|E][+|-]d{d}`
- **Reserved Words**: Recognition of `for`, `if`, `else`, `while`, `do`, `int`, `float`

## Structure

```
├── HW3_Lexical_Analyzer/
│   ├── front_extended.c      # Main implementation
│   ├── front.in             # Section 4.2 test input
│   ├── test_reserved.in     # Reserved words test
│   ├── test_floats.in       # Floating-point literals test
│   └── Makefile             # Build and test automation
└── README.md               # This file
```

## Quick Start

```bash
cd HW3_Lexical_Analyzer
make all
make test-all
```

## Testing

- ✅ Section 4.2 compatibility: PASS
- ✅ Reserved words recognition: PASS  
- ✅ Floating-point literals: PASS
- ✅ Comment handling: PASS

## Usage

```bash
# Build
make all

# Run specific tests
make test-section42    # Section 4.2 compatibility
make test-reserved     # Reserved words
make test-floats       # Floating-point literals
make test-comments     # Comment handling
make test-all          # All tests
``` 