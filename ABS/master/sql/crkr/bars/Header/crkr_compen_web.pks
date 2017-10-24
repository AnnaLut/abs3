create or replace package crkr_compen_web is

  -- Author  : OLEG.MUZYKA
  -- Created : 26.07.2016 15:47:22
  -- Purpose : ����� �� ����� � ����������� ������� �������������� �������

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
                            p_numdoc        in varchar2,--�������� � (��� ID ������ 9 ����)
                            p_date_of_issue in date,
                            p_organ         in varchar2,
                            p_eddr_id       in varchar2,--����� � (��� ID ������ 8 ����,�����,5 ����)
                            p_actual_date   in date,
                            p_country_id    in number,
                            p_bplace        in varchar2,
                            p_tel           in varchar2,
                            p_tel_mob       in varchar2,
                            p_branch        in varchar2,
                            p_notes         in varchar2,
                            p_date_val      in date,    --���� ��� �����������
                            p_zip           in varchar2,
                            p_domain        in varchar2,
                            p_region        in varchar2,
                            p_locality      in varchar2,
                            p_address       in varchar2,
                            p_mfo           in compen_clients.mfo%type,
                            p_nls           in compen_clients.nls%type,
                            p_secondary     in compen_clients.secondary%type,-- 0 ��� 1 ���� �����������
                            p_okpo          in compen_clients.okpo%type,
                            p_rnk           in out number);

  --�����������
  --           p_opercode:
  --                          ACT_DEP - ����������� ��������������� ������
  --                          ACT_BUR - ����������� ��������������� ������ �� ���������
  procedure actualization_compen(p_rnk      in number,
                                 p_compenid in number,
                                 p_opercode in varchar2);

  procedure deactualization_compen(p_rnk         in number,
                                   p_compen_list in number_list default number_list(),
                                   p_opercode in varchar2 default 'ACT_DEP');

  --���������� ����� �� ����� ������������� �������
  --           p_opercode:
  --                          PAY_DEP - ���������� ����� �� ������� ���������������� ������
  --                          PAY_BUR - ���������� ����� �� ������� ���������������� ������ �� ���������
  procedure create_payments_registry(p_opercode    compen_oper_types.oper_code%type default 'PAY_DEP',
                                     p_data_from   compen_clients.date_val_reg%type,
                                     p_date_to     compen_clients.date_val_reg%type);

  --��������� ������ ������� � �� ��� ���� ���������
  procedure get_payments_compen_xml(p_regcode     varchar2,
                                     p_data_from   compen_payments_registry.date_val_reg%type,
                                     p_date_to     compen_payments_registry.date_val_reg%type,
                                     p_sum         OUT number,
                                     p_cnt         OUT number);

  --��������� �������(���������) � ��� (xml)
  --           p_regcode:
  --                          PAY_DEP - ������������� ������
  --                          PAY_BUR - ������������� ������ �� ���������
  procedure send_payments_compen_xml(p_regcode     varchar2,
                                     p_data_from   compen_payments_registry.date_val_reg%type,
                                     p_date_to     compen_payments_registry.date_val_reg%type,
                                     p_sum         OUT number,
                                     p_cnt         OUT number);

  /*
    --��������� ��� ����������� ��� ����������� ��� job
    procedure send_batch_rebranch_for_job;
  */

  --³������� ������ ������ � ���������� ����� ���������
  procedure open_new_compen_transfer(p_rnk              in number,
                                     p_compen_donor_id  in number,
                                     p_amount      in number);
  --³�������/����������� �����������
  procedure registr_benef(p_id_compen   in number,
                          p_code        in varchar2,
                          p_fio         in varchar2,
                          p_country     in integer,
                          p_fulladdress in varchar2,
                          p_icod        in varchar2,
                          p_doctype     in integer,
                          p_docserial   in varchar2,
                          p_docnumber   in varchar2,
                          p_eddr_id     in varchar2,--����� � (��� ID ������ 8 ����,�����,5 ����)
                          p_docorgb     in varchar2,
                          p_docdate     in date,
                          p_cliebtbdate in date,
                          p_clientsex   in varchar2,
                          p_clientphone in varchar2,
                          p_percent     in number,
                          p_idb         in out number,
                          p_without_oper in char default null);


  --���� ������� ������
  procedure set_compen_status(p_compen_id            compen_portfolio.id%type,
                              p_status_id            compen_portfolio.status%type,
                              p_reason_change_status compen_portfolio.reason_change_status%type default null,
                              p_unblock              number default null);

  /* ������� ����� ������ ������ � ���� ����� ���������
        * p_nsc - ����� ������                  --|}_��� ����������� ��� ��������������� �� �������� ����������
          p_fio - Գ���� �� �������            --|}                   �� ������������� � ������ ���
          p_compen_id - ���� �������� �� ����� ����
  */
  function get_compens_write_down(p_nsc         compen_portfolio.nsc%type,
                                  p_fio         compen_portfolio.fio%type default null,
                                  p_compen_id   compen_portfolio.id%type default null)
  return sys_refcursor;

  --����������� ���� �� �������
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

 --���� ��������� �� ����� � ��� ����� ��������� ��� ���������� ��������
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

  --����������� ������ ������ �� ���������� �������
  procedure set_registry_status_block(p_reg_list       number_list default number_list(),
                                      p_info     out   varchar2);
  --������������� ������ ������ �� ���������� �������
  procedure set_registry_status_no_block(p_reg_list       number_list default number_list(),
                                      p_info     out   varchar2);

  --������� � ������(� ���вǲ ������/������ �� ���������) �� ������ ��� �� ����� ������������ �� ����������� ��������
  --           p_regcode:
  --                          PAY_DEP - ������������� ������
  --                          PAY_BUR - ������������� ������ �� ���������
  procedure get_stat_registry(p_regcode                    varchar2,
                              p_count_compen_all out       number, --������ ������ � ���� (�� � ����� ������/������ �� ���������)
                              p_count_act_all    out       number, --������ �볺��� � ����(�� � ����� ������/������ �� ���������)
                              p_count_act_reg    out       number, --������ �볺��� �� � ������ ������
                              p_count_compen_reg out       number, --������ ������������� ������
                              p_count_compen_new out       number, --��� ����������� ������ (�� �������� � �����)
                              p_sum_state_new    out       number, --���� �������� ������(� ���� ���� � ������ ��������, ��� �������� �������)
                              p_sum_state_formed out       number, --���� ����������� ������ �� �������� ��� � ���
                              p_sum_state_payed  out       number, --���� ����������� ������, �� �������
                              p_sum_state_block  out       number, --���� �������� ������, �� ���������� ��� ���������� �������
                              p_date_first       out       date,   --���� ����� �����������
                              p_date_last        out       date    --���� �������� �����������
  );


  /*��� ������������ ������ ������ � ����� (�� ���������)*/
    --��� �� �� ���� ������. �������������� �� ���� �������� ���������� ��������
  procedure add_to_registry_bur(p_compen_id     compen_portfolio.id%type);

  --�������� ��� �� �������� (���-����)
  --ҳ���� �� ������ �� ����� �����������
  procedure apply_act_visa_bk(p_oper_list in number_list default number_list());
 --�������� ��� �� ��������(��������)
  procedure apply_act_visa(p_oper_list in number_list default number_list());
  --��������� ��������� (��������)
  procedure refuse_act_visa(p_oper_list in number_list default number_list(), p_reason varchar2);
