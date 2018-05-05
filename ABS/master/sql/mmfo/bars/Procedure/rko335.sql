CREATE OR REPLACE PROCEDURE BARS.RKO335(P_dat1 DATE,P_dat2 DATE, P_nls varchar2, p_branch varchar2, p_flag varchar2)
IS
DKON_KV     VARCHAR2(22):=f_DKON_KV(P_dat1,P_dat2);
L_DOC_NOPAY NUMBER(5);
L_OPERTIME  CHAR(4);
L_OPERTIME2 CHAR(4);
okpo_       Char(12);
l_nls       VARCHAR2(14);
l_branch    VARCHAR2(30):=SYS_CONTEXT ('bars_context','user_branch');
l_cnt1      INTEGER;        --К-ство документов на бум. носителе  до опер. времени
l_s1        NUMBER(25);     --Сума документов на бум. носителе до опер. времени
l_cnt2      INTEGER;        --К-ство документов на бум. носителе  после опер. времени
l_s2        NUMBER(25);     --Сума документов на бум. носителе после опер. времени
l_cnt3      INTEGER;        --К-ство документов клиент-банк до опер. времени
l_s3        NUMBER(25);     --Сума документов клиент-банк до опер. времени
l_cnt4      INTEGER;        --К-ство документов клиент-банк после опер. времени
l_s4        NUMBER(25);     --Сума документов клиент-банк после опер. времени
l_cnt5      INTEGER;        --К-ство входящих документов
l_s5        NUMBER(25);     --Сума входящих документов
l_s_all     INTEGER;        --Сума всего
kkk_        number(3);      --Kод Корп.Клиента
OprTime1    CHAR(4);
OprTime2    CHAR(4);
n_tarpak    number(6);      --Номер пакета
BEGIN
   BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE RKO_335';
   END;

FOR k IN (SELECT ACC, BRANCH, NLS
          FROM   ACCOUNTS
          WHERE  NLS like P_nls and KV=980 and DAZS is NULL
            and  ACC in (Select ACC from RKO_LST)
            and branch like decode(p_branch,'Поточне',sys_context('bars_context','user_branch'), p_branch) ||p_flag
          )

 LOOP


------   Определяем kkk_ - Kод Корп.Клиента  
   BEGIN  
     Select r.KODK  Into  kkk_         
     From   RNKP_KOD r, Accounts a
     Where  a.NLS=k.NLS and a.KV=980 and  a.RNK=r.RNK  and  
            r.RNK is not NULL and r.KODK is not NULL and rownum=1;
   EXCEPTION  WHEN NO_DATA_FOUND THEN
     kkk_:=0;
   END;  


------   Определяем ОперВремя: 



IF      gl.amfo = '302076'  then   --  1. Винница 
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'  then   ---- 1) ПФУ  ------

          L_OPERTIME2:='1630';  --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';  --   Обычный день            

   ELSIF  kkk_=2                   then   ---- 2) Укрпошта ---

          L_OPERTIME2:='1600';  --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';  --   Обычный день             

   ELSE                                   ---- 3) Другие кл.
          L_OPERTIME2:='1600';  --   Пятница или ПредПразд.день
          L_OPERTIME :='1600';  --   БАЗОВОЕ опер.время

   END IF;


ElsIf   gl.amfo = '313957'  then   --  2. Запорожье  
------------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'   then  --- 1) ПФУ
   
          L_OPERTIME2:='1630';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
    
   ELSIF  kkk_=2                    then  --- 2) Укрпошта
   
          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
   
   ELSIF  kkk_=5                    then  --- 3) ОблЕнерго

          L_OPERTIME2:='1700';  
          L_OPERTIME :='1700';  
   
          If k.NLS='26008301141401' then
               L_OPERTIME2:='1630';  
               L_OPERTIME :='1630';  
          end if;
   
   ELSE                                   --- 4) Другие кл.

          L_OPERTIME2:='1600';  --   Пятница или ПредПразд.день
          L_OPERTIME :='1600';  --<-  БАЗОВОЕ опер.время
   
   END IF;


ElsIf   gl.amfo = '323475'  then   --  3. Кировоград
-------------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'    then  --- 1) ПФУ
      
          L_OPERTIME2:='1630';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
    
   ELSIF  kkk_=2                     then  --- 2) Укрпошта
   
          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
   
   ELSE                                    --- 3) Другие кл.
   
          L_OPERTIME2:='1500';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1600';   --   Обычный день            
   
   END IF;


ElsIf   gl.amfo = '324805'  then   --  4. Крым
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'          then  --- 1) ПФУ
   
          L_OPERTIME2:='1630';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
    
   ELSIF  kkk_=2                          then  --- 2) Укрпошта
   
          L_OPERTIME2:='1630';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
   
   ELSE                                         --- 3) Другие кл.

          L_OPERTIME2:='1530';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1600';   --   Обычный день            
   
   END IF;


