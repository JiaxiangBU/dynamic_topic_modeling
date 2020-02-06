README:
	Rscript analysis/build-README.R

index:

	RScript -e "rmarkdown::render('../imp_rmd/update_index_content.Rmd')"
	notedown index.md  > index.ipynb
	cp README-tmp.md README.md
	rm README-tmp.md
