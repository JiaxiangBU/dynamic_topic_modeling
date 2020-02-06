# update template ---------------------------------------------------------

library(fs)
file_copy("../dev_history/refs/dev_history_r_proj.R",
          ".",
          overwrite = TRUE)

# setup -------------------------------------------------------------------

library(devtools)
use_git()

# CTRL + F1 show Git
library(devtools)
use_build_ignore("dev_history_r_proj.R")
library(magrittr)

# add desc ----------------------------------------------------------------

library(usethis)
add2pkg::create_desc()
author_info <- add2pkg::add_me(is_paste = TRUE)
desc_lines <- readr::read_lines("DESCRIPTION")
desc_lines[5] <- author_info
desc_lines %>% readr::write_lines("DESCRIPTION")
# file.edit("DESCRIPTION")
library(tidyverse)

# add license -------------------------------------------------------------

options(usethis.full_name = "Jiaxiang Li")
use_cc0_license()


# add namespace -----------------------------------------------------------

use_namespace()


# add makefile ------------------------------------------------------------

usethis::use_make()

# coding ------------------------------------------------------------------

# prettify ----------------------------------------------------------------

if (file.exists("README.Rmd")) {
    file.rename("README.Rmd", "README-bak.Rmd")
    file.edit("README-bak.Rmd")
}
use_readme_rmd(open = FALSE)
read_lines("README.Rmd")[1:22] %>%
    c("") %>%
    c('`r add2pkg::add_disclaimer("Jiaxiang Li")`') %>%
    write_lines("README.Rmd")
file.remove("README-bak.Rmd")
# file.edit("README.Rmd")
rmarkdown::render("README.Rmd")
rstudioapi::viewer("README.html")
file.remove("README.html")

# add examlpes ------------------------------------------------------------

clipr::read_clip() %>%
    str_c("#' ", .) %>%
    clipr::write_clip()

clipr::read_clip() %>%
    str_c("#' \\dontrun{", ., "}") %>%
    clipr::write_clip()


# add dirs ----------------------------------------------------------------

library(tidyverse)
library(fs)
list("analysis", "output", "refs") %>% map(dir.create)


# add commit --------------------------------------------------------------


git2r::add(path = ".")
glue::glue("Add metadata

1. license
1. readme
1. namespace
1. desc
1. Makefile") %>%
    git2r::commit(message = .)

git2r::remote_add(name = "origin",
                  url = glue::glue("https://github.com/JiaxiangBU/{add2pkg::proj_name()}.git"))

library(git2r)
git2r::push(name = 'origin', refspec = "refs/heads/master",
            cred = git2r::cred_token()
            )


# delete object -----------------------------------------------------------

rm("author_info")
rm("desc_lines")

# update template ---------------------------------------------------------

library(fs)
file_copy("dev_history_r_proj.R", "../dev_history/refs/dev_history_r_proj.R",
          overwrite = TRUE)
repo <-  git2r::repository("../dev_history/")
repo %>% git2r::status()
repo %>% git2r::add(path = ".")
repo %>% git2r::status()
repo %>% git2r::commit(message = "Update r proj dev history.")
repo %>% git2r::push(name = 'origin', refspec = "refs/heads/master", cred = git2r::cred_token())
rm("repo")


# update local ------------------------------------------------------------

git2r::status()
git2r::add(path = "dev_history_r_proj.R")
git2r::status()
git2r::commit(message = "Update r proj dev history.")
git2r::push(name = 'origin', refspec = "refs/heads/master", cred = git2r::cred_token())
