#' @title Quantitative Pathway Analysis
#‘
#' @description This package provides tools for analysis KEGG pathways quantitatively. A new quantitative way to analysis biological pathways which contains functions for vectorizing and comparing pathways.
#'
#'
#' @details Main functions are as follows; additional help is
#'     available for each function, e.g., `?QPA::pathway_vectorization`.
#'
#' \describe{
#'
#'   \item{`QPA::merge_pathway()`}{Return a list containing three elements KEGG IDs,ENTREZ ID of genes which are pathway members,pathway and gene interaction.}
#'
#'   \item{`QPA::pathway_vectorization()`}{Return a list which contains two pathway-gene profiles that are vectorization result of pathways. Colnames are pathways' names, rownames are genes' names.}
#'
#'   \item{`QPA::pathway_comparison()`}{Return a dataframe containing pathway ID and p-value.}
#'
#'
#' }
#'
#' @name Quantitative Pathway Analysis-pkg
#' @aliases QPA
#' @docType package
"_PACKAGE"
