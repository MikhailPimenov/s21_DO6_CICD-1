CC= gcc -std=c11 -D_GNU_SOURCE
CFLAGS=
GREP= s21_grep.c

all: s21_grep

s21_grep:
	$(CC) $(CFLAGS) $(GREP) -o s21_grep

test:
	chmod 777 test.sh
	./test.sh

clean:
	rm -rf s21_grep
	rm -rf *.a *.out *.o *.txt

check:
	clang-format -n s21_grep.c >> clang_output.txt
	clang-format -n s21_grep.h >> clang_output.txt

rebuild:
	make clean
	make all
	rm -rf  *.o *.a
