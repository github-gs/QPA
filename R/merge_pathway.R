#' @name merge_pathway
#' @title Merge enriched pathways between different groups together.
#'
#' 
#' @description This function combines the enriched pathways together,preparing for the next step comparing pathways between different groups.
#'
#'
#' @param pathway_list A list containing KEGG IDs of enriched pathways in different groups.
#'
#' @usage merge_pathway(pathway_list)
#'
#' @return Return a list containing three elements KEGG IDs,ENTREZ ID of genes which are pathway members,pathway and gene interaction.
#'
#' @examples
#' data(example)
#' pathway_info=merge_pathway(pathway_vector)
#'
#'
#' @export
#'




merge_pathway<-function(pathway_list){

    requireNamespace("KEGGREST")
    path.list<-keggLink("pathway",'rno')
    genes=gsub(paste('rno',":",sep=""),"",names(path.list))
    paths=gsub(paste('path',":",sep=""),"",path.list)
    kg.sets=split(genes,paths)

    pathway=c()
    for (i in 1:length(pathway_list)){
      	pathway=c(pathway,pathway_list[[i]])
    }
    all_pathway=pathway[!duplicated(pathway)]

    all_gene_in_pathway=c()     ###### save genes' entrez id in pathway
    for(i in 1:length(pathway)){
        gene_in_pathway=kg.sets[[pathway[i]]]
        all_gene_in_pathway=c(all_gene_in_pathway,gene_in_pathway)
    }
    all_gene_in_pathway=all_gene_in_pathway[!duplicated(all_gene_in_pathway)]

    pathway_info=list(all_pathway,all_gene_in_pathway,kg.sets)  ###### contain 3 elements:kegg id,entrez id,pathway and gene interaction

    return(pathway_info)
}
