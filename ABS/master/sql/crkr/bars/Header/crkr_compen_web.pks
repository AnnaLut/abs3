create or replace package crkr_compen_web is

  -- Author  : OLEG.MUZYKA
  -- Created : 26.07.2016 15:47:22
  -- Purpose : Пакет по роботі з центральним реєстром компенсаційних рахунків

  -- Public constant declarations
  g_header_version constant varchar2(120) := 'Version Header 1.09 31.03.2017 15:59';

  -- Public function and procedure declarations
  function header_version return varchar2;

  function body_version return varchar2;

  function get_compen(p_id in number) return compen_portfolio%rowtype;

  procedure create_customer(p_name          in varchar2,
                            p_inn           in varchar2,
                            p_sex           in varchar2,
                            p_birth_date    in date,
                            p_rezid         in number,
                            p_doc_type      in integer,
                            p_ser           in varchar2,
                            p_numdoc        in varchar2,--Документ № (для ID картки 9 цифр)
                            p_date_of_issue in date,
                            p_organ         in varchar2,
                            p_eddr_id       in varchar2,--Запис № (для ID картки 8 цифр,дефіс,5 цифр)
                            p_actual_date   in date,
                            p_country_id    in number,
                            p_bplace        in varchar2,
                            p_tel           in varchar2,
                            p_tel_mob       in varchar2,
                            p_branch        in varchar2,
                            p_notes         in varchar2,
                            p_date_val      in date,    --дата тіпа валютування
                            p_zip           in varchar2,
                            p_domain        in varchar2,
                            p_region        in varchar2,
                            p_locality      in varchar2,
                            p_address       in varchar2,
                            p_mfo           in compen_clients.mfo%type,
                            p_nls           in compen_clients.nls%type,
                            p_secondary     in compen_clients.secondary%type,-- 0 або 1 якщо представник
                            p_okpo          in compen_clients.okpo%type,
                            p_rnk           in out number);

  --Актуалізація
  --           p_opercode:
  --                          ACT_DEP - Актуалізація компенсаційного вкладу
  --                          ACT_BUR - Актуалізація компенсаційного вкладу на поховання
  procedure actualization_compen(p_rnk      in number,
                                 p_compenid in number,
                                 p_opercode in varchar2);

  procedure deactualization_compen(p_rnk         in number,
                                   p_compen_list in number_list default number_list(),
                                   p_opercode in varchar2 default 'ACT_DEP');

  --сформувати реєстр по новим актуалізованим вкладам
  --           p_opercode:
  --                          PAY_DEP - сформувати реєстр на виплату компенсанційного вкладу
  --                          PAY_BUR - сформувати реєстр на виплату компенсанційного вкладу на поховання
  procedure create_payments_registry(p_opercode    compen_oper_types.oper_code%type default 'PAY_DEP',
                                     p_data_from   compen_clients.date_val_reg%type,
                                     p_date_to     compen_clients.date_val_reg%type);

  --повернути скільки платежів і на яку суму планується
  procedure get_payments_compen_xml(p_regcode     varchar2,
                                     p_data_from   compen_payments_registry.date_val_reg%type,
                                     p_date_to     compen_payments_registry.date_val_reg%type,
                                     p_sum         OUT number,
                                     p_cnt         OUT number);

  --відправити виплати(потенційні) в ГРЦ (xml)
  --           p_regcode:
  --                          PAY_DEP - компенсанційні вклади
  --                          PAY_BUR - компенсанційні вклади на поховання
  procedure send_payments_compen_xml(p_regcode     varchar2,
                                     p_data_from   compen_payments_registry.date_val_reg%type,
                                     p_date_to     compen_payments_registry.date_val_reg%type,
                                     p_sum         OUT number,
                                     p_cnt         OUT number);

  /*
    --процедура для ребранчингу при актуалізації для job
    procedure send_batch_rebranch_for_job;
  */

  --Відкриття нового вкладу і зачислення коштів спадкоємцю
  procedure open_new_compen_transfer(p_rnk              in number,
                                     p_compen_donor_id  in number,
                                     p_amount      in number);
  --Відкриття/модифікація бенефіціара
  procedure registr_benef(p_id_compen   in number,
                          p_code        in varchar2,
                          p_fio         in varchar2,
                          p_country     in integer,
                          p_fulladdress in varchar2,
                          p_icod        in varchar2,
                          p_doctype     in integer,
                          p_docserial   in varchar2,
                          p_docnumber   in varchar2,
                          p_eddr_id     in varchar2,--Запис № (для ID картки 8 цифр,дефіс,5 цифр)
                          p_docorgb     in varchar2,
                          p_docdate     in date,
                          p_cliebtbdate in date,
                          p_clientsex   in varchar2,
                          p_clientphone in varchar2,
                          p_percent     in number,
                          p_idb         in out number,
                          p_without_oper in char default null);


  --зміна статусу вкладу
  procedure set_compen_status(p_compen_id            compen_portfolio.id%type,
                              p_status_id            compen_portfolio.status%type,
                              p_reason_change_status compen_portfolio.reason_change_status%type default null,
                              p_unblock              number default null);

  /* Функція вертає список вкладів з яких можна поповнити
        * p_nsc - Номер книжки                  --|}_для відображення всіх неактуалізованих по заданним параметрам
          p_fio - Фільтр по прізвищу            --|}                   та актуалізованих у своему МФО
          p_compen_id - Якщо вказаний то тільки його
  */
  function get_compens_write_down(p_nsc         compen_portfolio.nsc%type,
                                  p_fio         compen_portfolio.fio%type default null,
                                  p_compen_id   compen_portfolio.id%type default null)
  return sys_refcursor;

  --розрахувати суму на виплату
  function get_payment_amount(p_rnk in number) return number;

  procedure delete_benef(p_id_compen    number,
                         p_idb          integer,
                         p_without_oper char default null);

  procedure set_compen_param_value(p_param     compen_params.par%type,
                                   p_type      compen_params.type%type,
                                   p_id        compen_params_data.id%type,
                                   p_val       compen_params_data.val%type,
                                   p_kf        compen_params_data.kf%type,
                                   p_branch    compen_params_data.branch%type,
                                   p_all       number,
                                   p_date_from compen_params_data.date_from%type,
                                   p_date_to   compen_params_data.date_to%type,
                                   p_is_enable compen_params_data.is_enable%type,
                                   p_err_code  out number,
                                   p_err_text  out varchar2);

  /*
  procedure send_rebranch(p_summa      in varchar2,
                          p_ob22       in varchar2,
                          p_branchfrom in varchar2,
                          p_branchto   in varchar2,
                          p_err        out varchar2,
                          p_ret        out int);
                          */

 --зміна документа на вкладі в разі смерті вкладника або оформлення спадщини
  procedure change_compen_document(p_compen_id      compen_portfolio.id%type,
                                   p_doc_type       passp.passp%type,
                                   p_ser            compen_portfolio.docserial%type,
                                   p_numdoc         compen_portfolio.docnumber%type,
                                   p_date_of_issue  compen_portfolio.docdate%type,
                                   p_organ          compen_portfolio.docorg%type,
                                   p_type_person    compen_portfolio.type_person%type,
                                   p_name_person    compen_portfolio.name_person%type default null,
                                   p_edrpo_person   compen_portfolio.edrpo_person%type default null                                   
                                   );

  --заблокувати записи реєстру на формування платежу
  procedure set_registry_status_block(p_reg_list       number_list default number_list(),
                                      p_info     out   varchar2);
  --розаблокувати записи реєстру на формування платежу
  procedure set_registry_status_no_block(p_reg_list       number_list default number_list(),
                                      p_info     out   varchar2);

  --повертає в цілому(в РОЗРІЗІ аткуал/актуал на поховання) по системі дані по новим актуалізаціям та сформованим виплатам
  --           p_regcode:
  --                          PAY_DEP - компенсанційні вклади
  --                          PAY_BUR - компенсанційні вклади на поховання
  procedure get_stat_registry(p_regcode                    varchar2,
                              p_count_compen_all out       number, --всього вкладів в ЦРКР (не в розрізі актуал/актуал на поховання)
                              p_count_act_all    out       number, --всього клієнтів в ЦРКР(не в розрізі актуал/актуал на поховання)
                              p_count_act_reg    out       number, --всього клієнтів які в списку реєстру
                              p_count_compen_reg out       number, --всього актуалізованих вкладів
                              p_count_compen_new out       number, --нові актуалізації вкладів (не враховані в реєстрі)
                              p_sum_state_new    out       number, --сума планових виплат(у тому числі і спроба відправки, але отримано помилку)
                              p_sum_state_formed out       number, --сума сформованих виплат на очікувані візи в АБС
                              p_sum_state_payed  out       number, --сума сформованих виплат, які оплачені
                              p_sum_state_block  out       number, --сума планових виплат, які заблоковані для формування платежів
                              p_date_first       out       date,   --дата першої актуалізації
                              p_date_last        out       date    --дата останньої актуалізації
  );


  /*Для операціоніста кнопка Додати у реєстр (на поховання)*/
    --вже не має цієї кнопки. автодобавлялка на єтапі візування контролера підрозділа
  procedure add_to_registry_bur(p_compen_id     compen_portfolio.id%type);

  --Накласти візу на операції (Бєк-офіс)
  --Тільки на запити на відміну актуалізацій
  procedure apply_act_visa_bk(p_oper_list in number_list default number_list());
 --Накласти візу на операції(Контрлер)
  procedure apply_act_visa(p_oper_list in number_list default number_list());
  --Повернути виконавцю (Контрлер)
  procedure refuse_act_visa(p_oper_list in number_list default number_list(), p_reason varchar2);
