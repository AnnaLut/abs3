
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/dynfiltnextid.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.DYNFILTNEXTID RETURN  NUMBER IS
BEGIN
  FOR c IN
   ( SELECT filter_id + 1 as newid FROM dyn_filter o1
     WHERE NOT EXISTS ( SELECT filter_id FROM dyn_filter
                        WHERE filter_id=o1.filter_id + 1)) LOOP
     RETURN c.newid;
     EXIT;
  END LOOP;
END;
/
 show err;
 
PROMPT *** Create  grants  DYNFILTNEXTID ***
grant EXECUTE                                                                on DYNFILTNEXTID   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DYNFILTNEXTID   to START1;
grant EXECUTE                                                                on DYNFILTNEXTID   to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/dynfiltnextid.sql =========*** End 
 PROMPT ===================================================================================== 
 