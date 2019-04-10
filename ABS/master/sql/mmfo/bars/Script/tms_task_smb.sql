prompt == *** SMB_DEPOSIT_TRANSFER_FUNDS *** ===
declare 
    id_ number ;
begin 
    bc.go('/'); 

    id_ := TMS_UTL.create_or_replace_task (
             p_task_code               => 'SMB_DEPOSIT_TRANSFER_FUNDS' -- унікальний код процедури (довідник TMS_TASK)
            ,p_task_group_id           => 1  -- контекст банківської дати при виконанні процедури: 1 - фініш, 2 - старт, 3 - не встановлюється контекст дати
            ,p_sequence_number         => 301  -- порядковий номер виконання завдання (може дублюватися)
            ,p_task_name               => 'smb Переведення суми з рахунку для списання на депозитний. Депозити ММСБ'   -- назва завдання
            ,p_task_description        => null  -- додатковий текстовий опис завдання
            ,p_separate_by_branch_mode => 3  -- режим представлення РУ: 1 - виконувати процедуру на "/", 2 - кожна РУ обробляється по черзі, 3 - всі РУ обробляються паралельно
            ,p_action_on_failure       => 1  -- порядок дій у разі виникнення помилки: 1 - продовжити виконання процедур, 2 - зупинити виконання наступних процедур
            ,p_task_statement          =>
                                         'begin
                                              smb_calculation_deposit.transfer_funds_failed_deposit();
                                              commit;
                                          end ;' -- PL/SQL-блок, що виконується для даного завдання
       ) ;
 
    commit;
end;
/

prompt == *** SMB_DEPOSIT_PROLONGATION *** ===
declare 
    id_ number ;
begin 
    bc.go('/'); 

    id_ := TMS_UTL.create_or_replace_task (
             p_task_code               => 'SMB_DEPOSIT_PROLONGATION' -- унікальний код процедури (довідник TMS_TASK)
            ,p_task_group_id           => 1  -- контекст банківської дати при виконанні процедури: 1 - фініш, 2 - старт, 3 - не встановлюється контекст дати
            ,p_sequence_number         => 302  -- порядковий номер виконання завдання (може дублюватися)
            ,p_task_name               => 'smb Автопролонгація депозитних траншів. Депозити ММСБ'   -- назва завдання
            ,p_task_description        => null  -- додатковий текстовий опис завдання
            ,p_separate_by_branch_mode => 1  -- режим представлення РУ: 1 - виконувати процедуру на "/", 2 - кожна РУ обробляється по черзі, 3 - всі РУ обробляються паралельно
            ,p_action_on_failure       => 1  -- порядок дій у разі виникнення помилки: 1 - продовжити виконання процедур, 2 - зупинити виконання наступних процедур
            ,p_task_statement          =>
                                         'begin
                                              smb_calculation_deposit.auto_deposit_prolongation(p_date => null);
                                              commit;
                                          end ;' -- PL/SQL-блок, що виконується для даного завдання
       ) ;
 
    commit;
end;
/

prompt == *** SMB_ACCRUAL_INTEREST *** ===
declare 
    id_ number ;
begin 
    bc.go('/'); 

    id_ := TMS_UTL.create_or_replace_task (
             p_task_code               => 'SMB_ACCRUAL_INTEREST' -- унікальний код процедури (довідник TMS_TASK)
            ,p_task_group_id           => 1  -- контекст банківської дати при виконанні процедури: 1 - фініш, 2 - старт, 3 - не встановлюється контекст дати
            ,p_sequence_number         => 303  -- порядковий номер виконання завдання (може дублюватися)
            ,p_task_name               => 'smb Нарахування відсотків. Депозити ММСБ'   -- назва завдання
            ,p_task_description        => null  -- додатковий текстовий опис завдання
            ,p_separate_by_branch_mode => 3  -- режим представлення РУ: 1 - виконувати процедуру на "/", 2 - кожна РУ обробляється по черзі, 3 - всі РУ обробляються паралельно
            ,p_action_on_failure       => 1  -- порядок дій у разі виникнення помилки: 1 - продовжити виконання процедур, 2 - зупинити виконання наступних процедур
            ,p_task_statement          =>
                                         'begin
                                              smb_calculation_deposit.auto_accrual_interest(p_date    => null
                                                                                           ,p_deposit_list => null);
                                              commit;
                                          end ;' -- PL/SQL-блок, що виконується для даного завдання
       ) ;
 
    commit;
