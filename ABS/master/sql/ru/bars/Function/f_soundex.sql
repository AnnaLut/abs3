
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_soundex.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_SOUNDEX (p_txt varchar2)
return varchar2 is
-- soundex на новый лад
  l_txt   varchar2(350);
  l_first varchar2(1);
  i       number;
  l_len   number;

  l_a1 varchar2(7) := 'EYUIOA';
  l_a2 varchar2(7) := 'AAAAAA';
  l_c1 varchar2(6) := 'QSKZXC';
  l_c2 varchar2(6) := 'CCCCCC';
  l_v1 varchar2(5) := 'VWBPF';
  l_v2 varchar2(5) := 'VVVVV';
  l_g1 varchar2(3) := 'GJH';
  l_g2 varchar2(3) := 'GGG';
  l_d1 varchar2(2) := 'DT';
  l_d2 varchar2(2) := 'DD';
  l_m1 varchar2(2) := 'MN';
  l_m2 varchar2(2) := 'MM';
begin
  l_txt := upper(trim(p_txt));

  -- несколько симв. -> в один
  l_txt := replace(l_txt, 'ZH', 'C');
  l_txt := replace(l_txt, 'KH', 'C');
  l_txt := replace(l_txt, 'TS', 'C');
  l_txt := replace(l_txt, 'CH', 'C');
  l_txt := replace(l_txt, 'SH', 'C');
  l_txt := replace(l_txt, 'SHCH', 'C');

  -- H (англ.) в конце игнорируем
  l_txt := l_txt || ' ';
  l_txt := replace(l_txt, 'H ', '');
  l_txt := trim(l_txt);

  -- гласные
  l_txt := translate(l_txt, l_a1, l_a2);

  -- запоминаем первую букву
  l_first := substr(l_txt,1,1);
  l_txt := substr(l_txt,2);

  l_txt := translate(l_txt,l_c1,l_c2);
  l_txt := translate(l_txt,l_v1,l_v2);
  l_txt := translate(l_txt,l_g1,l_g2);
  l_txt := translate(l_txt,l_d1,l_d2);
  l_txt := translate(l_txt,l_m1,l_m2);

  --убираем повторяющиеся буквы
  l_len := length(l_txt);
  if l_len > 1 then
     i := 1;
     while i < l_len loop
        if substr(l_txt,i,1) = substr(l_txt,i+1,1) then
           l_txt := substr(l_txt,1,i) || substr(l_txt, i+2);
           l_len := l_len - 1;
        else
           i := i + 1;
        end if;
     end loop;
  end if;

  return l_first || l_txt;
end f_soundex;
/
 show err;
 
PROMPT *** Create  grants  F_SOUNDEX ***
grant EXECUTE                                                                on F_SOUNDEX       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_SOUNDEX       to START1;
grant EXECUTE                                                                on F_SOUNDEX       to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_soundex.sql =========*** End *** 
 PROMPT ===================================================================================== 
 