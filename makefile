include var.txt

all: compile
	chmod +x *.sh
compile:
	g++ -c $(shTestPath)/zipMerge/zipMerge.cpp -std=c++17 -lstdc++fs -o $(shTestPath)/zipMerge/zipMerge.out; g++ $(shTestPath)/zipMerge/zipMerge.out -lstdc++fs -o $(shTestPath)/zipMerge/zipMerge
run:
	./step1Total.sh
test: var.txt
	echo "$(path0)"