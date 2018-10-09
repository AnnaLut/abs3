
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/cim_mgr.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
CREATE OR REPLACE PACKAGE CIM_MGR
is
   --
   --  CIM_MGR
   --  Currency Inspection Module - Модуль валютного контролю
   --

-- g_header_version    constant varchar2 (64) := 'version 1.00.01 17/07/2015';
-- g_header_version    constant varchar2 (64) := 'version 1.00.02 16/11/2015';
-- g_header_version    constant varchar2 (64) := 'version 1.00.03 04/04/2016';
-- g_header_version    constant varchar2 (64) := 'version 1.00.04 08/08/2016';
   g_header_version    constant varchar2 (64) := 'version 1.01.03 23/08/2018';
   g_awk_header_defs   constant varchar2 (512) := '';

   --------------------------------------------------------------------------------
   -- Типи
   --

   --------------------------------------------------------------------------------
   -- Константи
   --
   --------------------------------------------------------------------------------
   -- Глобальні константи
   --

   --------------------------------------------------------------------------------
   -- Глобальні змінні
   --

   --------------------------------------------------------------------------------
   -- header_version - повертає версію заголовка пакету
   --
   function header_version return varchar2;

   --------------------------------------------------------------------------------
   -- body_version - повертає версію тіла пакету
   --
   function body_version return varchar2;

   --------------------------------------------------------------------------------
   -- get_address - Адреса клієнта
   --
   -- @p_rnk - RNK клієнта

   function get_address (p_rnk in number) return varchar2;

   --------------------------------------------------------------------------------
   -- body_version - конвертор для формування WEB-посилань
   --
   FUNCTION form_url_encode ( data IN VARCHAR2) RETURN VARCHAR2;

   --------------------------------------------------------------------------------
   -- check_visa_condition - перевірка умови необхідності візування документу візою валютного контролю
   --
   -- @p_dk - дебет\кредит документу
   -- @p_kv - валюта документу
   -- @p_nlsa - рахунок А документу
   -- @p_nlsb - рахунок Б документу
   --
   function check_visa_condition(p_dk in number, p_kv in number, p_nlsa in varchar2, p_nlsb in varchar2,
                                 p_tt in varchar2 := null, p_ref in number := null) return number;

   --------------------------------------------------------------------------------
   -- check_visa_condition_by_ref - перевірка умови необхідності візування документу візою валютного контролю (по реф. документа)
   --
   -- @p_ref - референс документу
   --
   function check_visa_condition_by_ref(p_ref in number) return number;

   --------------------------------------------------------------------------------
   -- get_payments_bound_sum - сума усіх привязних платежів по реальному документу
   --
   -- @p_ref - референс документу
   --
   function get_payments_bound_sum(p_ref in number) return number;

   --------------------------------------------------------------------------------
   -- get_payment_oper_type - тип операції із дод. реквізиту документа
   --
   -- @p_ref - референс документу
   --
   function get_payment_oper_type(p_ref in number) return varchar2;

--------------------------------------------------------------------------------
   -- check_contract_status - Перевірка та оновлення статусу контракту
   --
   procedure check_contract_status(p_contr_id in number /*id контракту*/);

--------------------------------------------------------------------------------
   -- create_ape - Створення акту цінової експертизи
   --
   procedure create_ape (p_contr_id number, -- id контракту
                         p_num varchar2, -- Номер акту цінової експертизи
                         p_kv number, -- Код валюти
                         p_s number, -- Сума
                         p_rate number, --Курс
                         p_s_vk number, --Сума у валюті контракту
                         p_begin_date date, -- Дата акту цінової експертизи
                         p_end_date date, -- Дата, до якої дійсний акт
                         p_comments varchar2 -- Примітка
                        );

--------------------------------------------------------------------------------
   -- delete_ape - Видалення акту цінової експертизи
   --
   procedure delete_ape (p_ape_id number); -- id акту цінової експертизи

--------------------------------------------------------------------------------
   -- update_ape - Редагування акту цінової експертизи
   --
    procedure update_ape (p_ape_id number, -- id акту цінової експертизи
                          p_num varchar2, -- Номер акту цінової експертизи
                          p_kv number, -- Код валюти
                          p_s number, -- Сума
                          p_rate number, --Курс
                          p_s_vk number, --Сума у валюті контракту
                          p_begin_date date, -- Дата акту цінової експертизи
                          p_end_date date, -- Дата, до якої дійсний акт
                          p_comments varchar2 -- Примітка
                         );

-- ape_link - Зв'язок Акту цінової експертизи з платежем
--
procedure ape_link(p_ape_id in number, --id акту
                   p_doc_type in number, --тип документу
                   p_doc_id in number, --id документу
                   p_s in number:=null, -- Сума
                   p_service_code in varchar2:=null --Код класифікатора послуг
                  );

-- ape_unlink - Відв'язка Акту цінової експертизи від платежу
--
procedure ape_unlink(p_ape_id in number, --id Акту цінової експертизи
                     p_doc_type in number, --тип документу
                     p_doc_id in number --id документу
                    );

-- get_ape_link_sum - Сума зв'язку Акту цінової експертизи з платежем
function get_ape_link_sum (p_ape_id in number, --id висновку
                           p_doc_type in number, --тип документу
                           p_doc_id in number --id документу
                          ) return number;

--------------------------------------------------------------------------------
-- ape_requed - Необхідність прив'язки акта цінової експертизи
--
function ape_requed(p_contr_id in number, --id контракту
                    p_service_code in varchar2, --Код класифікатора послуг
                    p_val_date in date, --Дата валютування
                    p_kv in number, --Код валюти платежу
                    p_s_vp in number, --Сума у валюті платежу
                    p_s_vk in number --Сума у валюті контракту
                   ) return number; --0 - акт не потрібний, 1 -  повідомлення про перевірку наявності актів, 2 - акт обов'язковий

--------------------------------------------------------------------------------
-- create_license - Створення ліцензії мінекономіки
--
   procedure create_license (p_okpo varchar2, -- id контракту
                             p_num varchar2, -- Номер ліцензії
                             p_type number, -- Тип ліцензії
                             p_kv number, -- Код валюти
                             p_s number, -- Сума
                             p_begin_date date, -- Дата ліцензії
                             p_end_date date, -- Дата, до якої дійсна ліцензія
                             p_comments varchar2 -- Примітка
                            );

-------------------------------------------------------------------------------
   -- delete_license - Видалення ліцензії мінекономіки
   --
   procedure delete_license (p_license_id number); -- id ліцензії мінекономіки
-------------------------------------------------------------------------------
   -- update_license - Редагування ліцензії мінекономіки
   --
    procedure update_license (p_license_id number, -- id акту цінової експертизи
                              p_num varchar2, -- Номер ліцензії
                              p_type number, -- Тип ліцензії
                              p_kv number, -- Код валюти
                              p_s number, -- Сума
                              p_begin_date date, -- Дата ліцензії
                              p_end_date date, -- Дата, до якої дійсна ліцензія
                              p_comments varchar2 -- Примітка
                             );

-- license_link - Зв'язок ліцензії з первинним документом
--
procedure license_link(p_license_id in number, --id ліцензії
                       p_doc_type in number, --тип документу
                       p_doc_id in number, --id документу
                       p_s in number, -- Сума зв`язку
                       p_kv in number :=null, --Код валюти
                       p_s_pl in number :=null -- Сума платежу
                      );

-- clear_null_license - Видалення рив'язок ліцензій без id платежа
--
procedure clear_null_license (p_okpo in varchar2 --ОКПО
                             );

-- license_unlink - Відв'язка ліцензії від платежу
--
procedure license_unlink(p_license_id in number, --id ліцензії
                         p_doc_type in number, --тип платежу
                         p_doc_id in number --id платежу
                        );

-- get_license_link_sum - Сума зв'язку ліцензії з платежем
--
function get_license_link_sum (p_license_id in number, --id ліцензії
                               p_doc_type in number, --тип платежу
                               p_doc_id in number --id платежу
                              ) return number;

--------------------------------------------------------------------------------
   -- set_selected_doc - встановленняid вибраного пов'язаного документа (використовужється на формі стан контракту)
   --
   -- @p_ref - референс документу
   --
   procedure set_selected_doc (p_ref number);
   -- get_selected_doc - вибірка id вибраного пов'язаного документа (використовуэться на формы стан контракту)
   --
   function get_selected_doc return number;
  -- get_visa_id - вибірка id візи валютного контролю
  --
   function get_visa_id return number;

  -- get_visa_status - Стан візи документа
  --  xxx 0 - документ завізовано візою валютного контролю xxx
  --  1 - віза валютного контролю відсутня на документі
  --  2 - віза валютного контролю наявна, але не є наступною у документі
  --  3 - віза валютного контролю наступна у документі
  --
   function get_visa_status (p_tt in oper.tt%type, p_nextvisagrp in oper.nextvisagrp%type ) return number;

   -------------------------------------------------------------------------------
   -- check_visa_status - Перевірка стан віз по документу
   --
   procedure check_visa_status (p_ref in oper.ref%type, p_code out number,  p_msg out varchar2);

  -- f_check_visa_status - Стан візи документа
  --  0 - документ завізовано візою валютного контролю
  --  1 - віза валютного контролю відсутня на документі
  --  2 - віза валютного контролю наявна, але не є наступною у документі
  --  3 - віза валютного контролю наступна у документі
  --------------------------------------------------------------------------------
   function f_check_visa_status (p_ref in oper.ref%type) return number;

  -- create_contract - Створення контракту
  --
   procedure create_contract(p_contr_id out number, -- Системний номер контракту
                                                    p_contr_type in number, -- Тип контракту
                                                     p_rnk in number, -- Внутрішній номер (rnk) клієнта (резидента)
                                                     p_num in varchar2, -- Номер контракту
                                                     p_subnum in varchar2, -- Субномер контракту
                                                     p_s in number, -- Сума контракту
                                                     p_kv in number, -- Код валюти
                                                     p_benef_id in number, -- id нерезидента
                                                     p_open_date in date, -- Дата відкриття контракту
                                                     p_close_date in date := null, -- Дата закінчення контракту
                                                     p_comments in varchar2 := null, -- Деталі контракту
                                                     p_bank_change varchar2 := null, --Інформація про перехід з іншого банку
                                                     p_bic in varchar2 := null, -- BIC-код банку нерезидента
                                                     p_b010 in varchar2 := null, -- Код B010 банку нерезидента
                                                     p_service_branch in varchar2 := null, --Установа, відповідальна за прийом первинних документів
                                                     --------Параметри торгового контракту------------------------------------
                                                     p_spec_id in number := null, -- Спеціалізація контракту
                                                     p_subject_id in number := null, -- Предмет контракту
                                                     p_without_acts in number :=null, -- Робота без актів цінової експертизи
                                                     p_deadline in number := null, -- Контрольний строк
                                                     p_txt_subject in varchar2 := null, -- Уточнення предмету контракту
                                                     -------Параметри кредитного контракту----------------------------------
                                                     p_percent_nbu in number := null, -- Максимальна процентна ставка НБУ
                                                     --p_percent in number := null, --Процентна ставка (по замовчуванню)
                                                     p_s_limit in number := null, --Ліміт заборгованості
                                                     p_creditor_type in number := null, --Тип кредитора
                                                     p_credit_borrower in number := null, -- Вид позичальника
                                                     p_credit_type in number := null, --Тип кредиту
                                                     --p_credit_period in number := null, --Код періодичності погашення
                                                     p_credit_term in number := null, --Код строковості кредиту
                                                     --p_credit_method in number := null, --Метод нарахування відсотків
                                                     p_credit_prepay in number := null, --Можливість дострокового погашення
                                                     p_name in varchar2 := null, --Назва договору
                                                     p_add_agree in varchar2 := null, --Додаткові угоди
                                                     p_percent_nbu_type in number := null, --Назва максимальної процентної ставки НБУ
                                                     p_percent_nbu_info in varchar2 := null, --Додаткова інформація про максимальну процентну ставку НБУ
                                                     p_r_agree_date in date := null, --Дата реєстрації контракту (заповнюється при змінах)
                                                     p_r_agree_no in varchar2 := null, --Номер реєстрації контракту (заповнюється при змінах)
                                                     p_prev_doc_key in number := null, --Реєстраційний серверний номер (заповнюється при змінах)
                                                     p_prev_reestr_attr in varchar2 := null, -- Зміни до договору +
                                                     p_ending_date_indiv in date := null, --Кінцева дата індивідуального строку дії реєстрації контракту
                                                     p_parent_ch_data in varchar2 := null, --Інформація про короткостроковий контракт (заповнюється при перереєстрації з короткострокового у довгостроковий)
                                                     p_ending_date in date := null, --Строк дії реєстрації контракту (заповнюється при продовженні строку)
                                                     p_f503_reason in number := null, --Підстави подання звіту Ф503
                                                     p_f503_state in number := null, --Стан розрахунків за контрактом для звіту Ф503
                                                     p_f503_note in varchar2 := null, --Примітка звіту Ф503
                                                     p_f504_reason in number := null, --Підстави подання звіту Ф504
                                                     p_f504_note in varchar2 := null, --Примітка звіту Ф504
                                                     p_f503_percent_type in number := null, --Тип процентної ставки
                                                     p_f503_percent_base in varchar2 := null, --База процентної ставки (база)
                                                     p_f503_percent_margin in number := null, --Маржа процентної ставки
                                                     p_f503_percent in number := null, --Процентна ставка за основною сумою боргу
                                                     p_f503_purpose in number := null, --Ціль використання кредиту
                                                     p_f503_percent_base_t varchar2 :=null, --База процентної ставки (термін)
                                                     p_f503_change_info varchar2 :=null, --Інформація щодо внесення змін до договору
                                                     p_f503_percent_base_val varchar2 :=null, --База процентної ставки (валюта)
                                                     p_f057 char :=null --Вид запозичення,
                                                    );

  -- update_contract - Редагування контракту
  --
procedure update_contract                           (p_contr_id in number, -- id контракту
                                                     p_num in varchar2 := null, -- Номер контракту
                                                     p_subnum in varchar2 := null, -- Субномер контракту
                                                     p_s in number := null, -- Сума контракту
                                                     p_benef_id in number := null, -- id нерезидента
                                                     p_open_date in date := null, -- Дата відкриття контракту
                                                     p_close_date in date := null, -- Дата закінчення контракту
                                                     p_comments in varchar2 := null, -- Деталі контракту
                                                     p_bank_change varchar2 := null, --Інформація про перехід з іншого банку
                                                     p_bic in varchar2 := null, -- BIC-код банку нерезидента
                                                     p_b010 in varchar2 := null, -- Код B010 банку нерезидента
                                                     p_service_branch in varchar2 := null, --Установа, відповідальна за прийом первинних документів
                                                     --------Параметри торгового контракту------------------------------------
                                                     p_spec_id in number := null, -- Спеціалізація контракту
                                                     p_subject_id in number := null, -- Предмет контракту
                                                     p_without_acts in number :=null, -- Робота без актів цінової експертизи
                                                     p_deadline in number := null, -- Контрольний строк
                                                     p_txt_subject in varchar2 := null, -- Уточнення предмету контракту
                                                     -------Параметри кредитного контракту----------------------------------
                                                     p_percent_nbu in number := null, -- Максимальна процентна ставка НБУ
                                                     --p_percent in number := null, --Процентна ставка (по замовчуванню)
                                                     p_s_limit in number := null, --Ліміт заборгованості
                                                     p_creditor_type in number := null, --Тип кредитора
                                                     p_credit_borrower in number := null, -- Вид позичальника
                                                     p_credit_type in number := null, --Тип кредиту
                                                     --p_credit_period in number := null, --Код періодичності погашення
                                                     p_credit_term in number := null, --Код строковості кредиту
                                                     --p_credit_method in number := null, --Метод нарахування відсотків
                                                     p_credit_prepay in number := null, --Можливість дострокового погашення
                                                     p_name in varchar2 := null, --Назва договору
                                                     p_add_agree in varchar2 := null, --Додаткові угоди
                                                     p_percent_nbu_type in number := null, --Назва максимальної процентної ставки НБУ
                                                     p_percent_nbu_info in varchar2 := null, --Додаткова інформація про максимальну процентну ставку НБУ
                                                     p_r_agree_date in date := null, --Дата реєстрації контракту (заповнюється при змінах)
                                                     p_r_agree_no in varchar2 := null, --Номер реєстрації контракту (заповнюється при змінах)
                                                     p_prev_doc_key in number := null, --Реєстраційний серверний номер (заповнюється при змінах)
                                                     p_prev_reestr_attr in varchar2 := null, -- Зміни до договору +
                                                     p_ending_date_indiv in date := null, --Кінцева дата індивідуального строку дії реєстрації контракту
                                                     p_parent_ch_data in varchar2 := null, --Інформація про короткостроковий контракт (заповнюється при перереєстрації з короткострокового у довгостроковий)
                                                     p_ending_date in date := null, --Строк дії реєстрації контракту (заповнюється при продовженні строку)
                                                     p_f503_reason in number := null, --Підстави подання звіту Ф503
                                                     p_f503_state in number := null, --Стан розрахунків за контрактом для звіту Ф503
                                                     p_f503_note in varchar2 := null, --Примітка звіту Ф503
                                                     p_f504_reason in number := null, --Підстави подання звіту Ф504
                                                     p_f504_note in varchar2 := null, --Примітка звіту Ф504
                                                     p_f503_percent_type in number := null, --Тип процентної ставки
                                                     p_f503_percent_base in varchar2 := null, --База процентної ставки
                                                     p_f503_percent_margin in number := null, --Маржа процентної ставки
                                                     p_f503_percent in number := null, --Процентна ставка за основною сумою боргу
                                                     p_f503_purpose in number := null, --Ціль використання кредиту
                                                     p_f503_percent_base_t varchar2 :=null, --База процентної ставки (термін)
                                                     p_f503_change_info varchar2 :=null, --Інформація щодо внесення змін до договору
                                                     p_f503_percent_base_val varchar2 :=null, --База процентної ставки (валюта)
                                                     p_f057 char :=null --Вид запозичення,
                                                    );
  -- close_contract - Закриття (видалення) / відновлення контракту
  --
  procedure close_contract (p_contr_id in number/*id контракту*/);

  -- resurrect_contract - Відновлення контракту
  --
  procedure resurrect_contract (p_contr_id in number/*id контракту*/);

  -- change_contract_branch - Передача контракту у іншу установу
  --
  procedure change_contract_branch (p_contr_id in number,
                                    p_new_branch varchar2);

  -- nbu_registration - Формування XML - повідомлення для реєстрації у НБУ
  --
  function nbu_registration (p_contr_id in number,
                           p_agree_fname in varchar2 := null,
                           p_letter_fname in varchar2 := null,
                           p_old_mfo in number := null,
                           p_old_oblcode in number := null,
                           p_old_bank_code in varchar2 := null,
                           p_old_bank_oblcode in number := null,
                           p_prev_doc_key in number := null, --Реєстраційний серверний номер (заповнюється при змінах)
                           p_r_agree_date in date := null, --Дата реєстрації контракту (заповнюється при змінах)
                           p_r_agree_no in varchar2 := null --Номер реєстрації контракту (заповнюється при змінах)
                          ) return varchar2;
-- confirm_nbu_registration - Підтвердження реєстрації контракту у НБУ
--
procedure confirm_nbu_registration(p_contr_id in number, -- id контракту
                                   p_prev_doc_key in number, --Реєстраційний серверний номер
                                   p_r_agree_date in date, --Дата реєстрації контракту/змін
                                   p_r_agree_no in varchar2 --Номер реєстрації контракту/змін
                                  );

  -- cancel_nbu_registration - Відміна реєстрації контракту у НБУ
  --
  procedure cancel_nbu_registration(p_contr_id in number -- id контракту
                                 );
 --------------------------------------------------------------------------------
   -- create_beneficiary - Створення бенефиціара
   --
   procedure create_beneficiary (p_benef_name varchar2, -- Назва контрагента
                                 p_country_id number :=null, -- Код країни контрагента
                                 p_adr varchar2 :=null, -- Адреса контрагента
                                 p_comments varchar2 :=null  -- Коментар
                                );
 -------------------------------------------------------------------------------
   -- update_beneficiary - Редагування бенефиціара
   --
    procedure update_beneficiary (p_benef_id number, -- id контрагента
                                  p_benef_name varchar2 := null, -- Назва контрагента
                                  p_country_id number :=null, -- Код країни контрагента
                                  p_adr varchar2 :=null,  -- Адреса контрагента
                                  p_comments varchar2 :=null  -- Коментар
                                 );
 -------------------------------------------------------------------------------
   -- delete_ape - Видалення бенефиціара
   --
   procedure delete_beneficiary (p_benef_id number); -- id контрагента
-------------------------------------------------------------------------------
   -- create_credgraph_period - Створення періоду графіка кредитного контракту
   --
   procedure create_credgraph_period (p_contr_id number, -- ID контракту
                                      p_end_date date, -- Дата закінчення періоду
                                      p_cr_method number, -- Медтод погашення тіла
                                      p_payment_period number, -- Періодичність погашення тіла
                                      p_z number, -- Залишок тіла на кінець періоду
                                      p_adaptive number, --'Метод ліквідації відхилень погашення тіла кредиту
                                      p_percent number, -- Процентна ставка
                                      p_percent_nbu number, -- Процентна ставка НБУ
                                      p_percent_base number, -- База нарахування відсотків
                                      p_percent_period number, -- Періодичність погашення відсотків
                                      p_payment_delay number,-- Затримка оплати тіла
                                      p_percent_delay number,-- Затримка оплати відсотків
                                      p_get_day number, -- Врахування дня видачі кредиту при нарахуванні відсотків
                                      p_pay_day number, -- Врахування дня погашення кредиту при нарахуванні відсотків
                                      p_payment_day number, -- Дата погашення тіла
                                      p_percent_day number -- Дата погашення відсотків
                                      --p_holiday number -- Врахування вихідних при побудові графіка
                                     );
-------------------------------------------------------------------------------
   -- update_credgraph_period- Редагування періоду графіка кредитного контракту
   --
    procedure update_credgraph_period (p_contr_id number, -- ID контракту
                                       p_row_id rowid, -- ID рядка
                                       p_end_date date :=null, -- Дата закінчення періоду
                                       p_cr_method number :=null, -- Медтод погашення тіла
                                       p_payment_period number :=null, -- Періодичність погашення тіла
                                       p_z number :=null, -- Залишок тіла на кінець періоду
                                       p_adaptive number :=null, --'Метод ліквідації відхилень погашення тіла кредиту
                                       p_percent number :=null, -- Процентна ставка
                                       p_percent_nbu number :=null, -- Процентна ставка НБУ
                                       p_percent_base number :=null, -- База нарахування відсотків
                                       p_percent_period number :=null, -- Періодичність погашення відсотків
                                       p_payment_delay number :=null,-- Затримка оплати тіла
                                       p_percent_delay number :=null,-- Затримка оплати відсотків
                                       p_get_day number :=null, -- Врахування дня видачі кредиту при нарахуванні відсотків
                                       p_pay_day number :=null, -- Врахування дня погашення кредиту при нарахуванні відсотків
                                       p_payment_day number, -- Дата погашення тіла
                                       p_percent_day number -- Дата погашення відсотків
                                       --p_holiday number :=null -- Врахування вихідних при побудові графіка
                                      );
-------------------------------------------------------------------------------
   -- delete_credgraph_period - Видалення періоду графіка кредитного контракту
   --
   procedure delete_credgraph_period (p_contr_id number, -- ID контракту
                                      p_row_id rowid -- ID рядка
                                     );
--------------------------------------------------------------------------------
   -- create_credgraph_payment - Створення неперіодичного платежа графіка кредитного контракту
   --
   procedure create_credgraph_payment (p_contr_id number, -- ID контракту
                                       p_dat date, -- Дата платежа
                                       p_s number, -- Сума платежа
                                       p_pay_flag number -- Класифікатор платежа
                                      );
-------------------------------------------------------------------------------
   -- update_credgraph_payment- Редагування неперіодичного платежа графіка кредитного контракту
   --
    procedure update_credgraph_payment (p_contr_id number, -- ID контракту
                                        p_row_id rowid, -- ID рядка
                                        p_dat date, -- Дата платежа
                                        p_s number, -- Сума платежа
                                        p_pay_flag number -- Класифікатор платежа
                                       );
-------------------------------------------------------------------------------
   -- delete_credgraph_period - Видалення неперіодичного платежа графіка кредитного контракту
   --
   procedure delete_credgraph_payment (p_contr_id number, -- ID контракту
                                       p_row_id rowid -- ID рядка
                                      );
-- create_credgraph - Формування графіка по кредиту
--
procedure create_credgraph(p_contr_id in number); -- id контракту

-- get_credcontract_info - Одержання інформації по кредитному контракту
--
procedure get_credcontract_info (p_contr_id in number, --id контракту
                                 p_date in date, --дата надання інформації
                                 p_percent out number, -- Нараховані відсотки
                                 p_percent_nbu out number, -- Нараховані відсотки НБУ
                                 p_percent_over out number, -- Прострочені відсотки
                                 p_credit_over out number -- Прострочена заборгованість по тілу
                                );

-- bound_payment- Прив'язка платежу до контракту
--
function bound_payment(p_payment_type in number, -- Тип платежу
                        p_pay_flag in number, -- 0 - основний платіж, 1 - платіж, що не впливає на суму контракту
                        p_direct in number, -- Тип платежу (0 - вхідні, 1 - вихідні)
                        p_ref in number, -- Референс документу
                        p_contr_id in number, -- Ідентифікатор контракту
                        p_s_vp in number, -- Сума прив'язки у валюты платежу
                        p_comiss in number, -- Комісія
                        p_rate in number, -- Курс
                        p_s_vc in number, -- Сума прив'язки у валюті платежу
                        p_top_id in number, -- Тип операції
                        p_comments in varchar2 :=null,-- Коментар
                        p_subject in number := null, -- Предмет оплати (1 - товари, 2 - послуги)
                        p_service_code in varchar2 :=null, -- Код класифікатора послуг
                        ----------------------------------------------------------------------
                        p_kv in number :=null, -- Код валюти платежу
                        --p_bank_date in date :=null, --  Банківська дата створення
                        p_val_date in date :=null, -- Дата валютування
                        p_details in varchar2 :=null, -- Призначення платежу
                        ----------------------------------------------------------------------
                        p_rnk in number :=null, -- RNK  резидента
                        p_benef_id in number :=null, -- id нерезидента
                        p_c_num varchar2 :=null,
                        p_c_date date :=null
                       ) return number;

procedure unbound_payment(p_payment_type in number, -- Тип платежу
                          p_bound_id in number, -- id зв`язку
                          p_comments in varchar2 -- Коментар
                         );

-- beck_payment - видалення висячого неприв'язаного документу
--
procedure back_payment (p_doc_type in number, p_doc_id in number);

-- bound_vmd- Прив'язка ВМД до контракту
--
function bound_vmd(p_vmd_type in number, -- Тип ВМД
                   p_ref in number, -- Референс ВМД
                   p_contr_id in number, -- Ідентифікатор контракту
                   p_s_vt in number, -- Сума прив'язки у валюті товару
                   p_rate in number :=null, -- Курс
                   p_s_vc in number :=null, -- Сума прив'язки у валюті контракту
                   p_doc_date in date :=null, -- Дата паперового носія
                   p_comments in varchar2 :=null,-- Коментар
                   ---------------------------------------------------------------------
                   p_num varchar2 :=null, --номер акта
                   p_kv in number :=null, -- Код валюти товару
                   p_allow_date in date :=null, -- Дата дозволу
                   ----------------------------------------------------------------------
                   p_rnk in number :=null, -- RNK  резидента
                   p_benef_id in number :=null, -- id нерезидента
                   p_c_num varchar2 :=null, --Номер контракту
                   p_c_date date :=null, --Дата контракту
                   p_file_name varchar2 :=null, -- Назва файлу реєстру
                   p_file_date date :=null --Дата файлу реєстру
                  ) return number;

-- autobound_vmd- Автоприв`язка ВМД до контракту
--

procedure autobound_vmd (p_cim_id in number,
                         p_dat in date,
                         p_sdate in date,
                         p_s_okpo in varchar2,
                         p_r_okpo in varchar2,
                         p_f_okpo in varchar2,
                         p_doc in varchar2,
                         p_kv number,
                         p_s in number,
                         p_kurs number
                        );

-- process_all_vmd- Автоприв`язка усіх вільних ВМД до контрактів
--
procedure process_all_vmd(p_begin_date in date :=null,
                          p_end_date in date :=null,
                          p_okpo in varchar2 :=null
                         );

