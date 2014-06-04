#!/bin/bash


#table creation
mysql sme8admin < /usr/share/doc/smeserver-sme8admin/tables-update.sql 2>err
if [ $? -ne 0 ]
then
    echo -n "Error in the modification of the tables : "
    cat err
else
    echo -e "Modification of tables :\t\t\t[OK]"
fi

rm -f err

#validation des modifications
mysqladmin flush-privileges


