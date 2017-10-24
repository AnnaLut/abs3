
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/atow2.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.ATOW2 (S1 varchar2)
RETURN VARCHAR2 IS
  kod_ VARCHAR2(250);
--
-- преобразует из DOS в WIN исходную строку
-- (например параметры из ARC_RRP)
-- для реестров
BEGIN
  begin
    select decode(sep.version(),1,
             translate(S1,sep.dos_,sep.win_),2, S1,S1) into kod_ from dual;
    EXCEPTION WHEN NO_DATA_FOUND THEN  kod_:='';
  end;
  RETURN kod_;
END ATOW2;
 
/
 show err;
 
PROMPT *** Create  grants  ATOW2 ***
grant EXECUTE                                                                on ATOW2           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on ATOW2           to RPBN001;
grant EXECUTE                                                                on ATOW2           to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/atow2.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 