

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_PERSVALIDDOCUMENT_UPDATE.sql =
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_PERSVALIDDOCUMENT_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_PERSVALIDDOCUMENT_UPDATE 
  after insert or update of DOC_STATE on PERSON_VALID_DOCUMENT
  for each row
declare
  l_rec person_valid_document_update%rowtype;
begin

  if (:new.doc_state != :old.doc_state or
     (:new.doc_state is null and :old.doc_state is not null) or
     (:new.doc_state is not null and :old.doc_state is null))
  then

    l_rec.RNK       := :new.RNK;
    l_rec.DOC_STATE := :new.DOC_STATE;
    l_rec.USERID    := gl.aUID;
    l_rec.chgdate   := sysdate;

    insert into BARS.PERSON_VALID_DOCUMENT_UPDATE
    values l_rec;

  End If;

end;
/
ALTER TRIGGER BARS.TAIUD_PERSVALIDDOCUMENT_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_PERSVALIDDOCUMENT_UPDATE.sql =
PROMPT ===================================================================================== 
