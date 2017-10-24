CREATE OR REPLACE PACKAGE pkg_escr_reg_utl IS
  c_branch VARCHAR2(4000) := sys_context(bars_context.context_ctx
                                        ,bars_context.ctxpar_userbranch);
  /**********************************************
    FUNCTION header_version
    DESCRIPTION: ������� ������ ������������ ������
  *********************************************/
  FUNCTION header_version RETURN VARCHAR2;
  /**********************************************
    FUNCTION body_version
   DESCRIPTION: ������� ������ ��� ������
  *********************************************/
  FUNCTION body_version RETURN VARCHAR2;

  PROCEDURE p_oplv(p_ref NUMBER);

  PROCEDURE p_dop
  (
    p_ref NUMBER
   ,s_nd  VARCHAR2
   ,s_sd  VARCHAR2
   ,s_cd  VARCHAR2
   ,s_id  VARCHAR2
  );

  PROCEDURE p_pay1
  (
    flg_  SMALLINT
   , -- ���� ������
    ref_  INTEGER
   , -- ����������
    vdat_ DATE
   , -- ���� ������������
    tt_   CHAR
   , -- ��� ����������
    dk_   NUMBER
   , -- ������� �����-������
    kv_   SMALLINT
   , -- ��� ������ �
    nlsm_ VARCHAR2
   , -- ����� ����� �
    sa_   DECIMAL
   , -- ����� � ������ �
    kvk_  SMALLINT
   , -- ��� ������ �
    nlsk_ VARCHAR2
   , -- ����� ����� �
    ss_   DECIMAL -- ����� � ������ �
  );

  PROCEDURE p_del1(p_ref NUMBER); -- ��������� ��� � ��������� NLQ 
  /**********************************************
     PROCEDURE : p_reg_create
     DESCRIPTION: ��������� ������
  *********************************************/
  PROCEDURE p_reg_create
  (
    in_date_from escr_register.date_from%TYPE
   ,in_date_to   escr_register.date_to%TYPE
   ,in_reg_type  escr_reg_types.code%TYPE
   ,in_reg_kind  escr_reg_kind.code%TYPE
   ,in_reg_level escr_register.reg_level%TYPE
   ,in_oper_type escr_reg_mapping.oper_type%TYPE
   ,in_obj_list  number_list
   ,out_reg_id   IN OUT escr_register.id%TYPE
  );
  /************************************************************
     PROCEDURE   p_mapping
     DESCRIPTION: ���� ��*���� �� ��*������ ������
  **************************************************************/
  PROCEDURE p_mapping
  (
    in_in_doc_id    escr_reg_mapping.in_doc_id%TYPE
   ,in_in_doc_type  escr_reg_mapping.in_doc_type%TYPE
   ,in_out_doc_id   number_list
   ,in_out_doc_type escr_reg_mapping.out_doc_type%TYPE
   ,in_oper_type    escr_reg_mapping.oper_type %TYPE
   ,in_oper_date    DATE DEFAULT SYSDATE
  );
  /***************************************************************
     PROCEDURE   p_get_status_ID
     DESCRIPTION: ��  ���� ������� �����Ӫ�� ���� ID
  **************************************************************/
  PROCEDURE p_get_status_id
  (
    in_status_code escr_reg_status.code%TYPE
   ,out_status_id  OUT escr_reg_status.id%TYPE
    
  );
  /***************************************************************
     PROCEDURE   p_get_status_ID
     DESCRIPTION: ��  ID ������� �����Ӫ�� ���� CODE
  **************************************************************/
  PROCEDURE p_get_status_code
  (
    in_status_id    escr_reg_status.id%TYPE
   ,out_status_code OUT escr_reg_status.code%TYPE
    
  );
  /***************************************************************
     PROCEDURE   p_get_status_name
     DESCRIPTION: ��  ���� ������� �����Ӫ�� ���� ��`�
  **************************************************************/
  PROCEDURE p_get_status_name
  (
    in_status_code  escr_reg_status.code%TYPE
   ,out_status_name OUT escr_reg_status.name%TYPE
    
  );
  /**********************************************
     PROCEDURE   P_SET_REG_OUT_NUMBER
     DESCRIPTION: ��������ު ���Ͳ�Ͳ� ����� �Ū����
  *********************************************/
  PROCEDURE p_set_reg_out_number
  (
    in_reg_id     escr_register.id%TYPE
   ,in_out_number escr_register.outer_number%TYPE DEFAULT NULL
  );
  /**********************************************
     PROCEDURE P_SET_CREDIT_STATUS
     DESCRIPTION: ��������ު ������ ���������� �������� � nd_txt
  *********************************************/
  PROCEDURE p_set_credit_status
  (
    in_obj_id         IN escr_reg_obj_state.obj_id%TYPE
   ,in_status_code    IN escr_reg_status.code%TYPE
   ,in_status_comment IN escr_reg_obj_state.status_comment%TYPE DEFAULT NULL
   ,in_set_date       IN DATE
  );
  /**********************************************
     PROCEDURE P_get_reg_deals
     DESCRIPTION: ������� �������� �������, �� ������� � �����
  *********************************************/
  PROCEDURE p_get_reg_deals
  (
    in_reg_id     escr_register.id%TYPE
   ,in_check_flag NUMBER DEFAULT 0 -- ���������� �� � ������� ��
   ,out_deal_list OUT number_list
  );
  /**********************************************
     PROCEDURE P_SET_OBJ_STATUS
     DESCRIPTION: ��������ު ������ �Ū���� �� ������� � �Ū��в
  *********************************************/
  PROCEDURE p_set_obj_status
  (
    in_obj_id         escr_reg_obj_state.obj_id%TYPE
   ,in_obj_type       escr_reg_obj_state.obj_type%TYPE
   ,in_status_code    escr_reg_status.code%TYPE
   ,in_status_comment escr_reg_obj_state.status_comment%TYPE DEFAULT NULL
   ,in_obj_check      NUMBER DEFAULT 1
   ,in_set_date       escr_reg_obj_state.set_date%TYPE DEFAULT SYSDATE
   ,in_oper_level     NUMBER DEFAULT 0
  );
  /**********************************************
     PROCEDURE  p_reg_del
     DESCRIPTION: ��������� ������
  *********************************************/
  PROCEDURE p_reg_del(in_reg_id escr_register.id%TYPE);
  /************************************************************
     PROCEDURE   p_unmapping
     DESCRIPTION: ������� ��*���� �� ��*������ ������
  **************************************************************/
  PROCEDURE p_unmapping
  (
    in_doc_id    number_list
   ,in_oper_type escr_reg_mapping.oper_type %TYPE
  );
  /**********************************************
     PROCEDURE   p_received_xml
     DESCRIPTION: ��������� ������ �� �� �� ���� xml ���� � ������ � �������
  *********************************************/
  PROCEDURE p_received_xml
  (
    in_reg_xml IN CLOB
   ,in_flag    NUMBER DEFAULT 0
  );

  PROCEDURE p_xml_parse
  (
    in_reg_xml IN CLOB DEFAULT NULL
   ,in_file_id NUMBER DEFAULT NULL
  );
  /**********************************************
     PROCEDURE   p_gen_pay
     DESCRIPTION: ��������� ��������� �������� ���������
  *********************************************/
  PROCEDURE p_gen_pay(in_reg_list number_list);
  /***************************************************************
     PROCEDURE   p_get_reg_id
     DESCRIPTION:
  **************************************************************/
  PROCEDURE p_get_reg_id
  (
    in_obj_id    NUMBER
   ,in_oper_type NUMBER
   ,out_reg_id   OUT escr_register.id%TYPE
  );
  /***************************************************************
     PROCEDURE   p_get_reg_status_id
     DESCRIPTION: �������� ID ��������� ������� ��*����
  **************************************************************/
  PROCEDURE p_get_obj_status_id
  (
    in_obj_id     NUMBER
   ,in_obj_type   NUMBER
   ,out_status_id OUT escr_reg_status.id%TYPE
  );
  /******************************************************************************
     PROCEDURE   p_get_reg_list
     DESCRIPTION: ������� �-��� ������,���� �� ������� �� ������� ���������
  *****************************************************************************/
  PROCEDURE p_get_reg_list
  (
    in_reg_id       escr_register.id%TYPE
   ,out_branch_list OUT VARCHAR2
  );

  PROCEDURE p_check_before_create
  (
    in_obj_list    IN number_list DEFAULT NULL
   ,in_reg_kind    IN escr_reg_kind.code%TYPE DEFAULT NULL
   ,out_check_flag OUT NUMBER
  );
  PROCEDURE p_sync_state;
  /************************************************************
     PROCEDURE    p_check_after_create
     DESCRIPTION: �������� ���� ��������� ������ �� ���
  **************************************************************/
  PROCEDURE p_check_after_create;
  /***************************************************************
     PROCEDURE   p_change_comp_sum
     DESCRIPTION: ���������� ���� ���� �� �� ���� �����������,
     ��� �������, ���� �� ����������� ��������
  **************************************************************/
  PROCEDURE p_change_comp_sum
  (
    in_deal_id       escr_reg_header.deal_id%TYPE
   ,in_new_good_cost escr_reg_header.new_good_cost%TYPE
  );
  /**********************************************
     PROCEDURE  p_event_del
     DESCRIPTION: ��������� ����������������� ������,
     � �������,���� ���� �� ��������� ���
  *********************************************/
  PROCEDURE p_event_del
  (
    in_deal_id  escr_reg_body.deal_id%TYPE
   ,in_event_id escr_reg_body.id%TYPE
  );
  /********************************************************
     PROCEDURE p_set_new_sum
     DESCRIPTION: Anoaiiae??ouny iiaa aa?o?nou oiaa?o
                  noia e?aaeoo oa noia eiiiainao?? aey
                  EA ii yeei AAA ia iiaiaea ii?aoeia? noie
  *******************************************************/
  PROCEDURE p_set_new_sum
  (
    in_deal_id       NUMBER
   ,in_new_good_cost NUMBER
   ,in_new_deal_sum  NUMBER
   ,in_new_comp_sum  NUMBER
  );
