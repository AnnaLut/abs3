

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NOTARY_PRETENDENT.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NOTARY_PRETENDENT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NOTARY_PRETENDENT ("RNK", "Tin", "FirstName", "MiddleName", "LastName", "DateOfBirth", "PassportSeries", "PassportNumber", "Address", "PassportIssuer", "PassportIssued", "PhoneNumber", "MobilePhoneNumber", "Email", "MFO", "NLS", "NotaryType", "CertNumber", "CertIssueDate", "CertCancDate") AS 
  select c.RNK                                 ,
       c.OKPO             "Tin"              ,
       f_fio(c.nmk,1)     "FirstName"        ,
       f_fio(c.nmk,2)     "MiddleName"       ,
       f_fio(c.nmk,3)     "LastName"         ,
       p.bday             "DateOfBirth"      ,
       p.ser              "PassportSeries"   ,
       p.numdoc           "PassportNumber"   ,
       c.adr              "Address"          ,
       p.organ            "PassportIssuer"   ,
       p.pdate            "PassportIssued"   ,
       nvl(p.telw,p.teld) "PhoneNumber"      ,
       p.cellphone        "MobilePhoneNumber",
       w1.value           "Email"            ,
       w6.value           "MFO"              ,
       w7.value           "NLS"              ,
       w2.value           "NotaryType"       ,
       w3.value           "CertNumber"       ,
       w4.value           "CertIssueDate"    ,
       w5.value           "CertCancDate"
from   v_customer  c ,
       v_person    p ,
       v_customerw w1,
       v_customerw w2,
       v_customerw w3,
       v_customerw w4,
       v_customerw w5,
       v_customerw w6,
       v_customerw w7
where  p.rnk(+)=c.rnk    and
       w1.rnk(+)=c.rnk   and
       w1.tag(+)='EMAIL' and
       w2.rnk(+)=c.rnk   and
       w2.tag(+)='NOTAT' and
       w3.rnk(+)=c.rnk   and
       w3.tag(+)='NOTAN' and
       w4.rnk(+)=c.rnk   and
       w4.tag(+)='NOTAD' and
       w5.rnk(+)=c.rnk   and
       w5.tag(+)='NOTAF' and
       w6.rnk(+)=c.rnk   and
       w6.tag(+)='NOTAM' and
       w7.rnk(+)=c.rnk   and
       w7.tag(+)='NOTAS';

PROMPT *** Create  grants  V_NOTARY_PRETENDENT ***
grant SELECT                                                                 on V_NOTARY_PRETENDENT to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NOTARY_PRETENDENT.sql =========*** En
PROMPT ===================================================================================== 
