README:
	Rscript analysis/build-README.R

index:

	RScript ../imp_rmd/update_index_content.R
	notedown index.md  > index.ipynb
	cp README-tmp.md README.md
	rm README-tmp.md