/*  --Виявлена помилка (Контрлер)
  procedure error_act_visa(p_oper_list in number_list default number_list(), p_reason varchar2);*/

  --Само віза на операції(Опер)
  procedure apply_act_visa_self(p_oper_list in number_list default number_list());
  --Само сторно на операціях(Опер)
  procedure refuse_act_visa_self(p_oper_list in number_list default number_list(), p_reason varchar2);

  --Повернути виконавцю
  procedure refuse_act_visa_bk(p_oper_list in number_list default number_list(), p_reason varchar2);

  --Зробити запити по створеним виплатам в ГРЦ для перевірки на рахунок візування
  --For JOB
  procedure request_grc_state_oper;

    --процедура ребранчінга вкладів
  procedure rebranch_crca(p_branch_from      branch.branch%type,
                          p_branch_to        branch.branch%type,
                          p_res         out  varchar2);

 --повертає тіпа дати валютування
  function get_planned_day return date;

    --Якщо є планові виплати або на візуванні в АБС відмінити їх по клієнту, видалити інформацію з реєстру(при можливості)
  procedure cancel_reg_pay(p_rnk        in number,
                           p_regcode    varchar2,
                           p_add_msg    varchar2);


  function convert_doctype_asvo_to_crkr(p_doctype number) return number;

