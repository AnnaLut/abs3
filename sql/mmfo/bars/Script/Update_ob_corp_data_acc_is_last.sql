begin
for i in (select kf from mv_kf) loop
bc.go(i.kf);
update ob_corp_data_acc a
   set a.is_last = 0 
where (kf, fdat, corp_id, sess_id) not in
(select kf, fdat, corp_id, max(sess_id) from ob_corp_data_acc group by kf, fdat, corp_id)
and is_last = 1;
dbms_output.put_line('KF :'||i.kf||' Updated: '||sql%rowcount);
commit;
end loop;
bc.go('/');
exception when others then
bc.go('/');
raise;
end;
/