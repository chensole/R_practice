rm(list = ls())
library(tidyverse)

#################　函数式编程　############################
#purrr package
library(purrr)
###### map family ############
## map -> return a list
## 但是对于简单的数据结构返回一个列表反而不方便，因此有以下四个map家族函数
# map_chr() -> return a character vector

mp <- map_chr(mtcars,length)
#attr(mp,"names")=NULL  
# map_lgl() -> always returns a logical vector
map_lgl(mtcars,is.double)
# map_int() -> always returns a integer vector
map_int(mtcars,length)

# map_dbl() -> always returns a double vector
map_dbl(mtcars,mean)

#map is equivlent to the lapply function

map(mtcars,length)  

lapply(mtcars,length)


#All map functions always return an output vector the same length as the input
#当每次函数返回结果不是一个单一的值时，将会报错，推荐使用map,map可以是任何形式的输出

pair <- function(x) {
  c(x,x)
}

map_dbl(1:2,pair)  #failure


map(1:2,pair)


x <- list(
  list(-1, x = 1, y = c(2), z = "a"),
  list(-2, x = 4, y = c(5, 6), z = "b"),
  list(-3, x = 8, y = c(9, 10, 11))
)

# easy to extract the complicated list
#by list name
map_dbl(x,"x")

#by position
map_dbl(x,1)

# a list to select by both name and position   
map_dbl(x,list("y",1))
#map_dbl(x,list(3,1))


# You'll get an error if a component doesn't exist:
map_chr(x, "z")  

# Unless you supply a .default value
map_chr(x, "z", .default = NA)  

#默认情况下,map的第一个参数作为作为function的第一个参数，如果某些情况下要想实现对函数的非第一个参数进行运行
#例如，想实现对一组数不同的trim后的平均值的计算
trims <- c(0, 0.1, 0.2, 0.5)
x <- rcauchy(1000)
#The simplest technique is to use an anonymous function to rearrange the argument order

map_dbl(trims,function(trims) mean(x,trim = trims))
#you can take advantage of R’s flexible argument matching rules 
map_dbl(trims,mean,x=x)

x <- list(
  list(1, c(3, 9)),
  list(c(3, 6), 7, c(4, 7, 6))
)

triple <- function(x) x * 3
map(x,map,.f = triple)

triple(unlist(x))
triple(unlist(map(x,list(2,1))))    


# function ----------------------------------------------------------------


# 当你想复制粘贴一个代码块多次时，考虑使用函数，可以提高效率和避免发生错误

both_na <- function(x,y) {
  if (length(x) != length(y)) {stop("is not")}
  re <- c(which(x %in% NA),which(y %in% NA)) 
  return(re)
} 
both_na(c(1:2,NA),c(NA,1:2))

# 给函数添加注释 快捷键 ctrl + shift +R


# conditions

 c(1:10) == 2
  identical(c(1:10),1:10)
  any(c(TRUE,FALSE))
  all(c(TRUE,FALSE))

  # 你能结合多个条件表达式(|| &&)
  # || 和 && 只返回一个TRUE 或者 FALSE ,不能使用 & 和 |，这两个返回的多个逻辑值
  df <- 1
  if (df < 3 && df >0 ) {
    print("better")
    
  }

  # 如果你有一个逻辑向量，可以使用 any 或者 all 合并为单一的逻辑值
  # any 只要有一个TRUE，则返回TRUE
  any(TRUE,FALSE)
  
  # all 判断是否所有都为TRUE
  all(TRUE,TRUE)
  
  # == 操作符返回向量化结果，注意使用
  # 不要使用 x == NA , 不起任何作用
  
  # multiple conditions
  
  if (...) {
    
  }else if () {
    
  }else {
    
  }
  temp <- seq(-10, 50, by = 5)
  
  # cut 也可以替代多个ifelse 
  cut(temp, c(-Inf, 0, 10, 20, 30, Inf),
      right = TRUE,
      labels = c("freezing", "cold", "cool", "warm", "hot")
  )
  

# 要养成检查函数重要的先诀条件，如果不满足条件则报错，stop
  we_mean <- function(x,w) {
    if (length(x) != length(w)) {
      stop("wrong",call. = F)
    }
    sum(x * w)/sum(w)
    
  }

  we_mean(c(1,2,3),c(0.1,0.8,0.1))

  
# return 和perl 中一样默认返回最后一个语句的输出，但是你也可以自定义输出通过return
  

  

# vector ------------------------------------------------------------------

# every vector have two key properties
  # 1. type 
  vec <- 1:10
  
  typeof(vec)  
  
  # 2. length
  
  length(vec)

