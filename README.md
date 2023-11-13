## CHOMP ##
# Names: 
    Luella Sugiman
    Evelyn Vu
    Nicole Ogen

# Email Addresses: 
    luella.sugiman@tufts.edu
    evelyn.vu@tufts.edu
    nicole.ogen@tufts.edu

# Program that we are testing
    hello_world.chomp is being tested. This file contains a main function 
    with a call to our built in print function. The argument being passed
    to this print function is the string literal "Hello, World!". When
    compiled and run, this program prints "Hello, World!"

    
# How to run the scripts to perform the three commands
    - Packages to install & how to install them:
        pytest: pip install pytest
    - Navigate to the chomp directory
    - Run the following command: 
        pytest run_tests.py
  
# How your test script validates that a compiled program is correct or 
# that an invalid program couldn’t be compiled
    This test script compiles the hello_world.chomp into llvm using lcc. Then it generates assembly from this llvm code using gcc. Then it runs this assembly using ./chomp and pipes the output into a file. 
    Then this script runs diff with the output of ./chomp and the expected output from compiling and running hello_world.chomp. If the compiled program did not compile correctly or print the correct output, then the diff would fail and the script would fail. It does this by asserting that the diff command has a 0 return code.
    If the output file piped from running the chomp executable doesn't exist, one the previous commands didn't run correctly, meaning that it would be an invalid program.


