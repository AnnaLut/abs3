PROMPT =============================================================================
PROMPT *** Run *** = Scripts /Sql/BARS/View/V_SMB_LIST_TERM_DEPOSIT.sql =*** Run ***
PROMPT ============================================================================= 

PROMPT *** Create  view v_smb_list_term_deposit  ***

create or replace force view v_smb_list_term_deposit 
as
select  0 id, '<��>'  name from dual union all
select  1 id, '������ �� 1 ����� �� �� �����' from dual union all
select  3 id, '������ �� 3 ������' from dual union all
select  6 id, '������ �� 6 ������' from dual union all
select  9 id, '������ �� 9 ������' from dual union all
select 12 id, '������ �� 12 ������' from dual union all
select 13 id, '������ ����� 1 ����' from dual
;


PROMPT *** Create  grants  V_SMB_LIST_TERM_DEPOSIT ***

grant SELECT  on v_smb_list_term_deposit  to BARSREADER_ROLE;
grant SELECT  on v_smb_list_term_deposit  to BARS_ACCESS_DEFROLE;

PROMPT =============================================================================
PROMPT *** End *** = Scripts /Sql/BARS/View/V_SMB_LIST_TERM_DEPOSIT.sql =*** End ***
PROMPT ============================================================================= 
