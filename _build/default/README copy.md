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
- test-builtins: tests the polymorphin to{Bin type} builtin functions with every 
    possible type of input
- test-for:

- test-add: prints the addition of 2 integer literals & an integer variable
- test-sub: prints the addition of 2 integer literals & the combination of an integer literal and an integer variable
- test-mult: prints multiplication of 2 integer literals & 2 integer variables
- test-div: prints division of 2 integers "car"d from 2 integer lists

- EVELYN TESTS BELOW (will delete this later)
- TODO test-block: 

# Semantically Negative Tests: 
- fail-add: fails when calling the add operator on 2 strings
- fail-sub: fails when calling the subtract operator on 2 chars
- fail-mult: fails when calling the subtract operator on 2 integer lists
- fail-div: fails when dividing by 0


- fail-list-list: fails when trying to create a list of lists
-TODO fail-list: fails when trying to give a list literal the wrong type
-TODO fail-list-ty: fails when trying to put a bit and nibble in the same list
-TODO fail-empty: fails when trying to cons to empty list of wrong type

- EVELYN TESTS BELOW (will delete this later)
- fail-list-scope: fails when trying to reference a variable in a different scope to a list in main   
- fail-block: fails when trying to reference a variable declared in a block 

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