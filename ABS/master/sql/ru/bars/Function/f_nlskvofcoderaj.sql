
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_nlskvofcoderaj.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_NLSKVOFCODERAJ (nls_ in varchar2, kv_ in number) return number is
  res number;
begin
    res := -1;
    BEGIN
        SELECT CODERAJ INTO RES FROM (
            SELECT F_BRANCHTOCODERAJ(A.BRANCH) CODERAJ, ROW_NUMBER() OVER (ORDER BY DAZS) NPP
            FROM ACCOUNTS A
            WHERE A.NLS LIKE nls_ AND A.KV = kv_
        ) WHERE NPP <= 1;
        EXCEPTION WHEN NO_DATA_FOUND THEN RETURN -1;
    END;
    RETURN RES;    
end f_NlsKvOfCodeRaj; 
/
 show err;
 
PROMPT *** Create  grants  F_NLSKVOFCODERAJ ***
grant EXECUTE                                                                on F_NLSKVOFCODERAJ to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_nlskvofcoderaj.sql =========*** E
 PROMPT ===================================================================================== 
 