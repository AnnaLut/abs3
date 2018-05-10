begin
Insert into BARS.OP_FIELD
   (TAG, NAME, USE_IN_ARCH)
 Values
   ('SHTAR', 'Код тарифного пакета', 1);
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

begin
update bars.op_field set browser=
  'TagBrowse("SELECT id, fio, atrt, pasp||'' ''||paspn pasp FROM bars.podotch")'
  where TAG='INK_I';
end;
/            

begin
update bars.op_field set browser=
  'TagBrowse(''SELECT issued, fio from PODOTCH'')'
  where TAG='PASP1';
end;
/            

begin Insert into OP_FIELD (TAG,NAME,BROWSER,USE_IN_ARCH) Values ('F092', 'Показник F092 для Звітності НБУ', 'TagBrowse("SELECT F092 kod, TXT naim FROM KOD_F092")', 1);
exception when others then   if SQLCODE = - 00001 then null;   else raise; end if; --ORA-00001: unique constraint
end;
/

begin Insert into OP_FIELD (TAG,NAME,BROWSER,USE_IN_ARCH) Values ('FOREX', 'Вид("довжина") ФОРЕКС-Угоди', '', 1);
exception when others then   if SQLCODE = - 00001 then null;   else raise; end if; --ORA-00001: unique constraint
end;
/

begin
Insert into BARS.OP_FIELD
   (TAG, NAME, USE_IN_ARCH, BROWSER)
 Values
   ('CP_VO', 'Вид операції', 1, 'TagBrowse("SELECT code,txt FROM cp_voper")');
exception when dup_val_on_index then
      null;
    end;
/

begin
Insert into BARS.OP_FIELD
   (TAG, NAME, USE_IN_ARCH, BROWSER)
 Values
   ('CP_VD', 'Вид договору', 1, 'TagBrowse("SELECT code,txt FROM cp_vdogo")');
exception when dup_val_on_index then
      null;
    end;
/


COMMIT;


