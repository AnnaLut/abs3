---1111111111111
begin
tuda;
     insert into nd_txt
     (nd, tag, txt)
      select distinct dd.nd,'BUS_MOD',1 from cc_deal dd, nd_acc na,accounts a where dd.nd=na.nd and na.acc=a.acc and a.dazs is null
      and nbs in ('1500', '1502', '1510','1513','1520', '1521', '1522', '1524', '1211', '1212') and dd.SOS <>15
  and dd.nd not in( select nd from nd_txt where tag='BUS_MOD');
   COMMIT;
end; 
/
---222222222222222
begin
     insert into accountsw
     (acc, tag, value)
     select a.acc,'BUS_MOD',2 from  accounts a where a.nbs in ('3040', '3041', '3042','3043','3044') and a.dazs is null
  and a.acc not in (select acc from accountsw where tag='BUS_MOD');
 COMMIT;
end;  
/
--÷œ--3333333333333333333333333
begin 
tuda;
     insert into accountsw
     (acc, tag, value)
  select cp.ref,'BUS_MOD',3  from cp_deal cp, accounts a where cp.acc=a.acc and cp.dazs is null and 
        substr(a.nls,1,4) in (1410, 1420, 1430, 1440, 1411, 1421)
        and cp.ref not in (select ref from cp_refw where tag='BUS_MOD');
   COMMIT;
 end;  
/
--÷œ--44444444444444444444444444
begin 
tuda;
   insert into cp_refw
    (ref,tag,value) 
    select cp.ref,'BUS_MOD',4 from cp_deal cp, accounts a where cp.acc=a.acc and cp.dazs is null and 
    substr(a.nls,1,4) in (1400, 1401, 1402, 3010, 3011, 3012, 3013, 3014)
    and cp.ref not in (select ref from cp_refw where tag='BUS_MOD');
   COMMIT;
end;  
/
--÷œ--5555555555555555555555555555
begin 
tuda;
    insert into cp_refw
     (ref,tag,value)  
    select cp.ref,'BUS_MOD',5 from cp_deal cp, accounts a where cp.acc=a.acc and cp.dazs is null and 
      substr(a.nls,1,4) in (1412, 1413, 1414, 1422, 1423, 1424, 3110, 3111, 3112, 3113, 3114, 3210, 3211, 3212, 3213, 3214, 3102, 3103, 3105)
      and cp.ref not in (select ref from cp_refw where tag='BUS_MOD');
 COMMIT;
end;  
/

---666666666666666666666666666
begin
    insert into nd_txt
     (nd, tag, txt)
    select distinct dd.nd,'BUS_MOD',6 from cc_deal dd, nd_acc na,accounts a where dd.nd=na.nd and na.acc=a.acc and a.dazs is null and dd.SOS <>15
      and a.rnk in ( select cw.rnk from  customerw cw,customer c ,KL_K110 k1 where k1.K110=c.ved and cw.tag='BUSSL' and cw.value='1' and c.date_off is null 
      and cw.rnk=c.rnk and k1.k111 in('35'))
      and a.nbs in ('2020','2030','2060','2063','2071','2083','2103','2113','2123','2133')	  
     and dd.nd not in( select nd from nd_txt where tag='BUS_MOD');
 COMMIT;
end; 
/
----777777777777777777777
begin
tuda;
    insert into nd_txt
     (nd, tag, txt)
    select distinct dd.nd,'BUS_MOD',7 from cc_deal dd, nd_acc na,accounts a where dd.nd=na.nd and na.acc=a.acc and a.dazs is null and dd.SOS <>15
      and a.rnk in (select cw.rnk from  customerw cw,customer c ,KL_K110 k1 where k1.K110=c.ved and cw.tag='BUSSL' and cw.value='1' and c.date_off is null 
      and cw.rnk=c.rnk and k1.k111 in('41','42','43','49','50','51','52'))
      and a.nbs in ('2020','2030','2060','2063','2071','2083','2103','2113','2123','2133')
     and dd.nd not in( select nd from nd_txt where tag='BUS_MOD');
 COMMIT;
end; 
/
---88888888888888888
begin
tuda;
    insert into nd_txt
     (nd, tag, txt)
    select distinct dd.nd,'BUS_MOD',8  from cc_deal dd, nd_acc na,accounts a where dd.nd=na.nd and na.acc=a.acc and a.dazs is null and dd.SOS <>15
      and a.rnk in (select cw.rnk from  customerw cw,customer c,KL_K110 k1  where k1.K110=c.ved and cw.tag='BUSSL' and cw.value='1' and c.date_off is null 
      and cw.rnk=c.rnk and k1.k111 in('01','02','03','10','11','12'))   
      and a.nbs in ('2020', '2030','2060','2063','2071','2083','2103','2113','2123','2133')
  and dd.nd not in( select nd from nd_txt where tag='BUS_MOD');
 COMMIT;
