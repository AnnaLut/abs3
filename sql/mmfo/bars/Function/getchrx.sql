
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/getchrx.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GETCHRX (val NUMBER, nBase NUMBER ) RETURN VARCHAR2 IS

--================================================
--== Преобразование 10-ти ричного числа в nBase-ное =
--===============================================

res   VARCHAR2(10);
ost_  NUMBER;
int_  NUMBER;

BEGIN

  res:='';

  IF val<10 THEN
     RETURN to_char(val);
  END IF;

  int_:= trunc(val/nBase);
  ost_:=mod(val,nBase);

  WHILE int_ >=nBase LOOP

    res:= getchr(ost_)||res;

    ost_:=mod(int_,nBase);
    int_:=trunc(int_/nBase);

 END LOOP;

 res:= getchr(int_)||getchr(ost_)||res;

 dbms_output.put_line('After:='||res);
 RETURN res;

END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/getchrx.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 