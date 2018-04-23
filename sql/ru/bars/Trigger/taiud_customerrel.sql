PROMPT *** Create  trigger TAIUD_CUSTOMERREL ***
CREATE OR REPLACE TRIGGER BARS.TAIUD_CUSTOMERREL 
after insert or update or delete
ON BARS.CUSTOMER_REL for each row
declare
-- Author : V.Kharin
-- Date   : 08/12/2016
  l_rec  CUSTOMER_REL_UPDATE%rowtype;
  ---
  procedure SAVE_CHANGES
  is
--    l_old_key varchar2(38);
  begin
    
    BARS_AUDIT.TRACE('CUSTOMER_REL_UPDATE3: doneby='||user||', l_rec.EFFECTDATE='||COALESCE(gl.bd, glb_bankdate)||',  l_rec.GLOBAL_BDATE='||glb_bankdate );
   
    if ( l_rec.CHGACTION = '3' )
    then
        l_rec.RNK           := :old.RNK;           l_rec.REL_ID        := :old.REL_ID;       l_rec.REL_RNK          := :old.REL_RNK;
        l_rec.REL_INTEXT    := :old.REL_INTEXT;    l_rec.VAGA1         := :old.VAGA1;        l_rec.VAGA2            := :old.VAGA2;
        l_rec.TYPE_ID       := :old.TYPE_ID;       l_rec.POSITION      := :old.POSITION;     l_rec.FIRST_NAME       := :old.FIRST_NAME;
        l_rec.MIDDLE_NAME   := :old.MIDDLE_NAME;   l_rec.LAST_NAME     := :old.LAST_NAME;    l_rec.DOCUMENT_TYPE_ID := :old.DOCUMENT_TYPE_ID;
        l_rec.DOCUMENT      := :old.DOCUMENT;      l_rec.TRUST_REGNUM  := :old.TRUST_REGNUM; l_rec.TRUST_REGDAT     := :old.TRUST_REGDAT;
        l_rec.BDATE         := :old.BDATE;         l_rec.EDATE         := :old.EDATE;        l_rec.NOTARY_NAME      := :old.NOTARY_NAME;
        l_rec.NOTARY_REGION := :old.NOTARY_REGION; l_rec.SIGN_PRIVS    := :old.SIGN_PRIVS;   l_rec.SIGN_ID          := :old.SIGN_ID;
        l_rec.NAME_R        := :old.NAME_R;        l_rec.POSITION_R    := :old.POSITION_R;
    else
        l_rec.RNK           := :new.RNK;           l_rec.REL_ID        := :new.REL_ID;       l_rec.REL_RNK          := :new.REL_RNK;
        l_rec.REL_INTEXT    := :new.REL_INTEXT;    l_rec.VAGA1         := :new.VAGA1;        l_rec.VAGA2            := :new.VAGA2;
        l_rec.TYPE_ID       := :new.TYPE_ID;       l_rec.POSITION      := :new.POSITION;     l_rec.FIRST_NAME       := :new.FIRST_NAME;
        l_rec.MIDDLE_NAME   := :new.MIDDLE_NAME;   l_rec.LAST_NAME     := :new.LAST_NAME;    l_rec.DOCUMENT_TYPE_ID := :new.DOCUMENT_TYPE_ID;
        l_rec.DOCUMENT      := :new.DOCUMENT;      l_rec.TRUST_REGNUM  := :new.TRUST_REGNUM; l_rec.TRUST_REGDAT     := :new.TRUST_REGDAT;
        l_rec.BDATE         := :new.BDATE;         l_rec.EDATE         := :new.EDATE;        l_rec.NOTARY_NAME      := :new.NOTARY_NAME;
        l_rec.NOTARY_REGION := :new.NOTARY_REGION; l_rec.SIGN_PRIVS    := :new.SIGN_PRIVS;   l_rec.SIGN_ID          := :new.SIGN_ID;
        l_rec.NAME_R        := :new.NAME_R;        l_rec.POSITION_R    := :new.POSITION_R;
    end if;
    
     BARS_AUDIT.TRACE('CUSTOMER_REL_UPDATE2: doneby='||user||', l_rec.EFFECTDATE='||COALESCE(gl.bd, glb_bankdate)||',  l_rec.GLOBAL_BDATE='||glb_bankdate );
   
       
  
    l_rec.IDUPD         := bars_sqnc.get_nextval('s_customerrelupdate');
    l_rec.EFFECTDATE    := COALESCE(gl.bd, glb_bankdate);
    l_rec.GLOBAL_BDATE  := glb_bankdate;    -- sysdate
    l_rec.DONEBY        := user; --gl.aUID;  user_name;
    l_rec.CHGDATE       := sysdate;
   
    
   BARS_AUDIT.TRACE('CUSTOMER_REL_UPDATE4:'|| l_rec.CHGACTION ||' -- '||l_rec.CHGDATE ||' -- '||l_rec.DONEBY ||' -- '||l_rec.EFFECTDATE ||' -- '||l_rec.IDUPD||' -- '||l_rec.GLOBAL_BDATE  ||' -- ' ||' -- '||l_rec.REL_ID ||' -- '||l_rec.REL_INTEXT ||' -- '||l_rec.REL_RNK ||' -- '||l_rec.RNK);  
   
    insert into BARS.CUSTOMER_REL_UPDATE values l_rec;
  end SAVE_CHANGES;
  ---
