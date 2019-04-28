############ dplyr 使用 ###################

rm(list = ls())
library(tidyverse)

# convert the data.frame to tibbles

as_tibble(iris)

# create a new tibble object
# tibble 不会将字符串转化为因子
tib <- tibble('x' = 1:3,
              'y' = letters[1:3],
              'z' = seq(1,5,2))

# Tibbles vs. data.frame
# 1. print
nycflights13::flights %>% 
  print(n = 10, width = Inf)

# 2.subset (use pipe is more easy)
nycflights13::flights$year

# 使用占位符 . 代表管道符前面的数据
nycflights13::flights %>% .$year
nycflights13::flights %>% .[['year']]

#is_tibble(nycflights13::flights)



table1
table1 %>% mutate(rate = cases/population*10000)

# count function 
# if wt omitted ,will count the number of rows
table1 %>% count(year)
# if wt specified,will sum the values of varibale wt
table1 %>% count(year,wt=cases)

data <- nycflights13::flights

# 通过含有列名的原子向量访问数据框
variable <- "year"

# data$variable    $后面不能接其他变量

data[[variable]] # 可以使用[[ 操作符

# 使用match
INDEX <- match(variable,colnames(data))
data[,INDEX] # 保留
data[[INDEX]] # 简化


df <- as.data.frame(data)
df[[variable]]
fa <- as.factor(table1$year)
# ggplot 绘图时注意要将分组信息(分组颜色和线型等)包含在aes映射中去
ggplot(data = table1,mapping = aes(x=year,y=cases)) +
  geom_point(aes(group=country,color=country)) + 
  geom_line(aes(group=country),color="blue")

ggplot(data = table1,mapping = aes(x=year,y=cases,group=country)) +
  
  geom_line(aes(group=country),color="blue") +
  geom_point(aes(color=country)) 




##################### 数据转换 ############################
# 当我们用R处理数据时，应该遵循Tidy data的原则，每一行代表一次观测，每一列代表一变量

# gather  (make the data narrower and longer)
# 将列变量转为行观测值
# gather more columns(not variable) into one variable
# gather (key=定义新变量名，value=定义观测值所在的列名，非变量列名(需要转化的列名))
# 在指定要转换的列名时，也可以不用列名，直接指定列的编号，若转换列较多，也可用-号指定不需要转换的列名  
tidy4a <- table4a %>% gather('1999','2000',key = "year",value = "cases")


table4b$a = rep(1,nrow(table4b))
tidy4b <- table4b %>% gather(key = "year",value = "population",'1999','2000')    

left_join(tidy4a,tidy4b)
# 等价于 merge,相对来说left_join 比较方便
merge(tidy4a,tidy4b,by=c("country","year"))   



# spreadb (make the data wider and shorter)
# spread(key=自定义列变量名，value=含有多个变量value的列名)
# spread 只有两个参数，key ,value,将tidy格式数据还原
# 将行观测值转为列变量，让数据变短，变宽
table2 %>% spread(key = type,value = count)


spread(year, return) %>% 
  gather("year", "return", `2015`:`2016`)

# 注意gather第一个参数代表的是列的索引，或者列名(列名需要加引号，不加引号则出错)
table4a %>% 
  gather(1999,2000,key = "year", value = "cases")

# 直接使用列的索引
table4a %>% 
  gather(2,3, key = "year", value = "cases")


annoying <- tibble(
  `1` = 1:10,
  `2` = `1` * 2 + rnorm(length(`1`))
)
annoying %>% .$`1`
annoying$`1`    
with(annoying,plot(`1`,`2`))    

annoying <- annoying %>% mutate(`3`=`2` / `1`)

# rename(替换后的名字 = 替换前的名字)    
annoying %>% rename("one"= `1`,
                    "two"= `2`,
                    "three"= `3`)    

# enframe 
# convert named atomic vectors or list to one- or two-column data frame
a <- 1:10
names(a) <- letters[1:10]
enframe(a)

li <- list('x'=1:10,
           'y'=1:5)
le <- enframe(li)    



table3

# if a single variable is spread across multiple columns

# separate function can  divide one column into more columns
# 默认以非 字母(数字+单词) 为分割符
table3 %>% separate(col = rate,into = c("cases","population"))

