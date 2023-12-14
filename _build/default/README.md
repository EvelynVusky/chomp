## CHOMP ##
# Names: 
    Luella Sugiman
    Evelyn Vu
    Nicole Ogen

# Email Addresses: 
    luella.sugiman@tufts.edu
    evelyn.vu@tufts.edu
    nicole.ogen@tufts.edu

## Integration test descriptions ##
# Positive Tests:
- test-list: tests cons, car, and cdr using ids and printing them
- test-list-literals: tests printing for list literals and cons, car, cdr with list literals 
- test-list-empty: tests printing, cons, car, cdr with the emtpy list
- test-list-scope: prints a list created & modified in a different scope (both
    function scope & for loop scope)
- test-builtins: tests the polymorphic to{Bin type} builtin functions with every 
    possible type of input
- test-builtins-get: tests polymorphic setBit, getBit, and flipBit builtin functions with 
    every possible type of input
- test-print: tests the polymorphic print and println functions for all types

- test-add: prints the addition of 2 integer literals & an integer variable
- test-sub: prints the addition of 2 integer literals & the combination of an integer literal and an integer variable
- test-mult: prints multiplication of 2 integer literals & 2 integer variables
- test-div: prints division of 2 integers car'd from 2 integer lists
- test-bool-ops: prints the and (&&), or (||) & not (!) of a combination of boolean literals & variables
- test-bin-binops: prints the binand (&), binor (|) & binxor (^) of a combination of bin type literals & variables
- test-unops: prints the binnot (~) of all possible bin types, and the neg (-) of an integer
- test-shift: prints the lshift (<<) & rshift (>>) of bin types
- test-comp: prints the greater (>), geq (>=), lesser (<) and leq (<=) of a combination of 2 integer literals & variables
- test-concat: assigns the concatenation (><) of every combination of bin type to its appropriate resulting bin type & prints its value

- test-function-list: tests passing in lists of different types and empty 
                      list into a function and printing it
- test-function-list-ret: tests returning a list from a function and printing it
- test-function-formals: prints all formals passed to a function, tests all types 
- test-function-ret: prints value that function returns

- test-id-scope: give 3 variables that are in different scopes the same name and print their different values

- test-block: creates a block, declares a variable within the block and performs arithmetic operations on the variable in the block and on a variable outside of the block
- test-block-for: creates a for loop within a block and performs arithmetic operations on variables and prints within the for loop
- test-for: performs arithmetic operations on a variable within a for loop
- test-for-for: prints strings using nested for loops
- test-fors: tests multiple configurations of for loops: loops with a variety of header initialization variables, increment/decrement statements, booean conditions, and inner operations
- test-function-for: tests that a function with a for loop correctly updates a list literal passed into it
- test-while: tests a simple while loop that performs arithmetic on a variable
- test-while-big: tests a while loop to find index of first 1 bit in a bin type
- test-while-while: tests a nested while loop
- test-if: tests if and nested if statements in main and in functions
- test-function-while: tests while within a function
- test-return: tests that functions with return types of all data types return correctly

# Semantically Negative Tests: 
- fail-add: fails when calling the add operator on 2 strings
- fail-sub: fails when calling the subtract operator on 2 chars
- fail-mult: fails when calling the subtract operator on 2 integer lists
- fail-div: fails when dividing by 0
- fail-bool-ops: calls boolean operator and (&&) on 2 char literals
- fail-bin-binops: calls a bin type operator on 2 interger literals
- fail-unops: calls a binnot (~) on an integer
- fail-shift: fails when calling a shift (<<) on 2 integers
- fail-concat: assigns the result of the concat (><) of 2 nibbles to a nibble, when it's supposed to return a byte
- fail-main: creates a main function with a "void" return type

- fail-list-list: fails when trying to create a list of lists
- fail-list: fails when trying to give car result a list type
- fail-list-ty: fails when trying to put a bit and nibble in the same list
- fail-list-empty: fails when trying to cons to empty list of wrong type

- fail-function-formal: fails when calling a function with the wrong number of formals
- fail-function-formal-ty: fails when calling a function with a formal of the wrong type
- fail-function-ret: fails when returning the wrong type for a function
- fail-function-no-return: fails when missing a return statment
- fail-function-scope: tries to reference variable that is not in functions scope

- fail-id-dup-glob: fails to give a global variable and function the same name
- fail-id-dup-loc: fails to give local variable and function the same name

- fail-list-scope: fails when trying to reference a variable in a different scope to a list in main   
- fail-block: fails when trying to reference a variable declared in a block 
- fail-for: fails when trying to create a for loop without initializing the counter in the for loop header before the for loop
- fail-for-for: fails when trying to reference a variable declared in an inner for loop in the outer for loop
- fail-while: fails when trying to reference a variable in the conditional that doesn't exist
- fail-if: fails when if statement expression is not type boolean
- fail-return: fails when trying to return before the end of a function block
- fail-return-type: fails when trying to return a different type than the function return type

## How to run the scripts to perform the three commands listed above ##
Compile the compiler into an executable by running: 
    make all

## TODO ##

Run all tests in our testsuite by running:
    make test
Note: this runs 2 pytest files run_tests.py & run_semant_tests.py, and leaves
command intermediary files. This was successful if it says 5 tests were passeed, 
followed by 2 tests were passed. 

Run a single test by running:
    make run FILENAME=<filename>
Note: <filename> must only contain the name of the file without the .chomp extension,
and this command leaves all intermediary files. This is successful if there's no error & the expected output is printed to stdout.