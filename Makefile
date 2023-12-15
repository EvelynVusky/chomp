MAKEFLAGS += --silent

# "make all" builds the executable
.PHONY : all linked_funcs
all : ./_build/default/binb/toplevel.exe linked_funcs.o

# "make test" Compiles everything and runs the regression tests
.PHONY : test
test : all testall.sh
	./testall.sh

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
	gcc $(FILENAME).s -o $(FILENAME).exe linked_funcs.o
	# ./$(FILENAME).exe
	
linked_funcs : linked_funcs.c
	cc -o linked_funcs -DBUILD_TEST linked_funcs.c

# "make" will just compile the chomp compiler along with printbig.c

./_build/default/binb/toplevel.exe : binb/parser.mly binb/scanner.mll binb/codegen.ml binb/semant.ml binb/toplevel.ml
	dune build

# "make clean" removes all generated files
.PHONY : clean
clean :
	dune clean
	rm -rf chomp.opam *.s *.out *.ll *.exe tests/*.s tests/*.ll tests/*.exe demos/*.s demos/*.ll demos/*.exe linked_funcs.o
