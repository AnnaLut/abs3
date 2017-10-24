

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_V_CCK_REP.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_V_CCK_REP ***

  CREATE OR REPLACE TRIGGER BARS.TAU_V_CCK_REP 
INSTEAD OF INSERT ON V_cck_rep FOR EACH ROW
DECLARE
   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
 if inserting then

 --  logger.info ('CC_REPORTS 2 ND='||:NEW.ND);
 -- raise_application_error(   -(20203), '\OK !',  TRUE );

     Insert into BARS.tmp_CCK_REP
     (BRANCH     , TT     , VOB , VDAT , KV , DK, S  , NAM_A, NLSA , MFOA  , NAM_B , NLSB  , MFOB  , NAZN , S2, KV2 , SQ2, ND, CC_ID, SDATE, NMK) Values
     (:NEW.BRANCH,:NEW.TT,:NEW.VOB,:NEW.VDAT,:NEW.KV,:NEW.DK,:NEW.S,:NEW.NAM_A,:NEW.NLSA,:NEW.MFOA,:NEW.NAM_B,:NEW.NLSB,:NEW.MFOB,:NEW.NAZN ,:NEW.S2,:NEW.KV2,:NEW.SQ2,:NEW.ND,:NEW.CC_ID,:NEW.SDATE,:NEW.NMK);

 end if;
commit;
end;
/
ALTER TRIGGER BARS.TAU_V_CCK_REP ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_V_CCK_REP.sql =========*** End *
PROMPT ===================================================================================== 
