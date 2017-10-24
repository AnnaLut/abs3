
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/last_rko.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.LAST_RKO (today_dat date) RETURN date IS
DATL_ varchar2(10);
--
-- используем для конструирования назначения платежа в перекрытиях
-- вычисляет последний банковский день предыдущего месяца
BEGIN
 BEGIN
SELECT max(fdat)  INTO DATL_
    FROM fdat
    WHERE
to_number(to_char(fdat,'MM'))=decode(to_char(today_dat,'MM'),'01',12,
                          to_number(to_char(today_dat,'MM'))-1) AND
	      fdat<(SELECT max(fdat) FROM fdat
		  WHERE to_number(to_char(fdat,'MM'))=
                        decode(to_number(to_char(today_dat,'MM')),1,12,
                        to_number(to_char(today_dat,'MM'))-1));
	EXCEPTION WHEN NO_DATA_FOUND THEN DATL_:='';
 END;
RETURN DATL_;
END LAST_RKO; 
 
/
 show err;
 
PROMPT *** Create  grants  LAST_RKO ***
grant EXECUTE                                                                on LAST_RKO        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/last_rko.sql =========*** End *** =
 PROMPT ===================================================================================== 
 