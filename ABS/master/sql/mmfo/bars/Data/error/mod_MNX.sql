PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_MNX.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль MNX ***
declare
  l_mod  varchar2(3) := 'MNX';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Клірінг пл. ситем та переказів', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_geo, 'The system already exists', 'The system already exists', 1, 'ERR_KOD_NBU');
    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Такая системма уже существует', 'Такая системма уже существует', 1, 'ERR_KOD_NBU');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Така системма вже існує', 'Така системма вже існує', 1, 'ERR_KOD_NBU');

    bars_error.add_message(l_mod, 2, l_exc, l_geo, 'Choose a system', 'Choose a system', 1, 'NOT_KOD_NBU');
    bars_error.add_message(l_mod, 2, l_exc, l_rus, 'Выберите систему переводов', 'Выберите систему переводов', 1, 'NOT_KOD_NBU');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, 'Оберіть систему переводів', 'Оберіть систему переводів', 1, 'NOT_KOD_NBU');

    bars_error.add_message(l_mod, 3, l_exc, l_geo, 'Enter the Profix ID', 'Enter the Profix ID', 1, 'NOT_ID_PROFIX');
    bars_error.add_message(l_mod, 3, l_exc, l_rus, 'Введите идентификатор Profix', 'Введите идентификатор Profix', 1, 'NOT_ID_PROFIX');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, 'Введіть ідентифікатор Profix', 'Введіть ідентифікатор Profix', 1, 'NOT_ID_PROFIX');

    bars_error.add_message(l_mod, 4, l_exc, l_geo, 'The action is carried out by the responsible officer', 'The action is carried out by the responsible officer', 1, 'ERR_USER');
    bars_error.add_message(l_mod, 4, l_exc, l_rus, 'Действие выполняется ответственным сотрудником', 'Действие выполняется ответственным сотрудником', 1, 'ERR_USER');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, 'Дія виконується відповідальним співробітником ГО', 'Дія виконується відповідальним співробітником ГО', 1, 'ERR_USER');

    bars_error.add_message(l_mod, 5, l_exc, l_geo, 'The operation has already been conducted!', 'The operation has already been conducted!', 1, 'ERR_PROC');
    bars_error.add_message(l_mod, 5, l_exc, l_rus, 'Операция уже проводилась!', 'Операция уже проводилась!', 1, 'ERR_PROC');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, 'Операція вже проводилась!', 'Операція вже проводилась!', 1, 'ERR_PROC');

    bars_error.add_message(l_mod, 6, l_exc, l_geo, 'No OB parameters ', '', 1, 'NOT_OB');
    bars_error.add_message(l_mod, 6, l_exc, l_rus, 'Отсутствуют параметры ОВ', '', 1, 'NOT_OB');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, 'Відсутні параметри ОВ', '', 1, 'NOT_OB');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_MNX.sql =========*** Run *** ==
PROMPT ===================================================================================== 
