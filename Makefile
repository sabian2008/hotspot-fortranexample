COMP     = gfortran -c -march=native
LINK     = gfortran

standard_mult.o:
	$(COMP) -O2 standard_mult.f90

O_mult.o:
	$(COMP) -O O_mult.f90

O1_mult.o:
	$(COMP) -O1 O1_mult.f90

O2_mult.o:
	$(COMP) -O2 O2_mult.f90

O3_mult.o:
	$(COMP) -O3 O3_mult.f90

test:
	@$(MAKE) standard_mult.o
	@$(MAKE) O_mult.o
	@$(MAKE) O1_mult.o
	@$(MAKE) O2_mult.o
	@$(MAKE) O3_mult.o
	$(LINK) *.o test.f90 -o test

clean:
	rm -f *.o

dist:
	@$(MAKE) clean
	rm -f test

