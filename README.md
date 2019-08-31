
# QPA

# Depends
R Vsersion >= 3.4.2
R Package: omicade4, clusterProfiler, KEGGREST, limma, ade4, parallel

# Installation

install.packages("devtools") # if you have not installed "devtools" package
library(devtools)
devtools::install_github("github-gs/QPA")

or you can down load the source code .zip file to install.
(https://github.com/github-gs/QPA/blob/source-code-zip/QPA_1.0.tar.gz) 


# R Depends Package Installation
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(c('omicade4', 'clusterProfiler', 'KEGGREST', 'limma', 'ade4'))

install.package('parallel')

# Usage

# Example

data(Case)  ######## pathway-gene matrix


pathway_info = merge(pathway_list)

group1 = 'Treatment'

group2 = 'Model'

group3 = 'Control'


Treatment_profile = pathway_vectorize(nmerge_tab,condition,group1,group2,pathway_info)

Model_profile = pathway_vectorize(nmerge_tab,condition,group2,group3,pathway_info)

significant_pathway = pathway_comparision(Treatment_profile,Model_profile,pathway_info)
