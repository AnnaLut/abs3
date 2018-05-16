begin
for m in (select kf from mv_kf)loop
    bc.go (m.kf);    
  for t8 in( select  distinct dd.nd from cc_deal dd, nd_acc na,accounts a,nd_txt t where dd.nd=na.nd and na.acc=a.acc and a.dazs is null and dd.SOS <> 15 
      and a.rnk in (select cw.rnk from  customerw cw,customer c,KL_K110 k1 where k1.K110=c.ved and cw.tag='BUSSL' and cw.value='1' and c.date_off is null 
      and cw.rnk=c.rnk and k1.k111 in('01','02','03')) 
      and a.nbs in ('2020','2030','2060','2063','2071','2083','2103','2113','2123','2133')
    and dd.nd=t.nd and  t.tag='BUS_MOD' and t.txt=14) loop
        update nd_txt set txt=8 where nd=t8.nd and tag='BUS_MOD';
        end loop;
      end loop;
      COMMIT;
end; 
/