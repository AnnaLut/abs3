
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_cp_get_hierarchy.sql =========***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CP_GET_HIERARCHY (p_id INT, p_dat DATE)
   RETURN INT
AS
   l_hierarchy_id   INT;
BEGIN
  begin
    SELECT hierarchy_id
      INTO l_hierarchy_id
      FROM cp_hierarchy_hist
     WHERE (cp_id, fdat) = (  SELECT cp_id, MAX (fdat)
                                FROM cp_hierarchy_hist
                               WHERE fdat <= p_dat
                                 AND CP_ID = p_id
                            GROUP BY cp_id);
  exception when no_data_found
             then
               begin
                SELECT hierarchy_id
                  INTO l_hierarchy_id
                  FROM cp_hierarchy_hist
                 WHERE (cp_id, fdat) = (  SELECT cp_id, min (fdat)
                                            FROM cp_hierarchy_hist
                                           WHERE fdat >= p_dat
                                             AND CP_ID = p_id
                                        GROUP BY cp_id);   
               exception when no_data_found then null;
               end;
  end;

   RETURN l_hierarchy_id;
END f_cp_get_hierarchy;
/
 show err;
 
PROMPT *** Create  grants  F_CP_GET_HIERARCHY ***
grant EXECUTE                                                                on F_CP_GET_HIERARCHY to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_cp_get_hierarchy.sql =========***
 PROMPT ===================================================================================== 
 