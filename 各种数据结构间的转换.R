##########>>>>>>>>>>>>>>change data.frame to list

rm(list = ls())
dat=data.frame('a'=c(1:3),
               'b'=letters[1:3],
               stringsAsFactors = F
               )
######>>>>>>将数据框列作为List中的元素
  #first way
  as_list=as.list(dat)
  #second way
  class(dat)=NULL
######>>>>>>将数据框行作为List中元素
  ##first way
  as_list1=split(dat,1:nrow(dat))
  ##second way
  as_list2=split(dat,dat$a)

#########>>>>>>>>>>>>>>change matrix to list  
  
  mat=matrix(1:9,3)
  ######>>>>>>将矩阵列作为列表中的元素  
  ##first way
  split(mat,col(mat))
  ##second way
  as.list(mat)  ##as.list 作用于矩阵会将矩阵中的每个元素转换成列表中的元素
    ##因此首先将矩阵转化为数据框
    as.list(as.data.frame(mat))
  
  
  ######>>>>>>将矩阵行作为列表中的元素
  #first way
    as.list(as.data.frame(t(mat)))
    
  ##second way
    split(mat,row(mat))
    
    
    
####>>>>>>>>>将列表转换为数据框    
    as.data.frame(as_list)
    
#####>>>>>>>>>将列表转换为矩阵
    as.matrix(as.data.frame(as_list))
    
    
######>>>>>>>>>将列表转换成向量
    as.vector(unlist(as_list))
    
######>>>>>>>>>将数据框转换为矩阵
    as_mat=as.matrix(dat)
    
######>>>>>>>>>将矩阵转换为数据框
    as.data.frame(as_mat)
    
    
    