
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_universal_box2.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_UNIVERSAL_BOX2 
/*
--Date:           27/09/2011
--Comments: Функция для визирования пользователями
--                  документов на универсальных окнах
*/

(  p_userid oper.userid%type)
return int
is
    l_id    universal_box.id%type;
begin
    select id
      into l_id
      from universal_box
     where id = p_userid;
    -- користувач в довіднику, візу не просимо
    return 0;
exception
    when no_data_found then
        -- користувач не у довіднику, аналізуємо параметр NOT2VISA
        if nvl(branch_usr.get_branch_param('NOT2VISA'),0) = 0
        then
            return 1;
        else
            return 0;
        end if;
end f_universal_box2;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_universal_box2.sql =========*** E
 PROMPT ===================================================================================== 
 