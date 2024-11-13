```
echo "esearch -db protein -query 'aedes aegypti transient receptor potential' | efetch -format fasta" >> trp_aegypti.sh

chmod +x trp_aegypti.sh 

./trp_aegypti.sh > trp_ppk_aegypti.fasta
```

```
 echo "esearch -db protein -query 'aedes aegypti pickpocket' | efetch -format fasta" >> ppk_aegypti.sh

 chmod +x ppk_aegypti.sh 

 ./ppk_aegypti.sh >> trp_ppk_aegypti.fasta 
```
now we have genes of interest

redoing it here

```
esearch -db protein -query 'aedes aegypti transient receptor potential' | esummary | grep -A 1 "<Title>" > trp_ppk_aegypti.txt
```

```
esearch -db protein -query 'aedes aegypti pickpocket' | esummary | grep -A 1 "<Title>" >> trp_ppk_aegypti.txt
```