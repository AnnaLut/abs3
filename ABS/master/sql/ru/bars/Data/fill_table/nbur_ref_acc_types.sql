begin
   begin 
       Insert into BARS.NBUR_REF_ACC_TYPES
           (ACC_TYPE, DESCRIPTION)
         Values
           ('DP', 'Рахунки по депозитах (без відсотків)');
    exception 
        when dup_val_on_index then null; 
    end;
    
    begin 
        Insert into BARS.NBUR_REF_ACC_TYPES
           (ACC_TYPE, DESCRIPTION)
         Values
           ('DPN', 'Рахунки нарахованих відсотків по депозитах');
    exception 
        when dup_val_on_index then null; 
    end;
    
    begin 
        Insert into BARS.NBUR_REF_ACC_TYPES
           (ACC_TYPE, DESCRIPTION)
         Values
           ('RZD', 'Рахунки резерву по дебіторці');
    exception 
        when dup_val_on_index then null; 
    end;
    
    begin 
        Insert into BARS.NBUR_REF_ACC_TYPES
           (ACC_TYPE, DESCRIPTION)
         Values
           ('RZM', 'Рахунки резерву по міжбанку');
    exception 
        when dup_val_on_index then null; 
    end;
    
    begin 
        Insert into BARS.NBUR_REF_ACC_TYPES
           (ACC_TYPE, DESCRIPTION)
         Values
           ('RZO', 'Рахунки резерву за іншими зобовязаннями');
    exception 
        when dup_val_on_index then null; 
    end;
    
    begin 
        Insert into BARS.NBUR_REF_ACC_TYPES
           (ACC_TYPE, DESCRIPTION)
         Values
           ('RZS', 'Рахунки резерву по кредитах ЮО та ФО');
    exception 
        when dup_val_on_index then null; 
    end;
    
    begin 
        Insert into BARS.NBUR_REF_ACC_TYPES
           (ACC_TYPE, DESCRIPTION)
         Values
           ('RZC', 'Рахунки резерву по ЦП');
    exception 
        when dup_val_on_index then null; 
    end;
    
    begin 
        Insert into BARS.NBUR_REF_ACC_TYPES
           (ACC_TYPE, DESCRIPTION)
         Values
           ('SS', 'Рахунки основного/простроченого боргу по кредитах');
    exception 
        when dup_val_on_index then null; 
    end;
    
    begin 
        Insert into BARS.NBUR_REF_ACC_TYPES
           (ACC_TYPE, DESCRIPTION)
         Values
           ('SSD', 'Рахунки дисконту/премії по кредитах');
    exception 
        when dup_val_on_index then null; 
    end;
    
    begin 
        Insert into BARS.NBUR_REF_ACC_TYPES
           (ACC_TYPE, DESCRIPTION)
         Values
           ('SSN', 'Рахунки нарахованих та прострочених відсотків по кредитах ');
    exception 
        when dup_val_on_index then null; 
    end;

END;
/       
COMMIT;