-- unbound_vmd- Відв'язка ВМД від контракту
--
procedure unbound_vmd(p_vmd_type in number, -- Тип платежу
                      p_bound_id in number, -- id зв`язку
                      p_comments in varchar2 -- Коментар
                     );

-- vmd_link - Зв'язок платежу з ВМД
--
procedure vmd_link(p_payment_type in number, --тип платежу
                   p_payment_id in number, --id платежу
                   p_vmd_type in number, --тип ВМД
                   p_vmd_id in number, --id ВМД
                   p_s in number -- Сума
                  );

-- vmd_unlink - Відв'язка платежу від ВМД
--
procedure vmd_unlink(p_payment_type in number, --тип платежу
                   p_payment_id in number, --id платежу
                   p_vmd_type in number, --тип ВМД
                   p_vmd_id in number, --id ВМД
                   p_comments in varchar2 :=null --Коментар
                  );

--------------------------------------------------------------------------------
-- delete_act - Видалення актів
--
procedure delete_act(p_act_id number);

-- get_link_sum - Сума Зв'язку платежу з ВМД
--
function get_link_sum (p_payment_type in number, --тип платежу
                       p_payment_id in number, --id платежу
                       p_vmd_type in number, --тип ВМД
                       p_vmd_id in number --id ВМД
                      ) return number;

-- update_comment - Редагувати коментар
--
procedure update_comment(p_doc_kind in number, --0 - платіж, 1 - ВМД
                         p_doc_type in number, --id типу
                         p_bound_id in number, -- Id прив'язки
                         p_str_level in number, -- id лінка
                         p_comments in varchar2 -- Коментар
                        );

-- delete_from_journal - Видалення запису з журналу
--
procedure delete_from_journal(p_doc_kind in number, --0 - платіж, 1 - ВМД, 2 - лінк
                              p_doc_type in number, --id типу
                              p_bound_id in number -- Id прив'язки
                             );

-- check_bound- Перевірка прив'язки платежу до контракту
--
function check_bound(p_doc_kind in number, --вид документу (0 - платіж, 1 - МД)
                     p_payment_type in number, -- Тип платежу
                     p_pay_flag in number, -- Класифікатор платежу (0 ..6)
                     p_direct in number, -- Напрям платежу (0 - вхідні, 1 - вихідні)
                     p_ref in number, -- Референс документу
                     p_contr_id in number, -- Ідентифікатор контракту
                     p_s_vp in number, -- Сума прив'язки у валюті платежу
                     p_comiss in number, -- Комісія
                     p_rate in number, -- Курс
                     p_s_vc in number, -- Сума прив'язки у валюті контракту
                     p_val_date in date, -- Дата валютування
                     p_subject in number := null, -- Предмет оплати (0 - товари, 1 - послуги)
                     p_service_code in varchar2 :=null -- Код класифікатора послуг
                    ) return varchar2;

-- get_control_date - Розрахунок контрольної дати
--
function get_control_date(p_doc_kind in number, --id висновку
                          p_doc_type in number, --тип документу
                          p_doc_id in number, --id документу
                          p_pay_flag in number default null -- для оптимізації при виклику з cim_reports
                         ) return date;

--------------------------------------------------------------------------------
   -- create_conclusion - Створення висновку
   --
procedure create_conclusion (p_contr_id number, -- id контракту
                             p_org_id number, -- id органу, який дав висновок
                             p_out_num varchar2, -- Вихідний номер висньовку
                             p_out_date date, -- Вихідна дата висньовку
                             p_kv number, --Код валюти
                             p_s number, --Сума
                             p_begin_date date, --Початок строку
                             p_end_date date --Кінець строку
                            );

-------------------------------------------------------------------------------
   -- update_conclusion- Редагування висновку
   --
procedure update_conclusion (p_conclusion_id number, -- id висновку
                             p_org_id number, -- id органу, який дав висновок
                             p_out_num varchar2, -- Вихідний номер висньовку
                             p_out_date date, -- Вихідна дата висньовку
                             p_kv number, --Код валюти
                             p_s number, --Сума
                             p_begin_date date, --Початок строку
                             p_end_date date --Кінець строку
                            );

-------------------------------------------------------------------------------
   -- delete_conclusion - Видалення висновку
   --
   procedure delete_conclusion (p_conclusion_id number); -- id висновку

--------------------------------------------------------------------------------
-- conclusion_link - Зв'язок Висновку з первинним документом
--
procedure conclusion_link(p_cnc_id in number, --id висновку
                          p_doc_type in number, --тип документу
                          p_doc_id in number, --id документу
                          p_s in number -- Сума
                         );

--------------------------------------------------------------------------------
-- conclusion_unlink - Відв'язка Висновку выд первинного документу
--
procedure conclusion_unlink(p_cnc_id in number, --id висновку
                            p_doc_type in number, --тип документу
                            p_doc_id in number --id документу
                           );

-- get_cnc_link_sum - Сума Зв'язку виксновку з документом
--
function get_cnc_link_sum (p_cnc_id in number, --id висновку
                           p_doc_type in number, --тип документу
                           p_doc_id in number --id документу
                          ) return number;

--------------------------------------------------------------------------------
-- check_contract_sanction - Перевырка накладення санкції
--
function check_contract_sanction(p_contr_id in number, --id контракту
                                 p_date in date :=bankdate, --Дата перевірки
                                 p_okpo out varchar2, --ОКПО резидента
                                 p_benef_name out varchar2 --Назва нерезилента
                                ) return number;
--------------------------------------------------------------------------------
-- journal_numbering - Нумерування нових рядків журналу
--
procedure journal_numbering;

procedure check_unheld_que;

-- change_reg_date - Зміна дати реєстрації документа у журналі
--
function change_reg_date (p_contr_type in number, --Тип контракту
                          p_doc_kind in number, -- Вид документу (0 - платіж, 1 - МД/Акт)
                          p_doc_type in number, -- Тип документу
                          p_doc_id in number, -- id документу
                          p_date in date -- Нова дата реєстрації
                         ) return varchar2;

-- change_link_date - Зміна дати лінкування
--
function change_link_date (p_payment_type in number, --Тип платежа
                           p_payment_id in number, -- bound_id платежа
                           p_vmd_type in number, -- Тип ВМД
                           p_vmd_id in number, -- bound_id ВМД
                           p_date in date -- Нова дата реєстрації
                          ) return varchar2;

function val_convert(p_dat in date , -- Дата конмертації
                     p_s in number, -- Конвертована сума
                     p_kv_a in number, -- Код валюти А
                     p_kv_b in number default 980 -- Код валюти Б
                    ) return number;

END cim_mgr;
/
CREATE OR REPLACE PACKAGE BODY cim_mgr
is
   --
   --  CIM_MGR
   --  Currency Inspection Module - Модуль валютного контролю
   --

   g_body_version      constant varchar2 (64) := 'version 1.01.09 26/09/2018';
   g_awk_body_defs     constant varchar2 (512) := '';

   --------------------------------------------------------------------------------
   -- Глобальні змінні
   --
   g_module_name       constant varchar2(3) := 'CIM';
   g_trace_module      constant varchar2(8) := 'cim_mgr.';

   -- маска формату для перетворення char <--> date
   g_date_format       constant varchar2(10)  := 'dd.mm.yyyy';
   g_datetime_format   constant varchar2(30)  := 'dd.mm.yyyy HH24:MI:SS';
   -- ідентифіктор параметру для номеру візи
   g_par_visaid        constant varchar2(7) := 'VISA_ID';
   -- ідентифікатор дод. реквізиту для виду операції (код з довідника cim_operation_types)
   g_opertype_tag       constant varchar2(5) := 'CIMTO';
   -- вибраний пов'язаний документ (вмкористовується на формі стан контракту)
   g_selected_doc number :=0;
   -- id візивалютного контролю
   g_visa_id chklist.idchk%type := 7;
   g_visa_id_hex chklist.idchk_hex%type := '07';
   g_alert_term number :=14;
   g_create_borg_message number := 0;
   g_root_branch varchar2(8);
   --------------------------------------------------------------------------------
   -- header_version - повертає версію заголовка пакету
   --
   function header_version return varchar2
   is
   begin
      return    'Package header CIM_MGR '
             || g_header_version
             || '.'
             || CHR (10)
             || 'AWK definition: '
             || CHR (10)
             || g_awk_header_defs;
   end header_version;

   --------------------------------------------------------------------------------
   -- body_version - повертає версію тіла пакету
   --
   function body_version return varchar2
   is
   begin
      return    'Package body CIM_MGR '
             || g_body_version
             || '.'
             || CHR (10)
             || 'AWK definition: '
             || CHR (10)
             || g_awk_body_defs;
   end body_version;

   --------------------------------------------------------------------------------
   -- body_version - конвертор для формування WEB-посилань
   --
   FUNCTION form_url_encode ( data IN VARCHAR2) RETURN VARCHAR2
   is
   BEGIN
     RETURN utl_url.escape(data, TRUE, 'UTF-8'--'ISO-8859-1'
                          ); -- note use of TRUE
   END form_url_encode;

--------------------------------------------------------------------------------
   -- get_address - Адреса клієнта
   --
   -- @p_rnk - RNK клієнта

   function get_address (p_rnk in number) return varchar2
   is
     l_adr varchar2(4000);
     l_nn number;
   begin
      select count(*) into l_nn from customer_address where type_id=1 and rnk=p_rnk;
      if l_nn>0 then
        select nvl2(zip, zip || ', ', '') || case when upper(domain) like '%МІСТО%' and upper(domain) like '%'||upper(locality)||'%' then '' else nvl2(domain, domain || ', ', '') end ||
               case when upper(region) like '%МІСТО%' and upper(region) like '%'||upper(locality)||'%' then '' else nvl2(region, region || ', ', '') end ||
               nvl2(locality, locality || ', ', '') || address  into l_adr
          from customer_address where type_id=1 and rnk=p_rnk;
      else
        select adr into l_adr from customer where rnk=p_rnk;
      end if;
     return l_adr;
   end get_address;


  --------------------------------------------------------------------------------
   -- check_visa_condition - перевірка умови необхідності візування документу візою валютного контролю
   --
   -- @p_dk - дебет\кредит документу
   -- @p_kv - валюта документу
   -- @p_nlsa - рахунок А документу
   -- @p_nlsb - рахунок Б документу
   --

   function check_visa_condition(p_dk in number, p_kv in number, p_nlsa in varchar2, p_nlsb in varchar2,
                                 p_tt in varchar2 := null, p_ref in number := null) return number
                                                                    -- 0 - вхідні, 1 - вихідні, 2 - в обробці, null - віза не потрібна
   is
   begin
     return f_cim_visa_condition(p_dk, p_kv, p_nlsa, p_nlsb, p_tt, p_ref);
   end check_visa_condition;

   --------------------------------------------------------------------------------
   -- check_visa_condition_by_ref - перевірка умови необхідності візування документу візою валютного контролю (по реф. документа)
   --
   -- @p_ref - референс документу
   --

   function check_visa_condition_by_ref(p_ref in number) return number
   is
       l_res number;
       l_doc oper%rowtype;
   begin
       select * into l_doc from oper where ref = p_ref;
     return check_visa_condition(l_doc.dk, l_doc.kv, l_doc.nlsa, l_doc.nlsb);
   end;

  --------------------------------------------------------------------------------
   -- get_payments_bound_sum - сума усіх привязних платежів по реальному документу
   --
   -- @p_ref - референс документу
   --
   function get_payments_bound_sum(p_ref in number) return number
   is
       l_sum number;
   begin
     select nvl(sum(s),0) into l_sum from cim_payments_bound where contr_id is not null and delete_date is null and ref=p_ref;
     return l_sum;
   end;

   --------------------------------------------------------------------------------
   -- get_payment_oper_type - тип операції із дод. реквізиту документа
   --
   -- @p_ref - референс документу
   --
   function get_payment_oper_type(p_ref in number) return varchar2
   is
    l_type_name cim_operation_types.type_name%type;
   begin
      select type_name into l_type_name from cim_operation_types
      where type_id = (select to_number (value)
                       from operw
                       where ref = p_ref and tag = g_opertype_tag
            );
      return l_type_name;
      exception
         when others then return null;
   end;

--------------------------------------------------------------------------------
   -- check_contract_status - Статус контрагента
   --

procedure check_contract_status(p_contr_id in number /*id контракту*/)

is
  l_type number;
  l_status number;
  l_old_status number;
  l_branch varchar2(30);
  l_rnk number;
  l_dog_num varchar2(60);
  l_open_date date;
  l_close_date date;
  l_n number;
  l_s_pl number;
  l_s_vmd number;
begin
  if p_contr_id !=0 then
    select status_id, contr_type, branch,   rnk,   num,       open_date,   close_date
      into l_old_status,  l_type,     l_branch, l_rnk, l_dog_num, l_open_date, l_close_date
      from cim_contracts where contr_id=p_contr_id and (kf = sys_context('bars_context','user_mfo') or sys_context('bars_context','user_mfo') is null);
    if l_type<2  and l_old_status != 1 and l_old_status<9 then
      l_s_pl:=0; l_s_vmd:=0; l_status:=0;
      if l_type = 1 then
        for l in (select * from v_cim_trade_payments where zs_vk>0 and contr_id=p_contr_id) loop
          if bankdate>l.control_date then
            if g_create_borg_message = 1 then
              select count(*) into l_n from cim_borg_message
                where doc_kind=0 and doc_type=l.type_id and bound_id=l.bound_id and control_date=l.control_date;
              if l_n=0 then
                insert into cim_borg_message (branch, rnk, nom_dog, date_dog, date_plat, doc_kind, doc_type, bound_id, control_date)
                  values (l_branch, l_rnk, l_dog_num, l_open_date, l.vdat, 0, l.type_id, l.bound_id, l.control_date);
              end if;
            end if;
            l_status:=4;
          elsif l_status != 4 and (trunc(l.control_date)-bankdate)<g_alert_term then l_status:=5;
          elsif l_status != 4 and l_status != 5 and l_close_date is not null and l.vdat>l_close_date then l_status:=6;
          else
            l_s_pl:=l_s_pl+l.zs_vk;
          end if;
        end loop;
        select sum(z_vk) into l_s_vmd from v_cim_bound_vmd where contr_id=p_contr_id;
      elsif l_type = 0 then
        for l in (select * from v_cim_bound_vmd where z_vk>0 and contr_id=p_contr_id) loop
          if bankdate>l.control_date then
            if g_create_borg_message = 1 then
              select count(*) into l_n from cim_borg_message
                where doc_kind=1 and doc_type=l.type_id and bound_id=l.bound_id and control_date=l.control_date;
              if l_n=0 then
                insert into cim_borg_message (branch, rnk, nom_dog, date_dog, date_plat, doc_kind, doc_type, bound_id, control_date)
                  values (l_branch, l_rnk, l_dog_num, l_open_date, nvl(l.allow_date,l.doc_date), 1, l.type_id, l.bound_id, l.control_date);
              end if;
            end if;
            l_status:=4;
          elsif l_status != 4 and (trunc(l.control_date)-bankdate)<g_alert_term then l_status:=5;
          elsif l_status != 4 and l_status != 5 and l_close_date is not null and  nvl(l.allow_date,l.doc_date)>l_close_date then l_status:=6;
          else
            l_s_vmd:=l_s_vmd+l.z_vk;
          end if;
        end loop;
        select sum(zs_vk) into l_s_pl from v_cim_trade_payments where contr_id=p_contr_id;
      end if;
      if l_status != 4 and l_status != 5 and l_status != 6 then
        if l_s_pl=0 and l_s_vmd=0 then l_status:=8; else l_status:=0; end if;
      end if;
      if l_old_status != l_status then
        update cim_contracts set status_id=l_status where contr_id=p_contr_id;
      end if;
    end if;
  end if;
end check_contract_status;

   --------------------------------------------------------------------------------
   -- create_license - Створення ліцензії мінекономіки
   --
   procedure create_license (p_okpo varchar2, -- ОКПО резидента
                             p_num varchar2, -- Номер ліцензії
                             p_type number, -- Тип ліцензії
                             p_kv number, -- Код валюти
                             p_s number, -- Сума
                             p_begin_date date, -- Дата ліцензії
                             p_end_date date, -- Дата, до якої дійсна ліцензія
                             p_comments varchar2 -- Примітка
                            )
   is
   begin
     insert into cim_license(okpo, num, type, kv, s, begin_date, end_date, comments)
       values (p_okpo, p_num, p_type, p_kv, p_s*100, p_begin_date, p_end_date, p_comments);
   end;

-------------------------------------------------------------------------------
   -- delete_license  - Видалення ліцензії мінекономіки
   --
   procedure delete_license (p_license_id number) -- id ліцензії мінекономіки
   is
     l_n number;
   begin
     select count(*) into l_n from cim_license_link where delete_date is null and license_id=p_license_id;
     if l_n>0 then bars_error.raise_error(g_module_name, 95); end if;
     update cim_license set delete_date=bankdate, delete_uid=user_id where license_id=p_license_id;
   end;
-------------------------------------------------------------------------------
   -- update_license - Редагування ліцензії мінекономіки
   --
    procedure update_license (p_license_id number, -- id акту цінової експертизи
                              p_num varchar2, -- Номер ліцензії
                              p_type number, -- Тип ліцензії
                              p_kv number, -- Код валюти
                              p_s number, -- Сума
                              p_begin_date date, -- Дата ліцензії
                              p_end_date date, -- Дата, до якої дійсна ліцензія
                              p_comments varchar2 -- Примітка
                             )
   is
     l_n number;
     l_okpo varchar2(14 byte);
     l_num varchar2(16 byte);
     l_type number;
     l_kv number;
     l_s number;
     l_begin_date date;
     l_end_date date;
     l_comments varchar2(64 byte);
   begin
     select max(okpo), max(num), max(type), max(kv), max(s), max(begin_date), max(end_date), max(comments)
         into l_okpo, l_num, l_type, l_kv, l_s, l_begin_date, l_end_date, l_comments
         from cim_license where license_id=p_license_id;
     if l_num!=p_num or l_type!=p_type or l_kv!=p_kv or l_s!=p_s or l_begin_date!=p_begin_date or l_end_date!=p_end_date or
        l_comments!=p_comments then
       insert into cim_license (okpo, num, type, kv, s, begin_date, end_date, comments)
           values (l_okpo, p_num, p_type, p_kv, p_s*100, p_begin_date, p_end_date, p_comments);
       update cim_license set delete_date=bankdate where license_id=p_license_id;
     end if;
   end;


-- license_link - Зв'язок ліцензії з первинним документом
--
procedure license_link(p_license_id in number, --id ліцензії
                       p_doc_type in number, --тип документу
                       p_doc_id in number, --id документу
                       p_s in number, -- Сума зв`язку
                       p_kv in number :=null, --Код валюти
                       p_s_pl in number :=null -- Сума платежу
                      )
is
  l_n number;
  l_l_kv number;
  l_l_s number;
  l_l_okpo varchar2 (14 byte);

  l_ref number;
  l_direct number;
  l_b_kv number;
  l_b_s number;

  l_ds number;
  log_txt varchar2(1024);
begin
  select count(*), max(okpo), max(kv), max(s) into l_n, l_l_okpo, l_l_kv, l_l_s from cim_license
    where delete_date is null and license_id=p_license_id;
  if l_n !=1 then bars_error.raise_error(g_module_name, 90); end if;
  if p_doc_id is not null and p_doc_type is not null then
    if p_doc_type=0 then
      select max(ref), max(s), max(direct) into l_ref, l_b_s, l_direct from cim_payments_bound where bound_id=p_doc_id;
      select max(kv) into l_b_kv from oper where ref=l_ref;
      select nvl(sum(s),0) into l_ds from cim_license_link where delete_date is null and payment_id=p_doc_id;
    else
      select max(bound_id), max(s), max(direct) into l_ref, l_b_s, l_direct from cim_fantoms_bound where bound_id=p_doc_id;
      select max(kv) into l_b_kv from cim_fantom_payments where fantom_id=l_ref;
      select nvl(sum(s),0) into l_ds from cim_license_link where delete_date is null and fantom_id=p_doc_id;
    end if;
  else
    l_b_kv:=p_kv; l_b_s:=p_s_pl*100; l_ds:=0; l_direct:=1;
  end if;
  if l_direct != 1 then bars_error.raise_error(g_module_name, 91); end if;
  if l_b_kv != l_l_kv then bars_error.raise_error(g_module_name, 92); end if;
  if l_b_s<l_ds+p_s*100 then bars_error.raise_error(g_module_name, 93); end if;
  select sum(s) into l_ds from cim_license_link where delete_date is null and license_id=p_license_id;
  if l_l_s<l_ds+p_s*100 then bars_error.raise_error(g_module_name, 94); end if;
  insert into cim_license_link (payment_id, fantom_id, license_id, okpo, s, create_date, create_uid)
    values (decode(p_doc_type, 0, p_doc_id, null), decode(p_doc_type, 0, null, p_doc_id), p_license_id,
            l_l_okpo, p_s*100, bankdate, user_id);
  bars_audit.info(g_module_name||' Прив`язка ліцензії. license_id: '||p_license_id||' payment_type:'||p_doc_type||
                  case when p_doc_id is null then ' kv:'||p_kv||' s_pl:'||p_s_pl else ' payment_id:'||p_doc_id end);
end license_link;

-- clear_null_license - Видалення рив'язок ліцензій без id платежа
--
procedure clear_null_license (p_okpo in varchar2 --ОКПО
                             )
is
begin
  delete from cim_license_link where payment_id is null and fantom_id is null and okpo=p_okpo;
end clear_null_license;

-- license_unlink - Відв'язка ліцензії від платежу
--
procedure license_unlink(p_license_id in number, --id ліцензії
                         p_doc_type in number, --тип платежу
                         p_doc_id in number --id платежу
                        )
is
begin
  update cim_license_link set delete_date=bankdate, delete_uid=user_id
    where delete_date is null and
          (p_doc_id!=-1 and decode(p_doc_type, 0, payment_id, fantom_id)=p_doc_id or
          p_doc_id=-1 and payment_id is null and fantom_id is null) and
          license_id=p_license_id;
  bars_audit.info(g_module_name||' Відв`язка ліцензії. license_id: '||p_license_id||' payment_type:'||p_doc_type||' payment_id:'||p_doc_id);
end license_unlink;

-- get_license_link_sum - Сума зв'язку ліцензії з платежем
--
function get_license_link_sum (p_license_id in number, --id ліцензії
                               p_doc_type in number, --тип платежу
                               p_doc_id in number --id платежу
                              ) return number
is
  l_s number;
begin
  if p_license_id is null and p_doc_id is null then return 0; end if;
  select sum(s) into l_s from cim_license_link
    where delete_date is null and license_id=p_license_id and
          (p_doc_id!=-1 and decode(p_doc_type, 0, payment_id, fantom_id)=p_doc_id or
           p_doc_id=-1 and payment_id is null and fantom_id is null);
  return round(nvl(l_s,0)/100,2);
end get_license_link_sum;

--------------------------------------------------------------------------------
   -- set_selected_doc - встановленняid вибраного пов'язаного документа (використовуэться на формы стан контракту)
   --
   -- @p_ref - референс документу
   --
   procedure set_selected_doc (p_ref number)
   is
   begin
     g_selected_doc:=p_ref;
   end;
   -- get_selected_doc - вибірка id вибраного пов'язаного документа (використовуэться на формы стан контракту)
   --
   function get_selected_doc return number
   is
   begin
      return g_selected_doc;
   end get_selected_doc;
  -- get_visa_id - вибірка id візи валютного контролю
  --
   function get_visa_id return number
   is
   begin
      return g_visa_id;
   end get_visa_id;
  -- get_visa_status - Стан візи документа
  --  xxx 0 - документ завізовано візою валютного контролю xxx
  --  1 - віза валютного контролю відсутня на документі
  --  2 - віза валютного контролю наявна, але не є наступною у документі
  --  3 - віза валютного контролю наступна у документі
  --
   function get_visa_status (p_tt in oper.tt%type, p_nextvisagrp in oper.nextvisagrp%type ) return number
   is
     l_n number;
   begin
     select count(*) into l_n from chklist_tts where idchk=g_visa_id and tt=p_tt;
     if l_n!=1 then return 1;
     else
       if p_nextvisagrp=g_visa_id_hex then return 3; else return 2; end if;
     end if;
   end get_visa_status;

  -------------------------------------------------------------------------------
   -- check_visa_status - Перевірка стан віз по документу
   --
   -- @p_ref - референс докумету
   -- @p_code OUT - код
   --        0 - вже завізовано візою вал.контролю
   --        1 - віза відсутня у маршруті візування
   --

   -- @p_msg  OUT - текст повідомлення
   procedure check_visa_status (p_ref in oper.ref%type, p_code out number,  p_msg out varchar2)
   is
     l_status number;
     l_flag number;
     l_tt oper.tt%type;
     l_chk_name chklist.name%type;
     l_sos number;
   begin
     select o.tt, o.sos, cim_mgr.get_visa_status(tt, nextvisagrp), (select name from chklist where idchk_hex=o.nextvisagrp),
            (select count(*) from oper_visa where ref=o.ref and passive is null and status in (1, 2, 3) and groupid=g_visa_id )
        into l_tt, l_sos, l_status, l_chk_name, l_flag
        from oper o where ref=p_ref;
     p_code := l_status;
     -- вже завізований (перевіряємо тільки по факту по oper_visa, поточний маршрут візування в chklist_tts вже міг змінитися)
     if l_flag > 0 then
        p_msg := 'Документ ref='||p_ref||' вже завізований візою валютного контролю (код '||g_visa_id||').';
        p_code := 0;
        -- виходимо, інші перевірки неважливі
        return;
     end if;
     if l_sos=5 then
        p_msg := 'Документ ref='||p_ref||' вже проведено.';
        p_code := 0;
        -- виходимо, інші перевірки неважливі
        return;
        elsif l_sos < 0 then
          p_msg := 'Документ ref='||p_ref||' сторновано.';
          p_code := 0;
          -- виходимо, інші перевірки неважливі
        return;
     end if;
     -- віза відсутня у маршртуті візування
     if l_status = 1 then
        p_msg := 'Віза валютного контролю (код '||g_visa_id||') не передбачена для операції '||l_tt||' (документ ref='||p_ref||').\nПотрібно доналаштувати маршрут візування.';
     elsif l_status = 2 then
        p_msg := 'Документ наразі очікує візу ['||l_chk_name||']. Візування поки неможливе.';
     elsif l_status = 3 then
        p_msg := null;
     end if;
   end check_visa_status;

  -- f_check_visa_status - Стан візи документа
  --  0 - документ завізовано візою валютного контролю
  --  1 - віза валютного контролю відсутня на документі
  --  2 - віза валютного контролю наявна, але не є наступною у документі
  --  3 - віза валютного контролю наступна у документі
  --------------------------------------------------------------------------------
   function f_check_visa_status (p_ref in oper.ref%type) return number
   is
     l_n number;
     l_txt varchar2(4000);
   begin
     check_visa_status(p_ref,l_n, l_txt); return l_n;
   end f_check_visa_status;

  -- create_contract - Створення контракту
  --
   procedure create_contract(p_contr_id out number, -- Системний номер контракту
                                                    p_contr_type in number, -- Тип контракту
                                                     p_rnk in number, -- Внутрішній номер (rnk) клієнта (резидента)
                                                     p_num in varchar2, -- Номер контракту
                                                     p_subnum in varchar2, -- Субномер контракту
                                                     p_s in number, -- Сума контракту
                                                     p_kv in number, -- Код валюти
                                                     p_benef_id in number, -- id нерезидента
                                                     p_open_date in date, -- Дата відкриття контракту
                                                     p_close_date in date := null, -- Дата закінчення контракту
                                                     p_comments in varchar2 := null, -- Деталі контракту
                                                     ------
                                                     p_bank_change varchar2 := null, --Інформація про перехід з іншого банку
                                                     ------
                                                     p_bic in varchar2 := null, -- BIC-код банку нерезидента
                                                     p_b010 in varchar2 := null, -- Код B010 банку нерезидента
                                                     p_service_branch in varchar2 := null, --Установа, відповідальна за прийом первинних документів
                                                     --------Параметри торгового контракту------------------------------------
                                                     p_spec_id in number := null, -- Спеціалізація контракту
                                                     p_subject_id in number := null, -- Предмет контракту
                                                     p_without_acts in number :=null, -- Робота без актів цінової експертизи
                                                     p_deadline in number := null, -- Контрольний строк
                                                     p_txt_subject in varchar2 := null, -- Уточнення предмету контракту
                                                     -------Параметри кредитного контракту----------------------------------
                                                     p_percent_nbu in number := null, -- Максимальна процентна ставка НБУ
                                                     --p_percent in number := null, --Процентна ставка (по замовчуванню)
                                                     p_s_limit in number := null, --Ліміт заборгованості
                                                     p_creditor_type in number := null, --Тип кредитора
                                                     p_credit_borrower in number := null, -- Вид позичальника
                                                     p_credit_type in number := null, --Тип кредиту
                                                     --p_credit_period in number := null, --Код періодичності погашення
                                                     p_credit_term in number := null, --Код строковості кредиту
                                                     --p_credit_method in number := null, --Метод нарахування відсотків
                                                     p_credit_prepay in number := null, --Можливість дострокового погашення
                                                     p_name in varchar2 := null, --Назва договору
                                                     p_add_agree in varchar2 := null, --Додаткові угоди
                                                     p_percent_nbu_type in number := null, --Назва максимальної процентної ставки НБУ
                                                     p_percent_nbu_info in varchar2 := null, --Додаткова інформація про максимальну процентну ставку НБУ
                                                     p_r_agree_date in date := null, --Дата реєстрації контракту (заповнюється при змінах)
                                                     p_r_agree_no in varchar2 := null, --Номер реєстрації контракту (заповнюється при змінах)
                                                     p_prev_doc_key in number := null, --Реєстраційний серверний номер (заповнюється при змінах)
                                                     p_prev_reestr_attr in varchar2 := null, -- Зміни до договору +
                                                     p_ending_date_indiv in date := null, --Кінцева дата індивідуального строку дії реєстрації контракту
                                                     p_parent_ch_data in varchar2 := null, --Інформація про короткостроковий контракт (заповнюється при перереєстрації з короткострокового у довгостроковий)
                                                     p_ending_date in date := null, --Строк дії реєстрації контракту (заповнюється при продовженні строку)
                                                     p_f503_reason in number := null, --Підстави подання звіту Ф503
                                                     p_f503_state in number := null, --Стан розрахунків за контрактом для звіту Ф503
                                                     p_f503_note in varchar2 := null, --Примітка звіту Ф503
                                                     p_f504_reason in number := null, --Підстави подання звіту Ф504
                                                     p_f504_note in varchar2 := null, --Примітка звіту Ф504
                                                     p_f503_percent_type in number := null, --Тип процентної ставки
                                                     p_f503_percent_base in varchar2 := null, --База процентної ставки (база)
                                                     p_f503_percent_margin in number := null, --Маржа процентної ставки
                                                     p_f503_percent in number := null, --Процентна ставка за основною сумою боргу
                                                     p_f503_purpose in number := null, --Ціль використання кредиту
                                                     p_f503_percent_base_t varchar2 :=null, --База процентної ставки (термін)
                                                     p_f503_change_info varchar2 :=null, --Інформація щодо внесення змін до договору
                                                     p_f503_percent_base_val varchar2 :=null, --База процентної ставки (валюта),
                                                     p_f057 char :=null --Вид запозичення,
                                                    )
