import subprocess
import pytest

TESTS = ["list", "scope", "bit-length"]

@pytest.mark.parametrize("dune_command, succeed", [
    ("dune exec --no-build toplevel ./semant_fails/fail-{}.chomp &> fail-{}-result.out", False),
    ("diff fail-{}-result.out ./semant_fails/fail-{}.out", True),
])

def test_dune_commands(dune_command, succeed):
    for file in TESTS:
        formatted_command = dune_command.format(file, file)
        # get result from running command with file
        result = subprocess.run(formatted_command, shell=True, text=True)
        # check return code is 0, if necessary
        if succeed:
            assert result.returncode == 0
        else:
            assert result.returncode != 0


if __name__ == "__main__":
    pytest.main()