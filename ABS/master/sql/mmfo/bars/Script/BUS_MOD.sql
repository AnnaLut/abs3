---1111111111111
begin
for m in (select kf from mv_kf)
  loop
    bc.go (m.kf);
  for n in ( select distinct dd.nd from cc_deal dd, nd_acc na,accounts a where dd.nd=na.nd and na.acc=a.acc and a.dazs is null
      and nbs in ('1500', '1502', '1510', '1512', '1513', '1514','1520', '1521', '1522', '1523', '1524', '1211', '1212') and dd.SOS <>15)
      loop
      CCK_APP.Set_ND_TXT (n.nd, p_tag =>'BUS_MOD' ,p_TXT=>1);
      end loop;
      end loop;
      end; 
/
COMMIT;
---222222222222222
begin
for m in (select kf from mv_kf)
  loop
    bc.go (m.kf);
  for n in (select a.acc from  accounts a where a.nbs in ('3040', '3041', '3042',3043,3044) and a.dazs is null)
      loop
      accreg.setAccountwParam (n.acc, p_tag =>'BUS_MOD' ,p_val=>2);
      end loop;
      end loop;
      end;  
/
COMMIT;
--ÖÏ--3333333333333333333333333
begin 
for k in (select kf from mv_kf )
  loop
    bc.go (k.kf);
    for n in (select cp.ref from cp_deal cp, accounts a where cp.acc=a.acc and cp.dazs is null and 
      substr(a.nls,1,4) in (1410, 1420, 1430, 1440, 1411, 1421))
      loop
    cp.cp_set_tag(n.ref ,p_tag =>'BUS_MOD',p_value =>3 ,p_type =>3);
      end loop;
      end loop;
      end;  
/
COMMIT;
--ÖÏ--44444444444444444444444444
begin 
for k in (select kf from mv_kf )
  loop
      bc.go (k.kf);
    for n in (select cp.ref from cp_deal cp, accounts a where cp.acc=a.acc and cp.dazs is null and 
      substr(a.nls,1,4) in (1400, 1401, 1402, 3010, 3011, 3012, 3013, 3014))
      loop
       cp.cp_set_tag(n.ref,p_tag=>'BUS_MOD',p_value =>4,p_type=>3);
      end loop;
      end loop;
      end;
/
COMMIT;
--ÖÏ--5555555555555555555555555555
begin 
for k in (select kf from mv_kf )
  loop
     bc.go (k.kf);
    for n in (select cp.ref from cp_deal cp, accounts a where cp.acc=a.acc and cp.dazs is null and 
      substr(a.nls,1,4) in (1412, 1413, 1414, 1422, 1423, 1424, 3110, 3111, 3112, 3113, 3114, 3210, 3211, 3212, 3213, 3214))
      loop
      cp.cp_set_tag(n.ref,p_tag=>'BUS_MOD',p_value=>5,p_type=>3);
      end loop;
      end loop;
      end;
/
COMMIT;

---666666666666666666666666666
begin 
for k in (select kf from mv_kf)
  loop
     bc.go (k.kf);
    for n in (select distinct dd.nd from cc_deal dd, nd_acc na,accounts a where dd.nd=na.nd and na.acc=a.acc and a.dazs is null and dd.SOS <>15
      and a.rnk in ( select cw.rnk from  customerw cw,customer c ,KL_K110 k1 where k1.K110=c.ved and cw.tag='BUSSL' and cw.value='1' and c.date_off is null 
      and cw.rnk=c.rnk and k1.k111 in('35'))
      and a.nbs in ('2020', '2030', '2060', '2062', '2063', '2071',
             '2082','2083','2102','2103','2112','2113','2122','2123','2132','2133'))
             loop
      CCK_APP.Set_ND_TXT (n.nd ,p_TAG =>'BUS_MOD' ,p_TXT =>6);
      end loop;
      end loop;
      end;
