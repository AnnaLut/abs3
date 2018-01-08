

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PRIOCOM_CLIENT_PERSON.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PRIOCOM_CLIENT_PERSON ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PRIOCOM_CLIENT_PERSON ("CODE", "STATUS", "KOD_FIL", "IDENT", "SYSNAME", "REGDATE", "LNAME", "FNAME", "SNAME", "ENGLNAME", "ENGFNAME", "BIRTHDAY", "BIRTHPLACE", "ISSTOCKHOLDER", "ISVIP", "ISRESIDENT", "CLOSEDATE", "ACCOUNTMFO", "ACCOUNTNUM", "DEBTORCLASS", "GENDER", "ADDR", "K040", "K060", "PASPNUM", "PASPSERIES", "PASPDATE", "PASPISSUER", "FOREIGNPASPNUM", "FOREIGNPASPSERIES", "FOREIGNPASPDATE", "FOREIGNPASPISSUER") AS 
  select
    c.rnk                        as code,
    decode(date_off,null,1,2)    as status,
    null                        as kod_fil,
    c.okpo                        as ident,
    c.nmk                        as sysname,
    c.date_on                    as regdate,
    nvl((select value from customerw where rnk=c.rnk and tag='LNAME'),c.nmk)
    as lname,
    nvl((select value from customerw where rnk=c.rnk and tag='FNAME'),'не вказано')
    as fname,
    (select value from customerw where rnk=c.rnk and tag='MNAME') as sname,
    c.nmkv                        as englname,
    null                        as engfname,
    p.bday                        as birthday,
    p.bplace                    as birthplace,
    decode(c.prinsider,1,1,0)   as isStockholder,
    decode((select tag from customerw where tag='VIP_K' and rnk=c.rnk),null,0,1) as isVip,
    decode(c.codcagent,5,1,6,0,null)    as isResident,
    c.date_off                    as closedate,
    null                        as accountMfo,
    null                        as accountNum,
    c.crisk                        as debtorclass,
    decode(p.sex,1,'М',2,'Ж',null) as gender,
    c.adr                        as addr,
    lpad(to_char(c.country),3,'0') as k040,
    lpad(to_char(c.prinsider),2,'0') as k060,
    p.numdoc                    as paspnum,
    p.ser                        as paspseries,
    p.pdate                        as paspdate,
    p.organ                        as paspissuer,
    null as foreignpaspnum,
    null as foreignpaspseries,
    null as foreignpaspdate,
    null as foreignpaspissuer
from customer c, person p
where c.custtype=3  -- физлица
and c.rnk=p.rnk(+);

PROMPT *** Create  grants  V_PRIOCOM_CLIENT_PERSON ***
grant SELECT                                                                 on V_PRIOCOM_CLIENT_PERSON to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PRIOCOM_CLIENT_PERSON to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PRIOCOM_CLIENT_PERSON.sql =========**
PROMPT ===================================================================================== 
