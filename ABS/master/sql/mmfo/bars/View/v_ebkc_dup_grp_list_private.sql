

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_EBKC_DUP_GRP_LIST_PRIVATE.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_EBKC_DUP_GRP_LIST_PRIVATE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_EBKC_DUP_GRP_LIST_PRIVATE ("M_RNK", "QTY_D_RNK", "CARD_QUALITY", "OKPO", "NMK", "GROUP_ID", "PRODUCT", "LAST_MODIFC_DATE", "BRANCH") AS 
  select a.m_rnk,
       a.qty_d_rnk,
       a.card_quality,
       a.okpo,
       a.nmk,
       a.group_id,
       (select name from ebkc_groups where id = a.group_id and cust_type = 'P') as product,
       a.last_modifc_date,
       a.branch
  from ( select edg.m_rnk,
                edg.qty_d_rnk,
       (select max(quality) from ebkc_qualityattr_groups
         where kf  = edg.kf
           and rnk = edg.m_rnk
           and name = 'card'
           and cust_type = 'P') as card_quality,
       c.okpo,
       c.nmk,
      ebkc_pack.get_group_id( edg.m_rnk, edg.kf ) as group_id,
      ebkc_pack.get_last_modifc_date(edg.m_rnk) as last_modifc_date,
      c.branch
  from ( select m_rnk
              , kf
              , count(d_rnk) as qty_d_rnk /* кол-во открытых дубликатов */
           from BARS.EBKC_DUPLICATE_GROUPS edg
          where not exists (select null from customer where rnk = d_rnk and date_off is not null)
            and edg.cust_type = 'P'
          group by m_rnk, kf
       ) edg,
       customer c
 where c.rnk = edg.m_rnk
   and edg.qty_d_rnk > 0 ) a;

PROMPT *** Create  grants  V_EBKC_DUP_GRP_LIST_PRIVATE ***
grant SELECT                                                                 on V_EBKC_DUP_GRP_LIST_PRIVATE to BARSREADER_ROLE;
grant SELECT                                                                 on V_EBKC_DUP_GRP_LIST_PRIVATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_EBKC_DUP_GRP_LIST_PRIVATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_EBKC_DUP_GRP_LIST_PRIVATE.sql =======
PROMPT ===================================================================================== 
