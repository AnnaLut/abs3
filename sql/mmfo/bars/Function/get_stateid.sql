
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_stateid.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_STATEID (DAT_ DATE, FLAG_ NUMBER DEFAULT 0 ) return NUMBER
IS
  cur_date DATE;
BEGIN
  IF flag_=0 THEN
    cur_date := TO_DATE( TO_CHAR(DAT_, 'dd/mm/yyyy') || ' 13:00:00', 'dd/mm/yyyy hh24:mi:ss' );
    IF DAT_ > cur_date THEN
      RETURN 2;
    ELSE
      RETURN 1;
    END IF;
  ELSIF flag_=1 THEN
    cur_date := TO_DATE( TO_CHAR(DAT_, 'dd/mm/yyyy') || ' 14:30:00', 'dd/mm/yyyy hh24:mi:ss' );
	IF DAT_ < cur_date THEN
	  RETURN 1;
	END IF;
    cur_date := TO_DATE( TO_CHAR(DAT_, 'dd/mm/yyyy') || ' 17:30:00', 'dd/mm/yyyy hh24:mi:ss' );
	IF DAT_ > cur_date THEN
	  RETURN 3;
	END IF;
    RETURN 2;
  END IF;
END GET_STATEID;
 
/
 show err;
 
PROMPT *** Create  grants  GET_STATEID ***
grant EXECUTE                                                                on GET_STATEID     to J_EXE;
grant EXECUTE                                                                on GET_STATEID     to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_stateid.sql =========*** End **
 PROMPT ===================================================================================== 
 