ElsIf   gl.amfo = '325796'  then   --  5. Львов    
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'    then  --- 1) ПФУ
      
          L_OPERTIME2:='1630';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
   
   ELSIF  kkk_=2                     then  --- 2) Укрпошта
   
          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
   
   ELSIF  kkk_=17                    then  --- 3) Укрзалізниця

          L_OPERTIME2:='1645';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1745';   --   Обычный день            

   ELSE                                         --- 4) Другие кл.

          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1600';   --   Обычный день            
   
   END IF;


ElsIf   gl.amfo = '326461'  then   --  6. Николаев    
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ПФУ
      
          L_OPERTIME2:='1630';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
    
   ELSIF  kkk_=2                      then  --- 2) Укрпошта
   
          L_OPERTIME2:='1500';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1600';   --   Обычный день            
   
   ELSE                                     --- 3) Другие кл.

          L_OPERTIME2:='1445';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1600';   --   Обычный день            

   END IF;


ElsIf   gl.amfo = '328845'  then   --  7. Одесса    
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ПФУ
  
          L_OPERTIME2:='1630';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
    
   ELSIF  kkk_=2                      then  --- 2) Укрпошта
  
          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
  
   ELSE                                     --- 3) Другие кл.

          L_OPERTIME2:='1530';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1600';   --   Обычный день            

   END IF;


ElsIf   gl.amfo = '331467'  then   --  8. Полтава  
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ПФУ
      
          L_OPERTIME2:='1630';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
    
   ELSIF  kkk_=2                      then  --- 2) Укрпошта
  
          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
  
   ELSE                                     --- 3) Другие кл.

          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1600';   --<-  БАЗОВОЕ опер.время              
   
   END IF;


ElsIf   gl.amfo = '337568'  then   --  9. Сумы      
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ПФУ
      
          L_OPERTIME2:='1630';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
    
   ELSIF  kkk_=2                      then  --- 2) Укрпошта
   
          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1600';   --   БАЗОВОЕ опер.время              
   
   ELSE                                     --- 3) Другие кл.

          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1600';   --   БАЗОВОЕ опер.время              
   
   END IF;


ElsIf   gl.amfo = '351823'  then   -- 10. Харьков
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ПФУ
   
          L_OPERTIME2:='1630';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
    
   ELSIF  kkk_=2                      then  --- 2) Укрпошта

          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
 
   ELSE                                     --- 3) Другие кл.

         L_OPERTIME2:='1500';    --   Пятница или ПредПразд.день
         L_OPERTIME :='1600';    --   Обычный день            
   
   END IF;


ElsIf   gl.amfo = '353553'  then   -- 11. Чернигов
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ПФУ
      
          L_OPERTIME2:='1630';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
    
   ELSIF  kkk_=2                      then  --- 2) Укрпошта
   
          L_OPERTIME2:='1630';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
   
   ELSIF  kkk_=8                      then  --- 3) ОблГаз
   
          L_OPERTIME2:='1700';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
   
   ELSE                                     --- 4) Другие кл.

          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1600';   --   БАЗОВОЕ опер.время
   
   END IF;

ElsIf   gl.amfo = '305482'  then   -- 12. Днепропетровск   
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ПФУ
   
          L_OPERTIME2:='1630';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
    
   ELSIF  kkk_=2                      then  --- 2) Укрпошта
   
          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
   
   ELSE                                         --- 3) Другие кл.
           
          L_OPERTIME2:='1700';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
   
   END IF;


ElsIf   gl.amfo = '335106'  then   -- 13. Донецк      
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ПФУ
   
          L_OPERTIME2:='1630';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
    
   ELSIF  kkk_=2                      then  --- 2) Укрпошта
   
          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
   
   ELSE                                     --- 3) Другие кл.

          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
   
   END IF;


ElsIf   gl.amfo = '311647'  then   -- 14. Житомир 
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ПФУ
   
          L_OPERTIME2:='1630';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
    
   ELSIF  kkk_=2                      then  --- 2) Укрпошта
   
          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
   
   ELSE                                     --- 3) Другие кл.

          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
   
   END IF;


ElsIf   gl.amfo = '336503'  then   -- 15. Ив-Франк 
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ПФУ
   
          L_OPERTIME2:='1630';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
    
   ELSIF  kkk_=2                      then  --- 2) Укрпошта
   
          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
   
   ELSE                                     --- 3) Другие кл.
           
          L_OPERTIME2:='1700';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
   
   END IF;


ElsIf   gl.amfo = '304665'  then   -- 16. Луганск 
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ПФУ
      
          L_OPERTIME2:='1630';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
    
   ELSIF  kkk_=2                      then  --- 2) Укрпошта
   
          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
   
   ELSE                                     --- 3) Другие кл.

          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
   
   END IF;


ElsIf   gl.amfo = '303398'  then   -- 17. Луцк 
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ПФУ
   
          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
    
   ELSIF  kkk_=2                      then  --- 2) Укрпошта
   
          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
   
   ELSE    
                                            --- 3) Другие кл.
          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
   
   END IF;


