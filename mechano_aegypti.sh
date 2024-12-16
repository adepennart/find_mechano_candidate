esearch -db gene -query 'aedes aegypti transient receptor potential' | esummary | grep -A 7 "<Id>" > mechano_aegypti.txt

esearch -db gene -query 'aedes aegypti pickpocket' | esummary | grep -A 7 "<Id>" >> mechano_aegypti.txt

esearch -db gene -query 'aedes aegypti piezo' | esummary | grep -A 7 "<Id>" >> mechano_aegypti.txt

esearch -db gene -query 'aedes aegypti TMEM63' | esummary | grep -A 7 "<Id>" >> mechano_aegypti.txt

esearch -db gene -query 'aedes aegypti tmc' | esummary | grep -A 7 "<Id>" >> mechano_aegypti.txt

esearch -db gene -query '5566135' | esummary | grep -A 7 "<Id>" >> mechano_aegypti.txt

# esearch -db gene -query '5567467' | esummary | grep -A 7 "<Id>" >> mechano_aegypti.txt

esearch -db gene -query '5566135' | esummary | grep -A 7 "<Id>" >> mechano_aegypti.txt

#esearch -db gene -query '5572115' | esummary | grep -A 7 "<Id>" >> mechano_aegypti.txt

esearch -db gene -query '5571248' | esummary | grep -A 7 "<Id>" >> mechano_aegypti.txt