end; 
/
---9999999
begin
tuda;
    insert into nd_txt
     (nd, tag, txt)
     select distinct dd.nd,'BUS_MOD',9 from cc_deal dd, nd_acc na,accounts a where dd.nd=na.nd and na.acc=a.acc and a.dazs is null and dd.SOS <>15
      and a.rnk in (select cw.rnk from  customerw cw,customer c  where ((cw.tag='BUSSS' and cw.value='21') or (cw.tag='BUSSL' and cw.value='2')) 
      and c.date_off is null and cw.rnk=c.rnk
       group by cw.rnk
       having count(*)>1) 
       and a.nbs in ('2020','2030','2060','2063','2071','2083','2103','2113','2123','2133')
       and dd.nd not in( select nd from nd_txt where tag='BUS_MOD');
 COMMIT;
end; 
/
----10101010
begin
tuda;
    insert into nd_txt
     (nd, tag, txt)
    select distinct dd.nd,'BUS_MOD',10 from cc_deal dd, nd_acc na,accounts a where dd.nd=na.nd and na.acc=a.acc and a.dazs is null  and dd.SOS <>15
      and a.rnk in (select cw.rnk from  customerw cw,customer c  where ((cw.tag='BUSSS' and cw.value='22') or (cw.tag='BUSSL' and cw.value='2')) 
      and c.date_off is null and cw.rnk=c.rnk
      group by cw.rnk
      having count(*)>1) 
      and a.nbs in ('2020','2030','2060','2063','2071','2083','2103','2113','2123','2133')
     and dd.nd not in( select nd from nd_txt where tag='BUS_MOD');
 COMMIT;
end; 
/
----11111111111111
begin
tuda;
    insert into nd_txt
     (nd, tag, txt)
   select distinct dd.nd, 'BUS_MOD',11 from cc_deal dd, nd_acc na,accounts a where dd.nd=na.nd and na.acc=a.acc and a.dazs is null  and dd.SOS <>15
      and a.rnk in (select cw.rnk from  customerw cw,customer c  where ((cw.tag='BUSSS' and cw.value='23') or (cw.tag='BUSSL' and cw.value='2')) 
      and c.date_off is null and cw.rnk=c.rnk
      group by cw.rnk
      having count(*)>1) 
      and a.nbs in ('2020','2030','2060','2063','2071','2083','2103','2113','2123','2133')
      and dd.nd not in( select nd from nd_txt where tag='BUS_MOD');
    COMMIT;
end; 
/
--121212121212
begin
tuda;
    insert into nd_txt
     (nd, tag, txt)
     select nd,'BUS_MOD',12 from cc_deal where vidd in (11,12,13) and SOS <>15
     and nd not in( select nd from nd_txt where tag='BUS_MOD');
  COMMIT;
end; 
/
--131313131313
begin
tuda;
      INSERT  INTO bpk_parameters  
       select nd, 'BUS_MOD', 13  from(
       select distinct nd,acc_pk,dat_close from w4_acc where dat_close is null 
       union 
       select distinct  nd,acc_pk,dat_close from bpk_acc where dat_close is null)t
       where t.nd not in( select nd from bars.bpk_parameters where tag='BUS_MOD');
 COMMIT;
end;
/
----1414141411414
begin
tuda;
    insert into nd_txt
     (nd, tag, txt)
  select distinct dd.nd,'BUS_MOD',14 from cc_deal dd, nd_acc na,accounts a where dd.nd=na.nd and na.acc=a.acc and a.dazs is null and dd.SOS <>15
      and a.rnk in (select cw.rnk from  customerw cw,customer c,KL_K110 k1 where k1.K110=c.ved and cw.tag='BUSSL' and cw.value='1' and c.date_off is null 
      and cw.rnk=c.rnk and k1.k111 not in('01','02','03','10','11','12','35','41','42','43','49','50','51','52')) 
      and a.nbs in ('2020','2030','2060','2063','2071','2083','2103','2113','2123','2133')
      and dd.nd not in( select nd from nd_txt where tag='BUS_MOD');
 COMMIT;
end; 
/
----1515151515
begin
tuda;
     insert into accountsw
     (acc, tag, value)
     select distinct a.acc,'BUS_MOD',15 from
      (select acc from  accounts   where dazs is null and (nbs in (1811,1819,2800,2801,2805,2806,2809,3548,3570,3578,3541,3710) or (nbs=3540 and OB22 in 	(01,03))))a
       where a.acc not in (select acc from accountsw  where tag='BUS_MOD');
 COMMIT;
