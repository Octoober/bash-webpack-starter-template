#!/bin/bash

# Vars
gitRepo="https://github.com/Octoober/webpack-starter-template.git"
q="[ \e[32m?\e[0m ]"

# Input project name
function inProjectName() { 
	echo -ne "${q} Project name: "; read projectName
}

# Create project
function create() {
	echo -e "\nGit clone: ${gitRepo}"
	git clone $gitRepo $projectName
	rm -rf $projectName/.git $projectName/.gitignore
	# Rename project
	sed -i "s/\"webpack-starter-template\"/\"${projectName}\"/g" $projectName/package.json
}

# Run input project name
echo; inProjectName

# If no project name is specified
while [ -z $projectName ]; do
	echo -e "\n\e[1;33mPlease indicate the name of your project.\e[0m"
	inProjectName
done

# Question run "npm install"
echo -ne "${q} Run install (Y/N): "; read install

case "$install" in
	n|N)
		create
		echo -e "\n\tSuccessfully created \"${projectName}\"\n\n\t\e[1;32mcd ${projectName}\n\tnpm install \n\tnpm run dev\e[0m"
		;;
	y|Y|*)
		create
		echo -e "\n\e[1;32mRun \"npm install\"...\e[0m"
		cd $projectName
		npm install
		;;
esac

#---end