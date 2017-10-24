

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OW_REBRANCH_DATA.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OW_REBRANCH_DATA ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OW_REBRANCH_DATA ("ID", "FILEID", "IDN", "RNK", "NLS", "BRANCH", "STATE", "MSG") AS 
  select t.id, t.fileid, t.idn, t.rnk, t.nls, t.branch, t.state, t.msg from ow_rebranch_data t;

PROMPT *** Create  grants  V_OW_REBRANCH_DATA ***
grant SELECT                                                                 on V_OW_REBRANCH_DATA to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OW_REBRANCH_DATA.sql =========*** End
PROMPT ===================================================================================== 
