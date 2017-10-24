

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_PFU_PENS_BLOCK_TYPE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PFU_PENS_BLOCK_TYPE ***

  CREATE OR REPLACE FORCE VIEW PFU.V_PFU_PENS_BLOCK_TYPE ("ID", "NAME") AS 
  select "ID","NAME"
    from PFU_PENS_BLOCK_TYPE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_PFU_PENS_BLOCK_TYPE.sql =========*** E
PROMPT ===================================================================================== 