/
COMMIT;
----777777777777777777777
begin 
for k in (select kf from mv_kf )
  loop
     bc.go (k.kf);
    for n in (select distinct dd.nd from cc_deal dd, nd_acc na,accounts a where dd.nd=na.nd and na.acc=a.acc and a.dazs is null and dd.SOS <>15
      and a.rnk in (select cw.rnk from  customerw cw,customer c ,KL_K110 k1 where k1.K110=c.ved and cw.tag='BUSSL' and cw.value='1' and c.date_off is null 
      and cw.rnk=c.rnk and k1.k111 in('41','42','43','49','50','51','52'))
      and a.nbs in ('2020', '2030', '2060', '2062', '2063', '2071',
             '2082','2083','2102','2103','2112','2113','2122','2123','2132','2133'))
             loop
      CCK_APP.Set_ND_TXT (n.nd ,p_TAG =>'BUS_MOD' ,p_TXT =>7);
      end loop;
      end loop;
      end;
/
COMMIT;
---88888888888888888
begin 
for k in (select kf from mv_kf )
  loop
     bc.go (k.kf);
    for n in (select distinct dd.nd from cc_deal dd, nd_acc na,accounts a where dd.nd=na.nd and na.acc=a.acc and a.dazs is null and dd.SOS <>15
      and a.rnk in (select cw.rnk from  customerw cw,customer c,KL_K110 k1  where k1.K110=c.ved and cw.tag='BUSSL' and cw.value='1' and c.date_off is null 
      and cw.rnk=c.rnk and k1.k111 in('1','2','3','10','11','12'))   
      and a.nbs in ('2020', '2030', '2060', '2062', '2063', '2071',
             '2082','2083','2102','2103','2112','2113','2122','2123','2132','2133'))
             loop
      CCK_APP.Set_ND_TXT (n.nd ,p_TAG =>'BUS_MOD' ,p_TXT =>8);
      end loop;
      end loop;
        bc.home;
      end;
/
COMMIT;
---9999999
begin 
for k in (select kf from mv_kf )
  loop
     bc.go (k.kf);
    for n in (select distinct dd.nd from cc_deal dd, nd_acc na,accounts a where dd.nd=na.nd and na.acc=a.acc and a.dazs is null and dd.SOS <>15
      and a.rnk in (select cw.rnk from  customerw cw,customer c  where ((cw.tag='BUSSS' and cw.value='21') or (cw.tag='BUSSL' and cw.value='2')) 
      and c.date_off is null and cw.rnk=c.rnk
       group by cw.rnk
       having count(*)>1) 
       and a.nbs in ('2020', '2030', '2060', '2062', '2063', '2071',
             '2082','2083','2102','2103','2112','2113','2122','2123','2132','2133'))
             loop
      CCK_APP.Set_ND_TXT (n.nd ,p_TAG =>'BUS_MOD' ,p_TXT =>9);
      end loop;
      end loop;
      end;
/
COMMIT;
----10101010
begin 
for k in (select kf from mv_kf )
  loop
     bc.go (k.kf);
    for n in (select distinct dd.nd from cc_deal dd, nd_acc na,accounts a where dd.nd=na.nd and na.acc=a.acc and a.dazs is null  and dd.SOS <>15
      and a.rnk in (select cw.rnk from  customerw cw,customer c  where ((cw.tag='BUSSS' and cw.value='22') or (cw.tag='BUSSL' and cw.value='2')) 
      and c.date_off is null and cw.rnk=c.rnk
      group by cw.rnk
      having count(*)>1) 
      and a.nbs in ('2020', '2030', '2060', '2062', '2063', '2071',
             '2082','2083','2102','2103','2112','2113','2122','2123','2132','2133'))
             loop
      CCK_APP.Set_ND_TXT (n.nd ,p_TAG =>'BUS_MOD' ,p_TXT =>10);
      end loop;
      end loop;
      end;
