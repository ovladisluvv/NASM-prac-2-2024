.PHONY: all clean test
all: integral

integral: integral.o functions.o
	gcc -m32 -lm integral.o functions.o -o integral
	
integral.o: 
	gcc -m32 -c integral.c -o integral.o
	
functions.o: 
	nasm -f elf32 functions.asm -o functions.o

test: integral
	./$< -R 1:2:0.2984:3.9999:0.00001:0.697082
	./$< -R 1:3:0.01:0.3308:0.00001:0.330056
	./$< -R 2:3:0.666:7.777:0.00001:0.922758
	./$< -I 1:4.5:5.5:0.0001:-370.752
	./$< -I 2:2.37:7.943:0.0001:11143.2
	./$< -I 3:5.6728:1.5684:0.0001:-0.0576641

clean:
	rm *.o integral
