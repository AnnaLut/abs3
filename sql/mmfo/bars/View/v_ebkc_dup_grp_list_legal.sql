

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_EBKC_DUP_GRP_LIST_LEGAL.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_EBKC_DUP_GRP_LIST_LEGAL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_EBKC_DUP_GRP_LIST_LEGAL ("M_RNK", "QTY_D_RNK", "CARD_QUALITY", "OKPO", "NMK", "GROUP_ID", "PRODUCT", "LAST_MODIFC_DATE", "BRANCH") AS 
  select a.m_rnk,
       a.qty_d_rnk,
       a.card_quality,
       a.okpo,
       a.nmk,
       a.group_id,
       g.NAME as PRODUCT,
       a.last_modifc_date,
       a.branch
  from ( select edg.m_rnk,
                edg.qty_d_rnk,
                (select max(quality)
                   from EBKC_QUALITYATTR_GROUPS
                  where kf   = edg.kf
                    and rnk  = edg.m_rnk
                    and name = 'card'
                    and cust_type = 'L') as card_quality,
                c.okpo,
                c.nmk,
                ebkc_pack.get_group_id(edg.m_rnk, c.kf) as group_id,
                ebkc_pack.get_last_modifc_date(edg.m_rnk) as last_modifc_date,
                c.BRANCH
           from ( select m_rnk
                       , kf
                       , count(D_RNK) as QTY_D_RNK /* кол-во открытых дубликатов */
                    from ebkc_duplicate_groups edg
                   where exists (select null from CUSTOMER c where c.KF = edg.KF and c.RNK = edg.D_RNK and c.DATE_OFF is null )
                     and edg.cust_type = 'L'
                   group by m_rnk, kf
                ) edg
           join CUSTOMER c
             on ( c.KF = edg.KF and c.RNK = edg.M_RNK )
          where edg.QTY_D_RNK > 0
       ) a
  join EBKC_GROUPS g
    on ( g.ID = a.group_id and g.CUST_TYPE = 'L' )
;

PROMPT *** Create  grants  V_EBKC_DUP_GRP_LIST_LEGAL ***
grant SELECT                                                                 on V_EBKC_DUP_GRP_LIST_LEGAL to BARSREADER_ROLE;
grant SELECT                                                                 on V_EBKC_DUP_GRP_LIST_LEGAL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_EBKC_DUP_GRP_LIST_LEGAL to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_EBKC_DUP_GRP_LIST_LEGAL.sql =========
PROMPT ===================================================================================== 