is
  l_n                 number;
  l_branch            varchar2(30);
  l_p27_f531          number;
  l_benef_id          number;
  l_max_p27_f531      number;
  l_s_limit           number;
begin
  if (p_s=0 or p_s is null) and p_contr_type=2 then bars_error.raise_error(g_module_name, 8); end if;
  select count(*) into l_n from cim_contracts
    where rnk=p_rnk and benef_id=p_benef_id and contr_type=p_contr_type and num=p_num and subnum=p_subnum and open_date=p_open_date and kv=p_kv;
  if l_n>0 then bars_error.raise_error(g_module_name, 28); end if;
  if p_contr_type=2 and nvl(p_f503_percent_type,-1)=2 and ( p_f503_percent_base is null or p_f503_percent_base_t is null or p_f503_percent_margin is null )
    then bars_error.raise_error(g_module_name, 39); end if;
  select bars_sqnc.get_nextval('s_cim_contracts') into p_contr_id from dual;
  insert into cim_contracts (contr_id,contr_type,rnk,okpo,num, subnum,open_date,close_date,s,kv,benef_id,status_id,comments,bic,b010, service_branch,
      bank_change)
    values (p_contr_id, p_contr_type, p_rnk,(select max(okpo) from customer where rnk=p_rnk), p_num, p_subnum, p_open_date,
            p_close_date, round(nvl(p_s,0)*100,0), p_kv, p_benef_id, decode (p_contr_type,2,9,0), p_comments, p_bic, p_b010, p_service_branch,
            p_bank_change);
  if p_contr_type=0 or p_contr_type=1 then
    select count(*), max(decode(c.benef_id, p_benef_id, c.benef_id, null)), max(decode(c.benef_id, p_benef_id, t.p27_f531, null)),
           max(t.p27_f531) into l_n, l_benef_id, l_p27_f531, l_max_p27_f531
      from cim_contracts c
           join cim_contracts_trade t on t.contr_id=c.contr_id
     where c.rnk=p_rnk and c.contr_type=p_contr_type and c.num=p_num and c.open_date=trunc(p_open_date);
    if l_n=0 then l_p27_f531:=0;
      elsif l_benef_id is null then l_p27_f531:=l_max_p27_f531+1;
    end if;
    insert into cim_contracts_trade (contr_id, spec_id, without_acts, subject_id, deadline, trade_desc, p27_f531)
      values (p_contr_id, p_spec_id, p_without_acts, p_subject_id, p_deadline, p_txt_subject, l_p27_f531);
  else
    if p_contr_type=2 then
      insert into cim_contracts_credit (contr_id, percent_nbu, s_limit, creditor_type, borrower, credit_type, credit_term, credit_prepay, name,
        add_agree, percent_nbu_type, percent_nbu_info, r_agree_date, r_agree_no, prev_doc_key, prev_reestr_attr, ending_date_indiv,
        parent_ch_data, ending_date, f503_reason, f503_state, f503_note, f504_reason, f504_note, f503_percent_type, f503_percent_base,
        f503_percent_margin, f503_percent, f503_purpose, f503_percent_base_t, f503_change_info, f503_percent_base_val, f057)
        values (p_contr_id, p_percent_nbu, round(p_s_limit*100,0), p_creditor_type, p_credit_borrower, p_credit_type, p_credit_term,
        p_credit_prepay, p_name,
        p_add_agree, p_percent_nbu_type, p_percent_nbu_info, p_r_agree_date, p_r_agree_no, p_prev_doc_key, p_prev_reestr_attr,
        p_ending_date_indiv, p_parent_ch_data, p_ending_date, p_f503_reason, p_f503_state, p_f503_note, p_f504_reason, p_f504_note,
        p_f503_percent_type, case when p_f503_percent_type=2 then p_f503_percent_base else null end,
        case when p_f503_percent_type=2 then p_f503_percent_margin else null end, p_f503_percent, p_f503_purpose,
        case when p_f503_percent_type=2 then p_f503_percent_base_t else null end, p_f503_change_info,
        case when p_f503_percent_type=2 then p_f503_percent_base_val else null end,
        p_f057);
    end if;
    if p_contr_type=4 then
      begin
        select to_number(par_value)*100 into l_s_limit from cim_params where par_name='LIMIT_CONTR_EL_LIC';
        if val_convert(p_open_date, p_s*100, p_kv, 840) > l_s_limit then
          bars_error.raise_error(g_module_name, 104);
        end if;
        exception
          when NO_DATA_FOUND then
            bars_error.raise_error(g_module_name, 103);
      end;
    end if;
  end if;
  l_branch:=sys_context('bars_context','user_branch');
  select count(*) into l_n from cim_journal_num where branch=l_branch;
  if l_n=0 then
    insert into cim_journal_num (branch, name, adr, name_ov)
      values (l_branch, 'Заповніть назву установи в cim_journal_num',
              'Заповніть адресу установи в cim_journal_num', 'Заповніть назву установи в cim_journal_num');
  end if;
  bars_audit.info(g_module_name||' Створення контракту. contr_type: '||p_contr_type||' contr_id:'||p_contr_id||' rnk:'||p_rnk||
                  ' benef_id:'||p_benef_id||' kv:'||p_kv||' s:'||p_s||' open_date: '||p_open_date||' close_date: '||p_close_date);
end create_contract;

  -- update_contract - Редагування контракту
  --
procedure update_contract                           (p_contr_id in number, -- id контракту
                                                     p_num in varchar2 := null, -- Номер контракту
                                                     p_subnum in varchar2 := null, -- Субномер контракту
                                                     p_s in number := null, -- Сума контракту
                                                     p_benef_id in number := null, -- id нерезидента
                                                     p_open_date in date := null, -- Дата відкриття контракту
                                                     p_close_date in date := null, -- Дата закінчення контракту
                                                     p_comments in varchar2 := null, -- Деталі контракту
                                                     p_bank_change varchar2 := null, --Інформація про перехід з іншого банку
                                                     p_bic in varchar2 := null, -- BIC-код банку нерезидента
                                                     p_b010 in varchar2 := null, -- Код B010 банку нерезидента
                                                     p_service_branch in varchar2 := null, --Установа, відповідальна за прийом первинних документів
                                                     --------Параметри торгового контракту------------------------------------
                                                     p_spec_id in number := null, -- Спеціалізація контракту
                                                     p_subject_id in number := null, -- Предмет контракту
                                                     p_without_acts in number :=null, -- Робота без актів цінової експертизи
                                                     p_deadline in number := null, -- Контрольний строк
                                                     p_txt_subject in varchar2 := null, -- Уточнення предмету контракту
                                                     -------Параметри кредитного контракту----------------------------------
                                                     p_percent_nbu in number := null, -- Максимальна процентна ставка НБУ
                                                     --p_percent in number := null, --Процентна ставка (по замовчуванню)
                                                     p_s_limit in number := null, --Ліміт заборгованості
                                                     p_creditor_type in number := null, --Тип кредитора
                                                     p_credit_borrower in number := null, -- Вид позичальника
                                                     p_credit_type in number := null, --Тип кредиту
                                                     --p_credit_period in number := null, --Код періодичності погашення
                                                     p_credit_term in number := null, --Код строковості кредиту
                                                     --p_credit_method in number := null, --Метод нарахування відсотків
                                                     p_credit_prepay in number := null, --Можливість дострокового погашення
                                                     p_name in varchar2 := null, --Назва договору
                                                     p_add_agree in varchar2 := null, --Додаткові угоди
                                                     p_percent_nbu_type in number := null, --Назва максимальної процентної ставки НБУ
                                                     p_percent_nbu_info in varchar2 := null, --Додаткова інформація про максимальну процентну ставку НБУ
                                                     p_r_agree_date in date := null, --Дата реєстрації контракту (заповнюється при змінах)
                                                     p_r_agree_no in varchar2 := null, --Номер реєстрації контракту (заповнюється при змінах)
                                                     p_prev_doc_key in number := null, --Реєстраційний серверний номер (заповнюється при змінах)
                                                     p_prev_reestr_attr in varchar2 := null, -- Зміни до договору +
                                                     p_ending_date_indiv in date := null, --Кінцева дата індивідуального строку дії реєстрації контракту
                                                     p_parent_ch_data in varchar2 := null, --Інформація про короткостроковий контракт (заповнюється при перереєстрації з короткострокового у довгостроковий)
                                                     p_ending_date in date := null, --Строк дії реєстрації контракту (заповнюється при продовженні строку)
                                                     p_f503_reason in number := null, --Підстави подання звіту Ф503
                                                     p_f503_state in number := null, --Стан розрахунків за контрактом для звіту Ф503
                                                     p_f503_note in varchar2 := null, --Примітка звіту Ф503
                                                     p_f504_reason in number := null, --Підстави подання звіту Ф504
                                                     p_f504_note in varchar2 := null, --Примітка звіту Ф504
                                                     p_f503_percent_type in number := null, --Тип процентної ставки
                                                     p_f503_percent_base in varchar2 := null, --База процентної ставки
                                                     p_f503_percent_margin in number := null, --Маржа процентної ставки
                                                     p_f503_percent in number := null, --Процентна ставка за основною сумою боргу
                                                     p_f503_purpose in number := null, --Ціль використання кредиту
                                                     p_f503_percent_base_t varchar2 :=null, --База процентної ставки (термін)
                                                     p_f503_change_info varchar2 :=null, --Інформація щодо внесення змін до договору
                                                     p_f503_percent_base_val varchar2 :=null, --База процентної ставки (валюта)
                                                     p_f057 char :=null --Вид запозичення,
                                                    )
is l_contr_type         number;
   l_status_id          number;
   l_okpo               varchar2(10);
   l_branch             varchar2(30); -- Код установи
   l_date_term_change   date;
   l_rnk                number;
   l_subject_id         number;
   l_n                  number;
   l_p27_f531           number;
   l_benef_id           number;
   l_max_p27_f531       number;
   l_kv                 number;
   l_s_limit            number;
begin
  select status_id, c.contr_type, (select max(okpo) from customer where rnk=c.rnk), branch, rnk, kv
    into l_status_id, l_contr_type, l_okpo, l_branch, l_rnk, l_kv from cim_contracts c where contr_id=p_contr_id;
  if (p_s=0 or p_s is null) and l_contr_type=2 then bars_error.raise_error(g_module_name, 8); end if;
  if l_branch!=sys_context('bars_context', 'user_branch') then bars_error.raise_error(g_module_name, 40); end if;
  if l_contr_type=2 and nvl(p_f503_percent_type,-1)=2 and ( p_f503_percent_base is null or p_f503_percent_base_t is null or p_f503_percent_margin is null )
    then bars_error.raise_error(g_module_name, 39); end if;
  if l_contr_type=0 or l_contr_type=1 then
    select subject_id into l_subject_id from cim_contracts_trade where contr_id=p_contr_id;
    if l_subject_id=1 and p_subject_id=0 then
      select count(*) into l_n from cim_contracts_ape where delete_date is null and contr_id=p_contr_id;
      if l_n>0 then bars_error.raise_error(g_module_name, 19); end if;
    end if;

    select count(*), max(decode(c.benef_id, p_benef_id, c.benef_id, null)), max(decode(c.benef_id, p_benef_id, t.p27_f531, null)),
           max(t.p27_f531) into l_n, l_benef_id, l_p27_f531, l_max_p27_f531
      from cim_contracts c
           join cim_contracts_trade t on t.contr_id=c.contr_id
     where c.contr_id != p_contr_id and c.rnk=l_rnk and c.contr_type=l_contr_type and c.num=p_num and c.open_date=trunc(p_open_date);
    if l_n=0 then l_p27_f531:=0;
      elsif l_benef_id is null then l_p27_f531:=l_max_p27_f531+1;
    end if;
    update cim_contracts_trade
      set spec_id=p_spec_id, subject_id=p_subject_id, without_acts=p_without_acts, deadline=p_deadline, trade_desc=p_txt_subject, p27_f531=l_p27_f531
      where contr_id=p_contr_id;
  elsif l_contr_type=2 then
    update cim_contracts_credit
    set percent_nbu=p_percent_nbu, s_limit=round(p_s_limit*100,0),
        creditor_type=p_creditor_type, borrower=p_credit_borrower, credit_type=p_credit_type,
        credit_term=p_credit_term, credit_prepay=p_credit_prepay, name=p_name,
        add_agree=p_add_agree, percent_nbu_type=p_percent_nbu_type,
        percent_nbu_info=p_percent_nbu_info, r_agree_date=p_r_agree_date,
        r_agree_no=p_r_agree_no, prev_doc_key=p_prev_doc_key,
        prev_reestr_attr=p_prev_reestr_attr,
        ending_date_indiv=p_ending_date_indiv, parent_ch_data=p_parent_ch_data,
        ending_date=p_ending_date,
        date_term_change= case when p_credit_term=2 and l_status_id=0 then
          decode(credit_term, 2, date_term_change, to_date('01/01/3000','DD/MM/YYYY'))
          else null end,
        f503_reason=p_f503_reason, f503_state=p_f503_state, f503_note=p_f503_note,
        f504_reason=p_f504_reason, f504_note=p_f504_note,
        f503_percent_type=p_f503_percent_type, f503_percent_base=case when p_f503_percent_type=2 then p_f503_percent_base else null end,
        f503_percent_margin=case when p_f503_percent_type=2 then p_f503_percent_margin else null end, f503_percent=p_f503_percent, f503_purpose=p_f503_purpose,
        f503_percent_base_t=case when p_f503_percent_type=2 then p_f503_percent_base_t else null end, f503_change_info=p_f503_change_info,
        f503_percent_base_val=case when p_f503_percent_type=2 then p_f503_percent_base_val else null end,
        f057 = p_f057
    where contr_id=p_contr_id;
   elsif l_contr_type=4 then
      begin
        select to_number(par_value)*100 into l_s_limit from cim_params where par_name='LIMIT_CONTR_EL_LIC';
        if val_convert(p_open_date, p_s*100, l_kv, 840) > l_s_limit then
          bars_error.raise_error(g_module_name, 104);
        end if;
        exception
          when NO_DATA_FOUND then
            bars_error.raise_error(g_module_name, 103);
      end;
  end if;
  update cim_contracts
  set num=p_num, subnum=p_subnum, open_date=p_open_date, close_date=p_close_date,
      s=round(nvl(p_s,0)*100,0), benef_id=p_benef_id, comments=p_comments,
      okpo=l_okpo, bic=p_bic, b010=p_b010, service_branch=p_service_branch,
      bank_change=p_bank_change
  where contr_id=p_contr_id;
  if l_contr_type<2 then check_contract_status(p_contr_id); end if;
  bars_audit.info(g_module_name||' Редагування контракту. contr_id:'||p_contr_id||' rnk:'||l_rnk||
                  ' benef_id:'||p_benef_id||' s:'||p_s||' open_date: '||p_open_date||' close_date: '||p_close_date||' l_contr_type: '||l_contr_type||' l_s_limit: '||l_s_limit/100);
end update_contract;

-- close_contract - Закриття (видалення) / відновлення контракту
--
procedure close_contract (p_contr_id in number/*id контракту*/)
is l_contr_type number;
   l_status_id number;
   l_can_delete number;
   l_branch varchar2(30); -- Код установи
begin
  select contr_type, status_id, branch, can_delete into l_contr_type, l_status_id, l_branch, l_can_delete
    from v_cim_all_contracts where contr_id=p_contr_id;
  if l_branch != sys_context('bars_context', 'user_branch') then bars_error.raise_error(g_module_name, 40); end if;
  if l_status_id = 10 or l_contr_type != 2 and l_status_id=9 or l_can_delete=0 and l_status_id=1 then
    bars_error.raise_error(g_module_name, 7);
  elsif l_status_id != 9 and l_status_id != 1 then
    update cim_contracts set status_id=1 where contr_id=p_contr_id;
    bars_audit.info(g_module_name||'Закриття контракту. contr_id:'||p_contr_id);
  else
    if l_contr_type < 2 then
      delete from cim_contracts_trade where contr_id=p_contr_id;
    elsif l_contr_type = 2 then
      delete from cim_credgraph_payment where contr_id=p_contr_id;
      delete from cim_credgraph_period where contr_id=p_contr_id;
      delete from cim_contracts_credit where contr_id=p_contr_id;
    end if;
    delete from cim_contracts where contr_id=p_contr_id;
     bars_audit.info(g_module_name||'Видалення контракту. contr_id:'||p_contr_id);
  end if;
end close_contract;

-- resurrect_contract - Відновлення контракту
--
procedure resurrect_contract (p_contr_id in number/*id контракту*/)
is l_contr_type number;
   l_status_id number;
   l_branch varchar2(30); -- Код установи
begin
  select contr_type, status_id, branch into l_contr_type, l_status_id, l_branch from cim_contracts where contr_id=p_contr_id;
  if l_branch != sys_context('bars_context', 'user_branch') then bars_error.raise_error(g_module_name, 40); end if;
  if l_status_id=1 then
    update cim_contracts set status_id=0 where contr_id=p_contr_id;
    if l_contr_type<2 then check_contract_status(p_contr_id); end if;
    bars_audit.info(g_module_name||' Відновлення контракту. contr_id:'||p_contr_id);
  end if;
end resurrect_contract;

-- change_contract_branch - Передача контракту у іншу установу
--
procedure change_contract_branch (p_contr_id in number,
                                  p_new_branch varchar2)
is
  l_old_branch varchar2(30);
  l_n number;
begin
  select branch into l_old_branch from cim_contracts where contr_id=p_contr_id;
  if l_old_branch != p_new_branch then
    select count(*) into l_n from cim_journal_num where branch=p_new_branch;
    if l_n=0 then
      insert into cim_journal_num (branch, name, adr, name_ov)
        values (p_new_branch, 'Заповніть назву установи в cim_journal_num',
                'Заповніть адресу установи в cim_journal_num', 'Заповніть назву установи в cim_journal_num');
    end if;
    update cim_contracts set branch=p_new_branch where contr_id=p_contr_id;
    bars_audit.info(g_module_name||' Передача контракту у іншу установу. contr_id:'||to_char(p_contr_id,'fm00000000')||
                    ' old_branch:'||l_old_branch||' new_branch:'||p_new_branch);
  end if;
end change_contract_branch;

-- nbu_registration - Формування XML - повідомлення для реєстрації у НБУ
--
function nbu_registration (p_contr_id in number,
                           p_agree_fname in varchar2 := null,
                           p_letter_fname in varchar2 := null,
                           p_old_mfo in number := null,
                           p_old_oblcode in number := null,
                           p_old_bank_code in varchar2 := null,
                           p_old_bank_oblcode in number := null,
                           p_prev_doc_key in number := null, --Реєстраційний серверний номер (заповнюється при змінах)
                           p_r_agree_date in date := null, --Дата реєстрації контракту (заповнюється при змінах)
                           p_r_agree_no in varchar2 := null --Номер реєстрації контракту (заповнюється при змінах)
                          ) return varchar2
   is
     l_xml varchar2 (8192 byte);
     l_n number;
     l_credit_term number;
     l_s number;
     --l_credit_opertype number;
     l_status_id number;
     l_doc_type varchar2 (16 byte);
     l_oblcode number;
     l_branch varchar2(30); -- Код установи
     l_banc_code varchar2(20);
begin
     select max(branch) into l_branch from cim_contracts where contr_id=p_contr_id;
     if l_branch!=sys_context('bars_context', 'user_branch') then bars_error.raise_error(g_module_name, 40); end if;
     select b040 into l_banc_code from branch where branch=l_branch;
     if l_banc_code is null then bars_error.raise_error(g_module_name, 27); end if;
     select to_number(par_value) into l_oblcode from cim_params where par_name='OBL_CODE';
     if l_oblcode is null then bars_error.raise_error(g_module_name, 23);
     else
       select count(*), max(credit_term), max(s), max(status_id) --,max(credit_opertype)
         into l_n, l_credit_term, l_s, l_status_id --,l_credit_opertype
         from v_cim_credit_contracts where contr_id=p_contr_id;
       if l_status_id=10 then bars_error.raise_error(g_module_name, 28); end if;
       if l_n!=1 or l_s is null then bars_error.raise_error(g_module_name, 20);
       else
         if p_old_mfo is null then
           if p_letter_fname is null then
             if  l_status_id=9 then l_doc_type := 'DOC'; else l_doc_type := 'DOC_CH'; end if;
             else l_doc_type := 'NAME_CH';
           end if;
           else l_doc_type := 'BANK_CH';
         end if;
         if (l_doc_type='BANK_CH' or l_doc_type='BANK_CH') and
               (p_old_bank_code is null or p_old_bank_oblcode is null or p_prev_doc_key is null or p_r_agree_date is null or p_r_agree_no is null)
             or l_doc_type='BANK_CH' and p_old_oblcode is null
           then bars_error.raise_error(g_module_name, 20);
         end if;
         --if l_credit_term=1 then
           select '<?xml version="1.0" encoding="windows-1251"?>'||
            XmlElement("long_agree",
             XmlAttributes('http://www.w3schools.com' as "xmlns"),
              XmlConcat( XmlElement("subject_type",'NEBANK'),
               XmlElement("doc_id",to_char(f_ourmfo,'fm999999')||'/'||to_char(contr_id,'fm09999999')),
               XmlElement("document_type",l_doc_type),
               XmlElement("mfo",300465),
               XmlElement("oblcode",26),
               nvl2(name,XmlElement("agree_name",name),''),
               XmlElement("agree_date",to_char(open_date,'dd.mm.yyyy')),
               XmlElement("agree_no",num),

               nvl2(add_agree,XmlElement("agree_additional",add_agree),''),

               decode(l_doc_type,
                 'DOC_CH', XmlConcat (XmlElement("r_agree_date",to_char(r_agree_date,'dd.mm.yyyy')),
                             XmlElement("r_agree_no",r_agree_no), XmlElement("prev_ddoc_key",prev_ddoc_key)),
                 'DOC','',
                 XmlConcat(XmlElement("r_agree_date",to_char( p_r_agree_date,'dd.mm.yyyy')),
                             XmlElement("r_agree_no",p_r_agree_no), XmlElement("prev_ddoc_key",p_prev_doc_key))),
               nvl2(prev_reestr_attr,XmlElement("prev_reestr_attr",prev_reestr_attr),''),
               nvl2(parent_ch_data,XmlElement("parent_ch_data",parent_ch_data),''),
               nvl2(ending_date,XmlElement("ending_date",to_char(ending_date,'dd.mm.yyyy')),''),
               nvl2(ending_date_indiv,XmlElement("ending_date_indiv",to_char(ending_date_indiv,'dd.mm.yyyy')),''),
               XmlElement("bank_code",decode(l_banc_code,'00626804026614000000','300465',l_banc_code)),
               XmlElement("bank_oblcode",l_oblcode),
               XmlElement("f_name",nvl((select nmku from corps where rnk=c.rnk),c.nmk)||decode(custtype,3,'',' / '||nmkk)),
               XmlElement("f_code", decode(custtype,3, passport, okpo)),
               decode( l_doc_type, 'BANK_CH', XmlConcat( XmlElement("old_mfo",p_old_mfo),XmlElement("old_oblcode",p_old_oblcode)), ''),
               decode( l_doc_type,'BANK_CH',
                 XmlConcat( XmlElement("old_bank_code",p_old_bank_code),XmlElement("old_bank_oblcode",to_char(p_old_bank_oblcode)))
               ),
               XmlElement("max_rate_nbu",percent_nbu_name||to_char(percent_nbu,'99.99')||'%'||nvl(percent_nbu_info,'')),
               --sender_head
               XmlElement("document",
                 --XmlAttributes('http://www.w3schools.com' as "xmlns"),
                 XmlConcat(
                   XmlElement("doc_kind",'AGREE'),
                   XmlElement("file_name",p_agree_fname))),
               --ASSENT
               nvl2(p_letter_fname,XmlElement("document",
                             --      XmlAttributes('http://www.w3schools.com' as "xmlns"),
                                   XmlConcat(
                                     XmlElement("doc_kind",'LETTER'),
                                     XmlElement("file_name",p_letter_fname))),'')
               )
            ) into l_xml
         from  v_cim_credit_contracts c
         where contr_id=p_contr_id;
       /*else
         if l_credit_opertype is null then bars_error.raise_error(g_module_name, 20);
         else
           select  '<?xml version="1.0" encoding="windows-1251"?>'||XmlElement("short_agree",
             XmlAttributes('http://www.w3schools.com' as "xmlns"),
             XmlConcat(
               XmlElement("subject_type",'NEBANK'),
               XmlElement("doc_id",to_char(f_ourmfo,'fm999999')||'/'||to_char(contr_id,'fm09999999')),
               XmlElement("mfo",300465),
               nvl2(credit_operdate,XmlElement("operdate",to_char(credit_operdate,'dd.mm.yyyy')),''),
               XmlElement("doctype_id",l_doc_type),
               nvl2(name,XmlElement("ground_name",name),''),
               XmlElement("ground_no",num),
               XmlElement("ground_date",to_char(open_date,'dd.mm.yyyy')),
               XmlElement("nerez_name",benef_name),
               XmlElement("nerez_country",country_name),
               XmlElement("opertype",credit_opertype),
               XmlElement("currency",(select max(lcv) from tabval$global where kv=v.kv)),
               XmlElement("summa_all",s),
               nvl2(close_date,XmlElement("date_pgs",to_char(close_date,'dd.mm.yyyy')),''),
               nvl2(close_date,XmlElement("day_count",close_date-open_date+1),''),
               nvl2(s_limit,XmlElement("limit_bebt",s_limit),''),
               XmlElement("rate_name",percent_nbu_name||to_char(percent_nbu,'99.99')||'%'||nvl2(margin,to_char(margin,'99.99'),'')),
               XmlElement("rate",percent_nbu),
               nvl2(tranche_no,XmlElement("tranche_no",tranche_no),''),
               nvl2(tr_summa,XmlElement("tr_summa",tr_summa),''),
               nvl2(tr_currency,XmlElement("tr_currency",(select max(lcv) from tabval$global where kv=v.tr_currency)),''),
               nvl2(tr_rate_name,XmlElement("tr_rate_name",tr_rate_name),''),
               nvl2(tr_rate,XmlElement("tr_rate",tr_rate),''),
               nvl2(prev_ddoc_key,XmlElement("parent_ddoc_key",prev_ddoc_key),''),
               nvl2(r_agree_no,XmlElement("tr_1_ddoc_key",r_agree_no),'')
             )) into l_xml
           from  v_cim_credit_contracts v
           where contr_id=p_contr_id;
         end if; */
       end if;
       update cim_contracts set status_id=10 where status_id=9 and contr_id=p_contr_id;
       update cim_contracts_credit set parent_ch_data = null, ending_date = null, prev_doc_key=nvl(p_prev_doc_key,prev_doc_key),
              r_agree_date=nvl(p_r_agree_date, r_agree_date), r_agree_no=nvl(p_r_agree_no, r_agree_no)
        where contr_id=p_contr_id;
       return l_xml;
     end if;
