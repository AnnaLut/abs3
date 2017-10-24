
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_translate_kmu.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_TRANSLATE_KMU (p_txt varchar2) return varchar2 is
  l_txt  varchar2(2000) := null;
  l_char varchar2(1);
  l_rus  varchar2(100) := '���å���Ȳ��������������ݨ';
  l_eng  varchar2(100) := 'ABVHGDEZYIIIKLMNOPRSTUFYEE';
begin

  l_txt := ' ' || upper(trim(p_txt));

  -- ��������������
  l_txt := replace(l_txt, ' �', ' YE');
  l_txt := replace(l_txt, ' �', ' YI');
  l_txt := replace(l_txt, ' �', ' Y');
  l_txt := replace(l_txt, ' �', ' YU');
  l_txt := replace(l_txt, ' �', ' YA');
  l_txt := replace(l_txt, '�',  'IE');
  l_txt := replace(l_txt, '�',  'IU');
  l_txt := replace(l_txt, '�',  'IA');
  l_txt := replace(l_txt, '�',  'ZH');
  l_txt := replace(l_txt, '�',  'KH');
  l_txt := replace(l_txt, '�',  'TS');
  l_txt := replace(l_txt, '�',  'CH');
  l_txt := replace(l_txt, '�',  'SH');
  l_txt := replace(l_txt, '�',  'SHCH');
  l_txt := replace(l_txt, '��', 'ZGH');
  l_txt := replace(l_txt, '�',  '');
  l_txt := replace(l_txt, '�',  '');
  l_txt := replace(l_txt, '''', '');
  l_txt := replace(l_txt, '`', '');

  l_txt := trim(translate(l_txt, l_rus, l_eng));
  return l_txt;
end;
/
 show err;
 
PROMPT *** Create  grants  F_TRANSLATE_KMU ***
grant EXECUTE                                                                on F_TRANSLATE_KMU to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_TRANSLATE_KMU to CUST001;
grant EXECUTE                                                                on F_TRANSLATE_KMU to START1;
grant EXECUTE                                                                on F_TRANSLATE_KMU to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_translate_kmu.sql =========*** En
 PROMPT ===================================================================================== 
 