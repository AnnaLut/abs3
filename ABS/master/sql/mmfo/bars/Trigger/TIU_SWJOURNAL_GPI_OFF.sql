CREATE OR REPLACE TRIGGER "TIU_SWJOURNAL_GPI_OFF"
before insert or update ON BARS.SW_JOURNAL
for each row
WHEN (new.imported !='Y')
begin
  :new.sti:=null;
  :new.uetr:=null;
end;
/ 
