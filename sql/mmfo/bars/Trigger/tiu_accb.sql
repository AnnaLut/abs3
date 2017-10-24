

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_ACCB.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_ACCB ***

  CREATE OR REPLACE TRIGGER BARS.TIU_ACCB 
BEFORE INSERT OR UPDATE OF accc, blkd, blkk, dazs, isp, kv, lim, ostx, pos,
  nbs, nls, nlsalt, nms, pap, grp, sec, seci, seco, tip, vid, tobo, mdate, rnk, daos, branch, ob22 , send_sms
ON accounts
BEGIN
   gl.acc_rec.acc := NULL;
END tiu_accb;
/
ALTER TRIGGER BARS.TIU_ACCB ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_ACCB.sql =========*** End *** ==
PROMPT ===================================================================================== 