END pkg_escr_reg_utl;
/
CREATE OR REPLACE PACKAGE BODY pkg_escr_reg_utl IS

  g_body_version   CONSTANT VARCHAR2(64) := 'VERSION 8.2.5 22/06/2017';
  g_header_version CONSTANT VARCHAR2(64) := 'VERSION 8.2.5 22/06/2017';

  c_err_txt VARCHAR2(4000);
  --���������
  lc_new_line    CONSTANT VARCHAR2(5) := chr(13) || chr(10);
  lc_date_format CONSTANT VARCHAR2(10) := 'DD/MM/YYYY';
  --����, �� ����� � �������� ���������� ������
  user_name VARCHAR2(400);
  p_new_id  NUMBER;

  l_credit_list    number_list := number_list();
  l_reg_list       number_list := number_list();
  l_status_id      escr_reg_status.id%TYPE;
  l_reg_id         escr_register.id%TYPE;
  l_status_name    escr_reg_status.name%TYPE;
  l_reg_type_id    escr_reg_types.id%TYPE;
  l_reg_kind_id    escr_reg_kind.id%TYPE;
  l_reg_union_flag escr_register.reg_union_flag%TYPE DEFAULT 0;
  l_in_flag        NUMBER;
  l_out_flag       NUMBER;
  --  ����
  TYPE t_register IS TABLE OF escr_register%ROWTYPE;
  TYPE t_reg_header IS TABLE OF escr_reg_header%ROWTYPE;
  TYPE t_reg_body IS TABLE OF escr_reg_body%ROWTYPE;
  TYPE t_reg_mapping IS TABLE OF escr_reg_mapping%ROWTYPE;
  TYPE t_vw_escr_list_for_sync IS TABLE OF VW_ESCR_LIST_FOR_SYNC%ROWTYPE;
  /**********************************************
    FUNCTION HEADER_VERSION
    DESCRIPTION: �������� ���Ѳ� �����Բ��ֲ� ������
  *********************************************/
  FUNCTION header_version RETURN VARCHAR2 IS
  BEGIN
    RETURN 'PACKAGE HEADER DOCSIGN ' || g_header_version || '.';
  END header_version;

  /**********************************************
    FUNCTION BODY_VERSION
   DESCRIPTION: �������� ���Ѳ� Ҳ�� ������
  *********************************************/
  FUNCTION body_version RETURN VARCHAR2 IS
  BEGIN
    RETURN 'PACKAGE BODY DOCSIGN ' || g_body_version || '.';
  END body_version;
  /***************************************************************
   ���������� ��������� � ������ ESCR
  **************************************************************/
  
  
  PROCEDURE P_oplv(p_ref NUMBER) IS
  BEGIN
    FOR k IN (SELECT o.*
                FROM oper o, nlk_ref r, accounts a
               WHERE a.tip = 'NLQ'
                 AND a.acc = r.acc
                 AND r.ref2 IS NULL
                 AND r.ref1 = o.ref
                 AND (p_ref = 0 OR p_ref = o.ref))
    LOOP
      p_pay1(0
               ,k.ref
               ,gl.bdate
               ,'PS1'
               ,1
               ,k.kv
               ,k.nlsb
               ,k.s
               ,k.kv
               ,k.nlsb
               ,k.s);
    END LOOP;
  END p_oplv;
  ----------------------------------------------------------------------------------------------------------
  PROCEDURE p_dop
  (
    p_ref NUMBER
   ,s_nd  VARCHAR2
   ,s_sd  VARCHAR2
   ,s_cd  VARCHAR2
   ,s_id  VARCHAR2
  ) IS
  BEGIN
    set_operw(p_ref, 'ND   ', s_nd);
    set_operw(p_ref, 'DAT1 ', s_sd);
    set_operw(p_ref, 'CC_ID', s_cd);
    set_operw(p_ref, 'IDB  ', s_id);
    COMMIT;
   p_oplv(p_ref);
  END p_dop;
  ----------------------------------------------------------------------------------------------------------
  PROCEDURE p_pay1
  (
    flg_  SMALLINT
   , -- ���� ������
    ref_  INTEGER
   , -- ����������
    vdat_ DATE
   , -- ���� ������������
    tt_   CHAR
   , -- ��� ����������
    dk_   NUMBER
   , -- ������� �����-������
    kv_   SMALLINT
   , -- ��� ������ �
    nlsm_ VARCHAR2
   , -- ����� ����� �
    sa_   DECIMAL
   , -- ����� � ������ �
    kvk_  SMALLINT
   , -- ��� ������ �
    nlsk_ VARCHAR2
   , -- ����� ����� �
    ss_   DECIMAL -- ����� � ������ �
  ) IS
    dd       cc_deal%ROWTYPE;
    aa       accounts%ROWTYPE;
    oo       oper%ROWTYPE;
    nls_2924 accounts.nls%TYPE;
    n_ss     NUMBER := 0;
    l_acc8   NUMBER;
    ntmp_    NUMBER;
    stmp_    VARCHAR2(5);
    nazn_    VARCHAR2(160);
    i_       INT;
    l_txt    VARCHAR2(70) := NULL;

    l_tx1 VARCHAR2(70) := '��������� ��������� ��� �� � �������.�������';
    l_tx2 VARCHAR2(70) := '���� ��*';
    l_tx3 VARCHAR2(70) := '� ��*';
    l_tx4 VARCHAR2(70) := 'NOT ��*';
    l_tx5 VARCHAR2(70) := '��.���*';
    l_tx6 VARCHAR2(70) := '�.2620*';
    l_tx7 VARCHAR2(70) := '->2620*';
    l_tx8 VARCHAR2(70) := '->220*';
    l_tx9 VARCHAR2(70) := '! ���*';
    --------------------
    code_   NUMBER;
    erm_    VARCHAR2(2048);
    tmp_    VARCHAR2(2048);
    status_ VARCHAR2(10);
    l_recid NUMBER;
    ------------------------------------------------
    s_nd VARCHAR2(10);
    s_sd VARCHAR2(10);
    s_cd VARCHAR2(30);
    s_id VARCHAR2(20);
    -----------------------------------------------
    i_ost   NUMBER;
    v_ost   NUMBER;
    fdat_   DATE; ----------------------- ����������� ���, ��� ���������� ���������.
    p_k0    NUMBER := 2;
    p_z1    NUMBER;
    p_z2    NUMBER;
    p_z3    NUMBER;
    p_z4    NUMBER;
    p_z5    NUMBER;
    p_r1    NUMBER;
    p_r2    NUMBER;
    p_p1    NUMBER;
    p_k2    NUMBER;
    phone_  acc_sms_phones.phone%TYPE;
    l_msgid INTEGER;
    l_count NUMBER;
    l_nazn  NUMBER;
  BEGIN

    BEGIN
      SELECT * INTO oo FROM oper WHERE REF = ref_;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(-20203
                               ,'\9517 - ESCR.�� �������� ��.���-���');
    END;
    ---------------------------------------
    s_nd := substr(f_dop(ref_, 'ND'), 1, 10);
    s_sd := substr(f_dop(ref_, 'DAT1'), 1, 10);
    s_cd := substr(f_dop(ref_, 'CC_ID'), 1, 30);
    s_id := substr(f_dop(ref_, 'IDB'), 1, 14);

    IF s_cd IS NULL
       OR s_sd IS NULL THEN
      nazn_ := oo.nazn;
    BEGIN
      SELECT regexp_count(oo.nazn, ';') INTO l_count FROM dual;
    END;
      BEGIN
        WITH txt AS
         (SELECT substr(nazn_, 1, instr(nazn_, ';', 1, 1) - 1) AS text
            FROM dual)
        SELECT COUNT(*)
          INTO l_nazn
          FROM txt
         WHERE NOT regexp_like(txt.text, '^(\d+)([.,]?)(\d*)$');
      END;
      IF l_nazn = 0
         AND l_count = 5 THEN
        i_    := instr(nazn_, ';', 1);
        s_nd  := substr(nazn_, 1, i_ - 1);
        nazn_ := substr(nazn_, i_ + 1, 160);
        s_sd  := substr(nazn_, 1, 10);
        nazn_ := substr(nazn_, 12, 160);
        i_    := instr(nazn_, ';', 1);
        s_cd  := substr(nazn_, 1, i_ - 1);
        nazn_ := substr(nazn_, i_ + 1, 160);
        i_    := instr(nazn_, ';', 1);
        s_id  := substr(nazn_, 1, i_ - 1);
        set_operw(ref_, 'ND   ', s_nd);
        set_operw(ref_, 'DAT1 ', s_sd);
        set_operw(ref_, 'CC_ID', s_cd);
        set_operw(ref_, 'IDB  ', s_id);
      END IF;
      IF l_nazn <> 0 THEN
        i_    := instr(nazn_, ';', 1, 1);
        nazn_ := substr(nazn_, i_ + 1, 160);

        IF  l_count = 6 THEN
          i_    := instr(nazn_, ';', 1);
          s_nd  := substr(nazn_, 1, i_ - 1);
          nazn_ := substr(nazn_, i_ + 1, 160);
          s_sd  := substr(nazn_, 1, 10);
          nazn_ := substr(nazn_, 12, 160);
          i_    := instr(nazn_, ';', 1);
          s_cd  := substr(nazn_, 1, i_ - 1);
          nazn_ := substr(nazn_, i_ + 1, 160);
          i_    := instr(nazn_, ';', 1);
          s_id  := substr(nazn_, 1, i_ - 1);
          set_operw(ref_, 'ND   ', s_nd);
          set_operw(ref_, 'DAT1 ', s_sd);
          set_operw(ref_, 'CC_ID', s_cd);
          set_operw(ref_, 'IDB  ', s_id);
        ELSIF  l_count = 5 THEN
          i_    := instr(nazn_, ';', 1);
          s_nd  := substr(nazn_, 1, i_ - 1);
          nazn_ := substr(nazn_, i_ + 1, 160);
          s_sd  := substr(nazn_, 1, 10);
          nazn_ := substr(nazn_, 12, 160);
          i_    := instr(nazn_, ';', 1);
          s_cd  := substr(nazn_, 1, i_ - 1);
          --nazn_ := substr(nazn_, i_ + 1, 160);
          --i_    := instr(nazn_, ';', 1);
          -- s_id  := substr(nazn_, 1, i_ - 1);
          s_id := '';
          set_operw(ref_, 'ND   ', s_nd);
          set_operw(ref_, 'DAT1 ', s_sd);
          set_operw(ref_, 'CC_ID', s_cd);
          set_operw(ref_, 'IDB  ', s_id);
        END IF;
      END IF;
    END IF;
    BEGIN
      dd.nd := to_number(s_nd);
    EXCEPTION
      WHEN OTHERS THEN
        l_txt := l_tx1;
        GOTO no_pay;
    END;
    BEGIN
      dd.sdate := to_date(s_sd, 'dd/mm/yyyy');
    EXCEPTION
      WHEN OTHERS THEN
        l_txt := l_tx2;
        GOTO no_pay;
    END;
    dd.cc_id := s_cd;
    IF length(dd.cc_id) = 0 THEN
      l_txt := l_tx3;
      GOTO no_pay;
    END IF;
    oo.id_b := s_id;

    BEGIN
      SELECT *
        INTO dd
        FROM (SELECT *
                FROM cc_deal
               WHERE vidd = 11
                 AND sos > 0
                 AND (nd = dd.nd OR sdate = dd.sdate AND cc_id = dd.cc_id)
               ORDER BY sos)
       WHERE rownum = 1;
    EXCEPTION
      WHEN no_data_found THEN
        l_txt := l_tx4;
        GOTO no_pay;
    END;

    IF length(TRIM(oo.id_b)) > 0 THEN
      BEGIN
        SELECT 1
          INTO ntmp_
          FROM customer
         WHERE rnk = dd.rnk
           AND okpo = oo.id_b;
      EXCEPTION
        WHEN no_data_found THEN
          l_txt := l_tx5;
          GOTO no_pay;
      END;
    END IF;
    BEGIN
      SELECT *
        INTO aa
        FROM accounts
       WHERE kv = kv_
         AND nbs = '2620'
         AND dazs IS NULL
         AND acc IN (SELECT acc FROM nd_acc WHERE nd = dd.nd)
         AND rownum = 1;
    EXCEPTION
      WHEN no_data_found THEN
        l_txt := l_tx6;
        GOTO no_pay;
    END;
    l_txt := NULL;
    -------------------------------------------------------------------------------------------------------------------
    SAVEPOINT do_opl;
    BEGIN
      ----------------------------------------------------------------------- ��������� ��� ����� �� 2620
      l_txt := l_tx7;
      gl.payv(flg_, ref_, vdat_, tt_, 1, kv_, nlsm_, sa_, kv_, aa.nls, sa_); -------------3739_05 ---> 2620
      gl.pay(2, ref_, vdat_);
      -------------------------------------------------------------------------------------------------------------------
      DELETE FROM nlk_ref WHERE ref1 = ref_;

      IF dd.sos >= 14 THEN
        RETURN;
      END IF;

      l_txt   := l_tx8;
      aa.ostc := sa_;
      n_ss    := 0; ------------2620 ---> 2203
      FOR kk IN (SELECT *
                   FROM accounts
                  WHERE kv = kv_
                    AND tip IN ('SP ', 'SS ')
                    AND ostc < 0
                    AND acc IN (SELECT acc FROM nd_acc WHERE nd = dd.nd)
                  ORDER BY tip)
      LOOP
        --- ����� � ���������� = ������� �� 2-� (������� ���� � ������� ����)
        oo.s := least(-kk.ostc, aa.ostc);
        IF oo.s > 0 THEN
          l_acc8 := kk.accc;
          IF kk.tip = 'SS ' THEN
            n_ss := n_ss + oo.s;
          END IF;
          gl.payv(flg_
                 ,ref_
                 ,vdat_
                 ,tt_
                 ,1
                 ,kv_
                 ,aa.nls
                 ,oo.s
                 ,kv_
                 ,kk.nls
                 ,oo.s);
        END IF;
        aa.ostc := aa.ostc - oo.s;
      END LOOP;
      gl.pay(2, ref_, vdat_);

      --- ����������� ���, ��� ���������� ���������.
      IF n_ss > 0
         AND l_acc8 > 0 THEN
        l_txt := l_tx9;
        SELECT ostc,- (ostc - kos + dos)
          INTO i_ost, v_ost
          FROM accounts
         WHERE acc = l_acc8;

        IF i_ost = 0 THEN
          ------------------------------------------------------------------- ���� �������� ���������
          UPDATE cc_lim
             SET sumg = v_ost, lim2 = 0
           WHERE nd = dd.nd
             AND fdat = gl.bdate;
          IF SQL%ROWCOUNT = 0 THEN
            INSERT INTO cc_lim
              (nd, fdat, acc, lim2, sumg, sumo, sumk)
            VALUES
              (dd.nd, gl.bdate, l_acc8, 0, v_ost, v_ost, 0);
          END IF;
          SELECT MIN(fdat)
            INTO fdat_
            FROM cc_lim
           WHERE nd = dd.nd
             AND fdat > gl.bdate;
          DELETE FROM cc_lim
           WHERE nd = dd.nd
             AND fdat > fdat_;
          UPDATE cc_lim
             SET lim2 = 0, sumg = 0
           WHERE nd = dd.nd
             AND fdat = fdat_;
          UPDATE accounts SET ostx = 0 WHERE acc = l_acc8;
          UPDATE cc_deal SET LIMIT = 0, wdate = fdat_ WHERE nd = dd.nd;
          UPDATE cc_add
             SET s = 0
           WHERE nd = dd.nd
             AND adds = 0;
        ELSE
          ------------p_K2 := CCK_DPK.Day_PL(dd.nd) ; --------------------------------------  nMode = 122 ������ ���������� ���
          SELECT s
            INTO p_k2
            FROM int_accn
           WHERE acc = l_acc8
             AND id = 0;
          cck_dpk.dpk(p_mode    => 2
                     , -- IN  int   , -- 0 - �������, 1 - ��������� ���.+����������� ��� (121) , 2 - ������ ����������� ��� (122)
                      p_nd      => dd.nd
                     , -- IN  number, -- ��� ��
                      p_acc2620 => aa.acc
                     , -- IN  number, -- ���� ������� (2620) ----/2625/SG)
                      p_k0      => p_k0
                     , -- IN OUT number, -- 1-�������. 0 - �����
                      p_k1      => 0
                     , -- IN     number, -- <����� ��� ���������� ���>, �� ����� = R2,
                      p_k2      => p_k2
                     , -- IN     number, -- <��������� ����>, �� ���� = DD �� �������� ����.���
                      p_k3      => 1
                     , -- IN     number, -- 1=�� ,<� ����������� ����� ������ �������?>, 2=��� (� ������������ ����� �� ��������� ��������� ����)
                      p_z1      => p_z1
                     , --OUT number, -- ��������� z1 =SLN+SLK+SL+SPN+SK9+SP+SN8
                      p_z2      => p_z2
                     , --OUT number, -- ����.�������� � ����� z2 =SN+SN`+SK0
                      p_z3      => p_z3
                     , --OUT number, -- <�����������> ��� ��������� (�������, ���������) ������ �� ����
                      p_z4      => p_z4
                     , --OUT number, --�����  ������������� ������� = z4 =  z1 + z2 + z3
                      p_z5      => p_z5
                     , --OUT number, -- �������� ������� �� ����  z5 = (SS - z3)
                      p_r1      => p_r1
                     , --OUT number, -- ����� ������ (��� �� SG(262*)
                      p_r2      => p_r2
                     , --OUT number, --  ��������� ������ R2 =  R1 - z4
                      p_p1      => p_p1 --OUT number  --  ���.�������
                      );
        END IF;
      END IF;
      l_txt := NULL;
      GOTO no_pay;
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK TO do_opl;
        bars_audit.error(p_msg     => 'ESCR-err*' || SQLERRM
                        ,p_module  => NULL
                        ,p_machine => NULL
                        ,p_recid   => l_recid);
        deb.trap(SQLERRM, code_, erm_, status_);
        IF code_ <= -20000 THEN
          bars_error.get_error_info(SQLERRM, erm_, tmp_, tmp_);
        END IF;
        l_txt := substr(l_txt || l_recid || '*' || erm_, 1, 70);
        GOTO no_pay;
    END;
    -----------------------------------------------------
    <<no_pay>>
    NULL;
    bars_audit.info('ESCR-inf* NP ' || aa.acc || ';' || l_txt || ';');
    IF l_txt IS NOT NULL THEN
      -- ���� ��������
      UPDATE opldok SET txt = l_txt WHERE REF = ref_;
    ELSE
      BEGIN
        SELECT phone INTO phone_ FROM acc_sms_phones WHERE acc = aa.acc; --���� ������� �� ����� 2620
        bars_audit.info('ESCR-inf* SM ' || aa.acc || ';' || phone_ || ';');
        bars_sms.create_msg(p_msgid           => l_msgid
                           ,p_creation_time   => SYSDATE
                           ,p_expiration_time => SYSDATE + 1
                           ,p_phone           => phone_
                           ,p_encode          => 'lat'
                           ,p_msg_text        => 'Vam zarahovano vidshkoduvannja za teplim creditom.<\n>Data ' ||
                                                 to_char(SYSDATE
                                                        ,'DD.MM.YYYY') ||
                                                 '. Dovidka 0800210800'
                                                 ,P_KF=>sys_context('bars_context','user_mfo'));
        l_msgid := NULL;
        phone_  := NULL; -- ����������� ����������
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
      END;

    END IF;
    RETURN;

  END p_pay1;

  PROCEDURE p_del1(p_ref NUMBER) IS -- ��������� ��� � ��������� NLQ � ������ � ������ �����������
  BEGIN
    DELETE FROM nlk_ref WHERE ref1 = p_ref;
  END p_del1;
  
  
  PROCEDURE p_get_user_name
  (
    in_user_id    staff$base.id%TYPE DEFAULT user_id
   ,out_user_name OUT VARCHAR2
  ) IS
  BEGIN
    BEGIN
      SELECT t.fio
        INTO out_user_name
        FROM staff$base t
       WHERE t.id = in_user_id;
    EXCEPTION
      WHEN OTHERS THEN
        out_user_name := '�� ���������';
    END;

  END p_get_user_name;
  /***************************************************************
     PROCEDURE   P_GET_NEW_ID
     DESCRIPTION: �����Ӫ ����� ID ��� ��'��Ҳ�
  **************************************************************/
  PROCEDURE p_get_new_id
  (
    in_obj_name IN VARCHAR2
   ,out_id      OUT NUMBER
  ) IS
    p_kf VARCHAR(20);
  BEGIN
    IF in_obj_name = 'ESCR_REGISTER' THEN
      BEGIN
        SELECT t.code
          INTO p_kf
          FROM regions t
         WHERE t.kf = (SELECT getglobaloption('MFO') FROM dual);
      EXCEPTION
        WHEN no_data_found THEN
          out_id := to_number(to_char(s_escr.nextval));
      END;
      out_id := to_number(to_char(s_escr.nextval) || p_kf);
    ELSE
      out_id := s_escr.nextval;
    END IF;
  END p_get_new_id;
  /***************************************************************
     PROCEDURE   p_get_type_ID
     DESCRIPTION: ��  ���� ���� ������ �����Ӫ�� ���� ID
  **************************************************************/
  PROCEDURE p_get_type_id
  (
    in_type_code escr_reg_types.code%TYPE
   ,out_type_id  OUT escr_reg_types.id%TYPE

  )

   IS
  BEGIN
    BEGIN
      SELECT t.id
        INTO out_type_id
        FROM escr_reg_types t
       WHERE t.code = in_type_code;
    EXCEPTION
      WHEN OTHERS THEN
        out_type_id := -999;
    END;
  END p_get_type_id;
  /***************************************************************
     PROCEDURE   p_get_kind_ID
     DESCRIPTION: ��  ���� ���� ������ �����Ӫ�� ���� ID
  **************************************************************/
  PROCEDURE p_get_kind_id
  (
    in_kind_code escr_reg_kind.code%TYPE
   ,out_kind_id  OUT escr_reg_kind.id%TYPE

  ) IS
  BEGIN
    BEGIN
      SELECT t.id
        INTO out_kind_id
        FROM escr_reg_kind t
       WHERE t.code = in_kind_code;
    EXCEPTION
      WHEN OTHERS THEN
        out_kind_id := -999;
    END;
  END p_get_kind_id;
  /***************************************************************
     PROCEDURE   p_check_kind_id
     DESCRIPTION: ��  ���� ���� ������ �����Ӫ�� ���� ID
  **************************************************************/
  PROCEDURE p_check_kind_id
  (
    in_kind_code escr_reg_kind.code%TYPE
   ,out_flag     OUT escr_reg_kind.valid_until%TYPE

  ) IS
  BEGIN
    BEGIN
      SELECT t.valid_until
        INTO out_flag
        FROM escr_reg_kind t
       WHERE t.code = in_kind_code;
    EXCEPTION
      WHEN OTHERS THEN
        out_flag := NULL;
    END;
  END p_check_kind_id;
  /***************************************************************
     PROCEDURE   p_get_status_ID
     DESCRIPTION: ��  ���� ������� �����Ӫ�� ���� ID
  **************************************************************/
  PROCEDURE p_get_status_id
  (
    in_status_code escr_reg_status.code%TYPE
   ,out_status_id  OUT escr_reg_status.id%TYPE

  ) IS
  BEGIN
    BEGIN
      SELECT t.id
        INTO out_status_id
        FROM escr_reg_status t
       WHERE t.code = in_status_code;
    EXCEPTION
      WHEN OTHERS THEN
        out_status_id := -999;
    END;
  END p_get_status_id;
  /***************************************************************
     PROCEDURE   p_get_status_ID
     DESCRIPTION: ��  ID ������� �����Ӫ�� ���� CODE
  **************************************************************/
  PROCEDURE p_get_status_code
  (
    in_status_id    escr_reg_status.id%TYPE
   ,out_status_code OUT escr_reg_status.code%TYPE

  ) IS
  BEGIN
    BEGIN
      SELECT t.code
        INTO out_status_code
        FROM escr_reg_status t
       WHERE t.id = in_status_id;
    EXCEPTION
      WHEN OTHERS THEN
        out_status_code := -999;
    END;
  END p_get_status_code;
  /***************************************************************
     PROCEDURE   p_get_status_name
     DESCRIPTION: ��  ���� ������� �����Ӫ�� ���� ��`�
  **************************************************************/
  PROCEDURE p_get_status_name
  (
    in_status_code  escr_reg_status.code%TYPE
   ,out_status_name OUT escr_reg_status.name%TYPE

  ) IS
  BEGIN
    BEGIN
      SELECT t.name
        INTO out_status_name
        FROM escr_reg_status t
       WHERE t.code = in_status_code;
    EXCEPTION
      WHEN OTHERS THEN
        out_status_name := -999;
    END;
  END p_get_status_name;
  /**********************************************
     PROCEDURE p_get_reg_union_flag
     DESCRIPTION: ������� ������ ��*������ ����� �� �
  *********************************************/
  PROCEDURE p_get_reg_union_flag
  (
    in_reg_id          escr_register.id%TYPE
   ,out_reg_union_flag OUT escr_register.reg_union_flag%TYPE
  ) IS

  BEGIN
    BEGIN
      SELECT t.reg_union_flag
        INTO out_reg_union_flag
        FROM escr_register t
       WHERE t.id = in_reg_id;
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;

  END p_get_reg_union_flag;
  /**********************************************
     PROCEDURE P_get_reg_register
     DESCRIPTION: ������� �������� �������� ������
  *********************************************/
  PROCEDURE p_get_reg_register
  (
    in_reg_id    escr_register.id%TYPE
   ,out_reg_list OUT number_list
  ) IS

    out_reg_list1 number_list := number_list();
  BEGIN

    BEGIN
      SELECT t.out_doc_id BULK COLLECT
        INTO out_reg_list1
        FROM escr_reg_mapping t
       WHERE t.in_doc_id = in_reg_id
         AND t.oper_type = 1;
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;

    out_reg_list := out_reg_list1;
  END p_get_reg_register;
  /**********************************************
     PROCEDURE P_get_reg_deals
     DESCRIPTION: ������� �������� �������, �� ������� � �����
  *********************************************/
  PROCEDURE p_get_reg_deals
  (
    in_reg_id     escr_register.id%TYPE
   ,in_check_flag NUMBER DEFAULT 0 -- ���������� �� � ������� ��
   ,out_deal_list OUT number_list
  ) IS

    all_deal_list   number_list := number_list();
    valid_deal_list number_list := number_list();
    --final_deal_list number_list := number_list();

  BEGIN

    BEGIN
      SELECT t.out_doc_id BULK COLLECT
        INTO all_deal_list
        FROM escr_reg_mapping t
       WHERE t.in_doc_id = in_reg_id
         AND t.oper_type = 0;
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;
    /*���� �� ��� � �������������� ��,
    �� ������� �� ����������� �� ��� ������� ��� ����� � ��������� �� � ������ ��� ������*/
    IF in_check_flag IN (7, 11) THEN
      BEGIN

        SELECT t.deal_id BULK COLLECT
          INTO valid_deal_list
          FROM escr_reg_header t
         WHERE t.deal_id IN (SELECT * FROM TABLE(all_deal_list))
           AND t.credit_status_id NOT IN (9, 5);
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
      END;
      out_deal_list := valid_deal_list;
    ELSE

      out_deal_list := all_deal_list;
    END IF;
  END p_get_reg_deals;
  /**********************************************
     PROCEDURE P_SET_CREDIT_STATUS
     DESCRIPTION: ��������ު ������ ���������� �������� � nd_txt
  *********************************************/
  PROCEDURE p_set_credit_status
  (
    in_obj_id         IN escr_reg_obj_state.obj_id%TYPE
   ,in_status_code    IN escr_reg_status.code%TYPE
   ,in_status_comment IN escr_reg_obj_state.status_comment%TYPE DEFAULT NULL
   ,in_set_date       IN DATE
  ) IS
    l_flag NUMBER;
  BEGIN
    p_get_status_id(in_status_code => in_status_code
                   ,out_status_id  => l_status_id);
    p_get_status_name(in_status_code  => in_status_code
                     ,out_status_name => l_status_name);
    BEGIN
      SELECT COUNT(1) INTO l_flag FROM cc_tag t WHERE t.tag LIKE 'ES%';
    END;
    IF l_flag >= 1 THEN
      cck_app.set_nd_txt(in_obj_id, 'ES000', l_status_id);
      cck_app.set_nd_txt(in_obj_id, 'ES005', l_status_name);
      cck_app.set_nd_txt(in_obj_id, 'ES006', in_set_date);
      cck_app.set_nd_txt(in_obj_id, 'ES007', in_status_comment);
      IF l_status_id = 11 THEN
        cck_app.set_nd_txt(in_obj_id, 'ES003', trunc(SYSDATE));
      END IF;
    END IF;
    UPDATE escr_reg_header t
       SET t.credit_status_id = l_status_id
     WHERE t.deal_id = in_obj_id;

  END p_set_credit_status;

  /**********************************************
     PROCEDURE P_SET_OBJ_STATUS
     DESCRIPTION: ��������ު ������ �Ū���� �� ������� � �Ū��в
  *********************************************/
  PROCEDURE p_set_obj_status
  (
    in_obj_id         escr_reg_obj_state.obj_id%TYPE
   ,in_obj_type       escr_reg_obj_state.obj_type%TYPE
   ,in_status_code    escr_reg_status.code%TYPE
   ,in_status_comment escr_reg_obj_state.status_comment%TYPE DEFAULT NULL
   ,in_obj_check      NUMBER DEFAULT 1 --��������� ��*���� ����� ��*���� ��  � (��� ������)
   ,in_set_date       escr_reg_obj_state.set_date%TYPE DEFAULT SYSDATE
   ,in_oper_level     NUMBER DEFAULT 0
  )

   IS
    l_obj_status_id escr_reg_status.id%TYPE;
    l_max_status_id NUMBER;
    -- in_obj_type ��� ��������  ��'���� (1 -�����,0-������)
    p_obj_list number_list := number_list();
  BEGIN
    --   _escrRegister.SetComment(deals.deals.deal[i].deal_id, String.Empty, status_code, 0, 1, cmd);
    p_get_status_id(in_status_code => in_status_code
                   ,out_status_id  => l_status_id);

    -- ���������� ��������� ������ ��*����.�������� �� �������� ��� ������� ��������.���� ���� ������ ��� ��� ��������
    IF l_status_id <> 16 THEN
      BEGIN
        SELECT MAX(t.status_id) keep(dense_rank LAST ORDER BY t.id)
          INTO l_max_status_id
          FROM bars.escr_reg_obj_state t
         WHERE obj_id = in_obj_id;
      EXCEPTION
        WHEN no_data_found THEN
          l_max_status_id := NULL;
      END;
    ELSE
      l_max_status_id := NULL;
    END IF;
 -- ���� ������������ ������ ��-11,����� ���������,�� �������� � ���������.
    if l_max_status_id=11 then
     return;
    end if;

    IF l_max_status_id <> l_status_id
       OR l_max_status_id IS NULL THEN
      --�����Ӫ�� ����� ID
      p_get_new_id(in_obj_name => 'ESCR_REG_OBJ_STATE', out_id => p_new_id);
      -- �����Ӫ�� ϲ� �����������
      p_get_user_name(out_user_name => user_name);
      -- ������������ ������ ��*����, ��� ����� ������������ ����  �������
      INSERT INTO escr_reg_obj_state
        (id
        ,obj_id
        ,obj_type
        ,status_id
        ,status_comment
        ,user_id
        ,user_name
        ,set_date)
      VALUES
        (p_new_id
        ,in_obj_id
        ,in_obj_type
        ,l_status_id
        ,in_status_comment
        ,user_id
        ,user_name
        ,in_set_date) log errors INTO err$_escr_reg_obj_state
        ('INSERT') reject LIMIT unlimited;
      IF in_obj_type = 1
         AND in_obj_check = 0 THEN
        UPDATE escr_register t
           SET t.status_id = l_status_id log errors INTO err$_escr_reg_obj_state('UPDATE') reject LIMIT unlimited;
      END IF;
      -- ���� ��� ��*����,����� ������� ������ -0 (������), �� ������� ������� ���� � ������������
      IF in_obj_type = 0
         AND in_obj_check = 0
         AND in_oper_level = 0 THEN
        p_set_credit_status(in_obj_id         => in_obj_id
                           ,in_status_code    => in_status_code
                           ,in_status_comment => in_status_comment
                           ,in_set_date       => in_set_date);
      END IF;
      IF in_obj_type = 0
         AND in_obj_check = 1 THEN
        IF in_oper_level = 0 THEN
          p_set_credit_status(in_obj_id         => in_obj_id
                             ,in_status_code    => in_status_code
                             ,in_status_comment => in_status_comment
                             ,in_set_date       => in_set_date);
        END IF;
        p_get_reg_id(in_obj_id    => in_obj_id
                    ,in_oper_type => 0
                    ,out_reg_id   => l_reg_id);
        p_get_obj_status_id(in_obj_id     => l_reg_id
                           ,in_obj_type   => 1
                           ,out_status_id => l_obj_status_id);
        IF l_status_id <> l_obj_status_id THEN
          INSERT INTO escr_reg_obj_state
            (id
            ,obj_id
            ,obj_type
            ,status_id
            ,status_comment
            ,user_id
            ,user_name
            ,set_date)
          VALUES
            (p_new_id
            ,l_reg_id
            ,1
            ,l_status_id
            ,in_status_comment
            ,user_id
            ,user_name
            ,in_set_date) log errors INTO err$_escr_reg_obj_state
            ('INSERT') reject LIMIT unlimited;
        END IF;
      END IF;
      --�������� �� �� ����� ���*���� ������
      IF in_obj_type = 1
         AND in_obj_check = 1 THEN
        p_get_reg_union_flag(in_reg_id          => in_obj_id
                            ,out_reg_union_flag => l_reg_union_flag);
      END IF;

      --���� ��� ��*���� 1 � ���� ���� ���*������ ������, �� ��������� ������� ���� �������� � ����� �����
      IF in_obj_type = 1
         AND in_obj_check = 1
         AND l_reg_union_flag = 0 THEN

        UPDATE escr_register t
           SET t.status_id = l_status_id
              ,t.user_id   = user_id
              ,t.user_name = user_name
         WHERE t.id = in_obj_id;
        p_get_reg_deals(in_reg_id     => in_obj_id
                       ,in_check_flag => l_status_id
                       ,out_deal_list => l_credit_list);

        FOR i IN 1 .. l_credit_list.count
        LOOP
          INSERT INTO escr_reg_obj_state
            (id
            ,obj_id
            ,obj_type
            ,status_id
            ,status_comment
            ,user_id
            ,user_name
            ,set_date)
          VALUES
            (s_escr.nextval
            ,l_credit_list(i)
            ,0
            ,l_status_id
            ,in_status_comment
            ,user_id
            ,user_name
            ,in_set_date);
          p_set_credit_status(in_obj_id         => l_credit_list(i)
                             ,in_status_code    => in_status_code
                             ,in_status_comment => in_status_comment
                             ,in_set_date       => in_set_date);
        END LOOP;
      END IF;
      --���� ��� ��*���� 1 � ���� ��� ���*���� ������, �� ��������� ������� ��� �������
      IF in_obj_type = 1
         AND in_obj_check = 1
         AND l_reg_union_flag = 1 THEN
        UPDATE escr_register t
           SET t.status_id = l_status_id
              ,t.user_id   = user_id
              ,t.user_name = user_name
         WHERE t.id = in_obj_id;
        p_get_reg_register(in_reg_id    => in_obj_id
                          ,out_reg_list => l_reg_list);
        UPDATE escr_register t
           SET t.status_id = l_status_id
              ,t.user_id   = user_id
              ,t.user_name = user_name
         WHERE t.id IN (SELECT * FROM TABLE(l_reg_list));
        FOR i IN 1 .. l_reg_list.count
        LOOP
          INSERT INTO escr_reg_obj_state
            (id
            ,obj_id
            ,obj_type
            ,status_id
            ,status_comment
            ,user_id
            ,user_name
            ,set_date)
          VALUES
            (s_escr.nextval
            ,l_reg_list(i)
            ,1
            ,l_status_id
            ,in_status_comment
            ,user_id
            ,user_name
            ,in_set_date);
          p_get_reg_deals(in_reg_id     => l_reg_list(i)
                         ,in_check_flag => l_status_id
                         ,out_deal_list => l_credit_list);

          FOR i IN 1 .. l_credit_list.count
          LOOP
            INSERT INTO escr_reg_obj_state
              (id
              ,obj_id
              ,obj_type
              ,status_id
              ,status_comment
              ,user_id
              ,user_name
              ,set_date)
            VALUES
              (s_escr.nextval
              ,l_credit_list(i)
              ,0
              ,l_status_id
              ,in_status_comment
              ,user_id
              ,user_name
              ,in_set_date);
            p_set_credit_status(in_obj_id         => l_credit_list(i)
                               ,in_status_code    => in_status_code
                               ,in_status_comment => in_status_comment
                               ,in_set_date       => in_set_date);
          END LOOP;
        END LOOP;
      END IF;
    END IF;
  END p_set_obj_status;

  /**********************************************
     PROCEDURE p_get_obj_status_id
     DESCRIPTION: ��������ު ������ �Ū���� �� ������� � �Ū��в
  *********************************************/
  PROCEDURE p_get_obj_status
  (
    in_obj_id   escr_register.id%TYPE
   ,in_obj_type escr_reg_obj_state.obj_type%TYPE
   ,out_status  OUT escr_reg_status.id%TYPE
  ) IS

  BEGIN

    BEGIN
      SELECT t.status_id
        INTO out_status
        FROM escr_reg_obj_state t
       WHERE t.set_date =
             (SELECT MAX(t1.set_date) FROM escr_reg_obj_state t1)
         AND t.obj_type = in_obj_type
         AND t.obj_id = in_obj_id;
    EXCEPTION
      WHEN OTHERS THEN
        out_status := -999;
    END;
  END p_get_obj_status;
  /**********************************************
     PROCEDURE p_set_reg_union_flag
     DESCRIPTION: ���������� �������, �� ����� ��*������ � ������ ������ ���� � ���� � ����
  *********************************************/
  PROCEDURE p_set_reg_union_flag(in_reg_id escr_register.id%TYPE) IS

  BEGIN
    UPDATE escr_register t
       SET t.reg_union_flag = 1
          ,t.inner_number   = t.inner_number || ' ��''�������'
     WHERE t.id = in_reg_id;

  END p_set_reg_union_flag;
  /***************************************************************
     PROCEDURE   p_deal_in_reg
     DESCRIPTION: ����²�ߪ �� �������� ��������� ����²� � �Ū���
  **************************************************************/
  PROCEDURE p_deal_in_reg
  (
    in_deal_list number_list
   ,out_err_txt  OUT VARCHAR2
  ) IS
  BEGIN
    NULL;
  END p_deal_in_reg;
  /***************************************************************
     PROCEDURE   p_reg_has_in_mapping
     DESCRIPTION: ����²�ߪ �� ����� ��*���� �� �����
  **************************************************************/
  PROCEDURE p_reg_has_in_mapping
  (
    in_reg_id    escr_register.id%TYPE
   ,out_has_flag OUT NUMBER
  ) IS
  BEGIN
    BEGIN
      SELECT COUNT(t.id)
        INTO out_has_flag
        FROM escr_reg_mapping t
       WHERE t.in_doc_id = in_reg_id;
    END;
  END p_reg_has_in_mapping;
  /***************************************************************
     PROCEDURE   p_reg_has_out_mapping
     DESCRIPTION: ����²�ߪ �� ����� ��*���� �� �����
  **************************************************************/
  PROCEDURE p_reg_has_out_mapping
  (
    in_reg_id    escr_register.id%TYPE
   ,out_has_flag OUT NUMBER
  ) IS
  BEGIN
    BEGIN
      SELECT COUNT(t.id)
        INTO out_has_flag
        FROM escr_reg_mapping t
       WHERE t.out_doc_id = in_reg_id;
    END;
  END p_reg_has_out_mapping;
  /******************************************************************************
     PROCEDURE   p_get_reg_list
     DESCRIPTION: ������� �-��� ������,���� �� ������� �� ������� ���������
  *****************************************************************************/
  PROCEDURE p_get_reg_list
  (
    in_reg_id       escr_register.id%TYPE
   ,out_branch_list OUT VARCHAR2
  ) IS
    l_reg_list     number_list;
    l_reg_list_all number_list;
    l_reg_list_dif number_list;
  BEGIN
    BEGIN
      SELECT DISTINCT substr(REPLACE(t.branch, '/', ''), 1, 6) BULK COLLECT
        INTO l_reg_list
        FROM escr_register t
       WHERE t.id IN (SELECT t1.out_doc_id
                        FROM escr_reg_mapping t1
                       WHERE t1.oper_type = 1
                         AND t1.in_doc_type = 1
                         AND t1.out_doc_type = 1
                         AND t1.in_doc_id = in_reg_id);
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;
    BEGIN
      SELECT DISTINCT t.kf BULK COLLECT INTO l_reg_list_all FROM regions t;
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;
    l_reg_list_dif := l_reg_list_all MULTISET except DISTINCT l_reg_list;
    IF l_reg_list_dif IS NOT NULL THEN
      FOR i IN 1 .. l_reg_list_dif.count
      LOOP
        out_branch_list := l_reg_list_dif(i) || ' ,' || out_branch_list;
      END LOOP;
    END IF;
    out_branch_list :=  /*'24/' || l_reg_list_dif.count ||' '||lc_new_line
                                                                                                                                               ||*/
     substr(out_branch_list
                             ,1
                             ,length(out_branch_list) - 1);
  END p_get_reg_list;
  /***************************************************************
     PROCEDURE   P_GET_REG_ID
     DESCRIPTION: �������� ID ������, � ���� �������� ������ (in_oper_type=0)
                  �� ������, � ���� �������� ����� (in_oper_type=1)
  **************************************************************/
  PROCEDURE p_get_reg_id
  (
    in_obj_id    NUMBER
   ,in_oper_type NUMBER
   ,out_reg_id   OUT escr_register.id%TYPE
  ) IS
  BEGIN
    BEGIN
      SELECT t.in_doc_id
        INTO out_reg_id
        FROM escr_reg_mapping t
       WHERE t.oper_type = in_oper_type
         AND t.out_doc_id = in_obj_id;
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;
  END p_get_reg_id;
  /***************************************************************
     PROCEDURE   p_get_reg_status_id
     DESCRIPTION: �������� ID ��������� ������� ��*����
  **************************************************************/
  PROCEDURE p_get_obj_status_id
  (
    in_obj_id     NUMBER
   ,in_obj_type   NUMBER
   ,out_status_id OUT escr_reg_status.id%TYPE
  ) IS
  BEGIN
    BEGIN
      SELECT t.status_id
        INTO out_status_id
        FROM escr_reg_obj_state t
       WHERE t.id = (SELECT MAX(t1.id)
                       FROM escr_reg_obj_state t1
                      WHERE t1.obj_id = in_obj_id
                        AND t1.obj_type = in_obj_type);
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;
  END p_get_obj_status_id;

  /************************************************************
     PROCEDURE   P_MAPPING
     DESCRIPTION: ����� ��*���� ̲� ��*������ �Ū����
  **************************************************************/
  PROCEDURE p_after_mapping_check
  (
    in_in_doc_id    escr_reg_mapping.in_doc_id%TYPE
   ,in_in_doc_type  escr_reg_mapping.in_doc_type%TYPE
   ,in_out_doc_id   number_list
   ,in_out_doc_type escr_reg_mapping.out_doc_type%TYPE
   ,in_oper_type    escr_reg_mapping.oper_type %TYPE
   ,in_oper_date    DATE DEFAULT SYSDATE
  ) IS

  BEGIN
    -- DOC_TYPE ���� �������� �������� 1 -�Ū���,0-������
    -- OPER_TYPE 0-�Ū���-������,1- �Ū���-�Ū���
    ---!!!!������ �������� �� ������

    FORALL i IN in_out_doc_id.first .. in_out_doc_id.last

      INSERT INTO escr_reg_mapping
        (id
        ,in_doc_id
        ,in_doc_type
        ,out_doc_id
        ,out_doc_type
        ,branch
        ,oper_type
        ,oper_date)
      VALUES
        (s_escr.nextval
        ,in_in_doc_id
        ,in_in_doc_type
        ,in_out_doc_id(i)
        ,in_out_doc_type
        ,c_branch
        ,in_oper_type
        ,in_oper_date) log errors INTO err$_escr_reg_mapping
        ('INSERT') reject LIMIT unlimited;
    --������������ ������,�� ����� ��*�������,���� ��� ������ �����-�����
    IF in_oper_type = 1
       AND in_in_doc_type = 1 THEN
      p_set_reg_union_flag(in_reg_id => in_in_doc_id);
    END IF;
  END p_after_mapping_check;

  /************************************************************
     PROCEDURE    p_check_after_create
     DESCRIPTION: �������� ���� ��������� ������ �� ���
  **************************************************************/
  PROCEDURE p_check_after_create IS
    l_boiler_count   number_list;
    l_material_count number_list;
    l_customer_okpo  number_list;
    l_deal_id        number_list;

  BEGIN
    BEGIN
      SELECT COUNT(CASE
                     WHEN substr(t.deal_product, 1, 6) IN ('220347', '220257') THEN
                      1
                   END) boiler_count
            ,COUNT(CASE
                     WHEN substr(t.deal_product, 1, 6) IN ('220258', '220348') THEN
                      2
                   END) material_count
            ,t.customer_okpo BULK COLLECT
        INTO l_boiler_count, l_material_count, l_customer_okpo
        FROM escr_reg_header t
       WHERE extract(YEAR FROM t.deal_date_from) = '2017'
       GROUP BY t.customer_okpo
      HAVING COUNT(*) > 1;
    END;

    IF l_material_count.count > 0 THEN
      BEGIN
        SELECT t.deal_id BULK COLLECT
          INTO l_deal_id
          FROM escr_reg_header t
         WHERE substr(t.deal_product, 1, 6) IN ('220258', '220348')
           AND extract(YEAR FROM t.deal_date_from) = '2017'
           AND t.customer_okpo IN (SELECT * FROM TABLE(l_customer_okpo));
      END;
      IF l_deal_id.count > 0 THEN
        FOR i IN 1 .. l_deal_id.count
        LOOP
          NULL;
          p_set_obj_status(in_obj_id         => l_deal_id(i)
                          ,in_obj_type       => 0
                          ,in_status_code    => 'DUPLICATE_DEAL'
                          ,in_status_comment => '����������� ��������� ��������� �-��� �� �� ���������'
                          ,in_obj_check      => 0
                          ,in_set_date       => SYSDATE
                          ,in_oper_level     => 1);
        END LOOP;
      END IF;
    ELSIF l_boiler_count.count > 0 THEN
      BEGIN
        SELECT t.deal_id BULK COLLECT
          INTO l_deal_id
          FROM escr_reg_header t
         WHERE substr(t.deal_product, 1, 6) IN ('220347', '220257')
           AND extract(YEAR FROM t.deal_date_from) = '2017'
           AND t.customer_okpo IN (SELECT * FROM TABLE(l_customer_okpo));
      END;
      IF l_deal_id.count > 0 THEN
        FOR i IN 1 .. l_deal_id.count
        LOOP
          NULL;
          p_set_obj_status(in_obj_id         => l_deal_id(i)
                          ,in_obj_type       => 0
                          ,in_status_code    => 'DUPLICATE_DEAL'
                          ,in_status_comment => '����������� ��������� ��������� �-��� �� �� ������'
                          ,in_obj_check      => 0
                          ,in_set_date       => SYSDATE
                          ,in_oper_level     => 1);
        END LOOP;
      END IF;

    END IF;

  END p_check_after_create;
  /************************************************************
     PROCEDURE   p_check_before_create
     DESCRIPTION: �������� ������ �� ��������
  **************************************************************/
  PROCEDURE p_check_before_create
  (
    in_obj_list    IN number_list DEFAULT NULL
   ,in_reg_kind    IN escr_reg_kind.code%TYPE DEFAULT NULL
   ,out_check_flag OUT NUMBER
  ) IS
    l_invalid  number_list;
    l_deal_id  number_list;
    l_multiset number_list;
    l_improved number_list;

  BEGIN

    out_check_flag := 0;
    l_deal_id      := number_list();
    l_invalid      := number_list();
    --  ³������� �� ��������� ��,��� ���������� ����������� ������� (������������)
    /* BEGIN
      SELECT t.nd BULK COLLECT
        INTO l_invalid
        FROM nd_txt t
       WHERE t.tag = 'ES000'
         AND t.txt = 16;
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;*/
    --���� � ������� � ��� ���� �� � ����������� ������� ������, �� �������� � ���������
    BEGIN
      SELECT COUNT(*)
        INTO out_check_flag
        FROM bars.vw_escr_errors t
       WHERE t.err_type_code = 'GOOD_COST';
    END;
    IF out_check_flag <> 0 THEN
      out_check_flag := -999;
    END IF;

    --

    --��� ����� ���������� vw_escr_invalid_credits -���� ���� �����
    IF out_check_flag = 0 THEN

      FOR c IN (SELECT t.deal_id
                      ,listagg(t.rn || '.' || t.description || chr(13) ||
                               chr(10)) within GROUP(ORDER BY t.rn, t.deal_id, t.description) reg_errors
                  FROM (SELECT t1.deal_id
                              ,t2.description
                              ,row_number() over(PARTITION BY t1.deal_id ORDER BY t1.deal_id) rn
                          FROM bars.vw_escr_invalid_credits t1
                              ,bars.escr_errors_types       t2
                         WHERE t1.error_id = t2.id) t
                 GROUP BY t.deal_id)
      LOOP

        /* pkg_escr_reg_utl.p_set_credit_status(in_obj_id         => c.deal_id
        ,in_status_code    => 'VALID_ERROR'
        ,in_status_comment => substr(c.reg_errors
                                    ,1
                                    ,4000)
        ,in_set_date       => SYSDATE);
        */
        pkg_escr_reg_utl.p_set_obj_status(in_obj_id         => c.deal_id
                                         ,in_obj_type       => 0
                                         ,in_status_code    => 'VALID_ERROR'
                                         ,in_status_comment => substr(c.reg_errors
                                                                     ,1
                                                                     ,4000));
      END LOOP;
      /*      COMMIT;*/
      BEGIN
        SELECT deal_id BULK COLLECT
          INTO l_deal_id
          FROM vw_escr_reg_all_credits t
         WHERE t.credit_status_id = 16;
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
      END;
      -- ������������ ������ ������������� �� ��� ��, �� �� ������ � ��������, ��� ���� ������� ��� ������� ��������� (������������)
      /*    l_improved := l_invalid MULTISET except l_deal_id;
      FOR i IN 1 .. l_improved.count
      LOOP
        pkg_escr_reg_utl.p_set_obj_status(in_obj_id         => l_improved(i)
                                         ,in_obj_type       => 0
                                         ,in_status_code    => 'IMPROVED'
                                         ,in_status_comment => '');
      END LOOP;*/
      -- �������� �� ����������� �������� � ����� �������� ��
      l_multiset := l_deal_id MULTISET INTERSECT in_obj_list;
      IF l_multiset.count > 0 THEN
        out_check_flag := -999;
      ELSE
        out_check_flag := 0;
      END IF;
    END IF;
  END p_check_before_create;
  /************************************************************
     PROCEDURE   P_MAPPING
     DESCRIPTION: ����� ��*���� ̲� ��*������ �Ū����
  **************************************************************/
  PROCEDURE p_mapping
  (
    in_in_doc_id    escr_reg_mapping.in_doc_id%TYPE
   ,in_in_doc_type  escr_reg_mapping.in_doc_type%TYPE
   ,in_out_doc_id   number_list
   ,in_out_doc_type escr_reg_mapping.out_doc_type%TYPE
   ,in_oper_type    escr_reg_mapping.oper_type %TYPE
   ,in_oper_date    DATE DEFAULT SYSDATE
  ) IS
    l_reg_id        escr_register.id%TYPE;
    l_in_out_doc_id number_list := in_out_doc_id;
  BEGIN
    -- DOC_TYPE ���� �������� �������� 1 -�Ū���,0-������
    -- OPER_TYPE 0-�Ū���-������,1- �Ū���-�Ū���
    ---!!!!������ �������� �� ������
    IF in_oper_type = 1 THEN
      FOR i IN l_in_out_doc_id.first .. l_in_out_doc_id.last
      LOOP
        l_reg_id := l_in_out_doc_id(i);
        p_get_reg_union_flag(in_reg_id          => l_reg_id
                            ,out_reg_union_flag => l_reg_union_flag);
        IF l_reg_union_flag = 1 THEN
          UPDATE escr_reg_mapping t
             SET t.in_doc_id = in_in_doc_id, t.oper_date = in_oper_date
           WHERE t.oper_type = 1
             AND t.in_doc_id = l_in_out_doc_id(i) log errors INTO
           err$_escr_reg_mapping('update') reject LIMIT unlimited;
          l_in_out_doc_id.delete(i);
        END IF;

      END LOOP;
    END IF;
    --FORALL i IN in_out_doc_id.first .. in_out_doc_id.last
    FORALL i IN INDICES OF l_in_out_doc_id
      INSERT INTO escr_reg_mapping
        (id
        ,in_doc_id
        ,in_doc_type
        ,out_doc_id
        ,out_doc_type
        ,branch
        ,oper_type
        ,oper_date)
      VALUES
        (s_escr.nextval
        ,in_in_doc_id
        ,in_in_doc_type
        ,in_out_doc_id(i)
        ,in_out_doc_type
        ,c_branch
        ,in_oper_type
        ,in_oper_date) log errors INTO err$_escr_reg_mapping
        ('INSERT') reject LIMIT unlimited;
    --������������ ������,�� ����� ��*�������,���� ��� ������ �����-�����
    IF in_oper_type = 1
       AND in_in_doc_type = 1 THEN
      p_set_reg_union_flag(in_reg_id => in_in_doc_id);
    END IF;
  END p_mapping;
  /************************************************************
     PROCEDURE   p_unmapping
     DESCRIPTION: ������� ��*���� �� ��*������ ������
  **************************************************************/
  PROCEDURE p_unmapping
  (
    in_doc_id    number_list
   ,in_oper_type escr_reg_mapping.oper_type %TYPE

  ) IS
  BEGIN
    -- OPER_TYPE 0-�Ū���-������,1- �Ū���-�Ū���
    ---!!!!������ �������� �� ������
    IF in_oper_type = 1 THEN
      FORALL i IN in_doc_id.first .. in_doc_id.last
        DELETE FROM escr_reg_mapping t
         WHERE t.oper_type = 1
           AND t.in_doc_id = in_doc_id(i);
    END IF;
    IF in_oper_type = 0 THEN
      FORALL i IN in_doc_id.first .. in_doc_id.last
        DELETE FROM escr_reg_mapping t
         WHERE t.oper_type = 0
           AND t.out_doc_id = in_doc_id(i);
      FORALL i IN in_doc_id.first .. in_doc_id.last
        DELETE FROM escr_reg_header t WHERE t.deal_id = in_doc_id(i);
      FORALL i IN in_doc_id.first .. in_doc_id.last
        DELETE FROM escr_reg_body t WHERE t.deal_id = in_doc_id(i);
      FORALL i IN in_doc_id.first .. in_doc_id.last
        DELETE FROM nd_txt t
         WHERE (t.tag = 'ES000' OR t.tag = 'ES005')
           AND t.nd = in_doc_id(i);
    END IF;
    FOR i IN 1 .. in_doc_id.count
    LOOP
      p_reg_del(in_reg_id => in_doc_id(i));
    END LOOP;
  END p_unmapping;

  /**********************************************
     PROCEDURE  P_REG_CREATE
     DESCRIPTION: ��������� �Ū����
  *********************************************/
  PROCEDURE p_reg_create
  (
    in_date_from escr_register.date_from%TYPE
   ,in_date_to   escr_register.date_to%TYPE
   ,in_reg_type  escr_reg_types.code%TYPE
   ,in_reg_kind  escr_reg_kind.code%TYPE
   ,in_reg_level escr_register.reg_level%TYPE
   ,in_oper_type escr_reg_mapping.oper_type%TYPE
   ,in_obj_list  number_list
   ,out_reg_id   IN OUT escr_register.id%TYPE
  ) IS
    l_inner_number escr_register.inner_number%TYPE;
    l_create_date  escr_register.create_date%TYPE := SYSDATE;
    l_check_flag   NUMBER;

  BEGIN
    -- in_reg_level ���� �������� �������� 1-��,0-��

    p_get_user_name(out_user_name => user_name);
    --��������� ID ����, ���� ������ �� �������
    p_get_status_id(in_status_code => 'ADD_TO_REGISTER'
                   ,out_status_id  => l_status_id);
    p_get_kind_id(in_kind_code => in_reg_kind
                 ,out_kind_id  => l_reg_kind_id);
    p_get_type_id(in_type_code => in_reg_type
                 ,out_type_id  => l_reg_type_id);
    IF in_oper_type = 0 THEN
      p_check_before_create(in_obj_list    => in_obj_list
                           ,in_reg_kind    => in_reg_kind
                           ,out_check_flag => l_check_flag);
    ELSE
      l_check_flag := 0;
    END IF;
    --������� ����� ����� � �Ū���

    IF l_check_flag <> -999 THEN
      IF out_reg_id IS NULL THEN
        --�����Ӫ�� ����� ID
        p_get_new_id(in_obj_name => 'ESCR_REGISTER', out_id => out_reg_id);
        --����Ӫ�� ����в�Ͳ� ����� �Ū����
        l_inner_number := '����� � ' || out_reg_id || ' �� ����� � ' ||
                          to_char(in_date_from, lc_date_format) || ' �� ' ||
                          to_char(in_date_to, lc_date_format) ||
                          ' �������� ' || c_branch;
        INSERT INTO escr_register
          (id
          ,inner_number
          ,outer_number
          ,create_date
          ,date_from
          ,date_to
          ,reg_type_id
          ,reg_kind_id
          ,branch
          ,reg_level
          ,user_id
          ,user_name
          ,status_id
          ,reg_union_flag)
        VALUES
          (out_reg_id
          ,l_inner_number
          ,NULL
          ,l_create_date
          ,trunc(in_date_from)
          ,trunc(in_date_to)
          ,l_reg_type_id
          ,l_reg_kind_id
          ,c_branch
          ,in_reg_level
          ,user_id
          ,user_name
          ,l_status_id
          ,l_reg_union_flag) log errors INTO err$_escr_register
          ('INSERT') reject LIMIT unlimited;
        --��������ު�� ������ �Ū����
        -- DOC_TYPE ���� �������� �������� 1 -�Ū���,0-������
        -- OPER_TYPE 0-�Ū���-������,1- �Ū���-�Ū���
        ---!!!!������ �������� �� ������
      END IF;
      IF in_obj_list IS NOT NULL
         AND in_oper_type = 0
         AND in_reg_level = 0 THEN
        p_mapping(in_in_doc_id    => out_reg_id
                 ,in_in_doc_type  => 1
                 ,in_out_doc_id   => in_obj_list
                 ,in_out_doc_type => 0
                 ,in_oper_type    => in_oper_type
                 ,in_oper_date    => SYSDATE);
        p_set_obj_status(in_obj_id      => out_reg_id
                        ,in_obj_type    => 1
                        ,in_status_code => 'ADD_TO_REGISTER'
                        ,in_set_date    => l_create_date);
      END IF;
      IF in_obj_list IS NOT NULL
         AND in_oper_type = 1
         AND in_reg_level = 0 THEN
        p_mapping(in_in_doc_id    => out_reg_id
                 ,in_in_doc_type  => 1
                 ,in_out_doc_id   => in_obj_list
                 ,in_out_doc_type => 1
                 ,in_oper_type    => in_oper_type
                 ,in_oper_date    => SYSDATE);
        p_set_obj_status(in_obj_id      => out_reg_id
                        ,in_obj_type    => 1
                        ,in_status_code => 'ADD_TO_REGISTER'
                        ,in_set_date    => l_create_date);
      END IF;
      IF in_obj_list IS NOT NULL
         AND in_oper_type = 1
         AND in_reg_level = 1 THEN
        p_mapping(in_in_doc_id    => out_reg_id
                 ,in_in_doc_type  => 1
                 ,in_out_doc_id   => in_obj_list
                 ,in_out_doc_type => 1
                 ,in_oper_type    => in_oper_type
                 ,in_oper_date    => SYSDATE);
        /*p_set_obj_status(in_obj_id      => out_reg_id
                        ,in_obj_type    => 1
                        ,in_status_code => 'RECEIVED'
                        ,in_set_date    => l_create_date);*/
      END IF;
    ELSIF l_check_flag <> 0 THEN
      out_reg_id := l_check_flag; --��� �������� �����������, �� � �������� �� � ����� �� ���� ���� ��������
    END IF;
    -- out_reg_id:=-998;
  END p_reg_create;
  /**********************************************
     PROCEDURE  p_event_del
     DESCRIPTION: ��������� ����������������� ������,
     � �������,���� ���� �� ��������� ���
  *********************************************/
  PROCEDURE p_event_del
  (
    in_deal_id  escr_reg_body.deal_id%TYPE
   ,in_event_id escr_reg_body.id%TYPE
  ) IS
  BEGIN
    DELETE FROM escr_reg_body t
     WHERE t.id = in_event_id
       AND t.deal_id = in_deal_id;
  END p_event_del;
  /**********************************************
     PROCEDURE  p_reg_del
     DESCRIPTION: ��������� ������
  *********************************************/
  PROCEDURE p_reg_del(in_reg_id escr_register.id%TYPE) IS
  BEGIN
    -- ���������� �� �� ����� ��*���� �� ����� � ������
    p_reg_has_in_mapping(in_reg_id => in_reg_id, out_has_flag => l_in_flag);
    p_reg_has_out_mapping(in_reg_id    => in_reg_id
                         ,out_has_flag => l_out_flag);
    IF l_in_flag = 0
       AND l_out_flag = 0 THEN
      DELETE FROM escr_register t WHERE t.id = in_reg_id;
    END IF;
  END p_reg_del;
  /**********************************************
     PROCEDURE   P_SET_REG_OUT_NUMBER
     DESCRIPTION: ��������ު ���Ͳ�Ͳ� ����� �Ū����
  *********************************************/
  PROCEDURE p_set_reg_out_number
  (
    in_reg_id     escr_register.id%TYPE
   ,in_out_number escr_register.outer_number%TYPE DEFAULT NULL
  ) IS
  BEGIN
    --������ ����²��� �� ���������  REG_ID
    UPDATE escr_register
       SET outer_number = in_out_number
     WHERE id = in_reg_id;
    --cck_app.set_nd_txt(in_obj_id, 'ES007', in_status_comment);
    BEGIN

      pkg_escr_reg_utl.p_set_obj_status(in_obj_id         => in_reg_id
                                       ,in_obj_type       => 1
                                       ,in_status_code    => 'CONFIRMED_GVI'
                                       ,in_status_comment => ''
                                       ,in_obj_check      => 1
                                       ,in_set_date       => SYSDATE
                                       ,in_oper_level     => 1);
    END;

  END p_set_reg_out_number;
  /**********************************************
     PROCEDURE   f_convert_to_number
     DESCRIPTION: �������� ��� � �����
  *********************************************/
  FUNCTION f_convert_to_number(p_str VARCHAR2) RETURN NUMBER IS
  BEGIN
    RETURN to_number(REPLACE(REPLACE(p_str
                                    ,','
                                    ,substr(to_char(11 / 10), 2, 1))
                            ,'.'
                            ,substr(to_char(11 / 10), 2, 1)));
  EXCEPTION
    WHEN OTHERS THEN
      raise_application_error(-20000, SQLERRM, TRUE);
  END f_convert_to_number;
  /**********************************************
     PROCEDURE   p_received_xml
     DESCRIPTION: ��������� ������ �� �� �� ���� xml ���� � ������ � �������
  *********************************************/
  PROCEDURE p_received_xml
  (
    in_reg_xml IN CLOB
   ,in_flag    NUMBER DEFAULT 0
  ) IS
  BEGIN
    p_get_new_id(in_obj_name => 'escr_reg_xml_files', out_id => p_new_id);
    INSERT INTO escr_reg_xml_files
      (id
      ,branch
      ,CLOB
      ,oper_date
      ,reg_count
      ,reg_header_count
      ,reg_body_count
      ,err_text)
    VALUES
      (p_new_id, c_branch, in_reg_xml, SYSDATE, 0, 0, 0, NULL);
    COMMIT;
    IF in_flag = 0 THEN
      --p_xml_parse(in_reg_xml => in_reg_xml);
      p_xml_parse(in_file_id => p_new_id);
    END IF;
  END p_received_xml;

  /**********************************************
     PROCEDURE   p_reg_ins_from_xml
     DESCRIPTION: ����� �������� ������ � ������ ������� � ������� escr_register
  *********************************************/

  PROCEDURE p_reg_ins_xml
  (
    in_dom_doc IN xmldom.domdocument
   ,in_file_id NUMBER DEFAULT NULL
  ) IS

    l_escrparamlist dbms_xmldom.domnodelist;
    l_escrparam     dbms_xmldom.domnode;

    h     VARCHAR2(100) := 'bars.pkg_escr_reg_utls.p_reg_ins_xml.';
    l_str VARCHAR2(2000);

    l_reg_rec   t_register := t_register();
    l_reg_count NUMBER;
  BEGIN

    bars_audit.trace(h || 'Started');

    --  ������� �������� ������
    l_escrparamlist := dbms_xmldom.getelementsbytagname(in_dom_doc
                                                       ,'EscrParam');
    FOR i IN 0 .. dbms_xmldom.getlength(l_escrparamlist) - 1
    LOOP
      l_escrparam := dbms_xmldom.item(l_escrparamlist, i);

      l_reg_rec.extend;

      dbms_xslprocessor.valueof(l_escrparam, 'register/ID/text()', l_str);
      l_reg_rec(l_reg_rec.last).id := f_convert_to_number(l_str);

      dbms_xslprocessor.valueof(l_escrparam
                               ,'register/INNER_NUMBER/text()'
                               ,l_str);
      l_reg_rec(l_reg_rec.last).inner_number := TRIM(l_str);

      dbms_xslprocessor.valueof(l_escrparam
                               ,'register/OUTER_NUMBER/text()'
                               ,l_str);
      l_reg_rec(l_reg_rec.last).outer_number := TRIM(l_str);

      l_reg_rec(l_reg_rec.last).create_date := SYSDATE;

      dbms_xslprocessor.valueof(l_escrparam
                               ,'register/DATE_FROM/text()'
                               ,l_str);
      l_reg_rec(l_reg_rec.last).date_from := to_date(substr(l_str, 1, 10)
                                                    ,'yyyy-mm-dd');

      dbms_xslprocessor.valueof(l_escrparam
                               ,'register/DATE_TO/text()'
                               ,l_str);
      l_reg_rec(l_reg_rec.last).date_to := to_date(substr(l_str, 1, 10)
                                                  ,'yyyy-mm-dd');

      dbms_xslprocessor.valueof(l_escrparam
                               ,'register/REG_TYPE_ID/text()'
                               ,l_str);
      l_reg_rec(l_reg_rec.last).reg_type_id := f_convert_to_number(l_str);

      dbms_xslprocessor.valueof(l_escrparam
                               ,'register/REG_KIND_ID/text()'
                               ,l_str);
      l_reg_rec(l_reg_rec.last).reg_kind_id := f_convert_to_number(l_str);

      dbms_xslprocessor.valueof(l_escrparam
                               ,'register/BRANCH/text()'
                               ,l_str);
      l_reg_rec(l_reg_rec.last).branch := TRIM(l_str);

      dbms_xslprocessor.valueof(l_escrparam
                               ,'register/REG_LEVEL/text()'
                               ,l_str);
      l_reg_rec(l_reg_rec.last).reg_level := f_convert_to_number(l_str);

      dbms_xslprocessor.valueof(l_escrparam
                               ,'register/USER_ID/text()'
                               ,l_str);
      l_reg_rec(l_reg_rec.last).user_id := f_convert_to_number(l_str);

      dbms_xslprocessor.valueof(l_escrparam
                               ,'register/USER_NAME/text()'
                               ,l_str);
      l_reg_rec(l_reg_rec.last).user_name :=  /*TRIM(convert(*/
       l_str
      /*,'CL8MSWIN1251'
                                                                                                                                                               ,'UTF8'))*/
        ;

      dbms_xslprocessor.valueof(l_escrparam
                               ,'register/STATUS_ID/text()'
                               ,l_str);
      l_reg_rec(l_reg_rec.last).status_id := f_convert_to_number(l_str);

      dbms_xslprocessor.valueof(l_escrparam
                               ,'register/REG_UNION_FLAG/text()'
                               ,l_str);
      l_reg_rec(l_reg_rec.last).reg_union_flag := 0;
      l_reg_rec(l_reg_rec.last).file_id := in_file_id;
      -- dbms_xmldom.freedocument(in_dom_doc);
    END LOOP;

    --������� � �������  escr_register ��� ������ � ��������
    BEGIN
      FORALL j IN l_reg_rec.first .. l_reg_rec.last
        INSERT INTO escr_register t
        VALUES l_reg_rec
          (j) log errors INTO err$_escr_register
          ('INSERT') reject LIMIT unlimited;
    END;
    l_reg_count := l_reg_rec.count;
    UPDATE escr_reg_xml_files t
       SET t.reg_count = l_reg_count
     WHERE t.id = in_file_id;
    --������������ ������� �������
    FOR i IN 1 .. l_reg_rec.count
    LOOP
      p_set_obj_status(in_obj_id      => l_reg_rec(i).id
                      ,in_obj_type    => 1
                      ,in_status_code => 'RECEIVED'
                      ,in_obj_check   => 1 /*0*/);
    END LOOP;

    --�������,���� ������� �������
    l_reg_rec.delete();
    l_reg_rec := NULL;
    bars_audit.trace(h || ' finished.');
  END p_reg_ins_xml;
  /*****************************************************************************
     PROCEDURE   p_reg_header_ins_xml
     DESCRIPTION: ������ xml � ������� � ������� escr_reg_header
  *****************************************************************************/

  PROCEDURE p_reg_header_ins_xml
  (
    in_dom_doc IN xmldom.domdocument
   ,in_file_id NUMBER DEFAULT 0
  ) IS

    h                   VARCHAR2(100) := 'bars.pkg_escr_reg_utls.p_reg_header_ins_xml.';
    l_escrdealparamlist dbms_xmldom.domnodelist;
    l_escrdealparam     dbms_xmldom.domnode;

    l_reg_header       t_reg_header := t_reg_header();
    l_reg_mapping      t_reg_mapping := t_reg_mapping();
    l_str              VARCHAR(4000);
    l_reg_header_count NUMBER;
  BEGIN

    bars_audit.trace(h || 'Started');

    --������� �������� ������� ,� ����� ����� �� ��������� �� ��������
    l_escrdealparamlist := dbms_xmldom.getelementsbytagname(in_dom_doc
                                                           ,'EscrDealParam');

    dbms_output.put_line(dbms_xmldom.getlength(l_escrdealparamlist));
    FOR i IN 0 .. dbms_xmldom.getlength(l_escrdealparamlist) - 1
    LOOP
      l_escrdealparam := dbms_xmldom.item(l_escrdealparamlist, i);

      l_reg_header.extend;
      l_reg_header(l_reg_header.last).id := s_escr.nextval;
      dbms_xslprocessor.valueof(l_escrdealparam
                               ,'credit/CUSTOMER_ID/text()'
                               ,l_str);
      l_reg_header(l_reg_header.last).customer_id := f_convert_to_number(l_str);

      dbms_xslprocessor.valueof(l_escrdealparam
                               ,'credit/CUSTOMER_NAME/text()'
                               ,l_str);

      l_reg_header(l_reg_header.last).customer_name := l_str;

      dbms_xslprocessor.valueof(l_escrdealparam
                               ,'credit/CUSTOMER_OKPO/text()'
                               ,l_str);
      l_reg_header(l_reg_header.last).customer_okpo := l_str;

      dbms_xslprocessor.valueof(l_escrdealparam
                               ,'credit/CUSTOMER_REGION/text()'
                               ,l_str);

      l_reg_header(l_reg_header.last).customer_region := l_str;

      dbms_xslprocessor.valueof(l_escrdealparam
                               ,'credit/CUSTOMER_FULL_ADDRESS/text()'
                               ,l_str);

      l_reg_header(l_reg_header.last).customer_full_address := l_str;

      dbms_xslprocessor.valueof(l_escrdealparam
                               ,'credit/SUBS_NUMB/text()'
                               ,l_str);

      l_reg_header(l_reg_header.last).subs_numb := l_str;

      dbms_xslprocessor.valueof(l_escrdealparam
                               ,'credit/SUBS_DATE/text()'
                               ,l_str);

      l_reg_header(l_reg_header.last).subs_date := to_date(substr(l_str
                                                                 ,1
                                                                 ,10)
                                                          ,'yyyy-mm-dd');

      dbms_xslprocessor.valueof(l_escrdealparam
                               ,'credit/SUBS_DOC_TYPE/text()'
                               ,l_str);

      l_reg_header(l_reg_header.last).subs_doc_type := l_str;
      l_reg_mapping.extend;
      dbms_xslprocessor.valueof(l_escrdealparam
                               ,'credit/DEAL_ID/text()'
                               ,l_str);
      l_reg_header(l_reg_header.last).deal_id := f_convert_to_number(l_str);
      l_reg_mapping(l_reg_mapping.last).out_doc_id := f_convert_to_number(l_str);
      dbms_xslprocessor.valueof(l_escrdealparam
                               ,'credit/DEAL_NUMBER/text()'
                               ,l_str);
      l_reg_header(l_reg_header.last).deal_number := l_str;
      dbms_xslprocessor.valueof(l_escrdealparam
                               ,'credit/DEAL_DATE_FROM/text()'
                               ,l_str);
      l_reg_header(l_reg_header.last).deal_date_from := to_date(substr(l_str
                                                                      ,1
                                                                      ,10)
                                                               ,'yyyy-mm-dd');
      dbms_xslprocessor.valueof(l_escrdealparam
                               ,'credit/DEAL_DATE_TO/text()'
                               ,l_str);
      l_reg_header(l_reg_header.last).deal_date_to := to_date(substr(l_str
                                                                    ,1
                                                                    ,10)
                                                             ,'yyyy-mm-dd');
      dbms_xslprocessor.valueof(l_escrdealparam
                               ,'credit/DEAL_TERM/text()'
                               ,l_str);
      l_reg_header(l_reg_header.last).deal_term := l_str;
      dbms_xslprocessor.valueof(l_escrdealparam
                               ,'credit/DEAL_PRODUCT/text()'
                               ,l_str);
      l_reg_header(l_reg_header.last).deal_product := l_str;
      dbms_xslprocessor.valueof(l_escrdealparam
                               ,'credit/DEAL_PRODUCT/text()'
                               ,l_str);
      l_reg_header(l_reg_header.last).deal_product := l_str;
      dbms_xslprocessor.valueof(l_escrdealparam
                               ,'credit/DEAL_STATE/text()'
                               ,l_str);
      l_reg_header(l_reg_header.last).deal_state := l_str;

      dbms_xslprocessor.valueof(l_escrdealparam
                               ,'credit/DEAL_TYPE_NAME/text()'
                               ,l_str);
      l_reg_header(l_reg_header.last).deal_type_name := l_str;
      dbms_xslprocessor.valueof(l_escrdealparam
                               ,'credit/DEAL_SUM/text()'
                               ,l_str);
      l_reg_header(l_reg_header.last).deal_sum := l_str;
      dbms_xslprocessor.valueof(l_escrdealparam
                               ,'credit/GOOD_COST/text()'
                               ,l_str);
      l_reg_header(l_reg_header.last).good_cost := l_str;
      dbms_xslprocessor.valueof(l_escrdealparam
                               ,'credit/NLS/text()'
                               ,l_str);
      l_reg_header(l_reg_header.last).nls := l_str;

      dbms_xslprocessor.valueof(l_escrdealparam
                               ,'credit/DOC_DATE/text()'
                               ,l_str);
      l_reg_header(l_reg_header.last).doc_date := to_date(substr(l_str
                                                                ,1
                                                                ,10)
                                                         ,'yyyy-mm-dd');
      dbms_xslprocessor.valueof(l_escrdealparam
                               ,'credit/COMP_SUM/text()'
                               ,l_str);
      l_reg_header(l_reg_header.last).comp_sum := l_str;
      dbms_xslprocessor.valueof(l_escrdealparam
                               ,'credit/BRANCH_CODE/text()'
                               ,l_str);
      l_reg_header(l_reg_header.last).branch_code := l_str;
      dbms_xslprocessor.valueof(l_escrdealparam
                               ,'credit/BRANCH_NAME/text()'
                               ,l_str);
      l_reg_header(l_reg_header.last).branch_name := l_str;
      dbms_xslprocessor.valueof(l_escrdealparam
                               ,'credit/MFO/text()'
                               ,l_str);
      l_reg_header(l_reg_header.last).mfo := l_str;
      dbms_xslprocessor.valueof(l_escrdealparam
                               ,'credit/USER_ID/text()'
                               ,l_str);
      l_reg_header(l_reg_header.last).user_id := l_str;
      dbms_xslprocessor.valueof(l_escrdealparam
                               ,'credit/USER_NAME/text()'
                               ,l_str);
      l_reg_header(l_reg_header.last).user_name := l_str;

      --���������� �������� ������

      l_reg_mapping(l_reg_mapping.last).id := s_escr.nextval;
      dbms_xslprocessor.valueof(l_escrdealparam
                               ,'credit/REG_ID/text()'
                               ,l_str);
      l_reg_mapping(l_reg_mapping.last).in_doc_id := f_convert_to_number(l_str);
      l_reg_mapping(l_reg_mapping.last).in_doc_type := 1;
      l_reg_mapping(l_reg_mapping.last).out_doc_type := 0;
      l_reg_mapping(l_reg_mapping.last).branch := c_branch;
      l_reg_mapping(l_reg_mapping.last).oper_date := SYSDATE;
      l_reg_mapping(l_reg_mapping.last).oper_type := 0;

    END LOOP;

    /*    --������� �������,�� ������ �������� ������
    BEGIN
      EXECUTE IMMEDIATE ' truncate table  ERR$_escr_reg_header';
    END;*/
    BEGIN
      FORALL j IN l_reg_header.first .. l_reg_header.last
        INSERT INTO escr_reg_header t
        VALUES l_reg_header
          (j) log errors INTO err$_escr_reg_header
          ('INSERT') reject LIMIT unlimited;
      -- l_reg_header.delete;
    END;

    BEGIN
      FORALL j IN l_reg_mapping.first .. l_reg_mapping.last
        INSERT INTO escr_reg_mapping t
        VALUES l_reg_mapping
          (j) log errors INTO err$_escr_reg_mapping
          ('INSERT') reject LIMIT unlimited;
      l_reg_mapping.delete;
      bars_audit.trace(h || 'Finished');
    END;
    --������������ ��������� ������ �������
    FOR i IN 1 .. l_reg_header.count
    LOOP
      p_set_obj_status(in_obj_id         => l_reg_header(i).deal_id
                      ,in_obj_type       => 0
                      ,in_status_code    => 'RECEIVED'
                      ,in_status_comment => NULL
                      ,in_obj_check      => 0
                      ,in_set_date       => SYSDATE
                      ,in_oper_level     => 1);
    END LOOP;
    l_reg_header_count := l_reg_header.count;
    UPDATE escr_reg_xml_files t
       SET t.reg_header_count = l_reg_header_count
     WHERE t.id = in_file_id;
    --�������,���� ������� �������
    l_reg_header.delete();
    l_reg_header := NULL;
    l_reg_mapping.delete();
    l_reg_mapping := NULL;

    -- dbms_xmldom.freedocument(in_dom_doc);
  END p_reg_header_ins_xml;
  /**********************************************
     PROCEDURE   p_reg_body_ins__xml
     DESCRIPTION: ������
  *********************************************/

  PROCEDURE p_reg_body_ins_xml
  (
    in_dom_doc IN xmldom.domdocument
   ,in_file_id NUMBER DEFAULT 0
  ) IS

    h                     VARCHAR2(100) := 'bars.pkg_escr_reg_utls.p_reg_body_ins_xml.';
    l_escreventsparamlist dbms_xmldom.domnodelist;
    l_escreventsparam     dbms_xmldom.domnode;

    l_reg_body       t_reg_body := t_reg_body();
    l_str            VARCHAR(4000);
    l_reg_body_count NUMBER;
  BEGIN

    bars_audit.trace(h || 'Started');

    --������� �������� ������� ,� ����� ����� �� ��������� �� ��������
    l_escreventsparamlist := dbms_xmldom.getelementsbytagname(in_dom_doc
                                                             ,'EscrHeaderEvents');

    dbms_output.put_line(dbms_xmldom.getlength(l_escreventsparamlist));
    FOR i IN 0 .. dbms_xmldom.getlength(l_escreventsparamlist) - 1
    LOOP
      l_escreventsparam := dbms_xmldom.item(l_escreventsparamlist, i);

      l_reg_body.extend;
      l_reg_body(l_reg_body.last).id := s_escr.nextval;
      dbms_xslprocessor.valueof(l_escreventsparam, 'DEAL_ID/text()', l_str);
      l_reg_body(l_reg_body.last).deal_id := f_convert_to_number(l_str);
      dbms_xslprocessor.valueof(l_escreventsparam
                               ,'DEAL_ADR_ID/text()'
                               ,l_str);
      l_reg_body(l_reg_body.last).deal_adr_id := f_convert_to_number(l_str);
      dbms_xslprocessor.valueof(l_escreventsparam
                               ,'DEAL_REGION/text()'
                               ,l_str);
      l_reg_body(l_reg_body.last).deal_region := l_str;
      dbms_xslprocessor.valueof(l_escreventsparam
                               ,'DEAL_FULL_ADDRESS/text()'
                               ,l_str);
      l_reg_body(l_reg_body.last).deal_full_address := l_str;
      dbms_xslprocessor.valueof(l_escreventsparam
                               ,'DEAL_BUILD_ID/text()'
                               ,l_str);
      l_reg_body(l_reg_body.last).deal_build_id := f_convert_to_number(l_str);
      dbms_xslprocessor.valueof(l_escreventsparam
                               ,'DEAL_EVENT_ID/text()'
                               ,l_str);
      l_reg_body(l_reg_body.last).deal_event_id := f_convert_to_number(l_str);

    END LOOP;
    --������� �������,�� ������ �������� ������
    /* BEGIN
      EXECUTE IMMEDIATE ' truncate table  ERR$_escr_reg_body';
    END;*/
    BEGIN
      FORALL j IN l_reg_body.first .. l_reg_body.last
        INSERT INTO escr_reg_body t
        VALUES l_reg_body
          (j) log errors INTO err$_escr_reg_body
          ('INSERT') reject LIMIT unlimited;
      -- l_reg_header.delete;
    END;
    l_reg_body_count := l_reg_body.count;
    UPDATE escr_reg_xml_files t
       SET t.reg_body_count = l_reg_body_count
     WHERE t.id = in_file_id;
    --�������,���� ������� �������
    l_reg_body.delete();
    l_reg_body := NULL;

    -- dbms_xmldom.freedocument(in_dom_doc);
  END p_reg_body_ins_xml;
  /**********************************************
     PROCEDURE   p_xml_parse
     DESCRIPTION: ������ ���������� xml
  *********************************************/

  PROCEDURE p_xml_parse
  (
    in_reg_xml IN CLOB DEFAULT NULL
   ,in_file_id NUMBER DEFAULT NULL
  ) IS
    l_doc     dbms_xmldom.domdocument;
    h         VARCHAR2(100) := 'bars.pkg_escr_reg_utls.p_xml_parse.';
    l_parser  dbms_xmlparser.parser;
    l_reg_xml CLOB;
  BEGIN
    IF in_file_id IS NOT NULL THEN
      BEGIN
        SELECT t.clob
          INTO l_reg_xml
          FROM escr_reg_xml_files t
         WHERE t.id = in_file_id;
      EXCEPTION
        WHEN no_data_found THEN
          l_reg_xml := in_reg_xml;
      END;
    ELSE
      l_reg_xml := in_reg_xml;
    END IF;
    bars_audit.trace(h || 'Started');
    -- dbms_session.set_nls('NLS_DATE_FORMAT', '''DD/MON/YYYY''');
    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, l_reg_xml);
    bars_audit.trace(h || 'clob loaded');

    l_doc := dbms_xmlparser.getdocument(l_parser);
    bars_audit.trace(h || 'getdocument done');

    p_reg_ins_xml(l_doc, in_file_id);
    p_reg_header_ins_xml(l_doc, in_file_id);
    p_reg_body_ins_xml(l_doc, in_file_id);
    --
    p_check_after_create;
    --
    dbms_xmlparser.freeparser(l_parser);
    dbms_xmldom.freedocument(l_doc);
  END p_xml_parse;
  /********************************************************
     PROCEDURE p_set_new_sum
     DESCRIPTION: �������������� ���� ������� ������
                  ���� ������� �� ���� ����������� ���
                  �� �� ���� ��� �� ������� �������� ����
  *******************************************************/
  PROCEDURE p_set_new_sum
  (
    in_deal_id       NUMBER
   ,in_new_good_cost NUMBER
   ,in_new_deal_sum  NUMBER
   ,in_new_comp_sum  NUMBER
  ) IS

  BEGIN
    logger.info('ESCR.p_set_new_sum in_deal_id=' || in_deal_id ||
                ' ,in_new_good_cost=' || in_new_good_cost);
    cck_app.set_nd_txt(in_deal_id, 'ES010', in_new_good_cost);
    cck_app.set_nd_txt(in_deal_id, 'ES011', in_new_deal_sum);
    cck_app.set_nd_txt(in_deal_id, 'ES012', in_new_comp_sum);

  END p_set_new_sum;
  /***************************************************************
     PROCEDURE   p_change_comp_sum
     DESCRIPTION: ���������� ���� ���� �� �� ���� �����������,
     ��� �������, ���� �� ����������� ��������
  **************************************************************/
  PROCEDURE p_change_comp_sum
  (
    in_deal_id       escr_reg_header.deal_id%TYPE
   ,in_new_good_cost escr_reg_header.new_good_cost%TYPE
  ) IS
    l_new_comp_sum NUMBER;
  BEGIN
    UPDATE bars.escr_reg_header t
       SET t.new_good_cost = in_new_good_cost
     WHERE t.deal_id = in_deal_id;
    UPDATE bars.escr_reg_header t
       SET t.new_deal_sum = t.deal_sum * (t.new_good_cost / t.good_cost)
     WHERE t.deal_id = in_deal_id;

    FOR rez IN (SELECT *
                  FROM bars.vw_escr_reg_header_ca t
                 WHERE t.deal_id = in_deal_id)
    LOOP
      CASE
        WHEN rez.deal_date_from <= to_date('26/08/2015', 'dd/mm/yyyy')
             AND round(rez.deal_sum * 0.3, 2) <= 5000
             AND rez.subs_numb IS NULL
             AND rez.reg_type_id = 1 THEN
          l_new_comp_sum := round(rez.new_deal_sum * 0.2, 2);
        WHEN rez.deal_date_from <= to_date('26/08/2015', 'dd/mm/yyyy')
             AND round(rez.deal_sum * 0.2, 2) > 5000
             AND rez.subs_numb IS NULL
             AND rez.reg_type_id = 1 THEN
          l_new_comp_sum := 5000;
        WHEN rez.deal_date_from <= to_date('26/08/2015', 'dd/mm/yyyy')
             AND round(rez.new_deal_sum * 0.3, 2) <= 10000
             AND rez.subs_numb IS NULL
             AND rez.reg_type_id = 2 THEN
          l_new_comp_sum := round(rez.new_deal_sum * 0.3, 2);
        WHEN rez.deal_date_from <= to_date('26/08/2015', 'dd/mm/yyyy')
             AND round(rez.new_deal_sum * 0.3, 2) > 10000
             AND rez.subs_numb IS NULL
             AND rez.reg_type_id = 2 THEN
          l_new_comp_sum := 10000;
        WHEN rez.deal_date_from >= to_date('27/08/2015', 'dd/mm/yyyy')
             AND rez.deal_date_from < to_date('19/09/2016', 'dd/mm/yyyy')
             AND round(rez.deal_sum * 0.2, 2) > 12000
             AND rez.subs_numb IS NULL
             AND rez.reg_type_id = 1 THEN
          l_new_comp_sum := 12000;
        WHEN rez.deal_date_from >= to_date('27/08/2015', 'dd/mm/yyyy')
             AND rez.deal_date_from < to_date('19/09/2016', 'dd/mm/yyyy')
             AND round(rez.deal_sum * 0.2, 2) > 12000
             AND rez.subs_numb IS NULL
             AND rez.reg_type_id = 1 THEN
          l_new_comp_sum := 12000;
        WHEN rez.deal_date_from >= to_date('27/08/2015', 'dd/mm/yyyy')
             AND rez.deal_date_from < to_date('19/09/2016', 'dd/mm/yyyy')
             AND round(rez.new_deal_sum * 0.2, 2) <= 12000
             AND rez.subs_numb IS NULL
             AND rez.reg_type_id = 1 THEN
          l_new_comp_sum := round(rez.new_deal_sum * 0.2, 2);
        WHEN rez.deal_date_from >= to_date('27/08/2015', 'dd/mm/yyyy')
             AND rez.deal_date_from < to_date('19/09/2016', 'dd/mm/yyyy')
             AND round(rez.new_deal_sum * 0.7, 2) <= 12000
             AND rez.subs_numb IS NOT NULL
             AND rez.reg_type_id = 1 THEN
          l_new_comp_sum := round(rez.new_deal_sum * 0.7, 2);
        WHEN rez.deal_date_from >= to_date('27/08/2015', 'dd/mm/yyyy')
             AND rez.deal_date_from < to_date('19/09/2016', 'dd/mm/yyyy')
             AND round(rez.new_deal_sum * 0.7, 2) > 12000
             AND rez.subs_numb IS NOT NULL
             AND rez.reg_type_id = 1 THEN
          l_new_comp_sum := 12000;
        WHEN rez.deal_date_from >= to_date('27/08/2015', 'dd/mm/yyyy')
             AND rez.deal_date_from < to_date('19/09/2016', 'dd/mm/yyyy')
             AND round(rez.deal_sum * 0.2, 2) > 12000
             AND rez.subs_numb IS NULL
             AND rez.reg_type_id = 1 THEN
          l_new_comp_sum := 12000;
        WHEN rez.deal_date_from >= to_date('27/08/2015', 'dd/mm/yyyy')
             AND rez.deal_date_from < to_date('19/09/2016', 'dd/mm/yyyy')
             AND round(rez.new_deal_sum * 0.3, 2) > 14000
             AND rez.subs_numb IS NULL
             AND rez.reg_type_id = 2 THEN
          l_new_comp_sum := 14000;
        WHEN rez.deal_date_from >= to_date('27/08/2015', 'dd/mm/yyyy')
             AND rez.deal_date_from < to_date('19/09/2016', 'dd/mm/yyyy')
             AND round(rez.new_deal_sum * 0.3, 2) <= 14000
             AND rez.subs_numb IS NULL
             AND rez.reg_type_id = 2 THEN
          l_new_comp_sum := round(rez.new_deal_sum * 0.3, 2);
        WHEN rez.deal_date_from >= to_date('27/08/2015', 'dd/mm/yyyy')
             AND rez.deal_date_from < to_date('19/09/2016', 'dd/mm/yyyy')
             AND round(rez.new_deal_sum * 0.7, 2) <= 14000
             AND rez.subs_numb IS NOT NULL
             AND rez.reg_type_id = 2 THEN
          l_new_comp_sum := round(rez.new_deal_sum * 0.7, 2);
        WHEN rez.deal_date_from >= to_date('27/08/2015', 'dd/mm/yyyy')
             AND rez.deal_date_from < to_date('19/09/2016', 'dd/mm/yyyy')
             AND round(rez.new_deal_sum * 0.7, 2) > 14000
             AND rez.subs_numb IS NOT NULL
             AND rez.reg_type_id = 2 THEN
          l_new_comp_sum := 14000;
        WHEN rez.deal_date_from >= to_date('19/09/2016', 'dd/mm/yyyy')
             AND round(rez.new_deal_sum * 0.35, 2) > 12000
             AND rez.subs_numb IS NOT NULL
             AND rez.reg_type_id = 1 THEN
          l_new_comp_sum := 12000;
        WHEN rez.deal_date_from >= to_date('19/09/2016', 'dd/mm/yyyy')
             AND round(rez.deal_sum * 0.35, 2) <= 12000
             AND rez.subs_numb IS NOT NULL
             AND rez.reg_type_id = 1 THEN
          l_new_comp_sum := round(rez.new_deal_sum * 0.35, 2);
        WHEN rez.deal_date_from >= to_date('19/09/2016', 'dd/mm/yyyy')
             AND round(rez.new_deal_sum * 0.2, 2) > 12000
             AND rez.subs_numb IS NULL
             AND rez.reg_type_id = 1 THEN
          l_new_comp_sum := 12000;
        WHEN rez.deal_date_from >= to_date('19/09/2016', 'dd/mm/yyyy')
             AND round(rez.new_deal_sum * 0.2, 2) <= 12000
             AND rez.subs_numb IS NULL
             AND rez.reg_type_id = 1 THEN
          l_new_comp_sum := round(rez.new_deal_sum * 0.2, 2);
        WHEN rez.deal_date_from >= to_date('19/09/2016', 'dd/mm/yyyy')
             AND round(rez.new_deal_sum * 0.35, 2) > 14000
             AND rez.reg_type_id = 2 THEN
          l_new_comp_sum := 14000;
        WHEN rez.deal_date_from >= to_date('19/09/2016', 'dd/mm/yyyy')
             AND round(rez.new_deal_sum * 0.35, 2) <= 14000
             AND rez.reg_type_id = 2 THEN
          l_new_comp_sum := round(rez.new_deal_sum * 0.35, 2);
      END CASE;
    END LOOP;
    UPDATE bars.escr_reg_header t
       SET t.new_comp_sum = l_new_comp_sum
     WHERE t.deal_id = in_deal_id;
  END p_change_comp_sum;
  /**********************************************
     PROCEDURE   p_gen_pay
     DESCRIPTION: ��������� ��������� �������� ���������
  *********************************************/
  PROCEDURE p_gen_pay(in_reg_list number_list) IS
    oo       oper%ROWTYPE;
    aa       accounts%ROWTYPE;
    l_nlsa   oper.nlsa%TYPE;
    l_dblink VARCHAR2(100);
    l_user   VARCHAR2(100);
  BEGIN
    --DB-link
    BEGIN
      SELECT p.val
        INTO l_dblink
        FROM params$base p
       WHERE p.par = 'ESCR_LDBL';
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;
    --ACC
    BEGIN
      SELECT p.val
        INTO l_nlsa
        FROM params$base p
       WHERE p.par = 'ESCR_ACC_TEMP';
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;
    --USER
    BEGIN
      SELECT p.val
        INTO l_user
        FROM params$base p
       WHERE p.par = 'ESCR_USER';
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;
    oo.nlsa := l_nlsa;
    EXECUTE IMMEDIATE '
    declare
      l_g_mfo accounts.kf%type;
    begin
      bars.bars_login.login_user@' || l_dblink ||
                      '(null, null, null, null);
      l_g_mfo := bars.f_ourmfo_g@' || l_dblink || ';
      bars.bars_context.subst_branch@' || l_dblink ||
                      '(''/'' || l_g_mfo || ''/'');
    end;';

    BEGIN
      EXECUTE IMMEDIATE 'select *
                         from bars.accounts@' ||
                        l_dblink ||
                        ' where kv = ''980''
                          and nls = :p_nlsa
                          and dazs is null'
        INTO aa
        USING oo.nlsa;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(- (20203)
                               ,'\ �� �������� ���.' || l_nlsa || '/' ||
                                gl.baseval);
    END;
    oo.nam_b := '³����������� ����� �� ����';
    oo.nam_a := substr(aa.nms, 1, 38);
    oo.nlsa  := aa.nls;
    oo.mfoa  := aa.kf;
    oo.kv    := aa.kv;
    FOR i IN 1 .. in_reg_list.count
    LOOP

      FOR k IN (SELECT DISTINCT rh.*, t1.outer_number reg_n
                  FROM bars.vw_escr_reg_header_ca rh, bars.escr_register t1
                 WHERE t1.id = rh.reg_id
                   AND rh.credit_status_id = 7
                   AND rh.reg_id = in_reg_list(i))
      LOOP
        EXECUTE IMMEDIATE 'begin bars.gl.ref@' || l_dblink ||
                          '(:p_REF); end;'
          USING IN OUT oo.ref;
        oo.s    := k.comp_sum * 100;
        oo.nlsb := vkrzn(substr(k.mfo, 1, 5), '3739005');
        /* bars_audit.info('ESCR oo.nlsb =' || oo.nlsb || ' oo.nlsa =' ||
        oo.nlsa);*/
        oo.nd   := substr(k.deal_number, 1, 10);
        oo.mfob := k.mfo;

        BEGIN
          SELECT mfo INTO oo.id_b FROM banks WHERE mfo = k.mfo;
        EXCEPTION
          WHEN no_data_found THEN
            raise_application_error(- (20203)
                                   ,'\ �� �������� � banks_RU MFO=' ||
                                    k.mfo);
        END;

        BEGIN
          EXECUTE IMMEDIATE 'select OKPO
                                 from bars.banks_ru@' ||
                            l_dblink || ' where MFO = :p_mfoa'
            INTO oo.id_a
            USING oo.mfoa;
        EXCEPTION
          WHEN no_data_found THEN
            oo.id_a := NULL;
        END;

        BEGIN
          EXECUTE IMMEDIATE 'select OKPO
                                 from bars.banks_ru@' ||
                            l_dblink || ' where MFO = :p_mfob'
            INTO oo.id_b
            USING oo.mfob;
        EXCEPTION
          WHEN no_data_found THEN
            oo.id_b := NULL;
        END;
        --   oo.id_b := k.G03 ;
        ---  oo.nazn := ND;SDATE;CC_ID;OKPO;NMK

        IF /*instr(k.customer_okpo, '³����� ��� ���������')>0  and*/
         length(TRIM(k.customer_okpo)) > 10 THEN
          oo.nazn := substr(k.reg_n || ';' || k.deal_id || ';' ||
                            to_char(k.deal_date_from, 'dd/mm/yyyy') || ';' ||
                            k.deal_number || ';' || k.customer_name || ';'
                           ,1
                           ,160);
        ELSE
          oo.nazn := substr(k.reg_n || ';' || k.deal_id || ';' ||
                            to_char(k.deal_date_from, 'dd/mm/yyyy') || ';' ||
                            k.deal_number || ';' || k.customer_okpo || ';' ||
                            k.customer_name || ';'
                           ,1
                           ,160);
        END IF;
        IF oo.mfob <> oo.mfoa THEN
          oo.tt := '310';
        ELSE
          oo.tt := '015';
        END IF;
        EXECUTE IMMEDIATE '
    begin
      savepoint before_pay;
      begin
        bars.gl.in_doc3@' || l_dblink ||
                          '(ref_   => :p_ref,
                            tt_    => :p_tt,
                            vob_   => 6,
                            nd_    => :p_nd,
                            pdat_  => SYSDATE,
                            vdat_  => bars.gl.bd@' ||
                          l_dblink || ',
                            dk_    => 1,
                            kv_    => :p_kv,
                            s_     => :p_s,
                            kv2_   => :p_kv,
                            s2_    => :p_s,
                            sk_    => null,
                            data_  => bars.gl.bd@' ||
                          l_dblink || ',
                            datp_  => bars.gl.bd@' ||
                          l_dblink || ',
                            nam_a_ => :p_nam_a,
                            nlsa_  => :p_nlsa,
                            mfoa_  => :p_mfoa,
                            nam_b_ => :p_nam_b,
                            nlsb_  => :p_nlsb,
                            mfob_  => :p_mfob,
                            nazn_  => :p_nazn,
                            d_rec_ => null,
                            id_a_  => :p_okpoa,
                            id_b_  => :p_okpob,
                            id_o_  => null,
                            sign_  => null,
                            sos_   => 1,
                            prty_  => null,
                            uid_   => ' || l_user || ');
        bars.PAYTT@' || l_dblink || '(0,
                       :p_ref,
                       bars.gl.bd@' || l_dblink || ',
                       :p_tt,
                       1,
                       :p_kv,
                       :p_nlsa,
                       :p_s,
                       :p_kv,
                       :p_nlsb,
                       :p_s);
      exception
        when others then
          rollback to before_pay;
          raise;
      end;
    end;'
          USING oo.ref, oo.tt, oo.nd, oo.kv, oo.s /*,oo.kv,oo.s*/
        , oo.nam_a, oo.nlsa, oo.mfoa, oo.nam_b, oo.nlsb, oo.mfob, oo.nazn, oo.id_a, oo.id_b /*,oo.ref,oo.tt,oo.kv,oo.nlsa,oo.s,oo.kv,oo.nlsb,oo.s*/
        ;
        UPDATE escr_reg_header
           SET payment_ref = oo.ref
         WHERE deal_id = k.deal_id
           AND customer_okpo = k.customer_okpo;
      END LOOP;
    END LOOP;

    FOR i IN 1 .. in_reg_list.count
    LOOP
      p_set_obj_status(in_reg_list(i)
                      ,1
                      ,'SETTLE_ACCOUNT'
                      ,NULL
                      ,1
                      ,SYSDATE);
    END LOOP;

  END p_gen_pay;
  /**********************************************
     FUNCTION   p_sync_state
     DESCRIPTION: ������� ������������ ������� � ��
  *********************************************/
  FUNCTION decodeclobfrombase64(p_clob CLOB) RETURN CLOB IS
    l_clob   CLOB;
    l_len    NUMBER;
    l_pos    NUMBER := 1;
    l_buf    VARCHAR2(32767);
    l_amount NUMBER := 32767;
  BEGIN
    l_len := dbms_lob.getlength(p_clob);
    dbms_lob.createtemporary(l_clob, TRUE);

    WHILE l_pos <= l_len
    LOOP
      dbms_lob.read(p_clob, l_amount, l_pos, l_buf);
      l_buf := utl_encode.text_decode(l_buf, encoding => utl_encode.base64);
      l_pos := l_pos + l_amount;
      dbms_lob.writeappend(l_clob, length(l_buf), l_buf);
    END LOOP;

    RETURN l_clob;
  END;

  PROCEDURE p_sync_state IS
    l_url         params$global.val%TYPE := getglobaloption('ESCR_URL_RU');
    l_wallet_path VARCHAR2(256); --:= getglobaloption('OWWALLETPATH');
    l_wallet_pwd  VARCHAR2(256); --:= getglobaloption('OWWALETPWD');
    l_response    wsm_mgr.t_response;
    l_cursor      SYS_REFCURSOR;
    l_deals       t_vw_escr_list_for_sync;
  BEGIN
    BEGIN
      SELECT MAX(val)
        INTO l_wallet_path
        FROM web_barsconfig
       WHERE key = 'SMPP.Wallet_dir';
    END;

    BEGIN
      SELECT MAX(val)
        INTO l_wallet_pwd
        FROM web_barsconfig
       WHERE key = 'SMPP.Wallet_pass';
    END;

    OPEN l_cursor FOR
    /*      SELECT rm.* \*DEAL_ID,
                                                 decode(rm.credit_status_id, 11, rm.credit_status_id, null) as state_id,
                                                 null as comment,
                                                 decode(rm.credit_status_id, 11, 'true', 'false') as is_set*\
                        FROM vw_escr_reg_header rm
                       WHERE rm.credit_status_id IN (1, 2, 3, 16, 6, 7, 5, 12, -999)
                         AND rm.credit_status_id IS NOT NULL;
                */
      SELECT t.deal_id
            ,t.credit_status_id
            ,to_number(NULL) state_id
            ,t.kf
            ,'' AS "COMMENT"
             ,'false' AS is_set
        FROM vw_escr_list_for_sync t;
    LOOP
      FETCH l_cursor BULK COLLECT
        INTO l_deals LIMIT 100;
      DECLARE
        l_root     xmltype;
        l_dealsxml xmltype;
        l_xml      xmltype;
        l_clb      VARCHAR2(4000);
        l_tmp      DECIMAL;
      BEGIN
        SELECT xmlelement("root", xmlelement("mfo", f_ourmfo_g))
          INTO l_root
          FROM dual;
        SELECT xmlelement("deals", NULL) INTO l_dealsxml FROM dual;
        IF l_deals.count = 0 THEN
          RETURN;
        END IF;
        FOR i IN 1 .. l_deals.count
        LOOP
          SELECT xmlagg(xmlelement("deal"
                                   ,xmlelement("deal_id", l_deals(i).deal_id)
                                   ,xmlelement("state_id"
                                              ,l_deals(i).credit_status_id)
                                   ,xmlelement("is_set", 'false')))
            INTO l_xml
            FROM dual;
          SELECT appendchildxml(l_dealsxml, 'deals', l_xml)
            INTO l_dealsxml
            FROM dual;
        END LOOP;
        SELECT appendchildxml(l_root, 'root', l_dealsxml)
          INTO l_root
          FROM dual;

        UPDATE tmp_klp_clob
           SET c = l_root.getclobval()
         WHERE namef = 'EWA';
        /*bars.logger.info('ESCR syncstate body:' || '<?xml version="1.0"?>' ||
        l_root.getclobval());*/
        wsm_mgr.prepare_request(p_url         => l_url ||
                                                 'createregister/syncstate'
                               ,p_action      => NULL
                               ,p_http_method => wsm_mgr.g_http_post
                               ,p_wallet_path => l_wallet_path
                               ,p_wallet_pwd  => l_wallet_pwd
                               ,p_body        => '<?xml version="1.0"?>' ||
                                                 l_root.getclobval());

        wsm_mgr.add_header(p_name  => 'Content-Type'
                          ,p_value => 'application/xml; charset=utf-8');
        -- iicaaou iaoia aaa-na?aena
        wsm_mgr.execute_api(l_response);
        /*bars.logger.info('ESCR l_response' || '<?xml version="1.0"?>' ||
        l_response.cdoc);*/
        l_response.cdoc := decodeclobfrombase64(dbms_lob.substr(l_response.cdoc
                                                               ,length(l_response.cdoc) - 2
                                                               ,2));
      END;
      EXIT WHEN l_cursor%NOTFOUND;
    END LOOP;

    /*wsm_mgr.prepare_request(p_url         => l_url ||
                                             'createregister/syncstate'
                           ,p_action      => NULL
                           ,p_http_method => wsm_mgr.g_http_get
                           ,p_wallet_path => l_wallet_path
                           ,p_wallet_pwd  => l_wallet_pwd
                           ,p_body        => 'sync states');

    wsm_mgr.add_header(p_name  => 'Content-Type'
                      ,p_value => 'text/plain; charset=utf-8');
    -- iicaaou iaoia aaa-na?aena
    wsm_mgr.execute_api(l_response);

    l_response.cdoc := decodeclobfrombase64(dbms_lob.substr(l_response.cdoc
                                                           ,length(l_response.cdoc) - 2
                                                           ,2));*/
    --return l_response;
  END p_sync_state;
  ---old version
