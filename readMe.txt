Read Me for the shTest folder.

5 Steps total:
0: zipMerge: Takes the first 2 ".gz" files with the label "_R1" and "_R2" and unzips them -> merges them (step 0 bc its optional in proccess)

1: Fastq to Fasta: Takes the files and converts them to fasta using fastx toolkit

2: Kraken2: Takes the fasta file and filters through the kraken2 database (using memory mapping for efficiency)

3: SPAdes: Takes the kraken2 output and runs it throught spades

4: Cleanup: All relevant files are moved to the output folder, non needed files deleted (note there will be random *.report files, terminal cannot delete them)


Inputs:
There are 2 starting points for the step1Total (zipMerge || toFasta)

zipMerge requires at least 2 files with the ".gz" each having either "_R1" or "_R2" and have the file extenstion "fasta"
i.e. myData_notSortedYet_R1.fasta.gz && myData_notSortedYet_R2.fasta.gz

FastaToFastq requires a file that has file extention ".fasta"

Failing to name the input files is the most common error, you will see everything break.


Setup the project:
You can change all of the directory paths in var.txt:
I recommend setting up your file structure something like this:

scratch/
    pipeline/
        -0-zipMerge
        -1-fastaToFastq
        -2-inputToKraken2
        -3-inputToSPAdes
        -4-output

where path0 is zipMerge

After you setup the files we need to make the code runable now:
set the shTest folder as the current directory
$ make


Running the code:
you should now be ready to run the code:
Load the input folders with the files of correct naming sequence
$ ./step1Total.sh
or
$ make run
(it will prompt you for if you want to run the zipMerge or not)