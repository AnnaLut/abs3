
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/branch_adm.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BRANCH_ADM is
/*
  История изменений:

   17/03/2006 Иван   1. Сделал пакет интерфейсно совместимым с пред.
                        версией пакета - TOBO_ADM
   21.10.2005 SERG   Создание
*/

-- вернуть код отделения для пользователя
function get_user_branch(p_name in varchar2) return varchar2;
-- установить код отделения для пользователя
procedure set_user_branch(p_name in varchar2, p_branch varchar2);

/**************************************************************
* Функции для интерфейсной совместимости с пакетом TOBO_ADM
***************************************************************/

-- вернуть код ТОБО для пользователя
function GetUserTOBO(uname in varchar2) return varchar2;
-- установить код ТОБО для пользователя
procedure SetUserTOBO(uname in varchar2, tobo_value varchar2);

end branch_adm;
/
CREATE OR REPLACE PACKAGE BODY BARS.BRANCH_ADM is
/*
   29.03.2006 Иван   2. Убрал из пакета работу с STAFF_BRANCH - это
                        представление и модифицировать его не нужно.
   17/03/2006 Иван   1. Сделал пакет интерфейсно совместимым с пред.
                        версией пакета - TOBO_ADM
   21.10.2005 SERG   Создание
*/

-- вернуть код отделения для пользователя
function get_user_branch(p_name in varchar2) return varchar2 is
  v_branch staff.branch%type;
begin
  select branch into v_branch from staff where logname=p_name;
  return v_branch;
end;
-- установить код отделения для пользователя
procedure set_user_branch(p_name in varchar2, p_branch varchar2) is
begin
  /*begin -- добавляем в список разрешенных отделений для пользователя
    insert into staff_branch(id,branch)
    select id, branch from staff where logname=p_name;
  exception when dup_val_on_index then
    null;
  end;*/
  -- проставляем код ТОБО пользователю
  update staff set branch=p_branch where logname=p_name;
end;

-- вернуть код ТОБО для пользователя
function GetUserTOBO(uname in varchar2) return varchar2 is
begin
  return get_user_branch(uname);
end;

-- установить код ТОБО для пользователя
procedure SetUserTOBO(uname in varchar2, tobo_value varchar2) is
begin
  set_user_branch(uname, tobo_value);
end;

end branch_adm;
/
 show err;
 
PROMPT *** Create  grants  BRANCH_ADM ***
grant EXECUTE                                                                on BRANCH_ADM      to ABS_ADMIN;
grant EXECUTE                                                                on BRANCH_ADM      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BRANCH_ADM      to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/branch_adm.sql =========*** End *** 
 PROMPT ===================================================================================== 
 