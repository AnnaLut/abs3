
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_dates_for_snap.sql =========*** Run 
 PROMPT ===================================================================================== 
 
create or replace function get_dates_for_snap(date_from in date,
                                              date_to   in date)
  return t_snap_dates as
  res t_snap_dates;
begin
  select nvl(f.fdat,
                                 (select fdat
                                    from fdat
                                   where fdat > norm_dat
                                     and rownum = 1))
    bulk collect
    into res
    from (select date_from + level - 1 as norm_dat
          from dual
        connect by level <= date_to -
                   date_from + 1) t, fdat f
    where t.norm_dat = f.fdat(+);

  return res;
end get_dates_for_snap;

/
 show err;
grant EXECUTE                                   on t_snap_dates       to WR_ALL_RIGHTS;
grant EXECUTE                                   on t_snap_dates       to BARS_ACCESS_DEFROLE;
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_dates_for_snap.sql =========*** End 
 PROMPT ===================================================================================== 
 