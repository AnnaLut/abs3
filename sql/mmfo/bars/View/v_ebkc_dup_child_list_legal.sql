prompt ==================================
prompt Create view v_ebkc_dup_child_list_legal
prompt ==================================
create or replace view BARS.V_EBKC_DUP_CHILD_LIST_LEGAL
as
/* открытые дубликаты */
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

show err

prompt ==================================
prompt Grants
prompt ==================================

grant select on v_ebkc_dup_child_list_legal to bars_access_defrole;
