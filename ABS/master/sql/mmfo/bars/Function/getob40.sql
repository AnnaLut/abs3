
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/getob40.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GETOB40 (Nlsd_ VARCHAR2, Nlsk_ VARCHAR2)
RETURN  VARCHAR2 IS
  ob40_	VARCHAR2(4);

BEGIN
  BEGIN
    SELECT ob40 INTO ob40_
    FROM scheme_1c
    WHERE nbsdb=Nlsd_ AND nbskd=Nlsk_;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    BEGIN
      SELECT ob40 INTO ob40_
      FROM scheme_1c
      WHERE nbsdb=Nlsd_ AND nbskd=substr(Nlsk_,1,4);
    EXCEPTION WHEN NO_DATA_FOUND THEN
      BEGIN
        SELECT ob40 INTO ob40_
        FROM scheme_1c
        WHERE nbsdb=substr(Nlsd_,1,4) AND nbskd=Nlsk_;
      EXCEPTION WHEN NO_DATA_FOUND THEN
        BEGIN
          SELECT ob40 INTO ob40_
          FROM scheme_1c
          WHERE nbsdb=substr(Nlsd_,1,4) AND nbskd=substr(Nlsk_,1,4);
        EXCEPTION WHEN NO_DATA_FOUND THEN
          ob40_ := '';
        END;
      END;
    END;
  END;
  RETURN ob40_;
END;
/
 show err;
 
PROMPT *** Create  grants  GETOB40 ***
grant EXECUTE                                                                on GETOB40         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GETOB40         to SBB_LZ;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/getob40.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 