end nbu_registration;

-- confirm_nbu_registration - Підтвердження реєстрації контракту у НБУ
--
procedure confirm_nbu_registration(p_contr_id in number, -- id контракту
                                   p_prev_doc_key in number, --Реєстраційний серверний номер
                                   p_r_agree_date in date, --Дата реєстрації контракту/змін
                                   p_r_agree_no in varchar2 --Номер реєстрації контракту/змін
                                  )
is
  l_n1 number;
  l_n2 number;
  l_status_id number;
  l_branch varchar2(30); -- Код установи
  l_date_term_change date;
begin
  select count(*), max(status_id), max(branch) into l_n1, l_status_id, l_branch from cim_contracts where contr_id=p_contr_id;
  if l_branch!=sys_context('bars_context', 'user_branch') then bars_error.raise_error(g_module_name, 40); end if;
  select count(*), max(date_term_change) into l_n2, l_date_term_change from cim_contracts_credit where contr_id=p_contr_id;
  if l_n1!=1 or l_n2!=1 or l_status_id=9 or l_status_id=1 then bars_error.raise_error(g_module_name, 21);
  else
    if p_prev_doc_key is null then bars_error.raise_error(g_module_name, 22);
    else
      if l_status_id=10 then
        if p_r_agree_date is null or p_r_agree_no is null then bars_error.raise_error(g_module_name, 22);
        else
          update cim_contracts_credit
            set prev_doc_key=p_prev_doc_key, r_agree_date=nvl(r_agree_date,p_r_agree_date), r_agree_no=nvl(r_agree_no, p_r_agree_no)
            where contr_id=p_contr_id;
          update cim_contracts set status_id=0 where contr_id=p_contr_id;
        end if;
      else
        if l_date_term_change=to_date('01/01/3000','DD/MM/YYYY') then l_date_term_change:=p_r_agree_date; end if;
        update cim_contracts_credit set prev_doc_key=p_prev_doc_key, date_term_change=l_date_term_change,
          prev_reestr_attr=prev_reestr_attr||'; Додаток №'||p_r_agree_no||' від '||to_char(p_r_agree_date,'dd.mm.yyyy')
          where contr_id=p_contr_id;
      end if;
    end if;
  end if;
end confirm_nbu_registration;

-- cancel_nbu_registration - Відміна реєстрації контракту у НБУ
--
procedure cancel_nbu_registration(p_contr_id in number -- id контракту
                                  )
is
  l_n number;
  l_contr_type number;
  l_status_id number;
  l_branch varchar2(30); -- Код установи
begin
  select max(branch) into l_branch from cim_contracts where contr_id=p_contr_id;
  if l_branch!=sys_context('bars_context', 'user_branch') then bars_error.raise_error(g_module_name, 40); end if;
  select count(*), max(status_id), max(contr_type) into l_n, l_status_id, l_contr_type from cim_contracts where contr_id=p_contr_id;
  if l_n=1 and l_contr_type=2 and l_status_id=10 then
    update cim_contracts set status_id=9 where contr_id=p_contr_id;
    update cim_contracts_credit set r_agree_date=null, r_agree_no=null, prev_doc_key=null where contr_id=p_contr_id;
  end if;
end cancel_nbu_registration;

   --------------------------------------------------------------------------------
   -- create_beneficiary - Створення бенефиціара
   --
   procedure create_beneficiary (p_benef_name varchar2, -- Назва контрагента
                                 p_country_id number :=null, -- Код країни контрагента
                                 p_adr varchar2 :=null, -- Адреса контрагента
                                 p_comments varchar2 :=null  -- Коментар
                                )
   is
     l_n number;
   begin
     select count(*) into l_n from cim_beneficiaries where benef_name=p_benef_name;
     if l_n>0 then bars_error.raise_error(g_module_name, 30);
     else
       select bars_sqnc.get_nextval('s_cim_beneficiaries') into l_n from dual;
       insert into cim_beneficiaries (benef_id, benef_name, country_id, benef_adr, comments)
       values (l_n, p_benef_name, p_country_id, p_adr, p_comments);
     end if;
     bars_audit.info(g_module_name||' Створення бенефіціара. benef_id:'||l_n||' benef_name: '||p_benef_name);
   end;
-------------------------------------------------------------------------------
   -- update_beneficiary - Редагування бенефиціара
   --
    procedure update_beneficiary (p_benef_id number, -- id контрагента
                                  p_benef_name varchar2 := null, -- Назва контрагента
                                  p_country_id number :=null, -- Код країни контрагента
                                  p_adr varchar2 :=null,  -- Адреса контрагента
                                  p_comments varchar2 :=null  -- Коментар
                                 )
   is
     l_n number;
   begin
     select count(*) into l_n from cim_beneficiaries where benef_id=p_benef_id;
     if l_n!=1 then bars_error.raise_error(g_module_name, 31);
     else
       update cim_beneficiaries
         set benef_name=nvl(p_benef_name,benef_name), country_id=nvl(p_country_id,country_id),
             benef_adr=nvl(p_adr,benef_adr), comments=nvl(p_comments,comments)
         where benef_id=p_benef_id;
     end if;
     bars_audit.info(g_module_name||' Редагування бенефіціара. benef_id:'||p_benef_id||' benef_name: '||p_benef_name);
   end;
-------------------------------------------------------------------------------
   -- delete_beneficiary - Видалення бенефиціара
   --
   procedure delete_beneficiary (p_benef_id number) -- id бенефиціара
   is
     l_n number;
     l_date date;
   begin
     select count(*), max(delete_date) into l_n, l_date from cim_beneficiaries where benef_id=p_benef_id;
     if l_n!=1 then
       bars_error.raise_error(g_module_name, 31);
     else
       update cim_beneficiaries set delete_date=nvl2(l_date,null,bankdate) where benef_id=p_benef_id;
     end if;
     bars_audit.info(g_module_name||' Видалення бенефіціара. benef_id:'||p_benef_id);
   end;
--------------------------------------------------------------------------------
   -- create_credgraph_period - Створення періоду графіка кредитного контракту
   --
   procedure create_credgraph_period (p_contr_id number, -- ID контракту
                                      p_end_date date, -- Дата закінчення періоду
                                      p_cr_method number, -- Медтод погашення тіла
                                      p_payment_period number, -- Періодичність погашення тіла
                                      p_z number, -- Залишок тіла на кінець періоду
                                      p_adaptive number, --'Метод ліквідації відхилень погашення тіла кредиту
                                      p_percent number, -- Процентна ставка
                                      p_percent_nbu number, -- Процентна ставка НБУ
                                      p_percent_base number, -- База нарахування відсотків
                                      p_percent_period number, -- Періодичність погашення відсотків
                                      p_payment_delay number,-- Затримка оплати тіла
                                      p_percent_delay number,-- Затримка оплати відсотків
                                      p_get_day number, -- Врахування дня видачі кредиту при нарахуванні відсотків
                                      p_pay_day number, -- Врахування дня погашення кредиту при нарахуванні відсотків
                                      p_payment_day number, -- Дата погашення тіла
                                      p_percent_day number -- Дата погашення відсотків
                                      --p_holiday number -- Врахування вихідних при побудові графіка
                                     )
   is
     l_n number;
     l_branch varchar2(30); -- Код установи
   begin
     select max(branch) into l_branch from cim_contracts where contr_id=p_contr_id;
     if l_branch!=sys_context('bars_context', 'user_branch') then bars_error.raise_error(g_module_name, 40); end if;
     select count(*) into l_n from cim_credgraph_period where end_date=p_end_date and contr_id=p_contr_id;
     if l_n>0 then bars_error.raise_error(g_module_name, 24);
     else
       insert into cim_credgraph_period
         (contr_id, end_date, cr_method, payment_period, z, percent, percent_nbu,
          percent_base, percent_period, payment_delay, percent_delay, get_day, pay_day, adaptive, payment_day, percent_day)
         values (p_contr_id, trunc(p_end_date), p_cr_method, p_payment_period, p_z*100, p_percent,
                 p_percent_nbu, p_percent_base, p_percent_period, p_payment_delay, p_percent_delay, p_get_day, p_pay_day, p_adaptive , p_payment_day, p_percent_day);
     end if;
   end;
-------------------------------------------------------------------------------
   -- update_credgraph_period- Редагування періоду графіка кредитного контракту
   --
    procedure update_credgraph_period (p_contr_id number, -- ID контракту
                                       p_row_id rowid, -- ID рядка
                                       p_end_date date :=null, -- Дата закінчення періоду
                                       p_cr_method number :=null, -- Медтод погашення тіла
                                       p_payment_period number :=null, -- Періодичність погашення тіла
                                       p_z number :=null, -- Залишок тіла на кінець періоду
                                       p_adaptive number :=null, --'Метод ліквідації відхилень погашення тіла кредиту
                                       p_percent number :=null, -- Процентна ставка
                                       p_percent_nbu number :=null, -- Процентна ставка НБУ
                                       p_percent_base number :=null, -- База нарахування відсотків
                                       p_percent_period number :=null, -- Періодичність погашення відсотків
                                       p_payment_delay number :=null,-- Затримка оплати тіла
                                       p_percent_delay number :=null,-- Затримка оплати відсотків
                                       p_get_day number :=null, -- Врахування дня видачі кредиту при нарахуванні відсотків
                                       p_pay_day number :=null, -- Врахування дня погашення кредиту при нарахуванні відсотків
                                       p_payment_day number, -- Дата погашення тіла
                                       p_percent_day number -- Дата погашення відсотків
                                       --p_holiday number :=null -- Врахування вихідних при побудові графіка
                                      )
   is
     l_n number;
     l_branch varchar2(30); -- Код установи
   begin
     select max(branch) into l_branch from cim_contracts where contr_id=p_contr_id;
     if l_branch!=sys_context('bars_context', 'user_branch') then bars_error.raise_error(g_module_name, 40); end if;
     select count(*) into l_n from cim_credgraph_period where rowid=p_row_id and contr_id=p_contr_id;
     if l_n!=1 then bars_error.raise_error(g_module_name, 25);
     else
       update cim_credgraph_period
         set end_date=trunc(nvl(p_end_date,end_date)), cr_method=nvl(p_cr_method,cr_method), payment_period=nvl(p_payment_period,payment_period),
             z=nvl(p_z*100,z), percent=nvl(p_percent,percent), percent_nbu=nvl(p_percent_nbu,percent_nbu),
             percent_base=nvl(p_percent_base,percent_base), percent_period=nvl(p_percent_period,percent_period),
             payment_delay=nvl(p_payment_delay,payment_delay), percent_delay=nvl(p_percent_delay,percent_delay),
             get_day=nvl(p_get_day,get_day), pay_day=nvl(p_pay_day,pay_day), adaptive=p_adaptive, payment_day=p_payment_day, percent_day=p_percent_day
         where rowid=p_row_id and contr_id=p_contr_id;
     end if;
   end;
-------------------------------------------------------------------------------
   -- delete_credgraph_period - Видалення періоду графіка кредитного контракту
   --
   procedure delete_credgraph_period (p_contr_id number, -- ID контракту
                                      p_row_id rowid -- ID рядка
                                     )
   is
     l_n number;
     l_branch varchar2(30); -- Код установи
   begin
     select max(branch) into l_branch from cim_contracts where contr_id=p_contr_id;
     if l_branch!=sys_context('bars_context', 'user_branch') then bars_error.raise_error(g_module_name, 40); end if;
     select count(*) into l_n from cim_credgraph_period where rowid=p_row_id and contr_id=p_contr_id;
     if l_n!=1 then
       bars_error.raise_error(g_module_name, 25);
     else
       delete from cim_credgraph_period where rowid=p_row_id and contr_id=p_contr_id;
     end if;
   end;


--------------------------------------------------------------------------------
   -- create_credgraph_payment - Створення неперіодичного платежа графіка кредитного контракту
   --
   procedure create_credgraph_payment (p_contr_id number, -- ID контракту
                                       p_dat date, -- Дата платежа
                                       p_s number, -- Сума платежа
                                       p_pay_flag number -- Класифікатор платежа
                                      )
   is
     l_branch varchar2(30); -- Код установи
   begin
     select max(branch) into l_branch from cim_contracts where contr_id=p_contr_id;
     if l_branch!=sys_context('bars_context', 'user_branch') then bars_error.raise_error(g_module_name, 40); end if;
     insert into cim_credgraph_payment (contr_id, dat, s, pay_flag) values (p_contr_id, p_dat, p_s*100, p_pay_flag);
   end;
-------------------------------------------------------------------------------
   -- update_credgraph_payment- Редагування неперіодичного платежа графіка кредитного контракту
   --
    procedure update_credgraph_payment (p_contr_id number, -- ID контракту
                                        p_row_id rowid, -- ID рядка
                                        p_dat date, -- Дата платежа
                                        p_s number, -- Сума платежа
                                        p_pay_flag number -- Класифікатор платежа
                                       )
   is
     l_n number;
     l_branch varchar2(30); -- Код установи
   begin
     select max(branch) into l_branch from cim_contracts where contr_id=p_contr_id;
     if l_branch!=sys_context('bars_context', 'user_branch') then bars_error.raise_error(g_module_name, 40); end if;
     select count(*) into l_n from cim_credgraph_payment where rowid=p_row_id and contr_id=p_contr_id;
     if l_n!=1 then bars_error.raise_error(g_module_name, 26);
     else
       update cim_credgraph_payment
         set dat=nvl(p_dat,dat), s=nvl(p_s*100,s), pay_flag=nvl(p_pay_flag,pay_flag)
         where rowid=p_row_id and contr_id=p_contr_id;
     end if;
   end;
-------------------------------------------------------------------------------
   -- delete_credgraph_period - Видалення неперіодичного платежа графіка кредитного контракту
   --
   procedure delete_credgraph_payment (p_contr_id number, -- ID контракту
                                       p_row_id rowid -- ID рядка
                                      )
   is
     l_n number;
     l_branch varchar2(30); -- Код установи
   begin
     select max(branch) into l_branch from cim_contracts where contr_id=p_contr_id;
     if l_branch!=sys_context('bars_context', 'user_branch') then bars_error.raise_error(g_module_name, 40); end if;
     select count(*) into l_n from cim_credgraph_payment where rowid=p_row_id and contr_id=p_contr_id;
     if l_n!=1 then
       bars_error.raise_error(g_module_name, 26);
     else
       delete from cim_credgraph_payment where rowid=p_row_id and contr_id=p_contr_id;
     end if;
   end;

-- create_credgraph - Формування графіка по кредиту
--
procedure create_credgraph(p_contr_id in number -- id контракту
                                  )
is

  cursor c_period is
    select * from cim_credgraph_period where contr_id=p_contr_id order by end_date;
  cursor c_payment is
    select * from
      (select dat, s, pay_flag, 0 as r from cim_credgraph_payment where contr_id=p_contr_id
       union all
       select (select vdat from v_cim_oper where ref=b.ref) as dat, decode(b.direct,0,b.s_cv,1,-b.s_cv) as s, b.pay_flag, 1 as r
         from cim_payments_bound b where delete_date is null and contr_id=p_contr_id
       union all
       select (select val_date from cim_fantom_payments where fantom_id=b.fantom_id) as dat,
               decode(b.direct,0,b.s_cv,1,-b.s_cv), b.pay_flag, 1
         from cim_fantoms_bound b where delete_date is null and contr_id=p_contr_id
      )
    order by dat;
  cursor c_tmp is select * from cim_credgraph_tmp order by dat;

  l_payment c_payment%rowtype;
  l_begin_date date; -- Дата початку контракту
  l_last_rdate date; -- Дата останнього реального платежу
  l_bdat date; -- Дата початку періоду

  l_dat date;
  l_psnt number;
  l_pspt number;
  l_psk  number;
  l_pspe number;
  l_rsnt number;
  l_rspt number;
  l_rsk  number;
  l_rspe number;
  l_svp number;
  l_sd number;
  l_i_vp number;
  l_kp number;
  l_dy number; --Кількість днів у році

  l_n1 number; -- тимчасова змінна
  l_n2 number; -- тимчасова змінна
  l_n  number; -- тимчасова змінна

  l_sp number;
  l_sps number;
  l_spp number;
  l_spnbu number;
  l_zp number;
  l_snt number;
  l_spt number;
  l_dppt date;
  l_dt_m number; --прострочка по тілу, яка очікує закінчення місяця
  l_dt number;
  l_dp number;
  l_dp_m number; --прострочка по процентах, яка очікує закінчення місяця
  l_m varchar2(6); --поточний місяць

  l_zt number;
  l_pzt number;
  l_zpnbu number;
  l_bt number;
  l_ft number;
  l_smps number;

  l_last_rsnt number;
  l_last_rspt number;
  s           number;
  ss           number;

  x_sp number;
  x_sps number;
  x_spp number;
  x_zp number;
  x_zt number;
  x_last_rsnt number;
  x_last_rspt number;
  x_snt number;
  x_spt number;
  x_pspt number;
  x_pzt number;
  x_bt number;
begin
  delete from cim_credgraph_tmp;  delete from cim_credgraph_delay;
  open c_payment; fetch c_payment into l_payment;
  select open_date into l_begin_date from cim_contracts where contr_id=p_contr_id;
  l_last_rdate:=l_begin_date; l_bdat:=l_begin_date;  --l_mdat:=l_begin_date;

  for pr in c_period loop
    l_n2:=to_number(to_char(pr.end_date,'yyyy')); l_n1:=to_number(to_char(l_bdat,'yyyy'));
    while l_n1<l_n2 loop
      l_n1:=l_n1+1;
      insert into cim_credgraph_tmp
               (dat, psnt, rsnt, pspt, rspt, psk, rsk, pspe, rspe, zt, dt, smp, sp, svp, zp, sd, zpnbu,
                i_rp, i_vp, kp, percent, percent_nbu, percent_base, z, t_delay, p_delay, get_day, pay_day, adaptive)
        values (to_date('01.01.'||to_char(l_n1,'fm9999'),'dd.mm.yyyy'), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, pr.percent, pr.percent_nbu, pr.percent_base, pr.z, pr.payment_delay, pr.percent_delay, pr.get_day, pr.pay_day, pr.adaptive);
    end loop;

    l_n1:=months_between(last_day(pr.end_date-1),last_day(l_bdat))+1; l_n:=l_n1; l_dat:=last_day(l_bdat)+1;
    case pr.payment_period
      when 1 then l_kp:=l_n1;
      when 2 then l_kp:=trunc(l_n1/3+0.99);
      when 3 then l_kp:=trunc(l_n1/6+0.99);
      when 4 then l_kp:=trunc(l_n1/12+0.99);
      when 5 then l_kp:=1;
      when 14 then l_kp:=to_number(to_char(pr.end_date,'yyyy'))-to_number(to_char(l_bdat,'yyyy'));
      else l_kp:=null;
    end case;

    while l_n1>0 loop
      while c_payment%found and l_payment.dat<l_dat loop
        l_psnt:=0; l_pspt:=0; l_psk:=0; l_pspe:=0; l_rsnt:=0; l_rspt:=0; l_rsk:=0; l_rspe:=0; l_svp:=0; l_sd:=0; l_i_vp:=0;
        if l_payment.r=0 then
          case
            when l_payment.pay_flag=2 then if l_payment.s<0 then l_pspt:=-l_payment.s; else l_psnt:=l_payment.s; end if;
            when l_payment.pay_flag=3 and l_payment.s<0 then l_i_vp:=1;
            when l_payment.pay_flag=4 and l_payment.s<0 then l_psk:=-l_payment.s;
            when l_payment.pay_flag=5 and l_payment.s<0 then l_pspe:=-l_payment.s;
            else l_i_vp:=0;
          end case;
        else
          case
            when l_payment.pay_flag=2 then if l_payment.s<0 then l_rspt:=-l_payment.s; else l_rsnt:=l_payment.s; end if;
            when l_payment.pay_flag=3 and l_payment.s<0 then l_svp:=-l_payment.s;
            when l_payment.pay_flag=4 and l_payment.s<0 then l_rsk:=-l_payment.s;
            when l_payment.pay_flag=5 and l_payment.s<0 then l_rspe:=-l_payment.s;
            else if l_payment.s<0 then l_sd:=-l_payment.s; end if;
          end case;
        end if;
        if l_psnt+l_pspt+l_psk+l_pspe+l_rsnt+l_rspt+l_svp+l_rsk+l_rspe+l_sd+l_i_vp>0 then
          merge into cim_credgraph_tmp t using dual on (t.dat=l_payment.dat)
          when matched then
            update set psnt=psnt+l_psnt, pspt=pspt+l_pspt, psk=psk+l_psk, pspe=pspe+l_pspe, svp=svp+l_svp, sd=sd+l_sd,
                       rsnt=rsnt+l_rsnt, rspt=rspt+l_rspt, rsk=rsk+l_rsk, rspe=rspe+l_rspe,
                       i_rp=decode(l_payment.r,1,1,i_rp), i_vp=decode(l_i_vp,1,1,i_vp)
          when not matched then
            insert (dat, psnt, rsnt, pspt, rspt, psk, rsk, pspe, rspe, zt, dt, smp, sp, svp, zp,
                    sd, zpnbu, i_rp, i_vp, kp, percent, percent_nbu, percent_base, z, t_delay, p_delay, get_day, pay_day, adaptive)
            values (l_payment.dat, l_psnt, l_rsnt, l_pspt, l_rspt, l_psk, l_rsk, l_pspe, l_rspe, 0, 0, 0, 0, l_svp, 0,
                    l_sd, 0, l_payment.r, l_i_vp, null, pr.percent, pr.percent_nbu, pr.percent_base, pr.z,
                    pr.payment_delay, pr.percent_delay, pr.get_day, pr.pay_day, pr.adaptive);
        end if;
        fetch c_payment into l_payment;
      end loop;

      if l_n1=1 then l_i_vp:=2;
                     if pr.payment_period=6 then l_n2:=null; else l_n2:=1; end if;
                     l_dat:=pr.end_date; l_bdat:=l_dat;
      else
        case pr.percent_period
          when 1 then l_i_vp:=1;
          when 2 then if to_number(to_char(l_dat,'MM')) in (1,4,7,10) then l_i_vp:=1; else l_i_vp:=0; end if;
          when 3 then if mod(l_n-l_n1+1,6)=0 then l_i_vp:=1; else l_i_vp:=0; end if;
          when 4 then if mod(l_n-l_n1+1,12)=0 then l_i_vp:=1; else l_i_vp:=0; end if;
          when 14 then if to_char(l_dat,'DD/MM')='01/01' then l_i_vp:=1; else l_i_vp:=0; end if;
          else l_i_vp:=0;
        end case;
        case pr.payment_period
          when 1 then l_n2:=l_kp; l_kp:=l_kp-1;
          when 2 then if to_number(to_char(l_dat,'MM')) in (1,4,7,10) then l_n2:=l_kp; l_kp:=l_kp-1; else l_n2:=null; end if;
          when 3 then if mod(l_n-l_n1+1,6)=0 then l_n2:=l_kp; l_kp:=l_kp-1; else l_n2:=null; end if;
          when 4 then if mod(l_n-l_n1+1,12)=0 then l_n2:=l_kp; l_kp:=l_kp-1; else l_n2:=null; end if;
          when 14 then if to_char(l_dat,'DD/MM')='01/01' then l_n2:=l_kp; l_kp:=l_kp-1; else l_n2:=null; end if;
          else l_n2:=null;
        end case;
      end if;
      merge into cim_credgraph_tmp t using dual on (t.dat=l_dat)
        when matched then update set i_vp=decode(l_i_vp,0,i_vp,l_i_vp), kp=l_n2
        when not matched then
          insert (dat,  psnt, rsnt, pspt, rspt, psk, rsk, pspe, rspe, zt, dt, smp, sp, svp, zp, sd, zpnbu, i_rp, i_vp, kp,
                  percent, percent_nbu, percent_base, z, t_delay, p_delay, get_day, pay_day, adaptive)
          values (l_dat, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, l_i_vp, l_n2,
                  pr.percent, pr.percent_nbu, pr.percent_base, pr.z, pr.payment_delay, pr.percent_delay, pr.get_day, pr.pay_day, pr.adaptive);
      l_dat:=add_months(l_dat,1); l_n1:=l_n1-1;
    end loop;
  end loop;
  close c_payment;

  --------------------------------------------------------------
  l_dat:=l_begin_date; l_zp:=0; l_spp:=0; l_spnbu:=0; l_zpnbu:=0; l_sps:=0; l_zt:=0; l_pzt:=0; l_dt:=0; l_dt_m:=0;
  l_dp:=0; l_dp_m:=0; l_m:=to_char(l_begin_date,'MMYYYY'); l_last_rsnt:=0; l_last_rspt:=0; l_sd:=0; l_bt:=0; l_ft:=0; l_smps:=0;

  x_zp:=0; x_spp:=0; x_sps:=0; x_zt:=0; x_pzt:=0; x_last_rsnt:=0; x_last_rspt:=0; x_bt:=0;
  for t in c_tmp loop
    if t.dat>=l_dat then
      case t.percent_base
        when 1 then if mod(to_number(to_char(l_dat,'yyyy')),4)=0 then l_dy:=366; else l_dy:=365; end if;
        when 2 then l_dy:=360;
        when 3 then l_dy:=364;
        when 4 then l_dy:=365;
        when 5 then l_dy:=360;
      end case;

      ---------Розрахунок процентів-------------
      if t.percent_base=5 then
        l_sp:=l_zt*t.percent*months_between(last_day(t.dat),last_day(l_dat))*30/l_dy/100;
        l_spnbu:=l_spnbu+round(l_zt*t.percent_nbu*months_between(last_day(t.dat),last_day(l_dat))*30/l_dy/100,0);
      else
        l_sp:=l_zt*t.percent*(t.dat-l_dat)/l_dy/100;
        l_spnbu:=l_spnbu+round(l_zt*t.percent_nbu*(t.dat-l_dat)/l_dy/100,0);
        if t.get_day=0 then
          l_sp:=l_sp-l_last_rsnt*t.percent/l_dy/100;
          l_spnbu:=l_spnbu-round(l_last_rsnt*t.percent_nbu/l_dy/100,0);
        end if;
        if t.pay_day=1 then
          l_sp:=l_sp+l_last_rspt*t.percent/l_dy/100;
          l_spnbu:=l_spnbu+round(l_last_rspt*t.percent_nbu/l_dy/100,0);
        end if;
      end if;

      if l_spnbu<0 then l_spnbu:=0;
      else
      --  t.i_vp>0 or t.i_rp=1 then l_zpnbu:=l_zpnbu+l_spnbu; l_spnbu:=0;
        l_zpnbu:=l_zpnbu+l_spnbu; l_spnbu:=0;
      end if;
      if l_sp<0 then l_sp:=0; else l_sps:=l_sps+l_sp; end if;
      if l_sps>0 and t.i_vp>0 then
        insert into cim_credgraph_delay (dat, s, v_dat, i) values (t.dat, l_sps, add_months(t.dat,t.p_delay), 1); l_sps:=0;
      end if;
      if t.i_vp=2 then
        select nvl(sum(s),0) into l_spp from cim_credgraph_delay where i=1; delete from cim_credgraph_delay where i=1;
      else
        select nvl(sum(s),0) into l_spp from cim_credgraph_delay where v_dat<=t.dat and i=1;
        delete from cim_credgraph_delay where v_dat<=t.dat and i=1;
      end if;
      l_spp:=round(l_spp,0);
      if l_zp<0 then
        l_spp:=l_zp+l_spp; l_zp:=l_spp-t.svp; if l_spp<0 then l_spp:=0; end if;
      else
        l_zp:=l_zp+l_spp-t.svp;
      end if;
      if t.dat<bankdate then
        if to_char(t.dat,'MMYYYY')=l_m and t.i_vp!=2 then
          l_dp_m:=l_dp_m+l_spp;
        else
          if t.i_vp=2 then l_dp_m:=0; else l_dp_m:=l_spp; end if;
          --l_m:=to_char(t.dat,'MMYYYY');
        end if;
        l_dp:=l_zp-l_dp_m; if l_dp<0 then l_dp:=0; end if;
      end if;
     ---------Розрахунок погашення тіла-------------
      l_snt:=t.rsnt; if t.dat>=bankdate and t.psnt>l_snt then l_snt:=t.psnt; end if; l_last_rsnt:=l_snt;
      if t.i_vp=2 then
        select nvl(sum(s),0) into l_spt from cim_credgraph_delay where i=0; delete from cim_credgraph_delay where i=0;
      else
        select nvl(sum(s),0) into l_spt from cim_credgraph_delay where v_dat<=t.dat and i=0;
        delete from cim_credgraph_delay where v_dat<=t.dat and i=0;
      end if;
      if t.kp is not null then l_pspt:=round((l_pzt-t.pspt-t.z)/t.kp,0); if l_pspt<0 then l_pspt:=0; end if;
        else l_pspt:=t.pspt;
        --elsif t.dat>=bankdate then l_pspt:=t.pspt; else l_pspt:=0;
      end if;
      if t.kp is not null then
        if l_bt>0 then
          case t.adaptive
            when 0 then s:=l_bt;
            when 1 then s:=round(l_bt/t.kp,0);

          end case;
          if s>l_pspt then s:=l_pspt; end if; l_bt:=l_bt-s; l_pspt:=l_pspt-s; l_pzt:=l_pzt-s;
        end if;

        if l_pspt>0 and t.t_delay>0 and t.i_vp!=2 then
          insert into cim_credgraph_delay (dat, s, v_dat, i) values (t.dat, l_pspt, add_months(t.dat,t.t_delay), 0);
          l_pspt:=0;
        end if;
      else
        s:=0;
      end if;
      ss:=0; if t.rspt>0 then ss:=l_pzt-t.pspt-l_spt-l_zt+t.rspt-l_bt; else ss:=0; end if;
      if t.t_delay=0 then ss:=ss-l_pspt; end if; if ss>0 then l_bt:=l_bt+ss; end if;
      l_pspt:=l_spt+l_pspt;

      if t.dat<bankdate then
        --l_dt:=l_dt+l_pspt-t.rspt; if l_dt<0 then l_dt:=0; end if;
        l_spt:=t.rspt;
      else
        if l_pspt+s<t.rspt then l_spt:=t.rspt; else l_spt:=l_pspt; end if;
      end if;
      l_ft:=l_ft+l_snt-l_pspt; if t.rspt>0 and ss>0 then l_ft:=l_ft-ss; end if;
      l_zt:=l_zt+l_snt-l_spt; l_pzt:=l_pzt+l_snt-l_pspt; l_last_rspt:=l_spt;

      if t.dat<bankdate then
        if to_char(t.dat,'MMYYYY')=l_m and t.i_vp!=2 then
          l_dt_m:=l_dt_m+l_pspt;
        else
          if t.i_vp=2 then l_dt_m:=0; else l_dt_m:=l_pspt; end if;
          l_m:=to_char(t.dat,'MMYYYY');
        end if;
        l_dt:=l_zt-l_pzt-l_dt_m; if l_dt<0 then l_dt:=0; end if;
      end if;

      ---------Розрахунок процентів без майбутніх надходжень-------------
      if t.percent_base=5 then
        x_sp:=x_zt*t.percent*months_between(last_day(t.dat),last_day(l_dat))*30/l_dy/100;
      else
        x_sp:=x_zt*t.percent*(t.dat-l_dat)/l_dy/100;
        if t.get_day=0 then
          x_sp:=x_sp-x_last_rsnt*t.percent/l_dy/100;
        end if;
        if t.pay_day=1 then
          x_sp:=x_sp+x_last_rspt*t.percent/l_dy/100;
        end if;
      end if;
      if x_sp<0 then x_sp:=0; else x_sps:=x_sps+x_sp; end if;
      if x_sps>0 and t.i_vp>0 then
        insert into cim_credgraph_delay (dat, s, v_dat, i) values (t.dat, x_sps, add_months(t.dat,t.p_delay), 3); x_sps:=0;
      end if;
      if t.i_vp=2 then
        select nvl(sum(s),0) into x_spp from cim_credgraph_delay where i=3; delete from cim_credgraph_delay where i=3;
      else
        select nvl(sum(s),0) into x_spp from cim_credgraph_delay where v_dat<=t.dat and i=3;
        delete from cim_credgraph_delay where v_dat<=t.dat and i=3;
      end if;
      x_spp:=round(x_spp,0);
      if x_zp<0 then
        x_spp:=x_spp+x_zp; x_zp:=x_spp-t.svp; if x_spp<0 then x_spp:=0; end if;
      else
        x_zp:=x_zp+x_spp-t.svp;
      end if;

      ---------Розрахунок погашення тіла без майбутніх надходжень-------------
      x_snt:=t.rsnt; x_last_rsnt:=x_snt;
      if t.i_vp=2 then
        select nvl(sum(s),0) into x_spt from cim_credgraph_delay where i=2; delete from cim_credgraph_delay where i=2;
      else
        select nvl(sum(s),0) into x_spt from cim_credgraph_delay where v_dat<=t.dat and i=2;
        delete from cim_credgraph_delay where v_dat<=t.dat and i=2;
      end if;
      if t.kp is not null then x_pspt:=round((x_pzt-t.pspt-t.z)/t.kp,0); if x_pspt<0 then x_pspt:=0; end if; else x_pspt:=0; end if;
      if t.kp is not null then
        if x_bt>0 then
          case t.adaptive
            when 0 then s:=x_bt;
            when 1 then s:=round(x_bt/t.kp,0);
          end case;
          if s>x_pspt then s:=x_pspt; end if; x_bt:=x_bt-s; x_pspt:=x_pspt-s; x_pzt:=x_pzt-s;
        end if;

        if x_pspt>0 and t.t_delay>0 and t.i_vp!=2 then
          insert into cim_credgraph_delay (dat, s, v_dat, i) values (t.dat, x_pspt, add_months(t.dat,t.t_delay), 2);
          x_pspt:=0;
        end if;
      else
        s:=0;
      end if;
      ss:=0; if t.rspt>0 then ss:=x_pzt-t.pspt-x_spt-x_zt+t.rspt-x_bt; else ss:=0; end if;
      if t.t_delay=0 then ss:=ss-x_pspt; end if; if ss>0 then x_bt:=x_bt+ss; end if;
      x_pspt:=x_spt+x_pspt;

      if t.dat<bankdate or x_pspt+s<t.rspt then x_spt:=t.rspt; else x_spt:=x_pspt; end if;
      --x_ft:=x_ft+x_snt-x_pspt; if t.rspt>0 then x_ft:=x_ft-x_bt; end if;
      x_zt:=x_zt+x_snt-x_spt; x_pzt:=x_pzt+x_snt-x_pspt; x_last_rspt:=x_spt; l_smps:=l_smps+l_sp;
      l_sd:=l_sd+t.sd+t.rsk+t.rspe; l_dat:=t.dat;
      update cim_credgraph_tmp set
        smp=round(l_sp,3), smps=round(l_smps,3), sp=l_spp, zp=l_zp, zpnbu=l_zpnbu, dp=l_dp,
        pspt=l_pspt, bt=l_bt, pzt=l_ft, zt=l_zt,
        xsp=x_spp, xpspt=x_pspt, sd=l_sd, dt=l_dt, dy=l_dy
      where dat=l_dat;
      l_pspt:=0;
    end if;
  end loop;

  select count(*), sum(psnt), sum(rsnt), sum(pspt), sum(rspt), sum(smp), sum(sp), sum(svp), sum(bt)
    into     l_n1,    l_psnt,    l_rsnt,    l_pspt,    l_rspt,    l_spp,    l_sp,      l_n,    l_bt
    from cim_credgraph_tmp;
  if l_n1>0 then
    insert into cim_credgraph_tmp
               (dat, psnt, rsnt, pspt, rspt, psk, rsk, pspe, rspe, zt, dt, bt, pzt,
                dp, smp, smps, sp, svp, zp, sd, zpnbu,
                i_rp, i_vp, kp, percent, percent_nbu, percent_base, z, t_delay, p_delay, get_day, pay_day, adaptive)
        values (to_date('01.01.3000','DD.MM.YYYY'), l_psnt, l_rsnt, l_pspt, l_rspt, 0, 0, 0, 0, l_zt, l_dt, l_bt, l_pzt,
                l_dp, l_spp, round(l_smps,3), l_sp, l_n, l_zp, l_sd, l_zpnbu,
                null, null, null, null, null, null, null, null, null, null, null, null);
  end if;
  commit;
