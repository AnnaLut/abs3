CREATE OR REPLACE FUNCTION BARS.f_tarif_rko
                 ( kod_  INTEGER,      -- код тарифа
                   kv_   INTEGER,      -- валюта операции
                   nls_  VARCHAR2,     -- бух.номер счета
                   s_    NUMERIC,      -- сумма операции
                   PDAT_ DATE,         -- дата/время получения посл.визы
                DKON_KV  DATE,         -- ДАТА посл.раб.дня КВАРТАЛА
                   NLSA_ VARCHAR2,     -- Oper.NLSA
                   NLSB_ VARCHAR2,     -- Oper.NLSB
                   MFOA_ VARCHAR2,     -- Oper.MFOA
                   MFOB_ VARCHAR2,     -- Oper.MFOB
                   TT_   CHAR,         -- Oper.TT
                   ACC_  NUMBER,       -- ACC счета
                 D_REC_  VARCHAR2,
                   REF_  NUMBER        -- REF 
                 )       
                            
RETURN NUMERIC IS       
    
  OprTime   Char(4) ;      
  sk_       NUMERIC ;      
  not15_    Char(4) ;      
  uz_       NUMERIC ;
  kkk_      NUMERIC ;
  peredsv   NUMERIC ;
  ob22_NLSB Char(2) ;     -- OB22 счета NLSB
  n_tarpak  NUMBER  ;     --  № тарифного пакета

  OprTime1  Char(4) ;
  OprTime2  Char(4) ;

  maket_    NUMERIC ;
  okpo_     Char(12);

  vvod_     NUMERIC ;    --  OperW/TAG='VVOD' = 1 - ввод було відкладено на ПісляОпЧас
                         --  Для операцій 001,002

--------------------------------------------------------------------------- 
--
--               Универсальная F_TARIF_RKO  -  для всех РУ               
--                      
--------------------------------------------------------------------------- 
BEGIN

  vvod_ := 0;

  If kod_<>15 and TT_ in ('001','002','PKR') then

    Begin 

      Select 1 into kkk_ 
      from   OperW 
      where  REF=REF_ and TAG='DOG_S' and VALUE='1';

      RETURN  F_TARIF(205, kv_, nls_, s_);

    EXCEPTION  WHEN NO_DATA_FOUND THEN
      null;
    End;


    Begin 

      Select 1 into vvod_ 
      from   OperW 
      where  REF=REF_ and TAG='VVOD' and VALUE<>'0';

    EXCEPTION  WHEN NO_DATA_FOUND THEN
      vvod_ := 0;
    End;


 End If;


----  Определяем kkk_ - Kод Корп.Клиента:

 kkk_:=0;            
 BEGIN  
   Select r.KODK  Into  kkk_         
   From   RNKP_KOD r, Accounts a
   Where  a.ACC=ACC_  and  a.RNK=r.RNK  and  
          r.RNK is not NULL and r.KODK is not NULL and rownum=1;
 EXCEPTION  WHEN NO_DATA_FOUND THEN
   kkk_:=0;
 END;  


---  Определяем  № тар.пакета  n_tarpak :

 BEGIN

    SELECT to_number(w.VALUE)
    INTO   n_tarpak
    FROM   Accounts a, AccountsW w
    WHERE  a.ACC = w.ACC
       and w.TAG = 'SHTAR'
       and a.ACC = ACC_ ;

 EXCEPTION WHEN others THEN
    n_tarpak := 0; 
 END;



