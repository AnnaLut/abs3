------------------------------------------------------------------      
begin
tuda;
    insert into nd_txt
     (nd, tag, txt)
  select distinct nd,'IFRS','AC' from nd_txt where ((tag='BUS_MOD' and txt in(1,6,7,8,9,10,11,12,14) )or (tag='SPPI' and txt='връ')) 
       group by nd
       having count(*)>1
    and nd not in( select nd from nd_txt where tag='IFRS');  
      COMMIT;
end; 
/ 
----------------------------------------------------------         
begin 
tuda;
    insert into cp_refw
     (ref,tag,value)  
    select distinct c.ref,'IFRS','FVTPL/Other' from cp_refw c, cp_deal dd  where c.ref=dd.ref and ((tag='BUS_MOD' and value in(4)) or (tag='SPPI' and value='ЭГ'))
     group by c.ref
     having count(*)>1 
     and c.ref not in (select ref from cp_refw where tag='IFRS');
     COMMIT;
end;  
/

begin 
tuda;
    insert into cp_refw
     (ref,tag,value)  
    select distinct c.ref,'IFRS','FVOCI' from cp_refw c, cp_deal dd  where c.ref=dd.ref and ((tag='BUS_MOD' and value in(3,5)) or (tag='SPPI' and value='връ'))
     group by c.ref
     having count(*)>1 
     and c.ref not in (select ref from cp_refw where tag='IFRS');
     COMMIT;
end;  
/
------------------------------------------------------------------
--bpk_parameters
begin
tuda;
        insert  into bpk_parameters (nd,tag,value)
         select distinct b.nd,'IFRS','AC' from bpk_parameters b,
                                             (select distinct nd,acc_pk,dat_close from w4_acc where dat_close is null 
                                              union 
                                              select distinct nd,acc_pk,dat_close from bpk_acc where dat_close is null )a
                where b.nd = a.nd and b.nd not in( select nd from bars.bpk_parameters where tag='IFRS');                                
   commit;
end;
/
----------------------------------------------------------------       
begin
 tuda;
     insert into accountsw
     (acc, tag, value)
   select acc,'IFRS','FVTPL/Other' from accountsw where ((tag='BUS_MOD' and value=2) or (tag='SPPI' and value='ЭГ'))
       group by acc
       having count(*)>1  
  and acc not in (select acc from accountsw where tag='IFRS');       
 COMMIT;
end;  
/

begin
tuda;
     insert into accountsw
     (acc, tag, value)
   select acc,'IFRS','AC' from accountsw where ((tag='BUS_MOD' and value=15) or (tag='SPPI' and value='връ')) and kf=m.kf
       group by acc
        having count(*)>1  
  and acc not in (select acc from accountsw where tag='IFRS' and value='AC');       
 COMMIT;
end;  
/   
----------------------------------------------------------------          
---IFRS accountsw
begin
tuda;
    insert into accountsw
     (acc, tag, value)
     select a.acc,'IFRS','AC' from
       (select distinct acc from  accounts where dazs is null and nbs in ('1811','1819','2800','2801','2805','2806','2809','3548','3570','3578','3541','3710')
       union 
       select distinct acc  from  accounts where nbs in ('3540') and OB22 in (01,03) and dazs is null)a
   where a.acc not in (select acc from accountsw where tag='IFRS'); 
  commit;
  end;
/       
---- оЫ Accounts
begin
tuda;
     insert into accountsw
     (acc, tag, value)
      select distinct acc,'IFRS','AC' from accountsw where (tag='BUS_MOD' and value in(6,7,8,9,10,11,14) or (tag='SPPI' and value='връ'))
       group by acc
       having count(*)>1  
       and acc not in (select acc from accountsw where tag='IFRS'); 
    COMMIT;
end;  
/  




