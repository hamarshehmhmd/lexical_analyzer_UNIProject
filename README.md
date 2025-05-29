# Extended Lexical Analyzer

A lexical analyzer based on Section 4.2 of the compiler design textbook, extended with additional features.

## Features

- **Section 4.2 Compatibility**: Maintains exact compatibility with the textbook implementation
- **C-Style Comments**: Supports both `/* */` block comments and `//` line comments
- **Floating-Point Literals**: Recognizes floating-point numbers with optional exponents
- **Reserved Words**: Recognizes reserved words (for, if, else, while, do, int, float)

## Build and Run

```bash
# Compile
make

# Run with default input
make run

# Test all features
make test-all
```

## Files

- `front_extended.c` - Main lexical analyzer source code
- `front.in` - Section 4.2 test input: `(sum + 47) / total`
- `test_reserved.in` - Reserved words test
- `test_floats.in` - Floating-point literals test
- `Makefile` - Build system

## Testing

The lexical analyzer has been tested to ensure:
- ✅ Perfect Section 4.2 compatibility
- ✅ Comment recognition and skipping
- ✅ Floating-point literal parsing
- ✅ Reserved word identification

## Output Format

The analyzer outputs tokens in the format:
```
Next token is: [TOKEN_CODE], Next lexeme is [LEXEME]
``` 