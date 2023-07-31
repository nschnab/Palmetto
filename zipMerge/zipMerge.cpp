#include <string>
#include <iostream>
#include <filesystem>
#include <vector>
#include <fstream>

using namespace std;
namespace fs = std::filesystem;

int main() {

    // //g++ -c zipMerge.cpp -std=c++17 -lstdc++fs -o zipMerge.out; g++ zipMerge.out -lstdc++fs -o zipMerge
    // std::filesystem::path directoryPath = "/scratch/nschnab/dataFolder/fastqToFasta/-0-zipTest/";  // Replace with the actual directory path

    // std::string userInput, pattern;
    std::vector<std::string> filePairs;
    // std::string mergedFilePath = "/scratch/nschnab/dataFolder/fastqToFasta/-1-inputToFasta/";  // Update the path and file name for the merged file

    ifstream varFile("var.txt");
    if (!varFile)
    {
        cerr << "Error opening var.txt" << endl;
        return 1;
    }
    stringstream varStream;
    varStream << varFile.rdbuf();
    
    string zipPath, inputPath, outputPath, userInput;
    std::filesystem::path directoryPath;
    varStream >> zipPath >> inputPath >> outputPath;

    filesystem::path zipDirectory(zipPath);
    
    string mergedFilePath = outputPath;

    for (const auto& entry : std::filesystem::directory_iterator(zipDirectory)) {
        std::string fileName = entry.path().filename().string();
        std::string filePath1, filePath2;

        if (fileName.find("_R1") != std::string::npos) {
            userInput = fileName.substr(0, 2);  // Assuming the desired substring starts at index 0 and has a length of 2

            // Construct the corresponding file path for the second file in the pair
            std::string filePath2Name = fileName;
            filePath2Name.replace(filePath2Name.find("_R1"), 3, "_R2");
            filePath2 = zipDirectory.string() + filePath2Name;

            // Store the file paths
            filePath1 = entry.path().string();
            filePairs.push_back(filePath1);
            filePairs.push_back(filePath2);
        }
    }

    // Unzip the files
    std::cout << "Unzipping files..." << std::endl;
    for (const auto& filePath : filePairs) {
        std::string unzipCommand = "gzip -d " + filePath;
        int unzipResult = std::system(unzipCommand.c_str());
        if (unzipResult != 0) {
            std::cerr << "Failed to unzip file: " << filePath << std::endl;
            return 1;
        }
    }

    // Merge the file pairs using the cat command
    std::cout << "Merging file pairs..." << std::endl;
    for (size_t i = 0; i < filePairs.size(); i += 2) {
        std::string filePath1 = filePairs[i].substr(0, filePairs[i].size() - 3);
        std::string filePath2 = filePairs[i + 1].substr(0, filePairs[i + 1].size() - 3);

        // Extract the root name from the first file path
        std::string rootName = std::filesystem::path(filePath1).stem().string();

        // Customize the merged file name per file pair
        std::string mergedFileName = rootName + "_merged_file.fastq";
        std::string mergedFilePath2 = mergedFilePath + mergedFileName;

        // Construct the cat command for each file pair
        std::string catCommand = "cat " + filePath1 + " " + filePath2 + " > " + mergedFilePath2;

        // Execute the cat command
        int catResult = std::system(catCommand.c_str());
        if (catResult == 0) {
            std::cout << "Merged file created: " << mergedFilePath2 << std::endl;
        } else {
            std::cerr << "Failed to merge the files for pair: " << filePath1 << " and " << filePath2 << std::endl;
        }
    }
    return 0;
}
