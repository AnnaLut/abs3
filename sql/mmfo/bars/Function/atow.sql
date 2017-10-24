
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/atow.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.ATOW (S1 varchar2)
RETURN VARCHAR2 IS
  kod_ VARCHAR2(250);
--
-- преобразует из DOS в WIN исходную строку
-- (например поля  ARC_RRP)
BEGIN
  begin
    select translate(S1,sep.dos_,sep.win_) into kod_ from dual;
    EXCEPTION WHEN NO_DATA_FOUND THEN  kod_:='';
  end;
  RETURN kod_;
END ATOW;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/atow.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 