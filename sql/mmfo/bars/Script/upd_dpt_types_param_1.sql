begin
UPDATE DPT_TYPES_PARAM
   SET DESCRIPTION_EN =
          'The period is 3,6,9,12,18 months. The minimum deposit amount is 1000 UAH, 100 USD, Euro. Interest payment - monthly or interest capitalization. Automatic renewal',
       DESCRIPTION_RU =
          '���� - 3,6,9,12,18 �������. ����������� ����� �������� - 1000 ���, 100 ����.���, ����. ������� ��������� - ���������� ��� ������������� ���������. ���������������',
       TOPUPAMOUNT_EN =
           'with replenishment from 200 UAH, 10 USD, Euro',
       TOPUPAMOUNT_RU =
          '� ����������� �� 200 ���, 10 ����.���, ����',
       EARLYCLOSE_EN = 
          'without the possibility of early withdrawal',
       EARLYCLOSE_RU =
          '��� ����������� ���������� �������',
       WITHDRAWAL_EN =
          'without the possibility of partial removal',
       WITHDRAWAL_RU =
          '��� ����������� ���������� ������'
  WHERE type_id = 47;
 update DPT_TYPES_PARAM  
   set DESCRIPTION_EN = 
          'Opening of the deposit if the depositor has a pension certificate. The period is 3,6,9,12,18 months. The minimum deposit amount is 1000 UAH, 100 USD, Euro. Interest payment - monthly or interest capitalization. Automatic renewal',
       DESCRIPTION_RU = 
          '�������� �������� ��� ������� � ��������� ����������� �������������. ���� - 3,6,9,12,18 �������. ����������� ����� �������� - 1000 ���, 100 ����. ���, ����. ������� ��������� - ���������� ��� ������������� ���������. ���������������',
       TOPUPAMOUNT_EN =
          'with replenishment from 200 UAH, 10 USD, Euro',
       TOPUPAMOUNT_RU = 
          '� ����������� �� 200 ���, 10 ����.���, ����',
       EARLYCLOSE_EN = 
          'without the possibility of early withdrawal',
       EARLYCLOSE_RU =
          '��� ����������� ���������� �������',
       WITHDRAWAL_EN = 
          'without the possibility of partial removal',
       WITHDRAWAL_RU = 
          '��� ����������� ���������� ������'
  where type_id=48;
 update DPT_TYPES_PARAM 
   set DESCRIPTION_EN = 
          'The term - 3,6,9,12,18 months. The minimum deposit amount is -1 000 000 UAH, 40 000 USD, Euro. Interest payment - monthly or interest capitalization. Automatic renewal',
       DESCRIPTION_RU = 
          '���� - 3,6,9,12,18 �������. ����������� ����� �������� -1 000 000 ���, 40 000 ����.���, ����. ������� ��������� - ���������� ��� ������������� ���������. ���������������',
       TOPUPAMOUNT_EN = 
          'with replenishment from 1000 UAH, 100 USD, Euro',
       TOPUPAMOUNT_RU = 
          '� ����������� �� 1000 ���, 100 ����.���, ����',
       EARLYCLOSE_EN = 
          'without the possibility of early withdrawal',
       EARLYCLOSE_RU = 
          '��� ����������� ���������� �������',
       WITHDRAWAL_EN = 
          'without the possibility of partial removal',
       WITHDRAWAL_RU = 
          '��� ����������� ���������� ������'
   where type_id=49;
end;
/
commit; 