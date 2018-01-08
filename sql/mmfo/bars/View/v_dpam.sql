

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPAM.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPAM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPAM ("FDAT", "C_REG", "DK", "D_OPER", "KOD", "KV", "MFO", "NAZ1", "ND", "NLS", "NMK", "REF", "RNK", "S", "TYP_OPER", "T01", "NLSK") AS 
  select o.fdat,c.C_REG,'0',to_char(o.fdat,'ddmmyy'),c.okpo,a.kv,300120,
       p.nazn,p.nd,to_number(a.nls),c.nmk,o.ref,c.rnk,to_number(o.s),5,c.tgr,o.nlsk
from customer c, cust_acc cu, provodki o, accounts a,
     list_dpa l, saldoa s, oper p
where c.rnk=cu.rnk       and cu.acc=a.acc   and c.okpo=l.kod   and
      c.okpo<>'22906155' and a.acc=s.acc    and c.custtype=2   and
      o.accD=a.acc       and p.ref=o.ref    and s.fdat=o.fdat  and
      p.sk<> 40          and substr(o.nlsD,1,4)='2600'         and
      substr(o.nlsk,1,4) in ('1500','1600','1001','2620','2625','2630')    and
      msumdos(a.acc,bankdate)>=5000000                         and
      MONTHS_BETWEEN(o.fdat,a.daos) < 24
UNION ALL
select o.fdat,c.C_REG,'0',to_char(o.fdat,'ddmmyy'),c.okpo,a.kv,300120,
       p.nazn,p.nd,to_number(a.nls),c.nmk,o.ref,c.rnk,to_number(o.s),6,c.tgr,o.nlsk
from customer c, cust_acc cu, provodki o, accounts a,
     list_dpa l, saldoa s, oper p
where c.rnk=cu.rnk       and cu.acc=a.acc   and c.okpo=l.kod   and
      c.okpo<>'22906155' and a.acc=s.acc    and c.custtype=2   and
      o.accD=a.acc       and p.ref=o.ref    and s.fdat=o.fdat  and
      p.sk<>40           and substr(o.nlsD,1,4)='2600'         and
      substr(o.nlsk,1,4) in ('1500','1600','1001','2620','2625','2630')    and
      msumdos(a.acc,bankdate)>=10000000                        and
      MONTHS_BETWEEN(o.fdat,a.daos) > 24;

PROMPT *** Create  grants  V_DPAM ***
grant SELECT                                                                 on V_DPAM          to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPAM          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPAM          to START1;
grant SELECT                                                                 on V_DPAM          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPAM.sql =========*** End *** =======
PROMPT ===================================================================================== 