/
COMMIT;
----11111111111111
begin 
for k in (select kf from mv_kf )
  loop
     bc.go (k.kf);
    for n in (select distinct dd.nd from cc_deal dd, nd_acc na,accounts a where dd.nd=na.nd and na.acc=a.acc and a.dazs is null  and dd.SOS <>15
      and a.rnk in (select cw.rnk from  customerw cw,customer c  where ((cw.tag='BUSSS' and cw.value='23') or (cw.tag='BUSSL' and cw.value='2')) 
      and c.date_off is null and cw.rnk=c.rnk
      group by cw.rnk
      having count(*)>1) 
      and a.nbs in ('2020', '2030', '2060', '2062', '2063', '2071',
             '2082','2083','2102','2103','2112','2113','2122','2123','2132','2133'))
             loop
      CCK_APP.Set_ND_TXT (n.nd ,p_TAG =>'BUS_MOD' ,p_TXT =>11);
      end loop;
      end loop;
      end;
/
COMMIT;
--121212121212
begin
for m in (select kf from mv_kf)
  loop
    bc.go (m.kf);
  for n in (select nd from cc_deal where vidd in (11,12,13) and SOS <>15) 
            loop
      CCK_APP.Set_ND_TXT (n.nd, p_tag =>'BUS_MOD' ,p_txt=>12); 
  end loop;
end loop;
end;  
/
COMMIT;
--131313131313
begin
for m in (select kf from mv_kf)
  loop
    bc.go (m.kf);
  for n in (select nd from (
       select nd,dat_close from w4_acc
       union all
       select nd,dat_close from bpk_acc)t
       where not exists (select nd from 
                                (select nd, dat_close from w4_acc
                                  union all
                                  select nd,dat_close from bpk_acc)i
                                  where i.nd=t.nd and i.dat_close is not null))
     loop
     bars_ow.set_bpk_parameter(n.nd, p_tag =>'BUS_MOD' ,p_value=>13); 
      end loop;
      end loop;
      end; 
/
COMMIT;
----14141414114141
begin 
for k in (select kf from mv_kf )
  loop
     bc.go (k.kf);
    for n in (select distinct dd.nd from cc_deal dd, nd_acc na,accounts a where dd.nd=na.nd and na.acc=a.acc and a.dazs is null and dd.SOS <>15
      and a.rnk in (select cw.rnk from  customerw cw,customer c,KL_K110 k1 where k1.K110=c.ved and cw.tag='BUSSL' and cw.value='1' and c.date_off is null 
      and cw.rnk=c.rnk and k1.k111 not in('1','2','3','10','11','12','35','41','42','43','49','50','51','52')) 
      and a.nbs in ('2020', '2030', '2060', '2062', '2063', '2071',
             '2082','2083','2102','2103','2112','2113','2122','2123','2132','2133'))
             loop
      CCK_APP.Set_ND_TXT (n.nd ,p_TAG =>'BUS_MOD' ,p_TXT =>14);
      end loop;
      end loop;
      end;
/
COMMIT;
----1515151515
begin
for m in (select kf from mv_kf)
  loop
    bc.go (m.kf);
  for n in (select acc from  accounts where dazs is null and nbs in ('1811', '1812', '1819', '2800', '2801', '2802', '2805', '2806', '2809', '3548', '3570', '3578', '3541', '3710'))
      loop
      accreg.setAccountwParam (n.acc, p_tag =>'BUS_MOD' ,p_val=>15);
      end loop;
      end loop;
      bc.home;
      end; 
/
COMMIT;

