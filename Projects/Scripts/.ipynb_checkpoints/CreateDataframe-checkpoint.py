#!/usr/bin/env python
# coding: utf-8

# # Find dataset in the provided data folder and Loading Datasets into a dataframes dict

import pandas as pd
import os
import zipfile

global dataframes
dataframes = {}


def find_and_make_dataset(folder_name, dataset):
    """
    Find dataset in the provided folder and load it into dataframes dictionary.

    Args:
        folder_name (str): Name of the folder to search in
        dataset (str): Name of the dataset file to find

    Returns:
        dict: Dictionary containing dataframes
    """

    dataset_path = ""

    for root, dirs, files in os.walk("/Users/my-air/Desktop/DSA/Github/Data Engineering/DE-Notes/Projects"):
        try:
            if folder_name in dirs:
                data_file_path = os.path.join(root, folder_name)
                print(f"Dataset folder found at: {data_file_path} \n")

                for d_root, d_dirs, d_files in os.walk(data_file_path):
                    try:
                        visible_files = [each for each in d_files if
                                         not each.startswith('.')]  #ignore hidden files and empty

                        for file in visible_files:
                            if dataset in file:
                                dataset_path = os.path.join(data_file_path, file)
                                print(f"Dataset file found: {dataset_path.split('/')[-1]}\n")
                                return (convert_zip_to_dataframe(dataset, dataset_path))
                                print(f"New dataset added to dataframes dict: {dataframes.keys()}")
                    except Exception as e:
                        print(f"{e}")
        except Exception as e:
            print(f"{e}")


def convert_zip_to_dataframe(dataset_name, dataset_path):
    """
   Convert zip file to pandas dataframes

   Args:
   dataset_name (str): Name of the dataset file to find
   dataset_path (str): Path to the zip file
   Returns:

   """
    if not os.path.isfile(dataset_path):
        raise FileNotFoundError("File not found: {dataset_path}")
    else:
        print(f"Processing file: {dataset_path} \n")  #process stage update
        with zipfile.ZipFile(dataset_path, 'r') as zip_ref:
            if dataset_name in dataframes.keys():
                print("dataset converted to datarame already please check dataframes.keys()")
            else:
                dataframes[dataset_name] = {}

                file_list = zip_ref.namelist()

                for file in file_list:
                    if '.csv' in file:
                        try:
                            print(f"Extracting {file} and converting it to a dataframe \n")  #process stage update
                            extracted_file = zip_ref.extract(file)

                            df = pd.read_csv(extracted_file)  #extract the file and read csv into a pandas dataframe

                            dataframes[dataset_name][file.split('/')[1]] = df

                            print(f"Sucessfully processed the data file: {file} \n")

                            #Cleanup
                            os.remove(file)
                            print(f"{file} removed \n")
                            os.rmdir(file.split('/')[0])
                            print(f"Directory removed")

                        except Exception as e:
                            print(f"Error reading the csv file {file}: {e}")
                    continue
        # return dataframes

def get_dataframes():
    """
    Return the dataframes dictionary
    Returns:
    dict: Dictionary containing all loaded dataframes
    """
    return dataframes

if __name__ =="__main__":

    print("tsting")