# 向量也能增加任意其他属性创建增强向量，附加其他行为
  
  # 三个主要的类型
   # 1. factor (建立在整数向量之上)
   # 2. data-time and Dates (建立在数字向量上)
   # 3. data_frame and tibble (建立在list上)
  
  

  # atomic vector -----------------------------------------------------------

  #1. logical
  
    # The most simplest type (only three values) : TRUE FALSE NA
    # 通常由比较操作符构建
  
  #2. numeric
  
  # contain integer and double (在R 中，数字默认时double)
  
  # to make an integer ,place an L after the number
  typeof(2)
  typeof(2L)
  
  # 整形有一个特殊的值是NA,然而double有四个: NA NaN Inf -Inf,后面三个是除法过程产生的
  
  
  w <- c(1,0,-1)/0

  # 避免使用 == 操作符检查这些的值
  is.finite(w)
    
  is.infinite(w)   
  
  is.nan(w)
  
  is.na(w)  

  # 3. character
  x <- "hah ah"
  length(x)
  
  str_length(x)
  
  # 4. missing value
    
    # 每一个原子向量都有对应的缺失值
    
    NA  # logical
    
    NA_integer_  # integer
    
    NA_character_ # character
    
    NA_real_  # double
    

# using the atomic vector
    
  # 转换
    # 显示转换 : as.logicla() ...
    # 隐式转换 : 根据上下文发生转换，如在数值运算中使用逻辑向量
    
    # 在一些代码中经常能够看到隐式转换
    if (length(x)) { # from the integer to logical, 0 -> FALSE; other -> TRUE
      
    }
    
  # scalar and recycling rules
    # 短的向量会自动补齐至长变量相同的长度(recycling rule)
    # 这个规则对于混合“标量”和向量很有用(R 中其实没有标量这一概念，一个单一数字实际上是长度为1的vector)
    
  
    # 当短向量和长向量的长度不是整数倍关系时，将会报错
    
    1:10 + 1:3

    
  # Naming vector
    # most useful for subsetting
    c(x=1,y=2,z=3)
    
    
  # subseting 
    # '[' function
    
    # 1. number vector at position
    
    # 2. logical vector (比较操作符)
    
    # 3. character (used for named vector)
    

# list --------------------------------------------------------------------

 # list 是原子向量复杂性的体现
   li <- list(1,2,3)
  
   str(li)    
    
   # list是个大杂烩
   li1 <- list(1,"a",TRUE,NA)
   str(li1)
   
   # 可以包含其他list (和perl 中的哈希有一拼)
   li2 <- list(list(1,2,2),list("a",TRUE))
   str(li2)   

   # subset
   # '['  返回一个list
   # '[[' 返回的是向量
   # '$'  通过list中的named element
   
   
# Augmented vectors
   
   # 1. factor (分类数据)
   
   x <- factor(1:3,levels = c(3,1,2))
   x   

   # 2. dates and data-times
   
   x <- as.Date("1971-01-01")
   class(x)
   
   # unclass 去除对象的类
   x <- unclass(x)      
   class(x)   
   

# Iteration ---------------------------------------------------------------
library(tidyverse)
# for loop have three components
   df <- tibble(
     a = rnorm(10),
     b = rnorm(10),
     c = rnorm(10),
     d = rnorm(10)
   )
   
  output <- vector("double",length = ncol(df))
  for (i in seq_along(df)) {
    output[[i]] <- median(df[[i]])
    
  }
   
  # for循环前需要先分配一个内存空间给输出结果,这样会明显提高效率，
  # 通常是预定义一个长度已知的空vector,使用vector函数
  
  # 迭代向量，对向量索引迭代，使用seq_along(vector),比1:length(vector)更好
  
  # 使用for loop 修改存在的对象
    set.seed(123)
    df <- tibble(a = rnorm(100),b = runif(100))
    df 
   
    scale <- function(x) {
      sd <- sd(x)
      mean <- mean(x)
      (x - mean) / sd
    }
    
    for (i in seq_along(df)) {
      df[[i]] <- scale(df[[i]])
      
    }
    
    # 推荐使用[[]],可以更好的说明你想操作的是data.frame的单个元素
    
  # loop patterns
    # 通常都是按照索引来进行迭代
    # 迭代元素的名字 for (i in names(xxx))
    
  #  不知道输出结果的长度
    # 可以预定义一个list
    # unlist将list向量转换为原子向量
    
    # str_pad 空格处理
      str_pad("hello",10,pad = ">")
      
      
    show_mean <- function(df, digits = 2) {
      # Get max length of all variable names in the dataset
     
      
      maxstr <- max(str_length(names(df)))
      for (nm in names(df)) {
        if (is.numeric(df[[nm]])) {
          cat(
            str_c(str_pad(str_c(nm, ":"), maxstr + 1L, side = "right"),
                  format(mean(df[[nm]]), digits = digits, nsmall = digits),
                  sep = " "
            ),
            "\n"
          )
        }
      }
    }
    
    
    show_mean(iris)
    
    # R 中for循环不像其他函数那样重要，通常把for loop 写进函数中去而不是直接使用for loop
      #rm(list = ls())
    # 在R中将一个函数写进另一个函数中非常有用(闭包)  
    df <- tibble(
      a = rnorm(10),
      b = rnorm(10),
      c = rnorm(10),
      d = rnorm(10)
    )
  
    fun <- function (df,fc) {
      output <- vector("double",length = length(df))
      for (i in seq_along(df)) {
        output[[i]] <- fc(df[[i]])
        
      }
      
      return(output)
    }    
    
    fun(df,mean)    
    

