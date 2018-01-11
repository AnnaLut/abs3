

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ALIEN_BANK_SW.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ALIEN_BANK_SW ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ALIEN_BANK_SW ("NLS", "BIC", "NAME", "ADDRESS", "ID", "REC_ID") AS 
  select "NLS","BIC","NAME","ADDRESS","ID","REC_ID" from alien_bank_sw where id=user_id;

PROMPT *** Create  grants  V_ALIEN_BANK_SW ***
grant SELECT                                                                 on V_ALIEN_BANK_SW to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_ALIEN_BANK_SW to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ALIEN_BANK_SW to START1;
grant SELECT                                                                 on V_ALIEN_BANK_SW to UPLD;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_ALIEN_BANK_SW to WR_DOC_INPUT;
grant FLASHBACK,SELECT                                                       on V_ALIEN_BANK_SW to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ALIEN_BANK_SW.sql =========*** End **
PROMPT ===================================================================================== 
