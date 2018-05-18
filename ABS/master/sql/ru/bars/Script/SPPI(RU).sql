----NEW SPPI
--ND_TXT
begin
tuda;
    insert into nd_txt
     (nd, tag, txt)
     select nd,'SPPI','връ' from nd_txt where tag='BUS_MOD' and txt in(1,6,7,8,9,10,11,12,14)
      and nd not in( select nd from nd_txt where tag='SPPI' and txt='връ');
   COMMIT;
end; 
/ 
--CP_REFW
begin 
tuda;
    insert into cp_refw
     (ref,tag,value)  
     select c.ref,'SPPI','ЭГ' from cp_refw c, cp_deal dd  where c.ref=dd.ref and tag='BUS_MOD' and value=4
     and c.ref not in (select ref from cp_refw where tag='SPPI');
   COMMIT;
end;  
/

begin 
tuda;
    insert into cp_refw
     (ref,tag,value)  
     select c.ref,'SPPI','връ' from cp_refw c, cp_deal dd  where c.ref=dd.ref and tag='BUS_MOD' and value in(3,5)
     and c.ref not in (select ref from cp_refw where tag='SPPI');
   COMMIT;
end;  
/

---bpk_parameters
begin 
tuda;
       insert into bpk_parameters (nd,tag,value)
        select nd,'SPPI','връ'  from (
              select nd,dat_close from w4_acc where dat_close is null 
              union all
              select nd,dat_close from bpk_acc where dat_close is null )
      where nd not in (select nd from bpk_parameters  where tag='SPPI' and value is not null);
  commit;
end;
/

-- accountsw 
--1111
begin
tuda;
     insert into accountsw
     (acc, tag, value)
     select acc,'SPPI','ЭГ' from accountsw where tag='BUS_MOD' and value=2 
      and acc not in (select acc from accountsw where tag='SPPI' and value='ЭГ');
    COMMIT;
end;  
/   
---22222
begin
tuda;
     insert into accountsw
     (acc, tag, value)
       select acc,'SPPI','връ' from accountsw where tag='BUS_MOD' and value=15 
       and acc not in (select acc from accountsw where tag='SPPI' and value='връ'); 
   COMMIT;
end;  
/ 
---- оЫ Accounts
begin
tuda;
     insert into accountsw
     (acc, tag, value)
     select acc,'SPPI','връ' from accountsw where tag='BUS_MOD' and value in(6,7,8,9,10,11,14)
       and acc not in (select acc from accountsw where tag='SPPI' and value='връ'); 
    COMMIT;
end;  
/  



