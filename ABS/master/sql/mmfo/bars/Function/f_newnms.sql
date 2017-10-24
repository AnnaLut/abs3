
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_newnms.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_NEWNMS (
   ACC2_ int,
   descrname_ varchar2,
   nbs_ char,
   RNK2_ int,
   IDD2_ varchar2 ) RETURN varchar2 IS

-- ACC_       - ACC счета для вычисления RNK (если RNK не известен)
-- Descrname_ - тип счета
-- Nbs_       - номер балансового счета
-- RNK_       - Регистрационный номер клиента
-- IDD_       - депозиты ??

-- функция получения наименования лицевого счета по типу счета

ACC_      number;
RNK_      number;
IDD_      varchar2(70);
NewNms_   varchar2(70);
SqlNms_   varchar2(2000);
sTmp_     varchar2(70);
refcur SYS_REFCURSOR;
ern CONSTANT POSITIVE   := 208; err EXCEPTION; erm VARCHAR2(80);

BEGIN
  ACC_ := ACC2_ ;
  RNK_ := RNK2_ ;
  IDD_ := IDD2_ ;
  BEGIN
    SELECT masknms, sqlnms INTO NewNms_, SqlNms_ FROM nlsmask
    WHERE maskid=descrname_;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    NewNms_ := '' ;
    SqlNms_ := '' ;
  END;
  IF NewNms_ is null and SqlNms_ is not null THEN
    IF ACC_ is not null and RNK_ is null THEN
      BEGIN
        SELECT rnk INTO RNK_ FROM cust_acc WHERE acc=ACC_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
        RNK_ := 0 ;
      END;
    END IF;
    SqlNms_ := Replace(SqlNms_, ':ACC', to_char(ACC_)) ;
    SqlNms_ := Replace(SqlNms_, ':RNK', to_char(RNK_)) ;
    SqlNms_ := Replace(SqlNms_, ':IDD', to_char(IDD_));
    SqlNms_ := Replace(SqlNms_, ':NBS', to_char(nbs_)) ;
    SqlNms_ := Replace(SqlNms_, ':TIP', to_char(descrname_)) ;
    OPEN refcur FOR SqlNms_ ;
    FETCH refcur INTO sTmp_ ;
    CLOSE refcur;
    NewNms_ := sTmp_ ;
  END IF;

  RETURN NewNms_;

END F_NEWNMS; 
 
/
 show err;
 
PROMPT *** Create  grants  F_NEWNMS ***
grant EXECUTE                                                                on F_NEWNMS        to ABS_ADMIN;
grant EXECUTE                                                                on F_NEWNMS        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_NEWNMS        to CUST001;
grant EXECUTE                                                                on F_NEWNMS        to START1;
grant EXECUTE                                                                on F_NEWNMS        to WR_ALL_RIGHTS;
grant EXECUTE                                                                on F_NEWNMS        to WR_VIEWACC;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_newnms.sql =========*** End *** =
 PROMPT ===================================================================================== 
 