ElsIf   gl.amfo = '333368'  then   -- 18. Ровно 
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ПФУ
      
          L_OPERTIME2:='1630';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
    
   ELSIF  kkk_=2                      then  --- 2) Укрпошта
   
          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
   
   ELSE                                     --- 3) Другие кл.

          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
   
   END IF;


ElsIf   gl.amfo = '338545'  then   -- 19. Тернополь
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ПФУ
      
          L_OPERTIME2:='1630';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
    
   ELSIF  kkk_=2                      then  --- 2) Укрпошта
   
          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
   
   ELSE                                     --- 3) Другие кл.

          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
   
   END IF;


ElsIf   gl.amfo = '312356'  then   -- 20. Ужгород 
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ПФУ
   
          L_OPERTIME2:='1630';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
    
   ELSIF  kkk_=2                      then  --- 2) Укрпошта
   
          L_OPERTIME2:='1545';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1645';   --   Обычный день            

   ELSIF  kkk_=5                      then  --- 3) ОблЕнерго
   
          L_OPERTIME2:='1645';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            

   ELSIF  kkk_=8 or kkk_=11           then  --- 4) ОблГаз
                                                --- 5) Тепловики
          L_OPERTIME2:='1700';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';               
   
   ELSE                                     --- 6) Другие кл.

          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
   
   END IF;


ElsIf   gl.amfo = '352457'  then   -- 21. Херсон 
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ПФУ
   
          L_OPERTIME2:='1630';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
    
   ELSIF  kkk_=2                      then  --- 2) Укрпошта
   
          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
   
   ELSE                                     --- 3) Другие кл.

          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
   
   END IF;


ElsIf   gl.amfo = '315784'  then   -- 22. Хмельницкий 
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ПФУ
   
          L_OPERTIME2:='1630';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
    
   ELSIF  kkk_=2                      then  --- 2) Укрпошта
   
          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
   
   ELSE                                     --- 3) Другие кл.

          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
   
   END IF;


ElsIf   gl.amfo = '354507'  then   -- 23. Черкассы 
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ПФУ
      
          L_OPERTIME2:='1630';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
    
   ELSIF  kkk_=2                      then  --- 2) Укрпошта
   
          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
   
   ELSE                                     --- 3) Другие кл.
          
          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
   
   END IF;


ElsIf   gl.amfo = '356334'  then   -- 24. Черновцы 
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ПФУ
      
          L_OPERTIME2:='1630';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
    
   ELSIF  kkk_=2                      then  --- 2) Укрпошта
   
          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
   
   ELSE                                     --- 3) Другие кл.
          
          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            

   END IF;


ElsIf   gl.amfo = '300465'  then   -- 25. ГОУ   
----------------------------------------------------

   ----  Определяем ОКПО Клиента:
   BEGIN
      Select c.OKPO Into okpo_
      From   Accounts a, Customer c
      Where  a.ACC=k.ACC  and  a.RNK=c.RNK and rownum=1;
   EXCEPTION  WHEN NO_DATA_FOUND THEN
      okpo_:='0';
   END;


   IF     okpo_='00035323' or
          kkk_ = 1                 then  --- 1)  ПФУ
   
          L_OPERTIME2:='1630';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
   
   ELSIF  okpo_='21560766'         then  --- 2)  УКРТЕЛЕКОМ

          L_OPERTIME2:='1630';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1730';   --   Обычный день            
   
   ELSIF  okpo_='00100227'         then  --- 3)  УКРЭНЕРГО
   
          L_OPERTIME2:='1545';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            

   ELSIF  okpo_ in ('21560045',          --- 4)  Укрпошта
                    '01181736',
                    '36282474'
                    )        or
          kkk_ = 2                 then
   
          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
   
   ELSIF  okpo_='20077720'         then  --- 5)  НАФТОГАЗ  
   
          L_OPERTIME2:='1630';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1730';   --   Обычный день            
   
   ELSIF  okpo_ in ('04737111',          --- 6)  МППЗТ 
                    '26008588',
                    '04736991',
                    '34292653',
                    '25975458',
                    '34292669',
                    '34425528',
                    '25956299',
                    '04737022',
                    '04737039',
                    '04736940',
                    '34292695',
                    '04737016',
                    '04736956',
                    '34425486',
                    '34425512',
                    '34425533',
                    '34425575',
                    '34425580',
                    '34425562',
                    '04736962',
                    '34292700',
                    '34292681',
                    '34425554',
                    '34292674',
                    '04737008',
                    '34425549',
                    '34425507',
                    '34292721',
                    '34425491',
                    '34292716' 
                   )               then
                    

          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            

   
   ELSIF  okpo_ in ( '00034045',           --- 7)  УкрЗалiзниця  
                     '20078961',
                     '01073828',
                     '01071315',
                     '01072609',
                     '01074957',
                     '01059900' 
                    )              then
   
          L_OPERTIME2:='1645';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1745';   --   Обычный день            

   ELSIF  okpo_='36425142'         then    --- 8)  ГЛОБАЛМАНІ 


          L_OPERTIME2:='1630';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1730';   --   Обычный день            
   
   ELSIF  okpo_='31570412'         then    --- 9)  УКРТРАНСНАФТА 
   
          L_OPERTIME2:='1700';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
   
   ELSE                                    --- 10)  Все другие кл.

          L_OPERTIME2:='1530';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1630';   --   Обычный день            

   END IF;


