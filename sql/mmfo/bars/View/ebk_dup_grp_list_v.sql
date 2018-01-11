

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/EBK_DUP_GRP_LIST_V.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view EBK_DUP_GRP_LIST_V ***

  CREATE OR REPLACE FORCE VIEW BARS.EBK_DUP_GRP_LIST_V ("KF", "M_RNK", "QTY_D_RNK", "CARD_QUALITY", "OKPO", "NMK", "BIRTH_DAY", "DOCUMENT", "GROUP_ID", "PRODUCT", "LAST_MODIFC_DATE", "BRANCH") AS 
  select a.KF,
       a.m_rnk,
       a.qty_d_rnk,
       a.card_quality,
       a.okpo,
       a.nmk,
       a.birth_day,
       a.document,
       a.group_id,
       (select name from ebk_groups where id = a.group_id) as product,
       a.last_modifc_date,
       a.branch
  from( select edg.KF,
               edg.M_RNK,
               edg.qty_d_rnk,
               ( select max(quality)
                   from ebk_qualityattr_gourps
                  where kf  = edg.kf
                    and rnk = edg.m_rnk
                    and name = 'card'
               ) as card_quality,
               c.okpo,
               c.nmk,
               (select ser || ' ' || numdoc from person where rnk = edg.m_rnk) as document,
               (select bday from person where rnk = edg.m_rnk)  as birth_day,
               ebk_dup_wform_utl.get_group_id(edg.m_rnk,edg.kf) as group_id,
               ebk_dup_wform_utl.get_last_modifc_date(edg.m_rnk) as last_modifc_date,
               c.branch
          from ( select M_RNK
                      , KF
                      , count(d_rnk) as qty_d_rnk /* кол-во открытых дубликатов */
                   from EBK_DUPLICATE_GROUPS
                  where not exists (select null from CUSTOMER where rnk = d_rnk and date_off is not null)
                    and KF = SYS_CONTEXT('BARS_CONTEXT','USER_MFO')
                  group by M_RNK, KF
               ) edg
          join CUSTOMER c
            on ( c.KF = edg.KF and c.RNK = edg.M_RNK )
         where edg.QTY_D_RNK > 0
      ) a
;

PROMPT *** Create  grants  EBK_DUP_GRP_LIST_V ***
grant SELECT                                                                 on EBK_DUP_GRP_LIST_V to BARSREADER_ROLE;
grant SELECT                                                                 on EBK_DUP_GRP_LIST_V to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EBK_DUP_GRP_LIST_V to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/EBK_DUP_GRP_LIST_V.sql =========*** End
PROMPT ===================================================================================== 
