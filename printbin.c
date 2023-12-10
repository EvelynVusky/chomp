#include <stdio.h>
#include <stdlib.h>

void print_bit(int n) {
    // Assuming 1-bit binary representation
    for (int i = 0; i >= 0; i--) {
        printf("%d", (n & (1 << i)) ? 1 : 0);
    }
}

void print_nibble(int n) {
    // Assuming 4-bit binary representation
    for (int i = 3; i >= 0; i--) {
        printf("%d", (n & (1 << i)) ? 1 : 0);
    }
}

void print_byte(int n) {
    // Assuming 8-bit binary representation
    for (int i = 7; i >= 0; i--) {
        printf("%d", (n & (1 << i)) ? 1 : 0);
    }
}

void print_word(int n) {
    // Assuming 16-bit binary representation
    for (int i = 15; i >= 0; i--) {
        printf("%d", (n & (1 << i)) ? 1 : 0);
    }
}