ElsIf   gl.amfo = '322669'  then   -- 26. Киев 
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ПФУ
      
          L_OPERTIME2:='1630';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
    
   ELSIF  kkk_=2                      then  --- 2) Укрпошта
   
          L_OPERTIME2:='1600';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1700';   --   Обычный день            
   
   ELSE                                     --- 3) Другие кл.
          
          L_OPERTIME2:='1530';   --   Пятница или ПредПразд.день
          L_OPERTIME :='1630';   --   Обычный день            

   END IF;

End If;


--------------------------------------------------------------

---  Определяем НОМЕР ПАКЕТA: 

  BEGIN
     SELECT to_number(VALUE)
     INTO   n_tarpak
     FROM   AccountsW 
     WHERE  ACC = k.ACC
        and TAG = 'SHTAR';

  EXCEPTION WHEN OTHERS THEN
     n_tarpak := 0; 
  END;

---------------------------------------------------------------
---
---      Поиск индивидуального опер.времени по счету
---      ---------------------------------------------

 BEGIN      

   SELECT trim(w.VALUE)
   INTO   OprTime1
   FROM   Accounts a, AccountsW w
   WHERE  a.ACC = w.ACC
      and w.TAG = 'OPTIME1'
      and a.ACC = k.ACC ;

   if OprTime1 is not NULL     and 
      to_number(OprTime1)>=800 and to_number(OprTime1)<=2400 then 

         L_OPERTIME:=OprTime1;   --   Обычный день

   end if;

 EXCEPTION WHEN OTHERS THEN
   null; 
 END;


 BEGIN      

   SELECT trim(w.VALUE)
   INTO   OprTime2
   FROM   Accounts a, AccountsW w
   WHERE  a.ACC = w.ACC
      and w.TAG = 'OPTIME2'
      and a.ACC = k.ACC ;

   if OprTime2 is not NULL     and 
      to_number(OprTime2)>=800 and to_number(OprTime2)<=2400 then 

         L_OPERTIME2:=OprTime2;  -- Пятница или ПредПразд.день

   end if;

 EXCEPTION WHEN OTHERS THEN
   null; 
 END;


BEGIN

---------------------------------------------------------
----  Определяем Кол. бесплатных платежей:
    SELECT NVL(t.doc_nopay,0)
        INTO L_DOC_NOPAY
        FROM tarif_scheme t,
             accountsw w
        WHERE     w.tag = 'SHTAR'
              AND t.id  = w.VALUE
              AND w.acc = k.acc;
    EXCEPTION WHEN OTHERS THEN
        L_DOC_NOPAY:=0; 
    END;
----------------------------------------------------------



