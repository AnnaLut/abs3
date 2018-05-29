declare
l_cou number;
l_err varchar2(100);
begin  
mgr_utl.p_ref_constraints_disable('SKRYNKA_ND');
l_err := '';
------------------SKRYNKA_ND_322669_ND
l_err := 'SKRYNKA_ND_322669_ND';
select count(*) into l_cou from SKRYNKA_ND t 
where t.kf = '322669' and t.nd <= 180036459
   and substr(t.nd,-2) not in (select tt.ru from kf_ru tt where tt.kf = t.kf);

if l_cou>0 then
update SKRYNKA_ND t
set t.nd = t.nd * 100 + 11
where t.kf = '322669' and t.nd <= 180036459;
dbms_output.put_line('Updated '||sql%rowcount||' rows in table SKRYNKA_ND for kf 322669');
end if;

------------------SKRYNKA_ATTORNEY_322669_ND
l_err := 'SKRYNKA_ATTORNEY_322669_ND';
select count(*) into l_cou from SKRYNKA_ATTORNEY t 
where t.kf = '322669' and t.nd <= 180036459
   and substr(t.nd,-2) not in (select tt.ru from kf_ru tt where tt.kf = t.kf);

if l_cou>0 then
update SKRYNKA_ATTORNEY t
set t.nd = t.nd * 100 + 11
where t.kf = '322669' and t.nd <= 180036459;
dbms_output.put_line('Updated '||sql%rowcount||' rows in table SKRYNKA_ATTORNEY for kf 322669');
end if;

------------------SKRYNKA_ND_REF_322669_ND
l_err := 'SKRYNKA_ND_REF_322669_ND';
select count(*) into l_cou from SKRYNKA_ND_REF t 
where t.kf = '322669' and t.nd <= 180036459
   and substr(t.nd,-2) not in (select tt.ru from kf_ru tt where tt.kf = t.kf);

if l_cou>0 then
update SKRYNKA_ND_REF t
set t.nd = t.nd * 100 + 11
where t.kf = '322669' and t.nd <= 180036459;
dbms_output.put_line('Updated '||sql%rowcount||' rows in table SKRYNKA_ND_REF for kf 322669');
end if;

------------------SKRYNKA_VISIT_322669_ND
l_err := 'SKRYNKA_VISIT_322669_ND';
select count(*) into l_cou from SKRYNKA_VISIT t 
where t.kf = '322669' and t.nd <= 180036459
   and substr(t.nd,-2) not in (select tt.ru from kf_ru tt where tt.kf = t.kf);

if l_cou>0 then
update SKRYNKA_VISIT t
set t.nd = t.nd * 100 + 11
where t.kf = '322669' and t.nd <= 180036459;
dbms_output.put_line('Updated '||sql%rowcount||' rows in table SKRYNKA_VISIT for kf 322669');
end if;

------------------SKRYNKA_ND_ARC_322669_ND
l_err := 'SKRYNKA_ND_ARC_322669_ND';
select count(*) into l_cou from SKRYNKA_ND_ARC t 
where t.kf = '322669' and t.nd <= 180036459
   and substr(t.nd,-2) not in (select tt.ru from kf_ru tt where tt.kf = t.kf);

if l_cou>0 then
update SKRYNKA_ND_ARC t
set t.nd = t.nd * 100 + 11
where t.kf = '322669' and t.nd <= 180036459;
dbms_output.put_line('Updated '||sql%rowcount||' rows in table SKRYNKA_ND_ARC for kf 322669');
end if;

------------------SKRYNKA_ND_ACC_322669_ND
l_err := 'SKRYNKA_ND_ACC_322669_ND';
select count(*) into l_cou from SKRYNKA_ND_ACC t 
where t.kf = '322669' and t.nd <= 180036459
   and substr(t.nd,-2) not in (select tt.ru from kf_ru tt where tt.kf = t.kf);

if l_cou>0 then
update SKRYNKA_ND_ACC t
set t.nd = t.nd * 100 + 11
where t.kf = '322669' and t.nd <= 180036459;
dbms_output.put_line('Updated '||sql%rowcount||' rows in table SKRYNKA_ND_ACC for kf 322669');
end if;
------------- 
commit;

mgr_utl.p_ref_constraints_enable('SKRYNKA_ND');

exception when others then
  dbms_output.put_line('Error('||l_err||'): '||sqlerrm);
  mgr_utl.p_ref_constraints_enable('SKRYNKA_ND');
end;
/
