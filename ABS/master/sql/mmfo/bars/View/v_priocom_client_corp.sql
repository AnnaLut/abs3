

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PRIOCOM_CLIENT_CORP.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PRIOCOM_CLIENT_CORP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PRIOCOM_CLIENT_CORP ("CODE", "STATUS", "KOD_FIL", "OKPO", "SYSNAME", "REGDATE", "NAME", "ENGNAME", "ISSTOCKHOLDER", "ISVIP", "ISBUDGETORG", "ISRESIDENT", "CLOSEDATE", "ACCOUNTMFO", "ACCOUNTNUM", "DEBTORCLASS", "LEGALADDR", "ADDR", "FIODIRECTOR", "POSDIRECT", "STATUT", "K040", "K050", "K060", "K070", "K080", "K090", "K110", "K120", "TAXADMINNUM", "TAXREGIONNUM", "TAXZONENUM", "GOVERMENTPART", "FOREIGNPART", "TAXNUM", "TAXREGDATE", "PUBADMIN", "PUBADMINNUM", "PUBADMINDATE", "SALESTAXCODE", "SINGLETAXCODE", "UNPROFITCODE", "SMALLBISS", "FIOSYN", "POSSYN") AS 
  select
    c.rnk                        as code,
    decode(c.date_off,null,1,2)    as status,
    null                        as kod_fil,
    c.okpo                        as okpo,
    c.nmk                        as sysname,
    c.date_on                    as regdate,
    c.nmk                        as name,
    c.nmkv                        as engname,
    decode(c.prinsider,11,1,0)   as isStockholder,
    decode((select tag from customerw where tag='VIP_K' and rnk=c.rnk),null,0,1) as isVip,
    null                            as isBudgetorg,
    decode(c.codcagent,1,1,3,1,7,1,9,1,11,1,2,0,4,0,null)    as isResident,
    c.date_off                    as closedate,
    null                        as accountMfo,
    null                        as accountNum,
    c.crisk                        as debtorclass,
    c.adr                        as legaladdr,
    nvl((select value from customerw where rnk=c.rnk and tag='FADR '),c.adr)                        as addr,
    p.ruk                        as fiodirector,
    (select value from customerw where rnk=c.rnk and tag='WORKU') as posdirect,
    null                        as statut,
    lpad(to_char(c.country),3,'0') as k040,
    (select min(k050) from kl_k050 where trim(k051)=trim(c.sed) and rownum=1)
        as k050,  -- передаємо k051 замість k050
    lpad(to_char(c.prinsider),2,'0') as k060,
    c.ise                        as k070,
    c.fs                        as k080,
    c.oe                        as k090,
    c.ved                        as k110,
    null                        as k120,
    c.c_dst                        as taxadminnum,
    c.c_reg                        as taxregionnum,
    c.c_reg                        as taxzonenum,
    null                        as govermentpart,
    null                        as foreignpart,
    c.rgtax                        as taxnum,
    c.datet                        as taxregdate,
    c.adm                        as pubadmin,    -- Адм. орган реєстрації
    c.rgadm                        as pubadminnum,
    c.datea                        as pubadmindate,
    c.taxf                        as salestaxcode,
    null                        as singletaxcode,
    null                        as unprofitcode,
    decode(to_number(c.mb),1,1,0) as smallbiss,
    p.buh                        as fiosyn,
    null                        as possyn
from customer c, corps p
where c.custtype in (1,2,4)  -- юрлица
and c.rnk=p.rnk(+);

PROMPT *** Create  grants  V_PRIOCOM_CLIENT_CORP ***
grant SELECT                                                                 on V_PRIOCOM_CLIENT_CORP to BARSREADER_ROLE;
grant SELECT                                                                 on V_PRIOCOM_CLIENT_CORP to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PRIOCOM_CLIENT_CORP to START1;
grant SELECT                                                                 on V_PRIOCOM_CLIENT_CORP to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PRIOCOM_CLIENT_CORP.sql =========*** 
PROMPT ===================================================================================== 