---CC_DEAL VIDD=110 join acc_over Îâåðäðàôò
---666666666666666666666666666
begin 
for k in (select kf from mv_kf )
  loop
     bc.go (k.kf);
    for n in (  select dd.nd
    from cc_deal dd, nd_acc na, accounts a
   where dd.nd = na.nd
     and na.acc = a.acc
     and a.dazs is null
     and dd.SOS <> 15
     and a.rnk in (select cw.rnk
                     from customerw cw, customer c, KL_K110 k1
                    where k1.K110 = c.ved
                      and cw.tag = 'BUSSL'
                      and cw.value = '1'
                      and c.date_off is null
                      and cw.rnk = c.rnk
                      and k1.k111 in ('35'))
     and dd.vidd = '110'
  union 
  select o.nd
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
                      and k1.k111 in ('35')))
                  loop
      CCK_APP.Set_ND_TXT (n.nd ,p_TAG =>'BUS_MOD' ,p_TXT =>6);
      end loop;
      end loop;
      end;
/
COMMIT;
----777777777777777777777
begin 
for k in (select kf from mv_kf )
  loop
     bc.go (k.kf);
    for n in (select dd.nd
  from cc_deal dd, nd_acc na, accounts a
  where dd.nd = na.nd
   and na.acc = a.acc
   and a.dazs is null
   and dd.SOS <> 15
   and dd.vidd = '110'
   and a.rnk in
       (select cw.rnk
          from customerw cw, customer c, KL_K110 k1
         where k1.K110 = c.ved
           and cw.tag = 'BUSSL'
           and cw.value = '1'
           and c.date_off is null
           and cw.rnk = c.rnk
           and k1.k111 in ('41', '42', '43', '49', '50', '51', '52'))
 union
 select o.nd
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
           and k1.k111 in ('41', '42', '43', '49', '50', '51', '52')))
             loop
      CCK_APP.Set_ND_TXT (n.nd ,p_TAG =>'BUS_MOD' ,p_TXT =>7);
      end loop;
      end loop;
      end;
/
COMMIT;
---88888888888888888
begin 
for k in (select kf from mv_kf )
  loop
     bc.go (k.kf);
    for n in (select distinct dd.nd from cc_deal dd, nd_acc na,accounts a where dd.nd=na.nd and na.acc=a.acc and a.dazs is null and dd.SOS <>15 and dd.vidd = '110'
      and a.rnk in (select cw.rnk from  customerw cw,customer c,KL_K110 k1  where k1.K110=c.ved and cw.tag='BUSSL' and cw.value='1' and c.date_off is null 
      and cw.rnk=c.rnk and k1.k111 in('1','2','3','10','11','12'))
   union 
   select o.nd
    from accounts a, acc_over o
   where o.acc = a.acc
     and a.dazs is null
     and a.rnk in ( select cw.rnk from  customerw cw,customer c,KL_K110 k1  where k1.K110=c.ved and cw.tag='BUSSL' and cw.value='1' and c.date_off is null 
      and cw.rnk=c.rnk and k1.k111 in('1','2','3','10','11','12')))
             loop
      CCK_APP.Set_ND_TXT (n.nd ,p_TAG =>'BUS_MOD' ,p_TXT =>8);
      end loop;
      end loop;
        bc.home;
      end;
/
COMMIT;
---9999999
begin 
for k in (select kf from mv_kf )
  loop
     bc.go (k.kf);
    for n in (select distinct dd.nd from cc_deal dd, nd_acc na,accounts a where dd.nd=na.nd and na.acc=a.acc and a.dazs is null and dd.SOS <>15 and dd.vidd = '110'
      and a.rnk in (select cw.rnk from  customerw cw,customer c  where ((cw.tag='BUSSS' and cw.value='21') or (cw.tag='BUSSL' and cw.value='2')) 
      and c.date_off is null and cw.rnk=c.rnk
      group by cw.rnk
      having count(*)>1)
        union 
  select o.nd
    from accounts a, acc_over o
   where o.acc = a.acc
     and a.dazs is null
     and a.rnk in (select cw.rnk from  customerw cw,customer c  where ((cw.tag='BUSSS' and cw.value='21') or (cw.tag='BUSSL' and cw.value='2')) 
     and c.date_off is null and cw.rnk=c.rnk
     group by cw.rnk
     having count(*)>1))
             loop
      CCK_APP.Set_ND_TXT (n.nd ,p_TAG =>'BUS_MOD' ,p_TXT =>9);
      end loop;
      end loop;
      end;
