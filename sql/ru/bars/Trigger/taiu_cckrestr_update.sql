

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_CCKRESTR_UPDATE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_CCKRESTR_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_CCKRESTR_UPDATE 
after insert or update or delete
   on BARS.CCK_RESTR for each row
declare
  l_rec    CCK_RESTR_UPDATE%rowtype;
begin

  if deleting
  then

    l_rec.chgaction := 'D';

    l_rec.restr_id  := :old.restr_id;
    l_rec.nd        := :old.nd;
    l_rec.fdat      := :old.fdat;
    l_rec.vid_restr := :old.vid_restr;
    l_rec.txt       := :old.txt;
    l_rec.sumr      := :old.sumr;
    l_rec.fdat_end  := :old.fdat_end;
    l_rec.pr_no     := :old.pr_no;
    l_rec.s_restr   := :old.s_restr;
    l_rec.n_dodatok := :old.n_dodatok;
    l_rec.qty_pay   := :old.qty_pay;

  else

    if updating
    then
      if ( (:old.ND          != :new.ND) or
           (:old.ND is Null AND :new.ND is Not Null) or
           (:new.ND is Null AND :old.ND is Not Null)
           OR
           (:old.FDAT          != :new.FDAT) or
           (:old.FDAT is Null AND :new.FDAT is Not Null) or
           (:new.FDAT is Null AND :old.FDAT is Not Null)
           OR
           (:old.VID_RESTR          != :new.VID_RESTR) or
           (:old.VID_RESTR is Null AND :new.VID_RESTR is Not Null) or
           (:new.VID_RESTR is Null AND :old.VID_RESTR is Not Null)
           OR
           (:old.TXT          != :new.TXT) or
           (:old.TXT is Null AND :new.TXT is Not Null) or
           (:new.TXT is Null AND :old.TXT is Not Null)
           OR
           (:old.SUMR          != :new.SUMR) or
           (:old.SUMR is Null AND :new.SUMR is Not Null) or
           (:new.SUMR is Null AND :old.SUMR is Not Null)
           OR
           (:old.FDAT_END          != :new.FDAT_END) or
           (:old.FDAT_END is Null AND :new.FDAT_END is Not Null) or
           (:new.FDAT_END is Null AND :old.FDAT_END is Not Null)
           OR
           (:old.PR_NO          != :new.PR_NO) or
           (:old.PR_NO is Null AND :new.PR_NO is Not Null) or
           (:new.PR_NO is Null AND :old.PR_NO is Not Null)
           OR
           (:old.RESTR_ID != :new.RESTR_ID)
           OR
           (:old.S_RESTR          != :new.S_RESTR) or
           (:old.S_RESTR is Null AND :new.S_RESTR is Not Null) or
           (:new.S_RESTR is Null AND :old.S_RESTR is Not Null)
           OR
           (:old.N_DODATOK          != :new.N_DODATOK) or
           (:old.N_DODATOK is Null AND :new.N_DODATOK is Not Null) or
           (:new.N_DODATOK is Null AND :old.N_DODATOK is Not Null)
           OR
           (:old.QTY_PAY          != :new.QTY_PAY) or
           (:old.QTY_PAY is Null AND :new.QTY_PAY is Not Null) or
           (:new.QTY_PAY is Null AND :old.QTY_PAY is Not Null)
         )
      then
        l_rec.CHGACTION := 'U';
      end if;

    else
      l_rec.chgaction := 'I';
    end if;

    l_rec.restr_id  := :new.restr_id;
    l_rec.nd        := :new.nd;
    l_rec.fdat      := :new.fdat;
    l_rec.vid_restr := :new.vid_restr;
    l_rec.txt       := :new.txt;
    l_rec.sumr      := :new.sumr;
    l_rec.fdat_end  := :new.fdat_end;
    l_rec.pr_no     := :new.pr_no;
    l_rec.s_restr   := :new.s_restr;
    l_rec.n_dodatok := :new.n_dodatok;
    l_rec.qty_pay   := :new.qty_pay;

  end if;

  If (l_rec.chgaction Is Not Null)
  then

    l_rec.IDUPD      := S_CCK_RESTR_UPDATE.NextVal;
    l_rec.EFFECTDATE := COALESCE(gl.bd, glb_bankdate);
    l_rec.CHGDATE    := sysdate;
    l_rec.DONEBY     := gl.aUID;

    insert into BARS.CCK_RESTR_UPDATE
    values l_rec;

  End If;

end;
/
ALTER TRIGGER BARS.TAIU_CCKRESTR_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_CCKRESTR_UPDATE.sql =========**
PROMPT ===================================================================================== 
