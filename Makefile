addsubmodule:
	echo ${REPO}
	echo ${DIR}
	git submodule add ${REPO} docker/work/submodules/${DIR}
update_piplock:
	/bin/bash -x scripts/update_piplock.sh
