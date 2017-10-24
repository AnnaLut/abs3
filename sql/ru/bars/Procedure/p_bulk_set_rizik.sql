create or replace procedure bars.p_bulk_set_rizik(p_filter in varchar2)
  is
l_kf varchar2(6) := f_ourmfo;
l_upd_statement varchar2(4000);
begin
  l_upd_statement := q'[Insert into BARS.CUSTOMERW_UPDATE (  RNK,     TAG,   VALUE, ISP, CHGDATE, CHGACTION,    DONEBY,                      IDUPD, kf)
  select rnk, 'RIZIK', rizik, 0, sysdate, 2, user_name, bars_sqnc.get_nextval('s_customerw_update', :l_kf), :l_kf from V_CUSTOMER_RIZIK
  where ]' || p_filter;
  execute immediate l_upd_statement using l_kf, l_kf;
end;
/
grant all on bars.p_bulk_set_rizik to bars_access_defrole;
