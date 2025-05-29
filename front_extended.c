/* front_extended.c - Extended version of the Section 4.2 lexical analyzer
   Original from textbook Section 4.2, extended with:
   1. C-style comments (block and line comments)
   2. Floating-point literals with pattern [+|-] d{d}.d{d} [e|E] [+|-] d{d}
   3. Reserved words: for(30), if(31), else(32), while(33), do(34), int(35), float(36)
*/
#include <stdio.h>
#include <ctype.h>
#include <string.h>

/* Global declarations */
/* Variables */
int charClass;
char lexeme[100];
char nextChar;
int lexLen;
int token;
int nextToken;
FILE *in_fp;

/* Function declarations */
void addChar();
void getChar();
void getNonBlank();
int lex();
int lookup(char ch);
int lookupReservedWord();
void skipBlockComment();
void skipLineComment();

/* Character classes */
#define LETTER 0
#define DIGIT 1
#define UNKNOWN 99

/* Token codes - original from Section 4.2 */
#define INT_LIT 10
#define IDENT 11
#define ASSIGN_OP 20
#define ADD_OP 21
#define SUB_OP 22
#define MULT_OP 23
#define DIV_OP 24
#define LEFT_PAREN 25
#define RIGHT_PAREN 26

/* Extended token codes */
#define FLOAT_LIT 12

/* Reserved word codes as specified in homework */
#define FOR_CODE 30
#define IF_CODE 31
#define ELSE_CODE 32
#define WHILE_CODE 33
#define DO_CODE 34
#define INT_CODE 35
#define FLOAT_CODE 36

/* Reserved words table */
struct {
    char *word;
    int code;
} reservedWords[] = {
    {"for", FOR_CODE},
    {"if", IF_CODE},
    {"else", ELSE_CODE},
    {"while", WHILE_CODE},
    {"do", DO_CODE},
    {"int", INT_CODE},
    {"float", FLOAT_CODE},
    {NULL, 0}
};

/******************************************************/
/* main driver - same as Section 4.2 */
int main() {
    /* Open the input data file and process its contents */
    if ((in_fp = fopen("front.in", "r")) == NULL)
        printf("ERROR - cannot open front.in \n");
    else {
        getChar();
        do {
            lex();
        } while (nextToken != EOF);
    }
    return 0;
}

/*****************************************************/
/* lookup - extended from Section 4.2 to handle comments */
int lookup(char ch) {
    switch (ch) {
        case '(':
            addChar();
            nextToken = LEFT_PAREN;
            break;
        case ')':
            addChar();
            nextToken = RIGHT_PAREN;
            break;
        case '+':
            addChar();
            nextToken = ADD_OP;
            break;
        case '-':
            addChar();
            nextToken = SUB_OP;
            break;
        case '*':
            addChar();
            nextToken = MULT_OP;
            break;
        case '/':
            /* Extended: Check for comments */
            {
                char next = getc(in_fp);
                if (next == '*') {
                    /* Block comment - skip it */
                    skipBlockComment();
                    return lex(); /* Continue lexical analysis */
                } else if (next == '/') {
                    /* Line comment - skip it */
                    skipLineComment();
                    return lex(); /* Continue lexical analysis */
                } else {
                    /* Not a comment, put back character and treat as division */
                    ungetc(next, in_fp);
                    addChar();
                    nextToken = DIV_OP;
                }
            }
            break;
        default:
            addChar();
            nextToken = EOF;
            break;
    }
    return nextToken;
}

/*****************************************************/
/* lookupReservedWord - check if identifier is reserved word */
int lookupReservedWord() {
    int i = 0;
    while (reservedWords[i].word != NULL) {
        if (strcmp(lexeme, reservedWords[i].word) == 0) {
            return reservedWords[i].code;
        }
        i++;
    }
    return IDENT;
}

/*****************************************************/
/* skipBlockComment - skip block comments */
void skipBlockComment() {
    /* We've already read '/' and '*' */
    while (nextChar != EOF) {
        getChar();
        if (nextChar == '*') {
            getChar();
            if (nextChar == '/') {
                getChar(); /* Skip the closing '/' */
                return;
            }
        }
    }
    printf("ERROR - Unterminated block comment\n");
}

/*****************************************************/
/* skipLineComment - skip line comments */
void skipLineComment() {
    /* We've already read '//' */
    while (nextChar != '\n' && nextChar != EOF) {
        getChar();
    }
    if (nextChar == '\n') {
        getChar();
    }
}

