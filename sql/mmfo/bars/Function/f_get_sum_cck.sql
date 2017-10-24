
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_sum_cck.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_SUM_CCK (CC_ID_ VARCHAR2,DAT1_ DATE)  RETURN NUMBER
IS

       NextPaySum number;
       NextPayDate date;


-- формируем платеж строго за сутки до дня погашения по БД
BEGIN
        NextPayDate:=F_GET_DATE_CCK (CC_ID_, DAT1_);

        if  cck_app.CorrectDate2(980,NextPayDate)= cck_app.CorrectDate2(980,gl.bd+1) then
            NextPaySum:= GET_INFO_SUM_EXT (CC_ID_, DAT1_ ,NextPayDate);
        else
           NextPaySum:=0;
        end if;

return NextPaySum;
END;
/
 show err;
 
PROMPT *** Create  grants  F_GET_SUM_CCK ***
grant EXECUTE                                                                on F_GET_SUM_CCK   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_GET_SUM_CCK   to RCC_DEAL;
grant EXECUTE                                                                on F_GET_SUM_CCK   to STO;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_sum_cck.sql =========*** End 
 PROMPT ===================================================================================== 
 