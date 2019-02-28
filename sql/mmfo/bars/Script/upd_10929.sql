
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/scripts/upd_10929.sql COBUMMFO-10929 =========*** Run ***
 PROMPT  ���������� �������� 8, �������� ������ � BARS.CIM_PAYMENT_TYPES

begin
Insert into BARS.CIM_PAYMENT_TYPES
   (TYPE_ID, TYPE_NAME)
 Values
   (8, '�������� ������');
   exception when dup_val_on_index then null;   
COMMIT;
end;
/


PROMPT *** �������� ������� *** ==========

PROMPT  ̳����� �������� id=1  ��� 37508506 � �������� CIM_CONCLUSION_ORG


begin
   update BARS.CIM_CONCLUSION_ORG set id=1 where id=37508506;
   commit;
end;
/

PROMPT  ���������� ��������  2, ������� ����� � CIM_CONCLUSION_ORG

begin
Insert into BARS.CIM_CONCLUSION_ORG
   (ID, NAME)
 Values
   (2, '������� �����');
   exception when dup_val_on_index then null;   
COMMIT;
end;
/

PROMPT  ������� �������� � CIM_CONCLUSION �� org_id=1

begin
  update  CIM_CONCLUSION set org_id=1 where org_id=37508506;
  commit;
end;
/

PROMPT  ���������� � BARS.CIM_CONCLUSION FK_CIM_CONCLUSION_ORG  BARS.CIM_CONCLUSION_ORG (ID)
 
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