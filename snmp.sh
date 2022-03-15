#!/bin/bash
if [ $# != 1 ]
then
 echo "Usar: . snmp [HOST]"
 exit 1
fi
TARGET=$1
echo "[*] Ejecutando enumeración SNMP en '$TARGET'"
for comm_string in \
`msfcli auxiliary/scanner/snmp/snmp_login RHOSTS=$TARGET E 2> /dev/null\
 | awk -F\' '/access with community/ { print $2 }'`;
do
 echo "[*] cadena comunitaria encontrada '$comm_string' ...ejecutando enumeración";
 msfcli auxiliary/scanner/snmp/snmp_enum RHOSTS=$TARGET
COMMUNITY=$comm_string E 2> /dev/null;
done
