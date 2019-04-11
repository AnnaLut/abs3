PROMPT ==============================================================================
PROMPT *** Run *** == Scripts /Sql/BARS/View/V_SMB_DEPOSIT_ACCOUNT.sql == *** Run ***
PROMPT ============================================================================== 

PROMPT *** Create  view V_SMB_DEPOSIT_ACCOUNT  ***

create or replace force view v_smb_deposit_account 
as
with obj as(   
     select distinct 
            da.account_id
           ,ot.type_code
           ,ot.type_name
           ,d.customer_id
      from object_type ot
          ,object o
          ,deal d
          ,deal_account da
          ,attribute_kind ak
     where 1 = 1
       and ot.type_code in ('SMB_DEPOSIT_TRANCHE', 'SMB_DEPOSIT_ON_DEMAND')
       and o.object_type_id = ot.id
       and o.id = d.id
       and d.id = da.deal_id
       and da.account_type_id = ak.id
       and ak.attribute_code = 'DEPOSIT_PRIMARY_ACCOUNT'
       )
select a.daos start_date
      ,a.dazs close_date
      ,a.nls  account_number
      ,c.lcv currency_name
      ,a.ostc / c.denom   account_balance 
      ,a.kv currency_id
      ,o.type_code  deposit_code
      ,o.type_name  deposit_name
      ,a.acc account_id
      ,o.customer_id
  from obj o
      ,accounts a
      ,tabval c  
 where o.account_id = a.acc     
   and a.kv = c.kv 
;

PROMPT *** Create  grants  V_SMB_DEPOSIT_ACCOUNT ***

grant SELECT  on v_smb_deposit_account  to BARSREADER_ROLE;
grant SELECT  on v_smb_deposit_account  to BARS_ACCESS_DEFROLE;

PROMPT ==============================================================================
PROMPT *** End *** == Scripts /Sql/BARS/View/v_smb_deposit_account.sql == *** End ***
PROMPT ==============================================================================