If n_tarpak >= 38 then   ------    Бесплатные набираются только из Клиент-Банк  ( IB% и CL% ) !!!
                         ------------------------------------------------------------------------
  BEGIN                  
  SELECT nls,
         SUM (bumdo16),
         SUM (s_bumdo16),
         SUM (bumposle16),
         SUM (s_bumposle16),
         SUM (kbdo16),
         SUM (s_kbdo16),
         SUM (kbposle16),
         SUM (s_kbposle16),
         SUM (vxod),
         SUM (s_vxod),
         SUM (s)
    INTO l_nls,
         l_cnt1,
         l_s1,
         l_cnt2,
         l_s2,
         l_cnt3,
         l_s3,
         l_cnt4,
         l_s4,
         l_cnt5,
         l_s5,
         l_s_all
    FROM (SELECT DISTINCT nls,
                          NVL ( (DECODE (FL, 1, CNT)), 0) bumdo16,
                          NVL ( (DECODE (FL, 1, S)), 0) s_bumdo16,
                          NVL ( (DECODE (FL, 0, CNT)), 0) KBDO16,
                          NVL ( (DECODE (FL, 0, S)), 0) S_KBDO16,
                          NVL ( (DECODE (FL, 3, CNT)), 0) bumPOSLE16,
                          NVL ( (DECODE (FL, 3, S)), 0) S_bumPOSLE16,
                          NVL ( (DECODE (FL, 4, CNT)), 0) KBPOSLE16,
                          NVL ( (DECODE (FL, 4, S)), 0) S_KBPOSLE16,
                          NVL ( (DECODE (FL, 2, CNT)), 0) VXOD,
                          NVL ( (DECODE (FL, 2, S)), 0) S_VXOD,
                          s
            FROM (  SELECT nls,
                           BRANCH,
                           fl,
                           COUNT (*) CNT,
                           SUM (S) S
                      FROM (
                            -------------------------------------------------------
                            SELECT nls,
                                   branch,
                                   FL,
                                   S
                              FROM (

                                    SELECT nls,
                                           branch,
                                           FL,
                                           S,
                                           ROWNUM r
                                      FROM (SELECT nls,
                                                   branch,
                                                   FL,
                                                   S,
                                                   REF
                                             FROM (SELECT a.NLS nls,
                                                           a.branch BRANCH,
                                                           CASE
                                                              WHEN D.TT IN (Select TT from RKO_TTS where DK=0 and NTAR=13) THEN 1  --- Исходящие Ручные (001,002,...)
                                                              WHEN D.TT IN (Select TT from RKO_TTS where DK=0 and NTAR=14) THEN 0  --- Исходящие Авто   (KL1,KL2,IB1,IB2,PS1,PS2)
                                                           END FL,
                                                           o.REF,
                                                           F_TARIF_RKO (
                                                              t.ntar,
                                                              a.kv,
                                                              a.nls,
                                                              d.s,
                                       nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                                              TO_DATE (DKON_KV,'DD/MM/YYYY'),
                                                              o.NLSA,
                                                              o.NLSB,
                                                              o.MFOA,
                                                              o.MFOB,
                                                              t.TT,
                                                              a.ACC,
                                                              o.D_REC, o.REF) S
                                                      FROM oper o,
                                                           opldok d,
                                                           accounts a,
                                                           RKO_TTS t,
                                                           RKO_LST r 
                                                     WHERE     a.acc = k.acc
                                                           AND a.acc = r.acc
                                                           AND a.acc = d.acc
                                                           and (t.TT like 'IB%' or t.TT like 'CL%')  ---- **************************
                                                           AND d.REF = o.REF   
                                                           AND d.sos = 5      
                                                           AND d.fdat >= P_dat1
                                                           AND d.fdat <= P_dat2
                                                           AND d.TT = t.TT
                                                           AND t.DK=0
                                                           AND d.DK=0
                                                           AND (
                TO_CHAR ( nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),'HH24MI' )
                                                                   <=
                decode( (Select count(*) from HOLIDAY where trunc(o.PDAT+1)=HOLIDAY and KV=980), 0, L_OPERTIME, L_OPERTIME2 )
                                                                   OR
               ( o.TT in ('001','002')  and  exists ( Select 1 From OperW where TAG='VVOD' and VALUE='1' and REF=o.REF ) )
                                                                )
                                                           AND d.S > 0
                                                   UNION ALL
                                                   SELECT a.NLS nls,
                                                           a.branch BRANCH,
                                                           CASE
                                                              WHEN D.TT IN (Select TT from RKO_TTS where DK=0 and NTAR=13) THEN 3  --- Исходящие Ручные (001,002,... )
                                                              WHEN D.TT IN (Select TT from RKO_TTS where DK=0 and NTAR=14) THEN 4  --- Исходящие Авто   (KL1,KL2,IB1,IB2,PS1,PS2)
                                                           END FL,
                                                           o.REF,
                                                           F_TARIF_RKO (
                                                              t.ntar,
                                                              a.kv,
                                                              a.nls,
                                                              d.s,
                                       nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                                              TO_DATE (DKON_KV,'DD/MM/YYYY'),
                                                              o.NLSA,
                                                              o.NLSB,
                                                              o.MFOA,
                                                              o.MFOB,
                                                              t.TT,
                                                              a.ACC,
                                                              o.D_REC, o.REF) S
                                                      FROM oper o,
                                                           opldok d,
                                                           accounts a,
                                                           RKO_TTS t,
                                                           RKO_LST r
                                                      WHERE    a.acc = k.acc
                                                           AND a.acc = r.acc
                                                           AND a.acc = d.acc
                                                           and (t.TT like 'IB%' or t.TT like 'CL%')  ---- **************************
                                                           AND d.REF = o.REF   
                                                           AND d.sos = 5      
                                                           AND d.fdat >= P_dat1
                                                           AND d.fdat <= P_dat2
                                                           AND d.TT = t.TT
                                                           AND t.DK=0
                                                           AND d.DK=0
                                                           AND (
               TO_CHAR ( nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT), 'HH24MI' )
                                                                    > 
               decode((Select count(*) from HOLIDAY where trunc(o.PDAT+1)=HOLIDAY and KV=980), 0, L_OPERTIME, L_OPERTIME2 )
                                                                AND
               not ( o.TT in ('001','002')  and  exists ( Select 1 From OperW where TAG='VVOD' and VALUE='1' and REF=o.REF ) )
                                                                )
                                                           AND d.S > 0
                                                      ORDER BY REF))
                                     WHERE s > 0 )
                             WHERE r > L_DOC_NOPAY                 --- Oтбрасываем первых L_DOC_NOPAY платежей
                                                                   --------------------------------------------  
--  ================================================================================================================
                                                           UNION ALL
                            SELECT nls,
                                   branch,
                                   FL,
                                   S
                              FROM (

                                    SELECT nls,
                                           branch,
                                           FL,
                                           S,
                                           ROWNUM r
                                      FROM (SELECT nls,
                                                   branch,
                                                   FL,
                                                   S,
                                                   REF
                                             FROM (SELECT a.NLS nls,
                                                           a.branch BRANCH,
                                                           CASE
                                                              WHEN D.TT IN (Select TT from RKO_TTS where DK=0 and NTAR=13) THEN 1  --- Исходящие Ручные (001,002,...)
                                                              WHEN D.TT IN (Select TT from RKO_TTS where DK=0 and NTAR=14) THEN 0  --- Исходящие Авто   (KL1,KL2,IB1,IB2,PS1,PS2)
                                                           END FL,
                                                           o.REF,
                                                           F_TARIF_RKO (
                                                              t.ntar,
                                                              a.kv,
                                                              a.nls,
                                                              d.s,
                                       nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                                              TO_DATE (DKON_KV,'DD/MM/YYYY'),
                                                              o.NLSA,
                                                              o.NLSB,
                                                              o.MFOA,
                                                              o.MFOB,
                                                              t.TT,
                                                              a.ACC,
                                                              o.D_REC, o.REF) S
                                                      FROM oper o,
                                                           opldok d,
                                                           accounts a,
                                                           RKO_TTS t,
                                                           RKO_LST r
                                                     WHERE     a.acc = k.acc
                                                           AND a.acc = r.acc
                                                           AND a.acc = d.acc
                                                           and t.TT not like 'IB%' and t.TT not like 'CL%'   ---- **************************
                                                           AND d.REF = o.REF  
                                                           AND d.sos = 5      
                                                           AND d.fdat >= P_dat1
                                                           AND d.fdat <= P_dat2
                                                           AND d.TT = t.TT
                                                           AND t.DK=0
                                                           AND d.DK=0
                                                           AND (
                  TO_CHAR ( nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT), 'HH24MI' )
                                                               <=
                  decode((Select count(*) from HOLIDAY where trunc(o.PDAT+1)=HOLIDAY and KV=980), 0, L_OPERTIME, L_OPERTIME2 )
                                                                OR
                  ( o.TT in ('001','002')  and  exists ( Select 1 From OperW where TAG='VVOD' and VALUE='1' and REF=o.REF ) )
                                                               )
                                                           AND d.s > 0
                                                   UNION ALL
                                                   SELECT a.NLS nls,
                                                           a.branch BRANCH,
                                                           CASE
                                                              WHEN D.TT IN (Select TT from RKO_TTS where DK=0 and NTAR=13) THEN 3  --- Исходящие Ручные (001,002,... )
                                                              WHEN D.TT IN (Select TT from RKO_TTS where DK=0 and NTAR=14) THEN 4  --- Исходящие Авто   (KL1,KL2,IB1,IB2,PS1,PS2)
                                                           END FL,
                                                           o.REF,
                                                           F_TARIF_RKO (
                                                              t.ntar,
                                                              a.kv,
                                                              a.nls,
                                                              d.s,
                                       nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                                              TO_DATE (DKON_KV,'DD/MM/YYYY'),
                                                              o.NLSA,
                                                              o.NLSB,
                                                              o.MFOA,
                                                              o.MFOB,
                                                              t.TT,
                                                              a.ACC,
                                                              o.D_REC, o.REF) S
                                                      FROM oper o,
                                                           opldok d,
                                                           accounts a,
                                                           RKO_TTS t,
                                                           RKO_LST r
                                                     WHERE     a.acc = k.acc
                                                           AND a.acc = r.acc
                                                           AND a.acc = d.acc
                                                           and t.TT not like 'IB%' and t.TT not like 'CL%'    ---- **************************
                                                           AND d.REF = o.REF   
                                                           AND d.sos = 5       
                                                           AND d.fdat >= P_dat1
                                                           AND d.fdat <= P_dat2
                                                           AND d.TT = t.TT
                                                           AND t.DK=0
                                                           AND d.DK=0
                                                           AND (
                    TO_CHAR ( nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),'HH24MI' )
                                                                   > 
                    decode( (Select count(*) from HOLIDAY where trunc(o.PDAT+1)=HOLIDAY and KV=980), 0, L_OPERTIME, L_OPERTIME2 )
                                                                  AND
                    not ( o.TT in ('001','002')  and  exists ( Select 1 From OperW where TAG='VVOD' and VALUE='1' and REF=o.REF ) )
                                                               )
                                                           AND d.S > 0
                                                    ORDER BY REF))
                                     WHERE s > 0)
                           ----- WHERE r > L_DOC_NOPAY             --- Oтбрасываем первых L_DOC_NOPAY платежей
                                                                   --------------------------------------------  
