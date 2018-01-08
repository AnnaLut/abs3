

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/W4_ACCOUNTS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view W4_ACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARS.W4_ACCOUNTS ("ACC_MODE", "ACC") AS 
  select 'PK', acc_pk from w4_acc
union
select 'OVR', acc_ovr from w4_acc where acc_ovr is not null
union
select '9129', acc_9129 from w4_acc where acc_9129 is not null
union
select '3570', acc_3570 from w4_acc where acc_3570 is not null
union
select '2208', acc_2208 from w4_acc where acc_2208 is not null
union
select '2627', acc_2627 from w4_acc where acc_2627 is not null
union
select '2207', acc_2207 from w4_acc where acc_2207 is not null
union
select '3579', acc_3579 from w4_acc where acc_3579 is not null
union
select '2209', acc_2209 from w4_acc where acc_2209 is not null
union
select '2628', acc_2628 from w4_acc where acc_2628 is not null
union
select '2625X', acc_2625X from w4_acc where acc_2625X is not null
union
select '2627X', acc_2627X from w4_acc where acc_2627X is not null
union
select '2625D', acc_2625D from w4_acc where acc_2625D is not null;

PROMPT *** Create  grants  W4_ACCOUNTS ***
grant SELECT                                                                 on W4_ACCOUNTS     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on W4_ACCOUNTS     to CUST001;
grant SELECT                                                                 on W4_ACCOUNTS     to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/W4_ACCOUNTS.sql =========*** End *** ==
PROMPT ===================================================================================== 
