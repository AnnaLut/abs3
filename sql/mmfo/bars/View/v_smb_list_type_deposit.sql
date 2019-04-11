PROMPT =============================================================================
PROMPT *** Run *** = Scripts /Sql/BARS/View/V_SMB_LIST_TYPE_DEPOSIT.sql =*** Run ***
PROMPT ============================================================================= 

PROMPT *** Create  view v_smb_list_type_deposit  ***

create or replace force view v_smb_list_type_deposit 
as
select  0 id, '<Всі>'  name from dual union all
select  1 id, 'Короткострокові (транш)' from dual union all
select  2 id, 'Довгострокові (вклад на вимогу)' from dual
;


PROMPT *** Create  grants  v_smb_list_type_deposit ***
grant SELECT  on v_smb_list_type_deposit  to BARSREADER_ROLE;
grant SELECT  on v_smb_list_type_deposit  to BARS_ACCESS_DEFROLE;

PROMPT =============================================================================
PROMPT *** End *** = Scripts /Sql/BARS/View/V_SMB_LIST_TYPE_DEPOSIT.sql =*** End ***
PROMPT ============================================================================= 
