TARGET_DIR="docker/work/submodules/${DIR}"

addsubmodule:
	echo ${REPO}
	echo ${DIR}
	git submodule add ${REPO} ${TARGET_DIR}
removesubmodule:
	@echo ${TARGET_DIR}
	git submodule deinit -f ${TARGET_DIR}
	git rm -f ${TARGET_DIR}
	rm -rf .git/modules/${TARGET_DIR}
update_piplock:
	/bin/bash -x scripts/update_piplock.sh
cp_pipfiles_to_local:
	docker compose cp jupyter:/home/jovyan/Pipfile ./src/notebook/
	docker compose cp jupyter:/home/jovyan/Pipfile.lock ./src/notebook/

freeze:
	docker compose exec jupyter pip3 list --format=freeze > ./src/notebook/requirements.txt