begin
  case
    when inserting
    then
      l_rec.CHGACTION := 1; --'I';
      SAVE_CHANGES;

    when deleting
    then
      l_rec.CHGACTION := 3; --'D';
      SAVE_CHANGES;

    when updating
    then
      case
        when (:old.RNK <> :new.RNK OR :old.REL_ID <> :new.REL_ID OR :old.REL_RNK <> :new.REL_RNK OR :old.REL_INTEXT <> :new.REL_INTEXT) -- !!! analize changing PRIMARY KEY - columns
        then -- При зміні значеннь полів, що входять в PRIMARY KEY (для правильного відображення при вивантаженні даних до DWH)
          -- породжуємо в історії запис про видалення
          l_rec.CHGACTION := 3; --'D';
          SAVE_CHANGES;

          -- породжуємо в історії запис про вставку
          l_rec.CHGACTION := 1; --'I';
          SAVE_CHANGES;

        when (  :old.RNK <> :new.RNK OR :old.REL_ID <> :new.REL_ID OR :old.REL_RNK <> :new.REL_RNK OR :old.REL_INTEXT <> :new.REL_INTEXT
             OR :old.VAGA1 <> :new.VAGA1                       OR (:old.VAGA1 IS NULL AND :new.VAGA1 IS NOT NULL)                       OR (:old.VAGA1 IS NOT NULL AND :new.VAGA1 IS NULL)
             OR :old.VAGA2 <> :new.VAGA2                       OR (:old.VAGA2 IS NULL AND :new.VAGA2 IS NOT NULL)                       OR (:old.VAGA2 IS NOT NULL AND :new.VAGA2 IS NULL)
             OR :old.TYPE_ID <> :new.TYPE_ID                   OR (:old.TYPE_ID IS NULL AND :new.TYPE_ID IS NOT NULL)                   OR (:old.TYPE_ID IS NOT NULL AND :new.TYPE_ID IS NULL)
             OR :old.POSITION <> :new.POSITION                 OR (:old.POSITION IS NULL AND :new.POSITION IS NOT NULL)                 OR (:old.POSITION IS NOT NULL AND :new.POSITION IS NULL)
             OR :old.FIRST_NAME <> :new.FIRST_NAME             OR (:old.FIRST_NAME IS NULL AND :new.FIRST_NAME IS NOT NULL)             OR (:old.FIRST_NAME IS NOT NULL AND :new.FIRST_NAME IS NULL)
             OR :old.MIDDLE_NAME <> :new.MIDDLE_NAME           OR (:old.MIDDLE_NAME IS NULL AND :new.MIDDLE_NAME IS NOT NULL)           OR (:old.MIDDLE_NAME IS NOT NULL AND :new.MIDDLE_NAME IS NULL)
             OR :old.LAST_NAME <> :new.LAST_NAME               OR (:old.LAST_NAME IS NULL AND :new.LAST_NAME IS NOT NULL)               OR (:old.LAST_NAME IS NOT NULL AND :new.LAST_NAME IS NULL)
             OR :old.DOCUMENT_TYPE_ID <> :new.DOCUMENT_TYPE_ID OR (:old.DOCUMENT_TYPE_ID IS NULL AND :new.DOCUMENT_TYPE_ID IS NOT NULL) OR (:old.DOCUMENT_TYPE_ID IS NOT NULL AND :new.DOCUMENT_TYPE_ID IS NULL)
             OR :old.DOCUMENT <> :new.DOCUMENT                 OR (:old.DOCUMENT IS NULL AND :new.DOCUMENT IS NOT NULL)                 OR (:old.DOCUMENT IS NOT NULL AND :new.DOCUMENT IS NULL)
             OR :old.TRUST_REGNUM <> :new.TRUST_REGNUM         OR (:old.TRUST_REGNUM IS NULL AND :new.TRUST_REGNUM IS NOT NULL)         OR (:old.TRUST_REGNUM IS NOT NULL AND :new.TRUST_REGNUM IS NULL)
             OR :old.TRUST_REGDAT <> :new.TRUST_REGDAT         OR (:old.TRUST_REGDAT IS NULL AND :new.TRUST_REGDAT IS NOT NULL)         OR (:old.TRUST_REGDAT IS NOT NULL AND :new.TRUST_REGDAT IS NULL)
             OR :old.BDATE <> :new.BDATE                       OR (:old.BDATE IS NULL AND :new.BDATE IS NOT NULL)                       OR (:old.BDATE IS NOT NULL AND :new.BDATE IS NULL)
             OR :old.EDATE <> :new.EDATE                       OR (:old.EDATE IS NULL AND :new.EDATE IS NOT NULL)                       OR (:old.EDATE IS NOT NULL AND :new.EDATE IS NULL)
             OR :old.NOTARY_NAME <> :new.NOTARY_NAME           OR (:old.NOTARY_NAME IS NULL AND :new.NOTARY_NAME IS NOT NULL)           OR (:old.NOTARY_NAME IS NOT NULL AND :new.NOTARY_NAME IS NULL)
             OR :old.NOTARY_REGION <> :new.NOTARY_REGION       OR (:old.NOTARY_REGION IS NULL AND :new.NOTARY_REGION IS NOT NULL)       OR (:old.NOTARY_REGION IS NOT NULL AND :new.NOTARY_REGION IS NULL)
             OR :old.SIGN_PRIVS <> :new.SIGN_PRIVS             OR (:old.SIGN_PRIVS IS NULL AND :new.SIGN_PRIVS IS NOT NULL)             OR (:old.SIGN_PRIVS IS NOT NULL AND :new.SIGN_PRIVS IS NULL)
             OR :old.SIGN_ID <> :new.SIGN_ID                   OR (:old.SIGN_ID IS NULL AND :new.SIGN_ID IS NOT NULL)                   OR (:old.SIGN_ID IS NOT NULL AND :new.SIGN_ID IS NULL)
             OR :old.NAME_R <> :new.NAME_R                     OR (:old.NAME_R IS NULL AND :new.NAME_R IS NOT NULL)                     OR (:old.NAME_R IS NOT NULL AND :new.NAME_R IS NULL)
             OR :old.POSITION_R <> :new.POSITION_R             OR (:old.POSITION_R IS NULL AND :new.POSITION_R IS NOT NULL)             OR (:old.POSITION_R IS NOT NULL AND :new.POSITION_R IS NULL)
   )
   then -- При зміні значеннь полів, що НЕ входять в PRIMARY KEY
          l_rec.CHGACTION := 2; --'U';
          SAVE_CHANGES;
        else
          Null;
      end case;
    else
      null;
  end case;
end TAIUD_CUSTOMERREL;
/
ALTER TRIGGER BARS.TAIUD_CUSTOMERREL ENABLE;