end create_credgraph;

-- get_credcontract_info - Одержання інформації по кредитному контракту
--
procedure get_credcontract_info (p_contr_id in number, --id контракту
                                 p_date in date, --дата надання інформації
                                 p_percent out number, -- Нараховані відсотки
                                 p_percent_nbu out number, -- Нараховані відсотки НБУ
                                 p_percent_over out number, -- Прострочені відсотки
                                 p_credit_over out number -- Прострочена заборгованість по тілу
                                )
is
  l_dat1 date;
  l_dat2 date;
  l_p1 number;
  l_p2 number;
  l_pnbu1 number;
  l_pnbu2 number;
  l_n number;
begin
  --create_credgraph(p_contr_id);
  select count(*), round(nvl(max(smps),0)/100,2), round(nvl(max(zpnbu),0)/100,2), round(nvl(max(dp),0)/100,2), round(nvl(max(dt),0)/100,2)
    into l_n, p_percent, p_percent_nbu, p_percent_over, p_credit_over
    from cim_credgraph_tmp where dat=p_date;
  if l_n !=1 then
    select max(dat) into l_dat1 from cim_credgraph_tmp where dat<p_date;
    select min(dat) into l_dat2 from cim_credgraph_tmp where dat>p_date;
    if l_dat1 is not null and l_dat2 is not null then
      select nvl(smps,0), nvl(zpnbu,0), round(nvl(dp,0)/100,2), round(nvl(dt,0)/100,2) into l_p1, l_pnbu1, p_percent_over, p_credit_over
        from cim_credgraph_tmp where dat=l_dat1;
      select nvl(smps,0), nvl(zpnbu,0) into l_p2, l_pnbu2 from cim_credgraph_tmp where dat=l_dat2;
      p_percent:=nvl(round((l_p1+(l_p2-l_p1)*(p_date-l_dat1)/(l_dat2-l_dat1))/100,2),0);
      p_percent_nbu:=nvl(round((l_pnbu1+(l_pnbu2-l_pnbu1)*(p_date-l_dat1)/(l_dat2-l_dat1))/100,2),0);
    end if;
  end if;
end get_credcontract_info;

-- bound_payment- Прив'язка платежу до контракту
--
function bound_payment(p_payment_type in number, -- Тип платежу
                        p_pay_flag in number, -- Класифікатор платежу (0 ..6)
                        p_direct in number, -- Напрям платежу (0 - вхідні, 1 - вихідні)
                        p_ref in number, -- Референс документу
                        p_contr_id in number, -- Ідентифікатор контракту
                        p_s_vp in number, -- Сума прив'язки у валюті платежу
                        p_comiss in number, -- Комісія
                        p_rate in number, -- Курс
                        p_s_vc in number, -- Сума прив'язки у валюті контракту
                        p_top_id in number, -- Тип операції
                        p_comments in varchar2 :=null,-- Коментар
                        p_subject in number := null, -- Предмет оплати (0 - товари, 1 - послуги)
                        p_service_code in varchar2 :=null, -- Код класифікатора послуг
                        ----------------------------------------------------------------------
                        p_kv in number :=null, -- Код валюти платежу
                        --p_bank_date in date :=null, --  Банківська дата створення
                        p_val_date in date :=null, -- Дата валютування
                        p_details in varchar2 :=null, -- Призначення платежу
                        ----------------------------------------------------------------------
                        p_rnk in number :=null, -- RNK  резидента
                        p_benef_id in number :=null, -- id нерезидента
                        p_c_num varchar2 :=null, --Номер контракту
                        p_c_date date :=null --Дата контракту
                       ) return number
is l_vc                      number; -- Валюта контракту
   l_contr_type              number; -- Тип контракту
   l_rnk                     number; -- rnk клієнта
   l_benef_id                number; -- id бенефіціара
   l_branch                  varchar2(30); -- Код установи
   l_contr_s                 number; --сума контракту
   l_status                  number; --статус контрату


   l_s                       number; -- Cума платежу
   l_vp                      number; -- Валюта платежу
   l_sos                     number; -- Стан документа

   l_sum_bound               number; -- Сума привязаних
   l_s_limit                 number; -- Ліміт для типу контракту 4
   l_open_date               date;   -- Дата видачі е-ліцензії (дата відкриття)

   l_n                       number;
   l_bound_id                number; -- id зв'язку
   l_direct                  number; -- Тип платежу (0 - вхідні, 1 - вихідні)
   l_s_unbound               number; -- Неприв'язана частина суми (реальна)
   l_s_unbound_x             number; -- Неприв'язана частина суми (з висячого зв'язку)
   l_subject_id              number; -- Предмет оплати (0 - товари, 1 - послуги)
   l_comments                varchar2(250); -- Коментар
   l_contr_arrears           number; -- Заборгованысть по кредиту
   l_val_date                date; -- Дата валютування

   l_fantom_id               number; -- id фантома
   l_okpo                    varchar2(14 byte);

   l_ape_id                  number;
   l_txt                     varchar2(4000);
begin
  if p_contr_id=0 then
    if p_payment_type>0 or p_ref is null then bars_error.raise_error(g_module_name, 44); end if;
    l_branch:=sys_context('bars_context', 'user_branch'); l_contr_type:=3;
  else
    select max(rnk), max(benef_id), max(kv), max(contr_type), max(branch), max(okpo), max(s), max(status_id), max(open_date)
      into l_rnk, l_benef_id, l_vc, l_contr_type, l_branch, l_okpo, l_contr_s, l_status, l_open_date
      from cim_contracts where contr_id=p_contr_id;
    if l_branch != sys_context('bars_context', 'user_branch') then bars_error.raise_error(g_module_name, 40); end if;
    if l_status=1 or l_status>8 then bars_error.raise_error(g_module_name, 6); end if;
    if p_direct=1 and p_comiss != 0 and l_contr_type != 2 and p_pay_flag != 3 then bars_error.raise_error(g_module_name, 51); end if;

    if p_s_vp <=0 or l_contr_type != 2 and p_pay_flag>1 or
      l_contr_type=2 and (p_pay_flag<2 or p_pay_flag=3 and p_direct=0) or
      l_contr_type=0 and p_pay_flag=0 and p_direct=1 or l_contr_type=1 and p_pay_flag=0 and p_direct=0
      or p_s_vc<=0 or p_rate<=0 or p_direct is null or p_direct>1
    then bars_error.raise_error(g_module_name, 41); end if;
    if round((p_s_vp+p_comiss)*p_rate,2) != p_s_vc and round(p_s_vc/(p_s_vp+p_comiss),8) != p_rate then
      bars_error.raise_error(g_module_name, 47);
    end if;
    if l_contr_type=2 and p_direct=1 and p_pay_flag=2 then
      select nvl(sum(decode(direct, 0, s_vk,0)),0)-nvl(sum(decode(direct, 1, s_vk,0)),0) into l_contr_arrears
        from v_cim_bound_payments where pay_flag = 2 and contr_id = p_contr_id;
      if (p_s_vp+p_comiss)*p_rate-l_contr_arrears>=0.01 then bars_error.raise_error(g_module_name, 50); end if;
    end if;
--    if l_contr_type<2 and (p_subject is null or p_subject=1 and p_service_code is null) then bars_error.raise_error(g_module_name, 48); end if;
    if l_contr_type=1 then select max(subject_id) into l_subject_id from cim_contracts_trade where contr_id=p_contr_id; end if;
  end if;

  l_txt:='';
  if l_contr_type=2 then
    if p_direct=0 and p_pay_flag=2 then l_txt:=' Надходження. ';
    elsif p_pay_flag=2 then l_txt:=' Погашення тіла. ';
    elsif p_pay_flag=3 then l_txt:=' Погашення процентів. ';
    end if;
  end if;
  --l_txt:=l_txt||' Платіж прив`язано до контракту '||p_contr_id||' (id прив`язки:';

  if p_ref is null then
    if p_payment_type=0 then bars_error.raise_error(g_module_name, 45);
    else -- Створення та прив'язка фантому
      select bars_sqnc.get_nextval('s_cim_fantom_payments') into l_fantom_id from dual;
      insert into cim_fantom_payments (fantom_id, rnk, benef_id, direct, payment_type, oper_type, val_date, kv, s, details)
        values (l_fantom_id, l_rnk, l_benef_id, p_direct, p_payment_type, p_top_id,p_val_date, p_kv, round(p_s_vp*100,0)/*<>*/,
                p_details);
      select bars_sqnc.get_nextval('s_cim_fantoms_bound') into l_bound_id from dual;
      insert into cim_fantoms_bound (bound_id, direct, fantom_id, contr_id, pay_flag, s, s_cv, rate, comiss, comments, journal_num)
        values (l_bound_id, p_direct, l_fantom_id, p_contr_id, p_pay_flag, round(p_s_vp*100,0),
               p_s_vc*100, (case when l_vc=p_kv then 1 else p_rate end),
               round(p_comiss*100,0), l_txt||decode(p_payment_type, 5, 'Взаємозалік. ','')||p_comments,
               decode(l_contr_type, 0, 1, 1, 2, 2, decode(p_payment_type, 11, null, 4), 4));
      l_val_date:=p_val_date;
    end if;
  else -- Прив'язка реального платежку або фантому
    if p_payment_type=0 then -- Реальні платежі
      select max(kv), max(s), max(sos), max(vdat) into l_vp, l_s, l_sos, l_val_date from v_cim_oper where ref=p_ref;
      select l_s-nvl(sum(s),0) into l_s_unbound from cim_payments_bound where delete_date is null and contr_id is not null and ref=p_ref;
      select count(*), max(bound_id), sum(s), max(direct) into l_n, l_bound_id, l_s_unbound_x, l_direct
        from cim_payments_bound where delete_date is null and contr_id is null and ref=p_ref;
      if l_n>1 or l_direct!=p_direct or l_n=1 and l_s_unbound_x!=l_s_unbound then bars_error.raise_error(g_module_name, 42); end if;

      l_comments:=p_comments;
      if p_s_vp*100>l_s_unbound or p_s_vp=0 then bars_error.raise_error(g_module_name, 43);
      else
        if l_contr_type = 4 then
          select nvl(sum(b.s_cv),0)
          into   l_sum_bound
          from cim_payments_bound b
          where b.contr_id = p_contr_id;

          begin
            select to_number(par_value)*100 into l_s_limit from cim_params where par_name='LIMIT_CONTR_EL_LIC';
            bars_audit.debug(g_module_name||' Прив`язка платежу. bound_id:'||l_bound_id||' l_sum_bound+p_s_vc: '||(l_sum_bound+p_s_vc*100)||' l_s_limit: '||l_s_limit);
            if val_convert(l_open_date, l_sum_bound+p_s_vc*100, l_vc, 840) > l_s_limit then
              bars_error.raise_error(g_module_name, 104);
            end if;
            exception
              when NO_DATA_FOUND then
                   bars_error.raise_error(g_module_name, 103);
          end;
          --if l_sum_bound+
        end if;
        if p_s_vp*100<l_s_unbound and (l_sos=5 or f_check_visa_status(p_ref)=0) then
            insert into cim_payments_bound (direct, ref, s, branch, pay_flag)
              values (p_direct, p_ref, round((l_s_unbound-p_s_vp*100),0), l_branch, 0);
    --      l_comments:='Загальна сума платежу:'||to_char(l_s/100,'999999999999.99')||'; '||p_comments;
        end if;
        if p_s_vp*100<l_s then
          l_comments:='Загальна сума платежу:'||to_char(l_s/100,'999999999999.99')||'; '||p_comments;
        end if;
        if l_n=1 then -- Реальні платежі з неприв`язаним залишком
          update cim_payments_bound
            set contr_id=p_contr_id, pay_flag=decode(p_contr_id,0,0,p_pay_flag), s=round(p_s_vp*100,0),
                s_cv=decode(p_contr_id, 0, 0, p_s_vc*100),
                rate=decode(p_contr_id,0,null,(case when l_vc=l_vp then 1 else p_rate end)), comiss=round(p_comiss*100,0),
                create_date=bankdate, modify_date=bankdate, branch=l_branch,
                comments=l_comments, journal_num=decode(l_contr_type, 0, 1, 1, 2, 4)
            where bound_id=l_bound_id;
        else -- Реальні платежі без неприв`язаного залишку
          select bars_sqnc.get_nextval('s_cim_payments_bound') into l_bound_id from dual;
          insert into cim_payments_bound (bound_id, direct, ref, contr_id, pay_flag, s, s_cv, rate, comiss, comments, branch, journal_num)
            values (l_bound_id, p_direct, p_ref, p_contr_id, decode(p_contr_id,0,0,p_pay_flag), round(p_s_vp*100,0),
            decode(p_contr_id,0,0, round(p_s_vc*100,0)), --(case when l_vc=l_vp then round(p_s_vp*100,0) else round(p_s_vc*100,0) end)),
            decode(p_contr_id,0,null,(case when l_vc=l_vp then 1 else p_rate end)), round(p_comiss*100,0), l_comments, l_branch,
            decode(l_contr_type, 0, 1, 1, 2, 4));
        end if;
        if l_sos != 5 then insert into cim_unheld_que (bound_id, ref, contr_id, vdat) values (l_bound_id, p_ref, p_contr_id, l_val_date); end if;
      end if;
      merge into operw o
        using dual d
        on (o.tag= /*cim_mgr.g_opertype_tag */ 'CIMTO' and o.ref=p_ref)
        when matched then update set value=to_char(p_top_id)
        when not matched then insert(ref, tag, value) values (p_ref, /*cim_mgr.g_opertype_tag */'CIMTO',to_char(p_top_id));
      if p_contr_id=0 then
        if p_rnk is null or p_benef_id is null then bars_error.raise_error(g_module_name, 46); end if;
        insert into cim_bound_data (bound_id, rnk, benef_id, c_num, c_date) values (l_bound_id, p_rnk, p_benef_id, p_c_num, p_c_date);
      else
        update cim_payments_bound set comments=substr(l_txt||comments,1,3999)
          where delete_date is not null and ref=p_ref;
      end if;
    else -- Фантомні платежі
      select max(kv), max(s), max(val_date) into l_vp, l_s, l_val_date from cim_fantom_payments where fantom_id=p_ref;
      select count(*), max(bound_id), sum(s), max(direct) into l_n, l_bound_id, l_s_unbound, l_direct
        from cim_fantoms_bound where delete_date is null and contr_id is null and fantom_id=p_ref;
      if l_n<1 or l_n>1 or l_direct!=p_direct then bars_error.raise_error(g_module_name, 42); end if;
      if p_s_vp>l_s_unbound then bars_error.raise_error(g_module_name, 43);
      else
        if p_s_vp*100<l_s_unbound then
            insert into cim_fantoms_bound (direct, fantom_id, s, branch, pay_flag)
              values (p_direct, p_ref, round((l_s_unbound-p_s_vp*100),0), l_branch, 0);
            l_comments:='Загальна сума платежу:'||to_char(l_s/100,'999999999999.99')||'; '||p_comments;
        else l_comments:=p_comments;
        end if;
        update cim_fantoms_bound
          set contr_id=p_contr_id, pay_flag=p_pay_flag, s=round(p_s_vp*100,0),
              s_cv=round(p_s_vc*100,0),--(case when l_vc=l_vp then round(p_s_vp*100,0) else round(p_s_vc*100,0) end),
              rate=(case when l_vc=l_vp then 1 else p_rate end), comiss=round(p_comiss*100,0), create_date=bankdate, modify_date=bankdate,
              branch=l_branch,
              journal_num=decode(l_contr_type, 0, 1, 1, 2, 2, decode(p_payment_type, 11, null, 4), 4),
              comments=decode(p_payment_type, 5, 'Взаємозалік. ','')||l_comments
          where bound_id=l_bound_id;
      end if;
      update cim_fantom_payments set oper_type=p_top_id where fantom_id=p_ref;

      update cim_fantoms_bound set comments=substr(l_txt||comments,1,3999) where delete_date is not null and fantom_id=p_ref;
    end if;
  end if;

 if p_contr_id!=0 and l_contr_type=2 and p_pay_flag=2 then
    delete from cim_credgraph_payment where s>0 and dat<=l_val_date and contr_id=p_contr_id;
    select sum(s) into l_s_unbound from cim_credgraph_payment where pay_flag=2 and dat>l_val_date and contr_id=p_contr_id;
    select s_in_pl-s_out_pl into l_s from v_cim_credit_contracts where contr_id=p_contr_id;
    if p_direct=0 then l_s:=l_s+p_s_vc; else l_s:=l_s-p_s_vc; end if;
    if (l_s+l_s_unbound)<0 or (l_s+l_s_unbound)>l_contr_s then
      delete from cim_credgraph_payment where pay_flag=2 and dat>l_val_date and contr_id=p_contr_id;
    end if;
  end if;

  if p_direct=1 then
    update cim_license_link set payment_id=decode(p_payment_type,0,l_bound_id,null), fantom_id=decode(p_payment_type,0,null,l_bound_id)
      where delete_date is null and payment_id is null and fantom_id is null and okpo=l_okpo;
  end if;
  if l_contr_type=1 and p_subject=1 and p_direct=1 then
    select count(*), max(l.ape_id) into l_n, l_ape_id
      from cim_ape_link l, (select ape_id from cim_contracts_ape where contr_id=p_contr_id) a
      where l.delete_date is null and l.payment_id is null and l.fantom_id is null and l.ape_id=a.ape_id;
    if l_n>1 then bars_error.raise_error(g_module_name, 17);
    elsif l_n=1 then
      update cim_ape_link set payment_id=decode(p_payment_type,0,l_bound_id,null), fantom_id=decode(p_payment_type,0,null,l_bound_id)
        where delete_date is null and payment_id is null and fantom_id is null and ape_id=l_ape_id;
    else
      -- Раніше створених невидалених прив'язок до актів бути не може!
      insert into cim_ape_link (payment_id, fantom_id, service_code)
        values (decode(p_payment_type,0,l_bound_id,null), decode(p_payment_type,0,null,l_bound_id), p_service_code);
    end if;
    delete from cim_ape_link
    where payment_id is null and fantom_id is null
          and ape_id in (select ape_id from cim_contracts_ape where contr_id=p_contr_id);
  end if;
  if p_contr_id != 0 and l_contr_type<2 then check_contract_status(p_contr_id); end if;
  bars_audit.info(g_module_name||' Прив`язка платежу. bound_id:'||l_bound_id||' payment_type:'||p_payment_type||' ref: '||p_ref||
                  ' contr_id:'||p_contr_id||' s_vp:'||p_s_vp||' comiss:'||p_comiss||' rate:'||p_rate||' s_vc:'||p_s_vc||' val_date: '||l_val_date||
                  ' pay_flag:'||p_pay_flag);
  return l_bound_id;
end bound_payment;

