

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/View/V_PROBLEM_DOCS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PROBLEM_DOCS ***

  CREATE OR REPLACE FORCE VIEW BARSAQ.V_PROBLEM_DOCS ("BANK_REF") AS 
  select bank_ref from (select 65404719 bank_ref from dual union all 
select 68881908 bank_ref from dual union all 
select 69569027 bank_ref from dual union all 
select 270963740 bank_ref from dual union all 
 select null from dual) where bank_ref is not null;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/View/V_PROBLEM_DOCS.sql =========*** End *
PROMPT ===================================================================================== 
