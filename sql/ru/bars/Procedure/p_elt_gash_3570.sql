

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ELT_GASH_3570.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ELT_GASH_3570 ***

  CREATE OR REPLACE PROCEDURE BARS.P_ELT_GASH_3570 
(p_dat date, p_tt varchar2 default 'ELA', p_rnk int default -1) is
-- погашення 3570 по портфелю абонплати
-- v.1.7  від 11/01-17

 l_dat1 date; l_dat2 date;
 mask_ varchar2(15);  l_tt varchar2(3);
 sERR varchar2(100);
 ern CONSTANT POSITIVE := 208; err EXCEPTION; erm VARCHAR2(80);
begin
 logger.info('P_elt_gash_3570 started');
 l_dat1 := ADD_MONTHS (LAST_DAY(bankdate),-1)+1;
 l_dat2:=bankdate;
 l_tt:=p_tt;

 for k in
(select e.nd, e.rnk, nvl(c.nmkk,c.nmk) NMK,
        e.nls26, e.nls36, a3.ostc ostc3570, e.wdate,
        nvl(e.nls_p,e.nls26) PL, decode(e.nls_p,null,null,1) fl_p, e.branch
from  customer c, e_deal e, accounts a3, accounts p
where 1=1 and e.nls36 is not null and e.nls36=a3.nls and a3.kv=980
      and a3.ostc !=0 and  a3.ostc=a3.ostb
      and nvl(e.nls_p,e.nls26) = p.nls and p.kv=980
      and p.ostc>0 and p.ostc >=-a3.ostc
      and e.rnk = c.rnk and e.sos!=15
      and e.rnk = decode(p_rnk,-1,e.rnk,p_rnk)
          -- and rownum < 30    -- ! otladka
order by e.branch,e.rnk,e.nls36)

  loop

  ELT.opl(3,l_tt,null,null,null,k.wdate,l_dat2,null,1,k.nls36,sERR);

 logger.trace('RNK='|| k.rnk ||' nls='||k.nls36||' погашення '||k.ostc3570);

    if sERR is not null then NULL;
    --   logger.info(k.branch||' RNK='|| k.rnk ||' nls='||k.nls36||' ERR погашення ');
    end if;
  end loop;
--  commit;
end;
/
show err;

PROMPT *** Create  grants  P_ELT_GASH_3570 ***
grant EXECUTE                                                                on P_ELT_GASH_3570 to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_ELT_GASH_3570 to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ELT_GASH_3570.sql =========*** E
PROMPT ===================================================================================== 