/*****************************************************/
/* addChar - same as Section 4.2 */
void addChar() {
    if (lexLen <= 98) {
        lexeme[lexLen++] = nextChar;
        lexeme[lexLen] = 0;
    }
    else
        printf("Error - lexeme is too long \n");
}

/*****************************************************/
/* getChar - same as Section 4.2 */
void getChar() {
    if ((nextChar = getc(in_fp)) != EOF) {
        if (isalpha(nextChar))
            charClass = LETTER;
        else if (isdigit(nextChar))
            charClass = DIGIT;
        else charClass = UNKNOWN;
    }
    else
        charClass = EOF;
}

/*****************************************************/
/* getNonBlank - same as Section 4.2 */
void getNonBlank() {
    while (isspace(nextChar))
        getChar();
}

/*****************************************************/
/* lex - extended from Section 4.2 */
int lex() {
    lexLen = 0;
    getNonBlank();
    switch (charClass) {
        /* Parse identifiers - extended to check reserved words */
        case LETTER:
            addChar();
            getChar();
            while (charClass == LETTER || charClass == DIGIT) {
                addChar();
                getChar();
            }
            nextToken = lookupReservedWord(); /* Extended: check reserved words */
            break;

        /* Parse integer literals - extended for floating-point */
        case DIGIT:
            addChar();
            getChar();
            while (charClass == DIGIT) {
                addChar();
                getChar();
            }
            
            /* Extended: Check for floating-point pattern */
            if (nextChar == '.') {
                addChar(); /* Add the '.' */
                getChar();
                
                /* Must have digits after decimal point */
                if (charClass == DIGIT) {
                    while (charClass == DIGIT) {
                        addChar();
                        getChar();
                    }
                    
                    /* Optional exponent */
                    if (nextChar == 'e' || nextChar == 'E') {
                        addChar();
                        getChar();
                        
                        /* Optional sign */
                        if (nextChar == '+' || nextChar == '-') {
                            addChar();
                            getChar();
                        }
                        
                        /* Must have digits in exponent */
                        if (charClass == DIGIT) {
                            while (charClass == DIGIT) {
                                addChar();
                                getChar();
                            }
                        }
                    }
                    nextToken = FLOAT_LIT;
                } else {
                    nextToken = FLOAT_LIT; /* Still treat as float */
                }
            } else {
                nextToken = INT_LIT;
            }
            break;

        /* Extended: Handle signed floating-point literals */
        case UNKNOWN:
            if ((nextChar == '+' || nextChar == '-')) {
                /* Look ahead to see if this is a signed number */
                char next1 = getc(in_fp);
                if (isdigit(next1)) {
                    /* Look further to see if it's a float */
                    char next2 = getc(in_fp);
                    ungetc(next2, in_fp);
                    ungetc(next1, in_fp);
                    
                    if (next2 == '.' || isdigit(next2)) {
                        /* Parse as signed number */
                        addChar();
                        getChar();
                        
                        /* Parse digits */
                        while (charClass == DIGIT) {
                            addChar();
                            getChar();
                        }
                        
                        /* Check for floating-point */
                        if (nextChar == '.') {
                            addChar();
                            getChar();
                            
                            if (charClass == DIGIT) {
                                while (charClass == DIGIT) {
                                    addChar();
                                    getChar();
                                }
                                
                                /* Optional exponent */
                                if (nextChar == 'e' || nextChar == 'E') {
                                    addChar();
                                    getChar();
                                    
                                    if (nextChar == '+' || nextChar == '-') {
                                        addChar();
                                        getChar();
                                    }
                                    
                                    if (charClass == DIGIT) {
                                        while (charClass == DIGIT) {
                                            addChar();
                                            getChar();
                                        }
                                    }
                                }
                                nextToken = FLOAT_LIT;
                            } else {
                                nextToken = FLOAT_LIT;
                            }
                        } else {
                            nextToken = INT_LIT;
                        }
                        break;
                    }
                } else {
                    ungetc(next1, in_fp);
                }
            }
            
            /* Original Section 4.2 handling */
            lookup(nextChar);
            getChar();
            break;

        /* EOF - same as Section 4.2 */
        case EOF:
            nextToken = EOF;
            lexeme[0] = 'E';
            lexeme[1] = 'O';
            lexeme[2] = 'F';
            lexeme[3] = 0;
            break;
    } /* End of switch */

    printf("Next token is: %d, Next lexeme is %s\n",
           nextToken, lexeme);
    return nextToken;
} /* End of function lex */ 