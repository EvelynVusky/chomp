## CHOMP ##
# Names: 
    Luella Sugiman
    Evelyn Vu
    Nicole Ogen

# Email Addresses: 
    luella.sugiman@tufts.edu
    evelyn.vu@tufts.edu
    nicole.ogen@tufts.edu

# Integration test descriptions
# Semantically Negative Tests (3): 
"fail-list.chomp": Incorrectly declares an integer list without the necessary bracket syntax, "[" and "]". Detects mismatched types between id and value.

"fail-scope.chomp": Incorrectly calls a function that is declared after the scope that it is called in. Detects unidentified function name.

"bit-length.chomp": Incorrectly assigns a nibble datatype with five bits rather than four. Detects incorrect size of bits assigned to nibble type.

# Positive Tests (7):
"test-print.chomp": Calls our polymporhic built-in print function on nibble, byte, integer, and string literals.

"test-hello-world.chomp": Prints the string "hello world".

"test-scope.chomp": Accesses & modifies a global variable inside a child scope, and ensures its value is retained outside of the scope.

"test-if.chomp": Prints different strings based on conditions in nested if statements.

"test-formals.chomp": Defines a function that takes 2 integer parameters, and calls said function using arguments.

"test-globals.chomp": Prints globally-defined strings inside a function.

"test-fib.chomp": Calculates Fibonacci(10) using a bottom-up algorithm.

  
# How to run the scripts to perform the three commands listed above
Dependendencies:
    pytest (install using: pip install pytest)

Compile the compiler into an executable by running: 
    make all

Run all tests in our testsuite by running:
    make test
Note: this runs 2 pytest files run_tests.py & run_semant_tests.py, and leaves
command intermediary files. This was successful if it says 5 tests were passeed, 
followed by 2 tests were passed. 

Run a single test by running:
    make run FILENAME=<filename>
Note: <filename> must only contain the name of the file without the .chomp extension,
and this command leaves all intermediary files. This is successful if there's no error & the expected output is printed to stdout.


# How your test script validates that a compiled program is correct or that an 
# invalid program couldn’t be compiled
    make test runs all of the tests in the test suite. It does this by running
    2 pytest files, run_semant_tests.py and run_tests.py. 

    The run_semant_tests file does the following on all 3 semant tests: 
    it calls dune exec and compares the output with the gold standard error 
    output using diff. 

    The run_tests.py file does the folling on all 7 tests: 
    It comiles the .chomp file into llvm using llc. Then it generates assembly 
    from this llvm code using gcc. Then it runs this assembly using and pipes 
    the output into a file. Then this script runs diff with the output file
    and the expected gold standard output. If the compiled program did not 
    compile correctly or print the correct output, then the diff would fail and 
    the script would fail. It does this by asserting that the diff command has 
    a 0 return code. If the output file piped from running the chomp executable 
    doesn't exist, one the previous commands didn't run correctly, meaning that 
    it would be an invalid program.