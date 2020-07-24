## code to prepare `affirmative_modifed` dataset goes here

# usethis::use_data(affirmative_modifed, overwrite = TRUE)
library(tidyverse)
affirmative <- readr::read_csv("data/affirmative.csv")
affirmative_modifed <-
    affirmative %>%
    rename_all(str_to_lower) %>%
    mutate(
        group = group %>%
            str_replace("八", "8") %>%
            str_replace("九", "9") %>%
            str_replace("十", "10") %>%
            str_extract("\\d+") %>%
            str_pad(width = 2, pad = "0") %>%
            str_c("第", ., "组")
    )
affirmative_modifed %>%
    write_excel_csv("data/affirmative_modifed.csv")
