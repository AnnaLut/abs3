

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_MBK_DSW.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_MBK_DSW ***

  CREATE OR REPLACE PROCEDURE BARS.P_MBK_DSW (p_dat date)
is
begin

delete from TMP_MBK_DSW_REP;

insert into TMP_MBK_DSW_REP (ord, nd, ntik, mb, tipd, id, dat1, dat2, rnk, kv,  S, ir, nls)
select                  1 as ord, nd, ntik, mb, tipd, id, dat1, dat2, rnk, kv,  S, ir, nls
from (
 select m.ND,
        m.cc_id ntik,
        1 MB,
        m.tipd,
        k.id,
        m.sdate DAT1,
        m.wdate DAT2,
        m.rnk,
        a.kv,
        m.S,
        m.IR,
        a.nls
                  from (select d.nd, d.cc_id, d.sdate, d.wdate, d.rnk, v.tipd, ad.accs, ABS(fost(ad.accs,NVL(p_dat,gl.bd))) S, acrn.fprocn(ad.accs,(v.tipd-1), gl.bd) IR  --  acrn.fprocn(ad.accs,(v.tipd-1),d.sdate) IR
                        from cc_deal d, cc_add ad, CC_VIDD v
                        where d.sdate <= NVL(p_dat,gl.bd) and d.wdate>NVL(p_dat,gl.bd) and d.nd=ad.nd and ad.adds=0 and d.vidd=v.vidd and fost(ad.accs,NVL(p_dat,gl.bd))<>0
                       ) m,
                       accounts a, ani331 k
                  where a.acc= m.accs and  substr(a.nls,1,4)= k.nbs and k.id not in (3,6,7,8,9,10,11)
                  UNION ALL
                  select r.tag1,
                         x1.ntik,
                         2,
                         2,
                         CASE WHEN DAT_NEXT_U(X1.dat_A,1)=X2.dat_B THEN 21 ELSE 22 END,
                         x1.dat_a,
                         x2.dat_b,
                         x1.rnk,
                         x1.kva,
                         x1.suma,
                         acrn.fprocn(x2.ACC9b,1,x2.dat_b),
                         ''
                  from (select swap_tag TAG1, min(deal_tag) tag2, count(*) from fx_deal where swap_tag>0 and swap_tag<>deal_tag group by swap_tag having count(*)>1) r,
                       (select f.* from fx_deal f, oper o where f.ref=o.ref and o.sos > 0 ) x1,
                       (select f.* from fx_deal f, oper o where f.ref=o.ref and o.sos > 0 ) x2
                  where x1.deal_tag = r.tag1 and x2.deal_tag = r.tag2   and x1.dat_a <= NVL(p_dat , gl.bd)   and x2.dat_b >  NVL(p_dat , gl.bd)
                  UNION ALL
                  select r.tag1,
                         x1.ntik,
                         2,
                         1,
                         CASE WHEN DAT_NEXT_U(X1.dat_B,1)=X2.dat_A THEN 24 ELSE 25 END,
                         x1.dat_b,
                         x2.dat_a,
                         x1.rnk,
                         x1.kvb,
                         x1.sumb,
                         acrn.fprocn(x2.ACC9a,0,x2.dat_a),
                         ''
                  from (select swap_tag TAG1, min(deal_tag) tag2, count(*) from fx_deal where swap_tag>0 and swap_tag<>deal_tag group by swap_tag having count(*)>1 ) r,
                       (select f.* from fx_deal f, oper o where f.ref=o.ref and o.sos > 0 ) x1,
                       (select f.* from fx_deal f, oper o where f.ref=o.ref and o.sos > 0 ) x2
                  where x1.deal_tag = r.tag1 and x2.deal_tag = r.tag2   and x1.dat_b <= NVL( p_dat , gl.bd)  and x2.dat_a > NVL( p_dat , gl.bd)  );


                  insert into TMP_MBK_DSW_REP
                     (ord, nd,  ntik,    mb,    tipd,   id,   dat1,   dat2,  rnk, kv,  S, ir, nls)
                            select 1,  ' ',  ' ', b.type, b.tipd, b.id, a.dat1, a.dat2, a.rnk, nvl(a.kv,b.kv) as kv,  0, 0, a.nls
                  from TMP_MBK_DSW_REP a, (
                      select 2,
                             null,
                             null,
                             1 as type,
                             type as tipd,
                             id,
                             null,
                             null,
                             null,
                             kv,
                             0,
                             0,
                             null
                       from ani33 a, tabval b
                         where (  (b.kv in (980,840,643,978) )) and id  in (1,2,4,5)
                      union all
                      select
                            2,
                            null,
                            null,
                            2,
                            type,
                            id,
                            null,
                            null,
                            null,
                            kv,
                            0,
                            0,
                            null
                      from ani33 a, tabval b
                         where (  (b.kv in (980,840,643,978) )) and id  in (21,22,24,25) ) b
                  where b.id = a.id(+)
                    and b.kv = a.kv(+)
                    and b.type = a.mb(+)
                    and a.ord is null;



end;
/
show err;

PROMPT *** Create  grants  P_MBK_DSW ***
grant EXECUTE                                                                on P_MBK_DSW       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_MBK_DSW       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_MBK_DSW.sql =========*** End ***
PROMPT ===================================================================================== 
