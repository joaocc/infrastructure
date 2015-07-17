plan:
	terraform plan -input=false

core-user-data:
	terraform apply -target=template_file.deis-core
	@cat ./tmp/deis-core/user_data.yml | pbcopy

generators:
	@sh -c 'for generator in `ls generators` ; do sh generators/$$generator ; done'

apply:
	terraform apply -input=false

refresh:
	terraform refresh -input=false

push:
	terraform push -vcs=false -name brandfolder/infrastructure .

.PHONY: subdirs generators