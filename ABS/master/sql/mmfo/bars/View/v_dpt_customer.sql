

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_CUSTOMER.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_CUSTOMER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_CUSTOMER ("RNK", "NAME", "COUNTRY", "ADDRESS", "TGR", "OKPO", "C_REG", "C_DST", "RESIDENT", "DOCTYPE", "DOCTYPENAME", "DOCSERIAL", "DOCNUM", "DOCORG", "DOCDATE", "PHOTODATE", "BDATE", "BPLACE", "SEX", "PHONEH", "PHONEW", "CELLPHONE", "U_IDX", "U_REGION", "U_DISTRICT", "U_SETTLEMENT", "U_ADDRESS", "TERRITORY", "F_IDX", "F_REGION", "F_DISTRICT", "F_SETTLEMENT", "F_ADDRESS", "TERRITORYREAL") AS 
  SELECT c.rnk,
          c.nmk,
          c.country,
          c.adr,
          c.tgr,
          c.okpo,
          c.c_reg,
          c.c_dst,
          6 - c.codcagent,
          p.passp,
          v.name,
          p.ser,
          p.numdoc,
          p.organ,
          p.pdate,
          p.date_photo,
          p.bday,
          p.bplace,
          p.sex,
          p.teld,
          p.telw,
          p.cellphone,
          au.zip,
          au.domain,
          au.region,
          au.locality,
          au.address,
          au.territory_id,
          af.zip,
          af.domain,
          af.region,
          af.locality,
          af.address,
          af.territory_id
     FROM customer c,
          person p,
          passp v,
          customer_address au,
          customer_address af
    WHERE     c.custtype = 3
          AND c.date_off IS NULL
          AND c.rnk = p.rnk(+)
          AND p.passp = v.passp
          AND c.rnk = au.rnk(+)
          AND 1 = au.type_id(+)
          AND c.rnk = af.rnk(+)
          AND 2 = af.type_id(+);

PROMPT *** Create  grants  V_DPT_CUSTOMER ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_DPT_CUSTOMER  to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_DPT_CUSTOMER  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_CUSTOMER  to DPT;
grant SELECT                                                                 on V_DPT_CUSTOMER  to DPT_ROLE;
grant SELECT                                                                 on V_DPT_CUSTOMER  to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_CUSTOMER  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_CUSTOMER.sql =========*** End ***
PROMPT ===================================================================================== 
