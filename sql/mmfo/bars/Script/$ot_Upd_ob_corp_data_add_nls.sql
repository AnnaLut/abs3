begin
for i in (select kf from mv_kf) loop
bc.go(i.kf);
update OB_CORP_DATA_ACC cd set cd.nbs = substr(cd.nls, 1, 4);
dbms_output.put_line('KF :'||i.kf||' Updated: '||sql%rowcount);
commit;
update OB_CORP_DATA_DOC cd set cd.nbsa = substr(cd.nlsa, 1, 4), cd.nbsb = substr (cd.nlsb, 1, 4);
dbms_output.put_line('KF :'||i.kf||' Updated: '||sql%rowcount);
commit;
end loop;
bc.go('/');
dbms_stats.gather_table_stats ('BARS','OB_CORP_DATA_ACC', estimate_percent => 5, cascade => true);
dbms_stats.gather_table_stats ('BARS','OB_CORP_DATA_DOC', estimate_percent => 5, cascade => true);
exception when others then
bc.go('/');
raise;
end;
/
