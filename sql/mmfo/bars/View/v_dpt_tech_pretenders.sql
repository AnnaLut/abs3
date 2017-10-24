

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_TECH_PRETENDERS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_TECH_PRETENDERS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_TECH_PRETENDERS ("D_ID", "ND", "TYPE_NAME", "DATZ", "DAT_END", "RNK", "OKPO", "NMK", "SER", "NUMDOC", "BDAY", "NLS", "LCV", "OSTC", "P_OSTC") AS 
  SELECT d.deposit_id as d_id,
	d.nd as nd,
	v.type_name as type_name,
	d.datz as datz,
	d.dat_end as dat_end,
	d.rnk as rnk,
	c.okpo as okpo,
	c.nmk nmk,
	p.ser ser,
	p.numdoc numdoc,
	p.bday bday,
	s.nls as nls,
	t.lcv as lcv,
	to_char(s.ostc/100,'999999999990.99') as ostc,
	decode(s.acc,a2.acc,'0.00',to_char(a2.ostc/100,'999999999990.99')) as p_ostc
FROM dpt_deposit d, saldo s, customer c, tabval t, saldo a2,int_accn i,dpt_vidd v, person p
WHERE d.vidd = v.vidd
	AND d.acc = s.acc
	AND d.rnk = c.rnk
	AND c.rnk = p.rnk
	AND t.kv=d.kv
	AND i.acc=d.acc
	AND i.acra=a2.acc
	AND d.acc_d is null
	AND v.fl_2620 = 1
 ;

PROMPT *** Create  grants  V_DPT_TECH_PRETENDERS ***
grant SELECT                                                                 on V_DPT_TECH_PRETENDERS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_TECH_PRETENDERS to DPT_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_TECH_PRETENDERS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_TECH_PRETENDERS.sql =========*** 
PROMPT ===================================================================================== 
