

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/EBK_CUST_SUBGRP_V.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view EBK_CUST_SUBGRP_V ***

  CREATE OR REPLACE FORCE VIEW BARS.EBK_CUST_SUBGRP_V ("RNK", "GROUP_ID", "ID_PRC_QUALITY", "OKPO", "NMK", "QUALITY", "DOCUMENT", "BIRTH_DAY", "ATTR_QTY", "LAST_CARD_UPD", "LAST_USER_UPD", "BRANCH") AS 
  select r.rnk,
       r.group_id,
       r.id_prc_quality,
       r.okpo,
       r.nmk,
       r.quality,
       r.document,
       r.birth_day,
       r.attr_qty,
       r.last_card_upd,
       (select s.fio from staff$base s, ebk_card_qlt_log l
         where l.rnk = r.rnk
           and l.date_updated = r.last_card_upd
           and s.id = l.user_id
           and rownum=1)  as last_user_upd,
       r.branch
from(
with ss as (select gl.kf as kf from dual)
select teru.rnk,
       teru.group_id,
       ebk_wforms_utl.get_cust_subgrp(teru.group_id, teru.quality) as id_prc_quality,
       c.okpo,
       c.nmk,
       teru.quality,
       (select ser ||' '||numdoc from person where rnk = teru.rnk) as document,
       (select to_char(bday,'dd.mm.yyyy')  from person where rnk = teru.rnk ) as birth_day,
       (select count(name) from tmp_ebk_req_updcard_attr
         where kf = teru.kf and rnk = teru.rnk and quality <>'C') as attr_qty,
      (select max(date_updated) from ebk_card_qlt_log where rnk = teru.rnk)  as last_card_upd,
      c.branch
from tmp_ebk_req_updatecard teru,
     customer c,
     ss ss_kf
where teru.kf = ss_kf.kf
  and c.rnk = teru.rnk
  and c.date_off is null) r;

PROMPT *** Create  grants  EBK_CUST_SUBGRP_V ***
grant SELECT                                                                 on EBK_CUST_SUBGRP_V to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/EBK_CUST_SUBGRP_V.sql =========*** End 
PROMPT ===================================================================================== 