/*  --�������� ������� (��������)
  procedure error_act_visa(p_oper_list in number_list default number_list(), p_reason varchar2);*/

  --���� ��� �� ��������(����)
  procedure apply_act_visa_self(p_oper_list in number_list default number_list());
  --���� ������ �� ���������(����)
  procedure refuse_act_visa_self(p_oper_list in number_list default number_list(), p_reason varchar2);

  --��������� ���������
  procedure refuse_act_visa_bk(p_oper_list in number_list default number_list(), p_reason varchar2);

  --������� ������ �� ��������� �������� � ��� ��� �������� �� ������� ��������
  --For JOB
  procedure request_grc_state_oper;

    --��������� ����������� ������
  procedure rebranch_crca(p_branch_from      branch.branch%type,
                          p_branch_to        branch.branch%type,
                          p_res         out  varchar2);

 --������� ��� ���� �����������
  function get_planned_day return date;

    --���� � ������ ������� ��� �� ������� � ��� ������� �� �� �볺���, �������� ���������� � ������(��� ���������)
  procedure cancel_reg_pay(p_rnk        in number,
                           p_regcode    varchar2,
                           p_add_msg    varchar2);


  function convert_doctype_asvo_to_crkr(p_doctype number) return number;

--������� ���������� �� ������� ��� ���������
  function get_compen_new_doc(p_compen_id compen_portfolio.id%type)
  return sys_refcursor;

  --����� �� ������������� ������
  --           p_opercode:
  --                          REQ_DEACT_DEP - ����� �� ����� ����������� ��������������� ������
  --                          REQ_DEACT_BUR - ����� �� ����� ����������� ��������������� ������ �� ���������
  procedure request_deactualization_compen(p_rnk         in number,
                                           p_compen_list in number_list default number_list(),
                                           p_opercode    in varchar2 default 'REQ_DEACT_DEP',
                                           p_reason      in varchar2 default null
                                           );

  function f_dbcode(p_doc_type number, p_ser varchar2, p_numdoc varchar2) return varchar2;

  --0 - �� ����
  --1 - �볺�� � ����� ���������� ��� �
  function check_customer_by_document(p_passp       passp.passp%type,
                                      p_ser         person.ser%type,
                                      p_docnum      person.numdoc%type,
                                      p_eddr_id     person.eddr_id%type,
                                      p_secondary   compen_clients.secondary%type,
                                      p_branch_name out branch.name%type)
  return number;
  
  --������������� ������ ���-������
  procedure unblock_compen(p_compen_id compen_portfolio.id%type);
  
  function analiz_change_benef(p_compen_id compen_benef.id_compen%type, p_idb compen_benef.idb%type)
    return varchar2;

end crkr_compen_web;
/