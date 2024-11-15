
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Title: select_gene_of_interest.py
Date: May 29th, 2024
Author: Auguste de Pennart
Description:
    unzip fasta files and relabel the fasta headers to include shortened species name

List of functions:
    rename_file
       find gene of interest
    rename_file_stack_2
        parralelizes

List of "non standard modules"
    no non standard modules

Procedure:
    1. input with pandas .csv file
    2. import fasta file
    3. find accession match
    4. output file of interest



Usage:
    python select_gene_of_interest.py [-h] [-v] -i INPUT_FOLDER -o OUTPUT_FOLDER
                                  [-c CORES]


known error:
    1. gene of interest accession codes not an inputtable file

 """
import logging
import os, re, sys
import argparse
#import pandas


from multiprocessing import Pool
from tqdm import tqdm

logging.basicConfig(level=logging.INFO)

#sets up the previous function rename_file for parralel processing
def rename_file(filepath_dir):
    print(filepath_dir)
    fasta = filepath_dir[0].split('/')[-1] #file name
    output_file = os.path.join(filepath_dir[1][1], "filtered_"+fasta)
    testing_file = filepath_dir[1][0].split('/')[-1] #file name

    #need to include this in argeparse, and add it to list to use parallel core function
    # testing_file=os.path.abspath("trp_ppk_aegypti.fasta")
    #testing_file=os.path.abspath("trp_ppk_aegypti.txt")
    # testing_file=os.path.abspath("small_trp_ppk_aegypti.txt")


    #need to include this in argeparse
    species_dict={}
    gene_count={}
    counter=0
#could be more efficient if youj switch the nesting of these for loops
    with open(testing_file, 'r') as gene_in : 
            for gene_line in gene_in:
                # print(gene_line)
                if re.search('\<Id\>([\d]+)', gene_line):
                    accesion=re.search('\<Id\>([\d]+)', gene_line).group(1).strip()
                    print(accesion)
                    next_line=next(gene_in)
                    gene_name=re.search('\<Name\>([\dA-Za-z\_]+)', next_line).group(1).strip()
                    print(gene_name)

                    with open(filepath_dir[0], "r") as species_in:
                        for line in species_in:
                            if counter==0:
                                firstline=line
                            if f',{accesion},' in line:
                                # print("yup")
                                species_dict[gene_name.strip()]=line.strip()
                            counter+=1
                # if re.search('([A-Za-z\s\d\-\/]+)', gene_line):
                #     gene=re.search('([A-Za-z\s\d\-\/]+)', gene_line).group(1).strip()
                #     with open(filepath_dir[0], "r") as species_in: #unzips file
                #         for line in species_in:
                #             if re.search('^>', line):
                #                 if gene in line:
                #                     next_line=next(species_in)
                #                     species_dict[line.strip()]=next_line.strip()      
                #                     counter+=1  
                # else:
                #     print(gene_line.strip(),"what") 
                # if counter == 0:
                #     gene_count[gene_line]=0
                #     print(f"{gene_line.strip()} not found")
                # counter=0

    print(len(species_dict))
    with open(output_file, 'w') as f_out: 
        print(f'Id name,{firstline.strip()}', file=f_out)
        for key,value in species_dict.items(): 
            print(f'{key.strip()},{value.strip()}')
            print(f'{key.strip()},{value.strip()}', file=f_out)

            # print(f'{key.strip()}', file=f_out)
            # print(value.strip(), file=f_out)

#sets up the previous function rename_file for parralel processing
def rename_file_stack_2(files_dir,
                            my_genes,
                            n_workers,                        
                            out_dir):
    files_list=os.listdir(files_dir) #files in input folder
    if ".DS_Store" in files_list:
        files_list.remove(".DS_Store")
    os.makedirs(out_dir, exist_ok=True)  #makes output directory
    inputs = [os.path.join(files_dir, f) for f in files_list] #creates file paths
    out_plus_genes = [my_genes,out_dir] #grouped my_genes and out_dir
    path_dic= {input: out_plus_genes for input in inputs} #dictionary of input file with output file destination
    logging.info(f'Processing {len(inputs)} images from: {files_dir}') 
    logging.info(f'Using {n_workers} workers')
    with Pool(n_workers) as p: #parallel processor
        results = list(tqdm(p.imap(rename_file, path_dic.items()), total=len(inputs)))
    logging.info('Done!')
    logging.info(f'Output in: {out_dir}')
    return

if __name__ == '__main__':
    usage='make an image pyramd of inputted image(s)'
    parser=argparse.ArgumentParser(description=usage)#create an argument parser

    #creates the argument for program version
    parser.add_argument('-v', '--version',
                        action='version',
                        version='%(prog)s 1.0')
    #creates the argument where input_folder will be inputted
    parser.add_argument('-i', '--input_folder',
                        metavar='INPUT_FOLDER',
                        dest='files_dir',
                        required=True,
                        help='input folder')
     #creates the argument where input_folder will be inputted
    parser.add_argument('-g', '--gene_of_interst',
                        metavar='GENE_OF_INTEREST',
                        dest='my_genes',
                        required=True,
                        help='sectioned summary files of genes of interest from NCBI')
    #creates the argument where the output folder will be inputted
    parser.add_argument('-o', '--output_folder',
                        metavar='OUTPUT_FOLDER',
                        dest='out_dir',
                        required=True,
                        help='output folder')
    parser.add_argument('-c', '--cores',
                        metavar='CORES',
                        dest='n_workers',
                        default=1,
                        type=int,
                        help='number of cores to use')
    args=parser.parse_args()#parses command line
    rename_file_stack_2(os.path.abspath(args.files_dir),
                        os.path.abspath(args.my_genes),
                        args.n_workers,
                        os.path.abspath(args.out_dir)
                       )
    
