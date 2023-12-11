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

void raiseError() {
    printf("%s\n", "Error: invalid index");
    exit(1);
}

void validate_idx(int size, int idx) {
    if (idx < 0) return raiseError();
    if (size == 1) {
        if (idx != 0) return raiseError();
    } else if (size == 4) {
        if (idx >= 4) return raiseError();
    } else if (size == 8) {
        if (idx >= 8) return raiseError();
    } else {
        if (idx >= 16) return raiseError();
    }
}

int get_bit(int b, int size, int idx) {
    // validate size of input
    validate_idx(size, idx);
    int shiftedBit = (b >> idx) & 1;
    return shiftedBit;
}

int set_bit(int b, int size, int idx, int replacement) {
    // validate size of input
    validate_idx(size, idx);
    int mask = 1 << idx;
    b &= ~mask;
    b |= (replacement << idx);
    return b;
}

int flip_bit(int b, int size, int idx) {
    // validate size of input
    validate_idx(size, idx);
    int flipped_val = b ^ (1 << idx);
    return flipped_val;
}
