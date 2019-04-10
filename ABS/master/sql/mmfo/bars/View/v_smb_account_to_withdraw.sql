PROMPT ================================================================================
PROMPT *** Run *** = Scripts /Sql/BARS/View/V_SMB_ACCOUNT_TO_WITHDRAW.sql = *** Run ***
PROMPT ================================================================================ 

PROMPT *** Create  view V_SMB_ACCOUNT_TO_WITHDRAW  ***

create or replace force view V_SMB_ACCOUNT_TO_WITHDRAW 
as
-- выбор счета для списания
select a.acc, a.rnk, a.nls, a.nms, a.ostc / v.denom ostc, a.branch, a.kv
  from accounts a
      ,tabval$global v
where a.nbs in ('2600', '2650') 
  and a.dazs is null 
  and a.kv = v.kv 
  and a.ob22 = '01'
  and not exists (-- без депозитов по требованию -- они имею такие же счета 2600, 2650
                  select null
                    from object_type ot
                        ,object o  
                        ,attribute_kind ak  
                        ,deal_account da
                   where 1 = 1
                     and ot.type_code = 'SMB_DEPOSIT_ON_DEMAND' 
                     and ot.id = o.object_type_id
                     and o.id = da.deal_id
                     and da.account_id = a.acc
                     and ak.attribute_code = 'DEPOSIT_PRIMARY_ACCOUNT'
                     and da.account_type_id = ak.id)                     
;

PROMPT *** Create  grants  V_SMB_ACCOUNT_TO_WITHDRAW ***

grant SELECT  on V_SMB_ACCOUNT_TO_WITHDRAW  to BARSREADER_ROLE;
grant SELECT  on V_SMB_ACCOUNT_TO_WITHDRAW  to BARS_ACCESS_DEFROLE;

PROMPT ================================================================================
PROMPT *** End *** = Scripts /Sql/BARS/View/V_SMB_ACCOUNT_TO_WITHDRAW.sql = *** End ***
PROMPT ================================================================================