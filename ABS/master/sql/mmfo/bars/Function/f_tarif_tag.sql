
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_tarif_tag.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_TARIF_TAG 
 (p_ref     in oper.ref%type,      -- ref документа
  p_tag     in op_field.tag%type)  -- код доп.реквизита
 return number
is
  l_value   operw.value%type;  -- числовое значение доп.реквизита операции
  l_num     number;        -- числовое значение доп.реквизита операции
  g_number_format     constant varchar2(128) := 'FM999999999999999999999999999999.9999999999999999999999999999999';
        -- параметры преобразования char <--> number
  g_number_nlsparam   constant varchar2(30)  := 'NLS_NUMERIC_CHARACTERS = ''. ''';
  err       exception;
  erm       varchar2(80);
begin

    begin
        select value
          into l_value
          from operw
         where ref = p_ref
           and tag = p_tag;
      exception when no_data_found
                then erm := '9701- '|| 'Відсутній додатковий реквізит в операції '||p_tag;
                     raise err;
    end;

    begin

        if nvl(length(trim(translate(l_value, '0123456789.,', ' '))),0) = 0 then
           l_value := replace(l_value,' ','');
           l_value := replace(l_value,',','.');  --привели строку к представлению 999999.99
           l_num   := to_number(l_value, g_number_format, g_number_nlsparam);
        else erm := '9701- '|| 'Додатковий реквізит містіть недопустимі символи '||l_value;
             raise err;
        end if;

    end;


    return l_num;

    exception
       when err
        then
            raise_application_error(-20000,'\'||erm);
       when others
        then
            raise_application_error(-20000,
            dbms_utility.format_error_stack()||dbms_utility.format_error_backtrace());

end F_TARIF_TAG;
/
 show err;
 
PROMPT *** Create  grants  F_TARIF_TAG ***
grant EXECUTE                                                                on F_TARIF_TAG     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_TARIF_TAG     to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_tarif_tag.sql =========*** End **
 PROMPT ===================================================================================== 
 