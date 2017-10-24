
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/beforebankdate.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.BEFOREBANKDATE (today_dat date) RETURN varchar2 IS
DATB_ varchar2(10);
DATD_ date;
ern  CONSTANT POSITIVE := 1; erm  VARCHAR2(80); err  EXCEPTION;
-- последняя банковская дата перед текущей
-- используем для конструирования назначения платежа в перекрытиях
BEGIN
 DATD_:=null;
 DATB_:='';
 BEGIN
	SELECT max(fdat) INTO DATD_  FROM fdat
	WHERE fdat<today_dat;
	EXCEPTION WHEN NO_DATA_FOUND THEN DATD_:=null;
 END;
deb.trace(ern, '1',to_char(DATD_,'dd-mm-yyyy'));
if DATD_ is not null then DATB_:=to_char(DATD_,'dd-mm-yyyy'); end if;
deb.trace(ern, '2',DATB_);
RETURN DATB_;
END beforebankdate;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/beforebankdate.sql =========*** End
 PROMPT ===================================================================================== 
 