--  ================================================================================================================
                                                           UNION ALL
                                                    SELECT a.NLS nls,
                                                           a.branch BRANCH,
                                                           2 FL,
                                                            F_TARIF_RKO (
                                                              t.ntar,
                                                              a.kv,
                                                              a.nls,
                                                              d.s,
                                       nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                                              TO_DATE (DKON_KV,'DD/MM/YYYY'),
                                                              o.NLSA,
                                                              o.NLSB,
                                                              o.MFOA,
                                                              o.MFOB,
                                                              t.TT,
                                                              a.ACC,
                                                              o.D_REC, o.REF) S
                                                      FROM oper o,
                                                           opldok d,
                                                           accounts a,
                                                           RKO_TTS t,
                                                           RKO_LST r
                                                     WHERE     a.acc = k.acc
                                                           AND a.acc = r.acc
                                                           AND a.acc = d.acc
                                                           AND d.REF = o.REF
                                                           AND d.sos = 5
                                                           AND d.fdat >= P_dat1
                                                           AND d.fdat <= P_dat2
                                                           AND d.tt = t.tt
                                                           AND t.DK=1
                                                           AND d.DK=1
                                                           AND d.s > 0)     
                     WHERE s > 0
                  GROUP BY NLS, BRANCH, FL))
        GROUP BY nls;
  EXCEPTION WHEN NO_DATA_FOUND THEN  NULL;
        l_nls:=null;  --не все записи с курсора отбираються тут, потому обнуляем
  END;


