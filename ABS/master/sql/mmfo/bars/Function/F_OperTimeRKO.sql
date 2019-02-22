CREATE OR REPLACE FUNCTION BARS.F_OperTimeRKO
                 ( 
ACC_         NUMBER,
PDAT_        DATE,
OprTime1_    CHAR,        -- БАЗОВОЕ 1  (обычные дни)
OprTime2_    CHAR,        -- БАЗОВОЕ 2  (пятница и предпраздничные)
bussl_       CHAR,        -- Бізнес-напрямок  ( 1 - КБ, 2 - ММСБ )
TT_          CHAR
                 )       
RETURN varchar2 IS       
  OprTime1_ind   varchar2(4);   --  индивидуальное 1
  OprTime2_ind   varchar2(4);   --  индивидуальное 2
  OprT1_         varchar2(4);   --  
  OprT2_         varchar2(4);   --  
  nn             integer    ;
  OprTime        varchar2(4);   --  Результирующее
---------------------------------------------------------------------------
--                      Модуль "Плата за РО", для отчета 335
--                     --------------------------------------
--   Функция определения ОперВремени.
--
--  Для счетов КБ  :  БАЗОВОЕ время (передается) 
--  Для счетов ММСБ:  ПН 001,002,PKR,MM2 - 14:00     
--                    IB%, CL%           - 17:00
--------------------------------------------------------------------------- 
BEGIN

  OprT1_  :=  OprTime1_ ;      -- БАЗОВОЕ 1
  OprT2_  :=  OprTime2_ ;      -- БАЗОВОЕ 2


  If bussl_ = '2'  and  gl.amfo in ('353553','325796')  and  trunc(PDAT_) >= to_date('01/03/2019','dd/mm/yyyy')  then     ---  ММСБ 

     If TT_ like 'IB%' or TT_ like 'CL%' then   ---  Кл-Банк
         ----OprT1_  :=  '1700' ;      
         ----OprT2_  :=  '1700' ;   
         NULL;
     Else                                       ---  ПН
        OprT1_  :=  '1400' ;      
        OprT2_  :=  '1400' ;      
     End If;

  End If;


  BEGIN      
    SELECT trim(w.VALUE)
    INTO   OprTime1_ind
    FROM   Accounts a, AccountsW w
    WHERE  a.ACC = w.ACC
       and w.TAG = 'OPTIME1'
       and a.ACC = ACC_ ;

    if OprTime1_ind is not NULL and to_number(OprTime1_ind)>=800 and to_number(OprTime1_ind)<=2400 then 
       OprT1_ := OprTime1_ind;   --   Обычный день
    end if;
  EXCEPTION WHEN OTHERS THEN
    null; 
  END;
  
  BEGIN      
    SELECT trim(w.VALUE)
    INTO   OprTime2_ind
    FROM   Accounts a, AccountsW w
    WHERE  a.ACC = w.ACC
       and w.TAG = 'OPTIME2'
       and a.ACC = ACC_ ;
  
    if OprTime2_ind is not NULL and to_number(OprTime2_ind)>=800 and to_number(OprTime2_ind)<=2400 then 
       OprT2_ := OprTime2_ind;   --   Пятница или предпразд.
    end if;
  EXCEPTION WHEN OTHERS THEN
    null; 
  END;
 

  Select count(*) into nn  
  from   HOLIDAY  
  where  trunc(PDAT_+1)=HOLIDAY and KV=980 ;

  if  nn = 0  then               
      OprTime :=  OprT1_ ;   --   Обычный день
  else 
      OprTime :=  OprT2_ ;   --   Пятница
  end if;

  RETURN OprTime ;


END F_OperTimeRKO ;
/
grant execute on F_OperTimeRKO to START1;

