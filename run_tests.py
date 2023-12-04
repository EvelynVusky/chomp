import subprocess
import pytest

FILES = ["test-print", "test-hello-world", "test-scope", "test-if", \
         "test-formals", "test-globals", "test-fib"]

@pytest.mark.parametrize("dune_command, one, check", [
    ("dune exec --no-build toplevel ./tests/{}.chomp > {}.ll", False, True),
    ("llc -relocation-model=pic {}.ll", True, True),
    ("gcc {}.s -o {}.exe printbin.o", False, True),
    ("./{}.exe > {}-result.out", False, False),
    ("diff {}-result.out ./tests/{}.out", False, True),
])

def test_dune_commands(dune_command, one, check):
    for file in FILES:
        # Format the dune_command with the current FILE_NAME
        if one:
            formatted_command = dune_command.format(file)
        else:
            formatted_command = dune_command.format(file, file)
        # get result from running command with file
        result = subprocess.run(formatted_command, shell=True, text=True)
        
        # check return code is 0, if necessary
        if check:
            assert result.returncode == 0


if __name__ == "__main__":
    pytest.main()