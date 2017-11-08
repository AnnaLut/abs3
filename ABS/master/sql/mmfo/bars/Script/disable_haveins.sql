begin
for c in (select * from mv_kf)
loop
bc.go(c.kf);
update w4_card set haveins = 0 where haveins = 1;
end loop;
bc.home;
end;
/

commit;