# QPA


# Installation

install.packages("devtools") # if you have not installed "devtools" package
devtools::install_github("github-gs/QPA")

# Usage

pathway_info=merge(pathway_list)

group1='Treatment'
group2='Model'
group3='Control'


Treatment_profile=pathway_vectorize(expression_profile,condition,group1,group2,pathway_info)
Model_profile=pathway_vectorize(expression_profile,condition,group2,group3,pathway_info)

significant_pathway=pathway_comparision(Treatment_profile,Model_profile,pathway_info)
