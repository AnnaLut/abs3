

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BPK_PRODUCT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BPK_PRODUCT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BPK_PRODUCT ("ID", "NAME", "TYPE", "TYPE_NAME", "CARD_TYPE", "CARD_TYPE_NAME", "KV", "KK", "KK_NAME", "COND_SET", "COND_SET_NAME", "C_VALIDITY", "DEB_INTR", "OLIM_INTR", "CRED_INTR", "NBS", "NBS_NAME", "OB22", "OB22_NAME", "CUSTTYPE", "LIMIT", "ID_DOC", "ID_DOC_CRED") AS 
  select b.id, b.name, b.type, a.name type_name,
       b.card_type, d.name card_type_name,
       b.kv, b.kk, k.name kk_name,
       c.cond_set, substr(c.name,1,8) cond_set_name,
       c.c_validity, c.deb_intr, c.olim_intr, c.cred_intr,
       b.nbs, substr(p.name,1,175) nbs_name,
       b.ob22, substr(s.txt,1,254) ob22_name,
       n.custtype, b.limit, b.id_doc, b.id_doc_cred
  from bpk_product b, demand_acc_type a, demand_card_type d, demand_kk k,
       demand_cond_set c, bpk_nbs n, ps p, sb_ob22 s
 where b.type = a.type
   and b.card_type = d.card_type
   and b.card_type = c.card_type
   and b.cond_set  = c.cond_set
   and b.kk = k.kk
   and b.kv = decode(c.currency,'UAH',980,840)
   and b.nbs  = n.nbs
   and b.ob22 = n.ob22
   and b.nbs  = p.nbs
   and b.nbs  = s.r020
   and b.ob22 = s.ob22
   and (b.d_close is null or b.d_close > sysdate);

PROMPT *** Create  grants  V_BPK_PRODUCT ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BPK_PRODUCT   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_BPK_PRODUCT   to OBPC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BPK_PRODUCT.sql =========*** End *** 
PROMPT ===================================================================================== 
