PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_CPN.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль CPN ***
declare
  l_mod  varchar2(3) := 'CPN';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Модуль цiнних паперiв НБУ', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Код ценной бумаги %s не найден', '', 1, 'NO_SUCH_IDCP');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Код ц_нного паперу %s не знайдено', '', 1, 'NO_SUCH_IDCP');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, 'Для ценной бумаги %s дата %s уже установлена для выплаты под номером %s', '', 1, 'DATE_WAS_USED');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, 'Для цінного паперу %s дату %s вже встановлено для виплати під номером %s', '', 1, 'DATE_WAS_USED');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, 'Для ценной бумаги %s не найден преидущий номер выплаты %s. Был передан %s', '', 1, 'NO_PREVIOUS_NPP');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, 'Для цінного паперу %s не знайдено попердній номер виплати %s. Ьуло передано %s', '', 1, 'NO_PREVIOUS_NPP');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, 'Для ценной бумаги %s попытка вставить под номером %s дату оплаты %s, которая установлена для номера  %s', '', 1, 'SUCH_DATE_INOTHERNPP');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, 'Для цінного паперу %s спроба внести під номером %s дату сплати %s, яку вже встановлено для номеру %s', '', 1, 'SUCH_DATE_INOTHERNPP');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, 'Ценная бумага с кодом %s уже существует в справочнике', '', 1, 'YET_EXISTS');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, 'Цiнний папер  з кодом %s  вже iснує в довiднику', '', 1, 'YET_EXISTS');

    bars_error.add_message(l_mod, 6, l_exc, l_rus, 'Передан некорректный тип оплаты (должен быть 1-купон,2-номинал): %s', '', 1, 'NOT_CORRECT_PAYTYPE');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, 'Передано некорекний тип сплати 9повинен бути 1-купон,2-номынал): %s', '', 1, 'NOT_CORRECT_PAYTYPE');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_CPN.sql =========*** Run *** ==
PROMPT ===================================================================================== 
