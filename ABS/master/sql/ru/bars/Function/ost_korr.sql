 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/ost_korr.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.OST_KORR 
  --  
(p_acc number, -- ACC счета
 p_dat date  , -- Дата типа 31 число          31.MM.YYYY
 p_di  number, -- номер даты месячного снимка 01.MM.YYYY, за который делаем отчет
 p_nbs char    -- бал.счет - т.к. не все счета есть в мес.снимках
) return number is

  DI_ NUMBER;
  s_ number :=0;

BEGIN
   If p_dat >= trunc(sysdate) then     -- остатки на текущую дату
      begin
        select ostc into s_ from accounts where acc=p_acc;
      EXCEPTION WHEN NO_DATA_FOUND THEN null;
      end;
      return s_;
   end if;

   If    p_di    > 0  then DI_ :=  p_DI    ;
   elsIf z23.DI_ > 0  then DI_ :=  z23.DI_ ;
   else                    DI_ :=  to_char ( trunc(p_dat,'MM'), 'J' ) - 2447892 ;  z23.DI_ := DI_;
   end if;

   RETURN snp.fost(p_acc, DI_, 1, 7 );

END ost_korr;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/ost_korr.sql =========*** End *** =
 PROMPT ===================================================================================== 
 