PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_BMS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль BMS ***
declare
  l_mod  varchar2(3) := 'BMS';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'BARS Message', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Достигнуто макс. количество подписчиков в %s очередях, обратитесь к администратору!', '', 1, 'exceeded_max_number');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Досягнуто макс. кількість отримувачів в %s чергах, зверніться до адміністратора!', '', 1, 'exceeded_max_number');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_BMS.sql =========*** Run *** ==
PROMPT ===================================================================================== 
