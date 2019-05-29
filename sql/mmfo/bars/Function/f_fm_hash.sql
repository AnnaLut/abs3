
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_fm_hash.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_FM_HASH (p_txt varchar2) return varchar2
is
  l_tmp   varchar2(2000);
  l_tmp2  varchar2(2000);
  l_ascii pls_integer;
  n       pls_integer;
  l_hash  varchar2(32);
begin

  l_tmp := p_txt;

  -- верхний регистр
  l_tmp := upper(l_tmp);

  -- транслитерация
  l_tmp := f_translate_kmu(l_tmp);

  if l_tmp is not null then
     -- удаляем не-буквы
     l_tmp2 := null;
     n := length(l_tmp);
     for i in 1..n loop
         l_ascii := ascii(substr(l_tmp, i, 1));
         if l_ascii >= 65 and l_ascii <= 90 then
            l_tmp2 := l_tmp2 || substr(l_tmp, i, 1);
         end if;
     end loop;
  end if;

  -- hash-функция
  if l_tmp2 is not null then
     l_hash:= dbms_obfuscation_toolkit.MD5(input => utl_raw.cast_to_raw(c => l_tmp2));
  else
     l_hash := null;
  end if;

  return l_hash;

end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_fm_hash.sql =========*** End *** 
 PROMPT ===================================================================================== 
 