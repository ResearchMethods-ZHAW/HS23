list.files(path = c("stat1-4", "stat5-8", "statKons"), pattern = "\\.qmd$", recursive = TRUE,full.names = TRUE) |>
    sapply(\(x){
        y <- file.path("purl",paste0(tools::file_path_sans_ext(basename(x)),".R"))
        knitr::purl(x, output = y,documentation = 0L)
        }) 