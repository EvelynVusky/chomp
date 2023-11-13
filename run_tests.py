import subprocess
import pytest

FILE_NAME = "hello_world"

@pytest.mark.parametrize("dune_command, check", [
    ("dune build", False),
    ("dune exec --no-build toplevel tests/" + FILE_NAME + ".chomp > " + FILE_NAME + ".ll", False),
    ("llc -relocation-model=pic " + FILE_NAME + ".ll", False),
    ("gcc " + FILE_NAME + ".s -o chomp", False),
    ("./chomp > " + FILE_NAME + "_result.out", False),
    ("diff " + FILE_NAME + "_result.out ./tests/" + FILE_NAME + ".out", True),
    ("dune clean; rm " + FILE_NAME + ".ll " + FILE_NAME + ".s " + FILE_NAME + "_result.out chomp chomp.opam", False)
])

def test_dune_commands(dune_command, check):
    # get result from running command with file
    result = subprocess.run(dune_command, shell=True, text=True)
    # check return code is 0, if necessary
    if check:
        assert result.returncode == 0


if __name__ == "__main__":
    pytest.main()