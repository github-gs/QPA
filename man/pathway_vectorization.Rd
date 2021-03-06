% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pathway_vectorization.R
\name{pathway_vectorization}
\alias{pathway_vectorization}
\title{Vectorization of pathways}
\usage{
pathway_vectorization(expression_profile,condition,group1,group2,pathway_info)
}
\arguments{
\item{expression_profile}{Gene expression profile contains gene expression. Rownames are entrez IDs. Colnames are sample names.}

\item{condition}{A vector contains group information of samples. For example, condition<-c(type1,type1,type2,type2) of four samples.}

\item{group1}{Group1 to be compared.}

\item{group2}{Group1 to be compared.}

\item{pathway_info}{A list containing pathway information to be compared, which can be generated by the merge_pathway function.}
}
\value{
Return a dataframe which contains pathway-gene information. Colnames are pathways' names, rownames are genes' names and the value of each element is Foldchange between two groups.
}
\description{
This function vectorizes pathways by creating pathway-gene profile.
}
\examples{
data(example)
group1='Treatment'
group2='Model'
group3='Control'
Treatment_profile=pathway_vectorize(expression_profile,condition,group1,group2,pathway_info)
Model_profile=pathway_vectorize(expression_profile,condition,group2,group3,pathway_info)

}
