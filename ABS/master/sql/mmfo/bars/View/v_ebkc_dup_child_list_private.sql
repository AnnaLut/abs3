

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_EBKC_DUP_CHILD_LIST_PRIVATE.sql =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_EBKC_DUP_CHILD_LIST_PRIVATE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_EBKC_DUP_CHILD_LIST_PRIVATE ("KF", "M_RNK", "D_RNK", "OKPO", "NMK", "PRODUCT", "LAST_MODIFC_DATE", "CARD_QUALITY", "SORT_NUM") AS 
  select KF
     , M_RNK
     , D_RNK
     , OKPO
     , NMK
     , PRODUCT
     , LAST_MODIFC_DATE
     , CARD_QUALITY
     , row_number() over (partition by m_rnk order by last_modifc_date asc nulls first, card_quality asc nulls  first) as sort_num
  from ( select edg.kf,
                edg.m_rnk,
                edg.d_rnk,
                (select max(quality)
                   from EBKC_QUALITYATTR_GROUPS
                  where kf  = edg.kf
                    and rnk = edg.d_rnk
                    and name = 'card'
                    and cust_type = 'P') as card_quality,
                cst.okpo,
                cst.nmk,
                (select name from ebk_groups where id = ebkc_pack.get_group_id( edg.d_rnk, edg.kf ) ) as product,
                ebkc_pack.get_last_modifc_date(edg.d_rnk) as last_modifc_date
           from EBKC_DUPLICATE_GROUPS edg
           join CUSTOMER cst
             on ( cst.KF = edg.KF and cst.RNK = edg.D_RNK )
          where edg.CUST_TYPE = 'P'
            and cst.DATE_OFF is null
       );

PROMPT *** Create  grants  V_EBKC_DUP_CHILD_LIST_PRIVATE ***
grant SELECT                                                                 on V_EBKC_DUP_CHILD_LIST_PRIVATE to BARSREADER_ROLE;
grant SELECT                                                                 on V_EBKC_DUP_CHILD_LIST_PRIVATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_EBKC_DUP_CHILD_LIST_PRIVATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_EBKC_DUP_CHILD_LIST_PRIVATE.sql =====
PROMPT ===================================================================================== 
