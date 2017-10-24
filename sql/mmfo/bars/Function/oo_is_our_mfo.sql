
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/oo_is_our_mfo.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.OO_IS_OUR_MFO (MFO_ VARCHAR2) RETURN NUMBER IS
CNT_ NUMBER;
BEGIN
  SELECT COUNT(*) INTO CNT_ FROM BRANCH_MFO WHERE MFO=MFO_;
  RETURN CNT_;
END;
 
/
 show err;
 
PROMPT *** Create  grants  OO_IS_OUR_MFO ***
grant EXECUTE                                                                on OO_IS_OUR_MFO   to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/oo_is_our_mfo.sql =========*** End 
 PROMPT ===================================================================================== 
 