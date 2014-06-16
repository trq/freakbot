git checkout master
git merge --no-ff develop

git push heroku master
git push origin master

git checkout develop
git push origin develop
