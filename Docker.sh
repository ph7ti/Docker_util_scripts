#!/bin/bash

#Parando ou iniciando os serviços do Docker

status=$(service docker status | grep active | awk '{print $2}')
zenity --question --text "Status atual do Docker: $status - Deseja modificar?" --no-wrap --ok-label "Sim" --cancel-label "Não"
opcao=$?
if [[ $opcao == 0 ]]; then
	if [[ $status = 'inactive' ]]; then
		PASSWD=$(zenity --password --title="Authenticação" --text "$status")
		echo $PASSWD | sudo service docker start
	else
		PASSWD=$(zenity --password --title="Authenticação" --text "$status")
		echo $PASSWD | sudo service docker stop
	fi
	zenity --info --title="Informação" --text="Status atual do Docker: $(service docker status | grep active | awk '{print $2}')" --width="200" height="50"
fi
