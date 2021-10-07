all: P2 P3 P4 P5

P2: P2.o
	gcc -o P2 P2.o
	rm -f P2.o

P3: P3.o 
	gcc -o P3 P3.o
	rm -f P3.o

P4: P4.o
	gcc -o P4 P4.o
	rm -f P4.o

P5: P5.o 
	gcc -o P5 P5.o
	rm -f P5.o

P2.o: P2.c
	gcc -c P2.c

P3.o: P3.c
	gcc -c P3.c

P4.o: P4.c
	gcc -c P4.c

P5.o: P5.c
	gcc -c P5.c


clean:
	rm -f P2 P3 P4 P5  *.txt *.o *~ \#* 
