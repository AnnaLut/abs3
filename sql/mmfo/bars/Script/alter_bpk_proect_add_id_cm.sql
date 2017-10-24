begin 
execute immediate'
alter table bpk_proect add id_cm number';
exception
 when others 
 then 
 if sqlcode = -1430 then null; 
 else raise;
 end if;
end;
/
begin
for lc_kf in (select kf from bars.mv_kf)
    loop
    bars.bc.go(lc_kf.kf);
        for z in ( select c.okpo, c.okpo_n,  id 
                       from v_cm_salary c)
          loop
             update bpk_proect
                set id_cm = z.id 
              where okpo = z.okpo and nvl(okpo_n,0) = nvl(z.okpo_n,0);
          end loop;
     end loop;
end;
/
commit;
/
begin
bars.bc.home;
end;
/
