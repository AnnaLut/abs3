CREATE OR REPLACE TRIGGER BARS.TIU_SWJOURNAL_GPI_OFF
   BEFORE INSERT OR UPDATE
   ON BARS.SW_JOURNAL
   FOR EACH ROW
WHEN (
new.imported != 'Y' AND new.mt not  in ( '103','199','192','196','299','202')
      )
BEGIN
   :new.sti := NULL;

   :new.uetr := NULL;
END;
/