---  Исключения:  Не берется плата за Дебет, если в Кредите стоят   
---  определенные счета  (в ГОУ эти исключения работают только для 
---  счетов "С ПАКЕТОМ")


 IF kod_ in (13,14) and ( gl.amfo<>'300465'  OR  gl.amfo='300465' and n_tarpak > 0 )  then   ----  ИСХОДЯЩИЕ:

    --  Не берем за Кт на балансовые  (кроме ПФУ и Укрпошты):
    ---------------------------------------------------------
    if substr(NLSB_,1,4) in ('2525','2546','2610','2611','2651','3570','2900','6510','6514' ) and 
       MFOA_=MFOB_  and  kkk_ not in (1,2)  then

       RETURN 0;

    end if;


    --  Не берем за Кт на 2600/05, 3739/05,12  (кроме ПФУ и Укрпошты):
    ------------------------------------------------------------------
    if (substr(NLSB_,1,4)='3739' or substr(NLSB_,1,4)='2600') and 
       MFOA_=MFOB_                                            and 
       kkk_ not in (1,2)        then

       Begin 

         Select OB22 into ob22_NLSB 
         from   ACCOUNTS
         where  KV=980 and NLS=NLSB_;

         if substr(NLSB_,1,4)='2600' and ob22_NLSB='05' then  
            RETURN 0;
         end if;

         if substr(NLSB_,1,4)='3739' and ob22_NLSB in ('05','12') then  
            RETURN 0;
         end if;

       EXCEPTION  WHEN NO_DATA_FOUND THEN
         null;
       End;

    end if;

 END IF;


 -----  Определяем  "В межах ОБ" / "За межi ОБ" :

 IF gl.amfo='300465' THEN       ----  ГОУ:

    ---   В ГОУ определяем МАКЕТ.  Он нужен для 29 особых счетов ГОУ.     
    ---   maket_ = 1  - Внутренний
    ---   maket_ = 2  - В межах ОБ (ВПС)
    ---   maket_ = 3  - За межi ОБ (СЭП)
    
    If   MFOA_ = MFOB_  then
         maket_:=1;
    Else
         if kod_ in (13,14) then   -- Исходящий (kod_ = 13,14 )
             Begin
               Select 2  into  maket_
               from   BANKS$BASE where MFO=MFOB_ and BLK=0 and MFOU='300465';
               maket_:=2;                                      -------------
             EXCEPTION  WHEN NO_DATA_FOUND THEN
               maket_:=3;
             END;
         else                       -- Входящий  (kod_ = 15 )
             Begin
               Select 2  into  maket_
               from   BANKS$BASE where MFO=MFOA_ and BLK=0 and MFOU='300465';
               maket_:=2;                                      -------------
             EXCEPTION  WHEN NO_DATA_FOUND THEN
               maket_:=3;
             END;
         end if;
    End If;
    
    If maket_ = 3 then 
       uz_ := 1;  ---  "За межi ОБ"
    Else 
       uz_ := 0;  ---  "В межах ОБ"
    End If;

 ELSE 
                                ----  РУ:
    uz_ :=0;
    If  kod_<>15 and MFOA_<>MFOB_ then    ---  Исходящий МЕЖБАНК 
        Begin
          Select 0 into uz_ from BANKS$BASE where MFO=MFOB_ and BLK=0 and MFOU='300465';
          uz_:=0;  ---  "В межах ОБ"                                      -------------
        EXCEPTION  WHEN NO_DATA_FOUND THEN
          uz_:=1;  ---  "За межi ОБ"
        END;
    End If;       ---  uz_:=0  -  "В межах ОБ"
                  ---  uz_:=1  -  "За межi ОБ"
 END IF;



