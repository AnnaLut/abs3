---========================================================================================

CREATE OR REPLACE FUNCTION BARS.PROC_MIN_MAX
                 ( 
                   S      NUMERIC,    -- сумма операции  (в КОП)
                   PR     NUMBER ,    -- % от суммы
                   S_MIN  NUMBER,     -- не менше ніж    (в ГРН.KOП )
                   S_MAX  NUMBER      -- не менше ніж    (в ГРН.KOП )
                 )       
----------------------------------------------------------------------------------------
--
--     Функция определяет % (PR) от суммы (S) с учетом ограничений S_MIN и S_MAX  
--                           
--  Для операции 470,471,472:   PR, S_MIN, S_MAX  - вводятся с экрана как доп.реквизиты операции
----------------------------------------------------------------------------------------

RETURN NUMERIC IS           
  sk_       NUMERIC ;   --  Cумма комиссии  (в КОП)
BEGIN

  sk_ := round(S*PR/100, 0) ;

  if S_MIN > 0  and  sk_ < S_MIN*100 then 
     sk_ := S_MIN*100 ;
  end if;

  if S_MAX > 0  and  sk_ > S_MAX*100 then 
     sk_ := S_MAX*100 ;
  end if;

  RETURN sk_ ;   
          
END PROC_MIN_MAX;
/

grant execute on PROC_MIN_MAX to START1;

