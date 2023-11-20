import subprocess
import pytest

TESTS = ["print", "list", "return", "no-return", "scope", "main", "internal-list"]

@pytest.mark.parametrize("dune_command, succeed", [
    ("dune exec --no-build toplevel ./semant_tests/test-{}.chomp", True),
    ("dune exec --no-build toplevel ./semant_tests/fail-{}.chomp", False),
])

def test_dune_commands(dune_command, succeed):
    for file in TESTS:
        formatted_command = dune_command.format(file)
        # get result from running command with file
        result = subprocess.run(formatted_command, shell=True, text=True)
        # check return code is 0, if necessary
        if succeed:
            print(f"Testing test-{file}...", end="\n")
            assert result.returncode == 0
        else:
            print(f"Testing fail-{file}...", end="\n")
            assert result.returncode != 0


if __name__ == "__main__":
    pytest.main()