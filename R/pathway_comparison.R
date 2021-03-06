#' @name pathway_comparison
#' @title Projection and comparison between pathways
#'
#' @description This function makes projection and comparison between pathways. The output contains pathway ID and p-value. P-value<0.05 was considered significantly different.
#'
#'
#' @param profile1 A dataframe that generated by function pathway_vectorization().
#'
#' @param profile2 A dataframe that generated by function pathway_vectorization().
#'
#' @param pathway_info A list containing pathway information to be compared, which can be generated by the merge_pathway function.
#'
#' @usage pathway_comparison(profile1,profile2,pathway_info)
#'
#' @return Return a dataframe containing pathway ID and p-value.
#'
#' @examples
#' data(example)
#' significant_pathway=pathway_comparison(Treatment_profile,Model_profile,pathway_info)
#'
#' @export
#'
#'
#'


pathway_comparison<-function(profile1,profile2,pathway_info){
requireNamespace("omicade4")
requireNamespace("parallel")
# library(omicade4)
# library(parallel)
cl <- makeCluster(4)
########  Distance Compute Function

distance<-function(co1,co2){
  matrix<-rbind(co1,co2)
  dis<-dist(matrix)
  return(dis)
}


random_profile<-function(real_profile,input_pathway){
  ################ save all values in a vector, then random sampling in the vector (replace=True)

  exvector<-as.vector(as.matrix(real_profile))
  random_profile=data.frame()

  random_zz<-function(n){
    print(n)
    flag=FALSE
    ############ keep random matrix size same with real one by this random way
    while(flag==FALSE){
      sample=sample(exvector,ncol(real_profile),replace=TRUE)
      if(sum(sample)==0){flag=FALSE}
      else{flag=TRUE}
    }
    return(sample)
  }

  results <- parLapply(cl,1:nrow(real_profile),random_zz)
  random_profile <- do.call('rbind',results)

  rownames(random_profile)=rownames(real_profile)
  colnames(random_profile)=colnames(real_profile)

  return(random_profile)
}


Input_group<-function(group1,group2,axis,input_pathway){
  dis<-c()
  for(i in 1:length(input_pathway)){
    strcon1=paste(input_pathway[i],paste('.',group1,sep=''),sep='')
    strcon2=paste(input_pathway[i],paste('.',group2,sep=''),sep='')
    index1=c(rownames(axis)==strcon1)
    coordinate_con1<-axis[index1,]
    index2=c(rownames(axis)==strcon2)
    coordinate_con2<-axis[index2,]
    dis_con1_con2<-distance(coordinate_con1,coordinate_con2)
    dis<-c(dis,dis_con1_con2)
  }
  return(dis)
}




Get_mcia_distance<-function(profile1,profile2,input_pathway){
  data_random<-list(GROUP1=profile1,GROUP2=profile2)
  type_random<-colnames(data_random$GROUP1)
  mcoin_random<-mcia(data_random)
  # plot(mcoin_random)
  axis_random<-mcoin_random$mcoa$Tli

  #######compute distance between pathways

  list=list()
  list[[1]]=Input_group('GROUP1','GROUP2',axis_random,input_pathway)


  return(list)
}






requireNamespace('parallel')
Compute_distance_onethousand_times<-function(real_profile1,real_profile2,input_pathway){

   ########### real part
   dis_real=Get_mcia_distance(real_profile1,real_profile2,input_pathway)
   print('real done')
   ########### random part
   dis_random_all<-list()
   for(i in 1:length(dis_real)){
     dis_random_all[[i]]=data.frame()
   }
   cl <- makeCluster(4)
   for(i in 1:999){
    print('random start')
    print(i)
    group_one_random<-random_profile(real_profile1,input_pathway)
    group_two_random<-random_profile(real_profile2,input_pathway)

    print('random done')
    dis_random<-Get_mcia_distance(group_one_random,group_two_random,input_pathway)
    for(j in 1:length(dis_random)){
      dis_random_all[[j]]<-rbind(dis_random_all[[j]],dis_random[[j]])
    }
   }
   stopCluster(cl)


  dis_combined=list()
  sig_path=list()
  for(i in 1:length(dis_real)){
    dis_combined[[i]]<-rbind(dis_random_all[[i]],dis_real[[i]])
    colnames(dis_combined[[i]])=input_pathway

    ########## compute p-value
    pvalue_pathway<-c()
    for(j in 1:length(input_pathway)){
      sig_count=length(dis_combined[[i]][,j][dis_combined[[i]][,j]>=dis_combined[[i]][1000,j]])
      pvalue=sig_count/1000
      pvalue_pathway<-c(pvalue_pathway,pvalue)
    }

    ########## get significant pathway
    pathway_pvalue<-data.frame(pathname=input_pathway,pvalue=pvalue_pathway)
    significant_pathway<-pathway_pvalue[pathway_pvalue[,2]<=0.05,]
    sig_path[[i]]=list(pathway_pvalue,significant_pathway)  ## contain all pathway and sig_pathway
  }

  return(sig_path)
}






pathway=pathway_info[[1]]
result=Compute_distance_onethousand_times(profile1,profile2,pathway)
stopCluster(cl)
return(result)
}








































