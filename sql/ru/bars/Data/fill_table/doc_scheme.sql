exec bc.home;
begin 
 insert into doc_scheme (ID, NAME, PRINT_ON_BLANK, TEMPLATE, HEADER, FOOTER, HEADER_EX, D_CLOSE, FR, FILE_NAME)
 values ('WB_CREATE_DEPOSIT', '������ ��� ²������� �������� ����� ���� 24/7', 0, null, null,null, null, null, 1, 'WB_CREATE_DEPOSIT.frx');
exception when dup_val_on_index then 
  update doc_scheme set NAME='������ ��� ²������� �������� ����� ���� 24/7', FILE_NAME='WB_CREATE_DEPOSIT.frx' where id ='WB_CREATE_DEPOSIT';
end; 
/

begin 
 insert into doc_scheme (ID, NAME, PRINT_ON_BLANK, TEMPLATE, HEADER, FOOTER, HEADER_EX, D_CLOSE, FR, FILE_NAME)
 values ('WB_DENY_AUTOLONGATION', '������ ��� ²����� ²� ����������ί ����������ֲ� �������� ����� ���� 24/7', 0, null, null,null, null, null, 1, 'WB_DENY_AUTOLONGATION.frx');
exception when dup_val_on_index then 
 update doc_scheme set NAME='������ ��� ²����� ²� ����������ί ����������ֲ� �������� ����� ���� 24/7', FILE_NAME='WB_DENY_AUTOLONGATION.frx' where id ='WB_DENY_AUTOLONGATION';
end; 
/

begin 
 insert into doc_scheme (ID, NAME, PRINT_ON_BLANK, TEMPLATE, HEADER, FOOTER, HEADER_EX, D_CLOSE, FR, FILE_NAME)
 values ('WB_CHANGE_ACCOUNT', '������ ��� �̲�� ������� ������� Ҳ�� �� ²����ʲ� �� �������� ����� ���� 24/7', 0, null, null,null, null, null, 1, 'WB_CHANGE_ACCOUNT.frx');
exception when dup_val_on_index then 
    update doc_scheme set NAME='������ ��� �̲�� ������� ������� Ҳ�� �� ²����ʲ� �� �������� ����� ���� 24/7', FILE_NAME='WB_CHANGE_ACCOUNT.frx' where id ='WB_CHANGE_ACCOUNT';
end; 
/
commit;
/

