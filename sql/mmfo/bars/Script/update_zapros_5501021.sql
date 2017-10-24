update zapros set txt = 
'select x.dat, x.nd, x.nbs, x.nls, x.kv, x.nls_ost, x.ir, x.br, x.ir_br, x.bdat, x.stp_dat, x.prc
     , round((x.nls_ost/(add_months(trunc(x.dat, ''yyyy''),12) - trunc(x.dat, ''yyyy'')))/100*x.prc,4) as prc_nar
from 
(
select ac.caldt_date as dat, d.nd, a.acc as acc_nls, a.nbs, a.nls, a.kv, abs(fost(a.acc, ac.caldt_date)/100) as nls_ost
     , prc.acc, prc.ir, prc.br, getbrat(ac.caldt_date,prc.br,a.kv,1) as ir_br, prc.bdat
     , ia.stp_dat
     , case when ia.stp_dat is not NULL and nvl(ia.stp_dat,ac.caldt_date) < ac.caldt_date then 0
            else (case when prc.br is null then prc.ir else getbrat(ac.caldt_date,prc.br,a.kv,1)*nvl(prc.ir,1) end)
            end as prc
from cc_deal d, nd_acc n, accounts a, ACCM_CALENDAR ac
   , (select i.acc, i.ir, i.br, i.bdat from int_ratn i where i.id=2) prc
   , int_accn ia
where d.nd=n.nd and n.acc=a.acc
  and a.nbs in (''2207'',''2237'',''2209'',''2239'')
  and a.tip <> ''SNA''
  and ac.caldt_date between to_date(:zDate1,''dd.mm.yyyy'') and to_date(:zDate2,''dd.mm.yyyy'')
  and a.acc=prc.acc
  and prc.bdat=(select max(bdat) from int_ratn where id=2 and acc=a.acc and bdat<=ac.caldt_date)
  and ia.acc=prc.acc
  and ia.id=2
  and a.daos<=to_date(:zDate2,''dd.mm.yyyy'')
  and (a.dazs is NULL or a.dazs>=to_date(:zDate1,''dd.mm.yyyy''))
  and d.nd=:nd --205507
order by a.acc, ac.caldt_date  
) x' where kodz = 5501021;

commit;