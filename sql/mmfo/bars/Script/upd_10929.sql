
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/scripts/upd_10929.sql COBUMMFO-10929 =========*** Run ***
 PROMPT  Добавляємо значення 8, Поставка товару в BARS.CIM_PAYMENT_TYPES

begin
Insert into BARS.CIM_PAYMENT_TYPES
   (TYPE_ID, TYPE_NAME)
 Values
   (8, 'Поставка товару');
   exception when dup_val_on_index then null;   
COMMIT;
end;
/


PROMPT *** Наводимо порядок *** ==========

PROMPT  Міняємо значення id=1  для 37508506 в довіднику CIM_CONCLUSION_ORG


begin
   update BARS.CIM_CONCLUSION_ORG set id=1 where id=37508506;
   commit;
end;
/

PROMPT  Добавляємо значення  2, Судовий орган в CIM_CONCLUSION_ORG

begin
Insert into BARS.CIM_CONCLUSION_ORG
   (ID, NAME)
 Values
   (2, 'Судовий орган');
   exception when dup_val_on_index then null;   
COMMIT;
end;
/

PROMPT  змінюємо значення в CIM_CONCLUSION на org_id=1

begin
  update  CIM_CONCLUSION set org_id=1 where org_id=37508506;
  commit;
end;
/

PROMPT  добавляємо в BARS.CIM_CONCLUSION FK_CIM_CONCLUSION_ORG  BARS.CIM_CONCLUSION_ORG (ID)
 
begin 
  execute immediate 
    ' ALTER TABLE BARS.CIM_CONCLUSION'||
    '  ADD CONSTRAINT FK_CIM_CONCLUSION_ORG '||
    '   FOREIGN KEY (ORG_ID) '||
    '   REFERENCES BARS.CIM_CONCLUSION_ORG (ID)'||
    '   ENABLE VALIDATE';
exception when others then 
  if sqlcode=-2275 then null; else raise; end if;
end;
/