#subsection of summary file
esearch -db gene -query 'aedes aegypti transient receptor potential' | esummary | grep -A 7 "<Id>" > mechano_aegypti.txt

esearch -db gene -query 'aedes aegypti pickpocket' | esummary | grep -A 7 "<Id>" >> mechano_aegypti.txt

esearch -db gene -query 'aedes aegypti piezo' | esummary | grep -A 7 "<Id>" >> mechano_aegypti.txt

esearch -db gene -query 'aedes aegypti TMEM63' | esummary | grep -A 7 "<Id>" >> mechano_aegypti.txt

esearch -db gene -query 'aedes aegypti tmc' | esummary | grep -A 7 "<Id>" >> mechano_aegypti.txt

esearch -db gene -query '5566135' | esummary | grep -A 7 "<Id>" >> mechano_aegypti.txt

esearch -db gene -query '5571248' | esummary | grep -A 7 "<Id>" >> mechano_aegypti.txt

#fasta file
esearch -db gene -query 'aedes aegypti transient receptor potential' | esummary | grep  "<Id>" | cut -d ">" -f 2 | cut -d "<" -f 1  > mechano_aegypti_fna.txt

esearch -db gene -query 'aedes aegypti pickpocket' | esummary | grep  "<Id>" | cut -d ">" -f 2 | cut -d "<" -f 1  >> mechano_aegypti_fna.txt

esearch -db gene -query 'aedes aegypti piezo' | esummary | grep  "<Id>" | cut -d ">" -f 2 | cut -d "<" -f 1  >> mechano_aegypti_fna.txt

esearch -db gene -query 'aedes aegypti TMEM63' | esummary | grep  "<Id>" | cut -d ">" -f 2 | cut -d "<" -f 1  >> mechano_aegypti_fna.txt

esearch -db gene -query 'aedes aegypti tmc' | esummary | grep  "<Id>" | cut -d ">" -f 2 | cut -d "<" -f 1  >> mechano_aegypti_fna.txt

esearch -db gene -query '5566135' | esummary | grep  "<Id>" | cut -d ">" -f 2 | cut -d "<" -f 1   >> mechano_aegypti_fna.txt

esearch -db gene -query '5571248' | esummary | grep  "<Id>" | cut -d ">" -f 2 | cut -d "<" -f 1  >> mechano_aegypti_fna.txt

