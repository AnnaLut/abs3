begin
    /*��� ����������-��������� ������ PDF ��� ���� */        
    BAU.ADD_NEW_ATTRIBUTE('OWENABLEEA', '���� PDF ��� ���� (1-PDF, 0-DOC)');    
    /*�������� ������*/
    BAU.SET_ATTRIBUTE_VALUE('/','OWENABLEEA',1);  
end;
/
commit; 