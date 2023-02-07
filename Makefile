addsubmodule:
	echo ${REPO}
	echo ${DIR}
	git submodule add ${REPO} docker/work/submodules/${DIR}
