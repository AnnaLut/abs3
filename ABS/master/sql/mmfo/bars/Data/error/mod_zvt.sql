PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_ZVT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль ZVT ***
declare
  l_mod  varchar2(3) := 'ZVT';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Отчетность свода банковского дня', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Накопление данных выполняется толко на уровне РУ', '', 1, 'ONLY_ON_MFO_LEVEL');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Накопление данных выполняется толко на уровне РУ', '', 1, 'ONLY_ON_MFO_LEVEL');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_ZVT.sql =========*** Run *** ==
PROMPT ===================================================================================== 
