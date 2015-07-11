plan:
	terraform plan -input=false

core-user-data:
	terraform apply -target=template_file.deis-core
	@cat ./tmp/deis-core/user_data.yml | pbcopy

apply:
	terraform apply -input=false

refresh:
	terraform refresh -input=false

push:
	terraform push -vcs=false -name brandfolder/infrastructure .