
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/wcs_utl.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.WCS_UTL is

  -- ===============================================================================================
  g_header_version constant varchar2(64) := 'version 1.1 02/07/2015';
  -- ���������� ������ ��������� ������
  function header_version return varchar2;
  -- ���������� ������ ���� ������
  function body_version return varchar2;
  -- ===============================================================================================
  -- Public variable declarations
  g_cur_ws_id wcs_answers.ws_id%type := 'MAIN';
  function get_ws_id return wcs_answers.ws_id%type;
  procedure set_ws_id(p_val wcs_answers.ws_id%type);
  g_cur_ws_num wcs_answers.ws_number%type := 0;
  function get_ws_num return wcs_answers.ws_number%type;
  procedure set_ws_num(p_val wcs_answers.ws_number%type);

  g_rs_id wcs_jobs.rs_id%type;
  function get_rs_id return wcs_jobs.rs_id%type;
  procedure set_rs_id;
  -- ===============================================================================================
  -- Public types declarations
  -- ��������� ���
  type t_gpk_rec is record(
    bid_id         varchar2(100), -- ����� ������
    build_date     date, -- ���� ����������
    pmt_id         number, -- ����� �������
    pmt_date       date, -- ���� �������
    pmt_in_bal     number, -- �������� ������� �� �������
    pmt_body       number, -- ������ �� ����
    pmt_body_total number, -- ������� ����� �������� �� ����
    pmt_interest   number, -- ������ �� ���������
    pmt_total      number, -- ����� ������
    pmt_out_bal    number -- ��������� ������� �� �������
    );

  -- ������ �������� ���
  type t_gpk_table is table of t_gpk_rec;

  -- ��������� ������� ������������ � ��������
  type t_scor_quest_rec is record(
    scoring_id  varchar2(100), -- ������������� ����. �����
    question_id varchar2(100) -- ������������� �������
    );

  -- ������ �������� �������� ����������� � ��������
  type t_scor_quest_table is table of t_scor_quest_rec;

  -- ��������� ��������� ���������� ������������ ������
  type t_phases_tlims_rec is record(
    bid_id       number, -- ������������� ������
    phase_id     varchar2(100), -- ������������� �����
    phase_start  date, -- ���� ������ �����
    phase_end    date, -- ���� ��������� �����
    proc_start   date, -- ���� ������ ��������� �����
    proc_end     date, -- ���� ��������� ��������� �����
    proc_user_id number -- �� ������������ ��������������� ������
    );

  -- ������ �������� ��������� ���������� ������������ ������
  type t_phases_tlims_table is table of t_phases_tlims_rec;

  -- ����� ����� ��������������� ��������
  type t_array_varchar2 is table of varchar2(200) index by varchar2(200);
  -- ===============================================================================================

  -- �������������� ���-�� ���� � ������ ������� 1� 1� 1��
  function get_formated_days_string(p_days in number -- ���-�� ����
                                    ) return varchar2;

  -- ������ sql
  /* ����� ������������� ��������:

  :#<���>%A-<��������>%T-<���>%WS-<������� ������������>%WSN-<����� �������� ������������>%VAL-<�������� ���������������� ���������>%SCR-<��� ����������� �����>#

  <���>:
     ��� ���������
  <��������>:
     G - �����
     S - ����������

     default - G
  <���>:
     Q - ������
     QF - ������ ���������������
     M - ���
     S - ����������� ��� �������
     SG - ����������� ��� �����
     � - ���������

     default - Q
  <������� ������������>:
     ��� �������� ������������

     default - MAIN
  <����� �������� ������������>:
     ����� �������� ������������

     default - 0
  <�������� ���������������� ���������>:
     ��������� ������������� ��������
  <��� ����������� �����>:
     ��� ����������� ����� ��� �������� ��������

  ������:
  �������� ��� �������: :#CL_1%A-G%T-Q%WS-MAIN%WSN-0# ��� :#CL_1#
  �������� ��� 1-�� ����������: :#CL_1%A-G%T-Q%WS-GRT_GUARANTOR%WSN-0# ��� :#CL_1%WS-GRT_GUARANTOR#
     */
  function parse_sql(p_bid_id    wcs_bids.id%type, -- ������������� ������
                     p_plsql     varchar2, -- sql ����
                     p_ws_id     wcs_answers.ws_id%type default g_cur_ws_id, -- ������������� �������� ������������
                     p_ws_number wcs_answers.ws_number%type default g_cur_ws_num -- ����� �������� ������������
                     ) return varchar2; -- ����������� sql ����

  -- ������ sql (clob)
  function parse_sql(p_bid_id    wcs_bids.id%type, -- ������������� ������
                     p_plsql     clob, -- sql ����
                     p_ws_id     wcs_answers.ws_id%type default g_cur_ws_id, -- ������������� �������� ������������
                     p_ws_number wcs_answers.ws_number%type default g_cur_ws_num -- ����� �������� ������������
                     ) return clob; -- ����������� sql ����

  -- ��������� pl/sql ���� � ����:
  /*declare
      l_bid_id := ������� ������
      l_question_id := ������� ������
  begin
  --------------------
  ---- pl/sql ���� ---
  --------------------
  end

  ��� ������� ���������� ('����� ������'), ��� - (null) */
  function exec_sql(bid_id_      number, -- ������������� ������
                    question_id_ varchar2, -- ������������� �������
                    plsql_       varchar2, -- sql ����
                    p_ws_id      wcs_answers.ws_id%type default g_cur_ws_id, -- ������������� �������� ������������
                    p_ws_number  wcs_answers.ws_number%type default g_cur_ws_num -- ����� �������� ������������
                    ) return varchar2; -- ��������� ����������

  -- ��������� ����������� pl/sql ����
  /* ��� ����������� ���������� �������� ('����� ������ ��������') pl/sql ����
  ������ ������� ���������� (bars_error), ��� �������������� (null) ������
  ����������� ��� ������ */
  function exec_check(bid_id_     number, -- ������������� ������
                      plsql_      varchar2, -- sql ����
                      p_ws_id     wcs_answers.ws_id%type default g_cur_ws_id, -- ������������� �������� ������������
                      p_ws_number wcs_answers.ws_number%type default g_cur_ws_num -- ����� �������� ������������
                      ) return varchar2; -- ��������� ��������

  -- ��������� �������� sql ������
  function calc_sql_line(bid_id_     number, -- ������������� ������
                         plsql_line_ varchar2, -- sql ������
                         p_ws_id     wcs_answers.ws_id%type default g_cur_ws_id, -- ������������� �������� ������������
                         p_ws_number wcs_answers.ws_number%type default g_cur_ws_num -- ����� �������� ������������
                         ) return varchar2; -- ��������� ����������

  -- ��������� �������� �������� sql ���������
  function calc_sql_bool(bid_id_     number, -- ������������� ������
                         plsql_bool_ varchar2, -- ������� sql ���������
                         p_ws_id     wcs_answers.ws_id%type default g_cur_ws_id, -- ������������� �������� ������������
                         p_ws_number wcs_answers.ws_number%type default g_cur_ws_num -- ����� �������� ������������
                         ) return number; -- ��������� ����������

  -- ���� �� ����� �� ������
  function has_answ(p_bid_id      wcs_answers.bid_id%type, -- ������������� ������
                    p_question_id wcs_answers.question_id%type, -- ������������� �������
                    p_ws_id       wcs_answers.ws_id%type default g_cur_ws_id, -- ������������� �������� ������������
                    p_ws_number   wcs_answers.ws_number%type default g_cur_ws_num -- ����� �������� ������������
                    ) return number; -- ����� ���� - 1, ��� - 0

  -- ���������� �������� ������ (�������)
  function get_answ(p_bid_id      wcs_answers.bid_id%type, -- ������������� ������
                    p_question_id wcs_answers.question_id%type, -- ������������� �������
                    p_ws_id       wcs_answers.ws_id%type default get_ws_id, -- ������������� �������� ������������
                    p_ws_number   wcs_answers.ws_number%type default get_ws_num -- ����� �������� ������������
                    ) return varchar2; -- �������� ������

  -- ���������� ����������� �������� ������ ������� TEXT
  function get_answ_text(p_bid_id      wcs_answers.bid_id%type, -- ������������� ������
                         p_question_id wcs_answers.question_id%type, -- ������������� �������
                         p_ws_id       wcs_answers.ws_id%type default get_ws_id, -- ������������� �������� ������������
                         p_ws_number   wcs_answers.ws_number%type default get_ws_num -- ����� �������� ������������
                         ) return wcs_answers.val_text%type; -- �������� ������

  -- ���������� ����������� �������� ������ ������� NUMB
  function get_answ_numb(p_bid_id      wcs_answers.bid_id%type, -- ������������� ������
                         p_question_id wcs_answers.question_id%type, -- ������������� �������
                         p_ws_id       wcs_answers.ws_id%type default get_ws_id, -- ������������� �������� ������������
                         p_ws_number   wcs_answers.ws_number%type default get_ws_num -- ����� �������� ������������
                         ) return wcs_answers.val_numb%type; -- �������� ������

  -- ���������� ����������� �������� ������ ������� DECIMAL
  function get_answ_decimal(p_bid_id      wcs_answers.bid_id%type, -- ������������� ������
                            p_question_id wcs_answers.question_id%type, -- ������������� �������
                            p_ws_id       wcs_answers.ws_id%type default get_ws_id, -- ������������� �������� ������������
                            p_ws_number   wcs_answers.ws_number%type default get_ws_num -- ����� �������� ������������
                            ) return wcs_answers.val_decimal%type; -- �������� ������

  -- ���������� ����������� �������� ������ ������� DATE
  function get_answ_date(p_bid_id      wcs_answers.bid_id%type, -- ������������� ������
                         p_question_id wcs_answers.question_id%type, -- ������������� �������
                         p_ws_id       wcs_answers.ws_id%type default get_ws_id, -- ������������� �������� ������������
                         p_ws_number   wcs_answers.ws_number%type default get_ws_num -- ����� �������� ������������
                         ) return wcs_answers.val_date%type; -- �������� ������

  -- ���������� ����������� �������� ������ ������� LIST
  function get_answ_list(p_bid_id      wcs_answers.bid_id%type, -- ������������� ������
                         p_question_id wcs_answers.question_id%type, -- ������������� �������
                         p_ws_id       wcs_answers.ws_id%type default get_ws_id, -- ������������� �������� ������������
                         p_ws_number   wcs_answers.ws_number%type default get_ws_num -- ����� �������� ������������
                         ) return wcs_answers.val_list%type; -- �������� ������

  -- ���������� ����������� �������� ������ ������� LIST (��������� ��������)
  function get_answ_list_text(p_bid_id      wcs_answers.bid_id%type, -- ������������� ������
                              p_question_id wcs_answers.question_id%type, -- ������������� �������
                              p_ws_id       wcs_answers.ws_id%type default get_ws_id, -- ������������� �������� ������������
                              p_ws_number   wcs_answers.ws_number%type default get_ws_num -- ����� �������� ������������
                              ) return wcs_question_list_items.text%type; -- �������� ������

  -- ���������� ����������� �������� ������ ������� REFER
  function get_answ_refer(p_bid_id      wcs_answers.bid_id%type, -- ������������� ������
                          p_question_id wcs_answers.question_id%type, -- ������������� �������
                          p_ws_id       wcs_answers.ws_id%type default get_ws_id, -- ������������� �������� ������������
                          p_ws_number   wcs_answers.ws_number%type default get_ws_num -- ����� �������� ������������
                          ) return wcs_answers.val_refer%type; -- �������� ������

  -- ���������� ����������� �������� ������ ������� REFER (�����)
  function get_answ_refer_text(p_bid_id      wcs_answers.bid_id%type, -- ������������� ������
                               p_question_id wcs_answers.question_id%type, -- ������������� �������
                               p_ws_id       wcs_answers.ws_id%type default get_ws_id, -- ������������� �������� ������������
                               p_ws_number   wcs_answers.ws_number%type default get_ws_num -- ����� �������� ������������
                               ) return wcs_answers.val_refer%type; -- �������� ������

  -- ���������� ����������� �������� ������ ������� BOOL
  function get_answ_bool(p_bid_id      wcs_answers.bid_id%type, -- ������������� ������
                         p_question_id wcs_answers.question_id%type, -- ������������� �������
                         p_ws_id       wcs_answers.ws_id%type default get_ws_id, -- ������������� �������� ������������
                         p_ws_number   wcs_answers.ws_number%type default get_ws_num -- ����� �������� ������������
                         ) return wcs_answers.val_bool%type; -- �������� ������

  -- ���������� �������� ������ ���� blob
  function get_answ_blob(p_bid_id      wcs_answers.bid_id%type, -- ������������� ������
                         p_question_id wcs_answers.question_id%type, -- ������������� �������
                         p_ws_id       wcs_answers.ws_id%type default get_ws_id, -- ������������� �������� ������������
                         p_ws_number   wcs_answers.ws_number%type default get_ws_num -- ����� �������� ������������
                         ) return blob; -- �������� ������

  -- ���������� �������� ������ ���� XML
  function get_answ_xml(p_bid_id      wcs_answers.bid_id%type, -- ������������� ������
                        p_question_id wcs_answers.question_id%type, -- ������������� �������
                        p_ws_id       wcs_answers.ws_id%type default get_ws_id, -- ������������� �������� ������������
                        p_ws_number   wcs_answers.ws_number%type default get_ws_num -- ����� �������� ������������
                        ) return wcs_answers.val_xml%type; -- �������� ������

  -- ���������� �������� ������ �������������� (�������)
  function get_answ_formated(p_bid_id      wcs_answers.bid_id%type, -- ������������� ������
                             p_question_id wcs_answers.question_id%type, -- ������������� �������
                             p_for_export  number default 0, -- �������� ��������� ������� �������
                             p_ws_id       wcs_answers.ws_id%type default get_ws_id, -- ������������� �������� ������������
                             p_ws_number   wcs_answers.ws_number%type default get_ws_num -- ����� �������� ������������
                             ) return varchar2;

  -- ����������� ��������� �������� �� ��������� ����
  function get_val_formated(p_val         varchar2, -- �������� � ������
                            p_type        varchar2, -- ��� �������� (TEXT, NUMB, DECIMAL, DATE, LIST_QUEST, LIST_MAC, REFER_QUEST, REFER_MAC, BOOL)
                            p_bid_id      wcs_bids.id%type default null, -- ������������� ������
                            p_ws_id       wcs_answers.ws_id%type default g_cur_ws_id, -- ������������� �������� ������������
                            p_ws_number   wcs_answers.ws_number%type default g_cur_ws_num, -- ����� �������� ������������
                            p_question_id wcs_questions.id%type default null, -- ������������� ������� ��� ����� �������� � ���������
                            p_mac_id      wcs_macs.id%type default null -- ������������� ���� ��� ����� �������� � ���������
                            ) return varchar2;

  -- ���������� �������� ������ (�������)
  procedure calc_answ(p_bid_id      wcs_answers.bid_id%type, -- ������������� ������
                      p_question_id wcs_answers.question_id%type, -- ������������� �������
                      p_ws_id       wcs_answers.ws_id%type default g_cur_ws_id, -- ������������� �������� ������������
                      p_ws_number   wcs_answers.ws_number%type default g_cur_ws_num -- ����� �������� ������������
                      );

  -- �������� ������������ ������� �� ��������������
  function get_quest_name(p_question_id wcs_questions.id%type -- ������������� �������
                          ) return varchar2; -- ������������ �������

  -- ������������� �������� ������ (�������)
  procedure set_answ(p_bid_id      wcs_answers.bid_id%type, -- ������������� ������
                     p_question_id wcs_answers.question_id%type, -- ������������� �������
                     p_val         varchar2, -- ��������
                     p_ws_id       wcs_answers.ws_id%type default g_cur_ws_id, -- ������������� �������� ������������
                     p_ws_number   wcs_answers.ws_number%type default g_cur_ws_num -- ����� �������� ������������
                     );

  -- ��������� ��. ������� �������� ��������� �������
  function get_creditdata_qid(p_bid_id     wcs_answers.bid_id%type, -- ������������� ������
                              p_crddata_id wcs_creditdata_base.id%type -- ������������� �������� ���������
                              ) return varchar2; -- �������� ������

  -- ��������� ������� ���������� ������� �� ������ (�������)
  function get_creditdata(p_bid_id     wcs_answers.bid_id%type, -- ������������� ������
                          p_crddata_id wcs_creditdata_base.id%type -- ������������� �������� ���������
                          ) return varchar2; -- �������� ������

  -- ���������� �������� ���� ����
  function get_sbp_mac_blob(p_subproduct_id wcs_subproduct_macs.subproduct_id%type, -- ������������� �����������
                            p_mac_id        wcs_subproduct_macs.mac_id%type, -- ������������� ����
                            p_branch        wcs_subproduct_macs.branch%type default null, -- ���������
                            p_apply_date    wcs_subproduct_macs.apply_date%type default null -- ���������
                            ) return blob; -- �������� ����

  -- ���������� �������� ���� (�������)
  function get_sbp_mac(p_subproduct_id wcs_subproduct_macs.subproduct_id%type, -- ������������� �����������
                       p_mac_id        wcs_subproduct_macs.mac_id%type, -- ������������� ����
                       p_branch        wcs_subproduct_macs.branch%type default null, -- ���������
                       p_apply_date    wcs_subproduct_macs.apply_date%type default null -- ���������
                       ) return varchar2; -- �������� ����

  -- ���������� �������� ���� �������������� (�������)
  function get_sbp_mac_formated(p_subproduct_id wcs_subproduct_macs.subproduct_id%type, -- ������������� �����������
                                p_mac_id        wcs_subproduct_macs.mac_id%type, -- ������������� ����
                                p_branch        wcs_subproduct_macs.branch%type default null, -- ���������
                                p_apply_date    wcs_subproduct_macs.apply_date%type default null -- ���������
                                ) return varchar2; -- �������� ����

  -- ���������� �������� ���� (�������)
  function get_mac(p_bid_id wcs_bids.id%type, -- ������������� ������
                   p_mac_id wcs_macs.id%type -- ������������� ����
                   ) return varchar2; -- �������� ����

  -- ���������� �������������� �������� ���� (�������)
  function get_mac_formated(p_bid_id wcs_bids.id%type, -- ������������� ������
                            p_mac_id wcs_macs.id%type -- ������������� ����
                            ) return varchar2; -- �������� ����

  -- ������������ ����������� ����� �������
  function get_score(p_bid_id      wcs_answers.bid_id%type, -- ������������� ������
                     p_scoring_id  wcs_scorings.id%type, -- ������������� ����� ��������
                     p_question_id wcs_answers.question_id%type, -- ������������� �������
                     p_ws_id       wcs_answers.ws_id%type default g_cur_ws_id, -- ������������� �������� ������������
                     p_ws_number   wcs_answers.ws_number%type default g_cur_ws_num -- ����� �������� ������������
                     ) return number; -- ����������� �����

  -- ������������ �������������� ��� �����������
  function calc_kzb(p_bid_id wcs_answers.bid_id%type) return number;

  -- ������������ ����������� ����� ����� ��������
  function get_general_score(p_bid_id     wcs_answers.bid_id%type, -- ������������� ������
                             p_scoring_id wcs_scorings.id%type, -- ������������� ����� ��������
                             p_type       varchar2, -- ��� ������� ���� ����� (STANDART - �����������, OBU - ���������� ���)
                             p_ws_id      wcs_answers.ws_id%type default g_cur_ws_id, -- ������������� �������� ������������
                             p_ws_number  wcs_answers.ws_number%type default g_cur_ws_num -- ����� �������� ������������
                             ) return number; -- ����������� �����

  -- ��������� �������� ����-�������/-�������
  function get_stop(p_bid_id  number, -- ������������� ������
                    p_stop_id varchar2 -- ������������� �����
                    ) return number; -- �������� ����-�������

  -- ������ ������ ������ � ������� �� ����������
  procedure setup_iquery(p_bid_id      wcs_jobs.bid_id%type, -- ������������� ������
                         p_iquery_id   wcs_jobs.iquery_id%type, -- ������������� ��������������� �������
                         p_rs_id       wcs_jobs.rs_id%type, -- ������������� ������ �������
                         p_rs_iqs_tcnt wcs_jobs.rs_iqs_tcnt%type, -- ���-�� ����-�������� � ������ �������
                         p_rs_state_id wcs_jobs.rs_state_id%type, -- ��������� ������ �������
                         p_lag         in number default 0);

  -- ��������� ������ ������, ������������� ��������
  procedure run_iquery(p_bid_id    number, -- ������������� ������
                       p_iquery_id varchar2 -- ������������� ��������������� �������
                       );

  -- ����������� ���������� ������ �������
  procedure stop_iquery(p_bid_id    wcs_jobs.bid_id%type, -- ������������� ������
                        p_iquery_id wcs_jobs.iquery_id%type, -- ������������� ��������������� �������
                        p_ws_id     wcs_workspaces.id%type default 'MAIN', -- ������������� ������������� �������� ������������
                        p_status_id wcs_jobs.status_id%type default 'DONE', -- ������������� ������� JOB�
                        p_err_msg   wcs_jobs.err_msg%type default null -- ����� ������
                        );

  /*
    -- �������������� ������ �� ������ �� CC_interactive
    procedure bid_prefill_from_ccinter(p_bid_id number -- ������������� ������
                                       );
    -- ��������� �������� ������ ��������, �� ������ ������
    function get_ccid(p_bid_id number -- ������������� ������
                      ) return varchar2;

    -- ��������� ���� ��������, �� ������ ������
    function get_ccdat1(p_bid_id number -- ������������� ������
                      ) return date;

    -- ����������� ��������� ������
    procedure bids_set_aside(p_bdate date -- ������� ���������� ����
                             );

    -- ��� ��������� ������
    function get_manager_fio(p_bid_id number -- ������������� ������
                             ) return varchar2;

    -- �������� �������� ��� �����
    function f_get_all_add_servises(p_bid_id number -- ������������� ������
                                    ) return varchar2;

    -- �������� �������� ������
    procedure clear_hanging_bids(p_bdate date -- ������� ���������� ����
                                 );

    -- ������ ������������ �������� � cc_docs
    procedure save_printed_doc(p_doc_scheme_id in varchar2, -- ������������� ������� ��������
                               p_bid_id        in number, -- ������������� ������
                               p_doc_text      clob -- ����� ������������ ��������
                               );
  */
  -- ���� �� � ������ �������� ��������� (0 - ���, 1 - ��)
  function check_bid_state_hist(p_bid_id   number, -- ������������� ������
                                p_state_id varchar2 -- ������������� ���������
                                ) return number;

  -- ����� �� ������ ���������
  function has_bid_state(p_bid_id   wcs_bid_states.bid_id%type, -- ������������� ������
                         p_state_id wcs_bid_states.state_id%type -- ������������ ���������
                         ) return number;

  -- ����� �� ������ ���������
  function had_bid_state(p_bid_id     wcs_bid_states_history.bid_id%type, -- ������������� ������
                         p_state_id   wcs_bid_states_history.state_id%type, -- ������������ ���������
                         p_checkouted wcs_bid_states_history.checkouted%type default null, -- �������������� �� ���������
                         p_cngaction  wcs_bid_states_history.change_action%type default null -- ��������
                         ) return number;

  -- ������ ������� ��������� ������ (������������ ����� �������)
  function get_bid_states(p_bid_id number -- ������������� ������
                          ) return varchar2;

  -- ������ ������� ����������� ������ (������������ ����� �������)
  function get_bid_garantees(p_bid_id number -- ������������� ������
                             ) return varchar2;

  -- ������ ���������� ����������� ����������� (������������ ����� �������)
  function get_sbp_garantees(p_subproduct_id wcs_subproduct_garantees.subproduct_id%type -- ������������� �����������
                             ) return varchar2;

  -- ������ ����������� ���������� (������������ ����� �������)
  function get_sbp_docs(p_subproduct_id wcs_subproduct_templates.subproduct_id%type -- ������������� �����������
                        ) return varchar2;

  -- ��������� ���������� �������
  procedure get_quest_params(p_bid_id             wcs_answers.bid_id%type, -- ������������� ������
                             p_question_id        wcs_answers.question_id%type, -- ������������� �������
                             p_text_leng_min      out number, -- ����������� ����� ���������� ����
                             p_text_leng_max      out number, -- ������������ ����� ���������� ����
                             p_text_val_default   out varchar2, -- ��������� �������� ���������� ����
                             p_text_width         out number, -- ������ ���������� ����
                             p_text_rows          out number, -- ���-�� ������ ���������� ����
                             p_nmbdec_val_min     out number, -- ����������� �������� �����
                             p_nmbdec_val_max     out number, -- ������������ �������� �����
                             p_nmbdec_val_default out number, -- ��������� �������� �����
                             p_dat_val_min        out date, -- ����������� �������� ����
                             p_dat_val_max        out date, -- ������������ �������� ����
                             p_dat_val_default    out date, -- ��������� �������� ����
                             p_list_sid_default   out number, -- ��������� �������� �������� �� ������
                             p_refer_sid_default  out varchar2, -- ��������� �������� �������� �� �����������
                             p_tab_id             out v_wcs_question_params.tab_id%type, -- ������������� ������� �����������
                             p_key_field          out v_wcs_question_params.key_field%type, -- �������� ����
                             p_semantic_field     out v_wcs_question_params.semantic_field%type, -- ���� ���������
                             p_show_fields        out v_wcs_question_params.show_fields%type, -- ���� ��� ����������� (������������ ����� �������)
                             p_where_clause       out v_wcs_question_params.where_clause%type, -- ������� ������ (������� ����� where)
                             p_bool_val_default   out number, -- ��������� �������� �������� �������
                             p_ws_id              wcs_answers.ws_id%type default g_cur_ws_id, -- ������������� �������� ������������
                             p_ws_number          wcs_answers.ws_number%type default g_cur_ws_num -- ����� �������� ������������
                             );

  -- ����� �� ������ ������ ��������� ������� � ������ ����� (������� �� ������)
  function has_sur_grp_quest_rel(p_survey_id   wcs_survey_group_questions.survey_id%type, -- ������������� ������
                                 p_sgroup_id   wcs_survey_group_questions.sgroup_id%type, -- ������������� �����
                                 p_question_id wcs_survey_group_questions.question_id%type -- ������������� �������
                                 ) return number;

  -- ����� �� ������ ������ ��������� ������� � ������ ����� (������� �� ���. �������������)
  function has_related_survey(p_survey_id   wcs_survey_group_questions.survey_id%type, -- ������������� ������
                              p_sgroup_id   wcs_survey_group_questions.sgroup_id%type, -- ������������� �����
                              p_question_id wcs_survey_group_questions.question_id%type -- ������������� �������
                              ) return number;

  -- ����� �� ������ ������ ������� ��������� ������� � �����������
  function has_related_creditdata(p_subproduct_id wcs_subproduct_creditdata.subproduct_id%type, -- ������������� �����������
                                  p_crddata_id    wcs_subproduct_creditdata.crddata_id%type -- ������������� �������
                                  ) return number;

  -- �������� �������������� ������� ����� ������
  procedure set_null_2_hided_quests(p_bid_id    wcs_bids.id%type, -- ������������� ������
                                    p_survey_id wcs_survey_group_questions.survey_id%type, -- ������������� ������
                                    p_sgroup_id wcs_survey_group_questions.sgroup_id%type, -- ������������� �����
                                    p_ws_id     wcs_answers.ws_id%type default g_cur_ws_id, -- ������������� �������� ������������
                                    p_ws_number wcs_answers.ws_number%type default g_cur_ws_num -- ����� �������� ������������
                                    );

  -- ������� ��������� �� ������� ��� ���� ����/���� � ������ �� � ������� �������
  function get_interest(p_in_bal        number,
                        p_interest_rate number,
                        p_date_start    date,
                        p_date_end      date) return number;

  -- ��������� ���������� �������� ��� (������ ���������, ���� ����/����)
  function get_gpk_ep(p_pmt_id        number, -- ������ ����� �������
                      p_build_date    date, -- ���� ������ ����������
                      p_credit_sum    number, -- ����� �������
                      p_credit_term   number, -- ���� �������
                      p_interest_rate number -- ������� % ������
                      ) return t_gpk_table
    pipelined;

  -- ��������� ���������� �������� ��� (������, ���� 30/360)
  function get_gpk_a(p_pmt_id        number, -- ������ ����� �������
                     p_build_date    date, -- ���� ������ ����������
                     p_credit_sum    number, -- ����� �������
                     p_credit_term   number, -- ���� �������
                     p_interest_rate number -- ������� % ������
                     ) return t_gpk_table
    pipelined;

  -- ��������� ���������� �������� ��� (� ���� ������, ������ ���������, ���� ����/����)
  function get_gpk_ae(p_pmt_id        number, -- ������ ����� �������
                      p_build_date    date, -- ���� ������ ����������
                      p_credit_sum    number, -- ����� �������
                      p_credit_term   number, -- ���� �������
                      p_interest_rate number -- ������� % ������
                      ) return t_gpk_table
    pipelined;

  -- ������� ��� ���������� ��� �������� �� ������ ������� � �������� ���������� ������
  function gpk_anuitent_by_month_nrates( p_date_credit in date, -- ���� ��������
                                           p_sum_credit in number, -- �������� ������
                                           p_n_months in number, -- �� ���-�� �������
                                           p_when_first_pay in varchar2 default '����� ������', -- ����� ������ ������ '����� ������' ����� '������. �����'
                                           p_day_pay in number, -- ���� ���������
                                           p_credit_rate_tab in t_credit_rate_tab )
    return t_gpc_tab pipelined;

  -- ������� ��� ���������� ��� ������� ������� �� ������ ������� � �������� ���������� ������
  function gpk_ravnie_by_month_nrates( p_date_credit in date, -- ���� ��������
                                       p_sum_credit in number, -- �������� ������
                                       p_n_months in number, -- �� ���-�� �������
                                       p_when_first_pay in varchar2 default '������. �����', -- ����� ������ ������ '������. �����' ����� '����� ������'
                                       p_day_pay in number, -- ���� ���������
                                       p_credit_rate_tab in t_credit_rate_tab )
    return t_gpc_tab pipelined;

  -- ��������� ���������� �������� ���
  function build_gpk(p_bid_id in wcs_bids.id%type -- ������������� ������
                     ) return t_gpk_table
    pipelined;

  -- ������� �������� ��� � ���������� ������� wcs_bid_gpk
  procedure store_gpk(p_bid_id in wcs_bids.id%type -- ������������� ������
                      );

  -- ������� �������� ���
  function get_gpk(p_bid_id in wcs_bids.id%type -- ������������� ������
                   ) return t_gpk_table
    pipelined;

  -- ��������� ������� �� % ������
  function get_xirr(p_bid_id in wcs_bids.id%type -- ������������� ������
                    ) return number;

  -- ��������� �������������� ������ �������� ����������� � �������� (������� �� �������)
  function get_scorquest_subquestions(p_scoring_id  in wcs_scoring_questions.scoring_id%type, -- ������������� ����������� �����
                                      p_question_id in wcs_scoring_questions.question_id%type -- ������������� �������
                                      ) return t_scor_quest_table
    pipelined;

  -- ��������� �������������� ������ �������� ����������� � ��������
  function get_scorings_subquestions return t_scor_quest_table
    pipelined;

  -- ���������� ������ � ������ ��� ��� (��� ��������������� ������ ���������� ������ ������� ������� ��������� � ��������)
  function show_in_survey(p_bid_id      in number, -- ������������� ������
                          p_question_id in varchar2 -- ������������� �������
                          ) return number;

  -- ��������� ������� ����������� ������ �� ������
  function get_bid_phases_times(p_bid_id wcs_bids.id%type -- ������������� �����
                                ) return t_phases_tlims_table
    pipelined;

  -- ������� ������ ���������������� �������� ��������� ������ 2� ������
  procedure clear_prescoring_bids;

  -- ��������� �������� ������������ �������
  function get_answers_diff(p_bid_id    wcs_answers_history.bid_id%type, -- ������������� ������
                            p_date_from wcs_answers_history.action_date%type, -- ���� ��
                            p_date_to   wcs_answers_history.action_date%type -- ���� ��
                            ) return varchar2;

  -- ������������ ����/���� ��� ���������� ���� ������� ����� "����������� ������/������� �������/������� � �������/�������� ��`�?"
  procedure register_spouse_as_guarantor(p_bid_id wcs_bids.id%type -- ������������� ������
                                         );

  -- ������������� ������� ������ ����� �� ������ ����
  function bid_create_kacko_from_auto(p_bid_id wcs_bids.id%type -- ������������� ������
                                      ) return wcs_bids.id%type;

  -- ��������� ������ ������ �� ����� �� ������ �������� ������
  function get_kacko_bid_id(p_bid_id wcs_bids.id%type) return number;

  -- �������������� ������ �� ������� ������������
  procedure prefill_from_customers(p_dest_bid_id    wcs_answers.bid_id%type, -- ������������� ������ ��� ����������
                                   p_dest_ws_id     wcs_answers.ws_id%type, -- ������������� �������� ������������ ��� ����������
                                   p_dest_ws_number wcs_answers.ws_number%type, -- ����� �������� ������������ ��� ����������
                                   p_src_rnk        customer.rnk%type -- ��� ��� ������
                                   );

  -- �������������� ����������� �� ������� ������
  procedure prefill_auth_from_bids(p_dest_bid_id    wcs_answers.bid_id%type, -- ������������� ������ ��� ����������
                                   p_dest_ws_id     wcs_answers.ws_id%type, -- ������������� �������� ������������ ��� ����������
                                   p_dest_ws_number wcs_answers.ws_number%type, -- ����� �������� ������������ ��� ����������
                                   p_dest_auth_id   wcs_authorizations.id%type, -- ������������� ����������� ��� ����������
                                   p_src_bid_id     wcs_answers.bid_id%type, -- ������������� ������ ��� ������
                                   p_src_ws_id      wcs_answers.ws_id%type, -- ������������� �������� ������������ ��� ������
                                   p_src_ws_number  wcs_answers.ws_number%type -- ����� �������� ������������ ��� ������
                                   );

  -- �������������� ������ �� ������� ������
  procedure prefill_survey_from_bids(p_dest_bid_id    wcs_answers.bid_id%type, -- ������������� ������ ��� ����������
                                     p_dest_ws_id     wcs_answers.ws_id%type, -- ������������� �������� ������������ ��� ����������
                                     p_dest_ws_number wcs_answers.ws_number%type, -- ����� �������� ������������ ��� ����������
                                     p_dest_survey_id wcs_surveys.id%type, -- ������������� ������ ��� ����������
                                     p_src_bid_id     wcs_answers.bid_id%type, -- ������������� ������ ��� ������
                                     p_src_ws_id      wcs_answers.ws_id%type, -- ������������� �������� ������������ ��� ������
                                     p_src_ws_number  wcs_answers.ws_number%type -- ����� �������� ������������ ��� ������
                                     );

  -- ������ ����� ����������� �� �����
  /*
  ������ XML ����� ��� ������� ��ʳ�:
  � ������ ������ �� �������� ��������� <?xml version="1.0" encoding="utf-8" ?>, ��� �� �������� �������� ��� <root></root>.
  � ������� ���������� ���� <root></root> ���� �������� ������� ������� ���� <branch></branch>, �� ���������� �� �������� ��ʳ� �������� ������. �������� ���� <branch>:
  branch_id � ��� �������� (�������, /303398/ - ������������� ������� ��ʳ� ���� ��, /303398/000000/ - ������������� ������� ��ʳ� ��� ���� 2-�� ����);
  comment � ��������, ���� ���� ���������� � �������� ���. �������� ����� ������������ �� ��� �������������� ������� ��ʳ�. ������� � �� �����������.
  � ������� ���� <branch></branch> ���� �������� ������� ������� ���� <subproduct></subproduct>, �� ���������� �� �������� ��ʳ� �������� ����������� � ����� ���������� ��������. �������� ���� <subproduct>:
  sbp_id � ��� �����������.
  � ������� ���� <subproduct></subproduct> ���� �������� ������� ������� ���� <mac />, �� ���������� �� �������� �������� ����, �������� ����������� � ����� ���������� ��������. �������� ���� <mac />:
  mac_id � ��� ����. ��������� ��������, �� � ������ � ���� ���� ��� ��: MAC_SINGLE_FEE_MIN � MAC_SINGLE_FEE_MAX, MAC_INTEREST_RATE_MIN � MAC_INTEREST_RATE_MAX, ����, �� ������ ������������� �����. ������ ������ ��ʳ� ����� ������ � ������ �.
  apply_date � ���� � ��� �������� ���� ������� ���������������. ���� ������� ���� � ������ yyyy-MM-dd;
  value � �������� ����. ������ �������� � ��������� �� ���� ����:
  TEXT � ������
  NUMB � ���� ����� (�������: 5, 10, 357)
  DECIMAL � ������� �����, ����� . (������) (�������: 5.47, 18.2, 17)
  DATE � ���� � ������ yyyy-MM-dd (�������: 2012-02-22)
  LIST � ��� �������� � ���������� ������
  REFER � �������� ��������� ���� � ���������� ��������
  BOOL � 0 ��� 1

  ������� XML �����:
  <?xml version="1.0" encoding="utf-8" ?>
  <root>
    <branch branch_id="/303398/" comment="������ ���������� ���������� �� �� �1 �� 22/11/2011">
      <subproduct sbp_id="SBP_AUTO_G2_60_EP">
        <mac mac_id="MAC_SINGLE_FEE_MAX" apply_date="2012-01-01" value="3.5" />
        <mac mac_id="MAC_SINGLE_FEE_MIN" apply_date="2012-01-01" value="3.5" />
      </subproduct>
      <subproduct sbp_id="SBP_AUTO_G2_60_A" comment="������ ���������� ���������� �� �� �2 �� 23/11/2011">
        <mac mac_id="MAC_SINGLE_FEE_MAX" apply_date="2012-02-01" value="3.5" />
        <mac mac_id="MAC_SINGLE_FEE_MIN" apply_date="2012-02-01" value="3.5" />
      </subproduct>
    </branch>
  </root>
  */
  procedure import_sbpmacs(p_xml        in clob, -- XML
                           p_error_code out number, -- ��� ������ ������� (null ���� ��� ������)
                           p_protocol   out varchar2 -- �������� ������� (����� ������ ���� p_error_code != null)
                           );