end;  
/
--- acc_over
---666666666666666666666666666
begin
tuda;
    insert into accountsw
     (acc, tag, value)
  select o.acc,'BUS_MOD',6
    from accounts a, acc_over o
   where o.acc = a.acc
     and a.dazs is null
     and a.rnk in (select cw.rnk
                     from customerw cw, customer c, KL_K110 k1
                    where k1.K110 = c.ved
                      and cw.tag = 'BUSSL'
                      and cw.value = '1'
                      and c.date_off is null
                      and cw.rnk = c.rnk
                      and k1.k111 in ('35'))
      and o.acc not in( select acc from accountsw where tag='BUS_MOD');
    COMMIT;
end; 
/
----777777777777777777777
begin 
tuda;
   insert into accountsw
     (acc, tag, value)    
  select o.acc,'BUS_MOD',7
  from accounts a, acc_over o
  where o.acc = a.acc
  and a.dazs is null
  and a.rnk in
       (select cw.rnk
          from customerw cw, customer c, KL_K110 k1
         where k1.K110 = c.ved
           and cw.tag = 'BUSSL'
           and cw.value = '1'
           and c.date_off is null
           and cw.rnk = c.rnk
           and k1.k111 in ('41', '42', '43', '49', '50', '51', '52'))
      and o.acc not in( select acc from accountsw where tag='BUS_MOD');
    COMMIT;
end; 
/
---88888888888888888
begin 
tuda;
      insert into accountsw
        (acc, tag, value)    
  select o.acc,'BUS_MOD',8
   from accounts a, acc_over o
    where o.acc = a.acc
    and a.dazs is null
    and a.rnk in ( select cw.rnk from  customerw cw,customer c,KL_K110 k1  where k1.K110=c.ved and cw.tag='BUSSL' and cw.value='1' and c.date_off is null 
    and cw.rnk=c.rnk and k1.k111 in('01','02','03','10','11','12'))
    and o.acc not in( select acc from accountsw where tag='BUS_MOD');
      COMMIT;
end; 
/
---9999999
begin 
tuda;
     insert into accountsw
     (acc, tag, value)    
    select distinct o.acc,'BUS_MOD',9
    from accounts a, acc_over o
     where o.acc = a.acc
     and a.dazs is null
     and a.rnk in (select cw.rnk from  customerw cw,customer c  where ((cw.tag='BUSSS' and cw.value='21') or (cw.tag='BUSSL' and cw.value='2')) 
     and c.date_off is null and cw.rnk=c.rnk
     group by cw.rnk
     having count(*)>1)
     and o.acc not in(select acc from accountsw where tag='BUS_MOD');
  COMMIT;
end; 
/
----10101010
begin 
tuda;
     insert into accountsw
     (acc, tag, value)    
    select distinct o.acc,'BUS_MOD',10
    from accounts a, acc_over o
    where o.acc = a.acc
    and a.dazs is null
    and a.rnk in (select cw.rnk from  customerw cw,customer c  where ((cw.tag='BUSSS' and cw.value='22') or (cw.tag='BUSSL' and cw.value='2')) 
    and c.date_off is null and cw.rnk=c.rnk
    group by cw.rnk
    having count(*)>1)  
    and o.acc not in(select acc from accountsw where tag='BUS_MOD');
   COMMIT;
end; 
/
----11111111111111
begin 
tuda;
    insert into accountsw
     (acc, tag, value)    
  select distinct o.acc,'BUS_MOD',11
      from accounts a, acc_over o
      where o.acc = a.acc
      and a.dazs is null
      and a.rnk in (select cw.rnk from  customerw cw,customer c  where ((cw.tag='BUSSS' and cw.value='23') or (cw.tag='BUSSL' and cw.value='2')) 
      and c.date_off is null and cw.rnk=c.rnk
      group by cw.rnk
      having count(*)>1) 
      and a.acc not in(select acc from accountsw where tag='BUS_MOD');
     COMMIT;
end; 
/      
 ----1414141411414
begin 
tuda;
    insert into accountsw
     (acc, tag, value)  
     select distinct o.acc,'BUS_MOD',14
     from accounts a, acc_over o
     where o.acc = a.acc
     and a.dazs is null
     and a.rnk in (select cw.rnk from  customerw cw,customer c,KL_K110 k1 where k1.K110=c.ved and cw.tag='BUSSL' and cw.value='1' and c.date_off is null 
     and cw.rnk=c.rnk and k1.k111 not in('01','02','03','10','11','12','35','41','42','43','49','50','51','52'))
     and a.acc not in(select acc from accountsw where tag='BUS_MOD');
   COMMIT;
end; 
/  