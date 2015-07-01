plan:
	terraform plan -input=false

apply:
	terraform apply -input=false

refresh:
	terraform refresh -input=false

push:
	terraform push -vcs=false -name brandfolder/infrastructure .