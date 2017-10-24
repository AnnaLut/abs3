

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIUD_STO_DET.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIUD_STO_DET ***

  CREATE OR REPLACE TRIGGER BARS.TIUD_STO_DET 
after insert or update or delete ON BARS.STO_DET for each row
declare
  --------------------
  -- коммерч.банк   --
  --------------------
  l_bankdate date          := gl.bdate;
  l_userid   number(38)    := gl.auid;
  l_actionid number(1);
  l_idupd    number(38);
begin
  if deleting then
    l_actionid := -1; -- удаление
    
    select bars_sqnc.get_nextval('S_STO_DET_UPDATE')into l_idupd from dual;

    INSERT INTO sto_det_update (IDS,
                                VOB,
                                DK,
                                TT,
                                NLSA,
                                KVA,
                                NLSB,
                                KVB,
                                MFOB,
                                POLU,
                                NAZN,
                                FSUM,
                                OKPO,
                                DAT1,
                                DAT2,
                                FREQ,
                                DAT0,
                                WEND,
                                STMP,
                                IDD,
                                ORD,
                                KF,
                                DR,
                                BRANCH,
                                STATUS_ID,
                                DISCLAIM_ID,
                                STATUS_DATE,
                                STATUS_UID,
                                ACTION,
                                IDUPD,
                                "WHEN",
                                USERID)
         VALUES (:old.IDS,
                 :old.VOB,
                 :old.DK,
                 :old.TT,
                 :old.NLSA,
                 :old.KVA,
                 :old.NLSB,
                 :old.KVB,
                 :old.MFOB,
                 :old.POLU,
                 :old.NAZN,
                 :old.FSUM,
                 :old.OKPO,
                 :old.DAT1,
                 :old.DAT2,
                 :old.FREQ,
                 :old.DAT0,
                 :old.WEND,
                 :old.STMP,
                 :old.IDD,
                 :old.ORD,
                 :old.KF,
                 :old.DR,
                 :old.BRANCH,
                 :old.STATUS_ID,
                 :old.DISCLAIM_ID,
                 :old.STATUS_DATE,
                 :old.STATUS_UID,
                 l_actionid,
                 l_idupd,
                 SYSDATE,
                 l_userid);

  elsif inserting then

    l_actionid := 0;  -- открытие

    select bars_sqnc.get_nextval('S_STO_DET_UPDATE') into l_idupd from dual;

    insert into sto_det_update
      (IDS,
                                VOB,
                                DK,
                                TT,
                                NLSA,
                                KVA,
                                NLSB,
                                KVB,
                                MFOB,
                                POLU,
                                NAZN,
                                FSUM,
                                OKPO,
                                DAT1,
                                DAT2,
                                FREQ,
                                DAT0,
                                WEND,
                                STMP,
                                IDD,
                                ORD,
                                KF,
                                DR,
                                BRANCH,
                                USERID_MADE,
                                BRANCH_MADE,
                                DATETIMESTAMP,
                                BRANCH_CARD,
                                STATUS_ID,
                                DISCLAIM_ID,
                                STATUS_DATE,
                                STATUS_UID,
                                ACTION,
                                IDUPD,
                                "WHEN",
                                USERID)
    values
                (:new.IDS,
                 :new.VOB,
                 :new.DK,
                 :new.TT,
                 :new.NLSA,
                 :new.KVA,
                 :new.NLSB,
                 :new.KVB,
                 :new.MFOB,
                 :new.POLU,
                 :new.NAZN,
                 :new.FSUM,
                 :new.OKPO,
                 :new.DAT1,
                 :new.DAT2,
                 :new.FREQ,
                 :new.DAT0,
                 :new.WEND,
                 :new.STMP,
                 :new.IDD,
                 :new.ORD,
                 :new.KF,
                 :new.DR,
                 :new.BRANCH,
                 :new.USERID_MADE,
                 :new.BRANCH_MADE,
                 :new.DATETIMESTAMP,
                 :new.BRANCH_CARD,
                 :new.STATUS_ID,
                 :new.DISCLAIM_ID,
                 :new.STATUS_DATE,
                 :new.STATUS_UID,
                 l_actionid,
                 l_idupd,
                 SYSDATE,
                 l_userid);

  elsif updating then
    l_actionid := 1; -- изменение
    -- проверим, действительно ли что-то менялось
    if :old.IDS     != :new.IDS     OR
      :old.VOB     != :new.VOB     OR
      :old.DK      != :new.DK      OR
      :old.TT      != :new.TT      OR
      :old.NLSA    != :new.NLSA    OR
      :old.KVA     != :new.KVA     OR
      :old.NLSB    != :new.NLSB    OR
      :old.KVB     != :new.KVB     OR
      :old.MFOB    != :new.MFOB    OR
      :old.POLU    != :new.POLU    OR
      :old.NAZN    != :new.NAZN    OR
      :old.FSUM    != :new.FSUM    OR
      :old.OKPO    != :new.OKPO    OR
      :old.DAT1    != :new.DAT1    OR
      :old.DAT2    != :new.DAT2    OR
      :old.FREQ    != :new.FREQ    OR
      :old.DAT0    != :new.DAT0    OR
      :old.WEND    != :new.WEND    OR
      :old.STMP    != :new.STMP    OR
      :old.IDD     != :new.IDD     OR
      :old.ORD     != :new.ORD     OR
      :old.KF      != :new.KF      OR
      :old.DR      != :new.DR      OR
      :old.BRANCH  != :new.BRANCH  OR
      :old.USERID_MADE  != :new.USERID_MADE  OR
      :old.BRANCH_MADE  != :new.BRANCH_MADE  OR
      :old.DATETIMESTAMP!= :new.DATETIMESTAMP  OR
      :old.BRANCH_CARD  != :new.BRANCH_CARD  OR
      :old.STATUS_ID    != :new.STATUS_ID  OR
      :old.DISCLAIM_ID  != :new.DISCLAIM_ID  OR
      :old.STATUS_DATE  != :new.STATUS_DATE  OR
      :old.STATUS_UID   != :new.STATUS_UID
    then

      select bars_sqnc.get_nextval('S_STO_DET_UPDATE')into l_idupd from dual;

      INSERT INTO sto_det_update (IDS,
                                VOB,
                                DK,
                                TT,
                                NLSA,
                                KVA,
                                NLSB,
                                KVB,
                                MFOB,
                                POLU,
                                NAZN,
                                FSUM,
                                OKPO,
                                DAT1,
                                DAT2,
                                FREQ,
                                DAT0,
                                WEND,
                                STMP,
                                IDD,
                                ORD,
                                KF,
                                DR,
                                BRANCH,
                                USERID_MADE,
                                BRANCH_MADE,
                                DATETIMESTAMP,
                                BRANCH_CARD,
                                STATUS_ID,
                                DISCLAIM_ID,
                                STATUS_DATE,
                                STATUS_UID,
                                ACTION,
                                IDUPD,
                                "WHEN",
                                USERID)
         VALUES (:new.IDS,
                 :new.VOB,
                 :new.DK,
                 :new.TT,
                 :new.NLSA,
                 :new.KVA,
                 :new.NLSB,
                 :new.KVB,
                 :new.MFOB,
                 :new.POLU,
                 :new.NAZN,
                 :new.FSUM,
                 :new.OKPO,
                 :new.DAT1,
                 :new.DAT2,
                 :new.FREQ,
                 :new.DAT0,
                 :new.WEND,
                 :new.STMP,
                 :new.IDD,
                 :new.ORD,
                 :new.KF,
                 :new.DR,
                 :new.BRANCH,
                 :new.USERID_MADE,
                 :new.BRANCH_MADE,
                 :new.DATETIMESTAMP,
                 :new.BRANCH_CARD,
                 :new.STATUS_ID,
                 :new.DISCLAIM_ID,
                 :new.STATUS_DATE,
                 :new.STATUS_UID,
                 l_actionid,
                 l_idupd,
                 SYSDATE,
                 l_userid);
    else
      return; -- ничего не менялось, выходим
    end if;
  end if;

end;
/
ALTER TRIGGER BARS.TIUD_STO_DET ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIUD_STO_DET.sql =========*** End **
PROMPT ===================================================================================== 
