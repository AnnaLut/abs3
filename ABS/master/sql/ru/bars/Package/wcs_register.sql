 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/wcs_register.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.WCS_REGISTER is

  -- ===============================================================================================
  g_header_version constant varchar2(64) := 'version 5.0 27/10/2016';

  -- ���������� ������ ��������� ������
  function header_version return varchar2;
  -- ���������� ������ ���� ������
  function body_version return varchar2;

  -- ===============================================================================================
  -- Public types declarations
  -- ��������� ��������� ����������
  type t_pmt_instr is record(
    mfo  oper.mfob%type, -- ��� ����������
    nls  oper.nlsb%type, -- ����� ����� ����������
    nam oper.nam_b%type, -- ������������ ����� ����������
    okpo oper.id_b%type, -- ��� ����������
    nazn oper.nazn%type -- ���������� �������
    );
  -- ===============================================================================================

  function to_number2(p varchar2) return number;

  -- ��������� ��������� ���������� ��� ������������ ��������� �������
  function get_payment_instr(p_bid_id wcs_bids.id%type -- ������������� ������
                             ) return t_pmt_instr;

  -- ����������� �������
  procedure register_credit(p_bid_id in v_wcs_bids.bid_id%type -- ������������� ������
                            );
  -- ����������� ������/�������
  /*
  p_visa - ��������������� �������� ��������
  0  - ������-�� ��, �������� ������� ��������� � ������ �������������� �� ������
  2  - �������������� ����������� � �������� ���������. � ��� cc_deal.sos=4
  4  - ����-�� ����� �������� � �����������. �������������� ������� ����
  10 - ������������ �������� �� ������ ������. ������������ �������� �� ����� ��������. �� ��������� � ����� ������������

  15 - ����������� ��
  */
  procedure put_visa(p_bid_id in number, -- ������������� ������
                     p_visa   in number);


  -- ����������� �������� �����������
  function set_guarantee_deal(p_bid_id       in v_wcs_bid_garantees.bid_id%type, -- ������������� ������
                              p_garantee_id  in v_wcs_bid_garantees.garantee_id%type, -- ������������� ���� �����������
                              p_garantee_num in v_wcs_bid_garantees.garantee_num%type, -- ����� �����������
                              p_rnk          in customer.rnk%type default null -- ��� �������
                              ) return grt_deals.deal_id%type;
 --�������� �볺���
   function register_client(p_bid_id    in v_wcs_bids.bid_id%type, -- ������������� ������
                           p_ws_id     in wcs_answers.ws_id%type default wcs_utl.g_cur_ws_id, -- ������������� �������� ������������
                           p_ws_number in wcs_answers.ws_number%type default wcs_utl.g_cur_ws_num -- ����� �������� ������������
                           ) return customer.rnk%type;
 --TEST
 procedure register_comp_prg (p_bid_id in wcs_bids.id%type, -- ������������� ������
                              p_ws_id     in wcs_answers.ws_id%type default wcs_utl.g_cur_ws_id, -- ������������� �������� ������������
                              p_ws_number in wcs_answers.ws_number%type default wcs_utl.g_cur_ws_num -- ����� �������� ������������
);

