% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/merge_pathway.R
\name{merge_pathway}
\alias{merge_pathway}
\title{Merge enriched pathways between different groups together.}
\usage{
merge_pathway(pathway_list)
}
\arguments{
\item{pathway_list}{A list containing KEGG IDs of enriched pathways in different groups.}
}
\value{
Return a list containing three elements KEGG IDs,ENTREZ ID of genes which are pathway members,pathway and gene interaction.
}
\description{
This function combines the enriched pathways together,preparing for the next step comparing pathways between different groups.
}
\examples{
data(example)
pathway_info=merge_pathway(pathway_vector)


}