--поверне інформацію по плановій зміні документу
  function get_compen_new_doc(p_compen_id compen_portfolio.id%type)
  return sys_refcursor;

  --Запит на деактуалізацію вкладів
  --           p_opercode:
  --                          REQ_DEACT_DEP - Запит на відміну Актуалізація компенсаційного вкладу
  --                          REQ_DEACT_BUR - Запит на відміну Актуалізація компенсаційного вкладу на поховання
  procedure request_deactualization_compen(p_rnk         in number,
                                           p_compen_list in number_list default number_list(),
                                           p_opercode    in varchar2 default 'REQ_DEACT_DEP',
                                           p_reason      in varchar2 default null
                                           );

  function f_dbcode(p_doc_type number, p_ser varchar2, p_numdoc varchar2) return varchar2;

  --0 - не існує
  --1 - клієнт з таким документом вже є
  function check_customer_by_document(p_passp       passp.passp%type,
                                      p_ser         person.ser%type,
                                      p_docnum      person.numdoc%type,
                                      p_eddr_id     person.eddr_id%type,
                                      p_secondary   compen_clients.secondary%type,
                                      p_branch_name out branch.name%type)
  return number;
  
  --Розблокування вкладу БЄК-офісом
  procedure unblock_compen(p_compen_id compen_portfolio.id%type);
  
  function analiz_change_benef(p_compen_id compen_benef.id_compen%type, p_idb compen_benef.idb%type)
    return varchar2;

end crkr_compen_web;
/