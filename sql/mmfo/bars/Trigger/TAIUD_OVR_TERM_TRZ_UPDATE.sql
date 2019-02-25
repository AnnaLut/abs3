CREATE OR REPLACE TRIGGER TAIUD_OVR_TERM_TRZ_UPDATE
after insert or update or delete ON BARS.OVR_TERM_TRZ for each row
declare
  l_rec  OVR_TERM_TRZ_UPDATE%rowtype;
begin

  if deleting
  then

    l_rec.CHGACTION     := 'D';

    l_rec.acc            := :old.acc  ;
    l_rec.datvz          := :old.datvz  ;
    l_rec.datsp          := :old.datsp  ;
    l_rec.trz            := :old.trz  ;
    l_rec.acc1           := :old.acc1  ;
  else

    if updating
    then
      l_rec.CHGACTION := 'U';
      -- зберігаєм всі оновлення без перевірки чи щось змінилося
    else
      l_rec.CHGACTION := 'I';
    end if;
    l_rec.acc            := :new.acc  ;
    l_rec.datvz          := :new.datvz  ;
    l_rec.datsp          := :new.datsp  ;
    l_rec.trz            := :new.trz  ;
    l_rec.acc1           := :new.acc1  ;


  end if;

  If (l_rec.CHGACTION Is Not Null)
  then
    l_rec.IDUPD      := bars_sqnc.get_nextval('S_OVR_TERM_TRZ_UPDATE');
    l_rec.EFFECTDATE := glb_bankdate;
    l_rec.CHGDATE    := sysdate;
    l_rec.DONEBY     := gl.aUID;
    l_rec.kf         := sys_context('bars_context','user_mfo');

    insert into BARS.OVR_TERM_TRZ_UPDATE
    values l_rec;


  End If;


end TAIUD_OVR_TERM_TRZ_UPDATE;
/
