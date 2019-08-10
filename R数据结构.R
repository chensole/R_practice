######>>>>>>>>>数据结构<<<<<<<<<<<<<<<<<<<<<<<

vec=c(1:5)
#####check vector type

typeof(vec)
  
###IS function 
  is.character(vec)
  is.vector(vec)  
  is.double(vec)  
  is.numeric(vec)  
  

#####>>>change type
  
  as.double(vec)
  as.character(vec)  
  as.list(vec)  #####将向量中每一个元素变成列表中每一个元素
  list(vec)     #####将向量总体变成列表中的一个元素
  

#####>>>>>>属性<<<<<<<<<<<<<
  

#####查看属性
  y=c(1:10)
  attributes(y)  ####view all attributes
  
#####增加属性(name,dimension,class三个是固有属性)
  attr(y,"my_attributes")<-"this is the vector"
  attributes(y)
  
#####查看增加或修改的属性
  attr(y,"my_attribute")  ###view one attributes
  y=as.vector(y)  ###as.vector 可以去除任何附加的属性
  
######命名向量中的元素
  #first way
  x=c(a=1,b=2,c=3)
  
  #second way
  z=1:3
  names(z)=c('a','b','c')  
  
  #third way
  x=setNames(1:3,c("a","b","c"))
  
####remove names of vector
  ##first
  names(x)=NULL
  
  ##second
  z=as.vector(z)
  
  
### practice
structure(1:5,comment="my_attribute")  

f2=factor(letters)  
levels(f2)=rev(letters)  


f2=rev(factor(letters))
f2
f3=factor(letters,levels = rev(letters))
f3



#######>>>>>>>>>>>matrix and array

##给原子向量添加dim属性就形成多维数组


a=c(1:6)
dim(a)=c(2,3)

####vector to array or matrix

b=c(1:6)
as.matrix(b) ###按列填充
as.array(b)  ###按行填充 (行向量)

#########data.frame --------- combine list and matrix

df=data.frame(x=1:3,y=c("a","b","c"))
str(df)
attributes(df)

###change data.frame to list
####data.frame是一种特殊的List,将list增加了class属性为data.frame

class(df)=NULL
df

df=list(x=1:3,y=c("a","b","c"))
df


#####data.frame 默认将字符串变成因子，防止这种转换用下面的代码
rm(list = ls())

df=data.frame(a=1:3,y=c("a","b","c"),stringsAsFactors = F)
str(df)
attributes(df)

######判断对象是不是数据框使用class() 或者is.data.frame()
typeof(df)
class(df)
is.data.frame(df)

####as.data.frame >>>>>>convert object to data.frame
####向量将创建一列的数据框
  as.data.frame(c(1:3))
####列表将为每个元素创建一列
  as.data.frame(list('a'=1:3,'b'=c(2:4)))

####矩阵将创建一个相同行数和列数的数据框
  as.data.frame(matrix(1:9,3))
####数组同样适用
  as.data.frame(array(1:10,c(2,5)))


###数据框一列由列表组成
  
  df=data.frame(x=1:3)
  df$y=list(1:2,1:3,1:4)
  df
  
  ####当对列表使用data.frame时会将列表中的每个元素都放入自己的列表中
  data.frame(x=1:3,y=list(1:2,1:3,1:4))
  data.frame(x=1:2,y=list(1:2,1:2,1:2))
  ##use I() function
  data.frame(x=1:3,y=I(list(1:2,1:3,1:4)))
  
  #####数据框中某一列为矩阵，同样使用I函数
  
  dfm=data.frame(x=1:3,y=I(matrix(1:9,nrow = 3)))
  dfm
  str(dfm)
  
#####合并数据框
  df=data.frame(x=1:3,y=c('a','b','c'))
  cbind(df,data.frame(z=3:1))
  rbind(df,data.frame(x=10,y="z"))
###cbind不能将向量合并成数据框，创建的是矩阵，可直接使用data.frame组建向量成数据框
  
# -- 常见数据结构
  
  ############<<<<<<<<<<< list >>>>>>>#################
  
  #create a list
  my_list=list(a=c(1:5),
               b=c("wang","li","zhang","sun","wu"),
               d=c("n","n","y","y","n"),
               e=matrix(c(1:100),ncol=10),
               f=mtcars)
  #view list 
  str(my_list)
  #pick one sub list
  my_list[["a"]]
  my_list$a
  
  #rename list name
  names(my_list) <- c("one","two","three","four","five")
  my_list
  
  ############<<<<<<<<<<< vector >>>>>>>#################
  ##make vector
  vec=c(1:5)
  seq_v=seq(1,10,by=2)
  rep_v=rep(1,7)
  ##make logical vector
  logi=seq_v >7
  ##add elements to old vector
  vec1=c(vec,9:18)
  vec1
  

  ##get element from vector
  vec1[1:6]
  
  
  ############<<<<<<<<<<< matrix >>>>>>>#################
  
  ##change vector into matrix
  dim(vec1)=c(5,3)
  vec1   
  ##two methods generate matrix
  ##first (matrix equal to two dimentation array)
  mat1=array(c(1:10),dim = c(2,5),dimnames = list(dim1=c("a","b"),
                                                  dim2=c("c","d","e",
                                                         "f","g")))
  
  mat1
  ##second
  mat2=matrix(c(1:10),nrow = 2,ncol = 5)
  
  #vector function create list
  vector(mode = "list",length = 10)
  
  #numeric function create vector
  numeric(length = 20)
  
  
  #简化和保留
  #子集选取时要注意最后的子集是否还保留着原来的数据结构
  
  
  #vector
  v <- c(1:3)
  names(v) <- letters[1:3]
  #简化
  v[[1]]
  
  #保留 (向量名字会保留下来)
  v[1]
  
  #list
  li <- list('x' = 1:5,
             'y' = sample(1:5,3)) 
  #简化
  li[[1]]
  
  #保留
  li[1]
  
  #因子
  fv <- factor(c('a','c','b','w'),
               levels = c('a','b','c','w'))
  
  #简化
  fv[1:2,drop = T] #扔掉不需要的因子水平
  
  #保留
  fv[1:2]
  

  #array
  
  ay <- array(1:20,dim = c(4,5))
  
  #简化(抛弃长度为１的维度)
  ay[1,]
  
  #保留
  ay[1, , drop = F]
  
  
  #data.frame
  
  df <- data.frame('a' = 1:10,
                   'b' = 2:11)
  #简化
  df[,1]
  
  #保留
  df[,1,drop = F]
  df[1]  
  
  
  
  
  

