begin
Insert into BARS.OP_FIELD
   (TAG, NAME, USE_IN_ARCH)
 Values
   ('SHTAR', '��� ��������� ������', 1);
exception when dup_val_on_index then
      null;
    end;
/

begin

update bars.op_field set browser=
  'TagBrowse("SELECT id as code, name as txt FROM p_l_2c where id in (''3'',''5'',''6'',''7'',''8'',''9'',''A'',''B'')")'
  where TAG='KOD2C';
end;
/

COMMIT;


