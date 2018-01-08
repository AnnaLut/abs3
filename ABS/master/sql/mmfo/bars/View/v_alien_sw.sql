

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ALIEN_SW.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ALIEN_SW ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ALIEN_SW ("NLS", "NAME", "ADDRESS", "ID", "REC_ID") AS 
  select "NLS","NAME","ADDRESS","ID","REC_ID" from alien_sw where id=user_id;

PROMPT *** Create  grants  V_ALIEN_SW ***
grant SELECT                                                                 on V_ALIEN_SW      to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_ALIEN_SW      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ALIEN_SW      to UPLD;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_ALIEN_SW      to WR_DOC_INPUT;
grant FLASHBACK,SELECT                                                       on V_ALIEN_SW      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ALIEN_SW.sql =========*** End *** ===
PROMPT ===================================================================================== 
