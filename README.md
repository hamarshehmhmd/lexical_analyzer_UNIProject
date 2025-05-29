# HW#4 - Recursive Descent Parser

[![Language](https://img.shields.io/badge/language-C-blue.svg)](https://en.wikipedia.org/wiki/C_(programming_language))
[![Standard](https://img.shields.io/badge/standard-C99-green.svg)](https://en.wikipedia.org/wiki/C99)

Recursive descent parser based on Section 4.4.1, extended with control flow statements.

## Features

- **Section 4.4.1 Compliance**: Exact implementation of textbook parser
- **Expression Parsing**: Arithmetic expressions with precedence
- **Control Flow**: `if-else`, `while`, `for`, `do-while` statements
- **Error Handling**: Comprehensive syntax error detection
- **Integrated Lexer**: Includes extended lexical analyzer from HW#3

## Structure

```
├── HW4_Parser/
│   ├── parser.c             # Complete parser implementation
│   ├── test_correct_1.txt   # Valid syntax test case 1
│   ├── test_correct_2.txt   # Valid syntax test case 2
│   ├── test_incorrect_1.txt # Invalid syntax test case 1
│   ├── test_incorrect_2.txt # Invalid syntax test case 2
│   ├── HW4_PARSER_REPORT.md # Detailed documentation
│   └── Makefile             # Build and test automation
└── README.md               # This file
```

## Quick Start

```bash
cd HW4_Parser
make all
make test-all
```

## Testing Results

- ✅ Correct syntax parsing: PASS (2/2 cases)
- ✅ Error detection: PASS (2/2 cases)
- ✅ Control flow statements: PASS
- ✅ Expression evaluation: PASS

## Grammar Extensions

The parser recognizes:

```
<statement> → <ifStatement> | <whileStatement> | <forStatement> | 
              <doWhileStatement> | <compoundStatement> | <assignment>

<ifStatement> → if ( <expr> ) <statement> [else <statement>]
<whileStatement> → while ( <expr> ) <statement>
<forStatement> → for ( [<init>] ; [<expr>] ; [<increment>] ) <statement>
<doWhileStatement> → do <statement> while ( <expr> ) ;
```

## Usage

```bash
# Build
make all

# Test individual cases
make test-correct-1      # If-else and while statements
make test-correct-2      # For and do-while statements
make test-incorrect-1    # Missing semicolon error
make test-incorrect-2    # Missing parenthesis error
make test-all           # All test cases
``` 