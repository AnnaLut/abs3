
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/patch_data_SPS_SPR.sql =========*** Run
PROMPT ===================================================================================== 

Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (0,'0','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (1,'C ��������� �������� �/� �� NBS','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (2,'2','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (3,'3','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (5,'5 �����','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (6,'���� + �����','����� �������� = ����� �� ����� ����� �������� ���� PEREKR_B.Formula');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (7,'����� (������ 1 ���. ���.)','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (8,'����','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (10,'����� (������������ 10 ���.)','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (29,'���������� �� ��������� ������� (�������� ��)','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (39,'��������. ���������� � ������ ������������ ������� ��� �������� �� ��','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (40,'40 ���������','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (86,'���������� �� ��������� ������� (�������� ��)','��� 8600');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (101,'������ ����� 55-�� ������','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (112,'���������� ������ ��������� ��������','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (139,'��������. ���������� � ������ ������������ ������� ��� �������� �� �� �� ����������� ������ �����','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (260,'���������� ������ 3570 �� ELT','PET, UPB, STL');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (763,'���������� �� ���������� �������','�������� � � ��������� ���� ���. � ��������� ��������� ���� � ���� �������. ������������ � ��������.');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (2900,'AGI','����� ����� ��� � ������������� �����');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (3570,'��������','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO SPS_SPR(SPS,SPS_NAME,DESCRIPTION) VALUES (3579,'��� ���������� ������ 3579','PET,UPB,STL');
    exception when dup_val_on_index then null;
end;
/
COMMIT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/patch_data_SPS_SPR.sql =========*** End
PROMPT ===================================================================================== 
