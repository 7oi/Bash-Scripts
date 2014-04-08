#
#  gitNew is a script for initializing a new git repo as well as creating
#  a new repo on gitHub.
#

#
# Run within the folder meant for the project
# Next to git the thing
PROJ=$(basename $PWD)
echo $PROJ
git init
echo "Which files/folders to add (. for all)?"
ADD="what"
while [[ $ADD ]]; do
	ls -A
	read -p "Add: " ADD
	git add $ADD 
done
 
if [[ "$1" ]]; then
    git commit -m "$1"
else
    git commit -m "Let there be project"
fi
read -p "GitHub user name: " GUSR
read -p "Organization name (press enter for none): " ORG
read -p "Private? (y or n): " PRI
if [[ $PRI == "y" ]] then
    PRI="private"
else
    PRI="public"
if [[ $ORG ]]; then
    echo "Creating repo $PROJ for organization $ORG on GitHub"
    curl -# -u $GUSR https://api.github.com/orgs/$ORG/repos -d "{\"name\":\"${PROJ}\"}"
    git remote add origin git@github.com:$ORG/$PROJ.git
else
    echo "Creating repo $PROJ for $GUSR on GitHub"
    curl -# -u $GUSR https://api.github.com/user/repos -d "{\"name\":\"${PROJ}\", \"${PRI}\": true}"
    git remote add origin git@github.com:$GUSR/$PROJ.git
fi   
git push origin master
