SAVENAME=_autosave1.zip
FACTORIO_PATH={your_factorio_directory}

all:
	@echo "init"
	@echo "hardreset"
	@echo "chmod"
	@echo "start"
	@echo "stop"
	@echo "log"
	@echo "upgrade"
	@echo "console"
	@echo "import-save"

init:
	sudo chown 845:845 $(FACTORIO_PATH)
	sudo chmod -R 777 $(FACTORIO_PATH)
	docker-compose up

hardreset:
	@echo WARNING! : Factorio server will be deleted.
	@echo "> sudo rm $(FACTORIO_PATH)/* -rf"
	@echo "> docker-compose down"
	sleep 20
	sudo rm $(FACTORIO_PATH)/* -rf
	docker-compose down

chown:
	sudo chown 845:845 $(FACTORIO_PATH)
	sudo chmod -R 777 $(FACTORIO_PATH)

start:
	docker start factorio

stop:
	docker stop factorio

log:
	docker logs factorio

upgrade:
	docker stop factorio
	docker rm factorio
	docker pull factoriotools/factorio:stable

console:
	docker attach factorio

import-save:
	sudo cp ./saves/$(SAVENAME) $(FACTORIO_PATH)/saves/_autosave1.zip
	sudo chown 845:845 $(FACTORIO_PATH)/saves/_autosave1.zip
	sudo chmod 777 $(FACTORIO_PATH)/saves/_autosave1.zip
