PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_TPL.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль TPL ***
declare
  l_mod  varchar2(3) := 'TPL';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Шаблоны документов', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Шаблон %s не найден', '', 1, 'TPL_NOTFOUND');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Шаблон %s не знайдено', '', 1, 'TPL_NOTFOUND');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_TPL.sql =========*** Run *** ==
PROMPT ===================================================================================== 
