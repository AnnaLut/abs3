
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/c_mon.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.C_MON (
  sP1_ VARCHAR2,  --TAG доп.реквизита
  sP2_ VARCHAR2,  --значение доп.реквизита
  nP3_ number,    -- сумма операции
  nP4_ number )   -- код валюты
 RETURN NUMBER IS
  n1_ int;
 BEGIN
  n1_:= 1;
  begin

   if SP1_ IN ('B_MNZ','B_MZP','B_MFK') then
      -- ПЛОХО, если  проблемы с выбором из справочника
      select CENA_BANKA *100 into n1_ from  v_BANK_MON
      where SUBSTR(DR_B_MON_NZP( kod ),1,4) = SUBSTR(sP2_,1,4) ;
      -- ПЛОХО, если
         -- введенный вес меньше веса одного слитка или
         -- не кратен весу слитка
         bars_audit.trace('C_MON SP1_ = '||SP1_ ||'  sP2_= '||sP2_||' nP3_= '||to_char(nP3_)||' nP4_='||to_char(nP4_) );
      if nP3_ < N1_ or mod(nP3_, N1_) <> 0 then  return 0; end if;
 ----------
   end if;

   RETURN 1;
  exception when others then RETURN 0;
  end ;
 END C_MON; 
/
 show err;
 
PROMPT *** Create  grants  C_MON ***
grant EXECUTE                                                                on C_MON           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on C_MON           to PYOD001;
grant EXECUTE                                                                on C_MON           to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/c_mon.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 