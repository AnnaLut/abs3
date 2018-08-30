declare
  ID_ INT;
  l_seq_num   tms_task.sequence_number%type;
begin

  bc.home;

  select max(SEQUENCE_NUMBER)
    into l_seq_num
    from TMS_TASK;

  id_ := TMS_UTL.CREATE_OR_REPLACE_TASK
         ( p_task_code               => 'INT_ACR_MO'
         , p_task_group_id           => TMS_UTL.TASK_GROUP_BEFORE_FINISH -- на фініші дня
         , p_sequence_number         => l_seq_num + 1
         , p_task_name               => 'INT. Нарахування %% по непортфельним рахунках'
         , p_task_description        => 'Регламентні роботи по закриттю місяця'
         , p_separate_by_branch_mode => 3 -- TMS_UTL.BRANCH_PROC_MODE_PARALLEL
         , p_action_on_failure       => TMS_UTL.ACTION_ON_FAILURE_PROCEED
         , p_task_statement          => 'begin INTEREST_UTL.MONTHLY_INTEREST_ACCRUAL( false ); end;'
         );
  commit;
----------------------------------------
end;
/



update tms_task set 
                    state_id = 1        -- по-умолчанию включено
where          id in ( 282,   -- Нарахування комісії за РКО 3570-6110            (seq_num = 47)
                       162,   -- Нарахування відсотків по вкладам в кінці місяця (seq_num = 280)
                       402,   -- INT. Нарахування %% по непортфельним рахунках   (seq_num = 402)
                       302,   -- Нарахування абонплати 3570-6110                 (seq_num = 302)
                       263,   -- Нарахування відсотків,комісій,пені по КП ФО 
                       264    -- Нарахування відсотків,комісій,пені по КП ЮО
                    );
commit;



begin 
  insert into tms_task_exclusion(task_code, kf) values('AVTO%_CCKU','300465');
  commit;
exception when dup_val_on_index then
   null;
end;
/