-- unbound_payment- Відв'язка платежу від контракту
--
procedure unbound_payment(p_payment_type in number, -- Тип платежу
                          p_bound_id in number, -- id зв`язку
                          p_comments in varchar2 -- Коментар
                         )
is
  l_n number;
  l_ref number;
  l_s number; -- Cума прив`язки
  l_sos number; -- Стан документу
  l_branch varchar2(30); -- Код установи
  l_service_branch varchar2(30); -- Відділення, відповідальне за прийом первинних документів
  l_direct number;
  l_contr_id number;
  l_status number;

  l_visa number;
  l_txt varchar2(4000);
begin
  if p_payment_type=0 then
    select count(*), max(ref), max(s), max(branch), max(direct), max(contr_id) into l_n, l_ref, l_s, l_branch, l_direct, l_contr_id
      from cim_payments_bound where delete_date is null and bound_id=p_bound_id;
    if l_n=1 then
      select c.branch, c.service_branch,  c.status_id
      into l_branch, l_service_branch, l_status
      from cim_contracts c where c.contr_id = l_contr_id;
      if l_status=1 or l_status>8 then bars_error.raise_error(g_module_name, 6); end if;
      --if l_branch != sys_context('bars_context', 'user_branch') then bars_error.raise_error(g_module_name, 40); end if;
      if not (l_branch = sys_context('bars_context', 'user_branch') or l_service_branch = sys_context('bars_context', 'user_branch')) then
        bars_error.raise_error(g_module_name, 40);
      end if;
      select max(sos) into l_sos from oper where ref=l_ref;
      select count(*) into l_n from cim_link where delete_date is null and payment_id=p_bound_id;
      if l_n>0 then bars_error.raise_error(g_module_name, 53); end if;
      check_visa_status(l_ref, l_visa, l_txt);
      if l_visa<2 then
        select count(*) into l_n from cim_payments_bound where delete_date is null and contr_id is null and ref=l_ref;
        if l_n=1 then
          update cim_payments_bound set s=s+l_s where delete_date is null and contr_id is null and ref=l_ref;
        else
          insert into cim_payments_bound (direct, ref, s, branch, pay_flag, s_cv) values (l_direct, l_ref, l_s, l_branch, 0, 0);
        end if;
--        merge into cim_payments_bound b where delete_date is null and contr_id is null and ref=l_ref;
  --        using (select direct, ref, s, branch from cim_payments_bound where bound_id=p_bound_id) a
    --      on (b.delete_date is null and b.contr_id is null and b.ref=l_ref)
      --    when matched then update set b.s=b.s+l_s
        --  when not matched then insert (direct, ref, s, branch, pay_flag) values (a.direct, a.ref, a.s, a.branch, 0);
      end if;
      update cim_payments_bound set delete_date=bankdate, modify_date=bankdate, uid_del_bound=user_id,
             comments=comments||' Видалено. '||p_comments
        where bound_id=p_bound_id;
      delete from cim_unheld_que where bound_id=p_bound_id;
      update cim_license_link set delete_date=bankdate, delete_uid=user_id where delete_date is null and payment_id=p_bound_id;
      update cim_conclusion_link set delete_date=bankdate, delete_uid=user_id where delete_date is null and payment_id=p_bound_id;
    else bars_error.raise_error(g_module_name, 49);
    end if;
  else
    select count(*), max(fantom_id), max(s), max(branch), max(direct), max(contr_id) into l_n, l_ref, l_s, l_branch, l_direct, l_contr_id
      from cim_fantoms_bound where delete_date is null and bound_id=p_bound_id;
    if l_n=1 then
      select c.branch, c.service_branch,  c.status_id
      into l_branch, l_service_branch, l_status
      from cim_contracts c where c.contr_id = l_contr_id;
      if l_status=1 or l_status>8 then bars_error.raise_error(g_module_name, 6); end if;
      --if l_branch != sys_context('bars_context', 'user_branch') then bars_error.raise_error(g_module_name, 40); end if;
      if not (l_branch = sys_context('bars_context', 'user_branch') or l_service_branch = sys_context('bars_context', 'user_branch')) then
        bars_error.raise_error(g_module_name, 40);
      end if;
      select count(*) into l_n from cim_link where delete_date is null and fantom_id=p_bound_id;
      if l_n>0 then bars_error.raise_error(g_module_name, 53); end if;
      select count(*) into l_n from cim_fantoms_bound where delete_date is null and contr_id is null and fantom_id=l_ref;
      if l_n=1 then
        update cim_fantoms_bound set s=s+l_s where delete_date is null and contr_id is null and fantom_id=l_ref;
      else
        insert into cim_fantoms_bound (direct, fantom_id, s, branch, pay_flag, s_cv) values (l_direct, l_ref, l_s, l_branch, 0, 0);
      end if;
--      merge into cim_fantoms_bound b
  --      using (select * from cim_fantoms_bound where bound_id=p_bound_id) a
    --    on (b.delete_date is null and b.contr_id is null and b.fantom_id=l_ref)
      --  when matched then update set b.s=b.s+l_s
        --when not matched then insert (direct, fantom_id, s, branch, pay_flag) values (a.direct, a.fantom_id, a.s, a.branch, 0);
      update cim_fantoms_bound set delete_date=bankdate, modify_date=bankdate, uid_del_bound=user_id,
             comments=comments||' Видалено. '||p_comments
        where bound_id=p_bound_id;
      update cim_license_link set delete_date=bankdate, delete_uid=user_id where delete_date is null and fantom_id=p_bound_id;
      update cim_conclusion_link set delete_date=bankdate, delete_uid=user_id where delete_date is null and fantom_id=p_bound_id;
    else bars_error.raise_error(g_module_name, 49);
    end if;
  end if;
  update cim_ape_link set delete_date=bankdate, delete_uid=user_id
    where delete_date is null and decode(p_payment_type,0,payment_id,fantom_id)=p_bound_id;
  if l_contr_id != 0 then check_contract_status(l_contr_id); end if;
  bars_audit.info(g_module_name||' Відв`язка платежу. bound_id:'||p_bound_id||' payment_type:'||p_payment_type);
end unbound_payment;

-- beck_fantom- видалення висячого неприв'язаного документу
--
procedure back_payment (p_doc_type in number, p_doc_id in number)
is
  l_bound_sum number;
begin
  select total_sum-unbound_sum into l_bound_sum from v_cim_unbound_payments where pay_type=p_doc_type and ref=p_doc_id;
  if l_bound_sum is null or l_bound_sum != 0 then bars_error.raise_error(g_module_name, 54); end if;
  if p_doc_type=0 then
    update cim_payments_bound set delete_date=bankdate, uid_del_bound=user_id where delete_date is null and contr_id is null and ref=p_doc_id;
  else
    update cim_fantoms_bound set delete_date=bankdate, uid_del_bound=user_id where delete_date is null and contr_id is null and fantom_id=p_doc_id;
  end if;
end back_payment;

-- bound_vmd- Прив'язка ВМД до контракту
--
function bound_vmd(p_vmd_type in number, -- Тип ВМД
                   p_ref in number, -- Референс ВМД
                   p_contr_id in number, -- Ідентифікатор контракту
                   p_s_vt in number, -- Сума прив'язки у валюті товару
                   p_rate in number :=null, -- Курс
                   p_s_vc in number :=null, -- Сума прив'язки у валюті контракту
                   p_doc_date in date :=null, -- Дата паперового носія
                   p_comments in varchar2 :=null,-- Коментар
                   ---------------------------------------------------------------------
                   p_num varchar2 :=null, --номер акта
                   p_kv in number :=null, -- Код валюти товару
                   p_allow_date in date :=null, -- Дата дозволу
                   ----------------------------------------------------------------------
                   p_rnk in number :=null, -- RNK  резидента
                   p_benef_id in number :=null, -- id нерезидента
                   p_c_num varchar2 :=null, --Номер контракту
                   p_c_date date :=null, --Дата контракту
                   p_file_name varchar2 :=null, -- Назва файлу реєстру
                   p_file_date date :=null --Дата файлу реєстру
                  ) return number
is
  l_n number;
  l_vc number; -- Валюта контракту
  l_contr_type number; -- Тип контракту
  l_rnk number; -- rnk клієнта
  l_benef_id number; -- id бенефіціара
  l_contract_num varchar2(60); --Номер контракту
  l_contract_date date; --Дата контракту
  l_branch varchar2(30); -- Код установи
  l_act_kind number; -- Вид Акту
  l_status number;

  l_act_id number; -- id Акту
  l_bound_id number; -- id зв'язку

  l_vt number; -- Валюта товару
  l_s number; -- Cума
  l_s_unbound number; -- Неприв'язана частина суми (реальна)
  l_direct number; -- Тип ВМД (0 - вхідні, 1 - вихідні
  l_vmd_branch varchar2(30);
  l_set_doc_date varchar2(2);
begin
  if p_vmd_type is null or p_contr_id is null or p_contr_id=0 or p_s_vt is null or p_rate is null or p_s_vc is null
    then bars_error.raise_error(g_module_name, 64); end if;
  select count(*), max(rnk), max(benef_id), max(kv), max(contr_type), max(branch),       max(num), max(open_date),  max(status_id)
    into      l_n,    l_rnk,    l_benef_id,    l_vc,    l_contr_type,    l_branch, l_contract_num, l_contract_date, l_status
    from cim_contracts where contr_id=p_contr_id;
  if l_n!=1 or p_s_vt<=0 or p_rate<=0 then bars_error.raise_error(g_module_name, 41); end if;
  if l_status=1 or l_status>8 then bars_error.raise_error(g_module_name, 6); end if;
  if l_branch!=sys_context('bars_context', 'user_branch') then bars_error.raise_error(g_module_name, 40); end if;
  if round(p_s_vt*p_rate,2) != p_s_vc and round(p_s_vc/p_rate,2) != p_s_vt then bars_error.raise_error(g_module_name, 47); end if;
  select kind into l_act_kind from cim_act_types where type_id=p_vmd_type;
  if p_ref is null then
    if p_vmd_type=0 then bars_error.raise_error(g_module_name, 61);
    else -- Створення та прив'язка Акту
      if l_contr_type=0 then l_direct:=1; elsif l_contr_type=1 then l_direct:=0; else bars_error.raise_error(g_module_name, 60); end if;
      select bars_sqnc.get_nextval('s_cim_acts') into l_act_id from dual;
      insert into cim_acts (act_id, direct, act_type, rnk, benef_id, num, kv, s, bound_sum, act_date, allow_date,
                                 contract_num, contract_date, file_name, file_date)
        values (l_act_id, l_direct, p_vmd_type, l_rnk, l_benef_id, p_num,  p_kv, round(p_s_vt*100,0), round(p_s_vt*100,0),
                p_doc_date, p_doc_date, l_contract_num, l_contract_date, decode(p_vmd_type, 4, p_file_name, null),
                decode(p_vmd_type, 4, p_file_date, null));
      select bars_sqnc.get_nextval('s_cim_act_bound') into l_bound_id from dual;
      insert into cim_act_bound (bound_id, direct, act_id, contr_id, s_vt, rate_vk, s_vk, comments, journal_num)
        values (l_bound_id, l_direct, l_act_id, p_contr_id, round(p_s_vt*100,0), (case when l_vc=p_kv then 1 else p_rate end),
               (case when l_vc=p_kv then round(p_s_vt*100,0) else round(p_s_vc*100,0) end), decode(p_vmd_type, 5, 'Взаємозалік. ','')||p_comments,
               decode(l_contr_type,0,1,null));
    end if;
  else -- Прив'язка існуючої ВМД або акту
    if p_vmd_type=0 then -- ВМД
      select kv, s, direct, cim_branch into l_vt, l_s, l_direct, l_vmd_branch from v_cim_customs_decl where cim_id=p_ref;
      if l_contr_type=0 and l_direct=0 or l_contr_type=1 and l_direct=1 then bars_error.raise_error(g_module_name, 60); end if;
      if l_vmd_branch is not null and l_vmd_branch!=l_branch then bars_error.raise_error(g_module_name, 62); end if;
      select l_s*100-nvl(sum(s_vt),0) into l_s_unbound from cim_vmd_bound where delete_date is null and vmd_id=p_ref;
      if p_s_vt*100>l_s_unbound or p_s_vt=0 then bars_error.raise_error(g_module_name, 43);
      else
        select bars_sqnc.get_nextval('s_cim_vmd_bound') into l_bound_id from dual;
        insert into cim_vmd_bound (bound_id, direct, vmd_id, contr_id, s_vt, rate_vk, s_vk, comments, journal_num)
        values (l_bound_id, l_direct, p_ref, p_contr_id, round(p_s_vt*100,0), (case when l_vc=p_kv then 1 else p_rate end),
               (case when l_vc=p_kv then round(p_s_vt*100,0) else round(p_s_vc*100,0) end), p_comments,
               decode(l_contr_type,0,1,null));
      end if;
      /*
      l_set_doc_date := '0';
      if p_doc_date is null and p_comments='Автоприв`язка МД' then
        select par_value into l_set_doc_date from cim_params where par_name='SET_MD_AUTOBOUND_DATE';
      end if; */
      update customs_decl set cim_date=allow_dat, --decode(l_set_doc_date, '1', allow_dat, p_doc_date),
                              cim_branch=l_branch, cim_boundsum=l_s*100-l_s_unbound+p_s_vt*100
        where cim_id=p_ref;
    else -- Акт
      select kv, s, direct into l_vt, l_s, l_direct from cim_acts where act_id=p_ref;
      if not (l_contr_type=0 and l_direct=1 or l_contr_type=1 and l_direct=0) then bars_error.raise_error(g_module_name, 60); end if;
      select l_s-nvl(sum(s_vt),0) into l_s_unbound from cim_act_bound where delete_date is null and act_id=p_ref;
      if p_s_vt*100>l_s_unbound or p_s_vt=0 then bars_error.raise_error(g_module_name, 43);
      else
        select bars_sqnc.get_nextval('s_cim_act_bound') into l_bound_id from dual;
        insert into cim_act_bound (bound_id, direct, act_id, contr_id, s_vt, rate_vk, s_vk, comments, journal_num)
        values (l_bound_id, l_direct, p_ref, p_contr_id, round(p_s_vt*100,0), (case when l_vc=p_kv then 1 else p_rate end),
               (case when l_vc=p_kv then round(p_s_vt*100,0) else round(p_s_vc*100,0) end),
               decode(p_vmd_type, 5, 'Взаємозалік. ','')||p_comments,
               decode(l_contr_type,0,1,null));
        update cim_acts set bound_sum=s-l_s_unbound+p_s_vt*100 where act_id=p_ref;
      end if;
    end if;
  end if;
  if p_contr_id != 0 then check_contract_status(p_contr_id);  end if;
  bars_audit.info(g_module_name||' Прив`язка МД. bound_id:'||l_bound_id||' vmd_type:'||p_vmd_type||' ref: '||p_ref||
                  ' contr_id:'||p_contr_id||' s_vt:'||p_s_vt||' rate:'||p_rate||' s_vc:'||p_s_vc||' doc_date: '||p_doc_date);
  return l_bound_id;
end bound_vmd;

-- autobound_vmd- Автоприв`язка ВМД до контракту
--
procedure autobound_vmd (p_cim_id in number,
                         p_dat in date,
                         p_sdate in date,
                         p_s_okpo in varchar2,
                         p_r_okpo in varchar2,
                         p_f_okpo in varchar2,
                         p_doc in varchar2,
                         p_kv number,
                         p_s in number,
                         p_kurs number
                      )
is
  l_contr_type number;
  l_okpo varchar2(10);
  l_n number;
  l_contr_id number;
  l_s number;
  l_branch cim_contracts.branch%type;
begin
  if p_s_okpo is not null then
    l_contr_type:=0; l_okpo:=p_s_okpo;
  elsif p_r_okpo is not null then
    l_contr_type:=1; l_okpo:=p_r_okpo;
  else
    return;
  end if;

  select count(*), max(contr_id), max(branch) into l_n, l_contr_id, l_branch from cim_contracts
    where trunc(open_date) = trunc(p_sdate) and num=translatedos2win(p_doc) and kv=p_kv and contr_type=l_contr_type
          and (okpo=l_okpo or okpo=p_f_okpo);
  if l_n>1 then
    select count(*), max(contr_id), max(branch) into l_n, l_contr_id, l_branch from v_cim_trade_contracts
      where trunc(open_date) = trunc(p_sdate) and num=translatedos2win(p_doc) and kv=p_kv and contr_type=l_contr_type
            and subject_id=0 and (okpo=l_okpo or okpo=p_f_okpo);
  end if;
  if l_n=1 then
     if trunc(p_dat)<to_date('01/12/2012','DD/MM/YYYY') then
      l_s:=round(p_s*1000000/p_kurs,2);
    else
      l_s:=round(p_s/100,2);
    end if;

    bc.subst_branch(l_branch);
    begin
      l_n:=bound_vmd(0, p_cim_id, l_contr_id, l_s, 1, l_s, null, 'Автоприв`язка МД');
    exception when others then null;
    end;
    bc.set_context;
  end if;
end autobound_vmd;

-- process_all_vmd- Автоприв`язка усіх вільних ВМД до контрактів
--
procedure process_all_vmd(p_begin_date in date :=null,
                          p_end_date in date :=null,
                          p_okpo in varchar2 :=null
                         )
is
  l_date date;
  l_n number;
  l_row customs_decl%rowtype;
begin
  select to_date(par_value, 'DD/MM/YYYY HH24:MI:SS') into l_date from cim_params where par_name='MD_AUTOBOUND_LAST_DATE';
  if (sysdate-l_date)<0.0035 then
    bars_error.raise_error(g_module_name, 66);
  else
    update cim_params set par_value=to_char(sysdate, 'DD/MM/YYYY HH24:MI:SS') where par_name='MD_AUTOBOUND_LAST_DATE';
    commit;
  end if;

  for v in
    (select max(cim_id) as cim_id, max(dat) as dat, max(s_okpo) as s_okpo, max(r_okpo) as r_okpo, max(f_okpo) as f_okpo,
            max(doc) as doc, kv, s, kurs, max(sdate) as sdate from customs_decl
      where cim_boundsum=0 and (p_okpo is null or s_okpo=p_okpo or r_okpo=p_okpo or f_okpo=p_okpo)
      and (p_begin_date is null or trunc(dat)>=p_begin_date) and (p_end_date is null or trunc(dat)<=p_end_date)
      group by cnum_cst, cnum_year, cnum_num, kv, s, kurs, trunc(allow_dat)
     )
  loop
    select * into l_row from customs_decl where cim_id=v.cim_id for update;
    autobound_vmd(v.cim_id, v.dat, v.sdate, v.s_okpo, v.r_okpo, v.f_okpo, v.doc, v.kv, v.s, v.kurs);
  end loop;
end process_all_vmd;

-- unbound_vmd- Відв'язка ВМД від контракту
--
procedure unbound_vmd(p_vmd_type in number, -- Тип платежу
                      p_bound_id in number, -- id зв`язку
                      p_comments in varchar2 -- Коментар
                     )
is
  l_n number;
  l_ref number;
  l_s number; -- Cума прив`язки
  l_branch varchar2(30); -- Код установи
  l_service_branch varchar2(30); -- Відділення, відповідальне за прийом первинних документів
  l_s_vmd number; -- Cума ВМД
  l_contr_id number;
  l_status number;
begin
  if p_vmd_type=0 then
    select count(*), max(vmd_id), max(s_vt), max(branch), max(contr_id) into l_n, l_ref, l_s, l_branch, l_contr_id
      from cim_vmd_bound where delete_date is null and bound_id=p_bound_id;
    if l_n=1 then
      select c.branch, c.service_branch,  c.status_id
      into l_branch, l_service_branch, l_status
      from cim_contracts c where c.contr_id = l_contr_id;
      --if l_branch!=sys_context('bars_context', 'user_branch') then bars_error.raise_error(g_module_name, 40); end if;
      if not (l_branch = sys_context('bars_context', 'user_branch') or l_service_branch = sys_context('bars_context', 'user_branch')) then
        bars_error.raise_error(g_module_name, 40);
      end if;
      --select status_id into l_status from cim_contracts where contr_id=l_contr_id;
      if l_status=1 or l_status>8 then bars_error.raise_error(g_module_name, 6); end if;
      select count(*) into l_n from cim_link where delete_date is null and vmd_id=p_bound_id;
      if l_n>0 then bars_error.raise_error(g_module_name, 63); end if;
      update cim_vmd_bound set delete_date=bankdate, modify_date=bankdate, uid_del_bound=user_id, comments=comments||' Видалено. '||p_comments
        where bound_id=p_bound_id;
      update customs_decl set cim_boundsum=cim_boundsum-l_s, cim_branch=decode(l_s, cim_boundsum, null, cim_branch) where cim_id=l_ref;
      update cim_conclusion_link set delete_date=bankdate, delete_uid=user_id where delete_date is null and vmd_id=p_bound_id;
    else bars_error.raise_error(g_module_name, 49);
    end if;
  else
    select count(*), max(act_id), max(s_vt), max(branch), max(contr_id) into l_n, l_ref, l_s, l_branch, l_contr_id
      from cim_act_bound where delete_date is null and bound_id=p_bound_id;
    if l_n=1 then
      select c.branch, c.service_branch, c.status_id
      into l_branch, l_service_branch, l_status
      from cim_contracts c where c.contr_id = l_contr_id;
      if not (l_branch = sys_context('bars_context', 'user_branch') or l_service_branch = sys_context('bars_context', 'user_branch')) then
        bars_error.raise_error(g_module_name, 40);
      end if;
--      if l_branch!=sys_context('bars_context', 'user_branch') then bars_error.raise_error(g_module_name, 40); end if;
--      select status_id into l_status from cim_contracts where contr_id=l_contr_id;
      if l_status=1 or l_status>8 then bars_error.raise_error(g_module_name, 6); end if;
      select count(*) into l_n from cim_link where delete_date is null and act_id=p_bound_id;
      if l_n>0 then bars_error.raise_error(g_module_name, 63); end if;
      update cim_act_bound set delete_date=bankdate, modify_date=bankdate, uid_del_bound=user_id, comments=comments||' Видалено. '||p_comments
        where bound_id=p_bound_id;
      update cim_acts set bound_sum=bound_sum-l_s where act_id=l_ref;
      update cim_conclusion_link set delete_date=bankdate, delete_uid=user_id where delete_date is null and act_id=p_bound_id;
    else bars_error.raise_error(g_module_name, 49);
    end if;
  end if;
  if l_contr_id != 0 then check_contract_status(l_contr_id); end if;
  bars_audit.info(g_module_name||' Відв`язка МД. bound_id:'||p_bound_id||' vmd_type:'||p_vmd_type);
end unbound_vmd;

-- vmd_link - Зв'язок платежу з ВМД
--
procedure vmd_link(p_payment_type in number, --тип платежу
                   p_payment_id in number, --id платежу
                   p_vmd_type in number, --тип ВМД
                   p_vmd_id in number, --id ВМД
                   p_s in number -- Сума
                  )
is
  l_n number;
  l_s_p number;
  l_s_p_pv number;
  l_s_v number;
  l_p_contr_id number;
  l_v_contr_id number;
  l_contr_type number;
  l_p_jnum number;
  l_p_jid number;
  l_v_jnum number;
  l_v_jid number;
  l_p_comments varchar2(4000);
  l_v_comments varchar2(4000);
  l_old_bound number;
  l_status number;
  l_p_type number :=0;

  l_p_id number;
  l_v_id number;
  l_p_dat date;
  l_v_dat date;
  l_max_pdat date;
  l_max_vdat date;

  l_num varchar2(48);
begin
  if p_payment_type=0 then
    select count(*), max(s_cv), max(s), max(contr_id), max(journal_num), max(journal_id), max(comments), max(ref)
      into l_n, l_s_p, l_s_p_pv, l_p_contr_id, l_p_jnum, l_p_jid, l_p_comments, l_p_id
      from cim_payments_bound where bound_id=p_payment_id;
    select trunc(vdat) into l_p_dat from v_cim_oper where ref=l_p_id;
    select l_s_p-nvl(sum(s),0) into l_s_p from cim_link where delete_date is null and payment_id=p_payment_id;
  else
    select count(*), max(s_cv), max(s), max(contr_id), max(journal_num), max(journal_id), max(comments), max(fantom_id)
      into l_n, l_s_p, l_s_p_pv, l_p_contr_id, l_p_jnum, l_p_jid, l_p_comments, l_p_id
      from cim_fantoms_bound where bound_id=p_payment_id;
    select trunc(val_date), payment_type into l_p_dat, l_p_type from cim_fantom_payments where fantom_id=l_p_id;
    select l_s_p-nvl(sum(s),0) into l_s_p from cim_link where delete_date is null and fantom_id=p_payment_id;
  end if;
  if l_n!=1 then bars_error.raise_error(g_module_name, 70); end if;
  if l_s_p<p_s*100 then bars_error.raise_error(g_module_name, 72); end if;
  if p_vmd_type=0 then
    select count(*), max(s_vk), max(contr_id), max(journal_num), max(journal_id), max(comments), max(vmd_id)
      into l_n, l_s_v, l_v_contr_id, l_v_jnum, l_v_jid, l_v_comments, l_v_id
      from cim_vmd_bound where bound_id=p_vmd_id;
    select trunc(allow_dat) into l_v_dat from customs_decl where cim_id=l_v_id;
    select l_s_v-nvl(sum(s),0) into l_s_v from cim_link where delete_date is null and vmd_id=p_vmd_id;
  else
    select count(*), max(s_vk), max(contr_id), max(journal_num), max(journal_id), max(comments), max(act_id)
      into l_n, l_s_v, l_v_contr_id, l_v_jnum, l_v_jid, l_v_comments, l_v_id
      from cim_act_bound where bound_id=p_vmd_id;
    select trunc(allow_date) into l_v_dat from cim_acts where act_id=l_v_id;
    select l_s_v-nvl(sum(s),0) into l_s_v from cim_link where delete_date is null and act_id=p_vmd_id;
  end if;
  if l_n!=1 then bars_error.raise_error(g_module_name, 71); end if;
  if l_s_v<p_s*100 then bars_error.raise_error(g_module_name, 72); end if;
  if l_p_contr_id!=l_v_contr_id then bars_error.raise_error(g_module_name, 73); end if;
  select contr_type, status_id into l_contr_type, l_status from cim_contracts where contr_id=l_p_contr_id;
  if l_status=1 or l_status>8 then bars_error.raise_error(g_module_name, 6); end if;

  insert into cim_link (payment_id, fantom_id, vmd_id, act_id, s, comments, create_date)
    values (decode(p_payment_type,0,p_payment_id,null), decode(p_payment_type,0,null,p_payment_id),
            decode(p_vmd_type,0,p_vmd_id,null), decode(p_vmd_type,0,null,p_vmd_id), p_s*100,
            decode(l_p_type,5,'Ваємозалік',null),
            case when bankdate>=l_p_dat and bankdate>=l_v_dat then bankdate
                 when l_p_dat>l_v_dat then l_p_dat
                 else l_v_dat
             end
            );

  if l_contr_type=0 then
    if p_vmd_type=0 then
      update cim_vmd_bound set modify_date=bankdate where bound_id=p_vmd_id;
    else
      update cim_act_bound set modify_date=bankdate where bound_id=p_vmd_id;
    end if;

    select num into l_num from v_cim_bound_vmd where type_id=p_vmd_type and bound_id=p_vmd_id;
    l_p_comments:=substr(l_p_comments||'; '||round(p_s*l_s_p_pv/l_s_p, 2)||' - МД/Акт '||l_num||
                  case when l_v_jid is not null then ' (запис №'||l_v_jid||')' else null end, 1, 4000);
    if p_s*100=l_s_p and l_p_jid is null then
      if p_payment_type=0 then
        update cim_payments_bound set comments=l_p_comments, journal_num=null where bound_id=p_payment_id;
      else
        update cim_fantoms_bound set comments=l_p_comments, journal_num=null where bound_id=p_payment_id;
      end if;
    else
      if p_payment_type=0 then
        update cim_payments_bound set comments=l_p_comments where bound_id=p_payment_id;
      else
        update cim_fantoms_bound set comments=l_p_comments where bound_id=p_payment_id;
      end if;
    end if;
  else
    if p_payment_type=0 then
      update cim_payments_bound set modify_date=bankdate where bound_id=p_payment_id;
    else
      update cim_fantoms_bound set modify_date=bankdate where bound_id=p_payment_id;
    end if;
  end if;
/*
  select trunc(max(v.vdat)) into l_max_pdat from cim_link l, v_cim_trade_payments v
  where (l.payment_id is not null and v.type_id=0 or l.payment_id is null and v.type_id != 0)
        and v.bound_id=nvl(l.payment_id, l.fantom_id) and decode(p_vmd_type, 0, l.vmd_id, l.act_id)=p_vmd_id;

  select trunc(max(nvl(v.allow_date, v.doc_date))) into l_max_vdat from cim_link l, v_cim_bound_vmd v
  where (l.vmd_id is not null and v.type_id=0 or l.vmd_id is null and v.type_id != 0)
        and v.bound_id=nvl(l.vmd_id, l.act_id) and decode(p_payment_type, 0, l.payment_id, l.fantom_id)=p_payment_id;
*/
  check_contract_status(l_p_contr_id);
  bars_audit.info(g_module_name||' Лінкування. payment_type:'||p_payment_type||' payment_id:'||p_payment_id||' vmd_type:'||p_vmd_type||
                  ' vmd_id:'||p_vmd_id||' s:'||p_s);
end vmd_link;

-- vmd_unlink - Відв'язка платежу від ВМД
--
procedure vmd_unlink( p_payment_type in number, --тип платежу
                      p_payment_id in number, --id платежу
                      p_vmd_type in number, --тип ВМД
                      p_vmd_id in number, --id ВМД
                      p_comments in varchar2 :=null --Коментар
                    )
is
  l_n number;
  l_contr_type number;
  l_contr_id number;
  l_status number;
begin
  select count(*) into l_n from cim_link
    where delete_date is null
          and (p_payment_type=0 and p_payment_id=payment_id or p_payment_type!=0 and p_payment_id=fantom_id)
          and (p_vmd_type=0 and p_vmd_id=vmd_id or p_vmd_type!=0 and p_vmd_id=act_id);
  if l_n<1 then bars_error.raise_error(g_module_name, 74); end if;
  update cim_link set delete_date=bankdate, comments=comments||p_comments
    where delete_date is null
          and (p_payment_type=0 and p_payment_id=payment_id or p_payment_type!=0 and p_payment_id=fantom_id)
          and (p_vmd_type=0 and p_vmd_id=vmd_id or p_vmd_type!=0 and p_vmd_id=act_id);
  if p_payment_type=0 then
    select b.contr_id into l_contr_id from cim_payments_bound b where b.bound_id=p_payment_id;
  else
    select b.contr_id into l_contr_id from cim_fantoms_bound b where b.bound_id=p_payment_id;
  end if;

  select contr_type, status_id into l_contr_type, l_status from cim_contracts where contr_id=l_contr_id;
  if l_status=1 or l_status>8 then bars_error.raise_error(g_module_name, 6); end if;
  if l_contr_type=0 then
    if p_vmd_type=0 then
      update cim_vmd_bound set modify_date=bankdate where bound_id=p_vmd_id;
    else
      update cim_fantoms_bound set modify_date=bankdate where bound_id=p_vmd_id;
    end if;
  else
    if p_payment_type=0 then
      update cim_payments_bound set modify_date=bankdate where bound_id=p_payment_id;
    else
      update cim_fantoms_bound set modify_date=bankdate where bound_id=p_payment_id;
    end if;
  end if;

  check_contract_status(l_contr_id);
  bars_audit.info(g_module_name||' Розлінкування. payment_type:'||p_payment_type||' payment_id:'||p_payment_id||' vmd_type:'||p_vmd_type||
                  ' vmd_id:'||p_vmd_id);
end vmd_unlink;

--------------------------------------------------------------------------------
-- delete_act - Видалення актів
--
procedure delete_act(p_act_id number)
is
  l_n number;
  l_direct number;
  l_s number;
  l_bound_id number;
begin
  select count(*) into l_n from cim_act_bound where delete_date is null and act_id=p_act_id;
  if l_n>0 then bars_error.raise_error(g_module_name, 65); end if;

  select direct, s into l_direct, l_s from cim_acts where act_id=p_act_id;
  select bars_sqnc.get_nextval('s_cim_act_bound') into l_bound_id from dual;
  insert into cim_act_bound (bound_id,   direct,   act_id,   contr_id, s_vt, rate_vk, s_vk, comments,   journal_num)
                          values (l_bound_id, l_direct, p_act_id, 0,        l_s,  1,       l_s,  'Видалено', null);
  update cim_acts set bound_sum=l_s where act_id=p_act_id;
end delete_act;
--------------------------------------------------------------------------------
-- journal_numbering - Нумерування нових рядків журналу
--
procedure journal_numbering
is
  cursor c_journal is
    select branch, journal_num, doc_kind, doc_type, bound_id from v_cim_journal
      where delete_date is null and journal_num is not null and str_level=-1 and num is null order by branch, create_date, okpo;
  l_branch varchar2(30);
  l_n1 number;
  l_n2 number;
  l_n3 number;
  l_n4 number;
  n number;
  l_date date;
begin
  if sys_context('bars_context','user_mfo') is null then
    bars_audit.error(g_module_name||' '||g_trace_module||'journal_numbering: user_id '||user_id()||' kf '||sys_context('bars_context','user_mfo'));
    raise_application_error(-20001,'Представтесь відділенням');
  end if;
  bars_audit.info(g_module_name||' '||g_trace_module||'journal_numbering: user_id '||user_id()||' kf '||sys_context('bars_context','user_mfo'));
  select to_date(par_value, 'DD/MM/YYYY HH24:MI:SS') into l_date from cim_params where par_name='JOURNAL_NUMBERING_DATE';
  if (sysdate-l_date)<0.0035 then
    bars_error.raise_error(g_module_name, 9);
  else
    update cim_params set par_value=to_char(sysdate, 'DD/MM/YYYY HH24:MI:SS') where par_name='JOURNAL_NUMBERING_DATE';
    commit;
  end if;

  check_unheld_que;
  l_branch:='x';
  for d in c_journal loop
    if d.branch!=l_branch then
      if l_branch!='x' then update cim_journal_num set n1=l_n1,  n2=l_n2, n3=l_n3, n4=l_n4 where branch=l_branch; end if;
      select count(*), max(branch), max(n1), max(n2), max(n3), max(n4) into n, l_branch, l_n1, l_n2, l_n3, l_n4
        from cim_journal_num where branch=d.branch;
      if n=0 then
        l_n1:=0; l_n2:=0; l_n3:=0; l_n4:=0; l_branch:=d.branch;
        insert into cim_journal_num (branch, name, adr, name_ov)
          values (l_branch, 'Заповніть назву установи в cim_journal_num', 'Заповніть адресу установи в cim_journal_num',
                            'Заповніть назву установи в cim_journal_num');
      end if;
    end if;
    case d.journal_num
      when 1 then l_n1:=l_n1+1; n:=l_n1;
      when 2 then l_n2:=l_n2+1; n:=l_n2;
      when 3 then l_n3:=l_n3+1; n:=l_n3;
      else l_n4:=l_n4+1; n:=l_n4;
    end case;
    if d.doc_kind=0 then
      if d.doc_type=0 then
        update cim_payments_bound set journal_id=n where bound_id=d.bound_id;
      else
        update cim_fantoms_bound set journal_id=n where bound_id=d.bound_id;
      end if;
    else
      if d.doc_type=0 then
        update cim_vmd_bound set journal_id=n where bound_id=d.bound_id;
      else
        update cim_act_bound set journal_id=n where bound_id=d.bound_id;
      end if;
    end if;
  end loop;
  update cim_journal_num set n1=l_n1, n2=l_n2, n3=l_n3, n4=l_n4 where branch=l_branch;
  for c in (select contr_id from cim_contracts where contr_type<2 and status_id != 1 and kf = sys_context('bars_context','user_mfo')) loop
    cim_mgr.check_contract_status(c.contr_id);
  end loop;

  dbms_stats.gather_table_stats( 'bars', 'cim_contracts',      cascade=>true);
  dbms_stats.gather_table_stats( 'bars', 'cim_fantoms_bound',  cascade=>true);
  dbms_stats.gather_table_stats( 'bars', 'cim_vmd_bound',      cascade=>true);
  dbms_stats.gather_table_stats( 'bars', 'cim_payments_bound', cascade=>true);
  dbms_stats.gather_table_stats( 'bars', 'cim_act_bound',      cascade=>true);
  dbms_stats.gather_table_stats( 'bars', 'cim_link',           cascade=>true);
end journal_numbering;

-- get_link_sum - Сума Зв'язку платежу з ВМД
--
function get_link_sum (p_payment_type in number, --тип платежу
                       p_payment_id in number, --id платежу
                       p_vmd_type in number, --тип ВМД
                       p_vmd_id in number --id ВМД
                      ) return number
is
  l_s number;
begin
  if p_payment_id is null or p_vmd_id is null then return 0; end if;
  select nvl(sum(s),0) into l_s from cim_link
  where delete_date is null and (p_payment_type=0 and p_payment_id=payment_id or p_payment_type!=0 and p_payment_id=fantom_id)
        and (p_vmd_type=0 and p_vmd_id=vmd_id or p_vmd_type!=0 and p_vmd_id=act_id);
  return round(l_s/100,2);
end get_link_sum;

-- update_comment - Редагувати коментар
--
procedure update_comment(p_doc_kind in number, --0 - платіж, 1 - ВМД
                         p_doc_type in number, --id типу
                         p_bound_id in number, -- Id прив'язки
                         p_str_level in number, -- id лінка
                         p_comments in varchar2 -- Коментар
                        )
is
begin
  if (p_doc_kind=0 or p_doc_kind=1) and (p_doc_type=0 or p_doc_type=1) and p_bound_id is not null and p_str_level is not null then
    if p_str_level = -1 then
      if p_doc_kind=0 then
        if p_doc_type=0 then
          update cim_payments_bound set comments=p_comments where bound_id=p_bound_id;
        else
          update cim_fantoms_bound set comments=p_comments where bound_id=p_bound_id;
        end if;
      else
        if p_doc_type=0 then
          update cim_vmd_bound set comments=p_comments where bound_id=p_bound_id;
        else
          update cim_act_bound set comments=p_comments where bound_id=p_bound_id;
        end if;
      end if;
    else
      update cim_link set comments=p_comments where id=p_str_level;
    end if;
  end if;
end update_comment;

-- delete_from_journal - Видалення запису з журналу
--
procedure delete_from_journal(p_doc_kind in number, --0 - платіж, 1 - ВМД, 2 - лінк
                              p_doc_type in number, --id типу
                              p_bound_id in number -- Id прив'язки
                             )
is
  l_del_date date;
begin
  if p_doc_kind=0 then
    if p_doc_type=0 then
      select delete_date into l_del_date from cim_payments_bound where bound_id=p_bound_id;
      if l_del_date is null then bars_error.raise_error(g_module_name, 52);
      else update cim_payments_bound set uid_del_journal=user_id where bound_id=p_bound_id; end if;
    else
      select delete_date into l_del_date from cim_fantoms_bound where bound_id=p_bound_id;
      if l_del_date is null then bars_error.raise_error(g_module_name, 52);
      else update cim_fantoms_bound set uid_del_journal=user_id where bound_id=p_bound_id; end if;
    end if;
  elsif p_doc_kind=1 then
    if p_doc_type=0 then
      select delete_date into l_del_date from cim_vmd_bound where bound_id=p_bound_id;
        if l_del_date is null then bars_error.raise_error(g_module_name, 52);
        else update cim_vmd_bound set uid_del_journal=user_id where bound_id=p_bound_id; end if;
      else
        select delete_date into l_del_date from cim_act_bound where bound_id=p_bound_id;
        if l_del_date is null then bars_error.raise_error(g_module_name, 52);
        else update cim_act_bound set uid_del_journal=user_id where bound_id=p_bound_id; end if;
    end if;
  else
    select delete_date into l_del_date from cim_link where id=p_bound_id;
    if l_del_date is null then bars_error.raise_error(g_module_name, 52);
    else
      update cim_link set uid_del_journal=user_id where id=p_bound_id;
    end if;
  end if;
end delete_from_journal;

-- check_bound- Перевірка прив'язки платежу до контракту
--
function check_bound(p_doc_kind in number, --вид документу (0 - платіж, 1 - МД)
                     p_payment_type in number, -- Тип платежу
                     p_pay_flag in number, -- Класифікатор платежу (0 ..6)
                     p_direct in number, -- Напрям платежу (0 - вхідні, 1 - вихідні)
                     p_ref in number, -- Референс документу
                     p_contr_id in number, -- Ідентифікатор контракту
                     p_s_vp in number, -- Сума прив'язки у валюті платежу
                     p_comiss in number, -- Комісія
                     p_rate in number, -- Курс
                     p_s_vc in number, -- Сума прив'язки у валюті контракту
                     p_val_date in date, -- Дата валютування
                     p_subject in number := null, -- Предмет оплати (0 - товари, 1 - послуги)
                     p_service_code in varchar2 :=null -- Код класифікатора послуг
                     ----------------------------------------
                     --p_kv in number :=null -- Код валюти платежу
                    ) return varchar2
is l_txt varchar2(1000); -- Текст повідомлення

   l_contr_type number; -- Тип контракту
   l_s_contr number; -- Сума контракту
   l_s_limit number; -- Ліміт заборгованості (на дату валютування) ?
   l_s_in_pl number; -- Сума вхідних платежів
   l_s_out_pl number; -- Сума вихідних платежів
   l_z_pr number; --Заборгованість по процентах
   l_z_pr_nbu number; -- Заборгованість по процентах за ставкою НБУ

   l_out_okpo varchar2 (14 byte);
   l_out_benef_name varchar2 (256 byte);
   l_s number;
   l_contr_bic varchar2 (11 byte);
   l_bic varchar2 (11 byte);
   l_n number;
begin
  l_txt := '';
  if p_contr_id!=0 then
    select contr_type, okpo, bic into l_contr_type, l_out_okpo, l_contr_bic from cim_contracts where contr_id=p_contr_id;
    if p_direct = 1 then delete from cim_license_link where p_s_vp*100<s and payment_id is null and fantom_id is null and okpo=l_out_okpo; end if;
    if l_contr_type=2 then
      create_credgraph(p_contr_id);
      select s, s_in_pl, s_out_pl, z_pr, s_pr_nbu-s_v_pr-s_dod_pl into l_s_contr, l_s_in_pl, l_s_out_pl, l_z_pr, l_z_pr_nbu
        from v_cim_credit_contracts where contr_id=p_contr_id;
      if l_s_contr-l_s_in_pl<p_s_vp and p_direct=0 then l_txt:=l_txt||'Сума надходжень перевищує суму контракту!<Br>'; end if;
      if p_direct=1 and p_pay_flag=3 and p_s_vc>l_z_pr then l_txt:=l_txt||'Сума виплачених процентів перевищує заборгованість по процентах!<Br>'; end if;
      if p_direct=1 and p_pay_flag>2 and p_s_vc>l_z_pr_nbu then l_txt:=l_txt||'Сума виплачених % перевищує суму нарахованих % за ставкою НБУ!<Br>'; end if;
    end if;

    if p_doc_kind=0 and p_direct=1 and check_contract_sanction(p_contr_id, p_val_date, l_out_okpo, l_out_benef_name)>1 then
      select nvl(sum(s),0) into l_s from cim_license_link where delete_date is null and payment_id is null and fantom_id is null;
      if p_s_vp*100>l_s then l_txt:='По даному контракту є санкції мінекономіки. Для прив`язки платежу необхідні ліцензії! Для прив`язки ліцензій натисніть <Відміна>.'
                                                            ||' Натискання <ОК> приведе до прив`язки платежу без ліцензії!<Br>'; end if;
    end if;
  else
    if p_doc_kind=0 and p_payment_type=0 and p_direct=1 then
      select count(*), max(value) into l_n, l_bic from operw where tag='57A' and ref=p_ref;
      if l_contr_bic is null then l_txt:='Не заповнено BIC-код банку нерезидента у контракті!<Br>';
        elsif l_n=1 and l_bic != l_contr_bic then l_txt:='BIC-код банку нерезидента платіжного документа не співпадвє з BIC-колом контракту!<Br>';
      end if;
    end if;
  end if;
  if l_txt is not null then l_txt:=l_txt||'Продовжити виконання операції?'; end if;
  return l_txt;
end check_bound;

-- get_control_date - Розрахунок контрольної дати
--
function get_control_date(p_doc_kind in number, --Вид документу
                          p_doc_type in number, --тип документу
                          p_doc_id in number, --id документу
                          p_pay_flag in number default null -- для оптимізації при виклику з cim_reports
                         ) return date
is
  l_vdat date;
  l_contr_id number;
  l_deadline number;
  l_bound_s number;

  l_minus_date date;
  l_n number;
  l_contr_type number;

/*  25.01.2017 Переписана єрісь з використанням вьюх в яких визивається ця ж функція, яка рано чи пізно призводила до неперехоплюємої помилки блоком exception:
    ORA-01013: user requested cancel of current operation
*/
  cursor c is
    select max(dat) as dat from
      (select l_vdat+l_deadline+1 as dat from  dual
       union all
       select o.end_date+1 as dat
         from cim_conclusion_link l, cim_conclusion o
        where o.id=l.cnc_id and l.delete_date is null
          and (p_doc_kind=1 and (p_doc_type=0 and l.vmd_id=p_doc_id or p_doc_type!=0 and l.act_id=p_doc_id)
           or p_doc_kind=0 and (p_doc_type=0 and l.payment_id=p_doc_id or p_doc_type!=0 and l.fantom_id=p_doc_id)));

begin
--  raise_application_error(-20001, 'p_doc_kind='||p_doc_kind||' p_doc_type='||p_doc_type||' p_doc_id='||p_doc_id);
--  bars_audit.info('CIM_MGR.get_control_date: p_doc_kind='||p_doc_kind||' p_doc_type='||p_doc_type||' p_doc_id='||p_doc_id);
  if p_doc_kind=0 then
    if nvl(p_pay_flag, 0) = 0 then
      select b.vdat, b.contr_id, (select contr_type from cim_contracts where contr_id=b.contr_id)--, b.borg_reason
        into l_vdat, l_contr_id, l_contr_type from /*v_cim_trade_payments*/v_cim_bound_payments b
        where b.pay_flag = 0 and b.type_id=p_doc_type and b.bound_id=p_doc_id;
        if l_contr_type!=1 then return null; end if;
        else --тоді тупо ретурн нулл, бо буде но_дата_фаунд (бо cim_reports використовує також v_cim_bound_payments)
          return null;
    end if;
  else
    if p_doc_type=0 then
      select trunc(v.allow_dat), b.contr_id into l_vdat, l_contr_id
        from cim_vmd_bound b join customs_decl v on v.cim_id=b.vmd_id
        where b.bound_id=p_doc_id;
    else
      select trunc(v.allow_date), b.contr_id into l_vdat, l_contr_id
        from cim_act_bound b join cim_acts v on v.act_id=b.act_id
        where b.bound_id=p_doc_id;
    end if;
  end if;
  begin
    select case when deadline=120 and l_vdat<to_date('01/04/2016', 'dd/mm/yyyy') then 90 else deadline end into l_deadline
      from cim_contracts_trade where contr_id=l_contr_id;

    exception
        when NO_DATA_FOUND then
          l_deadline := 0;
  end;

  l_minus_date:=null;

  open c;
  fetch c into l_minus_date;
  close c;

  return l_minus_date-1;
  exception
    when others then
      bars_audit.error('CIM_MGR.get_control_date: p_doc_kind='||p_doc_kind||' p_doc_type='||p_doc_type||' p_doc_id='||p_doc_id||' l_minus_date='||COALESCE(to_char(l_minus_date,'DD.MM.YYYY'),'NULL')||' l_vdat='||l_vdat||' l_deadline='||COALESCE(to_char(l_deadline, 'DD.MM.YYYY'), 'NULL')||' ERR:'||sqlerrm);
      return null;
--      raise;
end get_control_date;

--------------------------------------------------------------------------------
   -- create_conclusion - Створення висновку
   --
procedure create_conclusion (p_contr_id number, -- id контракту
                             p_org_id number, -- id органу, який дав висновок
                             p_out_num varchar2, -- Вихідний номер висньовку
                             p_out_date date, -- Вихідна дата висньовку
                             p_kv number, --Код валюти
                             p_s number, --Сума
                             p_begin_date date, --Початок строку
                             p_end_date date --Кінець строку
                            )
is
  l_contr_type number;
  l_cnc_id number;
  l_status number;
begin
  select contr_type, status_id into l_contr_type, l_status from cim_contracts where contr_id=p_contr_id;
  if l_status=1 or l_status>8 then bars_error.raise_error(g_module_name, 6); end if;
  if l_contr_type>1 then bars_error.raise_error(g_module_name, 80); end if;
  select bars_sqnc.get_nextval('s_cim_conclusion') into l_cnc_id from dual;
  insert into cim_conclusion (id, contr_id, org_id, out_num, out_date, kv, s, begin_date, end_date)
       values (l_cnc_id, p_contr_id, p_org_id, p_out_num, p_out_date, p_kv, p_s*100, p_begin_date, p_end_date);
  bars_audit.info(g_module_name||' Створення висновку. conclusion_id:'||l_cnc_id||' contr_id:'||p_contr_id||' kv:'||p_kv||' s:'||p_s||
                  ' begin_date:'||p_begin_date||' end_date:'||p_end_date);
end create_conclusion;

-------------------------------------------------------------------------------
   -- update_conclusion- Редагування висновку
   --
procedure update_conclusion (p_conclusion_id number, -- id висновку
                             p_org_id number, -- id органу, який дав висновок
                             p_out_num varchar2, -- Вихідний номер висньовку
                             p_out_date date, -- Вихідна дата висньовку
                             p_kv number, --Код валюти
                             p_s number, --Сума
                             p_begin_date date, --Початок строку
                             p_end_date date --Кінець строку
                            )
   is
     l_n number;
     l_contr_id number;
     l_org_id number;
     l_out_num varchar2(16 byte);
     l_out_date date;
     l_kv number;
     l_s number;
     l_begin_date date;
     l_end_date date;
     l_status number;
   begin
     select count(*), max(contr_id), max(org_id), max(out_num), max(out_date), max(kv), max(s)*100, max(begin_date), max(end_date)
       into l_n, l_contr_id, l_org_id, l_out_num, l_out_date, l_kv, l_s, l_begin_date, l_end_date
       from cim_conclusion where delete_date is null and id=p_conclusion_id;
     if l_n!=1 then bars_error.raise_error(g_module_name, 81); end if;
     select status_id into l_status from cim_contracts where contr_id=l_contr_id;
     if l_status=1 or l_status>8 then bars_error.raise_error(g_module_name, 6); end if;

     if l_org_id!=p_org_id or l_out_num!=p_out_num or l_out_date!=p_out_date or l_kv!=p_kv or l_s!=p_s
        or l_begin_date!=p_begin_date or l_end_date!=p_end_date then
       if l_kv!=p_kv or l_s!=p_s or l_begin_date!=p_begin_date or l_end_date!=p_end_date then
         select count(*) into l_n from cim_conclusion_link where delete_date is null and cnc_id=p_conclusion_id;
         if l_n>0 then bars_error.raise_error(g_module_name, 87);
         else
           insert into cim_conclusion (contr_id, org_id, out_num, out_date, kv, s, begin_date, end_date)
             values (l_contr_id, p_org_id, p_out_num, p_out_date, p_kv, p_s*100, p_begin_date, p_end_date);
           update cim_conclusion set delete_date=bankdate, delete_uid=user_id where id=p_conclusion_id;
         end if;
       else
         update cim_conclusion set org_id=p_org_id, out_num=p_out_num, out_date=p_out_date where id=p_conclusion_id;
       end if;
     end if;
     bars_audit.info(g_module_name||' Редагування висновку. conclusion_id:'||p_conclusion_id||' kv:'||p_kv||' s:'||p_s||
                  ' begin_date:'||p_begin_date||' end_date:'||p_end_date);
   end;

-------------------------------------------------------------------------------
   -- delete_conclusion - Видалення висновку
   --
   procedure delete_conclusion (p_conclusion_id number) -- id висновку
   is
     l_n number;
   begin
     select count(*) into l_n from cim_conclusion_link where delete_date is null and cnc_id=p_conclusion_id;
     if l_n>0 then
       bars_error.raise_error(g_module_name, 86);
     else
       update cim_conclusion set delete_date=bankdate, delete_uid=user_id
         where id=p_conclusion_id;
     end if;
     bars_audit.info(g_module_name||' Видалення висновку. conclusion_id:'||p_conclusion_id);
   end delete_conclusion;

-- conclusion_link - Зв'язок Висновку з первинним документом
--
procedure conclusion_link(p_cnc_id in number, --id висновку
                          p_doc_type in number, --тип документу
                          p_doc_id in number, --id документу
                          p_s in number -- Сума
                         )
is
  l_n number;
  l_kv number;
  l_s number;
  l_contr_id number;
  l_contr_type number;
  l_vd number;
  l_sd number;
  l_sd_vk number;

  l_deadline number;
  l_vdat date;
  l_doc_type number;
  l_status number;

begin
  select count(*), max(contr_id), max(kv), max(s-s_doc) into l_n, l_contr_id, l_kv, l_s  from v_cim_conclusion where id=p_cnc_id;
  if l_n!=1 then bars_error.raise_error(g_module_name, 81); end if;

  if l_s<p_s then bars_error.raise_error(g_module_name, 82); end if;

  select contr_type, status_id into l_contr_type, l_status from cim_contracts where contr_id=l_contr_id;
  if l_status=1 or l_status>8 then bars_error.raise_error(g_module_name, 6); end if;
  select deadline into l_deadline from cim_contracts_trade where contr_id=l_contr_id;
  if l_contr_type=0 then
    select count(*), max(vt), max(s_vt), max(allow_date) into l_n, l_vd, l_sd, l_vdat from v_cim_bound_vmd
      where type_id=p_doc_type and bound_id=p_doc_id;
    if l_n!=1 then bars_error.raise_error(g_module_name, 85); end if;
    l_sd:=l_sd-get_cnc_link_sum(p_cnc_id, p_doc_type, p_doc_id);
    if l_sd<p_s then bars_error.raise_error(g_module_name, 83); end if;
    if l_kv!=l_vd then bars_error.raise_error(g_module_name, 84); end if;
    insert into cim_conclusion_link (cnc_id, vmd_id, act_id, s, create_date, create_uid)
      values (p_cnc_id, decode(p_doc_type,0,p_doc_id,null), decode(p_doc_type,0,null,p_doc_id), p_s*100, bankdate, user_id);
    if p_doc_type=0 then
      update cim_vmd_bound set modify_date=bankdate where bound_id=p_doc_id;
    else
      update cim_act_bound set modify_date=bankdate where bound_id=p_doc_id;
    end if;
  else
    select count(*), max(v_pl), max(s_vpl), max(vdat) into l_n, l_vd, l_sd, l_vdat  from v_cim_trade_payments
      where type_id=p_doc_type and bound_id=p_doc_id;
    if l_n!=1 then bars_error.raise_error(g_module_name, 85); end if;
    l_sd:=l_sd-get_cnc_link_sum(p_cnc_id, p_doc_type, p_doc_id);
    if l_sd<p_s then bars_error.raise_error(g_module_name, 83); end if;
    if l_kv!=l_vd then bars_error.raise_error(g_module_name, 84); end if;
    insert into cim_conclusion_link (cnc_id, payment_id, fantom_id, s, create_date, create_uid)
      values (p_cnc_id, decode(p_doc_type,0,p_doc_id,null), decode(p_doc_type,0,null,p_doc_id), p_s*100, bankdate, user_id);
    if p_doc_type=0 then
      update cim_payments_bound set modify_date=bankdate where bound_id=p_doc_id;
    else
      update cim_fantoms_bound set modify_date=bankdate where bound_id=p_doc_id;
    end if;
  end if;
  check_contract_status(l_contr_id);
  bars_audit.info(g_module_name||' Прив`язка висновку. conclusion_id:'||p_cnc_id||' contr_type:'||l_contr_type||' doc_type:'||p_doc_type||
                  ' doc_id:'||p_doc_id||' s:'||p_s);
end conclusion_link;

-- conclusion_unlink - Відв'язка Висновку выд первинного документу
--
procedure conclusion_unlink(p_cnc_id in number, --id висновку
                            p_doc_type in number, --тип документу
                            p_doc_id in number --id документу
                           )
is
  l_n number;
  l_contr_id number;
  l_contr_type number;
  l_status number;
begin
  select count(*), max(contr_id) into l_n, l_contr_id from cim_conclusion where id=p_cnc_id;
  if l_n!=1 then bars_error.raise_error(g_module_name, 81); end if;

  select contr_type, status_id into l_contr_type, l_status from cim_contracts where contr_id=l_contr_id;
  if l_status=1 or l_status>8 then bars_error.raise_error(g_module_name, 6); end if;
  update cim_conclusion_link set delete_date=bankdate, delete_uid=user_id
    where delete_date is null and
      (l_contr_type=0 and (p_doc_type=0 and vmd_id=p_doc_id or p_doc_type!=0 and act_id=p_doc_id) or
      l_contr_type!=0 and (p_doc_type=0 and payment_id=p_doc_id or p_doc_type!=0 and fantom_id=p_doc_id));
  check_contract_status(l_contr_id);
  bars_audit.info(g_module_name||' Відв`язка висновку. conclusion_id:'||p_cnc_id||' contr_type:'||l_contr_type||' doc_type:'||p_doc_type||
                  ' doc_id:'||p_doc_id);
end conclusion_unlink;

-- get_cnc_link_sum - Сума Зв'язку виксновку з документом
--
function get_cnc_link_sum (p_cnc_id in number, --id висновку
                           p_doc_type in number, --тип документу
                           p_doc_id in number --id документу
                          ) return number
is
  l_s number;
  l_contr_type number;
begin
  if p_cnc_id is null or p_doc_id is null then return 0; end if;
  select contr_type into l_contr_type from cim_contracts where contr_id=(select contr_id from cim_conclusion where id=p_cnc_id);

  select nvl(sum(s),0) into l_s from cim_conclusion_link
    where delete_date is null and cnc_id=p_cnc_id and
          (l_contr_type=0 and decode(p_doc_type, 0, vmd_id, act_id)=p_doc_id or
          l_contr_type=1 and decode(p_doc_type, 0, payment_id, fantom_id)=p_doc_id);
  return round(l_s/100,2);
end get_cnc_link_sum;

--------------------------------------------------------------------------------
   -- create_ape - Створення акту цінової експертизи
   --
   procedure create_ape (p_contr_id number, -- id контракту
                         p_num varchar2, -- Номер акту цінової експертизи
                         p_kv number, -- Код валюти
                         p_s number, -- Сума
                         p_rate number, --Курс
                         p_s_vk number, --Сума у валюті контракту
                         p_begin_date date, -- Дата акту цінової експертизи
                         p_end_date date, -- Дата, до якої дійсний акт
                         p_comments varchar2 -- Примітка
                        )
   is
     l_s_vk number;
     l_ape_id number;
     l_status number;
   begin
     select status_id into l_status from cim_contracts where contr_id=p_contr_id;
     if l_status=1 or l_status>8 then bars_error.raise_error(g_module_name, 6); end if;
     l_s_vk:=round(p_s*100*p_rate,0);
     if l_s_vk!=p_s_vk*100 then bars_error.raise_error(g_module_name, 12); end if;
     select bars_sqnc.get_nextval('s_cim_contracts_ape') into l_ape_id from dual;
     insert into cim_contracts_ape (ape_id, contr_id, num, kv, s, rate, s_vk, begin_date, end_date, comments)
       values (l_ape_id, p_contr_id, p_num, p_kv, p_s*100, p_rate, l_s_vk, p_begin_date, p_end_date, p_comments);
     bars_audit.info(g_module_name||' Створення АЦЕ. ape_id:'||l_ape_id||' contr_id:'||p_contr_id||' kv:'||p_kv||' s:'||p_s||
                     ' rate:'||p_rate||' s_vk:'||p_s_vk||' begin_date:'||p_begin_date||' end_date:'||p_end_date);
   end;

------------------------------------------------------------------------------
   -- update_ape - Редагування акту цінової експертизи
   --
    procedure update_ape (p_ape_id number, -- id акту цінової експертизи
                          p_num varchar2, -- Номер акту цінової експертизи
                          p_kv number, -- Код валюти
                          p_s number, -- Сума
                          p_rate number, --Курс
                          p_s_vk number, --Сума у валюті контракту
                          p_begin_date date, -- Дата акту цінової експертизи
                          p_end_date date, -- Дата, до якої дійсний акт
                          p_comments varchar2 -- Примітка
                         )
   is
     l_n number;
     l_contr_id number;
     l_num varchar2(16 byte);
     l_kv number;
     l_s number;
     l_rate number;
     l_s_vk number;
     l_begin_date date;
     l_end_date date;
     l_comments varchar2(64 byte);
     l_status number;
   begin
     select count(*), max(contr_id), max(num), max(kv), max(s)*100, max(rate), max(s_vk)*100, max(begin_date), max(end_date), max(comments)
       into l_n, l_contr_id, l_num, l_kv, l_s, l_rate, l_s_vk, l_begin_date, l_end_date, l_comments
       from cim_contracts_ape where delete_date is null and ape_id=p_ape_id;
     if l_n!=1 then bars_error.raise_error(g_module_name, 11); end if;
     select status_id into l_status from cim_contracts where contr_id=l_contr_id;
     if l_status=1 or l_status>8 then bars_error.raise_error(g_module_name, 6); end if;
     if round(p_s*p_rate,2)!=p_s_vk then bars_error.raise_error(g_module_name, 12); end if;
     if l_num!=p_num or l_kv!=p_kv or l_s!=p_s or l_rate!=p_rate or l_s_vk!=p_s_vk or
        l_begin_date!=p_begin_date or l_end_date!=p_end_date or l_comments!=p_comments then
       if l_kv!=p_kv or l_s!=p_s or l_rate!=p_rate or l_s_vk!=l_s_vk or l_begin_date!=p_begin_date or l_end_date!=p_end_date then
         select count(*) into l_n from cim_ape_link where delete_date is null and ape_id=p_ape_id;
         if l_n>0 then bars_error.raise_error(g_module_name, 13);
         else
           insert into cim_contracts_ape (contr_id, num, kv, s, rate, s_vk, begin_date, end_date, comments)
             values (l_contr_id, p_num, p_kv, p_s*100, p_rate, p_s_vk*100, p_begin_date, p_end_date, p_comments);
           update cim_contracts_ape set delete_date=bankdate, delete_uid=user_id where ape_id=p_ape_id;
         end if;
       else
         update cim_contracts_ape set num=p_num, comments=p_comments where ape_id=p_ape_id;
       end if;
     end if;
     bars_audit.info(g_module_name||' Редагування АЦЕ. ape_id:'||p_ape_id||' kv:'||p_kv||' s:'||p_s||
                     ' rate:'||p_rate||' s_vk:'||p_s_vk||' begin_date:'||p_begin_date||' end_date:'||p_end_date);
   end;

-------------------------------------------------------------------------------
   -- delete_ape - Видалення акту цінової експертизи
   --
   procedure delete_ape (p_ape_id number) -- id акту цінової експертизи
   is
     l_n number;
   begin
     select count(*) into l_n from cim_ape_link where delete_date is null and ape_id=p_ape_id;
     if l_n>0 then
       bars_error.raise_error(g_module_name, 10);
     else
       update cim_contracts_ape set delete_date=bankdate, delete_uid=user_id where ape_id=p_ape_id;
     end if;
     bars_audit.info(g_module_name||' Видалення АЦЕ. ape_id:'||p_ape_id);
   end;

-- ape_link - Зв'язок Акту цінової експертизи з платежем
--
procedure ape_link(p_ape_id in number, --id акту
                   p_doc_type in number, --тип документу
                   p_doc_id in number, --id документу
                   ------------------------------------
                   p_s in number:=null, -- Сума
                   p_service_code in varchar2:=null --Код класифікатора послуг
                  )
is
  l_n number;
  l_contr_id number;
  l_a_zs_vk number;
  l_p_s_vk number;
  l_ape_id number;
  l_status number;
begin
  select count(*), max(contr_id), max(zs_vk) into l_n, l_contr_id, l_a_zs_vk from v_cim_ape where ape_id=p_ape_id;
  if l_n!=1 then bars_error.raise_error(g_module_name, 11); end if;
  select status_id into l_status from cim_contracts where contr_id=l_contr_id;
  if l_status=1 or l_status>8 then bars_error.raise_error(g_module_name, 6); end if;
  if p_doc_id is not null then
    select count(*), max(s_vk) into l_n, l_p_s_vk from v_cim_trade_payments
      where contr_id=l_contr_id and type_id=p_doc_type and bound_id=p_doc_id;
    if l_n!=1 then bars_error.raise_error(g_module_name, 14); end if;
    if l_a_zs_vk<l_p_s_vk then bars_error.raise_error(g_module_name, 15); end if;
    select count(*), max(ape_id) into l_n, l_ape_id from cim_ape_link
      where delete_date is null and decode(p_doc_type,0,payment_id,fantom_id)=p_doc_id;
    if l_n>1 or l_n=1 and l_ape_id is not null then bars_error.raise_error(g_module_name, 16);
    elsif l_n=0 then
      insert into cim_ape_link (ape_id, payment_id, fantom_id,  s, service_code)
        values (p_ape_id, decode(p_doc_type,0,p_doc_id,null), decode(p_doc_type,0,null,p_doc_id), l_p_s_vk*100, p_service_code);
    else
      update cim_ape_link set ape_id=p_ape_id, s=l_p_s_vk*100
        where delete_date is null and decode(p_doc_type,0,payment_id,fantom_id)=p_doc_id;
    end if;
  else
    select count(*) into l_n from cim_ape_link
      where delete_date is null and payment_id is null and fantom_id is null and ape_id=p_ape_id;
    if l_n>0 then bars_error.raise_error(g_module_name, 16); end if;
    if  p_service_code is null then bars_error.raise_error(g_module_name, 18); end if;
    insert into cim_ape_link (ape_id, payment_id, fantom_id, s, service_code)
      values (p_ape_id, null, null, p_s*100, p_service_code);
  end if;
  bars_audit.info(g_module_name||' Прив`язка АЦЕ. ape_id:'||p_ape_id||' doc_type:'||p_doc_type||' doc_id:'||p_doc_id);
end ape_link;

-- ape_unlink - Відв'язка Акту цінової експертизи від платежу
--
procedure ape_unlink(p_ape_id in number, --id Акту цінової експертизи
                     p_doc_type in number, --тип документу
                     p_doc_id in number --id документу
                    )
is
  l_n number;
  l_contr_id number;
  l_status number;
begin
  select count(*), max(contr_id) into l_n, l_contr_id from v_cim_ape where ape_id=p_ape_id;
  delete from cim_ape_link
    where payment_id is null and fantom_id is null
          and ape_id in (select ape_id from cim_contracts_ape where contr_id=l_contr_id);
  if l_n!=1 then bars_error.raise_error(g_module_name, 11); end if;
  select status_id into l_status from cim_contracts where contr_id=l_contr_id;
  if l_status=1 or l_status>8 then bars_error.raise_error(g_module_name, 6); end if;
  insert into  cim_ape_link (payment_id, fantom_id, s, service_code)
    select payment_id, fantom_id, s, service_code from cim_ape_link
      where delete_date is null and decode(p_doc_type,0,payment_id,fantom_id)=p_doc_id and ape_id=p_ape_id;
  update cim_ape_link set delete_date=bankdate, delete_uid=user_id
    where delete_date is null and decode(p_doc_type,0,payment_id,fantom_id)=p_doc_id and ape_id=p_ape_id;
  bars_audit.info(g_module_name||' Відв`язка АЦЕ. ape_id:'||p_ape_id||' doc_type:'||p_doc_type||' doc_id:'||p_doc_id);
end ape_unlink;

-- get_ape_link_sum - Сума зв'язку Акту цінової експертизи з платежем
function get_ape_link_sum (p_ape_id in number, --id висновку
                           p_doc_type in number, --тип документу
                           p_doc_id in number --id документу
                          ) return number
is
  l_n number;
  l_s number;
  l_contr_type number;
begin
  if p_ape_id is null then return 0; end if;
  select count(*), nvl(sum(s),0) into l_n, l_s from cim_ape_link
    where delete_date is null and ape_id=p_ape_id and
    (p_doc_id is not null and decode(p_doc_type,0,payment_id,fantom_id)=p_doc_id or p_doc_id is null and payment_id is null and fantom_id is null);
  if l_n>1 then bars_error.raise_error(g_module_name, 17);
    else return round(l_s/100,2);
  end if;
end get_ape_link_sum;

function val_convert(p_dat in date , -- Дата конмертації
                     p_s in number, -- Конвертована сума
                     p_kv_a in number, -- Код валюти А
                     p_kv_b in number default 980 -- Код валюти Б
                    ) return number
is
  l_kurs_a number;
  l_kurs_b number;
begin
  --bars_audit.debug(g_module_name||' val_convert() - p_dat:'||p_dat||' p_s:'||p_s||' p_kv_a:'||p_kv_a||' p_kv_b:'||p_kv_b||' g_root_branch:'||g_root_branch);
  if p_dat<to_date('26/12/2008', 'dd/mm/yyyy') then return null; end if;
  if p_kv_a=980 then l_kurs_a:=1;
  else
    select /*+ index(b pk_currate$base) */ rate_o/bsum into l_kurs_a
      from cur_rates$base b
     where b.branch=g_root_branch and b.kv=p_kv_a and
           b.vdate=(select /*+ index(a pk_currate$base) */ max(vdate) from cur_rates$base a where a.branch=g_root_branch and a.kv=p_kv_a and a.vdate<=p_dat);
  end if;
  --bars_audit.debug(g_module_name||' val_convert() - l_kurs_a:'||l_kurs_a);
  if p_kv_b=980 then l_kurs_b:=1;
  else
    select /*+ index(b pk_currate$base) */ rate_o/bsum into l_kurs_b
      from cur_rates$base b
     where b.branch=g_root_branch and b.kv=p_kv_b and
           b.vdate=(select /*+ index(a pk_currate$base) */ max(vdate) from cur_rates$base a where a.branch=g_root_branch and a.kv=p_kv_b and a.vdate<=p_dat);
  end if;
  --bars_audit.debug(g_module_name||' val_convert() - l_kurs_a:'||l_kurs_b||' round(p_s*l_kurs_a/l_kurs_b ,0):'||round(p_s*l_kurs_a/l_kurs_b ,0));
  return round(p_s*l_kurs_a/l_kurs_b ,0);
end val_convert;

--------------------------------------------------------------------------------
-- ape_requed - Необхідність прив'язки акта цінової експертизи
--
function ape_requed(p_contr_id in number, --id контракту
                    p_service_code in varchar2, --Код класифікатора послуг
                    p_val_date in date, --Дата валютування
                    p_kv in number, --Код валюти платежу
                    p_s_vp in number, --Сума у валюті платежу
                    p_s_vk in number --Сума у валюті контракту
                   ) return number --0 - акт не потрібний, 1 -  повідомлення про перевірку наявності актів, 2 - акт обов'язковий
is
  l_s number;
  l_rnk number;
  l_benef_id number;
  l_kv number;
  l_sk number;
  l_n number;
  l_open_date date;
  l_s_limit number;
begin
  select rnk, benef_id, kv, nvl(s,0), open_date into l_rnk, l_benef_id, l_kv, l_sk, l_open_date from cim_contracts where contr_id=p_contr_id;
  select without_acts into l_n from cim_contracts_trade where contr_id=p_contr_id; if l_n>0 then return 0; end if;
  select count(*) into l_s from cim_ape_link l, cim_contracts_ape a
    where l.s=p_s_vk*100 and l.fantom_id is null and l.payment_id is null and l.ape_id=a.ape_id and a.delete_date is null and a.contr_id=p_contr_id;
  if l_s<1 then
    select nvl(sum(val_convert(vdat, s, kv, 978)),0) into l_s
      from (select p.s as s, o.vdat as vdat, o.kv as kv, a.service_code as service_code, a.ape_id as ape_id
              from cim_payments_bound p, v_cim_oper o, cim_ape_link a,
                   (select c.contr_id from cim_contracts c
                      where (select subject_id from cim_contracts_trade where contr_id=c.contr_id)=1
                            and c.contr_type=1 and c.benef_id=l_benef_id and c.rnk=l_rnk) c
              where o.ref=p.ref and p.bound_id(+)=a.payment_id
                    and p.direct=1 and p.contr_id=c.contr_id
            union all
            select p.s as s, f.val_date as vdat, f.kv as kv, a.service_code as service_code, a.ape_id as ape_id
              from cim_fantoms_bound p, cim_fantom_payments f, cim_ape_link a,
                   (select c.contr_id from cim_contracts c
                      where (select subject_id from cim_contracts_trade where contr_id=c.contr_id)=1
                            and c.contr_type=1 and c.benef_id=l_benef_id and c.rnk=l_rnk) c
              where f.fantom_id=p.fantom_id and p.bound_id(+)=a.fantom_id
                    and p.direct=1 and p.contr_id=c.contr_id)
      where trunc(vdat,'YEAR')=trunc(p_val_date,'YEAR') and service_code=p_service_code and ape_id is null;
    select to_number(par_value)*100 into l_s_limit from cim_params where par_name='SERVICE_COST_LIMIT';
    if l_s+val_convert(p_val_date, p_s_vp*100, p_kv, 978)>l_s_limit then return 2; end if;
    if val_convert(l_open_date, l_sk, l_kv, 978)>l_s_limit then return 2; end if;
  end if;
  return 0;
end ape_requed;

--------------------------------------------------------------------------------
-- check_unheld_que - Перевірка черги непроведених платежів
--
procedure check_unheld_que
is
  l_contr_id number;
begin
  l_contr_id:=-1;
  for l in
    (select q.ref, q.contr_id, max(q.vdat) as vdat, nvl(max(o.fdat), max(q.vdat)) as fdat, nvl(max(o.sos), -1) as sos, max(c.branch) as branch
       from cim_unheld_que q, opldok o, cim_contracts c
       where c.kf=sys_context('bars_context','user_mfo') and q.contr_id=c.contr_id and q.ref=o.ref(+) group by q.ref, q.contr_id order by contr_id)
  loop
    if l.sos = 5 then
      if l_contr_id != l.contr_id and l.vdat != l.fdat then
        check_contract_status(l.contr_id); l_contr_id:=l.contr_id;
      end if;
      delete from cim_unheld_que where ref=l.ref;
    elsif l.sos<0 then
      begin
        bc.subst_branch(l.branch); -- представилися потрібним відділенням
        for s in (select bound_id from cim_payments_bound where delete_date is null and ref=l.ref) loop
          update cim_ape_link set delete_date=bankdate, delete_uid=user_id where delete_date is null and payment_id=s.bound_id;
          update cim_license_link set delete_date=bankdate, delete_uid=user_id where delete_date is null and payment_id=s.bound_id;
          update cim_conclusion_link set delete_date=bankdate, delete_uid=user_id where delete_date is null and payment_id=s.bound_id;
          for v in (select nvl(vmd_id, act_id) as v_id, nvl2( vmd_id, 0, 1) as v_type from cim_link where payment_id=s.bound_id) loop
            vmd_unlink(0, s.bound_id, v.v_type, v.v_id, ' Платіж сторновано.');
          end loop;
          unbound_payment(0, s.bound_id, ' Платіж сторновано.');
        end loop;
        --delete from cim_unheld_que where ref=l.ref;
        bc.set_context; -- повертаємо початкове відділення
      exception when OTHERS then
        bc.set_context; -- у випадку будь яких помилок, повертаємо відділення
      end;
    end if;
  end loop;
end check_unheld_que;

--------------------------------------------------------------------------------
-- check_contract_sanction - Перевірка накладення санкції
--
function check_contract_sanction(p_contr_id in number, --id контракту
                                 p_date in date :=bankdate, --Дата перевірки
                                 p_okpo out varchar2, --ОКПО резидента
                                 p_benef_name out varchar2 --Назва нерезилента
                                ) return number
is
  cursor c_sanction is
select max(k030) as k030, max(k020) as k020, max(r4) as r4, case when max(sanksia1)='З' then 2 else 1 end as sanksia1, max(v_sank) as v_sank,
       max(nakaz) as nakaz, max(srsank11) as srsank11, max(srsank12) as srsank12,
       decode(max(v_sank),'2', -1, --1 - застосування, -1 - відміна, 0 - призупинення
                          case when max(nakaz) like 'ПРИЗУПИН%' then 0 else 1  end) as status,
       nomnak, datanak, nomnaksk, datnaksk
  from cim_f98
 where sanksia1!='ПІ' and sanksia1!='П' and
       (k030=2 and r4=(select upper(benef_name) from cim_beneficiaries where benef_id=(select benef_id from cim_contracts where contr_id=p_contr_id))
          or k030=1 and ltrim(k020,'0')=(select ltrim(okpo, '0') from cim_contracts where contr_id=p_contr_id))
 group by nomnak, datanak, nomnaksk, datnaksk
 order by decode(status, 0, 2, 1), nvl(datnaksk, datanak);

  l_n number;
  date_i date;
  date_z date;
  date_i_end date;
  date_z_end date;
  l_n_i number;
  l_n_z number;
  l_benef_id number;
begin
--  bars_audit.info(g_module_name||'.check_contract_sanction. p_contr_id:'||p_contr_id||' p_date:'||p_date||' p_okpo:'||p_okpo||' p_benef_name:'||p_benef_name);  
  date_i:=null; date_z:=null; date_i_end:=null; date_z_end:=null; l_n_i:=0; l_n_z:=0; l_n:=0;
  for c in c_sanction loop
    if c.k030=2 then
      case c.status
        when 0 then
           if c.srsank11<=p_date and (c.srsank12 is null or c.srsank12>p_date) then l_n_z:=0; end if;
        when -1 then
          if c.srsank12 is null or c.srsank12<=p_date and c.srsank12>date_z_end then date_z_end:=c.srsank12; l_n_z:=l_n_z-1; end if;
        else
          if c.srsank11 is null or c.srsank11<=p_date and (c.srsank12 is null or c.srsank12>p_date) and (date_z<c.srsank11 or date_z is null)
            then date_z:=c.srsank11; date_z_end:=c.srsank12; l_n_z:=l_n_z+1;
          end if;
      end case;
    else
      case c.status
        when 0 then
           if c.srsank11<=p_date and (c.srsank12 is null or c.srsank12>p_date) then l_n_i:=0; end if;
        when -1 then
          if c.srsank12 is null or c.srsank12<=p_date and c.srsank12>date_i_end then date_i_end:=c.srsank12; l_n_i:=l_n_i-1; end if;
        else
          if c.srsank11<=p_date and (c.srsank12 is null or c.srsank12>p_date) and (date_i<c.srsank11 or date_i is null)
            then date_i:=c.srsank11; date_i_end:=c.srsank12; l_n_i:=l_n_i+1;
          end if;
      end case;
    end if;
    l_n:=l_n+1;
  end loop;

  select okpo, benef_id into p_okpo, l_benef_id  from cim_contracts where contr_id=p_contr_id;
  select benef_name into p_benef_name from cim_beneficiaries where benef_id=l_benef_id;
  bars_audit.info(g_module_name||'.check_contract_sanction. p_contr_id:'||p_contr_id||' p_date:'||p_date||' p_okpo:'||p_okpo||' p_benef_name:'||p_benef_name||' Санкції? => l_n='||l_n);      
  if l_n=0 then return 0; -- Немає жодних санкцій
    elsif date_i is not null and l_n_i>0 then return 2; --Є діючі санкції на резидента
    elsif date_z is not null and l_n_z>0 then return 3; --Є діючі санкції на нерезидента
    else return 1; --Є недіючі санкції
  end if;
end check_contract_sanction;

-- change_reg_date - Зміна дати реєстрації документа у журналі
--
function change_reg_date (p_contr_type in number, --Тип контракту
                          p_doc_kind in number, -- Вид документу (0 - платіж, 1 - МД/Акт)
                          p_doc_type in number, -- Тип документу
                          p_doc_id in number, -- id документу
                          p_date in date -- Нова дата реєстрації
                         ) return varchar2
is l_txt varchar2(1000); -- Текст повідомлення
   l_date date;
   l_vdate date;
   l_j_n number;
begin
  if p_date is null then l_txt:='Не задана нова дата реєстрації!'; return l_txt; end if;
  l_date:=bankdate;
  if p_contr_type=0 then
    if p_doc_kind=1 then
      select create_date, allow_date into l_date, l_vdate from v_cim_bound_vmd where type_id=p_doc_type and bound_id=p_doc_id;
      if l_date=p_date then l_txt:='Нова дата реєстрації рівна актуальній даті реєстрації. Зміна дати не потрібна!'; return l_txt; end if;
      if l_vdate>p_date then l_txt:='Нова дата реєстрації менша дати дозволу. Зміна дати реєстрації неможлива!'; return l_txt; end if;

      if p_doc_type=0 then
        update cim_vmd_bound set create_date=p_date, modify_date=bankdate where bound_id=p_doc_id;
      else
        update cim_act_bound set create_date=p_date, modify_date=bankdate where bound_id=p_doc_id;
      end if;
      l_txt:='Дата реєстрації документу змінена. Не забудьте роздрукувати нову редакцію експортного журналу зa дати: '
              ||to_char(p_date,'dd.mm.yyyy')||' та '||to_char(l_date,'dd.mm.yyyy')||'!';
    else
      select create_date, vdat into l_date, l_vdate from v_cim_bound_payments where type_id=p_doc_type and bound_id=p_doc_id;
      if l_date=p_date then l_txt:='Нова дата реєстрації рівна актуальній даті реєстрації. Зміна дати не потрібна!'; return l_txt; end if;
      if l_vdate>p_date then l_txt:='Нова дата реєстрації менша дати валютування. Зміна дати реєстрації неможлива!'; return l_txt; end if;

      if p_doc_type=0 then
        update cim_payments_bound set create_date=p_date, modify_date=bankdate where bound_id=p_doc_id;
        update cim_link set create_date=p_date where payment_id=p_doc_id;
      else
        update cim_fantoms_bound set create_date=p_date, modify_date=bankdate where bound_id=p_doc_id;
        update cim_link set create_date=p_date where fantom_id=p_doc_id;
      end if;
      l_txt:='Дата реєстрації документу та його прив`язок змінена!';
    end if;
  else
    if p_doc_kind=0 then
      if p_contr_type=1 then l_j_n:=2; else l_j_n:=4; end if;
      select create_date, vdat into l_date, l_vdate from v_cim_bound_payments where type_id=p_doc_type and bound_id=p_doc_id;
      if l_date=p_date then l_txt:='Нова дата реєстрації рівна актуальній даті реєстрації. Зміна дати не потрібна!'; return l_txt; end if;
      if l_vdate>p_date then l_txt:='Нова дата реєстрації менша дати валютування. Зміна дати реєстрації неможлива!'; return l_txt; end if;

      if p_doc_type=0 then
        update cim_payments_bound set create_date=p_date, modify_date=bankdate where bound_id=p_doc_id;
      else
        update cim_fantoms_bound set create_date=p_date, modify_date=bankdate where bound_id=p_doc_id;
      end if;
      l_txt:='Дата реєстрації документу змінена. Не забудьте роздрукувати нову редакцію '||
         case l_j_n when 2 then 'імпорт' when 4 then 'загаль' end||'ного журналу за дати: '||to_char(p_date,'dd.mm.yyyy')||' та '||to_char(l_date,'dd.mm.yyyy')||'!';
    else
      select create_date, allow_date into l_date, l_vdate from v_cim_bound_vmd where type_id=p_doc_type and bound_id=p_doc_id;
      if l_date=p_date then l_txt:='Нова дата реєстрації рівна актуальній даті реєстрації. Зміна дати не потрібна!'; return l_txt; end if;
      if l_vdate>p_date then l_txt:='Нова дата реєстрації менша дати дозволу. Зміна дати реєстрації неможлива!'; return l_txt; end if;

      if p_doc_type=0 then
        update cim_vmd_bound set create_date=p_date, modify_date=bankdate where bound_id=p_doc_id;
        update cim_link set create_date=p_date where vmd_id=p_doc_id;
      else
        update cim_act_bound set create_date=p_date, modify_date=bankdate where bound_id=p_doc_id;
        update cim_link set create_date=p_date where act_id=p_doc_id;
      end if;
      l_txt:='Дата реєстрації документу та його прив`язок змінена!';
    end if;
  end if;

  bars_audit.info(g_module_name||' Зміна дати реєстрації документу. contr_type:'||p_contr_type||' doc_kind:'||
                    p_doc_kind||' doc_type:'||p_doc_type||' doc_id:'||p_doc_id||' p_date:'||to_char(p_date,'dd/mm/yyyy'));
  commit;
  return l_txt;
end change_reg_date;

-- change_link_date - Зміна дати лінкування
--
function change_link_date (p_payment_type in number, --Тип платежа
                           p_payment_id in number, -- bound_id платежа
                           p_vmd_type in number, -- Тип ВМД
                           p_vmd_id in number, -- bound_id ВМД
                           p_date in date -- Нова дата реєстрації
                          ) return varchar2
is l_txt varchar2(1000); -- Текст повідомлення
begin
  if p_date is null then l_txt:='Не задана нова дата реєстрації!'; return l_txt; end if;

  if/* to_char(p_date,'mm')=to_char(l_date-5,'mm') or to_char(p_date,'mm')=to_char(l_date,'mm') */ 1=1then

    update cim_link set create_date=p_date
     where delete_date is null and decode(p_payment_type, 0, payment_id, fantom_id)=p_payment_id and
           decode(p_vmd_type, 0, vmd_id, act_id)=p_vmd_id;
    if p_vmd_type=0 then
      update cim_vmd_bound set modify_date=bankdate where bound_id=p_vmd_id;
    else
      update cim_act_bound set modify_date=bankdate where bound_id=p_vmd_id;
    end if;
    if p_payment_type=0 then
      update cim_payments_bound set modify_date=bankdate where bound_id=p_payment_id;
    else
      update cim_fantoms_bound set modify_date=bankdate where bound_id=p_payment_id;
    end if;
    l_txt:='Дата прив`язки документу змінена!';
  else
    l_txt:='Нова дата прив`язки виходить за допуснимі межі. Зміна дати  неможлива!';
  end if;
  bars_audit.info(g_module_name||' Зміна дати прив`язки документу. payment_type:'||p_payment_type||' payment_id:'||
                    p_payment_id||' vmd_type:'||p_vmd_type||' vmd_id:'||p_vmd_id||' p_date:'||to_char(p_date,'dd/mm/yyyy'));
  commit;
  return l_txt;
end change_link_date;

begin
   -- Initialization
  begin
      select idchk, idchk_hex into g_visa_id, g_visa_id_hex
        from chklist
       where idchk = (select to_number(par_value) from cim_params where par_name = g_par_visaid);
    exception
      when no_data_found then
        bars_error.raise_error(g_module_name, 1);
      when invalid_number then
        bars_error.raise_error(g_module_name, 2);
    end;
    select to_number(par_value) into g_alert_term from cim_params where par_name='ALERT_TERM';
    select to_number(par_value) into g_create_borg_message from cim_params where par_name='CREATE_BORG_MESSAGE';
    bars_audit.set_module('CIM');
    select '/'||val||'/' into g_root_branch from params$global where par='GLB-MFO';
end cim_mgr;
/
 show err;
 
PROMPT *** Create  grants  CIM_MGR ***
grant EXECUTE                                                                on CIM_MGR         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CIM_MGR         to CIM_ROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/cim_mgr.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 