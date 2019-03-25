begin
for i in (select kf from mv_kf) loop
bc.go(i.kf);
update ob_corp_data_acc a
   set a.kod_analyt = lpad(a.kod_analyt, 2, '0')
where a.kod_analyt is not null and length(a.kod_analyt) = 1 and a.kf = i.kf;
dbms_output.put_line('KF :'||i.kf||' Updated: '||sql%rowcount);
commit;
end loop;
bc.go('/');
exception when others then
bc.go('/');
end;
/

