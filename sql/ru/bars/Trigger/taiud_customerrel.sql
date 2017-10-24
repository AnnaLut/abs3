

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_CUSTOMERREL.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_CUSTOMERREL ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_CUSTOMERREL 
after insert or update or delete
ON BARS.CUSTOMER_REL for each row
declare
  l_rec  CUSTOMER_REL_UPDATE%rowtype;
begin

  if deleting
  then

    l_rec.CHGACTION        := 3;

    l_rec.RNK              := :old.RNK;
    l_rec.REL_ID           := :old.REL_ID;
    l_rec.REL_RNK          := :old.REL_RNK;
    l_rec.REL_INTEXT       := :old.REL_INTEXT;
    l_rec.VAGA1            := :old.VAGA1;
    l_rec.VAGA2            := :old.VAGA2;
    l_rec.TYPE_ID          := :old.TYPE_ID;
    l_rec.POSITION         := :old.POSITION;
    l_rec.FIRST_NAME       := :old.FIRST_NAME;
    l_rec.MIDDLE_NAME      := :old.MIDDLE_NAME;
    l_rec.LAST_NAME        := :old.LAST_NAME;
    l_rec.DOCUMENT_TYPE_ID := :old.DOCUMENT_TYPE_ID;
    l_rec.DOCUMENT         := :old.DOCUMENT;
    l_rec.TRUST_REGNUM     := :old.TRUST_REGNUM;
    l_rec.TRUST_REGDAT     := :old.TRUST_REGDAT;
    l_rec.BDATE            := :old.BDATE;
    l_rec.EDATE            := :old.EDATE;
    l_rec.NOTARY_NAME      := :old.NOTARY_NAME;
    l_rec.NOTARY_REGION    := :old.NOTARY_REGION;
    l_rec.SIGN_PRIVS       := :old.SIGN_PRIVS;
    l_rec.SIGN_ID          := :old.SIGN_ID;
    l_rec.NAME_R           := :old.NAME_R;
    l_rec.POSITION_R       := :old.POSITION_R;

  else

    if updating
    then

      if ( (:old.RNK != :new.RNK)
           OR
           (:old.REL_ID != :new.REL_ID)
           OR
           (:old.REL_RNK != :new.REL_RNK)
           OR
           (:old.REL_INTEXT != :new.REL_INTEXT)
           OR
           (:old.VAGA1          != :new.VAGA1) or
           (:old.VAGA1 is Null AND :new.VAGA1 is Not Null) or
           (:new.VAGA1 is Null AND :old.VAGA1 is Not Null)
           OR
           (:old.VAGA2          != :new.VAGA2) or
           (:old.VAGA2 is Null AND :new.VAGA2 is Not Null) or
           (:new.VAGA2 is Null AND :old.VAGA2 is Not Null)
           OR
           (:old.TYPE_ID          != :new.TYPE_ID) or
           (:old.TYPE_ID is Null AND :new.TYPE_ID is Not Null) or
           (:new.TYPE_ID is Null AND :old.TYPE_ID is Not Null)
           OR
           (:old.POSITION          != :new.POSITION) or
           (:old.POSITION is Null AND :new.POSITION is Not Null) or
           (:new.POSITION is Null AND :old.POSITION is Not Null)
           OR
           (:old.FIRST_NAME          != :new.FIRST_NAME) or
           (:old.FIRST_NAME is Null AND :new.FIRST_NAME is Not Null) or
           (:new.FIRST_NAME is Null AND :old.FIRST_NAME is Not Null)
           OR
           (:old.MIDDLE_NAME          != :new.MIDDLE_NAME) or
           (:old.MIDDLE_NAME is Null AND :new.MIDDLE_NAME is Not Null) or
           (:new.MIDDLE_NAME is Null AND :old.MIDDLE_NAME is Not Null)
           OR
           (:old.LAST_NAME          != :new.LAST_NAME) or
           (:old.LAST_NAME is Null AND :new.LAST_NAME is Not Null) or
           (:new.LAST_NAME is Null AND :old.LAST_NAME is Not Null)
           OR
           (:old.DOCUMENT_TYPE_ID          != :new.DOCUMENT_TYPE_ID) or
           (:old.DOCUMENT_TYPE_ID is Null AND :new.DOCUMENT_TYPE_ID is Not Null) or
           (:new.DOCUMENT_TYPE_ID is Null AND :old.DOCUMENT_TYPE_ID is Not Null)
           OR
           (:old.DOCUMENT          != :new.DOCUMENT) or
           (:old.DOCUMENT is Null AND :new.DOCUMENT is Not Null) or
           (:new.DOCUMENT is Null AND :old.DOCUMENT is Not Null)
           OR
           (:old.TRUST_REGNUM          != :new.TRUST_REGNUM) or
           (:old.TRUST_REGNUM is Null AND :new.TRUST_REGNUM is Not Null) or
           (:new.TRUST_REGNUM is Null AND :old.TRUST_REGNUM is Not Null)
           OR
           (:old.TRUST_REGDAT          != :new.TRUST_REGDAT) or
           (:old.TRUST_REGDAT is Null AND :new.TRUST_REGDAT is Not Null) or
           (:new.TRUST_REGDAT is Null AND :old.TRUST_REGDAT is Not Null)
           OR
           (:old.BDATE          != :new.BDATE) or
           (:old.BDATE is Null AND :new.BDATE is Not Null) or
           (:new.BDATE is Null AND :old.BDATE is Not Null)
           OR
           (:old.EDATE          != :new.EDATE) or
           (:old.EDATE is Null AND :new.EDATE is Not Null) or
           (:new.EDATE is Null AND :old.EDATE is Not Null)
           OR
           (:old.NOTARY_NAME          != :new.NOTARY_NAME) or
           (:old.NOTARY_NAME is Null AND :new.NOTARY_NAME is Not Null) or
           (:new.NOTARY_NAME is Null AND :old.NOTARY_NAME is Not Null)
           OR
           (:old.NOTARY_REGION          != :new.NOTARY_REGION) or
           (:old.NOTARY_REGION is Null AND :new.NOTARY_REGION is Not Null) or
           (:new.NOTARY_REGION is Null AND :old.NOTARY_REGION is Not Null)
           OR
           (:old.SIGN_PRIVS          != :new.SIGN_PRIVS) or
           (:old.SIGN_PRIVS is Null AND :new.SIGN_PRIVS is Not Null) or
           (:new.SIGN_PRIVS is Null AND :old.SIGN_PRIVS is Not Null)
           OR
           (:old.SIGN_ID          != :new.SIGN_ID) or
           (:old.SIGN_ID is Null AND :new.SIGN_ID is Not Null) or
           (:new.SIGN_ID is Null AND :old.SIGN_ID is Not Null)
           OR
           (:old.NAME_R          != :new.NAME_R) or
           (:old.NAME_R is Null AND :new.NAME_R is Not Null) or
           (:new.NAME_R is Null AND :old.NAME_R is Not Null)
           OR
           (:old.POSITION_R          != :new.POSITION_R) or
           (:old.POSITION_R is Null AND :new.POSITION_R is Not Null) or
           (:new.POSITION_R is Null AND :old.POSITION_R is Not Null)


         )
      then
        l_rec.CHGACTION := 2;
      end if;

    else -- inserting
      l_rec.CHGACTION := 1;
    end if;

    l_rec.RNK              := :new.RNK;
    l_rec.REL_ID           := :new.REL_ID;
    l_rec.REL_RNK          := :new.REL_RNK;
    l_rec.REL_INTEXT       := :new.REL_INTEXT;
    l_rec.VAGA1            := :new.VAGA1;
    l_rec.VAGA2            := :new.VAGA2;
    l_rec.TYPE_ID          := :new.TYPE_ID;
    l_rec.POSITION         := :new.POSITION;
    l_rec.FIRST_NAME       := :new.FIRST_NAME;
    l_rec.MIDDLE_NAME      := :new.MIDDLE_NAME;
    l_rec.LAST_NAME        := :new.LAST_NAME;
    l_rec.DOCUMENT_TYPE_ID := :new.DOCUMENT_TYPE_ID;
    l_rec.DOCUMENT         := :new.DOCUMENT;
    l_rec.TRUST_REGNUM     := :new.TRUST_REGNUM;
    l_rec.TRUST_REGDAT     := :new.TRUST_REGDAT;
    l_rec.BDATE            := :new.BDATE;
    l_rec.EDATE            := :new.EDATE;
    l_rec.NOTARY_NAME      := :new.NOTARY_NAME;
    l_rec.NOTARY_REGION    := :new.NOTARY_REGION;
    l_rec.SIGN_PRIVS       := :new.SIGN_PRIVS;
    l_rec.SIGN_ID          := :new.SIGN_ID;
    l_rec.NAME_R           := :new.NAME_R;
    l_rec.POSITION_R       := :new.POSITION_R;

  end if;

  If (l_rec.CHGACTION Is Not Null)
  then

    l_rec.IDUPD        := s_customerrelupdate.NextVal;
    l_rec.CHGDATE      := sysdate;
    l_rec.DONEBY       := user;
    l_rec.GLOBAL_BDATE := glb_bankdate;
    l_rec.EFFECTDATE   := COALESCE(gl.bd, glb_bankdate);

    insert into BARS.CUSTOMER_REL_UPDATE
    values l_rec;

  End If;

    --VIP
    if(:NEW.REL_ID=60) then
        p_vip_relation(:new.rnk, :new.rel_rnk);
        p_vip_relation(:new.rel_rnk, :new.rnk);
    end if;

end TAIUD_CUSTOMERREL;
/
ALTER TRIGGER BARS.TAIUD_CUSTOMERREL ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_CUSTOMERREL.sql =========*** E
PROMPT ===================================================================================== 
