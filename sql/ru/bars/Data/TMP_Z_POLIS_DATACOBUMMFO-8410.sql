prompt ... 


-- Create table
begin
    execute immediate 'create table TMP_Z_POLIS
(
  a1 VARCHAR2(20),
  a2 VARCHAR2(500),
  a3 VARCHAR2(20),
  a4 VARCHAR2(20),
  a5 VARCHAR2(20),
  a6 VARCHAR2(20),
  a7 VARCHAR2(20),
  a8 VARCHAR2(20)
)
tablespace BRSDYND
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 




prompt ... 

SET DEFINE OFF;

begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''11'', ''11.�������� �� ���������� ������/���������� ������� ����������, �� ��������� ������� ��������� ������ ������� ̳����� ������'', ''9030'', ''9030'', ''9030'', 
    ''11'', ''1'', ''ͳ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''15'', ''36.������� ��������, �� �������� � �����-�������� �� �����, �� ������, �� ����� ������������ �������, �� ����� ������������ ������������ �������� �� ������� �����-��������� �� ��� ����� � ��� ����������� ��������� ���������� �� ��������� ������'', ''9500'', ''9500'', ''9500'', 
    ''36'', ''1'', ''ͳ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''21'', ''21.�������� ������, �� ����������� �� �������� � �����-��������, �� ������ ����� �� �������� ������, �� ������� �� ��������� (�����������) ������� � �����-�������� �� �����, �� ������, �� ����� ������������ �������, �� ����� ������������'', ''9500'', ''9500'', ''9500'', 
    ''21'', ''1'', ''ͳ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''23'', ''23.ֳ�� ������, ������� ������������ �������� ��������� ����� ������ ��� ���������� �������� ̳����� ������'', ''9500'', ''9500'', ''9500'', 
    ''23'', ''1'', ''ͳ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''25'', ''25.�������� �����, �� �������� �� ��������� ����� (��������)'', ''9521'', ''9521'', ''9521'', 
    ''25'', ''0.75'', ''���'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''26'', ''72.������ ����� �� �������� �����, �� ���������� �� ��������� ����� (���������������� �������)'', ''9521'', ''9521'', ''9521'', 
    ''72'', ''0'', ''���'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''28'', ''28.������ � ������ ��� � ���������'', ''9500'', ''9500'', ''9500'', 
    ''28'', ''0.4'', ''���'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''30'', ''30.I��� ������ �����'', ''9500'', ''9500'', ''9500'', 
    ''30'', ''0'', ''���'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''31'', ''31.���� �������� �����'', ''9523'', ''9523'', ''9523'', 
    ''31'', ''0'', ''���'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''33'', ''331.ֳ�� ������ ���i'', ''9500'', ''9500'', ''9500'', 
    ''33'', ''0'', ''ͳ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''34'', ''334.������'', ''9031'', ''9031'', ''9031'', 
    ''33'', ''0'', ''ͳ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''38'', ''38.���������� ������ (��� �������� ���������)'', ''9500'', ''9500'', ''9500'', 
    ''38'', ''0.5'', ''���'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''39'', ''39.�������� ���������� ���������� ����������, �� �� ������, ���������� ���� ���������� �����, ��/��� �������� �� ����������� �������� ������ ��������� ���� �������� �� ������� ������'', ''9500'', ''9500'', ''9500'', 
    ''39'', ''1'', ''ͳ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''50'', ''50.�ᒺ�� � ���� �������� ��������� ���������'', ''9523'', ''9523'', ''9523'', 
    ''50'', ''0.5'', ''���'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''56'', ''333.����. ����� �� �������� ����� ������.�����'', ''9523'', ''9523'', ''9523'', 
    ''33'', ''0'', ''���'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''58'', ''58.������� ��������, ������� ���������� ���������, ����� �� 50 ������� ������������� ���� ��� �������� ������ ��/��� ��������� ������, ����� ���������� �������� �� ����� ������� ������� ������������� ������'', ''9500'', ''9500'', ''9500'', 
    ''58'', ''0.6'', ''ͳ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''61'', ''61.�������� �� ���������� ������/���������� ������� ����������, �� ��������� ������� ��������� ������ ����� ����, �� ����� ������������� ��������� ������� ����� � ���������� ������, ������������ ���������� (�������) Standard&Poor�s '', ''9031'', ''9031'', ''9031'', 
    ''61'', ''1'', ''ͳ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''62'', ''62.�������� �� ���������� ������/���������� ������� ����������, �� ��������� ������� ��������� ������ ����� �� ����� �������, �� ����� ������������� ��������� ������� ����� � ���������� ������, ������������ ���������� (�������) Stand'', ''9031'', ''9031'', ''9031'', 
    ''62'', ''1'', ''ͳ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''63'', ''63.�������� �� ���������� ������/���������� ������� ����������, �� ��������� ������� ��������� ������ ���������� �������������� ����� (����, ����, ���, ���, ���)'', ''9031'', ''9031'', ''9031'', 
    ''63'', ''1'', ''ͳ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''90'', ''90.��� ������������ (�������)'', ''9500'', ''9500'', ''9500'', 
    ''90'', ''0'', ''ͳ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''156'', ''18.������ ����� �� ������ �����, ������� �� ��������� (�����������) ������� � �����, ���� �� ������������� ��������� �������, �� �����, �� ����� ��������� ����� �� ������, �� ����� ������������ �������'', ''9500'', ''9500'', ''9500'', 
    ''18'', ''1'', ''ͳ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''231'', ''57.������� ���� ������ �� ���������� ����, �� ����������� �� �������������� ������� �� ������ �� ���� ������������ ��� ������ ��������� ������ ������ �� ���������� �����"������� ����������� �������� ������� ���� ������ �� ����������� � �����'', ''9500'', ''9500'', ''9500'', 
    ''57'', ''1'', ''ͳ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''233'', ''19.ֳ�� ������, ������� ������������ ������ ������'', ''9500'', ''9500'', ''9500'', 
    ''19'', ''1'', ''ͳ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''235'', ''53.ֳ�� ������, ������� �������� �������� ��������������'', ''9500'', ''9500'', ''9500'', 
    ''53'', ''0.4'', ''ͳ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''244'', ''24.ֳ�� ������ �������, �� ����� ������������� ��������� ������� ����� � ���������� ������, ������������ ���������� (�������) Standard&Poor�s ��� ���������� ������� ����� �������� ������� ����������� �������� (�������), ���������� ������'', ''9500'', ''9500'', ''9500'', 
    ''24'', ''1'', ''ͳ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''245'', ''67 � ���� ������ (��� ������ ������ ��������� �������� ������������), ������� �����������, �� ������ �� ������� ���� ������� �� ����������� � ����� �� ����� ����� ������ ������ �� ���� ���������� ������ ���������� ������ �� �������'', ''9500'', ''9500'', ''9500'', 
    ''67'', ''0.4'', ''ͳ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''250'', ''71.�������� �����, �� �������� �� ��������� ����� (�������)'', ''9521'', ''9521'', ''9521'', 
    ''71'', ''0.55'', ''���'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''283'', ''66.������, ������� �� ��������� �� �������� ���������� ��������� (�������� ������ ��������� ������ �� ������ ������� ����� ��������)'', ''9503'', ''9503'', ''9503'', 
    ''66'', ''0.4'', ''���'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''301'', ''35.������ ��������'', ''9500'', ''9500'', ''9500'', 
    ''35'', ''0.75'', ''���'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''302'', ''513.������ / �������������'', ''9500'', ''9500'', ''9500'', 
    ''51'', ''0.5'', ''���'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''303'', ''55.�������� ������'', ''9500'', ''9500'', ''9500'', 
    ''55'', ''0.4'', ''���'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''304'', ''511.������������'', ''9500'', ''9500'', ''9500'', 
    ''51'', ''0.5'', ''���'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''305'', ''512.������ (��������� � ���������)'', ''9500'', ''9500'', ''9500'', 
    ''51'', ''0.5'', ''���'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''307'', ''335.�������� ������'', ''9500'', ''9500'', ''9500'', 
    ''33'', ''0'', ''���'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''309'', ''70.������� ������ [��� ��������� ������, �� ����� �� ������, ������ �� ���� ��������� ����������� (������������) ������� �� ������������� ���] ��� ��������� ��������, ���������� �� ������ ��������'', ''9520'', ''9520'', ''9520'', 
    ''70'', ''0.35'', ''���'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''310'', ''69.������� ������, �������� �� ������ ��������, �� ���� ����������� �������� �����, �� �������� �� ��������� ����� (�������), � ����� ���� ������������� ��������������� � ������������� �ᒺ���'', ''9520'', ''9520'', ''9520'', 
    ''69'', ''0.55'', ''���'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''311'', ''68.������� ������, �������� �� ������ ��������, �� ���� ����������� �������� �����, �� �� �������� �� ��������� �����, � ����� ���� ������������� ��������������� � ������������� �ᒺ���'', ''9520'', ''9520'', ''9520'', 
    ''68'', ''0.6'', ''���'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''312'', ''371. �������� �����, �� �� �������� �� ��������� ����� (��� ��������� ������ �� ���������� � ����� ���)'', ''9523'', ''9523'', ''9523'', 
    ''37'', ''0.6'', ''���'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''313'', ''372.���������� � ����� ���'', ''9523'', ''9523'', ''9523'', 
    ''37'', ''0.6'', ''���'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''321'', ''336.����.����� �� ������, ������ (�� ���.���)'', ''9500'', ''9500'', ''9500'', 
    ''33'', ''0'', ''���'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''322'', ''337.����.����� �� ��.����� �� ���.'', ''9500'', ''9500'', ''9500'', 
    ''33'', ''0'', ''ͳ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''323'', ''338.����.����� �� ����� �� ���.���.�������.�����.'', ''9500'', ''9500'', ''9500'', 
    ''33'', ''0'', ''ͳ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''339'', ''339.���� ���� ������������ (9500)'', ''9500'', ''9500'', ''9500'', 
    ''33'', ''0'', ''ͳ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''591'', ''591.����� ����� (���) ������, ������� ������-����������'', ''9500'', ''9500'', ''9500'', 
    ''59'', ''1'', ''ͳ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''592'', ''592.���� ����� �� ���� ���, ���� �� ��� (���) ��� � �����-��������'', ''9500'', ''9500'', ''9500'', 
    ''59'', ''1'', ''ͳ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''640'', ''64.�������� �� ���������� ����� ������ ������ ���, �� ����� ���� �� ����� �� 2'', ''9031'', ''9031'', ''9031'', 
    ''33'', ''0.5'', ''ͳ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''832'', ''������ ����� �� ������� ��������'', ''9510'', ''9510'', ''9510'', 
    ''73'', ''0'', ''ͳ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''919'', ''�������� ����������� ���'', ''9510'', ''9510'', ''9510'', 
    ''19'', ''0'', ''ͳ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''920'', ''�������� �������� �������� ��������'', ''9510'', ''9510'', ''9510'', 
    ''58'', ''0'', ''ͳ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''923'', ''������� �������� ������'', ''9510'', ''9510'', ''9510'', 
    ''23'', ''0'', ''ͳ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''932'', ''������ ����� �� ������� ����������� �� ����������������� �������'', ''9510'', ''9510'', ''9510'', 
    ''33'', ''0'', ''ͳ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''933'', ''���� ���� ������������ (9510)'', ''9510'', ''9510'', ''9510'', 
    ''33'', ''0'', ''ͳ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''952'', ''�������� ���������'', ''9510'', ''9510'', ''9510'', 
    ''33'', ''0'', ''ͳ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''3214'', ''332.����.����� �� ��������.�����'', ''9500'', ''9500'', ''9500'', 
    ''33'', ''0'', ''ͳ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.TMP_Z_POLIS
   (A1, A2, A3, A4, A5, 
    A6, A7, A8)
 Values
   (''999999'', ''��� ���'', ''9510'', ''9510'', ''9510'', 
    ''33'', ''0'', ''ͳ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

COMMIT;
/