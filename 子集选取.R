rm(list=ls())
##########>>>>>>$ 符号注意事项
###常见错误，知道数据框某列的名字，但这个名字存储在变量中，如果$后面使用变量就会出错
df=data.frame('a'=c(1:3),
              'b'=letters[1:3])
var="a"
df$var
##########>>>>$ 和 [[ 有一点非常重要的不同。$是部分匹配

x=list(abc=1)
x$a   ##可返回结果
x[["a"]]  ##无法返回结果

mod=lm(mpg~wt,data = mtcars)
str(mod)
mod$residuals
su=summary(mod)
str(su)
su$r.squared

######>>>>>子集选取
#子集选取时使用空引号和赋值操作会比较有用，因为会保持原有对象类和数据结构
mtcars[]=lapply(mtcars,as.integer) 
mtcars=lapply(mtcars,as.integer)

##对于列表可用子集选取加赋值NULL来去除列表中的元素

#####>>>展开重复记录
##先建立重复行的索引，再用子集选取将重复记录展开
rm(list = ls())
df=data.frame(x=c(2,4,1),
              y=c(9,11,6),
              n=c(3,5,1))

df[rep(1:nrow(df),df$n),]

######删除数据框中某些列
＃first way
  df$y=NULL
#second way
  df[c("x","y")]

#third way
  df[setdiff(names(df),"n")]

  ##setdiff是一种集合运算，两集合不共有的子集
    setdiff(1:3,1:2)
#####根据条件选取行（逻辑子集）----->最常用的技术
    
    mtcars[mtcars$gear==5,]
    mtcars[mtcars$gear==5 & mtcars$cyl==4,]

#####subset 是对数据框进行子集选取的专用简写函数
    subset(mtcars,gear==5)
    subset(mtcars,gear==5 & cyl==4)
    
#####布尔代数与集合
    #which 可将布尔转换成整数表示
    which(c(F,F,F,T,T,F))
    x=sample(10)<4
    which(x)
###同时对行和列进行重排
    df[sample(nrow(df),nrow(df)),sample(nrow(df),nrow(df))]
####随机抽取行 
    mtcars[sample(nrow(mtcars),3),]
    rep(1:2,each=3)

        