

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OBPC_ZP_DOCS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OBPC_ZP_DOCS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OBPC_ZP_DOCS ("ID", "FILE_NAME", "FILE_DATE", "TRANSIT_NLS", "TRANSIT_NMS", "REF", "S", "CARD_ACCT", "PK_NLS", "PK_NMS") AS 
  select z.id, z.file_name, z.file_date, a.nls, a.nms,
       o.ref, o.s/100, c.value, o.nlsb, o.nam_b
  from obpc_zp_files z, accounts a, operw w, oper o, operw c
 where z.transit_acc = a.acc
   and to_char(z.id) = trim(w.value) and w.tag = 'ZP_ID'
   and w.ref = o.ref
   and o.ref = c.ref and c.tag = 'CDAC'
   and a.branch like sys_context('bars_context','user_branch_mask');

PROMPT *** Create  grants  V_OBPC_ZP_DOCS ***
grant SELECT                                                                 on V_OBPC_ZP_DOCS  to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OBPC_ZP_DOCS  to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_OBPC_ZP_DOCS  to OBPC;
grant SELECT                                                                 on V_OBPC_ZP_DOCS  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OBPC_ZP_DOCS.sql =========*** End ***
PROMPT ===================================================================================== 
