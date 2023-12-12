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
- test-add: prints the addition of 2 integer literals & the combination of an 
    integer literal and integer variable
- test-list-scope: prints a list created & modified in a different scope (both
    function scope & for loop scope)
- test-builtins: tests the polymorphin to{Bin type} builtin functions with every 
    possible type of input

# Semantically Negative Tests: 
- fail-add: fails when calling the add operator on 2 strings
- 
- 
  
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