end wcs_register;
/
CREATE OR REPLACE PACKAGE BODY BARS.WCS_REGISTER IS
  -- ================================== ��������� ===============================================
  g_isto      INT := 4; -- ��� ��������� ��������������
  g_obs       INT := 1; -- ��� ��� �����,
  g_freq      INT := 5; -- ������������� ��������� �������
  g_freqp     INT := 5; -- ������������� ����� %
  g_daynp     INT := -2; -- ���-�� �������� ���� � ���
  g_grp       INT := 5; -- ��� ������ �����
  g_br        INT := 9999; -- ��� ������� ���������� ������
  g_pack_name VARCHAR2(20) := 'wcs_register. ';
  -- ===============================================================================================

  g_body_version CONSTANT VARCHAR2(64) := 'version 5.3  27/09/2016';

  -- header_version - ���������� ������ ��������� ������
  FUNCTION header_version RETURN VARCHAR2 IS
  BEGIN
    RETURN 'Package header wcs_register ' || g_header_version || '.';
  END header_version;

  -- body_version - ���������� ������ ���� ������
  FUNCTION body_version RETURN VARCHAR2 IS
  BEGIN
    RETURN 'Package body wcs_register ' || g_body_version || '.';
  END body_version;
  -- ===============================================================================================

  FUNCTION to_number2(p VARCHAR2) RETURN NUMBER IS
  BEGIN
    RETURN round(to_number(translate(p, ',', '. ')
                          ,'99999999999D999'
                          ,'NLS_NUMERIC_CHARACTERS = ''. ''')
                ,2);
  END;

  -- ��������� ������ ����� �������
  FUNCTION concat_strings
  (
    s1  IN VARCHAR2
   ,s2  IN VARCHAR2
   ,s3  IN VARCHAR2 DEFAULT NULL
   ,s4  IN VARCHAR2 DEFAULT NULL
   ,s5  IN VARCHAR2 DEFAULT NULL
   ,s6  IN VARCHAR2 DEFAULT NULL
   ,s7  IN VARCHAR2 DEFAULT NULL
   ,s8  IN VARCHAR2 DEFAULT NULL
   ,s9  IN VARCHAR2 DEFAULT NULL
   ,s10 IN VARCHAR2 DEFAULT NULL
  ) RETURN VARCHAR2 IS
    l_res VARCHAR2(4000);
  BEGIN
    SELECT REPLACE(s1, ',', ' ') || nvl2(s2, ', ', '') ||
           REPLACE(s2, ',', ' ') || nvl2(s3, ', ', '') ||
           REPLACE(s3, ',', ' ') || nvl2(s4, ', ', '') ||
           REPLACE(s4, ',', ' ') || nvl2(s5, ', ', '') ||
           REPLACE(s5, ',', ' ') || nvl2(s6, ', ', '') ||
           REPLACE(s6, ',', ' ') || nvl2(s7, ', ', '') ||
           REPLACE(s7, ',', ' ') || nvl2(s8, ', ', '') ||
           REPLACE(s8, ',', ' ') || nvl2(s9, ', ', '') ||
           REPLACE(s9, ',', ' ') || REPLACE(s10, ',', ' ')
      INTO l_res
      FROM dual;

    RETURN l_res;
  END concat_strings;

  -- ��������� ��������� ���������� ��� ������������ ��������� �������
  FUNCTION get_payment_instr(p_bid_id wcs_bids.id%TYPE -- ������������� ������
                             ) RETURN t_pmt_instr IS
    l_res  t_pmt_instr;
    l_nazn VARCHAR2(4000);

    FUNCTION get_payment_nazn(p_bid_id wcs_bids.id%TYPE -- ������������� ������
                              ) RETURN VARCHAR2 IS
      l_pattern VARCHAR2(4000);
      l_res     VARCHAR2(4000);
    BEGIN
      SELECT dbms_lob.substr(f.html, dbms_lob.getlength(f.html), 1)
        INTO l_pattern
        FROM wcs_forms f
       WHERE f.id = 'CRD_PAYMENT_NAZN_PTRN';
      l_res := wcs_utl.parse_sql(p_bid_id, l_pattern);

      RETURN l_res;
    END get_payment_nazn;

  BEGIN
    -- ������� ���������� �������
    l_nazn := get_payment_nazn(p_bid_id);

    -- ���������� �������� ��� ������ � ������ �� ���� ��������� ����������
    CASE
      WHEN wcs_utl.get_answ(p_bid_id, 'PI_CURACC_SELECTED') = 1 THEN
        -- CURACC �� �������� �������
        DECLARE
          l_pi_curacc_accno accounts.acc%TYPE;
        BEGIN
          l_pi_curacc_accno := to_number(wcs_utl.get_answ(p_bid_id
                                                         ,'PI_CURACC_ACCNO'));
          IF (l_pi_curacc_accno IS NOT NULL) THEN
            SELECT a.kf   AS mfo
                  ,a.nls  AS nls
                  ,c.nmk  AS nam
                  ,c.okpo AS okpo
                  ,l_nazn AS nazn
              INTO l_res.mfo, l_res.nls, l_res.nam, l_res.okpo, l_res.nazn
              FROM accounts a, customer c
             WHERE a.acc = l_pi_curacc_accno
               AND a.rnk = c.rnk;
          END IF;
        END;
        cck_app.set_nd_txt(p_bid_id
                          ,'PARTN'
                          ,'ͳ');
      WHEN wcs_utl.get_answ(p_bid_id, 'PI_CARDACC_SELECTED') = 1 THEN
        -- CARDACC �� ��������� ������� !!! �������� !!!
        -- cmn.wp.ANSW_TEXT_SET(BID_ID, "PI_CARDACC_ACCNO", PI_CARDACC_ACCNO.Value);
        NULL;
        cck_app.set_nd_txt(p_bid_id
                          ,'PARTN'
                          ,'ͳ');
      WHEN wcs_utl.get_answ(p_bid_id, 'PI_PARTNER_SELECTED') = 1 THEN
        -- PARTNER �� ������� ��������
        cck_app.set_nd_txt(p_bid_id
                          ,'PARTN'
                          ,'Ta�');
        SELECT p.ptn_mfo  AS mfo
              ,p.ptn_nls  AS nls
              ,p.ptn_name AS nam
              ,p.ptn_okpo AS okpo
              ,l_nazn     AS nazn
          INTO l_res.mfo, l_res.nls, l_res.nam, l_res.okpo, l_res.nazn
          FROM wcs_partners p
         WHERE p.id =
               to_number(wcs_utl.get_answ(p_bid_id, 'PI_PARTNER_ID'));
         cck_app.set_nd_txt(p_bid_id
                          ,'PAR_N'
                          ,to_number(wcs_utl.get_answ(p_bid_id
                                                     ,'PI_PARTNER_ID')));

      WHEN wcs_utl.get_answ(p_bid_id, 'PI_FREE_SELECTED') = 1 THEN
        -- FREE �� ������ ��������
        l_res.mfo  := wcs_utl.get_answ(p_bid_id, 'PI_FREE_MFO');
        l_res.nls  := wcs_utl.get_answ(p_bid_id, 'PI_FREE_NLS');
        l_res.nam  := wcs_utl.get_answ(p_bid_id, 'PI_FREE_NAME');
        l_res.okpo := wcs_utl.get_answ(p_bid_id, 'PI_FREE_OKPO');
        l_res.nazn := l_nazn;
        cck_app.set_nd_txt(p_bid_id
                          ,'PARTN'
                          ,'ͳ');
      WHEN wcs_utl.get_answ(p_bid_id, 'PI_CASH_SELECTED') = 1 THEN
        -- CASH ����� ���� �����
        SELECT a.kf AS mfo
              ,a.nls
              ,substr(a.nms, 1, 38) AS nam
              ,c.okpo
              ,l_nazn AS nazn
          INTO l_res.mfo, l_res.nls, l_res.nam, l_res.okpo, l_res.nazn
          FROM accounts a, customer c
         WHERE a.rnk = c.rnk
           AND a.nls =
               (SELECT val
                  FROM branch_parameters
                 WHERE tag = 'CASH'
                   AND branch = wcs_utl.get_answ(p_bid_id, 'PI_CASH_BRANCH'))
           AND a.kv =
               (SELECT kv
                  FROM tabval t
                 WHERE t.lcv =
                       wcs_utl.get_creditdata(p_bid_id, 'CREDIT_CURRENCY'));
        cck_app.set_nd_txt(p_bid_id
                          ,'PARTN'
                          ,'ͳ');
    END CASE;

    RETURN l_res;
  END get_payment_instr;

  /* !!! ���� ���������� ������ �����������
  -- ���������� ������� �������� �� ���������
  procedure append_payment_ins(p_deal_id   ins_payments_schedule.deal_id%type,
                               p_plan_date ins_payments_schedule.plan_date%type,
                               p_plan_sum  ins_payments_schedule.plan_sum%type,
                               p_alertdays ins_payments_schedule.alertdays%type default null,
                               p_freq      number) is
    l_ostc   number := p_plan_sum;
    l_sum    number;
    l_col    int;
    l_months int;
    l_num    int := 1;
  begin

    bars_audit.info(g_pack_name || ' append_payment_ins ' ||
                    'Start. Params:  p_deal_id=' || to_char(p_deal_id) ||
                    ' Plan Date= ' || to_char(p_plan_date) ||
                    ' Plan Summa=' || to_char(p_plan_sum) || ' Freq=' ||
                    to_char(p_freq));
    if p_plan_sum > 0 then
      l_col := (case
                 when p_freq = 5 then
                  12
                 when p_freq = 7 then
                  4
                 when p_freq = 180 then
                  2
                 when p_freq = 360 then
                  1
                 else
                  1
               end);

      l_months := (case
                    when p_freq = 5 then
                     1
                    when p_freq = 7 then
                     3
                    when p_freq = 180 then
                     6
                    else
                     12
                  end);
      l_sum    := round(p_plan_sum / l_col);
      for cur in 1 .. l_col loop
        if l_num = l_col then
          INS_PACK.P_ADD_PAYMENT(p_deal_id,
                                 add_months(p_plan_date,
                                            (l_num - 1) * l_months),
                                 l_ostc,
                                 p_alertdays);
        else
          INS_PACK.P_ADD_PAYMENT(p_deal_id,
                                 add_months(p_plan_date,
                                            (l_num - 1) * l_months),
                                 l_sum,
                                 p_alertdays);

        end if;
        l_ostc := l_ostc - l_sum;
        l_num  := l_num + 1;
      end loop;
    end if;
  end;
  */

  -- �������� ������
  PROCEDURE accounts_open
  (
    p_bid_id         IN NUMBER
   , -- �������� ��������
    p_subproduct_id  IN VARCHAR2
   , -- ������������� �����������
    p_prk            IN NUMBER
   , -- % �i� ���� ��� ���I�. ���i�i�
    p_metr90         IN NUMBER
   , -- ��� ������ ���������� �������
    p_dat4_corrected IN DATE
   , -- ���������������� ���� ���������� ��������
    p_8_acc          OUT NUMBER
   , -- ���� 8-�� ������ (acc)
    p_ss_nls         OUT VARCHAR2
   , -- ������� ���� SS (nls)
    p_ss_acc         OUT NUMBER
   , -- ������� ���� SS (acc)
    p_sn_nls         OUT VARCHAR2
   , -- ���� ����������� ��������� SN (nls)
    p_sn_acc         OUT NUMBER
   , -- ���� ����������� ��������� SN (acc)
    p_sg_nls         OUT VARCHAR2
   , -- ���� ������� SG (nls)
    p_sg_acc         OUT NUMBER
   , -- ���� ������� SG (acc)
    p_sk0_nls        OUT VARCHAR2
   , -- ���� ������� SK0 (nls)
    p_sk0_acc        OUT NUMBER
   , -- ���� ������� SK0 (acc)
    p_sdi_nls        OUT VARCHAR2
   , -- ���� �������� SDI (nls)
    p_sdi_acc        OUT NUMBER -- ���� �������� SDI (acc)
  ) IS
    l_proc_name VARCHAR2(40) := 'accounts_open. ';

    l_acrb         NUMBER; -- ���� �������(����) � ��.
    l_kv           NUMBER;
    l_is_employee  NUMBER := wcs_utl.get_answ_refer_text(p_bid_id
                                                        ,'WORKER_BANK');
    l_is_base_rate NUMBER := wcs_utl.get_answ_bool(p_bid_id, 'BASE_RATES');
  BEGIN
    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Start. Params: p_bid_id=%s, p_subproduct_id=%s, p_prk=%s, p_metr90=%s, p_dat4_corrected=%s'
                    ,to_char(p_bid_id)
                    ,p_subproduct_id
                    ,to_char(p_prk)
                    ,to_char(p_metr90)
                    ,to_char(p_dat4_corrected));

    -- ���� 8-�� ������
    SELECT a.acc
      INTO p_8_acc
      FROM accounts a
     WHERE a.nls LIKE '8999_' || p_bid_id;

    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Proccess. Params: p_8_acc=%s'
                    ,to_char(p_8_acc));

    -- ������� ���� SS
    p_ss_nls := substr(cck.nls0(p_bid_id, 'SS '), 1, 15);
    cck.cc_op_nls(p_bid_id
                 ,l_kv
                 ,p_ss_nls
                 ,'SS '
                 ,gl.auid
                 ,g_grp
                 ,'1'
                 ,p_dat4_corrected
                 ,p_ss_acc);

    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Proccess. Params: p_ss_nls=%s, p_ss_acc=%s'
                    ,p_ss_nls
                    ,to_char(p_ss_acc));

    -- ���� ����������� ���������
    p_sn_nls := substr(cck.nls0(p_bid_id, 'SN '), 1, 15);
    cck.cc_op_nls(p_bid_id
                 ,l_kv
                 ,p_sn_nls
                 ,'SN '
                 ,gl.auid
                 ,g_grp
                 ,NULL
                 ,p_dat4_corrected
                 ,p_sn_acc);

    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Proccess. Params: p_sn_nls=%s, p_sn_acc=%s'
                    ,p_sn_nls
                    ,to_char(p_sn_acc));

    UPDATE int_accn ia
       SET ia.acrb = l_acrb
     WHERE ia.acc = p_ss_acc
       AND ia.id = 0;

    INSERT INTO nd_acc (nd, acc) VALUES (p_bid_id, l_acrb);

    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Proccess. Params: l_acrb=%s'
                    ,to_char(l_acrb));

    -- ���� �������
    p_sg_nls := substr(f_newnls2(p_8_acc, 'SG ', NULL, NULL, NULL), 1, 15);
    cck.cc_op_nls(p_bid_id
                 ,l_kv
                 ,p_sg_nls
                 ,'SG '
                 ,gl.auid
                 ,g_grp
                 ,'1'
                 ,p_dat4_corrected
                 ,p_sg_acc);

    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Proccess. Params: p_sg_nls=%s, p_sg_acc=%s'
                    ,p_sg_nls
                    ,to_char(p_sg_acc));

    -- �������� �����������
    p_sk0_nls := substr(f_newnls2(p_8_acc, 'SK0', NULL, NULL, NULL), 1, 15);
    cck.cc_op_nls(p_bid_id
                 ,l_kv
                 ,p_sk0_nls
                 ,'SK0'
                 ,gl.auid
                 ,g_grp
                 ,'1'
                 ,p_dat4_corrected
                 ,p_sk0_acc);

    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Proccess. Params: p_sk0_nls=%s, p_sk0_acc=%s'
                    ,p_sk0_nls
                    ,to_char(p_sk0_acc));

    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Proccess. Params: l_acrb=%s'
                    ,to_char(l_acrb));

    UPDATE int_accn ia
       SET ia.metr = p_metr90, ia.acrb = l_acrb, ia.acr_dat = NULL
     WHERE ia.acc = p_8_acc
       AND ia.id = 2;

    IF l_is_employee = 1
       AND l_is_base_rate = 1 THEN
      INSERT INTO int_ratn
        (acc, id, bdat, br)
      VALUES
        (p_8_acc, 2, gl.bdate, 9999);
    ELSE
      INSERT INTO int_ratn
        (acc, id, bdat, ir)
      VALUES
        (p_8_acc, 2, gl.bdate, p_prk);
    END IF;

    -- SDI �������
    p_sdi_nls := substr(f_newnls2(p_8_acc, 'SDI', NULL, NULL, NULL), 1, 15);
    cck.cc_op_nls(p_bid_id
                 ,l_kv
                 ,p_sdi_nls
                 ,'SDI'
                 ,gl.auid
                 ,g_grp
                 ,'1'
                 ,p_dat4_corrected
                 ,p_sdi_acc);

    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Finish. Params: p_sdi_nls=%s, p_sdi_acc=%s'
                    ,p_sdi_nls
                    ,to_char(p_sdi_acc));

  END accounts_open;

  -- ��������� ���������� ������������ � ����� �� ������� ��������������� ������ (��� ���������� ������)
  PROCEDURE get_branch_user
  (
    p_bid_id  IN NUMBER
   ,p_branch  IN VARCHAR2
   ,p_user_id IN VARCHAR2
   ,l_branch  OUT VARCHAR2
   ,l_user_id OUT VARCHAR2
  ) IS
  BEGIN
    IF p_branch IS NULL
       OR p_user_id IS NULL THEN
      BEGIN
        SELECT user_id, branch
          INTO l_user_id, l_branch
          FROM cc_deal
         WHERE nd = p_bid_id;
      EXCEPTION
        WHEN no_data_found THEN
          SELECT mgr_id, branch
            INTO l_user_id, l_branch
            FROM wcs_bids b
           WHERE b.id = p_bid_id;
      END;
    END IF;

    l_branch := nvl(p_branch, l_branch);

    IF length(l_branch) < 8 THEN
      raise_application_error(-20331
                             ,'���������� ���������� �������� �� �� ��볺� �� ������������  �' ||
                              l_user_id || ' ����������!'
                             ,TRUE);
    ELSIF length(l_branch) = 8 THEN
      l_branch := l_branch || '000000/';
    END IF;

    l_user_id := nvl(p_user_id, l_user_id);
  END;

  -- ����� ������� � ��� ������������������ (null ���� �� ������)
  FUNCTION get_client_rnk
  (
    p_bid_id    IN v_wcs_bids.bid_id%TYPE
   , -- ������������� ������
    p_ws_id     IN wcs_answers.ws_id%TYPE DEFAULT wcs_utl.g_cur_ws_id
   , -- ������������� �������� ������������
    p_ws_number IN wcs_answers.ws_number%TYPE DEFAULT wcs_utl.g_cur_ws_num -- ����� �������� ������������
  ) RETURN customer.rnk%TYPE IS
    l_okpo VARCHAR2(10) := wcs_utl.get_answ(p_bid_id
                                           ,'CODE_002'
                                           ,p_ws_id
                                           ,p_ws_number); -- ���������������� ��� �볺���
    l_f    VARCHAR2(45) := wcs_utl.get_answ(p_bid_id
                                           ,'CL_1'
                                           ,p_ws_id
                                           ,p_ws_number); -- �������
    l_i    VARCHAR2(40) := wcs_utl.get_answ(p_bid_id
                                           ,'CL_2'
                                           ,p_ws_id
                                           ,p_ws_number); -- ���
    l_o    VARCHAR2(40) := wcs_utl.get_answ(p_bid_id
                                           ,'CL_3'
                                           ,p_ws_id
                                           ,p_ws_number); -- �� �������
    l_fio  VARCHAR2(125) := l_f || ' ' || l_i || ' ' || l_o; -- ���
    l_bdat DATE := to_date(wcs_utl.get_answ(p_bid_id
                                           ,'CL_4'
                                           ,p_ws_id
                                           ,p_ws_number)); -- ���� ����������

    l_rnk customer.rnk%TYPE := NULL;
  BEGIN
    -- �������� �������� ��� ����������� (��� ����������)
    IF (p_ws_id = 'MAIN') THEN
      SELECT b.rnk INTO l_rnk FROM wcs_bids b WHERE b.id = p_bid_id;
    ELSE
      l_rnk := to_number(wcs_utl.get_answ(p_bid_id
                                         ,'CL_RNK'
                                         ,p_ws_id
                                         ,p_ws_number));
    END IF;

    IF (l_rnk IS NOT NULL) THEN
      RETURN l_rnk;
    END IF;

    -- ���� �� ���
    SELECT MAX(rnk)
      INTO l_rnk
      FROM (SELECT rnk
              FROM customer
             WHERE okpo = l_okpo
               AND custtype = 3
               AND okpo != '0000000000'
             ORDER BY date_off NULLS FIRST)
     WHERE rownum = 1;

    IF (l_rnk IS NOT NULL) THEN
      RETURN l_rnk;
    END IF;

    -- ���� �� ��� � ���� ����.
    SELECT MAX(rnk)
      INTO l_rnk
      FROM (SELECT p.rnk
              FROM customer c, person p
             WHERE upper(translate(c.nmk, '1 ', '1')) =
                   upper(translate(l_fio, '1 ', '1'))
               AND c.custtype = 3
               AND p.bday = l_bdat
               AND p.rnk = c.rnk
             ORDER BY date_off NULLS FIRST, p.rnk DESC)
     WHERE rownum = 1;

    IF (l_rnk IS NOT NULL) THEN
      RETURN l_rnk;
    END IF;

    RETURN NULL;
  END get_client_rnk;

  -- ����������� �����������
  FUNCTION register_client
  (
    p_bid_id    IN v_wcs_bids.bid_id%TYPE
   , -- ������������� ������
    p_ws_id     IN wcs_answers.ws_id%TYPE DEFAULT wcs_utl.g_cur_ws_id
   , -- ������������� �������� ������������
    p_ws_number IN wcs_answers.ws_number%TYPE DEFAULT wcs_utl.g_cur_ws_num -- ����� �������� ������������
  ) RETURN customer.rnk%TYPE IS
    l_proc_name VARCHAR2(40) := 'register_client. ';

    l_type_kl NUMBER := 3;
    l_rnk     customer.rnk%TYPE;

    -- �������� ���������� ��� �볺���
    l_f                  VARCHAR2(45) := wcs_utl.get_answ(p_bid_id
                                                         ,'CL_1'
                                                         ,p_ws_id
                                                         ,p_ws_number); -- �������
    l_i                  VARCHAR2(40) := wcs_utl.get_answ(p_bid_id
                                                         ,'CL_2'
                                                         ,p_ws_id
                                                         ,p_ws_number); -- ���
    l_o                  VARCHAR2(40) := wcs_utl.get_answ(p_bid_id
                                                         ,'CL_3'
                                                         ,p_ws_id
                                                         ,p_ws_number); -- �� �������
    l_fio                VARCHAR2(125) := l_f || ' ' || l_i || ' ' || l_o; -- ���
    l_fio_k              VARCHAR2(37) := substr((l_f || substr(l_i, 1, 1) || '.' ||
                                                substr(l_o, 1, 1) || '.')
                                               ,1
                                               ,38); -- ��� �������
    l_fio_r              VARCHAR2(125) := wcs_utl.get_answ(p_bid_id
                                                          ,'CL_123_R'
                                                          ,p_ws_id
                                                          ,p_ws_number); -- ϲ� � �������� ������
    l_sex                NUMBER := to_number(wcs_utl.get_answ(p_bid_id
                                                             ,'CL_71'
                                                             ,p_ws_id
                                                             ,p_ws_number)); -- �����
    l_rez                NUMBER := to_number(wcs_utl.get_answ(p_bid_id
                                                             ,'CL_63'
                                                             ,p_ws_id
                                                             ,p_ws_number)); -- ��������
    l_rez_kl NUMBER := (CASE
                         WHEN l_type_kl = 2
                              AND l_rez = 1 THEN
                          3
                         WHEN l_type_kl = 2
                              AND l_rez = 0 THEN
                          4
                         WHEN l_type_kl = 3
                              AND l_rez = 0 THEN
                          5
                         WHEN l_type_kl = 3
                              AND l_rez = 1 THEN
                          6
                         ELSE
                          NULL
                       END);
    l_maiden_name        VARCHAR2(40) := NULL; -- ĳ���� ������� (���� ��� ����)
    l_mother_maiden_name VARCHAR2(40) := NULL; -- ĳ���� ������� �����
    l_bdat               DATE := to_date(wcs_utl.get_answ(p_bid_id
                                                         ,'CL_4'
                                                         ,p_ws_id
                                                         ,p_ws_number)); -- ���� ����������
    l_bplace             VARCHAR2(70) := substr(wcs_utl.get_answ(p_bid_id
                                                                ,'CL_4_0'
                                                                ,p_ws_id
                                                                ,p_ws_number)
                                               ,1
                                               ,70); -- ̳��� ����������
    l_okpo               VARCHAR2(10) := wcs_utl.get_answ(p_bid_id
                                                         ,'CODE_002'
                                                         ,p_ws_id
                                                         ,p_ws_number); -- ���������������� ��� �볺���
    l_tel_prime          VARCHAR2(20) := wcs_utl.get_answ(p_bid_id
                                                         ,'CL_199'
                                                         ,p_ws_id
                                                         ,p_ws_number); -- ���������� �������
    l_has_tel_mob        VARCHAR2(20) := to_number(wcs_utl.get_answ(p_bid_id
                                                                   ,'CL_0_3'
                                                                   ,p_ws_id
                                                                   ,p_ws_number)); -- �������� �������
    l_tel_mob            VARCHAR2(20) := wcs_utl.get_answ(p_bid_id
                                                         ,'CL_0_4'
                                                         ,p_ws_id
                                                         ,p_ws_number); -- ����� ��������� ��������
    l_e_mail             VARCHAR2(45) := wcs_utl.get_answ(p_bid_id
                                                         ,'CL_0_5'
                                                         ,p_ws_id
                                                         ,p_ws_number); -- ���������� �����

    -- ���������
    l_doc_ser   VARCHAR2(2) := wcs_utl.get_answ(p_bid_id
                                               ,'CL_7'
                                               ,p_ws_id
                                               ,p_ws_number); -- ���� ��������
    l_doc_num   VARCHAR2(6) := wcs_utl.get_answ(p_bid_id
                                               ,'CL_8'
                                               ,p_ws_id
                                               ,p_ws_number); -- ����� ��������
    l_doc_organ VARCHAR2(120) := wcs_utl.get_answ(p_bid_id
                                                 ,'CL_9'
                                                 ,p_ws_id
                                                 ,p_ws_number) || '  ' ||
                                 wcs_utl.get_answ(p_bid_id
                                                 ,'CL_10'
                                                 ,p_ws_id
                                                 ,p_ws_number); -- �����, �� ����� ������� (� ��)
    l_doc_dat   DATE := to_date(wcs_utl.get_answ(p_bid_id
                                                ,'CL_11'
                                                ,p_ws_id
                                                ,p_ws_number)); -- ���� ������ ��������

    --Pivanova 27/04/2016 ������ ��������� ��������� ������, � ��*���� � ��������� �� ��������
    l_status_live VARCHAR2(255) := wcs_utl.get_answ_list_text(p_bid_id
                                                             ,'CL_0_147'
                                                             ,p_ws_id
                                                             ,p_ws_number); -- ������ ���� ����������
    -- ������ ���������
    l_reg_settlement_id  NUMBER(17) := wcs_utl.get_answ_refer(p_bid_id
                                                             ,'ADR_REG_SETTLEMENT_ID'
                                                             ,p_ws_id
                                                             ,p_ws_number); -- ��� ���������� ������
    l_adr_reg_street_id  NUMBER(17) := wcs_utl.get_answ_refer(p_bid_id
                                                             ,'ADR_REG_STREET_ID'
                                                             ,p_ws_id
                                                             ,p_ws_number); -- ��� ������
    l_fact_settlement_id NUMBER(17) := wcs_utl.get_answ_refer(p_bid_id
                                                             ,'ADR_FACT_SETTLEMENT_ID'
                                                             ,p_ws_id
                                                             ,p_ws_number); -- ��� ���������� ������
    l_adr_fact_street_id NUMBER(17) := wcs_utl.get_answ_refer(p_bid_id
                                                             ,'ADR_FACT_STREET_ID'
                                                             ,p_ws_id
                                                             ,p_ws_number); -- ��� ������

    l_adr_reg_region        VARCHAR2(255); -- �������
    l_adr_reg_area          VARCHAR2(255); -- �����
    l_adr_reg_locality      VARCHAR2(255); -- ����/��������� �����
    l_adr_reg_locality_type VARCHAR2(255); -- ����/��������� �����
    l_adr_reg_street        VARCHAR2(255); -- ����� ������
    l_adr_reg_street_type   VARCHAR2(255);
    l_adr_reg_full_address  VARCHAR2(2000);

    l_adr_reg_home          VARCHAR2(255) := wcs_utl.get_answ(p_bid_id
                                                             ,'ADR_REG_HOME'
                                                             ,p_ws_id
                                                             ,p_ws_number);
    l_adr_reg_home_type     VARCHAR2(255) := wcs_utl.get_answ_refer(p_bid_id
                                                                   ,'ADR_REG_HOME_TYPE'
                                                                   ,p_ws_id
                                                                   ,p_ws_number);
    l_adr_reg_homepart      VARCHAR2(255) := wcs_utl.get_answ(p_bid_id
                                                             ,'ADR_REG_HOMEPART'
                                                             ,p_ws_id
                                                             ,p_ws_number);
    l_adr_reg_homepart_type VARCHAR2(255) := wcs_utl.get_answ(p_bid_id
                                                             ,'ADR_REG_HOMEPART_TYPE'
                                                             ,p_ws_id
                                                             ,p_ws_number);

    l_adr_reg_room        VARCHAR2(255) := wcs_utl.get_answ(p_bid_id
                                                           ,'ADR_REG_ROOM'
                                                           ,p_ws_id
                                                           ,p_ws_number);
    l_adr_reg_room_type   VARCHAR2(255) := wcs_utl.get_answ(p_bid_id
                                                           ,'ADR_REG_ROOM_TYPE'
                                                           ,p_ws_id
                                                           ,p_ws_number);
    l_adr_reg_postal_code VARCHAR2(5) := wcs_utl.get_answ(p_bid_id
                                                         ,'ADR_REG_POSTAL_CODE'
                                                         ,p_ws_id
                                                         ,p_ws_number); -- �������� ������
    l_has_tel_home        VARCHAR2(20) := wcs_utl.get_answ(p_bid_id
                                                          ,'CL_0_8'
                                                          ,p_ws_id
                                                          ,p_ws_number); -- ������� �������

    l_adr_fact_region        VARCHAR2(255); -- �������
    l_adr_fact_area          VARCHAR2(255); -- �����
    l_adr_fact_locality      VARCHAR2(255); -- ����/��������� �����
    l_adr_fact_locality_type VARCHAR2(255); -- ����/��������� �����
    l_adr_fact_street        VARCHAR2(255); -- ����� ������
    l_adr_fact_street_type   VARCHAR2(255);
    l_adr_fact_full_address  VARCHAR2(2000);
    l_adr_fact_home          VARCHAR2(255) := wcs_utl.get_answ(p_bid_id
                                                              ,'ADR_FACT_HOME'
                                                              ,p_ws_id
                                                              ,p_ws_number);
    l_adr_fact_home_type     VARCHAR2(255) := wcs_utl.get_answ_refer(p_bid_id
                                                                    ,'ADR_FACT_HOME_TYPE'
                                                                    ,p_ws_id
                                                                    ,p_ws_number);
    l_adr_fact_homepart      VARCHAR2(255) := wcs_utl.get_answ(p_bid_id
                                                              ,'ADR_FACT_HOMEPART'
                                                              ,p_ws_id
                                                              ,p_ws_number);
    l_adr_fact_homepart_type VARCHAR2(255) := wcs_utl.get_answ(p_bid_id
                                                              ,'ADR_FACT_HOMEPART_TYPE'
                                                              ,p_ws_id
                                                              ,p_ws_number);

    l_adr_fact_room        VARCHAR2(255) := wcs_utl.get_answ(p_bid_id
                                                            ,'ADR_FACT_ROOM'
                                                            ,p_ws_id
                                                            ,p_ws_number);
    l_adr_fact_room_type   VARCHAR2(255) := wcs_utl.get_answ(p_bid_id
                                                            ,'ADR_FACT_ROOM_TYPE'
                                                            ,p_ws_id
                                                            ,p_ws_number);
    l_adr_fact_postal_code VARCHAR2(5) := wcs_utl.get_answ(p_bid_id
                                                          ,'ADR_FACT_POSTAL_CODE'
                                                          ,p_ws_id
                                                          ,p_ws_number); -- �������� ������

    l_tel_home VARCHAR2(20) := wcs_utl.get_answ(p_bid_id
                                               ,'CL_23'
                                               ,p_ws_id
                                               ,p_ws_number); -- ������� �� ����� ����������

    -- ������ ����������
    l_adr_reg_like_live NUMBER := to_number(wcs_utl.get_answ(p_bid_id
                                                            ,'CL_0_188'
                                                            ,p_ws_id
                                                            ,p_ws_number)); -- ������ ���� ���������� � ��������� ����������?

    -- �������
    l_s         NUMBER := to_number(wcs_utl.get_answ(p_bid_id
                                                    ,'S'
                                                    ,p_ws_id
                                                    ,p_ws_number)); -- C��� ���� ������ ���������, ��� ������� �����������
    l_cr        NUMBER := to_number(wcs_utl.get_answ(p_bid_id
                                                    ,'CR'
                                                    ,p_ws_id
                                                    ,p_ws_number)); -- �������� ���������� ������
    l_crisk_obu VARCHAR2(255) := wcs_utl.get_answ_list_text(p_bid_id
                                                           ,'CRISK_OBU'
                                                           ,p_ws_id
                                                           ,p_ws_number); -- �������� ��������� ������� ������������
    l_crisk_nbu VARCHAR2(255) := wcs_utl.get_answ_list_text(p_bid_id
                                                           ,'CRISK_NBU'
                                                           ,p_ws_id
                                                           ,p_ws_number); -- ���� ������������ (�������� �� ������������ ���)
    l_crisk     customer.crisk%TYPE := to_number(wcs_utl.get_answ(p_bid_id
                                                                 ,'CRISK_NBU'
                                                                 ,p_ws_id
                                                                 ,p_ws_number)) + 1; -- ��� ����� ������������

    -- ������������� ���������
    l_sed customer.sed%TYPE := CASE
                                 WHEN l_type_kl = 3 THEN
                                  '00  '
                                 ELSE
                                  NULL
                               END;

    -- ������
    l_prinsider customer.prinsider%TYPE := CASE
                                             WHEN wcs_utl.get_answ(p_bid_id
                                                                  ,'CL_0_109'
                                                                  ,p_ws_id
                                                                  ,p_ws_number) = 1 THEN
                                              1
                                             WHEN wcs_utl.get_answ(p_bid_id
                                                                  ,'CL_0_110'
                                                                  ,p_ws_id
                                                                  ,p_ws_number) = 1 THEN
                                              1
                                             WHEN wcs_utl.get_answ(p_bid_id
                                                                  ,'CL_0_111'
                                                                  ,p_ws_id
                                                                  ,p_ws_number) = 1 THEN
                                              1
                                             WHEN wcs_utl.get_answ(p_bid_id
                                                                  ,'CL_0_112'
                                                                  ,p_ws_id
                                                                  ,p_ws_number) = 1 THEN
                                              1
                                             ELSE
                                              99
                                           END;

    l_ved VARCHAR2(5); -- ��� ������������� ������������
    --��������� �����䳿
    l_subsidy_avaliable VARCHAR2(255) := nvl(wcs_utl.get_answ(p_bid_id
                                                             ,'PRG_EVENT_SUBSIDY_AVALIABLE'
                                                             ,p_ws_id
                                                             ,p_ws_number)
                                            ,0);
    l_subsidy_numb      VARCHAR2(255) := nvl(wcs_utl.get_answ_text(p_bid_id
                                                                  ,'PRG_EVENT_SUBSIDY_NUMB'
                                                                  ,p_ws_id
                                                                  ,p_ws_number)
                                            ,'');
    l_subsidy_date      VARCHAR2(255) := nvl(to_char(wcs_utl.get_answ_date(p_bid_id
                                                                          ,'PRG_EVENT_SUBSIDY_DATE'
                                                                          ,p_ws_id
                                                                          ,p_ws_number)
                                                    ,'DD/MM/YYYY')
                                            ,'');

    l_subsidy_doc_type     VARCHAR2(255) := nvl(wcs_utl.get_answ_list_text(p_bid_id
                                                                          ,'PRG_EVENT_SUBSIDY_DOC_TYPE'
                                                                          ,p_ws_id
                                                                          ,p_ws_number)
                                               ,'');
    l_subsidy_doc_type_txt VARCHAR2(255) := wcs_utl.get_answ_text(p_bid_id
                                                                 ,'PRG_EVENT_SUBSIDY_DOC_TYPE_TXT'
                                                                 ,p_ws_id
                                                                 ,p_ws_number);

  BEGIN

    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Start. Params: p_bid_id=%s'
                    ,to_char(p_bid_id));

    -- ����������� ���� ������������� ������������
    BEGIN
      SELECT val INTO l_ved FROM params WHERE par = 'CUSTK110';
    EXCEPTION
      WHEN no_data_found THEN
        l_ved := '00000';
    END;

    -- ���� ������� � ��� ������������������
    l_rnk := get_client_rnk(p_bid_id, p_ws_id, p_ws_number);

    -- ��������� ������� ���� �� ������
    UPDATE customer c
       SET c.date_off = NULL
     WHERE c.rnk = l_rnk
       AND c.date_off IS NOT NULL;

    -- ������������ �������� ��������� �����������
    kl.setcustomerattr(rnk_       => l_rnk
                      , -- Customer number
                       custtype_  => l_type_kl
                      , -- ��� �������: 1-����, 2-��.����, 3-���.����
                       nd_        => NULL
                      , -- � ��������
                       nmk_       => l_fio
                      , -- ������������ �������
                       nmkv_      => substr(l_fio, 1, 70)
                      , -- ������������ ������� �������������
                       nmkk_      => l_fio_k
                      , -- ������������ ������� �������
                       adr_       => NULL
                      , -- ����� �������
                       codcagent_ => l_rez_kl
                      , -- �������������� (5-���������� ����-��������)
                       country_   => 804
                      , -- ������ (804 - �������)
                       prinsider_ => l_prinsider
                      , -- ������� ��������� (0-�� �������� �� _�������_�)
                       tgr_       => 2
                      , -- ��� ���.������� (2-����� ���� (�i�.��i�))
                       okpo_      => l_okpo
                      , -- ����
                       stmt_      => 0
                      , -- ������ ������� (0-�� ������������)
                       sab_       => NULL
                      , -- ��.���
                       dateon_    => gl.bdate
                      , -- ���� �����������
                       taxf_      => NULL
                      , -- ��������� ���
                       creg_      => NULL
                      , -- ��� ���.��
                       cdst_      => NULL
                      , -- ��� �����.��
                       adm_       => NULL
                      , -- �����.�����
                       rgtax_     => NULL
                      , -- ��� ����� � ��
                       rgadm_     => NULL
                      , -- ��� ����� � ���.
                       datet_     => NULL
                      , -- ���� ��� � ��
                       datea_     => NULL
                      , -- ���� ���. � �������������
                       ise_       => NULL
                      , -- ����. ���. ���������
                       fs_        => NULL
                      , -- ����� �������������
                       oe_        => NULL
                      , -- ������� ���������
                       ved_       => l_ved
                      , -- ��� ��. ������������
                       sed_       => l_sed
                      , -- ����� ��������������
                       notes_     => NULL
                      , -- ����������
                       notesec_   => NULL
                      , -- ���������� ��� ������ ������������
                       crisk_     => l_crisk
                      , -- ��������� �����
                       pincode_   => NULL
                      , --
                       rnkp_      => NULL
                      , -- ���. ����� ��������
                       lim_       => NULL
                      , -- ����� �����
                       nompdv_    => NULL
                      , -- � � ������� ����. ���
                       mb_        => NULL
                      , -- �������. ������ �������
                       bc_        => 0
                      , -- ������� ��������� �����
                       tobo_      => sys_context('bars_context'
                                                ,'user_branch')
                      , -- ��� �������������� ���������
                       isp_       => user_id -- �������� ������� (�����. �����������)
                       );

    IF l_reg_settlement_id IS NOT NULL
       AND l_reg_settlement_id <> 1 THEN
      BEGIN
        SELECT t.region_name
              ,t.area_name
              ,t.settlement_type || ' ' || t.settlement_name
          INTO l_adr_reg_region, l_adr_reg_area, l_adr_reg_locality
          FROM vw_escr_address t
         WHERE t.settlement_id = l_reg_settlement_id;
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
        WHEN OTHERS THEN
          NULL;
      END;
    ELSIF l_reg_settlement_id IS NOT NULL
          AND l_reg_settlement_id = 1 THEN
      l_adr_reg_region := '';
      l_adr_reg_area   := '';
      BEGIN
        SELECT t.settlement_type || ' ' || t.settlement_name
          INTO l_adr_reg_locality
          FROM vw_escr_address t
         WHERE t.settlement_id = l_reg_settlement_id;
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
        WHEN OTHERS THEN
          NULL;
      END;
    ELSE
      l_adr_reg_region        := wcs_utl.get_answ_text(p_bid_id
                                                      ,'ADR_REG_REGION'
                                                      ,p_ws_id
                                                      ,p_ws_number);
      l_adr_reg_area          := wcs_utl.get_answ_text(p_bid_id
                                                      ,'ADR_REG_AREA'
                                                      ,p_ws_id
                                                      ,p_ws_number);
      l_adr_reg_locality_type := wcs_utl.get_answ_refer_text(p_bid_id
                                                            ,'ADR_REG_LOCALITY_TYPE'
                                                            ,p_ws_id
                                                            ,p_ws_number);
      l_adr_reg_locality      := l_adr_reg_locality_type || '' ||
                                 wcs_utl.get_answ_text(p_bid_id
                                                      ,'ADR_REG_LOCALITY'
                                                      ,p_ws_id
                                                      ,p_ws_number);
    END IF;

    IF l_adr_reg_street_id IS NOT NULL THEN
      BEGIN
        SELECT t.str_tp_nm || ' ' || t.street_name

          INTO l_adr_reg_street
          FROM vw_adr_streets t
         WHERE t.street_id = l_adr_reg_street_id
           AND t.settlement_id = l_reg_settlement_id;
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
        WHEN OTHERS THEN
          NULL;
      END;
    ELSE
      l_adr_reg_street_type := wcs_utl.get_answ_refer(p_bid_id
                                                     ,'ADR_REG_STREET_TYPE'
                                                     ,p_ws_id
                                                     ,p_ws_number);
      l_adr_reg_street      := l_adr_reg_street_type || '' ||
                               wcs_utl.get_answ_text(p_bid_id
                                                    ,'ADR_REG_STREET'
                                                    ,p_ws_id
                                                    ,p_ws_number);
    END IF;
    IF length(l_adr_reg_street) > 0 THEN
      l_adr_reg_full_address := ', ' || l_adr_reg_street || ', ' ||
                                l_adr_reg_home_type || l_adr_reg_home;

    ELSE
      l_adr_reg_full_address := ', ' || l_adr_reg_home_type ||
                                l_adr_reg_home;
    END IF;
    IF length(l_adr_reg_homepart_type) > 0 THEN
      l_adr_reg_full_address := l_adr_reg_full_address || ', ' ||
                                l_adr_reg_homepart_type ||
                                l_adr_reg_homepart;
    END IF;
    IF length(l_adr_reg_room_type) > 0 THEN
      l_adr_reg_full_address := l_adr_reg_full_address || ', ' ||
                                l_adr_reg_room_type || l_adr_reg_room;
    END IF;

    IF l_adr_reg_like_live = 0 THEN
      IF l_fact_settlement_id IS NOT NULL
         AND l_fact_settlement_id <> 1 THEN
        BEGIN
          SELECT t.region_name
                ,t.area_name
                ,t.settlement_type || ' ' || t.settlement_name
            INTO l_adr_fact_region, l_adr_fact_area, l_adr_fact_locality
            FROM vw_escr_address t
           WHERE t.settlement_id = l_fact_settlement_id;

        EXCEPTION
          WHEN no_data_found THEN
            NULL;
          WHEN OTHERS THEN
            NULL;

        END;
      ELSIF l_fact_settlement_id IS NOT NULL
            AND l_fact_settlement_id = 1 THEN
        l_adr_fact_region := '';
        l_adr_fact_area   := '';
        BEGIN
          SELECT t.settlement_type || ' ' || t.settlement_name
            INTO l_adr_fact_locality
            FROM vw_escr_address t
           WHERE t.settlement_id = l_fact_settlement_id;
        EXCEPTION
          WHEN no_data_found THEN
            NULL;
          WHEN OTHERS THEN
            NULL;

        END;
      ELSE
        l_adr_fact_region        := wcs_utl.get_answ_text(p_bid_id
                                                         ,'ADR_FACT_REGION'
                                                         ,p_ws_id
                                                         ,p_ws_number);
        l_adr_fact_area          := wcs_utl.get_answ_text(p_bid_id
                                                         ,'ADR_FACT_AREA'
                                                         ,p_ws_id
                                                         ,p_ws_number);
        l_adr_fact_locality_type := wcs_utl.get_answ_refer(p_bid_id
                                                          ,'ADR_FACT_LOCALITY_TYPE'
                                                          ,p_ws_id
                                                          ,p_ws_number);
        l_adr_fact_locality      := l_adr_fact_locality_type || '' ||
                                    wcs_utl.get_answ_text(p_bid_id
                                                         ,'ADR_FACT_LOCALITY'
                                                         ,p_ws_id
                                                         ,p_ws_number);

      END IF;

      IF l_adr_fact_street_id IS NOT NULL THEN
        BEGIN
          SELECT t.str_tp_nm || ' ' || t.street_name

            INTO l_adr_fact_street
            FROM vw_adr_streets t
           WHERE t.street_id = l_adr_fact_street_id
             AND t.settlement_id = l_fact_settlement_id;

        EXCEPTION
          WHEN no_data_found THEN
            NULL;
          WHEN OTHERS THEN
            NULL;

        END;
      ELSE
        l_adr_fact_street_type := wcs_utl.get_answ_refer(p_bid_id
                                                        ,'ADR_FACT_STREET_TYPE'
                                                        ,p_ws_id
                                                        ,p_ws_number);
        l_adr_fact_street      := l_adr_fact_street_type || '' ||
                                  wcs_utl.get_answ_text(p_bid_id
                                                       ,'ADR_FACT_STREET'
                                                       ,p_ws_id
                                                       ,p_ws_number);
      END IF;
      /*  l_adr_fact_full_address := l_adr_fact_street || ' ,' ||
      l_adr_fact_home_type || l_adr_fact_home;*/
      IF length(l_adr_fact_street) > 0 THEN
        l_adr_fact_full_address := ', ' || l_adr_fact_street || ', ' ||
                                   l_adr_fact_home_type || l_adr_fact_home;

      ELSE
        l_adr_fact_full_address := ', ' || l_adr_fact_home_type ||
                                   l_adr_fact_home;
      END IF;

      IF length(l_adr_fact_homepart_type) > 0 THEN
        l_adr_fact_full_address := l_adr_fact_full_address || ', ' ||
                                   l_adr_fact_homepart_type ||
                                   l_adr_fact_homepart;
      END IF;
      IF length(l_adr_fact_room_type) > 0 THEN
        l_adr_fact_full_address := l_adr_fact_full_address || ', ' ||
                                   l_adr_fact_room_type || l_adr_fact_room;
      END IF;
    END IF;
    -- ������������ ���������� ����� � ������� ��� ������� (���� ��� ����)
    -- 1 - ������ ���������, 2 - ������ ����������
    -- Call the procedure
    BEGIN
      kl.setfullcustomeraddress(p_rnk           => l_rnk
                               ,p_typeid        => 1
                               ,p_country       => '804'
                               ,p_zip           => l_adr_reg_postal_code
                               ,p_domain        => l_adr_reg_region
                               ,p_region        => l_adr_reg_area
                               ,p_locality      => l_adr_reg_locality
                               ,p_address       => l_adr_reg_full_address
                               ,p_territoryid   => NULL
                               ,p_locality_type => NULL
                               ,p_street_type   => NULL
                               ,p_street        => NULL
                               ,p_home_type     => NULL
                               ,p_home          => NULL
                               ,p_homepart_type => NULL
                               ,p_homepart      => NULL
                               ,p_room_type     => NULL
                               ,p_room          => NULL
                               ,p_comment       => NULL
                               ,p_flag_visa     => 0);
    END;
    IF l_adr_reg_like_live = 1 THEN
      BEGIN
        kl.setfullcustomeraddress(p_rnk           => l_rnk
                                 ,p_typeid        => 2
                                 ,p_country       => '804'
                                 ,p_zip           => l_adr_reg_postal_code
                                 ,p_domain        => l_adr_reg_region
                                 ,p_region        => l_adr_reg_area
                                 ,p_locality      => l_adr_reg_locality
                                 ,p_address       => l_adr_reg_full_address
                                 ,p_territoryid   => NULL
                                 ,p_locality_type => NULL
                                 ,p_street_type   => NULL
                                 ,p_street        => NULL
                                 ,p_home_type     => NULL
                                 ,p_home          => NULL
                                 ,p_homepart_type => NULL
                                 ,p_homepart      => NULL
                                 ,p_room_type     => NULL
                                 ,p_room          => NULL
                                 ,p_comment       => NULL
                                 ,p_flag_visa     => 0);
      END;
    ELSIF l_adr_reg_like_live = 0 THEN
      BEGIN
        kl.setfullcustomeraddress(p_rnk           => l_rnk
                                 ,p_typeid        => 2
                                 ,p_country       => '804'
                                 ,p_zip           => l_adr_fact_postal_code
                                 ,p_domain        => l_adr_fact_region
                                 ,p_region        => l_adr_fact_area
                                 ,p_locality      => l_adr_fact_locality
                                 ,p_address       => l_adr_fact_full_address
                                 ,p_territoryid   => NULL
                                 ,p_locality_type => NULL
                                 ,p_street_type   => NULL
                                 ,p_street        => NULL
                                 ,p_home_type     => NULL
                                 ,p_home          => NULL
                                 ,p_homepart_type => NULL
                                 ,p_homepart      => NULL
                                 ,p_room_type     => NULL
                                 ,p_room          => NULL
                                 ,p_comment       => NULL
                                 ,p_flag_visa     => 0);
      END;
    END IF;
    -- �������� ���������� ��� ������� � ������ �볺���

    -- RAISE_APPLICATION_ERROR(-20005,l_subsidy_avaliable);
    IF l_subsidy_doc_type = '����' THEN
      l_subsidy_doc_type := l_subsidy_doc_type_txt;
    END IF;
    kl.setcustomerelement(l_rnk, 'SUBSN', l_subsidy_numb, 0, 0);
    -- RAISE_APPLICATION_ERROR (-20009,l_subsidy_numb);
    kl.setcustomerelement(l_rnk, 'SUBSD', l_subsidy_date, 0, 0);
    kl.setcustomerelement(l_rnk, 'SUBDT', l_subsidy_doc_type, 0, 0);
    kl.setcustomerelement(l_rnk, 'SUBS', l_subsidy_avaliable, 0, 0);

    -- ������������ ��������� ����������� ���. ����
    kl.setpersonattr(l_rnk
                    ,l_sex
                    , -- ��� (+1 ��� ���������� � ����������� �����)
                     1
                    , -- �������� �������
                     l_doc_ser
                    , -- ����� ��������
                     l_doc_num
                    , -- ����� ��������
                     l_doc_dat
                    , -- ���� ������ ��������
                     l_doc_organ
                    , -- ��� ����� �������
                     l_bdat
                    , -- ���� ��������
                     NULL
                    , -- ����� ��������
                     l_tel_prime
                    , -- ���������� �������
                     l_tel_home -- �������������� �������
                     );

    -- =========================
    -- ������������ �����������

    -- DATZ - ���� ���������� ������
    kl.setcustomerelement(l_rnk, 'DATZ', to_char(SYSDATE, 'dd/mm/yyyy'), 0);
    -- MPNO - ����� ��������� ��������
    kl.setcustomerelement(l_rnk, 'MPNO', l_tel_mob, 0);
    -- EMAIL - ������ ���������� �����
    kl.setcustomerelement(l_rnk, 'EMAIL', l_e_mail, 0);
    -- MN - ĳ���� ������� (���� ��� ����)
    IF (l_sex = 1) THEN
      kl.setcustomerelement(l_rnk, 'MN', l_maiden_name, 0);
    END IF;
    -- MMN - ������� ������� ������ �������
    kl.setcustomerelement(l_rnk, 'MMN', l_mother_maiden_name, 0);
    -- SN_GC - ϲ� �볺��� � �������� ������
    kl.setcustomerelement(l_rnk, 'SN_GC', l_fio_r, 0);

    -- ������������� ������������ ����������� ��� ���������
    -- !!!! �������� ��� �������������

    bars_audit.trace(g_pack_name || l_proc_name || 'Finish.  RNK=' ||
                     to_char(l_rnk));
    RETURN l_rnk;
  END register_client;

  -- ����������� ��� ��������
  PROCEDURE reg_servise_app_pay_client(p_bid_id IN NUMBER -- ������������� ������
                                       ) IS

    l_sum NUMBER(20, 2);
  BEGIN
    /*
        SV0K1    ������ ���i�i�, %
        SV1RK    ����-���.����., %
      + SV2PW    �����.�������, ���i���, %
        SV3CV    �����.�����, ���i���, %
        SV4TI    �����.������, ���i���(3 �), %
        SV5GO    �����.���.�i����, ���
      + SV6NO    ������� �����i���, ���
        SV7RE    ������� �������., ���
        SV8MI    �������� ����, % �i� �������
        SV9PF    ����i��.����, % �i� �������
      + SV:BT    ������� ��I(����), ���
    */
    -- ��������� ���������� ���������� �����
    l_sum := nvl(to_number2(wcs_utl.get_answ(p_bid_id, 'CL_0_113')), 0);

    cck_app.set_nd_txt(p_bid_id, 'SV7RE', l_sum);

    -- ������������ - ������ ��������� ������� - � ���� ������ ������� ��  ������ ��
    l_sum := nvl(to_number2(wcs_utl.get_answ(p_bid_id, 'CL_0_121')), 0) +
             nvl(to_number2(wcs_utl.get_answ(p_bid_id, 'CL_0_122')), 0) +
             nvl(to_number2(wcs_utl.get_answ(p_bid_id, 'CL_0_123')), 0) +
             nvl(to_number2(wcs_utl.get_answ(p_bid_id, 'CL_0_124')), 0) +
             nvl(to_number2(wcs_utl.get_answ(p_bid_id, 'CL_0_125')), 0) +
             nvl(to_number2(wcs_utl.get_answ(p_bid_id, 'CL_0_126')), 0);

    cck_app.set_nd_txt(p_bid_id, 'SV2PW', l_sum);
    -- ��������� �������� - ����������

    l_sum :=  /*nvl(to_number2(wcs_utl.get_answ(p_bid_id, 'CL_0_114')), 0) +
                                                             nvl(to_number2(wcs_utl.get_answ(p_bid_id, 'CL_0_115')), 0) +
                                                             nvl(to_number2(wcs_utl.get_answ(p_bid_id, 'CL_0_116')), 0) +
                                                             nvl(to_number2(wcs_utl.get_answ(p_bid_id, 'CL_0_117')), 0) +
                                                             nvl(to_number2(wcs_utl.get_answ(p_bid_id, 'CL_0_118')), 0) +
                                                             nvl(to_number2(wcs_utl.get_answ(p_bid_id, 'CL_0_119')), 0)*/
     nvl(to_number2(wcs_utl.get_answ(p_bid_id, 'CL_0_260')), 0);

    cck_app.set_nd_txt(p_bid_id, 'SV6NO', l_sum);

    -- ���� ������
    cck_app.set_nd_txt(p_bid_id
                      ,'INTRT'
                      ,wcs_utl.get_creditdata(p_bid_id, 'INTEREST_RATE'));

    l_sum := nvl(to_number2(wcs_utl.get_answ(p_bid_id, 'CL_0_120')), 0) +
             nvl(to_number2(wcs_utl.get_answ(p_bid_id, 'CL_0_128')), 0) +
             nvl(to_number2(wcs_utl.get_answ(p_bid_id, 'CL_0_129')), 0);

    cck_app.set_nd_txt(p_bid_id, 'SV:BT', l_sum);

    NULL;

  END;
  -- �������� ��������/��������� ������ �볺���

  PROCEDURE p_set_adr_to_comp_prg
  (
    p_bid_id    IN v_wcs_bids.bid_id%TYPE
   , -- ������������� ������
    p_ws_id     IN wcs_answers.ws_id%TYPE DEFAULT wcs_utl.g_cur_ws_id
   , -- ������������� �������� ������������
    p_ws_number IN wcs_answers.ws_number%TYPE DEFAULT wcs_utl.g_cur_ws_num -- ����� �������� ������������
  ) AS
    --���������� �� ����������� ����� "��������������� ������ ���������"
    l_adr_reg_like_live NUMBER := to_number(wcs_utl.get_answ(p_bid_id
                                                            ,'CL_0_188'
                                                            ,p_ws_id
                                                            ,p_ws_number)); -- ������ ���� ���������� � ��������� ����������?

    prg_adr_1_use_reg_adr NUMBER(17) := wcs_utl.get_answ(p_bid_id
                                                        ,'PRG_ADR_1_USE_REG_ADR'
                                                        ,p_ws_id
                                                        ,p_ws_number);
    prg_adr_2_use_reg_adr NUMBER(17) := wcs_utl.get_answ(p_bid_id
                                                        ,'PRG_ADR_2_USE_REG_ADR'
                                                        ,p_ws_id
                                                        ,p_ws_number);
    prg_adr_3_use_reg_adr NUMBER(17) := wcs_utl.get_answ(p_bid_id
                                                        ,'PRG_ADR_3_USE_REG_ADR'
                                                        ,p_ws_id
                                                        ,p_ws_number);
    --���������� �� ����������� ����� "��������������� �������� ������"
    prg_adr_1_use_fact_adr NUMBER(17) := wcs_utl.get_answ(p_bid_id
                                                         ,'PRG_ADR_1_USE_FACT_ADR'
                                                         ,p_ws_id
                                                         ,p_ws_number);
    prg_adr_2_use_fact_adr NUMBER(17) := wcs_utl.get_answ(p_bid_id
                                                         ,'PRG_ADR_2_USE_FACT_ADR'
                                                         ,p_ws_id
                                                         ,p_ws_number);
    prg_adr_3_use_fact_adr NUMBER(17) := wcs_utl.get_answ(p_bid_id
                                                         ,'PRG_ADR_3_USE_FACT_ADR'
                                                         ,p_ws_id
                                                         ,p_ws_number);

    -- ������ ���������
    l_reg_settlement_id   NUMBER(17) := wcs_utl.get_answ_refer(p_bid_id
                                                              ,'ADR_REG_SETTLEMENT_ID'
                                                              ,p_ws_id
                                                              ,p_ws_number); -- ��� ���������� ������
    l_adr_1_settlement_id NUMBER(17) := wcs_utl.get_answ_refer(p_bid_id
                                                              ,'PRG_ADR_1_SETTLEMENT_ID'
                                                              ,p_ws_id
                                                              ,p_ws_number);
    l_adr_2_settlement_id NUMBER(17) := wcs_utl.get_answ_refer(p_bid_id
                                                              ,'PRG_ADR_2_SETTLEMENT_ID'
                                                              ,p_ws_id
                                                              ,p_ws_number);
    l_adr_3_settlement_id NUMBER(17) := wcs_utl.get_answ_refer(p_bid_id
                                                              ,'PRG_ADR_3_SETTLEMENT_ID'
                                                              ,p_ws_id
                                                              ,p_ws_number);
    l_adr_reg_street_id   NUMBER(17) := wcs_utl.get_answ_refer(p_bid_id
                                                              ,'ADR_REG_STREET_ID'
                                                              ,p_ws_id
                                                              ,p_ws_number); -- ��� ������
    l_adr_1_street_id     NUMBER(17) := wcs_utl.get_answ_refer(p_bid_id
                                                              ,'PRG_ADR_1_STREET_ID'
                                                              ,p_ws_id
                                                              ,p_ws_number); -- ��� ������
    l_adr_2_street_id     NUMBER(17) := wcs_utl.get_answ_refer(p_bid_id
                                                              ,'PRG_ADR_2_STREET_ID'
                                                              ,p_ws_id
                                                              ,p_ws_number); -- ��� ������
    l_adr_3_street_id     NUMBER(17) := wcs_utl.get_answ_refer(p_bid_id
                                                              ,'PRG_ADR_3_STREET_ID'
                                                              ,p_ws_id
                                                              ,p_ws_number); -- ��� ������
    l_fact_settlement_id  NUMBER(17) := wcs_utl.get_answ_refer(p_bid_id
                                                              ,'ADR_FACT_SETTLEMENT_ID'
                                                              ,p_ws_id
                                                              ,p_ws_number); -- ��� ���������� ������
    l_adr_fact_street_id  NUMBER(17) := wcs_utl.get_answ_refer(p_bid_id
                                                              ,'ADR_FACT_STREET_ID'
                                                              ,p_ws_id
                                                              ,p_ws_number); -- ��� ������

    l_adr_reg_region        VARCHAR2(255); -- �������
    l_adr_reg_area          VARCHAR2(255); -- �����
    l_adr_reg_locality      VARCHAR2(255); -- ����/��������� �����
    l_adr_reg_locality_type VARCHAR2(255); -- ����/��������� �����
    l_adr_reg_street        VARCHAR2(255); -- ����� ������
    l_adr_reg_street_type   VARCHAR2(255);
    l_adr_reg_full_address  VARCHAR2(2000);

    l_adr_reg_home          VARCHAR2(255) := wcs_utl.get_answ(p_bid_id
                                                             ,'ADR_REG_HOME'
                                                             ,p_ws_id
                                                             ,p_ws_number);
    l_adr_reg_home_type     VARCHAR2(255) := wcs_utl.get_answ_refer(p_bid_id
                                                                   ,'ADR_REG_HOME_TYPE'
                                                                   ,p_ws_id
                                                                   ,p_ws_number);
    l_adr_reg_homepart      VARCHAR2(255) := wcs_utl.get_answ(p_bid_id
                                                             ,'ADR_REG_HOMEPART'
                                                             ,p_ws_id
                                                             ,p_ws_number);
    l_adr_reg_homepart_type VARCHAR2(255) := wcs_utl.get_answ(p_bid_id
                                                             ,'ADR_REG_HOMEPART_TYPE'
                                                             ,p_ws_id
                                                             ,p_ws_number);

    l_adr_reg_room      VARCHAR2(255) := wcs_utl.get_answ(p_bid_id
                                                         ,'ADR_REG_ROOM'
                                                         ,p_ws_id
                                                         ,p_ws_number);
    l_adr_reg_room_type VARCHAR2(255) := wcs_utl.get_answ(p_bid_id
                                                         ,'ADR_REG_ROOM_TYPE'
                                                         ,p_ws_id
                                                         ,p_ws_number);

    l_adr_fact_region        VARCHAR2(255); -- �������
    l_adr_fact_area          VARCHAR2(255); -- �����
    l_adr_fact_locality      VARCHAR2(255); -- ����/��������� �����
    l_adr_fact_locality_type VARCHAR2(255); -- ����/��������� �����
    l_adr_fact_street        VARCHAR2(255); -- ����� ������
    l_adr_fact_street_type   VARCHAR2(255);
    l_adr_fact_full_address  VARCHAR2(2000);
    l_adr_fact_home          VARCHAR2(255) := wcs_utl.get_answ(p_bid_id
                                                              ,'ADR_FACT_HOME'
                                                              ,p_ws_id
                                                              ,p_ws_number);
    l_adr_fact_home_type     VARCHAR2(255) := wcs_utl.get_answ_refer(p_bid_id
                                                                    ,'ADR_FACT_HOME_TYPE'
                                                                    ,p_ws_id
                                                                    ,p_ws_number);
    l_adr_fact_homepart      VARCHAR2(255) := wcs_utl.get_answ(p_bid_id
                                                              ,'ADR_FACT_HOMEPART'
                                                              ,p_ws_id
                                                              ,p_ws_number);
    l_adr_fact_homepart_type VARCHAR2(255) := wcs_utl.get_answ(p_bid_id
                                                              ,'ADR_FACT_HOMEPART_TYPE'
                                                              ,p_ws_id
                                                              ,p_ws_number);

    l_adr_fact_room       VARCHAR2(255) := wcs_utl.get_answ(p_bid_id
                                                           ,'ADR_FACT_ROOM'
                                                           ,p_ws_id
                                                           ,p_ws_number);
    l_adr_fact_room_type  VARCHAR2(255) := wcs_utl.get_answ(p_bid_id
                                                           ,'ADR_FACT_ROOM_TYPE'
                                                           ,p_ws_id
                                                           ,p_ws_number);
    l_adr_1_region        VARCHAR2(255); -- �������
    l_adr_1_area          VARCHAR2(255); -- �����
    l_adr_1_locality      VARCHAR2(255); -- ����/��������� �����
    l_adr_1_locality_type VARCHAR2(255); -- ����/��������� �����
    l_adr_1_street        VARCHAR2(255); -- ����� ������
    l_adr_1_street_type   VARCHAR2(255);
    l_adr_1_full_address  VARCHAR2(2000);

    l_adr_1_home          VARCHAR2(255) := wcs_utl.get_answ(p_bid_id
                                                           ,'PRG_ADR_1_HOME'
                                                           ,p_ws_id
                                                           ,p_ws_number);
    l_adr_1_home_type     VARCHAR2(255) := wcs_utl.get_answ_refer(p_bid_id
                                                                 ,'PRG_ADR_1_HOME_TYPE'
                                                                 ,p_ws_id
                                                                 ,p_ws_number);
    l_adr_1_homepart      VARCHAR2(255) := wcs_utl.get_answ(p_bid_id
                                                           ,'PRG_ADR_1_HOMEPART'
                                                           ,p_ws_id
                                                           ,p_ws_number);
    l_adr_1_homepart_type VARCHAR2(255) := wcs_utl.get_answ(p_bid_id
                                                           ,'PRG_ADR_1_HOMEPART_TYPE'
                                                           ,p_ws_id
                                                           ,p_ws_number);

    l_adr_1_room      VARCHAR2(255) := wcs_utl.get_answ(p_bid_id
                                                       ,'PRG_ADR_1_ROOM'
                                                       ,p_ws_id
                                                       ,p_ws_number);
    l_adr_1_room_type VARCHAR2(255) := wcs_utl.get_answ(p_bid_id
                                                       ,'PRG_ADR_1_ROOM_TYPE'
                                                       ,p_ws_id
                                                       ,p_ws_number);

    l_adr_2_region        VARCHAR2(255); -- �������
    l_adr_2_area          VARCHAR2(255); -- �����
    l_adr_2_locality      VARCHAR2(255); -- ����/��������� �����
    l_adr_2_locality_type VARCHAR2(255); -- ����/��������� �����
    l_adr_2_street        VARCHAR2(255); -- ����� ������
    l_adr_2_street_type   VARCHAR2(255);
    l_adr_2_full_address  VARCHAR2(2000);

    l_adr_2_home          VARCHAR2(255) := wcs_utl.get_answ(p_bid_id
                                                           ,'PRG_ADR_2_HOME'
                                                           ,p_ws_id
                                                           ,p_ws_number);
    l_adr_2_home_type     VARCHAR2(255) := wcs_utl.get_answ_refer(p_bid_id
                                                                 ,'PRG_ADR_2_HOME_TYPE'
                                                                 ,p_ws_id
                                                                 ,p_ws_number);
    l_adr_2_homepart      VARCHAR2(255) := wcs_utl.get_answ(p_bid_id
                                                           ,'PRG_ADR_2_HOMEPART'
                                                           ,p_ws_id
                                                           ,p_ws_number);
    l_adr_2_homepart_type VARCHAR2(255) := wcs_utl.get_answ(p_bid_id
                                                           ,'PRG_ADR_2_HOMEPART_TYPE'
                                                           ,p_ws_id
                                                           ,p_ws_number);

    l_adr_2_room      VARCHAR2(255) := wcs_utl.get_answ(p_bid_id
                                                       ,'PRG_ADR_2_ROOM'
                                                       ,p_ws_id
                                                       ,p_ws_number);
    l_adr_2_room_type VARCHAR2(255) := wcs_utl.get_answ(p_bid_id
                                                       ,'PRG_ADR_2_ROOM_TYPE'
                                                       ,p_ws_id
                                                       ,p_ws_number);

    l_adr_3_region        VARCHAR2(255); -- �������
    l_adr_3_area          VARCHAR2(255); -- �����
    l_adr_3_locality      VARCHAR2(255); -- ����/��������� �����
    l_adr_3_locality_type VARCHAR2(255); -- ����/��������� �����
    l_adr_3_street        VARCHAR2(255); -- ����� ������
    l_adr_3_street_type   VARCHAR2(255);
    l_adr_3_full_address  VARCHAR2(2000);
    l_adr_3_home          VARCHAR2(255) := wcs_utl.get_answ(p_bid_id
                                                           ,'PRG_ADR_3_HOME'
                                                           ,p_ws_id
                                                           ,p_ws_number);
    l_adr_3_home_type     VARCHAR2(255) := wcs_utl.get_answ_refer(p_bid_id
                                                                 ,'PRG_ADR_3_HOME_TYPE'
                                                                 ,p_ws_id
                                                                 ,p_ws_number);
    l_adr_3_homepart      VARCHAR2(255) := wcs_utl.get_answ(p_bid_id
                                                           ,'PRG_ADR_3_HOMEPART'
                                                           ,p_ws_id
                                                           ,p_ws_number);
    l_adr_3_homepart_type VARCHAR2(255) := wcs_utl.get_answ(p_bid_id
                                                           ,'PRG_ADR_3_HOMEPART_TYPE'
                                                           ,p_ws_id
                                                           ,p_ws_number);

    l_adr_3_room      VARCHAR2(255) := wcs_utl.get_answ(p_bid_id
                                                       ,'PRG_ADR_3_ROOM'
                                                       ,p_ws_id
                                                       ,p_ws_number);
    l_adr_3_room_type VARCHAR2(255) := wcs_utl.get_answ(p_bid_id
                                                       ,'PRG_ADR_3_ROOM_TYPE'
                                                       ,p_ws_id
                                                       ,p_ws_number);

  BEGIN
    IF l_fact_settlement_id IS NOT NULL THEN
      BEGIN
        SELECT t.region_name
              ,t.area_name
               /*,t.settlement_type || ' ' || */
              ,t.settlement_name
              ,t.settlement_type
          INTO l_adr_fact_region
              ,l_adr_fact_area
              ,l_adr_fact_locality
              ,l_adr_fact_locality_type
          FROM vw_escr_address t
         WHERE t.settlement_id = l_fact_settlement_id;
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
        WHEN OTHERS THEN
          NULL;
      END;

    ELSE
      l_adr_fact_region        := wcs_utl.get_answ_text(p_bid_id
                                                       ,'ADR_FACT_REGION'
                                                       ,p_ws_id
                                                       ,p_ws_number);
      l_adr_fact_area          := wcs_utl.get_answ_text(p_bid_id
                                                       ,'ADR_FACT_AREA'
                                                       ,p_ws_id
                                                       ,p_ws_number);
      l_adr_fact_locality_type := wcs_utl.get_answ_refer_text(p_bid_id
                                                             ,'ADR_FACT_LOCALITY_TYPE'
                                                             ,p_ws_id
                                                             ,p_ws_number);
      l_adr_fact_locality      := wcs_utl.get_answ_text(p_bid_id
                                                       ,'ADR_FACT_LOCALITY'
                                                       ,p_ws_id
                                                       ,p_ws_number);
    END IF;
    IF l_fact_settlement_id = 1 THEN
      l_adr_fact_region := '';
    END IF;

    IF l_reg_settlement_id IS NOT NULL THEN
      BEGIN
        SELECT t.region_name
              ,t.area_name
               /*,t.settlement_type || ' ' || */
              ,t.settlement_name
              ,t.settlement_type
          INTO l_adr_reg_region
              ,l_adr_reg_area
              ,l_adr_reg_locality
              ,l_adr_reg_locality_type
          FROM vw_escr_address t
         WHERE t.settlement_id = l_reg_settlement_id;
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
        WHEN OTHERS THEN
          NULL;
      END;
    ELSE
      l_adr_reg_region        := wcs_utl.get_answ_text(p_bid_id
                                                      ,'ADR_REG_REGION'
                                                      ,p_ws_id
                                                      ,p_ws_number);
      l_adr_reg_area          := wcs_utl.get_answ_text(p_bid_id
                                                      ,'ADR_REG_AREA'
                                                      ,p_ws_id
                                                      ,p_ws_number);
      l_adr_reg_locality_type := wcs_utl.get_answ_refer_text(p_bid_id
                                                            ,'ADR_REG_LOCALITY_TYPE'
                                                            ,p_ws_id
                                                            ,p_ws_number);
      l_adr_reg_locality      := wcs_utl.get_answ_text(p_bid_id
                                                      ,'ADR_REG_LOCALITY'
                                                      ,p_ws_id
                                                      ,p_ws_number);
    END IF;
    IF l_reg_settlement_id = 1 THEN
      l_adr_reg_region := '';
    END IF;
    IF l_adr_1_settlement_id IS NOT NULL THEN
      BEGIN
        SELECT t.region_name
              ,t.area_name
               /* ,t.settlement_type || ' ' ||*/
              ,t.settlement_name
              ,t.settlement_type
          INTO l_adr_1_region
              ,l_adr_1_area
              ,l_adr_1_locality
              ,l_adr_1_locality_type
          FROM vw_escr_address t
         WHERE t.settlement_id = l_adr_1_settlement_id;
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
        WHEN OTHERS THEN
          NULL;
      END;
    ELSE
      l_adr_1_region        := wcs_utl.get_answ_text(p_bid_id
                                                    ,'PRG_ADR_1_REGION'
                                                    ,p_ws_id
                                                    ,p_ws_number);
      l_adr_1_area          := wcs_utl.get_answ_text(p_bid_id
                                                    ,'PRG_ADR_1_AREA'
                                                    ,p_ws_id
                                                    ,p_ws_number);
      l_adr_1_locality_type := wcs_utl.get_answ_refer_text(p_bid_id
                                                          ,'PRG_ADR_1_LOCALITY_TYPE'
                                                          ,p_ws_id
                                                          ,p_ws_number);
      l_adr_1_locality      := wcs_utl.get_answ_text(p_bid_id
                                                    ,'PRG_ADR_1_LOCALITY'
                                                    ,p_ws_id
                                                    ,p_ws_number);

    END IF;
    IF l_adr_1_settlement_id = 1 THEN
      l_adr_1_region := '';
    END IF;
    IF l_adr_2_settlement_id IS NOT NULL THEN
      BEGIN
        SELECT t.region_name
              ,t.area_name
               /* ,t.settlement_type || ' ' ||*/
              ,t.settlement_name
              ,t.settlement_type
          INTO l_adr_2_region
              ,l_adr_2_area
              ,l_adr_2_locality
              ,l_adr_2_locality_type
          FROM vw_escr_address t
         WHERE t.settlement_id = l_adr_2_settlement_id;
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
        WHEN OTHERS THEN
          NULL;
      END;
    ELSE

      l_adr_2_region        := wcs_utl.get_answ_text(p_bid_id
                                                    ,'PRG_ADR_2_REGION'
                                                    ,p_ws_id
                                                    ,p_ws_number);
      l_adr_2_area          := wcs_utl.get_answ_text(p_bid_id
                                                    ,'PRG_ADR_2_AREA'
                                                    ,p_ws_id
                                                    ,p_ws_number);
      l_adr_2_locality_type := wcs_utl.get_answ_refer_text(p_bid_id
                                                          ,'PRG_ADR_2_LOCALITY_TYPE'
                                                          ,p_ws_id
                                                          ,p_ws_number);
      l_adr_2_locality      := wcs_utl.get_answ_text(p_bid_id
                                                    ,'PRG_ADR_2_LOCALITY'
                                                    ,p_ws_id
                                                    ,p_ws_number);

    END IF;
    IF l_adr_2_settlement_id = 1 THEN
      l_adr_2_region := '';
    END IF;
    IF l_adr_3_settlement_id IS NOT NULL THEN
      BEGIN
        SELECT t.region_name
              ,t.area_name
               /* ,t.settlement_type || ' ' ||*/
              ,t.settlement_name
              ,t.settlement_type
          INTO l_adr_3_region
              ,l_adr_3_area
              ,l_adr_3_locality
              ,l_adr_3_locality_type
          FROM vw_escr_address t
         WHERE t.settlement_id = l_adr_3_settlement_id;
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
        WHEN OTHERS THEN
          NULL;
      END;
    ELSE

      l_adr_3_region        := wcs_utl.get_answ_text(p_bid_id
                                                    ,'PRG_ADR_3_REGION'
                                                    ,p_ws_id
                                                    ,p_ws_number);
      l_adr_3_area          := wcs_utl.get_answ_text(p_bid_id
                                                    ,'PRG_ADR_3_AREA'
                                                    ,p_ws_id
                                                    ,p_ws_number);
      l_adr_3_locality_type := wcs_utl.get_answ_refer_text(p_bid_id
                                                          ,'PRG_ADR_3_LOCALITY_TYPE'
                                                          ,p_ws_id
                                                          ,p_ws_number);
      l_adr_3_locality      := wcs_utl.get_answ_text(p_bid_id
                                                    ,'PRG_ADR_3_LOCALITY'
                                                    ,p_ws_id
                                                    ,p_ws_number);
    END IF;
    IF l_adr_3_settlement_id = 1 THEN
      l_adr_3_region := '';
    END IF;
    IF l_adr_reg_street_id IS NOT NULL THEN
      BEGIN
        SELECT t.str_tp_nm, t.street_name

          INTO l_adr_reg_street_type, l_adr_reg_street
          FROM vw_adr_streets t
         WHERE t.street_id = l_adr_reg_street_id
           AND t.settlement_id = l_reg_settlement_id;
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
        WHEN OTHERS THEN
          NULL;
      END;
    ELSE
      l_adr_reg_street_type := wcs_utl.get_answ_refer(p_bid_id
                                                     ,'ADR_REG_STREET_TYPE'
                                                     ,p_ws_id
                                                     ,p_ws_number);
      l_adr_reg_street      := wcs_utl.get_answ_text(p_bid_id
                                                    ,'ADR_REG_STREET'
                                                    ,p_ws_id
                                                    ,p_ws_number);
    END IF;

    IF l_fact_settlement_id IS NOT NULL THEN
      BEGIN
        SELECT t.region_name
              ,t.area_name
               /* ,t.settlement_type || ' ' || */
              ,t.settlement_name
              ,t.settlement_type
          INTO l_adr_fact_region
              ,l_adr_fact_area
              ,l_adr_fact_locality
              ,l_adr_fact_locality_type
          FROM vw_escr_address t
         WHERE t.settlement_id = l_fact_settlement_id;

      EXCEPTION
        WHEN no_data_found THEN
          NULL;
        WHEN OTHERS THEN
          NULL;

      END;

    ELSE
      l_adr_fact_region        := wcs_utl.get_answ_text(p_bid_id
                                                       ,'ADR_FACT_REGION'
                                                       ,p_ws_id
                                                       ,p_ws_number);
      l_adr_fact_area          := wcs_utl.get_answ_text(p_bid_id
                                                       ,'ADR_FACT_AREA'
                                                       ,p_ws_id
                                                       ,p_ws_number);
      l_adr_fact_locality_type := wcs_utl.get_answ_refer_text(p_bid_id
                                                             ,'ADR_FACT_LOCALITY_TYPE'
                                                             ,p_ws_id
                                                             ,p_ws_number);
      l_adr_fact_locality      := wcs_utl.get_answ_text(p_bid_id
                                                       ,'ADR_FACT_LOCALITY'
                                                       ,p_ws_id
                                                       ,p_ws_number);

    END IF;
    --l_adr_1_settlement_id
    IF l_adr_fact_street_id IS NOT NULL THEN
      BEGIN
        SELECT t.str_tp_nm, t.street_name
          INTO l_adr_fact_street_type, l_adr_fact_street
          FROM vw_adr_streets t
         WHERE t.street_id = l_adr_fact_street_id
           AND t.settlement_id = l_fact_settlement_id;

      EXCEPTION
        WHEN no_data_found THEN
          NULL;
        WHEN OTHERS THEN
          NULL;

      END;

    ELSE
      l_adr_fact_street_type := wcs_utl.get_answ_refer(p_bid_id
                                                      ,'ADR_FACT_STREET_TYPE'
                                                      ,p_ws_id
                                                      ,p_ws_number);
      l_adr_fact_street      := wcs_utl.get_answ_text(p_bid_id
                                                     ,'ADR_FACT_STREET'
                                                     ,p_ws_id
                                                     ,p_ws_number);
    END IF;
    -- l_adr_1_settlement_id
    IF l_adr_1_street_id IS NOT NULL THEN
      BEGIN
        SELECT t.str_tp_nm, t.street_name
          INTO l_adr_1_street_type, l_adr_1_street
          FROM vw_adr_streets t
         WHERE t.street_id = l_adr_1_street_id
           AND t.settlement_id = l_adr_1_settlement_id;

      EXCEPTION
        WHEN no_data_found THEN
          NULL;
        WHEN OTHERS THEN
          NULL;

      END;

    ELSE
      l_adr_1_street_type := wcs_utl.get_answ_refer(p_bid_id
                                                   ,'PRG_ADR_1_STREET_TYPE'
                                                   ,p_ws_id
                                                   ,p_ws_number);
      l_adr_1_street      := wcs_utl.get_answ_text(p_bid_id
                                                  ,'PRG_ADR_1_STREET'
                                                  ,p_ws_id
                                                  ,p_ws_number);
    END IF;
    IF l_adr_2_street_id IS NOT NULL THEN
      BEGIN
        SELECT t.str_tp_nm, t.street_name
          INTO l_adr_2_street_type, l_adr_2_street
          FROM vw_adr_streets t
         WHERE t.street_id = l_adr_2_street_id
           AND t.settlement_id = l_adr_2_settlement_id;

      EXCEPTION
        WHEN no_data_found THEN
          NULL;
        WHEN OTHERS THEN
          NULL;

      END;

    ELSE
      l_adr_2_street_type := wcs_utl.get_answ_refer(p_bid_id
                                                   ,'PRG_ADR_2_STREET_TYPE'
                                                   ,p_ws_id
                                                   ,p_ws_number);
      l_adr_2_street      := wcs_utl.get_answ_text(p_bid_id
                                                  ,'PRG_ADR_2_STREET'
                                                  ,p_ws_id
                                                  ,p_ws_number);
    END IF;
    IF l_adr_3_street_id IS NOT NULL THEN
      BEGIN
        SELECT t.str_tp_nm, t.street_name
          INTO l_adr_3_street_type, l_adr_3_street
          FROM vw_adr_streets t
         WHERE t.street_id = l_adr_3_street_id
           AND t.settlement_id = l_adr_3_settlement_id;

      EXCEPTION
        WHEN no_data_found THEN
          NULL;
        WHEN OTHERS THEN
          NULL;

      END;

    ELSE
      l_adr_3_street_type := wcs_utl.get_answ_refer(p_bid_id
                                                   ,'PRG_ADR_3_STREET_TYPE'
                                                   ,p_ws_id
                                                   ,p_ws_number);
      l_adr_3_street      := wcs_utl.get_answ_text(p_bid_id
                                                  ,'PRG_ADR_3_STREET'
                                                  ,p_ws_id
                                                  ,p_ws_number);
    END IF;
    --���������� ��� �� ����� 1
    IF prg_adr_1_use_reg_adr = 1
       AND prg_adr_1_use_fact_adr = 0
       AND (l_adr_reg_like_live = 1 OR l_adr_reg_like_live = 0) THEN
      cck_app.set_nd_txt(p_bid_id, 'ES069', l_adr_reg_locality_type);
      cck_app.set_nd_txt(p_bid_id, 'ES070', l_adr_reg_locality);
      cck_app.set_nd_txt(p_bid_id, 'ES072', l_adr_reg_area);
      cck_app.set_nd_txt(p_bid_id, 'ES074', l_adr_reg_region);
      cck_app.set_nd_txt(p_bid_id, 'ES075', l_adr_reg_street_type);
      cck_app.set_nd_txt(p_bid_id, 'ES076', l_adr_reg_street);
      cck_app.set_nd_txt(p_bid_id, 'ES077', l_adr_reg_homepart_type);
      cck_app.set_nd_txt(p_bid_id, 'ES078', l_adr_reg_homepart);
      cck_app.set_nd_txt(p_bid_id, 'ES079', l_adr_reg_home_type);
      cck_app.set_nd_txt(p_bid_id, 'ES080', l_adr_reg_home);
      cck_app.set_nd_txt(p_bid_id, 'ES081', l_adr_reg_room_type);
      cck_app.set_nd_txt(p_bid_id, 'ES082', l_adr_reg_room);
    ELSIF prg_adr_1_use_reg_adr = 0
          AND prg_adr_1_use_fact_adr = 1
          AND l_adr_reg_like_live = 0 THEN
      cck_app.set_nd_txt(p_bid_id, 'ES069', l_adr_fact_locality_type);
      cck_app.set_nd_txt(p_bid_id, 'ES070', l_adr_fact_locality);
      cck_app.set_nd_txt(p_bid_id, 'ES072', l_adr_fact_area);
      cck_app.set_nd_txt(p_bid_id, 'ES074', l_adr_fact_region);
      cck_app.set_nd_txt(p_bid_id, 'ES075', l_adr_fact_street_type);
      cck_app.set_nd_txt(p_bid_id, 'ES076', l_adr_fact_street);
      cck_app.set_nd_txt(p_bid_id, 'ES077', l_adr_fact_homepart_type);
      cck_app.set_nd_txt(p_bid_id, 'ES078', l_adr_fact_homepart);
      cck_app.set_nd_txt(p_bid_id, 'ES079', l_adr_fact_home_type);
      cck_app.set_nd_txt(p_bid_id, 'ES080', l_adr_fact_home);
      cck_app.set_nd_txt(p_bid_id, 'ES081', l_adr_fact_room_type);
      cck_app.set_nd_txt(p_bid_id, 'ES082', l_adr_fact_room);
    ELSIF prg_adr_1_use_reg_adr = 0
          AND prg_adr_1_use_fact_adr = 1
          AND l_adr_reg_like_live = 1 THEN
      cck_app.set_nd_txt(p_bid_id, 'ES069', l_adr_reg_locality_type);
      cck_app.set_nd_txt(p_bid_id, 'ES070', l_adr_reg_locality);
      cck_app.set_nd_txt(p_bid_id, 'ES072', l_adr_reg_area);
      cck_app.set_nd_txt(p_bid_id, 'ES074', l_adr_reg_region);
      cck_app.set_nd_txt(p_bid_id, 'ES075', l_adr_reg_street_type);
      cck_app.set_nd_txt(p_bid_id, 'ES076', l_adr_reg_street);
      cck_app.set_nd_txt(p_bid_id, 'ES077', l_adr_reg_homepart_type);
      cck_app.set_nd_txt(p_bid_id, 'ES078', l_adr_reg_homepart);
      cck_app.set_nd_txt(p_bid_id, 'ES079', l_adr_reg_home_type);
      cck_app.set_nd_txt(p_bid_id, 'ES080', l_adr_reg_home);
      cck_app.set_nd_txt(p_bid_id, 'ES081', l_adr_reg_room_type);
      cck_app.set_nd_txt(p_bid_id, 'ES082', l_adr_reg_room);
    ELSE
      cck_app.set_nd_txt(p_bid_id, 'ES069', l_adr_1_locality_type);
      cck_app.set_nd_txt(p_bid_id, 'ES070', l_adr_1_locality);
      cck_app.set_nd_txt(p_bid_id, 'ES072', l_adr_1_area);
      cck_app.set_nd_txt(p_bid_id, 'ES074', l_adr_1_region);
      cck_app.set_nd_txt(p_bid_id, 'ES075', l_adr_1_street_type);
      cck_app.set_nd_txt(p_bid_id, 'ES076', l_adr_1_street);
      cck_app.set_nd_txt(p_bid_id, 'ES077', l_adr_1_homepart_type);
      cck_app.set_nd_txt(p_bid_id, 'ES078', l_adr_1_homepart);
      cck_app.set_nd_txt(p_bid_id, 'ES079', l_adr_1_home_type);
      cck_app.set_nd_txt(p_bid_id, 'ES080', l_adr_1_home);
      cck_app.set_nd_txt(p_bid_id, 'ES081', l_adr_1_room_type);
      cck_app.set_nd_txt(p_bid_id, 'ES082', l_adr_1_room);
    END IF;
    --���������� ��� �� ����� 2
    IF prg_adr_2_use_reg_adr = 1
       AND prg_adr_2_use_fact_adr = 0 THEN
      cck_app.set_nd_txt(p_bid_id, 'ES219', l_adr_reg_locality_type);
      cck_app.set_nd_txt(p_bid_id, 'ES220', l_adr_reg_locality);
      cck_app.set_nd_txt(p_bid_id, 'ES222', l_adr_reg_area);
      cck_app.set_nd_txt(p_bid_id, 'ES224', l_adr_reg_region);
      cck_app.set_nd_txt(p_bid_id, 'ES225', l_adr_reg_street_type);
      cck_app.set_nd_txt(p_bid_id, 'ES226', l_adr_reg_street);
      cck_app.set_nd_txt(p_bid_id, 'ES227', l_adr_reg_homepart_type);
      cck_app.set_nd_txt(p_bid_id, 'ES228', l_adr_reg_homepart);
      cck_app.set_nd_txt(p_bid_id, 'ES229', l_adr_reg_home_type);
      cck_app.set_nd_txt(p_bid_id, 'ES230', l_adr_reg_home);
      cck_app.set_nd_txt(p_bid_id, 'ES231', l_adr_reg_room_type);
      cck_app.set_nd_txt(p_bid_id, 'ES232', l_adr_reg_room);
    ELSIF prg_adr_2_use_reg_adr = 0
          AND prg_adr_2_use_fact_adr = 1
          AND l_adr_reg_like_live = 1 THEN

      cck_app.set_nd_txt(p_bid_id, 'ES219', l_adr_reg_locality_type);
      cck_app.set_nd_txt(p_bid_id, 'ES220', l_adr_reg_locality);
      cck_app.set_nd_txt(p_bid_id, 'ES222', l_adr_reg_area);
      cck_app.set_nd_txt(p_bid_id, 'ES224', l_adr_reg_region);
      cck_app.set_nd_txt(p_bid_id, 'ES225', l_adr_reg_street_type);
      cck_app.set_nd_txt(p_bid_id, 'ES226', l_adr_reg_street);
      cck_app.set_nd_txt(p_bid_id, 'ES227', l_adr_reg_homepart_type);
      cck_app.set_nd_txt(p_bid_id, 'ES228', l_adr_reg_homepart);
      cck_app.set_nd_txt(p_bid_id, 'ES229', l_adr_reg_home_type);
      cck_app.set_nd_txt(p_bid_id, 'ES230', l_adr_reg_home);
      cck_app.set_nd_txt(p_bid_id, 'ES231', l_adr_reg_room_type);
      cck_app.set_nd_txt(p_bid_id, 'ES232', l_adr_reg_room);

    ELSIF prg_adr_2_use_reg_adr = 0
          AND prg_adr_2_use_fact_adr = 1
          AND l_adr_reg_like_live = 0 THEN

      cck_app.set_nd_txt(p_bid_id, 'ES219', l_adr_fact_locality_type);
      cck_app.set_nd_txt(p_bid_id, 'ES220', l_adr_fact_locality);
      cck_app.set_nd_txt(p_bid_id, 'ES222', l_adr_fact_area);
      cck_app.set_nd_txt(p_bid_id, 'ES224', l_adr_fact_region);
      cck_app.set_nd_txt(p_bid_id, 'ES225', l_adr_fact_street_type);
      cck_app.set_nd_txt(p_bid_id, 'ES226', l_adr_fact_street);
      cck_app.set_nd_txt(p_bid_id, 'ES227', l_adr_fact_homepart_type);
      cck_app.set_nd_txt(p_bid_id, 'ES228', l_adr_fact_homepart);
      cck_app.set_nd_txt(p_bid_id, 'ES229', l_adr_fact_home_type);
      cck_app.set_nd_txt(p_bid_id, 'ES230', l_adr_fact_home);
      cck_app.set_nd_txt(p_bid_id, 'ES231', l_adr_fact_room_type);
      cck_app.set_nd_txt(p_bid_id, 'ES232', l_adr_fact_room);

    ELSE
      cck_app.set_nd_txt(p_bid_id, 'ES219', l_adr_2_locality_type);
      cck_app.set_nd_txt(p_bid_id, 'ES220', l_adr_2_locality);
      cck_app.set_nd_txt(p_bid_id, 'ES222', l_adr_2_area);
      cck_app.set_nd_txt(p_bid_id, 'ES224', l_adr_2_region);
      cck_app.set_nd_txt(p_bid_id, 'ES225', l_adr_2_street_type);
      cck_app.set_nd_txt(p_bid_id, 'ES226', l_adr_2_street);
      cck_app.set_nd_txt(p_bid_id, 'ES227', l_adr_2_homepart_type);
      cck_app.set_nd_txt(p_bid_id, 'ES228', l_adr_2_homepart);
      cck_app.set_nd_txt(p_bid_id, 'ES229', l_adr_2_home_type);
      cck_app.set_nd_txt(p_bid_id, 'ES230', l_adr_2_home);
      cck_app.set_nd_txt(p_bid_id, 'ES231', l_adr_2_room_type);
      cck_app.set_nd_txt(p_bid_id, 'ES232', l_adr_2_room);
    END IF;
    --���������� ��� �� ����� 3
    IF prg_adr_3_use_reg_adr = 1
       AND prg_adr_3_use_fact_adr = 0 THEN
      cck_app.set_nd_txt(p_bid_id, 'ES357', l_adr_reg_locality_type);
      cck_app.set_nd_txt(p_bid_id, 'ES358', l_adr_reg_locality);
      cck_app.set_nd_txt(p_bid_id, 'ES360', l_adr_reg_area);
      cck_app.set_nd_txt(p_bid_id, 'ES362', l_adr_reg_region);
      cck_app.set_nd_txt(p_bid_id, 'ES363', l_adr_reg_street_type);
      cck_app.set_nd_txt(p_bid_id, 'ES364', l_adr_reg_street);
      cck_app.set_nd_txt(p_bid_id, 'ES365', l_adr_fact_homepart_type);
      cck_app.set_nd_txt(p_bid_id, 'ES366', l_adr_fact_homepart);
      cck_app.set_nd_txt(p_bid_id, 'ES367', l_adr_reg_home_type);
      cck_app.set_nd_txt(p_bid_id, 'ES368', l_adr_reg_home);
      cck_app.set_nd_txt(p_bid_id, 'ES369', l_adr_reg_room_type);
      cck_app.set_nd_txt(p_bid_id, 'ES370', l_adr_reg_room);
    ELSIF prg_adr_3_use_reg_adr = 0
          AND prg_adr_3_use_fact_adr = 1
          AND l_adr_reg_like_live = 0 THEN
      cck_app.set_nd_txt(p_bid_id, 'ES357', l_adr_fact_locality_type);
      cck_app.set_nd_txt(p_bid_id, 'ES358', l_adr_fact_locality);
      cck_app.set_nd_txt(p_bid_id, 'ES360', l_adr_fact_area);
      cck_app.set_nd_txt(p_bid_id, 'ES362', l_adr_fact_region);
      cck_app.set_nd_txt(p_bid_id, 'ES363', l_adr_fact_street_type);
      cck_app.set_nd_txt(p_bid_id, 'ES364', l_adr_fact_street);
      cck_app.set_nd_txt(p_bid_id, 'ES365', l_adr_fact_homepart_type);
      cck_app.set_nd_txt(p_bid_id, 'ES366', l_adr_fact_homepart);
      cck_app.set_nd_txt(p_bid_id, 'ES367', l_adr_fact_home_type);
      cck_app.set_nd_txt(p_bid_id, 'ES368', l_adr_fact_home);
      cck_app.set_nd_txt(p_bid_id, 'ES369', l_adr_fact_room_type);
      cck_app.set_nd_txt(p_bid_id, 'ES370', l_adr_fact_room);
    ELSIF prg_adr_3_use_reg_adr = 0
          AND prg_adr_3_use_fact_adr = 1
          AND l_adr_reg_like_live = 1 THEN
      cck_app.set_nd_txt(p_bid_id, 'ES357', l_adr_reg_locality_type);
      cck_app.set_nd_txt(p_bid_id, 'ES358', l_adr_reg_locality);
      cck_app.set_nd_txt(p_bid_id, 'ES360', l_adr_reg_area);
      cck_app.set_nd_txt(p_bid_id, 'ES362', l_adr_reg_region);
      cck_app.set_nd_txt(p_bid_id, 'ES363', l_adr_reg_street_type);
      cck_app.set_nd_txt(p_bid_id, 'ES364', l_adr_reg_street);
      cck_app.set_nd_txt(p_bid_id, 'ES365', l_adr_fact_homepart_type);
      cck_app.set_nd_txt(p_bid_id, 'ES366', l_adr_fact_homepart);
      cck_app.set_nd_txt(p_bid_id, 'ES367', l_adr_reg_home_type);
      cck_app.set_nd_txt(p_bid_id, 'ES368', l_adr_reg_home);
      cck_app.set_nd_txt(p_bid_id, 'ES369', l_adr_reg_room_type);
      cck_app.set_nd_txt(p_bid_id, 'ES370', l_adr_reg_room);

    ELSIF prg_adr_3_use_reg_adr = 0
          AND prg_adr_3_use_fact_adr = 0 THEN
      cck_app.set_nd_txt(p_bid_id, 'ES357', l_adr_3_locality_type);
      cck_app.set_nd_txt(p_bid_id, 'ES358', l_adr_3_locality);
      cck_app.set_nd_txt(p_bid_id, 'ES360', l_adr_3_area);
      cck_app.set_nd_txt(p_bid_id, 'ES362', l_adr_3_region);
      cck_app.set_nd_txt(p_bid_id, 'ES363', l_adr_3_street_type);
      cck_app.set_nd_txt(p_bid_id, 'ES364', l_adr_3_street);
      cck_app.set_nd_txt(p_bid_id, 'ES365', l_adr_3_homepart_type);
      cck_app.set_nd_txt(p_bid_id, 'ES366', l_adr_3_homepart);
      cck_app.set_nd_txt(p_bid_id, 'ES367', l_adr_3_home_type);
      cck_app.set_nd_txt(p_bid_id, 'ES368', l_adr_3_home);
      cck_app.set_nd_txt(p_bid_id, 'ES369', l_adr_3_room_type);
      cck_app.set_nd_txt(p_bid_id, 'ES370', l_adr_3_room);
    END IF;

  END p_set_adr_to_comp_prg;
  --��������� ��������� ������������� ��������
  PROCEDURE register_comp_prg
  (
    p_bid_id    IN wcs_bids.id%TYPE
   , -- ������������� ������
    p_ws_id     IN wcs_answers.ws_id%TYPE DEFAULT wcs_utl.g_cur_ws_id
   , -- ������������� �������� ������������
    p_ws_number IN wcs_answers.ws_number%TYPE DEFAULT wcs_utl.g_cur_ws_num -- ����� �������� ������������
  ) IS

    --������� ������
    goods_cost VARCHAR2(255);
    --���������� �������� �����������
    prg_region_avaliable   NUMBER;
    prg_region_type_1      VARCHAR2(255);
    prg_region_name_1      VARCHAR2(255);
    prg_region_size_1      VARCHAR2(255);
    prg_region_comp_type_1 VARCHAR2(255);
    prg_region_type_2      VARCHAR2(255);
    prg_region_name_2      VARCHAR2(255);
    prg_region_size_2      VARCHAR2(255);
    prg_region_comp_type_2 VARCHAR2(255);
    prg_region_type_3      VARCHAR2(255);
    prg_region_name_3      VARCHAR2(255);
    prg_region_size_3      VARCHAR2(255);
    prg_region_comp_type_3 VARCHAR2(255);
    -- ������ ���� ��������
    prg_adr_1_settlement_id adr_settlements.settlement_id%TYPE;
    prg_adr_1_street_id     adr_streets.street_id%TYPE;
    tmp                     VARCHAR2(255);
    -- ��������������� ������ ��������� �� �������� ������
    prg_adr_1_use_fact_adr NUMBER;
    prg_adr_1_use_reg_adr  NUMBER;
    prg_adr_2_use_fact_adr NUMBER;
    prg_adr_2_use_reg_adr  NUMBER;
    prg_adr_3_use_fact_adr NUMBER;
    prg_adr_3_use_reg_adr  NUMBER;
    -- ��������� �� � ����� � ����� ������
    prg_region_add_2 NUMBER;
    prg_region_add_3 NUMBER;
    prg_adr_2_add    NUMBER;
    prg_adr_3_add    NUMBER;
  BEGIN
    prg_adr_2_add := wcs_utl.get_answ_bool(p_bid_id
                                          ,'PRG_ADR_2_ADD'
                                          ,p_ws_id
                                          ,p_ws_number);

    prg_adr_3_add := wcs_utl.get_answ_bool(p_bid_id
                                          ,'PRG_ADR_3_ADD'
                                          ,p_ws_id
                                          ,p_ws_number);

    prg_region_add_3 := wcs_utl.get_answ_bool(p_bid_id
                                             ,'PRG_REGION_ADD_3'
                                             ,p_ws_id
                                             ,p_ws_number);
    --�������
    goods_cost := wcs_utl.get_answ(p_bid_id
                                  ,'GOODS_COST'
                                  ,p_ws_id
                                  ,p_ws_number); --������� ������
    cck_app.set_nd_txt(p_bid_id, 'ES001', goods_cost);

    -- ��� �� ������������� (������ 1)
    BEGIN
      FOR c IN (WITH params AS
                   (SELECT 'ES100' AS tag, 'PRG_ADR_1_GOOD_TYPE_1' AS quest
                     FROM dual
                   UNION ALL
                    SELECT 'ES106' AS tag, 'PRG_ADR_1_GOOD_TYPE_2' AS quest from dual
                   UNION ALL
                   SELECT 'ES112' AS tag, 'PRG_ADR_1_GOOD_TYPE_3' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES118' AS tag, 'PRG_ADR_1_GOOD_TYPE_4' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES124' AS tag, 'PRG_ADR_1_GOOD_TYPE_5' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES130' AS tag, 'PRG_ADR_1_GOOD_TYPE_6' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES136' AS tag, 'PRG_ADR_1_GOOD_TYPE_7' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES142' AS tag, 'PRG_ADR_1_GOOD_TYPE_8' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES148' AS tag, 'PRG_ADR_1_GOOD_TYPE_9' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES154' AS tag, 'PRG_ADR_1_GOOD_TYPE_10' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES160' AS tag, 'PRG_ADR_1_GOOD_TYPE_11' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES166' AS tag, 'PRG_ADR_1_GOOD_TYPE_12' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES172' AS tag, 'PRG_ADR_1_GOOD_TYPE_13' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES178' AS tag, 'PRG_ADR_1_GOOD_TYPE_14' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES184' AS tag, 'PRG_ADR_1_GOOD_TYPE_15' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES190' AS tag, 'PRG_ADR_1_GOOD_TYPE_16' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES196' AS tag, 'PRG_ADR_1_GOOD_TYPE_17' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES202' AS tag, 'PRG_ADR_1_GOOD_TYPE_18' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES208' AS tag, 'PRG_ADR_1_GOOD_TYPE_19' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES214' AS tag, 'PRG_ADR_1_GOOD_TYPE_20' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES102' AS tag, 'PRG_ADR_1_GOOD_NAME_1' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES108' AS tag, 'PRG_ADR_1_GOOD_NAME_2' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES114' AS tag, 'PRG_ADR_1_GOOD_NAME_3' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES120' AS tag, 'PRG_ADR_1_GOOD_NAME_4' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES126' AS tag, 'PRG_ADR_1_GOOD_NAME_5' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES132' AS tag, 'PRG_ADR_1_GOOD_NAME_6' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES138' AS tag, 'PRG_ADR_1_GOOD_NAME_7' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES144' AS tag, 'PRG_ADR_1_GOOD_NAME_8' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES150' AS tag, 'PRG_ADR_1_GOOD_NAME_9' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES156' AS tag, 'PRG_ADR_1_GOOD_NAME_10' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES162' AS tag, 'PRG_ADR_1_GOOD_NAME_11' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES168' AS tag, 'PRG_ADR_1_GOOD_NAME_12' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES174' AS tag, 'PRG_ADR_1_GOOD_NAME_13' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES180' AS tag, 'PRG_ADR_1_GOOD_NAME_14' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES186' AS tag, 'PRG_ADR_1_GOOD_NAME_15' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES192' AS tag, 'PRG_ADR_1_GOOD_NAME_16' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES198' AS tag, 'PRG_ADR_1_GOOD_NAME_17' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES204' AS tag, 'PRG_ADR_1_GOOD_NAME_18' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES210' AS tag, 'PRG_ADR_1_GOOD_NAME_19' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES216' AS tag, 'PRG_ADR_1_GOOD_NAME_20' AS quest
                     FROM dual)
                  SELECT params.tag tag
                        ,CASE
                           WHEN params.quest LIKE '%GOOD_TYPE%' THEN
                            (SELECT t2.good
                               FROM escr_goods t2
                              WHERE t2.id = t.val_refer)
                           ELSE
                            t.val_text
                         END VALUE
                    FROM params
                    LEFT JOIN wcs_answers t
                      ON t.question_id = params.quest
                     AND t.bid_id = p_bid_id
                   ORDER BY params.tag)
      LOOP
        cck_app.set_nd_txt(p_bid_id, c.tag, c.value);

      END LOOP;
    END;
    --��� �� ������������� (������ 2)
    IF prg_adr_2_add = 1 THEN
      BEGIN
        FOR c IN (WITH params AS
                     (SELECT 'ES238' AS tag, 'PRG_ADR_2_GOOD_TYPE_1' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES244' AS tag, 'PRG_ADR_2_GOOD_TYPE_2' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES250' AS tag, 'PRG_ADR_2_GOOD_TYPE_3' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES256' AS tag, 'PRG_ADR_2_GOOD_TYPE_4' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES262' AS tag, 'PRG_ADR_2_GOOD_TYPE_5' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES268' AS tag, 'PRG_ADR_2_GOOD_TYPE_6' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES274' AS tag, 'PRG_ADR_2_GOOD_TYPE_7' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES280' AS tag, 'PRG_ADR_2_GOOD_TYPE_8' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES286' AS tag, 'PRG_ADR_2_GOOD_TYPE_9' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES292' AS tag
                           ,'PRG_ADR_2_GOOD_TYPE_10' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES298' AS tag
                           ,'PRG_ADR_2_GOOD_TYPE_11' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES304' AS tag
                           ,'PRG_ADR_2_GOOD_TYPE_12' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES310' AS tag
                           ,'PRG_ADR_2_GOOD_TYPE_13' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES316' AS tag
                           ,'PRG_ADR_2_GOOD_TYPE_14' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES322' AS tag
                           ,'PRG_ADR_2_GOOD_TYPE_15' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES328' AS tag
                           ,'PRG_ADR_2_GOOD_TYPE_16' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES334' AS tag
                           ,'PRG_ADR_2_GOOD_TYPE_17' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES340' AS tag
                           ,'PRG_ADR_2_GOOD_TYPE_18' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES346' AS tag
                           ,'PRG_ADR_2_GOOD_TYPE_19' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES352' AS tag
                           ,'PRG_ADR_2_GOOD_TYPE_20' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES240' AS tag, 'PRG_ADR_2_GOOD_NAME_1' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES246' AS tag, 'PRG_ADR_2_GOOD_NAME_2' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES252' AS tag, 'PRG_ADR_2_GOOD_NAME_3' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES258' AS tag, 'PRG_ADR_2_GOOD_NAME_4' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES264' AS tag, 'PRG_ADR_2_GOOD_NAME_5' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES270' AS tag, 'PRG_ADR_2_GOOD_NAME_6' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES276' AS tag, 'PRG_ADR_2_GOOD_NAME_7' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES282' AS tag, 'PRG_ADR_2_GOOD_NAME_8' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES288' AS tag, 'PRG_ADR_2_GOOD_NAME_9' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES294' AS tag
                           ,'PRG_ADR_2_GOOD_NAME_10' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES300' AS tag
                           ,'PRG_ADR_2_GOOD_NAME_11' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES306' AS tag
                           ,'PRG_ADR_2_GOOD_NAME_12' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES312' AS tag
                           ,'PRG_ADR_2_GOOD_NAME_13' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES318' AS tag
                           ,'PRG_ADR_2_GOOD_NAME_14' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES324' AS tag
                           ,'PRG_ADR_2_GOOD_NAME_15' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES330' AS tag
                           ,'PRG_ADR_2_GOOD_NAME_16' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES336' AS tag
                           ,'PRG_ADR_2_GOOD_NAME_17' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES342' AS tag
                           ,'PRG_ADR_2_GOOD_NAME_18' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES348' AS tag
                           ,'PRG_ADR_2_GOOD_NAME_19' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES354' AS tag
                           ,'PRG_ADR_2_GOOD_NAME_20' AS quest
                       FROM dual)

                    SELECT params.tag tag
                          ,CASE
                             WHEN params.quest LIKE '%GOOD_TYPE%' THEN
                              (SELECT t2.good
                                 FROM escr_goods t2
                                WHERE t2.id = t.val_refer)
                             ELSE
                              t.val_text
                           END VALUE
                      FROM params
                      LEFT JOIN wcs_answers t
                        ON t.question_id = params.quest
                       AND t.bid_id = p_bid_id

                     ORDER BY params.tag)
        LOOP
          cck_app.set_nd_txt(p_bid_id, c.tag, c.value);

        END LOOP;
      END;
    END IF;
    --��� �� ������������� (������ 3)
    IF prg_adr_3_add = 1 THEN
      BEGIN
        FOR c IN (WITH params AS
                     (SELECT 'ES376' AS tag, 'PRG_ADR_3_GOOD_TYPE_1' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES382' AS tag, 'PRG_ADR_3_GOOD_TYPE_2' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES388' AS tag, 'PRG_ADR_3_GOOD_TYPE_3' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES394' AS tag, 'PRG_ADR_3_GOOD_TYPE_4' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES400' AS tag, 'PRG_ADR_3_GOOD_TYPE_5' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES406' AS tag, 'PRG_ADR_3_GOOD_TYPE_6' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES412' AS tag, 'PRG_ADR_3_GOOD_TYPE_7' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES418' AS tag, 'PRG_ADR_3_GOOD_TYPE_8' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES424' AS tag, 'PRG_ADR_3_GOOD_TYPE_9' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES430' AS tag
                           ,'PRG_ADR_3_GOOD_TYPE_10' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES436' AS tag
                           ,'PRG_ADR_3_GOOD_TYPE_11' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES442' AS tag
                           ,'PRG_ADR_3_GOOD_TYPE_12' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES448' AS tag
                           ,'PRG_ADR_3_GOOD_TYPE_13' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES454' AS tag
                           ,'PRG_ADR_3_GOOD_TYPE_14' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES460' AS tag
                           ,'PRG_ADR_3_GOOD_TYPE_15' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES466' AS tag
                           ,'PRG_ADR_3_GOOD_TYPE_16' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES472' AS tag
                           ,'PRG_ADR_3_GOOD_TYPE_17' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES478' AS tag
                           ,'PRG_ADR_3_GOOD_TYPE_18' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES484' AS tag
                           ,'PRG_ADR_3_GOOD_TYPE_19' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES490' AS tag
                           ,'PRG_ADR_3_GOOD_TYPE_20' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES378' AS tag, 'PRG_ADR_3_GOOD_NAME_1' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES384' AS tag, 'PRG_ADR_3_GOOD_NAME_2' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES390' AS tag, 'PRG_ADR_3_GOOD_NAME_3' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES396' AS tag, 'PRG_ADR_3_GOOD_NAME_4' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES402' AS tag, 'PRG_ADR_3_GOOD_NAME_5' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES408' AS tag, 'PRG_ADR_3_GOOD_NAME_6' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES414' AS tag, 'PRG_ADR_3_GOOD_NAME_7' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES420' AS tag, 'PRG_ADR_3_GOOD_NAME_8' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES426' AS tag, 'PRG_ADR_3_GOOD_NAME_9' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES432' AS tag
                           ,'PRG_ADR_3_GOOD_NAME_10' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES438' AS tag
                           ,'PRG_ADR_3_GOOD_NAME_11' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES444' AS tag
                           ,'PRG_ADR_3_GOOD_NAME_12' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES450' AS tag
                           ,'PRG_ADR_3_GOOD_NAME_13' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES456' AS tag
                           ,'PRG_ADR_3_GOOD_NAME_14' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES462' AS tag
                           ,'PRG_ADR_3_GOOD_NAME_15' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES468' AS tag
                           ,'PRG_ADR_3_GOOD_NAME_16' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES474' AS tag
                           ,'PRG_ADR_3_GOOD_NAME_17' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES480' AS tag
                           ,'PRG_ADR_3_GOOD_NAME_18' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES486' AS tag
                           ,'PRG_ADR_3_GOOD_NAME_19' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES492' AS tag
                           ,'PRG_ADR_3_GOOD_NAME_20' AS quest
                       FROM dual)
                    SELECT params.tag tag
                          ,CASE
                             WHEN params.quest LIKE '%GOOD_TYPE%' THEN
                              (SELECT t2.good
                                 FROM escr_goods t2
                                WHERE t2.id = t.val_refer)
                             ELSE
                              t.val_text
                           END VALUE
                      FROM params
                      LEFT JOIN wcs_answers t
                        ON t.question_id = params.quest
                       AND t.bid_id = p_bid_id
                     ORDER BY params.tag)
        LOOP
          cck_app.set_nd_txt(p_bid_id, c.tag, c.value);

        END LOOP;
      END;
    END IF;
    -- ��� �� ������������� (������ 1)
    BEGIN
      FOR c IN (WITH params AS
                   (SELECT 'ES100' AS tag, 'PRG_ADR_1_GOOD_TYPE_1' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES106' AS tag, 'PRG_ADR_1_GOOD_TYPE_2' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES112' AS tag, 'PRG_ADR_1_GOOD_TYPE_3' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES118' AS tag, 'PRG_ADR_1_GOOD_TYPE_4' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES124' AS tag, 'PRG_ADR_1_GOOD_TYPE_5' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES130' AS tag, 'PRG_ADR_1_GOOD_TYPE_6' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES136' AS tag, 'PRG_ADR_1_GOOD_TYPE_7' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES142' AS tag, 'PRG_ADR_1_GOOD_TYPE_8' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES148' AS tag, 'PRG_ADR_1_GOOD_TYPE_9' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES154' AS tag, 'PRG_ADR_1_GOOD_TYPE_10' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES160' AS tag, 'PRG_ADR_1_GOOD_TYPE_11' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES166' AS tag, 'PRG_ADR_1_GOOD_TYPE_12' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES172' AS tag, 'PRG_ADR_1_GOOD_TYPE_13' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES178' AS tag, 'PRG_ADR_1_GOOD_TYPE_14' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES184' AS tag, 'PRG_ADR_1_GOOD_TYPE_15' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES190' AS tag, 'PRG_ADR_1_GOOD_TYPE_16' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES196' AS tag, 'PRG_ADR_1_GOOD_TYPE_17' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES202' AS tag, 'PRG_ADR_1_GOOD_TYPE_18' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES208' AS tag, 'PRG_ADR_1_GOOD_TYPE_19' AS quest
                     FROM dual
                   UNION ALL
                   SELECT 'ES214' AS tag, 'PRG_ADR_1_GOOD_TYPE_20' AS quest
                     FROM dual)
                  SELECT params.tag
                        ,t2.id
                        ,'ES' || to_char(substr(params.tag
                                               ,length(params.tag) - 2
                                               ,3) + 4) tag_event
                        ,t2.event_id
                    FROM params
                        ,wcs_answers                  t
                        ,escr_map_event_to_good       t2
                        ,escr_map_event_to_build_type t3
                   WHERE t.bid_id = p_bid_id
                     AND t.question_id = params.quest
                     AND t2.event_id = t3.event_id
                     AND t3.build_type_id =
                         wcs_utl.get_answ_refer(t.bid_id
                                               ,'PRG_ADR_1_BUILD_TYPE')
                     AND to_char(t2.good_id) = to_char(t.val_refer))
      LOOP

       cck_app.set_nd_txt(p_bid_id, c.tag_event, c.event_id);


      END LOOP;
    END;
    --��� �� ������������� (������ 2)
    IF prg_adr_2_add = 1 THEN
      BEGIN
        FOR c IN (WITH params AS
                     (SELECT 'ES238' AS tag, 'PRG_ADR_2_GOOD_TYPE_1' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES244' AS tag, 'PRG_ADR_2_GOOD_TYPE_2' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES250' AS tag, 'PRG_ADR_2_GOOD_TYPE_3' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES256' AS tag, 'PRG_ADR_2_GOOD_TYPE_4' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES262' AS tag, 'PRG_ADR_2_GOOD_TYPE_5' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES268' AS tag, 'PRG_ADR_2_GOOD_TYPE_6' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES274' AS tag, 'PRG_ADR_2_GOOD_TYPE_7' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES280' AS tag, 'PRG_ADR_2_GOOD_TYPE_8' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES286' AS tag, 'PRG_ADR_2_GOOD_TYPE_9' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES292' AS tag
                           ,'PRG_ADR_2_GOOD_TYPE_10' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES298' AS tag
                           ,'PRG_ADR_2_GOOD_TYPE_11' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES304' AS tag
                           ,'PRG_ADR_2_GOOD_TYPE_12' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES310' AS tag
                           ,'PRG_ADR_2_GOOD_TYPE_13' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES316' AS tag
                           ,'PRG_ADR_2_GOOD_TYPE_14' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES322' AS tag
                           ,'PRG_ADR_2_GOOD_TYPE_15' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES328' AS tag
                           ,'PRG_ADR_2_GOOD_TYPE_16' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES334' AS tag
                           ,'PRG_ADR_2_GOOD_TYPE_17' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES340' AS tag
                           ,'PRG_ADR_2_GOOD_TYPE_18' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES346' AS tag
                           ,'PRG_ADR_2_GOOD_TYPE_19' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES352' AS tag
                           ,'PRG_ADR_2_GOOD_TYPE_20' AS quest
                       FROM dual)
                    SELECT params.tag
                          ,t2.id
                          ,'ES' || to_char(substr(params.tag
                                                 ,length(params.tag) - 2
                                                 ,3) + 4) tag_event
                          ,t2.event_id
                      FROM params
                          ,wcs_answers                  t
                          ,escr_map_event_to_good       t2
                          ,escr_map_event_to_build_type t3
                     WHERE t.bid_id = p_bid_id
                       AND t.question_id = params.quest
                       AND t2.event_id = t3.event_id
                       AND t3.build_type_id =
                           wcs_utl.get_answ_refer(t.bid_id
                                                 ,'PRG_ADR_2_BUILD_TYPE')
                       AND to_char(t2.good_id) = to_char(t.val_refer))
        LOOP
          cck_app.set_nd_txt(p_bid_id, c.tag_event, c.event_id);
        END LOOP;
      END;
    END IF;
    --��� �� ������������� (������ 3)
    IF prg_adr_3_add = 1 THEN
      BEGIN
        FOR c IN (WITH params AS
                     (

                     SELECT 'ES376' AS tag, 'PRG_ADR_3_GOOD_TYPE_1' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES382' AS tag, 'PRG_ADR_3_GOOD_TYPE_2' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES388' AS tag, 'PRG_ADR_3_GOOD_TYPE_3' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES394' AS tag, 'PRG_ADR_3_GOOD_TYPE_4' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES400' AS tag, 'PRG_ADR_3_GOOD_TYPE_5' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES406' AS tag, 'PRG_ADR_3_GOOD_TYPE_6' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES412' AS tag, 'PRG_ADR_3_GOOD_TYPE_7' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES418' AS tag, 'PRG_ADR_3_GOOD_TYPE_8' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES424' AS tag, 'PRG_ADR_3_GOOD_TYPE_9' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES430' AS tag, 'PRG_ADR_3_GOOD_TYPE_10' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES436' AS tag, 'PRG_ADR_3_GOOD_TYPE_11' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES442' AS tag, 'PRG_ADR_3_GOOD_TYPE_12' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES448' AS tag, 'PRG_ADR_3_GOOD_TYPE_13' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES454' AS tag, 'PRG_ADR_3_GOOD_TYPE_14' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES460' AS tag, 'PRG_ADR_3_GOOD_TYPE_15' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES466' AS tag, 'PRG_ADR_3_GOOD_TYPE_16' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES472' AS tag, 'PRG_ADR_3_GOOD_TYPE_17' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES478' AS tag, 'PRG_ADR_3_GOOD_TYPE_18' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES484' AS tag, 'PRG_ADR_3_GOOD_TYPE_19' AS quest
                       FROM dual
                     UNION ALL
                     SELECT 'ES490' AS tag, 'PRG_ADR_3_GOOD_TYPE_20' AS quest
                       FROM dual)
                    SELECT params.tag
                          ,t2.id
                          ,'ES' || to_char(substr(params.tag
                                                 ,length(params.tag) - 2
                                                 ,3) + 4) tag_event
                          ,t2.event_id
                      FROM params
                          ,wcs_answers                  t
                          ,escr_map_event_to_good       t2
                          ,escr_map_event_to_build_type t3
                     WHERE t.bid_id = p_bid_id
                       AND t.question_id = params.quest
                       AND t2.event_id = t3.event_id
                       AND t3.build_type_id =
                           wcs_utl.get_answ_refer(t.bid_id
                                                 ,'PRG_ADR_3_BUILD_TYPE')
                       AND to_char(t2.good_id) = to_char(t.val_refer))
        LOOP

          cck_app.set_nd_txt(p_bid_id, c.tag_event, c.event_id);
        END LOOP;
      END;
    END IF;
    -- ���������� ��������

    prg_region_avaliable := wcs_utl.get_answ(p_bid_id
                                            ,'PRG_REGION_AVALIABLE'
                                            ,p_ws_id
                                            ,p_ws_number); --��� �����������
    -- IF prg_region_avaliable = 1 THEN
    --1-��
    prg_region_type_1 := wcs_utl.get_answ_refer_text(p_bid_id
                                                    ,'PRG_REGION_TYPE_1'
                                                    ,p_ws_id
                                                    ,p_ws_number); --��������� ����������� (����,������,������)

    prg_region_name_1      := wcs_utl.get_answ(p_bid_id
                                              ,'PRG_REGION_NAME_1'
                                              ,p_ws_id
                                              ,p_ws_number); --����� (����,������,������)
    prg_region_comp_type_1 := wcs_utl.get_answ_refer(p_bid_id
                                                    ,'PRG_REGION_COMP_TYPE_1'
                                                    ,p_ws_id
                                                    ,p_ws_number); --��� �����������
    prg_region_size_1      := wcs_utl.get_answ(p_bid_id
                                              ,'PRG_REGION_SIZE_1'
                                              ,p_ws_id
                                              ,p_ws_number); --����� �����������
    --2-��
    prg_region_type_2      := wcs_utl.get_answ_refer_text(p_bid_id
                                                         ,'PRG_REGION_TYPE_2'
                                                         ,p_ws_id
                                                         ,p_ws_number); --��������� ����������� (����,������,������)
    prg_region_name_2      := wcs_utl.get_answ(p_bid_id
                                              ,'PRG_REGION_NAME_2'
                                              ,p_ws_id
                                              ,p_ws_number); --����� (����,������,������)
    prg_region_comp_type_2 := wcs_utl.get_answ_refer(p_bid_id
                                                    ,'PRG_REGION_COMP_TYPE_2'
                                                    ,p_ws_id
                                                    ,p_ws_number); --��� �����������
    prg_region_size_2      := wcs_utl.get_answ(p_bid_id
                                              ,'PRG_REGION_SIZE_2'
                                              ,p_ws_id
                                              ,p_ws_number); --����� �����������
    -- 3-��
    prg_region_type_3      := wcs_utl.get_answ_refer_text(p_bid_id
                                                         ,'PRG_REGION_TYPE_3'
                                                         ,p_ws_id
                                                         ,p_ws_number); --��������� ����������� (����,������,������)
    prg_region_name_3      := wcs_utl.get_answ(p_bid_id
                                              ,'PRG_REGION_NAME_3'
                                              ,p_ws_id
                                              ,p_ws_number); --����� (����,������,������)
    prg_region_comp_type_3 := wcs_utl.get_answ_refer(p_bid_id
                                                    ,'PRG_REGION_COMP_TYPE_3'
                                                    ,p_ws_id
                                                    ,p_ws_number); --��� �����������
    prg_region_size_3      := wcs_utl.get_answ(p_bid_id
                                              ,'PRG_REGION_SIZE_3'
                                              ,p_ws_id
                                              ,p_ws_number); --����� �����������
    -- END IF;

    -- �������� ����� � ������������ �� ���������� �������
    -- IF prg_region_avaliable IS NOT NULL THEN

    cck_app.set_nd_txt(p_bid_id, 'SQAPR', prg_region_avaliable);
    cck_app.set_nd_txt(p_bid_id, 'SQBA1', prg_region_type_1);
    cck_app.set_nd_txt(p_bid_id, 'SQBA2', prg_region_name_1);
    cck_app.set_nd_txt(p_bid_id, 'SQBA3', prg_region_comp_type_1);
    cck_app.set_nd_txt(p_bid_id, 'SQBA4', prg_region_size_1);
    cck_app.set_nd_txt(p_bid_id, 'SQCA1', prg_region_type_2);
    cck_app.set_nd_txt(p_bid_id, 'SQCA2', prg_region_name_2);
    cck_app.set_nd_txt(p_bid_id, 'SQCA3', prg_region_comp_type_2);
    cck_app.set_nd_txt(p_bid_id, 'SQCA4', prg_region_size_2);
    cck_app.set_nd_txt(p_bid_id, 'SQDA1', prg_region_type_3);
    cck_app.set_nd_txt(p_bid_id, 'SQDA2', prg_region_name_3);
    cck_app.set_nd_txt(p_bid_id, 'SQDA3', prg_region_comp_type_3);
    cck_app.set_nd_txt(p_bid_id, 'SQDA4', prg_region_size_3);
    --  END IF;

    --��� �������
    cck_app.set_nd_txt(p_bid_id
                      ,'ES084'
                      ,wcs_utl.get_answ_refer(p_bid_id
                                             ,'PRG_ADR_1_BUILD_TYPE'
                                             ,p_ws_id
                                             ,p_ws_number));

    cck_app.set_nd_txt(p_bid_id
                      ,'ES236'
                      ,wcs_utl.get_answ_refer(p_bid_id
                                             ,'PRG_ADR_2_BUILD_TYPE'
                                             ,p_ws_id
                                             ,p_ws_number));

    cck_app.set_nd_txt(p_bid_id
                      ,'ES374'
                      ,wcs_utl.get_answ_refer(p_bid_id
                                             ,'PRG_ADR_3_BUILD_TYPE'
                                             ,p_ws_id
                                             ,p_ws_number));

    p_set_adr_to_comp_prg(p_bid_id, p_ws_id, p_ws_number);
  END register_comp_prg;
  -- ����������� ��������� ������
  PROCEDURE register_deal
  (
    p_bid_id    IN NUMBER
   , -- ������������� ������
    p_rnk       IN NUMBER
   , -- ������������� �������
    p_ws_id     IN wcs_answers.ws_id%TYPE DEFAULT wcs_utl.g_cur_ws_id
   , -- ������������� �������� ������������
    p_ws_number IN wcs_answers.ws_number%TYPE DEFAULT wcs_utl.g_cur_ws_num
   , -- ����� �������� ������������
    p_branch    IN VARCHAR2 DEFAULT NULL
   , -- �����
    p_user_id   IN VARCHAR2 DEFAULT NULL -- Staff
  ) IS

    l_proc_name VARCHAR2(40) := 'register_deal. ';

    l_user_id INT; -- ��� ������������
    l_branch  VARCHAR2(50); -- BRANCH (���������)  nd_txt.INIC

    -- �������� ��������������
    l_nd            INT := p_bid_id;
    l_subproduct_id VARCHAR2(100); -- ������������� �����������
    l_ob22          VARCHAR2(6);
    l_prod          VARCHAR2(20);
    l_cc_id         VARCHAR2(50) := wcs_utl.get_creditdata(p_bid_id
                                                          ,'DEAL_NUMBER'); -- ������� ����� ��������
    l_dat1          DATE; -- ���� ����������
    l_dat4          DATE; -- ���� ��������� ��
    l_term          INT; -- ������ ��
    l_lcv           tabval.lcv%TYPE; -- ���������� ��� ������
    l_kv            tabval.kv%TYPE; -- �������� ��� ������
    l_s             NUMBER; -- ���� ��  (� ���-��)
    l_vidd          INT; -- ��� �������� (1,2,3 - �� , 11,12,13 - ��)
    l_sour          INT; -- �������� �������� �������
    l_aim           INT; -- ���� ������������
    l_s260          VARCHAR2(2); -- ������ (S260)
    l_crisk         customer.crisk%TYPE := to_number(wcs_utl.get_answ(p_bid_id
                                                                     ,'CRISK_NBU'
                                                                     ,p_ws_id
                                                                     ,p_ws_number)) + 1; -- ��� ����� ������������
    l_obs           INT; -- ������������ �����
    l_ir            NUMBER := NULL; -- ���������� ������
    l_br            INT := NULL; -- ������� ���������� ������
    l_basey         INT; -- ���� ����������
    l_method        INT; -- �������� � ������ (1 - �����)
    l_acc8          VARCHAR2(15);
    l_acc           accounts.acc%TYPE;

    l_freq          INT; -- ������������� ���������� �� ����
    l_pay_day       INT; -- ���� ���������
    l_first_pay_dat DATE; -- ������ ���� ��������� ����

    l_freqi INT; -- ������������� ���������� %
    l_deni  INT; -- ���� ��������� %
    l_datfi DATE; -- ������ ���� ��������� %

    l_rang     INT; -- ������ ���������
    l_holidays INT; -- ��������
    --   l_method        int;           -- ������ ���������� ���������

    type_gpk NUMBER; -- ��� ������� ���������
    l_rterm  NUMBER; -- ����� ��������� ��������� ������ �� �������� �� (��)

    -- ������������ ������

    l_sdi      NUMBER; -- ����� ��������,
    l_kom      INT; -- ��� ��������
    l_kom_ir   NUMBER; -- % ������ ����-��� ����� ��� ���� � ����� �� ������
    l_kom_datf DATE; -- ���� ������� ����������
    l_kom_date DATE; -- ���� ��������� ����������
    l_kom_kv   INT; -- ���.��.��� ���-��� ���-�� (3578) �� ����-��� ��� ��������������
    l_cr9_kv   INT; -- ���.��.��� ���-��� ���-�� (3578) �� ����� �����
    l_cr9_ir   INT; -- % ������ �� ����� �����
    l_cr9_i    INT; -- % 0- ������ , 1- �� ������-��� ����-��� �����
    l_sn8_ir   INT; -- % ������ ����
    l_sn8_kv   INT; -- % ������ ����
    l_sk4_ir   INT; -- % ������ �� ��������� ���������

    l_pmt_instr   t_pmt_instr; -- ��������� ���������� ��� ������������ ��������� �������
    l_is_standart NUMBER := 0;

    l_is_employee    NUMBER := nvl(to_number(wcs_utl.get_answ_refer(p_bid_id
                                                                   ,'WORKER_BANK'))
                                  ,0);
    l_is_base_rate   NUMBER := nvl(wcs_utl.get_answ_bool(p_bid_id
                                                        ,'BASE_RATES')
                                  ,0);
    l_is_affiliate   NUMBER := nvl(wcs_utl.get_answ_bool(p_bid_id
                                                        ,'AFFILIATE_PRG')
                                  ,0);
    l_affiliate_rate NUMBER(5, 3) := wcs_utl.get_answ_decimal(p_bid_id
                                                             ,'AFFILIATE_PRG_RATE');
  BEGIN

    bars_audit.info(g_pack_name || l_proc_name ||
                    'Start. Params: p_bid_id=' || to_char(p_bid_id));

    wcs_register.get_branch_user(p_bid_id
                                ,p_branch
                                ,p_user_id
                                ,l_branch
                                ,l_user_id);
    bars_audit.info(g_pack_name || l_proc_name || ' l_branch=' || l_branch ||
                    ' p_user_id=' || p_user_id);

    -- ������������� �����������
    SELECT b.subproduct_id
      INTO l_subproduct_id
      FROM wcs_bids b
     WHERE b.id = p_bid_id;

    bars_audit.trace(g_pack_name || l_proc_name ||
                     'Proccess. Params: l_subproduct_id=%s'
                    ,l_subproduct_id);

    -- ���� �������
    l_term := to_number(wcs_utl.get_creditdata(p_bid_id, 'CREDIT_TERM'));

    BEGIN
      SELECT 1
        INTO l_is_standart
        FROM wcs_bids
       WHERE id = p_bid_id
         AND regexp_like(subproduct_id, 'NONSTANDARD');
    EXCEPTION
      WHEN no_data_found THEN
        l_is_standart := 0;
    END;
    -- ��22 �� �������� �����������
    IF l_is_standart = 0
       AND wcs_utl.has_answ(p_bid_id, 'OB22') = 0 THEN
      IF (l_term <= 12) THEN
        l_ob22 := wcs_utl.get_mac(p_bid_id, 'MAC_OB22_SHORT');
      ELSE
        l_ob22 := wcs_utl.get_mac(p_bid_id, 'MAC_OB22_LONG');
      END IF;
    ELSIF l_is_standart = 1
          OR wcs_utl.has_answ(p_bid_id, 'OB22') = 1 THEN
      l_ob22 := wcs_utl.get_answ_refer(p_bid_id, 'OB22');
    END IF;

    BEGIN
      -- � ����������� �� ����� ������� ����� ������ ���� ��22
      SELECT id INTO l_prod FROM cc_potra WHERE id = l_ob22;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(-20331
                               ,'� ���������� ������� ' ||
                                l_subproduct_id ||
                                ' �������� ������� �������������� ������� (OB22)=' ||
                                substr(wcs_utl.get_mac(p_bid_id
                                                      ,'MAC_OB22')
                                      ,1
                                      ,6)
                               ,TRUE);
    END;

    --------------------------------------------------------------------------------
    -- l_Dat1          DATE,    -- ���� ����������
    -- l_Dat4          DATE,    -- ���� ��������� ��
    -- l_Den           int,    -- ���� ���������
    -- l_DATf         date,    -- ������ ���� ��������� ����

    -- ���� ������ �������� ���������� ����� ������������ � ������
    l_dat1 := to_date(wcs_utl.get_creditdata(p_bid_id, 'DEAL_DATE'));
    l_dat1 := cck.correctdate(gl.baseval, l_dat1, l_dat1 + 1);

    -- ��������� ���� � ����
    l_pay_day       := to_number(wcs_utl.get_creditdata(p_bid_id
                                                       ,'REPAYMENT_DAY'));
    l_first_pay_dat := add_months(to_date('01' || to_char(l_dat1, 'mmyyyy')
                                         ,'ddmmyyyy') + l_pay_day - 1
                                 ,1);

    /* ������������� ��� ��� ��������
    -- 19.03.2010(4) Sta
    If l_first_pay_dat < gl.BDATE then
      l_first_pay_dat := add_months(l_first_pay_dat, 2);
    else
      l_first_pay_dat := add_months(l_first_pay_dat, 1);
    end if;
    If months_between(l_first_pay_dat, gl.bdate) > 1.5 OR
       l_first_pay_dat - gl.bdate > 45 then
      l_first_pay_dat := add_months(l_first_pay_dat, -1);
    end if;
    */

    -- ���������� ��������
    l_dat4 := add_months(l_dat1, l_term);
    --l_dat4 := cck.CorrectDate(gl.baseVal, l_dat4, l_dat4 - 1);

    --------------------------------------------------------------------------------
    l_lcv := wcs_utl.get_creditdata(p_bid_id, 'CREDIT_CURRENCY');
    SELECT t.kv INTO l_kv FROM tabval t WHERE t.lcv = l_lcv;

    --------------------------------------------------------------------------------
    l_s := to_number2(wcs_utl.get_creditdata(p_bid_id, 'CREDIT_SUM'));

    --------------------------------------------------------------------------------
    -- l_VIDD          int,    -- ��� �������� (1,2,3 - �� , 11,12,13 - ��)
    IF l_is_standart = 0 THEN
      l_vidd := to_number(wcs_utl.get_mac(p_bid_id, 'MAC_CRD_TYPE'));
    ELSE
      l_vidd := wcs_utl.get_answ_list(p_bid_id, 'CRD_TYPE');
    END IF;

    IF l_vidd = 0 THEN
      l_vidd  := 11;
      l_cr9_i := 0;
    ELSIF l_vidd = 1 THEN
      l_vidd  := 12;
      l_cr9_i := 0;
    ELSIF l_vidd = 2 THEN
      l_vidd  := 13;
      l_cr9_i := 0;
    ELSIF l_vidd = 3 THEN
      l_vidd  := 12;
      l_cr9_i := 1;
    ELSIF l_vidd = 4 THEN
      l_vidd  := 13;
      l_cr9_i := 1;
    ELSIF l_vidd = 5 THEN
      l_vidd  := 12;
      l_cr9_i := 0;
    END IF;

    IF l_vidd IN (12, 13, 2, 3) THEN
      l_rterm := to_number(wcs_utl.get_mac(p_bid_id, 'MAC_REPAYMENT_TERM'));
    END IF;

    --------------------------------------------------------------------------------
    -- G_SOUR          int,    -- �������� �������� �������
    --
    --------------------------------------------------------------------------------
    -- l_AIM           int,    -- ���� ������������
    --����� ����
    select nvl(min(AIM), 62)
      into l_aim
      from cc_aim
     where substr(l_prod, 1, 4) in
           (nvl(NBS,decode(NEWNBS.GET_STATE,0,'2062','2063') ),
            nvl(NBS2, '2063'),
            nvl(NBSF, decode(NEWNBS.GET_STATE,0,'2202','2203')),
            nvl(NBSF2, '2203'))
	   and d_close is null
       and rownum = 1;

    --------------------------------------------------------------------------------
    --l_MS_NX    varchar2,    -- ������ (S260)
    l_s260 := to_number(wcs_utl.get_mac(p_bid_id, 'MAC_S260'));

    --------------------------------------------------------------------------------
    -- l_IR         number,    -- ���������� ������
    /*if l_is_employee = 1 and l_is_base_rate = 1 then
      l_br := g_BR;
    else*/
    l_ir := to_number2(wcs_utl.get_creditdata(p_bid_id, 'INTEREST_RATE'));
    --end if;

    --------------------------------------------------------------------------------
    -- l_Basey         int,    -- ���� ����������
    IF l_is_standart = 0 THEN
      l_basey := to_number(wcs_utl.get_mac(p_bid_id, 'MAC_BASEY'));
    ELSE
      l_basey := wcs_utl.get_answ_list(p_bid_id, 'BASEY');
    END IF;

    --------------------------------------------------------------------------------
    --l_FREQ          int,    -- ������������� ���������� �� ����
    --G_FREQ

    --------------------------------------------------------------------------------
    -- l_FREQI         int,    -- ������������� ���������� %
    -- l_DenI          int,    -- ���� ��������� %
    -- l_DATfI        date,    -- ������ ���� ��������� %
    -- ��� �� ��������� � �������� �� �� ����������
    --------------------------------------------------------------------------------

    -- type_gpk
    type_gpk := to_number(wcs_utl.get_creditdata(p_bid_id
                                                ,'REPAYMENT_METHOD'));

    -- l_RANG          int,    -- ������ ���������
    BEGIN
      IF l_is_standart = 0 THEN
        l_rang := to_number(wcs_utl.get_mac(p_bid_id
                                           ,'MAC_PAYMENT_PARSING_SCHEME'));
      ELSE
        l_rang := to_number(wcs_utl.get_answ_list(p_bid_id
                                                 ,'PAYMENT_PARSING_SCHEME'));
      END IF;
    EXCEPTION
      WHEN no_data_found THEN
        l_rang := getglobaloption('CC_RANG');
    END;
    --------------------------------------------------------------------------------
    --l_Holidays      int,    -- ��������
    IF l_is_standart = 0 THEN
      l_holidays := to_number(wcs_utl.get_mac(p_bid_id, 'MAC_HOLIDAYS'));
    ELSE
      l_holidays := wcs_utl.get_answ_list(p_bid_id, 'HOLIDAYS');
    END IF;
    --------------------------------------------------------------------------------
    --l_method        int,    -- ������ ���������� ���������
    IF type_gpk = 4 THEN
      l_method := 0;
    ELSE
      l_method := 1;
    END IF;

    --raise_application_error (-20331, substr(to_char(l_kv) ||' - '||sqlerrm,1,250),true);

    -- ��������� ��������� ���������� ��� ������������ �������
    l_pmt_instr := get_payment_instr(p_bid_id);

    -- �������� ��������
    cck.cc_open_ext(p_nd         => l_nd
                   , -- ��� ���������� �������� (���������)
                    p_rnk        => p_rnk
                   , -- ��� ��������������
                    p_user_id    => l_user_id
                   , -- ��� ������������
                    p_branch     => l_branch
                   , -- BRANCH (���������)  nd_txt.INIC
                    p_prod       => l_prod || l_subproduct_id
                   , -- ������� ��
                    p_cc_id      => l_cc_id
                   , -- � �� (����������������)
                    p_dat1       => l_dat1
                   , -- ���� ����������
                    p_dat2       => l_dat1
                   , -- ���� ������ ��������
                    p_dat3       => l_dat1
                   , -- ���� ������ (��������)
                    p_dat4       => l_dat4
                   , -- ���� ��������� ��
                    p_kv         => l_kv
                   , -- ��� ������
                    p_s          => l_s
                   , -- ���� ��  (� ���-��)
                    p_vidd       => l_vidd
                   , -- ��� �������� (1,2,3 - �� , 11,12,13 - ��)
                    p_sour       => g_isto
                   , -- �������� �������� �������
                    p_aim        => l_aim
                   , -- ���� ������������
                    p_ms_nx      => l_s260
                   , -- ������ (S260)
                    p_fin        => l_crisk
                   , -- ��� ����
                    p_obs        => g_obs
                   , -- ������������ �����
                    p_ir         => l_ir
                   , -- ���������� ������
                    p_op         => NULL
                   , -- ��� �������� ��� % ������
                    p_br         => l_br
                   , -- ������� ������
                    p_basey      => l_basey
                   , -- ���� ����������
                    p_dat_stp_ir => NULL
                   , -- ���� ��������������� ���������� ���������

                    p_type_gpk => type_gpk
                   , -- ��� ��������� (0 - ����� 2- ���� ���� 4 �������)
                    p_daynp    => g_daynp
                   , -- ���-�� �������� ���� � ���

                    p_freq => g_freq
                   , -- ������������� ���������� �� ����
                    p_den  => l_pay_day
                   , -- ���� ���������
                    p_datf => l_first_pay_dat
                   , -- ������ ���� ��������� ����

                    p_freqi => g_freqp
                   , -- ������������� ���������� %
                    p_deni  => NULL
                   , -- ���� ��������� %
                    p_datfi => NULL
                   , -- ������ ���� ��������� %

                    p_rang     => l_rang
                   , -- ������ ���������
                    p_holidays => l_holidays
                   , -- ��������
                    p_method   => l_method
                   , -- ������ ���������� ���������

                    p_mfokred  => l_pmt_instr.mfo
                   , -- ��������� ���������� ���
                    p_nlskred  => l_pmt_instr.nls
                   , --     -------//------- ����
                    p_okpokred => l_pmt_instr.okpo
                   , -- ��� ����������
                    p_namkred  => l_pmt_instr.nam
                   , -- ������������ ����� ����������
                    p_naznkred => l_pmt_instr.nazn
                   , -- ���������� �������

                    p_saim      => NULL
                   , -- ����  ���������� �������� (�����-����������)
                    p_pawn      => NULL
                   , -- ����� ���������� �������� (�����-����������)
                    nd_external => NULL -- ������������� ������� ������� (������������� ��)
                    );

    bars_audit.info(g_pack_name || l_proc_name || 'Register Commision');
    --------------------------------------------------------------------------------
    --------------------------------------------------------------------------------
    ----------------��������� ���-��� ������ � ������-------------------------------
    --------------------------------------------------------------------------------

    -- l_sdi - ����� �������� (� ���., ����. 150.00���)
    l_sdi := nvl(to_number2(wcs_utl.get_creditdata(p_bid_id, 'SINGLE_FEE'))
                ,0);

    --l_KOM        int; -- ��� ��������
    IF l_is_standart = 0 THEN
      l_kom := to_number(wcs_utl.get_mac(p_bid_id, 'MAC_MONTHLY_FEE_TYPE'));
    ELSE
      l_kom := to_number(wcs_utl.get_answ_refer(p_bid_id
                                               ,'MONTHLY_FEE_TYPE'));
    END IF;
    --l_KOM_IR  number; -- % ������ ����-��� ����� ��� ���� � ����� �� ������
    l_kom_ir := to_number2(wcs_utl.get_creditdata(p_bid_id, 'MONTHLY_FEE'));

    --l_KOM_KV     int; -- ���.��.��� ���-��� ���-�� (3578) �� ����-��� ��� ��������������

    --l_CR9_KV     int; -- ���.��.��� ���-��� ���-�� (3578) �� ����� �����

    --l_CR9_IR     int; -- % ������ �� ����� �����

    --l_CR9_I      int; -- % 0- ������ , 1- �� ������-��� ����-��� �����

    --l_SN8_IR     int; -- % ������ ����
    l_sn8_ir := to_number2(wcs_utl.get_creditdata(p_bid_id, 'PENALTY'));

    --l_SN8_KV     int; -- % ������ ����

    --l_SK4_IR     int;  -- % ������ �� ��������� ���������
    IF l_is_standart = 0 THEN
      l_sk4_ir := to_number(wcs_utl.get_mac(p_bid_id
                                           ,'MAC_AHEADPAYMENT_FEE'));
    ELSE
      l_sk4_ir := wcs_utl.get_answ_decimal(p_bid_id, 'AHEADPAYMENT_FEE');
    END IF;

    cck.cc_open_com(p_nd       => p_bid_id
                   , -- ��� ���������� �������� (���������)
                    p_sdi      => l_sdi
                   , -- ����� �������� (� ���., ����� 150.00���),
                    p_f        => NULL
                   , -- ����� �������������� ��������,
                    p_f_freq   => 2
                   , -- ������������� ������ ���� ��������
                    p_kom      => l_kom
                   , -- ��� ��������
                    p_kom_ir   => l_kom_ir
                   , -- % ������ ����-��� ����� ��� ���� � ����� �� ������
                    p_kom_freq => 2
                   , --  ������������� ����������� ��������
                    p_kom_datf => l_dat1
                   , -- ���� ������� ����������
                    p_kom_date => NULL
                   , -- ���� ��������� ����������
                    p_kom_kv   => NULL
                   , -- ���.��.��� ���-��� ���-�� (3578) �� ����-��� ��� ��������������
                    p_cr9_kv   => l_kv
                   , -- ���.��.��� ���-��� ���-�� (3578) �� ����� �����
                    p_cr9_ir   => NULL
                   , -- % ������ �� ����� �����
                    p_cr9_i    => l_cr9_i
                   , -- % 0- ������ , 1- �� ������-��� ����-��� �����
                    p_sn8_ir   => l_sn8_ir
                   , -- % ������ ����
                    p_sn8_kv   => l_kv
                   , -- % ������ ����
                    p_sk4_ir   => l_sk4_ir -- % ������ �� ��������� ���������
                    );

    --���������� ���������� �������� 8999
    -- �������������� ��������� ��� ������� ��� ��� ��������� �����
    IF l_is_employee = 1
       AND l_is_base_rate = 1 THEN
      cck_app.set_nd_txt(p_bid_id
                        ,'INTRT'
                        ,wcs_utl.get_creditdata(p_bid_id, 'INTEREST_RATE')); -- �������� ���������� ������
      cck_app.set_nd_txt(p_bid_id
                        ,'DTRTB'
                        ,wcs_utl.get_creditdata(p_bid_id
                                               ,'DATE_RATE_BEGIN')); -- ���� ������ �������� �������� ���������� ������
    END IF;

    -- ������ ���
    SELECT a.acc
      INTO l_acc
      FROM nd_acc na, accounts a
     WHERE na.acc = a.acc
       AND na.nd = p_bid_id
       AND a.tip = 'LIM';
    IF l_is_employee = 1
       AND l_is_base_rate = 1
       AND l_is_affiliate = 0 THEN
      IF type_gpk = 4 THEN
        BEGIN
          --          select a.acc into l_acc from nd_acc na, accounts a where na.acc = a.acc and na.nd = p_bid_id and a.tip = 'LIM';
          UPDATE int_accn
             SET basem = 1, basey = 2
           WHERE acc = l_acc
             AND id = 0;
        END;
      END IF;
      cck.br_int(p_bid_id, g_br);
    ELSIF l_is_affiliate = 1 THEN
      BEGIN
        --        select a.acc into l_acc from nd_acc na, accounts a where na.acc = a.acc and na.nd = p_bid_id and a.tip = 'LIM';
        DELETE FROM int_ratn
         WHERE acc = l_acc
           AND id = 0;
        INSERT INTO int_ratn
          (acc, id, bdat, ir, idu)
        VALUES
          (l_acc, 0, l_dat1, l_affiliate_rate, user_id);
        INSERT INTO int_ratn
          (acc, id, bdat, ir, idu)
        VALUES
          (l_acc, 0, add_months(l_dat1, 12), l_ir, user_id);
      END;
    END IF;
    cck_dop.builder_gpk(p_bid_id, NULL, l_rterm, 0);
    /*cck.cc_tmp_gpk(nd_      => p_bid_id
                  ,nvid_    => type_gpk
                  ,acc8_    => l_acc
                  ,dat3_    => l_dat1
                  ,dat4_    => l_dat4
                  ,reserv_  => NULL
                  ,sumr_    => NULL
                  ,gl_bdate => NULL);*/
    cck.UNI_GPK_FL(p_lim2  => l_s,
                   p_gpk   => type_gpk,
                   p_dd    => l_pay_day,
                   p_datn  => l_dat1,
                   p_datk  => l_dat4,
                   p_ir    => l_ir,
                   p_pl1   => null,
                   p_ssr   => null,
                   p_ss    => null,
                   p_acrd  => null,
                   p_basey => l_basey);

    -- ����������� �� ������ (l_SDI - � ���., ����. 15000���)
    cck_dop.calc_sdi(p_bid_id, l_sdi * 100);

    -- ��������� ���-��� ���-��
    -- �������� ���������� ������
    BEGIN
      EXECUTE IMMEDIATE 'alter trigger TAIU_ND_TXT_VNCR disable';
      cck_app.set_nd_txt(p_bid_id
                        ,'VNCRP'
                        ,wcs_utl.get_answ_list_text(p_bid_id, 'CRISK_OBU'));
      cck_app.set_nd_txt(p_bid_id
                        ,'VNCRR'
                        ,wcs_utl.get_answ_list_text(p_bid_id, 'CRISK_OBU'));
      EXECUTE IMMEDIATE 'alter trigger TAIU_ND_TXT_VNCR enable';
    EXCEPTION
      WHEN OTHERS THEN
        EXECUTE IMMEDIATE 'alter trigger TAIU_ND_TXT_VNCR enable';
    END;
    IF wcs_utl.get_answ_bool(p_bid_id, 'PI_PARTNER_SELECTED') = 1 THEN
      cck_app.set_nd_txt(p_bid_id, 'PARTN', 'Ta�');
      cck_app.set_nd_txt(p_bid_id
                        ,'PAR_N'
                        ,wcs_utl.get_answ_list_text(p_bid_id
                                                   ,'PI_PARTNER_ID'));
      cck_app.set_nd_txt(p_bid_id
                        ,'PAR_I'
                        ,wcs_utl.get_answ_text(p_bid_id, 'PI_WHO_INVOLVED'));
    ELSE
      cck_app.set_nd_txt(p_bid_id, 'PARTN', 'ͳ');
    END IF;

    -- �������� �� = 2-������
    cck_app.set_nd_txt(p_bid_id, 'CCSRC', '2');
  END;

  -- ����������� �������
  PROCEDURE register_credit(p_bid_id IN v_wcs_bids.bid_id%TYPE -- ������������� ������
                            ) IS
    l_proc_name VARCHAR2(40) := 'register_credit. ';
    l_rnk       customer.rnk%TYPE; -- ��� ������ �������
  BEGIN
    bars_audit.debug(g_pack_name || l_proc_name ||
                     'START !!! Params: p_bid_id=' || to_char(p_bid_id));

    -- ����������� �����������
    l_rnk := wcs_register.register_client(p_bid_id);
    wcs_pack.bid_set_rnk(p_bid_id, l_rnk);

    --  ����������� ��
    --BEGIN
      wcs_register.register_deal(p_bid_id, l_rnk);
    /*EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;*/
    -- ����������� �������� 3-� ���
    --wcs_register.reg_servise_app_pay_client(p_bid_id);
    --������� ������������� �������� ��� ������
    wcs_register.register_comp_prg(p_bid_id => p_bid_id);

    bars_audit.debug(g_pack_name || l_proc_name || 'Finish. - OK!');
  END register_credit;

  /* !!! ���� ���������� ������ �����������
  -- ����������� �������� ��������� �� �������
  function set_client_ins_deal(p_bid_id        in v_wcs_bid_insurances.bid_id%type, -- ������������� ������
                               p_insurance_id  in v_wcs_bid_insurances.insurance_id%type, -- ������������� ���� ���������
                               p_insurance_num in v_wcs_bid_insurances.insurance_num%type, -- ����� ���������
                               p_rnk           in customer.rnk%type -- ��� �������
                               ) return ins_deals.id%type is
    l_bi_row v_wcs_bid_insurances%rowtype;
    l_id_row ins_deals%rowtype;
  begin
    -- ��������� ��������� �� ������
    select *
      into l_bi_row
      from v_wcs_bid_insurances bi
     where bi.bid_id = p_bid_id
       and bi.insurance_id = p_insurance_id
       and bi.insurance_num = p_insurance_num;

    -- ���������� ��������� ��� ��������� ��������
    l_id_row.partner_id := l_bi_row.partner_id;
    l_id_row.type_id    := l_bi_row.ins_type_id;
    l_id_row.ser        := l_bi_row.ser;
    l_id_row.num        := l_bi_row.num;
    l_id_row.date_on    := l_bi_row.date_on;
    l_id_row.date_off   := l_bi_row.date_off;
    l_id_row.sum        := l_bi_row.sum;

    if wcs_utl.get_answ(p_bid_id,
                        'INS_COST_TYPE',
                        l_bi_row.ws_id,
                        l_bi_row.insurance_num) = 0 then
      l_id_row.insu_tariff := wcs_utl.get_answ(p_bid_id,
                                               'INS_COST_TARIFF',
                                               l_bi_row.ws_id,
                                               l_bi_row.insurance_num);
      l_id_row.insu_sum    := l_id_row.sum * l_id_row.insu_tariff / 100;
    else
      l_id_row.insu_sum := wcs_utl.get_answ(p_bid_id,
                                            'INS_COST_SUM',
                                            l_bi_row.ws_id,
                                            l_bi_row.insurance_num);
    end if;

    l_id_row.rnk    := p_rnk;
    l_id_row.grt_id := null;
    l_id_row.nd     := p_bid_id;

    if wcs_utl.get_answ(p_bid_id,
                        'INS_RENEW_NEED',
                        l_bi_row.ws_id,
                        l_bi_row.insurance_num) in ('0', 'N') then
      l_id_row.renew_need      := 'N';
      l_id_row.renew_alertdays := null;
    else
      l_id_row.renew_need      := 'Y';
      l_id_row.renew_alertdays := ins_pack.get_alertdays;
    end if;

    -- ����������� �������� �����������
    l_id_row.id := ins_pack.f_create_deal(p_partner_id      => l_id_row.partner_id,
                                          p_type_id         => l_id_row.type_id,
                                          p_ser             => l_id_row.ser,
                                          p_num             => l_id_row.num,
                                          p_date_on         => l_id_row.date_on,
                                          p_date_off        => l_id_row.date_off,
                                          p_sum             => l_id_row.sum,
                                          p_insu_tariff     => l_id_row.insu_tariff,
                                          p_insu_sum        => l_id_row.insu_sum,
                                          p_rnk             => l_id_row.rnk,
                                          p_grt_id          => l_id_row.grt_id,
                                          p_nd              => l_id_row.nd,
                                          p_renew_need      => l_id_row.renew_need,
                                          p_renew_alertdays => l_id_row.renew_alertdays);

    -- ��������� ��������� ���������
    append_payment_ins(l_id_row.id,
                       sysdate,
                       l_id_row.insu_sum,
                       l_id_row.renew_alertdays,
                       wcs_utl.get_answ(p_bid_id,
                                        'INS_PAYMENTS_FREQ',
                                        l_bi_row.ws_id,
                                        l_bi_row.insurance_num));

    return l_id_row.id;
  end set_client_ins_deal;

  -- ����������� ��������� ��������� �� �������
  procedure register_client_insurances(p_bid_id in v_wcs_bid_insurances.bid_id%type, -- ������������� ������
                                       p_rnk    in customer.rnk%type default null -- ��� �������
                                       ) is
    l_rnk customer.rnk%type;
  begin
    -- �������� ��� �������
    select nvl(p_rnk, min(cd.rnk))
      into l_rnk
      from cc_deal cd
     where cd.nd = p_bid_id;

    -- ���������� ������������ �������� ���������
    for cur in (select *
                  from v_wcs_bid_insurances bi
                 where bi.bid_id = p_bid_id) loop
      declare
        l_ins_deal_id ins_deals.id%type;
      begin
        l_ins_deal_id := set_client_ins_deal(cur.bid_id,
                                             cur.insurance_id,
                                             cur.insurance_num,
                                             l_rnk);
      end;
    end loop;
  end register_client_insurances;

  -- ����������� �������� ��������� �� �����������
  function set_grt_ins_deal(p_bid_id        in v_wcs_bid_grt_insurances.bid_id%type, -- ������������� ������
                            p_garantee_id   in v_wcs_bid_grt_insurances.garantee_id%type, -- ������������� ���� �����������
                            p_garantee_num  in v_wcs_bid_grt_insurances.garantee_num%type, -- ����� �����������
                            p_insurance_id  in v_wcs_bid_grt_insurances.insurance_id%type, -- ������������� ���� ���������
                            p_insurance_num in v_wcs_bid_grt_insurances.insurance_num%type, -- ����� ���������
                            p_rnk           in customer.rnk%type, -- ��� ������������ (���������� � ������ ������)
                            p_grt_id        in grt_deals.deal_id%type -- ������������� �������� ������
                            ) return ins_deals.id%type is
    l_bgi_row v_wcs_bid_grt_insurances%rowtype;
    l_id_row  ins_deals%rowtype;
  begin
    -- ��������� ��������� �� ������
    select *
      into l_bgi_row
      from v_wcs_bid_grt_insurances bgi
     where bgi.bid_id = p_bid_id
       and bgi.garantee_id = p_garantee_id
       and bgi.garantee_num = p_garantee_num
       and bgi.insurance_id = p_insurance_id
       and bgi.insurance_num = p_insurance_num;

    -- ���������� ��������� ��� ��������� ��������
    l_id_row.partner_id := l_bgi_row.partner_id;
    l_id_row.type_id    := l_bgi_row.ins_type_id;
    l_id_row.ser        := l_bgi_row.ser;
    l_id_row.num        := l_bgi_row.num;
    l_id_row.date_on    := l_bgi_row.date_on;
    l_id_row.date_off   := l_bgi_row.date_off;
    l_id_row.sum        := l_bgi_row.sum;

    if wcs_utl.get_answ(p_bid_id,
                        'INS_COST_TYPE',
                        l_bgi_row.ws_id,
                        l_bgi_row.insurance_num) = 0 then
      l_id_row.insu_tariff := wcs_utl.get_answ(p_bid_id,
                                               'INS_COST_TARIFF',
                                               l_bgi_row.ws_id,
                                               l_bgi_row.insurance_num);
      l_id_row.insu_sum    := l_id_row.sum * l_id_row.insu_tariff / 100;
    else
      l_id_row.insu_sum := wcs_utl.get_answ(p_bid_id,
                                            'INS_COST_SUM',
                                            l_bgi_row.ws_id,
                                            l_bgi_row.insurance_num);
    end if;

    l_id_row.rnk    := p_rnk;
    l_id_row.grt_id := p_grt_id;
    l_id_row.nd     := p_bid_id;

    if wcs_utl.get_answ(p_bid_id,
                        'INS_RENEW_NEED',
                        l_bgi_row.ws_id,
                        l_bgi_row.insurance_num) in ('0', 'N') then
      l_id_row.renew_need      := 'N';
      l_id_row.renew_alertdays := null;
    else
      l_id_row.renew_need      := 'Y';
      l_id_row.renew_alertdays := ins_pack.get_alertdays;
    end if;

    -- ����������� �������� �����������
    l_id_row.id := ins_pack.f_create_deal(p_partner_id      => l_id_row.partner_id,
                                          p_type_id         => l_id_row.type_id,
                                          p_ser             => l_id_row.ser,
                                          p_num             => l_id_row.num,
                                          p_date_on         => l_id_row.date_on,
                                          p_date_off        => l_id_row.date_off,
                                          p_sum             => l_id_row.sum,
                                          p_insu_tariff     => l_id_row.insu_tariff,
                                          p_insu_sum        => l_id_row.insu_sum,
                                          p_rnk             => l_id_row.rnk,
                                          p_grt_id          => l_id_row.grt_id,
                                          p_nd              => l_id_row.nd,
                                          p_renew_need      => l_id_row.renew_need,
                                          p_renew_alertdays => l_id_row.renew_alertdays);

    -- ��������� ��������� ���������
    append_payment_ins(l_id_row.id,
                       l_id_row.date_on,
                       l_id_row.insu_sum,
                       ins_pack.get_alertdays,
                       wcs_utl.get_answ(p_bid_id,
                                        'INS_PAYMENTS_FREQ',
                                        l_bgi_row.ws_id,
                                        l_bgi_row.insurance_num));

    return l_id_row.id;
  end set_grt_ins_deal;
  */

  -- ����������� ���. ���������� ����������� ���� ������������ ����
  PROCEDURE set_grt_vehicle_deal
  (
    p_bid_id       IN v_wcs_bid_garantees.bid_id%TYPE
   , -- ������������� ������
    p_ws_id        IN v_wcs_bid_garantees.ws_id%TYPE
   , -- ������������� �������� ������������
    p_garantee_num IN v_wcs_bid_garantees.garantee_num%TYPE
   , -- ����� �����������
    p_grt_id       IN grt_deals.deal_id%TYPE -- ������������� �������� �����������
  ) IS
    l_gv_row grt_vehicles%ROWTYPE;
  BEGIN
    l_gv_row.deal_id              := p_grt_id;
    l_gv_row.type                 := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_3_1'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gv_row.model                := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_3_2'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gv_row.mileage              := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_3_3'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gv_row.veh_reg_num          := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_3_4'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gv_row.made_date            := to_date('01/01/' ||
                                             wcs_utl.get_answ(p_bid_id
                                                             ,'GRT_3_5'
                                                             ,p_ws_id
                                                             ,p_garantee_num)
                                            ,'dd/mm/yyyy');
    l_gv_row.color                := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_3_6'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gv_row.vin                  := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_3_7'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gv_row.engine_num           := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_3_8'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gv_row.reg_doc_ser          := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_3_9'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gv_row.reg_doc_num          := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_3_10'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gv_row.reg_doc_date         := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_3_10_0'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gv_row.reg_doc_organ        := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_3_11'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gv_row.reg_owner_addr       := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_3_12'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gv_row.reg_spec_marks       := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_3_13'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gv_row.parking_addr         := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_3_14'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gv_row.crd_end_date         := NULL;
    l_gv_row.ownship_reg_num      := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_3_15'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gv_row.ownship_reg_checksum := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_3_16'
                                                     ,p_ws_id
                                                     ,p_garantee_num);

    grt_mgr.iu_vehicles(l_gv_row.deal_id
                       ,l_gv_row.type
                       ,l_gv_row.model
                       ,l_gv_row.mileage
                       ,l_gv_row.veh_reg_num
                       ,l_gv_row.made_date
                       ,l_gv_row.color
                       ,l_gv_row.vin
                       ,l_gv_row.engine_num
                       ,l_gv_row.reg_doc_ser
                       ,l_gv_row.reg_doc_num
                       ,l_gv_row.reg_doc_date
                       ,l_gv_row.reg_doc_organ
                       ,l_gv_row.reg_owner_addr
                       ,l_gv_row.reg_spec_marks
                       ,l_gv_row.parking_addr
                       ,l_gv_row.crd_end_date
                       ,l_gv_row.ownship_reg_num
                       ,l_gv_row.ownship_reg_checksum);
  END set_grt_vehicle_deal;

  -- ����������� ���. ���������� ����������� ���� �������
  PROCEDURE set_grt_deposit_deal
  (
    p_bid_id       IN v_wcs_bid_garantees.bid_id%TYPE
   , -- ������������� ������
    p_ws_id        IN v_wcs_bid_garantees.ws_id%TYPE
   , -- ������������� �������� ������������
    p_garantee_num IN v_wcs_bid_garantees.garantee_num%TYPE
   , -- ����� �����������
    p_grt_id       IN grt_deals.deal_id%TYPE -- ������������� �������� �����������
  ) IS
    l_gd_row grt_deposits%ROWTYPE;
  BEGIN
    l_gd_row.deal_id     := p_grt_id;
    l_gd_row.doc_num     := wcs_utl.get_answ(p_bid_id
                                            ,'GRT_6_1'
                                            ,p_ws_id
                                            ,p_garantee_num);
    l_gd_row.doc_date    := wcs_utl.get_answ(p_bid_id
                                            ,'GRT_6_2'
                                            ,p_ws_id
                                            ,p_garantee_num);
    l_gd_row.doc_enddate := wcs_utl.get_answ(p_bid_id
                                            ,'GRT_6_3'
                                            ,p_ws_id
                                            ,p_garantee_num);

    BEGIN
      SELECT a.acc
        INTO l_gd_row.acc
        FROM accounts a
       WHERE a.nls =
             wcs_utl.get_answ(p_bid_id, 'GRT_6_4', p_ws_id, p_garantee_num)
         AND a.kv =
             wcs_utl.get_answ(p_bid_id, 'GRT_6_5', p_ws_id, p_garantee_num);
    EXCEPTION
      WHEN no_data_found THEN
        /*
        TODO: owner="tvSukhov" created="06.06.2011"
        text="���������� ������ ������ �� bars_error"
        */
        raise_application_error(-20331
                               ,'��� ��������� ������ �' || p_bid_id ||
                                ' � ����������� ����������� �������� ������ �� ������ ���� ' ||
                                wcs_utl.get_answ(p_bid_id
                                                ,'GRT_6_4'
                                                ,p_ws_id
                                                ,p_garantee_num) || '(' ||
                                wcs_utl.get_answ(p_bid_id
                                                ,'GRT_6_5'
                                                ,p_ws_id
                                                ,p_garantee_num) || ') !'
                               ,TRUE);
    END;

    grt_mgr.iu_deposits(l_gd_row.deal_id
                       ,l_gd_row.doc_num
                       ,l_gd_row.doc_date
                       ,l_gd_row.doc_enddate
                       ,l_gd_row.acc);
  END set_grt_deposit_deal;

  -- ����������� ���. ���������� ����������� ���� ��������/�������
  PROCEDURE set_grt_mortgage_deal
  (
    p_bid_id       IN v_wcs_bid_garantees.bid_id%TYPE
   , -- ������������� ������
    p_ws_id        IN v_wcs_bid_garantees.ws_id%TYPE
   , -- ������������� �������� ������������
    p_garantee_num IN v_wcs_bid_garantees.garantee_num%TYPE
   , -- ����� �����������
    p_grt_id       IN grt_deals.deal_id%TYPE -- ������������� �������� �����������
  ) IS
    l_gm_row grt_mortgage%ROWTYPE;
  BEGIN
    l_gm_row.deal_id              := p_grt_id;
    l_gm_row.rooms_cnt            := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_4_1'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gm_row.app_num              := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_4_2'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gm_row.total_space          := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_4_3'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gm_row.living_space         := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_4_4'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gm_row.floor                := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_4_5'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gm_row.addr                 := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_4_6'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gm_row.buiding_type         := wcs_utl.get_answ_list_text(p_bid_id
                                                               ,'GRT_4_7'
                                                               ,p_ws_id
                                                               ,p_garantee_num);
    l_gm_row.building_num         := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_4_8'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gm_row.building_lit         := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_4_9'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gm_row.city                 := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_4_10'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gm_row.city_distr           := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_4_11'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gm_row.living_distr         := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_4_12'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gm_row.micro_distr          := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_4_13'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gm_row.area_num             := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_4_14'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gm_row.build_sect_count     := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_4_15'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gm_row.add_grt_addr         := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_4_16'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gm_row.mort_doc_num         := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_4_17'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gm_row.mort_doc_date        := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_4_18'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gm_row.ownship_reg_num      := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_4_19'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gm_row.ownship_reg_checksum := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_4_20'
                                                     ,p_ws_id
                                                     ,p_garantee_num);

    grt_mgr.iu_mortgage(l_gm_row.deal_id
                       ,l_gm_row.rooms_cnt
                       ,l_gm_row.app_num
                       ,l_gm_row.total_space
                       ,l_gm_row.living_space
                       ,l_gm_row.floor
                       ,l_gm_row.addr
                       ,l_gm_row.buiding_type
                       ,l_gm_row.building_num
                       ,l_gm_row.building_lit
                       ,l_gm_row.city
                       ,l_gm_row.city_distr
                       ,l_gm_row.living_distr
                       ,l_gm_row.micro_distr
                       ,l_gm_row.area_num
                       ,l_gm_row.build_sect_count
                       ,l_gm_row.add_grt_addr
                       ,l_gm_row.mort_doc_num
                       ,l_gm_row.mort_doc_date
                       ,l_gm_row.ownship_reg_num
                       ,l_gm_row.ownship_reg_checksum);
  END set_grt_mortgage_deal;

  -- ����������� ���. ���������� ����������� ���� �������� ������
  PROCEDURE set_grt_mortgage_land_deal
  (
    p_bid_id       IN v_wcs_bid_garantees.bid_id%TYPE
   , -- ������������� ������
    p_ws_id        IN v_wcs_bid_garantees.ws_id%TYPE
   , -- ������������� �������� ������������
    p_garantee_num IN v_wcs_bid_garantees.garantee_num%TYPE
   , -- ����� �����������
    p_grt_id       IN grt_deals.deal_id%TYPE -- ������������� �������� �����������
  ) IS
    l_gml_row grt_mortgage_land%ROWTYPE;
  BEGIN
    l_gml_row.deal_id             := p_grt_id;
    l_gml_row.area                := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_5_1'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gml_row.land_purpose        := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_5_2'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gml_row.build_num           := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_5_3'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gml_row.build_lit           := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_5_4'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gml_row.ownship_doc_ser     := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_5_5'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gml_row.ownship_doc_num     := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_5_6'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gml_row.ownship_doc_date    := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_5_7'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gml_row.ownship_doc_reason  := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_5_8'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gml_row.ownship_regbook_num := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_5_9'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gml_row.extract_reg_date    := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_5_10'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gml_row.extract_reg_organ   := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_5_11'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gml_row.extract_reg_num     := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_5_12'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gml_row.extract_reg_sum     := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_5_13'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gml_row.lessee_num          := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_5_14'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gml_row.lessee_name         := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_5_15'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gml_row.lessee_dog_enddate  := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_5_16'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gml_row.lessee_dog_num      := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_5_17'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gml_row.lessee_dog_date     := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_5_18'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gml_row.bans_reg_num        := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_5_19'
                                                     ,p_ws_id
                                                     ,p_garantee_num);
    l_gml_row.bans_reg_date       := wcs_utl.get_answ(p_bid_id
                                                     ,'GRT_5_20'
                                                     ,p_ws_id
                                                     ,p_garantee_num);

    grt_mgr.iu_mortgage_land(l_gml_row.deal_id
                            ,l_gml_row.area
                            ,l_gml_row.land_purpose
                            ,l_gml_row.build_num
                            ,l_gml_row.build_lit
                            ,l_gml_row.ownship_doc_ser
                            ,l_gml_row.ownship_doc_num
                            ,l_gml_row.ownship_doc_date
                            ,l_gml_row.ownship_doc_reason
                            ,l_gml_row.ownship_regbook_num
                            ,l_gml_row.extract_reg_date
                            ,l_gml_row.extract_reg_organ
                            ,l_gml_row.extract_reg_num
                            ,l_gml_row.extract_reg_sum
                            ,l_gml_row.lessee_num
                            ,l_gml_row.lessee_name
                            ,l_gml_row.lessee_dog_enddate
                            ,l_gml_row.lessee_dog_num
                            ,l_gml_row.lessee_dog_date
                            ,l_gml_row.bans_reg_num
                            ,l_gml_row.bans_reg_date);
  END set_grt_mortgage_land_deal;

  -- ����������� ���. ���������� ����������� ���� ����. ������
  PROCEDURE set_grt_product_deal
  (
    p_bid_id       IN v_wcs_bid_garantees.bid_id%TYPE
   , -- ������������� ������
    p_ws_id        IN v_wcs_bid_garantees.ws_id%TYPE
   , -- ������������� �������� ������������
    p_garantee_num IN v_wcs_bid_garantees.garantee_num%TYPE
   , -- ����� �����������
    p_grt_id       IN grt_deals.deal_id%TYPE -- ������������� �������� �����������
  ) IS
    l_gp_row grt_products%ROWTYPE;
  BEGIN
    l_gp_row.deal_id        := p_grt_id;
    l_gp_row.type_txt       := wcs_utl.get_answ(p_bid_id
                                               ,'GRT_7_1'
                                               ,p_ws_id
                                               ,p_garantee_num);
    l_gp_row.name           := wcs_utl.get_answ(p_bid_id
                                               ,'GRT_7_2'
                                               ,p_ws_id
                                               ,p_garantee_num);
    l_gp_row.model          := wcs_utl.get_answ(p_bid_id
                                               ,'GRT_7_3'
                                               ,p_ws_id
                                               ,p_garantee_num);
    l_gp_row.modification   := wcs_utl.get_answ(p_bid_id
                                               ,'GRT_7_4'
                                               ,p_ws_id
                                               ,p_garantee_num);
    l_gp_row.serial_num     := wcs_utl.get_answ(p_bid_id
                                               ,'GRT_7_5'
                                               ,p_ws_id
                                               ,p_garantee_num);
    l_gp_row.made_date      := wcs_utl.get_answ(p_bid_id
                                               ,'GRT_7_6'
                                               ,p_ws_id
                                               ,p_garantee_num);
    l_gp_row.other_comments := wcs_utl.get_answ(p_bid_id
                                               ,'GRT_7_7'
                                               ,p_ws_id
                                               ,p_garantee_num);

    grt_mgr.iu_products(l_gp_row.deal_id
                       ,l_gp_row.type_txt
                       ,l_gp_row.name
                       ,l_gp_row.model
                       ,l_gp_row.modification
                       ,l_gp_row.serial_num
                       ,l_gp_row.made_date
                       ,l_gp_row.other_comments);
  END set_grt_product_deal;

  -- ����������� ���. ���������� ����������� ���� ֳ�����
  PROCEDURE set_grt_valuables_deal
  (
    p_bid_id       IN v_wcs_bid_garantees.bid_id%TYPE
   , -- ������������� ������
    p_ws_id        IN v_wcs_bid_garantees.ws_id%TYPE
   , -- ������������� �������� ������������
    p_garantee_num IN v_wcs_bid_garantees.garantee_num%TYPE
   , -- ����� �����������
    p_grt_id       IN grt_deals.deal_id%TYPE -- ������������� �������� �����������
  ) IS
    l_gv_row grt_valuables%ROWTYPE;
  BEGIN
    l_gv_row.deal_id        := p_grt_id;
    l_gv_row.name           := wcs_utl.get_answ(p_bid_id
                                               ,'GRT_8_1'
                                               ,p_ws_id
                                               ,p_garantee_num);
    l_gv_row.descr          := wcs_utl.get_answ(p_bid_id
                                               ,'GRT_8_2'
                                               ,p_ws_id
                                               ,p_garantee_num);
    l_gv_row.weight         := wcs_utl.get_answ(p_bid_id
                                               ,'GRT_8_3'
                                               ,p_ws_id
                                               ,p_garantee_num);
    l_gv_row.part_cnt       := wcs_utl.get_answ(p_bid_id
                                               ,'GRT_8_4'
                                               ,p_ws_id
                                               ,p_garantee_num);
    l_gv_row.part_disc_weig := wcs_utl.get_answ(p_bid_id
                                               ,'GRT_8_5'
                                               ,p_ws_id
                                               ,p_garantee_num);
    l_gv_row.value_weight   := wcs_utl.get_answ(p_bid_id
                                               ,'GRT_8_6'
                                               ,p_ws_id
                                               ,p_garantee_num);
    l_gv_row.tariff_price   := wcs_utl.get_answ(p_bid_id
                                               ,'GRT_8_7'
                                               ,p_ws_id
                                               ,p_garantee_num);
    l_gv_row.expert_price   := wcs_utl.get_answ(p_bid_id
                                               ,'GRT_8_8'
                                               ,p_ws_id
                                               ,p_garantee_num);
    l_gv_row.estimate_price := wcs_utl.get_answ(p_bid_id
                                               ,'GRT_8_9'
                                               ,p_ws_id
                                               ,p_garantee_num);

    grt_mgr.iu_valuables(l_gv_row.deal_id
                        ,l_gv_row.name
                        ,l_gv_row.descr
                        ,l_gv_row.weight
                        ,l_gv_row.part_cnt
                        ,l_gv_row.part_disc_weig
                        ,l_gv_row.value_weight
                        ,l_gv_row.tariff_price
                        ,l_gv_row.expert_price
                        ,l_gv_row.estimate_price);
  END set_grt_valuables_deal;

  -- ����������� �������� �����������
  FUNCTION set_guarantee_deal
  (
    p_bid_id       IN v_wcs_bid_garantees.bid_id%TYPE
   , -- ������������� ������
    p_garantee_id  IN v_wcs_bid_garantees.garantee_id%TYPE
   , -- ������������� ���� �����������
    p_garantee_num IN v_wcs_bid_garantees.garantee_num%TYPE
   , -- ����� �����������
    p_rnk          IN customer.rnk%TYPE DEFAULT NULL -- ��� �������
  ) RETURN grt_deals.deal_id%TYPE IS
    l_b_row  v_wcs_bids%ROWTYPE;
    l_bg_row v_wcs_bid_garantees%ROWTYPE;
    l_gd_row grt_deals%ROWTYPE;
  BEGIN
    -- ��������� ������
    SELECT * INTO l_b_row FROM v_wcs_bids b WHERE b.bid_id = p_bid_id;

    -- ��������� �������� ����������� �� ������
    SELECT *
      INTO l_bg_row
      FROM v_wcs_bid_garantees bg
     WHERE bg.bid_id = p_bid_id
       AND bg.garantee_id = p_garantee_id
       AND bg.garantee_num = p_garantee_num;

    -- ����������� ��������� �����������/���������� ��� �����������
    IF (p_garantee_id = 'GUARANTOR' OR
       wcs_utl.get_answ(p_bid_id
                        ,'GRT_0'
                        ,l_bg_row.ws_id
                        ,l_bg_row.garantee_num) = 0) THEN
      l_gd_row.deal_rnk := register_client(p_bid_id
                                          ,l_bg_row.ws_id
                                          ,l_bg_row.garantee_num);
    ELSE
      l_gd_row.deal_rnk := p_rnk;
    END IF;

    -- ���������� ��������� ��� ��������� ��������
    l_gd_row.grt_type_id  := l_bg_row.type_obu_id;
    l_gd_row.grt_subj_id  := to_number(wcs_utl.get_answ(p_bid_id
                                                       ,'GRT_2_1_0'
                                                       ,l_bg_row.ws_id
                                                       ,l_bg_row.garantee_num));
    l_gd_row.grt_place_id := CASE
                               WHEN p_garantee_id = 'GUARANTOR' THEN
                               -- ��� ���������� �������� "��������� ������������" ������ 1 - ����������� � ������������
                                1
                               ELSE
                                wcs_utl.get_answ(p_bid_id
                                                ,'GRT_2_2'
                                                ,l_bg_row.ws_id
                                                ,l_bg_row.garantee_num)
                             END;

    l_gd_row.deal_num        := wcs_utl.get_answ(p_bid_id
                                                ,'GRT_2_3'
                                                ,l_bg_row.ws_id
                                                ,l_bg_row.garantee_num);
    l_gd_row.deal_date       := wcs_utl.get_answ(p_bid_id
                                                ,'GRT_2_4'
                                                ,l_bg_row.ws_id
                                                ,l_bg_row.garantee_num);
    l_gd_row.grt_name := CASE
                           WHEN p_garantee_id = 'GUARANTOR' THEN
                           -- ��� ���������� �������� "����� ����� �������" ������ null
                            NULL
                           ELSE
                            wcs_utl.get_answ(p_bid_id
                                            ,'GRT_2_7'
                                            ,l_bg_row.ws_id
                                            ,l_bg_row.garantee_num)
                         END;
    l_gd_row.grt_comment     := wcs_utl.get_answ(p_bid_id
                                                ,'GRT_2_8'
                                                ,l_bg_row.ws_id
                                                ,l_bg_row.garantee_num);
    l_gd_row.grt_buy_dognum  := wcs_utl.get_answ(p_bid_id
                                                ,'GRT_2_9'
                                                ,l_bg_row.ws_id
                                                ,l_bg_row.garantee_num);
    l_gd_row.grt_buy_dogdate := wcs_utl.get_answ(p_bid_id
                                                ,'GRT_2_10'
                                                ,l_bg_row.ws_id
                                                ,l_bg_row.garantee_num);

    CASE
      WHEN p_garantee_id = 'MORTGAGE_LAND' THEN
        l_gd_row.grt_unit := 2;
      WHEN p_garantee_id IN ('VEHICLE'
                            ,'DEPOSIT'
                            ,'PRODUCT'
                            ,'VALUABLES'
                            ,'MORTGAGE'
                            ,'GUARANTOR') THEN
        l_gd_row.grt_unit := 1;
    END CASE;

    /*
    TODO: owner="tvSukhov" category="Finish" priority="1 - High" created="06.06.2011"
    text="�������� ������� ���-�� � l_gd_row.grt_cnt �� ������"
    */
    l_gd_row.grt_cnt := 1;

    CASE
      WHEN p_garantee_id = 'GUARANTOR' THEN
        -- ��� ���������� ����� ����� �� ������� GRT_2_13 - ���� ������,
        -- � ������ �� ������ �������
        l_gd_row.grt_sum := wcs_utl.get_answ(p_bid_id
                                            ,'GRT_2_16'
                                            ,l_bg_row.ws_id
                                            ,l_bg_row.garantee_num);
        SELECT nvl(MIN(t.kv), 980)
          INTO l_gd_row.grt_sum_curcode
          FROM tabval$global t
         WHERE t.lcv = wcs_utl.get_creditdata(p_bid_id, 'CREDIT_CURRENCY')
           AND rownum = 1;

        l_gd_row.chk_sum := wcs_utl.get_answ(p_bid_id
                                            ,'GRT_2_16'
                                            ,l_bg_row.ws_id
                                            ,l_bg_row.garantee_num);
      ELSE
        l_gd_row.grt_sum         := wcs_utl.get_answ(p_bid_id
                                                    ,'GRT_2_12'
                                                    ,l_bg_row.ws_id
                                                    ,l_bg_row.garantee_num);
        l_gd_row.grt_sum_curcode := wcs_utl.get_answ(p_bid_id
                                                    ,'GRT_2_11'
                                                    ,l_bg_row.ws_id
                                                    ,l_bg_row.garantee_num);
        l_gd_row.chk_sum         := wcs_utl.get_answ(p_bid_id
                                                    ,'GRT_2_13'
                                                    ,l_bg_row.ws_id
                                                    ,l_bg_row.garantee_num);
    END CASE;

    l_gd_row.warn_days := grt_mgr.get_warn_days;
    l_gd_row.staff_id  := l_b_row.mgr_id;
    l_gd_row.branch    := l_b_row.branch;

    l_gd_row.deal_id := grt_mgr.register_deal(l_gd_row.grt_type_id
                                             ,l_gd_row.grt_place_id
                                             ,l_gd_row.deal_rnk
                                             ,l_gd_row.deal_num
                                             ,l_gd_row.deal_date
                                             ,NULL
                                             , -- p_deal_name
                                              NULL
                                             , -- p_deal_place
                                              l_gd_row.grt_name
                                             ,l_gd_row.grt_comment
                                             ,l_gd_row.grt_buy_dognum
                                             ,l_gd_row.grt_buy_dogdate
                                             ,l_gd_row.grt_unit
                                             ,l_gd_row.grt_cnt
                                             ,l_gd_row.grt_sum * 100
                                             ,l_gd_row.grt_sum_curcode
                                             ,l_gd_row.chk_date_avail
                                             ,l_gd_row.chk_date_status
                                             ,l_gd_row.revalue_date
                                             ,l_gd_row.chk_sum * 100
                                             ,l_gd_row.warn_days
                                             ,l_gd_row.staff_id
                                             ,l_gd_row.branch
                                             ,360
                                             ,l_gd_row.grt_sum
                                             ,l_gd_row.grt_subj_id);

    -- �������� � ���������� ��������
    grt_mgr.fill_cc_grt(p_bid_id, l_gd_row.deal_id);

    -- ����������� ���. ����������
    CASE
      WHEN p_garantee_id = 'VEHICLE' THEN
        set_grt_vehicle_deal(p_bid_id
                            ,l_bg_row.ws_id
                            ,p_garantee_num
                            ,l_gd_row.deal_id);
      WHEN p_garantee_id = 'DEPOSIT' THEN
        set_grt_deposit_deal(p_bid_id
                            ,l_bg_row.ws_id
                            ,p_garantee_num
                            ,l_gd_row.deal_id);
      WHEN p_garantee_id = 'MORTGAGE' THEN
        set_grt_mortgage_deal(p_bid_id
                             ,l_bg_row.ws_id
                             ,p_garantee_num
                             ,l_gd_row.deal_id);
      WHEN p_garantee_id = 'MORTGAGE_LAND' THEN
        set_grt_mortgage_land_deal(p_bid_id
                                  ,l_bg_row.ws_id
                                  ,p_garantee_num
                                  ,l_gd_row.deal_id);
      WHEN p_garantee_id = 'PRODUCT' THEN
        set_grt_product_deal(p_bid_id
                            ,l_bg_row.ws_id
                            ,p_garantee_num
                            ,l_gd_row.deal_id);
      WHEN p_garantee_id = 'VALUABLES' THEN
        set_grt_valuables_deal(p_bid_id
                              ,l_bg_row.ws_id
                              ,p_garantee_num
                              ,l_gd_row.deal_id);
      ELSE
        NULL;
    END CASE;

    /* !!! ���� ���������� ������ �����������
    -- ��������� ����������� (� ��� ����� � ������)
    for cur in (select *
                  from v_wcs_bid_grt_insurances bgi
                 where bgi.bid_id = p_bid_id
                   and bgi.garantee_id = p_garantee_id
                   and bgi.garantee_num = p_garantee_num) loop
      declare
        l_ins_deal_id ins_deals.id%type;
      begin
        l_ins_deal_id := set_grt_ins_deal(cur.bid_id,
                                          cur.garantee_id,
                                          cur.garantee_num,
                                          cur.insurance_id,
                                          cur.insurance_num,
                                          l_gd_row.deal_rnk,
                                          l_gd_row.deal_id);
      end;

    end loop;
    */

    RETURN l_gd_row.deal_id;
  END set_guarantee_deal;

  -- ����������� ��������� �����������
  PROCEDURE register_guarantees
  (
    p_bid_id IN v_wcs_bid_garantees.bid_id%TYPE
   , -- ������������� ������
    p_rnk    IN customer.rnk%TYPE DEFAULT NULL -- ��� �������
  ) IS
    l_rnk customer.rnk%TYPE;
  BEGIN
    -- �������� ��� �������
    SELECT nvl(p_rnk, MIN(cd.rnk))
      INTO l_rnk
      FROM cc_deal cd
     WHERE cd.nd = p_bid_id;

    -- ���������� ������������ �������� �����������
    FOR cur IN (SELECT *
                  FROM v_wcs_bid_garantees bg
                 WHERE bg.bid_id = p_bid_id)
    LOOP
      DECLARE
        l_grt_deal_id grt_deals.deal_id%TYPE;
      BEGIN
        l_grt_deal_id := set_guarantee_deal(cur.bid_id
                                           ,cur.garantee_id
                                           ,cur.garantee_num
                                           ,l_rnk);
      END;
    END LOOP;

    FOR c IN (SELECT *
                FROM v_wcs_bid_garantees
               WHERE bid_id = p_bid_id
                 AND wcs_utl.has_answ(bid_id
                                     ,'CERTIFY_NOTARY'
                                     ,ws_id
                                     ,garantee_num) = 1
                 AND rownum = 1)
    LOOP
      DECLARE
        l_acrnotary VARCHAR2(100) := wcs_utl.get_answ_refer(p_bid_id
                                                           ,'CERTIFY_NOTARY'
                                                           ,c.ws_id
                                                           ,c.garantee_num);
        l_fionotary VARCHAR2(200);
        l_innnotary VARCHAR2(14);
        l_accnotary VARCHAR2(14);
      BEGIN
        SELECT vn.id, vn.tin, n.account_number
          INTO l_fionotary, l_innnotary, l_accnotary
          FROM v_active_notary_accreditation vn, v_notary_accreditation n
         WHERE vn.id = n.id
           AND vn.id = l_acrnotary;

        cck_app.set_nd_txt(p_bid_id, 'FION', l_fionotary);

        cck_app.set_nd_txt(p_bid_id, 'INNN', l_innnotary);

        cck_app.set_nd_txt(p_bid_id, 'ACCN', l_accnotary);
      END;
    END LOOP;
  END register_guarantees;

  -- ����������� ������/�������
  /*
  p_visa - ��������������� �������� ��������
  0  - ������-�� ��, �������� ������� ��������� � ������ �������������� �� ������
  2  - �������������� ����������� � �������� ���������.
  4  - ����-�� ����� �������� � �����������. �������������� ������� ����
  10 - ������������ �������� �� ������ ������. ������������ �������� �� ����� ��������. �� ��������� � ����� ������������

  15 - ����������� ��
  */
  PROCEDURE put_visa
  (
    p_bid_id IN NUMBER
   , -- ������������� ������
    p_visa   IN NUMBER
  ) IS
    l_current_visa NUMBER;
    l_rnk          NUMBER;
    m_type         varchar2_list;
    l_acc          accounts.acc%TYPE;
  BEGIN
    -- ������� ���������
    SELECT MAX(sos)
      INTO l_current_visa
      FROM cc_deal cd
     WHERE cd.nd = p_bid_id;

    -- ���������� �������� ��������� ���������
    IF to_char(l_current_visa) || '_' || to_char(p_visa) NOT IN
       ('_0'
       ,'0_2'
       ,'2_4'
       ,'4_4'
       ,'4_10'
       ,'0_15'
       ,'2_15'
       ,'4_15'
       ,'10_15'
       ,'13_15') THEN
      raise_application_error(-20899
                             ,'������������ ���� ��� ��(' ||
                              to_char(p_bid_id) || ') � ����� - ' ||
                              to_char(l_current_visa) || ' � ���� - ' ||
                              to_char(p_visa));
    END IF;

    IF (p_visa = 2) THEN

      -- ��������� acc �������� �����
      l_acc := to_number(wcs_utl.get_answ_text(p_bid_id, 'PI_CURACC_ACCNO'));
      INSERT INTO nd_acc (nd, acc) VALUES (p_bid_id, l_acc);

      -- ����������� �����������
      wcs_register.register_guarantees(p_bid_id, NULL);

      /* !!! ���� ���������� ������ �����������
      -- ����������� �������� ��������� �� �������
      wcs_register.register_client_insurances(p_bid_id, null);
      */

      cck.cc_sob(p_bid_id, gl.bd, NULL, NULL, NULL, NULL, NULL, -2);
      UPDATE cc_deal cd SET cd.sos = 2 WHERE cd.nd = p_bid_id;

      -- !!! ��������� � cck.put_sos(nd,2);

    ELSIF p_visa = 4 THEN

      -- �������� ��������� ������
      -- ����� ����� ���������  ������ �� ���������
      SELECT DISTINCT tip BULK COLLECT
        INTO m_type
        FROM vidd_tip
       WHERE vidd = 11
         AND tip IN ('SS ', 'SN ', 'SD ', 'SDI', 'CR9');

      cck_dop.open_an_account(p_bid_id, m_type);

      -- �������� ������ �����������
      FOR t_grt IN (SELECT grt_deal_id FROM cc_grt WHERE nd = p_bid_id)
      LOOP
        l_acc := grt_mgr.authorize_deal(t_grt.grt_deal_id);
      END LOOP;

      cck.cc_sob(p_bid_id, gl.bd, NULL, NULL, NULL, NULL, NULL, -4);

      UPDATE cc_deal cd SET cd.sos = 4 WHERE cd.nd = p_bid_id;
      -- !!! ��������� � cck.put_sos(nd,4);
    ELSIF p_visa = 10 THEN
      UPDATE cc_deal cd SET cd.sos = 10 WHERE cd.nd = p_bid_id;
      -- !!! ��������� � cck.put_sos(nd,10);
    ELSIF p_visa = 15
          AND l_current_visa < 10 THEN
      cck.cc_delete(p_bid_id);
      cck.cc_sob(p_bid_id, gl.bd, NULL, NULL, NULL, NULL, NULL, -15);
    ELSIF p_visa = 15
          AND l_current_visa > 10 THEN
      UPDATE cc_deal SET sos = 15 WHERE nd = p_bid_id;
      cck.cc_sob(p_bid_id, gl.bd, NULL, NULL, NULL, NULL, NULL, -15);

      FOR t_grt IN (SELECT grt_deal_id FROM cc_grt WHERE nd = p_bid_id)
      LOOP
        grt_mgr.close_deal(t_grt.grt_deal_id);
      END LOOP;

      UPDATE cc_deal cd SET cd.sos = 15 WHERE cd.nd = p_bid_id;
      -- !!! ��������� � cck.put_sos(nd,15);
      NULL;
    END IF;
  END put_visa;

END wcs_register;
/
show err;
 
PROMPT *** Create  grants  WCS_REGISTER ***
grant EXECUTE                                                                on WCS_REGISTER    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on WCS_REGISTER    to RCC_DEAL;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/wcs_register.sql =========*** End **
 PROMPT ===================================================================================== 
 