

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_EBKC_DUP_CHILD_LIST_LEGAL.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_EBKC_DUP_CHILD_LIST_LEGAL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_EBKC_DUP_CHILD_LIST_LEGAL ("M_RNK", "D_RNK", "OKPO", "NMK", "PRODUCT", "LAST_MODIFC_DATE", "CARD_QUALITY", "SORT_NUM") AS 
  select m_rnk, d_rnk, okpo ,nmk , product, last_modifc_date, card_quality,
       row_number() over (partition by m_rnk order by last_modifc_date asc nulls first, card_quality asc nulls  first) as sort_num
from (
        with ss as (select gl.kf as kf from dual)
        select edg.m_rnk,
               edg.d_rnk,
               (select max(quality)
                  from ebkc_qualityattr_groups
                 where kf = ss_kf.kf
                   and rnk = edg.d_rnk
                   and name = 'card'
                   and cust_type = 'L') as card_quality,
               c.okpo,
               c.nmk,
              (select name from ebk_groups where id = ebkc_pack.get_group_id(edg.d_rnk, ss_kf.kf)) as product,
              ebkc_pack.get_last_modifc_date(edg.d_rnk) as last_modifc_date
        from
            ebkc_duplicate_groups edg,
            customer c,
            ss ss_kf
        where c.rnk = edg.d_rnk
        and edg.cust_type = 'L'
        and c.date_off is null)/*открытые дубликаты*/;

PROMPT *** Create  grants  V_EBKC_DUP_CHILD_LIST_LEGAL ***
grant SELECT                                                                 on V_EBKC_DUP_CHILD_LIST_LEGAL to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_EBKC_DUP_CHILD_LIST_LEGAL.sql =======
PROMPT ===================================================================================== 
