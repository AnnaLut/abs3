begin
   begin 
       Insert into BARS.NBUR_REF_ACC_TYPES
           (ACC_TYPE, DESCRIPTION)
         Values
           ('DP', '������� �� ��������� (��� �������)');
    exception 
        when dup_val_on_index then null; 
    end;
    
    begin 
        Insert into BARS.NBUR_REF_ACC_TYPES
           (ACC_TYPE, DESCRIPTION)
         Values
           ('DPN', '������� ����������� ������� �� ���������');
    exception 
        when dup_val_on_index then null; 
    end;
    
    begin 
        Insert into BARS.NBUR_REF_ACC_TYPES
           (ACC_TYPE, DESCRIPTION)
         Values
           ('RZD', '������� ������� �� ��������');
    exception 
        when dup_val_on_index then null; 
    end;
    
    begin 
        Insert into BARS.NBUR_REF_ACC_TYPES
           (ACC_TYPE, DESCRIPTION)
         Values
           ('RZM', '������� ������� �� �������');
    exception 
        when dup_val_on_index then null; 
    end;
    
    begin 
        Insert into BARS.NBUR_REF_ACC_TYPES
           (ACC_TYPE, DESCRIPTION)
         Values
           ('RZO', '������� ������� �� ������ �������������');
    exception 
        when dup_val_on_index then null; 
    end;
    
    begin 
        Insert into BARS.NBUR_REF_ACC_TYPES
           (ACC_TYPE, DESCRIPTION)
         Values
           ('RZS', '������� ������� �� �������� �� �� ��');
    exception 
        when dup_val_on_index then null; 
    end;
    
    begin 
        Insert into BARS.NBUR_REF_ACC_TYPES
           (ACC_TYPE, DESCRIPTION)
         Values
           ('RZC', '������� ������� �� ��');
    exception 
        when dup_val_on_index then null; 
    end;
    
    begin 
        Insert into BARS.NBUR_REF_ACC_TYPES
           (ACC_TYPE, DESCRIPTION)
         Values
           ('SS', '������� ���������/������������� ����� �� ��������');
    exception 
        when dup_val_on_index then null; 
    end;
    
    begin 
        Insert into BARS.NBUR_REF_ACC_TYPES
           (ACC_TYPE, DESCRIPTION)
         Values
           ('SSD', '������� ��������/���쳿 �� ��������');
    exception 
        when dup_val_on_index then null; 
    end;
    
    begin 
        Insert into BARS.NBUR_REF_ACC_TYPES
           (ACC_TYPE, DESCRIPTION)
         Values
           ('SSN', '������� ����������� �� ������������ ������� �� �������� ');
    exception 
        when dup_val_on_index then null; 
    end;

END;
/       
COMMIT;
