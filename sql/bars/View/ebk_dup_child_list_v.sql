prompt ==================================
prompt Create view EBK_DUP_CHILD_LIST_V
prompt ==================================

create or replace view BARS.EBK_DUP_CHILD_LIST_V
( KF
, M_RNK
, D_RNK
, OKPO
, NMK
, DOCUMENT
, BIRTH_DAY
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
     , DOCUMENT
     , BIRTH_DAY
     , PRODUCT
     , LAST_MODIFC_DATE
     , CARD_QUALITY
     , row_number() over (partition by m_rnk order by last_modifc_date asc nulls first, card_quality asc nulls first) as SORT_NUM
  from ( select edg.KF,
                edg.M_RNK,
                edg.D_RNK,
                ( select max(quality)
                    from EBK_QUALITYATTR_GOURPS
                   where kf  = edg.kf
                     and rnk = edg.d_rnk
                     and name = 'card' 
                ) as card_quality,  
                c.okpo,
                c.nmk,
                p.ser||' '||p.numdoc as DOCUMENT,
                p.BDAY               as BIRTH_DAY,
                ( select name from EBK_GROUPS where id = ebk_dup_wform_utl.get_group_id( edg.d_rnk, edg.kf ) ) as product,
                ebk_dup_wform_utl.get_last_modifc_date(edg.d_rnk) as last_modifc_date
           from EBK_DUPLICATE_GROUPS edg
           join CUSTOMER c
             on ( c.KF = edg.KF and c.RNK = edg.D_RNK )
           join PERSON p
             on (                   p.RNK = edg.D_RNK ) -- p.KF = edg.KF and p.RNK = edg.D_RNK )
          where edg.KF = SYS_CONTEXT('BARS_CONTEXT','USER_MFO')
            and c.DATE_OFF is null );

show err

prompt ==================================
prompt Grants
prompt ==================================

grant select on EBK_DUP_CHILD_LIST_V to BARS_ACCESS_DEFROLE;
