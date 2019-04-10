PROMPT =============================================================================
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_dbo .sql =========*** Run ***
PROMPT ============================================================================= 

PROMPT *** Create  view V_DBO  ***

create or replace force view v_dbo 
as
select n.value contract_number
      ,d.value contract_date
      ,'1' contract_signature_flag
      ,c.rnk
      ,c.okpo
      ,c.nmk
      ,c.branch
      ,c.kf
  from customerw n
      ,customer c
      ,customerw s 
      ,customerw d 
 where n.tag = 'NDBO'
   and n.rnk = c.rnk
   and c.date_off is null
   and s.rnk = c.rnk 
   and s.tag = 'SDBO' 
   and s.value = '1'
   and d.rnk = c.rnk 
   and d.tag = 'DDBO'
;


PROMPT *** Create  grants  V_DBO ***
grant SELECT  on v_dbo  to BARSREADER_ROLE;
grant SELECT  on v_dbo  to BARS_ACCESS_DEFROLE;

PROMPT =============================================================================
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_dbo .sql =========*** End ***
PROMPT ============================================================================= 