end wcs_utl;
/
CREATE OR REPLACE PACKAGE BODY BARS.WCS_UTL is
  -- ================================== ��������� ===============================================
  g_pack_name varchar2(20) := 'wcs_utl. ';
  -- ===============================================================================================
  -- Pivate variable declarations
  l_array_varchar2 t_array_varchar2;

  -- ===============================================================================================
  g_body_version constant varchar2(64) := 'version 1.4 03/11/2015';
  -- header_version - ���������� ������ ��������� ������
  function header_version return varchar2 is
  begin
    return 'Package header wcs_utl ' || g_header_version || '.';
  end header_version;
  -- ���������� ������ ���� ������
  function body_version return varchar2 is
  begin
    return 'Package body wcs_utl ' || g_body_version || '.';
  end body_version;

  -- ===============================================================================================
  function get_ws_id return wcs_answers.ws_id%type is
  begin
    return g_cur_ws_id;
  end get_ws_id;
  procedure set_ws_id(p_val wcs_answers.ws_id%type) is
  begin
    g_cur_ws_id := p_val;
  end set_ws_id;
  function get_ws_num return wcs_answers.ws_number%type is
  begin
    return g_cur_ws_num;
  end get_ws_num;
  procedure set_ws_num(p_val wcs_answers.ws_number%type) is
  begin
    g_cur_ws_num := p_val;
  end set_ws_num;

  function get_rs_id return wcs_jobs.rs_id%type is
  begin
    if (g_rs_id is null) then
      set_rs_id;
    end if;
    return g_rs_id;
  end get_rs_id;
  procedure set_rs_id is
  begin
    g_rs_id := 'RS_' ||
               lpad(round(abs(dbms_random.normal) * 10000), 5, '0');
  end set_rs_id;
  -- ===============================================================================================

  -- �������������� ���-�� ���� � ������ ������� 1� 1� 1��
  function get_formated_days_string(p_days in number -- ���-�� ����
                                    ) return varchar2 is
    l_days    number;
    l_hours   number;
    l_minutes number;
  begin
    l_days    := trunc(p_days);
    l_hours   := trunc((p_days - l_days) * 24);
    l_minutes := trunc(((p_days - l_days) * 24 - l_hours) * 60);

    return lpad(to_char(l_days), 2, '0') || '� ' || lpad(to_char(l_hours),
                                                         2,
                                                         '0') || '� ' || lpad(to_char(l_minutes),
                                                                              2,
                                                                              '0') || '��';
  end get_formated_days_string;

  -- ������ sql
  /* ����� ������������� ��������:

  :#<���>%A-<��������>%T-<���>%WS-<������� ������������>%WSN-<����� �������� ������������>%VAL-<�������� ���������������� ���������>%SCR-<��� ����������� �����>%GI-<��� �����������>%GN-<����� �����������>%GSN-<���������� ����� �����������>%F-<��� �����>#

  <���>:
     ��� ���������
  <��������>:
     G - �����
     S - ����������

     default - G
  <���>:
     Q - ������
     M - ���
     S - ����������� ��� �������
     SG - ����������� ��� ����� (��� ���� ���� �������������� ����. ����� ����������� ����� ��� ��������� = DEFAULT)
     K - ���������
     CD - ������ �������
     GI - ���������� �����������

     default - Q
  <������� ������������>:
     ��� �������� ������������

     default - MAIN
  <����� �������� ������������>:
     ����� �������� ������������

     default - 0
  <�������� ���������������� ���������>:
     ��������� ������������� ��������
  <��� ����������� �����>:
     ��� ����������� ����� ��� �������� ��������

     default - ������� ��� ������
  <��� �����������>
     ��� �����������
  <����� �����������>
     ����� �����������
  <���������� ����� �����������>
     ���������� ����� �����������
  <��� �����>:
     ������� 1 - ������������� �����
     ������� 2 - ��� ��������� ������ �����������, ���������� ����� ��������� ��� �����������
     ������� 3 - �����
     ...
     ������� 10 - �����

  ������:
  �������� ��� �������: :#CL_1%A-G%T-Q%WS-MAIN%WSN-0# ��� :#CL_1#
  �������� ��� 1-�� ����������: :#CL_1%A-G%T-Q%WS-GRT_GUARANTOR%WSN-0# ��� :#CL_1%WS-GRT_GUARANTOR#
     */
  function parse_sql(p_bid_id    wcs_bids.id%type, -- ������������� ������
                     p_plsql     varchar2, -- sql ����
                     p_ws_id     wcs_answers.ws_id%type default g_cur_ws_id, -- ������������� �������� ������������
                     p_ws_number wcs_answers.ws_number%type default g_cur_ws_num -- ����� �������� ������������
                     ) return varchar2 -- ����������� sql ����
   is
    l_plsql varchar2(32000) := p_plsql;

    l_item_txt    varchar2(4000);
    l_replace_txt varchar2(4000);

    l_item_name_txt   varchar2(1000);
    l_item_action_txt varchar2(1000);
    l_item_type_txt   varchar2(1000);
    l_item_ws_txt     varchar2(1000);
    l_item_ws_num_txt varchar2(1000);
    l_item_val_txt    varchar2(1000);
    l_item_scr_txt    varchar2(1000);
    l_item_gi_txt     varchar2(1000);
    l_item_gn_txt     varchar2(1000);
    l_item_gsn_txt    varchar2(1000);
    l_item_f_txt      varchar2(1000);

    l_item_name   varchar2(100);
    l_item_action varchar2(1);
    l_item_type   varchar2(2);
    l_item_ws     varchar2(100);
    l_item_ws_num number;
    l_item_val    varchar2(4000);
    l_item_scr    varchar2(1000);
    l_item_gi     varchar2(100);
    l_item_gn     number;
    l_item_gsn    number;
    l_item_f      varchar2(10);
    l_item_f1     number := 0;
    l_item_f2     number := 0;

    l_b_row wcs_bids%rowtype;
    l_s_row wcs_subproducts%rowtype;
  begin
    -- ��������� ������
    select * into l_b_row from wcs_bids b where b.id = p_bid_id;
    select *
      into l_s_row
      from wcs_subproducts s
     where s.id = l_b_row.subproduct_id;

    -- ����������� ������� ���� ��������
    while (regexp_instr(l_plsql, ':#[^#]+#') > 0) loop
      l_item_txt := regexp_substr(l_plsql, ':#[^#]+#');

      l_item_name_txt   := regexp_substr(l_item_txt, ':#[^%#]+');
      l_item_action_txt := regexp_substr(l_item_txt, '%A-[^%#]+');
      l_item_type_txt   := regexp_substr(l_item_txt, '%T-[^%#]+');

      l_item_ws_txt     := regexp_substr(l_item_txt, '%WS-[^%#]+');
      l_item_ws_num_txt := regexp_substr(l_item_txt, '%WSN-\d+');
      l_item_val_txt    := regexp_substr(l_item_txt, '%VAL-[^%#]+');
      l_item_scr_txt    := regexp_substr(l_item_txt, '%SCR-[^%#]+');
      l_item_gi_txt     := regexp_substr(l_item_txt, '%GI-[^%#]+');
      l_item_gn_txt     := regexp_substr(l_item_txt, '%GN-\d+');
      l_item_gsn_txt    := regexp_substr(l_item_txt, '%GSN-\d+');
      l_item_f_txt      := regexp_substr(l_item_txt, '%F-[^%#]+');

      l_item_name   := replace(l_item_name_txt, ':#', '');
      l_item_action := nvl(replace(l_item_action_txt, '%A-', ''), 'G');
      l_item_type   := nvl(replace(l_item_type_txt, '%T-', ''), 'Q');
      l_item_ws     := nvl(replace(l_item_ws_txt, '%WS-', ''), p_ws_id);
      l_item_ws_num := nvl(to_number(replace(l_item_ws_num_txt, '%WSN-', '')),
                           p_ws_number);
      l_item_val    := replace(l_item_val_txt, '%VAL-', '');
      l_item_scr    := replace(l_item_scr_txt, '%SCR-', '');
      l_item_gi     := replace(l_item_gi_txt, '%GI-', '');
      l_item_gn     := to_number(replace(l_item_gn_txt, '%GN-', ''));
      l_item_gsn    := to_number(replace(l_item_gsn_txt, '%GSN-', ''));
      l_item_f      := replace(l_item_f_txt, '%F-', '');

      -- ��������� �����, ���� �� ������
      if (l_item_f is not null) then
        l_item_f1 := to_number(substr(rpad(l_item_f, 10, '0'), 1, 1));
        l_item_f2 := to_number(substr(rpad(l_item_f, 10, '0'), 2, 1));
      end if;

      -- ��������� ������� ����. �����
      if (trim(l_item_scr) is null) then
        declare
          l_ss_row wcs_subproduct_scoring%rowtype;
        begin
          select *
            into l_ss_row
            from wcs_subproduct_scoring ss
           where ss.subproduct_id = l_b_row.subproduct_id
             and rownum = 1;
          l_item_scr := l_ss_row.scoring_id;
        end;
      end if;

      -- ������������ QF � Q
      if (l_item_type = 'QF') then
        l_item_type := 'Q';
      end if;

      case l_item_type
        when 'Q' then
          -- ������
          if (l_item_action = 'G') then
            -- ���������
            if (l_item_f1 = 1) then
              -- ��������������� �����
              l_replace_txt := wcs_utl.get_answ_formated(p_bid_id,
                                                         l_item_name,
                                                         0,
                                                         l_item_ws,
                                                         l_item_ws_num);
            else
              l_replace_txt := '''' ||
                               wcs_utl.get_answ(p_bid_id,
                                                l_item_name,
                                                l_item_ws,
                                                l_item_ws_num) || '''';
            end if;
          elsif (l_item_action = 'S') then
            -- ���������
            l_replace_txt := ' wcs_utl.set_answ(' || p_bid_id || ', ''' ||
                             l_item_name || ''', ''' || l_item_val ||
                             ''', ''' || l_item_ws || ''', ' ||
                             to_char(l_item_ws_num) || '); ';
          end if;
        when 'M' then
          -- ���
          if (l_item_f1 = 1) then
            -- ��������������� �����
            l_replace_txt := wcs_utl.get_mac_formated(p_bid_id, l_item_name);
          else
            l_replace_txt := '''' || wcs_utl.get_mac(p_bid_id, l_item_name) || '''';
          end if;
        when 'S' then
          -- ����������� ��� �������
          if (l_item_f1 = 1) then
            -- ��������������� �����
            l_replace_txt := wcs_utl.get_val_formated(wcs_utl.get_score(p_bid_id,
                                                                        l_item_scr,
                                                                        l_item_name,
                                                                        l_item_ws,
                                                                        l_item_ws_num),
                                                      'NUMB');
          else
            l_replace_txt := '''' ||
                             wcs_utl.get_score(p_bid_id,
                                               l_item_scr,
                                               l_item_name,
                                               l_item_ws,
                                               l_item_ws_num) || '''';
          end if;
        when 'SG' then
          -- ����������� ��� ����� (�� ��������� ����� ����� �������� ����. ����� ���)
          declare
            l_scoring_id wcs_scorings.id%type := case
                                                   when l_item_name = 'DEFAULT' then
                                                    l_item_scr
                                                   else
                                                    l_item_name
                                                 end;
          begin
            if (l_item_f1 = 1) then
              -- ��������������� �����
              l_replace_txt := wcs_utl.get_val_formated(wcs_utl.get_general_score(p_bid_id,
                                                                                  l_scoring_id,
                                                                                  'OBU',
                                                                                  l_item_ws,
                                                                                  l_item_ws_num),
                                                        'DECIMAL');
            else
              l_replace_txt := '''' ||
                               wcs_utl.get_general_score(p_bid_id,
                                                         l_scoring_id,
                                                         'NBU',
                                                         l_item_ws,
                                                         l_item_ws_num) || '''';
            end if;
          end;
        when 'K' then
          -- ���������
          case l_item_name
            when 'BID_ID' then
              l_replace_txt := to_char(p_bid_id);
            when 'SBP_ID' then
              l_replace_txt := l_b_row.subproduct_id;
            when 'SBP_NAME' then
              l_replace_txt := l_s_row.name;
            when 'GRT_LIST' then
              l_replace_txt := wcs_utl.get_bid_garantees(p_bid_id);
            when 'PRD_ID' then
              select s.product_id
                into l_replace_txt
                from wcs_subproducts s
               where s.id = l_b_row.subproduct_id;
            when 'CUR_WS_ID' then
              l_replace_txt := l_item_ws;
            when 'CUR_WS_NUM' then
              l_replace_txt := l_item_ws_num;
          end case;
        when 'CD' then
          -- ������ �������
          if (l_item_f1 = 1) then
            -- ��������������� �����
            l_replace_txt := wcs_utl.get_answ_formated(p_bid_id,
                                                       get_creditdata_qid(p_bid_id,
                                                                          l_item_name),
                                                       0,
                                                       'MAIN',
                                                       0);
          else
            l_replace_txt := '''' || wcs_utl.get_answ(p_bid_id,
                                                      get_creditdata_qid(p_bid_id,
                                                                         l_item_name),
                                                      'MAIN',
                                                      0) || '''';
          end if;
        when 'GI' then
          -- ���������� �����������
          declare
            l_bg_ws_id  v_wcs_bid_garantees.ws_id%type := 'MAIN';
            l_bg_ws_num v_wcs_bid_garantees.garantee_num%type := 0;
          begin
            if (l_item_gi is not null and l_item_gn is not null) then
              begin
                select bg.ws_id, bg.garantee_num
                  into l_bg_ws_id, l_bg_ws_num
                  from v_wcs_bid_garantees bg
                 where bg.bid_id = p_bid_id
                   and bg.garantee_id = l_item_gi
                   and bg.garantee_num = l_item_gn
                   and rownum = 1;
              exception
                when no_data_found then
                  l_bg_ws_id  := null;
                  l_bg_ws_num := null;
              end;
            elsif (l_item_gsn is not null) then
              begin
                select ws_id, garantee_num
                  into l_bg_ws_id, l_bg_ws_num
                  from (select rownum as rn, bg.ws_id, bg.garantee_num
                          from v_wcs_bid_garantees bg
                         where bg.bid_id = p_bid_id
                           and bg.garantee_id !=
                               decode(l_item_f2, 1, 'GUARANTOR', 'NONE'))
                 where rn = l_item_gsn + 1;
              exception
                when no_data_found then
                  l_bg_ws_id  := null;
                  l_bg_ws_num := null;
              end;
            end if;

            if (l_item_f1 = 1) then
              -- ��������������� �����
              l_replace_txt := wcs_utl.get_answ_formated(p_bid_id,
                                                         l_item_name,
                                                         0,
                                                         l_bg_ws_id,
                                                         l_bg_ws_num);
            else
              l_replace_txt := '''' ||
                               wcs_utl.get_answ(p_bid_id,
                                                l_item_name,
                                                l_bg_ws_id,
                                                l_bg_ws_num) || '''';
            end if;
          end;
      end case;

      -- �������� �������� ������ �� ���������
      l_plsql := replace(l_plsql, l_item_txt, l_replace_txt);
    end loop;

    return l_plsql;
  end parse_sql;

  -- ������ sql (clob)
  function parse_sql(p_bid_id    wcs_bids.id%type, -- ������������� ������
                     p_plsql     clob, -- sql ����
                     p_ws_id     wcs_answers.ws_id%type default g_cur_ws_id, -- ������������� �������� ������������
                     p_ws_number wcs_answers.ws_number%type default g_cur_ws_num -- ����� �������� ������������
                     ) return clob -- ����������� sql ����
   is
    l_plsql_parsed clob;

    l_amount    number := 4000;
    l_offset    number := 1;
    l_idx_start number;
    l_idx_end   number;

    l_buf        varchar2(4001);
    l_buf_parsed clob;
  begin
    dbms_lob.createtemporary(l_plsql_parsed, true);

    while (dbms_lob.getlength(p_plsql) > l_offset) loop
      l_buf := dbms_lob.substr(p_plsql, l_amount + 1, l_offset);

      l_idx_start := instr(l_buf, ':#', -1);
      l_idx_end   := instr(l_buf, '#', l_idx_start + 2);

      -- �������� ����� � ������ ������ ������ �������, �� �� ����� ����� (����� ��� �� ������)
      if (l_idx_start != 0 and l_idx_end = 0) then
        l_buf := substr(l_buf, 1, l_idx_start - 1);
      end if;

      l_offset     := l_offset + length(l_buf);
      l_buf_parsed := wcs_utl.parse_sql(p_bid_id,
                                        l_buf,
                                        p_ws_id,
                                        p_ws_number);
      dbms_lob.writeappend(l_plsql_parsed,
                           length(l_buf_parsed),
                           l_buf_parsed);
    end loop;

    return l_plsql_parsed;
  end parse_sql;

  -- ��������� pl/sql ���� � ����:
  /*declare
      l_bid_id := ������� ������
      l_question_id := ������� ������
  begin
  --------------------
  ---- pl/sql ���� ---
  --------------------
  end

  ��� ������� ���������� ('����� ������'), ��� - (null) */
  function exec_sql(bid_id_      number, -- ������������� ������
                    question_id_ varchar2, -- ������������� �������
                    plsql_       varchar2, -- sql ����
                    p_ws_id      wcs_answers.ws_id%type default g_cur_ws_id, -- ������������� �������� ������������
                    p_ws_number  wcs_answers.ws_number%type default g_cur_ws_num -- ����� �������� ������������
                    ) return varchar2 -- ��������� ����������
   is
    l_final_sql_  varchar2(4000);
    plsql_parsed_ varchar2(4000);

    l_proc_name varchar2(100) := 'exec_sql. ';
  begin
    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Start. Params: bid_id_=%s, question_id_=%s, plsql_=%s',
                     to_char(bid_id_),
                     question_id_,
                     plsql_);

    -- �������
    plsql_parsed_ := wcs_utl.parse_sql(bid_id_,
                                       plsql_,
                                       p_ws_id,
                                       p_ws_number);

    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Process. plsql_parsed_ =%s',
                     plsql_parsed_);

    l_final_sql_ := 'declare l_bid_id number := ' || bid_id_ || ';';
    l_final_sql_ := l_final_sql_ || ' l_question_id number := ''' ||
                    question_id_ || ''';';
    l_final_sql_ := l_final_sql_ || ' begin ';
    l_final_sql_ := l_final_sql_ || plsql_parsed_;
    l_final_sql_ := l_final_sql_ || ' end; ';

    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Process. l_final_sql_ =%s',
                     l_final_sql_);

    execute_immediate(l_final_sql_);

    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Process. executed successfully');

    return null;
  exception
    when others then
      bars_audit.trace(g_pack_name || l_proc_name ||
                       'Process. executed with errors');
      return sqlerrm;
  end exec_sql;

  -- ��������� ����������� pl/sql ����
  /* ��� ����������� ���������� �������� ('����� ������ ��������') pl/sql ����
  ������ ������� ���������� (bars_error), ��� �������������� (null) ������
  ����������� ��� ������ */
  function exec_check(bid_id_     number, -- ������������� ������
                      plsql_      varchar2, -- sql ����
                      p_ws_id     wcs_answers.ws_id%type default g_cur_ws_id, -- ������������� �������� ������������
                      p_ws_number wcs_answers.ws_number%type default g_cur_ws_num -- ����� �������� ������������
                      ) return varchar2 -- ��������� ��������
   is
    l_err_msg_  varchar2(1000);
    l_err_text_ varchar2(1000);

    sidx number;
    fidx number;
  begin
    -- ��������� ��������
    l_err_msg_ := wcs_utl.exec_sql(bid_id_,
                                   null,
                                   plsql_,
                                   p_ws_id,
                                   p_ws_number);

    if (l_err_msg_ is null) then
      return null;
    else
      sidx := instr(l_err_msg_, 'WCS');
      fidx := instr(l_err_msg_, 'when executing');

      l_err_text_ := substr(l_err_msg_, sidx + 9, fidx - sidx - 9);

      return trim(l_err_text_);
    end if;
  end exec_check;

  -- ��������� �������� sql ������
  function calc_sql_line(bid_id_     number, -- ������������� ������
                         plsql_line_ varchar2, -- sql ������
                         p_ws_id     wcs_answers.ws_id%type default g_cur_ws_id, -- ������������� �������� ������������
                         p_ws_number wcs_answers.ws_number%type default g_cur_ws_num -- ����� �������� ������������
                         ) return varchar2 -- ��������� ����������
   is
    l_cursor_ integer;
    l_result_ integer;

    l_calc_text_ varchar2(4000);
    l_res_       varchar2(4000);

    l_proc_name varchar2(100) := 'calc_sql_line. ';
  begin
    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Start. Params: bid_id_=%s, plsql_line_=%s',
                     to_char(bid_id_),
                     plsql_line_);

    l_calc_text_ := wcs_utl.parse_sql(bid_id_,
                                      plsql_line_,
                                      p_ws_id,
                                      p_ws_number);
    if (l_calc_text_ is null) then
      return null;
    end if;

    -- ��������� l_calc_text_ � ������
    l_calc_text_ := 'select ' || l_calc_text_ || ' as val from dual';

    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Process. l_calc_text_ =%s',
                     l_calc_text_);

    -- �������� � ��������
    begin
      l_cursor_ := dbms_sql.open_cursor;
      dbms_sql.parse(l_cursor_, l_calc_text_, dbms_sql.native);
      dbms_sql.define_column(l_cursor_, 1, l_res_, 4000);
      l_result_ := dbms_sql.execute_and_fetch(l_cursor_);
      dbms_sql.column_value(l_cursor_, 1, l_res_);
      dbms_sql.close_cursor(l_cursor_);
    exception
      when zero_divide then
        l_res_ := null;
        dbms_sql.close_cursor(l_cursor_);
        bars_audit.trace(g_pack_name || l_proc_name ||
                         'Process. zero_divide');
    end;

    -- ���� ��������� ����� �� ��������� ��� �� 5-�� ������ ����� �������
    declare
      l_tmp varchar2(4000);
    begin
      l_tmp := to_char(l_res_);
      if regexp_like(to_char(l_tmp),'^[+](0-9)*') then raise value_error; end if;
      l_res_ := round(l_res_, 5);
    exception
      when value_error then
        null;
    end;

    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Finish. Params: l_res_=%s',
                     l_res_);

    return l_res_;
  end calc_sql_line;

  -- ��������� �������� �������� sql ���������
  function calc_sql_bool(bid_id_     number, -- ������������� ������
                         plsql_bool_ varchar2, -- ������� sql ��������� (null/1/true - OK, 0/false - NOT OK)
                         p_ws_id     wcs_answers.ws_id%type default g_cur_ws_id, -- ������������� �������� ������������
                         p_ws_number wcs_answers.ws_number%type default g_cur_ws_num -- ����� �������� ������������
                         ) return number -- ��������� ����������
   is
    l_cursor_ integer;
    l_result_ integer;

    l_plsql_bool varchar2(4000) := upper(trim(plsql_bool_));
    l_calc_text_ varchar2(4000);
    l_res_       varchar2(4000);

    l_proc_name varchar2(40) := 'calc_sql_bool. ';
  begin
    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Start. Params: bid_id_=%s, l_plsql_bool=%s',
                     to_char(bid_id_),
                     l_plsql_bool);

    -- null/1/true - OK, 0/false - NOT OK
    if (l_plsql_bool is null or l_plsql_bool = '1' or l_plsql_bool = 'TRUE') then
      return 1;
    elsif (l_plsql_bool = '0' or l_plsql_bool = 'FALSE') then
      return 0;
    end if;

    l_calc_text_ := wcs_utl.parse_sql(bid_id_,
                                      l_plsql_bool,
                                      p_ws_id,
                                      p_ws_number);

    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Proccess. Params: l_calc_text_=%s',
                     l_calc_text_);

    -- ��������� l_calc_text_ � ������
    l_calc_text_ := 'select count(*) as val from dual where ' ||
                    l_calc_text_;

    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Proccess. Params: l_calc_text_=%s',
                     l_calc_text_);

    -- �������� � ��������
    l_cursor_ := dbms_sql.open_cursor;
    dbms_sql.parse(l_cursor_, l_calc_text_, dbms_sql.native);
    dbms_sql.define_column(l_cursor_, 1, l_res_, 100);
    l_result_ := dbms_sql.execute_and_fetch(l_cursor_);
    dbms_sql.column_value(l_cursor_, 1, l_res_);
    dbms_sql.close_cursor(l_cursor_);

    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Finish. Params: l_res_=%s',
                     l_res_);

    return l_res_;
  end calc_sql_bool;

  -- ���� �� ����� �� ������
  function has_answ(p_bid_id      wcs_answers.bid_id%type, -- ������������� ������
                    p_question_id wcs_answers.question_id%type, -- ������������� �������
                    p_ws_id       wcs_answers.ws_id%type default g_cur_ws_id, -- ������������� �������� ������������
                    p_ws_number   wcs_answers.ws_number%type default g_cur_ws_num -- ����� �������� ������������
                    ) return number -- ����� ���� - 1, ��� - 0
   is
    l_has_answ number;
  begin
    select count(*)
      into l_has_answ
      from wcs_answers a
     where a.bid_id = p_bid_id
       and a.ws_id = p_ws_id
       and a.ws_number = p_ws_number
       and a.question_id = p_question_id;
    return l_has_answ;
  end has_answ;

  -- ���������� �������� ������ (�������)
  function get_answ(p_bid_id      wcs_answers.bid_id%type, -- ������������� ������
                    p_question_id wcs_answers.question_id%type, -- ������������� �������
                    p_ws_id       wcs_answers.ws_id%type default get_ws_id, -- ������������� �������� ������������
                    p_ws_number   wcs_answers.ws_number%type default get_ws_num -- ����� �������� ������������
                    ) return varchar2 -- �������� ������
   is
    l_proc_name varchar2(40) := 'get_answ. ';

    l_q_row wcs_questions%rowtype;
    l_a_row wcs_answers%rowtype;

    l_isfreeze number;

    l_calc_res varchar2(4000);
    l_res      varchar2(4000);

    -- ����� �������. ���������� ����� �� ������ �� ���� � ������ ������
    function get_answ_from_row(p_type_id varchar2,
                               a_row     wcs_answers%rowtype) return varchar2 is
    begin
      case p_type_id
        when ('TEXT') then
          return replace(a_row.val_text, '''', '`');
        when ('NUMB') then
          return a_row.val_numb;
        when ('DECIMAL') then
          return a_row.val_decimal;
        when ('DATE') then
          return a_row.val_date;
        when ('LIST') then
          return a_row.val_list;
        when ('REFER') then
          return replace(a_row.val_refer, '''', '`');
        when ('BOOL') then
          return a_row.val_bool;
        else
          return null;
      end case;
    end get_answ_from_row;

  begin
    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Start %s. Params: p_bid_id=%s, p_question_id=%s, p_ws_id=%s, p_ws_number=%s',
                     p_question_id,
                     to_char(p_bid_id),
                     p_question_id,
                     p_ws_id,
                     to_char(p_ws_number));

    -- ��������� �������
    select * into l_q_row from wcs_questions q where q.id = p_question_id;

    -- ���������� �� ������
    select decode(count(*), 0, 0, 1)
      into l_isfreeze
      from wcs_bid_states_history bsh
     where bsh.bid_id = p_bid_id
       and bsh.state_id = 'FREEZE'
       and bsh.change_action = 'SET';

    -- ������ ����������, �� ���������� ������������ ��������
    if (l_isfreeze = 1) then
      begin
        select *
          into l_a_row
          from wcs_answers a
         where a.bid_id = p_bid_id
           and a.ws_id = p_ws_id
           and a.ws_number = p_ws_number
           and a.question_id = p_question_id;
      exception
        when no_data_found then
          l_a_row := null;
      end;
      l_res := get_answ_from_row(l_q_row.type_id, l_a_row);
    else
      -- �����������
      if (l_q_row.is_calcable = 1) then
        bars_audit.trace(g_pack_name || l_proc_name ||
                         'Proccess %s. is_calcable = 1, calc_proc=%s',
                         p_question_id,
                         l_q_row.calc_proc);

        l_calc_res := wcs_utl.calc_sql_line(p_bid_id,
                                            l_q_row.calc_proc,
                                            p_ws_id,
                                            p_ws_number);
      else
        l_calc_res := null;
      end if;

      -- ���� ��������� ���������� ������, �� ������� �����
      if (l_calc_res is not null) then
        l_res := l_calc_res;
      else
        begin
          select *
            into l_a_row
            from wcs_answers a
           where a.bid_id = p_bid_id
             and a.ws_id = p_ws_id
             and a.ws_number = p_ws_number
             and a.question_id = p_question_id;
        exception
          when no_data_found then
            l_a_row := null;
        end;
        l_res := get_answ_from_row(l_q_row.type_id, l_a_row);
      end if;
    end if;

    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Finish %s. return = %s',
                     p_question_id,
                     l_res);

    return l_res;
  end get_answ;

  -- ���������� ����������� �������� ������ ������� TEXT
  function get_answ_text(p_bid_id      wcs_answers.bid_id%type, -- ������������� ������
                         p_question_id wcs_answers.question_id%type, -- ������������� �������
                         p_ws_id       wcs_answers.ws_id%type default get_ws_id, -- ������������� �������� ������������
                         p_ws_number   wcs_answers.ws_number%type default get_ws_num -- ����� �������� ������������
                         ) return wcs_answers.val_text%type -- �������� ������
   is
    l_text wcs_answers.val_text%type;
  begin
    -- ���� �� ���������� ����� �� null
    begin
      select a.val_text
        into l_text
        from wcs_answers a
       where a.bid_id = p_bid_id
         and a.ws_id = p_ws_id
         and a.ws_number = p_ws_number
         and a.question_id = p_question_id;
    exception
      when no_data_found then
        l_text := null;
    end;

    return l_text;
  end get_answ_text;

  -- ���������� ����������� �������� ������ ������� NUMB
  function get_answ_numb(p_bid_id      wcs_answers.bid_id%type, -- ������������� ������
                         p_question_id wcs_answers.question_id%type, -- ������������� �������
                         p_ws_id       wcs_answers.ws_id%type default get_ws_id, -- ������������� �������� ������������
                         p_ws_number   wcs_answers.ws_number%type default get_ws_num -- ����� �������� ������������
                         ) return wcs_answers.val_numb%type -- �������� ������
   is
    l_numb wcs_answers.val_numb%type;
  begin
    -- ���� �� ���������� ����� �� null
    begin
      select a.val_numb
        into l_numb
        from wcs_answers a
       where a.bid_id = p_bid_id
         and a.ws_id = p_ws_id
         and a.ws_number = p_ws_number
         and a.question_id = p_question_id;
    exception
      when no_data_found then
        l_numb := to_number(get_answ(p_bid_id,
                                     p_question_id,
                                     p_ws_id,
                                     p_ws_number));
    end;

    return l_numb;
  end get_answ_numb;

  -- ���������� ����������� �������� ������ ������� DECIMAL
  function get_answ_decimal(p_bid_id      wcs_answers.bid_id%type, -- ������������� ������
                            p_question_id wcs_answers.question_id%type, -- ������������� �������
                            p_ws_id       wcs_answers.ws_id%type default get_ws_id, -- ������������� �������� ������������
                            p_ws_number   wcs_answers.ws_number%type default get_ws_num -- ����� �������� ������������
                            ) return wcs_answers.val_decimal%type -- �������� ������
   is
    l_decimal number(13,3);--wcs_answers.val_decimal%type;
  begin
    -- ���� �� ���������� ����� �� null
    begin
      select a.val_decimal
        into l_decimal
        from wcs_answers a
       where a.bid_id = p_bid_id
         and a.ws_id = p_ws_id
         and a.ws_number = p_ws_number
         and a.question_id = p_question_id;
    exception
      when no_data_found then
        l_decimal := round(to_number(get_answ(p_bid_id,
                                        p_question_id,
                                        p_ws_id,
                                        p_ws_number)),3);
    end;

    return l_decimal;
  end get_answ_decimal;

  -- ���������� ����������� �������� ������ ������� DATE
  function get_answ_date(p_bid_id      wcs_answers.bid_id%type, -- ������������� ������
                         p_question_id wcs_answers.question_id%type, -- ������������� �������
                         p_ws_id       wcs_answers.ws_id%type default get_ws_id, -- ������������� �������� ������������
                         p_ws_number   wcs_answers.ws_number%type default get_ws_num -- ����� �������� ������������
                         ) return wcs_answers.val_date%type -- �������� ������
   is
    l_date wcs_answers.val_date%type;
  begin
    -- ���� �� ���������� ����� �� null
    begin
      select a.val_date
        into l_date
        from wcs_answers a
       where a.bid_id = p_bid_id
         and a.ws_id = p_ws_id
         and a.ws_number = p_ws_number
         and a.question_id = p_question_id;
    exception
      when no_data_found then
        l_date := null;
    end;

    return l_date;
  end get_answ_date;

  -- ���������� ����������� �������� ������ ������� LIST
  function get_answ_list(p_bid_id      wcs_answers.bid_id%type, -- ������������� ������
                         p_question_id wcs_answers.question_id%type, -- ������������� �������
                         p_ws_id       wcs_answers.ws_id%type default get_ws_id, -- ������������� �������� ������������
                         p_ws_number   wcs_answers.ws_number%type default get_ws_num -- ����� �������� ������������
                         ) return wcs_answers.val_list%type -- �������� ������
   is
    l_list wcs_answers.val_list%type;
  begin
    -- ���� �� ���������� ����� �� null
    l_list := to_number(wcs_utl.get_answ(p_bid_id,
                                         p_question_id,
                                         p_ws_id,
                                         p_ws_number));

    return l_list;
  end get_answ_list;

  -- ���������� ����������� �������� ������ ������� LIST (��������� ��������)
  function get_answ_list_text(p_bid_id      wcs_answers.bid_id%type, -- ������������� ������
                              p_question_id wcs_answers.question_id%type, -- ������������� �������
                              p_ws_id       wcs_answers.ws_id%type default get_ws_id, -- ������������� �������� ������������
                              p_ws_number   wcs_answers.ws_number%type default get_ws_num -- ����� �������� ������������
                              ) return wcs_question_list_items.text%type -- �������� ������
   is
    l_qli_row wcs_question_list_items%rowtype;
  begin
    select *
      into l_qli_row
      from wcs_question_list_items qli
     where qli.question_id = p_question_id
       and qli.ord = to_number(wcs_utl.get_answ(p_bid_id,
                                                p_question_id,
                                                p_ws_id,
                                                p_ws_number));

    return l_qli_row.text;
  exception
    when no_data_found then
      return null;
  end get_answ_list_text;

  -- ���������� ����������� �������� ������ ������� REFER
  function get_answ_refer(p_bid_id      wcs_answers.bid_id%type, -- ������������� ������
                          p_question_id wcs_answers.question_id%type, -- ������������� �������
                          p_ws_id       wcs_answers.ws_id%type default get_ws_id, -- ������������� �������� ������������
                          p_ws_number   wcs_answers.ws_number%type default get_ws_num -- ����� �������� ������������
                          ) return wcs_answers.val_refer%type -- �������� ������
   is
    l_refer wcs_answers.val_refer%type;
  begin
    -- ���� �� ���������� ����� �� null
    begin
      select a.val_refer
        into l_refer
        from wcs_answers a
       where a.bid_id = p_bid_id
         and a.ws_id = p_ws_id
         and a.ws_number = p_ws_number
         and a.question_id = p_question_id;
    exception
      when no_data_found then
        l_refer := null;
    end;

    return l_refer;
  end get_answ_refer;

  -- ���������� ����������� �������� ������ ������� REFER (�����)
  function get_answ_refer_text(p_bid_id      wcs_answers.bid_id%type, -- ������������� ������
                               p_question_id wcs_answers.question_id%type, -- ������������� �������
                               p_ws_id       wcs_answers.ws_id%type default get_ws_id, -- ������������� �������� ������������
                               p_ws_number   wcs_answers.ws_number%type default get_ws_num -- ����� �������� ������������
                               ) return wcs_answers.val_refer%type -- �������� ������
   is
    l_refer      wcs_answers.val_refer%type;
    l_refer_text varchar2(4000);
    l_qrp_row    wcs_question_refer_params%rowtype;
  begin
    -- ���� �� ���������� ����� �� null
    begin
      -- �������� ������
      l_refer := wcs_utl.get_answ(p_bid_id,
                                  p_question_id,
                                  p_ws_id,
                                  p_ws_number);

      -- ��������� �����������
      select *
        into l_qrp_row
        from wcs_question_refer_params qrp
       where qrp.question_id = p_question_id;

      -- �������� ��������� ������
      declare
        l_sql_stmt varchar2(4000);
        l_tabname  varchar2(30);
      begin
        select mt.tabname
          into l_tabname
          from meta_tables mt
         where mt.tabid = l_qrp_row.tab_id;
        l_sql_stmt := 'select to_char(min(' || l_qrp_row.semantic_field ||
                      ')) as res from ' || l_tabname || ' where ' ||
                      l_qrp_row.key_field || ' = ''' || l_refer ||
                      ''' and rownum = 1';
        if (l_qrp_row.where_clause is not null) then
          l_sql_stmt := l_sql_stmt || ' and ' ||
                        replace(wcs_utl.parse_sql(p_bid_id,
                                                  l_qrp_row.where_clause,
                                                  p_ws_id,
                                                  p_ws_number),
                                'where',
                                '');
        end if;
        execute immediate l_sql_stmt
          into l_refer_text;
      end;
    exception
      when others then
        l_refer_text := null;
    end;

    return l_refer_text;
  end get_answ_refer_text;

  -- ���������� ����������� �������� ������ ������� BOOL
  function get_answ_bool(p_bid_id      wcs_answers.bid_id%type, -- ������������� ������
                         p_question_id wcs_answers.question_id%type, -- ������������� �������
                         p_ws_id       wcs_answers.ws_id%type default get_ws_id, -- ������������� �������� ������������
                         p_ws_number   wcs_answers.ws_number%type default get_ws_num -- ����� �������� ������������
                         ) return wcs_answers.val_bool%type -- �������� ������
   is
    l_bool wcs_answers.val_bool%type;
  begin
    -- ���� �� ���������� ����� �� null
    begin
      select a.val_bool
        into l_bool
        from wcs_answers a
       where a.bid_id = p_bid_id
         and a.ws_id = p_ws_id
         and a.ws_number = p_ws_number
         and a.question_id = p_question_id;
    exception
      when no_data_found then
        l_bool := null;
    end;

    return l_bool;
  end get_answ_bool;

  -- ���������� �������� ������ ���� blob
  function get_answ_blob(p_bid_id      wcs_answers.bid_id%type, -- ������������� ������
                         p_question_id wcs_answers.question_id%type, -- ������������� �������
                         p_ws_id       wcs_answers.ws_id%type default get_ws_id, -- ������������� �������� ������������
                         p_ws_number   wcs_answers.ws_number%type default get_ws_num -- ����� �������� ������������
                         ) return blob -- �������� ������
   is
    l_res blob;
  begin
    -- ���� �� ���������� ����� �� null
    begin
      select a.val_file
        into l_res
        from wcs_answers a
       where a.bid_id = p_bid_id
         and a.ws_id = p_ws_id
         and a.ws_number = p_ws_number
         and a.question_id = p_question_id;
    exception
      when no_data_found then
        l_res := null;
    end;

    return l_res;
  end get_answ_blob;

  -- ���������� �������� ������ ���� XML
  function get_answ_xml(p_bid_id      wcs_answers.bid_id%type, -- ������������� ������
                        p_question_id wcs_answers.question_id%type, -- ������������� �������
                        p_ws_id       wcs_answers.ws_id%type default get_ws_id, -- ������������� �������� ������������
                        p_ws_number   wcs_answers.ws_number%type default get_ws_num -- ����� �������� ������������
                        ) return wcs_answers.val_xml%type -- �������� ������
   is
    l_res wcs_answers.val_xml%type;
  begin
    -- ���� �� ���������� ����� �� null
    begin
      select a.val_xml
        into l_res
        from wcs_answers a
       where a.bid_id = p_bid_id
         and a.ws_id = p_ws_id
         and a.ws_number = p_ws_number
         and a.question_id = p_question_id;
    exception
      when no_data_found then
        l_res := null;
    end;

    return l_res;
  end get_answ_xml;

  -- ���������� �������� ������ �������������� (�������)
  function get_answ_formated(p_bid_id      wcs_answers.bid_id%type, -- ������������� ������
                             p_question_id wcs_answers.question_id%type, -- ������������� �������
                             p_for_export  number default 0, -- �������� ��������� ������� �������
                             p_ws_id       wcs_answers.ws_id%type default get_ws_id, -- ������������� �������� ������������
                             p_ws_number   wcs_answers.ws_number%type default get_ws_num -- ����� �������� ������������
                             ) return varchar2 is
    l_type_id varchar2(100);

    l_answ varchar2(4000);
    l_res  varchar2(4000);
  begin
    -- ����� ��������� �����������
    begin
      select q.type_id
        into l_type_id
        from wcs_questions q
       where q.id = p_question_id;
    exception
      when no_data_found then
        logger.error('Calc formula contains question ' || p_question_id ||
                     ' not included into questions dictionary');
        return null;
    end;

    -- �������� ������
    l_answ := wcs_utl.get_answ(p_bid_id,
                               p_question_id,
                               p_ws_id,
                               p_ws_number);

    -- ���������� ��������� � ����������� �� ���� ���������
    case l_type_id
      when ('TEXT') then
        l_res := get_val_formated(l_answ, 'TEXT');
      when ('NUMB') then
        l_res := get_val_formated(l_answ, 'NUMB');
      when ('DECIMAL') then
        l_res := get_val_formated(l_answ, 'DECIMAL');
      when ('DATE') then
        if (p_for_export = 1) then
          l_res := to_char(to_date(l_answ), 'yyyy-mm-dd');
        else
          l_res := get_val_formated(l_answ, 'DATE');
        end if;
      when ('LIST') then
        l_res := get_val_formated(l_answ,
                                  'LIST_QUEST',
                                  null,
                                  null,
                                  null,
                                  p_question_id,
                                  null);
      when ('REFER') then
        l_res := get_val_formated(l_answ,
                                  'REFER_QUEST',
                                  p_bid_id,
                                  p_ws_id,
                                  p_ws_number,
                                  p_question_id,
                                  null);
      when ('BOOL') then
        if (p_for_export = 1) then
          l_res := trim(to_char(to_number(l_answ), '9999999999999999990'));
        else
          l_res := get_val_formated(l_answ, 'BOOL');
        end if;
      else
        l_res := '';
    end case;

    return l_res;
  end get_answ_formated;

  -- ����������� ��������� �������� �� ��������� ����
  function get_val_formated(p_val         varchar2, -- �������� � ������
                            p_type        varchar2, -- ��� �������� (TEXT, NUMB, DECIMAL, DATE, LIST_QUEST, LIST_MAC, REFER_QUEST, REFER_MAC, BOOL)
                            p_bid_id      wcs_bids.id%type default null, -- ������������� ������
                            p_ws_id       wcs_answers.ws_id%type default g_cur_ws_id, -- ������������� �������� ������������
                            p_ws_number   wcs_answers.ws_number%type default g_cur_ws_num, -- ����� �������� ������������
                            p_question_id wcs_questions.id%type default null, -- ������������� ������� ��� ����� �������� � ���������
                            p_mac_id      wcs_macs.id%type default null -- ������������� ���� ��� ����� �������� � ���������
                            ) return varchar2 is
    l_res varchar2(4000);
  begin
    case p_type
      when 'TEXT' then
        l_res := trim(p_val);
      when 'NUMB' then
        l_res := trim(to_char(to_number(p_val), '9999999999999999990'));
      when 'DECIMAL' then
        l_res := trim(to_char(to_number(p_val), '9999999999999999990.00'));
      when 'DATE' then
        l_res := to_char(to_date(p_val), 'dd.mm.yyyy');
      when 'LIST_QUEST' then
        select min(qli.text)
          into l_res
          from wcs_question_list_items qli
         where qli.question_id = p_question_id
           and qli.ord = to_number(trim(p_val));
      when 'LIST_MAC' then
        select min(mli.text)
          into l_res
          from wcs_mac_list_items mli
         where mli.mac_id = p_mac_id
           and mli.ord = to_number(trim(p_val));
      when 'REFER_QUEST' then
        declare
          l_qrp_row  wcs_question_refer_params%rowtype;
          l_sql_stmt varchar2(4000);
          l_tabname  varchar2(30);
        begin
          -- ��������� �����������
          select *
            into l_qrp_row
            from wcs_question_refer_params qrp
           where qrp.question_id = p_question_id;

          -- �������� ��������� ������
          select mt.tabname
            into l_tabname
            from meta_tables mt
           where mt.tabid = l_qrp_row.tab_id;

          l_sql_stmt := 'select to_char(min(' || l_qrp_row.semantic_field ||
                        ')) as res from ' || l_tabname || ' where ' ||
                        l_qrp_row.key_field || ' = ''' || trim(p_val) ||
                        ''' and rownum = 1';

          if (l_qrp_row.where_clause is not null) then
            l_sql_stmt := l_sql_stmt || ' and ' ||
                          replace(wcs_utl.parse_sql(p_bid_id,
                                                    l_qrp_row.where_clause,
                                                    p_ws_id,
                                                    p_ws_number),
                                  'where',
                                  '');
          end if;

          execute immediate l_sql_stmt
            into l_res;
        end;
      when 'REFER_MAC' then
        declare
          l_mrp_row  wcs_mac_refer_params%rowtype;
          l_sql_stmt varchar2(4000);
          l_tabname  varchar2(30);
        begin
          -- ��������� �����������
          select *
            into l_mrp_row
            from wcs_mac_refer_params mrp
           where mrp.mac_id = p_mac_id;

          -- �������� ��������� ������
          select mt.tabname
            into l_tabname
            from meta_tables mt
           where mt.tabid = l_mrp_row.tab_id;

          l_sql_stmt := 'select to_char(min(' || l_mrp_row.semantic_field ||
                        ')) as res from ' || l_tabname || ' where ' ||
                        l_mrp_row.key_field || ' = ''' || trim(p_val) ||
                        ''' and rownum = 1';

          if (l_mrp_row.where_clause is not null) then
            l_sql_stmt := l_sql_stmt || ' and (' ||
                          replace(l_mrp_row.where_clause, 'where', '') || ')';
          end if;

          execute immediate l_sql_stmt
            into l_res;
        end;
      when 'BOOL' then
        select decode(to_number(trim(p_val)), 1, '���', 0, 'ͳ', null)
          into l_res
          from dual;
    end case;

    return l_res;
  end get_val_formated;

  -- �������� ������������ ������� �� ��������������
  function get_quest_name(p_question_id wcs_questions.id%type -- ������������� �������
                          ) return varchar2 -- ������������ �������
   is
    l_q_row wcs_questions%rowtype;
  begin
    -- ��������� �������
    select * into l_q_row from wcs_questions q where q.id = p_question_id;
    return l_q_row.name;
  end get_quest_name;

  -- ���������� �������� ������ (�������)
  procedure calc_answ(p_bid_id      wcs_answers.bid_id%type, -- ������������� ������
                      p_question_id wcs_answers.question_id%type, -- ������������� �������
                      p_ws_id       wcs_answers.ws_id%type default g_cur_ws_id, -- ������������� �������� ������������
                      p_ws_number   wcs_answers.ws_number%type default g_cur_ws_num -- ����� �������� ������������
                      ) is
    l_res varchar2(4000);
  begin
    l_res := wcs_utl.get_answ(p_bid_id, p_question_id, p_ws_id, p_ws_number);
    if (l_res is not null) then
      wcs_utl.set_answ(p_bid_id,
                       p_question_id,
                       l_res,
                       p_ws_id,
                       p_ws_number);
    end if;
  end calc_answ;

  -- ������������� �������� ������ (�������)
  procedure set_answ(p_bid_id      wcs_answers.bid_id%type, -- ������������� ������
                     p_question_id wcs_answers.question_id%type, -- ������������� �������
                     p_val         varchar2, -- ��������
                     p_ws_id       wcs_answers.ws_id%type default g_cur_ws_id, -- ������������� �������� ������������
                     p_ws_number   wcs_answers.ws_number%type default g_cur_ws_num -- ����� �������� ������������
                     ) is
    l_type_id varchar2(100);
  begin
    -- ����� ��� ���������
    select t.type_id
      into l_type_id
      from wcs_questions t
     where t.id = p_question_id;

    -- ������������� ��������� � ����������� �� ���� ���������
    case l_type_id
      when ('TEXT') then
        wcs_pack.answ_text_set(p_bid_id,
                               p_question_id,
                               p_val,
                               p_ws_id,
                               p_ws_number);
      when ('NUMB') then
        wcs_pack.answ_numb_set(p_bid_id,
                               p_question_id,
                               p_val,
                               p_ws_id,
                               p_ws_number);
      when ('DECIMAL') then
        wcs_pack.answ_dec_set(p_bid_id,
                              p_question_id,
                              p_val,
                              p_ws_id,
                              p_ws_number);
      when ('DATE') then
        wcs_pack.answ_dat_set(p_bid_id,
                              p_question_id,
                              p_val,
                              p_ws_id,
                              p_ws_number);
      when ('LIST') then
        wcs_pack.answ_list_set(p_bid_id,
                               p_question_id,
                               p_val,
                               p_ws_id,
                               p_ws_number);
      when ('REFER') then
        wcs_pack.answ_ref_set(p_bid_id,
                              p_question_id,
                              p_val,
                              p_ws_id,
                              p_ws_number);
      when ('BOOL') then
        wcs_pack.answ_bool_set(p_bid_id,
                               p_question_id,
                               p_val,
                               p_ws_id,
                               p_ws_number);
      else
        null;
    end case;
  end set_answ;

  -- ������������� �������� ������ (�������) ���� ������ ��� ���
  procedure set_answ_ifempty(p_bid_id      wcs_answers.bid_id%type, -- ������������� ������
                             p_question_id wcs_answers.question_id%type, -- ������������� �������
                             p_val         varchar2, -- ��������
                             p_ws_id       wcs_answers.ws_id%type default g_cur_ws_id, -- ������������� �������� ������������
                             p_ws_number   wcs_answers.ws_number%type default g_cur_ws_num -- ����� �������� ������������
                             ) is
  begin
    if (wcs_utl.has_answ(p_bid_id, p_question_id, p_ws_id, p_ws_number) != 1) then
      set_answ(p_bid_id, p_question_id, p_val, p_ws_id, p_ws_number);
    end if;
  end set_answ_ifempty;

  -- ��������� ��. ������� �������� ��������� �������
  function get_creditdata_qid(p_bid_id     wcs_answers.bid_id%type, -- ������������� ������
                              p_crddata_id wcs_creditdata_base.id%type -- ������������� �������� ���������
                              ) return varchar2 -- �������� ������
   is
    l_b_row   wcs_bids%rowtype;
    l_scd_row wcs_subproduct_creditdata%rowtype;
  begin
    -- ��������� ������
    select * into l_b_row from wcs_bids b where b.id = p_bid_id;

    -- ����� �������� ������� � ���������
    select *
      into l_scd_row
      from wcs_subproduct_creditdata scd
     where scd.subproduct_id = l_b_row.subproduct_id
       and scd.crddata_id = p_crddata_id;

    -- ���������� �� �������
    return l_scd_row.question_id;
  end get_creditdata_qid;

  -- ��������� ������� ���������� ������� �� ������ (�������)
  function get_creditdata(p_bid_id     wcs_answers.bid_id%type, -- ������������� ������
                          p_crddata_id wcs_creditdata_base.id%type -- ������������� �������� ���������
                          ) return varchar2 -- �������� ������
   is
    l_b_row   wcs_bids%rowtype;
    l_scd_row wcs_subproduct_creditdata%rowtype;
  begin
    -- ���������� ����� �� �������� ������
    return wcs_utl.get_answ(p_bid_id,
                            get_creditdata_qid(p_bid_id, p_crddata_id),
                            'MAIN',
                            0);
  end get_creditdata;

  -- ���������� �������� ���� ����
  function get_sbp_mac_blob(p_subproduct_id wcs_subproduct_macs.subproduct_id%type, -- ������������� �����������
                            p_mac_id        wcs_subproduct_macs.mac_id%type, -- ������������� ����
                            p_branch        wcs_subproduct_macs.branch%type default null, -- ���������
                            p_apply_date    wcs_subproduct_macs.apply_date%type default null -- ���������
                            ) return blob -- �������� ����
   is
    l_branch     wcs_subproduct_macs.branch%type := nvl(p_branch,
                                                        sys_context('bars_context',
                                                                    'user_branch'));
    l_apply_date wcs_subproduct_macs.apply_date%type := nvl(p_apply_date,
                                                            glb_bankdate);
    l_sm_row     wcs_subproduct_macs%rowtype;
    l_row_found  number := 0;
  begin
    -- ���� �� ���������� ����� ���� ���� �� ������� ���� ��� null
    while (l_row_found = 0 and l_branch is not null) loop
      -- ����� �������� ���� ��� �������� ���������
      begin
        select sm.*
          into l_sm_row
          from (select *
                  from (select *
                          from wcs_subproduct_macs
                         where subproduct_id = p_subproduct_id
                           and mac_id = p_mac_id
                           and branch = l_branch
                           and apply_date <= l_apply_date
                         order by apply_date desc)
                 where rownum = 1) sm,
               wcs_macs m
         where sm.mac_id = m.id
           and m.type_id = 'FILE';

        if (l_sm_row.val_file is not null) then
          l_row_found := 1;
        else
          l_row_found := 0;
        end if;
      exception
        when no_data_found then
          l_row_found := 0;
      end;

      -- ������ ��������� �� ������� �����
      l_branch := substr(l_branch, 0, length(l_branch) - 7);
    end loop;

    -- ���� �� ���������� ����� �� null
    if (l_row_found = 0) then
      return null;
    end if;

    -- ���������� ���������
    return l_sm_row.val_file;
  end get_sbp_mac_blob;

  -- ���������� �������� ���� (�������)
  function get_sbp_mac(p_subproduct_id wcs_subproduct_macs.subproduct_id%type, -- ������������� �����������
                       p_mac_id        wcs_subproduct_macs.mac_id%type, -- ������������� ����
                       p_branch        wcs_subproduct_macs.branch%type default null, -- ���������
                       p_apply_date    wcs_subproduct_macs.apply_date%type default null -- ���������
                       ) return varchar2 -- �������� ����
   is
    l_branch wcs_subproduct_macs.branch%type := nvl(p_branch,
                                                    sys_context('bars_context',
                                                                'user_branch'));

    l_apply_date wcs_subproduct_macs.apply_date%type := nvl(p_apply_date,
                                                            glb_bankdate);
    l_type_id    varchar2(100);
    l_sm_row     wcs_subproduct_macs%rowtype;
    l_row_found  number := 0;

    l_res varchar2(4000);
  begin
    -- ����� ��� ���������
    select t.type_id into l_type_id from wcs_macs t where t.id = p_mac_id;

    while (l_row_found = 0 and l_branch is not null) loop
      -- ����� �������� ���� ��� �������� ���������
      begin
        select *
          into l_sm_row
          from (select *
                  from wcs_subproduct_macs
                 where subproduct_id = p_subproduct_id
                   and mac_id = p_mac_id
                   and branch = l_branch
                   and apply_date <= l_apply_date
                 order by apply_date desc)
         where rownum = 1;

        l_row_found := 1;
      exception
        when no_data_found then
          l_row_found := 0;
      end;

      -- ������ ��������� �� ������� �����
      l_branch := substr(l_branch, 0, length(l_branch) - 7);
    end loop;

    -- ���� �� ���������� ����� �� null
    if (l_row_found = 0) then
      return null;
    end if;

    -- ���������� ��������� � ����������� �� ���� ���������
    case l_type_id
      when ('TEXT') then
        l_res := l_sm_row.val_text;
      when ('NUMB') then
        l_res := l_sm_row.val_numb;
      when ('DECIMAL') then
        l_res := l_sm_row.val_decimal;
      when ('DATE') then
        l_res := l_sm_row.val_date;
      when ('LIST') then
        l_res := l_sm_row.val_list;
      when ('REFER') then
        l_res := l_sm_row.val_refer;
      when ('BOOL') then
        l_res := l_sm_row.val_bool;
      else
        l_res := null;
    end case;

    return l_res;
  end get_sbp_mac;

  -- ���������� �������� ���� �������������� (�������)
  function get_sbp_mac_formated(p_subproduct_id wcs_subproduct_macs.subproduct_id%type, -- ������������� �����������
                                p_mac_id        wcs_subproduct_macs.mac_id%type, -- ������������� ����
                                p_branch        wcs_subproduct_macs.branch%type default null, -- ���������
                                p_apply_date    wcs_subproduct_macs.apply_date%type default null -- ���������
                                ) return varchar2 -- �������� ����
   is
    l_type_id varchar2(100);
    l_val     varchar2(4000);
    l_res     varchar2(4000);

    l_proc_name varchar2(40) := 'get_sbp_mac_formated. ';
  begin
    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Start. Params: p_subproduct_id=%s, p_mac_id=%s',
                     p_subproduct_id,
                     p_mac_id);

    -- ����� ��� ���������
    select t.type_id into l_type_id from wcs_macs t where t.id = p_mac_id;

    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Proccess. Params: l_type_id=%s',
                     l_type_id);

    -- �������� ������
    l_val := wcs_utl.get_sbp_mac(p_subproduct_id,
                                 p_mac_id,
                                 p_branch,
                                 p_apply_date);

    -- ���������� ��������� � ����������� �� ���� ���������
    case l_type_id
      when ('NUMB') then
        l_res := trim(to_char(to_number(l_val), '9999999999999999990'));
      when ('DECIMAL') then
        l_res := trim(to_char(to_number(l_val), '9999999999999999990.00'));
      when ('DATE') then
        l_res := to_char(to_date(l_val), 'dd.mm.yyyy');
      when ('LIST') then
        begin
          select mli.text
            into l_res
            from wcs_mac_list_items mli
           where mli.mac_id = p_mac_id
             and mli.ord = to_number(l_val);
        exception
          when no_data_found then
            l_res := '';
        end;
      when ('REFER') then
        l_res := l_val;
      when ('BOOL') then
        select decode(to_number(l_val), 1, '���', 0, 'ͳ')
          into l_res
          from dual;
      else
        l_res := '';
    end case;

    case l_type_id
      when ('TEXT') then
        l_res := get_val_formated(l_val, 'TEXT');
      when ('NUMB') then
        l_res := get_val_formated(l_val, 'NUMB');
      when ('DECIMAL') then
        l_res := get_val_formated(l_val, 'DECIMAL');
      when ('DATE') then
        l_res := get_val_formated(l_val, 'DATE');
      when ('LIST') then
        l_res := get_val_formated(l_val,
                                  'LIST_MAC',
                                  null,
                                  null,
                                  null,
                                  null,
                                  p_mac_id);
      when ('REFER') then
        l_res := get_val_formated(l_val,
                                  'REFER_MAC',
                                  null,
                                  null,
                                  null,
                                  null,
                                  p_mac_id);
      when ('BOOL') then
        l_res := get_val_formated(l_val, 'BOOL');
      else
        l_res := '';
    end case;

    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Finish. Params: l_res=%s',
                     l_res);

    return l_res;
  end get_sbp_mac_formated;

  -- ���������� �������� ���� (�������)
  function get_mac(p_bid_id wcs_bids.id%type, -- ������������� ������
                   p_mac_id wcs_macs.id%type -- ������������� ����
                   ) return varchar2 -- �������� ����
   is
    l_b_row wcs_bids%rowtype;
    l_res   varchar2(4000);
  begin
    -- ����� ������
    select b.* into l_b_row from wcs_bids b where b.id = p_bid_id;

    -- ����� ��������
    l_res := wcs_utl.get_sbp_mac(l_b_row.subproduct_id,
                                 p_mac_id,
                                 l_b_row.branch,
                                 l_b_row.crt_date);

    return l_res;
  end get_mac;

  -- ���������� �������������� �������� ���� (�������)
  function get_mac_formated(p_bid_id wcs_bids.id%type, -- ������������� ������
                            p_mac_id wcs_macs.id%type -- ������������� ����
                            ) return varchar2 -- �������� ����
   is
    l_b_row wcs_bids%rowtype;
    l_res   varchar2(4000);
  begin
    -- ����� ������
    select b.* into l_b_row from wcs_bids b where b.id = p_bid_id;

    -- ����� ��������
    l_res := wcs_utl.get_sbp_mac_formated(l_b_row.subproduct_id,
                                          p_mac_id,
                                          l_b_row.branch,
                                          l_b_row.crt_date);

    return l_res;
  end get_mac_formated;

  -- ������������ ����������� ����� �������
  function get_score(p_bid_id      wcs_answers.bid_id%type, -- ������������� ������
                     p_scoring_id  wcs_scorings.id%type, -- ������������� ����� ��������
                     p_question_id wcs_answers.question_id%type, -- ������������� �������
                     p_ws_id       wcs_answers.ws_id%type default g_cur_ws_id, -- ������������� �������� ������������
                     p_ws_number   wcs_answers.ws_number%type default g_cur_ws_num -- ����� �������� ������������
                     ) return number -- ����������� �����
   is
    l_b_row  wcs_bids%rowtype;
    l_q_row  wcs_questions%rowtype;
    l_sq_row wcs_scoring_questions%rowtype;

    l_sql varchar2(4000);

    l_score number;

    ----------------------------------------
    -- ����� ����� ���-������ ������� - NUMB
    function qet_matrix_numb_ord(p_bid_id      number,
                                 p_scoring_id  varchar2,
                                 p_question_id varchar2,
                                 p_axis_qid    varchar2) return number is
      l_val number;

      l_mins wcs_sign_types.sign%type;
      l_maxs wcs_sign_types.sign%type;

      l_sql varchar2(4000);
    begin
      -- ����� ��������
      l_val := wcs_utl.get_answ(p_bid_id, p_axis_qid);

      -- ��������� ��� �������
      for c in (select *
                  from wcs_scoring_qs_matrix_numb t
                 where t.scoring_id = p_scoring_id
                   and t.question_id = p_question_id
                   and t.axis_qid = p_axis_qid
                 order by t.ord) loop
        -- �����
        select s.sign
          into l_mins
          from wcs_sign_types s
         where s.id = c.min_sign;
        select s.sign
          into l_maxs
          from wcs_sign_types s
         where s.id = c.max_sign;

        -- ��������� ��������
        l_sql := to_char(c.min_val) || ' ' || l_mins || ' ''' ||
                 to_char(l_val) || '''';
        l_sql := l_sql || ' and ''' || to_char(l_val) || ''' ' || l_maxs || ' ' ||
                 to_char(c.max_val);

        -- ���� ��������� ������������� �� ���������� �����
        if (wcs_utl.calc_sql_bool(p_bid_id, l_sql) = 1) then
          return c.ord;
        end if;
      end loop;

      -- ���� �� �����
      return null;
    end qet_matrix_numb_ord;
    -- ����� ����� ���-������ ������� - DECIMAL
    function qet_matrix_dec_ord(p_bid_id      number,
                                p_scoring_id  varchar2,
                                p_question_id varchar2,
                                p_axis_qid    varchar2) return number is
      l_val number;

      l_mins wcs_sign_types.sign%type;
      l_maxs wcs_sign_types.sign%type;

      l_sql varchar2(4000);
    begin
      -- ����� ��������
      l_val := wcs_utl.get_answ(p_bid_id, p_axis_qid);

      -- ��������� ��� �������
      for c in (select *
                  from wcs_scoring_qs_matrix_decimal t
                 where t.scoring_id = p_scoring_id
                   and t.question_id = p_question_id
                   and t.axis_qid = p_axis_qid
                 order by t.ord) loop
        -- �����
        select s.sign
          into l_mins
          from wcs_sign_types s
         where s.id = c.min_sign;
        select s.sign
          into l_maxs
          from wcs_sign_types s
         where s.id = c.max_sign;

        -- ��������� ��������
        l_sql := to_char(c.min_val) || ' ' || l_mins || ' ''' ||
                 to_char(l_val) || '''';
        l_sql := l_sql || ' and ''' || to_char(l_val) || ''' ' || l_maxs || ' ' ||
                 to_char(c.max_val);

        -- ���� ��������� ������������� �� ���������� �����
        if (wcs_utl.calc_sql_bool(p_bid_id, l_sql) = 1) then
          return c.ord;
        end if;
      end loop;

      -- ���� �� �����
      return null;
    end qet_matrix_dec_ord;
    -- ����� ����� ���-������ ������� - DATE
    function qet_matrix_dat_ord(p_bid_id      number,
                                p_scoring_id  varchar2,
                                p_question_id varchar2,
                                p_axis_qid    varchar2) return number is
      l_val date;

      l_mins wcs_sign_types.sign%type;
      l_maxs wcs_sign_types.sign%type;

      l_sql varchar2(4000);
    begin
      -- ����� ��������
      l_val := wcs_utl.get_answ(p_bid_id, p_axis_qid);

      -- ��������� ��� �������
      for c in (select *
                  from wcs_scoring_qs_matrix_date t
                 where t.scoring_id = p_scoring_id
                   and t.question_id = p_question_id
                   and t.axis_qid = p_axis_qid
                 order by t.ord) loop
        -- �����
        select s.sign
          into l_mins
          from wcs_sign_types s
         where s.id = c.min_sign;
        select s.sign
          into l_maxs
          from wcs_sign_types s
         where s.id = c.max_sign;

        -- ��������� ��������
        l_sql := 'to_date(''' || to_char(c.min_val) || ''') ' || l_mins ||
                 ' to_date(''' || to_char(l_val) || ''') ';
        l_sql := l_sql || ' and to_date(''' || to_char(l_val) || ''') ' ||
                 l_maxs || ' to_date(''' || to_char(c.max_val) || ''') ';

        -- ���� ��������� ������������� �� ���������� �����
        if (wcs_utl.calc_sql_bool(p_bid_id, l_sql) = 1) then
          return c.ord;
        end if;
      end loop;

      -- ���� �� �����
      return null;
    end qet_matrix_dat_ord;
    -- ����� ����� ���-������ ������� - LIST
    function qet_matrix_list_ord(p_bid_id      number,
                                 p_scoring_id  varchar2,
                                 p_question_id varchar2,
                                 p_axis_qid    varchar2) return number is
      l_val number;
    begin
      -- ����� ��������
      l_val := wcs_utl.get_answ(p_bid_id, p_axis_qid);

      -- ���������� ��������
      return l_val;
    end qet_matrix_list_ord;
    -- ����� ����� ���-������ ������� - BOOL
    function qet_matrix_bool_ord(p_bid_id      number,
                                 p_scoring_id  varchar2,
                                 p_question_id varchar2,
                                 p_axis_qid    varchar2) return number is
      l_val number;
    begin
      -- ����� ��������
      l_val := wcs_utl.get_answ(p_bid_id, p_axis_qid);

      -- ���������� ��������
      return l_val;
    end qet_matrix_bool_ord;
    ----------------------------------------

  begin
    -- ���������
    select * into l_b_row from wcs_bids b where b.id = p_bid_id;
    select * into l_q_row from wcs_questions q where q.id = p_question_id;
    select *
      into l_sq_row
      from wcs_scoring_questions sq
     where sq.scoring_id = p_scoring_id
       and sq.question_id = p_question_id;

    -- ��������� �������� �� ��������
    if (wcs_utl.get_answ(p_bid_id, p_question_id, p_ws_id, p_ws_number) is null) then
      return l_sq_row.else_score;
    end if;

    -- ���������� ��������� � ����������� �� ���� ���������
    case l_q_row.type_id
      when ('NUMB') then
        declare
          l_val_ number;

          l_mins_ wcs_sign_types.sign%type;
          l_maxs_ wcs_sign_types.sign%type;
        begin
          -- ����� ��������
          l_val_ := wcs_utl.get_answ(p_bid_id,
                                     p_question_id,
                                     p_ws_id,
                                     p_ws_number);

          -- ��������� ��� �������
          for c in (select *
                      from wcs_scoring_qs_numb t
                     where t.scoring_id = p_scoring_id
                       and t.question_id = p_question_id
                     order by t.ord) loop
            -- �����
            select s.sign
              into l_mins_
              from wcs_sign_types s
             where s.id = c.min_sign;
            select s.sign
              into l_maxs_
              from wcs_sign_types s
             where s.id = c.max_sign;

            -- ��������� ��������
            l_sql := to_char(c.min_val) || ' ' || l_mins_ || ' ''' ||
                     to_char(l_val_) || '''';
            l_sql := l_sql || ' and ''' || to_char(l_val_) || ''' ' ||
                     l_maxs_ || ' ' || to_char(c.max_val);

            -- ���� ��������� ������������� �� ���������� �����
            if (wcs_utl.calc_sql_bool(p_bid_id, l_sql) = 1) then
              return c.score;
            end if;
          end loop;

          -- ���� ������ ���������� �� ������� �� ���������� �������� "�����"
          return l_sq_row.else_score;
        end;

      when ('DECIMAL') then
        declare
          l_val_ number;

          l_mins_ wcs_sign_types.sign%type;
          l_maxs_ wcs_sign_types.sign%type;

          l_min wcs_scoring_qs_decimal.min_val%type;
          l_max wcs_scoring_qs_decimal.max_val%type;
        begin
          -- ����� ��������
          l_val_ := wcs_utl.get_answ(p_bid_id,
                                     p_question_id,
                                     p_ws_id,
                                     p_ws_number);

          -- ��������/�������� �������� ���������
          select min(LEAST   (t.min_val, t.max_val)),
                 max(GREATEST(t.min_val, t.max_val))
             into l_min, l_max
            from wcs_scoring_qs_decimal t
           where t.scoring_id = p_scoring_id
             and t.question_id = p_question_id;

          -- �������� �������� �� ���� ��������� �� �������
          if     l_val_ < l_min then
            l_val_ := l_min;
          elsif  l_val_ > l_max then
            l_val_ := l_max;
          else
            l_val_ := l_val_;
          end if;

          -- ��������� ��� �������
          for c in (select *
                      from wcs_scoring_qs_decimal t
                     where t.scoring_id = p_scoring_id
                       and t.question_id = p_question_id
                     order by t.ord) loop
            -- �����
            select s.sign
              into l_mins_
              from wcs_sign_types s
             where s.id = c.min_sign;
            select s.sign
              into l_maxs_
              from wcs_sign_types s
             where s.id = c.max_sign;

            -- ��������� ��������
            l_sql := 'to_number(''' || to_char(c.min_val) || ''') ' ||
                     l_mins_ || ' to_number(''' || to_char(l_val_) || ''')';
            l_sql := l_sql || ' and to_number(''' || to_char(l_val_) ||
                     ''') ' || l_maxs_ || ' to_number(''' ||
                     to_char(c.max_val) || ''')';

            -- ���� ��������� ������������� �� ���������� �����
            if (wcs_utl.calc_sql_bool(p_bid_id, l_sql) = 1) then
              /*return (case l_val_
                        when c.min_val then c.score
                        when c.max_val then c.score_max
                        else (c.score + ((c.score_max - c.score)*((l_val_ - c.min_val)/(c.max_val - c.min_val))))
                       end);*/return c.score;
            end if;
          end loop;

          -- ���� ������ ���������� �� ������� �� ���������� �������� "�����"
          return nvl(l_sq_row.else_score,0);
        end;

      when ('DATE') then
        declare
          l_val_ date;

          l_mins_ wcs_sign_types.sign%type;
          l_maxs_ wcs_sign_types.sign%type;
        begin
          -- ����� ��������
          l_val_ := wcs_utl.get_answ(p_bid_id,
                                     p_question_id,
                                     p_ws_id,
                                     p_ws_number);

          -- ��������� ��� �������
          for c in (select *
                      from wcs_scoring_qs_date t
                     where t.scoring_id = p_scoring_id
                       and t.question_id = p_question_id
                     order by t.ord) loop
            -- �����
            select s.sign
              into l_mins_
              from wcs_sign_types s
             where s.id = c.min_sign;
            select s.sign
              into l_maxs_
              from wcs_sign_types s
             where s.id = c.max_sign;

            -- ��������� ��������
            l_sql := 'to_date(''' || to_char(c.min_val) || ''') ' ||
                     l_mins_ || ' to_date(''' || to_char(l_val_) || ''') ';
            l_sql := l_sql || ' and to_date(''' || to_char(l_val_) ||
                     ''') ' || l_maxs_ || ' to_date(''' ||
                     to_char(c.max_val) || ''') ';

            -- ���� ��������� ������������� �� ���������� �����
            if (wcs_utl.calc_sql_bool(p_bid_id, l_sql) = 1) then
              return c.score;
            end if;
          end loop;

          -- ���� ������ ���������� �� ������� �� ���������� �������� "�����"
          return l_sq_row.else_score;
        end;

      when ('LIST') then
        declare
          l_val_ number;
        begin
          -- ����� ��������
          l_val_ := wcs_utl.get_answ(p_bid_id,
                                     p_question_id,
                                     p_ws_id,
                                     p_ws_number);

          -- ��������� ��� �������
          for c in (select *
                      from wcs_scoring_qs_list t
                     where t.scoring_id = p_scoring_id
                       and t.question_id = p_question_id
                     order by t.ord) loop
            -- ������� ��������������� �����
            if (c.ord = l_val_) then
              return c.score;
            end if;
          end loop;

          -- ���� ������ ���������� �� ������� �� ���������� �������� "�����"
          return l_sq_row.else_score;
        end;

      when ('BOOL') then
        declare
          l_val_ number;

          l_scoring_qs_bool_ wcs_scoring_qs_bool%rowtype;
        begin
          -- ����� ��������
          l_val_ := wcs_utl.get_answ(p_bid_id,
                                     p_question_id,
                                     p_ws_id,
                                     p_ws_number);

          -- ����� �����
          select *
            into l_scoring_qs_bool_
            from wcs_scoring_qs_bool t
           where t.scoring_id = p_scoring_id
             and t.question_id = p_question_id;
          -- ��������� ��� �������
          if (l_val_ = 1) then
            return l_scoring_qs_bool_.score_if_1;
          else
            return l_scoring_qs_bool_.score_if_0;
          end if;

          -- ���� ������ ���������� �� ������� �� ���������� �������� "�����"
          return l_sq_row.else_score;
        end;
        /*
              when ('MATRIX') then
                declare
                  type t_axis_list is table of number index by binary_integer;
                  l_axis_list t_axis_list;
                  l_al_idx    number := 0;

                  l_axis_qid     varchar2(100);
                  l_axis_type_id varchar2(100);
                begin
                  -- ���������� ��� ���
                  for c in (select *
                              from wcs_question_matrix_params t
                             where t.question_id = question_id_
                             order by t.ord) loop
                    -- ��������� �������-���
                    l_axis_qid := c.axis_qid;
                    select t.type_id
                      into l_axis_type_id
                      from wcs_questions t
                     where t.id = l_axis_qid;

                    -- ����� �������� ������ �� ���
                    case l_axis_type_id
                      when ('NUMB') then
                        l_axis_list(l_al_idx) := qet_matrix_numb_ord(bid_id_,
                                                                     scoring_id_,
                                                                     question_id_,
                                                                     l_axis_qid);
                      when ('DECIMAL') then
                        l_axis_list(l_al_idx) := qet_matrix_dec_ord(bid_id_,
                                                                    scoring_id_,
                                                                    question_id_,
                                                                    l_axis_qid);
                      when ('DATE') then
                        l_axis_list(l_al_idx) := qet_matrix_dat_ord(bid_id_,
                                                                    scoring_id_,
                                                                    question_id_,
                                                                    l_axis_qid);
                      when ('LIST') then
                        l_axis_list(l_al_idx) := qet_matrix_list_ord(bid_id_,
                                                                     scoring_id_,
                                                                     question_id_,
                                                                     l_axis_qid);
                      when ('BOOL') then
                        l_axis_list(l_al_idx) := qet_matrix_bool_ord(bid_id_,
                                                                     scoring_id_,
                                                                     question_id_,
                                                                     l_axis_qid);
                    end case;

                    -- ����������� ������
                    l_al_idx := l_al_idx + 1;
                  end loop;

                  -- ��������� ����� ��������
                  while (l_al_idx <= 4) loop
                    l_axis_list(l_al_idx) := null;
                    l_al_idx := l_al_idx + 1;
                  end loop;

                  -- ���� ������ ���������� �� ������� �� ���������� �������� "�����"
                  begin
                    select t.score
                      into l_score_
                      from wcs_scoring_qs_matrix t
                     where t.scoring_id = scoring_id_
                       and t.question_id = question_id_
                       and t.axis0_ord = l_axis_list(0)
                       and t.axis1_ord = l_axis_list(1)
                       and (t.axis2_ord = l_axis_list(2) or
                           (t.axis2_ord is null and l_axis_list(2) is null))
                       and (t.axis3_ord = l_axis_list(3) or
                           (t.axis3_ord is null and l_axis_list(3) is null))
                       and (t.axis4_ord = l_axis_list(4) or
                           (t.axis4_ord is null and l_axis_list(4) is null));
                  exception
                    when no_data_found then
                      -- ���� ������ ���������� �� ������� �� ���������� �������� "�����"
                      return l_else_score_;
                  end;

                  -- ���������� ���������
                  return l_score_;
                end;
        */
      else
        return l_sq_row.else_score;
    end case;
  end get_score;

  -- ������������ �������������� ��� �����������
  function calc_kzb(p_bid_id wcs_answers.bid_id%type) return number
    is
      l_mzS decimal;
      l_mzSQ decimal;
      l_vzS decimal;
      l_vzSQ decimal;
      l_res decimal;
  begin
    select sum(wcs_utl.get_answ(bg.bid_id, 'MZ', bg.ws_id, bg.garantee_num) * grt_cost),
           sum(grt_cost)
      into l_mzSQ, l_mzS
      from v_wcs_bid_garantees bg, grt_types t
     where bg.bid_id = p_bid_id
       and bg.type_obu_id = t.type_id
       and t.group_id = 3;

    select sum((case
             when wcs_utl.get_answ_list(bg.bid_id,'GRT_3_1',bg.ws_id, bg.garantee_num) = 0 and wcs_utl.get_answ_list(bg.bid_id,'GRT_3_1',bg.ws_id, bg.garantee_num) = 0 then 18
             when wcs_utl.get_answ_list(bg.bid_id,'GRT_3_1',bg.ws_id, bg.garantee_num) = 1 and wcs_utl.get_answ_list(bg.bid_id,'GRT_3_1',bg.ws_id, bg.garantee_num) = 0 then 16
            else 8
           end)* grt_cost),
           sum(grt_cost)
    into l_vzSQ, l_vzS
    from v_wcs_bid_garantees bg where bg.bid_id = p_bid_id and bg.garantee_id = 'VEHICLE';

    l_res := case nvl(l_mzS,0) + nvl(l_vzS,0)
              when 0 then 0
              else (nvl(l_mzSQ,0) + nvl(l_vzSQ,0))/(nvl(l_mzS,0) + nvl(l_vzS,0))
             end;

    return l_res;
  end calc_kzb;

  -- ������������ ����������� ����� ����� ��������
  function get_general_score(p_bid_id     wcs_answers.bid_id%type, -- ������������� ������
                             p_scoring_id wcs_scorings.id%type, -- ������������� ����� ��������
                             p_type       varchar2, -- ��� ������� ���� ����� (STANDART - �����������, OBU - ���������� ���)
                             p_ws_id      wcs_answers.ws_id%type default g_cur_ws_id, -- ������������� �������� ������������
                             p_ws_number  wcs_answers.ws_number%type default g_cur_ws_num -- ����� �������� ������������
                             ) return number -- ����������� �����
   is
    l_score number := 0;
  begin
    case
      when p_type = 'OBU' then
        -- OBU - ���������� ��� � ������ ����. ������������������ �����, ������������, ���������� ����������� �����������/������������ ����������� 70/30)
        declare
          l_kpp number; -- ���������� ���������������� ������������ (���)
          l_kps number; -- ���������� ���������������� �쒿 ������������ (���)
          l_4p  number; -- ������ ��������� ������� � ������� ��������� ����� ������������ (��)
          l_dp  number; -- �������� ������ ��������� ������� (��)

          l_vn        number; -- �������� ������ ���������� (��)
          l_pr        number; -- �������� ������� ������ (��)
          l_cl_31     number; -- ��������� ���� ������ (������)
          l_sm        number; -- ѳ������ ���� �� ���� ���������� (��)
          l_vvk       number; -- ³� ������������ �� ������ ������ ������� (���)
          l_vpk       number; -- ³� ������������ �� ������ ��������� ������� (���)
          l_pkred     number; -- ��������� ������� (��)
          l_mz_vmaina number; -- ̳�������������� ��'���� ������� (��) (��� ����������)/��� ����� (��) (��� �������� ����� �� �������� ����)

          l_szdor       number; -- ������������� ������������ (���� ������'�) (��)
          l_r           number; -- �������� �� ��� ������� � ����� (�)
          l_cl_0_135    number; -- �������� �����
          l_compensator number; -- �����������

          l_balls_ojective   number;
          l_balls_subjective number;
          l_balls_total      number;
        begin
          l_kpp := wcs_utl.get_score(p_bid_id,
                                     p_scoring_id,
                                     'KPP',
                                     p_ws_id,
                                     p_ws_number);
          l_kps := case
                     when p_ws_id = 'GRT_GUARANTOR' then
                     -- ��� ���������� ������ ���������� kps ����� kpp
                      l_kpp
                     when wcs_utl.get_answ_bool(p_bid_id, 'CL_34_1') = 1 then
                     -- ����������� ������/������� �������/������� � �������/�������� ��`�?
                      wcs_utl.get_score(p_bid_id,
                                        p_scoring_id,
                                        'KPS',
                                        p_ws_id,
                                        p_ws_number)
                     else
                      l_kpp
                   end;
          l_4p  := wcs_utl.get_score(p_bid_id,
                                     p_scoring_id,
                                     '4P',
                                     p_ws_id,
                                     p_ws_number);
          l_dp  := wcs_utl.get_score(p_bid_id,
                                     p_scoring_id,
                                     'DP',
                                     p_ws_id,
                                     p_ws_number);

          l_vn        := wcs_utl.get_score(p_bid_id,
                                           p_scoring_id,
                                           'VN',
                                           p_ws_id,
                                           p_ws_number);
          l_pr        := wcs_utl.get_score(p_bid_id,
                                           p_scoring_id,
                                           'PR',
                                           p_ws_id,
                                           p_ws_number);
          l_cl_31     := wcs_utl.get_score(p_bid_id,
                                           p_scoring_id,
                                           'CL_31',
                                           p_ws_id,
                                           p_ws_number);
          l_sm        := wcs_utl.get_score(p_bid_id,
                                           p_scoring_id,
                                           'SM',
                                           p_ws_id,
                                           p_ws_number);
          l_vvk       := wcs_utl.get_score(p_bid_id,
                                           p_scoring_id,
                                           'VVK',
                                           p_ws_id,
                                           p_ws_number);
          l_vpk       := wcs_utl.get_score(p_bid_id,
                                           p_scoring_id,
                                           'VPK',
                                           p_ws_id,
                                           p_ws_number);
          l_pkred     := wcs_utl.get_score(p_bid_id,
                                           p_scoring_id,
                                           'PKRED',
                                           p_ws_id,
                                           p_ws_number);
          l_mz_vmaina := wcs_utl.get_score(p_bid_id,
                                           p_scoring_id,
                                           'MZ_VMAINA',
                                           p_ws_id,
                                           p_ws_number);

          l_szdor       := wcs_utl.get_score(p_bid_id,
                                             p_scoring_id,
                                             'SZDOR',
                                             p_ws_id,
                                             p_ws_number);
          l_r           := wcs_utl.get_score(p_bid_id,
                                             p_scoring_id,
                                             'R',
                                             p_ws_id,
                                             p_ws_number);
          l_cl_0_135    := wcs_utl.get_score(p_bid_id,
                                             p_scoring_id,
                                             'CL_0_135',
                                             p_ws_id,
                                             p_ws_number);
          l_compensator := to_number(wcs_utl.get_answ(p_bid_id,
                                                      'COMPENSATOR',
                                                      p_ws_id,
                                                      p_ws_number));

          l_balls_ojective   := l_kpp + l_kps + l_4p + l_dp + l_vn + l_pr +
                                l_cl_31 + l_sm + l_vvk + l_vpk + l_pkred +
                                l_mz_vmaina;
          l_balls_subjective := l_szdor + l_r + l_cl_0_135 + l_compensator;
          l_balls_total      := l_balls_ojective + l_balls_subjective;

          if (l_balls_subjective / l_balls_total) > (3 / 10) then
            l_score := l_balls_ojective * 100 / 70;
          else
            l_score := l_balls_total;
          end if;
        end;
      else
        -- STANDART - ����������� ������ ������
        for c in (select t.question_id, t.result_qid
                    from wcs_scoring_questions t
                   where t.scoring_id = p_scoring_id) loop
                   bars_audit.info('QUESTION '||c.question_id);
          l_score := l_score +
                     to_number(wcs_utl.get_answ(p_bid_id,
                                                c.result_qid,
                                                p_ws_id,
                                                p_ws_number));
                   bars_audit.info('QUESTION SCORE '||to_char(l_score));
        end loop;
    end case;

    return l_score;
  end get_general_score;

  -- ��������� �������� ����-�������/-�������
  function get_stop(p_bid_id  number, -- ������������� ������
                    p_stop_id varchar2 -- ������������� �����
                    ) return number -- �������� ����-�������
   is
    l_wcs_stop wcs_stops%rowtype;
    l_res      number;
  begin
    -- ����� ��������� ����-�������
    select * into l_wcs_stop from wcs_stops t where t.id = p_stop_id;

    -- ���������
    l_res := to_number(wcs_utl.calc_sql_bool(p_bid_id, l_wcs_stop.plsql));

    return l_res;
  end get_stop;

  -- ������� ������ � ������� ������ �� ���������� ����-��������
  procedure create_iquery_job(p_bid_id      wcs_jobs.bid_id%type, -- ������������� ������
                              p_iquery_id   wcs_jobs.iquery_id%type, -- ������������� ��������������� �������
                              p_rs_id       wcs_jobs.rs_id%type, -- ������������� ������ �������
                              p_rs_iqs_tcnt wcs_jobs.rs_iqs_tcnt%type, -- ���-�� ����-�������� � ������ �������
                              p_rs_state_id wcs_jobs.rs_state_id%type -- ��������� ������ �������
                              ) is
    l_status_id wcs_jobs.status_id%type := 'WAIT';
  begin
    insert into wcs_jobs
      (bid_id, iquery_id, status_id, rs_id, rs_iqs_tcnt, rs_state_id)
    values
      (p_bid_id,
       p_iquery_id,
       l_status_id,
       p_rs_id,
       p_rs_iqs_tcnt,
       p_rs_state_id);

  exception
    when dup_val_on_index then
      update wcs_jobs j
         set j.status_id   = l_status_id,
             j.rs_id       = p_rs_id,
             j.rs_iqs_tcnt = p_rs_iqs_tcnt,
             j.rs_state_id = p_rs_state_id
       where j.bid_id = p_bid_id
         and j.iquery_id = p_iquery_id;

  end create_iquery_job;

  -- ������������� ��������� ���������� ����-�������
  procedure set_iquery_status(p_bid_id    wcs_jobs.bid_id%type, -- ������������� ������
                              p_iquery_id wcs_jobs.iquery_id%type, -- ������������� ��������������� �������
                              p_ws_id     wcs_workspaces.id%type, -- ������� ������������ ��� ��������� �����������
                              p_status_id wcs_jobs.status_id%type, -- ������������� ������� JOB�
                              p_err_msg   wcs_jobs.err_msg%type default null -- ����� ������
                              ) is
    l_i_row wcs_infoqueries%rowtype;
  begin
    -- ��������� �������
    select * into l_i_row from wcs_infoqueries i where i.id = p_iquery_id;

    -- ������������� ������ � ������� ������
    update wcs_jobs j
       set j.status_id = p_status_id, j.err_msg = p_err_msg
     where j.bid_id = p_bid_id
       and j.iquery_id = p_iquery_id;

    -- ������������� ������ � ��������-�����������
    case p_status_id
      when 'WAIT' then
        -- 0 - �����
        wcs_pack.answ_list_set(p_bid_id, l_i_row.result_qid, 0, p_ws_id, 0);
        wcs_pack.answ_del(p_bid_id, l_i_row.result_msg_qid, p_ws_id, 0);
      when 'WORK' then
        -- 1 - ����������
        wcs_pack.answ_list_set(p_bid_id, l_i_row.result_qid, 1, p_ws_id, 0);
        wcs_pack.answ_del(p_bid_id, l_i_row.result_msg_qid, p_ws_id, 0);
      when 'DONE' then
        -- 2 - ��������
        wcs_pack.answ_list_set(p_bid_id, l_i_row.result_qid, 2, p_ws_id, 0);
        wcs_pack.answ_del(p_bid_id, l_i_row.result_msg_qid, p_ws_id, 0);
      when 'ERROR' then
        -- 3 - �������
        wcs_pack.answ_list_set(p_bid_id, l_i_row.result_qid, 3, p_ws_id, 0);
        wcs_pack.answ_text_set(p_bid_id,
                               l_i_row.result_msg_qid,
                               p_err_msg,
                               p_ws_id,
                               0);
    end case;
  end set_iquery_status;

  -- ������ ������ ������ � ������� �� ����������
  procedure setup_iquery(p_bid_id      wcs_jobs.bid_id%type, -- ������������� ������
                         p_iquery_id   wcs_jobs.iquery_id%type, -- ������������� ��������������� �������
                         p_rs_id       wcs_jobs.rs_id%type, -- ������������� ������ �������
                         p_rs_iqs_tcnt wcs_jobs.rs_iqs_tcnt%type, -- ���-�� ����-�������� � ������ �������
                         p_rs_state_id wcs_jobs.rs_state_id%type, -- ��������� ������ �������
                         p_lag         in number default 0) is
    l_job_id     number;
    l_job_name   varchar2(4000) := p_iquery_id || '_for_' || p_bid_id;
    l_job_what   varchar2(4000);
    l_start_date timestamp(6) with time zone := current_timestamp;
    l_comments   varchar2(4000) := 'WCS: info-query ' || p_iquery_id ||
                                   ' for bid #' || p_bid_id;

    l_i_row wcs_infoqueries%rowtype;
  begin
    -- ����� �� �������
    l_start_date := l_start_date + numtodsinterval(p_lag, 'SECOND');

    -- ��������� �������
    select * into l_i_row from wcs_infoqueries i where i.id = p_iquery_id;

    -- ��������� � �������
    create_iquery_job(p_bid_id,
                      p_iquery_id,
                      p_rs_id,
                      p_rs_iqs_tcnt,
                      p_rs_state_id);
    set_iquery_status(p_bid_id, p_iquery_id, 'MAIN', 'WAIT');

    l_job_what := 'begin bars.bars_login.login_user(sys_guid(), 1, null, null); bars.wcs_utl.run_iquery(' ||
                  p_bid_id || ', ''' || p_iquery_id || '''); end;';

    -- ��������� JOB
    dbms_scheduler.create_job(job_name   => l_job_name,
                              job_type   => 'PLSQL_BLOCK',
                              job_action => l_job_what,
                              start_date => l_start_date,
                              enabled    => true,
                              auto_drop  => true,
                              comments   => l_comments);

    logger.trace('wcs_utl.setup_iquery: Finish.');
  end setup_iquery;

  -- ��������� ������ ������, ������������� ��������
  procedure run_iquery(p_bid_id    number, -- ������������� ������
                       p_iquery_id varchar2 -- ������������� ��������������� �������
                       ) is
    l_i_row  wcs_infoqueries%rowtype;
    l_si_row wcs_subproduct_infoqueries%rowtype;
  begin
    -- ��������� �������
    select * into l_i_row from wcs_infoqueries i where i.id = p_iquery_id;
    select *
      into l_si_row
      from wcs_subproduct_infoqueries si
     where si.subproduct_id =
           (select b.subproduct_id from wcs_bids b where b.id = p_bid_id)
       and si.iquery_id = p_iquery_id;

    -- ������������� ������
    set_iquery_status(p_bid_id, p_iquery_id, 'MAIN', 'WORK');

    -- ��������� ��� �������
    case (l_i_row.type_id)
      when 'MANUAL' then
        begin
          -- ������ ����������� �������
          null;
        end;
      else
        -- EXTERNAL, INTERNAL
        declare
          l_res varchar2(4000);
        begin
          -- ��������� ���������
          l_res := wcs_utl.exec_sql(p_bid_id,
                                    null,
                                    dbms_lob.substr(l_i_row.plsql, 32000));

          -- ������ ����������
          if (l_res is null) then
            wcs_utl.stop_iquery(p_bid_id, p_iquery_id, 'MAIN', 'DONE');
          else
            wcs_utl.stop_iquery(p_bid_id,
                                p_iquery_id,
                                'MAIN',
                                'ERROR',
                                l_res);
          end if;
        end;
    end case;
  end run_iquery;

  -- ����������� ���������� ������ �������
  procedure stop_iquery(p_bid_id    wcs_jobs.bid_id%type, -- ������������� ������
                        p_iquery_id wcs_jobs.iquery_id%type, -- ������������� ��������������� �������
                        p_ws_id     wcs_workspaces.id%type default 'MAIN', -- ������������� ������������� �������� ������������
                        p_status_id wcs_jobs.status_id%type default 'DONE', -- ������������� ������� JOB�
                        p_err_msg   wcs_jobs.err_msg%type default null -- ����� ������
                        ) is
    l_done_err_cnt number;

    l_i_row  wcs_infoqueries%rowtype;
    l_si_row wcs_subproduct_infoqueries%rowtype;
    l_j_row  wcs_jobs%rowtype;
  begin
    -- ��������� �������
    select i.*
      into l_i_row
      from wcs_infoqueries i
     where i.id = p_iquery_id;
    select si.*
      into l_si_row
      from wcs_subproduct_infoqueries si, wcs_bids b
     where b.id = p_bid_id
       and si.subproduct_id = b.subproduct_id
       and si.iquery_id = p_iquery_id;

    -- ������������� ���������
    set_iquery_status(p_bid_id,
                      p_iquery_id,
                      p_ws_id,
                      p_status_id,
                      p_err_msg);

    -- ������������ ������� ������� ��� ���� ��������
    if (l_i_row.type_id != 'MANUAL') then
      select j.*
        into l_j_row
        from wcs_jobs j
       where j.bid_id = p_bid_id
         and j.iquery_id = p_iquery_id;

      -- ������� ��� �� JOB� �����������
      select count(*)
        into l_done_err_cnt
        from wcs_jobs j
       where j.bid_id = p_bid_id
         and (j.status_id = 'DONE' or j.status_id = 'ERROR');

      if (l_done_err_cnt = l_j_row.rs_iqs_tcnt) then
        -- ������ �������
        delete from wcs_jobs j where j.bid_id = p_bid_id;
        wcs_pack.bid_state_del(p_bid_id, l_j_row.rs_state_id);
      end if;
    end if;

    logger.trace('wcs_utl.stop_iquery: Finish.');
  end stop_iquery;

  /*
    -- �������������� ������ �� ������ �� CC_interactive
    procedure bid_prefill_from_ccinter(p_bid_id number -- ������������� ������
                                       ) is
      l_ccinter_id number;
      l_inn        varchar2(10);

      l_proc_name varchar2(100) := 'bid_prefill_from_ccinter. ';
    begin
      bars_audit.trace(g_pack_name || l_proc_name ||
                       'Start. Params: p_bid_id=%s',
                       to_char(p_bid_id));

      /*-- �������� dblink
      declare
        is_dblink_alive number := 0;
      begin
        select 1
          into is_dblink_alive
          from db2isa.clients@db2 cl
         where rownum = 1;
      exception
        when others then
          bars_audit.trace(g_pack_name || l_proc_name ||
                           'Finish. DBLink is NOT alive');
          return;
      end;

      -- ��� ������
      select a.val_text
        into l_inn
        from wcs_answers a
       where a.bid_id = p_bid_id
         and a.question_id = 'CL_13';

      bars_audit.trace(g_pack_name || l_proc_name || 'Process. l_inn =%s',
                       l_inn);

      -- ���� ������ �� ���
      begin
        select cl.id
          into l_ccinter_id
          from db2isa.clients@db2 cl
         where cl.cl_13 = l_inn
           and rownum = 1
         order by cl.manual_creation_date desc;

        bars_audit.trace(g_pack_name || l_proc_name ||
                         'Process. l_ccinter_id =%s',
                         to_char(l_ccinter_id));
      exception
        when no_data_found then
          -- ��� �� ������
          bars_audit.trace(g_pack_name || l_proc_name ||
                           'Finish. INN not found');
          return;
      end;

      -- ��������� ��������
      for c in (select cl.CL_144,
                       cl.CL_145,
                       cl.CL_5,
                       cl.CL_6,
                       cl.CL_7,
                       cl.CL_13,
                       cl.CL_12,
                       cl.CL_18,
                       cl.CL_19,
                       cl.CL_20,
                       cl.CL_21,
                       cl.CL_22,
                       cl.CL_23,
                       cl.CL_24,
                       cl.CL_25,
                       cl.CL_26,
                       cl.CL_27,
                       cl.CL_28,
                       cl.CL_29,
                       cl.CL_30,
                       cl.CL_32,
                       cl.CL_34,
                       cl.CL_35,
                       cl.CL_36,
                       cl.CL_37,
                       cl.CL_38,
                       cl.CL_39,
                       cl.CL_40,
                       cl.CL_41,
                       cl.CL_44,
                       cl.CL_46,
                       cl.CL_55,
                       cl.CL_56,
                       cl.CL_68,
                       cl.CL_69,
                       cl.CL_70,
                       cl.CL_14,
                       cl.PROFIT_NOT_CONFIRMED as CL_83,
                       cl.CL_101,
                       cl.CL_11,
                       cl.EXIST_CRDT_SUM as CL_104,
                       cl.EXIST_CRDT_LEFT as CL_105,
                       cl.EXIST_CRDT_MONTH_PAY as CL_106,
                       cl.CL_132
                  from db2isa.clients@db2 cl
                 where cl.id = l_ccinter_id) loop

  --       !!! �� ������� ������������ � ����� ��_���������� ��� ��������:
  --      cl.CL_31, cl.CL_125, cl.CL_102, cl.CL_103, cl.CL_131,

        bars_audit.trace(g_pack_name || l_proc_name ||
                         'Process. Answer resived for inn=%s : CL_144=' ||
                         c.CL_144 || ' CL_145=' || c.CL_145 || ' CL_5=' ||
                         c.CL_5 || ' CL_6=' || c.CL_6 || ' CL_7=' || c.CL_7 ||
                         ' CL_13=' || c.CL_13 || ' CL_12=' || c.CL_12 ||
                         ' CL_18=' || c.CL_18 || ' CL_19=' || c.CL_19 ||
                         ' CL_20=' || c.CL_20 || ' CL_21=' || c.CL_21 ||
                         ' CL_22=' || c.CL_22 || ' CL_23=' || c.CL_23 ||
                         ' CL_24=' || c.CL_24 || ' CL_25=' || c.CL_25 ||
                         ' CL_26=' || c.CL_26 || ' CL_27=' || c.CL_27 ||
                         ' CL_28=' || c.CL_28 || ' CL_29=' || c.CL_29 ||
                         ' CL_30=' || c.CL_30 || ' CL_32=' || c.CL_32 ||
                         ' CL_34=' || c.CL_34 || ' CL_35=' || c.CL_35 ||
                         ' CL_36=' || c.CL_36 || ' CL_37=' || c.CL_37 ||
                         ' CL_38=' || c.CL_38 || ' CL_39=' || c.CL_39 ||
                         ' CL_40=' || c.CL_40 || ' CL_41=' || c.CL_41 ||
                         ' CL_44=' || c.CL_44 || ' CL_46=' || c.CL_46 ||
                         ' CL_55=' || c.CL_55 || ' CL_56=' || c.CL_56 ||
                         ' CL_68=' || c.CL_68 || ' CL_69=' || c.CL_69 ||
                         ' CL_70=' || c.CL_70 || ' CL_14=' || c.CL_14 ||
                         ' CL_83=' || c.CL_83 || ' CL_101=' || c.CL_101 ||
                         ' CL_11=' || c.CL_11 || ' CL_104=' || c.CL_104 ||
                         ' CL_105=' || c.CL_105 || ' CL_106=' || c.CL_106 ||
                         ' CL_132=' || c.CL_132,
                         l_inn);

        wcs_utl.set_answ(p_bid_id, 'CL_144', c.CL_144);
        wcs_utl.set_answ(p_bid_id, 'CL_145', c.CL_145);
        wcs_utl.set_answ(p_bid_id, 'CL_5', c.CL_5);
        wcs_utl.set_answ(p_bid_id, 'CL_6', c.CL_6);
        wcs_utl.set_answ(p_bid_id, 'CL_7', c.CL_7);
        wcs_utl.set_answ(p_bid_id, 'CL_13', c.CL_13);
        wcs_utl.set_answ(p_bid_id, 'CL_12', c.CL_12);
        wcs_utl.set_answ(p_bid_id, 'CL_18', c.CL_18);
        wcs_utl.set_answ(p_bid_id, 'CL_19', c.CL_19);
        wcs_utl.set_answ(p_bid_id, 'CL_20', c.CL_20);
        wcs_utl.set_answ(p_bid_id, 'CL_21', c.CL_21);
        wcs_utl.set_answ(p_bid_id, 'CL_22', c.CL_22);
        wcs_utl.set_answ(p_bid_id, 'CL_23', c.CL_23);
        wcs_utl.set_answ(p_bid_id, 'CL_24', c.CL_24);
        wcs_utl.set_answ(p_bid_id, 'CL_25', c.CL_25);
        wcs_utl.set_answ(p_bid_id, 'CL_26', c.CL_26);
        wcs_utl.set_answ(p_bid_id, 'CL_27', c.CL_27);
        wcs_utl.set_answ(p_bid_id, 'CL_28', c.CL_28);
        wcs_utl.set_answ(p_bid_id, 'CL_29', c.CL_29);
        wcs_utl.set_answ(p_bid_id, 'CL_30', c.CL_30);
        wcs_utl.set_answ(p_bid_id, 'CL_32', c.CL_32);
        wcs_utl.set_answ(p_bid_id, 'CL_34', c.CL_34);
        wcs_utl.set_answ(p_bid_id, 'CL_35', c.CL_35);
        wcs_utl.set_answ(p_bid_id, 'CL_36', c.CL_36);
        wcs_utl.set_answ(p_bid_id, 'CL_37', c.CL_37);
        wcs_utl.set_answ(p_bid_id, 'CL_38', c.CL_38);
        wcs_utl.set_answ(p_bid_id, 'CL_39', c.CL_39);
        wcs_utl.set_answ(p_bid_id, 'CL_40', c.CL_40);
        wcs_utl.set_answ(p_bid_id, 'CL_41', c.CL_41);
        wcs_utl.set_answ(p_bid_id, 'CL_44', c.CL_44);
        wcs_utl.set_answ(p_bid_id, 'CL_46', c.CL_46);
        wcs_utl.set_answ(p_bid_id, 'CL_55', c.CL_55);
        wcs_utl.set_answ(p_bid_id, 'CL_56', c.CL_56);
        wcs_utl.set_answ(p_bid_id, 'CL_68', c.CL_68);
        wcs_utl.set_answ(p_bid_id, 'CL_69', c.CL_69);
        wcs_utl.set_answ(p_bid_id, 'CL_70', c.CL_70);
        wcs_utl.set_answ(p_bid_id, 'CL_14', c.CL_14);
        wcs_utl.set_answ(p_bid_id, 'CL_83', c.CL_83);
        wcs_utl.set_answ(p_bid_id, 'CL_101', c.CL_101);
        wcs_utl.set_answ(p_bid_id, 'CL_11', c.CL_11);
        wcs_utl.set_answ(p_bid_id, 'CL_104', c.CL_104);
        wcs_utl.set_answ(p_bid_id, 'CL_105', c.CL_105);
        wcs_utl.set_answ(p_bid_id, 'CL_106', c.CL_106);
        wcs_utl.set_answ(p_bid_id, 'CL_132', c.CL_132);
      end loop;

      bars_audit.trace(g_pack_name || l_proc_name || 'Finish');
    end bid_prefill_from_ccinter;
  /*
    -- ��������� �������� ������ ��������, �� ������ ������
    function get_ccid(p_bid_id number -- ������������� ������
                      ) return varchar2 is
      l_cc_id     varchar2(20);
      l_sign_date date;

      l_k1 char(1) := '0';
      l_k2 char(1);
      l_k3 char(1);

      l_bday date;

      l_yyyy int;
      l_mm   int;
      l_dd   int;

      l_proc_name varchar2(100) := 'get_ccid. ';
    begin
      bars_audit.trace(g_pack_name || l_proc_name ||
                       'Start. Params: p_bid_id=%s',
                       to_char(p_bid_id));

      -- ��������� ������
      select nvl(b.sign_date, bankdate)
        into l_sign_date
        from wcs_bids b
       where b.id = p_bid_id;

      bars_audit.trace(g_pack_name || l_proc_name ||
                       'Process. l_sign_date =%s',
                       l_sign_date);

      -- ���� �������� �������
      l_bday := to_date(wcs_utl.get_answ(p_bid_id, 'CL_12'));
      bars_audit.trace(g_pack_name || l_proc_name || 'Process. l_bday =%s',
                       l_bday);

      l_dd   := to_number(to_char(l_bday, 'DD'));
      l_mm   := to_number(to_char(l_bday, 'MM'));
      l_yyyy := to_number(to_char(l_bday, 'YYYY'));
      l_k2   := to_char(mod((l_dd + l_mm + l_yyyy), 10));
      bars_audit.trace(g_pack_name || l_proc_name ||
                       'Process. l_dd=%s, l_mm=%s, l_yyyy=%s, l_k2=%s',
                       to_char(l_dd),
                       to_char(l_mm),
                       to_char(l_yyyy),
                       l_k2);

      l_dd   := to_number(to_char(l_sign_date, 'DD'));
      l_mm   := to_number(to_char(l_sign_date, 'MM'));
      l_yyyy := to_number(to_char(l_sign_date, 'YYYY'));
      l_k3   := to_char(mod((l_dd + l_mm + l_yyyy), 10));
      bars_audit.trace(g_pack_name || l_proc_name ||
                       'Process. l_dd=%s, l_mm=%s, l_yyyy=%s, l_k3=%s',
                       to_char(l_dd),
                       to_char(l_mm),
                       to_char(l_yyyy),
                       l_k3);

      l_cc_id := nvl(l_k1, '0') || nvl(l_k2, '0') || nvl(l_k3, '0') ||
                 p_bid_id;
      bars_audit.trace(g_pack_name || l_proc_name || 'Process. l_cc_id=%s',
                       l_cc_id);

      l_cc_id := GET_KR_CC(l_cc_id);

      bars_audit.trace(g_pack_name || l_proc_name || 'Finish. l_cc_id=%s',
                       l_cc_id);
      return l_cc_id;

    end get_ccid;

    -- ��������� ���� ��������, �� ������ ������
    function get_ccdat1(p_bid_id number -- ������������� ������
                      ) return date is
      l_sign_date date;

      l_proc_name varchar2(100) := 'get_ccdat1. ';
    begin
      bars_audit.trace(g_pack_name || l_proc_name ||
                       'Start. Params: p_bid_id=%s',
                       to_char(p_bid_id));

      -- ��������� ������
      select nvl(b.sign_date, bankdate)
        into l_sign_date
        from wcs_bids b
       where b.id = p_bid_id;

      bars_audit.trace(g_pack_name || l_proc_name || 'Finish. l_sign_date=%s',
                       to_char(l_sign_date));
      return l_sign_date;
    end get_ccdat1;

    -- ����������� ��������� ������
    procedure bids_set_aside(p_bdate date -- ������� ���������� ����
                             ) is

      l_proc_name varchar2(100) := 'bids_set_aside. ';
    begin
      bars_audit.trace(g_pack_name || l_proc_name ||
                       'Start. Params: p_bdate=%s',
                       to_char(p_bdate));

      -- �������� ������ �� ������� ���� ��������� ���������, � ������ ������� �������
      for c in (select *
                  from wcs_bids b
                 where b.sign_date < trunc(p_bdate)
                   and not exists
                 (select *
                          from wcs_bid_states bs
                         where bs.bid_id = b.id
                           and bs.state_id in
                               ('SYS_ERR', 'NEW_DENY', 'NEW_DONE'))) loop
        bars_audit.trace(g_pack_name || l_proc_name || 'Process. c.id =%s',
                         c.id);

        -- ������ ���� �������
        wcs_pack.bid_signdate_set(c.id, null);

        -- ������ ��������� ������ ����������
        wcs_pack.bid_state_set_immediate(c.id, 'NEW_DOCUMENTS', '����� ���������. ������ ������ ������������ � ����� ���������� ����');
        -- ������ ��������� ������������ (��� ������� ��������� ���������� � ������)
        wcs_pack.bid_state_set(c.id, 'NEW_SECURITY', '������ ������ ������������ � ����� ���������� ����');
        -- ������ ��������� ��������� ������
        wcs_pack.bid_state_set(c.id, 'ASIDE', '������ ������ ������������ � ����� ���������� ����');
      end loop;

      bars_audit.trace(g_pack_name || l_proc_name || 'Finish.');
    end bids_set_aside;

    -- ��� ��������� ������
    function get_manager_fio(p_bid_id number -- ������������� ������
                             ) return varchar2 is
      l_mgr_fio varchar2(255);

      l_proc_name varchar2(100) := 'get_manager_fio. ';
    begin
      bars_audit.trace(g_pack_name || l_proc_name ||
                       'Start. Params: p_bid_id=%s',
                       to_char(p_bid_id));

      -- ����� ��� ���������
      begin
        select s.fio
          into l_mgr_fio
          from wcs_bid_states bs, staff s
         where bs.bid_id = p_bid_id
           and bs.state_id = 'MGR_BELONG'
           and bs.checkout_user_id = s.id;
      exception
        when no_data_found then
          l_mgr_fio := null;
      end;

      bars_audit.trace(g_pack_name || l_proc_name || 'Finish. l_mgr_fio=%s',
                       l_mgr_fio);
      return l_mgr_fio;

    end get_manager_fio;

    -- �������� �������� ��� �����
    function f_get_all_add_servises(p_bid_id number -- ������������� ������
                                    ) return varchar2 is
      l_sum  number;
      l_term number;

      l_res       varchar2(4000);
      l_proc_name varchar2(100) := 'f_get_all_add_servises. ';
    begin
      bars_audit.trace(g_pack_name || l_proc_name ||
                       'Start. Params: p_bid_id=%s',
                       to_char(p_bid_id));

      -- ���������� ����� ���� �������
      l_sum  := to_number(wcs_utl.get_answ(p_bid_id, 'CL_144'));
      l_term := to_number(wcs_utl.get_answ(p_bid_id, 'CL_145'));

      bars_audit.trace(g_pack_name || l_proc_name ||
                       'Process. l_sum=%s, l_term=%s',
                       to_char(l_sum),
                       to_char(l_term));

      for c in (select '"' || ads.name || '" ' ||
                       trim(to_char(wcs_register.get_addservice_summ(ads.id,
                                                                     l_sum,
                                                                     l_term),
                                    '9999999999999999990.00')) || '���' as ads_text
                  from wcs_additional_services ads
                 where 1 = to_number(wcs_utl.get_answ(p_bid_id, ads.result_qid))) loop
        l_res := l_res || ', ' || c.ads_text;
      end loop;
      if (l_res is not null) then
        l_res := substr(l_res, 3);
      end if;

      bars_audit.trace(g_pack_name || l_proc_name || 'Finish. l_res=%s', l_res);
      return l_res;
    end f_get_all_add_servises;

    -- �������� �������� ������
    procedure clear_hanging_bids(p_bdate date -- ������� ���������� ����
                                 ) is

      l_proc_name varchar2(100) := 'clear_hanging_bids. ';
    begin
      bars_audit.trace(g_pack_name || l_proc_name || 'Start.');

      -- ����� ��� ������ � ������� �� �������� ��������� �����������
      -- � ������� ������ 2-� �����
      -- �������������� ������ 40 ���� �� �������
      for c in (select b.*
                  from wcs_bids b, wcs_bid_states bs
                 where not exists (select *
                          from wcs_bid_states_history bsh
                         where bsh.bid_id = b.id
                           and bsh.state_id = 'NEW_AUTH'
                           and bsh.change_action = 'DELETE')
                   and not exists (select *
                          from wcs_bid_states bs0
                         where bs0.bid_id = b.id
                           and bs0.state_id = 'PRELIM_DEC'
                           and bs0.checkout_dat > sysdate - 40)
                   and b.id = bs.bid_id
                   and bs.state_id = 'MGR_BELONG'
                   and bs.checkout_dat < sysdate - 1 / 12) loop
        wcs_pack.bid_del(c.id);
        logger.info('wcs_utl.clear_hanging_bids ���������� �������������� �������� ������ �' || to_char(c.id));
      end loop;

      bars_audit.trace(g_pack_name || l_proc_name || 'Finish.');
    end clear_hanging_bids;

    -- ������ ������������ �������� � cc_docs
    procedure save_printed_doc(p_doc_scheme_id in varchar2, -- ������������� ������� ��������
                               p_bid_id        in number, -- ������������� ������
                               p_doc_text      clob -- ����� ������������ ��������
                               ) is

      l_proc_name varchar2(100) := 'save_printed_doc. ';
    begin
      bars_audit.trace(g_pack_name || l_proc_name || 'Start.');

      update cc_docs d
         set d.adds    = 0,
             d.version = sysdate,
             d.state   = 1,
             d.branch  = sys_context('bars_context', 'user_branch'),
             d.text    = p_doc_text,
             d.comm    = '������ ���������� ��� ��������� ��������� ������ �' ||
                         to_char(p_bid_id),
             d.doneby  = user_id
       where d.id = p_doc_scheme_id
         and d.nd = p_bid_id
         and d.adds = 0;

      if (sql%rowcount = 0) then
        insert into cc_docs
          (id, nd, adds, text, comm, doneby)
        values
          (p_doc_scheme_id,
           p_bid_id,
           0,
           p_doc_text,
           '������ ���������� ��� ��������� ��������� ������ �' || to_char(p_bid_id),
           user_id);
      end if;

      bars_audit.trace(g_pack_name || l_proc_name || 'Finish.');
    end save_printed_doc;
  */

  -- ���� �� � ������ �������� ��������� (0 - ���, 1 - ��)
  function check_bid_state_hist(p_bid_id   number, -- ������������� ������
                                p_state_id varchar2 -- ������������� ���������
                                ) return number is
    l_res       number := 0;
    l_proc_name varchar2(100) := 'check_bid_state_hist. ';
  begin
    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Start. Params: p_bid_id=%s, p_state_id=%s',
                     to_char(p_bid_id),
                     p_state_id);

    select count(*)
      into l_res
      from wcs_bid_states_history bsh
     where bsh.bid_id = p_bid_id
       and bsh.state_id = p_state_id
       and bsh.change_action = 'DELETE';

    bars_audit.trace(g_pack_name || l_proc_name || 'Finish. l_res=%s',
                     l_res);

    return l_res;
  end check_bid_state_hist;

  -- ����� �� ������ ���������
  function has_bid_state(p_bid_id   wcs_bid_states.bid_id%type, -- ������������� ������
                         p_state_id wcs_bid_states.state_id%type -- ������������ ���������
                         ) return number is
    l_res number(1);
  begin
    select count(*)
      into l_res
      from wcs_bid_states bs
     where bs.bid_id = p_bid_id
       and bs.state_id = p_state_id;
    return l_res;
  end has_bid_state;

  -- ����� �� ������ ���������
  function had_bid_state(p_bid_id     wcs_bid_states_history.bid_id%type, -- ������������� ������
                         p_state_id   wcs_bid_states_history.state_id%type, -- ������������ ���������
                         p_checkouted wcs_bid_states_history.checkouted%type default null, -- �������������� �� ���������
                         p_cngaction  wcs_bid_states_history.change_action%type default null -- ��������
                         ) return number is
    l_res number(1);
  begin
    select decode(count(*), 0, 0, 1)
      into l_res
      from wcs_bid_states_history bsh
     where bsh.bid_id = p_bid_id
       and bsh.state_id = p_state_id
       and bsh.checkouted = nvl(p_checkouted, bsh.checkouted)
       and bsh.change_action = nvl(p_cngaction, bsh.change_action);
    return l_res;
  end had_bid_state;

  -- ������ ������� ��������� ������ (������������ ����� �������)
  function get_bid_states(p_bid_id number -- ������������� ������
                          ) return varchar2 is
    l_res varchar2(1000);
  begin
    for cur in (select *
                  from wcs_states s
                 where s.is_disp = 1
                   and s.id in (select state_id
                                  from wcs_bid_states bs
                                 where bs.bid_id = p_bid_id)) loop
      l_res := l_res || ', ' || cur.name;
    end loop;

    return substr(l_res, 3);
  end get_bid_states;

  -- ������ ������� ����������� ������ (������������ ����� �������)
  function get_bid_garantees(p_bid_id number -- ������������� ������
                             ) return varchar2 is
    l_res varchar2(1000);
  begin
    for cur in (select bg.bid_id,
                       bg.garantee_id,
                       bg.garantee_name,
                       count(*) as cnt
                  from v_wcs_bid_garantees bg
                 where bg.bid_id = p_bid_id
                 group by bg.bid_id, bg.garantee_id, bg.garantee_name) loop
      l_res := l_res || ', ' || cur.garantee_name || '(' || cur.cnt || ')';
    end loop;

    return substr(l_res, 3);
  end get_bid_garantees;

  -- ������ ���������� ����������� ����������� (������������ ����� �������)
  function get_sbp_garantees(p_subproduct_id wcs_subproduct_garantees.subproduct_id%type -- ������������� �����������
                             ) return varchar2 is
    l_res varchar2(1000);
  begin
    for cur in (select *
                  from v_wcs_subproduct_garantees sg
                 where sg.subproduct_id = p_subproduct_id) loop
      l_res := l_res || ', ' || cur.garantee_name;
    end loop;

    return substr(l_res, 3);
  end get_sbp_garantees;

  -- ������ ����������� ���������� (������������ ����� �������)
  function get_sbp_docs(p_subproduct_id wcs_subproduct_templates.subproduct_id%type -- ������������� �����������
                        ) return varchar2 is
    l_res varchar2(4000);
  begin
    for cur in (select q.*
                  from wcs_subproduct_scancopies ss,
                       wcs_scancopy_questions    sq,
                       wcs_questions             q
                 where ss.subproduct_id = p_subproduct_id
                   and ss.scopy_id = sq.scopy_id
                   and sq.type_id = 'SCAN'
                   and sq.question_id = q.id) loop
      l_res := l_res || ', ' || cur.name;
    end loop;

    return substr(l_res, 3);
  end get_sbp_docs;

  -- ��������� ���������� �������
  procedure get_quest_params(p_bid_id             wcs_answers.bid_id%type, -- ������������� ������
                             p_question_id        wcs_answers.question_id%type, -- ������������� �������
                             p_text_leng_min      out number, -- ����������� ����� ���������� ����
                             p_text_leng_max      out number, -- ������������ ����� ���������� ����
                             p_text_val_default   out varchar2, -- ��������� �������� ���������� ����
                             p_text_width         out number, -- ������ ���������� ����
                             p_text_rows          out number, -- ���-�� ������ ���������� ����
                             p_nmbdec_val_min     out number, -- ����������� �������� �����
                             p_nmbdec_val_max     out number, -- ������������ �������� �����
                             p_nmbdec_val_default out number, -- ��������� �������� �����
                             p_dat_val_min        out date, -- ����������� �������� ����
                             p_dat_val_max        out date, -- ������������ �������� ����
                             p_dat_val_default    out date, -- ��������� �������� ����
                             p_list_sid_default   out number, -- ��������� �������� �������� �� ������
                             p_refer_sid_default  out varchar2, -- ��������� �������� �������� �� �����������
                             p_tab_id             out v_wcs_question_params.tab_id%type, -- ������������� ������� �����������
                             p_key_field          out v_wcs_question_params.key_field%type, -- �������� ����
                             p_semantic_field     out v_wcs_question_params.semantic_field%type, -- ���� ���������
                             p_show_fields        out v_wcs_question_params.show_fields%type, -- ���� ��� ����������� (������������ ����� �������)
                             p_where_clause       out v_wcs_question_params.where_clause%type, -- ������� ������ (������� ����� where)
                             p_bool_val_default   out number, -- ��������� �������� �������� �������
                             p_ws_id              wcs_answers.ws_id%type default g_cur_ws_id, -- ������������� �������� ������������
                             p_ws_number          wcs_answers.ws_number%type default g_cur_ws_num -- ����� �������� ������������
                             ) is
    l_q_row  wcs_questions%rowtype;
    l_qp_row v_wcs_question_params%rowtype;
  begin
    -- ������
    select * into l_q_row from wcs_questions q where q.id = p_question_id;

    -- �������������� ���������
    begin
      select *
        into l_qp_row
        from v_wcs_question_params qp
       where qp.id = p_question_id;
    exception
      when no_data_found then
        return;
    end;

    -- ������ ���������� � ����������� �� ����
    case (l_q_row.type_id)
      when 'TEXT' then
        p_text_leng_min    := to_number(wcs_utl.calc_sql_line(p_bid_id,
                                                              l_qp_row.text_leng_min,
                                                              p_ws_id,
                                                              p_ws_number));
        p_text_leng_max    := to_number(wcs_utl.calc_sql_line(p_bid_id,
                                                              l_qp_row.text_leng_max,
                                                              p_ws_id,
                                                              p_ws_number));
        p_text_val_default := wcs_utl.calc_sql_line(p_bid_id,
                                                    l_qp_row.text_val_default,
                                                    p_ws_id,
                                                    p_ws_number);
        p_text_width       := l_qp_row.text_width;
        p_text_rows        := l_qp_row.text_rows;
      when 'NUMB' then
        p_nmbdec_val_min     := to_number(wcs_utl.calc_sql_line(p_bid_id,
                                                                l_qp_row.nmbdec_val_min,
                                                                p_ws_id,
                                                                p_ws_number));
        p_nmbdec_val_max     := to_number(wcs_utl.calc_sql_line(p_bid_id,
                                                                l_qp_row.nmbdec_val_max,
                                                                p_ws_id,
                                                                p_ws_number));
        p_nmbdec_val_default := to_number(wcs_utl.calc_sql_line(p_bid_id,
                                                                l_qp_row.nmbdec_val_default,
                                                                p_ws_id,
                                                                p_ws_number));
      when 'DECIMAL' then

        p_nmbdec_val_min     := to_number(wcs_utl.calc_sql_line(p_bid_id,
                                                                l_qp_row.nmbdec_val_min,
                                                                p_ws_id,
                                                                p_ws_number));
        p_nmbdec_val_max     := to_number(wcs_utl.calc_sql_line(p_bid_id,
                                                                l_qp_row.nmbdec_val_max,
                                                                p_ws_id,
                                                                p_ws_number));
        p_nmbdec_val_default := to_number(wcs_utl.calc_sql_line(p_bid_id,
                                                                l_qp_row.nmbdec_val_default,
                                                                p_ws_id,
                                                                p_ws_number));
      when 'DATE' then
        p_dat_val_min     := to_date(wcs_utl.calc_sql_line(p_bid_id,
                                                           l_qp_row.dat_val_min,
                                                           p_ws_id,
                                                           p_ws_number));
        p_dat_val_max     := to_date(wcs_utl.calc_sql_line(p_bid_id,
                                                           l_qp_row.dat_val_max,
                                                           p_ws_id,
                                                           p_ws_number));
        p_dat_val_default := to_date(wcs_utl.calc_sql_line(p_bid_id,
                                                           l_qp_row.dat_val_default,
                                                           p_ws_id,
                                                           p_ws_number));
      when 'LIST' then
        p_list_sid_default := to_number(wcs_utl.calc_sql_line(p_bid_id,
                                                              l_qp_row.list_sid_default,
                                                              p_ws_id,
                                                              p_ws_number));
        p_text_width       := l_qp_row.text_width;
      when 'REFER' then
        p_refer_sid_default := wcs_utl.calc_sql_line(p_bid_id,
                                                     l_qp_row.refer_sid_default,
                                                     p_ws_id,
                                                     p_ws_number);
        p_tab_id            := l_qp_row.tab_id;
        p_key_field         := l_qp_row.key_field;
        p_semantic_field    := l_qp_row.semantic_field;
        p_show_fields       := l_qp_row.show_fields;
        p_where_clause      := l_qp_row.where_clause;
      when 'BOOL' then
        p_bool_val_default := to_number(wcs_utl.calc_sql_line(p_bid_id,
                                                              l_qp_row.bool_val_default,
                                                              p_ws_id,
                                                              p_ws_number));
      else
        return;
    end case;
  end get_quest_params;

  -- ����� �� ������ ������ ��������� ������� � ������ ����� (������� �� ������)
  function has_sur_grp_quest_rel(p_survey_id   wcs_survey_group_questions.survey_id%type, -- ������������� ������
                                 p_sgroup_id   wcs_survey_group_questions.sgroup_id%type, -- ������������� �����
                                 p_question_id wcs_survey_group_questions.question_id%type -- ������������� �������
                                 ) return number is
    l_search_pattern varchar2(100) := ':#' || p_question_id || '[^#0-9_]*#';--':#' || p_question_id || '[^#]*#';
    l_q_row          wcs_questions%rowtype;
    l_qp_row         v_wcs_question_params%rowtype;
  begin
    -- ����� ��� ������� ����� ������ ��������
    for cur in (select *
                  from wcs_survey_group_questions sgq
                 where sgq.survey_id = p_survey_id
                   and sgq.sgroup_id = p_sgroup_id
                   and sgq.question_id != p_question_id) loop
      -- ���� ��������c�� � ���������� ������� ������
      if (regexp_like(cur.dnshow_if, l_search_pattern) or
         regexp_like(cur.is_required, l_search_pattern) or
         (cur.is_checkable = 1 and
         regexp_like(cur.check_proc, l_search_pattern))) then
        --bars_audit.info('WCSINFO question_id = '||cur.question_id||' table = wcs_survey_group_questions');
        return 1;
      end if;
      -- ���� ��������c�� � ������� ���������� �������
      select *
        into l_q_row
        from wcs_questions q
       where q.id = cur.question_id;
      if (l_q_row.is_calcable = 1 and
         regexp_like(l_q_row.calc_proc, l_search_pattern)) then
         --bars_audit.info('WCSINFO question_id = '||cur.question_id||' table = wcs_questions');
        return 1;
      end if;
      -- ���� ��������c�� � �������������� ���������� �������
      begin
        select *
          into l_qp_row
          from v_wcs_question_params qp
         where qp.id = cur.question_id;
        if (regexp_like(l_qp_row.text_leng_min, l_search_pattern) or
           regexp_like(l_qp_row.text_leng_max, l_search_pattern) or
           regexp_like(l_qp_row.text_val_default, l_search_pattern) or
           regexp_like(l_qp_row.nmbdec_val_min, l_search_pattern) or
           regexp_like(l_qp_row.nmbdec_val_max, l_search_pattern) or
           regexp_like(l_qp_row.nmbdec_val_default, l_search_pattern) or
           regexp_like(l_qp_row.dat_val_min, l_search_pattern) or
           regexp_like(l_qp_row.dat_val_max, l_search_pattern) or
           regexp_like(l_qp_row.dat_val_default, l_search_pattern) or
           regexp_like(l_qp_row.list_sid_default, l_search_pattern) or
           regexp_like(l_qp_row.where_clause, l_search_pattern) or
           regexp_like(l_qp_row.refer_sid_default, l_search_pattern)) then
          --bars_audit.info('WCSINFO question_id = '||cur.question_id||' table = v_wcs_question_params');
          return 1;
        end if;
      exception
        when no_data_found then
          null;
      end;
    end loop;

    return 0;
  end has_sur_grp_quest_rel;

  -- ����� �� ������ ������ ��������� ������� � ������ ����� (������� �� ���. �������������)
  function has_related_survey(p_survey_id   wcs_survey_group_questions.survey_id%type, -- ������������� ������
                              p_sgroup_id   wcs_survey_group_questions.sgroup_id%type, -- ������������� �����
                              p_question_id wcs_survey_group_questions.question_id%type -- ������������� �������
                              ) return number is
    l_res number;
  begin
    execute immediate 'select count(*)
                        from mv_wcs_sur_grp_quest_relation sgqr
                       where sgqr.survey_id = :1
                         and sgqr.sgroup_id = :2
                         and sgqr.question_id = :3'
      into l_res
      using p_survey_id, p_sgroup_id, p_question_id;

    return l_res;
  end has_related_survey;

  -- ����� �� ������ ������ ������� ��������� ������� � �����������
  function has_related_creditdata(p_subproduct_id wcs_subproduct_creditdata.subproduct_id%type, -- ������������� �����������
                                  p_crddata_id    wcs_subproduct_creditdata.crddata_id%type -- ������������� �������
                                  ) return number is
    l_search_pattern varchar2(100) := ':#' || p_crddata_id ||
                                      '[^#]*%T-CD[^#]*#';
    l_q_row          wcs_questions%rowtype;
    l_qp_row         v_wcs_question_params%rowtype;
  begin
    -- ����� ��� ������� ������ ������� ������ ��������
    for cur in (select *
                  from wcs_subproduct_creditdata scd
                 where scd.subproduct_id = p_subproduct_id
                   and scd.crddata_id != p_crddata_id) loop
      -- ���� ��������c�� � ������� ���������� �������
      select *
        into l_q_row
        from wcs_questions q
       where q.id = cur.question_id;
      if (l_q_row.is_calcable = 1 and
         regexp_like(l_q_row.calc_proc, l_search_pattern)) then
        return 1;
      end if;
      -- ���� ��������c�� � �������������� ���������� �������
      begin
        select *
          into l_qp_row
          from v_wcs_question_params qp
         where qp.id = cur.question_id;
        if (regexp_like(l_qp_row.text_leng_min, l_search_pattern) or
           regexp_like(l_qp_row.text_leng_max, l_search_pattern) or
           regexp_like(l_qp_row.text_val_default, l_search_pattern) or
           regexp_like(l_qp_row.nmbdec_val_min, l_search_pattern) or
           regexp_like(l_qp_row.nmbdec_val_max, l_search_pattern) or
           regexp_like(l_qp_row.nmbdec_val_default, l_search_pattern) or
           regexp_like(l_qp_row.dat_val_min, l_search_pattern) or
           regexp_like(l_qp_row.dat_val_max, l_search_pattern) or
           regexp_like(l_qp_row.dat_val_default, l_search_pattern) or
           regexp_like(l_qp_row.list_sid_default, l_search_pattern) or
           regexp_like(l_qp_row.where_clause, l_search_pattern) or
           regexp_like(l_qp_row.refer_sid_default, l_search_pattern)) then
          return 1;
        end if;
      exception
        when no_data_found then
          null;
      end;
    end loop;

    return 0;
  end has_related_creditdata;

  -- �������� �������������� ������� ����� ������
  procedure set_null_2_hided_quests(p_bid_id    wcs_bids.id%type, -- ������������� ������
                                    p_survey_id wcs_survey_group_questions.survey_id%type, -- ������������� ������
                                    p_sgroup_id wcs_survey_group_questions.sgroup_id%type, -- ������������� �����
                                    p_ws_id     wcs_answers.ws_id%type default g_cur_ws_id, -- ������������� �������� ������������
                                    p_ws_number wcs_answers.ws_number%type default g_cur_ws_num -- ����� �������� ������������
                                    ) is
  begin
    for cur in (select sgq.question_id
                  from wcs_survey_groups sg, wcs_survey_group_questions sgq
                 where sg.survey_id = p_survey_id
                   and sg.id = p_sgroup_id
                   and sgq.survey_id = sg.survey_id
                   and sgq.sgroup_id = sg.id
                   and ((sg.dnshow_if is not null and
                       1 = wcs_utl.calc_sql_bool(p_bid_id,
                                                   sg.dnshow_if,
                                                   p_ws_id,
                                                   p_ws_number)) or
                       (sgq.dnshow_if is not null and
                       1 = wcs_utl.calc_sql_bool(p_bid_id,
                                                   sgq.dnshow_if,
                                                   p_ws_id,
                                                   p_ws_number)))) loop
      wcs_pack.answ_del(p_bid_id, cur.question_id, p_ws_id, p_ws_number);
    end loop;
  end set_null_2_hided_quests;

  -- ������� ��������� �� ������� ��� ���� ����/���� � ������ �� � ������� �������
  function get_interest(p_in_bal        number,
                        p_interest_rate number,
                        p_date_start    date,
                        p_date_end      date) return number is
    l_res            number := 0;
    l_actual_ny      date := trunc(p_date_end, 'YYYY'); -- ����. 01/01/2012
    l_days_in_year   number := add_months(trunc(p_date_start, 'YYYY'), 12) -
                               trunc(p_date_start, 'YYYY');
    l_days_in_period number := p_date_end - p_date_start + 1;
  begin
    if (p_date_start < l_actual_ny and l_actual_ny <= p_date_end) then
      l_res := get_interest(p_in_bal,
                            p_interest_rate,
                            p_date_start,
                            l_actual_ny - 1) +
               get_interest(p_in_bal,
                            p_interest_rate,
                            l_actual_ny,
                            p_date_end);
    else
      l_res := round(p_in_bal * p_interest_rate * l_days_in_period / 100 /
                     l_days_in_year,
                     2);
    end if;

    return l_res;
  end get_interest;

  -- ��������� ���������� �������� ��� (������ ���������, ���� ����/����)
  function get_gpk_ep(p_pmt_id        number, -- ������ ����� �������
                      p_build_date    date, -- ���� ������ ����������
                      p_credit_sum    number, -- ����� �������
                      p_credit_term   number, -- ���� �������
                      p_interest_rate number -- ������� % ������
                      ) return t_gpk_table
    pipelined is
    l_gpk_rec      t_gpk_rec;
    l_gpk_rec_prev t_gpk_rec;

    -- ��������� ���� ���������� ��������� �� �������
    -- ��������� ���� ����������� ������
    function get_ir_date(p_date date -- ������� ����
                         ) return date is
    begin
      return trunc(p_date, 'mm') - 1;
    end get_ir_date;
  begin
    l_gpk_rec.build_date := trunc(p_build_date);

    l_gpk_rec.pmt_id         := p_pmt_id;
    l_gpk_rec.pmt_date       := add_months(l_gpk_rec.build_date, 1);
    l_gpk_rec.pmt_in_bal     := p_credit_sum;
    l_gpk_rec.pmt_body       := round(p_credit_sum / p_credit_term, 2);
    l_gpk_rec.pmt_body_total := l_gpk_rec.pmt_body;

    l_gpk_rec.pmt_interest := get_interest(l_gpk_rec.pmt_in_bal,
                                           p_interest_rate,
                                           l_gpk_rec.build_date,
                                           get_ir_date(l_gpk_rec.pmt_date));

    l_gpk_rec.pmt_total   := l_gpk_rec.pmt_body + l_gpk_rec.pmt_interest;
    l_gpk_rec.pmt_out_bal := l_gpk_rec.pmt_in_bal - l_gpk_rec.pmt_body;
    pipe row(l_gpk_rec);
    l_gpk_rec_prev := l_gpk_rec;

    for i in 2 .. p_credit_term loop
      l_gpk_rec.build_date := trunc(p_build_date);

      l_gpk_rec.pmt_id     := p_pmt_id + i - 1;
      l_gpk_rec.pmt_date   := add_months(l_gpk_rec.build_date, i);
      l_gpk_rec.pmt_in_bal := l_gpk_rec_prev.pmt_out_bal;

      if (i = p_credit_term) then
        -- ������������� ���������� ������� �� ������� ����������
        l_gpk_rec.pmt_body := p_credit_sum - l_gpk_rec_prev.pmt_body_total;
      else
        l_gpk_rec.pmt_body := round(p_credit_sum / p_credit_term, 2);
      end if;

      l_gpk_rec.pmt_body_total := l_gpk_rec_prev.pmt_body_total +
                                  l_gpk_rec.pmt_body;

      l_gpk_rec.pmt_interest := get_interest(l_gpk_rec_prev.pmt_in_bal,
                                             p_interest_rate,
                                             get_ir_date(l_gpk_rec_prev.pmt_date) + 1,
                                             l_gpk_rec_prev.pmt_date - 1) +
                                get_interest(l_gpk_rec.pmt_in_bal,
                                             p_interest_rate,
                                             l_gpk_rec_prev.pmt_date,
                                             get_ir_date(l_gpk_rec.pmt_date));

      if (i = p_credit_term) then
        -- ������������� ���������� ������� �� ��������� �� ������� �� ���������
        l_gpk_rec.pmt_interest := l_gpk_rec.pmt_interest +
                                  get_interest(l_gpk_rec.pmt_in_bal,
                                               p_interest_rate,
                                               get_ir_date(l_gpk_rec.pmt_date) + 1,
                                               l_gpk_rec.pmt_date - 1);
      end if;

      l_gpk_rec.pmt_total   := l_gpk_rec.pmt_body + l_gpk_rec.pmt_interest;
      l_gpk_rec.pmt_out_bal := l_gpk_rec.pmt_in_bal - l_gpk_rec.pmt_body;

      pipe row(l_gpk_rec);
      l_gpk_rec_prev := l_gpk_rec;
    end loop;
  end get_gpk_ep;

  -- ��������� ���������� �������� ��� (������, ���� 30/360)
  function get_gpk_a(p_pmt_id        number, -- ������ ����� �������
                     p_build_date    date, -- ���� ������ ����������
                     p_credit_sum    number, -- ����� �������
                     p_credit_term   number, -- ���� �������
                     p_interest_rate number -- ������� % ������
                     ) return t_gpk_table
    pipelined is
    l_ir_period      number := p_interest_rate / 12 / 100;
    l_annuus_pmt_sum number := round(p_credit_sum * l_ir_period *
                                     power(1 + l_ir_period, p_credit_term) /
                                     (power(1 + l_ir_period, p_credit_term) - 1),
                                     2);

    l_gpk_rec      t_gpk_rec;
    l_gpk_rec_prev t_gpk_rec;
  begin
    l_gpk_rec.build_date     := trunc(p_build_date);
    l_gpk_rec.pmt_id         := p_pmt_id;
    l_gpk_rec.pmt_date       := add_months(l_gpk_rec.build_date, 1);
    l_gpk_rec.pmt_in_bal     := p_credit_sum;
    l_gpk_rec.pmt_interest   := round(l_gpk_rec.pmt_in_bal * l_ir_period, 2);
    l_gpk_rec.pmt_body       := l_annuus_pmt_sum - l_gpk_rec.pmt_interest;
    l_gpk_rec.pmt_body_total := l_gpk_rec.pmt_body;
    l_gpk_rec.pmt_total      := l_annuus_pmt_sum;
    l_gpk_rec.pmt_out_bal    := l_gpk_rec.pmt_in_bal - l_gpk_rec.pmt_body;
    pipe row(l_gpk_rec);
    l_gpk_rec_prev := l_gpk_rec;

    for i in 2 .. p_credit_term loop
      l_gpk_rec.build_date := trunc(p_build_date);

      l_gpk_rec.pmt_id       := p_pmt_id + i - 1;
      l_gpk_rec.pmt_date     := add_months(l_gpk_rec.build_date, i);
      l_gpk_rec.pmt_in_bal   := l_gpk_rec_prev.pmt_out_bal;
      l_gpk_rec.pmt_interest := round(l_gpk_rec.pmt_in_bal * l_ir_period, 2);

      if (i = p_credit_term) then
        -- ������������� ���������� ������� �� ������� ����������
        l_gpk_rec.pmt_body := p_credit_sum - l_gpk_rec_prev.pmt_body_total;
      else
        l_gpk_rec.pmt_body := l_annuus_pmt_sum - l_gpk_rec.pmt_interest;
      end if;

      l_gpk_rec.pmt_body_total := l_gpk_rec_prev.pmt_body_total +
                                  l_gpk_rec.pmt_body;
      l_gpk_rec.pmt_total      := l_annuus_pmt_sum;
      l_gpk_rec.pmt_out_bal    := l_gpk_rec.pmt_in_bal - l_gpk_rec.pmt_body;
      pipe row(l_gpk_rec);
      l_gpk_rec_prev := l_gpk_rec;
    end loop;
  end get_gpk_a;

  -- ��������� ���������� �������� ��� (� ���� ������, ������ ���������, ���� ����/����)
  function get_gpk_ae(p_pmt_id        number, -- ������ ����� �������
                      p_build_date    date, -- ���� ������ ����������
                      p_credit_sum    number, -- ����� �������
                      p_credit_term   number, -- ���� �������
                      p_interest_rate number -- ������� % ������
                      ) return t_gpk_table
    pipelined is
    l_gpk_rec      t_gpk_rec;
    l_gpk_rec_prev t_gpk_rec;
  begin
    l_gpk_rec.build_date := trunc(p_build_date);

    l_gpk_rec.pmt_id         := p_pmt_id;
    l_gpk_rec.pmt_date       := add_months(l_gpk_rec.build_date, 1);
    l_gpk_rec.pmt_in_bal     := p_credit_sum;
    l_gpk_rec.pmt_body       := 0;
    l_gpk_rec.pmt_body_total := l_gpk_rec.pmt_body;

    l_gpk_rec.pmt_interest := get_interest(l_gpk_rec.pmt_in_bal,
                                           p_interest_rate,
                                           l_gpk_rec.build_date,
                                           l_gpk_rec.pmt_date);
    l_gpk_rec.pmt_total    := l_gpk_rec.pmt_body + l_gpk_rec.pmt_interest;
    l_gpk_rec.pmt_out_bal  := l_gpk_rec.pmt_in_bal - l_gpk_rec.pmt_body;
    pipe row(l_gpk_rec);
    l_gpk_rec_prev := l_gpk_rec;

    for i in 2 .. p_credit_term loop
      l_gpk_rec.build_date := trunc(p_build_date);

      l_gpk_rec.pmt_id         := p_pmt_id + i - 1;
      l_gpk_rec.pmt_date       := add_months(l_gpk_rec.build_date, i);
      l_gpk_rec.pmt_in_bal     := l_gpk_rec_prev.pmt_out_bal;
      l_gpk_rec.pmt_body       := 0;
      l_gpk_rec.pmt_body_total := l_gpk_rec_prev.pmt_body_total +
                                  l_gpk_rec.pmt_body;

      l_gpk_rec.pmt_interest := get_interest(l_gpk_rec.pmt_in_bal,
                                             p_interest_rate,
                                             l_gpk_rec_prev.pmt_date,
                                             l_gpk_rec.pmt_date);
      l_gpk_rec.pmt_total    := l_gpk_rec.pmt_body + l_gpk_rec.pmt_interest;
      l_gpk_rec.pmt_out_bal  := l_gpk_rec.pmt_in_bal - l_gpk_rec.pmt_body;

      pipe row(l_gpk_rec);
      l_gpk_rec_prev := l_gpk_rec;
    end loop;
  end get_gpk_ae;

  -- ������� ��� ���������� ��� �������� �� ������ ������� � �������� ���������� ������
  function gpk_anuitent_by_month_nrates( p_date_credit in date, -- ���� ��������
                                           p_sum_credit in number, -- �������� ������
                                           p_n_months in number, -- �� ���-�� �������
                                           p_when_first_pay in varchar2 default '����� ������', -- ����� ������ ������ '����� ������' ����� '������. �����'
                                           p_day_pay in number, -- ���� ���������
                                           p_credit_rate_tab in t_credit_rate_tab )
    return t_gpc_tab pipelined
  is
    v_first_telo_credit number;
    v_prev_rate number :=0;
    v_ostatok_tela number;
    v_pogash_telo_credit number;
    v_A_sum number;
    v_qty_month integer;
    v_months_credit integer ;

    v_first_platej_data date; -- ������ ���� ������ �������
    v_data_pogash_credit date; -- ��������� ������ ���� �������
    v_max_date date := to_date('31.12.3000','dd.mm.yyyy');

    l_platej_data         date;
    l_sum_platej_anuitent number;
    l_pogash_telo_credit  number;
    l_protent_credit      number;
    l_ostatok_tela        number;
  begin
    v_ostatok_tela := p_sum_credit;
    v_first_telo_credit := v_ostatok_tela;

    -- ��������� ���� ������,������ ���������
    --v_data_pogash_credit := add_months(to_date(p_day_pay||to_char(p_date_credit,'mm.yyyy'),'dd.mm.yyyy'), p_n_months);
    v_data_pogash_credit := add_months(p_date_credit, p_n_months);

    if p_when_first_pay = '����� ������'  then
      v_months_credit := p_n_months + 1;
      v_first_platej_data := to_date(lpad(to_char(p_day_pay),2,'0')||to_char(p_date_credit,'mm.yyyy'),'dd.mm.yyyy');
    else ---'������. �����'
      v_months_credit := p_n_months;
      v_first_platej_data := to_date(lpad(to_char(p_day_pay),2,'0')||to_char(add_months(p_date_credit,1),'mm.yyyy'),'dd.mm.yyyy');
    end if;

    for x in (select a.*
                     , (select rate from table(p_credit_rate_tab) where a.platej_data between rate_date_start and nvl(rate_date_end, v_max_date) ) month_rate
                     , (select rate_date_start from table(p_credit_rate_tab) where a.platej_data between rate_date_start and nvl(rate_date_end, v_max_date) ) start_month_rate
                from ( select level
                              , case when level <> v_months_credit then add_months(v_first_platej_data ,(level-1))
                                     else v_data_pogash_credit end as platej_data

                        from dual
                      connect by level <= v_months_credit) a)
      loop
        if v_prev_rate <> x.month_rate then -- � ������ ����� ������ ������� ����� �������� ������� � ������������ ����;
          if v_prev_rate = 0 then -- ����� ��� ������ ������������
            v_A_sum := cck.f_pl1(0,v_ostatok_tela*100,4,p_day_pay,p_date_credit,v_data_pogash_credit,x.month_rate,0)/100;
          end if;

          if v_prev_rate <> 0 then -- ����� ������� = ������� ���� ��������� ������� - ������ �������� ����� ������
            v_A_sum := cck.f_pl1(0,v_ostatok_tela*100,4,p_day_pay,l_platej_data,v_data_pogash_credit,x.month_rate,0)/100;
          end if;
        end if;

        if x.level = v_months_credit then --� ��������� ����� ����� �������� �� �������, ������� �� ���� � ������� �� ����� ����� ������� � �����
          l_platej_data         := x.platej_data;
          if v_ostatok_tela < v_A_sum then
            l_sum_platej_anuitent := v_ostatok_tela + round(((v_ostatok_tela * x.month_rate)/36000)*30,2);
            l_pogash_telo_credit := v_ostatok_tela;
            l_ostatok_tela        := v_ostatok_tela - l_pogash_telo_credit;
          else
            l_sum_platej_anuitent := v_first_telo_credit + round(((v_ostatok_tela * x.month_rate)/36000)*30,2) ;
            l_pogash_telo_credit  := v_first_telo_credit ;
            l_ostatok_tela        := v_ostatok_tela - (v_A_sum - round(((v_ostatok_tela * x.month_rate)/36000)*30 ,2));
          end if;
          l_protent_credit      := round(((v_ostatok_tela * x.month_rate)/36000)*30,2) ;

          v_pogash_telo_credit :=  l_pogash_telo_credit;
        elsif x.level = v_months_credit - 1 and v_ostatok_tela < v_A_sum and p_when_first_pay = '����� ������' then
          continue;
        else
          l_platej_data         := x.platej_data;
          l_sum_platej_anuitent := v_A_sum ;
          l_pogash_telo_credit  := v_A_sum - round(((v_ostatok_tela * x.month_rate)/36000)*30 ,2)  ;
          l_protent_credit      := round(((v_ostatok_tela * x.month_rate)/36000)*30,2) ;
          l_ostatok_tela        := v_ostatok_tela - (v_A_sum - round(((v_ostatok_tela * x.month_rate)/36000)*30 ,2));

          v_pogash_telo_credit := l_pogash_telo_credit;
        end if;

        if v_prev_rate <> 0 and v_prev_rate <> x.month_rate then --������������ ������� ���� � ������ �������� ������ � ������ ������, ������� �� �����������
          -- �� ���������, �������� ������� ��������
          v_ostatok_tela := l_ostatok_tela;
        else
          -- ��������� ���o
          v_ostatok_tela := v_ostatok_tela - v_pogash_telo_credit;
        end if;

        v_first_telo_credit := v_first_telo_credit - v_pogash_telo_credit;
        v_prev_rate := x.month_rate;

        pipe row (t_gpc (l_platej_data
                         , l_sum_platej_anuitent
                         , l_pogash_telo_credit
                         , l_protent_credit
                         , l_ostatok_tela  ));
      end loop;

    return;
  end gpk_anuitent_by_month_nrates;

  -- ������� ��� ���������� ��� ������� ������� �� ������ ������� � �������� ���������� ������
  function gpk_ravnie_by_month_nrates( p_date_credit in date, -- ���� ��������
                                       p_sum_credit in number, -- �������� ������
                                       p_n_months in number, -- �� ���-�� �������
                                       p_when_first_pay in varchar2 default '������. �����', -- ����� ������ ������ '������. �����' ����� '����� ������'
                                       p_day_pay in number, -- ���� ���������
                                       p_credit_rate_tab in t_credit_rate_tab )
    return t_gpc_tab pipelined
  is
    v_first_platej_data date; -- ������ ���� ������ �������
    v_data_pogash_credit date; -- ��������� ������ ���� �������
    v_max_date date := to_date('31.12.3000','dd.mm.yyyy');
    v_date date;

    l_platej_data         date;
    l_sum_platej          number;
    l_pogash_telo_credit  number;
    l_protent_credit      number;
    l_ostatok_tela        number;
    ----------------------------
    v_OB number; -- ������ ������ ����
    v_V1 number; --�������� �� ������ �����
    v_Z1 number; --������������ ���� �� ������ ������
    v_Z2 number; --������������ ���� �� ������ ������
    v_N1 number; --��� ������� �������
    v_N2 number; --��� ������� �������
    v_N3 number;
    v_VP1 number; -- �������� �� ������ ������
    v_VP2 number; -- �������� �� ������ ������
    v_VP3 number;
    v_qty_days_year number; -- ���������� ���� � ����
    v_n_months number;
    l_prev_rate decimal;
  begin
    -- ������ �������� ������ ������ ���� 01 �����
    for x in ( select '<> 01' as msg from table (p_credit_rate_tab) where to_char(rate_date_start,'dd') <> '01')
    loop
      return; -- �����
    end loop;

    if p_when_first_pay = '������. �����'  then
      v_n_months := p_n_months;
      --������ ���� ������
      v_first_platej_data :=  add_months(to_date(lpad(p_day_pay,2,0)||to_char(p_date_credit,'mm.yyyy'),'dd.mm.yyyy'), 1);
    else -- '����� ������'
      v_n_months := p_n_months+1;
      v_first_platej_data :=  to_date(lpad(p_day_pay,2,0)||to_char(p_date_credit,'mm.yyyy'),'dd.mm.yyyy');
    end if;
    v_OB := round(p_sum_credit / v_n_months,2); -- ������ ������ ���� �������

    -- ��������� ���� ������,������ ���������
    v_data_pogash_credit := add_months(p_date_credit, p_n_months);

    for x in (select a.*
                   , (select rate from table(p_credit_rate_tab) where a.platej_data between rate_date_start and nvl(rate_date_end, v_max_date) ) month_rate
                   , (select rate_date_start from table(p_credit_rate_tab) where a.platej_data between rate_date_start and nvl(rate_date_end, v_max_date) ) start_month_rate
              from ( select level
                            , case when level <> v_n_months then add_months(v_first_platej_data ,(level-1))
                                   else v_data_pogash_credit end as platej_data

                      from dual
                    connect by level <= v_n_months) a)
      loop
        if x.level = 1 then
          v_qty_days_year := ( to_date('3112'||to_char(p_date_credit, 'YYYY'),'DDMMYYYY') - trunc(p_date_credit, 'YEAR') + 1);

          if p_when_first_pay = '������. �����'  then
            v_V1 := ((p_sum_credit * (x.month_rate / 100)) / v_qty_days_year) * ( (last_day(p_date_credit) - p_date_credit)+1);

            v_V1 := round(v_V1, 2);
          else -- '����� ������'
            v_V1 := 0;
          end if;

          l_platej_data         := x.platej_data;
          l_sum_platej          := v_OB + v_V1;
          l_pogash_telo_credit  := v_OB;
          l_protent_credit      := v_V1;
          l_ostatok_tela        := p_sum_credit - v_OB;

          -----
          v_Z1 := p_sum_credit;
          v_Z2 := l_ostatok_tela;
        end if;

        if x.level <> 1 and x.level <> v_n_months then
          v_N1 := (add_months(x.platej_data, -1) - trunc(add_months(x.platej_data, -1), 'mm'));
          v_N2 := (last_day(add_months(x.platej_data, -1)) - add_months(x.platej_data, -1))+1;

          v_qty_days_year := ( to_date('3112'||to_char((add_months(x.platej_data, -1) ), 'YYYY'),'DDMMYYYY') - trunc((add_months(x.platej_data, -1) ), 'YEAR') + 1) ;

          v_VP1 := round(((v_Z1* (l_prev_rate/100)) / v_qty_days_year) * v_N1, 2);
          v_VP2 := round(((v_Z2* (l_prev_rate/100)) / v_qty_days_year) * v_N2, 2);

          --------------------------------------

          l_platej_data         := x.platej_data;
          l_sum_platej          := v_OB + v_VP1 + v_VP2;
          l_pogash_telo_credit  := v_OB;
          l_protent_credit      := v_VP1 + v_VP2;
          l_ostatok_tela        := l_ostatok_tela - v_OB;

          v_Z1 := v_Z2;
          v_Z2 := l_ostatok_tela;

        end if;

        if x.level = v_n_months then
          v_date := to_date(lpad(p_day_pay,2,0)||to_char(x.platej_data,'mm.yyyy'),'dd.mm.yyyy');

          v_N1 := add_months( v_date, -1) - trunc(add_months( v_date, -1), 'mm');
          v_N2 := (last_day(add_months(v_date, -1)) - add_months(v_date, -1)) +1;

          v_qty_days_year := ( to_date('3112'||to_char((add_months(x.platej_data, -1) ), 'YYYY'),'DDMMYYYY') - trunc((add_months(x.platej_data, -1) ), 'YEAR') + 1) ;

          v_VP1 := round(((v_Z1* (l_prev_rate/100)) / v_qty_days_year) * v_N1, 2);
          v_VP2 := round(((v_Z2* (l_prev_rate/100)) / v_qty_days_year) * v_N2, 2);

          v_N3 := x.platej_data - trunc(x.platej_data, 'mm');
          v_qty_days_year := ( to_date('3112'||to_char((x.platej_data), 'YYYY'),'DDMMYYYY') - trunc((x.platej_data), 'YEAR') + 1) ;
          v_VP3 := round(((v_Z2* (x.month_rate/100)) / v_qty_days_year) * v_N3, 2);
          --------------------------------------
          l_platej_data         := x.platej_data;
          if l_ostatok_tela < l_sum_platej then
            l_sum_platej          := l_ostatok_tela + v_VP1 + v_VP2 + v_VP3;
            l_pogash_telo_credit  := l_ostatok_tela;
            l_ostatok_tela        := l_ostatok_tela - l_pogash_telo_credit;
          else
            l_sum_platej          := v_OB + v_VP1 + v_VP2 + v_VP3;
            l_pogash_telo_credit  := v_OB;
            l_ostatok_tela        := l_ostatok_tela - v_OB;
          end if;
          l_protent_credit      := v_VP1 + v_VP2 + v_VP3;

          v_Z1 := v_Z2;
          v_Z2 := l_ostatok_tela;

        end if;
        pipe row (t_gpc (l_platej_data
                       , l_sum_platej
                       , l_pogash_telo_credit
                       , l_protent_credit
                       , l_ostatok_tela  ));
        l_prev_rate := x.month_rate;
      end loop;

    return;
  end gpk_ravnie_by_month_nrates;

  -- ��������� ���������� �������� ���
  function build_gpk(p_bid_id in wcs_bids.id%type -- ������������� ������
                     ) return t_gpk_table
    pipelined is
    l_b_row wcs_bids%rowtype;

    l_gpk_rec      t_gpk_rec;
    l_gpk_rec_prev t_gpk_rec;

    l_mac_crd_type       number := to_number(wcs_utl.get_mac(p_bid_id,
                                                             'MAC_CRD_TYPE')); -- ��� �������
    l_mac_repayment_term number := to_number(wcs_utl.get_mac(p_bid_id,
                                                             'MAC_REPAYMENT_TERM')); -- ����� ��������� ��������� ������ �� �������� �� (��)

    l_credit_currency  varchar2(100) := wcs_utl.get_creditdata(p_bid_id,
                                                               'CREDIT_CURRENCY'); -- ������ �������
    l_property_cost    number := to_number(wcs_utl.get_creditdata(p_bid_id,
                                                                  'PROPERTY_COST')); -- ������� �����
    l_credit_sum       number := to_number(wcs_utl.get_creditdata(p_bid_id,
                                                                  'CREDIT_SUM')) * 100; -- ���� ������� (� ���)
    l_own_funds        number := to_number(wcs_utl.get_creditdata(p_bid_id,
                                                                  'OWN_FUNDS')); -- ���� ������� �����
    l_credit_term      number := to_number(wcs_utl.get_creditdata(p_bid_id,
                                                                  'CREDIT_TERM')); -- ����� �������
    l_interest_rate    number := to_number(wcs_utl.get_creditdata(p_bid_id,
                                                                  'INTEREST_RATE')); -- ³�������� ������
    l_repayment_method number := to_number(wcs_utl.get_creditdata(p_bid_id,
                                                                  'REPAYMENT_METHOD')); -- ����� ���������
    l_repayment_day    number := nvl(to_number(wcs_utl.get_creditdata(p_bid_id,
                                                                  'REPAYMENT_DAY')),
                                               extract(DAY from gl.bd)); -- ���� ���������
    l_deal_date        date := nvl(to_date(wcs_utl.get_creditdata(p_bid_id,
                                                                  'DEAL_DATE')),
                                   gl.bd); -- ���� ������
    l_single_fee       number := to_number(wcs_utl.get_creditdata(p_bid_id,
                                                                  'SINGLE_FEE')); -- ����� ����� ������
    l_monthly_fee      number := to_number(wcs_utl.get_creditdata(p_bid_id,
                                                                  'MONTHLY_FEE')); -- ����� ����� ��������
    l_penalty          number := to_number(wcs_utl.get_creditdata(p_bid_id,
                                                                  'PENALTY')); -- ����

    l_pl1 number;

    l_is_employee number := nvl(to_number(wcs_utl.get_answ_refer(p_bid_id,'WORKER_BANK')),0);
    l_is_base_rate number := nvl(wcs_utl.get_answ_bool(p_bid_id,'BASE_RATES'),0);
    l_date_rate_begin date := wcs_utl.get_answ_date(p_bid_id,'DATE_RATE_BEGIN');
    v_credit_rate_tab t_credit_rate_tab := t_credit_rate_tab();
    l_next_date date;
    v_max_date date := to_date('31.12.3000','dd.mm.yyyy');
    l_rate decimal;
    l_when_next_pay varchar2(50);

    not_date_format exception;
    pragma exception_init(not_date_format, -1840);
  begin
    -- ��������� ������
    select * into l_b_row from wcs_bids b where b.id = p_bid_id;

    l_gpk_rec.bid_id     := p_bid_id;
    l_gpk_rec.build_date := l_deal_date;

    case
      when l_repayment_method in (2, 4) and nvl(l_mac_crd_type, 0) = 0 and l_is_employee <> 1 and l_is_base_rate = 0 then
        -- 2 - ������ ��������� (���� ����/����)/ 4 - ������ (���� 30/360), ����������� ������
        l_pl1 := cck.f_pl1(p_nd   => null, -- ��� ���� ���������
                           p_lim2 => l_credit_sum, -- ����� ������� (� ���.)
                           p_gpk  => l_repayment_method, -- 4-�������. 2 - �����
                           p_dd   => l_repayment_day, -- <��������� ����>, �� ���� = DD �� �������� ����.���
                           p_datn => l_deal_date, -- ���� ��� ��
                           p_datk => add_months(l_deal_date, l_credit_term), -- ���� ����� ��
                           p_ir   => l_interest_rate, -- ����.������
                           p_ssr  => 0 -- ������� =0= "� ����������� �����"   - ��� ���� ��������� =0               \
                           );

        cck.uni_gpk_fl(p_lim2  => l_credit_sum, -- ����� ������� (� ���.)
                       p_gpk   => l_repayment_method, -- 4-�������. 2 - �����
                       p_dd    => l_repayment_day, -- <��������� ����>, �� ���� = dd �� �������� ����.���
                       p_datn  => l_deal_date, -- ���� ��� ��
                       p_datk  => add_months(l_deal_date, l_credit_term), -- ���� ����� ��
                       p_ir    => l_interest_rate, -- ����.������
                       p_pl1   => l_pl1, -- ����� 1 ��
                       p_ssr   => 0, -- ������� =0= "� ����������� �����"   - ��� ���� ��������� =0
                       p_ss    => 0, -- ������� �� ���� ����                - ��� ���� ���������= 0
                       p_acrd  => l_deal_date, -- � ����� ���� ��������� % acr_dat+1        - ��� ���� ��� = ���� ��� ��
                       p_basey => 0 -- ���� ��� ��� %%;   - � �����: ��� �������� = 2, ��� ����� = 0
                       );

        for cur in (select rownum - 1 as rwn,
                           fdat,
                           lim2 / 100 as lim2,
                           sumg / 100 as sumg,
                           sumo / 100 as sumo,
                           sumk / 100 as sumk
                      from (select * from tmp_gpk t order by t.fdat)) loop
          l_gpk_rec.bid_id         := p_bid_id;
          l_gpk_rec.build_date     := l_deal_date;
          l_gpk_rec.pmt_id         := cur.rwn;
          l_gpk_rec.pmt_date       := cur.fdat;
          l_gpk_rec.pmt_in_bal     := nvl(cur.lim2, 0) + nvl(cur.sumg, 0);
          l_gpk_rec.pmt_body       := cur.sumg;
          l_gpk_rec.pmt_body_total := null;
          l_gpk_rec.pmt_interest   := nvl(cur.sumo, 0) - nvl(cur.sumg, 0) -
                                      nvl(cur.sumk, 0);
          l_gpk_rec.pmt_total      := cur.sumo;
          l_gpk_rec.pmt_out_bal    := cur.lim2;

          pipe row(l_gpk_rec);
        end loop;
      when l_repayment_method = 0 and l_mac_crd_type = 1 and l_is_employee <> 1 and l_is_base_rate = 0 then
        -- � ���� ������, ���� ����/����, ������������� �������� ��� ���� ������� (� ���������� � ���� ������)
        for cur in (select *
                      from table(get_gpk_ae(1,
                                            l_deal_date,
                                            l_credit_sum / 100,
                                            l_mac_repayment_term,
                                            l_interest_rate))) loop
          l_gpk_rec.bid_id         := p_bid_id;
          l_gpk_rec.build_date     := cur.build_date;
          l_gpk_rec.pmt_id         := cur.pmt_id;
          l_gpk_rec.pmt_date       := cur.pmt_date;
          l_gpk_rec.pmt_in_bal     := cur.pmt_in_bal;
          l_gpk_rec.pmt_body       := cur.pmt_body;
          l_gpk_rec.pmt_body_total := cur.pmt_body_total;
          l_gpk_rec.pmt_interest   := cur.pmt_interest;
          l_gpk_rec.pmt_total      := cur.pmt_total;
          l_gpk_rec.pmt_out_bal    := cur.pmt_out_bal;

          pipe row(l_gpk_rec);
        end loop;

        -- ������������ ������� ����������� (��. ����� + ������)
        if (l_b_row.subproduct_id in
           ('SBP_CONSUMER_0_5_2_EP', 'SBP_CONSUMER_5_10_2_EP')) then
          -- ������ ���������, ���� ����/����, ����������� ������
          l_pl1 := cck.f_pl1(p_nd   => null, -- ��� ���� ���������
                             p_lim2 => l_credit_sum, -- ����� ������� (� ���.)
                             p_gpk  => 2, -- 4-�������. 2 - �����
                             p_dd   => l_repayment_day, -- <��������� ����>, �� ���� = DD �� �������� ����.���
                             p_datn => add_months(l_deal_date,
                                                  l_mac_repayment_term), -- ���� ��� ��
                             p_datk => add_months(l_deal_date, l_credit_term), -- ���� ����� ��
                             p_ir   => l_interest_rate, -- ����.������
                             p_ssr  => 0 -- ������� =0= "� ����������� �����"   - ��� ���� ��������� =0               \
                             );

          cck.uni_gpk_fl(p_lim2  => l_credit_sum, -- ����� ������� (� ���.)
                         p_gpk   => 2, -- 4-�������. 2 - �����
                         p_dd    => l_repayment_day, -- <��������� ����>, �� ���� = dd �� �������� ����.���
                         p_datn  => add_months(l_deal_date,
                                               l_mac_repayment_term), -- ���� ��� ��
                         p_datk  => add_months(l_deal_date, l_credit_term), -- ���� ����� ��
                         p_ir    => l_interest_rate, -- ����.������
                         p_pl1   => l_pl1, -- ����� 1 ��
                         p_ssr   => 0, -- ������� =0= "� ����������� �����"   - ��� ���� ��������� =0
                         p_ss    => 0, -- ������� �� ���� ����                - ��� ���� ���������= 0
                         p_acrd  => l_deal_date, -- � ����� ���� ��������� % acr_dat+1        - ��� ���� ��� = ���� ��� ��
                         p_basey => 0 -- ���� ��� ��� %%;   - � �����: ��� �������� = 2, ��� ����� = 0
                         );

          for cur in (select rownum + l_mac_repayment_term as rwn,
                             fdat,
                             lim2 / 100 as lim2,
                             sumg / 100 as sumg,
                             sumo / 100 as sumo,
                             sumk / 100 as sumk
                        from (select * from tmp_gpk t order by t.fdat)) loop
            l_gpk_rec.bid_id         := p_bid_id;
            l_gpk_rec.build_date     := l_deal_date;
            l_gpk_rec.pmt_id         := cur.rwn;
            l_gpk_rec.pmt_date       := cur.fdat;
            l_gpk_rec.pmt_in_bal     := nvl(cur.lim2, 0) + nvl(cur.sumg, 0);
            l_gpk_rec.pmt_body       := cur.sumg;
            l_gpk_rec.pmt_body_total := null;
            l_gpk_rec.pmt_interest   := nvl(cur.sumo, 0) - nvl(cur.sumg, 0) -
                                        nvl(cur.sumk, 0);
            l_gpk_rec.pmt_total      := cur.sumo;
            l_gpk_rec.pmt_out_bal    := cur.lim2;

            pipe row(l_gpk_rec);
          end loop;
        end if;
      when l_repayment_method in (2, 4) and l_mac_crd_type = 1 and l_is_employee <> 1 and l_is_base_rate = 0 then
        -- 2 - ������ ��������� (���� ����/����)/ 4 - ������ (���� 30/360), ����������� ������
        l_pl1 := cck.f_pl1(p_nd   => null, -- ��� ���� ���������
                           p_lim2 => l_credit_sum, -- ����� ������� (� ���.)
                           p_gpk  => l_repayment_method, -- 4-�������. 2 - �����
                           p_dd   => l_repayment_day, -- <��������� ����>, �� ���� = DD �� �������� ����.���
                           p_datn => l_deal_date, -- ���� ��� ��
                           p_datk => add_months(l_deal_date,
                                                l_mac_repayment_term), -- ���� ����� ��
                           p_ir   => l_interest_rate, -- ����.������
                           p_ssr  => 0 -- ������� =0= "� ����������� �����"   - ��� ���� ��������� =0               \
                           );

        cck.uni_gpk_fl(p_lim2  => l_credit_sum, -- ����� ������� (� ���.)
                       p_gpk   => l_repayment_method, -- 4-�������. 2 - �����
                       p_dd    => l_repayment_day, -- <��������� ����>, �� ���� = dd �� �������� ����.���
                       p_datn  => l_deal_date, -- ���� ��� ��
                       p_datk  => add_months(l_deal_date,
                                             l_mac_repayment_term), -- ���� ����� ��
                       p_ir    => l_interest_rate, -- ����.������
                       p_pl1   => l_pl1, -- ����� 1 ��
                       p_ssr   => 0, -- ������� =0= "� ����������� �����"   - ��� ���� ��������� =0
                       p_ss    => 0, -- ������� �� ���� ����                - ��� ���� ���������= 0
                       p_acrd  => l_deal_date, -- � ����� ���� ��������� % acr_dat+1        - ��� ���� ��� = ���� ��� ��
                       p_basey => 0 -- ���� ��� ��� %%;   - � �����: ��� �������� = 2, ��� ����� = 0
                       );

        for cur in (select rownum - 1 as rwn,
                           fdat,
                           lim2 / 100 as lim2,
                           sumg / 100 as sumg,
                           sumo / 100 as sumo,
                           sumk / 100 as sumk
                      from (select * from tmp_gpk t order by t.fdat)) loop
          l_gpk_rec.bid_id         := p_bid_id;
          l_gpk_rec.build_date     := l_deal_date;
          l_gpk_rec.pmt_id         := cur.rwn;
          l_gpk_rec.pmt_date       := cur.fdat;
          l_gpk_rec.pmt_in_bal     := nvl(cur.lim2, 0) + nvl(cur.sumg, 0);
          l_gpk_rec.pmt_body       := cur.sumg;
          l_gpk_rec.pmt_body_total := null;
          l_gpk_rec.pmt_interest   := nvl(cur.sumo, 0) - nvl(cur.sumg, 0) -
                                      nvl(cur.sumk, 0);
          l_gpk_rec.pmt_total      := cur.sumo;
          l_gpk_rec.pmt_out_bal    := cur.lim2;

          pipe row(l_gpk_rec);
        end loop;
      when l_is_employee = 1 and l_repayment_method = 4 and l_is_base_rate = 1 then
        for c in (select * from V_BRATES where br_id = 9999 and rate is not null)
          loop
            begin
              select /*min(dat)*/to_date(lpad(to_char(l_repayment_day),2,'0')||to_char(min(dat),'mm.yyyy'),'dd.mm.yyyy') into l_next_date from v_brates where dat > c.dat and br_id = c.br_id;
            exception
              when not_date_format then
                l_next_date := null;
            end;
            if l_next_date is null then
              l_next_date := to_date(lpad((case
                                        when l_repayment_day > 28 and extract(MONTH from l_date_rate_begin) in (2) then
                                           extract(DAY from last_day(l_date_rate_begin))
                                        when l_repayment_day > 30 and extract(MONTH from l_date_rate_begin) in (4,6,9,11) then
                                          extract(DAY from last_day(l_date_rate_begin))
                                        else l_repayment_day
                                      end),2,'0')||to_char(l_date_rate_begin,'mm.yyyy'),'dd.mm.yyyy');
            end if;
            v_credit_rate_tab.extend(1);
            v_credit_rate_tab(v_credit_rate_tab.count) := t_credit_rate(c.rate,to_date(lpad((case
                                        when l_repayment_day > 28 and extract(MONTH from c.dat) in (2) then
                                           extract(DAY from last_day(c.dat))
                                        when l_repayment_day > 30 and extract(MONTH from c.dat) in (4,6,9,11) then
                                           extract(DAY from last_day(c.dat))
                                        else l_repayment_day
                                      end),2,'0')||to_char(c.dat,'mm.yyyy'),'dd.mm.yyyy') + 1,l_next_date);
            dbms_output.put_line(c.rate||'|'||to_char(to_date(lpad((case
                                        when l_repayment_day > 28 and extract(MONTH from c.dat) in (2) then
                                           extract(DAY from last_day(c.dat))
                                        when l_repayment_day > 30 and extract(MONTH from c.dat) in (4,6,9,11) then
                                           extract(DAY from last_day(c.dat))
                                        else l_repayment_day
                                      end),2,'0')||to_char(c.dat,'mm.yyyy'),'dd.mm.yyyy') + 1)||'|'||l_next_date);
          end loop;
        v_credit_rate_tab.extend(1);
        v_credit_rate_tab(v_credit_rate_tab.count) := t_credit_rate(l_interest_rate,to_date(lpad((case
                                        when l_repayment_day > 28 and extract(MONTH from l_date_rate_begin) in (2) then
                                           extract(DAY from last_day(l_date_rate_begin))
                                        when l_repayment_day > 30 and extract(MONTH from l_date_rate_begin) in (4,6,9,11) then
                                           extract(DAY from last_day(l_date_rate_begin))
                                        else l_repayment_day
                                      end),2,'0')||to_char(l_date_rate_begin,'mm.yyyy'),'dd.mm.yyyy') + 1,null);
        dbms_output.put_line(l_interest_rate||'|'||to_char(to_date(lpad((case
                                        when l_repayment_day > 28 and extract(MONTH from l_date_rate_begin) in (2) then
                                           extract(DAY from last_day(l_date_rate_begin))
                                        when l_repayment_day > 30 and extract(MONTH from l_date_rate_begin) in (4,6,9,11) then
                                           extract(DAY from last_day(l_date_rate_begin))
                                        else l_repayment_day
                                      end),2,'0')||to_char(l_date_rate_begin,'mm.yyyy'),'dd.mm.yyyy') + 1)||'|');

        l_gpk_rec.bid_id         := p_bid_id;
        l_gpk_rec.build_date     := l_deal_date;
        l_gpk_rec.pmt_id         := 0;
        l_gpk_rec.pmt_date       := trunc(l_deal_date);
        l_gpk_rec.pmt_in_bal     := l_credit_sum/100;
        l_gpk_rec.pmt_body       := 0;
        l_gpk_rec.pmt_body_total := null;
        l_gpk_rec.pmt_interest   := 0;
        l_gpk_rec.pmt_total      := 0;
        l_gpk_rec.pmt_out_bal    := l_credit_sum/100;
        pipe row(l_gpk_rec);

        if to_number(l_repayment_day) > to_number(extract(DAY from l_deal_date)) then
          l_when_next_pay := '����� ������';
        else
          l_when_next_pay := '������. �����';
        end if;

        for cur in ( select rownum as rwn, t.* from table(gpk_anuitent_by_month_nrates( l_deal_date-- ���� ��������
                                                                      , l_credit_sum/100  -- �������� ������
                                                                      , l_credit_term  -- �� ���-�� �������
                                                                      , l_when_next_pay -- '����� ������' -- ����� ������ ������ '����� ������' ����� '������. �����'
                                                                      , l_repayment_day
                                                                      , v_credit_rate_tab)) t)
          loop
            select rate into l_rate from table(v_credit_rate_tab) where cur.platej_data between rate_date_start and nvl(rate_date_end, v_max_date);
            l_gpk_rec.bid_id         := p_bid_id;
            l_gpk_rec.build_date     := l_deal_date;
            l_gpk_rec.pmt_id         := cur.rwn;
            l_gpk_rec.pmt_date       := cur.platej_data;
            l_gpk_rec.pmt_in_bal     := round(cur.ostatok_tela + cur.pogash_telo_credit,2);
            l_gpk_rec.pmt_body       := cur.pogash_telo_credit;
            l_gpk_rec.pmt_body_total := null;
            l_gpk_rec.pmt_interest   := cur.protent_credit;
            l_gpk_rec.pmt_total      := cur.sum_platej;
            l_gpk_rec.pmt_out_bal    := cur.ostatok_tela;
            pipe row(l_gpk_rec);
          end loop;
      when l_is_employee = 1 and l_repayment_method = 2 and l_is_base_rate = 1 then
        for c in (select * from V_BRATES where br_id = 9999)
          loop
            select min(dat) - 1 into l_next_date from v_brates where dat > c.dat and br_id = c.br_id;
            if l_next_date is null then
              l_next_date := l_date_rate_begin - 1;
            end if;
            v_credit_rate_tab.extend(1);
            v_credit_rate_tab(v_credit_rate_tab.count) := t_credit_rate(c.rate,c.dat,l_next_date);
          end loop;
        v_credit_rate_tab.extend(1);
        v_credit_rate_tab(v_credit_rate_tab.count) := t_credit_rate(l_interest_rate,l_date_rate_begin,null);

        l_gpk_rec.bid_id         := p_bid_id;
        l_gpk_rec.build_date     := l_deal_date;
        l_gpk_rec.pmt_id         := 0;
        l_gpk_rec.pmt_date       := trunc(l_deal_date);
        l_gpk_rec.pmt_in_bal     := l_credit_sum/100;
        l_gpk_rec.pmt_body       := 0;
        l_gpk_rec.pmt_body_total := null;
        l_gpk_rec.pmt_interest   := 0;
        l_gpk_rec.pmt_total      := 0;
        l_gpk_rec.pmt_out_bal    := l_credit_sum/100;
        pipe row(l_gpk_rec);

        if to_number(l_repayment_day) < to_number(extract(DAY from l_deal_date)) then
          l_when_next_pay := '����� ������';
        else
          l_when_next_pay := '������. �����';
        end if;

        for cur in ( select rownum as rwn, t.* from table(gpk_ravnie_by_month_nrates( l_deal_date-- ���� ��������
                                                                      , l_credit_sum/100  -- �������� ������
                                                                      , l_credit_term  -- �� ���-�� �������
                                                                      , l_when_next_pay -- '����� ������' -- ����� ������ ������ '����� ������' ����� '������. �����'
                                                                      , l_repayment_day
                                                                      , v_credit_rate_tab)) t)
          loop
            select rate into l_rate from table(v_credit_rate_tab) where cur.platej_data between rate_date_start and nvl(rate_date_end, v_max_date);
            l_gpk_rec.bid_id         := p_bid_id;
            l_gpk_rec.build_date     := l_deal_date;
            l_gpk_rec.pmt_id         := cur.rwn;
            l_gpk_rec.pmt_date       := cur.platej_data;
            l_gpk_rec.pmt_in_bal     := round(cur.ostatok_tela + cur.pogash_telo_credit,2);
            l_gpk_rec.pmt_body       := cur.pogash_telo_credit;
            l_gpk_rec.pmt_body_total := null;
            l_gpk_rec.pmt_interest   := cur.protent_credit;
            l_gpk_rec.pmt_total      := cur.sum_platej;
            l_gpk_rec.pmt_out_bal    := cur.ostatok_tela;
            pipe row(l_gpk_rec);
          end loop;
      else
        null;
    end case;

    return;
  end build_gpk;

  -- ������� �������� ��� � ���������� ������� wcs_bid_gpk
  procedure store_gpk(p_bid_id in wcs_bids.id%type -- ������������� ������
                      ) is
  begin
    -- ������ �������
    delete from wcs_bid_gpk bg where bg.bid_id = p_bid_id;

    -- ��������� ������ ���
    insert into wcs_bid_gpk
      (bid_id,
       build_date,
       pmt_id,
       pmt_date,
       pmt_in_bal,
       pmt_body,
       pmt_interest,
       pmt_total,
       pmt_out_bal)
      select p_bid_id,
             sysdate,
             t.pmt_id,
             t.pmt_date,
             t.pmt_in_bal   as pmt_in_bal,
             t.pmt_body     as pmt_body,
             t.pmt_interest as pmt_interest,
             t.pmt_total    as pmt_total,
             t.pmt_out_bal  as pmt_out_bal
        from table(build_gpk(p_bid_id)) t;
  end store_gpk;

  -- ������� �������� ���
  function get_gpk(p_bid_id in wcs_bids.id%type -- ������������� ������
                   ) return t_gpk_table
    pipelined is
    l_gpk_rec t_gpk_rec;
  begin
    for cur in (select *
                  from wcs_bid_gpk bg
                 where bg.bid_id = p_bid_id
                 order by bg.pmt_id nulls last) loop
      l_gpk_rec.bid_id       := cur.bid_id;
      l_gpk_rec.build_date   := cur.build_date;
      l_gpk_rec.pmt_id       := cur.pmt_id;
      l_gpk_rec.pmt_date     := cur.pmt_date;
      l_gpk_rec.pmt_in_bal   := cur.pmt_in_bal;
      l_gpk_rec.pmt_body     := cur.pmt_body;
      l_gpk_rec.pmt_interest := cur.pmt_interest;
      l_gpk_rec.pmt_total    := cur.pmt_total;
      l_gpk_rec.pmt_out_bal  := cur.pmt_out_bal;

      pipe row(l_gpk_rec);
    end loop;

    return;
  end get_gpk;

  -- ��������� ������� �� % ������
  function get_xirr(p_bid_id in wcs_bids.id%type -- ������������� ������
                    ) return number is
    l_deal_date date := to_date(wcs_utl.get_creditdata(p_bid_id,
                                                       'DEAL_DATE'));
    l_sum       number := to_number(wcs_utl.get_creditdata(p_bid_id,
                                                           'CREDIT_SUM'));
    l_irr       number := to_number(wcs_utl.get_creditdata(p_bid_id,
                                                           'INTEREST_RATE'));

    l_xirr number;
  begin
    -- ������
    insert into tmp_irr (n, s) values (1, -1 * l_sum);

    -- ���������
    insert into tmp_irr
      (n, s)
      select t.pmt_date - l_deal_date + 1 as n, t.pmt_total as s
        from table(wcs_utl.get_gpk(p_bid_id)) t;

    -- ������ ��. % ������
    l_xirr := round(xirr(l_irr) * 100, 2);

    return l_xirr;
  end get_xirr;

  -- ��������� �������������� ������ �������� ����������� � �������� (������� �� �������)
  function get_scorquest_subquestions(p_scoring_id  in wcs_scoring_questions.scoring_id%type, -- ������������� ����������� �����
                                      p_question_id in wcs_scoring_questions.question_id%type -- ������������� �������
                                      ) return t_scor_quest_table
    pipelined is
    l_array_idx varchar2(200) := p_scoring_id || ':' || p_question_id;
    l_cur_rec   t_scor_quest_rec;
    l_q_row     wcs_questions%rowtype;
  begin
    -- ���� ������ ��� �������� �� �������
    if (l_array_varchar2.exists(l_array_idx)) then
      return;
    else
      l_array_varchar2(l_array_idx) := l_array_idx;
    end if;

    l_cur_rec.scoring_id  := p_scoring_id;
    l_cur_rec.question_id := p_question_id;
    pipe row(l_cur_rec);

    -- ������� ����������
    select * into l_q_row from wcs_questions q where q.id = p_question_id;
    if (l_q_row.is_calcable = 1) then
      for cur in (select *
                    from wcs_questions q
                   where regexp_like(l_q_row.calc_proc,
                                     ':#' || q.id || '[%#]')) loop
        for cur0 in (select *
                       from table(wcs_utl.get_scorquest_subquestions(p_scoring_id,
                                                                     cur.id))) loop
          l_cur_rec.scoring_id  := p_scoring_id;
          l_cur_rec.question_id := cur0.question_id;
          pipe row(l_cur_rec);
        end loop;
      end loop;
    end if;

    -- �������� ������������ ������� � �������� �� ������� �����������
    if (l_q_row.is_calcable = 1 and
       instr(upper(l_q_row.calc_proc), 'V_WCS_BID_GARANTEES') > 0) then
      for cur in (select *
                    from wcs_questions q
                   where id in ('GRT_3_4_0',
                                'GRT_3_1',
                                'GRT_4_0',
                                'GRT_2_1',
                                'GRT_2_13',
                                'GRT_2_16')) loop
        for cur0 in (select *
                       from table(get_scorquest_subquestions(p_scoring_id,
                                                             cur.id))) loop
          l_cur_rec.scoring_id  := p_scoring_id;
          l_cur_rec.question_id := cur0.question_id;
          pipe row(l_cur_rec);
        end loop;
      end loop;
    end if;

    -- ������� �� ���������� ���� �� ������
    for cur1 in (select *
                   from wcs_survey_group_questions sgq
                  where sgq.question_id = p_question_id
                    and sgq.dnshow_if is not null) loop
      for cur in (select *
                    from wcs_questions q
                   where regexp_like(cur1.dnshow_if, ':#' || q.id || '[%#]')) loop
        for cur0 in (select *
                       from table(get_scorquest_subquestions(p_scoring_id,
                                                             cur.id))) loop
          l_cur_rec.scoring_id  := p_scoring_id;
          l_cur_rec.question_id := cur0.question_id;
          pipe row(l_cur_rec);
        end loop;
      end loop;
    end loop;

    return;
  end get_scorquest_subquestions;

  -- ��������� �������������� ������ �������� ����������� � ��������
  function get_scorings_subquestions return t_scor_quest_table
    pipelined is
    l_cur_rec t_scor_quest_rec;
  begin
    -- �������� ����� ����������� �� ����������
    l_array_varchar2.delete();

    for cur in (select * from wcs_scoring_questions sq) loop
      for cur0 in (select *
                     from table(get_scorquest_subquestions(cur.scoring_id,
                                                           cur.question_id))) loop
        l_cur_rec.scoring_id  := cur.scoring_id;
        l_cur_rec.question_id := cur0.question_id;
        pipe row(l_cur_rec);
      end loop;
    end loop;

    -- �������� ����� ����������� ����� ����������
    l_array_varchar2.delete();

    return;
  end get_scorings_subquestions;

  -- ���������� ������ � ������ ��� ��� (��� ��������������� ������ ���������� ������ ������� ������� ��������� � ��������)
  function show_in_survey(p_bid_id      in number, -- ������������� ������
                          p_question_id in varchar2 -- ������������� �������
                          ) return number is
    l_res    number;
    l_bs_row wcs_bid_states%rowtype;
    l_ss_row wcs_subproduct_scoring%rowtype;
    l_q_row  wcs_questions%rowtype;
  begin
    -- ��������� ��� ������ � ��������� ������������
    select *
      into l_bs_row
      from wcs_bid_states bs
     where bs.bid_id = p_bid_id
       and bs.state_id = 'NEW_PRESCORING';

    -- ��������� ��� ������ "������������"
    select *
      into l_q_row
      from wcs_questions q
     where q.id = p_question_id
       and q.type_id != 'SECTION';

    -- ����� �� ���� ����� ������
    select ss.*
      into l_ss_row
      from wcs_bids b, wcs_subproduct_scoring ss
     where b.id = p_bid_id
       and b.subproduct_id = ss.subproduct_id
       and rownum = 1;

    -- ��������� ������ �� � ������� ��������
    execute immediate 'select decode(count(*), 0, 0, 1)
      from mv_wcs_scoring_subquestions ssq
     where ssq.scoring_id = :1
       and ssq.question_id = :2'
      into l_res
      using l_ss_row.scoring_id, p_question_id;

    return l_res;
  exception
    when no_data_found then
      return 1;
  end show_in_survey;

  -- ��������� ������� ����������� ������ �� ������
  function get_bid_phases_times(p_bid_id wcs_bids.id%type -- ������������� �����
                                ) return t_phases_tlims_table
    pipelined is

    l_ptl_rec t_phases_tlims_rec;

    procedure get_state_times(p_bid_id       in wcs_bid_states.bid_id%type, -- ������������� �����
                              p_state_id     in wcs_bid_states.state_id%type, -- ������������� ���������
                              p_state_start  out date, -- ���� ������ �����
                              p_state_end    out date, -- ���� ��������� �����
                              p_proc_start   out date, -- ���� ������ ��������� �����
                              p_proc_end     out date, -- ���� ��������� ��������� �����
                              p_proc_user_id out number -- �� ������������ ��������������� ������
                              ) is
    begin
      select min(change_dat)
        into p_state_start
        from (select *
                from wcs_bid_states_history bsh
               where bsh.bid_id = p_bid_id
                 and bsh.state_id = p_state_id
                 and bsh.change_action in ('SET', 'SET_IMMEDIATE')
               order by bsh.id)
       where rownum = 1;

      select min(change_dat)
        into p_state_end
        from (select *
                from wcs_bid_states_history bsh
               where bsh.bid_id = p_bid_id
                 and bsh.state_id = p_state_id
                 and bsh.change_action in ('DELETE')
               order by bsh.id desc)
       where rownum = 1;

      select min(change_dat), min(checkout_user_id)
        into p_proc_start, p_proc_user_id
        from (select *
                from wcs_bid_states_history bsh
               where bsh.bid_id = p_bid_id
                 and bsh.state_id = p_state_id
                 and bsh.change_action in ('CHECK_OUT')
               order by bsh.id)
       where rownum = 1;

      select min(change_dat)
        into p_proc_end
        from (select *
                from wcs_bid_states_history bsh
               where bsh.bid_id = p_bid_id
                 and bsh.state_id = p_state_id
                 and bsh.change_action in ('CHECK_IN')
               order by bsh.id desc)
       where rownum = 1;
    end get_state_times;
  begin
    l_ptl_rec.bid_id := p_bid_id;

    -- KM_DATAINPUNT ��� ����� ��������� ����������
    l_ptl_rec.phase_id := 'KM_DATAINPUNT';
    get_state_times(p_bid_id,
                    'NEW_DATAINPUT',
                    l_ptl_rec.phase_start,
                    l_ptl_rec.phase_end,
                    l_ptl_rec.proc_start,
                    l_ptl_rec.proc_end,
                    l_ptl_rec.proc_user_id);
    if (l_ptl_rec.phase_start is not null) then
      pipe row(l_ptl_rec);
    end if;

    -- KM_SIGNDOCS ϳ�������� ��������� ����������
    l_ptl_rec.phase_id := 'KM_SIGNDOCS';
    get_state_times(p_bid_id,
                    'NEW_SIGNDOCS',
                    l_ptl_rec.phase_start,
                    l_ptl_rec.phase_end,
                    l_ptl_rec.proc_start,
                    l_ptl_rec.proc_end,
                    l_ptl_rec.proc_user_id);
    if (l_ptl_rec.phase_start is not null) then
      pipe row(l_ptl_rec);
    end if;

    -- �S_TOBO_PROC ������� ������ ��������� ������� (����)
    l_ptl_rec.phase_id := '�S_TOBO_PROC';
    get_state_times(p_bid_id,
                    'NEW_CREDIT_S_PRC',
                    l_ptl_rec.phase_start,
                    l_ptl_rec.phase_end,
                    l_ptl_rec.proc_start,
                    l_ptl_rec.proc_end,
                    l_ptl_rec.proc_user_id);
    if (l_ptl_rec.phase_start is not null) then
      pipe row(l_ptl_rec);
    end if;

    -- SS_TOBO_PROC ������� ������ ������� ������� (����)
    l_ptl_rec.phase_id := 'SS_TOBO_PROC';
    get_state_times(p_bid_id,
                    'NEW_SECURITY_S_PRC',
                    l_ptl_rec.phase_start,
                    l_ptl_rec.phase_end,
                    l_ptl_rec.proc_start,
                    l_ptl_rec.proc_end,
                    l_ptl_rec.proc_user_id);
    if (l_ptl_rec.phase_start is not null) then
      pipe row(l_ptl_rec);
    end if;

    -- LS_TOBO_PROC ������� ������ ��������� ������� (����)
    l_ptl_rec.phase_id := 'LS_TOBO_PROC';
    get_state_times(p_bid_id,
                    'NEW_LAW_S_PRC',
                    l_ptl_rec.phase_start,
                    l_ptl_rec.phase_end,
                    l_ptl_rec.proc_start,
                    l_ptl_rec.proc_end,
                    l_ptl_rec.proc_user_id);
    if (l_ptl_rec.phase_start is not null) then
      pipe row(l_ptl_rec);
    end if;

    -- AS_TOBO_PROC ������� ������ ������� �� ���������� ������� (����)
    l_ptl_rec.phase_id := 'AS_TOBO_PROC';
    get_state_times(p_bid_id,
                    'NEW_PROBLEMACTIVE_S_PRC',
                    l_ptl_rec.phase_start,
                    l_ptl_rec.phase_end,
                    l_ptl_rec.proc_start,
                    l_ptl_rec.proc_end,
                    l_ptl_rec.proc_user_id);
    if (l_ptl_rec.phase_start is not null) then
      pipe row(l_ptl_rec);
    end if;

    -- CC_TOBO_PROC ������� ������ ���������� ���������� ������� (����)
    l_ptl_rec.phase_id := 'CC_TOBO_PROC';
    get_state_times(p_bid_id,
                    'NEW_SECRETARYCC',
                    l_ptl_rec.phase_start,
                    l_ptl_rec.phase_end,
                    l_ptl_rec.proc_start,
                    l_ptl_rec.proc_end,
                    l_ptl_rec.proc_user_id);
    if (l_ptl_rec.phase_start is not null) then
      pipe row(l_ptl_rec);
    end if;

    -- �S_RU_PROC ������� ������ ��������� ������� (��)
    l_ptl_rec.phase_id := '�S_RU_PROC';
    get_state_times(p_bid_id,
                    'NEW_RU_CREDIT_S_PRC',
                    l_ptl_rec.phase_start,
                    l_ptl_rec.phase_end,
                    l_ptl_rec.proc_start,
                    l_ptl_rec.proc_end,
                    l_ptl_rec.proc_user_id);
    if (l_ptl_rec.phase_start is not null) then
      pipe row(l_ptl_rec);
    end if;

    -- SS_RU_PROC ������� ������ ������� ������� (��)
    l_ptl_rec.phase_id := 'SS_RU_PROC';
    get_state_times(p_bid_id,
                    'NEW_RU_SECURITY_S_PRC',
                    l_ptl_rec.phase_start,
                    l_ptl_rec.phase_end,
                    l_ptl_rec.proc_start,
                    l_ptl_rec.proc_end,
                    l_ptl_rec.proc_user_id);
    if (l_ptl_rec.phase_start is not null) then
      pipe row(l_ptl_rec);
    end if;

    -- LS_RU_PROC ������� ������ ��������� ������� (��)
    l_ptl_rec.phase_id := 'LS_RU_PROC';
    get_state_times(p_bid_id,
                    'NEW_RU_LAW_S_PRC',
                    l_ptl_rec.phase_start,
                    l_ptl_rec.phase_end,
                    l_ptl_rec.proc_start,
                    l_ptl_rec.proc_end,
                    l_ptl_rec.proc_user_id);
    if (l_ptl_rec.phase_start is not null) then
      pipe row(l_ptl_rec);
    end if;

    -- AS_RU_PROC ������� ������ ������� �� ���������� ������� (��)
    l_ptl_rec.phase_id := 'AS_RU_PROC';
    get_state_times(p_bid_id,
                    'NEW_RU_PROBLEMACTIVE_S_PRC',
                    l_ptl_rec.phase_start,
                    l_ptl_rec.phase_end,
                    l_ptl_rec.proc_start,
                    l_ptl_rec.proc_end,
                    l_ptl_rec.proc_user_id);
    if (l_ptl_rec.phase_start is not null) then
      pipe row(l_ptl_rec);
    end if;

    -- CC_RU_PROC ������� ������ ���������� ���������� ������� (��)
    l_ptl_rec.phase_id := 'CC_RU_PROC';
    get_state_times(p_bid_id,
                    'NEW_RU_SECRETARYCC',
                    l_ptl_rec.phase_start,
                    l_ptl_rec.phase_end,
                    l_ptl_rec.proc_start,
                    l_ptl_rec.proc_end,
                    l_ptl_rec.proc_user_id);
    if (l_ptl_rec.phase_start is not null) then
      pipe row(l_ptl_rec);
    end if;

    -- �S_CA_PROC ������� ������ ��������� ������� (��)
    l_ptl_rec.phase_id := '�S_CA_PROC';
    get_state_times(p_bid_id,
                    'NEW_CA_CREDIT_S_PRC',
                    l_ptl_rec.phase_start,
                    l_ptl_rec.phase_end,
                    l_ptl_rec.proc_start,
                    l_ptl_rec.proc_end,
                    l_ptl_rec.proc_user_id);
    if (l_ptl_rec.phase_start is not null) then
      pipe row(l_ptl_rec);
    end if;

    -- SS_CA_PROC ������� ������ ������� ������� (��)
    l_ptl_rec.phase_id := 'SS_CA_PROC';
    get_state_times(p_bid_id,
                    'NEW_CA_SECURITY_S_PRC',
                    l_ptl_rec.phase_start,
                    l_ptl_rec.phase_end,
                    l_ptl_rec.proc_start,
                    l_ptl_rec.proc_end,
                    l_ptl_rec.proc_user_id);
    if (l_ptl_rec.phase_start is not null) then
      pipe row(l_ptl_rec);
    end if;

    -- LS_CA_PROC ������� ������ ��������� ������� (��)
    l_ptl_rec.phase_id := 'LS_CA_PROC';
    get_state_times(p_bid_id,
                    'NEW_CA_LAW_S_PRC',
                    l_ptl_rec.phase_start,
                    l_ptl_rec.phase_end,
                    l_ptl_rec.proc_start,
                    l_ptl_rec.proc_end,
                    l_ptl_rec.proc_user_id);
    if (l_ptl_rec.phase_start is not null) then
      pipe row(l_ptl_rec);
    end if;

    -- AS_CA_PROC ������� ������ ������� �� ���������� ������� (��)
    l_ptl_rec.phase_id := 'AS_CA_PROC';
    get_state_times(p_bid_id,
                    'NEW_CA_PROBLEMACTIVE_S_PRC',
                    l_ptl_rec.phase_start,
                    l_ptl_rec.phase_end,
                    l_ptl_rec.proc_start,
                    l_ptl_rec.proc_end,
                    l_ptl_rec.proc_user_id);
    if (l_ptl_rec.phase_start is not null) then
      pipe row(l_ptl_rec);
    end if;

    -- RD_CA_PROC ������� ������ ������������� ������ (��)
    l_ptl_rec.phase_id := 'RD_CA_PROC';
    get_state_times(p_bid_id,
                    'NEW_CA_RISK_S_PRC',
                    l_ptl_rec.phase_start,
                    l_ptl_rec.phase_end,
                    l_ptl_rec.proc_start,
                    l_ptl_rec.proc_end,
                    l_ptl_rec.proc_user_id);
    if (l_ptl_rec.phase_start is not null) then
      pipe row(l_ptl_rec);
    end if;

    -- FD_CA_PROC ������� ������ ���������-���������� ������������� (��)
    l_ptl_rec.phase_id := 'FD_CA_PROC';
    get_state_times(p_bid_id,
                    'NEW_CA_FINANCE_S_PRC',
                    l_ptl_rec.phase_start,
                    l_ptl_rec.phase_end,
                    l_ptl_rec.proc_start,
                    l_ptl_rec.proc_end,
                    l_ptl_rec.proc_user_id);
    if (l_ptl_rec.phase_start is not null) then
      pipe row(l_ptl_rec);
    end if;

    -- CC_CA_PROC ������� ������ ���������� ���������� ������� (��)
    l_ptl_rec.phase_id := 'CC_CA_PROC';
    get_state_times(p_bid_id,
                    'NEW_CA_SECRETARYCC',
                    l_ptl_rec.phase_start,
                    l_ptl_rec.phase_end,
                    l_ptl_rec.proc_start,
                    l_ptl_rec.proc_end,
                    l_ptl_rec.proc_user_id);
    if (l_ptl_rec.phase_start is not null) then
      pipe row(l_ptl_rec);
    end if;

    -- VISA ³�������
    l_ptl_rec.phase_id := 'VISA';
    get_state_times(p_bid_id,
                    'NEW_VISA',
                    l_ptl_rec.phase_start,
                    l_ptl_rec.phase_end,
                    l_ptl_rec.proc_start,
                    l_ptl_rec.proc_end,
                    l_ptl_rec.proc_user_id);
    if (l_ptl_rec.phase_start is not null) then
      pipe row(l_ptl_rec);
    end if;

  end get_bid_phases_times;

  -- ������� ������ ���������������� �������� ��������� ������ 2� ������
  procedure clear_prescoring_bids is
  begin
    for cur in (select distinct b.id
                  from wcs_bids b, wcs_bid_states bs
                 where b.id = bs.bid_id
                   and b.crt_date < sysdate - 14
                   and bs.state_id in
                       ('NEW_SBP_SELECTING', 'NEW_PRESCORING')) loop
      wcs_pack.bid_del(cur.id);
    end loop;
  end clear_prescoring_bids;

  -- ��������� �������� ������������ �������
  function get_answers_diff(p_bid_id    wcs_answers_history.bid_id%type, -- ������������� ������
                            p_date_from wcs_answers_history.action_date%type, -- ���� ��
                            p_date_to   wcs_answers_history.action_date%type -- ���� ��
                            ) return varchar2 is
    l_res varchar2(4000);
  begin
    for cur in (select t.ws_id,
                       w.name        as ws_name,
                       t.ws_number,
                       t.question_id,
                       q.name        as question_name,
                       t.val_old,
                       t.val_new
                  from (select ws_id,
                               ws_number,
                               question_id,
                               max(first_value) as val_old,
                               max(last_value) as val_new
                          from (select ah.ws_id,
                                       ah.ws_number,
                                       ah.question_id,
                                       first_value(ah.val_old) over(partition by ah.ws_id, ah.ws_number, ah.question_id order by ah.id) as first_value,
                                       first_value(ah.val_new) over(partition by ah.ws_id, ah.ws_number, ah.question_id order by ah.id desc) as last_value
                                  from wcs_answers_history ah
                                 where ah.bid_id = p_bid_id
                                   and ah.action_date between p_date_from and
                                       p_date_to
                                 order by ah.id)
                         group by ws_id, ws_number, question_id) t,
                       wcs_workspaces w,
                       wcs_questions q
                 where t.ws_id = w.id
                   and t.question_id = q.id) loop
      l_res := substr(l_res || cur.question_name || ' (' || cur.question_id ||
                      '): "' || cur.val_old || '" �� "' || cur.val_new ||
                      '"; ',
                      0,
                      3999);
    end loop;
    return l_res;
  end get_answers_diff;

  -- ������������ ����/���� ��� ���������� ���� ������� ����� "����������� ������/������� �������/������� � �������/�������� ��`�?"
  procedure register_spouse_as_guarantor(p_bid_id wcs_bids.id%type -- ������������� ������
                                         ) is
    -- ����������� ������/������� �������/������� � �������/�������� ��`�?
    l_cl_34_1 number := wcs_utl.get_answ_bool(p_bid_id, 'CL_34_1');
    -- �����. ��� �������/�������
    l_cl_0_178 varchar2(10) := wcs_utl.get_answ_text(p_bid_id, 'CL_0_178');

    -- ������� ������������ ����������
    l_ws_id     wcs_answers.ws_id%type;
    l_ws_number wcs_answers.ws_number%type;
  begin
    -- ������� ������� ����� "����������� ������/������� �������/������� � �������/�������� ��`�?"
    if (nvl(l_cl_34_1, 0) = 0) then
      return;
    end if;

    -- ������� ���������������� �� ���/���� ��� ����������
    begin
      select bg.ws_id, bg.garantee_num
        into l_ws_id, l_ws_number
        from v_wcs_bid_garantees bg
       where bg.bid_id = p_bid_id
         and bg.garantee_id = 'GUARANTOR'
         and wcs_utl.get_answ_text(bg.bid_id,
                                   'CODE_002',
                                   bg.ws_id,
                                   bg.garantee_num) = l_cl_0_178;
    exception
      when no_data_found then
        wcs_pack.bid_garantee_set(p_bid_id, 'GUARANTOR');

        select max(bg.ws_id), max(bg.garantee_num)
          into l_ws_id, l_ws_number
          from v_wcs_bid_garantees bg
         where bg.bid_id = p_bid_id
           and bg.garantee_id = 'GUARANTOR';
    end;

    -- ������������� ������
    wcs_pack.answ_text_set(p_bid_id,
                           'CL_1',
                           fio(wcs_utl.get_answ_text(p_bid_id, 'CL_0_176'),
                               1),
                           l_ws_id,
                           l_ws_number); -- �������
    wcs_pack.answ_text_set(p_bid_id,
                           'CL_2',
                           fio(wcs_utl.get_answ_text(p_bid_id, 'CL_0_176'),
                               2),
                           l_ws_id,
                           l_ws_number); -- ��`�
    wcs_pack.answ_text_set(p_bid_id,
                           'CL_3',
                           fio(wcs_utl.get_answ_text(p_bid_id, 'CL_0_176'),
                               3),
                           l_ws_id,
                           l_ws_number); -- �� �������
    wcs_pack.answ_text_set(p_bid_id,
                           'CL_123_R',
                           wcs_utl.get_answ_text(p_bid_id, 'CL_0_176_1'),
                           l_ws_id,
                           l_ws_number); -- ϲ� �������/������� � �������� ������
    wcs_pack.answ_text_set(p_bid_id,
                           'CL_123_O',
                           wcs_utl.get_answ_text(p_bid_id, 'CL_0_176_2'),
                           l_ws_id,
                           l_ws_number); -- ϲ� �������/������� � �������� ������
    wcs_pack.answ_dat_set(p_bid_id,
                          'CL_4',
                          wcs_utl.get_answ_date(p_bid_id, 'CL_0_177'),
                          l_ws_id,
                          l_ws_number); -- ���� ����������
    wcs_pack.answ_text_set(p_bid_id,
                           'CODE_002',
                           wcs_utl.get_answ_text(p_bid_id, 'CL_0_178'),
                           l_ws_id,
                           l_ws_number); -- ���������������� ��� �볺���
    wcs_pack.answ_text_set(p_bid_id,
                           'CL_7',
                           wcs_utl.get_answ_text(p_bid_id, 'CL_0_179'),
                           l_ws_id,
                           l_ws_number); -- ���� ��������
    wcs_pack.answ_text_set(p_bid_id,
                           'CL_8',
                           wcs_utl.get_answ_text(p_bid_id, 'CL_0_179_1'),
                           l_ws_id,
                           l_ws_number); -- ����� ��������
    wcs_pack.answ_text_set(p_bid_id,
                           'CL_9',
                           wcs_utl.get_answ_text(p_bid_id, 'CL_0_180'),
                           l_ws_id,
                           l_ws_number); -- ��� �� �� ������� �������
    wcs_pack.answ_dat_set(p_bid_id,
                          'CL_11',
                          wcs_utl.get_answ_date(p_bid_id, 'CL_0_181'),
                          l_ws_id,
                          l_ws_number); -- ���� ������ ��������

    wcs_pack.answ_list_set(p_bid_id,
                           'CL_34',
                           wcs_utl.get_answ_list(p_bid_id, 'CL_34'),
                           l_ws_id,
                           l_ws_number); -- ѳ������ ����
    wcs_pack.answ_text_set(p_bid_id,
                           'CL_0_176',
                           wcs_utl.get_answ_text(p_bid_id, 'CL_1') || ' ' ||
                           wcs_utl.get_answ_text(p_bid_id, 'CL_2') || ' ' ||
                           wcs_utl.get_answ_text(p_bid_id, 'CL_3'),
                           l_ws_id,
                           l_ws_number); -- ϲ� �������/�������
    wcs_pack.answ_text_set(p_bid_id,
                           'CL_0_176_1',
                           wcs_utl.get_answ_text(p_bid_id, 'CL_123_R'),
                           l_ws_id,
                           l_ws_number); -- ϲ� �������/������� � �������� ������
    wcs_pack.answ_text_set(p_bid_id,
                           'CL_0_176_2',
                           wcs_utl.get_answ_text(p_bid_id, 'CL_123_O'),
                           l_ws_id,
                           l_ws_number); -- ϲ� �������/������� � �������� ������
    wcs_pack.answ_dat_set(p_bid_id,
                          'CL_0_177',
                          wcs_utl.get_answ_date(p_bid_id, 'CL_4'),
                          l_ws_id,
                          l_ws_number); -- ���� ���������� �������/�������
    wcs_pack.answ_text_set(p_bid_id,
                           'CL_0_178',
                           wcs_utl.get_answ_text(p_bid_id, 'CODE_002'),
                           l_ws_id,
                           l_ws_number); -- �����. ��� �������/�������
    wcs_pack.answ_text_set(p_bid_id,
                           'CL_0_179',
                           wcs_utl.get_answ_text(p_bid_id, 'CL_7'),
                           l_ws_id,
                           l_ws_number); -- ���� �������� �������/�������
    wcs_pack.answ_text_set(p_bid_id,
                           'CL_0_179_1',
                           wcs_utl.get_answ_text(p_bid_id, 'CL_8'),
                           l_ws_id,
                           l_ws_number); -- ����� �������� �������/�������
    wcs_pack.answ_text_set(p_bid_id,
                           'CL_0_180',
                           wcs_utl.get_answ_text(p_bid_id, 'CL_9'),
                           l_ws_id,
                           l_ws_number); -- ��� �� �� ������ ������� �������/�������
    wcs_pack.answ_dat_set(p_bid_id,
                          'CL_0_181',
                          wcs_utl.get_answ_date(p_bid_id, 'CL_11'),
                          l_ws_id,
                          l_ws_number); -- ���� ������ �������� �������/�������

    wcs_pack.answ_dec_set(p_bid_id,
                          'CL_0_70',
                          wcs_utl.get_answ_decimal(p_bid_id, 'CL_0_79'),
                          l_ws_id,
                          l_ws_number); -- ������� �������� ����� (���.)
    wcs_pack.answ_dec_set(p_bid_id,
                          'CL_0_71',
                          wcs_utl.get_answ_decimal(p_bid_id, 'CL_0_80'),
                          l_ws_id,
                          l_ws_number); -- ��������� �������� ����� (��������� �� �����������) (���.)
    wcs_pack.answ_dec_set(p_bid_id,
                          'CL_0_72',
                          wcs_utl.get_answ_decimal(p_bid_id, 'CL_0_81'),
                          l_ws_id,
                          l_ws_number); -- �������� �� ������ ��/��� ������ ������ (���.)
    wcs_pack.answ_dec_set(p_bid_id,
                          'CL_0_73',
                          wcs_utl.get_answ_decimal(p_bid_id, 'CL_0_82'),
                          l_ws_id,
                          l_ws_number); -- ������ �� ����� ����� � ������ (���.)
    wcs_pack.answ_list_set(p_bid_id,
                           'CL_0_74',
                           wcs_utl.get_answ_list(p_bid_id, 'CL_0_83'),
                           l_ws_id,
                           l_ws_number); -- �����
    wcs_pack.answ_dec_set(p_bid_id,
                          'CL_0_75',
                          wcs_utl.get_answ_decimal(p_bid_id, 'CL_0_84'),
                          l_ws_id,
                          l_ws_number); -- ����� ���� (���.)
    wcs_pack.answ_list_set(p_bid_id,
                           'CL_0_76',
                           wcs_utl.get_answ_list(p_bid_id, 'CL_0_85'),
                           l_ws_id,
                           l_ws_number); -- ���� ������
    wcs_pack.answ_text_set(p_bid_id,
                           'CL_0_77',
                           wcs_utl.get_answ_text(p_bid_id, 'CL_0_86'),
                           l_ws_id,
                           l_ws_number); -- ������� ����� ������
    wcs_pack.answ_dec_set(p_bid_id,
                          'CL_0_78',
                          wcs_utl.get_answ_decimal(p_bid_id, 'CL_0_87'),
                          l_ws_id,
                          l_ws_number); -- ����� ����� ������ (���.)
    wcs_pack.answ_bool_set(p_bid_id,
                           'CL_0_148',
                           wcs_utl.get_answ_bool(p_bid_id, 'CL_0_148_2'),
                           l_ws_id,
                           l_ws_number); -- �볺�� ���?

    wcs_pack.answ_ref_set(p_bid_id,
                          'CL_0_149_1',
                          wcs_utl.get_answ_refer(p_bid_id, 'CL_0_149_2'),
                          l_ws_id,
                          l_ws_number); -- ��� ������������ �������� �1
    wcs_pack.answ_dec_set(p_bid_id,
                          'CL_0_150_1',
                          wcs_utl.get_answ_decimal(p_bid_id, 'CL_0_150_2'),
                          l_ws_id,
                          l_ws_number); -- �������������� ������� �� ��������� (����� ������)
    wcs_pack.answ_dec_set(p_bid_id,
                          'CL_0_151_1',
                          wcs_utl.get_answ_decimal(p_bid_id, 'CL_0_151_2'),
                          l_ws_id,
                          l_ws_number); -- ������������� ������� �� ������ ������������

    wcs_pack.answ_ref_set(p_bid_id,
                          'CL_0_149_12',
                          wcs_utl.get_answ_refer(p_bid_id, 'CL_0_149_22'),
                          l_ws_id,
                          l_ws_number); -- ��� ������������ �������� �2
    wcs_pack.answ_dec_set(p_bid_id,
                          'CL_0_150_12',
                          wcs_utl.get_answ_decimal(p_bid_id, 'CL_0_150_22'),
                          l_ws_id,
                          l_ws_number); -- �������������� ������� �� ��������� (����� ������)
    wcs_pack.answ_dec_set(p_bid_id,
                          'CL_0_151_12',
                          wcs_utl.get_answ_decimal(p_bid_id, 'CL_0_151_22'),
                          l_ws_id,
                          l_ws_number); -- ������������� ������� �� ������ ������������

    wcs_pack.answ_ref_set(p_bid_id,
                          'CL_0_149_13',
                          wcs_utl.get_answ_refer(p_bid_id, 'CL_0_149_23'),
                          l_ws_id,
                          l_ws_number); -- ��� ������������ �������� �3
    wcs_pack.answ_dec_set(p_bid_id,
                          'CL_0_150_13',
                          wcs_utl.get_answ_decimal(p_bid_id, 'CL_0_150_23'),
                          l_ws_id,
                          l_ws_number); -- �������������� ������� �� ��������� (����� ������)
    wcs_pack.answ_dec_set(p_bid_id,
                          'CL_0_151_13',
                          wcs_utl.get_answ_decimal(p_bid_id, 'CL_0_151_23'),
                          l_ws_id,
                          l_ws_number); -- ������������� ������� �� ������ ������������

    wcs_pack.answ_ref_set(p_bid_id,
                          'CL_0_149_14',
                          wcs_utl.get_answ_refer(p_bid_id, 'CL_0_149_24'),
                          l_ws_id,
                          l_ws_number); -- ��� ������������ �������� �4
    wcs_pack.answ_dec_set(p_bid_id,
                          'CL_0_150_14',
                          wcs_utl.get_answ_decimal(p_bid_id, 'CL_0_150_24'),
                          l_ws_id,
                          l_ws_number); -- �������������� ������� �� ��������� (����� ������)
    wcs_pack.answ_dec_set(p_bid_id,
                          'CL_0_151_14',
                          wcs_utl.get_answ_decimal(p_bid_id, 'CL_0_151_24'),
                          l_ws_id,
                          l_ws_number); -- ������������� ������� �� ������ ������������

    wcs_pack.answ_ref_set(p_bid_id,
                          'CL_0_149_15',
                          wcs_utl.get_answ_refer(p_bid_id, 'CL_0_149_25'),
                          l_ws_id,
                          l_ws_number); -- ��� ������������ �������� �5
    wcs_pack.answ_dec_set(p_bid_id,
                          'CL_0_150_15',
                          wcs_utl.get_answ_decimal(p_bid_id, 'CL_0_150_25'),
                          l_ws_id,
                          l_ws_number); -- �������������� ������� �� ��������� (����� ������)
    wcs_pack.answ_dec_set(p_bid_id,
                          'CL_0_151_15',
                          wcs_utl.get_answ_decimal(p_bid_id, 'CL_0_151_25'),
                          l_ws_id,
                          l_ws_number); -- ������������� ������� �� ������ ������������

    wcs_pack.answ_ref_set(p_bid_id,
                          'CL_0_149_16',
                          wcs_utl.get_answ_refer(p_bid_id, 'CL_0_149_26'),
                          l_ws_id,
                          l_ws_number); -- ��� ������������ �������� �6
    wcs_pack.answ_dec_set(p_bid_id,
                          'CL_0_150_16',
                          wcs_utl.get_answ_decimal(p_bid_id, 'CL_0_150_26'),
                          l_ws_id,
                          l_ws_number); -- �������������� ������� �� ��������� (����� ������)
    wcs_pack.answ_dec_set(p_bid_id,
                          'CL_0_151_16',
                          wcs_utl.get_answ_decimal(p_bid_id, 'CL_0_151_26'),
                          l_ws_id,
                          l_ws_number); -- ������������� ������� �� ������ ������������

    wcs_pack.answ_ref_set(p_bid_id,
                          'CL_0_149_17',
                          wcs_utl.get_answ_refer(p_bid_id, 'CL_0_149_27'),
                          l_ws_id,
                          l_ws_number); -- ��� ������������ �������� �7
    wcs_pack.answ_dec_set(p_bid_id,
                          'CL_0_150_17',
                          wcs_utl.get_answ_decimal(p_bid_id, 'CL_0_150_27'),
                          l_ws_id,
                          l_ws_number); -- �������������� ������� �� ��������� (����� ������)
    wcs_pack.answ_dec_set(p_bid_id,
                          'CL_0_151_17',
                          wcs_utl.get_answ_decimal(p_bid_id, 'CL_0_151_27'),
                          l_ws_id,
                          l_ws_number); -- ������������� ������� �� ������ ������������

    wcs_pack.answ_dec_set(p_bid_id,
                          'CL_0_89',
                          wcs_utl.get_answ_decimal(p_bid_id, 'CL_0_95'),
                          l_ws_id,
                          l_ws_number); -- �������� ������ (���.)
    wcs_pack.answ_dec_set(p_bid_id,
                          'CL_0_90',
                          wcs_utl.get_answ_decimal(p_bid_id, 'CL_0_96'),
                          l_ws_id,
                          l_ws_number); -- ����������, ��������� ������ (���.)
    wcs_pack.answ_dec_set(p_bid_id,
                          'CL_0_91',
                          wcs_utl.get_answ_decimal(p_bid_id, 'CL_0_97'),
                          l_ws_id,
                          l_ws_number); -- ������ ����� (���.)
    wcs_pack.answ_dec_set(p_bid_id,
                          'CL_0_92',
                          wcs_utl.get_answ_decimal(p_bid_id, 'CL_0_98'),
                          l_ws_id,
                          l_ws_number); -- ������� (���.)
    wcs_pack.answ_dec_set(p_bid_id,
                          'CL_0_93',
                          wcs_utl.get_answ_decimal(p_bid_id, 'CL_0_99'),
                          l_ws_id,
                          l_ws_number); -- ������� �� ����� ��������� �������� (���.)
    wcs_pack.answ_dec_set(p_bid_id,
                          'CL_0_93_1',
                          wcs_utl.get_answ_decimal(p_bid_id, 'CL_0_99_1'),
                          l_ws_id,
                          l_ws_number); -- ������� ����������� (���.)
    wcs_pack.answ_dec_set(p_bid_id,
                          'CL_0_94',
                          wcs_utl.get_answ_decimal(p_bid_id, 'CL_0_100'),
                          l_ws_id,
                          l_ws_number); -- ���� ������� (���.)
  end register_spouse_as_guarantor;

  -- ������������� ������� ������ ����� �� ������ ����
  function bid_create_kacko_from_auto(p_bid_id wcs_bids.id%type -- ������������� ������
                                      ) return wcs_bids.id%type is
    l_product_id wcs_products.id%type;
    l_b_row      wcs_bids%rowtype;

    l_kacko_sbp_id wcs_subproducts.id%type;
    l_kacko_bid_id wcs_bids.id%type;
  begin
    select * into l_b_row from wcs_bids b where b.id = p_bid_id;
    select s.product_id
      into l_product_id
      from wcs_subproducts s
     where s.id = l_b_row.subproduct_id;

    -- ��������� ��� ������ �� �������� ����
    if (l_product_id != 'PRD_AUTO') then
      return null;
    end if;

    -- ��������� ���������� �� ����� �� ��������� "����� ���������"
    begin
      select s.id
        into l_kacko_sbp_id
        from wcs_subproducts s
       where s.product_id = 'PRD_HULL_INSURANCE'
         and wcs_utl.get_mac(p_bid_id, 'MAC_REPAYMENT_METHOD') =
             wcs_utl.get_sbp_mac(s.id,
                                 'MAC_REPAYMENT_METHOD',
                                 l_b_row.branch,
                                 l_b_row.crt_date)
         and rownum = 1;
    exception
      when no_data_found then
        select s.id
          into l_kacko_sbp_id
          from wcs_subproducts s
         where s.product_id = 'PRD_HULL_INSURANCE'
           and rownum = 1;
    end;

    -- ������� ������ �����
    l_kacko_bid_id := wcs_pack.bid_create(l_kacko_sbp_id,
                                          wcs_utl.get_answ_text(p_bid_id,
                                                                'CODE_002'),
                                          l_b_row.rnk);
    wcs_pack.bid_state_del(l_kacko_bid_id, 'NEW_START');
    wcs_pack.bid_state_set_immediate(l_kacko_bid_id,
                                     'NEW_DATAINPUT',
                                     '����������� ����������');

    -- === ������ ������� ===
    wcs_pack.bid_state_check_out(l_kacko_bid_id, 'NEW_CREDITDATA_DI', null);
    -- ������� �����
    wcs_pack.answ_numb_set(l_kacko_bid_id,
                           wcs_utl.get_creditdata_qid(l_kacko_bid_id,
                                                      'PROPERTY_COST'),
                           wcs_utl.get_creditdata(p_bid_id, 'PROPERTY_COST'));
    -- ���� �������
    wcs_pack.answ_numb_set(l_kacko_bid_id,
                           wcs_utl.get_creditdata_qid(l_kacko_bid_id,
                                                      'CREDIT_SUM'),
                           to_number(wcs_utl.get_creditdata(p_bid_id,
                                                            'PROPERTY_COST')) *
                           to_number(wcs_utl.get_mac(l_kacko_bid_id,
                                                     'MAC_KACKO_PERCENTAGE')) / 100);
    -- ����� ������� (��.)
    wcs_pack.answ_numb_set(l_kacko_bid_id,
                           wcs_utl.get_creditdata_qid(l_kacko_bid_id,
                                                      'CREDIT_TERM'),
                           wcs_utl.get_creditdata(p_bid_id, 'CREDIT_TERM'));
    wcs_pack.bid_state_check_in(l_kacko_bid_id,
                                'NEW_CREDITDATA_DI',
                                '����������� ����������');
    wcs_pack.bid_state_del(l_kacko_bid_id, 'NEW_CREDITDATA_DI');

    -- === ������������ ���������� ������� ===
    wcs_pack.bid_state_check_out(l_kacko_bid_id, 'NEW_SCANCOPY', null);

    for cur in (select *
                  from v_wcs_bid_scancopy_questions sq
                 where sq.bid_id = l_kacko_bid_id) loop
      wcs_pack.answ_file_set(cur.bid_id,
                             cur.question_id,
                             wcs_utl.get_answ_blob(p_bid_id,
                                                   cur.question_id),
                             lower(cur.question_id) || '.jpg');
    end loop;

    wcs_pack.bid_state_check_in(l_kacko_bid_id,
                                'NEW_SCANCOPY',
                                '����������� ����������');
    wcs_pack.bid_state_del(l_kacko_bid_id, 'NEW_SCANCOPY');

    -- === ����������� ===
    wcs_pack.bid_state_check_out(l_kacko_bid_id, 'NEW_AUTH', null);

    for cur in (select *
                  from v_wcs_bid_auths_quests aq
                 where aq.bid_id = l_kacko_bid_id) loop
      wcs_utl.set_answ(cur.bid_id,
                       cur.question_id,
                       wcs_utl.get_answ(p_bid_id, cur.question_id));
    end loop;
    -- ����� ������� �������� ������
    wcs_pack.answ_numb_set(l_kacko_bid_id, 'CL_MAIN_CRD_ID', p_bid_id);

    wcs_pack.bid_state_check_in(l_kacko_bid_id,
                                'NEW_AUTH',
                                '����������� ����������');
    wcs_pack.bid_state_del(l_kacko_bid_id, 'NEW_AUTH');

    -- === ������ ������� ===
    wcs_pack.bid_state_check_out(l_kacko_bid_id, 'NEW_SURVEY', null);

    for cur in (select *
                  from v_wcs_bid_survey_group_quests sgq
                 where sgq.bid_id = l_kacko_bid_id) loop
      wcs_utl.set_answ(cur.bid_id,
                       cur.question_id,
                       wcs_utl.get_answ(p_bid_id, cur.question_id));
    end loop;

    -- ������� ����������
    wcs_pack.answ_del(l_kacko_bid_id, 'CL_0_93_1');
    wcs_pack.answ_del(l_kacko_bid_id, 'CL_0_94');

    wcs_pack.bid_state_check_in(l_kacko_bid_id,
                                'NEW_SURVEY',
                                '����������� ����������');
    wcs_pack.bid_state_del(l_kacko_bid_id, 'NEW_SURVEY');

    -- === �������� ����������� ===
    wcs_pack.bid_state_check_out(l_kacko_bid_id, 'NEW_GUARANTEE', null);

    for cur in (select *
                  from v_wcs_bid_garantees bg
                 where bg.bid_id = p_bid_id
                   and bg.garantee_id in ('GUARANTOR', 'VEHICLE')
                 order by bg.garantee_id, bg.garantee_num) loop
      declare
        l_garantee_id  varchar2(100) := cur.garantee_id;
        l_garantee_num number;
      begin
        begin
          select bg.garantee_num
            into l_garantee_num
            from v_wcs_bid_garantees bg
           where bg.bid_id = l_kacko_bid_id
             and bg.garantee_id = l_garantee_id
             and bg.garantee_num = cur.garantee_num;
        exception
          when no_data_found then
            l_garantee_num := wcs_pack.bid_garantee_set_ext(l_kacko_bid_id,
                                                            l_garantee_id);
        end;

        wcs_pack.bid_garantee_status_set(l_kacko_bid_id,
                                         l_garantee_id,
                                         l_garantee_num,
                                         1);
        for cur0 in (select *
                       from v_wcs_bid_grt_scancopy_quests bgsq
                      where bgsq.bid_id = l_kacko_bid_id
                        and bgsq.garantee_id = l_garantee_id
                        and bgsq.garantee_num = l_garantee_num) loop
          wcs_pack.answ_file_set(l_kacko_bid_id,
                                 cur0.question_id,
                                 wcs_utl.get_answ_blob(cur.bid_id,
                                                       cur0.question_id,
                                                       cur.ws_id,
                                                       cur.garantee_num),
                                 lower(cur0.question_id) || '.jpg',
                                 cur.ws_id,
                                 cur0.garantee_num);
        end loop;
        wcs_pack.bid_garantee_status_set(l_kacko_bid_id,
                                         l_garantee_id,
                                         l_garantee_num,
                                         2);
        for cur0 in (select *
                       from v_wcs_bid_grt_sur_group_quests bgsgq
                      where bgsgq.bid_id = l_kacko_bid_id
                        and bgsgq.garantee_id = l_garantee_id
                        and bgsgq.garantee_num = l_garantee_num) loop
          wcs_utl.set_answ(l_kacko_bid_id,
                           cur0.question_id,
                           wcs_utl.get_answ(cur.bid_id,
                                            cur0.question_id,
                                            cur.ws_id,
                                            cur.garantee_num),
                           cur.ws_id,
                           cur0.garantee_num);
        end loop;
        -- ��� �������������� ������ ����� �������������� �� ����� ������� �����
        if (l_garantee_id = 'GUARANTOR') then
          wcs_utl.set_answ(l_kacko_bid_id,
                           'GRT_2_16',
                           wcs_utl.get_creditdata(l_kacko_bid_id,
                                                  'CREDIT_SUM'),
                           cur.ws_id,
                           l_garantee_num);
        end if;

        wcs_pack.bid_garantee_status_set(l_kacko_bid_id,
                                         l_garantee_id,
                                         l_garantee_num,
                                         3);
      end loop;
    end loop;

    wcs_pack.bid_state_check_in(l_kacko_bid_id,
                                'NEW_GUARANTEE',
                                '����������� ����������');
    wcs_pack.bid_state_del(l_kacko_bid_id, 'NEW_GUARANTEE');

    -- === ��������� ���������� ===
    wcs_pack.bid_state_check_out(l_kacko_bid_id, 'NEW_PARTNER', null);

    wcs_pack.answ_bool_set(l_kacko_bid_id, 'PI_CURACC_SELECTED', 1);

    wcs_pack.bid_state_check_in(l_kacko_bid_id,
                                'NEW_PARTNER',
                                '����������� ����������');
    wcs_pack.bid_state_del(l_kacko_bid_id, 'NEW_PARTNER');

    return l_kacko_bid_id;
  end bid_create_kacko_from_auto;

  -- ��������� ������ ������ �� ����� �� ������ �������� ������
  function get_kacko_bid_id(p_bid_id wcs_bids.id%type) return number is
    l_b_row        wcs_bids%rowtype;
    l_kacko_bid_id wcs_bids.id%type;
  begin
    select b.* into l_b_row from wcs_bids b where b.id = p_bid_id;

    select min(b.id)
      into l_kacko_bid_id
      from wcs_bids b
     where b.crt_date >= l_b_row.crt_date - 14
       and wcs_utl.get_answ_numb(b.id, 'CL_MAIN_CRD_ID') = l_b_row.id;

    return l_kacko_bid_id;
  end get_kacko_bid_id;

  -- �������������� ������ �� ������� ������������
  procedure prefill_from_customers(p_dest_bid_id    wcs_answers.bid_id%type, -- ������������� ������ ��� ����������
                                   p_dest_ws_id     wcs_answers.ws_id%type, -- ������������� �������� ������������ ��� ����������
                                   p_dest_ws_number wcs_answers.ws_number%type, -- ����� �������� ������������ ��� ����������
                                   p_src_rnk        customer.rnk%type -- ��� ��� ������
                                   ) is
    l_c_row customer%rowtype;
    l_p_row person%rowtype;
  begin
    begin
      -- ���� ������� �� ���
      select * into l_c_row from customer c where c.rnk = p_src_rnk;
      select * into l_p_row from person p where p.rnk = p_src_rnk;
    exception
      when no_data_found then
        return;
    end;

    -- ���
    wcs_utl.set_answ_ifempty(p_dest_bid_id,
                             'CL_1',
                             fio(l_c_row.nmk, 1),
                             p_dest_ws_id,
                             p_dest_ws_number);
    wcs_utl.set_answ_ifempty(p_dest_bid_id,
                             'CL_2',
                             fio(l_c_row.nmk, 2),
                             p_dest_ws_id,
                             p_dest_ws_number);
    wcs_utl.set_answ_ifempty(p_dest_bid_id,
                             'CL_3',
                             fio(l_c_row.nmk, 3),
                             p_dest_ws_id,
                             p_dest_ws_number);
    -- �����
    wcs_utl.set_answ_ifempty(p_dest_bid_id,
                             'CL_71',
                             l_p_row.sex,
                             p_dest_ws_id,
                             p_dest_ws_number);
    -- ���� ����������
    wcs_utl.set_answ_ifempty(p_dest_bid_id,
                             'CL_4',
                             l_p_row.bday,
                             p_dest_ws_id,
                             p_dest_ws_number);
    -- ̳��� ����������
    wcs_utl.set_answ_ifempty(p_dest_bid_id,
                             'CL_4_0',
                             l_p_row.bplace,
                             p_dest_ws_id,
                             p_dest_ws_number);
    -- ���������� �������
    wcs_utl.set_answ_ifempty(p_dest_bid_id,
                             'CL_199',
                             l_p_row.teld,
                             p_dest_ws_id,
                             p_dest_ws_number);

    -- ���������
    -- ���� ��������
    wcs_utl.set_answ_ifempty(p_dest_bid_id,
                             'CL_7',
                             l_p_row.ser,
                             p_dest_ws_id,
                             p_dest_ws_number);
    -- ����� ��������
    wcs_utl.set_answ_ifempty(p_dest_bid_id,
                             'CL_8',
                             l_p_row.numdoc,
                             p_dest_ws_id,
                             p_dest_ws_number);
    -- �����, �� ����� ������� (� ��)
    wcs_utl.set_answ_ifempty(p_dest_bid_id,
                             'CL_9',
                             l_p_row.organ,
                             p_dest_ws_id,
                             p_dest_ws_number);
    -- ���� ������ ��������
    wcs_utl.set_answ_ifempty(p_dest_bid_id,
                             'CL_11',
                             l_p_row.pdate,
                             p_dest_ws_id,
                             p_dest_ws_number);

    -- ������ ��������
    declare
      l_ca_reg_row customer_address%rowtype;
      l_cl_13      varchar2(100);
    begin
      select *
        into l_ca_reg_row
        from customer_address ca
       where ca.rnk = p_src_rnk
         and ca.type_id = 1;

      -- �������
      select min(so.c_reg)
        into l_cl_13
        from spr_obl so
       where upper(so.name_reg) = trim(upper(l_ca_reg_row.domain));
      wcs_utl.set_answ_ifempty(p_dest_bid_id,
                               'CL_18',
                               l_cl_13,
                               p_dest_ws_id,
                               p_dest_ws_number);
      -- �����
      wcs_utl.set_answ_ifempty(p_dest_bid_id,
                               'CL_19',
                               l_ca_reg_row.region,
                               p_dest_ws_id,
                               p_dest_ws_number);
      -- ̳���/��������� �����
      wcs_utl.set_answ_ifempty(p_dest_bid_id,
                               'CL_20',
                               l_ca_reg_row.locality,
                               p_dest_ws_id,
                               p_dest_ws_number);
      -- ������, ��, ��������
      wcs_utl.set_answ_ifempty(p_dest_bid_id,
                               'CL_21',
                               l_ca_reg_row.address,
                               p_dest_ws_id,
                               p_dest_ws_number);
      -- ������
      wcs_utl.set_answ_ifempty(p_dest_bid_id,
                               'CL_17',
                               l_ca_reg_row.zip,
                               p_dest_ws_id,
                               p_dest_ws_number);
    exception
      when no_data_found then
        wcs_utl.set_answ_ifempty(p_dest_bid_id,
                                 'CL_21',
                                 l_c_row.adr,
                                 p_dest_ws_id,
                                 p_dest_ws_number);
    end;

    -- ������ ��������
    declare
      l_ca_live_row customer_address%rowtype;
      l_cl_13       varchar2(100);
    begin
      select *
        into l_ca_live_row
        from customer_address ca
       where ca.rnk = p_src_rnk
         and ca.type_id = 2;

      -- �������
      select min(so.c_reg)
        into l_cl_13
        from spr_obl so
       where upper(so.name_reg) = trim(upper(l_ca_live_row.domain));
      wcs_utl.set_answ_ifempty(p_dest_bid_id,
                               'CL_13',
                               l_cl_13,
                               p_dest_ws_id,
                               p_dest_ws_number);
      -- �����
      wcs_utl.set_answ_ifempty(p_dest_bid_id,
                               'CL_14',
                               l_ca_live_row.region,
                               p_dest_ws_id,
                               p_dest_ws_number);
      -- ̳���/��������� �����
      wcs_utl.set_answ_ifempty(p_dest_bid_id,
                               'CL_15',
                               l_ca_live_row.locality,
                               p_dest_ws_id,
                               p_dest_ws_number);
      -- ������, ��, ��������
      wcs_utl.set_answ_ifempty(p_dest_bid_id,
                               'CL_16',
                               l_ca_live_row.address,
                               p_dest_ws_id,
                               p_dest_ws_number);
      -- ������
      wcs_utl.set_answ_ifempty(p_dest_bid_id,
                               'CL_12',
                               l_ca_live_row.zip,
                               p_dest_ws_id,
                               p_dest_ws_number);
    exception
      when no_data_found then
        wcs_utl.set_answ_ifempty(p_dest_bid_id,
                                 'CL_16',
                                 l_c_row.adr,
                                 p_dest_ws_id,
                                 p_dest_ws_number);
    end;
  end prefill_from_customers;

  -- �������������� ����������� �� ������� ������
  procedure prefill_auth_from_bids(p_dest_bid_id    wcs_answers.bid_id%type, -- ������������� ������ ��� ����������
                                   p_dest_ws_id     wcs_answers.ws_id%type, -- ������������� �������� ������������ ��� ����������
                                   p_dest_ws_number wcs_answers.ws_number%type, -- ����� �������� ������������ ��� ����������
                                   p_dest_auth_id   wcs_authorizations.id%type, -- ������������� ����������� ��� ����������
                                   p_src_bid_id     wcs_answers.bid_id%type, -- ������������� ������ ��� ������
                                   p_src_ws_id      wcs_answers.ws_id%type, -- ������������� �������� ������������ ��� ������
                                   p_src_ws_number  wcs_answers.ws_number%type -- ����� �������� ������������ ��� ������
                                   ) is
  begin
    -- �����������
    for cur in (select aq.question_id
                  from wcs_authorization_questions aq
                 where aq.auth_id = p_dest_auth_id
                   and wcs_utl.has_answ(p_dest_bid_id,
                                        aq.question_id,
                                        p_dest_ws_id,
                                        p_dest_ws_number) != 1
                   and wcs_utl.has_answ(p_src_bid_id,
                                        aq.question_id,
                                        p_src_ws_id,
                                        p_src_ws_number) = 1) loop
      wcs_utl.set_answ(p_dest_bid_id,
                       cur.question_id,
                       wcs_utl.get_answ(p_src_bid_id,
                                        cur.question_id,
                                        p_src_ws_id,
                                        p_src_ws_number),
                       p_dest_ws_id,
                       p_dest_ws_number);
    end loop;
  end prefill_auth_from_bids;

  -- �������������� ������ �� ������� ������
  procedure prefill_survey_from_bids(p_dest_bid_id    wcs_answers.bid_id%type, -- ������������� ������ ��� ����������
                                     p_dest_ws_id     wcs_answers.ws_id%type, -- ������������� �������� ������������ ��� ����������
                                     p_dest_ws_number wcs_answers.ws_number%type, -- ����� �������� ������������ ��� ����������
                                     p_dest_survey_id wcs_surveys.id%type, -- ������������� ������ ��� ����������
                                     p_src_bid_id     wcs_answers.bid_id%type, -- ������������� ������ ��� ������
                                     p_src_ws_id      wcs_answers.ws_id%type, -- ������������� �������� ������������ ��� ������
                                     p_src_ws_number  wcs_answers.ws_number%type -- ����� �������� ������������ ��� ������
                                     ) is
  begin
    -- ������
    for cur in (select sgq.question_id
                  from wcs_survey_group_questions sgq
                 where sgq.survey_id = p_dest_survey_id
                   and wcs_utl.has_answ(p_dest_bid_id,
                                        sgq.question_id,
                                        p_dest_ws_id,
                                        p_dest_ws_number) != 1
                   and wcs_utl.has_answ(p_src_bid_id,
                                        sgq.question_id,
                                        p_src_ws_id,
                                        p_src_ws_number) = 1) loop
      wcs_utl.set_answ(p_dest_bid_id,
                       cur.question_id,
                       wcs_utl.get_answ(p_src_bid_id,
                                        cur.question_id,
                                        p_src_ws_id,
                                        p_src_ws_number),
                       p_dest_ws_id,
                       p_dest_ws_number);
    end loop;

    -- ������� ����������
    wcs_pack.answ_del(p_dest_bid_id,
                      'CL_0_93_1',
                      p_dest_ws_id,
                      p_dest_ws_number); -- ������� ����������� (���.)
    wcs_pack.answ_del(p_dest_bid_id,
                      'CL_0_94',
                      p_dest_ws_id,
                      p_dest_ws_number); -- ���� ������� (���.)

  end prefill_survey_from_bids;

  -- ������ ����� ����������� �� �����
  /*
  ������ XML ����� ��� ������� ��ʳ�:
  � ������ ������ �� �������� ��������� <?xml version="1.0" encoding="utf-8" ?>, ��� �� �������� �������� ��� <root></root>.
  � ������� ���������� ���� <root></root> ���� �������� ������� ������� ���� <branch></branch>, �� ���������� �� �������� ��ʳ� �������� ������. �������� ���� <branch>:
  branch_id � ��� �������� (�������, /303398/ - ������������� ������� ��ʳ� ���� ��, /303398/000000/ - ������������� ������� ��ʳ� ��� ���� 2-�� ����);
  comment � ��������, ���� ���� ���������� � �������� ���. �������� ����� ������������ �� ��� �������������� ������� ��ʳ�. ������� � �� �����������.
  � ������� ���� <branch></branch> ���� �������� ������� ������� ���� <subproduct></subproduct>, �� ���������� �� �������� ��ʳ� �������� ����������� � ����� ���������� ��������. �������� ���� <subproduct>:
  sbp_id � ��� �����������.
  � ������� ���� <subproduct></subproduct> ���� �������� ������� ������� ���� <mac />, �� ���������� �� �������� �������� ����, �������� ����������� � ����� ���������� ��������. �������� ���� <mac />:
  mac_id � ��� ����. ��������� ��������, �� � ������ � ���� ���� ��� ��: MAC_SINGLE_FEE_MIN � MAC_SINGLE_FEE_MAX, MAC_INTEREST_RATE_MIN � MAC_INTEREST_RATE_MAX, ����, �� ������ ������������� �����. ������ ������ ��ʳ� ����� ������ � ������ �.
  apply_date � ���� � ��� �������� ���� ������� ���������������. ���� ������� ���� � ������ yyyy-MM-dd;
  value � �������� ����. ������ �������� � ��������� �� ���� ����:
  TEXT � ������
  NUMB � ���� ����� (�������: 5, 10, 357)
  DECIMAL � ������� �����, ����� . (������) (�������: 5.47, 18.2, 17)
  DATE � ���� � ������ yyyy-MM-dd (�������: 2012-02-22)
  LIST � ��� �������� � ���������� ������
  REFER � �������� ��������� ���� � ���������� ��������
  BOOL � 0 ��� 1

  ������� XML �����:
  <?xml version="1.0" encoding="utf-8" ?>
  <root>
    <branch branch_id="/303398/" comment="������ ���������� ���������� �� �� �1 �� 22/11/2011">
      <subproduct sbp_id="SBP_AUTO_G2_60_EP">
        <mac mac_id="MAC_SINGLE_FEE_MAX" apply_date="2012-01-01" value="3.5" />
        <mac mac_id="MAC_SINGLE_FEE_MIN" apply_date="2012-01-01" value="3.5" />
      </subproduct>
      <subproduct sbp_id="SBP_AUTO_G2_60_A" comment="������ ���������� ���������� �� �� �2 �� 23/11/2011">
        <mac mac_id="MAC_SINGLE_FEE_MAX" apply_date="2012-02-01" value="3.5" />
        <mac mac_id="MAC_SINGLE_FEE_MIN" apply_date="2012-02-01" value="3.5" />
      </subproduct>
    </branch>
  </root>
  */
  procedure import_sbpmacs(p_xml        in clob, -- XML
                           p_error_code out number, -- ��� ������ ������� (null ���� ��� ������)
                           p_protocol   out varchar2 -- �������� ������� (����� ������ ���� p_error_code != null)
                           ) is
    l_parser dbms_xmlparser.Parser;
    l_doc    dbms_xmldom.DOMDocument;

    l_n_root dbms_xmldom.DOMNode;

    l_nl_branchs     dbms_xmldom.DOMNodeList;
    l_n_branch       dbms_xmldom.DOMNode;
    l_nl_subproducts dbms_xmldom.DOMNodeList;
    l_n_subproduct   dbms_xmldom.DOMNode;
    l_nl_macs        dbms_xmldom.DOMNodeList;
    l_n_mac          dbms_xmldom.DOMNode;

    l_comment_branch     varchar2(4000);
    l_comment_subproduct varchar2(4000);
    l_comment_mac        varchar2(4000);
    l_comment            varchar2(4000);
    l_val                varchar2(4000);
    l_session_id         varchar2(100);
    l_staff_fio          varchar2(300);
    l_sys_comment        varchar2(4000);
    l_chng_comment       varchar2(4000);
    l_chng_cnt           number;

    l_m_row wcs_macs%rowtype;

    l_subproduct_id wcs_subproduct_macs.subproduct_id%type;
    l_mac_id        wcs_subproduct_macs.mac_id%type;
    l_val_text      wcs_subproduct_macs.val_text%type;
    l_val_numb      wcs_subproduct_macs.val_numb%type;
    l_val_decimal   wcs_subproduct_macs.val_decimal%type;
    l_val_date      wcs_subproduct_macs.val_date%type;
    l_val_list      wcs_subproduct_macs.val_list%type;
    l_val_refer     wcs_subproduct_macs.val_refer%type;
    l_val_bool      wcs_subproduct_macs.val_bool%type;
    l_branch        wcs_subproduct_macs.subproduct_id%type;
    l_apply_date    wcs_subproduct_macs.apply_date%type;
  begin
    -- ��������� �������
    l_session_id := dbms_session.unique_session_id;
    select sb.fio
      into l_staff_fio
      from staff$base sb
     where sb.id = user_id;
    l_sys_comment := '������ ����� �� ����� (������ �' || l_session_id ||
                     ', ���� ' || to_char(sysdate, 'dd.mm.yyyy hh24:mi') ||
                     ', ������������ �' || user_id || ' ��� ' ||
                     l_staff_fio || ')';

    -- ������ XML
    l_parser := dbms_xmlparser.newParser;
    dbms_xmlparser.parseClob(l_parser, p_xml);
    l_doc := dbms_xmlparser.getDocument(l_parser);
    dbms_xmlparser.freeParser(l_parser);

    savepoint sp_before_data_changes;
    -- ���-�� �������������� �������
    l_chng_cnt := 0;

    -- ���������� ���������� �������� branch
    l_nl_branchs := dbms_xmldom.getElementsByTagName(l_doc, 'branch');
    for i in 0 .. dbms_xmldom.getlength(l_nl_branchs) - 1 loop
      l_n_branch := dbms_xmldom.item(l_nl_branchs, i);
      -- ��� ���������
      l_branch := dbms_xmldom.getAttribute(dbms_xmldom.makeElement(l_n_branch),
                                           'branch_id');
      -- ����������
      l_comment_branch := dbms_xmldom.getAttribute(dbms_xmldom.makeElement(l_n_branch),
                                                   'comment');

      -- ���������� ���������� �������� subproduct
      l_nl_subproducts := dbms_xmldom.getChildrenByTagName(dbms_xmldom.makeElement(l_n_branch),
                                                           'subproduct');
      for j in 0 .. dbms_xmldom.getlength(l_nl_subproducts) - 1 loop
        l_n_subproduct := dbms_xmldom.item(l_nl_subproducts, j);
        -- ��� �����������
        l_subproduct_id := dbms_xmldom.getAttribute(dbms_xmldom.makeElement(l_n_subproduct),
                                                    'sbp_id');
        -- �����������
        l_comment_subproduct := dbms_xmldom.getAttribute(dbms_xmldom.makeElement(l_n_subproduct),
                                                         'comment');

        -- ���������� ���������� �������� mac
        l_nl_macs := dbms_xmldom.getChildrenByTagName(dbms_xmldom.makeElement(l_n_subproduct),
                                                      'mac');
        for k in 0 .. dbms_xmldom.getlength(l_nl_macs) - 1 loop
          l_n_mac := dbms_xmldom.item(l_nl_macs, k);
          -- ��� ����
          l_mac_id := dbms_xmldom.getAttribute(dbms_xmldom.makeElement(l_n_mac),
                                               'mac_id');
          -- �����������
          l_comment_mac := dbms_xmldom.getAttribute(dbms_xmldom.makeElement(l_n_mac),
                                                    'comment');

          -- ����������� � ���������
          l_comment := l_sys_comment || '. ���������: ' ||
                       nvl(l_comment_mac,
                           nvl(l_comment_subproduct, l_comment_branch));
          -- ���� ����������
          l_apply_date := to_date(dbms_xmldom.getAttribute(dbms_xmldom.makeElement(l_n_mac),
                                                           'apply_date'),
                                  'yyyy-mm-dd');
          -- �������� ����
          l_val := dbms_xmldom.getAttribute(dbms_xmldom.makeElement(l_n_mac),
                                            'value');

          -- ���������� ��� ����
          select * into l_m_row from wcs_macs m where m.id = l_mac_id;
          case l_m_row.type_id
            when 'TEXT' then
              l_val_text := l_val;
              wcs_pack.sbprod_mac_text_set(l_subproduct_id,
                                           l_mac_id,
                                           l_val_text,
                                           l_branch,
                                           l_apply_date,
                                           l_comment);
            when 'NUMB' then
              l_val_numb := to_number(l_val);
              wcs_pack.sbprod_mac_numb_set(l_subproduct_id,
                                           l_mac_id,
                                           l_val_numb,
                                           l_branch,
                                           l_apply_date,
                                           l_comment);
            when 'DECIMAL' then
              l_val_decimal := to_number(replace(l_val, ',', '.'),
                                         '999999999999999.9999',
                                         'NLS_NUMERIC_CHARACTERS = ''. ''');
              wcs_pack.sbprod_mac_dec_set(l_subproduct_id,
                                          l_mac_id,
                                          l_val_decimal,
                                          l_branch,
                                          l_apply_date,
                                          l_comment);
            when 'DATE' then
              l_val_date := to_date(l_val, 'yyyy-mm-dd');
              wcs_pack.sbprod_mac_dat_set(l_subproduct_id,
                                          l_mac_id,
                                          l_val_date,
                                          l_branch,
                                          l_apply_date,
                                          l_comment);
            when 'LIST' then
              l_val_list := to_number(l_val);
              wcs_pack.sbprod_mac_list_set(l_subproduct_id,
                                           l_mac_id,
                                           l_val_list,
                                           l_branch,
                                           l_apply_date,
                                           l_comment);

            when 'REFER' then
              l_val_refer := l_val;
              wcs_pack.sbprod_mac_ref_set(l_subproduct_id,
                                          l_mac_id,
                                          l_val_refer,
                                          l_branch,
                                          l_apply_date,
                                          l_comment);
            when 'BOOL' then
              l_val_bool := to_number(l_val);
              wcs_pack.sbprod_mac_bool_set(l_subproduct_id,
                                           l_mac_id,
                                           l_val_bool,
                                           l_branch,
                                           l_apply_date,
                                           l_comment);
          end case;

          l_chng_comment := '������������ �������� ���� ' || l_mac_id ||
                            ' ����������� ' || l_subproduct_id ||
                            ' ��� ������ ' || l_branch || ' �� ���� ' ||
                            to_char(l_apply_date, 'dd.mm.yyyy') || ' (' ||
                            l_val || ')';

          p_protocol := substr(p_protocol || l_chng_comment, 1, 3999);

          l_chng_cnt := l_chng_cnt + 1;
        end loop;
      end loop;
    end loop;

    -- ��������� �������� �������
    bars_audit.info(l_sys_comment || '. ������������� ' || l_chng_cnt ||
                    ' �����');
  exception
    when others then
      rollback to savepoint sp_before_data_changes;
      p_error_code := 1;
      p_protocol   := '������ �������: ' || sqlerrm;
  end import_sbpmacs;

end wcs_utl;
/
 show err;
 
PROMPT *** Create  grants  WCS_UTL ***
grant EXECUTE                                                                on WCS_UTL         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on WCS_UTL         to WCS_SYNC_USER;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/wcs_utl.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 