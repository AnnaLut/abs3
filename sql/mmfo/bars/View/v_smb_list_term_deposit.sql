PROMPT =============================================================================
PROMPT *** Run *** = Scripts /Sql/BARS/View/V_SMB_LIST_TERM_DEPOSIT.sql =*** Run ***
PROMPT ============================================================================= 

PROMPT *** Create  view v_smb_list_term_deposit  ***

create or replace force view v_smb_list_term_deposit 
as
select  0 id, '<Всі>'  name from dual union all
select  1 id, 'Транші до 1 місяца та на місяць' from dual union all
select  3 id, 'Транші до 3 місяців' from dual union all
select  6 id, 'Транші до 6 місяців' from dual union all
select  9 id, 'Транші до 9 місяців' from dual union all
select 12 id, 'Транші до 12 місяців' from dual union all
select 13 id, 'Транші більше 1 року' from dual
;


PROMPT *** Create  grants  V_SMB_LIST_TERM_DEPOSIT ***

grant SELECT  on v_smb_list_term_deposit  to BARSREADER_ROLE;
grant SELECT  on v_smb_list_term_deposit  to BARS_ACCESS_DEFROLE;

PROMPT =============================================================================
PROMPT *** End *** = Scripts /Sql/BARS/View/V_SMB_LIST_TERM_DEPOSIT.sql =*** End ***
PROMPT ============================================================================= 
