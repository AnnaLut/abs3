

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/View/V_OP_FIELD.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OP_FIELD ***

  CREATE OR REPLACE FORCE VIEW BARSAQ.V_OP_FIELD ("TAG", "NAME") AS 
  select tag, name from bars.op_field;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/View/V_OP_FIELD.sql =========*** End *** =
PROMPT ===================================================================================== 
