

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CHECK_STAT_PARAM.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CHECK_STAT_PARAM ***

  CREATE OR REPLACE PROCEDURE BARS.P_CHECK_STAT_PARAM (p_table_name in varchar2, p_id in number, p_dk in number, p_out out number)
--функция проверяет на правильность заполнения стат. параметров для биржевых заявок согласно правилам,
--заведенных в таблицу stat_param_rule
is

t_result     number;
t_sql        varchar2(2000);

 procedure f_sql_text (p_table_name varchar2, p_id number, p_dk number,
                       p_param_main varchar2, p_value_main varchar2,
                       p_result out number
                      )
 as
 t_sql        varchar2(2000);
 t_result     number;
 begin
  t_result:=1;
  for i in (select * from stat_param_rule s
             where s.table_name=p_table_name
               and s.dk=p_dk
               and s.param_main=p_PARAM_MAIN
               and s.value_main=p_value_main)
  loop
    begin
      t_sql:='select count(*)
               from '||p_table_name ||'
              where id='||p_id||'
                and dk='||p_dk||'
                and '||p_PARAM_MAIN ||' =  to_char ('''||p_VALUE_MAIN||''')
                and '||i.PARAM_SUBJECT ||' = to_char('''||i.VALUE_SUBJECT ||''')';
       execute immediate t_sql into t_result;
       if t_result > 0 then
           f_sql_text(p_table_name,p_id,p_dk,i.PARAM_SUBJECT,i.VALUE_SUBJECT,t_result);
       elsif t_result = 0 then
             t_result:=-1;
             exit;
       end if;
    exception
       when others then t_result:=0;
    end;
  end loop;
    p_result:=t_result;
 end;

begin

  t_result:=0;

  for i in (select * from stat_param_rule s where s.table_name=p_table_name)
  loop
    begin
      t_sql:='select count(*)
               from '||p_table_name ||'
              where id='||p_id||'
                and dk='||p_dk||'
                and '||i.PARAM_MAIN ||' =  to_char ('''||i.VALUE_MAIN||''')';
       execute immediate t_sql into t_result;
       if t_result > 0 then
           f_sql_text(p_table_name,p_id,p_dk,i.param_main,i.value_main,t_result);
       end if;
    exception
       when others then t_result:=0;
    end;
  end loop;

  -- t_result= 0 - в таблице нет правил для такой цели
  -- t_result= 1 - правило найдено, поля заполнены соответсвенно правилу
  -- t_result=-1 - правильно найдено, но поля заполнены неверно
   p_out:=t_result;
end;
/
show err;

PROMPT *** Create  grants  P_CHECK_STAT_PARAM ***
grant EXECUTE                                                                on P_CHECK_STAT_PARAM to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_CHECK_STAT_PARAM to START1;
grant EXECUTE                                                                on P_CHECK_STAT_PARAM to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CHECK_STAT_PARAM.sql =========**
PROMPT ===================================================================================== 