ELSE            -----------    n_tarpak  <  38   -  Бесплатные набираются из ЛЮБЫХ платежей  !!!
                -----------------------------------------------------------------------------------
  BEGIN
  SELECT nls,
         SUM (bumdo16),
         SUM (s_bumdo16),
         SUM (bumposle16),
         SUM (s_bumposle16),
         SUM (kbdo16),
         SUM (s_kbdo16),
         SUM (kbposle16),
         SUM (s_kbposle16),
         SUM (vxod),
         SUM (s_vxod),
         SUM (s)
  INTO l_nls,
       l_cnt1,
       l_s1,
       l_cnt2,
       l_s2,
       l_cnt3,
       l_s3,
       l_cnt4,
       l_s4,
       l_cnt5,
       l_s5,
       l_s_all
    FROM (SELECT DISTINCT nls,
                          NVL ( (DECODE (FL, 1, CNT)), 0) bumdo16,
                          NVL ( (DECODE (FL, 1, S)), 0) s_bumdo16,
                          NVL ( (DECODE (FL, 0, CNT)), 0) KBDO16,
                          NVL ( (DECODE (FL, 0, S)), 0) S_KBDO16,
                          NVL ( (DECODE (FL, 3, CNT)), 0) bumPOSLE16,
                          NVL ( (DECODE (FL, 3, S)), 0) S_bumPOSLE16,
                          NVL ( (DECODE (FL, 4, CNT)), 0) KBPOSLE16,
                          NVL ( (DECODE (FL, 4, S)), 0) S_KBPOSLE16,
                          NVL ( (DECODE (FL, 2, CNT)), 0) VXOD,
                          NVL ( (DECODE (FL, 2, S)), 0) S_VXOD,
                          s
            FROM (  SELECT nls,
                           BRANCH,
                           fl,
                           COUNT (*) CNT,
                           SUM (S) S
                      FROM (SELECT nls,
                                   branch,
                                   FL,
                                   S
                              FROM (SELECT nls,
                                           branch,
                                           FL,
                                           S,
                                           ROWNUM r
                                      FROM (SELECT nls,
                                                   branch,
                                                   FL,
                                                   S,
                                                   REF
                                             FROM (SELECT a.NLS nls,
                                                           a.branch BRANCH,
                                                           CASE
                                                              WHEN D.TT IN (Select TT from RKO_TTS where DK=0 and NTAR=13) THEN 1  --- Исходящие Ручные (001,002,...)
                                                              WHEN D.TT IN (Select TT from RKO_TTS where DK=0 and NTAR=14) THEN 0  --- Исходящие Авто   (KL1,KL2,IB1,IB2,PS1,PS2)
                                                           END FL,
                                                           o.REF,
                                                           F_TARIF_RKO (
                                                              t.ntar,
                                                              a.kv,
                                                              a.nls,
                                                              d.s,
                                       nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                                              TO_DATE (DKON_KV,'DD/MM/YYYY'),
                                                              o.NLSA,
                                                              o.NLSB,
                                                              o.MFOA,
                                                              o.MFOB,
                                                              t.TT,
                                                              a.ACC,
                                                              o.D_REC, o.REF) S
                                                      FROM oper o,
                                                           opldok d,
                                                           accounts a,
                                                           RKO_TTS t,
                                                           RKO_LST r
                                                     WHERE     a.acc = k.acc
                                                           AND a.acc = r.acc
                                                           AND a.acc = d.acc
                                                           AND d.REF = o.REF  
                                                           AND d.sos = 5      
                                                           AND d.fdat >= P_dat1
                                                           AND d.fdat <= P_dat2
                                                           AND d.TT = t.TT
                                                           AND t.DK=0
                                                           AND d.DK=0
                                                           AND (
                      TO_CHAR ( nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT), 'HH24MI' )
                                                                 <=
                      decode( (Select count(*) from HOLIDAY where trunc(o.PDAT+1)=HOLIDAY and KV=980), 0, L_OPERTIME, L_OPERTIME2 )
                                                                 OR
                      ( o.TT in ('001','002')  and  exists ( Select 1 From OperW where TAG='VVOD' and VALUE='1' and REF=o.REF ) )
                                                                )
                                                           AND d.S > 0
                                                    UNION ALL
                                                    SELECT a.NLS nls,
                                                           a.branch BRANCH,
                                                           CASE
                                                              WHEN D.TT IN (Select TT from RKO_TTS where DK=0 and NTAR=13) THEN 3  --- Исходящие Ручные (001,002,... )
                                                              WHEN D.TT IN (Select TT from RKO_TTS where DK=0 and NTAR=14) THEN 4  --- Исходящие Авто   (KL1,KL2,IB1,IB2,PS1,PS2)
                                                           END FL,
                                                           o.REF,
                                                           F_TARIF_RKO (
                                                              t.ntar,
                                                              a.kv,
                                                              a.nls,
                                                              d.s,
                                       nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                                              TO_DATE (DKON_KV,'DD/MM/YYYY'),
                                                              o.NLSA,
                                                              o.NLSB,
                                                              o.MFOA,
                                                              o.MFOB,
                                                              t.TT,
                                                              a.ACC,
                                                              o.D_REC, o.REF) S
                                                      FROM oper o,
                                                           opldok d,
                                                           accounts a,
                                                           RKO_TTS t,
                                                           RKO_LST r
                                                     WHERE     a.acc = k.acc
                                                           AND a.acc = r.acc
                                                           AND a.acc = d.acc
                                                           AND d.REF = o.REF  
                                                           AND d.sos = 5      
                                                           AND d.fdat >= P_dat1
                                                           AND d.fdat <= P_dat2
                                                           AND d.TT = t.TT
                                                           AND t.DK=0
                                                           AND d.DK=0
                                                           AND (
                  TO_CHAR ( nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT), 'HH24MI' )
                                                                 > 
                  decode( (Select count(*) from HOLIDAY where trunc(o.PDAT+1)=HOLIDAY and KV=980), 0, L_OPERTIME, L_OPERTIME2 )
                                                                AND
                  not ( o.TT in ('001','002')  and  exists ( Select 1 From OperW where TAG='VVOD' and VALUE='1' and REF=o.REF ) )
                                                                )
                                                           AND d.S > 0
                                                    ORDER BY REF))
                                     WHERE s > 0)
                             WHERE r > L_DOC_NOPAY                 --- Oтбрасываем первых L_DOC_NOPAY платежей
                                                                   --------------------------------------------  
                                                           UNION ALL
                                                    SELECT a.NLS nls,
                                                           a.branch BRANCH,
                                                           2 FL,
                                                            F_TARIF_RKO (
                                                              t.ntar,
                                                              a.kv,
                                                              a.nls,
                                                              d.s,
                                       nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                                              TO_DATE (DKON_KV,'DD/MM/YYYY'),
                                                              o.NLSA,
                                                              o.NLSB,
                                                              o.MFOA,
                                                              o.MFOB,
                                                              t.TT,
                                                              a.ACC,
                                                              o.D_REC, o.REF) S
                                                      FROM oper o,
                                                           opldok d,
                                                           accounts a,
                                                           RKO_TTS t,
                                                           RKO_LST r
                                                     WHERE     a.acc = k.acc
                                                           AND a.acc = r.acc
                                                           AND a.acc = d.acc
                                                           AND d.REF = o.REF
                                                           AND d.sos = 5
                                                           AND d.fdat >= P_dat1
                                                           AND d.fdat <= P_dat2
                                                           AND d.tt = t.tt
                                                           AND t.DK=1
                                                           AND d.DK=1
                                                           AND d.s > 0)     
                     WHERE s > 0
                  GROUP BY NLS, BRANCH, FL))
    GROUP BY nls;
  EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
        l_nls:=null;  --не все записи с курсора отбираються тут, потому обнуляем
  END;


END IF;        ---  END IF   Бесплатных !!!

---+ + + + + + + + + + + + + + + + + + + + + + + + + + +

 BEGIN
   IF l_nls IS NOT NULL THEN --пустые не вставляем
      INSERT INTO RKO_335 (branch,nls,cnt1,s1,cnt2,s2,
                               cnt3,  s3 ,cnt4,s4,cnt5,s5,s_all)
      VALUES (k.branch,l_nls,l_cnt1,l_s1,l_cnt2,l_s2,
              l_cnt3,l_s3,l_cnt4,l_s4,l_cnt5,l_s5,l_s_all);
   END IF;
 END;

 COMMIT;
END LOOP;
END;
/

grant execute on RKO335 to start1;
grant execute on RKO335 to bars_access_defrole;
