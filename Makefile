
# "make all" builds the executable

.PHONY : all
all : ./_build/default/binb/toplevel.exe

# "make test" Compiles everything and runs the regression tests

.PHONY : test
test : all testall.sh
	./testall.sh

# "make" will just compile the MicroC compiler along with printbig.c

./_build/default/binb/toplevel.exe : binb/parser.mly binb/scanner.mll binb/codegen.ml binb/semant.ml binb/toplevel.ml
	dune build

# "make clean" removes all generated files

.PHONY : clean
clean :
	dune clean
	rm -rf *.diff chomp.opam *.s *.out *.ll *.exe


# Building the zip

TESTS = \
  print

FAILS = \

TESTFILES = $(TESTS:%=test-%.chomp) $(TESTS:%=test-%.out) \
	    # $(FAILS:%=fail-%.chomp) $(FAILS:%=fail-%.err)
