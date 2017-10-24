

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_TASK.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_TASK ***

  CREATE OR REPLACE PROCEDURE BARS.P_TASK ( P_MOD INT, P_cod varchar2, p_grp int, P_ORD INT, P_Nam varchar2, p_dsc varchar2, P_MFO int, p_ERR INT, p_SQL varchar2 )  IS
 ID_ INT ;
BEGIN
 iF P_MOD = 1 THEN -- ВСТАВКА -- Артем Юрченко
    id_ := TMS_UTL.create_or_replace_task (
        p_task_code               => p_cod,  -- унікальний код процедури (довідник TMS_TASK)
        p_task_group_id           => p_grp,  -- контекст банківської дати при виконанні процедури: 1 - фініш, 2 - старт, 3 - не встановлюється контекст дати
        p_sequence_number         => p_ord,  -- порядковий номер виконання завдання (може дублюватися)
        p_task_name               => p_nam,  -- назва завдання
        p_task_description        => p_dsc,  -- додатковий текстовий опис завдання
        p_separate_by_branch_mode => p_Mfo,  -- режим представлення РУ: 1 - виконувати процедуру на "/", 2 - кожна РУ обробляється по черзі, 3 - всі РУ обробляються паралельно
        p_action_on_failure       => p_err,  -- порядок дій у разі виникнення помилки: 1 - продовжити виконання процедур, 2 - зупинити виконання наступних процедур
        p_task_statement          => p_sql   -- PL/SQL-блок, що виконується для даного завдання
                                          ) ;
 end if;
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_TASK.sql =========*** End *** ==
PROMPT ===================================================================================== 
