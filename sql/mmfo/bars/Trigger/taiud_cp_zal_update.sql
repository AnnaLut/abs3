CREATE OR REPLACE TRIGGER TAIUD_CP_ZAL_UPDATE
after insert or update or delete
on BARS.CP_ZAL
for each row
declare
  l_rec  CP_ZAL_UPDATE%rowtype;
begin

  if deleting
  then

    l_rec.CHGACTION     := 'D';

    l_rec.REF           := :old.REF;
    l_rec.ID            := :old.ID;
    l_rec.KOLZ          := :old.KOLZ;
    l_rec.DATZ_FROM     := :old.DATZ_FROM;
    l_rec.DATZ_TO       := :old.DATZ_TO;
    l_rec.ID_CP_ZAL     := :old.ID_CP_ZAL;
    l_rec.RNK           := :old.RNK;
    
  else

    if updating
    then
      l_rec.CHGACTION := 'U';
      -- зберігаєм всі оновлення без перевірки чи щось змінилося
    else
      l_rec.CHGACTION := 'I';
    end if;

    l_rec.REF           := :new.REF;
    l_rec.ID            := :new.ID;
    l_rec.KOLZ          := :new.KOLZ;
    l_rec.DATZ_FROM     := :new.DATZ_FROM;
    l_rec.DATZ_TO       := :new.DATZ_TO;
    l_rec.ID_CP_ZAL     := :new.ID_CP_ZAL;
    l_rec.RNK           := :new.RNK;

  end if;


  l_rec.IDUPD      := bars_sqnc.get_nextval('S_CP_ZAL_UPDATE');
  l_rec.EFFECTDATE := gl.bd;
  l_rec.CHGDATE    := sysdate;
  l_rec.DONEBY     := gl.aUID;

  insert into BARS.CP_ZAL_UPDATE
  values l_rec;

end TAIUD_CP_ZAL_UPDATE;
/