prompt *** start check_war_pension ***

declare 
cnt number;
cur_log_lvl number;
begin
bc.go('/');
select trunc((trunc (sysdate) - to_date('01.12.2016','DD.MM.YYYY'))/30) into cnt from dual;
cur_log_lvl := bars_audit.get_log_level;
bars_audit.set_log_level(p_loglevel => 8);

for rec in (select kf from mv_kf) loop
bc.go(rec.kf);
bars.dpt_pf.start_fill_contracts(cnt);
commit;
bars.dpt_pf.no_transfer_pf(1); 
commit;

end loop; 
bc.home;
bars_audit.set_log_level(cur_log_lvl);

end;
/

prompt *** end check_war_pension ***