/*PROCEDURE p_sync_state IS
  l_url         params$global.val%TYPE := getglobaloption('ESCR_URL_RU');
  l_wallet_path VARCHAR2(256); --:= getglobaloption('OWWALLETPATH');
  l_wallet_pwd  VARCHAR2(256); --:= getglobaloption('OWWALETPWD');
  l_response    wsm_mgr.t_response;
BEGIN

  BEGIN
    SELECT MAX(val)
      INTO l_wallet_path
      FROM web_barsconfig
     WHERE key = 'SMPP.Wallet_dir';
  END;

  BEGIN
    SELECT MAX(val)
      INTO l_wallet_pwd
      FROM web_barsconfig
     WHERE key = 'SMPP.Wallet_pass';
  END;

  wsm_mgr.prepare_request(p_url         => l_url ||
                                           'createregister/syncstate'
                         ,p_action      => NULL
                         ,p_http_method => wsm_mgr.g_http_get
                         ,p_wallet_path => l_wallet_path
                         ,p_wallet_pwd  => l_wallet_pwd
                         ,p_body        => 'sync states');

  wsm_mgr.add_header(p_name  => 'Content-Type'
                    ,p_value => 'text/plain; charset=utf-8');
  -- iicaaou iaoia aaa-na?aena
  wsm_mgr.execute_api(l_response);

  l_response.cdoc := decodeclobfrombase64(dbms_lob.substr(l_response.cdoc
                                                         ,length(l_response.cdoc) - 2
                                                         ,2));
  --return l_response;
END p_sync_state;*/

BEGIN
  DECLARE
    l_id     staff$base.id%TYPE;
    l_branch staff$base.branch%TYPE;
  BEGIN
    BEGIN
      BEGIN
        SELECT branch INTO l_branch FROM staff$base WHERE id = user_id;
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
      END;
      IF l_branch = '/' THEN
        BEGIN
          SELECT id INTO l_id FROM staff$base WHERE logname = 'TECH_ESCR';
        EXCEPTION
          WHEN no_data_found THEN
            NULL;
        END;
        EXECUTE IMMEDIATE 'alter session set current_schema=BARS';
        bars.bars_login.login_user('w4session', l_id, NULL, NULL);
      ELSE
        NULL;
      END IF;
    EXCEPTION
      WHEN no_data_found THEN
        BEGIN
          SELECT id INTO l_id FROM staff$base WHERE logname = 'TECH_ESCR';
        EXCEPTION
          WHEN no_data_found THEN
            NULL;
        END;
        EXECUTE IMMEDIATE 'alter session set current_schema=BARS';
        bars.bars_login.login_user('w4session', l_id, NULL, NULL);
    END;
  END;
END pkg_escr_reg_utl;
/