# Purrr -------------------------------------------------------------------
  # 使用map family function 不是因为速度，而是因为map 可以让代码更加易读
    map_dbl(df,mean)

  # use pipe
    df %>% map_dbl(mean)
    
    df %>% map_dbl(mean,trim = 0.2)    
    
    models <- as.data.frame(mtcars) %>% split(.$cyl) %>% map(function(df) lm(mpg ~ wt,data = df))
    
    # ~ 匿名函数的简写
    models %>% map(summary) %>% map_dbl(~.$r.squared)
    
    
    # 通过名称可以直接获取数据
    models %>% map(summary) %>% map_dbl("r.squared")

    # 也可以获取子元素
    x <- list(list(1, 2, 3), list(4, 5, 6), list(7, 8, 9))
    x %>% map_dbl(2)
    
    
    
  # 处理失败
    # 在map 循环遍历时，一旦有一个失败，则不会返回output，那么这个对于我们解决问题增加了难度
    # 当函数成功时，result元素包含结果，error元素是NULL。
    # 当函数失败时，result元素是NULL，error元素包含一个错误对象
    safe_log <- safely(log)
    str(safe_log(10))
    
    safe_log("a")    
    
    # safely is designed to work with map
    
    x <- list(1, 10, "a")
    z <- x %>% map(log)
        
    # use safely
    z <- x %>% map(safely(log))
    
    
    # 还有另一个transpose 函数，将返回results 和 fail的两个list
    
    z <- z %>% transpose()
    str(z)

    
    # 检查错误
    
    is_ok <- z$error %>% map_lgl(is_null)
    x[!is_ok]

    
  # map 接收多个参数
    
    # 生成均值不同的随机数(map只需要接收mu一个输入)
    mu <- list(3,5,8)
    mu %>% map (rnorm,n = 5)
    
    # 若要生成均值和标准差均不同的随机数，那么map要同时接收mu和sd
    sigma <- c(1,5,10)
    
    seq_along(sigma) %>% 
      map(~rnorm(mu[[.]],sigma[[.]],n = 5))

    # 对于上面的代码可以实现我们想要的，但是使用map2则更加方便
    map2(mu,sigma,rnorm,n = 5)

    # 以此类推，我们可以创造map2,map3 etc...,在purrr包有个pmap,将接收一个参数列表
    li <- list(mean = c(3,5,8),sd = c(2,4,6),n = c(1,2,5))
    
    li %>% pmap(rnorm)    

    
    # 调用不同函数
    f <- c("runif","rnorm","rpois")
    parm <- list(
      list(min = -1,max = 1),
      list(sd = 5),
      list(lambda = 10)
    )    
    
    invoke_map(f,parm,n = 5)

    
    # 谓词函数
    # 这类函数返回TRUE或FALSE
    
    # 输出数据框中为factor的变量 keep
    iris %>% keep(is.factor)

    # 过滤数据框中为factor的变量 discard
    iris %>% discard(is.factor) %>% str()
    

    # some 和 every检查谓词函数检测的元素是部分为TRUE,还是每一都为TRUE
    
    x <- list(1:5,letters,list(10))
    
    x %>% some(is.character)
    x %>% every(is.character)    
    
    x %>% every(is.vector)

    # detect 返回谓词函数第一个为TRUE的元素  
    
    x %>% detect(is.character)
    
    # detect_index 返回第一个为TRUE的索引位置
    x %>% detect_index(is.character)

  # Reduce 和 accumulate
    # 由多个数据框组成的list，对于每两个数据框，基于name变量合并，直到最后一个数据框
    dfs <- list(
      age = tibble(name = "John", age = 30),
      sex = tibble(name = c("John", "Mary"), sex = c("M", "F")),
      trt = tibble(name = "Mary", treatment = "A")
    )
   
  # first ways 
   dfs[[1]] %>% full_join(dfs[[2]]) %>% full_join(dfs[[3]])
   
  # second ways
   reduce3 <- function(f,x) {
     out <- x[[1]]
     for(i in seq(2,length(x))) {
       out <- f(out,x[[i]])
     }
     out
   }
   reduce3(full_join,dfs)
      
   # 上述操作比较繁琐，可用 Reduce 替代
   
   dfs %>% reduce(full_join)
  
   # 找出vector中的公共元素
   vs <- list(
     c(1, 3, 5, 6, 10),
     c(1, 2, 3, 7, 8, 10),
     c(1, 2, 3, 4, 8, 9, 10)
   )
  
   reduce3(intersect,vs)
   
   # reduce对于在List中重复运用某个函数直到最后一个元素非常有用，避免了大量的代码和时间
   vs %>% reduce(intersect)
   

   
  # 注：reduce 接受的是一个二元函数，即该函数只接收两个参数
   
   vn <- 1:10
   vn %>% reduce(`+`)  # 累加
   
   
   # accumulate则会输出中间运行结果
   
   vn %>% accumulate(`+`)
   
   
   
   