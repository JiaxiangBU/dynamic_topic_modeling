README:
	Rscript analysis/build-README.R

index1:

	RScript ../imp_rmd/update_index_content.R

index2:

	notedown index.md  > index.ipynb
	cp README-tmp.md README.md
	rm README-tmp.md

push:
	Rscript analysis/push.R

all: index push
