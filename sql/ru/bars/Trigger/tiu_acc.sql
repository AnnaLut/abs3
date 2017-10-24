

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_ACC.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_ACC ***

  CREATE OR REPLACE TRIGGER BARS.TIU_ACC 
AFTER INSERT OR UPDATE OF accc, blkd, blkk, dazs, isp, kv, lim, ostx, pos,
                          nbs, nls, nlsalt, nms, pap, grp, sec, seci, seco,
                          tip, vid, tobo, mdate, rnk, daos, branch, ob22
                        , send_sms
ON ACCOUNTS
FOR EACH ROW

--Stores values in temp variables assuming trigger tiu_acca
--       write it into accounts_update table.
--VER @(#) tiu_acc.sql 4.6 10/06/2015

DECLARE
--'No group accounts update allowed';
  ern          NUMBER := 3;
  err          EXCEPTION;
BEGIN

  IF pul.acc_rec.acc IS NOT NULL
  THEN
    RAISE err;
  END IF;

  if inserting or updating and
     ( :new.accc<>:old.accc or         (:old.accc is null and :new.accc is not null) or
                                       (:old.accc is not null and :new.accc is null) or
       :new.blkd<>:old.blkd or         (:old.blkd is null and :new.blkd is not null) or
                                       (:old.blkd is not null and :new.blkd is null) or
       :new.blkk<>:old.blkk or         (:old.blkk is null and :new.blkk is not null) or
                                       (:old.blkk is not null and :new.blkk is null) or
       :new.dazs<>:old.dazs or         (:old.dazs is null and :new.dazs is not null) or
                                       (:old.dazs is not null and :new.dazs is null) or
       :new.isp<>:old.isp or           (:old.isp is null and :new.isp is not null) or
                                       (:old.isp is not null and :new.isp is null) or
       :new.kv<>:old.kv or             (:old.kv is null and :new.kv is not null) or
                                       (:old.kv is not null and :new.kv is null) or
       :new.lim<>:old.lim or           (:old.lim is null and :new.lim is not null) or
                                       (:old.lim is not null and :new.lim is null) or
       :new.ostx<>:old.ostx or         (:old.ostx is null and :new.ostx is not null) or
                                       (:old.ostx is not null and :new.ostx is null) or
       :new.pos<>:old.pos or           (:old.pos is null and :new.pos is not null) or
                                       (:old.pos is not null and :new.pos is null) or
       :new.nbs<>:old.nbs or           (:old.nbs is null and :new.nbs is not null) or
                                       (:old.nbs is not null and :new.nbs is null) or
       :new.nls<>:old.nls or           (:old.nls is null and :new.nls is not null) or
                                       (:old.nls is not null and :new.nls is null) or
       :new.nlsalt<>:old.nlsalt or     (:old.nlsalt is null and :new.nlsalt is not null) or
                                       (:old.nlsalt is not null and :new.nlsalt is null) or
       :new.nms<>:old.nms or           (:old.nms is null and :new.nms is not null) or
                                       (:old.nms is not null and :new.nms is null) or
       :new.pap<>:old.pap or           (:old.pap is null and :new.pap is not null) or
                                       (:old.pap is not null and :new.pap is null) or
       :new.grp<>:old.grp or           (:old.grp is null and :new.grp is not null) or
                                       (:old.grp is not null and :new.grp is null) or
       :new.sec<>:old.sec or           (:old.sec is null and :new.sec is not null) or
                                       (:old.sec is not null and :new.sec is null) or
       :new.seci<>:old.seci or         (:old.seci is null and :new.seci is not null) or
                                       (:old.seci is not null and :new.seci is null) or
       :new.seco <>:old.seco or        (:old.seco is null and :new.seco is not null) or
                                       (:old.seco is not null and :new.seco is null) or
       :new.tip <>:old.tip or          (:old.tip is null and :new.tip is not null) or
                                       (:old.tip is not null and :new.tip is null) or
       :new.vid<>:old.vid or           (:old.vid is null and :new.vid is not null) or
                                       (:old.vid is not null and :new.vid is null) or
       :new.tobo<>:old.tobo or         (:old.tobo is null and :new.tobo is not null) or
                                       (:old.tobo is not null and :new.tobo is null) or
       :new.mdate<>:old.mdate or       (:old.mdate is null and :new.mdate is not null) or
                                       (:old.mdate is not null and :new.mdate is null) or
       :new.rnk<>:old.rnk or           (:old.rnk is null and :new.rnk is not null) or
                                       (:old.rnk is not null and :new.rnk is null) or
       :new.daos<>:old.daos or
       :new.branch <> :old.branch   or
       :new.ob22 <> :old.ob22       or (:old.ob22 is null and :new.ob22 is not null) or
                                       (:old.ob22 is not null and :new.ob22 is null)
       or
       :new.send_sms<>:old.send_sms or (:old.send_sms is null and :new.send_sms is not null) or
                                       (:old.send_sms is not null and :new.send_sms is null)
    ) then

    IF INSERTING
    THEN -- Account opened
      pul.acc_otm := 1;
    ELSE
      CASE
        WHEN :OLD.dazs IS NULL AND :NEW.dazs IS NOT NULL
        THEN -- Account closed
          pul.acc_otm := 3;

        WHEN :OLD.dazs IS NOT NULL AND :NEW.dazs IS NULL
        THEN -- "Resurection"
          pul.acc_otm := 0;

        WHEN :OLD.daos <> :NEW.daos
        THEN -- "DAOS was changed"
          pul.acc_otm := 4;

        ELSE
          pul.acc_otm := 2;
      END CASE;
    END IF;

    pul.acc_rec.acc      := :NEW.acc;
    pul.acc_rec.nls      := :NEW.nls;
    pul.acc_rec.nlsalt   := :NEW.nlsalt;
    pul.acc_rec.kv       := :NEW.kv;
    pul.acc_rec.nbs      := :NEW.nbs;
    pul.acc_rec.nbs2     := :NEW.nbs2;
    pul.acc_rec.daos     := :NEW.daos;
    pul.acc_rec.isp      := :NEW.isp;
    pul.acc_rec.nms      := :NEW.nms;
    pul.acc_rec.pap      := :NEW.pap;
    pul.acc_rec.grp      := :NEW.grp;
    pul.acc_rec.sec      := :NEW.sec;
    pul.acc_rec.seci     := :NEW.seci;
    pul.acc_rec.seco     := :NEW.seco;
    pul.acc_rec.vid      := :NEW.vid;
    pul.acc_rec.tip      := :NEW.tip;
    pul.acc_rec.dazs     := :NEW.dazs;
    pul.acc_rec.blkd     := :NEW.blkd;
    pul.acc_rec.blkk     := :NEW.blkk;
    pul.acc_rec.lim      := :NEW.lim;
    pul.acc_rec.ostx     := :NEW.ostx;
    pul.acc_rec.pos      := :NEW.pos;
    pul.acc_rec.accc     := :NEW.accc;
    pul.acc_rec.tobo     := :NEW.tobo;
    pul.acc_rec.mdate    := :NEW.mdate;
    pul.acc_rec.rnk      := :NEW.rnk;
    pul.acc_rec.daos     := :NEW.daos;
    pul.acc_rec.branch   := :NEW.branch;
    pul.acc_rec.ob22     := :NEW.ob22;
    pul.acc_rec.send_sms := :NEW.send_sms;
  end if;

EXCEPTION
  WHEN err THEN
    bars_error.raise_error('CAC',ern);
END tiu_acc;
/
ALTER TRIGGER BARS.TIU_ACC ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_ACC.sql =========*** End *** ===
PROMPT ===================================================================================== 
