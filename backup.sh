[200~#!/bin/bash
# Envoyer un mail en cas d’erreur
#la commande trap qui permet d'appeler une fonction ou lancer une commande en cas d'erreur
exec 2>$LOGERR
trap 'err_handler' ERR
function err_handler {
	        mail -s TestErreur admins@domain.com < $LOGERR
		        exit 1
		}
	# date du jour
	backupdate=$(date +%Y-%m-%d)
	#répertoire de backup
	dirbackup=/backup/backup-$backupdate
	# création du répertoire de backup
	mkdir $dirbackup
	# /home contient tous les fichiers de notre site web
	# créé une archive bz2
	# sauvegarde de /home + ignorer les dossiers.git, logs et tmp
	Tar --exclude={git,logs,tmp} -cjf $dirbackup/home-$backupdate.tar.bz2 /home


	# sauvegarde mysql DB
	 mysqldump --user=mydbuser --password=mypass mydatabase | gzip > $dirbackup/mysqldump-$backupdate.sql.gz

	 find $dirbackup -mtime+8 -exec rm{}\

