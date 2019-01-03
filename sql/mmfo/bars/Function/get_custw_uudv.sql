CREATE OR REPLACE FUNCTION BARS.get_custw_uudv (p_rnk customer.rnk%type, p_tag customerw.tag%type) RETURN number IS
 l_dv number;

begin
   begin
      SELECT  CASE WHEN REGEXP_LIKE(value,'^[ |.|,|0-9]+$')
                   THEN 0+REPLACE(REPLACE(value ,' ',''),',','.')
                   ELSE 0 END
                   INTO l_dv
      FROM customerw WHERE rnk = p_rnk AND trim(tag) = p_tag;
   EXCEPTION WHEN OTHERS THEN l_dv := 0;
   END;
   return l_dv;
end;

/
 show err;
 
PROMPT *** Create  grants  get_custw_uudv ***
grant EXECUTE       on get_custw_uudv  to BARS_ACCESS_DEFROLE;
grant EXECUTE       on get_custw_uudv  to START1;

