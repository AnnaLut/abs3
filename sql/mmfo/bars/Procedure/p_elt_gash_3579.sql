

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ELT_GASH_3579.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ELT_GASH_3579 ***

  CREATE OR REPLACE PROCEDURE BARS.P_ELT_GASH_3579 
(p_dat date, p_tt varchar2 default 'ELA', p_rnk int default -1) is
-- погашення 3579 по портфелю абонплати
-- v.1.5 від 12/03-12

 l_dat1 date; l_dat2 date;
 mask_ varchar2(15); l_tt varchar2(3);
 sERR varchar2(100);
 ern CONSTANT POSITIVE := 208; err EXCEPTION; erm VARCHAR2(160);
begin
   logger.info('P_elt_gash_3579 started');
 l_dat1 := ADD_MONTHS (LAST_DAY(bankdate),-1)+1;
 l_dat2:=bankdate;
 l_tt:=p_tt;

 for k in
(select e.nd, e.rnk, nvl(c.nmkk,c.nmk) NMK,
        e.nls26, e.nls36, e.nls_d, a9.ostc OST3579, e.wdate,
        nvl(e.nls_p,e.nls26) PL, decode(e.nls_p,null,null,1) fl_p, e.branch
from  customer c, e_deal e, accounts a9, accounts p
where 1=1 and e.nls_d is not null and e.nls_d=a9.nls and a9.kv=980
      and a9.ostc !=0 and  a9.ostc=a9.ostb
      and nvl(e.nls_p,e.nls26) = p.nls and p.kv=980
      and p.ostc>0 and p.ostc >=-a9.ostc
      and e.rnk = c.rnk
      and e.rnk = decode(p_rnk,-1,e.rnk,p_rnk)
        and rownum < 30
    --  and e.branch like '%/000250%'
order by e.branch,e.rnk,e.nls_d)

  loop

  ELT.borg(8,l_tt,null,null,null,l_dat1,l_dat2,null,1,k.nls36,sERR);

  logger.info(k.branch||' RNK='|| k.rnk ||' nls='||k.nls_d||' погашення '||k.OST3579);

    if sERR is not null then NULL;
       logger.info(k.branch||' RNK='|| k.rnk ||' nls='||k.nls_d||' ERR погашення ');
    end if;
  end loop;
--  commit;
end;
/
show err;

PROMPT *** Create  grants  P_ELT_GASH_3579 ***
grant EXECUTE                                                                on P_ELT_GASH_3579 to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_ELT_GASH_3579 to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ELT_GASH_3579.sql =========*** E
PROMPT ===================================================================================== 
