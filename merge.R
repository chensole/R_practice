  #----------merge-----------------------
 
   dat1=data.frame("a"=c("a","b","c"),
                  "b"=c(4:6))  
   dat2=data.frame("e"=c("e","b","b"),
                  "b"=c(1:3))   
  
  
  #first 
  #by指定合并两个数据的公共列
  #列名相同时，默认情况情况下，by.x，by.y 都等于by，直接定义by即可
    dat=merge(dat1,dat2,by="a") #合并公共ａ列具有的行（inner匹配）   
    dat

  #当列名不同时，可以直接更改by.x和by.y的值
    dat=merge(dat1,dat2,by.x = "a",by.y = "e")
    dat

  #all指定合并结果的输出方式
  #默认情况，all.x，all.y 都等于all，而all = FALSE，
  #所以结果只会显示x，y这两个数据框中指定列中的相同内容的整理结果
    
    dat=merge(dat1,dat2,by.x = "a",by.y = "e",
              all = F)
    dat
  #all.x=T 显示ｘ中不能匹配的数据
    dat=merge(dat1,dat2,by.x = "a",by.y = "e",
              all.x = T)
    dat      


  #all.y=T 显示ｙ中不能匹配的数据
    dat=merge(dat1,dat2,by.x = "a",by.y = "e",
              all.y = T)
    dat

  #y中有多个可以和ｘ中匹配，结果行数将变化  
    dat=merge(dat1,dat2,by.x = "a",by.y = "e",
              )
    dat
    
    
    
    
    