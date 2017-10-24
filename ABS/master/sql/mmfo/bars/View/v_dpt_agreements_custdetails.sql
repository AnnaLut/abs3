

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_AGREEMENTS_CUSTDETAILS.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_AGREEMENTS_CUSTDETAILS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_AGREEMENTS_CUSTDETAILS ("AGRMNT_ID", "CUST_TYPE", "CUST_NUM", "CUST_NAME", "CUST_ID", "CUST_ADRESS", "CUST_HOMEPHONE", "CUST_DOCTYPE", "CUST_DOCNUM", "CUST_DOCNUM_EXT", "CUST_DOCATRT", "CUST_DOCISSUED", "CUST_DOCATRT_EXT", "CUST_BIRTHPLACE", "CUST_BIRTHDAY", "CUST_NAME_GENCASE") AS 
  SELECT a.agrmnt_id, 0, c.rnk, c.nmk, c.okpo, c.adr, p.teld,
       s.name, trim(p.ser||' '||p.numdoc),
       decode(trim(p.ser||p.numdoc), null, null, trim(s.name||' '||p.ser||' '||p.numdoc)),
       p.organ, substr(f_dat_lit(p.pdate, 'U'), 1, 50),
       trim(decode(p.organ, null, ' ', ' виданий '||p.organ||decode(p.pdate, null, ',', ' '||substr(f_dat_lit(p.pdate,'U'),1,50)||','))),
       p.bplace, substr(f_dat_lit(p.bday,'U'), 1, 50),
       nvl((SELECT substr(TRIM(value),1,250) NAME_GC FROM customerw WHERE rnk = c.rnk AND tag = 'SN_GC'),c.nmk)
  FROM dpt_agreements a, customer c, person p, passp s
 WHERE a.cust_id = c.rnk
   AND a.cust_id = p.rnk
   AND p.passp = s.passp(+)
 UNION ALL
SELECT a.agrmnt_id, 1, c.rnk, c.nmk, c.okpo, c.adr, p.teld,
       s.name, trim(p.ser||' '||p.numdoc),
       decode(trim(p.ser||p.numdoc), null, null, trim(s.name||' '||p.ser||' '||p.numdoc)),
       p.organ, substr(f_dat_lit(p.pdate, 'U'), 1, 50),
       trim(decode(p.organ, null, ' ', ' виданий '||p.organ||decode(p.pdate, null, ',', ' '||substr(f_dat_lit(p.pdate,'U'),1,50)||','))),
       p.bplace, substr(f_dat_lit(p.bday, 'U'), 1, 50),
       nvl((SELECT substr(TRIM(value),1,250) NAME_GC FROM customerw WHERE rnk = c.rnk AND tag = 'SN_GC'), c.nmk)
  FROM dpt_agreements a, dpt_trustee t, customer c, person p, passp s
 WHERE a.trustee_id = t.id
   AND t.rnk_tr = c.rnk
   AND t.rnk_tr = p.rnk
   AND p.passp = s.passp(+)
 ;

PROMPT *** Create  grants  V_DPT_AGREEMENTS_CUSTDETAILS ***
grant SELECT                                                                 on V_DPT_AGREEMENTS_CUSTDETAILS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_AGREEMENTS_CUSTDETAILS to DPT_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_AGREEMENTS_CUSTDETAILS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_AGREEMENTS_CUSTDETAILS.sql ======
PROMPT ===================================================================================== 
