
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/function/f_trans_value.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARSAQ.F_TRANS_VALUE (p_value in varchar2, kv in number) return varchar2 is
  l_value varchar2(200);
  begin
    l_value := substr(replace(p_value,'$nl$',chr(13)||chr(10)),1,200);

    -- замена укр. букв на соответствующие латинские (из-за проблем с транслитерацией)
    l_value := replace(l_value, 'і', 'i');
    l_value := replace(l_value, 'І', 'I');

    if kv!=643 then
        l_value := substr(bars.bars_swift.StrToSwift(l_value,'TRANS'),1,200);
    end if;
    return l_value;
  end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARSAQ/function/f_trans_value.sql =========*** En
 PROMPT ===================================================================================== 
 