/
COMMIT;
----10101010
begin 
for k in (select kf from mv_kf )
  loop
     bc.go (k.kf);
    for n in (select dd.nd from cc_deal dd, nd_acc na,accounts a where dd.nd=na.nd and na.acc=a.acc and a.dazs is null  and dd.SOS <>15  and  dd.vidd='110'
      and a.rnk in (select cw.rnk from  customerw cw,customer c  where ((cw.tag='BUSSS' and cw.value='22') or (cw.tag='BUSSL' and cw.value='2')) 
      and c.date_off is null and cw.rnk=c.rnk
      group by cw.rnk
     having count(*)>1) 
    union 
    select o.nd
    from accounts a, acc_over o
   where o.acc = a.acc
     and a.dazs is null
     and a.rnk in (select cw.rnk from  customerw cw,customer c  where ((cw.tag='BUSSS' and cw.value='22') or (cw.tag='BUSSL' and cw.value='2')) 
      and c.date_off is null and cw.rnk=c.rnk
      group by cw.rnk
     having count(*)>1))  
             loop
      CCK_APP.Set_ND_TXT (n.nd ,p_TAG =>'BUS_MOD' ,p_TXT =>10);
      end loop;
      end loop;
      end;
/
COMMIT;
----11111111111111
begin 
for k in (select kf from mv_kf )
  loop
     bc.go (k.kf);
    for n in (select distinct dd.nd from cc_deal dd, nd_acc na,accounts a where dd.nd=na.nd and na.acc=a.acc and a.dazs is null  and dd.SOS <>15 and dd.vidd='110'
      and a.rnk in (select cw.rnk from  customerw cw,customer c  where ((cw.tag='BUSSS' and cw.value='23') or (cw.tag='BUSSL' and cw.value='2')) 
      and c.date_off is null and cw.rnk=c.rnk
      group by cw.rnk
     having count(*)>1) 
      union 
    select o.nd
    from accounts a, acc_over o
   where o.acc = a.acc
     and a.dazs is null
     and a.rnk in (select cw.rnk from  customerw cw,customer c  where ((cw.tag='BUSSS' and cw.value='23') or (cw.tag='BUSSL' and cw.value='2')) 
      and c.date_off is null and cw.rnk=c.rnk
      group by cw.rnk
     having count(*)>1)) 
             loop
      CCK_APP.Set_ND_TXT (n.nd ,p_TAG =>'BUS_MOD' ,p_TXT =>11);
      end loop;
      end loop;
      end;
/
COMMIT;      
 ----1414141411414
begin 
for k in (select kf from mv_kf )
  loop
     bc.go (k.kf);
    for n in (select distinct dd.nd from cc_deal dd, nd_acc na,accounts a where dd.nd=na.nd and na.acc=a.acc and a.dazs is null and dd.SOS <>15 and  dd.vidd='110'
      and a.rnk in (select cw.rnk from  customerw cw,customer c,KL_K110 k1 where k1.K110=c.ved and cw.tag='BUSSL' and cw.value='1' and c.date_off is null 
      and cw.rnk=c.rnk and k1.k111 not in('1','2','3','10','11','12','35','41','42','43','49','50','51','52')) 
      union
      select o.nd
    from accounts a, acc_over o
   where o.acc = a.acc
     and a.dazs is null
     and a.rnk in (select cw.rnk from  customerw cw,customer c,KL_K110 k1 where k1.K110=c.ved and cw.tag='BUSSL' and cw.value='1' and c.date_off is null 
      and cw.rnk=c.rnk and k1.k111 not in('1','2','3','10','11','12','35','41','42','43','49','50','51','52')))
             loop
      CCK_APP.Set_ND_TXT (n.nd ,p_TAG =>'BUS_MOD' ,p_TXT =>14);
      end loop;
      end loop;
      end; 
/
COMMIT;
      