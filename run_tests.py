import subprocess
import pytest

COMMAND = "dune exec --no-build toplevel tests/"
RES_DIR = "./tests/results/"

@pytest.mark.parametrize("dune_command, succeed, expected_result", [
    ("dune build", True, RES_DIR + "empty.txt"),
    (COMMAND + "test1_pos.chomp", True, RES_DIR + "test1_pos.out"),
    (COMMAND + "test2_pos.chomp", True, RES_DIR + "test2_pos.out"),
    (COMMAND + "test3_pos.chomp", True, RES_DIR + "test3_pos.out"),
    (COMMAND + "test4_pos.chomp", True, RES_DIR + "test4_pos.out"),
    (COMMAND + "test5_pos.chomp", True, RES_DIR + "test5_pos.out"),
    (COMMAND + "test1_neg.chomp", False, ""),
    (COMMAND + "test2_neg.chomp", False, ""),
    (COMMAND + "test3_neg.chomp", False, ""),
    (COMMAND + "test4_neg.chomp", False, ""),
    (COMMAND + "test5_neg.chomp", False, ""),
])

def test_dune_commands(dune_command, succeed, expected_result):
    if succeed:
        # get output from running command with file
        output = subprocess.check_output(dune_command, shell=True, text=True)

        # get expected output from file
        with open(expected_result, 'r') as expected_result:
            expected_result = expected_result.read()

        #compare the output with the expected result
        assert output == expected_result
        
    else: # should fail bc running with negative tests
        # get return result of command
        result = subprocess.run(dune_command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
        assert result.check_returncode != 0

if __name__ == "__main__":
    pytest.main()