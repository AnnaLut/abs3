
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ======= Scripts /Sql/BARS/type/t_snap_dates.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.t_snap_dates AS TABLE OF DATE;
/

 show err;
 
PROMPT *** Create  grants  t_snap_dates ***
grant EXECUTE                                   on t_snap_dates       to WR_ALL_RIGHTS;
grant EXECUTE                                   on t_snap_dates       to BARS_ACCESS_DEFROLE;
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ======= Scripts /Sql/BARS/type/t_snap_dates.sql =========*** End *** ====
 PROMPT ===================================================================================== 