end;
/

prompt == *** SMB_DEPOSIT_CLOSING *** ===
declare 
    id_ number ;
begin 
    bc.go('/'); 

    id_ := TMS_UTL.create_or_replace_task (
             p_task_code               => 'SMB_DEPOSIT_CLOSING' -- унікальний код процедури (довідник TMS_TASK)
            ,p_task_group_id           => 1  -- контекст банківської дати при виконанні процедури: 1 - фініш, 2 - старт, 3 - не встановлюється контекст дати
            ,p_sequence_number         => 304  -- порядковий номер виконання завдання (може дублюватися)
            ,p_task_name               => 'smb Автоматичне закриття депозитних траншів. Депозити ММСБ'   -- назва завдання
            ,p_task_description        => null  -- додатковий текстовий опис завдання
            ,p_separate_by_branch_mode => 3  -- режим представлення РУ: 1 - виконувати процедуру на "/", 2 - кожна РУ обробляється по черзі, 3 - всі РУ обробляються паралельно
            ,p_action_on_failure       => 1  -- порядок дій у разі виникнення помилки: 1 - продовжити виконання процедур, 2 - зупинити виконання наступних процедур
            ,p_task_statement          =>
                                         'begin
                                              smb_calculation_deposit.auto_deposit_closing(p_date => null);
                                              commit;
                                          end ;' -- PL/SQL-блок, що виконується для даного завдання
       ) ;
 
    commit;
end;
/

prompt == *** SMB_PAYMENT_ACCRUED_INTEREST *** ===
declare 
    id_ number ;
begin 
    bc.go('/'); 

    id_ := TMS_UTL.create_or_replace_task (
             p_task_code               => 'SMB_PAYMENT_ACCRUED_INTEREST' -- унікальний код процедури (довідник TMS_TASK)
            ,p_task_group_id           => 2  -- контекст банківської дати при виконанні процедури: 1 - фініш, 2 - старт, 3 - не встановлюється контекст дати
            ,p_sequence_number         => 305  -- порядковий номер виконання завдання (може дублюватися)
            ,p_task_name               => 'smb Виплата нарахованих відсотків. Депозити ММСБ'   -- назва завдання
            ,p_task_description        => null  -- додатковий текстовий опис завдання
            ,p_separate_by_branch_mode => 3  -- режим представлення РУ: 1 - виконувати процедуру на "/", 2 - кожна РУ обробляється по черзі, 3 - всі РУ обробляються паралельно
            ,p_action_on_failure       => 1  -- порядок дій у разі виникнення помилки: 1 - продовжити виконання процедур, 2 - зупинити виконання наступних процедур
            ,p_task_statement          =>
                                         'begin
                                              smb_calculation_deposit.auto_payment_accrued_interest(p_date    => null);
                                              commit;
                                          end ;' -- PL/SQL-блок, що виконується для даного завдання
       ) ;
 
    commit;
end;
/

prompt == *** SMB_ACCOUNT_DEPOSIT_CLOSING *** ===
declare 
    id_ number ;
begin 
    bc.go('/'); 

    id_ := TMS_UTL.create_or_replace_task (
             p_task_code               => 'SMB_ACCOUNT_DEPOSIT_CLOSING' -- унікальний код процедури (довідник TMS_TASK)
            ,p_task_group_id           => 2  -- контекст банківської дати при виконанні процедури: 1 - фініш, 2 - старт, 3 - не встановлюється контекст дати
            ,p_sequence_number         => 306  -- порядковий номер виконання завдання (може дублюватися)
            ,p_task_name               => 'smb Автоматичне закриття рахунків. Депозити ММСБ'   -- назва завдання
            ,p_task_description        => null  -- додатковий текстовий опис завдання
            ,p_separate_by_branch_mode => 3  -- режим представлення РУ: 1 - виконувати процедуру на "/", 2 - кожна РУ обробляється по черзі, 3 - всі РУ обробляються паралельно
            ,p_action_on_failure       => 1  -- порядок дій у разі виникнення помилки: 1 - продовжити виконання процедур, 2 - зупинити виконання наступних процедур
            ,p_task_statement          =>
                                         'begin
                                              smb_calculation_deposit.auto_account_deposit_closing(p_date    => null);
                                              commit;
                                          end ;' -- PL/SQL-блок, що виконується для даного завдання
       ) ;
 
    commit;
end;
/
