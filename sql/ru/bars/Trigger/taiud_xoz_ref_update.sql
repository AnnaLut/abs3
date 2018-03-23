PROMPT ===================================================================================== 
PROMPT *** Run *** === Scripts /Sql/BARS/Trigger/TAIUD_XOZ_REF_UPDATE.sql ==*** Run *** ====
PROMPT ===================================================================================== 

PROMPT *** Create  trigger TAIUD_XOZ_REF_UPDATE ***

CREATE OR REPLACE TRIGGER BARS.TAIUD_XOZ_REF_UPDATE
after insert or update or delete on BARS.XOZ_REF
for each row
declare
  -- version 1.0 06/12/2017 V.Kharin
  l_rec    XOZ_REF_UPDATE%rowtype;

  procedure SAVE_CHANGES
  is
  begin

    if ( l_rec.CHGACTION = 'D' )

    then l_rec.REF1  := :old.REF1;    l_rec.STMT1 := :old.STMT1;
         l_rec.REF2  := :old.REF2;    l_rec.ACC   := :old.ACC;
         l_rec.MDATE := :old.MDATE;   l_rec.S     := :old.S;
         l_rec.FDAT  := :old.FDAT;    l_rec.S0    := :old.S0;
         l_rec.NOTP  := :old.NOTP;    l_rec.PRG   := :old.PRG;
         l_rec.BU    := :old.BU;      l_rec.DATZ  := :old.DATZ;
         l_rec.REFD  := :old.REFD;    l_rec.KF    := :old.KF;
         l_rec.ID    := :old.ID;
    else l_rec.REF1  := :new.REF1;    l_rec.STMT1 := :new.STMT1;
         l_rec.REF2  := :new.REF2;    l_rec.ACC   := :new.ACC;
         l_rec.MDATE := :new.MDATE;   l_rec.S     := :new.S;
         l_rec.FDAT  := :new.FDAT;    l_rec.S0    := :new.S0;
         l_rec.NOTP  := :new.NOTP;    l_rec.PRG   := :new.PRG;
         l_rec.BU    := :new.BU;      l_rec.DATZ  := :new.DATZ;
         l_rec.REFD  := :new.REFD;    l_rec.KF    := :new.KF;
         l_rec.ID    := :new.ID;
    end if;

    l_rec.IDUPD        := bars_sqnc.get_nextval('s_xoz_ref_update', l_rec.KF);
    l_rec.EFFECTDATE   := COALESCE(gl.bd, glb_bankdate);
    l_rec.GLOBAL_BD    := glb_bankdate;
    l_rec.CHGDATE      := sysdate;
    l_rec.DONEBY       := bars.gl.aUID; --user;

    insert into BARS.XOZ_REF_UPDATE
    values l_rec;
  end SAVE_CHANGES;

begin
  case
    when inserting
    then l_rec.CHGACTION := 'I';
         SAVE_CHANGES;

    when deleting
    then l_rec.CHGACTION := 'D';
         SAVE_CHANGES;

    when updating
    then
      case --:old.VALUE != :new.VALUE OR (:old.VALUE is Null AND :new.VALUE is Not Null) OR (:new.VALUE is Null AND :old.VALUE is Not Null)
         when ( (:old.REF1  = :new.REF1  or coalesce(:old.REF1,  :new.REF1 ) is null) and
                (:old.STMT1 = :new.STMT1 or coalesce(:old.STMT1, :new.STMT1) is null) and
                (:old.REF2  = :new.REF2  or coalesce(:old.REF2,  :new.REF2 ) is null) and
                (:old.ACC   = :new.ACC   or coalesce(:old.ACC,   :new.ACC  ) is null) and
                (:old.MDATE = :new.MDATE or coalesce(:old.MDATE, :new.MDATE) is null) and
                (:old.S     = :new.S     or coalesce(:old.S,     :new.S    ) is null) and
                (:old.FDAT  = :new.FDAT  or coalesce(:old.FDAT,  :new.FDAT ) is null) and
                (:old.S0    = :new.S0    or coalesce(:old.S0,    :new.S0   ) is null) and
                (:old.NOTP  = :new.NOTP  or coalesce(:old.NOTP,  :new.NOTP ) is null) and
                (:old.PRG   = :new.PRG   or coalesce(:old.PRG,   :new.PRG  ) is null) and
                (:old.BU    = :new.BU    or coalesce(:old.BU,    :new.BU   ) is null) and
                (:old.DATZ  = :new.DATZ  or coalesce(:old.DATZ,  :new.DATZ ) is null) and
                (:old.REFD  = :new.REFD  or coalesce(:old.REFD,  :new.REFD ) is null) and
                (:old.KF    = :new.KF    or coalesce(:old.KF,    :new.KF   ) is null) and
                (:old.ID    = :new.ID    or coalesce(:old.ID,    :new.ID   ) is null) )
         then 
              null;
         else -- При зміні значеннь полів, що НЕ входять в PRIMARY KEY
              -- протоколюємо внесені зміни
              l_rec.CHGACTION := 'U';
              SAVE_CHANGES;
        end case;
    else
      null;
  end case;
end;
/

ALTER TRIGGER BARS.TAIUD_XOZ_REF_UPDATE ENABLE;

PROMPT ===================================================================================== 
PROMPT *** End *** === Scripts /Sql/BARS/Trigger/TAIUD_XOZ_REF_UPDATE.sql ==*** End *** ====
PROMPT ===================================================================================== 