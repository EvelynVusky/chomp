MAKEFLAGS += --silent

# "make all" builds the executable
.PHONY : all
all : ./_build/default/binb/toplevel.exe printbin.o

# "make test" Compiles everything and runs the regression tests
.PHONY : test
test : all run_tests.py run_semant_tests.py
	pytest run_tests.py
	pytest run_semant_tests.py

# "make run FILENAME=<filename>" runs the compiler on a single test
.PHONY : run
run: all
	@if [ -z "$(FILENAME)" ]; then \
        echo "Error: Please provide a filename with FILENAME=<your_filename>"; \
        exit 1; \
    fi
	make all
	dune exec --no-build toplevel $(FILENAME).chomp > $(FILENAME).ll
	llc -relocation-model=pic $(FILENAME).ll
	gcc $(FILENAME).s -o $(FILENAME).exe printbin.o
	-./$(FILENAME).exe
	
printbin : printbin.c
	cc -o printbin -DBUILD_TEST printbin.c

# "make" will just compile the chomp compiler along with printbig.c

./_build/default/binb/toplevel.exe : binb/parser.mly binb/scanner.mll binb/codegen.ml binb/semant.ml binb/toplevel.ml
	dune build

# "make clean" removes all generated files
.PHONY : clean
clean :
	dune clean
	rm -rf chomp.opam *.s *.out *.ll *.exe tests/*.s tests/*.ll tests2/*.exe test2s/*.s tests2/*.ll tests2/*.exe printbin.o
