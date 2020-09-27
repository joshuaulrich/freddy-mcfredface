require(ratelimitr)

api_url <-
  function(category_id, api_key = NULL)
{
    if (is.null(api_key)) {
        api_key <- fred.key
    }
    
    u <- paste0("https://api.stlouisfed.org/fred/category/children?",
                "category_id=%s&file_type=json&api_key=%s")
    u <- sprintf(u, category_id, api_key)
    return(u)
}

import_category_children <-
  function(category_id, api_key = NULL)
{
    u <- api_url(category_id, api_key)
    d <- jsonlite::fromJSON(u)[[1]]
    d$notes <- NULL
    last_id <<- category_id
    return(d)
}
import_category_children <-
  limit_rate(import_category_children, rate(1, 2))

needed_categories <- 0      # root category
fetched_categories <- NULL  # nothing fetched yet

c0 <- do.call(rbind, lapply(needed_categories, import_category_children))
fetched_categories <- c(unique(c0[["parent_id"]]), fetched_categories)
needed_categories <- unique(c0[["id"]])

c1 <- do.call(rbind, lapply(needed_categories, import_category_children))
fetched_categories <- c(unique(c1[["parent_id"]]), fetched_categories)
needed_categories <- unique(c1[["id"]])

c2 <- do.call(rbind, lapply(needed_categories, import_category_children))
fetched_categories <- c(unique(c2[["parent_id"]]), fetched_categories)
needed_categories <- unique(c2[["id"]])

c3 <- do.call(rbind, lapply(needed_categories, import_category_children))
fetched_categories <- c(unique(c3[["parent_id"]]), fetched_categories)
needed_categories <- unique(c3[["id"]])

c4 <- do.call(rbind, lapply(needed_categories, import_category_children))
fetched_categories <- c(unique(c4[["parent_id"]]), fetched_categories)
needed_categories <- unique(c4[["id"]])

c5 <- do.call(rbind, lapply(needed_categories, import_category_children))
fetched_categories <- c(unique(c5[["parent_id"]]), fetched_categories)
needed_categories <- unique(c5[["id"]])

c6 <- do.call(rbind, lapply(needed_categories, import_category_children))
fetched_categories <- c(unique(c6[["parent_id"]]), fetched_categories)
needed_categories <- unique(c6[["id"]])

c7 <- do.call(rbind, lapply(needed_categories, import_category_children))
fetched_categories <- c(unique(c7[["parent_id"]]), fetched_categories)
needed_categories <- unique(c7[["id"]])

c8 <- do.call(rbind, lapply(needed_categories, import_category_children))
fetched_categories <- c(unique(c8[["parent_id"]]), fetched_categories)
needed_categories <- unique(c8[["id"]])

c9 <- do.call(rbind, lapply(needed_categories, import_category_children))
fetched_categories <- c(unique(c9[["parent_id"]]), fetched_categories)
needed_categories <- unique(c9[["id"]])

allc <- rbind(c0, c1, c2, c3, c4, c5, c6, c7, c8, c9)
save(c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, file = "all_c.RData")

gen1 <- allc
names(gen1) <- c("parent_id", "parent_name", "gparent_id")
family_tree <- merge(allc, gen1, by="parent_id", all.x = TRUE, sort = FALSE)
ft <- family_tree[c("id", "name", "parent_id", "parent_name", "gparent_id")]


#{{{ JD's script
## library(fredr)
## library(tidyverse)
##
## fredr_set_key(Sys.getenv("FRED_KEY"))
##
## crawl_children <- function(category_ids) {
##   # take a vector of categories and fetch children
##
##   out <- tibble()
##
##   for (category_id in category_ids) {
##     print(paste("now fetching id:", category_id))
##     children <- fredr_category_children(category_id)
##     children %>%
##       bind_rows(out) ->
##       out
##   }
##
##   return(out)
## }
##
## need_to_crawl <- function(children_df) {
##   # return children who need to be crawled
##
##   children_df %>%
##     select(id) ->
##     ids
##
##   children_df %>%
##     select(parent_id) ->
##     parent_ids
##
##   ids %>%
##     anti_join(parent_ids, by = c("id" = "parent_id")) %>%
##     distinct(id) %>%
##     pull(id) ->
##     needed
##
##   return(needed)
## }
##
## start_df <- crawl_children(0:6)
## out_df <- start_df
## new_df <- start_df
##
## loop <- 1
##
## while (nrow(new_df) > 0) {
##   print(paste(
##     "now on loop:",
##     loop,
##     "------------------------------------------------"
##   ))
##
##   start_df %>%
##     need_to_crawl %>%
##     crawl_children ->
##     new_df
##
##   new_df %>%
##     bind_rows(out_df) ->
##     out_df
##   print(paste("we've now pulled this many categories:", nrow(out_df)))
##   start_df <- new_df
##
##   loop <- loop + 1
## }
##
## out_df %>%
##   write_csv("out_df_crawl.csv")
##
## out_df %>%
##   left_join(out_df, by=c('id'='parent_id')) %>% View
#}}}
