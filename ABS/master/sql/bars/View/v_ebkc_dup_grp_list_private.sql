prompt ==================================
prompt Create view v_ebkc_dup_grp_list_private
prompt ==================================

create or replace view BARS.V_EBKC_DUP_GRP_LIST_PRIVATE
as
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

prompt ==================================
prompt Grants
prompt ==================================

grant select on bars.v_ebkc_dup_grp_list_private to bars_access_defrole;
