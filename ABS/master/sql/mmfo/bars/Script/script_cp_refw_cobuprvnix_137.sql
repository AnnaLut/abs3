prompt для accp bus_mod
  begin 
for k in (select kf from mv_kf )
  loop
    bc.go (k.kf);
    insert into cp_refw
     (ref,tag,value)  
       select distinct  cp.ref,'BUS_MOD',5 from cp_deal cp, accounts a where cp.accp=a.acc and cp.dazs is null and 
      substr(a.nls,1,4) in (3102, 3103, 3105)
      and cp.ref not in (select ref from cp_refw where tag='BUS_MOD');
      end loop;
     COMMIT;
end;  
/

Prompt SPPI
begin 
for k in (select kf from mv_kf )
  loop
    bc.go (k.kf);
    insert /*+ignore_row_on_dupkey_index(cp_refw XPK_CPREFW) */into cp_refw
     (ref,tag,value)  
    select c.ref,'SPPI','Так' from cp_refw c, cp_deal dd  where c.ref=dd.ref and tag='BUS_MOD' and value=5;
   end loop;
  COMMIT;
end;  
/

Prompt IFRS
begin 
for k in (select kf from mv_kf )
  loop
    bc.go (k.kf);
    insert into cp_refw
     (ref,tag,value)  
    select c.ref,'IFRS','FVOCI' from cp_refw c, cp_deal dd  where c.ref=dd.ref and ((tag='BUS_MOD' and value in(3,5)) or (tag='SPPI' and value='Так'))
                            group by c.ref
                             having count(*)>1
     and c.ref not in (select ref from cp_refw where tag='IFRS');
   end loop;
COMMIT;
bc.home;
end;  
/