-------- 1).  Определяем Опер.время:  -------------------------------------- 


 Begin                      --  peredsv=0 - обычный день           
   Select 1 into peredsv    --  peredsv=1 - пт. или предпраздн.день
   from   HOLIDAY                   
   where  trunc(PDAT_+1)=HOLIDAY and KV=980;   
 EXCEPTION WHEN NO_DATA_FOUND THEN
   peredsv:=0; 
 END;                                    



 IF      gl.amfo = '302076'  then   --  1. Винница 
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'        then   ---- 1) ПФУ  ------

          if peredsv=1           then
              OprTime:='1630';   --   Пятница или ПредПразд.день
          else
              OprTime:='1700';   --   Обычный день            
          end if;

   ELSIF  kkk_=2                        then   ---- 2) Укрпошта ---

          if  peredsv=1  then
               OprTime:='1600';  --   Пятница или ПредПразд.день
          else
               OprTime:='1700';  --   Обычный день             
          end if;

   ELSE                                        ---- 3) Другие кл.
          OprTime:='1600';       --<-  БАЗОВОЕ опер.время

   END IF;

 ElsIf   gl.amfo = '313957'  then   --  2. Запорожье  
 ------------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ПФУ
   
          if    trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   Посл.раб.день Квартала
          elsif peredsv=1           then
              OprTime:='1630';   --   Пятница или ПредПразд.день
          else
              OprTime:='1700';   --   Обычный день            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) Укрпошта
   
          if  peredsv=1  then
               OprTime:='1600';  --   Пятница или ПредПразд.день
          else
               OprTime:='1700';  --   Обычный день             
          end if;
   
   ELSIF  kkk_=5                          then  --- 3) ОблЕнерго
   
          If nls_='26008301141401' then
               OprTime:='1630';  
          end if;
   
          If nls_ like '2603%31414%' then
               OprTime:='1700';  
          end if;
   
   ELSE                                         --- 4) Другие кл.
          OprTime:='1600';       --<-  БАЗОВОЕ опер.время
   
   END IF;

 ElsIf   gl.amfo = '323475'  then   --  3. Кировоград
 -------------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ПФУ
      
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   Посл.раб.день Квартала
          elsif peredsv=1  then
              OprTime:='1630';   --   Пятница или ПредПразд.день
          else
              OprTime:='1700';   --   Обычный день            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) Укрпошта
   
          if  peredsv=1  then
               OprTime:='1600';  --   Пятница или ПредПразд.день
          else
               OprTime:='1700';  --   Обычный день             
          end if;
   
   ELSE                                         --- 4) Другие кл.
   
          if peredsv=1   then  
             OprTime:='1500';    --   Пятница или ПредПразд.день
          else
             OprTime:='1600';    ----<-  БАЗОВОЕ опер.время             
          end if;
   
   END IF;

 ElsIf   gl.amfo = '324805'  then   --  4. Крым
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ПФУ
   
          if   trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   Посл.раб.день Квартала
          elsif peredsv=1  then
              OprTime:='1630';   --   Пятница или ПредПразд.день
          else
              OprTime:='1700';   --   Обычный день            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) Укрпошта
   
          if  peredsv=1  then
               OprTime:='1630';  --   Пятница или ПредПразд.день
          else
               OprTime:='1700';  --   Обычный день             
          end if;
   
   ELSE                                         --- 3) Другие кл.
          if peredsv=1   then  
             OprTime:='1530';    --   Пятница или ПредПразд.день
          else
             OprTime:='1600';    ----<-  БАЗОВОЕ опер.время             
          end if;
   
   END IF;

 ElsIf   gl.amfo = '325796'  then   --  5. Львов    
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ПФУ
      
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   Посл.раб.день Квартала
          elsif peredsv=1  then
              OprTime:='1630';   --   Пятница или ПредПразд.день
          else
              OprTime:='1700';   --   Обычный день            
          end if;
   
   ELSIF  kkk_=2                          then  --- 2) Укрпошта
   
          if  peredsv=1  then
               OprTime:='1600';  --   Пятница или ПредПразд.день
          else
               OprTime:='1700';  --   Обычный день             
          end if;
   
   ELSIF  kkk_=17                         then  --- 3) Укрзалізниця
   
          if  peredsv=1  then
               OprTime:='1645';  --   Пятница или ПредПразд.день
          else
               OprTime:='1745';  --   Обычный день             
          end if;
   
   ELSE                                         --- 4) Другие кл.
          OprTime:='1600';   --<-  БАЗОВОЕ опер.время                
   
   END IF;

 ElsIf   gl.amfo = '326461'  then   --  6. Николаев    
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ПФУ
      
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   Посл.раб.день Квартала
          elsif peredsv=1  then
              OprTime:='1630';   --   Пятница или ПредПразд.день
          else
              OprTime:='1700';   --   Обычный день            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) Укрпошта
   
          if  peredsv=1  then
              OprTime:='1500';  --   Пятница или ПредПразд.день
          else
              OprTime:='1600';  --   Обычный день             
          end if;
   
   ELSE                                         --- 3) Другие кл.
          if peredsv=1   then  
             OprTime:='1445';    --   Пятница или ПредПразд.день
          else
             OprTime:='1600';    ---<-  БАЗОВОЕ опер.время             
          end if;
   
   END IF;

 ElsIf   gl.amfo = '328845'  then   --  7. Одесса    
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ПФУ
  
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   Посл.раб.день Квартала
          elsif peredsv=1           then
              OprTime:='1630';   --   Пятница или ПредПразд.день
          else
              OprTime:='1700';   --   Обычный день            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) Укрпошта
  
          if  peredsv=1  then
               OprTime:='1600';  --   Пятница или ПредПразд.день
          else
               OprTime:='1700';  --   Обычный день             
          end if;
  
   ELSE                                         --- 3) Другие кл.
          if peredsv=1   then  
              OprTime:='1530';    --   Пятница или ПредПразд.день
          else
              OprTime:='1600';    ----<-  БАЗОВОЕ опер.время             
          end if;
   
   END IF;

 ElsIf   gl.amfo = '331467'  then   --  8. Полтава  
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ПФУ
      
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   Посл.раб.день Квартала
          elsif peredsv=1  then
              OprTime:='1630';   --   Пятница или ПредПразд.день
          else
              OprTime:='1700';   --   Обычный день            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) Укрпошта
  
          if  peredsv=1  then
               OprTime:='1600';  --   Пятница или ПредПразд.день
          else
               OprTime:='1700';  --   Обычный день             
          end if;
  
   ELSE                                         --- 3) Другие кл.
          OprTime:='1600';   --<-  БАЗОВОЕ опер.время              
   
   END IF;

 ElsIf   gl.amfo = '337568'  then   --  9. Сумы      
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ПФУ
      
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   Посл.раб.день Квартала
          elsif peredsv=1  then
              OprTime:='1630';   --   Пятница или ПредПразд.день
          else
              OprTime:='1700';   --   Обычный день            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) Укрпошта
   
          OprTime:='1600';  
   
   ELSE                                         --- 3) Другие кл.
          OprTime:='1600';  --<-  БАЗОВОЕ опер.время               
   
   END IF;


   --1). За Входящие операцией PS1 на счет 260323010414 Облэнерго не берем !

     if kod_=15  and  nls_='260323010414' and TT_='PS1' then
        RETURN 0 ;                              
     end if;

   --2). За Внутренние Входящие (kod_=15) с 2902*  не берем !

     if kod_=15            and  MFOA_=MFOB_          and 
        NLSA_ like '2902%' and  NLSB_ like '26%'     then 
        RETURN 0 ;
     end if;


   --3). За Внутренние Входящие операцией 015  с 2924* на 26*  не берем !

     if kod_=15  and  TT_='015'  and  NLSA_ like '2924%' and  NLSB_ like '26%'  then
        RETURN 0 ;
     end if;


 ElsIf   gl.amfo = '351823'  then   -- 10. Харьков
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ПФУ
   
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   Посл.раб.день Квартала
          elsif peredsv=1           then
              OprTime:='1630';   --   Пятница или ПредПразд.день
          else
              OprTime:='1700';   --   Обычный день            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) Укрпошта
   
          if  to_char(PDAT_,'D')='6'  then
               OprTime:='1600';  --   Пятница  ( без ПредПразд.день !!! )
          else                                  ------------------------
               OprTime:='1700';  --   Обычный день             
          end if;
   
   ELSE                                         --- 3) Другие кл.
          if peredsv=1   then  
             OprTime:='1500';    --   Пятница или ПредПразд.день
          else
             OprTime:='1600';    ----<-  БАЗОВОЕ опер.время             
          end if;
   
   END IF;

 ElsIf   gl.amfo = '353553'  then   -- 11. Чернигов
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ПФУ
      
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   Посл.раб.день Квартала
          elsif peredsv=1  then
              OprTime:='1630';   --   Пятница или ПредПразд.день
          else
              OprTime:='1700';   --   Обычный день            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) Укрпошта
   
          if  peredsv=1  then
               OprTime:='1630';  --   Пятница или ПредПразд.день
          else
               OprTime:='1700';  --   Обычный день             
          end if;
   
   ELSIF  kkk_=8                          then  --- 3) ОблГаз
   
          OprTime:='1700';               
   
   ELSE                                         --- 4) Другие кл.
          OprTime:='1600';    ---<-  БАЗОВОЕ опер.время
   
   END IF;

 ElsIf   gl.amfo = '305482'  then   -- 12. Днепропетровск   
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ПФУ
   
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   Посл.раб.день Квартала
          elsif peredsv=1           then
              OprTime:='1630';   --   Пятница или ПредПразд.день
          else
              OprTime:='1700';   --   Обычный день            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) Укрпошта
   
          if  peredsv=1  then
               OprTime:='1600';  --   Пятница или ПредПразд.день
          else
               OprTime:='1700';  --   Обычный день             
          end if;
   
   ELSE                                         --- 3) Другие кл.
           
          If kod_=13 then     
             OprTime:='1630';    -- Папер.носії
          else
             OprTime:='1700';    -- БАЗОВОЕ опер.время
          end if;
   
   END IF;

 ElsIf   gl.amfo = '335106'  then   -- 13. Донецк      
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ПФУ
   
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   Посл.раб.день Квартала
          elsif peredsv=1  then
              OprTime:='1630';   --   Пятница или ПредПразд.день
          else
              OprTime:='1700';   --   Обычный день            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) Укрпошта
   
          if  peredsv=1  then
               OprTime:='1600';  --   Пятница или ПредПразд.день
          else
               OprTime:='1700';  --   Обычный день             
          end if;
   
   ELSE                                         --- 3) Другие кл.
          if peredsv=1   then  
             OprTime:='1600';    --   Пятница или ПредПразд.день
          else
             OprTime:='1700';    --<-  БАЗОВОЕ опер.время             
          end if;
   
   END IF;

   --------------  За   2560 - 373960003  плату НЕ берем !
   If  ( NLSA_='256023772062' and NLSB_='373960003' )  then 
      RETURN 0 ;
   End If;

   --------------  За   2560 - 3570/02   плату НЕ берем !
   If  substr(NLSA_,1,4)='2560' and substr(NLSB_,1,4)='3570'  then 
       Begin 
         Select OB22 into ob22_NLSB 
         from   ACCOUNTS
         where  KV=980 and NLS=NLSB_;
   
         if ob22_NLSB='02' then  
            RETURN 0;
         end if;
       EXCEPTION  WHEN NO_DATA_FOUND THEN
         null;
       End;
   End If;



 ElsIf   gl.amfo = '311647'  then   -- 14. Житомир 
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ПФУ
   
          if    trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   Посл.раб.день Квартала
          elsif peredsv=1  then
              OprTime:='1630';   --   Пятница или ПредПразд.день
          else
              OprTime:='1700';   --   Обычный день            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) Укрпошта
   
          if  peredsv=1  then
               OprTime:='1600';  --   Пятница или ПредПразд.день
          else
               OprTime:='1700';  --   Обычный день             
          end if;
   
   ELSE                                         --- 3) Другие кл.
          if peredsv=1   then  
             OprTime:='1600';    --   Пятница или ПредПразд.день
          else
             OprTime:='1700';    ---<-  БАЗОВОЕ опер.время             
          end if;
   
   END IF;

 ElsIf   gl.amfo = '336503'  then   -- 15. Ив-Франк 
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ПФУ
   
          if peredsv=1  then
              OprTime:='1630';   --   Пятница или ПредПразд.день
          else
              OprTime:='1700';   --   Обычный день            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) Укрпошта
   
          if peredsv=1  then
              OprTime:='1600';   --   Пятница или ПредПразд.день
          else
              OprTime:='1700';   --   Обычный день             
          end if;
   
   ELSE                                         --- 3) Другие кл.
           
          OprTime:='1700';      --<-  БАЗОВОЕ опер.время
   
   END IF;

 ElsIf   gl.amfo = '304665'  then   -- 16. Луганск 
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ПФУ
      
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   Посл.раб.день Квартала
          elsif peredsv=1  then
              OprTime:='1630';   --   Пятница или ПредПразд.день
          else
              OprTime:='1700';   --   Обычный день            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) Укрпошта
   
          if  peredsv=1  then
               OprTime:='1600';  --   Пятница или ПредПразд.день
          else
               OprTime:='1700';  --   Обычный день             
          end if;
   
   ELSE                                         --- 3) Другие кл.
          if peredsv=1   then  
             OprTime:='1600';    --   Пятница или ПредПразд.день
          else
             OprTime:='1700';    ----<-  БАЗОВОЕ опер.время             
          end if;
   
   END IF;


   if kod_=15 and NLSA_ like '2568%'      then 
      RETURN 0 ;
   end if;


 ElsIf   gl.amfo = '303398'  then   -- 17. Луцк 
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ПФУ
   
     ---  if  trunc(PDAT_)=DKON_KV  then
     ---      OprTime:='2400';   --   Посл.раб.день Квартала
   
          if peredsv=1           then
              OprTime:='1600';   --   Пятница или ПредПразд.день
          else
              OprTime:='1700';   --   Обычный день            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) Укрпошта
   
          if  peredsv=1  then
               OprTime:='1600';  --   Пятница или ПредПразд.день
          else
               OprTime:='1700';  --   Обычный день             
          end if;
   
   ELSE                                         --- 3) Другие кл.
          if peredsv=1   then  
             OprTime:='1600';    --   Пятница или ПредПразд.день
          else
             OprTime:='1700';    ---<-  БАЗОВОЕ опер.время             
          end if;
   
   END IF;

 ElsIf   gl.amfo = '333368'  then   -- 18. Ровно 
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ПФУ
      
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   Посл.раб.день Квартала
          elsif peredsv=1           then
              OprTime:='1630';   --   Пятница или ПредПразд.день
          else
              OprTime:='1700';   --   Обычный день            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) Укрпошта
   
          if  peredsv=1  then
               OprTime:='1600';  --   Пятница или ПредПразд.день
          else
               OprTime:='1700';  --   Обычный день             
          end if;
   
   ELSE                                         --- 3) Другие кл.
          if peredsv=1   then  
             OprTime:='1600';    --   Пятница или ПредПразд.день
          else
             OprTime:='1700';    ----<-  БАЗОВОЕ опер.время             
          end if;
   
   END IF;

 ElsIf   gl.amfo = '338545'  then   -- 19. Тернополь
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ПФУ
      
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   Посл.раб.день Квартала
          elsif peredsv=1  then
              OprTime:='1630';   --   Пятница или ПредПразд.день
          else
              OprTime:='1700';   --   Обычный день            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) Укрпошта
   
          if  peredsv=1  then
               OprTime:='1600';  --   Пятница или ПредПразд.день
          else
               OprTime:='1700';  --   Обычный день             
          end if;
   
   ELSE                                         --- 3) Другие кл.
          if peredsv=1   then  
             OprTime:='1600';    --   Пятница или ПредПразд.день
          else
             OprTime:='1700';    ----<-  БАЗОВОЕ опер.время             
          end if;
   
   END IF;


   if kod_=15  and TT_='I00' and  Substr(nls_,1,4)<>'2560'  then
      RETURN 0 ;                              
   end if;



 ElsIf   gl.amfo = '312356'  then   -- 20. Ужгород 
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ПФУ
   
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   Посл.раб.день Квартала
          elsif peredsv=1           then
              OprTime:='1630';   --   Пятница или ПредПразд.день
          else
              OprTime:='1700';   --   Обычный день            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) Укрпошта
   
          if  peredsv=1  then
               OprTime:='1545';  --   Пятница или ПредПразд.день
          else
               OprTime:='1645';  --   Обычный день             
          end if;
   
   ELSIF  kkk_=5                          then  --- 3) ОблЕнерго
   
          if  peredsv=1  then
               OprTime:='1645';  --   Пятница или ПредПразд.день
          else
               OprTime:='1700';  --   Обычный день             
          end if;
   
   ELSIF  kkk_=8 or kkk_=11               then  --- 4) ОблГаз
                                                --- 5) Тепловики
          OprTime:='1700';               
   
   ELSE                                         --- 6) Другие кл.
          if peredsv=1   then  
             OprTime:='1600';       -- Пятница или ПредПразд.день
          else
             OprTime:='1700';  ----<-  БАЗОВОЕ опер.время             
          end if;
   
   END IF;

 ElsIf   gl.amfo = '352457'  then   -- 21. Херсон 
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ПФУ
   
     ---  if  trunc(PDAT_)=DKON_KV  then
     ---      OprTime:='2400';   --   Посл.раб.день Квартала
   
          if peredsv=1  then
              OprTime:='1630';   --   Пятница или ПредПразд.день
          else
              OprTime:='1700';   --   Обычный день            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) Укрпошта
   
          if  peredsv=1  then
               OprTime:='1600';  --   Пятница или ПредПразд.день
          else
               OprTime:='1700';  --   Обычный день             
          end if;
   
   ELSE                                         --- 3) Другие кл.
          if peredsv=1   then  
             OprTime:='1600';    --   Пятница или ПредПразд.день
          else
             OprTime:='1700';    ----<-  БАЗОВОЕ опер.время             
          end if;
   
   END IF;

 ElsIf   gl.amfo = '315784'  then   -- 22. Хмельницкий 
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ПФУ
   
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   Посл.раб.день Квартала
          elsif peredsv=1  then
              OprTime:='1630';   --   Пятница или ПредПразд.день
          else
              OprTime:='1700';   --   Обычный день            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) Укрпошта
   
          if  peredsv=1  then
               OprTime:='1600';  --   Пятница или ПредПразд.день
          else
               OprTime:='1700';  --   Обычный день             
          end if;
   
   ELSE                                         --- 3) Другие кл.
          if peredsv=1   then  
             OprTime:='1600';    --   Пятница или ПредПразд.день
          else
             OprTime:='1700';    ----<-  БАЗОВОЕ опер.время             
          end if;
   
   END IF;

 ElsIf   gl.amfo = '354507'  then   -- 23. Черкассы 
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ПФУ
      
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   Посл.раб.день Квартала
          elsif peredsv=1  then
              OprTime:='1630';   --   Пятница или ПредПразд.день
          else
              OprTime:='1700';   --   Обычный день            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) Укрпошта
   
          if  peredsv=1  then
               OprTime:='1600';  --   Пятница или ПредПразд.день
          else
               OprTime:='1700';  --   Обычный день             
          end if;
   
   ELSE                                         --- 3) Другие кл.
          
          if  peredsv=1  then
               OprTime:='1600';  --   Пятница или ПредПразд.день
          else
               OprTime:='1700';  ----<-  БАЗОВОЕ опер.время
          end if;
   
   END IF;

 ElsIf   gl.amfo = '356334'  then   -- 24. Черновцы 
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ПФУ
      
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   Посл.раб.день Квартала
          elsif peredsv=1  then
              OprTime:='1630';   --   Пятница или ПредПразд.день
          else
              OprTime:='1700';   --   Обычный день            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) Укрпошта
   
          if  peredsv=1  then
               OprTime:='1600';  --   Пятница или ПредПразд.день
          else
               OprTime:='1700';  --   Обычный день             
          end if;
   
   ELSE                                         --- 3) Другие кл.
          
          if  peredsv=1  then
               OprTime:='1600';  --   Пятница или ПредПразд.день
          else
               OprTime:='1700';  ----<-  БАЗОВОЕ опер.время             
          end if;
   
   END IF;

 ElsIf   gl.amfo = '300465'  then   -- 25. ГОУ   
 ----------------------------------------------------

   ----  Определяем ОКПО Клиента
   Begin
      Select c.OKPO Into okpo_
      From   Accounts a, Customer c
      Where  a.ACC=ACC_  and  a.RNK=c.RNK  and rownum=1;
   EXCEPTION  WHEN NO_DATA_FOUND THEN
      okpo_:='0';
   End;


   IF     okpo_='00035323' or
          kkk_ = 1                 then  --- 1)  ПФУ
   
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   Посл.раб.день Квартала
          elsif peredsv=1  then
              OprTime:='1630';   --   Пятница или ПредПразд.день
          else
              OprTime:='1700';   --   Обычный день
          end if;
   
   ELSIF  okpo_='21560766'         then  --- 2)  УКРТЕЛЕКОМ
   
          if  peredsv=1  then
               OprTime:='1630';  --   Пятница или ПредПразд.день
          else
               OprTime:='1730';  --   Обычный день
          end if;
   
   ELSIF  okpo_='00100227'         then  --- 3)  УКРЭНЕРГО
   
          if  peredsv=1  then
               OprTime:='1545';  --   Пятница или ПредПразд.день
          else
               OprTime:='1700';  --   Обычный день
          end if;
   
   ELSIF  okpo_ in ('21560045',          --- 4)  Укрпошта
                    '01181736',
                    '36282474'
                    )        or
          kkk_ = 2                 then
   
          if  peredsv=1  then
               OprTime:='1600';  --   Пятница или ПредПразд.день
          else
               OprTime:='1700';  --   Обычный день
          end if;
   
   ELSIF  okpo_='20077720'         then  --- 5)  НАФТОГАЗ  
   
          if  peredsv=1  then
               OprTime:='1630';  --   Пятница или ПредПразд.день
          else
               OprTime:='1730';  --   Обычный день
          end if;
   
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
                    
          if  peredsv=1  then
               OprTime:='1600';  --   Пятница или ПредПразд.день
          else
               OprTime:='1700';  --   Обычный день
          end if;
   
   ELSIF  okpo_ in ( '00034045',           --- 7)  УкрЗалiзниця  
                     '20078961',
                     '01073828',
                     '01071315',
                     '01072609',
                     '01074957',
                     '01059900' 
                    )              then
   
          if  peredsv=1  then
               OprTime:='1645';  --   Пятница или ПредПразд.день
          else
               OprTime:='1745';  --   Обычный день
          end if;
   
   ELSIF  okpo_='36425142'         then    --- 8)  ГЛОБАЛМАНІ 
   
          if  peredsv=1  then
               OprTime:='1630';  --   Пятница или ПредПразд.день
          else
               OprTime:='1730';  --   Обычный день
          end if;
   
   ELSIF  okpo_='31570412'         then    --- 9)  УКРТРАНСНАФТА 
   
          OprTime:='1700';  
   
   ELSE                                   --- 10)  Все другие кл.
          if peredsv=1   then
             OprTime:='1530';    --    Пятница или ПредПразд.день
          else
             OprTime:='1630';    --<-  БАЗОВОЕ опер.время
          end if;
   
   END IF;

 ElsIf   gl.amfo = '322669'  then   -- 26. Киев 
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ПФУ
      
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   Посл.раб.день Квартала
          elsif peredsv=1  then
              OprTime:='1630';   --   Пятница или ПредПразд.день
          else
              OprTime:='1700';   --   Обычный день            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) Укрпошта
   
          if  peredsv=1  then
               OprTime:='1600';  --   Пятница или ПредПразд.день
          else
               OprTime:='1700';  --   Обычный день             
          end if;
   
   ELSE                                         --- 3) Другие кл.
          
          if  peredsv=1  then
               OprTime:='1530';  --   Пятница или ПредПразд.день
          else
               OprTime:='1630';  ----<-  БАЗОВОЕ опер.время             
          end if;
   
   END IF;


 End If;


