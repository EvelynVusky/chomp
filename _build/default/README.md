## CHOMP ##
# Names: 
    Luella Sugiman
    Evelyn Vu
    Nicole Ogen
# Email Addresses: 
    luella.sugiman@tufts.edu
    evelyn.vu@tufts.edu
    nicole.ogen@tufts.edu

# How to compile CHOMP (this is done already in the test script)
- Navigate to chomp directory
- Run the following commands:
    dune build
    dune dune exec --no-build toplevel tests/{standard file test name}.chomp

# Any syntax that you still need to add to your compiler:
- None

# How to run tests in test suite
- Packages to install & how to install them:
    pytest: pip install pytest
- Navigate to chomp directory
- Run the command:
    pytest run_tests.py