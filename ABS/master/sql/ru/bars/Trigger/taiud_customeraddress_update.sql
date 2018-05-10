CREATE OR REPLACE TRIGGER TAIUD_CUSTOMERADDRESS_UPDATE
after insert or update or delete
of RNK, TYPE_ID, COUNTRY, ZIP, DOMAIN, REGION, LOCALITY, ADDRESS,
   STREET, HOME_TYPE, HOME, HOMEPART_TYPE, HOMEPART, ROOM_TYPE, ROOM,
   AREA_ID, SETTLEMENT_ID, STREET_ID, HOUSE_ID
on BARS.CUSTOMER_ADDRESS
for each row
declare
  l_rec  CUSTOMER_ADDRESS_UPDATE%rowtype;
begin

  if deleting
  then

    l_rec.CHGACTION     := 'D';

    l_rec.RNK           := :old.RNK;
    l_rec.TYPE_ID       := :old.TYPE_ID;
    l_rec.COUNTRY       := :old.COUNTRY;
    l_rec.ZIP           := :old.ZIP;
    l_rec.DOMAIN        := :old.DOMAIN;
    l_rec.REGION        := :old.REGION;
    l_rec.LOCALITY      := :old.LOCALITY;
    l_rec.ADDRESS       := :old.ADDRESS;
    l_rec.STREET        := :old.STREET;
    l_rec.HOME_TYPE     := :old.HOME_TYPE;
    l_rec.HOME          := :old.HOME;
    l_rec.HOMEPART_TYPE := :old.HOMEPART_TYPE;
    l_rec.HOMEPART      := :old.HOMEPART;
    l_rec.ROOM_TYPE     := :old.ROOM_TYPE;
    l_rec.ROOM          := :old.ROOM;
    l_rec.REGION_ID     := :old.REGION_ID;
    l_rec.AREA_ID       := :old.AREA_ID;
    l_rec.SETTLEMENT_ID := :old.SETTLEMENT_ID;
    l_rec.STREET_ID     := :old.STREET_ID;
    l_rec.HOUSE_ID      := :old.HOUSE_ID;
    l_rec.locality_type_n      := :old.locality_type_n ;
    l_rec.street_type_n        := :old.street_type_n;

  else

    if updating
    then
      l_rec.CHGACTION := 'U';
      -- зберігаєм всі оновлення без перевірки чи щось змінилося
    else
      l_rec.CHGACTION := 'I';
    end if;

    l_rec.RNK           := :new.RNK;
    l_rec.TYPE_ID       := :new.TYPE_ID;
    l_rec.COUNTRY       := :new.COUNTRY;
    l_rec.ZIP           := :new.ZIP;
    l_rec.DOMAIN        := :new.DOMAIN;
    l_rec.REGION        := :new.REGION;
    l_rec.LOCALITY      := :new.LOCALITY;
    l_rec.ADDRESS       := :new.ADDRESS;
    l_rec.STREET        := :new.STREET;
    l_rec.HOME_TYPE     := :new.HOME_TYPE;
    l_rec.HOME          := :new.HOME;
    l_rec.HOMEPART_TYPE := :new.HOMEPART_TYPE;
    l_rec.HOMEPART      := :new.HOMEPART;
    l_rec.ROOM_TYPE     := :new.ROOM_TYPE;
    l_rec.ROOM          := :new.ROOM;
    l_rec.REGION_ID     := :new.REGION_ID;
    l_rec.AREA_ID       := :new.AREA_ID;
    l_rec.SETTLEMENT_ID := :new.SETTLEMENT_ID;
    l_rec.STREET_ID     := :new.STREET_ID;
    l_rec.HOUSE_ID      := :new.HOUSE_ID;
    l_rec.locality_type_n     := :new.locality_type_n;
    l_rec.street_type_n       := :new.street_type_n;


  end if;


  If (l_rec.CHGACTION Is Not Null)
  then

    l_rec.IDUPD      := S_CUSTOMER_ADDRESS_UPDATE.NextVal;
    l_rec.EFFECTDATE := glb_bankdate;
    l_rec.CHGDATE    := sysdate;
    l_rec.DONEBY     := gl.aUID;

    insert into BARS.CUSTOMER_ADDRESS_UPDATE
    values l_rec;


  End If;


end TAIUD_CUSTOMERADDRESS_UPDATE;
/