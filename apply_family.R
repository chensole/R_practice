############<<<<<<<<<<< apply family >>>>>>>#################

##make a matrix
  
  arr=array(rnorm(20,10,2),dim = c(4,5))
  arr
#######apply函数（用于数组和矩阵）
  apply(arr,1,mean)
  apply(arr, 2, mean)
###apply对矩阵每一个元素进行变化,margin=2,若margin=1,返回转置矩阵
  apply(arr,2,FUN =function(x){
    (x^2)
  })

##重现scale函数
  scale(arr,center = T,scale = T)
##自定义函数实现
  ##向量=列向量
  ##矩阵与向量运算，向量作为列向量，从矩阵第一列开始，矩阵的每一列向量与该向量运算
  amean=apply(arr, 2, mean)
  asd=apply(arr, 2, sd)
  myfun=function(x){
    t((t(x)-amean)/asd)
  }  
  myfun(arr)

  
#######spply和lapply函数（用于data.frame和列表）  
  ##数据集是一个向量或矩阵对象,那么直接使用lapply就不能达到想要的效果了,需要将其转为data.frame和list
  ##sapply函数是一个简化版的lapply，sapply增加了2个参数simplify和USE.NAMES
  ##如果simplify=FALSE和USE.NAMES=FALSE，那么完全sapply函数就等于lapply函数了
  vec=c(1:5)
  sapply(vec,FUN = function(x){
    x^2
  })
  lapply(vec, function(x) x^2)
  #不能直接用于数组要将其转化为data.frame或者List
  sapply(as.data.frame(arr),mean)
  sapply(as.data.frame(arr),mean,simplify = F,USE.NAMES = F)   # 等价于 lapply
  lapply(as.data.frame(arr),mean)
  #######tapply函数（用于向量数据分组计算）
  tapply(iris$Petal.Length,iris$Species,mean)
 
  
  #######mapply函数（类似多变量的sapply）
  x1=c(1:5)
  x2=c(6:10)
  sapply(as.data.frame(rbind(x1,x2)),sum)
  mapply(sum,x1,x2)
  
## --------------Reduce function -------------------
  #reduce() 是对双参数函数进行拓展的强大工具
  
  Reduce(sum,1:3) 
  #equal to 
  sum(sum(1,2),3)
  
  #reduce function simple explain
  reduce2 <- function(f,x) {
    out <- x[[1]]
    for (i in seq(2,length(x))) {
      out <- f(out,x[[i]])
    }
    out
  }
  
  #reduce parameters
  
  #init (定义初始值)
  Reduce(sum,1:10,init = 2)
  Reduce(sum,1:10,init = 0)
  
  #accumulate(输出中间结果值)
  Reduce(sum,1:10,init = 2,accumulate = T)
  
     