# 可以通过sep 参数指定分隔符 sep 接正则表达式
# 默认分隔出来的列数据类型是 chr,若本来是数值类型，则需要加conovert 参数
table3 %>% separate(col = rate,into = c("cases","population"),sep = "/")

table3 %>% separate(col = rate,
                    into = c("cases","population"),
                    sep = "/",
                    convert = T,
                    remove = T)

# sep 也可等于一个整型向量，指代分隔的位置，1表示最左边，-1表示最后一个

table3 %>% separate(col = year,
                    into = c("a","b","c","d"),
                    sep = c(1,2,3)) # 注意向量长度比into 长度小 1

# unite is the inverse of separate
# combine more columns into one column

# default, combine more column with the underscore
table5 %>% unite("new",c("century","year"))

table5 %>% unite("new",c("century","year"),sep = "")


####################### Missing value #############################
### there are two types missing value
# 1. 用NA 表示的缺失值 (明显能看出的)
# 2. 不存在数据中的缺失（不能明显的看出）

stocks <- tibble(
  year   = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
  qtr    = c(   1,    2,    3,    4,    2,    3,    4),
  return = c(1.88, 0.59, 0.35,   NA, 0.92, 0.17, 2.66)
)

# make implict value explict
stocks %>% spread(key = year,value = return)

stocks %>% spread(key = year,value = return) %>% gather(key = year,value = count,'2015','2016',na.rm = T)
gather    

stocks %>% 
  spread(year, return) %>% gather(`2015`,`2016`,key = "year",value = "return")

# another import tools make missing values explicit
# takes a set of columns, and finds all unique combinations,找到所有输入列的组合
stocks %>% complete(year,qtr)


## 还有一种情况就是对于数据录入员来说，有时候缺失值表示与之前值相同故而省略
# 对于这种函数，大神又构建了fill function

treament <- tribble(
  ~person, ~treament, ~response,
  "Derrick Whitmore",1,7,
  NA,2,10,
  NA,3,7,
  "Katherine Burke",1,4
  
)

treament %>% fill(person,.direction = "up")

who1 <- who %>% gather(key = "key",value = "cases",5:60,na.rm = T) 
who2 <- who1 %>% mutate(key=stringr::str_replace(key,"newrel","new_rel"))

who3 <- who2 %>% separate(col = key,into = c("new","type","sexage"))
who4 <- who3 %>% select(-iso2,-iso3,-new)      
who5 <- who4 %>% separate(col = "sexage",into = c("sex","age"),sep = 1)      

# no-tidy data
# 某些情况tidy data 不一定是最好的数据结构，一些规范是其他类型的数据结构
library(broom)
library(dplyr)
library(tidyr)
library(stringr)
library(readr)

original_data <- read_delim("http://varianceexplained.org/files/Brauer2008_DataSet1.tds", delim = "\t")

dim(original_data)
class(original_data) 
# mutate_each 实现多列转换
original_data <- original_data %>% separate(col = NAME,into = c("name","BP","MF","systematic_name","number"),sep = "\\|\\|") %>% 
  mutate_each(list(trimws), name:systematic_name) %>% 
  select(-number, -GID, -YORF, -GWEIGHT) %>% 
  gather(key = "sample",value = "expression",5:ncol(original_data)) %>% 
  separate(col = "sample",into = c("nutrient","rate"),sep = 1,convert = T)

# do是dplyr包的函数 通常与group_by结合，对每个组进行操作，在为每个组拟合模型时特别有用
# 专用操作函数filter() ， select() ， mutate() ， summarise()和arrange()通用补充，可以实现任意操作
# tidy function 是broom包中对模型结果进行tidy处理的函数
original_data %>% group_by(name) %>% 
  do(fit = lm(expression~rate+nutrient,data = .)) %>% 
  tidy(fit) %>% filter(term == "rate")


expr = original_data %>% 
  select(grep("[0:9]",names(original_data)))  

exprnames = original_data %>%
  separate(NAME, c("name", "BP", "MF", "systematic_name", "number"), sep = "\\|\\|") %>%
  select(systematic_name) %>% 
  mutate_each(funs(trimws),systematic_name) %>% 
  as.matrix()
as.data.frame(expr)
vals = data.frame(vals=names(expr))
pdata = separate(vals,vals,c("nutrient", "rate"), sep = 1, convert = TRUE)
expr = as.matrix(expr)
