

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PFU_EPP_LINE.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view PFU_EPP_LINE ***

  CREATE OR REPLACE FORCE VIEW BARS.PFU_EPP_LINE ("NAME_PENSIONER", "TAX_REGISTRATION_NUMBER", "NLS", "EPP_NUMBER", "EPP_EXPIRY_DATE", "KILL_DATE", "KILL_TYPE", "STATE") AS 
  select PELR."LAST_NAME"||' '||PELR."FIRST_NAME"||' '||PELR."MIDDLE_NAME" NAME_PENSIONER,
       PELR."TAX_REGISTRATION_NUMBER",
       PELR."NLS",
       PELR."EPP_NUMBER",
       PELR."EPP_EXPIRY_DATE",
       PEK.KILL_DATE,
       PEK.KILL_TYPE,
       PEK.STATE
  from PFU_EPP_LINE_PROCESSING PELR, PFU_EPP_KILLED PEK
 where PELR.EPP_NUMBER = pek.EPP_NUMBER(+)
;

PROMPT *** Create  grants  PFU_EPP_LINE ***
grant SELECT                                                                 on PFU_EPP_LINE    to BARSREADER_ROLE;
grant SELECT                                                                 on PFU_EPP_LINE    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PFU_EPP_LINE    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PFU_EPP_LINE.sql =========*** End *** =
PROMPT ===================================================================================== 
