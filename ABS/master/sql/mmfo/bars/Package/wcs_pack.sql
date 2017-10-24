
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/wcs_pack.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.WCS_PACK is

  -- ================================== Константы ===============================================
  g_scor_result_prefix       varchar2(64) := '_SCORRES';
  g_scor_quest_result_prefix varchar2(64) := '_SCORQUESTRES';
  g_stop_result_prefix       varchar2(64) := '_STOPRES';
  g_iquery_result_prefix     varchar2(64) := '_IQUERYRES';
  g_iquery_result_msg_prefix varchar2(64) := '_IQUERYRESMSG';
  g_addservice_result_prefix varchar2(64) := '_ADDSERVRES';
  g_addservice_scan_prefix   varchar2(64) := '_ADDSERVSCAN';
  g_card_no_qid_prefix       varchar2(64) := '_CARDNOQID';
  g_partner_result_prefix    varchar2(64) := '_PARTNERRES';
  g_partner_scan_prefix      varchar2(64) := '_PARTNERSCAN';
  g_surgrp_result_prefix     varchar2(64) := '_SURGRPRES';
  g_grt_count_prefix         varchar2(64) := '_GRTCOUNT';
  g_grt_status_prefix        varchar2(64) := '_GRTSTATUS';
  g_ins_count_prefix         varchar2(64) := '_INSCOUNT';
  g_ins_status_prefix        varchar2(64) := '_INSSTATUS';
  g_template_scan_prefix     varchar2(64) := '_TPLSCAN';

  g_pack_name varchar2(20) := 'wcs_pack. ';
  -- ===============================================================================================
  g_header_version constant varchar2(64) := 'version 1.2 01/09/2015';
  -- возвращает версию заголовка пакета
  function header_version return varchar2;
  -- возвращает версию тела пакета
  function body_version return varchar2;
  -- ===============================================================================================

  -- ------------------------------- Вопросы ----------------------------------------
  -- Создает/обновляет вопрос
  procedure quest_set(question_id_ varchar2, -- Идентификатор вопроса
                      name_        varchar2, -- Наименование
                      type_id_     varchar2, -- Идентификатор типа
                      is_calcable_ number, -- Вычисляемое ли поле
                      calc_proc_   varchar2 -- Текст вычисления
                      );

  -- Удаляет вопрос
  procedure quest_del(question_id_ varchar2 -- Идентификатор вопроса
                      );

  -- Создает/обновляет параметры вопроса (мин, макс, дефолтное значение) - текстового поля
  procedure quest_pars_text_set(question_id_ varchar2, -- Идентификатор вопроса
                                leng_min_    varchar2, -- Минимальная длина текстового поля
                                leng_max_    varchar2, -- Максимальная длина текстового поля
                                val_default_ varchar2, -- Дефолтное значение текстового поля
                                text_width_  number, -- Ширина текстового поля
                                text_rows_   number -- Кол-во рядков текстового поля
                                );

  -- Создает/обновляет параметры вопроса (мин, макс, дефолтное значение) - числа
  procedure quest_pars_nmbdec_set(question_id_ varchar2, -- Идентификатор вопроса
                                  val_min_     varchar2, -- Минимальное значение числа
                                  val_max_     varchar2, -- Максимальное значение числа
                                  val_default_ varchar2 -- Дефолтное значение числа
                                  );

  -- Создает/обновляет параметры вопроса (мин, макс, дефолтное значение) - даты
  procedure quest_pars_dat_set(question_id_ varchar2, -- Идентификатор вопроса
                               val_min_     varchar2, -- Минимальное значение даты
                               val_max_     varchar2, -- Максимальное значение даты
                               val_default_ varchar2 -- Дефолтное значение даты
                               );

  -- Создает/обновляет параметры вопроса (мин, макс, дефолтное значение) - выбраное из списка
  procedure quest_pars_list_set(question_id_ varchar2, -- Идентификатор вопроса
                                sid_default_ varchar2, -- Дефолтное значение выбраное из списка
                                text_width_  number -- Ширина текстового поля
                                );

  -- Создает/обновляет параметры вопроса - выбраное из списка (добвляет вариант ответа)
  procedure quest_list_item_set(p_question_id wcs_question_list_items.question_id%type, -- Идентификатор вопроса
                                p_ord         wcs_question_list_items.ord%type, -- Порядок вопроса
                                p_text        wcs_question_list_items.text%type, -- Текст ответа
                                p_visible     wcs_question_list_items.visible%type -- Флаг активности записи
                                );

  -- Удаляет параметры вопроса - выбраное из списка (удаляет вариант ответа)
  procedure quest_list_item_del(p_question_id wcs_question_list_items.question_id%type, -- Идентификатор вопроса
                                p_ord         wcs_question_list_items.ord%type -- Порядок вопроса
                                );

  -- Создает/обновляет параметры вопроса - выбраное из списка (перемещает вариант ответа)
  procedure quest_list_item_move(p_question_id wcs_question_list_items.question_id%type, -- Идентификатор вопроса
                                 p_src_ord     wcs_question_list_items.ord%type, -- Порядок источника
                                 p_dest_ord    wcs_question_list_items.ord%type -- Порядок назначения
                                 );

  -- Создает/обновляет параметры вопроса (дефолтное значение, параметры справочника) - справочник
  procedure quest_pars_ref_set(p_question_id    varchar2, -- Идентификатор вопроса
                               p_text_width     number, -- Ширина текстового поля
                               p_text_rows      number, -- Кол-во рядков текстового поля
                               p_sid_default    varchar2, -- Дефолтное значение выбраное из справочника
                               p_tab_id         integer default null, -- Идентификатор таблицы справочника
                               p_key_field      varchar2 default null, -- Ключевое поле
                               p_semantic_field varchar2 default null, -- Поле семантики
                               p_show_fields    varchar2 default null, -- Поля для отображения (перечисление через запятую)
                               p_where_clause   varchar2 default null -- Условие отбора (включая слово where)
                               );

  -- Создает/обновляет параметры вопроса (оси матрицы) - матрица
  procedure quest_mtx_axis_set(question_id_ varchar2, -- Идентификатор вопроса
                               axis_qid_    varchar2, -- Идентификатор вопроса - ось матрицы
                               ord_         number default null -- Порядок оси
                               );

  -- Удаляет параметры вопроса (оси матрицы) - матрица
  procedure quest_mtx_axis_del(question_id_ varchar2, -- Идентификатор вопроса
                               axis_qid_    varchar2 -- Идентификатор вопроса - ось матрицы
                               );

  -- Создает/обновляет параметры вопроса (дефолтное значение) - булевого поля
  procedure quest_pars_bool_set(question_id_ varchar2, -- Идентификатор вопроса
                                val_default_ varchar2 -- Дефолтное значение булевого поля
                                );

  -- Клонирует вопрос
  procedure quest_clone(p_question_id     wcs_questions.id%type, -- Идентификатор вопроса
                        p_src_question_id wcs_questions.id%type -- Идентификатор вопроса-источника
                        );
  -- ------------------------------- Вопросы ----------------------------------------

  -- ------------------------------- Продукты --------------------------------------
  -- Создает/обновляет продукт
  procedure prod_set(product_id_ varchar2, -- Идентификатор продукта
                     name_       varchar2 -- Наименование
                     );

  -- Удаляет продукт
  procedure prod_del(product_id_ varchar2 -- Идентификатор продукта
                     );

  -- Создает/обновляет субпродукт
  procedure sbprod_set(subproduct_id_ varchar2, -- Идентификатор субпродукта
                       name_          varchar2, -- Наименование
                       product_id_    varchar2 -- Идентификатор продукта
                       );

  -- Удаляет субпродукт
  procedure sbprod_del(subproduct_id_ varchar2 -- Идентификатор субпродукт
                       );

  -- Клонирует субпродукт
  procedure sbprod_clone(p_subproduct_id     wcs_subproducts.id%type, -- Идентификатор субпродукта
                         p_src_subproduct_id wcs_subproducts.id%type -- Идентификатор субпродукта-источника для клонирования
                         );

  -- Создает/обновляет МАК
  procedure mac_set(p_mac_id      wcs_macs.id%type, -- Идентификатор МАКа
                    p_name        wcs_macs.name%type, -- Наименование
                    p_type_id     wcs_macs.type_id%type, -- Тип
                    p_apply_level wcs_macs.apply_level%type -- Уровень применения
                    );

  -- Удаляет МАК
  procedure mac_del(p_mac_id wcs_macs.id%type -- Идентификатор МАКа
                    );

  -- Создает/обновляет МАК - выбраное из списка (добвляет вариант ответа)
  procedure mac_list_item_set(mac_id_ varchar2, -- Идентификатор МАКа
                              ord_    number, -- Порядок вопроса
                              text_   varchar2 -- Текст ответа
                              );

  -- Создает/обновляет МАК - выбраное из списка (перемещает вариант ответа)
  procedure mac_list_item_move(p_mac_id   wcs_mac_list_items.mac_id%type, -- Идентификатор МАКа
                               p_src_ord  wcs_mac_list_items.ord%type, -- Порядок источника
                               p_dest_ord wcs_mac_list_items.ord%type -- Порядок назначения
                               );

  -- Удаляет МАК - выбраное из списка (удаляет вариант ответа)
  procedure mac_list_item_del(mac_id_ varchar2, -- Идентификатор МАКа
                              ord_    number -- Порядок вопроса
                              );

  -- Создает/обновляет МАК - справочник
  procedure mac_refer_param_set(mac_id_         varchar2, -- Идентификатор МАКа
                                tab_id_         integer, -- Идентификатор таблицы справочника
                                key_field_      varchar2, -- Ключевое поле
                                semantic_field_ varchar2, -- Поле семантики
                                show_fields_    varchar2 default null, -- Поля для отображения (перечисление через запятую)
                                where_clause_   varchar2 default null -- Условие отбора (включая слово where)
                                );

  -- Удаляет МАК - справочник
  procedure mac_refer_param_del(mac_id_ varchar2 -- Идентификатор МАКа
                                );

  -- Создает/обновляет МАК субпродукта - Текстовый
  procedure sbprod_mac_text_set(p_subproduct_id wcs_subproduct_macs.subproduct_id%type, -- Идентификатор субпродукта
                                p_mac_id        wcs_subproduct_macs.mac_id%type, -- Идентификатор МАКа
                                p_val           wcs_subproduct_macs.val_text%type, -- Значение
                                p_branch        wcs_subproduct_macs.branch%type default '/', -- Отделение
                                p_apply_date    wcs_subproduct_macs.apply_date%type default trunc(sysdate) + 1, -- Дата применения
                                p_comment       varchar2 default null -- Комментарий
                                );

  -- Создает/обновляет МАК субпродукта - Целочисленный
  procedure sbprod_mac_numb_set(p_subproduct_id wcs_subproduct_macs.subproduct_id%type, -- Идентификатор субпродукта
                                p_mac_id        wcs_subproduct_macs.mac_id%type, -- Идентификатор МАКа
                                p_val           wcs_subproduct_macs.val_numb%type, -- Значение
                                p_branch        wcs_subproduct_macs.branch%type default '/', -- Отделение
                                p_apply_date    wcs_subproduct_macs.apply_date%type default trunc(sysdate) + 1, -- Дата применения
                                p_comment       varchar2 default null -- Комментарий
                                );

  -- Создает/обновляет МАК субпродукта - Дробное число
  procedure sbprod_mac_dec_set(p_subproduct_id wcs_subproduct_macs.subproduct_id%type, -- Идентификатор субпродукта
                               p_mac_id        wcs_subproduct_macs.mac_id%type, -- Идентификатор МАКа
                               p_val           wcs_subproduct_macs.val_decimal%type, -- Значение
                               p_branch        wcs_subproduct_macs.branch%type default '/', -- Отделение
                               p_apply_date    wcs_subproduct_macs.apply_date%type default trunc(sysdate) + 1, -- Дата применения
                               p_comment       varchar2 default null -- Комментарий
                               );

  -- Создает/обновляет МАК субпродукта - Дата
  procedure sbprod_mac_dat_set(p_subproduct_id wcs_subproduct_macs.subproduct_id%type, -- Идентификатор субпродукта
                               p_mac_id        wcs_subproduct_macs.mac_id%type, -- Идентификатор МАКа
                               p_val           wcs_subproduct_macs.val_date%type, -- Значение
                               p_branch        wcs_subproduct_macs.branch%type default '/', -- Отделение
                               p_apply_date    wcs_subproduct_macs.apply_date%type default trunc(sysdate) + 1, -- Дата применения
                               p_comment       varchar2 default null -- Комментарий
                               );

  -- Создает/обновляет МАК субпродукта - Список
  procedure sbprod_mac_list_set(p_subproduct_id wcs_subproduct_macs.subproduct_id%type, -- Идентификатор субпродукта
                                p_mac_id        wcs_subproduct_macs.mac_id%type, -- Идентификатор МАКа
                                p_val           wcs_subproduct_macs.val_list%type, -- Значение
                                p_branch        wcs_subproduct_macs.branch%type default '/', -- Отделение
                                p_apply_date    wcs_subproduct_macs.apply_date%type default trunc(sysdate) + 1, -- Дата применения
                                p_comment       varchar2 default null -- Комментарий
                                );

  -- Создает/обновляет МАК субпродукта - Справочник
  procedure sbprod_mac_ref_set(p_subproduct_id wcs_subproduct_macs.subproduct_id%type, -- Идентификатор субпродукта
                               p_mac_id        wcs_subproduct_macs.mac_id%type, -- Идентификатор МАКа
                               p_val           wcs_subproduct_macs.val_refer%type, -- Значение
                               p_branch        wcs_subproduct_macs.branch%type default '/', -- Отделение
                               p_apply_date    wcs_subproduct_macs.apply_date%type default trunc(sysdate) + 1, -- Дата применения
                               p_comment       varchar2 default null -- Комментарий
                               );

  -- Создает/обновляет МАК - Файл
  procedure sbprod_mac_file_set(p_subproduct_id wcs_subproduct_macs.subproduct_id%type, -- Идентификатор субпродукта
                                p_mac_id        wcs_subproduct_macs.mac_id%type, -- Идентификатор МАКа
                                p_val           wcs_subproduct_macs.val_file%type, -- Значение
                                p_branch        wcs_subproduct_macs.branch%type default '/', -- Отделение
                                p_apply_date    wcs_subproduct_macs.apply_date%type default trunc(sysdate) + 1, -- Дата применения
                                p_comment       varchar2 default null -- Комментарий
                                );

  -- Создает/обновляет МАК субпродукта - Булевый
  procedure sbprod_mac_bool_set(p_subproduct_id wcs_subproduct_macs.subproduct_id%type, -- Идентификатор субпродукта
                                p_mac_id        wcs_subproduct_macs.mac_id%type, -- Идентификатор МАКа
                                p_val           wcs_subproduct_macs.val_bool%type, -- Значение
                                p_branch        wcs_subproduct_macs.branch%type default '/', -- Отделение
                                p_apply_date    wcs_subproduct_macs.apply_date%type default trunc(sysdate) + 1, -- Дата применения
                                p_comment       varchar2 default null -- Комментарий
                                );

  -- Удаляет МАК субпродукта
  procedure sbprod_mac_del(p_subproduct_id wcs_subproduct_macs.subproduct_id%type, -- Идентификатор субпродукта
                           p_mac_id        wcs_subproduct_macs.mac_id%type, -- Идентификатор МАКа
                           p_branch        wcs_subproduct_macs.branch%type default null, -- Отделение
                           p_apply_date    wcs_subproduct_macs.apply_date%type default null, -- Дата применения
                           p_comment       varchar2 default null -- Комментарий
                           );

  -- Клонирует МАКи субпродукта
  procedure sbprod_macs_clone(p_subproduct_id     wcs_subproduct_macs.subproduct_id%type, -- Идентификатор субпродукта
                              p_src_subproduct_id wcs_subproduct_macs.subproduct_id%type -- Идентификатор субпродукта-источника для клонирования
                              );
  -- ------------------------------- Продукты --------------------------------------

  -- -------------------------- Заявки -------------------------------------
  -- Прописывает ИНН заявки и выполняет предзаполнение
  procedure bid_set_inn(p_bid_id wcs_bids.id%type, -- Идентификатор заявки
                        p_inn    wcs_bids.inn%type -- ИНН клиента
                        );

  -- Прописывает РНК заявки и выполняет предзаполнение
  procedure bid_set_rnk(p_bid_id wcs_bids.id%type, -- Идентификатор заявки
                        p_rnk    wcs_bids.rnk%type -- ИНН клиента
                        );

  -- Создает заявку
  function bid_create(p_subproduct_id wcs_bids.subproduct_id%type, -- Идентификатор состояния
                      p_inn           wcs_bids.inn%type default null, -- ИНН клиента
                      p_rnk           wcs_bids.rnk%type default null -- РНК клиента
                      ) return number; -- Идентификатор заявки

  /*
  -- Проставляет дату подписания клиентом документов
  procedure bid_signdate_set(p_bid_id    varchar2, -- Идентификатор заявки
                             p_sign_date date -- Дата подписания клиентом документов
                             );
                             */

  -- Удаляет заявку
  procedure bid_del(p_bid_id wcs_bids.id%type -- Идентификатор заявки
                    );

  -- Устанавливает состояние удаляя текущии не выполняя процедур действий
  procedure bid_state_set_immediate(bid_id_       number, -- Идентификатор заявки
                                    state_id_     varchar2, -- Идентификатор состояния
                                    user_comment_ varchar2 --Комментарий пользователя
                                    );

  -- Устанавливает состояние (добавляет к текущим)
  procedure bid_state_set(bid_id_       number, -- Идентификатор заявки
                          state_id_     varchar2, -- Идентификатор состояния
                          user_comment_ varchar2 --Комментарий пользователя
                          );

  -- Удаляет состояние (удаляет из текущих)
  procedure bid_state_del(bid_id_   number, -- Идентификатор заявки
                          state_id_ varchar2 -- Идентификатор состояния
                          );

  -- Лочит состояние на указаного пользователя
  procedure bid_state_reappoint(bid_id_            number, -- Идентификатор заявки
                                state_id_          varchar2, -- Идентификатор состояния
                                reappoint_user_id_ number, -- Пользователь для переназначения
                                user_comment_      varchar2 -- Комментарий пользователя
                                );

  -- Выполняет резервную копию состояний заявки
  procedure bid_states_backup(p_bid_id wcs_bid_states_backup.bid_id%type -- Идентификатор заявки
                              );

  -- Востанавливает состояния заявки из резервной копии
  procedure bid_states_restore(p_bid_id wcs_bid_states_backup.bid_id%type -- Идентификатор заявки
                               );

  -- Замена менеджера по заявке
  procedure bid_mgr_change(p_bid_id     wcs_bids.id%type, -- Идентификатор заявки
                           p_new_mgr_id wcs_bids.mgr_id%type -- Идентификатор нового менеджера
                           );

  -- Замена исполнителя-сотрудника службы по заявке
  procedure bid_srv_user_change(p_bid_id        wcs_bids.id%type, -- Идентификатор заявки
                                p_srv_id        wcs_services.id%type, -- Идентификатор службы
                                p_srv_hierarchy wcs_srv_hierarchy.id%type, -- Идентификатор уровня иерархии службы
                                p_new_mgr_id    wcs_bids.mgr_id%type -- Идентификатор нового исполнителя
                                );

  -- Лочит состояние
  procedure bid_state_check_out(bid_id_       number, -- Идентификатор заявки
                                state_id_     varchar2, -- Идентификатор состояния
                                user_comment_ varchar2 -- Комментарий пользователя
                                );

  -- Разблокирует состояние
  procedure bid_state_check_in(bid_id_       number, -- Идентификатор заявки
                               state_id_     varchar2, -- Идентификатор состояния
                               user_comment_ varchar2 --Комментарий пользователя
                               );

  -- История изменений состояния заявки
  procedure bid_state_history_set(p_bid_id           in number, -- Идентификатор заявки
                                  p_state_id         in varchar2, -- Идентификатор состояния
                                  p_checkouted       in number, -- Блокирована ли заявка (0/1)
                                  p_checkout_dat     in date, -- Дата блокировки заявки
                                  p_checkout_user_id in number, -- Пользователь заблокировавший заявку
                                  p_user_comment     in varchar2, -- Комментарий пользователя
                                  p_change_action    in varchar2 -- Действие
                                  );

-- Удаление истории изменений состояния заявки
  procedure bid_history_restore(p_bid_id           in number, -- Идентификатор заявки
                                p_state_status         in varchar2 -- Идентификатор состояния
                               );

  -- Запись в протокол
  procedure log_set(bid_id_   number, -- Идентификатор заявки
                    state_id_ varchar2, -- Идентификатор состояния
                    text_     varchar2 -- Текст записи протокола
                    );
  -- -------------------------- Заявки -------------------------------------

  -- ------------------------------- Ответы ----------------------------------------
  -- Создает/обновляет ответ - Текстовый
  procedure answ_text_set(p_bid_id      wcs_answers.bid_id%type, -- Идентификатор заявки
                          p_question_id wcs_answers.question_id%type, -- Идентификатор вопроса
                          p_val         wcs_answers.val_text%type, -- Ответ
                          p_ws_id       wcs_answers.ws_id%type default 'MAIN', -- Идентификатор рабочего пространства
                          p_ws_number   wcs_answers.ws_number%type default 0 -- Номер рабочего пространства
                          );

  -- Создает/обновляет ответ - Целочисленный
  procedure answ_numb_set(p_bid_id      wcs_answers.bid_id%type, -- Идентификатор заявки
                          p_question_id wcs_answers.question_id%type, -- Идентификатор вопроса
                          p_val         wcs_answers.val_numb%type, -- Ответ
                          p_ws_id       wcs_answers.ws_id%type default 'MAIN', -- Идентификатор рабочего пространства
                          p_ws_number   wcs_answers.ws_number%type default 0 -- Номер рабочего пространства
                          );

  -- Создает/обновляет ответ - Дробное число
  procedure answ_dec_set(p_bid_id      wcs_answers.bid_id%type, -- Идентификатор заявки
                         p_question_id wcs_answers.question_id%type, -- Идентификатор вопроса
                         p_val         wcs_answers.val_decimal%type, -- Ответ
                         p_ws_id       wcs_answers.ws_id%type default 'MAIN', -- Идентификатор рабочего пространства
                         p_ws_number   wcs_answers.ws_number%type default 0 -- Номер рабочего пространства
                         );

  -- Создает/обновляет ответ - Дата
  procedure answ_dat_set(p_bid_id      wcs_answers.bid_id%type, -- Идентификатор заявки
                         p_question_id wcs_answers.question_id%type, -- Идентификатор вопроса
                         p_val         wcs_answers.val_date%type, -- Ответ
                         p_ws_id       wcs_answers.ws_id%type default 'MAIN', -- Идентификатор рабочего пространства
                         p_ws_number   wcs_answers.ws_number%type default 0 -- Номер рабочего пространства
                         );

  -- Создает/обновляет ответ - Список
  procedure answ_list_set(p_bid_id      wcs_answers.bid_id%type, -- Идентификатор заявки
                          p_question_id wcs_answers.question_id%type, -- Идентификатор вопроса
                          p_val         wcs_answers.val_list%type, -- Ответ
                          p_ws_id       wcs_answers.ws_id%type default 'MAIN', -- Идентификатор рабочего пространства
                          p_ws_number   wcs_answers.ws_number%type default 0 -- Номер рабочего пространства
                          );

  -- Создает/обновляет ответ - Справочник
  procedure answ_ref_set(p_bid_id      wcs_answers.bid_id%type, -- Идентификатор заявки
                         p_question_id wcs_answers.question_id%type, -- Идентификатор вопроса
                         p_val         wcs_answers.val_refer%type, -- Ответ
                         p_ws_id       wcs_answers.ws_id%type default 'MAIN', -- Идентификатор рабочего пространства
                         p_ws_number   wcs_answers.ws_number%type default 0 -- Номер рабочего пространства
                         );

  -- Создает/обновляет ответ - Файл
  procedure answ_file_set(p_bid_id        wcs_answers.bid_id%type, -- Идентификатор заявки
                          p_question_id   wcs_answers.question_id%type, -- Идентификатор вопроса
                          p_val           wcs_answers.val_file%type, -- Ответ
                          p_val_file_name wcs_answers.val_file_name%type, -- Имя файла
                          p_ws_id         wcs_answers.ws_id%type default 'MAIN', -- Идентификатор рабочего пространства
                          p_ws_number     wcs_answers.ws_number%type default 0 -- Номер рабочего пространства
                          );

  -- Создает/обновляет ответ - Матрица
  procedure answ_mtx_set(p_bid_id      wcs_answers.bid_id%type, -- Идентификатор заявки
                         p_question_id wcs_answers.question_id%type, -- Идентификатор вопроса
                         p_val         wcs_answers.val_matrix%type, -- Ответ
                         p_ws_id       wcs_answers.ws_id%type default 'MAIN', -- Идентификатор рабочего пространства
                         p_ws_number   wcs_answers.ws_number%type default 0 -- Номер рабочего пространства
                         );

  -- Создает/обновляет ответ - Булевый
  procedure answ_bool_set(p_bid_id      wcs_answers.bid_id%type, -- Идентификатор заявки
                          p_question_id wcs_answers.question_id%type, -- Идентификатор вопроса
                          p_val         wcs_answers.val_bool%type, -- Ответ
                          p_ws_id       wcs_answers.ws_id%type default 'MAIN', -- Идентификатор рабочего пространства
                          p_ws_number   wcs_answers.ws_number%type default 0 -- Номер рабочего пространства
                          );

  -- Создает/обновляет ответ - Xml
  procedure answ_xml_set(p_bid_id      wcs_answers.bid_id%type, -- Идентификатор заявки
                         p_question_id wcs_answers.question_id%type, -- Идентификатор вопроса
                         p_val         wcs_answers.val_xml%type, -- Ответ
                         p_ws_id       wcs_answers.ws_id%type default 'MAIN', -- Идентификатор рабочего пространства
                         p_ws_number   wcs_answers.ws_number%type default 0 -- Номер рабочего пространства
                         );

  -- Удаляет ответ
  procedure answ_del(p_bid_id      wcs_answers.bid_id%type, -- Идентификатор заявки
                     p_question_id wcs_answers.question_id%type, -- Идентификатор вопроса
                     p_ws_id       wcs_answers.ws_id%type default 'MAIN', -- Идентификатор рабочего пространства
                     p_ws_number   wcs_answers.ws_number%type default 0 -- Номер рабочего пространства
                     );
  -- ------------------------------- Ответы ----------------------------------------

  -- --------------------------- Данные кредита --------------------------------------------
  -- Создает/обновляет данные кредита для субпродукта
  procedure sbp_crddata_set(p_subproduct_id wcs_subproduct_creditdata.subproduct_id%type, -- Идентификатор субпродукта
                            p_crddata_id    wcs_subproduct_creditdata.crddata_id%type, -- Идентификатор параметра
                            p_question_id   wcs_subproduct_creditdata.question_id%type, -- Идентификатор вопроса
                            p_is_visible    wcs_subproduct_creditdata.is_visible%type, -- Отображать или нет
                            p_is_readonly   wcs_subproduct_creditdata.is_readonly%type, -- Только чтение (null/1/true - OK, 0/false - NOT OK)
                            p_is_checkable  wcs_subproduct_creditdata.is_checkable%type, -- Проверять или нет
                            p_check_proc    wcs_subproduct_creditdata.check_proc%type, -- Идентификатор вопроса
                            p_dnshow_if     wcs_subproduct_creditdata.dnshow_if%type -- Условие по которому не показывать вопрос
                            );

  -- Удаляет данные кредита для субпродукта
  procedure sbp_crddata_del(p_subproduct_id wcs_subproduct_creditdata.subproduct_id%type, -- Идентификатор субпродукта
                            p_crddata_id    wcs_subproduct_creditdata.crddata_id%type -- Идентификатор параметра
                            );

  -- Клонирует данные кредита для субпродукта
  procedure sbp_crddata_clone(p_subproduct_id     wcs_subproduct_creditdata.subproduct_id%type, -- Идентификатор субпродукта
                              p_src_subproduct_id wcs_subproduct_creditdata.subproduct_id%type -- Идентификатор субпродукта
                              );
  -- --------------------------- Данные кредита --------------------------------------------

  -- --------------------------- Стопы --------------------------------------------
  -- Создает/обновляет стоп
  procedure stop_set(p_stop_id wcs_stops.id%type, -- Идентификатор стопа
                     p_name    wcs_stops.name%type, -- Наименование
                     p_type_id wcs_stops.type_id%type, -- Тип (правило/фактор)
                     p_plsql   wcs_stops.plsql%type -- plsql блок описывающий стоп фактор
                     );

  -- Удаляет стоп
  procedure stop_del(p_stop_id wcs_stops.id%type -- Идентификатор стопа
                     );

  -- Создает/обновляет стоп субпродукта
  procedure sbprod_stop_set(p_subproduct_id wcs_subproduct_stops.subproduct_id%type, -- Идентификатор субпродукта
                            p_stop_id       wcs_subproduct_stops.stop_id%type, -- Идентификатор стоп фактора
                            p_act_level     wcs_subproduct_stops.act_level%type default null -- Уровень активации
                            );

  -- Удаляет стоп субпродукта
  procedure sbprod_stop_del(p_subproduct_id wcs_subproduct_stops.subproduct_id%type, -- Идентификатор субпродукта
                            p_stop_id       wcs_subproduct_stops.stop_id%type -- Идентификатор стоп фактора
                            );

  -- Клонирует стопы субпродукта
  procedure sbp_stop_clone(p_subproduct_id     wcs_subproducts.id%type, -- Идентификатор субпродукта
                           p_src_subproduct_id wcs_subproducts.id%type -- Идентификатор субпродукта
                           );
  -- --------------------------- Стопы --------------------------------------------

  -- ---------------------- Сканкопии ----------------------------
  -- Создает/обновляет карту сканкопий
  procedure scopy_set(scopy_id_ varchar2, -- Идентификатор карты сканкопий
                      name_     varchar2 -- Наименование
                      );

  -- Удаляет карту сканкопий
  procedure scopy_del(scopy_id_ varchar2 -- Идентификатор карты сканкопий
                      );

  -- Создает/обновляет вопрос карты сканкопий
  procedure scopy_quest_set(p_scopy_id    varchar2, -- Идентификатор карты сканкопий
                            p_question_id varchar2, -- Идентификатор вопроса сканкопии
                            p_type_id     varchar2, -- Идентификатор типа сканкопии
                            p_is_required number -- Обязательный для заполнения
                            );

  -- Удаляет вопрос карты сканкопий
  procedure scopy_quest_del(scopy_id_    varchar2, -- Идентификатор карты сканкопий
                            question_id_ varchar2 -- Идентификатор вопроса сканкопии
                            );

  -- Перемещает вопрос карты сканкопий
  procedure scopy_quest_move(p_scopy_id     wcs_scancopy_questions.scopy_id%type, -- Идентификатор карты сканкопий
                             p_src_questid  wcs_scancopy_questions.question_id%type, -- Идентификатор вопроса сканкопии источника
                             p_dest_questid wcs_scancopy_questions.question_id%type -- Идентификатор вопроса сканкопии назначения
                             );

  -- Создает/обновляет карту сканкопий субпродукта
  procedure sbprod_scopy_set(subproduct_id_ varchar2, -- Идентификатор субпродукта
                             scopy_id_      varchar2 -- Идентификатор карты сканкопий
                             );

  -- Удаляет карту сканкопий субпродукта
  procedure sbprod_scopy_del(subproduct_id_ varchar2 -- Идентификатор субпродукта
                             );

  -- Клонирует карту сканкопий субпродукта
  procedure sbp_scopy_clone(p_subproduct_id     wcs_subproducts.id%type, -- Идентификатор субпродукта
                            p_src_subproduct_id wcs_subproducts.id%type -- Идентификатор субпродукта
                            );

  -- Добавляет сканкопию в очередь печати
  procedure print_scan_set(p_print_session_id wcs_print_scans.print_session_id%type, -- Идентификатор сессии печати
                           p_scan_data        wcs_print_scans.scan_data%type -- Сканкопия
                           );

  -- Чистит сессию печати
  procedure print_scan_clear(p_print_session_id wcs_print_scans.print_session_id%type -- Идентификатор сессии печати
                             );
  -- ---------------------- Сканкопии ----------------------------

  -- ---------------------- Авторизации ----------------------------
  -- Создает/обновляет карту авторизации
  procedure auth_set(auth_id_ varchar2, -- Идентификатор карты авторизации
                     name_    varchar2 -- Наименование
                     );

  -- Удаляет карту авторизации
  procedure auth_del(auth_id_ varchar2 -- Идентификатор карты авторизации
                     );

  -- Клонирует карту авторизации
  procedure auth_clone(p_auth_id    v_wcs_authorizations.auth_id%type, -- Идентификатор карты авторизации
                       p_auth_name  v_wcs_authorizations.auth_name%type, -- Наименование
                       p_src_authid v_wcs_authorizations.auth_id%type -- Идентификатор карты-источника для клонирования
                       );

  -- Создает/обновляет вопрос карты авторизации
  procedure auth_quest_set(p_auth_id      wcs_authorization_questions.auth_id%type, -- Идентификатор карты авторизации
                           p_question_id  wcs_authorization_questions.question_id%type, -- Идентификатор вопроса
                           p_scopy_qid    wcs_authorization_questions.scopy_qid%type, -- Идентификатор вопроса связной сканкопии
                           p_is_required  wcs_authorization_questions.is_required%type, -- Обязателен ли для заполнения
                           p_is_checkable wcs_authorization_questions.is_checkable%type, -- Проверяется ли поле
                           p_check_proc   wcs_authorization_questions.check_proc%type -- Текст проверки
                           );

  -- Удаляет вопрос карты авторизации
  procedure auth_quest_del(auth_id_     varchar2, -- Идентификатор карты авторизации
                           question_id_ varchar2 -- Идентификатор вопроса
                           );

  -- Перемещает вопрос карты авторизации
  procedure auth_quest_move(p_auth_id      wcs_authorization_questions.auth_id%type, -- Идентификатор карты авторизации
                            p_src_questid  wcs_authorization_questions.question_id%type, -- Идентификатор вопроса источника
                            p_dest_questid wcs_authorization_questions.question_id%type -- Идентификатор вопроса назначения
                            );

  -- Создает/обновляет карту авторизации субпродукта
  procedure sbprod_auth_set(subproduct_id_ varchar2, -- Идентификатор субпродукта
                            auth_id_       varchar2 -- Идентификатор карты авторизации
                            );

  -- Удаляет карту авторизации субпродукта
  procedure sbprod_auth_del(subproduct_id_ varchar2 -- Идентификатор субпродукта
                            );

  -- Клонирует карту авторизации субпродукта
  procedure sbp_auth_clone(p_subproduct_id     wcs_subproducts.id%type, -- Идентификатор субпродукта
                           p_src_subproduct_id wcs_subproducts.id%type -- Идентификатор субпродукта
                           );
  -- ---------------------- Авторизации ----------------------------

  -- ---------------------- Карты-анкеты ----------------------------
  -- Создает/обновляет карту-анкету
  procedure survey_set(survey_id_ varchar2, -- Идентификатор карты-анкеты
                       name_      varchar2 -- Наименование
                       );

  -- Удаляет карту-анкету
  procedure survey_del(survey_id_ varchar2 -- Идентификатор карты-анкеты
                       );

  -- Создает/обновляет групу анкеты
  procedure survey_group_set(p_survey_id wcs_survey_groups.survey_id%type, -- Идентификатор анкеты
                             p_sgroup_id wcs_survey_groups.id%type, -- Идентификатор
                             p_name      wcs_survey_groups.name%type, -- Наименование
                             p_dnshow_if wcs_survey_groups.dnshow_if%type -- Условие по которому не показывать группу
                             );

  -- Удаляет групу анкеты
  procedure survey_group_del(p_survey_id wcs_survey_groups.survey_id%type, -- Идентификатор анкеты
                             p_sgroup_id wcs_survey_groups.id%type -- Идентификатор
                             );

  -- Перемещает групу анкеты
  procedure survey_group_move(p_survey_id  wcs_survey_groups.survey_id%type, -- Идентификатор анкеты
                              p_src_grpid  wcs_survey_groups.id%type, -- Идентификатор групы источника
                              p_dest_grpid wcs_survey_groups.id%type -- Идентификатор групы назначения
                              );

  -- Клонируем групу анкеты
  procedure survey_group_clone(p_dest_surid wcs_survey_groups.survey_id%type, -- Идентификатор анкеты-назначения
                               p_src_surid  wcs_survey_groups.survey_id%type, -- Идентификатор анкеты-источника
                               p_src_grpid  wcs_survey_groups.id%type -- Идентификатор групы-источника
                               );

  -- Получает в dbms_output протокол разницы груп
  procedure survey_group_sync_protocol(p_dest_surid wcs_survey_groups.survey_id%type, -- Идентификатор анкеты-назначения
                                       p_dest_grpid wcs_survey_groups.id%type, -- Идентификатор групы-назначения
                                       p_src_surid  wcs_survey_groups.survey_id%type, -- Идентификатор анкеты-источника
                                       p_src_grpid  wcs_survey_groups.id%type -- Идентификатор групы-источника
                                       );

  -- Создает/обновляет вопрос карты-анкеты
  procedure survey_group_quest_set(p_survey_id     wcs_survey_group_questions.survey_id%type, -- Идентификатор карты-анкеты
                                   p_sgroup_id     wcs_survey_group_questions.sgroup_id%type, -- Идентификатор групы карты-анкеты
                                   p_rectype_id    wcs_survey_group_questions.rectype_id%type, -- Тип записи вопрос/раздел
                                   p_question_id   wcs_survey_group_questions.question_id%type, -- Идентификатор вопроса
                                   p_dnshow_if     wcs_survey_group_questions.dnshow_if%type, -- Условие по которому не показывать вопрос
                                   p_is_required   wcs_survey_group_questions.is_required%type, -- Обязателен для заполнения (null/1/true - OK, 0/false - NOT OK)
                                   p_is_readonly   wcs_survey_group_questions.is_readonly%type, -- Только чтение (null/1/true - OK, 0/false - NOT OK)
                                   p_is_rewritable wcs_survey_group_questions.is_rewritable%type, -- Возможность перезаписи
                                   p_is_checkable  wcs_survey_group_questions.is_checkable%type, -- Проверяется ли поле
                                   p_check_proc    wcs_survey_group_questions.check_proc%type -- Текст проверки
                                   );

  -- Удаляет вопрос карты-анкеты
  procedure survey_group_quest_del(survey_id_   varchar2, -- Идентификатор карты-анкеты
                                   sgroup_id_   varchar2, -- Идентификатор групы карты-анкеты
                                   question_id_ varchar2 -- Идентификатор вопроса
                                   );

  -- Перемещает вопрос групы анкеты
  procedure survey_group_quest_move(p_survey_id    wcs_survey_group_questions.survey_id%type, -- Идентификатор анкеты
                                    p_sgroup_id    wcs_survey_group_questions.sgroup_id%type, -- Идентификатор групы
                                    p_src_questid  wcs_survey_group_questions.question_id%type, -- Идентификатор вопроса источника
                                    p_dest_questid wcs_survey_group_questions.question_id%type -- Идентификатор вопроса назначения
                                    );

  -- Создает/обновляет карту-анкету субпродукта
  procedure sbprod_survey_set(subproduct_id_ varchar2, -- Идентификатор субпродукта
                              survey_id_     varchar2 -- Идентификатор карты-анкеты
                              );

  -- Удаляет карту карту-анкету субпродукта
  procedure sbprod_survey_del(subproduct_id_ varchar2 -- Идентификатор субпродукта
                              );

  -- Клонирует карту-анкету субпродукта
  procedure sbp_survey_clone(p_subproduct_id     wcs_subproducts.id%type, -- Идентификатор субпродукта
                             p_src_subproduct_id wcs_subproducts.id%type -- Идентификатор субпродукта
                             );
  -- ---------------------- Работа с картой-анкетой субпродукта ----------------------------

  -- ---------------------- Карты скоринга ----------------------------
  -- Создает/обновляет карту скоринга
  procedure scor_set(scoring_id_ varchar2, -- Идентификатор карты скоринга
                     name_       varchar2 -- Наименование
                     );

  -- Удаляет карту скоринга
  procedure scor_del(scoring_id_ varchar2 -- Идентификатор карты скоринга
                     );

  -- Клонирует карту скоринга
  procedure scor_clone(p_scoring_id     wcs_scorings.id%type, -- Идентификатор карты скоринга
                       p_src_scoring_id wcs_scorings.id%type -- Идентификатор карты скоринга - источника
                       );

  -- Создает/обновляет вопрос карты скоринга
  procedure scor_quest_set(p_scoring_id  wcs_scoring_questions.scoring_id%type, -- Идентификатор карты скоринга
                           p_question_id wcs_scoring_questions.question_id%type, -- Идентификатор вопроса
                           p_multiplier  wcs_scoring_questions.multiplier%type, -- Участвует в скоринге
                           p_else_score  wcs_scoring_questions.else_score%type -- Cкор. балла если не выполнились условия разбивки';
                           );

  -- Удаляет вопрос карты скоринга
  procedure scor_quest_del(scoring_id_  varchar2, -- Идентификатор карты скоринга
                           question_id_ varchar2 -- Идентификатор вопроса
                           );

  -- Создает/обновляет вопрос карты скоринга (бальность по вопросам типа NUMB)
  procedure scor_quest_numb_set(p_scoring_id  wcs_scoring_qs_numb.scoring_id%type, -- Идентификатор карты скоринга
                                p_question_id wcs_scoring_qs_numb.question_id%type, -- Идентификатор вопроса
                                p_ord         wcs_scoring_qs_numb.ord%type, -- Номер отрезка
                                p_min_val     wcs_scoring_qs_numb.min_val%type, -- Мин. значение отрезка
                                p_min_sign    wcs_scoring_qs_numb.min_sign%type, -- Знак мин. значения отрезка
                                p_max_val     wcs_scoring_qs_numb.max_val%type, -- Макс. значение отрезка
                                p_max_sign    wcs_scoring_qs_numb.max_sign%type, -- Знак макс. значения отрезка
                                p_score       wcs_scoring_qs_numb.score%type -- Баллы
                                );

  -- Удаляет вопрос карты скоринга (бальность по вопросам типа NUMB)
  procedure scor_quest_numb_del(p_scoring_id  wcs_scoring_qs_numb.scoring_id%type, -- Идентификатор карты скоринга
                                p_question_id wcs_scoring_qs_numb.question_id%type, -- Идентификатор вопроса
                                p_ord         wcs_scoring_qs_numb.ord%type -- Номер отрезка
                                );

  -- Создает/обновляет МАК - выбраное из списка (перемещает вариант ответа)
  procedure scor_quest_numb_move(p_scoring_id  wcs_scoring_qs_numb.scoring_id%type, -- Идентификатор карты скоринга
                                 p_question_id wcs_scoring_qs_numb.question_id%type, -- Идентификатор вопроса
                                 p_src_ord     wcs_scoring_qs_numb.ord%type, -- Номер отрезка источника
                                 p_dest_ord    wcs_scoring_qs_numb.ord%type -- Номер отрезка назначения
                                 );

  -- Создает/обновляет вопрос карты скоринга (бальность по вопросам типа NUMB)
  procedure scor_quest_decimal_set(p_scoring_id  wcs_scoring_qs_decimal.scoring_id%type, -- Идентификатор карты скоринга
                                   p_question_id wcs_scoring_qs_decimal.question_id%type, -- Идентификатор вопроса
                                   p_ord         wcs_scoring_qs_decimal.ord%type, -- Номер отрезка
                                   p_min_val     wcs_scoring_qs_decimal.min_val%type, -- Мин. значение отрезка
                                   p_min_sign    wcs_scoring_qs_decimal.min_sign%type, -- Знак мин. значения отрезка
                                   p_max_val     wcs_scoring_qs_decimal.max_val%type, -- Макс. значение отрезка
                                   p_max_sign    wcs_scoring_qs_decimal.max_sign%type, -- Знак макс. значения отрезка
                                   p_score       wcs_scoring_qs_decimal.score%type -- Баллы
                                   );

  -- Удаляет вопрос карты скоринга (бальность по вопросам типа NUMB)
  procedure scor_quest_decimal_del(p_scoring_id  wcs_scoring_qs_decimal.scoring_id%type, -- Идентификатор карты скоринга
                                   p_question_id wcs_scoring_qs_decimal.question_id%type, -- Идентификатор вопроса
                                   p_ord         wcs_scoring_qs_decimal.ord%type -- Номер отрезка
                                   );

  -- Создает/обновляет вопрос карты скоринга (бальность по вопросам типа DATE)
  procedure scor_quest_date_set(p_scoring_id  wcs_scoring_qs_date.scoring_id%type, -- Идентификатор карты скоринга
                                p_question_id wcs_scoring_qs_date.question_id%type, -- Идентификатор вопроса
                                p_ord         wcs_scoring_qs_date.ord%type, -- Номер отрезка
                                p_min_val     wcs_scoring_qs_date.min_val%type, -- Мин. значение отрезка
                                p_min_sign    wcs_scoring_qs_date.min_sign%type, -- Знак мин. значения отрезка
                                p_max_val     wcs_scoring_qs_date.max_val%type, -- Макс. значение отрезка
                                p_max_sign    wcs_scoring_qs_date.max_sign%type, -- Знак макс. значения отрезка
                                p_score       wcs_scoring_qs_date.score%type -- Баллы
                                );

  -- Удаляет вопрос карты скоринга (бальность по вопросам типа DATE)
  procedure scor_quest_date_del(p_scoring_id  wcs_scoring_qs_date.scoring_id%type, -- Идентификатор карты скоринга
                                p_question_id wcs_scoring_qs_date.question_id%type, -- Идентификатор вопроса
                                p_ord         wcs_scoring_qs_date.ord%type -- Номер отрезка
                                );

  -- Создает/обновляет вопрос карты скоринга (бальность по вопросам типа LIST)
  procedure scor_quest_list_set(p_scoring_id  wcs_scoring_qs_list.scoring_id%type, -- Идентификатор карты скоринга
                                p_question_id wcs_scoring_qs_list.question_id%type, -- Идентификатор вопроса
                                p_ord         wcs_scoring_qs_list.ord%type, -- Номер отрезка
                                p_score       wcs_scoring_qs_list.score%type -- Баллы
                                );

  -- Удаляет вопрос карты скоринга (бальность по вопросам типа LIST)
  procedure scor_quest_list_del(p_scoring_id  wcs_scoring_qs_list.scoring_id%type, -- Идентификатор карты скоринга
                                p_question_id wcs_scoring_qs_list.question_id%type, -- Идентификатор вопроса
                                p_ord         wcs_scoring_qs_list.ord%type -- Номер отрезка
                                );

  /*
    -- Создает/обновляет вопрос карты скоринга типа MATRIX (бальность по оси типа NUMB)
    procedure scor_quest_mtx_numb_set(scoring_id_  varchar2, -- Идентификатор карты скоринга
                                      question_id_ varchar2, -- Идентификатор вопроса
                                      axis_qid_    varchar2, -- Идентификатор вопроса-оси матрицы
                                      min_val_     number, -- Мин. значение отрезка
                                      min_sign_    varchar2, -- Знак мин. значения отрезка
                                      max_val_     number, -- Макс. значение отрезка
                                      max_sign_    varchar2, -- Знак макс. значения отрезка
                                      ord_         number default null -- Номер отрезка
                                      );

    -- Удаляет вопрос карты скоринга типа MATRIX (бальность по оси типа NUMB)
    procedure scor_quest_mtx_numb_del(scoring_id_  varchar2, -- Идентификатор карты скоринга
                                      question_id_ varchar2, -- Идентификатор вопроса
                                      axis_qid_    varchar2, -- Идентификатор вопроса-оси матрицы
                                      ord_         number -- Номер отрезка
                                      );

    -- Создает/обновляет вопрос карты скоринга типа MATRIX (бальность по оси типа DECIMAL)
    procedure scor_quest_mtx_dec_set(scoring_id_  varchar2, -- Идентификатор карты скоринга
                                     question_id_ varchar2, -- Идентификатор вопроса
                                     axis_qid_    varchar2, -- Идентификатор вопроса-оси матрицы
                                     min_val_     number, -- Мин. значение отрезка
                                     min_sign_    varchar2, -- Знак мин. значения отрезка
                                     max_val_     number, -- Макс. значение отрезка
                                     max_sign_    varchar2, -- Знак макс. значения отрезка
                                     ord_         number default null -- Номер отрезка
                                     );

    -- Удаляет вопрос карты скоринга типа MATRIX (бальность по оси типа DECIMAL)
    procedure scor_quest_mtx_dec_del(scoring_id_  varchar2, -- Идентификатор карты скоринга
                                     question_id_ varchar2, -- Идентификатор вопроса
                                     axis_qid_    varchar2, -- Идентификатор вопроса-оси матрицы
                                     ord_         number -- Номер отрезка
                                     );

    -- Создает/обновляет вопрос карты скоринга типа MATRIX (бальность по оси типа DATE)
    procedure scor_quest_mtx_dat_set(scoring_id_  varchar2, -- Идентификатор карты скоринга
                                     question_id_ varchar2, -- Идентификатор вопроса
                                     axis_qid_    varchar2, -- Идентификатор вопроса-оси матрицы
                                     min_val_     date, -- Мин. значение отрезка
                                     min_sign_    varchar2, -- Знак мин. значения отрезка
                                     max_val_     date, -- Макс. значение отрезка
                                     max_sign_    varchar2, -- Знак макс. значения отрезка
                                     ord_         number default null -- Номер отрезка
                                     );

    -- Удаляет вопрос карты скоринга типа MATRIX (бальность по оси типа DATE)
    procedure scor_quest_mtx_dat_del(scoring_id_  varchar2, -- Идентификатор карты скоринга
                                     question_id_ varchar2, -- Идентификатор вопроса
                                     axis_qid_    varchar2, -- Идентификатор вопроса-оси матрицы
                                     ord_         number -- Номер отрезка
                                     );

    -- Создает/обновляет вопрос карты скоринга (бальность по вопросам типа MATRIX)
    procedure scor_quest_mtx_set(scoring_id_  varchar2, -- Идентификатор карты скоринга
                                 question_id_ varchar2, -- Идентификатор вопроса
                                 score_       number, -- Баллы
                                 axis0_ord_   number, -- Номер ответа по оси 0
                                 axis1_ord_   number, -- Номер ответа по оси 1
                                 axis2_ord_   number default null, -- Номер ответа по оси 2
                                 axis3_ord_   number default null, -- Номер ответа по оси 3
                                 axis4_ord_   number default null -- Номер ответа по оси 4
                                 );

    -- Удаляет вопрос карты скоринга (бальность по вопросам типа MATRIX)
    procedure scor_quest_mtx_del(scoring_id_  varchar2, -- Идентификатор карты скоринга
                                 question_id_ varchar2, -- Идентификатор вопроса
                                 axis0_ord_   number, -- Номер ответа по оси 0
                                 axis1_ord_   number, -- Номер ответа по оси 1
                                 axis2_ord_   number default null, -- Номер ответа по оси 2
                                 axis3_ord_   number default null, -- Номер ответа по оси 3
                                 axis4_ord_   number default null -- Номер ответа по оси 4
                                 );
  */

  -- Создает/обновляет вопрос карты скоринга (бальность по вопросам типа BOOL)
  procedure scor_quest_bool_set(p_scoring_id  wcs_scoring_qs_bool.scoring_id%type, -- Идентификатор карты скоринга
                                p_question_id wcs_scoring_qs_bool.question_id%type, -- Идентификатор вопроса
                                p_score_if_0  wcs_scoring_qs_bool.score_if_0%type, -- Баллы за ответ нет (0)
                                p_score_if_1  wcs_scoring_qs_bool.score_if_1%type -- Баллы за ответ да (1)
                                );

  -- Удаляет вопрос карты скоринга (бальность по вопросам типа BOOL)
  procedure scor_quest_bool_del(p_scoring_id  wcs_scoring_qs_bool.scoring_id%type, -- Идентификатор карты скоринга
                                p_question_id wcs_scoring_qs_bool.question_id%type -- Идентификатор вопроса
                                );

  -- Создает/обновляет карту скоринга субпродукта
  procedure sbprod_scor_set(subproduct_id_ varchar2, -- Идентификатор субпродукта
                            scoring_id_    varchar2 -- Идентификатор карты скоринга
                            );

  -- Удаляет карту скоринга субпродукта
  procedure sbprod_scor_del(subproduct_id_ varchar2 -- Идентификатор субпродукта
                            );
  -- Клонирует карту скоринга субпродукта
  procedure sbp_scor_clone(p_subproduct_id     wcs_subproducts.id%type, -- Идентификатор субпродукта
                           p_src_subproduct_id wcs_subproducts.id%type -- Идентификатор субпродукта
                           );
  -- ---------------------- Карты скоринга ----------------------------

  -- ------------------ Карты кредитоспособности ----------------------
  -- Создает/обновляет карту кредитоспособности
  procedure solv_set(p_solvency_id varchar2, -- Идентификатор карты кредитоспособности
                     p_name        varchar2 -- Наименование
                     );

  -- Удаляет карту кредитоспособности
  procedure solv_del(p_solvency_id varchar2 -- Идентификатор карты кредитоспособности
                     );

  -- Клонирует карту кредитоспособности
  procedure solv_clone(p_solvency_id     wcs_solvencies.id%type, -- Идентификатор карты кредитоспособности
                       p_src_solvency_id wcs_solvencies.id%type -- Идентификатор карты кредитоспособности - источника
                       );

  -- Создает/обновляет вопрос карты кредитоспособности
  procedure solv_quest_set(p_solvency_id varchar2, -- Идентификатор карты кредитоспособности
                           p_question_id varchar2 -- Идентификатор вопроса
                           );

  -- Удаляет вопрос карты кредитоспособности
  procedure solv_quest_del(p_solvency_id varchar2, -- Идентификатор карты кредитоспособности
                           p_question_id varchar2 -- Идентификатор вопроса
                           );

  -- Создает/обновляет карту кредитоспособности субпродукта
  procedure sbprod_solv_set(p_subproduct_id varchar2, -- Идентификатор субпродукта
                            p_solvency_id   varchar2 -- Идентификатор карты кредитоспособности
                            );

  -- Удаляет карту кредитоспособности субпродукта
  procedure sbprod_solv_del(p_subproduct_id varchar2 -- Идентификатор субпродукта
                            );

  -- Клонирует карту кредитоспособности субпродукта
  procedure sbp_solv_clone(p_subproduct_id     wcs_subproducts.id%type, -- Идентификатор субпродукта
                           p_src_subproduct_id wcs_subproducts.id%type -- Идентификатор субпродукта
                           );
  -- ------------------ Карты кредитоспособности ----------------------

  -- ------------------------- Информ запросы --------------------------------------
  -- Создает/обновляет информ запрос
  procedure iquery_set(p_iquery_id wcs_infoqueries.id%type, -- Идентификатор информационного запроса
                       p_name      wcs_infoqueries.name%type, -- Наименование
                       p_type_id   wcs_infoqueries.type_id%type, -- Тип инфо-запроса
                       p_plsql     wcs_infoqueries.plsql%type -- plsql блок описывающий запрос
                       );

  -- Удаляет информ запрос
  procedure iquery_del(p_iquery_id wcs_infoqueries.id%type -- Идентификатор информационного запроса
                       );

  -- Создает/обновляет вопросы информационных запросов
  procedure iquery_quest_set(p_iquery_id    wcs_infoquery_questions.iquery_id%type, -- Идентификатор информационного запроса
                             p_question_id  wcs_infoquery_questions.question_id%type, -- Идентификатор вопроса
                             p_is_required  wcs_infoquery_questions.is_required%type, -- Обязателен ли для заполнения
                             p_is_checkable wcs_infoquery_questions.is_checkable%type, -- Проверяется ли поле
                             p_check_proc   wcs_infoquery_questions.check_proc%type -- Текст проверки
                             );

  -- Удаляет вопросы информационных запросов
  procedure iquery_quest_del(p_iquery_id   wcs_infoquery_questions.iquery_id%type, -- Идентификатор информационного запроса
                             p_question_id wcs_infoquery_questions.question_id%type -- Идентификатор вопроса
                             );

  -- Перемещает вопрос информационных запросов
  procedure iquery_quest_move(p_iquery_id    wcs_infoquery_questions.iquery_id%type, -- Идентификатор информационного запроса
                              p_src_questid  wcs_infoquery_questions.question_id%type, -- Идентификатор вопроса источника
                              p_dest_questid wcs_infoquery_questions.question_id%type -- Идентификатор вопроса назначения
                              );

  -- Создает/обновляет карту информ запросов суб-продукта
  procedure sbprod_iquery_set(p_subproduct_id wcs_subproduct_infoqueries.subproduct_id%type, -- Идентификатор субпродукта
                              p_iquery_id     wcs_subproduct_infoqueries.iquery_id%type, -- Идентификатор информационного запроса
                              p_act_level     wcs_subproduct_infoqueries.act_level%type, -- Уровень активации
                              p_service_id    wcs_subproduct_infoqueries.service_id%type, -- Исполняющая служба (если ручной)
                              p_is_required   wcs_subproduct_infoqueries.is_required%type -- Обязателен ли для выполнения
                              );

  -- Удаляет карту информ запросов суб-продукта
  procedure sbprod_iquery_del(p_subproduct_id wcs_subproduct_infoqueries.subproduct_id%type, -- Идентификатор субпродукта
                              p_iquery_id     wcs_subproduct_infoqueries.iquery_id%type -- Идентификатор информационного запроса
                              );

  -- Перемещает информационный запрос субпродукта
  procedure sbprod_iquery_move(p_subproduct_id wcs_subproduct_infoqueries.subproduct_id%type, -- Идентификатор субпродукта
                               p_src_iqueryid  wcs_subproduct_infoqueries.iquery_id%type, -- Идентификатор источника
                               p_dest_iqueryid wcs_subproduct_infoqueries.iquery_id%type -- Идентификатор назначения
                               );

  -- Клонирует информационные запросы субпродукта
  procedure sbprod_iquery_clone(p_subproduct_id     wcs_subproduct_infoqueries.subproduct_id%type, -- Идентификатор субпродукта
                                p_src_subproduct_id wcs_subproduct_infoqueries.subproduct_id%type -- Идентификатор субпродукта-источника для клонирования
                                );
  -- ------------------------- Информ запросы --------------------------------------

  -- ------------------------- Страховки --------------------------------------
  -- Обновляет страховку
  procedure insurance_set(p_insurance_id wcs_insurances.id%type, -- Идентификатор страховки
                          p_survey_id    wcs_insurances.survey_id%type -- Идентификатор анкеты
                          );

  -- Создает/обновляет страховку клиента субпродукта
  procedure sbp_insurance_set(p_subproduct_id wcs_subproduct_insurances.subproduct_id%type, -- Идентификатор субпродукта
                              p_insurance_id  wcs_subproduct_insurances.insurance_id%type, -- Идентификатор типа страховки
                              p_is_required   wcs_subproduct_insurances.is_required%type -- Обязательна ли для заполнения
                              );

  -- Удаляет страховку клиента субпродукта
  procedure sbp_insurance_del(p_subproduct_id wcs_subproduct_insurances.subproduct_id%type, -- Идентификатор субпродукта
                              p_insurance_id  wcs_subproduct_insurances.insurance_id%type -- Идентификатор типа страховки
                              );

  -- Перемещает страховку клиента субпродукта
  procedure sbp_insurance_move(p_subproduct_id wcs_subproduct_insurances.subproduct_id%type, -- Идентификатор субпродукта
                               p_src_id        wcs_subproduct_insurances.insurance_id%type, -- Идентификатор источника
                               p_dest_id       wcs_subproduct_insurances.insurance_id%type -- Идентификатор назначения
                               );
  -- Клонирует страховку клиента субпродукта
  procedure sbp_insurance_clone(p_subproduct_id     wcs_subproducts.id%type, -- Идентификатор субпродукта
                                p_src_subproduct_id wcs_subproducts.id%type -- Идентификатор субпродукта-источника для клонирования
                                );

  -- Создает страховку заявки
  procedure bid_insurance_set(p_bid_id       wcs_bids.id%type, -- Идентификатор заявки
                              p_insurance_id wcs_insurances.id%type -- Идентификатор типа страховки
                              );

  -- Удаляет страховку заявки
  procedure bid_insurance_del(p_bid_id        wcs_bids.id%type, -- Идентификатор заявки
                              p_insurance_id  wcs_insurances.id%type, -- Идентификатор типа страховки
                              p_insurance_num number -- Номер
                              );

  -- Устанавливает статус страховки заявки
  procedure bid_insurance_status_set(p_bid_id        wcs_bids.id%type, -- Идентификатор заявки
                                     p_insurance_id  wcs_insurances.id%type, -- Идентификатор типа страховки
                                     p_insurance_num number, -- Номер
                                     p_status_id     number -- Ид. статуса
                                     );

  -- Создает страховку обеспечения заявки
  procedure bid_grt_insurance_set(p_bid_id       wcs_bids.id%type, -- Идентификатор заявки
                                  p_garantee_id  wcs_garantees.id%type, -- Идентификатор обеспечения
                                  p_garantee_num number, -- Номер обеспечения
                                  p_insurance_id wcs_insurances.id%type -- Идентификатор типа страховки
                                  );

  -- Удаляет страховку обеспечения заявки
  procedure bid_grt_insurance_del(p_bid_id        wcs_bids.id%type, -- Идентификатор заявки
                                  p_garantee_id   wcs_garantees.id%type, -- Идентификатор обеспечения
                                  p_garantee_num  number, -- Номер обеспечения
                                  p_insurance_id  wcs_insurances.id%type, -- Идентификатор типа страховки
                                  p_insurance_num number -- Номер
                                  );

  -- Устанавливает статус страховки обеспечения заявки
  procedure bid_grt_insurance_status_set(p_bid_id        wcs_bids.id%type, -- Идентификатор заявки
                                         p_garantee_id   wcs_garantees.id%type, -- Идентификатор обеспечения
                                         p_garantee_num  number, -- Номер обеспечения
                                         p_insurance_id  wcs_insurances.id%type, -- Идентификатор типа страховки
                                         p_insurance_num number, -- Номер
                                         p_status_id     number -- Ид. статуса
                                         );
  -- ------------------------- Страховки --------------------------------------

  -- ------------------------- Обеспечение --------------------------------------
  -- Обновляет обеспечение
  procedure garantee_set(p_garantee_id wcs_garantees.id%type, -- Идентификатор обеспечения
                         p_scopy_id    wcs_garantees.scopy_id%type, -- Идентификатор карты сканкопий
                         p_survey_id   wcs_garantees.survey_id%type -- Идентификатор анкеты
                         );

  -- Создает/обновляет страховку обеспечения
  procedure garantee_insurance_set(p_garantee_id  wcs_garantee_insurances.garantee_id%type, -- Идентификатор обеспечения
                                   p_insurance_id wcs_garantee_insurances.insurance_id%type, -- Идентификатор типа страховки
                                   p_is_required  wcs_garantee_insurances.is_required%type -- Обязательна ли для заполнения
                                   );

  -- Удаляет страховку обеспечения
  procedure garantee_insurance_del(p_garantee_id  wcs_garantee_insurances.garantee_id%type, -- Идентификатор обеспечения
                                   p_insurance_id wcs_garantee_insurances.insurance_id%type -- Идентификатор типа страховки
                                   );

  -- Перемещает страховку обеспечения
  procedure garantee_insurance_move(p_garantee_id wcs_garantee_insurances.garantee_id%type, -- Идентификатор обеспечения
                                    p_src_id      wcs_garantee_insurances.insurance_id%type, -- Идентификатор источника
                                    p_dest_id     wcs_garantee_insurances.insurance_id%type -- Идентификатор назначения
                                    );

  -- Создает/обновляет шаблон обеспечения
  procedure garantee_template_set(p_garantee_id    wcs_garantee_templates.garantee_id%type, -- Идентификатор обеспечения
                                  p_template_id    wcs_garantee_templates.template_id%type, -- Идентификатор шаблона
                                  p_print_state_id wcs_garantee_templates.print_state_id%type, -- Этап печати
                                  p_is_scan_req    wcs_garantee_templates.is_scan_required%type -- Обязательно ли сканирование отпечатка
                                  );

  -- Удаляет шаблон обеспечения
  procedure garantee_template_del(p_garantee_id wcs_garantee_templates.garantee_id%type, -- Идентификатор обеспечения
                                  p_template_id wcs_garantee_templates.template_id%type -- Идентификатор шаблона
                                  );

  -- Создает/обновляет обеспечение субпродукта
  procedure sbp_garantee_set(p_subproduct_id wcs_subproduct_garantees.subproduct_id%type, -- Идентификатор субпродукта
                             p_garantee_id   wcs_subproduct_garantees.garantee_id%type, -- Идентификатор типа обеспечения
                             p_is_required   wcs_subproduct_garantees.is_required%type -- Обязательна ли для заполнения
                             );

  -- Удаляет обеспечение субпродукта
  procedure sbp_garantee_del(p_subproduct_id wcs_subproduct_garantees.subproduct_id%type, -- Идентификатор субпродукта
                             p_garantee_id   wcs_subproduct_garantees.garantee_id%type -- Идентификатор типа обеспечения
                             );

  -- Перемещает обеспечение субпродукта
  procedure sbp_garantee_move(p_subproduct_id wcs_subproduct_garantees.subproduct_id%type, -- Идентификатор субпродукта
                              p_src_gid       wcs_subproduct_garantees.garantee_id%type, -- Идентификатор источника
                              p_dest_gid      wcs_subproduct_garantees.garantee_id%type -- Идентификатор назначения
                              );

  -- Клонирует обеспечение субпродукта
  procedure sbp_garantee_clone(p_subproduct_id     wcs_subproducts.id%type, -- Идентификатор субпродукта
                               p_src_subproduct_id wcs_subproducts.id%type -- Идентификатор субпродукта-источника для клонирования
                               );

  -- Создает обеспечение заявки
  procedure bid_garantee_set(p_bid_id      wcs_bids.id%type, -- Идентификатор заявки
                             p_garantee_id wcs_garantees.id%type -- Идентификатор типа обеспечения
                             );

  function bid_garantee_set_ext(p_bid_id      wcs_bids.id%type, -- Идентификатор заявки
                                p_garantee_id wcs_garantees.id%type -- Идентификатор типа обеспечения
                                ) return number;

  -- Удаляет обеспечение заявки
  procedure bid_garantee_del(p_bid_id       wcs_bids.id%type, -- Идентификатор заявки
                             p_garantee_id  wcs_garantees.id%type, -- Идентификатор типа обеспечения
                             p_garantee_num number -- Номер
                             );

  -- Устанавливает статус обеспечение заявки
  procedure bid_garantee_status_set(p_bid_id       wcs_bids.id%type, -- Идентификатор заявки
                                    p_garantee_id  wcs_garantees.id%type, -- Идентификатор типа обеспечения
                                    p_garantee_num number, -- № обеспечения
                                    p_status_id    number -- Ид. статуса
                                    );
  -- ------------------------- Обеспечение --------------------------------------

  -- ------------------------- Шаблоны договоров --------------------------------------
  -- Создает/обновляет шаблон
  procedure template_set(p_template_id    v_wcs_templates.template_id%type, -- Идентификатор шаблона
                         p_template_name  v_wcs_templates.template_name%type, -- Наименование шаблона
                         p_file_name      v_wcs_templates.file_name%type, -- Имя файла шаблона
                         p_docexp_type_id v_wcs_templates.docexp_type_id%type default 'PDF' -- Формат экспорта
                         );

  -- Удаляет шаблон
  procedure template_del(p_template_id v_wcs_templates.template_id%type -- Идентификатор шаблона
                         );

  -- Создает/обновляет шаблон субпродукта
  procedure sbp_template_set(p_subproduct_id  wcs_subproduct_templates.subproduct_id%type, -- Идентификатор субродукта
                             p_template_id    wcs_subproduct_templates.template_id%type, -- Идентификатор шаблона
                             p_print_state_id wcs_subproduct_templates.print_state_id%type, -- Идентификатор этапа печати
                             p_is_scan_req    wcs_subproduct_templates.is_scan_required%type -- Обязательно ли сканирование отпечатка
                             );

  -- Удаляет шаблон субпродукта
  procedure sbp_template_del(p_subproduct_id wcs_subproduct_templates.subproduct_id%type, -- Идентификатор субродукта
                             p_template_id   wcs_subproduct_templates.template_id%type -- Идентификатор шаблона
                             );

  -- Клонирует шаблоны субпродукта
  procedure sbp_template_clone(p_subproduct_id     wcs_subproduct_templates.subproduct_id%type, -- Идентификатор субпродукта
                               p_src_subproduct_id wcs_subproduct_templates.subproduct_id%type -- Идентификатор субпродукта-источника для клонирования
                               );
  -- ------------------------- Шаблоны договоров --------------------------------------

  -- ------------------------- Платежные инструкции --------------------------------------
  -- Добавляет платежную инструкцию субпродукта
  procedure sbp_payment_set(p_subproduct_id wcs_subproduct_payments.subproduct_id%type, -- Идентификатор субродукта
                            p_payment_id    wcs_subproduct_payments.payment_id%type -- Идентификатор платежной инструкции
                            );

  -- Удаляет платежную инструкцию субпродукта
  procedure sbp_payment_del(p_subproduct_id wcs_subproduct_payments.subproduct_id%type, -- Идентификатор субродукта
                            p_payment_id    wcs_subproduct_payments.payment_id%type -- Идентификатор платежной инструкции
                            );
  -- Клонирует платежные инструкции субпродукта
  procedure sbp_payment_clone(p_subproduct_id     wcs_subproducts.id%type, -- Идентификатор субпродукта
                              p_src_subproduct_id wcs_subproducts.id%type -- Идентификатор субпродукта-источника для клонирования
                              );

  -- Добавляет тип торговца-партнера субпродукта
  procedure sbp_ptrtype_set(p_subproduct_id wcs_subproduct_ptrtypes.subproduct_id%type, -- Идентификатор субродукта
                            p_ptr_type_id   wcs_subproduct_ptrtypes.ptr_type_id%type -- Тип торговца-партнера
                            );

  -- Удаляет тип торговца-партнера субпродукта
  procedure sbp_ptrtype_del(p_subproduct_id wcs_subproduct_ptrtypes.subproduct_id%type, -- Идентификатор субродукта
                            p_ptr_type_id   wcs_subproduct_ptrtypes.ptr_type_id%type -- Тип торговца-партнера
                            );

  -- Клонирует типы торговцев-партнеров субпродукта
  procedure sbp_ptrtype_clone(p_subproduct_id     wcs_subproducts.id%type, -- Идентификатор субпродукта
                              p_src_subproduct_id wcs_subproducts.id%type -- Идентификатор субпродукта-источника для клонирования
                              );
  -- ------------------------- Платежные инструкции --------------------------------------

/*
  -- ---------------- Администрирование -------------------------------------
  -- Добавляет субпродукт в отделение
  procedure branch_subproduct_add(p_branch        in varchar2, -- Идентификатор отделения
                                  p_subproduct_id in varchar2 -- Идентификатор субпродукта
                                  );

  -- Удаляет субпродукт из отделение
  procedure branch_subproduct_del(p_branch        in varchar2, -- Идентификатор отделения
                                  p_subproduct_id in varchar2 -- Идентификатор субпродукта
                                  );

  -- Добавляет партнера в отделение
  procedure branch_subproduct_partner(p_branch        in varchar2, -- Идентификатор отделения
                                      p_subproduct_id in varchar2, -- Идентификатор субпродукта
                                      p_partner_id    in varchar2, -- Идентификатор партнера
                                      p_grant         in number -- Тип выдачи 0 - не выдано; 1 - выдано; 2 - по настройкам субпродукта
                                      );

  -- ---------------- Администрирование -------------------------------------
*/
end wcs_pack;
/
CREATE OR REPLACE PACKAGE BODY BARS.WCS_PACK is

  -- ===============================================================================================
  g_body_version constant varchar2(64) := 'version 1.2 01/09/2015';
  -- header_version - возвращает версию заголовка пакета
  function header_version return varchar2 is
  begin
    return 'Package header wcs_pack ' || g_header_version || '.';
  end header_version;
  -- возвращает версию тела пакета
  function body_version return varchar2 is
  begin
    return 'Package body wcs_pack ' || g_body_version || '.';
  end body_version;
  -- ===============================================================================================

  /*
  TODO: owner="tvSukhov" created="14.02.2011"
  text="Добавить трассировки в процедуры"
  */

  -- ------------------------------- Вопросы ----------------------------------------
  -- Создает/обновляет вопрос
  procedure quest_set(question_id_ varchar2, -- Идентификатор вопроса
                      name_        varchar2, -- Наименование
                      type_id_     varchar2, -- Идентификатор типа
                      is_calcable_ number, -- Вычисляемое ли поле
                      calc_proc_   varchar2 -- Текст вычисления
                      ) is
  begin
    -- обновляем или вставляем
    update wcs_questions t
       set t.name        = name_,
           t.type_id     = type_id_,
           t.is_calcable = is_calcable_,
           t.calc_proc   = calc_proc_
     where id = question_id_;

    if (sql%rowcount = 0) then
      insert into wcs_questions
        (id, name, type_id, is_calcable, calc_proc)
      values
        (question_id_, name_, type_id_, is_calcable_, calc_proc_);
    end if;

    -- проверяем входит ли вопрос в скоринговые, если да то перестраиваем зависимости
    declare
      l_cnt number;
    begin
      execute immediate 'select count(*)
        from mv_wcs_scoring_subquestions ssq
       where ssq.question_id = :1'
        into l_cnt
        using question_id_;
      if (l_cnt > 0) then
        dbms_mview.refresh('MV_WCS_SCORING_SUBQUESTIONS');
      end if;
    end;

    -- проверяем входит ли вопрос в анкету, если да то перестраиваем зависимости
    declare
      l_cnt number;
    begin
      select count(*)
        into l_cnt
        from wcs_survey_group_questions sgq
       where sgq.question_id = question_id_
         and sgq.rectype_id != 'SECTION';
      if (l_cnt > 0) then
        dbms_mview.refresh('MV_WCS_SUR_GRP_QUEST_RELATION');
      end if;
    end;
  end quest_set;

  -- Удаляет вопрос
  procedure quest_del(question_id_ varchar2 -- Идентификатор вопроса
                      ) is
  begin
    -- удаляем
    delete from wcs_questions t where t.id = question_id_;
  end quest_del;

  -- Создает/обновляет параметры вопроса (мин, макс, дефолтное значение) - текстового поля
  procedure quest_pars_text_set(question_id_ varchar2, -- Идентификатор вопроса
                                leng_min_    varchar2, -- Минимальная длина текстового поля
                                leng_max_    varchar2, -- Максимальная длина текстового поля
                                val_default_ varchar2, -- Дефолтное значение текстового поля
                                text_width_  number, -- Ширина текстового поля
                                text_rows_   number -- Кол-во рядков текстового поля
                                ) is
  begin
    -- обновляем или вставляем
    update wcs_question_params qp
       set qp.text_leng_min    = leng_min_,
           qp.text_leng_max    = leng_max_,
           qp.text_val_default = val_default_,
           qp.text_width       = text_width_,
           qp.text_rows        = text_rows_
     where qp.question_id = question_id_;

    if (sql%rowcount = 0) then
      insert into wcs_question_params
        (question_id,
         text_leng_min,
         text_leng_max,
         text_val_default,
         text_width,
         text_rows)
      values
        (question_id_,
         leng_min_,
         leng_max_,
         val_default_,
         text_width_,
         text_rows_);
    end if;
  end quest_pars_text_set;

  -- Создает/обновляет параметры вопроса (мин, макс, дефолтное значение) - числа
  procedure quest_pars_nmbdec_set(question_id_ varchar2, -- Идентификатор вопроса
                                  val_min_     varchar2, -- Минимальное значение числа
                                  val_max_     varchar2, -- Максимальное значение числа
                                  val_default_ varchar2 -- Дефолтное значение числа
                                  ) is
  begin
    -- обновляем или вставляем
    update wcs_question_params
       set nmbdec_val_min     = val_min_,
           nmbdec_val_max     = val_max_,
           nmbdec_val_default = val_default_
     where question_id = question_id_;

    if (sql%rowcount = 0) then
      insert into wcs_question_params
        (question_id, nmbdec_val_min, nmbdec_val_max, nmbdec_val_default)
      values
        (question_id_, val_min_, val_max_, val_default_);
    end if;
  end quest_pars_nmbdec_set;

  -- Создает/обновляет параметры вопроса (мин, макс, дефолтное значение) - даты
  procedure quest_pars_dat_set(question_id_ varchar2, -- Идентификатор вопроса
                               val_min_     varchar2, -- Минимальное значение даты
                               val_max_     varchar2, -- Максимальное значение даты
                               val_default_ varchar2 -- Дефолтное значение даты
                               ) is
  begin
    -- обновляем или вставляем
    update wcs_question_params
       set dat_val_min     = val_min_,
           dat_val_max     = val_max_,
           dat_val_default = val_default_
     where question_id = question_id_;

    if (sql%rowcount = 0) then
      insert into wcs_question_params
        (question_id, dat_val_min, dat_val_max, dat_val_default)
      values
        (question_id_, val_min_, val_max_, val_default_);
    end if;
  end quest_pars_dat_set;

  -- Создает/обновляет параметры вопроса (мин, макс, дефолтное значение) - выбраное из списка
  procedure quest_pars_list_set(question_id_ varchar2, -- Идентификатор вопроса
                                sid_default_ varchar2, -- Дефолтное значение выбраное из списка
                                text_width_  number -- Ширина текстового поля
                                ) is
  begin
    -- обновляем или вставляем
    update wcs_question_params t
       set t.list_sid_default = sid_default_,
           t.text_width = text_width_
     where t.question_id = question_id_;

    if (sql%rowcount = 0) then
      insert into wcs_question_params
        (question_id, list_sid_default, text_width)
      values
        (question_id_, sid_default_, text_width_);
    end if;
  end quest_pars_list_set;

  -- Создает/обновляет параметры вопроса - выбраное из списка (добвляет вариант ответа)
  procedure quest_list_item_set(p_question_id wcs_question_list_items.question_id%type, -- Идентификатор вопроса
                                p_ord         wcs_question_list_items.ord%type, -- Порядок вопроса
                                p_text        wcs_question_list_items.text%type, -- Текст ответа
                                p_visible     wcs_question_list_items.visible%type -- Флаг активности записи
                                ) is
    l_check            number;
    l_next_ord         number;
    l_next_visible_ord number;
  begin
    -- проверяем чтоб параметр был списочным
    select count(*)
      into l_check
      from wcs_questions
     where id = p_question_id
       and type_id = 'LIST';

    if (l_check > 0) then
      -- берем максимальный номер
      select nvl(max(t.ord), -1) + 1
        into l_next_ord
        from wcs_question_list_items t
       where t.question_id = p_question_id;
      select nvl(max(t.visible_ord), -1) + 1
        into l_next_visible_ord
        from wcs_question_list_items t
       where t.question_id = p_question_id;
      -- обновляем или добавляем
      update wcs_question_list_items t
         set t.text = p_text, t.visible = p_visible
       where t.question_id = p_question_id
         and t.ord = p_ord;

      if (sql%rowcount = 0) then
        insert into wcs_question_list_items
          (question_id, ord, text, visible, visible_ord)
        values
          (p_question_id,
           l_next_ord,
           p_text,
           p_visible,
           l_next_visible_ord);
      end if;
    end if;
  end quest_list_item_set;

  -- Удаляет параметры вопроса - выбраное из списка (удаляет вариант ответа)
  procedure quest_list_item_del(p_question_id wcs_question_list_items.question_id%type, -- Идентификатор вопроса
                                p_ord         wcs_question_list_items.ord%type -- Порядок вопроса
                                ) is
  begin
    -- удаляем вариант ответа
    delete from wcs_question_list_items t
     where t.question_id = p_question_id
       and t.ord = p_ord;
  end quest_list_item_del;

  -- Создает/обновляет параметры вопроса - выбраное из списка (перемещает вариант ответа)
  procedure quest_list_item_move(p_question_id wcs_question_list_items.question_id%type, -- Идентификатор вопроса
                                 p_src_ord     wcs_question_list_items.ord%type, -- Порядок источника
                                 p_dest_ord    wcs_question_list_items.ord%type -- Порядок назначения
                                 ) is
    l_src  wcs_question_list_items%rowtype;
    l_dest wcs_question_list_items%rowtype;
  begin
    select qli.*
      into l_src
      from wcs_question_list_items qli
     where qli.question_id = p_question_id
       and qli.ord = p_src_ord;
    select qli.*
      into l_dest
      from wcs_question_list_items qli
     where qli.question_id = p_question_id
       and qli.ord = p_dest_ord;

    update wcs_question_list_items qli
       set qli.visible_ord = l_dest.visible_ord
     where qli.question_id = l_src.question_id
       and qli.ord = l_src.ord;
    update wcs_question_list_items qli
       set qli.visible_ord = l_src.visible_ord
     where qli.question_id = l_dest.question_id
       and qli.ord = l_dest.ord;
  exception
    when no_data_found then
      null;
  end quest_list_item_move;

  -- Создает/обновляет параметры вопроса (дефолтное значение, параметры справочника) - справочник
  procedure quest_pars_ref_set(p_question_id    varchar2, -- Идентификатор вопроса
                               p_text_width     number, -- Ширина текстового поля
                               p_text_rows      number, -- Кол-во рядков текстового поля
                               p_sid_default    varchar2, -- Дефолтное значение выбраное из справочника
                               p_tab_id         integer default null, -- Идентификатор таблицы справочника
                               p_key_field      varchar2 default null, -- Ключевое поле
                               p_semantic_field varchar2 default null, -- Поле семантики
                               p_show_fields    varchar2 default null, -- Поля для отображения (перечисление через запятую)
                               p_where_clause   varchar2 default null -- Условие отбора (включая слово where)
                               ) is
    l_check number;
  begin
    -- проверяем чтоб параметр был справочник
    select count(*)
      into l_check
      from wcs_questions
     where id = p_question_id
       and type_id = 'REFER';

    if (l_check > 0) then
      if (p_sid_default is not null or p_text_width is not null or
         p_text_rows is not null) then
        -- обновляем или вставляем
        update wcs_question_params t
           set t.refer_sid_default = p_sid_default,
               t.text_width        = p_text_width,
               t.text_rows         = p_text_rows
         where t.question_id = p_question_id;

        if (sql%rowcount = 0) then
          insert into wcs_question_params
            (question_id, refer_sid_default, text_width, text_rows)
          values
            (p_question_id, p_sid_default, p_text_width, p_text_rows);
        end if;
      else
        delete from wcs_question_params t
         where t.question_id = p_question_id;
      end if;

      -- обновляем или вставляем (параметры справочника)
      update wcs_question_refer_params t
         set t.tab_id         = p_tab_id,
             t.key_field      = p_key_field,
             t.semantic_field = p_semantic_field,
             t.show_fields    = p_show_fields,
             t.where_clause   = p_where_clause
       where t.question_id = p_question_id;

      if (sql%rowcount = 0) then
        insert into wcs_question_refer_params
          (question_id,
           tab_id,
           key_field,
           semantic_field,
           show_fields,
           where_clause)
        values
          (p_question_id,
           p_tab_id,
           p_key_field,
           p_semantic_field,
           p_show_fields,
           p_where_clause);
      end if;
    end if;
  end quest_pars_ref_set;

  -- Создает/обновляет параметры вопроса (оси матрицы) - матрица
  procedure quest_mtx_axis_set(question_id_ varchar2, -- Идентификатор вопроса
                               axis_qid_    varchar2, -- Идентификатор вопроса - ось матрицы
                               ord_         number default null -- Порядок оси
                               ) is
    l_check_    number;
    l_next_ord_ number;
  begin
    -- проверяем чтоб параметр был справочник
    select count(*)
      into l_check_
      from wcs_questions
     where id = question_id_
       and type_id = 'MATRIX';
    if (l_check_ > 0) then
      -- берем максимальный номер
      select nvl(max(ord), -1) + 1
        into l_next_ord_
        from wcs_question_matrix_params t
       where t.question_id = question_id_;

      -- обновляем или вставляем
      update wcs_question_matrix_params t
         set t.ord = ord_
       where t.question_id = question_id_
         and t.axis_qid = axis_qid_
         and t.ord = ord_;

      if (sql%rowcount = 0) then
        insert into wcs_question_matrix_params
          (question_id, axis_qid, ord)
        values
          (question_id_, axis_qid_, l_next_ord_);
      end if;
    end if;
  end quest_mtx_axis_set;

  -- Удаляет параметры вопроса (оси матрицы) - матрица
  procedure quest_mtx_axis_del(question_id_ varchar2, -- Идентификатор вопроса
                               axis_qid_    varchar2 -- Идентификатор вопроса - ось матрицы
                               ) is
  begin
    -- удаляем (параметры справочника)
    delete from wcs_question_matrix_params t
     where t.question_id = question_id_
       and t.axis_qid = axis_qid_;
  end quest_mtx_axis_del;

  -- Создает/обновляет параметры вопроса (дефолтное значение) - булевого поля
  procedure quest_pars_bool_set(question_id_ varchar2, -- Идентификатор вопроса
                                val_default_ varchar2 -- Дефолтное значение булевого поля
                                ) is
  begin
    -- обновляем или вставляем
    update wcs_question_params qp
       set qp.bool_val_default = val_default_
     where question_id = question_id_;

    if (sql%rowcount = 0) then
      insert into wcs_question_params
        (question_id, bool_val_default)
      values
        (question_id_, val_default_);
    end if;
  end quest_pars_bool_set;

  -- Клонирует вопрос
  procedure quest_clone(p_question_id     wcs_questions.id%type, -- Идентификатор вопроса
                        p_src_question_id wcs_questions.id%type -- Идентификатор вопроса-источника
                        ) is
    l_q_row  wcs_questions%rowtype;
    l_qp_row wcs_question_params%rowtype;
  begin
    -- основные параметры
    select *
      into l_q_row
      from wcs_questions q
     where q.id = p_src_question_id;
    wcs_pack.quest_set(p_question_id,
                       l_q_row.name || '(копія)',
                       l_q_row.type_id,
                       l_q_row.is_calcable,
                       l_q_row.calc_proc);

    -- дочерние данные
    case l_q_row.type_id
      when ('LIST') then
        for cur in (select *
                      from wcs_question_list_items qli
                     where qli.question_id = p_src_question_id) loop
          wcs_pack.quest_list_item_set(p_question_id,
                                       cur.ord,
                                       cur.text,
                                       cur.visible);
        end loop;
      when ('REFER') then
        for cur in (select *
                      from v_wcs_question_params qp
                     where qp.id = p_src_question_id) loop
          wcs_pack.quest_pars_ref_set(p_question_id,
                                      cur.text_width,
                                      cur.text_rows,
                                      cur.refer_sid_default,
                                      cur.tab_id,
                                      cur.key_field,
                                      cur.semantic_field,
                                      cur.show_fields,
                                      cur.where_clause);
        end loop;
      else
        null;
    end case;

    -- дополнительные параметры
    begin
      select *
        into l_qp_row
        from wcs_question_params qp
       where qp.question_id = p_src_question_id;

      case l_q_row.type_id
        when ('TEXT') then
          wcs_pack.quest_pars_text_set(p_question_id,
                                       l_qp_row.text_leng_min,
                                       l_qp_row.text_leng_max,
                                       l_qp_row.text_val_default,
                                       l_qp_row.text_width,
                                       l_qp_row.text_rows);
        when ('NUMB') then
          wcs_pack.quest_pars_nmbdec_set(p_question_id,
                                         l_qp_row.nmbdec_val_min,
                                         l_qp_row.nmbdec_val_max,
                                         l_qp_row.nmbdec_val_default);
        when ('DECIMAL') then
          wcs_pack.quest_pars_nmbdec_set(p_question_id,
                                         l_qp_row.nmbdec_val_min,
                                         l_qp_row.nmbdec_val_max,
                                         l_qp_row.nmbdec_val_default);
        when ('DATE') then
          wcs_pack.quest_pars_dat_set(p_question_id,
                                      l_qp_row.dat_val_min,
                                      l_qp_row.dat_val_max,
                                      l_qp_row.dat_val_default);
        when ('LIST') then
          wcs_pack.quest_pars_list_set(p_question_id,
                                       l_qp_row.list_sid_default,
                                       l_qp_row.text_width);
        when ('REFER') then
          null;
        when ('BOOL') then
          wcs_pack.quest_pars_bool_set(p_question_id,
                                       l_qp_row.bool_val_default);
        else
          null;
      end case;
    exception
      when no_data_found then
        null;
    end;
  end quest_clone;
  -- ------------------------------- Вопросы ----------------------------------------

  -- ------------------------------- Продукты --------------------------------------
  -- Создает/обновляет продукт
  procedure prod_set(product_id_ varchar2, -- Идентификатор продукта
                     name_       varchar2 -- Наименование
                     ) is
  begin
    -- обновляем или вставляем
    update wcs_products t set t.name = name_ where t.id = product_id_;

    if (sql%rowcount = 0) then
      insert into wcs_products (id, name) values (product_id_, name_);
    end if;
  end prod_set;

  -- Удаляет продукт
  procedure prod_del(product_id_ varchar2 -- Идентификатор продукта
                     ) is
  begin
    -- удаляем
    delete from wcs_products t where t.id = product_id_;
  end prod_del;

  -- Создает/обновляет субпродукт
  procedure sbprod_set(subproduct_id_ varchar2, -- Идентификатор субпродукта
                       name_          varchar2, -- Наименование
                       product_id_    varchar2 -- Идентификатор продукта
                       ) is
    l_check_ number;
  begin
    -- проверяем чтоб был такой продукт
    select count(*) into l_check_ from wcs_products where id = product_id_;
    if (l_check_ > 0) then
      -- обновляем или вставляем
      update wcs_subproducts t
         set t.name = name_
       where t.id = subproduct_id_
         and t.product_id = product_id_;

      if (sql%rowcount = 0) then
        insert into wcs_subproducts
          (id, name, product_id)
        values
          (subproduct_id_, name_, product_id_);
      end if;
    end if;
  end sbprod_set;

  -- Удаляет субпродукт
  procedure sbprod_del(subproduct_id_ varchar2 -- Идентификатор субпродукт
                       ) is
  begin
    -- удаляем из зависимых объектов
    -- МАКи
    for cur in (select *
                  from wcs_subproduct_macs sm
                 where sm.subproduct_id = subproduct_id_) loop
      sbprod_mac_del(cur.subproduct_id, cur.mac_id);
    end loop;
    -- Данные кредита
    for cur in (select *
                  from wcs_subproduct_creditdata sc
                 where sc.subproduct_id = subproduct_id_) loop
      sbp_crddata_del(cur.subproduct_id, cur.crddata_id);
    end loop;
    -- Стопы
    for cur in (select *
                  from wcs_subproduct_stops ss
                 where ss.subproduct_id = subproduct_id_) loop
      sbprod_stop_del(cur.subproduct_id, cur.stop_id);
    end loop;
    -- Сканкопии
    for cur in (select *
                  from wcs_subproduct_scancopies ss
                 where ss.subproduct_id = subproduct_id_) loop
      sbprod_scopy_del(cur.subproduct_id);
    end loop;
    -- Авторизации
    for cur in (select *
                  from wcs_subproduct_authorizations sa
                 where sa.subproduct_id = subproduct_id_) loop
      sbprod_auth_del(cur.subproduct_id);
    end loop;
    -- Анкета
    for cur in (select *
                  from wcs_subproduct_survey ss
                 where ss.subproduct_id = subproduct_id_) loop
      sbprod_survey_del(cur.subproduct_id);
    end loop;
    -- Скоринг
    for cur in (select *
                  from wcs_subproduct_scoring ss
                 where ss.subproduct_id = subproduct_id_) loop
      sbprod_scor_del(cur.subproduct_id);
    end loop;
    -- Кредитоспособность
    for cur in (select *
                  from wcs_subproduct_solvency ss
                 where ss.subproduct_id = subproduct_id_) loop
      sbprod_solv_del(cur.subproduct_id);
    end loop;
    -- Информационные запросы
    for cur in (select *
                  from wcs_subproduct_infoqueries si
                 where si.subproduct_id = subproduct_id_) loop
      sbprod_iquery_del(cur.subproduct_id, cur.iquery_id);
    end loop;
    -- Страховка клиента
    for cur in (select *
                  from wcs_subproduct_insurances si
                 where si.subproduct_id = subproduct_id_) loop
      sbp_insurance_del(cur.subproduct_id, cur.insurance_id);
    end loop;
    -- Обеспечение
    for cur in (select *
                  from wcs_subproduct_garantees sg
                 where sg.subproduct_id = subproduct_id_) loop
      sbp_garantee_del(cur.subproduct_id, cur.garantee_id);
    end loop;
    -- Шаблоны
    for cur in (select *
                  from wcs_subproduct_ptrtypes sp
                 where sp.subproduct_id = subproduct_id_) loop
      sbp_ptrtype_del(cur.subproduct_id, cur.ptr_type_id);
    end loop;
    -- Платежные инструкции
    for cur in (select *
                  from wcs_subproduct_payments sp
                 where sp.subproduct_id = subproduct_id_) loop
      sbp_payment_del(cur.subproduct_id, cur.payment_id);
    end loop;
    -- Клонирует типы торговцев-партнеров субпродукта
    for cur in (select *
                  from wcs_subproduct_templates st
                 where st.subproduct_id = subproduct_id_) loop
      sbp_template_del(cur.subproduct_id, cur.template_id);
    end loop;

    -- !!! вынести в процедуру
    delete from wcs_subproduct_branches sa
     where sa.subproduct_id = subproduct_id_;

    -- удаляем
    delete from wcs_subproducts t where t.id = subproduct_id_;
  end sbprod_del;

  -- Клонирует субпродукт
  procedure sbprod_clone(p_subproduct_id     wcs_subproducts.id%type, -- Идентификатор субпродукта
                         p_src_subproduct_id wcs_subproducts.id%type -- Идентификатор субпродукта-источника для клонирования
                         ) is
  begin
    -- МАКи
    sbprod_macs_clone(p_subproduct_id, p_src_subproduct_id);
    -- Данные кредита
    sbp_crddata_clone(p_subproduct_id, p_src_subproduct_id);
    -- Стопы
    sbp_stop_clone(p_subproduct_id, p_src_subproduct_id);
    -- Сканкопии
    sbp_scopy_clone(p_subproduct_id, p_src_subproduct_id);
    -- Авторизации
    sbp_auth_clone(p_subproduct_id, p_src_subproduct_id);
    -- Анкета
    sbp_survey_clone(p_subproduct_id, p_src_subproduct_id);
    -- Скоринг
    sbp_scor_clone(p_subproduct_id, p_src_subproduct_id);
    -- Кредитоспособность
    sbp_solv_clone(p_subproduct_id, p_src_subproduct_id);
    -- Информационные запросы
    sbprod_iquery_clone(p_subproduct_id, p_src_subproduct_id);
    -- Страховка клиента
    sbp_insurance_clone(p_subproduct_id, p_src_subproduct_id);
    -- Обеспечение
    sbp_garantee_clone(p_subproduct_id, p_src_subproduct_id);
    -- Шаблоны
    sbp_template_clone(p_subproduct_id, p_src_subproduct_id);
    -- Платежные инструкции
    sbp_payment_clone(p_subproduct_id, p_src_subproduct_id);
    -- Клонирует типы торговцев-партнеров субпродукта
    sbp_ptrtype_clone(p_subproduct_id, p_src_subproduct_id);

  end sbprod_clone;

  -- Создает/обновляет МАК
  procedure mac_set(p_mac_id      wcs_macs.id%type, -- Идентификатор МАКа
                    p_name        wcs_macs.name%type, -- Наименование
                    p_type_id     wcs_macs.type_id%type, -- Тип
                    p_apply_level wcs_macs.apply_level%type -- Уровень применения
                    ) is
  begin
    -- обновляем или вставляем
    update wcs_macs m
       set m.name        = p_name,
           m.type_id     = p_type_id,
           m.apply_level = p_apply_level
     where m.id = p_mac_id;

    if (sql%rowcount = 0) then
      insert into wcs_macs
        (id, name, type_id, apply_level)
      values
        (p_mac_id, p_name, p_type_id, p_apply_level);
    end if;
  end mac_set;

  -- Удаляет МАК
  procedure mac_del(p_mac_id wcs_macs.id%type -- Идентификатор МАКа
                    ) is
  begin
    -- удаляем дочерние записи
    delete from wcs_mac_list_items mli where mli.mac_id = p_mac_id;
    delete from wcs_mac_refer_params mrp where mrp.mac_id = p_mac_id;

    -- удаляем
    delete from wcs_macs m where m.id = p_mac_id;
  end mac_del;

  -- Создает/обновляет МАК - выбраное из списка (добвляет вариант ответа)
  procedure mac_list_item_set(mac_id_ varchar2, -- Идентификатор МАКа
                              ord_    number, -- Порядок вопроса
                              text_   varchar2 -- Текст ответа
                              ) is
    l_check_    number;
    l_next_ord_ number;
  begin
    -- проверяем чтоб МАК был списочным
    select count(*)
      into l_check_
      from wcs_macs t
     where t.id = mac_id_
       and t.type_id = 'LIST';
    if (l_check_ > 0) then
      -- берем максимальный номер
      select nvl(max(ord), -1) + 1
        into l_next_ord_
        from wcs_mac_list_items t
       where t.mac_id = mac_id_;

      -- обновляем или добавляем
      update wcs_mac_list_items t
         set t.text = text_
       where t.mac_id = mac_id_
         and t.ord = ord_;

      if (sql%rowcount = 0) then
        insert into wcs_mac_list_items
          (mac_id, ord, text)
        values
          (mac_id_, l_next_ord_, text_);
      end if;
    end if;
  end mac_list_item_set;

  -- Создает/обновляет МАК - выбраное из списка (перемещает вариант ответа)
  procedure mac_list_item_move(p_mac_id   wcs_mac_list_items.mac_id%type, -- Идентификатор МАКа
                               p_src_ord  wcs_mac_list_items.ord%type, -- Порядок источника
                               p_dest_ord wcs_mac_list_items.ord%type -- Порядок назначения
                               ) is
    l_src_text  wcs_mac_list_items.text%type;
    l_dest_text wcs_mac_list_items.text%type;
  begin
    select mli.text
      into l_src_text
      from wcs_mac_list_items mli
     where mli.mac_id = p_mac_id
       and mli.ord = p_src_ord;
    select mli.text
      into l_dest_text
      from wcs_mac_list_items mli
     where mli.mac_id = p_mac_id
       and mli.ord = p_dest_ord;

    update wcs_mac_list_items mli
       set mli.text = l_dest_text
     where mli.ord = p_src_ord;
    update wcs_mac_list_items mli
       set mli.text = l_src_text
     where mli.ord = p_dest_ord;
  exception
    when no_data_found then
      null;
  end mac_list_item_move;

  -- Удаляет МАК - выбраное из списка (удаляет вариант ответа)
  procedure mac_list_item_del(mac_id_ varchar2, -- Идентификатор МАКа
                              ord_    number -- Порядок вопроса
                              ) is
  begin
    -- удаляем вариант ответа
    delete from wcs_mac_list_items t
     where t.mac_id = mac_id_
       and t.ord = ord_;
  end mac_list_item_del;

  -- Создает/обновляет МАК - справочник
  procedure mac_refer_param_set(mac_id_         varchar2, -- Идентификатор МАКа
                                tab_id_         integer, -- Идентификатор таблицы справочника
                                key_field_      varchar2, -- Ключевое поле
                                semantic_field_ varchar2, -- Поле семантики
                                show_fields_    varchar2 default null, -- Поля для отображения (перечисление через запятую)
                                where_clause_   varchar2 default null -- Условие отбора (включая слово where)
                                ) is
    l_check_ number;
  begin
    -- проверяем тип МАКа
    select count(*)
      into l_check_
      from wcs_macs t
     where t.id = mac_id_
       and t.type_id = 'REFER';

    if (l_check_ > 0) then
      -- обновляем или вставляем
      update wcs_mac_refer_params t
         set t.tab_id         = tab_id_,
             t.key_field      = key_field_,
             t.semantic_field = semantic_field_,
             t.show_fields    = show_fields_,
             t.where_clause   = where_clause_
       where t.mac_id = mac_id_;

      if (sql%rowcount = 0) then
        insert into wcs_mac_refer_params
          (mac_id,
           tab_id,
           key_field,
           semantic_field,
           show_fields,
           where_clause)
        values
          (mac_id_,
           tab_id_,
           key_field_,
           semantic_field_,
           show_fields_,
           where_clause_);
      end if;
    end if;
  end mac_refer_param_set;

  -- Удаляет МАК - справочник
  procedure mac_refer_param_del(mac_id_ varchar2 -- Идентификатор МАКа
                                ) is
  begin
    -- удаляем вариант ответа
    delete from wcs_mac_refer_params t where t.mac_id = mac_id_;
  end mac_refer_param_del;

  -- Создает/обновляет МАК субпродукта - Текстовый
  procedure sbprod_mac_text_set(p_subproduct_id wcs_subproduct_macs.subproduct_id%type, -- Идентификатор субпродукта
                                p_mac_id        wcs_subproduct_macs.mac_id%type, -- Идентификатор МАКа
                                p_val           wcs_subproduct_macs.val_text%type, -- Значение
                                p_branch        wcs_subproduct_macs.branch%type default '/', -- Отделение
                                p_apply_date    wcs_subproduct_macs.apply_date%type default trunc(sysdate) + 1, -- Дата применения
                                p_comment       varchar2 default null -- Комментарий
                                ) is
    l_proc_name varchar2(100) := 'sbprod_mac_text_set. ';

    l_old_value varchar2(4000);
    l_new_value varchar2(4000);

    l_chng_comment varchar2(4000);

    l_m_row wcs_macs%rowtype;
  begin
    -- проверяем тип МАКа
    begin
      select *
        into l_m_row
        from wcs_macs m
       where m.id = p_mac_id
         and m.type_id = 'TEXT';
    exception
      when no_data_found then
        return;
    end;

    -- новое и старое значения
    l_new_value := wcs_utl.get_val_formated(p_val,
                                            'TEXT',
                                            null,
                                            null,
                                            null,
                                            null,
                                            p_mac_id);
    select wcs_utl.get_val_formated(min(sm.val_text),
                                    'TEXT',
                                    null,
                                    null,
                                    null,
                                    null,
                                    p_mac_id)
      into l_old_value
      from wcs_subproduct_macs sm
     where sm.subproduct_id = p_subproduct_id
       and sm.mac_id = p_mac_id
       and sm.branch = p_branch
       and sm.apply_date = p_apply_date;

    if (l_old_value is not null) then
      -- обновляем
      update wcs_subproduct_macs sm
         set sm.val_text = p_val
       where sm.subproduct_id = p_subproduct_id
         and sm.mac_id = p_mac_id
         and sm.branch = p_branch
         and sm.apply_date = p_apply_date;

      l_chng_comment := 'Зміна значення МАКу ' || p_mac_id ||
                        ' субпродукту ' || p_subproduct_id ||
                        ' для бранчу ' || p_branch || ' за дату ' ||
                        to_char(p_apply_date, 'dd.mm.yyyy') || ' (з ' ||
                        l_old_value || ' на ' || l_new_value || ')';
    else
      -- удаляем пустое значение (если есть)
      delete from wcs_subproduct_macs sm
       where sm.subproduct_id = p_subproduct_id
         and sm.mac_id = p_mac_id
         and sm.branch = p_branch
         and sm.apply_date = p_apply_date;

      -- вставляем
      insert into wcs_subproduct_macs
        (subproduct_id, mac_id, branch, apply_date, val_text)
      values
        (p_subproduct_id, p_mac_id, p_branch, p_apply_date, p_val);

      l_chng_comment := 'Додано значення МАКу ' || p_mac_id ||
                        ' субпродукту ' || p_subproduct_id ||
                        ' для бранчу ' || p_branch || ' за дату ' ||
                        to_char(p_apply_date, 'dd.mm.yyyy') || ' (' ||
                        l_new_value || ')';
    end if;

    -- добавляем запись в таблицу синхронизации
    l_chng_comment := l_chng_comment || '. ' || p_comment;

    -- запись в протокол
    bars_audit.info(g_pack_name || l_proc_name || l_chng_comment);
  end sbprod_mac_text_set;

  -- Создает/обновляет МАК субпродукта - Целочисленный
  procedure sbprod_mac_numb_set(p_subproduct_id wcs_subproduct_macs.subproduct_id%type, -- Идентификатор субпродукта
                                p_mac_id        wcs_subproduct_macs.mac_id%type, -- Идентификатор МАКа
                                p_val           wcs_subproduct_macs.val_numb%type, -- Значение
                                p_branch        wcs_subproduct_macs.branch%type default '/', -- Отделение
                                p_apply_date    wcs_subproduct_macs.apply_date%type default trunc(sysdate) + 1, -- Дата применения
                                p_comment       varchar2 default null -- Комментарий
                                ) is
    l_proc_name varchar2(100) := 'sbprod_mac_numb_set. ';

    l_old_value varchar2(4000);
    l_new_value varchar2(4000);

    l_chng_comment varchar2(4000);

    l_m_row wcs_macs%rowtype;
  begin
    -- проверяем тип МАКа
    begin
      select *
        into l_m_row
        from wcs_macs m
       where m.id = p_mac_id
         and m.type_id = 'NUMB';
    exception
      when no_data_found then
        return;
    end;

    -- новое и старое значения
    l_new_value := wcs_utl.get_val_formated(p_val,
                                            'NUMB',
                                            null,
                                            null,
                                            null,
                                            null,
                                            p_mac_id);
    select wcs_utl.get_val_formated(min(sm.val_numb),
                                    'NUMB',
                                    null,
                                    null,
                                    null,
                                    null,
                                    p_mac_id)
      into l_old_value
      from wcs_subproduct_macs sm
     where sm.subproduct_id = p_subproduct_id
       and sm.mac_id = p_mac_id
       and sm.branch = p_branch
       and sm.apply_date = p_apply_date;

    if (l_old_value is not null) then
      -- обновляем
      update wcs_subproduct_macs sm
         set sm.val_numb = p_val
       where sm.subproduct_id = p_subproduct_id
         and sm.mac_id = p_mac_id
         and sm.branch = p_branch
         and sm.apply_date = p_apply_date;

      l_chng_comment := 'Зміна значення МАКу ' || p_mac_id ||
                        ' субпродукту ' || p_subproduct_id ||
                        ' для бранчу ' || p_branch || ' за дату ' ||
                        to_char(p_apply_date, 'dd.mm.yyyy') || ' (з ' ||
                        l_old_value || ' на ' || l_new_value || ')';
    else
      -- удаляем пустое значение (если есть)
      delete from wcs_subproduct_macs sm
       where sm.subproduct_id = p_subproduct_id
         and sm.mac_id = p_mac_id
         and sm.branch = p_branch
         and sm.apply_date = p_apply_date;

      -- вставляем
      insert into wcs_subproduct_macs
        (subproduct_id, mac_id, branch, apply_date, val_numb)
      values
        (p_subproduct_id, p_mac_id, p_branch, p_apply_date, p_val);

      l_chng_comment := 'Додано значення МАКу ' || p_mac_id ||
                        ' субпродукту ' || p_subproduct_id ||
                        ' для бранчу ' || p_branch || ' за дату ' ||
                        to_char(p_apply_date, 'dd.mm.yyyy') || ' (' ||
                        l_new_value || ')';
    end if;

    -- добавляем запись в таблицу синхронизации
    l_chng_comment := l_chng_comment || '. ' || p_comment;

    -- запись в протокол
    bars_audit.info(g_pack_name || l_proc_name || l_chng_comment);
  end sbprod_mac_numb_set;

  -- Создает/обновляет МАК субпродукта - Дробное число
  procedure sbprod_mac_dec_set(p_subproduct_id wcs_subproduct_macs.subproduct_id%type, -- Идентификатор субпродукта
                               p_mac_id        wcs_subproduct_macs.mac_id%type, -- Идентификатор МАКа
                               p_val           wcs_subproduct_macs.val_decimal%type, -- Значение
                               p_branch        wcs_subproduct_macs.branch%type default '/', -- Отделение
                               p_apply_date    wcs_subproduct_macs.apply_date%type default trunc(sysdate) + 1, -- Дата применения
                               p_comment       varchar2 default null -- Комментарий
                               ) is
    l_proc_name varchar2(100) := 'sbprod_mac_dec_set. ';

    l_old_value varchar2(4000);
    l_new_value varchar2(4000);

    l_chng_comment varchar2(4000);

    l_m_row wcs_macs%rowtype;
  begin
    -- проверяем тип МАКа
    begin
      select *
        into l_m_row
        from wcs_macs m
       where m.id = p_mac_id
         and m.type_id = 'DECIMAL';
    exception
      when no_data_found then
        return;
    end;

    -- новое и старое значения
    l_new_value := wcs_utl.get_val_formated(p_val,
                                            'DECIMAL',
                                            null,
                                            null,
                                            null,
                                            null,
                                            p_mac_id);
    select wcs_utl.get_val_formated(min(sm.val_decimal),
                                    'DECIMAL',
                                    null,
                                    null,
                                    null,
                                    null,
                                    p_mac_id)
      into l_old_value
      from wcs_subproduct_macs sm
     where sm.subproduct_id = p_subproduct_id
       and sm.mac_id = p_mac_id
       and sm.branch = p_branch
       and sm.apply_date = p_apply_date;

    if (l_old_value is not null) then
      -- обновляем
      update wcs_subproduct_macs sm
         set sm.val_decimal = p_val
       where sm.subproduct_id = p_subproduct_id
         and sm.mac_id = p_mac_id
         and sm.branch = p_branch
         and sm.apply_date = p_apply_date;

      l_chng_comment := 'Зміна значення МАКу ' || p_mac_id ||
                        ' субпродукту ' || p_subproduct_id ||
                        ' для бранчу ' || p_branch || ' за дату ' ||
                        to_char(p_apply_date, 'dd.mm.yyyy') || ' (з ' ||
                        l_old_value || ' на ' || l_new_value || ')';
    else
      -- удаляем пустое значение (если есть)
      delete from wcs_subproduct_macs sm
       where sm.subproduct_id = p_subproduct_id
         and sm.mac_id = p_mac_id
         and sm.branch = p_branch
         and sm.apply_date = p_apply_date;

      -- вставляем
      insert into wcs_subproduct_macs
        (subproduct_id, mac_id, branch, apply_date, val_decimal)
      values
        (p_subproduct_id, p_mac_id, p_branch, p_apply_date, p_val);

      l_chng_comment := 'Додано значення МАКу ' || p_mac_id ||
                        ' субпродукту ' || p_subproduct_id ||
                        ' для бранчу ' || p_branch || ' за дату ' ||
                        to_char(p_apply_date, 'dd.mm.yyyy') || ' (' ||
                        l_new_value || ')';
    end if;

    -- добавляем запись в таблицу синхронизации
    l_chng_comment := l_chng_comment || '. ' || p_comment;

    -- запись в протокол
    bars_audit.info(g_pack_name || l_proc_name || l_chng_comment);
  end sbprod_mac_dec_set;

  -- Создает/обновляет МАК субпродукта - Дата
  procedure sbprod_mac_dat_set(p_subproduct_id wcs_subproduct_macs.subproduct_id%type, -- Идентификатор субпродукта
                               p_mac_id        wcs_subproduct_macs.mac_id%type, -- Идентификатор МАКа
                               p_val           wcs_subproduct_macs.val_date%type, -- Значение
                               p_branch        wcs_subproduct_macs.branch%type default '/', -- Отделение
                               p_apply_date    wcs_subproduct_macs.apply_date%type default trunc(sysdate) + 1, -- Дата применения
                               p_comment       varchar2 default null -- Комментарий
                               ) is
    l_proc_name varchar2(100) := 'sbprod_mac_dat_set. ';

    l_old_value varchar2(4000);
    l_new_value varchar2(4000);

    l_chng_comment varchar2(4000);

    l_m_row wcs_macs%rowtype;
  begin
    -- проверяем тип МАКа
    begin
      select *
        into l_m_row
        from wcs_macs m
       where m.id = p_mac_id
         and m.type_id = 'DATE';
    exception
      when no_data_found then
        return;
    end;

    -- новое и старое значения
    l_new_value := wcs_utl.get_val_formated(p_val,
                                            'DATE',
                                            null,
                                            null,
                                            null,
                                            null,
                                            p_mac_id);
    select wcs_utl.get_val_formated(min(sm.val_date),
                                    'DATE',
                                    null,
                                    null,
                                    null,
                                    null,
                                    p_mac_id)
      into l_old_value
      from wcs_subproduct_macs sm
     where sm.subproduct_id = p_subproduct_id
       and sm.mac_id = p_mac_id
       and sm.branch = p_branch
       and sm.apply_date = p_apply_date;

    if (l_old_value is not null) then
      -- обновляем
      update wcs_subproduct_macs sm
         set sm.val_date = p_val
       where sm.subproduct_id = p_subproduct_id
         and sm.mac_id = p_mac_id
         and sm.branch = p_branch
         and sm.apply_date = p_apply_date;

      l_chng_comment := 'Зміна значення МАКу ' || p_mac_id ||
                        ' субпродукту ' || p_subproduct_id ||
                        ' для бранчу ' || p_branch || ' за дату ' ||
                        to_char(p_apply_date, 'dd.mm.yyyy') || ' (з ' ||
                        l_old_value || ' на ' || l_new_value || ')';
    else
      -- удаляем пустое значение (если есть)
      delete from wcs_subproduct_macs sm
       where sm.subproduct_id = p_subproduct_id
         and sm.mac_id = p_mac_id
         and sm.branch = p_branch
         and sm.apply_date = p_apply_date;

      -- вставляем
      insert into wcs_subproduct_macs
        (subproduct_id, mac_id, branch, apply_date, val_date)
      values
        (p_subproduct_id, p_mac_id, p_branch, p_apply_date, p_val);

      l_chng_comment := 'Додано значення МАКу ' || p_mac_id ||
                        ' субпродукту ' || p_subproduct_id ||
                        ' для бранчу ' || p_branch || ' за дату ' ||
                        to_char(p_apply_date, 'dd.mm.yyyy') || ' (' ||
                        l_new_value || ')';
    end if;

    -- добавляем запись в таблицу синхронизации
    l_chng_comment := l_chng_comment || '. ' || p_comment;

    -- запись в протокол
    bars_audit.info(g_pack_name || l_proc_name || l_chng_comment);
  end sbprod_mac_dat_set;

  -- Создает/обновляет МАК субпродукта - Список
  procedure sbprod_mac_list_set(p_subproduct_id wcs_subproduct_macs.subproduct_id%type, -- Идентификатор субпродукта
                                p_mac_id        wcs_subproduct_macs.mac_id%type, -- Идентификатор МАКа
                                p_val           wcs_subproduct_macs.val_list%type, -- Значение
                                p_branch        wcs_subproduct_macs.branch%type default '/', -- Отделение
                                p_apply_date    wcs_subproduct_macs.apply_date%type default trunc(sysdate) + 1, -- Дата применения
                                p_comment       varchar2 default null -- Комментарий
                                ) is
    l_proc_name varchar2(100) := 'sbprod_mac_list_set. ';

    l_old_value varchar2(4000);
    l_new_value varchar2(4000);

    l_chng_comment varchar2(4000);

    l_m_row   wcs_macs%rowtype;
    l_mli_row wcs_mac_list_items%rowtype;
  begin
    -- проверяем тип МАКа
    begin
      select *
        into l_m_row
        from wcs_macs m
       where m.id = p_mac_id
         and m.type_id = 'LIST';
    exception
      when no_data_found then
        return;
    end;

    -- проверяем чтоб в списоке был такой ответ
    begin
      select *
        into l_mli_row
        from wcs_mac_list_items mli
       where mli.mac_id = p_mac_id
         and mli.ord = p_val;
    exception
      when no_data_found then
        return;
    end;

    -- новое и старое значения
    l_new_value := wcs_utl.get_val_formated(p_val,
                                            'LIST_MAC',
                                            null,
                                            null,
                                            null,
                                            null,
                                            p_mac_id);
    select wcs_utl.get_val_formated(min(sm.val_list),
                                    'LIST_MAC',
                                    null,
                                    null,
                                    null,
                                    null,
                                    p_mac_id)
      into l_old_value
      from wcs_subproduct_macs sm
     where sm.subproduct_id = p_subproduct_id
       and sm.mac_id = p_mac_id
       and sm.branch = p_branch
       and sm.apply_date = p_apply_date;

    if (l_old_value is not null) then
      -- обновляем
      update wcs_subproduct_macs sm
         set sm.val_list = p_val
       where sm.subproduct_id = p_subproduct_id
         and sm.mac_id = p_mac_id
         and sm.branch = p_branch
         and sm.apply_date = p_apply_date;

      l_chng_comment := 'Зміна значення МАКу ' || p_mac_id ||
                        ' субпродукту ' || p_subproduct_id ||
                        ' для бранчу ' || p_branch || ' за дату ' ||
                        to_char(p_apply_date, 'dd.mm.yyyy') || ' (з ' ||
                        l_old_value || ' на ' || l_new_value || ')';
    else
      -- удаляем пустое значение (если есть)
      delete from wcs_subproduct_macs sm
       where sm.subproduct_id = p_subproduct_id
         and sm.mac_id = p_mac_id
         and sm.branch = p_branch
         and sm.apply_date = p_apply_date;

      -- вставляем
      insert into wcs_subproduct_macs
        (subproduct_id, mac_id, branch, apply_date, val_list)
      values
        (p_subproduct_id, p_mac_id, p_branch, p_apply_date, p_val);

      l_chng_comment := 'Додано значення МАКу ' || p_mac_id ||
                        ' субпродукту ' || p_subproduct_id ||
                        ' для бранчу ' || p_branch || ' за дату ' ||
                        to_char(p_apply_date, 'dd.mm.yyyy') || ' (' ||
                        l_new_value || ')';
    end if;

    -- добавляем запись в таблицу синхронизации
    l_chng_comment := l_chng_comment || '. ' || p_comment;

    -- запись в протокол
    bars_audit.info(g_pack_name || l_proc_name || l_chng_comment);
  end sbprod_mac_list_set;

  -- Создает/обновляет МАК субпродукта - Справочник
  procedure sbprod_mac_ref_set(p_subproduct_id wcs_subproduct_macs.subproduct_id%type, -- Идентификатор субпродукта
                               p_mac_id        wcs_subproduct_macs.mac_id%type, -- Идентификатор МАКа
                               p_val           wcs_subproduct_macs.val_refer%type, -- Значение
                               p_branch        wcs_subproduct_macs.branch%type default '/', -- Отделение
                               p_apply_date    wcs_subproduct_macs.apply_date%type default trunc(sysdate) + 1, -- Дата применения
                               p_comment       varchar2 default null -- Комментарий
                               ) is
    l_proc_name varchar2(100) := 'sbprod_mac_ref_set. ';

    l_old_value varchar2(4000);
    l_new_value varchar2(4000);

    l_chng_comment varchar2(4000);

    l_m_row wcs_macs%rowtype;
  begin
    -- проверяем тип МАКа
    begin
      select *
        into l_m_row
        from wcs_macs m
       where m.id = p_mac_id
         and m.type_id = 'REFER';
    exception
      when no_data_found then
        return;
    end;

    -- новое и старое значения
    l_new_value := wcs_utl.get_val_formated(p_val,
                                            'REFER_MAC',
                                            null,
                                            null,
                                            null,
                                            null,
                                            p_mac_id);
    select wcs_utl.get_val_formated(min(sm.val_refer),
                                    'REFER_MAC',
                                    null,
                                    null,
                                    null,
                                    null,
                                    p_mac_id)
      into l_old_value
      from wcs_subproduct_macs sm
     where sm.subproduct_id = p_subproduct_id
       and sm.mac_id = p_mac_id
       and sm.branch = p_branch
       and sm.apply_date = p_apply_date;

    if (l_old_value is not null) then
      -- обновляем
      update wcs_subproduct_macs sm
         set sm.val_refer = p_val
       where sm.subproduct_id = p_subproduct_id
         and sm.mac_id = p_mac_id
         and sm.branch = p_branch
         and sm.apply_date = p_apply_date;

      l_chng_comment := 'Зміна значення МАКу ' || p_mac_id ||
                        ' субпродукту ' || p_subproduct_id ||
                        ' для бранчу ' || p_branch || ' за дату ' ||
                        to_char(p_apply_date, 'dd.mm.yyyy') || ' (з ' ||
                        l_old_value || ' на ' || l_new_value || ')';
    else
      -- удаляем пустое значение (если есть)
      delete from wcs_subproduct_macs sm
       where sm.subproduct_id = p_subproduct_id
         and sm.mac_id = p_mac_id
         and sm.branch = p_branch
         and sm.apply_date = p_apply_date;

      -- вставляем
      insert into wcs_subproduct_macs
        (subproduct_id, mac_id, branch, apply_date, val_refer)
      values
        (p_subproduct_id, p_mac_id, p_branch, p_apply_date, p_val);

      l_chng_comment := 'Додано значення МАКу ' || p_mac_id ||
                        ' субпродукту ' || p_subproduct_id ||
                        ' для бранчу ' || p_branch || ' за дату ' ||
                        to_char(p_apply_date, 'dd.mm.yyyy') || ' (' ||
                        l_new_value || ')';
    end if;

    -- добавляем запись в таблицу синхронизации
    l_chng_comment := l_chng_comment || '. ' || p_comment;

    -- запись в протокол
    bars_audit.info(g_pack_name || l_proc_name || l_chng_comment);
  end sbprod_mac_ref_set;

  -- Создает/обновляет МАК - Файл
  procedure sbprod_mac_file_set(p_subproduct_id wcs_subproduct_macs.subproduct_id%type, -- Идентификатор субпродукта
                                p_mac_id        wcs_subproduct_macs.mac_id%type, -- Идентификатор МАКа
                                p_val           wcs_subproduct_macs.val_file%type, -- Значение
                                p_branch        wcs_subproduct_macs.branch%type default '/', -- Отделение
                                p_apply_date    wcs_subproduct_macs.apply_date%type default trunc(sysdate) + 1, -- Дата применения
                                p_comment       varchar2 default null -- Комментарий
                                ) is
    l_proc_name varchar2(100) := 'sbprod_mac_file_set. ';

    l_old_value wcs_subproduct_macs.val_file%type;
    l_new_value wcs_subproduct_macs.val_file%type;

    l_chng_comment varchar2(4000);

    l_m_row wcs_macs%rowtype;
  begin
    -- проверяем тип МАКа
    begin
      select *
        into l_m_row
        from wcs_macs m
       where m.id = p_mac_id
         and m.type_id = 'FILE';
    exception
      when no_data_found then
        return;
    end;

    -- новое и старое значения
    l_new_value := p_val;
    begin
      select sm.val_file
        into l_old_value
        from wcs_subproduct_macs sm
       where sm.subproduct_id = p_subproduct_id
         and sm.mac_id = p_mac_id
         and sm.branch = p_branch
         and sm.apply_date = p_apply_date;
    exception
      when no_data_found then
        l_old_value := null;
    end;

    if (l_old_value is not null) then
      -- обновляем
      update wcs_subproduct_macs sm
         set sm.val_file = p_val
       where sm.subproduct_id = p_subproduct_id
         and sm.mac_id = p_mac_id
         and sm.branch = p_branch
         and sm.apply_date = p_apply_date;

      l_chng_comment := 'Зміна значення МАКу ' || p_mac_id ||
                        ' субпродукту ' || p_subproduct_id ||
                        ' для бранчу ' || p_branch || ' за дату ' ||
                        to_char(p_apply_date, 'dd.mm.yyyy') ||
                        ' (з <file> на <file>)';
    else
      -- удаляем пустое значение (если есть)
      delete from wcs_subproduct_macs sm
       where sm.subproduct_id = p_subproduct_id
         and sm.mac_id = p_mac_id
         and sm.branch = p_branch
         and sm.apply_date = p_apply_date;

      -- вставляем
      insert into wcs_subproduct_macs
        (subproduct_id, mac_id, branch, apply_date, val_file)
      values
        (p_subproduct_id, p_mac_id, p_branch, p_apply_date, p_val);

      l_chng_comment := 'Додано значення МАКу ' || p_mac_id ||
                        ' субпродукту ' || p_subproduct_id ||
                        ' для бранчу ' || p_branch || ' за дату ' ||
                        to_char(p_apply_date, 'dd.mm.yyyy') || ' (<file>)';
    end if;

    -- добавляем запись в таблицу синхронизации
    l_chng_comment := l_chng_comment || '. ' || p_comment;

    -- запись в протокол
    bars_audit.info(g_pack_name || l_proc_name || l_chng_comment);
  end sbprod_mac_file_set;

  -- Создает/обновляет МАК субпродукта - Булевый
  procedure sbprod_mac_bool_set(p_subproduct_id wcs_subproduct_macs.subproduct_id%type, -- Идентификатор субпродукта
                                p_mac_id        wcs_subproduct_macs.mac_id%type, -- Идентификатор МАКа
                                p_val           wcs_subproduct_macs.val_bool%type, -- Значение
                                p_branch        wcs_subproduct_macs.branch%type default '/', -- Отделение
                                p_apply_date    wcs_subproduct_macs.apply_date%type default trunc(sysdate) + 1, -- Дата применения
                                p_comment       varchar2 default null -- Комментарий
                                ) is
    l_proc_name varchar2(100) := 'sbprod_mac_bool_set. ';

    l_old_value varchar2(4000);
    l_new_value varchar2(4000);

    l_chng_comment varchar2(4000);

    l_m_row wcs_macs%rowtype;
  begin
    -- проверяем тип МАКа
    begin
      select *
        into l_m_row
        from wcs_macs m
       where m.id = p_mac_id
         and m.type_id = 'BOOL';
    exception
      when no_data_found then
        return;
    end;

    -- новое и старое значения
    l_new_value := wcs_utl.get_val_formated(p_val,
                                            'BOOL',
                                            null,
                                            null,
                                            null,
                                            null,
                                            p_mac_id);
    select wcs_utl.get_val_formated(min(sm.val_bool),
                                    'BOOL',
                                    null,
                                    null,
                                    null,
                                    null,
                                    p_mac_id)
      into l_old_value
      from wcs_subproduct_macs sm
     where sm.subproduct_id = p_subproduct_id
       and sm.mac_id = p_mac_id
       and sm.branch = p_branch
       and sm.apply_date = p_apply_date;

    if (l_old_value is not null) then
      -- обновляем
      update wcs_subproduct_macs sm
         set sm.val_bool = p_val
       where sm.subproduct_id = p_subproduct_id
         and sm.mac_id = p_mac_id
         and sm.branch = p_branch
         and sm.apply_date = p_apply_date;

      l_chng_comment := 'Зміна значення МАКу ' || p_mac_id ||
                        ' субпродукту ' || p_subproduct_id ||
                        ' для бранчу ' || p_branch || ' за дату ' ||
                        to_char(p_apply_date, 'dd.mm.yyyy') || ' (з ' ||
                        l_old_value || ' на ' || l_new_value || ')';
    else
      -- удаляем пустое значение (если есть)
      delete from wcs_subproduct_macs sm
       where sm.subproduct_id = p_subproduct_id
         and sm.mac_id = p_mac_id
         and sm.branch = p_branch
         and sm.apply_date = p_apply_date;

      -- вставляем
      insert into wcs_subproduct_macs
        (subproduct_id, mac_id, branch, apply_date, val_bool)
      values
        (p_subproduct_id, p_mac_id, p_branch, p_apply_date, p_val);

      l_chng_comment := 'Додано значення МАКу ' || p_mac_id ||
                        ' субпродукту ' || p_subproduct_id ||
                        ' для бранчу ' || p_branch || ' за дату ' ||
                        to_char(p_apply_date, 'dd.mm.yyyy') || ' (' ||
                        l_new_value || ')';
    end if;

    -- добавляем запись в таблицу синхронизации
    l_chng_comment := l_chng_comment || '. ' || p_comment;

    -- запись в протокол
    bars_audit.info(g_pack_name || l_proc_name || l_chng_comment);
  end sbprod_mac_bool_set;

  -- Удаляет МАК субпродукта
  procedure sbprod_mac_del(p_subproduct_id wcs_subproduct_macs.subproduct_id%type, -- Идентификатор субпродукта
                           p_mac_id        wcs_subproduct_macs.mac_id%type, -- Идентификатор МАКа
                           p_branch        wcs_subproduct_macs.branch%type default null, -- Отделение
                           p_apply_date    wcs_subproduct_macs.apply_date%type default null, -- Дата применения
                           p_comment       varchar2 default null -- Комментарий
                           ) is
    l_proc_name varchar2(100) := 'sbprod_mac_del. ';

    l_chng_comment varchar2(4000);
  begin
    -- удаляем
    delete from wcs_subproduct_macs sm
     where sm.subproduct_id = p_subproduct_id
       and sm.mac_id = p_mac_id
       and sm.branch = nvl(p_branch, sm.branch)
       and sm.apply_date = nvl(p_apply_date, sm.apply_date);

    -- если удалили то пишем протокол
    if (sql%rowcount > 0) then
      l_chng_comment := 'Видалення значення МАКу ' || p_mac_id ||
                        ' субпродукту ' || p_subproduct_id;
      if (p_branch is not null) then
        l_chng_comment := l_chng_comment || ' для бранчу ' || p_branch;
      end if;
      if (p_apply_date is not null) then
        l_chng_comment := l_chng_comment || ' за дату ' ||
                          to_char(p_apply_date, 'dd.mm.yyyy');
      end if;

      -- добавляем записб в таблицу синхронизации
      l_chng_comment := l_chng_comment || '. ' || p_comment;

      -- запись в протокол
      bars_audit.info(g_pack_name || l_proc_name || l_chng_comment);
    end if;
  end sbprod_mac_del;

  -- Клонирует МАКи субпродукта
  procedure sbprod_macs_clone(p_subproduct_id     wcs_subproduct_macs.subproduct_id%type, -- Идентификатор субпродукта
                              p_src_subproduct_id wcs_subproduct_macs.subproduct_id%type -- Идентификатор субпродукта-источника для клонирования
                              ) is
  begin
    for cur in (select sm.*, m.type_id
                  from wcs_subproduct_macs sm, wcs_macs m
                 where sm.subproduct_id = p_src_subproduct_id
                   and sm.mac_id = m.id) loop
      case
        when cur.type_id = 'TEXT' then
          sbprod_mac_text_set(p_subproduct_id,
                              cur.mac_id,
                              cur.val_text,
                              cur.branch,
                              cur.apply_date);
        when cur.type_id = 'NUMB' then
          sbprod_mac_numb_set(p_subproduct_id,
                              cur.mac_id,
                              cur.val_numb,
                              cur.branch,
                              cur.apply_date);
        when cur.type_id = 'DECIMAL' then
          sbprod_mac_dec_set(p_subproduct_id,
                             cur.mac_id,
                             cur.val_decimal,
                             cur.branch,
                             cur.apply_date);
        when cur.type_id = 'DATE' then
          sbprod_mac_dat_set(p_subproduct_id,
                             cur.mac_id,
                             cur.val_date,
                             cur.branch,
                             cur.apply_date);
        when cur.type_id = 'LIST' then
          sbprod_mac_list_set(p_subproduct_id,
                              cur.mac_id,
                              cur.val_list,
                              cur.branch,
                              cur.apply_date);
        when cur.type_id = 'REFER' then
          sbprod_mac_ref_set(p_subproduct_id,
                             cur.mac_id,
                             cur.val_refer,
                             cur.branch,
                             cur.apply_date);
        when cur.type_id = 'FILE' then
          sbprod_mac_file_set(p_subproduct_id,
                              cur.mac_id,
                              cur.val_file,
                              cur.branch,
                              cur.apply_date);
        when cur.type_id = 'BOOL' then
          sbprod_mac_bool_set(p_subproduct_id,
                              cur.mac_id,
                              cur.val_bool,
                              cur.branch,
                              cur.apply_date);
      end case;
    end loop;
  end sbprod_macs_clone;
  -- ------------------------------- Продукты --------------------------------------

  -- -------------------------- Заявки -------------------------------------
  -- Предзаполнение заявки по данным из БД БАРС
  -- возвращает:
  -- null - не найден
  -- B - найдена заявка
  -- С - найден контрагент
  -- BC - найдена заявка и контрагент
  function bid_prefill_from_db(p_bid_id wcs_bids.id%type -- Идентификатор заявки
                               ) return varchar2 is
    l_res varchar2(2) := null;

    l_cur_b_row wcs_bids%rowtype;

    l_b_row wcs_bids%rowtype;

    l_c_row customer%rowtype;
    l_p_row person%rowtype;
  begin
    -- ИНН заявки
    select * into l_cur_b_row from wcs_bids b where b.id = p_bid_id;

    -- не обрабатываем ИНН = 0000000000
    if (l_cur_b_row.inn = '0000000000') then
      return l_res;
    end if;

    begin
      -- ищем заявку по РНК
      select *
        into l_b_row
        from (select *
                from wcs_bids b
               where b.rnk = l_cur_b_row.rnk
                 and b.id < p_bid_id
               order by b.crt_date desc)
       where rownum = 1;

      l_res := l_res || 'B';
    exception
      when no_data_found then
        begin
          -- если не нашли по РНК, то ищем заявку по ИНН
          select *
            into l_b_row
            from (select *
                    from wcs_bids b
                   where b.inn = l_cur_b_row.inn
                     and b.id < p_bid_id
                   order by b.crt_date desc)
           where rownum = 1;
          l_res := l_res || 'B';
        exception
          when no_data_found then
            l_b_row := null;
        end;
    end;

    begin
      -- ищем клиента по РНК
      select * into l_c_row from customer c where c.rnk = l_cur_b_row.rnk;
      l_res := l_res || 'C';
    exception
      when no_data_found then
        begin
          -- если не нашли по РНК, то ищем клиента по ИНН
          select *
            into l_c_row
            from (select *
                    from customer c
                   where c.okpo = l_cur_b_row.inn
                   order by c.date_on desc)
           where rownum = 1;
          l_res := l_res || 'C';
        exception
          when no_data_found then
            l_c_row := null;
        end;
    end;

    -- заполняем ответами из карточки контрагента
    if (l_c_row.rnk is not null) then
      wcs_utl.prefill_from_customers(p_bid_id, 'MAIN', 0, l_c_row.rnk);
    end if;

    -- заполняем ответами из заявки
    if (l_b_row.id is not null) then
      -- Авторизация
      declare
        l_auth_id wcs_authorizations.id%type;
      begin
        select sa.auth_id
          into l_auth_id
          from wcs_subproduct_authorizations sa
         where sa.subproduct_id = l_cur_b_row.subproduct_id;
        wcs_utl.prefill_auth_from_bids(p_bid_id,
                                       'MAIN',
                                       0,
                                       l_auth_id,
                                       l_b_row.id,
                                       'MAIN',
                                       0);
      end;

      -- Анкета
      declare
        l_survey_id wcs_surveys.id%type;
      begin
        select ss.survey_id
          into l_survey_id
          from wcs_subproduct_survey ss
         where ss.subproduct_id = l_cur_b_row.subproduct_id;
        wcs_utl.prefill_survey_from_bids(p_bid_id,
                                         'MAIN',
                                         0,
                                         l_survey_id,
                                         l_b_row.id,
                                         'MAIN',
                                         0);
      end;
    end if;

    return l_res;
  end bid_prefill_from_db;

  -- Прописывает ИНН заявки и выполняет предзаполнение
  procedure bid_set_inn(p_bid_id wcs_bids.id%type, -- Идентификатор заявки
                        p_inn    wcs_bids.inn%type -- ИНН клиента
                        ) is
    l_fill_res varchar2(2);
  begin
    update wcs_bids b set b.inn = p_inn where b.id = p_bid_id;

    -- Запоминаем ИНН
    wcs_pack.answ_text_set(p_bid_id, 'CODE_002', p_inn);

    -- Ищем заявки и/или контрагента по ИНН
    if (p_inn != '0000000000') then
      l_fill_res := bid_prefill_from_db(p_bid_id);
    end if;
  end bid_set_inn;

  -- Прописывает РНК заявки и выполняет предзаполнение
  procedure bid_set_rnk(p_bid_id wcs_bids.id%type, -- Идентификатор заявки
                        p_rnk    wcs_bids.rnk%type -- ИНН клиента
                        ) is
    l_inn wcs_bids.inn%type;
  begin
    update wcs_bids b set b.rnk = p_rnk where b.id = p_bid_id;
    select min(c.okpo) into l_inn from customer c where c.rnk = p_rnk;

    -- Запоминаем ИНН
    if (l_inn is not null) then
      bid_set_inn(p_bid_id, l_inn);
    end if;
  end bid_set_rnk;

  -- Создает заявку
  function bid_create(p_subproduct_id wcs_bids.subproduct_id%type, -- Идентификатор состояния
                      p_inn           wcs_bids.inn%type default null, -- ИНН клиента
                      p_rnk           wcs_bids.rnk%type default null -- РНК клиента
                      ) return number -- Идентификатор заявки
   is
    l_bid_id number;
  begin
    -- создаем заявку (идентификатор заявки совпадает с иденификатором кредита)
    select bars_sqnc.get_nextval('S_CC_DEAL') into l_bid_id from dual;

    insert into wcs_bids
      (id, subproduct_id, crt_date, inn, mgr_id, branch)
    values
      (l_bid_id,
       p_subproduct_id,
       sysdate,
       p_inn,
       user_id,
       sys_context('bars_context', 'user_branch'));

    -- устанавливаем стартовое состояние
    wcs_pack.bid_state_set_immediate(l_bid_id,
                                     'NEW_START',
                                     'Заявка создана');

    -- создаем обязательное обеспечение
    for cur in (select *
                  from wcs_subproduct_garantees sg
                 where sg.subproduct_id = p_subproduct_id
                   and sg.is_required = 1) loop
      wcs_pack.bid_garantee_set(l_bid_id, cur.garantee_id);
    end loop;

    -- создаем обязательные страховки
    for cur in (select *
                  from wcs_subproduct_insurances si
                 where si.subproduct_id = p_subproduct_id
                   and si.is_required = 1) loop
      wcs_pack.bid_insurance_set(l_bid_id, cur.insurance_id);
    end loop;

    -- Обрабатываем РНК и ИНН
    if (p_rnk is not null) then
      bid_set_rnk(l_bid_id, p_rnk);
    elsif (p_inn is not null) then
      bid_set_inn(l_bid_id, p_inn);
    end if;

    return l_bid_id;
  end bid_create;

  /*
    -- Проставляет дату подписания клиентом документов
    procedure bid_signdate_set(p_bid_id    varchar2, -- Идентификатор заявки
                               p_sign_date date -- Дата подписания клиентом документов
                               ) is
    begin
      update wcs_bids b set b.sign_date = p_sign_date where b.id = p_bid_id;
    end bid_signdate_set;
  */
  -- Удаляет заявку
  procedure bid_del(p_bid_id wcs_bids.id%type -- Идентификатор заявки
                    ) is
  begin
    -- точка сохранения
    savepoint before_delete;

    begin
      -- удаляем ответы
      for c in (select * from wcs_answers a where a.bid_id = p_bid_id) loop
        wcs_pack.answ_del(c.bid_id, c.question_id, c.ws_id, c.ws_number);
      end loop;

      -- удаляем историю состояний
      delete from wcs_bid_states_history bsh where bsh.bid_id = p_bid_id;

      -- удаляем состояния заявки
      delete from wcs_bid_states bs where bs.bid_id = p_bid_id;

      -- удаляем протокол
      delete from wcs_logs l where l.bid_id = p_bid_id;

      /*
        -- удаляем из предваритеьных решений
        delete from wcs_preliminary_decisions pd where pd.bid_id = bid_id_;
        bars_audit.trace(g_pack_name || l_proc_name ||
                         'Process. wcs_preliminary_decisions deleted');
      */

      -- удаляем заявку
      delete from wcs_bids t where t.id = p_bid_id;
    exception
      when others then
        rollback to savepoint before_delete;
        raise;
    end;

  end bid_del;

  -- Устанавливает состояние удаляя текущии не выполняя процедур действий
  procedure bid_state_set_immediate(bid_id_       number, -- Идентификатор заявки
                                    state_id_     varchar2, -- Идентификатор состояния
                                    user_comment_ varchar2 --Комментарий пользователя
                                    ) is
    l_proc_name varchar2(100) := 'bid_state_set_immediate. ';
  begin
    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Start. Params: bid_id_=%s, state_id_=%s, user_comment_=%s',
                     to_char(bid_id_),
                     state_id_,
                     user_comment_);

    -- история
    wcs_pack.bid_state_history_set(bid_id_,
                                   state_id_,
                                   null,
                                   null,
                                   null,
                                   user_comment_,
                                   'SET_IMMEDIATE');

    -- история
    /*
    !!! удаленные состояния по SET_IMMEDIATE без истории
    !!! может вызвать проблеммы
    for c in (select *
                from wcs_bid_states
               where bid_id = bid_id_
                 and state_id not in ('MGR_BELONG', 'PRELIM_DEC')) loop
      wcs_pack.bid_state_history_set(bid_id_,
                                     c.state_id,
                                     null,
                                     null,
                                     null,
                                     null,
                                     'DELETE');
    end loop;*/

    -- удаляем все состояния кроме принадлежности к менеджеру
    delete from wcs_bid_states
     where bid_id = bid_id_
       and state_id not in ('MGR_BELONG', 'PRELIM_DEC');

    wcs_pack.bid_state_set(bid_id_, state_id_, user_comment_);

    bars_audit.trace(g_pack_name || l_proc_name || 'Finish');
  end bid_state_set_immediate;

  -- Устанавливает состояние (добавляет к текущим)
  procedure bid_state_set(bid_id_       number, -- Идентификатор заявки
                          state_id_     varchar2, -- Идентификатор состояния
                          user_comment_ varchar2 --Комментарий пользователя
                          ) is
    l_wcs_states_ wcs_states%rowtype;
    l_res         varchar2(4000);
    l_cnt         number;

    l_proc_name varchar2(100) := 'bid_state_set. ';
  begin
    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Start. Params: bid_id_=%s, state_id_=%s, user_comment_=%s',
                     to_char(bid_id_),
                     state_id_,
                     user_comment_);

    -- на отказаные заявки состояния ставить нельзя
    select count(*)
      into l_cnt
      from wcs_bid_states bs
     where bs.bid_id = bid_id_
       and bs.state_id = 'NEW_DENY';

    -- исключаем дубль
    update wcs_bid_states t
       set t.bid_id = bid_id_
     where bid_id = bid_id_
       and state_id = state_id_;

    if (sql%rowcount = 0 and l_cnt = 0) then
      bars_audit.trace(g_pack_name || l_proc_name ||
                       'Process. State is seted');

      -- добавляем состояние
      insert into wcs_bid_states
        (bid_id,
         state_id,
         checkouted,
         checkout_dat,
         checkout_user_id,
         user_comment)
      values
        (bid_id_, state_id_, 0, sysdate, user_id, user_comment_);

      -- история
      wcs_pack.bid_state_history_set(bid_id_,
                                     state_id_,
                                     0,
                                     sysdate,
                                     user_id,
                                     user_comment_,
                                     'SET');

      -- параметры состояния
      select * into l_wcs_states_ from wcs_states where id = state_id_;

      -- выполняем процедуру действия (если она есть)
      if (l_wcs_states_.before_proc is not null) then

        bars_audit.trace(g_pack_name || l_proc_name ||
                         'Process. l_wcs_states_.before_proc =%s',
                         l_wcs_states_.before_proc);

        l_res := wcs_utl.exec_sql(bid_id_, null, l_wcs_states_.before_proc);

        if (l_res is not null) then
          bars_audit.trace(g_pack_name || l_proc_name ||
                           'Process. l_res is not null. l_res =%s',
                           l_res);

          wcs_pack.log_set(bid_id_,
                           state_id_,
                           'Ошибка выполнения блока before_proc. Текст ошибки: ' ||
                           l_res);

          -- создаем резервную копию состояний
          bid_states_backup(bid_id_);

          -- устанавливаем состояние ошибки
          wcs_pack.bid_state_set_immediate(bid_id_,
                                           'SYS_ERR',
                                           'Ошибка выполнения блока before_proc. Текст ошибки: ' ||
                                           l_res);
        end if;
      end if;
    end if;

    bars_audit.trace(g_pack_name || l_proc_name || 'Finish');
  end bid_state_set;

  -- Удаляет состояние (удаляет из текущих)
  procedure bid_state_del(bid_id_   number, -- Идентификатор заявки
                          state_id_ varchar2 -- Идентификатор состояния
                          ) is
    l_wcs_states_ wcs_states%rowtype;
    l_res         varchar2(4000);
  begin
    -- проверяем что состояние установлено
    update wcs_bid_states
       set bid_id = bid_id_
     where bid_id = bid_id_
       and state_id = state_id_;

    if (sql%rowcount > 0) then
      -- удаляем состояние
      delete from wcs_bid_states
       where bid_id = bid_id_
         and state_id = state_id_;

      -- история
      wcs_pack.bid_state_history_set(bid_id_,
                                     state_id_,
                                     null,
                                     null,
                                     null,
                                     null,
                                     'DELETE');

      -- параметры состояния
      select * into l_wcs_states_ from wcs_states where id = state_id_;

      -- выполняем процедуру действия (если она есть)
      if (l_wcs_states_.after_proc is not null) then
        l_res := wcs_utl.exec_sql(bid_id_, null, l_wcs_states_.after_proc);

        if (l_res is not null) then
          -- создаем резервную копию состояний
          bid_states_backup(bid_id_);

          -- устанавливаем состояние ошибки
          wcs_pack.bid_state_set_immediate(bid_id_,
                                           'SYS_ERR',
                                           'Ошибка выполнения блока after_proc. Текст ошибки: ' ||
                                           l_res);
        end if;
      end if;

      -- устанавливаем дочерние состояния
      for c in (select child_id from v_wcs_route where parent_id = state_id_) loop
        wcs_pack.bid_state_set(bid_id_, c.child_id, null);
      end loop;

    end if;
  end bid_state_del;

  -- Лочит состояние на указаного пользователя
  procedure bid_state_reappoint(bid_id_            number, -- Идентификатор заявки
                                state_id_          varchar2, -- Идентификатор состояния
                                reappoint_user_id_ number, -- Пользователь для переназначения
                                user_comment_      varchar2 -- Комментарий пользователя
                                ) is
  begin
    -- лочим
    update wcs_bid_states t
       set t.checkouted       = 1,
           t.checkout_dat     = sysdate,
           t.checkout_user_id = reappoint_user_id_
     where t.bid_id = bid_id_
       and t.state_id = state_id_
       and t.checkouted = 0;

    if (sql%rowcount > 0) then
      -- история
      wcs_pack.bid_state_history_set(bid_id_,
                                     state_id_,
                                     1,
                                     sysdate,
                                     reappoint_user_id_,
                                     user_comment_,
                                     'CHECK_OUT');
    end if;
  end bid_state_reappoint;

  -- Выполняет резервную копию состояний заявки
  procedure bid_states_backup(p_bid_id wcs_bid_states_backup.bid_id%type -- Идентификатор заявки
                              ) is
    l_backup_date wcs_bid_states_backup.backup_date%type := sysdate;
  begin
    -- удаляем текущие резервые копии
    delete from wcs_bid_states_backup bsbu where bsbu.bid_id = p_bid_id;

    -- копируем текущие состояния заявки
    insert into wcs_bid_states_backup
      (bid_id,
       state_id,
       checkouted,
       checkout_dat,
       checkout_user_id,
       user_comment,
       backup_date)
      select bs.bid_id,
             bs.state_id,
             bs.checkouted,
             bs.checkout_dat,
             bs.checkout_user_id,
             bs.user_comment,
             l_backup_date
        from wcs_bid_states bs
       where bs.bid_id = p_bid_id;
  end bid_states_backup;

  -- Востанавливает состояния заявки из резервной копии
  procedure bid_states_restore(p_bid_id wcs_bid_states_backup.bid_id%type -- Идентификатор заявки
                               ) is
  begin
    -- удаляем текущие состояния
    delete from wcs_bid_states bs where bs.bid_id = p_bid_id;

    -- копируем текущие состояния заявки из резервной копии
    insert into wcs_bid_states
      (bid_id,
       state_id,
       checkouted,
       checkout_dat,
       checkout_user_id,
       user_comment)
      select bsbu.bid_id,
             bsbu.state_id,
             bsbu.checkouted,
             bsbu.checkout_dat,
             bsbu.checkout_user_id,
             bsbu.user_comment ||
             '(відновлено після системної помилки користувачем №' ||
             user_id || ' станом на ' ||
             to_char(bsbu.backup_date, 'dd.mm.yyyy hh24:mi') || ')'
        from wcs_bid_states_backup bsbu
       where bsbu.bid_id = p_bid_id;

    -- удаляем резервые копии
    delete from wcs_bid_states_backup bsbu where bsbu.bid_id = p_bid_id;
  end bid_states_restore;

  -- Замена менеджера по заявке
  procedure bid_mgr_change(p_bid_id     wcs_bids.id%type, -- Идентификатор заявки
                           p_new_mgr_id wcs_bids.mgr_id%type -- Идентификатор нового менеджера
                           ) is
    l_b_row wcs_bids%rowtype;
  begin
    -- проставляем ид. нового менеджера
    select * into l_b_row from wcs_bids b where b.id = p_bid_id;
    update wcs_bids b set b.mgr_id = p_new_mgr_id where b.id = p_bid_id;

    -- регистрируем состояния за новым менеджером
    for cur in (select *
                  from wcs_bid_states bs
                 where bs.bid_id = p_bid_id
                   and bs.checkouted = 1
                   and bs.checkout_user_id = l_b_row.mgr_id) loop
      wcs_pack.bid_state_check_in(p_bid_id,
                                  cur.state_id,
                                  'Перепризначення заявки з менеджера №' ||
                                  l_b_row.mgr_id || ' на №' || p_new_mgr_id);
      wcs_pack.bid_state_reappoint(p_bid_id,
                                   cur.state_id,
                                   p_new_mgr_id,
                                   'Перепризначення заявки з менеджера №' ||
                                   l_b_row.mgr_id || ' на №' ||
                                   p_new_mgr_id);
    end loop;
  end bid_mgr_change;

  -- Замена исполнителя-сотрудника службы по заявке
  procedure bid_srv_user_change(p_bid_id        wcs_bids.id%type, -- Идентификатор заявки
                                p_srv_id        wcs_services.id%type, -- Идентификатор службы
                                p_srv_hierarchy wcs_srv_hierarchy.id%type, -- Идентификатор уровня иерархии службы
                                p_new_mgr_id    wcs_bids.mgr_id%type -- Идентификатор нового исполнителя
                                ) is
    l_srv_hierarchy wcs_srv_hierarchy.id%type := upper(p_srv_hierarchy);
    l_state_id      wcs_states.id%type;
    l_b_row         wcs_bids%rowtype;
  begin
    -- определяем соответствующее состояние
    case
      when p_srv_id = 'CREDIT_SERVICE' then
        case
          when l_srv_hierarchy = 'TOBO' then
            l_state_id := 'NEW_CREDIT_S|NEW_CREDIT_S_PRC|NEW_CREDIT_S_SRVANALYSE|NEW_CREDIT_S_CCANALYSE';
          when l_srv_hierarchy = 'RU' then
            l_state_id := 'NEW_RU_CREDIT_S|NEW_RU_CREDIT_S_PRC|NEW_RU_CREDIT_S_SRVANALYSE|NEW_RU_CREDIT_S_CCANALYSE';
          when l_srv_hierarchy = 'CA' then
            l_state_id := 'NEW_CA_CREDIT_S|NEW_CA_CREDIT_S_PRC|NEW_CA_CREDIT_S_SRVANALYSE|NEW_CA_CREDIT_S_CCANALYSE';
          else
            l_state_id := null;
        end case;
      when p_srv_id = 'SECURITY_SERVICE' then
        case
          when l_srv_hierarchy = 'TOBO' then
            l_state_id := 'NEW_SECURITY_S_PRC';
          when l_srv_hierarchy = 'RU' then
            l_state_id := 'NEW_RU_SECURITY_S_PRC';
          when l_srv_hierarchy = 'CA' then
            l_state_id := 'NEW_CA_SECURITY_S_PRC';
          else
            l_state_id := null;
        end case;
      when p_srv_id = 'LAW_SERVICE' then
        case
          when l_srv_hierarchy = 'TOBO' then
            l_state_id := 'NEW_LAW_S_PRC';
          when l_srv_hierarchy = 'RU' then
            l_state_id := 'NEW_RU_LAW_S_PRC';
          when l_srv_hierarchy = 'CA' then
            l_state_id := 'NEW_CA_LAW_S_PRC';
          else
            l_state_id := null;
        end case;
      when p_srv_id = 'ASSETS_SERVICE' then
        case
          when l_srv_hierarchy = 'TOBO' then
            l_state_id := 'NEW_PROBLEMACTIVE_S_PRC';
          when l_srv_hierarchy = 'RU' then
            l_state_id := 'NEW_RU_PROBLEMACTIVE_S_PRC';
          when l_srv_hierarchy = 'CA' then
            l_state_id := 'NEW_CA_PROBLEMACTIVE_S_PRC';
          else
            l_state_id := null;
        end case;
      when p_srv_id = 'RISK_DEPARTMENT' then
        case
          when l_srv_hierarchy = 'CA' then
            l_state_id := 'NEW_CA_RISK_S_PRC';
          else
            l_state_id := null;
        end case;
      when p_srv_id = 'FINANCE_DEPARTMENT' then
        case
          when l_srv_hierarchy = 'CA' then
            l_state_id := 'NEW_CA_FINANCE_S_PRC';
          else
            l_state_id := null;
        end case;
      when p_srv_id = 'SECRETARY_CC' then
        case
          when l_srv_hierarchy = 'TOBO' then
            l_state_id := 'NEW_SECRETARYCC';
          when l_srv_hierarchy = 'RU' then
            l_state_id := 'NEW_RU_SECRETARYCC';
          when l_srv_hierarchy = 'CA' then
            l_state_id := 'NEW_CA_SECRETARYCC';
          else
            l_state_id := null;
        end case;
      when p_srv_id = 'VISA' then
        l_state_id := 'NEW_VISA';
      else
        l_state_id := null;
    end case;

    -- регистрируем состояния за новым исполнителем
    for cur in (select *
                  from wcs_bid_states bs
                 where bs.bid_id = p_bid_id
                   and bs.checkouted = 1
                   and regexp_like(bs.state_id, l_state_id)) loop
      wcs_pack.bid_state_check_in(p_bid_id,
                                  cur.state_id,
                                  'Перепризначення виконавця по заявці з №' ||
                                  cur.checkout_user_id || ' на №' ||
                                  p_new_mgr_id);
      wcs_pack.bid_state_reappoint(p_bid_id,
                                   cur.state_id,
                                   p_new_mgr_id,
                                   'Перепризначення виконавця по заявці з №' ||
                                   cur.checkout_user_id || ' на №' ||
                                   p_new_mgr_id);
    end loop;
  end bid_srv_user_change;

  -- Лочит состояние
  procedure bid_state_check_out(bid_id_       number, -- Идентификатор заявки
                                state_id_     varchar2, -- Идентификатор состояния
                                user_comment_ varchar2 -- Комментарий пользователя
                                ) is
  begin
    wcs_pack.bid_state_reappoint(bid_id_,
                                 state_id_,
                                 user_id,
                                 user_comment_);
  end bid_state_check_out;

  -- Разблокирует состояние
  procedure bid_state_check_in(bid_id_       number, -- Идентификатор заявки
                               state_id_     varchar2, -- Идентификатор состояния
                               user_comment_ varchar2 --Комментарий пользователя
                               ) is
  begin
    -- разблокируем, если заявка залочена нами
    update wcs_bid_states t
       set t.checkouted       = 0,
           t.checkout_dat     = null,
           t.checkout_user_id = null
     where t.bid_id = bid_id_
       and t.state_id = state_id_
       and checkouted = 1;

    if (sql%rowcount > 0) then
      -- история
      wcs_pack.bid_state_history_set(bid_id_,
                                     state_id_,
                                     0,
                                     null,
                                     null,
                                     user_comment_,
                                     'CHECK_IN');
    end if;
  end bid_state_check_in;

  -- История изменений состояния заявки
  procedure bid_state_history_set(p_bid_id           in number, -- Идентификатор заявки
                                  p_state_id         in varchar2, -- Идентификатор состояния
                                  p_checkouted       in number, -- Блокирована ли заявка (0/1)
                                  p_checkout_dat     in date, -- Дата блокировки заявки
                                  p_checkout_user_id in number, -- Пользователь заблокировавший заявку
                                  p_user_comment     in varchar2, -- Комментарий пользователя
                                  p_change_action    in varchar2 -- Действие
                                  ) is
    l_id_nextval wcs_bid_states_history.id%type := -1;
    l_id_maxval  wcs_bid_states_history.id%type;
    l_sysdate    date := sysdate;
    l_proc_name  varchar2(100) := 'bid_state_history_set. ';
  begin
    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Start. Params: p_bid_id=%s',
                     to_char(p_bid_id));

    -- сохраняем историю
    update wcs_bid_states_history bsh
       set bsh.checkouted       = p_checkouted,
           bsh.checkout_dat     = p_checkout_dat,
           bsh.checkout_user_id = p_checkout_user_id,
           bsh.user_comment     = p_user_comment
     where bsh.bid_id = p_bid_id
       and bsh.state_id = p_state_id
       and bsh.change_action = p_change_action
       and bsh.change_dat = l_sysdate;

    if (sql%rowcount = 0) then
      select nvl(max(bsh.id), -1)
        into l_id_maxval
        from wcs_bid_states_history bsh;

      while (l_id_nextval <= l_id_maxval) loop
        select s_wcs_bid_states_history.nextval
          into l_id_nextval
          from dual;
      end loop;

      insert into wcs_bid_states_history
        (id,
         bid_id,
         state_id,
         checkouted,
         checkout_dat,
         checkout_user_id,
         user_comment,
         change_action,
         change_dat)
      values
        (l_id_nextval,
         p_bid_id,
         p_state_id,
         p_checkouted,
         p_checkout_dat,
         p_checkout_user_id,
         p_user_comment,
         p_change_action,
         l_sysdate);
    end if;

    bars_audit.trace(g_pack_name || l_proc_name || 'Finish.');
  end bid_state_history_set;

  -- Удаление истории изменений состояния заявки
  procedure bid_history_restore(p_bid_id           in number, -- Идентификатор заявки
                                p_state_status         in varchar2 -- Идентификатор состояния
			       ) is
/*Идентификатор состояния имеет 8 значений для возврата на нужный статус:
1. Ввод данных (NEW_CREDITDATA_DI, NEW_DATAINPUT);--INPDATA
2. Завершение ввода данных (NEW_DATAINPUT, NEW_DATAINPUT_FINISHED);--INPDATA_FIN
3. Кредитная служба РУ (NEW_RU_CREDIT_S, NEW_RU_CREDIT_S_PRC);--CREDSERV_RU
3а.Кредитная служба ТВБВ (NEW_CREDIT_S, NEW_CREDIT_S_PRC);--CREDSERV_TVBV
4. Анализ рассмотрения служб РУ (NEW_RU_CREDIT_S, NEW_RU_CREDIT_S_SRVANALYSE);--SRVANALYSE_RU
4a.Анализ рассмотрения служб ТВБВ (NEW_CREDIT_S, NEW_CREDIT_S_SRVANALYSE);--SRVANALYSE_TVBV
5. Анализ решения кредитного комитета РУ (NEW_RU_CREDIT_S, NEW_RU_CREDIT_S_CCANALYSE);--CCANALYSE_RU
5a.Анализ решения кредитного комитета ТВБВ (NEW_CREDIT_S, NEW_CREDIT_S_CCANALYSE);--CCANALYSE_TVBV
6. Выдача Данные кредита (NEW_SIGNDOCS, NEW_CREDITDATA_SD);--CREDITDATA
7. Завершение Подписание договоров (NEW_SIGNDOCS, NEW_SIGNDOCS_FINISHED);--SIGNFIN
8. Виза (NEW_VISA).--VISA
*/
  id_set number;
  id_checkout number;
  checkout_on number;
  checkouted number;
  user_id wcs_bid_states_history.checkout_user_id%type;
  state_first wcs_states.id%type;
  state_second wcs_states.id%type;
  begin
    --выбираем значение для возврата
    case p_state_status
    when 'INPDATA' then
      state_first:='NEW_CREDITDATA_DI';
      state_second:='NEW_DATAINPUT';
    when 'INPDATA_FIN' then
      state_first:='NEW_DATAINPUT';
      state_second:='NEW_DATAINPUT_FINISHED';
    when 'CREDSERV_RU' then
      state_first:='NEW_RU_CREDIT_S';
      state_second:='NEW_RU_CREDIT_S_PRC';
    when 'CREDSERV_TOBO' then
      state_first:='NEW_CREDIT_S';
      state_second:='NEW_CREDIT_S_PRC';
    when 'SRVANALYSE_RU' then
      state_first:='NEW_RU_CREDIT_S';
      state_second:='NEW_RU_CREDIT_S_SRVANALYSE';
    when 'SRVANALYSE_TOBO' then
      state_first:='NEW_CREDIT_S';
      state_second:='NEW_CREDIT_S_SRVANALYSE';
    when 'CCANALYSE_RU' then
      state_first:='NEW_RU_CREDIT_S';
      state_second:='NEW_RU_CREDIT_S_CCANALYSE';
    when 'CCANALYSE_TOBO' then
      state_first:='NEW_CREDIT_S';
      state_second:='NEW_CREDIT_S_CCANALYSE';
    when 'CREDITDATA' then
      state_first:='NEW_SIGNDOCS';
      state_second:='NEW_CREDITDATA_SD';
    when 'SIGNFIN' then
      state_first:='NEW_SIGNDOCS';
      state_second:='NEW_SIGNDOCS_FINISHED';
    when 'VISA' then
      state_first:='NEW_VISA';
      state_second:='';
    end case;

    if (p_state_status = 'CREDITDATA') then
      --удаляем запись в cc_deal
      begin
         cck.cc_delete(p_bid_id);
      exception
          when no_data_found then
            checkouted:=0;
      end;
      --находим первый статус со значением change_action=SET
      select min(id) into id_set from wcs_bid_states_history bs where bs.bid_id=p_bid_id and bs.state_id in (state_first, state_second) and bs.change_action='SET';
      --находим первый статус со значением change_action=CHECK_OUT
      select min(id) into id_checkout from wcs_bid_states_history bs where bs.bid_id=p_bid_id and bs.state_id in (state_first, state_second) and bs.change_action='CHECK_OUT';
    else
      --находим последний статус со значением change_action=SET
      select max(id) into id_set from wcs_bid_states_history bs where bs.bid_id=p_bid_id and bs.state_id in (state_first, state_second) and bs.change_action='SET';
      --находим последний статус со значением change_action=CHECK_OUT
      select max(id) into id_checkout from wcs_bid_states_history bs where bs.bid_id=p_bid_id and bs.state_id in (state_first, state_second) and bs.change_action='CHECK_OUT';
    end if;

    --проверка был CHECK_OUT или нет
    if (id_checkout = null or id_checkout < id_set) then
       checkout_on := id_set;
       checkouted := 0;
    else
       checkout_on := id_checkout;
       checkouted := 1;
    end if;

    --действия
    select checkout_user_id into user_id from wcs_bid_states_history where id = checkout_on;
    delete from wcs_bid_states_history where id > checkout_on and bid_id = p_bid_id;
    delete from wcs_bid_states where bid_id = p_bid_id;
    if (p_state_status = 'VISA') then
      insert into wcs_bid_states
      values(p_bid_id, state_first, checkouted, sysdate, user_id, null, null);
    else
      insert into wcs_bid_states
      values(p_bid_id, state_first, checkouted, sysdate, user_id, null, null);
      insert into wcs_bid_states
      values(p_bid_id, state_second, checkouted, sysdate, user_id, null, null);
    end if;
  end bid_history_restore;

  -- Запись в протокол
  procedure log_set(bid_id_   number, -- Идентификатор заявки
                    state_id_ varchar2, -- Идентификатор состояния
                    text_     varchar2 -- Текст записи протокола
                    ) is
    l_user_id staff$base.id%type := sys_context('bars_context', 'user_id');
  begin
    -- пришем протокол
    insert into wcs_logs
      (bid_id, state_id, dat, user_id, text)
    values
      (bid_id_, state_id_, sysdate, l_user_id, text_);
  end log_set;
  -- -------------------------- Заявки -------------------------------------

  -- ------------------------------- Ответы ----------------------------------------
  -- Записывает историю изменения ответа
  procedure answ_history_set(p_bid_id      wcs_answers_history.bid_id%type, -- Идентификатор заявки
                             p_question_id wcs_answers_history.question_id%type, -- Идентификатор вопроса
                             p_ws_id       wcs_answers_history.ws_id%type, -- Идентификатор рабочего пространства
                             p_ws_number   wcs_answers_history.ws_number%type, -- Номер рабочего пространства
                             p_val_new     wcs_answers_history.val_new%type -- Новое значение (null для удаления)
                             ) is
    l_id             wcs_answers_history.id%type;
    l_val_old        wcs_answers_history.val_old%type;
    l_action_type_id wcs_answers_history.action_type_id%type;
    l_action_date    wcs_answers_history.action_date%type := sysdate;
    l_action_user    wcs_answers_history.action_user%type := user_id;
  begin
    -- Проверяем нужно ли писать историю изменений:
    -- 1. Пишем историю если заявка в состоянии доработки
    if (1 = wcs_utl.has_bid_state(p_bid_id, 'NEW_DATAREINPUT')) then
      l_val_old := wcs_utl.get_answ(p_bid_id,
                                    p_question_id,
                                    p_ws_id,
                                    p_ws_number);

      -- определяем тип действия
      case
        when p_val_new is null then
          l_action_type_id := 'D';
        when p_val_new is not null and l_val_old is null then
          l_action_type_id := 'I';
        when p_val_new is not null and l_val_old is not null then
          l_action_type_id := 'U';
      end case;

      -- пишем историю только если страное и новое значения отличаются
      if ((l_val_old != p_val_new or
         (l_val_old is null and p_val_new is not null) or
         (l_val_old is not null and p_val_new is null))) then
        select s_wcs_answers_history.nextval into l_id from dual;

        insert into wcs_answers_history
          (id,
           bid_id,
           ws_id,
           ws_number,
           question_id,
           val_old,
           val_new,
           action_type_id,
           action_date,
           action_user)
        values
          (l_id,
           p_bid_id,
           p_ws_id,
           p_ws_number,
           p_question_id,
           l_val_old,
           p_val_new,
           l_action_type_id,
           l_action_date,
           l_action_user);
      end if;
    end if;
  end answ_history_set;

  -- Создает/обновляет ответ - Текстовый
  procedure answ_text_set(p_bid_id      wcs_answers.bid_id%type, -- Идентификатор заявки
                          p_question_id wcs_answers.question_id%type, -- Идентификатор вопроса
                          p_val         wcs_answers.val_text%type, -- Ответ
                          p_ws_id       wcs_answers.ws_id%type default 'MAIN', -- Идентификатор рабочего пространства
                          p_ws_number   wcs_answers.ws_number%type default 0 -- Номер рабочего пространства
                          ) is
    l_q_row wcs_questions%rowtype;
  begin
    -- проверяем тип вопроса
    begin
      select q.*
        into l_q_row
        from wcs_questions q
       where q.id = p_question_id
         and q.type_id = 'TEXT';
    exception
      when no_data_found then
        return;
    end;

    -- запись в историю изменений
    answ_history_set(p_bid_id, p_question_id, p_ws_id, p_ws_number, p_val);

    -- если значение пустое то удаляем из таблицы ответов
    if (p_val is null) then
      wcs_pack.answ_del(p_bid_id, p_question_id, p_ws_id, p_ws_number);
    else
      -- обновляем или вставляем
      update wcs_answers a
         set a.val_text = p_val
       where a.bid_id = p_bid_id
         and a.ws_id = p_ws_id
         and a.ws_number = p_ws_number
         and a.question_id = p_question_id;

      if (sql%rowcount = 0) then
        insert into wcs_answers
          (bid_id, ws_id, ws_number, question_id, val_text)
        values
          (p_bid_id, p_ws_id, p_ws_number, p_question_id, p_val);
      end if;
    end if;
  end answ_text_set;

  -- Создает/обновляет ответ - Целочисленный
  procedure answ_numb_set(p_bid_id      wcs_answers.bid_id%type, -- Идентификатор заявки
                          p_question_id wcs_answers.question_id%type, -- Идентификатор вопроса
                          p_val         wcs_answers.val_numb%type, -- Ответ
                          p_ws_id       wcs_answers.ws_id%type default 'MAIN', -- Идентификатор рабочего пространства
                          p_ws_number   wcs_answers.ws_number%type default 0 -- Номер рабочего пространства
                          ) is
    l_q_row wcs_questions%rowtype;
  begin
    -- проверяем тип вопроса
    begin
      select q.*
        into l_q_row
        from wcs_questions q
       where q.id = p_question_id
         and q.type_id = 'NUMB';
    exception
      when no_data_found then
        return;
    end;

    -- запись в историю изменений
    answ_history_set(p_bid_id, p_question_id, p_ws_id, p_ws_number, p_val);

    -- если значение пустое то удаляем из таблицы ответов
    if (p_val is null) then
      wcs_pack.answ_del(p_bid_id, p_question_id, p_ws_id, p_ws_number);
    else
      -- обновляем или вставляем
      update wcs_answers a
         set a.val_numb = p_val
       where a.bid_id = p_bid_id
         and a.ws_id = p_ws_id
         and a.ws_number = p_ws_number
         and a.question_id = p_question_id;

      if (sql%rowcount = 0) then
        insert into wcs_answers
          (bid_id, ws_id, ws_number, question_id, val_numb)
        values
          (p_bid_id, p_ws_id, p_ws_number, p_question_id, p_val);
      end if;
    end if;
  end answ_numb_set;

  -- Создает/обновляет ответ - Дробное число
  procedure answ_dec_set(p_bid_id      wcs_answers.bid_id%type, -- Идентификатор заявки
                         p_question_id wcs_answers.question_id%type, -- Идентификатор вопроса
                         p_val         wcs_answers.val_decimal%type, -- Ответ
                         p_ws_id       wcs_answers.ws_id%type default 'MAIN', -- Идентификатор рабочего пространства
                         p_ws_number   wcs_answers.ws_number%type default 0 -- Номер рабочего пространства
                         ) is
    l_q_row wcs_questions%rowtype;
  begin
    -- проверяем тип вопроса
    begin
      select q.*
        into l_q_row
        from wcs_questions q
       where q.id = p_question_id
         and q.type_id = 'DECIMAL';
    exception
      when no_data_found then
        return;
    end;

    -- запись в историю изменений
    answ_history_set(p_bid_id, p_question_id, p_ws_id, p_ws_number, p_val);

    -- если значение пустое то удаляем из таблицы ответов
    if (p_val is null) then
      wcs_pack.answ_del(p_bid_id, p_question_id, p_ws_id, p_ws_number);
    else
      -- обновляем или вставляем
      update wcs_answers a
         set a.val_decimal = p_val
       where a.bid_id = p_bid_id
         and a.ws_id = p_ws_id
         and a.ws_number = p_ws_number
         and a.question_id = p_question_id;

      if (sql%rowcount = 0) then
        insert into wcs_answers
          (bid_id, ws_id, ws_number, question_id, val_decimal)
        values
          (p_bid_id, p_ws_id, p_ws_number, p_question_id, p_val);
      end if;
    end if;
  end answ_dec_set;

  -- Создает/обновляет ответ - Дата
  procedure answ_dat_set(p_bid_id      wcs_answers.bid_id%type, -- Идентификатор заявки
                         p_question_id wcs_answers.question_id%type, -- Идентификатор вопроса
                         p_val         wcs_answers.val_date%type, -- Ответ
                         p_ws_id       wcs_answers.ws_id%type default 'MAIN', -- Идентификатор рабочего пространства
                         p_ws_number   wcs_answers.ws_number%type default 0 -- Номер рабочего пространства
                         ) is
    l_q_row wcs_questions%rowtype;
  begin
    -- проверяем тип вопроса
    begin
      select q.*
        into l_q_row
        from wcs_questions q
       where q.id = p_question_id
         and q.type_id = 'DATE';
    exception
      when no_data_found then
        return;
    end;

    -- запись в историю изменений
    answ_history_set(p_bid_id, p_question_id, p_ws_id, p_ws_number, p_val);

    -- если значение пустое то удаляем из таблицы ответов
    if (p_val is null) then
      wcs_pack.answ_del(p_bid_id, p_question_id, p_ws_id, p_ws_number);
    else
      -- обновляем или вставляем
      update wcs_answers a
         set a.val_date = p_val
       where a.bid_id = p_bid_id
         and a.ws_id = p_ws_id
         and a.ws_number = p_ws_number
         and a.question_id = p_question_id;

      if (sql%rowcount = 0) then
        insert into wcs_answers
          (bid_id, ws_id, ws_number, question_id, val_date)
        values
          (p_bid_id, p_ws_id, p_ws_number, p_question_id, p_val);
      end if;
    end if;
  end answ_dat_set;

  -- Создает/обновляет ответ - Список
  procedure answ_list_set(p_bid_id      wcs_answers.bid_id%type, -- Идентификатор заявки
                          p_question_id wcs_answers.question_id%type, -- Идентификатор вопроса
                          p_val         wcs_answers.val_list%type, -- Ответ
                          p_ws_id       wcs_answers.ws_id%type default 'MAIN', -- Идентификатор рабочего пространства
                          p_ws_number   wcs_answers.ws_number%type default 0 -- Номер рабочего пространства
                          ) is
    l_q_row         wcs_questions%rowtype;
    l_check_answer_ number;
  begin
    -- проверяем тип вопроса
    begin
      select q.*
        into l_q_row
        from wcs_questions q
       where q.id = p_question_id
         and q.type_id = 'LIST';
    exception
      when no_data_found then
        return;
    end;

    -- запись в историю изменений
    answ_history_set(p_bid_id, p_question_id, p_ws_id, p_ws_number, p_val);

    -- если значение пустое то удаляем из таблицы ответов
    if (p_val is null) then
      wcs_pack.answ_del(p_bid_id, p_question_id, p_ws_id, p_ws_number);
    else
      -- проверяем чтоб в списоке был такой ответ
      begin
        select qli.ord
          into l_check_answer_
          from wcs_question_list_items qli
         where qli.question_id = p_question_id
           and qli.ord = p_val;
      exception
        when no_data_found then
          return;
      end;

      -- обновляем или вставляем
      update wcs_answers a
         set a.val_list = p_val
       where a.bid_id = p_bid_id
         and a.ws_id = p_ws_id
         and a.ws_number = p_ws_number
         and a.question_id = p_question_id;

      if (sql%rowcount = 0) then
        insert into wcs_answers
          (bid_id, ws_id, ws_number, question_id, val_list)
        values
          (p_bid_id, p_ws_id, p_ws_number, p_question_id, p_val);
      end if;

    end if;
  end answ_list_set;

  -- Создает/обновляет ответ - Справочник
  procedure answ_ref_set(p_bid_id      wcs_answers.bid_id%type, -- Идентификатор заявки
                         p_question_id wcs_answers.question_id%type, -- Идентификатор вопроса
                         p_val         wcs_answers.val_refer%type, -- Ответ
                         p_ws_id       wcs_answers.ws_id%type default 'MAIN', -- Идентификатор рабочего пространства
                         p_ws_number   wcs_answers.ws_number%type default 0 -- Номер рабочего пространства
                         ) is
    l_q_row wcs_questions%rowtype;
  begin
    -- проверяем тип вопроса
    begin
      select q.*
        into l_q_row
        from wcs_questions q
       where q.id = p_question_id
         and q.type_id = 'REFER';
    exception
      when no_data_found then
        return;
    end;

    -- запись в историю изменений
    answ_history_set(p_bid_id, p_question_id, p_ws_id, p_ws_number, p_val);

    -- если значение пустое то удаляем из таблицы ответов
    if (p_val is null) then
      wcs_pack.answ_del(p_bid_id, p_question_id, p_ws_id, p_ws_number);
    else
      -- обновляем или вставляем
      update wcs_answers a
         set a.val_refer = p_val
       where a.bid_id = p_bid_id
         and a.ws_id = p_ws_id
         and a.ws_number = p_ws_number
         and a.question_id = p_question_id;

      if (sql%rowcount = 0) then
        insert into wcs_answers
          (bid_id, ws_id, ws_number, question_id, val_refer)
        values
          (p_bid_id, p_ws_id, p_ws_number, p_question_id, p_val);
      end if;
    end if;
  end answ_ref_set;

  -- Создает/обновляет ответ - Файл
  procedure answ_file_set(p_bid_id        wcs_answers.bid_id%type, -- Идентификатор заявки
                          p_question_id   wcs_answers.question_id%type, -- Идентификатор вопроса
                          p_val           wcs_answers.val_file%type, -- Ответ
                          p_val_file_name wcs_answers.val_file_name%type, -- Имя файла
                          p_ws_id         wcs_answers.ws_id%type default 'MAIN', -- Идентификатор рабочего пространства
                          p_ws_number     wcs_answers.ws_number%type default 0 -- Номер рабочего пространства
                          ) is
    l_q_row wcs_questions%rowtype;
  begin
    -- проверяем тип вопроса
    begin
      select q.*
        into l_q_row
        from wcs_questions q
       where q.id = p_question_id
         and q.type_id = 'FILE';
    exception
      when no_data_found then
        return;
    end;

    -- запись в историю изменений
    answ_history_set(p_bid_id, p_question_id, p_ws_id, p_ws_number, '...');

    -- если значение пустое то удаляем из таблицы ответов
    if (p_val is null) then
      wcs_pack.answ_del(p_bid_id, p_question_id, p_ws_id, p_ws_number);
    else
      -- обновляем или вставляем
      update wcs_answers a
         set a.val_file = p_val, a.val_file_name = p_val_file_name
       where a.bid_id = p_bid_id
         and a.ws_id = p_ws_id
         and a.ws_number = p_ws_number
         and a.question_id = p_question_id;

      if (sql%rowcount = 0) then
        insert into wcs_answers
          (bid_id, ws_id, ws_number, question_id, val_file, val_file_name)
        values
          (p_bid_id,
           p_ws_id,
           p_ws_number,
           p_question_id,
           p_val,
           p_val_file_name);
      end if;
    end if;
  end answ_file_set;

  -- Создает/обновляет ответ - Матрица
  procedure answ_mtx_set(p_bid_id      wcs_answers.bid_id%type, -- Идентификатор заявки
                         p_question_id wcs_answers.question_id%type, -- Идентификатор вопроса
                         p_val         wcs_answers.val_matrix%type, -- Ответ
                         p_ws_id       wcs_answers.ws_id%type default 'MAIN', -- Идентификатор рабочего пространства
                         p_ws_number   wcs_answers.ws_number%type default 0 -- Номер рабочего пространства
                         ) is
    l_q_row wcs_questions%rowtype;
  begin
    -- проверяем тип вопроса
    begin
      select q.*
        into l_q_row
        from wcs_questions q
       where q.id = p_question_id
         and q.type_id = 'MATRIX';
    exception
      when no_data_found then
        return;
    end;

    -- запись в историю изменений
    answ_history_set(p_bid_id, p_question_id, p_ws_id, p_ws_number, '...');

    -- если значение пустое то удаляем из таблицы ответов
    if (p_val is null) then
      wcs_pack.answ_del(p_bid_id, p_question_id, p_ws_id, p_ws_number);
    else
      -- обновляем или вставляем
      update wcs_answers a
         set a.val_matrix = p_val
       where a.bid_id = p_bid_id
         and a.ws_id = p_ws_id
         and a.ws_number = p_ws_number
         and a.question_id = p_question_id;

      if (sql%rowcount = 0) then
        insert into wcs_answers
          (bid_id, ws_id, ws_number, question_id, val_matrix)
        values
          (p_bid_id, p_ws_id, p_ws_number, p_question_id, p_val);
      end if;
    end if;
  end answ_mtx_set;

  -- Создает/обновляет ответ - Булевый
  procedure answ_bool_set(p_bid_id      wcs_answers.bid_id%type, -- Идентификатор заявки
                          p_question_id wcs_answers.question_id%type, -- Идентификатор вопроса
                          p_val         wcs_answers.val_bool%type, -- Ответ
                          p_ws_id       wcs_answers.ws_id%type default 'MAIN', -- Идентификатор рабочего пространства
                          p_ws_number   wcs_answers.ws_number%type default 0 -- Номер рабочего пространства
                          ) is
    l_q_row wcs_questions%rowtype;
  begin
    -- проверяем тип вопроса
    begin
      select q.*
        into l_q_row
        from wcs_questions q
       where q.id = p_question_id
         and q.type_id = 'BOOL';
    exception
      when no_data_found then
        return;
    end;

    -- запись в историю изменений
    answ_history_set(p_bid_id, p_question_id, p_ws_id, p_ws_number, p_val);

    -- если значение пустое то удаляем из таблицы ответов
    if (p_val is null or (p_val <> 0 and p_val <> 1)) then
      wcs_pack.answ_del(p_bid_id, p_question_id, p_ws_id, p_ws_number);
    else
      -- обновляем или вставляем
      update wcs_answers a
         set a.val_bool = p_val
       where a.bid_id = p_bid_id
         and a.ws_id = p_ws_id
         and a.ws_number = p_ws_number
         and a.question_id = p_question_id;

      if (sql%rowcount = 0) then
        insert into wcs_answers
          (bid_id, ws_id, ws_number, question_id, val_bool)
        values
          (p_bid_id, p_ws_id, p_ws_number, p_question_id, p_val);
      end if;
    end if;
  end answ_bool_set;

  -- Создает/обновляет ответ - Xml
  procedure answ_xml_set(p_bid_id      wcs_answers.bid_id%type, -- Идентификатор заявки
                         p_question_id wcs_answers.question_id%type, -- Идентификатор вопроса
                         p_val         wcs_answers.val_xml%type, -- Ответ
                         p_ws_id       wcs_answers.ws_id%type default 'MAIN', -- Идентификатор рабочего пространства
                         p_ws_number   wcs_answers.ws_number%type default 0 -- Номер рабочего пространства
                         ) is
    l_q_row wcs_questions%rowtype;
  begin
    -- проверяем тип вопроса
    begin
      select q.*
        into l_q_row
        from wcs_questions q
       where q.id = p_question_id
         and q.type_id = 'XML';
    exception
      when no_data_found then
        return;
    end;

    -- запись в историю изменений
    answ_history_set(p_bid_id, p_question_id, p_ws_id, p_ws_number, '...');

    -- если значение пустое то удаляем из таблицы ответов
    if (p_val is null) then
      wcs_pack.answ_del(p_bid_id, p_question_id, p_ws_id, p_ws_number);
    else
      -- обновляем или вставляем
      update wcs_answers a
         set a.val_xml = p_val
       where a.bid_id = p_bid_id
         and a.ws_id = p_ws_id
         and a.ws_number = p_ws_number
         and a.question_id = p_question_id;

      if (sql%rowcount = 0) then
        insert into wcs_answers
          (bid_id, ws_id, ws_number, question_id, val_xml)
        values
          (p_bid_id, p_ws_id, p_ws_number, p_question_id, p_val);
      end if;
    end if;
  end answ_xml_set;

  -- Удаляет ответ
  procedure answ_del(p_bid_id      wcs_answers.bid_id%type, -- Идентификатор заявки
                     p_question_id wcs_answers.question_id%type, -- Идентификатор вопроса
                     p_ws_id       wcs_answers.ws_id%type default 'MAIN', -- Идентификатор рабочего пространства
                     p_ws_number   wcs_answers.ws_number%type default 0 -- Номер рабочего пространства
                     ) is
    l_atype_id wcs_answers_history.action_type_id%type := 'D'; -- Ид. типа дейчтвия (I, U, D)
  begin
    -- запись в историю изменений
    answ_history_set(p_bid_id, p_question_id, p_ws_id, p_ws_number, null);

    -- удаляем
    delete from wcs_answers a
     where a.bid_id = p_bid_id
       and a.ws_id = p_ws_id
       and a.ws_number = p_ws_number
       and a.question_id = p_question_id;
  end answ_del;
  -- ------------------------------- Ответы ----------------------------------------

  -- --------------------------- Данные кредита --------------------------------------------
  -- Создает/обновляет данные кредита для субпродукта
  procedure sbp_crddata_set(p_subproduct_id wcs_subproduct_creditdata.subproduct_id%type, -- Идентификатор субпродукта
                            p_crddata_id    wcs_subproduct_creditdata.crddata_id%type, -- Идентификатор параметра
                            p_question_id   wcs_subproduct_creditdata.question_id%type, -- Идентификатор вопроса
                            p_is_visible    wcs_subproduct_creditdata.is_visible%type, -- Отображать или нет
                            p_is_readonly   wcs_subproduct_creditdata.is_readonly%type, -- Только чтение (null/1/true - OK, 0/false - NOT OK)
                            p_is_checkable  wcs_subproduct_creditdata.is_checkable%type, -- Проверять или нет
                            p_check_proc    wcs_subproduct_creditdata.check_proc%type, -- Идентификатор вопроса
                            p_dnshow_if     wcs_subproduct_creditdata.dnshow_if%type -- Условие по которому не показывать вопрос
                            ) is
    l_proc_name varchar2(100) := 'sbp_crddata_set. ';
  begin
    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Start. Params: p_subproduct_id=%s, p_crddata_id=%s, p_question_id=%s, p_is_visible=%s, p_is_readonly=%s, p_is_checkable=%s, p_check_proc=%s',
                     to_char(p_subproduct_id),
                     to_char(p_crddata_id),
                     to_char(p_question_id),
                     to_char(p_is_visible),
                     p_is_readonly,
                     to_char(p_is_checkable),
                     to_char(p_check_proc));

    -- обновляем или вставляем
    update wcs_subproduct_creditdata sc
       set sc.question_id  = p_question_id,
           sc.is_visible   = p_is_visible,
           sc.is_readonly  = p_is_readonly,
           sc.is_checkable = p_is_checkable,
           sc.check_proc   = p_check_proc,
           sc.dnshow_if    = p_dnshow_if
     where sc.subproduct_id = p_subproduct_id
       and sc.crddata_id = p_crddata_id;

    if (sql%rowcount = 0) then
      bars_audit.trace(g_pack_name || l_proc_name ||
                       'Proccess. sql%rowcount = 0');

      insert into wcs_subproduct_creditdata
        (subproduct_id,
         crddata_id,
         question_id,
         is_visible,
         is_readonly,
         is_checkable,
         check_proc,
         dnshow_if)
      values
        (p_subproduct_id,
         p_crddata_id,
         p_question_id,
         p_is_visible,
         p_is_readonly,
         p_is_checkable,
         p_check_proc,
         p_dnshow_if);
    end if;

    bars_audit.trace(g_pack_name || l_proc_name || 'Finish.');
  end sbp_crddata_set;

  -- Удаляет данные кредита для субпродукта
  procedure sbp_crddata_del(p_subproduct_id wcs_subproduct_creditdata.subproduct_id%type, -- Идентификатор субпродукта
                            p_crddata_id    wcs_subproduct_creditdata.crddata_id%type -- Идентификатор параметра
                            ) is
    l_proc_name varchar2(100) := 'sbp_crddata_del. ';
  begin
    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Start. Params: p_subproduct_id=%s, p_crddata_id=%s',
                     to_char(p_subproduct_id),
                     to_char(p_crddata_id));

    -- обновляем или вставляем
    delete from wcs_subproduct_creditdata sc
     where sc.subproduct_id = p_subproduct_id
       and sc.crddata_id = p_crddata_id;

    bars_audit.trace(g_pack_name || l_proc_name || 'Finish.');
  end sbp_crddata_del;

  -- Клонирует данные кредита для субпродукта
  procedure sbp_crddata_clone(p_subproduct_id     wcs_subproduct_creditdata.subproduct_id%type, -- Идентификатор субпродукта
                              p_src_subproduct_id wcs_subproduct_creditdata.subproduct_id%type -- Идентификатор субпродукта
                              ) is
  begin
    for cur in (select *
                  from wcs_subproduct_creditdata sc
                 where sc.subproduct_id = p_src_subproduct_id) loop
      sbp_crddata_set(p_subproduct_id,
                      cur.crddata_id,
                      cur.question_id,
                      cur.is_visible,
                      cur.is_readonly,
                      cur.is_checkable,
                      cur.check_proc,
                      cur.dnshow_if);
    end loop;
  end sbp_crddata_clone;
  -- --------------------------- Данные кредита --------------------------------------------

  -- --------------------------- Стопы --------------------------------------------
  -- Создает/обновляет стоп
  procedure stop_set(p_stop_id wcs_stops.id%type, -- Идентификатор стопа
                     p_name    wcs_stops.name%type, -- Наименование
                     p_type_id wcs_stops.type_id%type, -- Тип (правило/фактор)
                     p_plsql   wcs_stops.plsql%type -- plsql блок описывающий стоп фактор
                     ) is
    l_result_qid varchar2(100);
  begin
    -- добавляем вопрос результата
    l_result_qid := p_stop_id || g_stop_result_prefix;
    wcs_pack.quest_set(l_result_qid,
                       p_stop_id || ' stop result',
                       'BOOL',
                       1,
                       'wcs_utl.get_stop(:#BID_ID%T-K#, ''' || p_stop_id ||
                       ''')');

    -- обновляем или вставляем
    update wcs_stops t
       set t.name       = p_name,
           t.type_id    = p_type_id,
           t.result_qid = l_result_qid,
           t.plsql      = p_plsql
     where t.id = p_stop_id;

    if (sql%rowcount = 0) then
      insert into wcs_stops
        (id, name, type_id, result_qid, plsql)
      values
        (p_stop_id, p_name, p_type_id, l_result_qid, p_plsql);
    end if;
  end stop_set;

  -- Удаляет стоп
  procedure stop_del(p_stop_id wcs_stops.id%type -- Идентификатор стопа
                     ) is
  begin
    -- удаляем
    delete from wcs_subproduct_stops t where t.stop_id = p_stop_id;
    -- удаляем
    delete from wcs_stops t where t.id = p_stop_id;
  end stop_del;

  -- Создает/обновляет стоп субпродукта
  procedure sbprod_stop_set(p_subproduct_id wcs_subproduct_stops.subproduct_id%type, -- Идентификатор субпродукта
                            p_stop_id       wcs_subproduct_stops.stop_id%type, -- Идентификатор стоп фактора
                            p_act_level     wcs_subproduct_stops.act_level%type default null -- Уровень активации
                            ) is
  begin
    -- обновляем или вставляем
    update wcs_subproduct_stops t
       set t.act_level = p_act_level
     where t.subproduct_id = p_subproduct_id
       and t.stop_id = p_stop_id;

    if (sql%rowcount = 0) then
      insert into wcs_subproduct_stops
        (subproduct_id, stop_id, act_level)
      values
        (p_subproduct_id, p_stop_id, p_act_level);
    end if;
  end sbprod_stop_set;

  -- Удаляет стоп субпродукта
  procedure sbprod_stop_del(p_subproduct_id wcs_subproduct_stops.subproduct_id%type, -- Идентификатор субпродукта
                            p_stop_id       wcs_subproduct_stops.stop_id%type -- Идентификатор стоп фактора
                            ) is
  begin
    -- удаляем
    delete from wcs_subproduct_stops t
     where t.subproduct_id = p_subproduct_id
       and t.stop_id = p_stop_id;
  end sbprod_stop_del;

  -- Клонирует стопы субпродукта
  procedure sbp_stop_clone(p_subproduct_id     wcs_subproducts.id%type, -- Идентификатор субпродукта
                           p_src_subproduct_id wcs_subproducts.id%type -- Идентификатор субпродукта
                           ) is
  begin
    for cur in (select *
                  from v_wcs_subproduct_stops ss
                 where ss.subproduct_id = p_src_subproduct_id) loop
      sbprod_stop_set(p_subproduct_id, cur.stop_id, cur.act_level);
    end loop;
  end sbp_stop_clone;
  -- --------------------------- Стопы --------------------------------------------

  -- ---------------------- Сканкопии ----------------------------
  -- Создает/обновляет карту сканкопий
  procedure scopy_set(scopy_id_ varchar2, -- Идентификатор карты сканкопий
                      name_     varchar2 -- Наименование
                      ) is
  begin
    -- обновляем или вставляем
    update wcs_scancopies t set t.name = name_ where t.id = scopy_id_;

    if (sql%rowcount = 0) then
      insert into wcs_scancopies (id, name) values (scopy_id_, name_);
    end if;
  end scopy_set;

  -- Удаляет карту сканкопий
  procedure scopy_del(scopy_id_ varchar2 -- Идентификатор карты сканкопий
                      ) is
  begin
    delete from wcs_scancopies t where t.id = scopy_id_;
  end scopy_del;

  -- Создает/обновляет вопрос карты сканкопий
  procedure scopy_quest_set(p_scopy_id    varchar2, -- Идентификатор карты сканкопий
                            p_question_id varchar2, -- Идентификатор вопроса сканкопии
                            p_type_id     varchar2, -- Идентификатор типа сканкопии
                            p_is_required number -- Обязательный для заполнения
                            ) is
    l_ord  number;
    l_type wcs_questions.type_id%type;
  begin
    -- проверяем тип вопроса
    select t.type_id
      into l_type
      from wcs_questions t
     where t.id = p_question_id;

    if (l_type <> 'FILE') then
      return;
    end if;

    -- порядок отображения
    select nvl(max(ord), -1) + 1
      into l_ord
      from wcs_scancopy_questions t
     where t.scopy_id = p_scopy_id;

    -- обновляем или вставляем
    update wcs_scancopy_questions t
       set t.type_id = p_type_id, t.is_required = p_is_required
     where t.scopy_id = p_scopy_id
       and t.question_id = p_question_id;

    if (sql%rowcount = 0) then
      insert into wcs_scancopy_questions
        (scopy_id, question_id, type_id, is_required, ord)
      values
        (p_scopy_id, p_question_id, p_type_id, p_is_required, l_ord);
    end if;
  end scopy_quest_set;

  -- Удаляет вопрос карты сканкопий
  procedure scopy_quest_del(scopy_id_    varchar2, -- Идентификатор карты сканкопий
                            question_id_ varchar2 -- Идентификатор вопроса сканкопии
                            ) is
  begin
    delete from wcs_scancopy_questions t
     where t.scopy_id = scopy_id_
       and t.question_id = question_id_;
  end scopy_quest_del;

  -- Перемещает вопрос карты сканкопий
  procedure scopy_quest_move(p_scopy_id     wcs_scancopy_questions.scopy_id%type, -- Идентификатор карты сканкопий
                             p_src_questid  wcs_scancopy_questions.question_id%type, -- Идентификатор вопроса сканкопии источника
                             p_dest_questid wcs_scancopy_questions.question_id%type -- Идентификатор вопроса сканкопии назначения
                             ) is
    l_src  wcs_scancopy_questions%rowtype;
    l_dest wcs_scancopy_questions%rowtype;
  begin
    select sq.*
      into l_src
      from wcs_scancopy_questions sq
     where sq.scopy_id = p_scopy_id
       and sq.question_id = p_src_questid;
    select sq.*
      into l_dest
      from wcs_scancopy_questions sq
     where sq.scopy_id = p_scopy_id
       and sq.question_id = p_dest_questid;

    update wcs_scancopy_questions sq
       set sq.ord = l_dest.ord
     where sq.scopy_id = l_src.scopy_id
       and sq.question_id = l_src.question_id;
    update wcs_scancopy_questions sq
       set sq.ord = l_src.ord
     where sq.scopy_id = l_dest.scopy_id
       and sq.question_id = l_dest.question_id;
  exception
    when no_data_found then
      null;
  end scopy_quest_move;

  -- Создает/обновляет карту сканкопий субпродукта
  procedure sbprod_scopy_set(subproduct_id_ varchar2, -- Идентификатор субпродукта
                             scopy_id_      varchar2 -- Идентификатор карты сканкопий
                             ) is
  begin
    -- обновляем или вставляем
    update wcs_subproduct_scancopies t
       set t.scopy_id = scopy_id_
     where t.subproduct_id = subproduct_id_;

    if (sql%rowcount = 0) then
      insert into wcs_subproduct_scancopies
        (subproduct_id, scopy_id)
      values
        (subproduct_id_, scopy_id_);
    end if;
  end sbprod_scopy_set;

  -- Удаляет карту сканкопий субпродукта
  procedure sbprod_scopy_del(subproduct_id_ varchar2 -- Идентификатор субпродукта
                             ) is
  begin
    delete from wcs_subproduct_scancopies t
     where t.subproduct_id = subproduct_id_;
  end sbprod_scopy_del;

  -- Клонирует карту сканкопий субпродукта
  procedure sbp_scopy_clone(p_subproduct_id     wcs_subproducts.id%type, -- Идентификатор субпродукта
                            p_src_subproduct_id wcs_subproducts.id%type -- Идентификатор субпродукта
                            ) is
  begin
    for cur in (select *
                  from v_wcs_subproduct_scancopies ss
                 where ss.subproduct_id = p_src_subproduct_id) loop
      sbprod_scopy_set(p_subproduct_id, cur.scopy_id);
    end loop;
  end sbp_scopy_clone;

  -- Добавляет сканкопию в очередь печати
  procedure print_scan_set(p_print_session_id wcs_print_scans.print_session_id%type, -- Идентификатор сессии печати
                           p_scan_data        wcs_print_scans.scan_data%type -- Сканкопия
                           ) is
    l_ord wcs_print_scans.ord%type;
  begin
    select nvl(max(ps.ord), 0) + 1
      into l_ord
      from wcs_print_scans ps
     where ps.print_session_id = p_print_session_id;
    insert into wcs_print_scans
      (print_session_id, ord, scan_data)
    values
      (p_print_session_id, l_ord, p_scan_data);
  end print_scan_set;

  -- Чистит сессию печати
  procedure print_scan_clear(p_print_session_id wcs_print_scans.print_session_id%type -- Идентификатор сессии печати
                             ) is
  begin
    delete from wcs_print_scans ps
     where ps.print_session_id = p_print_session_id;
  end print_scan_clear;
  -- ---------------------- Сканкопии ----------------------------

  -- ---------------------- Авторизации ----------------------------
  -- Создает/обновляет карту авторизации
  procedure auth_set(auth_id_ varchar2, -- Идентификатор карты авторизации
                     name_    varchar2 -- Наименование
                     ) is
  begin
    -- обновляем или вставляем
    update wcs_authorizations t set t.name = name_ where t.id = auth_id_;

    if (sql%rowcount = 0) then
      insert into wcs_authorizations (id, name) values (auth_id_, name_);
    end if;
  end auth_set;

  -- Удаляет карту авторизации
  procedure auth_del(auth_id_ varchar2 -- Идентификатор карты авторизации
                     ) is
  begin
    delete from wcs_authorizations t where t.id = auth_id_;
  end auth_del;

  -- Клонирует карту авторизации
  procedure auth_clone(p_auth_id    v_wcs_authorizations.auth_id%type, -- Идентификатор карты авторизации
                       p_auth_name  v_wcs_authorizations.auth_name%type, -- Наименование
                       p_src_authid v_wcs_authorizations.auth_id%type -- Идентификатор карты-источника для клонирования
                       ) is
  begin
    -- Создает/обновляет карту авторизации
    auth_set(p_auth_id, p_auth_name);

    -- добавляем в нее вопросы
    for cur in (select *
                  from v_wcs_authorization_questions aq
                 where aq.auth_id = p_src_authid
                 order by aq.ord) loop
      auth_quest_set(p_auth_id,
                     cur.question_id,
                     cur.scopy_qid,
                     cur.is_required,
                     cur.is_checkable,
                     cur.check_proc);
    end loop;
  end auth_clone;

  -- Создает/обновляет вопрос карты авторизации
  procedure auth_quest_set(p_auth_id      wcs_authorization_questions.auth_id%type, -- Идентификатор карты авторизации
                           p_question_id  wcs_authorization_questions.question_id%type, -- Идентификатор вопроса
                           p_scopy_qid    wcs_authorization_questions.scopy_qid%type, -- Идентификатор вопроса связной сканкопии
                           p_is_required  wcs_authorization_questions.is_required%type, -- Обязателен ли для заполнения
                           p_is_checkable wcs_authorization_questions.is_checkable%type, -- Проверяется ли поле
                           p_check_proc   wcs_authorization_questions.check_proc%type -- Текст проверки
                           ) is
    l_ord     number;
    l_type    wcs_questions.type_id%type;
    l_sc_type wcs_questions.type_id%type;
  begin
    -- проверяем тип вопроса
    select t.type_id
      into l_type
      from wcs_questions t
     where t.id = p_question_id;
    if (l_type <> 'TEXT' and l_type <> 'NUMB' and l_type <> 'DECIMAL' and
       l_type <> 'DATE' and l_type <> 'LIST' and l_type <> 'REFER' and
       l_type <> 'BOOL') then
      return;
    end if;

    -- проверяем тип вопроса сканкопии
    if (p_scopy_qid is not null) then
      select t.type_id
        into l_sc_type
        from wcs_questions t
       where t.id = p_scopy_qid;
      if (l_sc_type <> 'FILE') then
        return;
      end if;
    end if;

    -- порядок отображения
    select nvl(max(ord), -1) + 1
      into l_ord
      from wcs_authorization_questions t
     where t.auth_id = p_auth_id;

    -- обновляем или вставляем
    update wcs_authorization_questions t
       set t.scopy_qid    = p_scopy_qid,
           t.is_required  = p_is_required,
           t.is_checkable = p_is_checkable,
           t.check_proc   = p_check_proc
     where t.auth_id = p_auth_id
       and t.question_id = p_question_id;

    if (sql%rowcount = 0) then
      insert into wcs_authorization_questions
        (auth_id,
         question_id,
         scopy_qid,
         is_required,
         is_checkable,
         check_proc,
         ord)
      values
        (p_auth_id,
         p_question_id,
         p_scopy_qid,
         p_is_required,
         p_is_checkable,
         p_check_proc,
         l_ord);
    end if;
  end auth_quest_set;

  -- Удаляет вопрос карты авторизации
  procedure auth_quest_del(auth_id_     varchar2, -- Идентификатор карты авторизации
                           question_id_ varchar2 -- Идентификатор вопроса
                           ) is
  begin
    delete from wcs_authorization_questions t
     where t.auth_id = auth_id_
       and t.question_id = question_id_;
  end auth_quest_del;

  -- Перемещает вопрос карты авторизации
  procedure auth_quest_move(p_auth_id      wcs_authorization_questions.auth_id%type, -- Идентификатор карты авторизации
                            p_src_questid  wcs_authorization_questions.question_id%type, -- Идентификатор вопроса источника
                            p_dest_questid wcs_authorization_questions.question_id%type -- Идентификатор вопроса назначения
                            ) is
    l_src  wcs_authorization_questions%rowtype;
    l_dest wcs_authorization_questions%rowtype;
  begin
    select aq.*
      into l_src
      from wcs_authorization_questions aq
     where aq.auth_id = p_auth_id
       and aq.question_id = p_src_questid;
    select aq.*
      into l_dest
      from wcs_authorization_questions aq
     where aq.auth_id = p_auth_id
       and aq.question_id = p_dest_questid;

    update wcs_authorization_questions aq
       set aq.ord = l_dest.ord
     where aq.auth_id = l_src.auth_id
       and aq.question_id = l_src.question_id;
    update wcs_authorization_questions aq
       set aq.ord = l_src.ord
     where aq.auth_id = l_dest.auth_id
       and aq.question_id = l_dest.question_id;
  exception
    when no_data_found then
      null;
  end auth_quest_move;

  -- Создает/обновляет карту авторизации субпродукта
  procedure sbprod_auth_set(subproduct_id_ varchar2, -- Идентификатор субпродукта
                            auth_id_       varchar2 -- Идентификатор карты авторизации
                            ) is
  begin
    -- обновляем или вставляем
    update wcs_subproduct_authorizations t
       set t.auth_id = auth_id_
     where t.subproduct_id = subproduct_id_;

    if (sql%rowcount = 0) then
      insert into wcs_subproduct_authorizations
        (subproduct_id, auth_id)
      values
        (subproduct_id_, auth_id_);
    end if;
  end sbprod_auth_set;

  -- Удаляет карту авторизации субпродукта
  procedure sbprod_auth_del(subproduct_id_ varchar2 -- Идентификатор субпродукта
                            ) is
  begin
    delete from wcs_subproduct_authorizations t
     where t.subproduct_id = subproduct_id_;
  end sbprod_auth_del;

  -- Клонирует карту авторизации субпродукта
  procedure sbp_auth_clone(p_subproduct_id     wcs_subproducts.id%type, -- Идентификатор субпродукта
                           p_src_subproduct_id wcs_subproducts.id%type -- Идентификатор субпродукта
                           ) is
  begin
    for cur in (select *
                  from v_wcs_subproduct_auths sa
                 where sa.subproduct_id = p_src_subproduct_id) loop
      sbprod_auth_set(p_subproduct_id, cur.auth_id);
    end loop;
  end sbp_auth_clone;
  -- ---------------------- Авторизации ----------------------------

  -- ---------------------- Карты-анкеты ----------------------------
  -- Создает/обновляет карту-анкету
  procedure survey_set(survey_id_ varchar2, -- Идентификатор карты-анкеты
                       name_      varchar2 -- Наименование
                       ) is
  begin
    -- обновляем или вставляем
    update wcs_surveys t set t.name = name_ where t.id = survey_id_;

    if (sql%rowcount = 0) then
      insert into wcs_surveys (id, name) values (survey_id_, name_);
    end if;
  end survey_set;

  -- Удаляет карту-анкету
  procedure survey_del(survey_id_ varchar2 -- Идентификатор карты-анкеты
                       ) is
  begin
    delete from wcs_surveys t where t.id = survey_id_;
  end survey_del;

  -- Создает/обновляет групу анкеты
  procedure survey_group_set(p_survey_id wcs_survey_groups.survey_id%type, -- Идентификатор анкеты
                             p_sgroup_id wcs_survey_groups.id%type, -- Идентификатор
                             p_name      wcs_survey_groups.name%type, -- Наименование
                             p_dnshow_if wcs_survey_groups.dnshow_if%type -- Условие по которому не показывать группу
                             ) is
    l_result_qid varchar2(100);
    l_ord        number;
  begin
    -- добавляем вопрос результата
    l_result_qid := p_sgroup_id || g_surgrp_result_prefix;
    wcs_pack.quest_set(l_result_qid,
                       p_sgroup_id || ' survey group filled result',
                       'BOOL',
                       0,
                       null);

    -- порядок отображения
    select nvl(max(ord), -1) + 1
      into l_ord
      from wcs_survey_groups t
     where t.survey_id = p_survey_id;

    -- обновляем или вставляем
    update wcs_survey_groups t
       set t.name       = p_name,
           t.dnshow_if  = p_dnshow_if,
           t.result_qid = l_result_qid
     where t.survey_id = p_survey_id
       and t.id = p_sgroup_id;

    if (sql%rowcount = 0) then
      insert into wcs_survey_groups
        (survey_id, id, name, dnshow_if, ord, result_qid)
      values
        (p_survey_id,
         p_sgroup_id,
         p_name,
         p_dnshow_if,
         l_ord,
         l_result_qid);
    end if;
  end survey_group_set;

  -- Удаляет групу анкеты
  procedure survey_group_del(p_survey_id wcs_survey_groups.survey_id%type, -- Идентификатор анкеты
                             p_sgroup_id wcs_survey_groups.id%type -- Идентификатор
                             ) is
  begin
    -- удаляем связку група-вопрос
    delete from wcs_survey_group_questions sgq
     where sgq.survey_id = p_survey_id
       and sgq.sgroup_id = p_sgroup_id;

    -- удаляем групу
    delete from wcs_survey_groups sg
     where sg.survey_id = p_survey_id
       and sg.id = p_sgroup_id;
  end survey_group_del;

  -- Перемещает групу анкеты
  procedure survey_group_move(p_survey_id  wcs_survey_groups.survey_id%type, -- Идентификатор анкеты
                              p_src_grpid  wcs_survey_groups.id%type, -- Идентификатор групы источника
                              p_dest_grpid wcs_survey_groups.id%type -- Идентификатор групы назначения
                              ) is
    l_src  wcs_survey_groups%rowtype;
    l_dest wcs_survey_groups%rowtype;
  begin
    select sg.*
      into l_src
      from wcs_survey_groups sg
     where sg.survey_id = p_survey_id
       and sg.id = p_src_grpid;
    select sg.*
      into l_dest
      from wcs_survey_groups sg
     where sg.survey_id = p_survey_id
       and sg.id = p_dest_grpid;

    update wcs_survey_groups sg
       set sg.ord = l_dest.ord
     where sg.survey_id = l_src.survey_id
       and sg.id = l_src.id;
    update wcs_survey_groups sg
       set sg.ord = l_src.ord
     where sg.survey_id = l_dest.survey_id
       and sg.id = l_dest.id;
  exception
    when no_data_found then
      null;
  end survey_group_move;

  -- Клонируем групу анкеты
  procedure survey_group_clone(p_dest_surid wcs_survey_groups.survey_id%type, -- Идентификатор анкеты-назначения
                               p_src_surid  wcs_survey_groups.survey_id%type, -- Идентификатор анкеты-источника
                               p_src_grpid  wcs_survey_groups.id%type -- Идентификатор групы-источника
                               ) is
    l_src wcs_survey_groups%rowtype;
  begin
    select sg.*
      into l_src
      from wcs_survey_groups sg
     where sg.survey_id = p_src_surid
       and sg.id = p_src_grpid;

    wcs_pack.survey_group_set(p_dest_surid,
                              l_src.id,
                              l_src.name || '(Копія)',
                              l_src.dnshow_if);

    for cur in (select *
                  from wcs_survey_group_questions sgq
                 where sgq.survey_id = p_src_surid
                   and sgq.sgroup_id = p_src_grpid
                 order by sgq.survey_id, sgq.sgroup_id, sgq.ord) loop
      wcs_pack.survey_group_quest_set(p_dest_surid,
                                      p_src_grpid,
                                      cur.rectype_id,
                                      cur.question_id,
                                      cur.dnshow_if,
                                      cur.is_required,
                                      cur.is_readonly,
                                      cur.is_rewritable,
                                      cur.is_checkable,
                                      cur.check_proc);
    end loop;
  end survey_group_clone;

  -- Получает в dbms_output протокол разницы груп
  procedure survey_group_sync_protocol(p_dest_surid wcs_survey_groups.survey_id%type, -- Идентификатор анкеты-назначения
                                       p_dest_grpid wcs_survey_groups.id%type, -- Идентификатор групы-назначения
                                       p_src_surid  wcs_survey_groups.survey_id%type, -- Идентификатор анкеты-источника
                                       p_src_grpid  wcs_survey_groups.id%type -- Идентификатор групы-источника
                                       ) is
  begin
    dbms_output.put_line('Destination: ' || p_dest_surid || ' ' ||
                         p_dest_grpid);
    dbms_output.put_line('Source: ' || p_src_surid || ' ' || p_src_grpid);

    for cur in (select sgq.question_id
                  from wcs_survey_group_questions sgq
                 where sgq.survey_id = p_dest_surid
                   and sgq.sgroup_id = p_dest_grpid
                minus
                select sgq.question_id
                  from wcs_survey_group_questions sgq
                 where sgq.survey_id = p_src_surid
                   and sgq.sgroup_id = p_src_grpid) loop
      dbms_output.put_line(cur.question_id || ' is extra in dest');
    end loop;

    for cur in (select sgq.question_id
                  from wcs_survey_group_questions sgq
                 where sgq.survey_id = p_src_surid
                   and sgq.sgroup_id = p_src_grpid
                minus
                select sgq.question_id
                  from wcs_survey_group_questions sgq
                 where sgq.survey_id = p_dest_surid
                   and sgq.sgroup_id = p_dest_grpid) loop
      dbms_output.put_line(cur.question_id || ' is missed in dest');
    end loop;

    for cur in (select sgq1.question_id
                  from wcs_survey_group_questions sgq1,
                       wcs_survey_group_questions sgq2
                 where sgq1.survey_id = p_src_surid
                   and sgq1.sgroup_id = p_src_grpid
                   and sgq2.survey_id = p_dest_surid
                   and sgq2.sgroup_id = p_dest_grpid
                   and sgq1.question_id = sgq2.question_id
                   and ((nvl(sgq1.rectype_id, 'null') !=
                       nvl(sgq2.rectype_id, 'null')) or
                       (nvl(sgq1.dnshow_if, 'null') !=
                       nvl(sgq2.dnshow_if, 'null')) or
                       (nvl(sgq1.is_required, -1) !=
                       nvl(sgq2.is_required, -1)) or
                       (nvl(sgq1.is_rewritable, -1) !=
                       nvl(sgq2.is_rewritable, -1)) or
                       (nvl(sgq1.is_checkable, -1) !=
                       nvl(sgq2.is_checkable, -1)) or
                       (nvl(sgq1.check_proc, 'null') !=
                       nvl(sgq2.check_proc, 'null')))) loop
      dbms_output.put_line(cur.question_id ||
                           ' different in dest and source');
    end loop;

  end survey_group_sync_protocol;

  -- Создает/обновляет вопрос карты-анкеты
  procedure survey_group_quest_set(p_survey_id     wcs_survey_group_questions.survey_id%type, -- Идентификатор карты-анкеты
                                   p_sgroup_id     wcs_survey_group_questions.sgroup_id%type, -- Идентификатор групы карты-анкеты
                                   p_rectype_id    wcs_survey_group_questions.rectype_id%type, -- Тип записи вопрос/раздел
                                   p_question_id   wcs_survey_group_questions.question_id%type, -- Идентификатор вопроса
                                   p_dnshow_if     wcs_survey_group_questions.dnshow_if%type, -- Условие по которому не показывать вопрос
                                   p_is_required   wcs_survey_group_questions.is_required%type, -- Обязателен для заполнения (null/1/true - OK, 0/false - NOT OK)
                                   p_is_readonly   wcs_survey_group_questions.is_readonly%type, -- Только чтение (null/1/true - OK, 0/false - NOT OK)
                                   p_is_rewritable wcs_survey_group_questions.is_rewritable%type, -- Возможность перезаписи
                                   p_is_checkable  wcs_survey_group_questions.is_checkable%type, -- Проверяется ли поле
                                   p_check_proc    wcs_survey_group_questions.check_proc%type -- Текст проверки
                                   ) is
    l_ord  number;
    l_type wcs_questions.type_id%type;
  begin
    -- проверяем тип вопроса
    select t.type_id
      into l_type
      from wcs_questions t
     where t.id = p_question_id;
    if (l_type <> 'TEXT' and l_type <> 'NUMB' and l_type <> 'DECIMAL' and
       l_type <> 'DATE' and l_type <> 'LIST' and l_type <> 'REFER' and
       l_type <> 'BOOL' and l_type <> 'SECTION') then
      return;
    end if;

    -- порядок отображения
    select nvl(max(ord), -1) + 1
      into l_ord
      from wcs_survey_group_questions t
     where t.survey_id = p_survey_id
       and t.sgroup_id = p_sgroup_id;

    -- обновляем или вставляем
    update wcs_survey_group_questions t
       set t.rectype_id    = p_rectype_id,
           t.dnshow_if     = p_dnshow_if,
           t.is_required   = p_is_required,
           t.is_readonly   = p_is_readonly,
           t.is_rewritable = p_is_rewritable,
           t.is_checkable  = p_is_checkable,
           t.check_proc    = p_check_proc
     where t.survey_id = p_survey_id
       and t.sgroup_id = p_sgroup_id
       and t.question_id = p_question_id;

    if (sql%rowcount = 0) then
      insert into wcs_survey_group_questions
        (survey_id,
         sgroup_id,
         rectype_id,
         question_id,
         dnshow_if,
         is_required,
         is_readonly,
         is_rewritable,
         is_checkable,
         check_proc,
         ord)
      values
        (p_survey_id,
         p_sgroup_id,
         p_rectype_id,
         p_question_id,
         p_dnshow_if,
         p_is_required,
         p_is_readonly,
         p_is_rewritable,
         p_is_checkable,
         p_check_proc,
         l_ord);
    end if;
  end survey_group_quest_set;

  -- Удаляет вопрос карты-анкеты
  procedure survey_group_quest_del(survey_id_   varchar2, -- Идентификатор карты-анкеты
                                   sgroup_id_   varchar2, -- Идентификатор групы карты-анкеты
                                   question_id_ varchar2 -- Идентификатор вопроса
                                   ) is
  begin
    delete from wcs_survey_group_questions t
     where t.survey_id = survey_id_
       and t.sgroup_id = sgroup_id_
       and t.question_id = question_id_;
  end survey_group_quest_del;

  -- Перемещает вопрос групы анкеты
  procedure survey_group_quest_move(p_survey_id    wcs_survey_group_questions.survey_id%type, -- Идентификатор анкеты
                                    p_sgroup_id    wcs_survey_group_questions.sgroup_id%type, -- Идентификатор групы
                                    p_src_questid  wcs_survey_group_questions.question_id%type, -- Идентификатор вопроса источника
                                    p_dest_questid wcs_survey_group_questions.question_id%type -- Идентификатор вопроса назначения
                                    ) is
    l_src  wcs_survey_group_questions%rowtype;
    l_dest wcs_survey_group_questions%rowtype;
  begin
    select sgq.*
      into l_src
      from wcs_survey_group_questions sgq
     where sgq.survey_id = p_survey_id
       and sgq.sgroup_id = p_sgroup_id
       and sgq.question_id = p_src_questid;
    select sgq.*
      into l_dest
      from wcs_survey_group_questions sgq
     where sgq.survey_id = p_survey_id
       and sgq.sgroup_id = p_sgroup_id
       and sgq.question_id = p_dest_questid;

    update wcs_survey_group_questions sgq
       set sgq.ord = l_dest.ord
     where sgq.survey_id = p_survey_id
       and sgq.sgroup_id = p_sgroup_id
       and sgq.question_id = l_src.question_id;
    update wcs_survey_group_questions sgq
       set sgq.ord = l_src.ord
     where sgq.survey_id = p_survey_id
       and sgq.sgroup_id = p_sgroup_id
       and sgq.question_id = l_dest.question_id;
  exception
    when no_data_found then
      null;
  end survey_group_quest_move;

  -- Создает/обновляет карту-анкету субпродукта
  procedure sbprod_survey_set(subproduct_id_ varchar2, -- Идентификатор субпродукта
                              survey_id_     varchar2 -- Идентификатор карты-анкеты
                              ) is
  begin
    -- обновляем или вставляем
    update wcs_subproduct_survey t
       set t.survey_id = survey_id_
     where t.subproduct_id = subproduct_id_;

    if (sql%rowcount = 0) then
      insert into wcs_subproduct_survey
        (subproduct_id, survey_id)
      values
        (subproduct_id_, survey_id_);
    end if;
  end sbprod_survey_set;

  -- Удаляет карту карту-анкету субпродукта
  procedure sbprod_survey_del(subproduct_id_ varchar2 -- Идентификатор субпродукта
                              ) is
  begin
    delete from wcs_subproduct_survey t
     where t.subproduct_id = subproduct_id_;
  end sbprod_survey_del;

  -- Клонирует карту-анкету субпродукта
  procedure sbp_survey_clone(p_subproduct_id     wcs_subproducts.id%type, -- Идентификатор субпродукта
                             p_src_subproduct_id wcs_subproducts.id%type -- Идентификатор субпродукта
                             ) is
  begin
    for cur in (select *
                  from v_wcs_subproduct_survey ss
                 where ss.subproduct_id = p_src_subproduct_id) loop
      sbprod_survey_set(p_subproduct_id, cur.survey_id);
    end loop;
  end sbp_survey_clone;
  -- ---------------------- Работа с картой-анкетой субпродукта ----------------------------

  -- ---------------------- Карты скоринга ----------------------------
  -- Создает/обновляет карту скоринга
  procedure scor_set(scoring_id_ varchar2, -- Идентификатор карты скоринга
                     name_       varchar2 -- Наименование
                     ) is
    l_result_qid varchar2(100);
  begin
    -- добавляем вопрос результата
    l_result_qid := scoring_id_ || g_scor_result_prefix;
    wcs_pack.quest_set(l_result_qid,
                       scoring_id_ || ' general scoring result',
                       'DECIMAL',
                       1,
                       ':#' || scoring_id_ || '%T-SG#');

    -- обновляем или вставляем
    update wcs_scorings t
       set t.name = name_, t.result_qid = l_result_qid
     where t.id = scoring_id_;

    if (sql%rowcount = 0) then
      insert into wcs_scorings
        (id, name, result_qid)
      values
        (scoring_id_, name_, l_result_qid);
    end if;
  end scor_set;

  -- Удаляет карту скоринга
  procedure scor_del(scoring_id_ varchar2 -- Идентификатор карты скоринга
                     ) is
  begin
    delete from wcs_scorings t where t.id = scoring_id_;
  end scor_del;

  -- Клонирует карту скоринга
  procedure scor_clone(p_scoring_id     wcs_scorings.id%type, -- Идентификатор карты скоринга
                       p_src_scoring_id wcs_scorings.id%type -- Идентификатор карты скоринга - источника
                       ) is
  begin
    for cur in (select *
                  from v_wcs_scoring_questions sq
                 where sq.scoring_id = p_src_scoring_id) loop
      scor_quest_set(p_scoring_id,
                     cur.question_id,
                     cur.multiplier,
                     cur.else_score);

      case cur.type_id
        when 'NUMB' then
          for cur0 in (select *
                         from v_wcs_scoring_qs_numb sqn
                        where sqn.scoring_id = cur.scoring_id
                          and sqn.question_id = cur.question_id
                        order by sqn.ord) loop
            scor_quest_numb_set(p_scoring_id,
                                cur0.question_id,
                                cur0.ord,
                                cur0.min_val,
                                cur0.min_sign,
                                cur0.max_val,
                                cur0.max_sign,
                                cur0.score);
          end loop;
        when 'DECIMAL' then
          for cur0 in (select *
                         from v_wcs_scoring_qs_decimal sqd
                        where sqd.scoring_id = cur.scoring_id
                          and sqd.question_id = cur.question_id
                        order by sqd.ord) loop
            scor_quest_decimal_set(p_scoring_id,
                                   cur0.question_id,
                                   cur0.ord,
                                   cur0.min_val,
                                   cur0.min_sign,
                                   cur0.max_val,
                                   cur0.max_sign,
                                   cur0.score);
          end loop;
        when 'DATE' then
          for cur0 in (select *
                         from v_wcs_scoring_qs_date sqd
                        where sqd.scoring_id = cur.scoring_id
                          and sqd.question_id = cur.question_id
                        order by sqd.ord) loop
            scor_quest_date_set(p_scoring_id,
                                cur0.question_id,
                                cur0.ord,
                                cur0.min_val,
                                cur0.min_sign,
                                cur0.max_val,
                                cur0.max_sign,
                                cur0.score);
          end loop;
        when 'LIST' then
          for cur0 in (select *
                         from v_wcs_scoring_qs_list sqlst
                        where sqlst.scoring_id = cur.scoring_id
                          and sqlst.question_id = cur.question_id
                          and sqlst.score is not null
                        order by sqlst.ord) loop
            scor_quest_list_set(p_scoring_id,
                                cur0.question_id,
                                cur0.ord,
                                cur0.score);
          end loop;
        when 'MATRIX' then
          -- !!! Доделать
          null;
        when 'BOOL' then
          for cur0 in (select *
                         from v_wcs_scoring_qs_bool sqb
                        where sqb.scoring_id = cur.scoring_id
                          and sqb.question_id = cur.question_id) loop
            scor_quest_bool_set(p_scoring_id,
                                cur0.question_id,
                                cur0.score_if_0,
                                cur0.score_if_1);
          end loop;
      end case;
    end loop;
  end scor_clone;

  -- Создает/обновляет вопрос карты скоринга
  procedure scor_quest_set(p_scoring_id  wcs_scoring_questions.scoring_id%type, -- Идентификатор карты скоринга
                           p_question_id wcs_scoring_questions.question_id%type, -- Идентификатор вопроса
                           p_multiplier  wcs_scoring_questions.multiplier%type, -- Участвует в скоринге
                           p_else_score  wcs_scoring_questions.else_score%type -- Cкор. балла если не выполнились условия разбивки';
                           ) is
    l_type       wcs_questions.type_id%type;
    l_result_qid varchar2(100);

    l_multiplier wcs_scoring_questions.multiplier%type := nvl(p_multiplier,
                                                              100);
    l_else_score wcs_scoring_questions.else_score%type := nvl(p_else_score,
                                                              0);
  begin
    -- проверяем тип вопроса
    select t.type_id
      into l_type
      from wcs_questions t
     where t.id = p_question_id;
    if (l_type <> 'NUMB' and l_type <> 'DECIMAL' and l_type <> 'DATE' and
       l_type <> 'LIST' and l_type <> 'MATRIX' and l_type <> 'BOOL') then
      return;
    end if;

    -- добавляем вопрос результата
    l_result_qid := p_scoring_id || '_' || p_question_id ||
                    g_scor_quest_result_prefix;
    wcs_pack.quest_set(l_result_qid,
                       p_question_id || ' scoring result',
                       'DECIMAL',
                       1,
                       ':#' || p_question_id || '%T-S%SCR-' || p_scoring_id || '#');

    -- обновляем или вставляем
    update wcs_scoring_questions t
       set t.result_qid = l_result_qid,
           t.multiplier = l_multiplier,
           t.else_score = l_else_score
     where t.scoring_id = p_scoring_id
       and t.question_id = p_question_id;

    if (sql%rowcount = 0) then
      insert into wcs_scoring_questions
        (scoring_id, question_id, result_qid, multiplier, else_score)
      values
        (p_scoring_id,
         p_question_id,
         l_result_qid,
         l_multiplier,
         l_else_score);
    end if;
  end scor_quest_set;

  -- Удаляет вопрос карты скоринга
  procedure scor_quest_del(scoring_id_  varchar2, -- Идентификатор карты скоринга
                           question_id_ varchar2 -- Идентификатор вопроса
                           ) is
  begin
    -- удаляем скоринговые баллы по вопросу
    for c in (select *
                from wcs_scoring_qs_numb sqn
               where sqn.scoring_id = scoring_id_
                 and sqn.question_id = question_id_) loop
      wcs_pack.scor_quest_numb_del(c.scoring_id, c.question_id, c.ord);
    end loop;

    for c in (select *
                from wcs_scoring_qs_decimal sqd
               where sqd.scoring_id = scoring_id_
                 and sqd.question_id = question_id_) loop
      wcs_pack.scor_quest_decimal_del(c.scoring_id, c.question_id, c.ord);
    end loop;

    for c in (select *
                from wcs_scoring_qs_date sqd
               where sqd.scoring_id = scoring_id_
                 and sqd.question_id = question_id_) loop
      wcs_pack.scor_quest_date_del(c.scoring_id, c.question_id, c.ord);
    end loop;

    for c in (select *
                from wcs_scoring_qs_list wsql
               where wsql.scoring_id = scoring_id_
                 and wsql.question_id = question_id_) loop
      wcs_pack.scor_quest_list_del(c.scoring_id, c.question_id, c.ord);
    end loop;

    -- удаляем разбивку матрицы
    /*
      for c in (select *
                  from wcs_scoring_qs_matrix_numb sqmn
                 where sqmn.scoring_id = scoring_id_
                   and sqmn.question_id = question_id_) loop
        wcs_pack.scor_quest_mtx_numb_del(c.scoring_id,
                                         c.question_id,
                                         c.axis_qid,
                                         c.ord);
      end loop;

      for c in (select *
                  from wcs_scoring_qs_matrix_decimal sqmd
                 where sqmd.scoring_id = scoring_id_
                   and sqmd.question_id = question_id_) loop
        wcs_pack.scor_quest_mtx_dec_del(c.scoring_id,
                                        c.question_id,
                                        c.axis_qid,
                                        c.ord);
      end loop;

      for c in (select *
                  from wcs_scoring_qs_matrix_date sqmd
                 where sqmd.scoring_id = scoring_id_
                   and sqmd.question_id = question_id_) loop
        wcs_pack.scor_quest_mtx_dat_del(c.scoring_id,
                                        c.question_id,
                                        c.axis_qid,
                                        c.ord);
      end loop;

      for c in (select *
                  from wcs_scoring_qs_matrix sqm
                 where sqm.scoring_id = scoring_id_
                   and sqm.question_id = question_id_) loop
        wcs_pack.scor_quest_mtx_del(c.scoring_id,
                                    c.question_id,
                                    c.axis0_ord,
                                    c.axis1_ord,
                                    c.axis2_ord,
                                    c.axis3_ord,
                                    c.axis4_ord);
      end loop;
    */

    for c in (select *
                from wcs_scoring_qs_bool sqb
               where sqb.scoring_id = scoring_id_
                 and sqb.question_id = question_id_) loop
      wcs_pack.scor_quest_bool_del(c.scoring_id, c.question_id);
    end loop;

    -- удаляем вопрос из скор. карты
    delete from wcs_scoring_questions t
     where t.scoring_id = scoring_id_
       and t.question_id = question_id_;
  end scor_quest_del;

  -- Создает/обновляет вопрос карты скоринга (бальность по вопросам типа NUMB)
  procedure scor_quest_numb_set(p_scoring_id  wcs_scoring_qs_numb.scoring_id%type, -- Идентификатор карты скоринга
                                p_question_id wcs_scoring_qs_numb.question_id%type, -- Идентификатор вопроса
                                p_ord         wcs_scoring_qs_numb.ord%type, -- Номер отрезка
                                p_min_val     wcs_scoring_qs_numb.min_val%type, -- Мин. значение отрезка
                                p_min_sign    wcs_scoring_qs_numb.min_sign%type, -- Знак мин. значения отрезка
                                p_max_val     wcs_scoring_qs_numb.max_val%type, -- Макс. значение отрезка
                                p_max_sign    wcs_scoring_qs_numb.max_sign%type, -- Знак макс. значения отрезка
                                p_score       wcs_scoring_qs_numb.score%type -- Баллы
                                ) is
    l_ord  number;
    l_type wcs_questions.type_id%type;
  begin
    -- проверяем тип вопроса
    select q.type_id
      into l_type
      from wcs_questions q
     where q.id = p_question_id;
    if (l_type <> 'NUMB') then
      return;
    end if;

    -- порядок отображения
    select nvl(max(sqn.ord), -1) + 1
      into l_ord
      from wcs_scoring_qs_numb sqn
     where sqn.scoring_id = p_scoring_id
       and sqn.question_id = p_question_id;

    -- обновляем или вставляем
    update wcs_scoring_qs_numb sqn
       set sqn.min_val  = p_min_val,
           sqn.min_sign = p_min_sign,
           sqn.max_val  = p_max_val,
           sqn.max_sign = p_max_sign,
           sqn.score    = p_score
     where sqn.scoring_id = p_scoring_id
       and sqn.question_id = p_question_id
       and sqn.ord = p_ord;

    if (sql%rowcount = 0) then
      insert into wcs_scoring_qs_numb
        (scoring_id,
         question_id,
         ord,
         min_val,
         min_sign,
         max_val,
         max_sign,
         score)
      values
        (p_scoring_id,
         p_question_id,
         l_ord,
         p_min_val,
         p_min_sign,
         p_max_val,
         p_max_sign,
         p_score);
    end if;
  end scor_quest_numb_set;

  -- Удаляет вопрос карты скоринга (бальность по вопросам типа NUMB)
  procedure scor_quest_numb_del(p_scoring_id  wcs_scoring_qs_numb.scoring_id%type, -- Идентификатор карты скоринга
                                p_question_id wcs_scoring_qs_numb.question_id%type, -- Идентификатор вопроса
                                p_ord         wcs_scoring_qs_numb.ord%type -- Номер отрезка
                                ) is
  begin
    delete from wcs_scoring_qs_numb sqn
     where sqn.scoring_id = p_scoring_id
       and sqn.question_id = p_question_id
       and sqn.ord = p_ord;
  end scor_quest_numb_del;

  -- Создает/обновляет карты скоринга (бальность по вопросам типа NUMB)
  procedure scor_quest_numb_move(p_scoring_id  wcs_scoring_qs_numb.scoring_id%type, -- Идентификатор карты скоринга
                                 p_question_id wcs_scoring_qs_numb.question_id%type, -- Идентификатор вопроса
                                 p_src_ord     wcs_scoring_qs_numb.ord%type, -- Номер отрезка источника
                                 p_dest_ord    wcs_scoring_qs_numb.ord%type -- Номер отрезка назначения
                                 ) is
    l_src  wcs_scoring_qs_numb%rowtype;
    l_dest wcs_scoring_qs_numb%rowtype;
  begin
    select sqn.*
      into l_src
      from wcs_scoring_qs_numb sqn
     where sqn.scoring_id = p_scoring_id
       and sqn.question_id = p_question_id
       and sqn.ord = p_src_ord;
    select sqn.*
      into l_dest
      from wcs_scoring_qs_numb sqn
     where sqn.scoring_id = p_scoring_id
       and sqn.question_id = p_question_id
       and sqn.ord = p_dest_ord;

    update wcs_scoring_qs_numb sqn
       set sqn.min_val  = l_dest.min_val,
           sqn.min_sign = l_dest.min_sign,
           sqn.max_val  = l_dest.max_val,
           sqn.max_sign = l_dest.max_sign,
           sqn.score    = l_dest.score
     where sqn.scoring_id = p_scoring_id
       and sqn.question_id = p_question_id
       and sqn.ord = p_src_ord;

    update wcs_scoring_qs_numb sqn
       set sqn.min_val  = l_src.min_val,
           sqn.min_sign = l_src.min_sign,
           sqn.max_val  = l_src.max_val,
           sqn.max_sign = l_src.max_sign,
           sqn.score    = l_src.score
     where sqn.scoring_id = p_scoring_id
       and sqn.question_id = p_question_id
       and sqn.ord = p_dest_ord;
  exception
    when no_data_found then
      null;
  end scor_quest_numb_move;

  -- Создает/обновляет вопрос карты скоринга (бальность по вопросам типа DECIMAL)
  procedure scor_quest_decimal_set(p_scoring_id  wcs_scoring_qs_decimal.scoring_id%type, -- Идентификатор карты скоринга
                                   p_question_id wcs_scoring_qs_decimal.question_id%type, -- Идентификатор вопроса
                                   p_ord         wcs_scoring_qs_decimal.ord%type, -- Номер отрезка
                                   p_min_val     wcs_scoring_qs_decimal.min_val%type, -- Мин. значение отрезка
                                   p_min_sign    wcs_scoring_qs_decimal.min_sign%type, -- Знак мин. значения отрезка
                                   p_max_val     wcs_scoring_qs_decimal.max_val%type, -- Макс. значение отрезка
                                   p_max_sign    wcs_scoring_qs_decimal.max_sign%type, -- Знак макс. значения отрезка
                                   p_score       wcs_scoring_qs_decimal.score%type -- Баллы
                                   ) is
    l_ord  number;
    l_type wcs_questions.type_id%type;
  begin
    -- проверяем тип вопроса
    select q.type_id
      into l_type
      from wcs_questions q
     where q.id = p_question_id;
    if (l_type <> 'DECIMAL') then
      return;
    end if;

    -- порядок отображения
    select nvl(max(sqd.ord), -1) + 1
      into l_ord
      from wcs_scoring_qs_decimal sqd
     where sqd.scoring_id = p_scoring_id
       and sqd.question_id = p_question_id;

    -- обновляем или вставляем
    update wcs_scoring_qs_decimal sqd
       set sqd.min_val  = p_min_val,
           sqd.min_sign = p_min_sign,
           sqd.max_val  = p_max_val,
           sqd.max_sign = p_max_sign,
           sqd.score    = p_score
     where sqd.scoring_id = p_scoring_id
       and sqd.question_id = p_question_id
       and sqd.ord = p_ord;

    if (sql%rowcount = 0) then
      insert into wcs_scoring_qs_decimal
        (scoring_id,
         question_id,
         ord,
         min_val,
         min_sign,
         max_val,
         max_sign,
         score)
      values
        (p_scoring_id,
         p_question_id,
         l_ord,
         p_min_val,
         p_min_sign,
         p_max_val,
         p_max_sign,
         p_score);
    end if;
  end scor_quest_decimal_set;

  -- Удаляет вопрос карты скоринга (бальность по вопросам типа DECIMAL)
  procedure scor_quest_decimal_del(p_scoring_id  wcs_scoring_qs_decimal.scoring_id%type, -- Идентификатор карты скоринга
                                   p_question_id wcs_scoring_qs_decimal.question_id%type, -- Идентификатор вопроса
                                   p_ord         wcs_scoring_qs_decimal.ord%type -- Номер отрезка
                                   ) is
  begin
    delete from wcs_scoring_qs_decimal sqd
     where sqd.scoring_id = p_scoring_id
       and sqd.question_id = p_question_id
       and sqd.ord = p_ord;
  end scor_quest_decimal_del;

  -- Создает/обновляет вопрос карты скоринга (бальность по вопросам типа DATE)
  procedure scor_quest_date_set(p_scoring_id  wcs_scoring_qs_date.scoring_id%type, -- Идентификатор карты скоринга
                                p_question_id wcs_scoring_qs_date.question_id%type, -- Идентификатор вопроса
                                p_ord         wcs_scoring_qs_date.ord%type, -- Номер отрезка
                                p_min_val     wcs_scoring_qs_date.min_val%type, -- Мин. значение отрезка
                                p_min_sign    wcs_scoring_qs_date.min_sign%type, -- Знак мин. значения отрезка
                                p_max_val     wcs_scoring_qs_date.max_val%type, -- Макс. значение отрезка
                                p_max_sign    wcs_scoring_qs_date.max_sign%type, -- Знак макс. значения отрезка
                                p_score       wcs_scoring_qs_date.score%type -- Баллы
                                ) is
    l_ord  number;
    l_type wcs_questions.type_id%type;
  begin
    -- проверяем тип вопроса
    select q.type_id
      into l_type
      from wcs_questions q
     where q.id = p_question_id;
    if (l_type <> 'DATE') then
      return;
    end if;

    -- порядок отображения
    select nvl(max(sqd.ord), -1) + 1
      into l_ord
      from wcs_scoring_qs_date sqd
     where sqd.scoring_id = p_scoring_id
       and sqd.question_id = p_question_id;

    -- обновляем или вставляем
    update wcs_scoring_qs_date sqd
       set sqd.min_val  = p_min_val,
           sqd.min_sign = p_min_sign,
           sqd.max_val  = p_max_val,
           sqd.max_sign = p_max_sign,
           sqd.score    = p_score
     where sqd.scoring_id = p_scoring_id
       and sqd.question_id = p_question_id
       and sqd.ord = p_ord;

    if (sql%rowcount = 0) then
      insert into wcs_scoring_qs_date
        (scoring_id,
         question_id,
         ord,
         min_val,
         min_sign,
         max_val,
         max_sign,
         score)
      values
        (p_scoring_id,
         p_question_id,
         l_ord,
         p_min_val,
         p_min_sign,
         p_max_val,
         p_max_sign,
         p_score);
    end if;
  end scor_quest_date_set;

  -- Удаляет вопрос карты скоринга (бальность по вопросам типа DATE)
  procedure scor_quest_date_del(p_scoring_id  wcs_scoring_qs_date.scoring_id%type, -- Идентификатор карты скоринга
                                p_question_id wcs_scoring_qs_date.question_id%type, -- Идентификатор вопроса
                                p_ord         wcs_scoring_qs_date.ord%type -- Номер отрезка
                                ) is
  begin
    delete from wcs_scoring_qs_date sqd
     where sqd.scoring_id = p_scoring_id
       and sqd.question_id = p_question_id
       and sqd.ord = p_ord;
  end scor_quest_date_del;

  -- Создает/обновляет вопрос карты скоринга (бальность по вопросам типа LIST)
  procedure scor_quest_list_set(p_scoring_id  wcs_scoring_qs_list.scoring_id%type, -- Идентификатор карты скоринга
                                p_question_id wcs_scoring_qs_list.question_id%type, -- Идентификатор вопроса
                                p_ord         wcs_scoring_qs_list.ord%type, -- Номер отрезка
                                p_score       wcs_scoring_qs_list.score%type -- Баллы
                                ) is
    l_type wcs_questions.type_id%type;
  begin
    -- проверяем тип вопроса
    select q.type_id
      into l_type
      from wcs_questions q
     where q.id = p_question_id;
    if (l_type <> 'LIST') then
      return;
    end if;

    -- обновляем или вставляем
    update wcs_scoring_qs_list sl
       set sl.score = p_score
     where sl.scoring_id = p_scoring_id
       and sl.question_id = p_question_id
       and sl.ord = p_ord;

    if (sql%rowcount = 0) then
      insert into wcs_scoring_qs_list
        (scoring_id, question_id, ord, score)
      values
        (p_scoring_id, p_question_id, p_ord, p_score);
    end if;
  end scor_quest_list_set;

  -- Удаляет вопрос карты скоринга (бальность по вопросам типа LIST)
  procedure scor_quest_list_del(p_scoring_id  wcs_scoring_qs_list.scoring_id%type, -- Идентификатор карты скоринга
                                p_question_id wcs_scoring_qs_list.question_id%type, -- Идентификатор вопроса
                                p_ord         wcs_scoring_qs_list.ord%type -- Номер отрезка
                                ) is
  begin
    delete from wcs_scoring_qs_list sl
     where sl.scoring_id = p_scoring_id
       and sl.question_id = p_question_id
       and sl.ord = p_ord;
  end scor_quest_list_del;

  /*
    -- Создает/обновляет вопрос карты скоринга типа MATRIX (бальность по оси типа NUMB)
    procedure scor_quest_mtx_numb_set(scoring_id_  varchar2, -- Идентификатор карты скоринга
                                      question_id_ varchar2, -- Идентификатор вопроса
                                      axis_qid_    varchar2, -- Идентификатор вопроса-оси матрицы
                                      min_val_     number, -- Мин. значение отрезка
                                      min_sign_    varchar2, -- Знак мин. значения отрезка
                                      max_val_     number, -- Макс. значение отрезка
                                      max_sign_    varchar2, -- Знак макс. значения отрезка
                                      ord_         number default null -- Номер отрезка
                                      ) is
      l_ord_  number;
      l_type_ wcs_questions.type_id%type;
    begin
      -- проверяем тип вопроса
      select t.type_id
        into l_type_
        from wcs_questions t
       where t.id = axis_qid_;
      if (l_type_ <> 'NUMB') then
        return;
      end if;

      -- порядок отображения
      l_ord_ := ord_;
      if (l_ord_ is null) then
        select nvl(max(ord), -1) + 1
          into l_ord_
          from wcs_scoring_qs_matrix_numb t
         where t.scoring_id = scoring_id_
           and t.question_id = question_id_
           and t.axis_qid = axis_qid_;
      end if;

      -- обновляем или вставляем
      update wcs_scoring_qs_matrix_numb t
         set t.min_val  = min_val_,
             t.min_sign = min_sign_,
             t.max_val  = max_val_,
             t.max_sign = max_sign_
       where t.scoring_id = scoring_id_
         and t.question_id = question_id_
         and t.axis_qid = axis_qid_
         and t.ord = l_ord_;

      if (sql%rowcount = 0) then
        insert into wcs_scoring_qs_matrix_numb
          (scoring_id,
           question_id,
           axis_qid,
           min_val,
           min_sign,
           max_val,
           max_sign,
           ord)
        values
          (scoring_id_,
           question_id_,
           axis_qid_,
           min_val_,
           min_sign_,
           max_val_,
           max_sign_,
           l_ord_);
      end if;
    end scor_quest_mtx_numb_set;

    -- Удаляет вопрос карты скоринга типа MATRIX (бальность по оси типа NUMB)
    procedure scor_quest_mtx_numb_del(scoring_id_  varchar2, -- Идентификатор карты скоринга
                                      question_id_ varchar2, -- Идентификатор вопроса
                                      axis_qid_    varchar2, -- Идентификатор вопроса-оси матрицы
                                      ord_         number -- Номер отрезка
                                      ) is
    begin
      delete from wcs_scoring_qs_matrix_numb t
       where t.scoring_id = scoring_id_
         and t.question_id = question_id_
         and t.axis_qid = axis_qid_
         and t.ord = ord_;
    end scor_quest_mtx_numb_del;

    -- Создает/обновляет вопрос карты скоринга типа MATRIX (бальность по оси типа DECIMAL)
    procedure scor_quest_mtx_dec_set(scoring_id_  varchar2, -- Идентификатор карты скоринга
                                     question_id_ varchar2, -- Идентификатор вопроса
                                     axis_qid_    varchar2, -- Идентификатор вопроса-оси матрицы
                                     min_val_     number, -- Мин. значение отрезка
                                     min_sign_    varchar2, -- Знак мин. значения отрезка
                                     max_val_     number, -- Макс. значение отрезка
                                     max_sign_    varchar2, -- Знак макс. значения отрезка
                                     ord_         number default null -- Номер отрезка
                                     ) is
      l_ord_  number;
      l_type_ wcs_questions.type_id%type;
    begin
      -- проверяем тип вопроса
      select t.type_id
        into l_type_
        from wcs_questions t
       where t.id = axis_qid_;
      if (l_type_ <> 'DECIMAL') then
        return;
      end if;

      -- порядок отображения
      l_ord_ := ord_;
      if (l_ord_ is null) then
        select nvl(max(ord), -1) + 1
          into l_ord_
          from wcs_scoring_qs_matrix_decimal t
         where t.scoring_id = scoring_id_
           and t.question_id = question_id_
           and t.axis_qid = axis_qid_;
      end if;

      -- обновляем или вставляем
      update wcs_scoring_qs_matrix_decimal t
         set t.min_val  = min_val_,
             t.min_sign = min_sign_,
             t.max_val  = max_val_,
             t.max_sign = max_sign_
       where t.scoring_id = scoring_id_
         and t.question_id = question_id_
         and t.axis_qid = axis_qid_
         and t.ord = l_ord_;

      if (sql%rowcount = 0) then
        insert into wcs_scoring_qs_matrix_decimal
          (scoring_id,
           question_id,
           axis_qid,
           min_val,
           min_sign,
           max_val,
           max_sign,
           ord)
        values
          (scoring_id_,
           question_id_,
           axis_qid_,
           min_val_,
           min_sign_,
           max_val_,
           max_sign_,
           l_ord_);
      end if;
    end scor_quest_mtx_dec_set;

    -- Удаляет вопрос карты скоринга типа MATRIX (бальность по оси типа DECIMAL)
    procedure scor_quest_mtx_dec_del(scoring_id_  varchar2, -- Идентификатор карты скоринга
                                     question_id_ varchar2, -- Идентификатор вопроса
                                     axis_qid_    varchar2, -- Идентификатор вопроса-оси матрицы
                                     ord_         number -- Номер отрезка
                                     ) is
    begin
      delete from wcs_scoring_qs_matrix_decimal t
       where t.scoring_id = scoring_id_
         and t.question_id = question_id_
         and t.axis_qid = axis_qid_
         and t.ord = ord_;
    end scor_quest_mtx_dec_del;

    -- Создает/обновляет вопрос карты скоринга типа MATRIX (бальность по оси типа DATE)
    procedure scor_quest_mtx_dat_set(scoring_id_  varchar2, -- Идентификатор карты скоринга
                                     question_id_ varchar2, -- Идентификатор вопроса
                                     axis_qid_    varchar2, -- Идентификатор вопроса-оси матрицы
                                     min_val_     date, -- Мин. значение отрезка
                                     min_sign_    varchar2, -- Знак мин. значения отрезка
                                     max_val_     date, -- Макс. значение отрезка
                                     max_sign_    varchar2, -- Знак макс. значения отрезка
                                     ord_         number default null -- Номер отрезка
                                     ) is
      l_ord_  number;
      l_type_ wcs_questions.type_id%type;
    begin
      -- проверяем тип вопроса
      select t.type_id
        into l_type_
        from wcs_questions t
       where t.id = axis_qid_;
      if (l_type_ <> 'DATE') then
        return;
      end if;

      -- порядок отображения
      l_ord_ := ord_;
      if (l_ord_ is null) then
        select nvl(max(ord), -1) + 1
          into l_ord_
          from wcs_scoring_qs_matrix_date t
         where t.scoring_id = scoring_id_
           and t.question_id = question_id_
           and t.axis_qid = axis_qid_;
      end if;

      -- обновляем или вставляем
      update wcs_scoring_qs_matrix_date t
         set t.min_val  = min_val_,
             t.min_sign = min_sign_,
             t.max_val  = max_val_,
             t.max_sign = max_sign_
       where t.scoring_id = scoring_id_
         and t.question_id = question_id_
         and t.axis_qid = axis_qid_
         and t.ord = l_ord_;

      if (sql%rowcount = 0) then
        insert into wcs_scoring_qs_matrix_date
          (scoring_id,
           question_id,
           axis_qid,
           min_val,
           min_sign,
           max_val,
           max_sign,
           ord)
        values
          (scoring_id_,
           question_id_,
           axis_qid_,
           min_val_,
           min_sign_,
           max_val_,
           max_sign_,
           l_ord_);
      end if;
    end scor_quest_mtx_dat_set;

    -- Удаляет вопрос карты скоринга типа MATRIX (бальность по оси типа DATE)
    procedure scor_quest_mtx_dat_del(scoring_id_  varchar2, -- Идентификатор карты скоринга
                                     question_id_ varchar2, -- Идентификатор вопроса
                                     axis_qid_    varchar2, -- Идентификатор вопроса-оси матрицы
                                     ord_         number -- Номер отрезка
                                     ) is
    begin
      delete from wcs_scoring_qs_matrix_date t
       where t.scoring_id = scoring_id_
         and t.question_id = question_id_
         and t.axis_qid = axis_qid_
         and t.ord = ord_;
    end scor_quest_mtx_dat_del;

    -- Создает/обновляет вопрос карты скоринга (бальность по вопросам типа MATRIX)
    procedure scor_quest_mtx_set(scoring_id_  varchar2, -- Идентификатор карты скоринга
                                 question_id_ varchar2, -- Идентификатор вопроса
                                 score_       number, -- Баллы
                                 axis0_ord_   number, -- Номер ответа по оси 0
                                 axis1_ord_   number, -- Номер ответа по оси 1
                                 axis2_ord_   number default null, -- Номер ответа по оси 2
                                 axis3_ord_   number default null, -- Номер ответа по оси 3
                                 axis4_ord_   number default null -- Номер ответа по оси 4
                                 ) is
      l_type_ wcs_questions.type_id%type;
    begin
      -- проверяем тип вопроса
      select t.type_id
        into l_type_
        from wcs_questions t
       where t.id = question_id_;
      if (l_type_ <> 'MATRIX') then
        return;
      end if;

      -- обновляем или вставляем
      update wcs_scoring_qs_matrix t
         set t.score = score_
       where t.scoring_id = scoring_id_
         and t.question_id = question_id_
         and t.axis0_ord = axis0_ord_
         and t.axis1_ord = axis1_ord_
         and (t.axis2_ord = axis2_ord_ or
             (t.axis2_ord is null and axis2_ord_ is null))
         and (t.axis3_ord = axis3_ord_ or
             (t.axis3_ord is null and axis3_ord_ is null))
         and (t.axis4_ord = axis4_ord_ or
             (t.axis4_ord is null and axis4_ord_ is null));

      if (sql%rowcount = 0) then
        insert into wcs_scoring_qs_matrix
          (scoring_id,
           question_id,
           score,
           axis0_ord,
           axis1_ord,
           axis2_ord,
           axis3_ord,
           axis4_ord)
        values
          (scoring_id_,
           question_id_,
           score_,
           axis0_ord_,
           axis1_ord_,
           axis2_ord_,
           axis3_ord_,
           axis4_ord_);
      end if;
    end scor_quest_mtx_set;

    -- Удаляет вопрос карты скоринга (бальность по вопросам типа MATRIX)
    procedure scor_quest_mtx_del(scoring_id_  varchar2, -- Идентификатор карты скоринга
                                 question_id_ varchar2, -- Идентификатор вопроса
                                 axis0_ord_   number, -- Номер ответа по оси 0
                                 axis1_ord_   number, -- Номер ответа по оси 1
                                 axis2_ord_   number default null, -- Номер ответа по оси 2
                                 axis3_ord_   number default null, -- Номер ответа по оси 3
                                 axis4_ord_   number default null -- Номер ответа по оси 4
                                 ) is
    begin
      -- удаляем вопрос из скор. карты
      delete from wcs_scoring_qs_matrix t
       where t.scoring_id = scoring_id_
         and t.question_id = question_id_
         and t.axis0_ord = axis0_ord_
         and t.axis1_ord = axis1_ord_
         and (t.axis2_ord = axis2_ord_ or
             (t.axis2_ord is null and axis2_ord_ is null))
         and (t.axis3_ord = axis3_ord_ or
             (t.axis3_ord is null and axis3_ord_ is null))
         and (t.axis4_ord = axis4_ord_ or
             (t.axis4_ord is null and axis4_ord_ is null));
    end scor_quest_mtx_del;
  */

  -- Создает/обновляет вопрос карты скоринга (бальность по вопросам типа BOOL)
  procedure scor_quest_bool_set(p_scoring_id  wcs_scoring_qs_bool.scoring_id%type, -- Идентификатор карты скоринга
                                p_question_id wcs_scoring_qs_bool.question_id%type, -- Идентификатор вопроса
                                p_score_if_0  wcs_scoring_qs_bool.score_if_0%type, -- Баллы за ответ нет (0)
                                p_score_if_1  wcs_scoring_qs_bool.score_if_1%type -- Баллы за ответ да (1)
                                ) is
    l_type wcs_questions.type_id%type;
  begin
    -- проверяем тип вопроса
    select t.type_id
      into l_type
      from wcs_questions t
     where t.id = p_question_id;
    if (l_type <> 'BOOL') then
      return;
    end if;

    -- обновляем или вставляем
    update wcs_scoring_qs_bool sqb
       set sqb.score_if_0 = p_score_if_0, sqb.score_if_1 = p_score_if_1
     where sqb.scoring_id = p_scoring_id
       and sqb.question_id = p_question_id;

    if (sql%rowcount = 0) then
      insert into wcs_scoring_qs_bool
        (scoring_id, question_id, score_if_0, score_if_1)
      values
        (p_scoring_id, p_question_id, p_score_if_0, p_score_if_1);
    end if;
  end scor_quest_bool_set;

  -- Удаляет вопрос карты скоринга (бальность по вопросам типа BOOL)
  procedure scor_quest_bool_del(p_scoring_id  wcs_scoring_qs_bool.scoring_id%type, -- Идентификатор карты скоринга
                                p_question_id wcs_scoring_qs_bool.question_id%type -- Идентификатор вопроса
                                ) is
  begin
    delete from wcs_scoring_qs_bool sqb
     where sqb.scoring_id = p_scoring_id
       and sqb.question_id = p_question_id;
  end scor_quest_bool_del;

  -- Создает/обновляет карту скоринга субпродукта
  procedure sbprod_scor_set(subproduct_id_ varchar2, -- Идентификатор субпродукта
                            scoring_id_    varchar2 -- Идентификатор карты скоринга
                            ) is
  begin
    -- обновляем или вставляем
    update wcs_subproduct_scoring t
       set t.scoring_id = scoring_id_
     where t.subproduct_id = subproduct_id_;

    if (sql%rowcount = 0) then
      insert into wcs_subproduct_scoring
        (subproduct_id, scoring_id)
      values
        (subproduct_id_, scoring_id_);
    end if;
  end sbprod_scor_set;

  -- Удаляет карту скоринга субпродукта
  procedure sbprod_scor_del(subproduct_id_ varchar2 -- Идентификатор субпродукта
                            ) is
  begin
    delete from wcs_subproduct_scoring t
     where t.subproduct_id = subproduct_id_;
  end sbprod_scor_del;

  -- Клонирует карту скоринга субпродукта
  procedure sbp_scor_clone(p_subproduct_id     wcs_subproducts.id%type, -- Идентификатор субпродукта
                           p_src_subproduct_id wcs_subproducts.id%type -- Идентификатор субпродукта
                           ) is
  begin
    for cur in (select *
                  from v_wcs_subproduct_scoring ss
                 where ss.subproduct_id = p_src_subproduct_id) loop
      sbprod_scor_set(p_subproduct_id, cur.scoring_id);
    end loop;
  end sbp_scor_clone;
  -- ---------------------- Карты скоринга ----------------------------

  -- ------------------ Карты кредитоспособности ----------------------
  -- Создает/обновляет карту кредитоспособности
  procedure solv_set(p_solvency_id varchar2, -- Идентификатор карты кредитоспособности
                     p_name        varchar2 -- Наименование
                     ) is
  begin
    -- обновляем или вставляем
    update wcs_solvencies s set s.name = p_name where s.id = p_solvency_id;

    if (sql%rowcount = 0) then
      insert into wcs_solvencies (id, name) values (p_solvency_id, p_name);
    end if;
  end solv_set;

  -- Удаляет карту кредитоспособности
  procedure solv_del(p_solvency_id varchar2 -- Идентификатор карты кредитоспособности
                     ) is
  begin
    delete from wcs_solvencies s where s.id = p_solvency_id;
  end solv_del;

  -- Клонирует карту кредитоспособности
  procedure solv_clone(p_solvency_id     wcs_solvencies.id%type, -- Идентификатор карты кредитоспособности
                       p_src_solvency_id wcs_solvencies.id%type -- Идентификатор карты кредитоспособности - источника
                       ) is
  begin
    for cur in (select *
                  from v_wcs_solvency_questions sq
                 where sq.solvency_id = p_src_solvency_id) loop
      solv_quest_set(p_solvency_id, cur.question_id);
    end loop;
  end solv_clone;

  -- Создает/обновляет вопрос карты кредитоспособности
  procedure solv_quest_set(p_solvency_id varchar2, -- Идентификатор карты кредитоспособности
                           p_question_id varchar2 -- Идентификатор вопроса
                           ) is
    l_type wcs_questions.type_id%type;
  begin
    -- обновляем или вставляем
    insert into wcs_solvency_questions
      (solvency_id, question_id)
    values
      (p_solvency_id, p_question_id);
  exception
    when dup_val_on_index then
      null;
  end solv_quest_set;

  -- Удаляет вопрос карты кредитоспособности
  procedure solv_quest_del(p_solvency_id varchar2, -- Идентификатор карты кредитоспособности
                           p_question_id varchar2 -- Идентификатор вопроса
                           ) is
  begin
    -- удаляем вопрос из карты кредитоспособности
    delete from wcs_solvency_questions sq
     where sq.solvency_id = p_solvency_id
       and sq.question_id = p_question_id;
  end solv_quest_del;

  -- Создает/обновляет карту кредитоспособности субпродукта
  procedure sbprod_solv_set(p_subproduct_id varchar2, -- Идентификатор субпродукта
                            p_solvency_id   varchar2 -- Идентификатор карты кредитоспособности
                            ) is
  begin
    -- обновляем или вставляем
    update wcs_subproduct_solvency ss
       set ss.solv_id = p_solvency_id
     where ss.subproduct_id = p_subproduct_id;

    if (sql%rowcount = 0) then
      insert into wcs_subproduct_solvency
        (subproduct_id, solv_id)
      values
        (p_subproduct_id, p_solvency_id);
    end if;
  end sbprod_solv_set;

  -- Удаляет карту кредитоспособности субпродукта
  procedure sbprod_solv_del(p_subproduct_id varchar2 -- Идентификатор субпродукта
                            ) is
  begin
    delete from wcs_subproduct_solvency ss
     where ss.subproduct_id = p_subproduct_id;
  end sbprod_solv_del;

  -- Клонирует карту кредитоспособности субпродукта
  procedure sbp_solv_clone(p_subproduct_id     wcs_subproducts.id%type, -- Идентификатор субпродукта
                           p_src_subproduct_id wcs_subproducts.id%type -- Идентификатор субпродукта
                           ) is
  begin
    for cur in (select *
                  from v_wcs_subproduct_solvency ss
                 where ss.subproduct_id = p_src_subproduct_id) loop
      sbprod_solv_set(p_subproduct_id, cur.solv_id);
    end loop;
  end sbp_solv_clone;
  -- ------------------ Карты кредитоспособности ----------------------

  /*
    -- ------------------------------- Дополнительные услуги --------------------------------------
    -- Создает/обновляет доп услугу
    procedure addservice_set(addservice_id_ varchar2, -- Идентификатор доп услуги
                             name_          varchar2, -- Наименование
                             descr_         varchar2, -- Описание (может включать элементы HTML)
                             insu_acc_      number, -- Накопительный счет для перечисления средств в пользу СК
                             sum_min_       number, -- Минимальная комиссия
                             sum_percent_   number, -- Комиссия процентная
                             sum_max_       number, -- Максимальная комиссия
                             calc_type_     varchar2, -- Идентификатор типа расчета суммы доп услуги
                             doc_scheme_id_ varchar2 -- Идентификатор шаблона договора
                             ) is
      l_result_qid varchar2(100);
      l_scan_qid   varchar2(100);
    begin
      -- добавляем вопрос результата
      l_result_qid := addservice_id_ || g_addservice_result_prefix;
      wcs_pack.quest_set(l_result_qid,
                         addservice_id_ || ' additional service chose result',
                         'BOOL',
                         0,
                         null);

      -- добавляем вопрос результат сканирования
      l_scan_qid := addservice_id_ || g_addservice_scan_prefix;
      wcs_pack.quest_set(l_scan_qid,
                         addservice_id_ ||
                         ' additional service doc scan result',
                         'FILE',
                         0,
                         null);

      -- обновляем или вставляем
      update wcs_additional_services t
         set t.name          = name_,
             t.descr         = descr_,
             t.insu_acc      = insu_acc_,
             t.sum_min       = sum_min_,
             t.sum_percent   = sum_percent_,
             t.sum_max       = sum_max_,
             t.calc_type     = calc_type_,
             t.doc_scheme_id = doc_scheme_id_,
             t.result_qid    = l_result_qid,
             t.scan_qid      = l_scan_qid
       where t.id = addservice_id_;

      if (sql%rowcount = 0) then
        insert into wcs_additional_services
          (id,
           name,
           descr,
           insu_acc,
           sum_min,
           sum_percent,
           sum_max,
           calc_type,
           doc_scheme_id,
           result_qid,
           scan_qid)
        values
          (addservice_id_,
           name_,
           descr_,
           insu_acc_,
           sum_min_,
           sum_percent_,
           sum_max_,
           calc_type_,
           doc_scheme_id_,
           l_result_qid,
           l_scan_qid);
      end if;
    end addservice_set;

    -- Удаляет доп услугу
    procedure addservice_del(addservice_id_ varchar2 -- Идентификатор продукта
                             ) is
    begin
      -- удаляем
      delete from wcs_additional_services t where t.id = addservice_id_;
    end addservice_del;

    -- Создает/обновляет карту доп услуг суб-продукта
    procedure sbprod_addservice_set(subproduct_id_ varchar2, -- Идентификатор субпродукта
                                    addservice_id_ varchar2 -- Идентификатор доп услуги
                                    ) is
    begin
      -- обновляем или вставляем
      update wcs_subproduct_addservices t
         set t.addservice_id = addservice_id_
       where t.subproduct_id = subproduct_id_
         and t.addservice_id = addservice_id_;

      if (sql%rowcount = 0) then
        insert into wcs_subproduct_addservices
          (subproduct_id, addservice_id)
        values
          (subproduct_id_, addservice_id_);
      end if;
    end sbprod_addservice_set;

    -- Удаляет карту доп услуг суб-продукта
    procedure sbprod_addservice_del(subproduct_id_ varchar2, -- Идентификатор субпродукта
                                    addservice_id_ varchar2 -- Идентификатор доп услуги
                                    ) is
    begin
      -- удаляем
      delete from wcs_subproduct_addservices t
       where t.subproduct_id = subproduct_id_
         and t.addservice_id = addservice_id_;
    end sbprod_addservice_del;
    -- ------------------------------- Дополнительные услуги --------------------------------------
  */

  /*
  TODO: owner="tvSukhov" created="14.02.2011"
  text="Добавить процедуры для работы с партнером"
  */

  /*
    -- ------------------------- Торговцы партнеры --------------------------------------
    -- Создает/обновляет торговца партнера
    procedure partner_set(partner_id_      varchar2, -- Идентификатор торговца партнера
                          name_            varchar2, -- Наименование торговца партнера
                          type_id_         varchar2, -- Тип партнера
                          ext_bank_acc_id_ number, -- Внешний счет для обслуживания партнера
                          nls_com_         varchar2, -- NLS счета отложеной комиссии
                          ptn_mfo_         varchar2, -- МФО банка партнера
                          ptn_nls_         varchar2, -- Счет партнера
                          ptn_okpo_        varchar2, -- Идент. код партнера
                          ptn_name_        varchar2, -- Наименование партнера
                          doc_scheme_id_   varchar2 -- Идентификатор шаблона договора
                          ) is
      l_card_no_qid varchar2(100);
      l_result_qid  varchar2(100);
      l_scan_qid    varchar2(100);
    begin
      -- добавляем вопрос результата
      l_result_qid := partner_id_ || g_partner_result_prefix;
      wcs_pack.quest_set(l_result_qid,
                         partner_id_ || ' partner chose result',
                         'BOOL',
                         0,
                         null);

      -- добавляем вопрос результат сканирования
      l_scan_qid := partner_id_ || g_partner_scan_prefix;
      wcs_pack.quest_set(l_scan_qid,
                         partner_id_ || ' partner doc scan result',
                         'FILE',
                         0,
                         null);

      -- создаем вопрос для заполнения номера карточки
      if (type_id_ = 'CARD') then
        l_card_no_qid := partner_id_ || g_card_no_qid_prefix;
        wcs_pack.quest_set(l_card_no_qid,
                           partner_id_ || ' card no storage',
                           'TEXT',
                           0,
                           null);
      end if;

      -- обновляем или вставляем
      update wcs_partners t
         set t.name            = name_,
             t.type_id         = type_id_,
             t.ext_bank_acc_id = ext_bank_acc_id_,
             t.nls_com         = nls_com_,
             t.ptn_mfo         = ptn_mfo_,
             t.ptn_nls         = ptn_nls_,
             t.ptn_okpo        = ptn_okpo_,
             t.ptn_name        = ptn_name_,
             t.card_no_qid     = l_card_no_qid,
             t.result_qid      = l_result_qid,
             t.doc_scheme_id   = doc_scheme_id_,
             t.scan_qid        = l_scan_qid
       where t.id = partner_id_;

      if (sql%rowcount = 0) then
        insert into wcs_partners
          (id,
           name,
           type_id,
           ext_bank_acc_id,
           nls_com,
           ptn_mfo,
           ptn_nls,
           ptn_okpo,
           ptn_name,
           card_no_qid,
           result_qid,
           doc_scheme_id,
           scan_qid)
        values
          (partner_id_,
           name_,
           type_id_,
           ext_bank_acc_id_,
           nls_com_,
           ptn_mfo_,
           ptn_nls_,
           ptn_okpo_,
           ptn_name_,
           l_card_no_qid,
           l_result_qid,
           doc_scheme_id_,
           l_scan_qid);
      end if;
    end partner_set;

    -- Удаляет торговца партнера
    procedure partner_del(partner_id_ varchar2 -- Идентификатор торговца партнера
                          ) is
    begin
      -- удаляем
      delete from wcs_partners t where t.id = partner_id_;
    end partner_del;

    -- Создает/обновляет карту торговцев партнеров суб-продукта
    procedure sbprod_partner_set(subproduct_id_ varchar2, -- Идентификатор субпродукта
                                 partner_id_    varchar2 -- Идентификатор торговца партнера
                                 ) is
    begin
      -- обновляем или вставляем
      update wcs_subproduct_partners t
         set t.partner_id = partner_id_
       where t.subproduct_id = subproduct_id_
         and t.partner_id = partner_id_;

      if (sql%rowcount = 0) then
        insert into wcs_subproduct_partners
          (subproduct_id, partner_id)
        values
          (subproduct_id_, partner_id_);
      end if;
    end sbprod_partner_set;

    -- Удаляет карту торговцев партнеров суб-продукта
    procedure sbprod_partner_del(subproduct_id_ varchar2, -- Идентификатор субпродукта
                                 partner_id_    varchar2 -- Идентификатор торговца партнера
                                 ) is
    begin
      -- удаляем
      delete from wcs_subproduct_partners t
       where t.subproduct_id = subproduct_id_
         and t.partner_id = partner_id_;
    end sbprod_partner_del;
    -- ------------------------- Торговцы партнеры --------------------------------------
  */

  -- ------------------------- Информ запросы --------------------------------------
  -- Создает/обновляет информ запрос
  procedure iquery_set(p_iquery_id wcs_infoqueries.id%type, -- Идентификатор информационного запроса
                       p_name      wcs_infoqueries.name%type, -- Наименование
                       p_type_id   wcs_infoqueries.type_id%type, -- Тип инфо-запроса
                       p_plsql     wcs_infoqueries.plsql%type -- plsql блок описывающий запрос
                       ) is
    l_result_qid     varchar2(100) := p_iquery_id || g_iquery_result_prefix;
    l_result_msg_qid varchar2(100) := p_iquery_id ||
                                      g_iquery_result_msg_prefix;
  begin
    -- добавляем вопрос результата
    wcs_pack.quest_set(l_result_qid,
                       p_iquery_id || ' info-query result',
                       'LIST',
                       0,
                       null);
    wcs_pack.quest_list_item_set(l_result_qid, 0, 'Очікує', 1);
    wcs_pack.quest_list_item_set(l_result_qid,
                                 1,
                                 'Виконується',
                                 1);
    wcs_pack.quest_list_item_set(l_result_qid, 2, 'Виконано', 1);
    wcs_pack.quest_list_item_set(l_result_qid, 3, 'Помилка', 1);

    wcs_pack.quest_set(l_result_msg_qid,
                       p_iquery_id || ' info-query result message',
                       'TEXT',
                       0,
                       null);

    -- обновляем или вставляем
    update wcs_infoqueries i
       set i.name           = p_name,
           i.type_id        = p_type_id,
           i.plsql          = p_plsql,
           i.result_qid     = l_result_qid,
           i.result_msg_qid = l_result_msg_qid
     where i.id = p_iquery_id;

    if (sql%rowcount = 0) then
      insert into wcs_infoqueries
        (id, name, type_id, plsql, result_qid, result_msg_qid)
      values
        (p_iquery_id,
         p_name,
         p_type_id,
         p_plsql,
         l_result_qid,
         l_result_msg_qid);
    end if;
  end iquery_set;

  -- Удаляет информ запрос
  procedure iquery_del(p_iquery_id wcs_infoqueries.id%type -- Идентификатор информационного запроса
                       ) is
  begin
    -- удаляем
    delete from wcs_infoqueries i where i.id = p_iquery_id;
  end iquery_del;

  -- Создает/обновляет вопросы информационных запросов
  procedure iquery_quest_set(p_iquery_id    wcs_infoquery_questions.iquery_id%type, -- Идентификатор информационного запроса
                             p_question_id  wcs_infoquery_questions.question_id%type, -- Идентификатор вопроса
                             p_is_required  wcs_infoquery_questions.is_required%type, -- Обязателен ли для заполнения
                             p_is_checkable wcs_infoquery_questions.is_checkable%type, -- Проверяется ли поле
                             p_check_proc   wcs_infoquery_questions.check_proc%type -- Текст проверки
                             ) is
    l_ord wcs_infoquery_questions.ord%type;
  begin
    -- порядок отображения
    select nvl(max(iq.ord), -1) + 1
      into l_ord
      from wcs_infoquery_questions iq
     where iq.iquery_id = p_iquery_id;

    -- обновляем или вставляем
    update wcs_infoquery_questions iq
       set iq.is_required  = p_is_required,
           iq.is_checkable = p_is_checkable,
           iq.check_proc   = p_check_proc
     where iq.iquery_id = p_iquery_id
       and iq.question_id = p_question_id;

    if (sql%rowcount = 0) then
      insert into wcs_infoquery_questions
        (iquery_id,
         question_id,
         is_required,
         is_checkable,
         check_proc,
         ord)
      values
        (p_iquery_id,
         p_question_id,
         p_is_required,
         p_is_checkable,
         p_check_proc,
         l_ord);
    end if;
  end iquery_quest_set;

  -- Удаляет вопросы информационных запросов
  procedure iquery_quest_del(p_iquery_id   wcs_infoquery_questions.iquery_id%type, -- Идентификатор информационного запроса
                             p_question_id wcs_infoquery_questions.question_id%type -- Идентификатор вопроса
                             ) is
  begin
    -- удаляем
    delete from wcs_infoquery_questions iq
     where iq.iquery_id = p_iquery_id
       and iq.question_id = p_question_id;
  end iquery_quest_del;

  -- Перемещает вопрос информационных запросов
  procedure iquery_quest_move(p_iquery_id    wcs_infoquery_questions.iquery_id%type, -- Идентификатор информационного запроса
                              p_src_questid  wcs_infoquery_questions.question_id%type, -- Идентификатор вопроса источника
                              p_dest_questid wcs_infoquery_questions.question_id%type -- Идентификатор вопроса назначения
                              ) is
    l_src  wcs_infoquery_questions%rowtype;
    l_dest wcs_infoquery_questions%rowtype;
  begin
    select iq.*
      into l_src
      from wcs_infoquery_questions iq
     where iq.iquery_id = p_iquery_id
       and iq.question_id = p_src_questid;
    select iq.*
      into l_dest
      from wcs_infoquery_questions iq
     where iq.iquery_id = p_iquery_id
       and iq.question_id = p_dest_questid;

    update wcs_infoquery_questions iq
       set iq.ord = l_dest.ord
     where iq.iquery_id = l_src.iquery_id
       and iq.question_id = l_src.question_id;
    update wcs_infoquery_questions iq
       set iq.ord = l_src.ord
     where iq.iquery_id = l_dest.iquery_id
       and iq.question_id = l_dest.question_id;
  exception
    when no_data_found then
      null;
  end iquery_quest_move;

  -- Создает/обновляет карту информ запросов суб-продукта
  procedure sbprod_iquery_set(p_subproduct_id wcs_subproduct_infoqueries.subproduct_id%type, -- Идентификатор субпродукта
                              p_iquery_id     wcs_subproduct_infoqueries.iquery_id%type, -- Идентификатор информационного запроса
                              p_act_level     wcs_subproduct_infoqueries.act_level%type, -- Уровень активации
                              p_service_id    wcs_subproduct_infoqueries.service_id%type, -- Исполняющая служба (если ручной)
                              p_is_required   wcs_subproduct_infoqueries.is_required%type -- Обязателен ли для выполнения
                              ) is
    l_ord wcs_subproduct_infoqueries.ord%type;
  begin
    -- порядок отображения
    select nvl(max(si.ord), -1) + 1
      into l_ord
      from wcs_subproduct_infoqueries si
     where si.subproduct_id = p_subproduct_id;

    -- обновляем или вставляем
    update wcs_subproduct_infoqueries si
       set si.act_level   = p_act_level,
           si.service_id  = p_service_id,
           si.is_required = p_is_required
     where si.subproduct_id = p_subproduct_id
       and si.iquery_id = p_iquery_id;

    if (sql%rowcount = 0) then
      insert into wcs_subproduct_infoqueries
        (subproduct_id, iquery_id, act_level, service_id, is_required, ord)
      values
        (p_subproduct_id,
         p_iquery_id,
         p_act_level,
         p_service_id,
         p_is_required,
         l_ord);
    end if;
  end sbprod_iquery_set;

  -- Удаляет карту информ запросов суб-продукта
  procedure sbprod_iquery_del(p_subproduct_id wcs_subproduct_infoqueries.subproduct_id%type, -- Идентификатор субпродукта
                              p_iquery_id     wcs_subproduct_infoqueries.iquery_id%type -- Идентификатор информационного запроса
                              ) is
  begin
    -- удаляем
    delete from wcs_subproduct_infoqueries si
     where si.subproduct_id = p_subproduct_id
       and si.iquery_id = p_iquery_id;
  end sbprod_iquery_del;

  -- Перемещает информационный запрос субпродукта
  procedure sbprod_iquery_move(p_subproduct_id wcs_subproduct_infoqueries.subproduct_id%type, -- Идентификатор субпродукта
                               p_src_iqueryid  wcs_subproduct_infoqueries.iquery_id%type, -- Идентификатор источника
                               p_dest_iqueryid wcs_subproduct_infoqueries.iquery_id%type -- Идентификатор назначения
                               ) is
    l_src  wcs_subproduct_infoqueries%rowtype;
    l_dest wcs_subproduct_infoqueries%rowtype;
  begin
    select si.*
      into l_src
      from wcs_subproduct_infoqueries si
     where si.subproduct_id = p_subproduct_id
       and si.iquery_id = p_src_iqueryid;
    select si.*
      into l_dest
      from wcs_subproduct_infoqueries si
     where si.subproduct_id = p_subproduct_id
       and si.iquery_id = p_dest_iqueryid;

    update wcs_subproduct_infoqueries si
       set si.ord = l_dest.ord
     where si.subproduct_id = p_subproduct_id
       and si.iquery_id = l_src.iquery_id;
    update wcs_subproduct_infoqueries si
       set si.ord = l_src.ord
     where si.subproduct_id = p_subproduct_id
       and si.iquery_id = l_dest.iquery_id;
  exception
    when no_data_found then
      null;
  end sbprod_iquery_move;

  -- Клонирует информационные запросы субпродукта
  procedure sbprod_iquery_clone(p_subproduct_id     wcs_subproduct_infoqueries.subproduct_id%type, -- Идентификатор субпродукта
                                p_src_subproduct_id wcs_subproduct_infoqueries.subproduct_id%type -- Идентификатор субпродукта-источника для клонирования
                                ) is
  begin
    for cur in (select *
                  from wcs_subproduct_infoqueries si
                 where si.subproduct_id = p_src_subproduct_id) loop
      sbprod_iquery_set(p_subproduct_id,
                        cur.iquery_id,
                        cur.act_level,
                        cur.service_id,
                        cur.is_required);
    end loop;
  end sbprod_iquery_clone;
  -- ------------------------- Информ запросы --------------------------------------

  -- ------------------------- Страховки --------------------------------------
  -- Обновляет страховку
  procedure insurance_set(p_insurance_id wcs_insurances.id%type, -- Идентификатор страховки
                          p_survey_id    wcs_insurances.survey_id%type -- Идентификатор анкеты
                          ) is
  begin
    -- обновляем
    update wcs_insurances i
       set i.survey_id = p_survey_id
     where i.id = p_insurance_id;
  end insurance_set;

  -- Создает/обновляет страховку клиента субпродукта
  procedure sbp_insurance_set(p_subproduct_id wcs_subproduct_insurances.subproduct_id%type, -- Идентификатор субпродукта
                              p_insurance_id  wcs_subproduct_insurances.insurance_id%type, -- Идентификатор типа страховки
                              p_is_required   wcs_subproduct_insurances.is_required%type -- Обязательна ли для заполнения
                              ) is
    l_ws_id   wcs_workspaces.id%type := 'INS_SBP_' || p_insurance_id;
    l_ws_name wcs_workspaces.name%type;

    l_ord wcs_subproduct_insurances.ord%type;
  begin
    -- порядок отображения
    select nvl(max(si.ord), -1) + 1
      into l_ord
      from wcs_subproduct_insurances si
     where si.subproduct_id = p_subproduct_id;

    -- обновляем или вставляем
    update wcs_subproduct_insurances si
       set si.is_required = p_is_required
     where si.subproduct_id = p_subproduct_id
       and si.insurance_id = p_insurance_id;

    if (sql%rowcount = 0) then
      -- добавляем рабочее пространство если его нет
      begin
        select 'Страховка клиента "' || i.name || '"'
          into l_ws_name
          from wcs_insurances i
         where i.id = p_insurance_id;

        insert into wcs_workspaces (id, name) values (l_ws_id, l_ws_name);
      exception
        when dup_val_on_index then
          null;
      end;

      -- добавляем
      insert into wcs_subproduct_insurances
        (subproduct_id, insurance_id, is_required, ord, ws_id)
      values
        (p_subproduct_id, p_insurance_id, p_is_required, l_ord, l_ws_id);
    end if;
  end sbp_insurance_set;

  -- Удаляет страховку клиента субпродукта
  procedure sbp_insurance_del(p_subproduct_id wcs_subproduct_insurances.subproduct_id%type, -- Идентификатор субпродукта
                              p_insurance_id  wcs_subproduct_insurances.insurance_id%type -- Идентификатор типа страховки
                              ) is
  begin
    -- удаляем
    delete from wcs_subproduct_insurances si
     where si.subproduct_id = p_subproduct_id
       and si.insurance_id = p_insurance_id;
  end sbp_insurance_del;

  -- Перемещает страховку клиента субпродукта
  procedure sbp_insurance_move(p_subproduct_id wcs_subproduct_insurances.subproduct_id%type, -- Идентификатор субпродукта
                               p_src_id        wcs_subproduct_insurances.insurance_id%type, -- Идентификатор источника
                               p_dest_id       wcs_subproduct_insurances.insurance_id%type -- Идентификатор назначения
                               ) is
    l_src  wcs_subproduct_insurances%rowtype;
    l_dest wcs_subproduct_insurances%rowtype;
  begin
    select si.*
      into l_src
      from wcs_subproduct_insurances si
     where si.subproduct_id = p_subproduct_id
       and si.insurance_id = p_src_id;
    select si.*
      into l_dest
      from wcs_subproduct_insurances si
     where si.subproduct_id = p_subproduct_id
       and si.insurance_id = p_dest_id;

    update wcs_subproduct_insurances si
       set si.ord = l_dest.ord
     where si.subproduct_id = p_subproduct_id
       and si.insurance_id = l_src.insurance_id;
    update wcs_subproduct_insurances si
       set si.ord = l_src.ord
     where si.subproduct_id = p_subproduct_id
       and si.insurance_id = l_dest.insurance_id;
  exception
    when no_data_found then
      null;
  end sbp_insurance_move;

  -- Клонирует страховку клиента субпродукта
  procedure sbp_insurance_clone(p_subproduct_id     wcs_subproducts.id%type, -- Идентификатор субпродукта
                                p_src_subproduct_id wcs_subproducts.id%type -- Идентификатор субпродукта-источника для клонирования
                                ) is
  begin
    for cur in (select *
                  from wcs_subproduct_insurances si
                 where si.subproduct_id = p_src_subproduct_id) loop
      sbp_insurance_set(p_subproduct_id, cur.insurance_id, cur.is_required);
    end loop;
  end sbp_insurance_clone;

  -- Создает страховку заявки
  procedure bid_insurance_set(p_bid_id       wcs_bids.id%type, -- Идентификатор заявки
                              p_insurance_id wcs_insurances.id%type -- Идентификатор типа страховки
                              ) is
    l_i_row  wcs_insurances%rowtype;
    l_si_row wcs_subproduct_insurances%rowtype;
    l_count  number;
    l_status number := 0; -- Новий
  begin
    -- параметры страховки
    select *
      into l_i_row
      from wcs_insurances i
     where i.id = p_insurance_id;
    select si.*
      into l_si_row
      from wcs_subproduct_insurances si, wcs_bids b
     where b.id = p_bid_id
       and si.subproduct_id = b.subproduct_id
       and si.insurance_id = p_insurance_id;

    -- кол-во уже заведеных
    l_count := nvl(wcs_utl.get_answ_numb(p_bid_id,
                                         l_i_row.count_qid,
                                         l_si_row.ws_id),
                   0);

    -- добавляем
    wcs_pack.answ_numb_set(p_bid_id,
                           l_i_row.count_qid,
                           l_count + 1,
                           l_si_row.ws_id);
    bid_insurance_status_set(p_bid_id, p_insurance_id, l_count, l_status);
  end bid_insurance_set;

  -- Удаляет страховку заявки
  procedure bid_insurance_del(p_bid_id        wcs_bids.id%type, -- Идентификатор заявки
                              p_insurance_id  wcs_insurances.id%type, -- Идентификатор типа страховки
                              p_insurance_num number -- Номер
                              ) is
    l_i_row  wcs_insurances%rowtype;
    l_si_row wcs_subproduct_insurances%rowtype;
    l_count  number;
  begin
    -- параметры страховки
    select *
      into l_i_row
      from wcs_insurances i
     where i.id = p_insurance_id;
    select si.*
      into l_si_row
      from wcs_subproduct_insurances si, wcs_bids b
     where b.id = p_bid_id
       and si.subproduct_id = b.subproduct_id
       and si.insurance_id = p_insurance_id;

    -- кол-во уже заведеных
    l_count := nvl(wcs_utl.get_answ_numb(p_bid_id,
                                         l_i_row.count_qid,
                                         l_si_row.ws_id),
                   0);

    -- Удаляем
    if (l_count = 1 and l_si_row.is_required = 1) then
      null;
      -- Нельзя удалить последний обязательный тип
    else
      wcs_pack.answ_numb_set(p_bid_id,
                             l_i_row.count_qid,
                             l_count - 1,
                             l_si_row.ws_id);

      if (l_count > 1) then
        delete from wcs_answers a
         where a.bid_id = p_bid_id
           and a.ws_id = l_si_row.ws_id
           and a.ws_number = p_insurance_num;

        update wcs_answers a
           set a.ws_number = a.ws_number - 1
         where a.bid_id = p_bid_id
           and a.ws_id = l_si_row.ws_id
           and a.ws_number > p_insurance_num;

        delete from wcs_answers a
         where a.bid_id = p_bid_id
           and a.ws_id = l_si_row.ws_id
           and a.ws_number = l_count - 1;
      end if;
    end if;
  end bid_insurance_del;

  -- Устанавливает статус страховки заявки
  procedure bid_insurance_status_set(p_bid_id        wcs_bids.id%type, -- Идентификатор заявки
                                     p_insurance_id  wcs_insurances.id%type, -- Идентификатор типа страховки
                                     p_insurance_num number, -- Номер
                                     p_status_id     number -- Ид. статуса
                                     ) is
    l_i_row  wcs_insurances%rowtype;
    l_si_row wcs_subproduct_insurances%rowtype;
  begin
    -- параметры страховки
    select *
      into l_i_row
      from wcs_insurances i
     where i.id = p_insurance_id;
    select si.*
      into l_si_row
      from wcs_subproduct_insurances si, wcs_bids b
     where b.id = p_bid_id
       and si.subproduct_id = b.subproduct_id
       and si.insurance_id = p_insurance_id;

    -- устанавливаем статус
    wcs_pack.answ_list_set(p_bid_id,
                           l_i_row.status_qid,
                           p_status_id,
                           l_si_row.ws_id,
                           p_insurance_num);
  end bid_insurance_status_set;

  -- Создает страховку обеспечения заявки
  procedure bid_grt_insurance_set(p_bid_id       wcs_bids.id%type, -- Идентификатор заявки
                                  p_garantee_id  wcs_garantees.id%type, -- Идентификатор обеспечения
                                  p_garantee_num number, -- Номер обеспечения
                                  p_insurance_id wcs_insurances.id%type -- Идентификатор типа страховки
                                  ) is
    l_i_row  wcs_insurances%rowtype;
    l_gi_row wcs_garantee_insurances%rowtype;
    l_bg_row v_wcs_bid_garantees%rowtype;

    l_count  number;
    l_status number := 0; -- Новий

    l_ws_id   wcs_workspaces.id%type := 'GRT_' || p_garantee_id || '_' ||
                                        p_garantee_num || '_INS_' ||
                                        p_insurance_id;
    l_ws_name wcs_workspaces.name%type := 'Страховка ' || p_insurance_id ||
                                          ' обеспечения ' || p_garantee_id || ' №' ||
                                          p_garantee_num;
  begin
    -- параметры страховки
    select *
      into l_i_row
      from wcs_insurances i
     where i.id = p_insurance_id;
    select gi.*
      into l_gi_row
      from wcs_garantee_insurances gi
     where gi.garantee_id = p_garantee_id
       and gi.insurance_id = p_insurance_id;
    select *
      into l_bg_row
      from v_wcs_bid_garantees bg
     where bg.bid_id = p_bid_id
       and bg.garantee_id = p_garantee_id
       and bg.garantee_num = p_garantee_num;

    -- добавляем рабочее пространство если его нет
    wcs_pack.answ_text_set(p_bid_id,
                           l_gi_row.ws_qid,
                           l_ws_id,
                           l_bg_row.ws_id,
                           p_garantee_num);

    begin
      insert into wcs_workspaces (id, name) values (l_ws_id, l_ws_name);
    exception
      when dup_val_on_index then
        null;
    end;

    -- кол-во уже заведеных
    l_count := nvl(wcs_utl.get_answ_numb(p_bid_id,
                                         l_i_row.count_qid,
                                         wcs_utl.get_answ_text(p_bid_id,
                                                               l_gi_row.ws_qid,
                                                               l_bg_row.ws_id,
                                                               p_garantee_num)),
                   0);

    -- добавляем
    wcs_pack.answ_numb_set(p_bid_id,
                           l_i_row.count_qid,
                           l_count + 1,
                           l_ws_id);
    bid_grt_insurance_status_set(p_bid_id,
                                 p_garantee_id,
                                 p_garantee_num,
                                 p_insurance_id,
                                 l_count,
                                 l_status);
  end bid_grt_insurance_set;

  -- Удаляет страховку обеспечения заявки
  procedure bid_grt_insurance_del(p_bid_id        wcs_bids.id%type, -- Идентификатор заявки
                                  p_garantee_id   wcs_garantees.id%type, -- Идентификатор обеспечения
                                  p_garantee_num  number, -- Номер обеспечения
                                  p_insurance_id  wcs_insurances.id%type, -- Идентификатор типа страховки
                                  p_insurance_num number -- Номер
                                  ) is
    l_i_row  wcs_insurances%rowtype;
    l_gi_row wcs_garantee_insurances%rowtype;
    l_bg_row v_wcs_bid_garantees%rowtype;

    l_count number;

    l_ws_id wcs_workspaces.id%type;
  begin
    -- параметры страховки
    select *
      into l_i_row
      from wcs_insurances i
     where i.id = p_insurance_id;
    select gi.*
      into l_gi_row
      from wcs_garantee_insurances gi
     where gi.garantee_id = p_garantee_id
       and gi.insurance_id = p_insurance_id;
    select *
      into l_bg_row
      from v_wcs_bid_garantees bg
     where bg.bid_id = p_bid_id
       and bg.garantee_id = p_garantee_id
       and bg.garantee_num = p_garantee_num;
    l_ws_id := wcs_utl.get_answ_text(p_bid_id,
                                     l_gi_row.ws_qid,
                                     l_bg_row.ws_id,
                                     p_garantee_num);

    -- кол-во уже заведеных
    l_count := nvl(wcs_utl.get_answ_numb(p_bid_id,
                                         l_i_row.count_qid,
                                         l_ws_id),
                   0);

    -- Удаляем
    if (l_count = 1 and l_gi_row.is_required = 1) then
      null;
      -- Нельзя удалить последний обязательный тип
    else
      wcs_pack.answ_numb_set(p_bid_id,
                             l_i_row.count_qid,
                             l_count - 1,
                             l_ws_id);

      if (l_count > 1) then
        delete from wcs_answers a
         where a.bid_id = p_bid_id
           and a.ws_id = l_ws_id
           and a.ws_number = p_insurance_num;

        update wcs_answers a
           set a.ws_number = a.ws_number - 1
         where a.bid_id = p_bid_id
           and a.ws_id = l_ws_id
           and a.ws_number > p_insurance_num;

        delete from wcs_answers a
         where a.bid_id = p_bid_id
           and a.ws_id = l_ws_id
           and a.ws_number = l_count - 1;
      end if;
    end if;
  end bid_grt_insurance_del;

  -- Устанавливает статус страховки обеспечения заявки
  procedure bid_grt_insurance_status_set(p_bid_id        wcs_bids.id%type, -- Идентификатор заявки
                                         p_garantee_id   wcs_garantees.id%type, -- Идентификатор обеспечения
                                         p_garantee_num  number, -- Номер обеспечения
                                         p_insurance_id  wcs_insurances.id%type, -- Идентификатор типа страховки
                                         p_insurance_num number, -- Номер
                                         p_status_id     number -- Ид. статуса
                                         ) is
    l_i_row  wcs_insurances%rowtype;
    l_gi_row wcs_garantee_insurances%rowtype;
    l_bg_row v_wcs_bid_garantees%rowtype;

    l_ws_id wcs_workspaces.id%type;
  begin
    -- параметры страховки
    select *
      into l_i_row
      from wcs_insurances i
     where i.id = p_insurance_id;
    select gi.*
      into l_gi_row
      from wcs_garantee_insurances gi
     where gi.garantee_id = p_garantee_id
       and gi.insurance_id = p_insurance_id;
    select *
      into l_bg_row
      from v_wcs_bid_garantees bg
     where bg.bid_id = p_bid_id
       and bg.garantee_id = p_garantee_id
       and bg.garantee_num = p_garantee_num;
    l_ws_id := wcs_utl.get_answ_text(p_bid_id,
                                     l_gi_row.ws_qid,
                                     l_bg_row.ws_id,
                                     p_garantee_num);

    -- устанавливаем статус
    wcs_pack.answ_list_set(p_bid_id,
                           l_i_row.status_qid,
                           p_status_id,
                           l_ws_id,
                           p_insurance_num);
  end bid_grt_insurance_status_set;
  -- ------------------------- Страховки --------------------------------------

  -- ------------------------- Обеспечение --------------------------------------
  -- Обновляет обеспечение
  procedure garantee_set(p_garantee_id wcs_garantees.id%type, -- Идентификатор обеспечения
                         p_scopy_id    wcs_garantees.scopy_id%type, -- Идентификатор карты сканкопий
                         p_survey_id   wcs_garantees.survey_id%type -- Идентификатор анкеты
                         ) is
  begin
    -- обновляем
    update wcs_garantees g
       set g.scopy_id = p_scopy_id, g.survey_id = p_survey_id
     where g.id = p_garantee_id;
  end garantee_set;

  -- Создает/обновляет страховку обеспечения
  procedure garantee_insurance_set(p_garantee_id  wcs_garantee_insurances.garantee_id%type, -- Идентификатор обеспечения
                                   p_insurance_id wcs_garantee_insurances.insurance_id%type, -- Идентификатор типа страховки
                                   p_is_required  wcs_garantee_insurances.is_required%type -- Обязательна ли для заполнения
                                   ) is
    l_ws_qid wcs_questions.id%type := 'GRT_' || p_garantee_id || '_INS_' ||
                                      p_insurance_id || '_WS';
    l_ord    wcs_garantee_insurances.ord%type;
  begin
    -- вопрос для хранения рабочего пространства
    wcs_pack.quest_set(l_ws_qid,
                       'Вопрос для хранения рабочего пространства страховки ' ||
                       p_insurance_id || ' обеспечения ' || p_garantee_id,
                       'TEXT',
                       0,
                       null);

    -- порядок отображения
    select nvl(max(gi.ord), -1) + 1
      into l_ord
      from wcs_garantee_insurances gi
     where gi.garantee_id = p_garantee_id;

    -- обновляем или вставляем
    update wcs_garantee_insurances gi
       set gi.is_required = p_is_required, gi.ws_qid = l_ws_qid
     where gi.garantee_id = p_garantee_id
       and gi.insurance_id = p_insurance_id;

    if (sql%rowcount = 0) then
      insert into wcs_garantee_insurances
        (garantee_id, insurance_id, is_required, ord, ws_qid)
      values
        (p_garantee_id, p_insurance_id, p_is_required, l_ord, l_ws_qid);
    end if;
  end garantee_insurance_set;

  -- Удаляет страховку обеспечения
  procedure garantee_insurance_del(p_garantee_id  wcs_garantee_insurances.garantee_id%type, -- Идентификатор обеспечения
                                   p_insurance_id wcs_garantee_insurances.insurance_id%type -- Идентификатор типа страховки
                                   ) is
  begin
    -- удаляем
    delete from wcs_garantee_insurances gi
     where gi.garantee_id = p_garantee_id
       and gi.insurance_id = p_insurance_id;
  end garantee_insurance_del;

  -- Перемещает страховку обеспечения
  procedure garantee_insurance_move(p_garantee_id wcs_garantee_insurances.garantee_id%type, -- Идентификатор обеспечения
                                    p_src_id      wcs_garantee_insurances.insurance_id%type, -- Идентификатор источника
                                    p_dest_id     wcs_garantee_insurances.insurance_id%type -- Идентификатор назначения
                                    ) is
    l_src  wcs_garantee_insurances%rowtype;
    l_dest wcs_garantee_insurances%rowtype;
  begin
    select gi.*
      into l_src
      from wcs_garantee_insurances gi
     where gi.garantee_id = p_garantee_id
       and gi.insurance_id = p_src_id;
    select gi.*
      into l_dest
      from wcs_garantee_insurances gi
     where gi.garantee_id = p_garantee_id
       and gi.insurance_id = p_dest_id;

    update wcs_garantee_insurances gi
       set gi.ord = l_dest.ord
     where gi.garantee_id = p_garantee_id
       and gi.insurance_id = l_src.insurance_id;
    update wcs_garantee_insurances gi
       set gi.ord = l_src.ord
     where gi.garantee_id = p_garantee_id
       and gi.insurance_id = l_dest.insurance_id;
  exception
    when no_data_found then
      null;
  end garantee_insurance_move;

  -- Создает/обновляет шаблон обеспечения
  procedure garantee_template_set(p_garantee_id    wcs_garantee_templates.garantee_id%type, -- Идентификатор обеспечения
                                  p_template_id    wcs_garantee_templates.template_id%type, -- Идентификатор шаблона
                                  p_print_state_id wcs_garantee_templates.print_state_id%type, -- Этап печати
                                  p_is_scan_req    wcs_garantee_templates.is_scan_required%type -- Обязательно ли сканирование отпечатка
                                  ) is
    l_scan_qid wcs_garantee_templates.scan_qid%type := 'GRT_' ||
                                                       p_template_id || '_' ||
                                                       g_template_scan_prefix;
  begin
    -- создаем вопрос сканкопию
    wcs_pack.quest_set(l_scan_qid,
                       'Сканкопия документа обеспечения ' || p_template_id,
                       'FILE',
                       0,
                       null);

    -- обновляем или вставляем
    update wcs_garantee_templates gt
       set gt.print_state_id   = p_print_state_id,
           gt.scan_qid         = l_scan_qid,
           gt.is_scan_required = p_is_scan_req
     where gt.garantee_id = p_garantee_id
       and gt.template_id = p_template_id;

    if (sql%rowcount = 0) then
      insert into wcs_garantee_templates
        (garantee_id,
         print_state_id,
         template_id,
         scan_qid,
         is_scan_required)
      values
        (p_garantee_id,
         p_print_state_id,
         p_template_id,
         l_scan_qid,
         p_is_scan_req);
    end if;
  end garantee_template_set;

  -- Удаляет шаблон обеспечения
  procedure garantee_template_del(p_garantee_id wcs_garantee_templates.garantee_id%type, -- Идентификатор обеспечения
                                  p_template_id wcs_garantee_templates.template_id%type -- Идентификатор шаблона
                                  ) is
  begin
    -- удаляем
    delete from wcs_garantee_templates gt
     where gt.garantee_id = p_garantee_id
       and gt.template_id = p_template_id;
  end garantee_template_del;

  -- Создает/обновляет обеспечение субпродукта
  procedure sbp_garantee_set(p_subproduct_id wcs_subproduct_garantees.subproduct_id%type, -- Идентификатор субпродукта
                             p_garantee_id   wcs_subproduct_garantees.garantee_id%type, -- Идентификатор типа обеспечения
                             p_is_required   wcs_subproduct_garantees.is_required%type -- Обязательна ли для заполнения
                             ) is
    l_ord wcs_subproduct_garantees.ord%type;
  begin
    -- порядок отображения
    select nvl(max(sg.ord), -1) + 1
      into l_ord
      from wcs_subproduct_garantees sg
     where sg.subproduct_id = p_subproduct_id;

    -- обновляем или вставляем
    update wcs_subproduct_garantees sg
       set sg.is_required = p_is_required
     where sg.subproduct_id = p_subproduct_id
       and sg.garantee_id = p_garantee_id;

    if (sql%rowcount = 0) then
      insert into wcs_subproduct_garantees
        (subproduct_id, garantee_id, is_required, ord)
      values
        (p_subproduct_id, p_garantee_id, p_is_required, l_ord);
    end if;
  end sbp_garantee_set;

  -- Удаляет обеспечение субпродукта
  procedure sbp_garantee_del(p_subproduct_id wcs_subproduct_garantees.subproduct_id%type, -- Идентификатор субпродукта
                             p_garantee_id   wcs_subproduct_garantees.garantee_id%type -- Идентификатор типа обеспечения
                             ) is
  begin
    -- удаляем
    delete from wcs_subproduct_garantees sg
     where sg.subproduct_id = p_subproduct_id
       and sg.garantee_id = p_garantee_id;
  end sbp_garantee_del;

  -- Перемещает обеспечение субпродукта
  procedure sbp_garantee_move(p_subproduct_id wcs_subproduct_garantees.subproduct_id%type, -- Идентификатор субпродукта
                              p_src_gid       wcs_subproduct_garantees.garantee_id%type, -- Идентификатор источника
                              p_dest_gid      wcs_subproduct_garantees.garantee_id%type -- Идентификатор назначения
                              ) is
    l_src  wcs_subproduct_garantees%rowtype;
    l_dest wcs_subproduct_garantees%rowtype;
  begin
    select sg.*
      into l_src
      from wcs_subproduct_garantees sg
     where sg.subproduct_id = p_subproduct_id
       and sg.garantee_id = p_src_gid;
    select sg.*
      into l_dest
      from wcs_subproduct_garantees sg
     where sg.subproduct_id = p_subproduct_id
       and sg.garantee_id = p_dest_gid;

    update wcs_subproduct_garantees sg
       set sg.ord = l_dest.ord
     where sg.subproduct_id = p_subproduct_id
       and sg.garantee_id = l_src.garantee_id;
    update wcs_subproduct_garantees sg
       set sg.ord = l_src.ord
     where sg.subproduct_id = p_subproduct_id
       and sg.garantee_id = l_dest.garantee_id;
  exception
    when no_data_found then
      null;
  end sbp_garantee_move;

  -- Клонирует обеспечение субпродукта
  procedure sbp_garantee_clone(p_subproduct_id     wcs_subproducts.id%type, -- Идентификатор субпродукта
                               p_src_subproduct_id wcs_subproducts.id%type -- Идентификатор субпродукта-источника для клонирования
                               ) is
  begin
    for cur in (select *
                  from wcs_subproduct_garantees sg
                 where sg.subproduct_id = p_src_subproduct_id) loop
      sbp_garantee_set(p_subproduct_id, cur.garantee_id, cur.is_required);
    end loop;
  end sbp_garantee_clone;

  -- Создает обеспечение заявки
  procedure bid_garantee_set(p_bid_id      wcs_bids.id%type, -- Идентификатор заявки
                             p_garantee_id wcs_garantees.id%type -- Идентификатор типа обеспечения
                             ) is
    l_garantee_num number;
  begin
    l_garantee_num := wcs_pack.bid_garantee_set_ext(p_bid_id, p_garantee_id);
  end bid_garantee_set;

  function bid_garantee_set_ext(p_bid_id      wcs_bids.id%type, -- Идентификатор заявки
                                p_garantee_id wcs_garantees.id%type -- Идентификатор типа обеспечения
                                ) return number is
    l_g_row  wcs_garantees%rowtype;
    l_count  number;
    l_status number := 0; -- Новий

    l_ws_id   wcs_workspaces.id%type;
    l_ws_name wcs_workspaces.name%type;
  begin
    -- параметры обеспечения
    select * into l_g_row from wcs_garantees g where g.id = p_garantee_id;

    -- кол-во уже заведеных
    l_count := nvl(wcs_utl.get_answ_numb(p_bid_id, l_g_row.count_qid), 0);

    -- добавляем
    wcs_pack.answ_numb_set(p_bid_id, l_g_row.count_qid, l_count + 1);
    bid_garantee_status_set(p_bid_id, p_garantee_id, l_count, l_status);

    -- добавляем обязательные страховки
    for cur in (select *
                  from wcs_garantee_insurances gi
                 where gi.garantee_id = p_garantee_id
                   and gi.is_required = 1) loop
      bid_grt_insurance_set(p_bid_id,
                            p_garantee_id,
                            l_count,
                            cur.insurance_id);
    end loop;

    return l_count;
  end bid_garantee_set_ext;

  -- Удаляет обеспечение заявки
  procedure bid_garantee_del(p_bid_id       wcs_bids.id%type, -- Идентификатор заявки
                             p_garantee_id  wcs_garantees.id%type, -- Идентификатор типа обеспечения
                             p_garantee_num number -- Номер
                             ) is
    l_g_row  wcs_garantees%rowtype;
    l_b_row  wcs_bids%rowtype;
    l_sg_row wcs_subproduct_garantees%rowtype;
    l_count  number;
    l_status number := 0; -- Новий
  begin
    -- параметры обеспечения
    select * into l_g_row from wcs_garantees g where g.id = p_garantee_id;
    select * into l_b_row from wcs_bids b where b.id = p_bid_id;
    select *
      into l_sg_row
      from wcs_subproduct_garantees sg
     where sg.subproduct_id = l_b_row.subproduct_id
       and sg.garantee_id = p_garantee_id;

    -- кол-во уже заведеных
    l_count := nvl(wcs_utl.get_answ_numb(p_bid_id, l_g_row.count_qid), 0);

    -- Удаляем
    if (l_count = 1 and l_sg_row.is_required = 1) then
      null;
      -- Нельзя удалить последний обязательный тип
    else
      /* !!! Ждем обновления модуля страхования
      -- удаляем страховки
      for cur in (select *
                    from v_wcs_bid_grt_insurances bgi
                   where bgi.bid_id = p_bid_id
                     and bgi.garantee_id = p_garantee_id
                     and bgi.garantee_num = p_garantee_num) loop
        bid_grt_insurance_del(p_bid_id,
                              p_garantee_id,
                              p_garantee_num,
                              cur.insurance_id,
                              cur.insurance_num);
      end loop;
      */

      -- удаляем обеспечение
      wcs_pack.answ_numb_set(p_bid_id, l_g_row.count_qid, l_count - 1);

      delete from wcs_answers a
       where a.bid_id = p_bid_id
         and a.ws_id = l_g_row.ws_id
         and a.ws_number = p_garantee_num;

      if (l_count > 1) then
        update wcs_answers a
           set a.ws_number = a.ws_number - 1
         where a.bid_id = p_bid_id
           and a.ws_id = l_g_row.ws_id
           and a.ws_number > p_garantee_num;

        delete from wcs_answers a
         where a.bid_id = p_bid_id
           and a.ws_id = l_g_row.ws_id
           and a.ws_number = l_count - 1;
      end if;
    end if;
  end bid_garantee_del;

  -- Устанавливает статус обеспечение заявки
  procedure bid_garantee_status_set(p_bid_id       wcs_bids.id%type, -- Идентификатор заявки
                                    p_garantee_id  wcs_garantees.id%type, -- Идентификатор типа обеспечения
                                    p_garantee_num number, -- № обеспечения
                                    p_status_id    number -- Ид. статуса
                                    ) is
    l_g_row wcs_garantees%rowtype;
  begin
    -- параметры обеспечения
    select * into l_g_row from wcs_garantees g where g.id = p_garantee_id;

    -- устанавливаем статус
    wcs_pack.answ_list_set(p_bid_id,
                           l_g_row.status_qid,
                           p_status_id,
                           l_g_row.ws_id,
                           p_garantee_num);
  end bid_garantee_status_set;
  -- ------------------------- Обеспечение --------------------------------------

  -- ------------------------- Шаблоны договоров --------------------------------------
  -- Создает/обновляет шаблон
  procedure template_set(p_template_id    v_wcs_templates.template_id%type, -- Идентификатор шаблона
                         p_template_name  v_wcs_templates.template_name%type, -- Наименование шаблона
                         p_file_name      v_wcs_templates.file_name%type, -- Имя файла шаблона
                         p_docexp_type_id v_wcs_templates.docexp_type_id%type default 'PDF' -- Формат экспорта
                         ) is
  begin
    -- обновляем или вставляем в doc_scheme
    update doc_scheme ds
       set ds.name           = p_template_name,
           ds.print_on_blank = 0,
           ds.fr             = 1,
           ds.file_name      = lower(p_file_name)
     where ds.id = p_template_id;

    if (sql%rowcount = 0) then
      insert into doc_scheme
        (id, name, print_on_blank, fr, file_name)
      values
        (p_template_id, p_template_name, 0, 1, lower(p_file_name));
    end if;

    -- обновляем/вставляем
    update wcs_templates t
       set t.docexp_type_id = p_docexp_type_id
     where t.template_id = p_template_id;

    if sql%rowcount = 0 then
      insert into wcs_templates
        (template_id, docexp_type_id)
      values
        (p_template_id, p_docexp_type_id);
    end if;
  end template_set;

  -- Удаляет шаблон
  procedure template_del(p_template_id v_wcs_templates.template_id%type -- Идентификатор шаблона
                         ) is
  begin
    -- удаляем
    delete from wcs_templates t where t.template_id = p_template_id;
    -- удаляем в doc_scheme
    doc_tpl_mgr.delete_template(p_template_id);
  end template_del;

  -- Создает/обновляет шаблон субпродукта
  procedure sbp_template_set(p_subproduct_id  wcs_subproduct_templates.subproduct_id%type, -- Идентификатор субродукта
                             p_template_id    wcs_subproduct_templates.template_id%type, -- Идентификатор шаблона
                             p_print_state_id wcs_subproduct_templates.print_state_id%type, -- Идентификатор этапа печати
                             p_is_scan_req    wcs_subproduct_templates.is_scan_required%type -- Обязательно ли сканирование отпечатка
                             ) is
    l_scan_qid wcs_subproduct_templates.scan_qid%type := p_template_id || '_' ||
                                                         g_template_scan_prefix;
  begin
    -- создаем вопрос сканкопию
    wcs_pack.quest_set(l_scan_qid,
                       'Сканкопия документа ' || p_template_id,
                       'FILE',
                       0,
                       null);

    -- обновляем или вставляем
    update wcs_subproduct_templates st
       set st.print_state_id   = p_print_state_id,
           st.scan_qid         = l_scan_qid,
           st.is_scan_required = p_is_scan_req
     where st.subproduct_id = p_subproduct_id
       and st.template_id = p_template_id;

    if (sql%rowcount = 0) then
      insert into wcs_subproduct_templates
        (subproduct_id,
         print_state_id,
         template_id,
         scan_qid,
         is_scan_required)
      values
        (p_subproduct_id,
         p_print_state_id,
         p_template_id,
         l_scan_qid,
         p_is_scan_req);
    end if;
  end sbp_template_set;

  -- Удаляет шаблон субпродукта
  procedure sbp_template_del(p_subproduct_id wcs_subproduct_templates.subproduct_id%type, -- Идентификатор субродукта
                             p_template_id   wcs_subproduct_templates.template_id%type -- Идентификатор шаблона
                             ) is
  begin
    -- вставляем
    delete from wcs_subproduct_templates st
     where st.subproduct_id = p_subproduct_id
       and st.template_id = p_template_id;
  end sbp_template_del;

  -- Клонирует шаблоны субпродукта
  procedure sbp_template_clone(p_subproduct_id     wcs_subproduct_templates.subproduct_id%type, -- Идентификатор субпродукта
                               p_src_subproduct_id wcs_subproduct_templates.subproduct_id%type -- Идентификатор субпродукта-источника для клонирования
                               ) is
  begin
    for cur in (select *
                  from wcs_subproduct_templates st
                 where st.subproduct_id = p_src_subproduct_id) loop
      sbp_template_set(p_subproduct_id,
                       cur.template_id,
                       cur.print_state_id,
                       cur.is_scan_required);
    end loop;
  end sbp_template_clone;
  -- ------------------------- Шаблоны договоров --------------------------------------

  -- ------------------------- Платежные инструкции --------------------------------------
  -- Добавляет платежную инструкцию субпродукта
  procedure sbp_payment_set(p_subproduct_id wcs_subproduct_payments.subproduct_id%type, -- Идентификатор субродукта
                            p_payment_id    wcs_subproduct_payments.payment_id%type -- Идентификатор платежной инструкции
                            ) is
  begin
    insert into wcs_subproduct_payments
      (subproduct_id, payment_id)
    values
      (p_subproduct_id, p_payment_id);
  exception
    when dup_val_on_index then
      null;
  end sbp_payment_set;

  -- Удаляет платежную инструкцию субпродукта
  procedure sbp_payment_del(p_subproduct_id wcs_subproduct_payments.subproduct_id%type, -- Идентификатор субродукта
                            p_payment_id    wcs_subproduct_payments.payment_id%type -- Идентификатор платежной инструкции
                            ) is
  begin
    -- вставляем
    delete from wcs_subproduct_payments sp
     where sp.subproduct_id = p_subproduct_id
       and sp.payment_id = p_payment_id;
  end sbp_payment_del;

  -- Клонирует платежные инструкции субпродукта
  procedure sbp_payment_clone(p_subproduct_id     wcs_subproducts.id%type, -- Идентификатор субпродукта
                              p_src_subproduct_id wcs_subproducts.id%type -- Идентификатор субпродукта-источника для клонирования
                              ) is
  begin
    for cur in (select *
                  from wcs_subproduct_payments sp
                 where sp.subproduct_id = p_src_subproduct_id) loop
      sbp_payment_set(p_subproduct_id, cur.payment_id);
    end loop;
  end sbp_payment_clone;

  -- Добавляет тип торговца-партнера субпродукта
  procedure sbp_ptrtype_set(p_subproduct_id wcs_subproduct_ptrtypes.subproduct_id%type, -- Идентификатор субродукта
                            p_ptr_type_id   wcs_subproduct_ptrtypes.ptr_type_id%type -- Тип торговца-партнера
                            ) is
  begin
    insert into wcs_subproduct_ptrtypes
      (subproduct_id, ptr_type_id)
    values
      (p_subproduct_id, p_ptr_type_id);
  exception
    when dup_val_on_index then
      null;
  end sbp_ptrtype_set;

  -- Удаляет тип торговца-партнера субпродукта
  procedure sbp_ptrtype_del(p_subproduct_id wcs_subproduct_ptrtypes.subproduct_id%type, -- Идентификатор субродукта
                            p_ptr_type_id   wcs_subproduct_ptrtypes.ptr_type_id%type -- Тип торговца-партнера
                            ) is
  begin
    -- вставляем
    delete from wcs_subproduct_ptrtypes sp
     where sp.subproduct_id = p_subproduct_id
       and sp.ptr_type_id = p_ptr_type_id;
  end sbp_ptrtype_del;

  -- Клонирует типы торговцев-партнеров субпродукта
  procedure sbp_ptrtype_clone(p_subproduct_id     wcs_subproducts.id%type, -- Идентификатор субпродукта
                              p_src_subproduct_id wcs_subproducts.id%type -- Идентификатор субпродукта-источника для клонирования
                              ) is
  begin
    for cur in (select *
                  from wcs_subproduct_ptrtypes sp
                 where sp.subproduct_id = p_src_subproduct_id) loop
      sbp_ptrtype_set(p_subproduct_id, cur.ptr_type_id);
    end loop;
  end sbp_ptrtype_clone;
  -- ------------------------- Платежные инструкции --------------------------------------
/*
  TODO: owner="tvSukhov" created="14.02.2011"
  text="Добавить схемы в разрезе бранчей"
  */
end wcs_pack;
/
 show err;
 
PROMPT *** Create  grants  WCS_PACK ***
grant EXECUTE                                                                on WCS_PACK        to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/wcs_pack.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 