prompt ==================================
prompt Create view v_ebkc_dup_child_list_private
prompt ==================================

create or replace view BARS.V_EBKC_DUP_CHILD_LIST_PRIVATE
( KF
, M_RNK
, D_RNK
, OKPO
, NMK
, PRODUCT
, LAST_MODIFC_DATE
, CARD_QUALITY
, SORT_NUM
) as /* открытые дубликаты */
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

show err

prompt ==================================
prompt Grants
prompt ==================================

grant select on v_ebkc_dup_child_list_private to bars_access_defrole;
