

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_EBKC_DUP_CHILD_LIST_LEGAL.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_EBKC_DUP_CHILD_LIST_LEGAL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_EBKC_DUP_CHILD_LIST_LEGAL ("M_RNK", "D_RNK", "OKPO", "NMK", "PRODUCT", "LAST_MODIFC_DATE", "CARD_QUALITY", "SORT_NUM") AS 
  select m_rnk, d_rnk, okpo ,nmk , product, last_modifc_date, card_quality,
       row_number() over (partition by m_rnk order by last_modifc_date asc nulls first, card_quality asc nulls  first) as sort_num
from ( select edg.m_rnk,
              edg.d_rnk,
              (select max(quality)
                 from ebkc_qualityattr_groups
                where kf  = edg.kf
                  and rnk = edg.d_rnk
                  and name = 'card'
                  and cust_type = 'L') as card_quality,
              c.okpo,
              c.nmk,
              (select name from ebk_groups where id = ebkc_pack.get_group_id( edg.d_rnk, edg.kf ) ) as product,
              ebkc_pack.get_last_modifc_date(edg.d_rnk) as last_modifc_date
         from EBKC_DUPLICATE_GROUPS edg
         join CUSTOMER c
           on ( c.KF = edg.KF and c.RNK = edg.M_RNK )
        where edg.CUST_TYPE = 'L'
          and c.DATE_OFF is null );

PROMPT *** Create  grants  V_EBKC_DUP_CHILD_LIST_LEGAL ***
grant SELECT                                                                 on V_EBKC_DUP_CHILD_LIST_LEGAL to BARSREADER_ROLE;
grant SELECT                                                                 on V_EBKC_DUP_CHILD_LIST_LEGAL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_EBKC_DUP_CHILD_LIST_LEGAL to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_EBKC_DUP_CHILD_LIST_LEGAL.sql =======
PROMPT ===================================================================================== 