---============================================================

---  Установлено ли Индивид.Опер.Время по счету ?

 BEGIN

   SELECT trim(w.VALUE)
   INTO   OprTime1
   FROM   Accounts a, AccountsW w
   WHERE  a.ACC = w.ACC
      and w.TAG = 'OPTIME1'
      and a.ACC = ACC_ ;

   if OprTime1 is not NULL and 
      to_number(OprTime1)>=800 and to_number(OprTime1)<=2400 then 

      OprTime:=OprTime1;

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
      and a.ACC = ACC_ ;

   if peredsv=1  and  OprTime2 is not NULL and
      to_number(OprTime2)>=800 and to_number(OprTime2)<=2400 then

      OprTime:=OprTime2;

   end if;

 EXCEPTION WHEN OTHERS THEN
   null; 
 END;



-- if trunc(PDAT_)=to_date('12/10/2015','dd/mm/yyyy') and 
--    TT_ in ('IB1','IB2')    then
--
--    OprTime:='2400';       
--
-- end if;



-------- 2).  Расчет тарифа:  ------------------------------------------------ 



 -----   Исходящие PS1,PS2   -------------------- 

 If TT_ in ('PS1','PS2') and kod_<>15 then

    if n_tarpak in (14,15)  then        ---  Тепловики (ТП 14,15)
       sk_:=F_TARIF(283,kv_,nls_,s_);
       RETURN sk_;
    end if;

    if n_tarpak > 0         then        ---  Cчет "с пакетом"
       sk_:=F_TARIF(205,kv_,nls_,s_);
       RETURN sk_;
    end if;

 End if;


 -------    29 особых счетов ГОУ :  -------------

 IF n_tarpak = 0  and  gl.amfo = '300465'  then      

   If    nls_ in ('26007302163',                   
                  '26008501800',
                  '26007501942'  )    then 

      if kod_=15  then
         if  maket_=2 then
             RETURN 30;
         else 
             RETURN 0;
         end if;
      elsif  kod_<>15 and maket_=1 then
         RETURN 0;
      end if;

   ElsIf nls_ in ('26005501955'   ,
                  '26009501905712',
                  '26008301862'   ,
                  '260273011177'  ,
                  '260053011177'  ,
                  '260063011206'  ,
                  '260023011262'  ,
                  '26041303861'   ,
                  '260413011102'    ) then

      if kod_=15 and maket_=1 then
          RETURN 0;
      end if;

   ElsIf nls_ in ('260045011114'  ,
                  '26006501901980' )  then

      if kod_=15  then
         if maket_=2 then
            RETURN 30;
         else 
            RETURN 0;
         end if;
      end if;

   ElsIf nls_ = '26004301811'         then

      if kod_<>15 and maket_=1 then
          RETURN 0;
      end if;


   ElsIf nls_ in ('26049301768'   ,
                  '26048302768'   ,
                  '26041301830'   ,
                  '26007301863'   ,
                  '26046501914711',
                  '260483011174'  ,
                  '260313011176'  ,
                  '260033031203'  ,
                  '260023011233'  ,
                  '260033021284'  ,
                  '260023011369'  ,
                  '260003011389'  ,
                  '260003011428'   )  then

      if maket_=1 then
          RETURN 0;
      end if;

   ElsIf nls_ = '26004301811'         then

      if kod_=15 and maket_=1 then
          RETURN 25;
      end if;

   End If;

 END IF;

 -------------------------------------------



 if    kod_=13   then                     --  Папер.носiї

       If uz_=1  then   ---  "За межi ОБ"

          if to_char(PDAT_,'HH24MI') <= OprTime  OR  vvod_ = 1  then     
             sk_:=F_TARIF(13, kv_, nls_, s_);    --------------
          else
             sk_:=F_TARIF(16, kv_, nls_, s_);
          end if;

       Else             ---  "В межах ОБ"

          if to_char(PDAT_,'HH24MI') <= OprTime  OR  vvod_ = 1  then    
             sk_:=F_TARIF(113, kv_, nls_, s_);   --------------
          else
             sk_:=F_TARIF(116, kv_, nls_, s_);
          end if;

       End If;


 elsif kod_=14  then                      --  Клiєнт-Банк   

       If uz_=1  then       ---  "За межi ОБ"

          if to_char(PDAT_,'HH24MI') <= OprTime   then 
             sk_:=F_TARIF(14, kv_, nls_, s_);
          else
             sk_:=F_TARIF(17, kv_, nls_, s_);
          end if;

       Else                 ---  "В межах ОБ"

          if to_char(PDAT_,'HH24MI') <= OprTime   then 
             sk_:=F_TARIF(114, kv_, nls_, s_);
          else
             sk_:=F_TARIF(117, kv_, nls_, s_);
          end if;

       End If;


 else              -------  За вхiднi (kod_ = 15):


       IF    gl.amfo = '302076'             then   --  1. Винница 
       -----------------------------------------------------------
             BEGIN                   -- Если по счету проставлен спец.пар. NOT15 = 1
                SELECT  trim(VALUE)  -- "РО: Не брати плату за внутр.вхiднi", то за     
                into    not15_       -- внутренние входящие НЕ БЕРЕМ !                         
                FROM    AccountsW    
                WHERE   ACC=acc_ and TAG='NOT15';
             EXCEPTION  WHEN NO_DATA_FOUND THEN
                not15_:=NULL;
             END;
             
             if (not15_='1' and MFOA_=MFOB_)               OR 
                NVL(instr(D_REC_,'#T2.1.12.1.1#'),0) > 0   then
                   sk_:=0;
             else
                   sk_:=F_TARIF(15, kv_, nls_, s_);
             end if;


       ELSIF gl.amfo = '336503' and kkk_=1  then   -- 15. Ив-Франк
       -----------------------------------------------------------

             if to_char(PDAT_,'HH24MI') <= OprTime  then 
                  sk_:=F_TARIF(15, kv_, nls_, s_);
             else
                  sk_:=200;  ---<--  За Вхiднi на 2560 ПФУ после 17:00
             end if;                                       -----------


       ELSIF gl.amfo = '325796'             then   --  5. Львов
       -----------------------------------------------------------

             if NVL(instr(D_REC_,'#T2.1.12.1.1#'),0)>0 then
                sk_:=0;
             else
                if n_tarpak = 0  and  substr(nls_,1,4)='2620' then  -- Вхiднi на 2620/07 
                   if s_<=5000000 then
                      sk_:=s_*1/100;   --  s_ <= 50 тыс.грн - 1%, но не меньше 5 грн 
                      if sk_<500 then  
                         sk_:=500;
                      end if;
                   else
                      sk_:=s_*0.5/100; --  s_ >  50 тыс.грн - 0.5%
                   end if;
                else
                   sk_:=F_TARIF(15, kv_, nls_, s_);
                end if;
             end if;

       ELSE
       -----------------------------------------------------------

             if NVL(instr(D_REC_,'#T2.1.12.1.1#'),0)>0 then
                sk_:=0;
             else
                sk_:=F_TARIF(15, kv_, nls_, s_);
             end if;
             
       END IF;


 end if;

 RETURN sk_;


END f_tarif_rko ;
/

