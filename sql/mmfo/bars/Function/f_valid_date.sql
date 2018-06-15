PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_valid_date.sql =========*** Run **
PROMPT ===================================================================================== 

create or replace function f_valid_date(
                              p_date in varchar2
                              , p_date_mask in varchar default 'dd/mm/yyyy'
                            ) return int deterministic parallel_enable
is
  l_date date;
begin
  l_date := to_date(p_date, p_date_mask);

  return 1;
exception
  when others then
    return 0;
end f_valid_date;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_valid_date.sql =========*** End **
PROMPT ===================================================================================== 