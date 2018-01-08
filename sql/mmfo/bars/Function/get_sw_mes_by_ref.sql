
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_sw_mes_by_ref.sql =========*** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_SW_MES_BY_REF (p_ref oper.ref%type)
  return varchar2 is
  Result varchar2(4000);
begin
  /*пишем номер строки, букву, а потом уже само сообщение*/
  select listagg('#F' || sw.tag || sw.opt || ':' || sw.value || '#',
                 chr(13) || chr(10)) within group(order by sw.ref) as val
    into Result
  from( /*по одному рефу может быть несколько сообщений, исключаем дубликаты*/
    select distinct os.ref,
                    t.tag,
                    t.opt,
                    /*убираем переносы строки и пробелы по краям*/
                    trim(replace(upper(t.value), chr(13) || chr(10), ' ')) as value
      from SW_OPERW t, sw_oper os
     where t.swref = os.swref
       and os.ref = p_ref
       and to_number(t.tag) between 20 and 71
     order by t.tag, t.opt) sw
     group by sw.ref;
  return(Result);
end get_sw_mes_by_ref;
/
 show err;
 
PROMPT *** Create  grants  GET_SW_MES_BY_REF ***
grant EXECUTE                                                                on GET_SW_MES_BY_REF to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_sw_mes_by_ref.sql =========*** 
 PROMPT ===================================================================================== 
 