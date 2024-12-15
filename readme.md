### Conda environment
First make sure conda is installed. If you do not have conda, refer to online resources on how to install conda.
https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html

Once installed, we can make a conda environment.

```bash=
conda create --name proteome
#activate
conda activate proteome
```
### Part 1: mechano_of_interest
#### Dependencies
This part requires  NCBI's Entrez Direct (EDirect) terminal app to download the proteomes from their database. The following link can be used to download the terminal app.
```bash=
sh -c "$(curl -fsSL https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/install-edirect.sh)"
```
After installing it will  ask if you would like to automatically install the path variables. Select yes.

If it does not work refer the NCBI EDirect webpage https://www.ncbi.nlm.nih.gov/books/NBK179288/.



Once set up, activate EDirect in this terminal session with the following.

```bash=
export PATH=${HOME}/edirect:${PATH}
```


Wget is also required to download the proteomes. So on a mac, one has to install homebrew to install wget.
```bash=
#install homebrew (mac OS 13.1)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#install wget
brew install wget
```
Should be good to run the first part of the workflow.


## Usage

### Part 1:  get candidate genes
run in terminal following code

```
chmod +x mechano_aegypti.sh

./mechano_aegypti.sh

```

run python script to get data wanted
```
python select_gene_of_interest.py  -i input -o output -g mechano_aegypti.txt


```

###### missing wtrw for some reason