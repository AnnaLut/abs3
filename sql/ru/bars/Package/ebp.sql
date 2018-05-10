
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/ebp.sql =========*** Run *** =======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.EBP 
IS
  --
  -- ����� �������� ��� ������ ���������� ������ ������� (���) ��������
  --
  g_header_version  CONSTANT  VARCHAR2(64)  := 'version 1.14  02.05.2018';
  g_awk_header_defs CONSTANT  VARCHAR2(512) := '';

  REQUEST_ALLOWED   CONSTANT  number(1)     :=  1;
  REQUEST_DENIED    CONSTANT  number(1)     := -1;

  FUNCTION header_version
    RETURN varchar2;

  FUNCTION body_version
    RETURN varchar2;

  --
  -- ��������� ������ �� ������ �� �������� ����� ���
  --
  procedure CREATE_ACCESS_REQUEST
  ( p_type         in   cust_requests.req_type%type,
    p_trustee      in   cust_requests.trustee_type%type,
    p_rnk          in   cust_requests.trustee_rnk%type,
    p_cert_num     in   cust_requests.certif_num%type,
    p_cert_date    in   cust_requests.certif_date%type,
    p_date_start   in   cust_requests.date_start%type,
    p_date_finish  in   cust_requests.date_finish%type,
    p_access_info  in   XMLType,
    p_reqid        out  cust_requests.req_id%type
  );

  --
  -- ���� ��������� ������ ������������ ���-�����
  -- ���� ��������� / ������ ������ / �������� �����.�����. /
  --
  procedure modify_access_request
  ( p_reqid        in   cust_requests.req_id%type,
    p_cert_num     in   cust_requests.certif_num%type,
    p_cert_date    in   cust_requests.certif_date%type,
    p_date_start   in   cust_requests.date_start%type,
    p_date_finish  in   cust_requests.date_finish%type,
    p_access_info  in   XMLType
  );

  --
  -- ������������ ������� �������
  --
  procedure set_request_state
  ( p_reqid        in      cust_requests.req_id%type,
    p_state        in      cust_requests.req_state%type,
    p_comment      in      cust_requests.comments%type  default null
  );

  --
  -- ������� ������ (������ / ������� ������� �� ��������)
  --
  procedure process_access_request
  ( p_reqid        in      cust_requests.req_id%type,
    p_reqstate     in      cust_requests.req_state%type,
    p_comment      in      cust_requests.comments%type
  );

  --
  -- �������� ��������� ������ � ��������� ���� (��� ��������� ������ � �볺����)
  --
  procedure close_access_request
  ( p_rnk          in   cust_requests.trustee_rnk%type,
    p_type         in   cust_requests.req_type%type
  );

  --
  -- ����� ��������� ������ �� �볺���
  --
  function get_active_request
  ( p_rnk          in   cust_requests.trustee_rnk%type,
    p_dptid        in   cust_req_access.contract_id%type
  ) return cust_requests.req_id%type;

  --
  -- �������� ������ ������� �������� ��������� �� ��� (1- ��� / 0 - �)
  --
  function HAS_EBP_DEPOSIT_ACCOUNTS
  ( p_ref          in  oper.ref%type
  ) return number;

  --
  -- ������� ������������� ����������� �������� � ��
  --
  function GET_ARCHIVE_DOCID
  ( p_dptid        in  dpt_deposit.deposit_id%type
  ) return dpt_deposit.archdoc_id%type
    result_cache;
  --
  -- ������� ������������� ����������� ��������� ���� � ��
  --
  function GET_ARCHIVE_DKBO_DOCID
  ( p_acc                in w4_acc.acc_pk%type,
    p_rnk                in deal.customer_id%type,
    p_struct_code        in ead_struct_codes.id%type,
    p_template           in ead_docs.template_id%type
  ) return number
    result_cache;
  --
  -- ������������ ������ �������� �������� ���������, �� ������� �����
  --
  procedure SET_VERIFIED_STATE
  ( p_rnk          in   person_valid_document.rnk%type,
    p_state        in   person_valid_document.doc_state%type
  );

  ---
  -- �������� ������ ����������� ���������, �� ������� �����
  ---
  function GET_VERIFIED_STATE
  ( p_rnk          in   dpt_customer_changes.rnk%type
  ) return number;

  ---
  -- �������� ���������� ������� �� "²������Ͳ���"
  ---
  function CHECK_VIRTUAL_BPK
  ( p_acc          in   accounts.acc%type
  ) return number;

  ---
  -- ���������� �������������� ����������� �������� ���������� �� ���
  ---
  procedure SET_ARCHIVE_DOCID
  ( p_dptid        in   dpt_deposit.deposit_id%type,
    p_docid        in   dpt_deposit.archdoc_id%type
  );

  ---
  -- ����� ������� ��� �����
  ---
  function GET_TEMPLATE
  ( p_dptid        in   dpt_deposit.deposit_id%type,
    p_code         in   dpt_vidd_flags.id%type,
    p_fr           in   doc_scheme.fr%type  default 0
  ) return dpt_vidd_scheme.id%type;

  ---
  -- ������� ������� ���������� �볺���
  ---
  function GET_CUSTOMER_IMAGE
  ( p_rnk          in   CUSTOMER_IMAGES.rnk%type,
    p_typ          in   CUSTOMER_IMAGES.type_img%type
  ) return CUSTOMER_IMAGES.image%type;

  ---
  -- ��������� ��������� ���������� ������� �������� �볺���
  ---
  procedure PREVIOUS_SAVE_CUSTOMER_PARAMS
  ( p_rnk          in   dpt_customer_changes.rnk%type,
    p_tag          in   dpt_customer_changes.tag%type,
    p_val          in   dpt_customer_changes.val%type,
    p_val_old      in   dpt_customer_changes.val_old%type default null
  );

  ---
  -- ��������� ���������� ��� �������� �볺���
  ---
  procedure SAVE_CHANGES_CUSTOMER_PARAMS
  ( p_rnk          in   dpt_customer_changes.rnk%type
  );

   ---
  --����������� ������������ ��� �����
  ---
  procedure send_message_to_back_office
  ( p_url          in   USER_MESSAGES.MSG_TEXT%type
  );
    --
  -- ��������� ��������� ���������� ������� �������� �볺���(���)
  --NAME_FULL ����� ����� �볺���
  --CUST_CODE ��� �볺���
  --BIRTH_DATE  ���� ���������� �볺���
  --COUNTRY ����� �볺���
  --CELL_PHONE  �������� �������
  --WORK_PHONE  ������� �������
  --HOME_PHONE  ������� �������
  --DOC_TYPE  ����� ����������������� ���������
  --DOC_SERIAL  ���� ����������������� ���������
  --DOC_NUMBER  ����� ����������������� ���������
  --DOC_DATE  ���� ������ ����������������� ���������
  --DOC_ORGAN ���������� ��� ������ ���������������� ��������
  --PHOTO_DATE  ���� ���������� ���� � �������
  --ADDRESS_F ����� ������ ����������
  --ADDRESS_U ����� ������ ���������
  --
 PROCEDURE PREVIOUS_SAVE_CUSTOMER_CHANGES (
      p_rnk              IN dpt_customer_changes.rnk%TYPE,
      p_NAME_FULL        IN dpt_customer_changes.val%TYPE,
      p_NAME_FULL_OLD    IN dpt_customer_changes.val_old%TYPE,
      p_CUST_CODE        IN dpt_customer_changes.val%TYPE,
      p_CUST_CODE_OLD    IN dpt_customer_changes.val_old%TYPE,
      p_BIRTH_DATE       IN dpt_customer_changes.val%TYPE,
      p_BIRTH_DATE_OLD   IN dpt_customer_changes.val_old%TYPE,
      p_COUNTRY          IN dpt_customer_changes.val%TYPE,
      p_COUNTRY_OLD      IN dpt_customer_changes.val_old%TYPE,
      p_CELL_PHONE       IN dpt_customer_changes.val%TYPE,
      p_CELL_PHONE_OLD   IN dpt_customer_changes.val_old%TYPE,
      p_WORK_PHONE       IN dpt_customer_changes.val%TYPE,
      p_WORK_PHONE_OLD   IN dpt_customer_changes.val_old%TYPE,
      p_HOME_PHONE       IN dpt_customer_changes.val%TYPE,
      p_HOME_PHONE_OLD   IN dpt_customer_changes.val_old%TYPE,
      p_DOC_TYPE         IN dpt_customer_changes.val%TYPE,
      p_DOC_TYPE_OLD     IN dpt_customer_changes.val_old%TYPE,
      p_DOC_SERIAL       IN dpt_customer_changes.val%TYPE,
      p_DOC_SERIAL_OLD   IN dpt_customer_changes.val_old%TYPE,
      p_DOC_NUMBER       IN dpt_customer_changes.val%TYPE,
      p_DOC_NUMBER_OLD   IN dpt_customer_changes.val_old%TYPE,
      p_DOC_DATE         IN dpt_customer_changes.val%TYPE,
      p_DOC_DATE_OLD     IN dpt_customer_changes.val_old%TYPE,
      p_DOC_ORGAN        IN dpt_customer_changes.val%TYPE,
      p_DOC_ORGAN_OLD    IN dpt_customer_changes.val_old%TYPE,
      p_PHOTO_DATE       IN dpt_customer_changes.val%TYPE,
      p_PHOTO_DATE_OLD   IN dpt_customer_changes.val_old%TYPE,
      p_ADDRESS_F        IN dpt_customer_changes.val%TYPE,
      p_ADDRESS_F_OLD    IN dpt_customer_changes.val_old%TYPE,
      p_ADDRESS_U        IN dpt_customer_changes.val%TYPE,
      p_ADDRESS_U_OLD    IN dpt_customer_changes.val_old%TYPE);

 function dpt_out_kv(p_deposit_id dpt_deposit.deposit_id%type) return int;

END EBP;
/
CREATE OR REPLACE PACKAGE BODY BARS.EBP 
IS
  g_body_version  CONSTANT VARCHAR2(64)  := 'version 1.27  02.05.2018';
  g_awk_body_defs CONSTANT VARCHAR2(512) := '';

  g_modcode       CONSTANT VARCHAR2(3)   := 'DPT';

  --
  -- ������� ����� ��������� ������
  --
  FUNCTION header_version RETURN VARCHAR2
  IS
  BEGIN
    RETURN 'Package header EBP '||g_header_version||'.'||chr(10)
         ||'AWK definition: '||chr(10)||g_awk_header_defs;
  END header_version;

  --
  -- ������� ����� ��� ������
  --
  FUNCTION body_version RETURN VARCHAR2
  IS
  BEGIN
    RETURN 'Package body EBP '||g_body_version||'.'||chr(10)
         ||'AWK definition: '||chr(10)||g_awk_body_defs;
  END body_version;

  --
  -- ��������� ������ �� ������ �� �������� ����� ���
  --
  procedure CREATE_ACCESS_REQUEST
  ( p_type         in   cust_requests.req_type%type,
    p_trustee      in   cust_requests.trustee_type%type,
    p_rnk          in   cust_requests.trustee_rnk%type,
    p_cert_num     in   cust_requests.certif_num%type,
    p_cert_date    in   cust_requests.certif_date%type,
    p_date_start   in   cust_requests.date_start%type,
    p_date_finish  in   cust_requests.date_finish%type,
    p_access_info  in   XMLType,
    p_reqid        out  cust_requests.req_id%type
  ) is
    l_title        varchar2(30) := 'EBP.create_access_request';
    l_nTmp         number;
    l_bdate        date;
    l_branch       branch.branch%type;
    type t_reqlist is table of cust_req_access%rowtype;
    l_req_access   t_reqlist;
  begin

    l_bdate := gl.bdate;
    l_branch := sys_context('bars_context','user_branch');

    bars_audit.trace( '%s: entry with trustee=%s, rnk=%s, certif_num=%s, certif_date=%s, date_start=%s, date_finish=%s ',
                      l_title, p_trustee, to_char(p_rnk), p_cert_num, to_char(p_cert_date,'dd/mm/yyyy'),
                      to_char(p_date_start,'dd/mm/yyyy'), to_char(p_date_finish,'dd/mm/yyyy') );

    bars_audit.trace( l_title || p_access_info.getStringVal() );

    If (p_type IN (1,2))
    Then -- ����� �� ������ �� ��������

      select null, -- REQ_ID
             to_number(ContractID),
             to_number(Amount,'FM999999990D0099'),
             Flags
        bulk collect
        into l_req_access
        from ( select ExtractValue(column_value, '/row/ContractID')  AS ContractID,
                      ExtractValue(column_value, '/row/Amount')      AS Amount,
                      ExtractValue(column_value, '/row/Flags')       AS Flags
                 from TABLE( XMLSequence( Extract( p_access_info, '/AccessInfo/row' ) ) ) );

      -- �������� �� �������� ����������� ������
      for r in 1..l_req_access.count
      loop

        if ( p_trustee = 'V' )
        then -- ����� �������� ��������

          select max(r.REQ_ID)
            into l_nTmp
            from CUST_REQUESTS   r
           inner join CUST_REQ_ACCESS ra on (RA.REQ_ID = R.REQ_ID)
           where r.REQ_TYPE     = p_type
             and r.REQ_BDATE    = l_bdate
             and r.TRUSTEE_RNK  = p_rnk
             and r.TRUSTEE_TYPE = p_trustee
             and r.REQ_STATE in (1,0)--������� ��������� �������� ������������� �� ����������� ������
             and r.REQ_STATE Is Not Null
             and ra.CONTRACT_ID = l_req_access(r).CONTRACT_ID;

        Else -- ����� �� ����� ���

          select max(r.REQ_ID)
            into l_nTmp
            from CUST_REQUESTS   r
           inner join CUST_REQ_ACCESS ra on (RA.REQ_ID = R.REQ_ID)
           where r.REQ_TYPE     = p_type
	     and r.DATE_FINISH >= l_bdate
             and r.TRUSTEE_RNK  = p_rnk
             and r.TRUSTEE_TYPE = p_trustee
             and r.REQ_STATE in (1,0)--������� ��������� �������� ������������� �� ����������� ������
             and r.REQ_STATE Is Not Null
             and ra.CONTRACT_ID = l_req_access(r).CONTRACT_ID;

        End If;

        If (l_nTmp Is Not Null)
        Then
          -- ����� �� ������ � ��������� ����������� ��� ���� �� �������
          bars_error.raise_nerror( g_modcode, 'REQ_ACCESS_ALREADY_EXISTS', to_char(l_nTmp) );
        Else
          null;
        End If;

        -- ���� ��������
        Case
          When (p_trustee = 'T') Then
            begin
              if (dpt_web.inherited_deal(l_req_access(r).CONTRACT_ID) = 'Y') then
                -- ���������� �����. ��������� �� ����� �� ����� � ����������� ���������
                bars_error.raise_nerror(g_modcode, 'REQ_ACCESS_REGISTRATION_DENIED');
              else
                null;
              end if;
            end;

          When (p_trustee = 'H') Then
            -- �������� ������ ��������
            begin
              If (l_req_access(r).AMOUNT not between 1 and 100) Then
                -- ������ ������ �� ���� � ����� �� 1 �� 100%
                bars_error.raise_nerror(g_modcode, 'INVALID_INHERIT_SHARE_RANGE', to_char(l_req_access(r).AMOUNT));
              Else

                select nvl(sum(inherit_share), 0)
                  into l_nTmp
                  from DPT_INHERITORS
                 where dpt_id = l_req_access(r).CONTRACT_ID;

                If ((l_nTmp + l_req_access(r).AMOUNT) > 100) Then
                  -- �� ������ ��� ������� ����������� ��������� � ������� l_nTmp
                  bars_error.raise_nerror(g_modcode, 'REGISTERED_INHERITORS_EXISTS', to_char(l_nTmp));
                Else
                  null;
                End If;

              End If;
            end;

          Else
            null;
        End Case;

      end loop;

    Else
      -- ����� �� ������ �� ������ �볺���
      l_req_access := null;
    End If;

    -- ��������� ������
    select bars_sqnc.get_nextval('S_CUST_REQUESTS')
      into p_reqid
      from dual;

    insert into CUST_REQUESTS
      ( REQ_ID, REQ_TYPE, TRUSTEE_TYPE, TRUSTEE_RNK, CERTIF_NUM, CERTIF_DATE, DATE_START, DATE_FINISH,
        BRANCH, REQ_BDATE, REQ_CRDATE, REQ_CRUSER, REQ_STATE )
    values
      ( p_reqid, p_type, p_trustee, p_rnk, p_cert_num, p_cert_date, p_date_start, p_date_finish,
        l_branch, l_bdate, sysdate, user_id, null );

    bars_audit.trace( '%s: req created id=%s', l_title, to_char(p_reqid) );

    -- ��������� ������
    If (p_type = 1)
    Then

      ForAll ra in 1..l_req_access.count
      Insert Into BARS.CUST_REQ_ACCESS
        ( REQ_ID, CONTRACT_ID, AMOUNT, FLAGS )
      Values
        ( p_reqid, l_req_access(ra).CONTRACT_ID, l_req_access(ra).AMOUNT, l_req_access(ra).FLAGS );

      bars_audit.trace( '%s: request detail created (inserted %s rows).', l_title, to_char(sql%rowcount) );

    End If;


    -- ��������� ������
    If (p_type = 2)
    Then

      ForAll ra in 1..l_req_access.count
      Insert Into BARS.CUST_REQ_ACCESS
        ( REQ_ID, CONTRACT_ID, AMOUNT, FLAGS )
      Values
        ( p_reqid, l_req_access(ra).CONTRACT_ID, l_req_access(ra).AMOUNT, l_req_access(ra).FLAGS );

      bars_audit.trace( '%s: request detail created (inserted %s rows).', l_title, to_char(sql%rowcount) );

    End If;

  end create_access_request;

  --
  -- ���� ��������� ������ ������������ ���-�����
  -- ���� ��������� / ������ ������ / �������� �����.�����. /
  --
  procedure modify_access_request
  ( p_reqid        in   cust_requests.req_id%type,
    p_cert_num     in   cust_requests.certif_num%type,
    p_cert_date    in   cust_requests.certif_date%type,
    p_date_start   in   cust_requests.date_start%type,
    p_date_finish  in   cust_requests.date_finish%type,
    p_access_info  in   XMLType
  ) is

    l_title        varchar2(30) := 'dpt_web.modify_access_request';
    l_state        cust_requests.req_state%type;
    l_type         cust_requests.req_type%type;
    type t_reqlist is table of cust_req_access%rowtype;
    l_req_access   t_reqlist;
  begin

    bars_audit.trace( '%s: entry with req_id=%s, cert_num=%s, cert_date=%s.',
                      l_title, to_char(p_reqid), p_cert_num, to_char(p_cert_date,'dd/mm/yyyy') );

    update CUST_REQUESTS
       set CERTIF_NUM  = nvl(p_cert_num,   CERTIF_NUM),
           CERTIF_DATE = nvl(p_cert_date, CERTIF_DATE),
           DATE_START  = nvl(p_date_start, DATE_START),
           DATE_FINISH = p_date_finish
     where REQ_ID      = p_reqid
    returning REQ_STATE, REQ_TYPE into l_state, l_type;

    -- ���� ���� �������� �� ��� �������� ������
    If (l_state Is Not Null)
    Then -- ����'������ �������������� � ������ ���� ���
      bars_audit.info( l_title ||': ������ ���������� ������ #' || to_char(p_reqid) ||
                       ' (cert_num='  || p_cert_num                         ||', cert_date='  || to_char(p_cert_date,  'dd.mm.yyyy') ||
                       ', date_start='|| to_char(p_date_start,'dd.mm.yyyy') ||', date_finish='|| to_char(p_date_finish,'dd.mm.yyyy') ||').' );
    End If;

    If (l_type = 1)
    Then -- ����� �� ������ �� ��������

      select null, -- REQ_ID
             to_number(ContractID),
             to_number(Amount,'FM999999990D0099'),
             Flags
        bulk collect
        into l_req_access
        from ( select ExtractValue(column_value, '/row/ContractID')  AS ContractID,
                      ExtractValue(column_value, '/row/Amount')      AS Amount,
                      ExtractValue(column_value, '/row/Flags')       AS Flags
                 from TABLE( XMLSequence( Extract( p_access_info, '/AccessInfo/row' ) ) ) );

      ForAll ra in 1..l_req_access.count
      update CUST_REQ_ACCESS
         set AMOUNT = l_req_access(ra).AMOUNT,
             FLAGS  = l_req_access(ra).FLAGS
       where REQ_ID      = p_reqid
         and CONTRACT_ID = l_req_access(ra).CONTRACT_ID;

      If ((SQL%ROWCOUNT <> 0) AND (l_state Is Not Null))
      Then -- ����'������ �������������� � ������ ���� ���
        bars_audit.info( l_title ||': ������ ���������� ������ #' || to_char(p_reqid) );
      End If;

    End If;

  end modify_access_request;

  --
  -- ������������ ������� �������
  --
  procedure set_request_state
  ( p_reqid        in  cust_requests.req_id%type,
    p_state        in  cust_requests.req_state%type,
    p_comment      in  cust_requests.comments%type  default null
  ) is
    l_title   varchar2(30) := 'dpt_web.set_access_state';
  begin

    bars_audit.trace( '%s: entry with reqid=%s, state=%s, comments=%s.', l_title, to_char(p_reqid), to_char(p_state), p_comment );

    If (p_state = REQUEST_DENIED)
    Then

      If (p_comment Is Null)
      Then
        -- �� ������� ������� ������ � ������
        bars_error.raise_nerror(g_modcode, 'REQ_NOT_VALID_REASON_REJECT');
      End If;

      If (Length(p_comment) < 10)
      Then
        -- ������� ������ ������ ���������� �-�� �������
        bars_error.raise_nerror(g_modcode, 'REQ_NOT_ENOUGH_CHARS_REASONS');
      End If;

    Else
      -- ���������� ���� ��������� ������ �� ������ �� ��������
      null;
    End If;

    if (p_state = 0)
    then
      -- ��������� ���� ��������� ����� �볺����
      update CUST_REQUESTS r
         set r.REQ_STATE   = p_state
       where r.REQ_ID      = p_reqid;
    else
      -- ������� ������
      update CUST_REQUESTS r
         set r.COMMENTS    = p_comment,
             r.REQ_PRCDATE = sysdate,
             r.REQ_PRCUSER = user_id,
             r.REQ_STATE   = p_state
       where r.REQ_ID      = p_reqid;
    end if;

    bars_audit.trace( '%s: exit.', l_title );

  end set_request_state;

  --
  -- ������� ������ (������ / ������� ������� �� ��������)
  --
  procedure process_access_request
  ( p_reqid        in  cust_requests.req_id%type,
    p_reqstate     in  cust_requests.req_state%type,
    p_comment      in  cust_requests.comments%type
  ) is
    l_title        varchar2(30) := 'dpt_web.process_access_request';

    l_rnk          dpt_deposit.rnk%type;
    l_agrid        dpt_agreements.agrmnt_id%type;

    l_req          cust_requests%rowtype;

    type t_par_type is table of cust_req_access%rowtype;
    l_par          t_par_type;

    l_flags        dpt_agreements.denom_count%type;
    l_flags_exp    varchar2(8); -- ������ ���������� ������ �������� �� �� �����������
  begin

    bars_audit.trace( '%s: entry with req_id=%s, req_state=%s.', l_title, to_char(p_reqid), to_char(p_reqstate) );

    If (p_reqstate = REQUEST_ALLOWED)
    then -- ������ ������

      -- ��������� ������ �� ������
      begin

        select *
          into l_req
          from BARS.CUST_REQUESTS
         where req_id = p_reqid;

      exception
        when NO_DATA_FOUND then
          bars_error.raise_nerror( g_modcode, 'GENERAL_ERROR_CODE', '�� �������� ����� �� ������ � ������� #'||to_char(p_reqid) );
      end;

      select *
         bulk collect
         into l_par
         from CUST_REQ_ACCESS
        where req_id = p_reqid;

      -- ������� � ��������� �� ���� ������ �����
      case

        when (l_req.TRUSTEE_TYPE = 'H')
        then -- ��������� ����������

          for h in 1 .. l_par.count
          loop
            dpt_web.inherit_registration( p_dptid        => l_par(h).CONTRACT_ID,
                                          p_inheritor    => l_req.TRUSTEE_RNK,
                                          p_inheritshare => l_par(h).amount,
                                          p_inheritdate  => l_req.date_start,
                                          p_certifnum    => l_req.certif_num,
                                          p_certifdate   => l_req.certif_date );
            bars_audit.trace( '%s: ������������ ��������� (rnk=%s) �� �������� #%s.', l_title, to_char(p_reqid), to_char(l_par(h).CONTRACT_ID) );


            dpt_web.inherit_activation( l_par(h).CONTRACT_ID, l_req.TRUSTEE_RNK);

          end loop;

        when (l_req.TRUSTEE_TYPE = 'T')
        then -- ��������� ���������

          for a in 1 .. l_par.count
          loop

            select d.rnk
              into l_rnk
              from BARS.DPT_DEPOSIT  d
             where d.deposit_id = l_par(a).CONTRACT_ID;

            begin
              l_flags := to_number(l_par(a).FLAGS);
              l_flags_exp := substr(l_flags,4,1) || substr(l_flags,1,1) || '00' || substr(l_flags,2,1) || substr(l_flags,3,1) || '00' ; -- � ��'���� � ����������� ���� �� ����������� ����� ����� ���������� ����������� ������ 4 ���� 0, �� �� ������ ���� ������� ����� �� �����
            exception
              when others then
                l_flags := 0;
                l_flags_exp :='0';
            end;

            dpt_web.create_agreement( l_par(a).CONTRACT_ID, 12, l_rnk, l_req.TRUSTEE_RNK,
                                      null, null, null, null, null,
                                      l_req.date_start, l_req.date_finish, null, null, null,
                                      l_par(a).AMOUNT, l_flags_exp, null, null, null, -13, l_agrid );

            bars_audit.trace( '%s: �������� �� ��� ��������� (rnk=%s) �� �������� #%s ����� ������ #%s.',
                              l_title, to_char(l_req.trustee_rnk), to_char(l_par(a).CONTRACT_ID), to_char(p_reqid) );

          end loop;

        when (l_req.TRUSTEE_TYPE = 'V')
        then -- ������ �� ������� ������� ����� ���
          begin
            bars_audit.trace( '%s: ��������� ������ ������ �� ������� ������� ����� ������ #%s.',
                              l_title, to_char(p_reqid) );
          end;

        -- ������������ ��� ������ �����
        else
          bars_audit.error( l_title ||' ������������ ��� ������ ����� � ����� #'|| to_char(p_reqid) );

      end case;

      -- ������
      set_request_state( p_reqid, REQUEST_ALLOWED, p_comment );

    Else
    -- ��������� � ������

      set_request_state( p_reqid, REQUEST_DENIED, p_comment );

    End If;

    bars_audit.trace( '%s: exit.', l_title);

  end process_access_request;

  ---
  -- �������� ��������� ������ � ��������� ���� (��� ��������� ������ � �볺����)
  ---
  procedure close_access_request
  ( p_rnk          in   cust_requests.trustee_rnk%type,
    p_type         in   cust_requests.req_type%type
  ) is
    l_title        varchar2(30) := 'dpt_web.close_access_request';
    l_branch       cust_requests.branch%type;
  begin

    l_branch := sys_context('bars_context','user_branch');

    bars_audit.trace( '%s: start with rnk = %s, type = %s, branch = %s.', l_title, to_char(p_rnk), to_char(p_type), l_branch );

    update CUST_REQUESTS r
       set r.REQ_STATE = 2
     where r.REQ_TYPE = p_type
       and r.TRUSTEE_TYPE = 'V'
       and r.REQ_STATE = 1
       and r.REQ_BDATE = bankdate
       and r.TRUSTEE_RNK = p_rnk
       and r.BRANCH = l_branch;

  end close_access_request;

  ---
  -- ����� ��������� ������ �� �볺���
  ---
  function get_active_request
  ( p_rnk          in   cust_requests.trustee_rnk%type,
    p_dptid        in   cust_req_access.contract_id%type
  ) return cust_requests.req_id%type
  is
    l_reqid        cust_requests.req_id%type;
    l_branch       cust_requests.branch%type;
  begin

    l_branch := sys_context('bars_context','user_branch');

    if ( p_dptid > 0)
    then
     -- ����� �� ������ �� �������� �� �볺���
      begin
        select r.req_id
          into l_reqid
          from CUST_REQUESTS r
         inner join CUST_REQ_ACCESS ra on (RA.REQ_ID = R.REQ_ID)
         where r.REQ_TYPE  in (1,2) -- COBUSUPABS-3797
           and r.REQ_STATE = 1
           and ((r.REQ_BDATE = bankdate and TRUSTEE_TYPE != 'H') or (r.REQ_BDATE <= bankdate and TRUSTEE_TYPE = 'H'))
           and r.TRUSTEE_RNK = p_rnk
           and ((r.BRANCH = l_branch and TRUSTEE_TYPE != 'H') or TRUSTEE_TYPE = 'H')
           and ra.CONTRACT_ID = p_dptid
           and rownum =1;
      exception
        when no_data_found then
          l_reqid := null;
      end;

    else

      -- ����� �� ������ �� ������ �볺���
      begin
        select r.req_id
          into l_reqid
          from CUST_REQUESTS r
         where r.REQ_TYPE = 0
           and r.REQ_STATE = 1
           and r.REQ_BDATE = bankdate
           and r.TRUSTEE_RNK = p_rnk
           and r.TRUSTEE_TYPE = 'V'
           and r.BRANCH = l_branch;
      exception
        when no_data_found then
          l_reqid := null;
      end;

    end if;

    RETURN l_reqid;

  end get_active_request;

  /* ************************ */
  ---
  -- �������� �� �������� �������� ��������� �� ���
  -- �������� ������ ������� �������� ��������� �� ��� (1- ��� / 0 - �)
  ---
  function HAS_EBP_DEPOSIT_ACCOUNTS
  ( p_ref          in  oper.ref%type
  ) return number
  is
    l_out          number;
  begin

    select case
             when EXISTS ( select 1
                             from DPT_DEPOSIT d
                            where exists ( select 1 from OPLDOK o
                                            inner join DPT_ACCOUNTS da on ( da.accid = o.acc )
                                            where o.ref = p_ref
                                              and da.dptid = d.deposit_id )
                              and d.archdoc_id >= 0 )
             then 1
             else 0
           end
      into l_out
      from DUAL;

    bars_audit.trace('EBP.HAS_EBP_DEPOSIT_ACCOUNTS: exit with %s;', nvl(to_char(l_out),'<null>') );

    return l_out;

  end HAS_EBP_DEPOSIT_ACCOUNTS;

  ---
  -- ������� ������������� ����������� �������� � ��
  ---
  function GET_ARCHIVE_DOCID
  ( p_dptid  in  dpt_deposit.deposit_id%type
  ) return       dpt_deposit.archdoc_id%type
    result_cache relies_on( dpt_deposit )
  is
    l_out        dpt_deposit.archdoc_id%type;
  begin

    begin

      select d.archdoc_id
        into l_out
        from DPT_DEPOSIT d
       where d.deposit_id = p_dptid;

    exception
      when NO_DATA_FOUND then
        l_out := null;
    end;

    return l_out;

  end GET_ARCHIVE_DOCID;

  ---
  -- ������������ ������ �������� �������� ���������, �� ������� �����
  ---
  procedure SET_VERIFIED_STATE
  ( p_rnk    in   person_valid_document.rnk%type,
    p_state  in   person_valid_document.doc_state%type
  ) is
    l_exists      number(1);
  begin

    If ( p_state = 1 )
    Then

      -- �������� �������� ��ﳿ ���������, �� ������� ����� �������� �볺����
      select case
               when EXISTS( select 1 from BARS.EAD_DOCS
                             where RNK = p_rnk
                                and EA_STRUCT_ID in  ( 131, 132, 133, 139, 1311, 1313, 134, 136, 137, 1310, 1316, 139, 138, 1312, 148, 143, 1115, 1324)
                               and SIGN_DATE is Not Null )
               then 1
               else 0
             end
        into l_exists
        from dual;

      if ( l_exists = 0 )
      then

        -- �� �������� ���� ���������, �� ������� ����� �������� �볺���� � ��� %s
        bars_error.raise_nerror( g_modcode, 'DOC_SIGNED_CLIENT_NOT_FOUND', to_char(p_rnk) );

      end if;

    End if;

    update PERSON_VALID_DOCUMENT
       set DOC_STATE = p_state
     where RNK = p_rnk;

    -- ���� ���� �������� ��������� �� "����������"
    If ( (SQL%rowcount = 0) And (p_state = 1) )
    Then

      Insert into PERSON_VALID_DOCUMENT
        ( RNK, DOC_STATE )
      Values
        ( p_rnk, p_state );

    End If;

  end SET_VERIFIED_STATE;

  ---
  -- �������� ������ ����������� ���������, �� ������� �����
  ---
  function GET_VERIFIED_STATE
  ( p_rnk   in   dpt_customer_changes.rnk%type
  ) return       number
  is
    l_state      person_valid_document.doc_state%type;
  begin

    begin
      select DOC_STATE
        into l_state
        from PERSON_VALID_DOCUMENT
       where rnk = p_rnk;
    exception
      when NO_DATA_FOUND then
        l_state := 0;
    end;

    RETURN l_state;

  end GET_VERIFIED_STATE;

  ---
  -- �������� ���������� ������� �� "²������Ͳ���"
  ---
  function CHECK_VIRTUAL_BPK
  ( p_acc  in  accounts.acc%type
  ) return     number
  is
    l_virt     number;
  begin
    select count(1)
      into l_virt
      from W4_ACC
     where acc_pk = p_acc
       and CARD_CODE in ( select CODE from W4_CARD
                           where PRODUCT_CODE in ( select CODE from W4_PRODUCT
                                                    where GRP_CODE = 'VIRTUAL' )
                         )
        or acc_2625D = p_acc; -- "������ �����������"
    RETURN l_virt;

  end CHECK_VIRTUAL_BPK;

  ---
  -- ���������� �������������� ����������� �������� ���������� �� ���
  ---
  procedure SET_ARCHIVE_DOCID
  ( p_dptid  in   dpt_deposit.deposit_id%type,
    p_docid  in   dpt_deposit.archdoc_id%type
  ) is
    title  constant varchar2(60) := 'EBP.set_archive_docid:';
  begin

    bars_audit.trace( '%s entry, dptid=>%s, docid=>%s.', title, to_char(p_dptid), to_char(p_docid) );

    update DPT_DEPOSIT
       set archdoc_id = nvl(p_docid,0)
     where deposit_id = p_dptid
         --and kv in (840, 980, 978) -- ��� ����� ��� ��� ����� (��� ������ �� �����) - �������� � ��'���� � BRSMAIN-2918
     ;
  end SET_ARCHIVE_DOCID;

  --
  -- ����� ������� ��� �����
  --
  function GET_TEMPLATE
  ( p_dptid  in   dpt_deposit.deposit_id%type,
    p_code   in   dpt_vidd_flags.id%type,
    p_fr     in   doc_scheme.fr%type  default 0
  ) return        dpt_vidd_scheme.id%type
  is
    l_code        dpt_vidd_flags.id%type;
    l_template    dpt_vidd_scheme.id%type;
    l_type_id  dpt_vidd_scheme.type_id%type;
    l_vidd     dpt_vidd_scheme.vidd%type;
  begin
    -- ���� ������ ������ ��������� �������� �� ���������� �������� �� ��� ����� ����Բֲ���
    If (p_code = 1) Then
      begin
         select AGRMNT_TYPE
          into l_code
          from DPT_AGREEMENTS
         where dpt_id = p_dptid
           and agrmnt_type  in ( 5,27)
           and agrmnt_state = 1;

        bars_audit.trace( 'EBP.GET_TEMPLATE: �� �������� #%s ������� �� ��� ����� ' ||
        (case
            when l_code =  5 then '�����������.'
            when l_code = 27 then ' ��������� �����.'
            end ), to_char(p_dptid) );

     exception
        when NO_DATA_FOUND then
          l_code := p_code;
      end;
    Else
      l_code := p_code;
    End If;

   begin
    -- ��� �������� �� ���� ��������
    select v.type_id, d.vidd
      into l_type_id, l_vidd
      from dpt_deposit d,
           dpt_vidd v
     where d.deposit_id = p_dptid
       and d.vidd = v.vidd;
    exception
    when no_data_found then
    --���� ������� ������� ������ � �����
    select v.type_id, vd.vidd_code
      into l_type_id, l_vidd
      from V_DPT_PORTFOLIO_ALL_CLOSED vd,
           dpt_vidd v
     where vd.dpt_id = p_dptid
       and vd.vidd_code = v.vidd;
    end;

    -- ����� ������� �� ���� ��������
    begin
      select decode(p_fr, 0, vs.id, vs.id_fr)
        into l_template
        from dpt_vidd_scheme vs
       where vs.type_id = l_type_id
         and vs.vidd = l_vidd
         and vs.flags = l_code;
    exception
      when no_data_found then
        -- ����� ������� �� ���� ��������
        begin
          select decode(p_fr, 0, vs.id, vs.id_fr)
            into l_template
            from DPT_VIDD_SCHEME vs
           where vs.type_id = l_type_id
             and vs.vidd is null
             and vs.flags = l_code;
        exception
          when no_data_found then
            null;
        end;
    end;

    RETURN nvl(l_template, 'EMPTY_TEMPLATE');

  end GET_TEMPLATE;

  --
  -- ������� ������� ���������� �볺���
  --
  function GET_CUSTOMER_IMAGE
  ( p_rnk   in   CUSTOMER_IMAGES.rnk%type,
    p_typ   in   CUSTOMER_IMAGES.type_img%type
  ) return       CUSTOMER_IMAGES.image%type
  is
    l_image      CUSTOMER_IMAGES.image%type;
  begin
    begin
      select IMAGE
        into l_image
        from CUSTOMER_IMAGES
       where RNK = p_rnk
         and TYPE_IMG = p_typ;
    exception
      when NO_DATA_FOUND then
        l_image := null;
    end;

    RETURN l_image;

  end GET_CUSTOMER_IMAGE;

  --
  -- ��������� ��������� ���������� ������� �������� �볺���
  --
  procedure PREVIOUS_SAVE_CUSTOMER_PARAMS
  ( p_rnk          in   dpt_customer_changes.rnk%type,
    p_tag          in   dpt_customer_changes.tag%type,
    p_val          in   dpt_customer_changes.val%type,
    p_val_old      in   dpt_customer_changes.val_old%type default null
  ) is
  begin
    --
     If ((p_tag Is Not Null) and ( p_val <> p_val_old or
                                    (p_val is null and p_val_old is not NULL) or
                                     (p_val is not null and p_val_old is NULL) ))
    Then

      begin

        insert into DPT_CUSTOMER_CHANGES
          ( RNK, TAG, VAL, VAL_OLD )
        values
          ( p_rnk, p_tag, p_val, p_val_old );

      exception
        when DUP_VAL_ON_INDEX then

          update DPT_CUSTOMER_CHANGES
             set val     = p_val,
                 val_old = p_val_old
           where rnk = p_rnk
             and tag = p_tag;
      end;

    Else

      Null;

    End If;

  end PREVIOUS_SAVE_CUSTOMER_PARAMS;

  ---
  -- ������� ��������� ���������� ��� �������� �볺���
  ---
  procedure SAVE_CHANGES_CUSTOMER_PARAMS
  ( p_rnk   in   dpt_customer_changes.rnk%type
  ) is
  begin

    delete from DPT_CUSTOMER_CHANGES
     where rnk = p_rnk;

  end SAVE_CHANGES_CUSTOMER_PARAMS;

     ---
  --����������� ������������ ��� �����
  ---
  procedure send_message_to_back_office
  ( p_url          in   USER_MESSAGES.MSG_TEXT%type
  ) is
   l_req_num varchar2(10);--����� ������ � ����
  begin
        --������� ���� ���� ���������� �����, �� ���� ����� ����� � �������, ���������� ������� �������� ���������� ��� ����� ���������� � url
        select regexp_replace(p_url,'[^0-9]')
        into l_req_num
        from dual;

        begin
        for cur in (
        select T2.ID, T3.LOGNAME from APPLIST t1 , applist_staff t2 , staff$base t3 , web_usermap t4
        where T1.CODEAPP = T2.CODEAPP and t1.codeapp = 'WREQ' and T2.ID = T3.ID and t4.dbuser = t3.logname)
        loop
        --dbms_output.put_line(cur.logname);
        BMS.PUSH_MSG_WEB(cur.logname, '<a href=' || p_url ||' target="_blank"> ������������ ����� �'|| l_req_num || ' </a>',2);
        end loop;
        end;

  end send_message_to_back_office;

  --
  -- ��������� ��������� ���������� ������� �������� �볺���(���)
  --
   PROCEDURE PREVIOUS_SAVE_CUSTOMER_CHANGES (
      p_rnk              IN dpt_customer_changes.rnk%TYPE,
      p_NAME_FULL        IN dpt_customer_changes.val%TYPE,
      p_NAME_FULL_OLD    IN dpt_customer_changes.val_old%TYPE,
      p_CUST_CODE        IN dpt_customer_changes.val%TYPE,
      p_CUST_CODE_OLD    IN dpt_customer_changes.val_old%TYPE,
      p_BIRTH_DATE       IN dpt_customer_changes.val%TYPE,
      p_BIRTH_DATE_OLD   IN dpt_customer_changes.val_old%TYPE,
      p_COUNTRY          IN dpt_customer_changes.val%TYPE,
      p_COUNTRY_OLD      IN dpt_customer_changes.val_old%TYPE,
      p_CELL_PHONE       IN dpt_customer_changes.val%TYPE,
      p_CELL_PHONE_OLD   IN dpt_customer_changes.val_old%TYPE,
      p_WORK_PHONE       IN dpt_customer_changes.val%TYPE,
      p_WORK_PHONE_OLD   IN dpt_customer_changes.val_old%TYPE,
      p_HOME_PHONE       IN dpt_customer_changes.val%TYPE,
      p_HOME_PHONE_OLD   IN dpt_customer_changes.val_old%TYPE,
      p_DOC_TYPE         IN dpt_customer_changes.val%TYPE,
      p_DOC_TYPE_OLD     IN dpt_customer_changes.val_old%TYPE,
      p_DOC_SERIAL       IN dpt_customer_changes.val%TYPE,
      p_DOC_SERIAL_OLD   IN dpt_customer_changes.val_old%TYPE,
      p_DOC_NUMBER       IN dpt_customer_changes.val%TYPE,
      p_DOC_NUMBER_OLD   IN dpt_customer_changes.val_old%TYPE,
      p_DOC_DATE         IN dpt_customer_changes.val%TYPE,
      p_DOC_DATE_OLD     IN dpt_customer_changes.val_old%TYPE,
      p_DOC_ORGAN        IN dpt_customer_changes.val%TYPE,
      p_DOC_ORGAN_OLD    IN dpt_customer_changes.val_old%TYPE,
      p_PHOTO_DATE       IN dpt_customer_changes.val%TYPE,
      p_PHOTO_DATE_OLD   IN dpt_customer_changes.val_old%TYPE,
      p_ADDRESS_F        IN dpt_customer_changes.val%TYPE,
      p_ADDRESS_F_OLD    IN dpt_customer_changes.val_old%TYPE,
      p_ADDRESS_U        IN dpt_customer_changes.val%TYPE,
      p_ADDRESS_U_OLD    IN dpt_customer_changes.val_old%TYPE)
   IS
   BEGIN
      --
      IF (p_rnk IS NOT NULL)
      THEN
         SAVE_CHANGES_CUSTOMER_PARAMS (p_rnk);     --������� ��������� �������

         -- �������� ���
         BEGIN
            PREVIOUS_SAVE_CUSTOMER_PARAMS (p_rnk,
                                           'NAME_FULL',
                                           p_NAME_FULL,
                                           p_NAME_FULL_old);
            PREVIOUS_SAVE_CUSTOMER_PARAMS (p_rnk,
                                           'CUST_CODE',
                                           p_CUST_CODE,
                                           p_CUST_CODE_old);
            PREVIOUS_SAVE_CUSTOMER_PARAMS (p_rnk,
                                           'BIRTH_DATE',
                                           p_BIRTH_DATE,
                                           p_BIRTH_DATE_old);
            PREVIOUS_SAVE_CUSTOMER_PARAMS (p_rnk,
                                           'COUNTRY',
                                           p_COUNTRY,
                                           p_COUNTRY_old);
            PREVIOUS_SAVE_CUSTOMER_PARAMS (p_rnk,
                                           'CELL_PHONE',
                                           p_CELL_PHONE,
                                           p_CELL_PHONE_old);
            PREVIOUS_SAVE_CUSTOMER_PARAMS (p_rnk,
                                           'WORK_PHONE',
                                           p_WORK_PHONE,
                                           p_WORK_PHONE_old);
            PREVIOUS_SAVE_CUSTOMER_PARAMS (p_rnk,
                                           'HOME_PHONE',
                                           p_HOME_PHONE,
                                           p_HOME_PHONE_old);
            PREVIOUS_SAVE_CUSTOMER_PARAMS (p_rnk,
                                           'DOC_TYPE',
                                           p_DOC_TYPE,
                                           p_DOC_TYPE_old);
            PREVIOUS_SAVE_CUSTOMER_PARAMS (p_rnk,
                                           'DOC_SERIAL',
                                           p_DOC_SERIAL,
                                           p_DOC_SERIAL_old);
            PREVIOUS_SAVE_CUSTOMER_PARAMS (p_rnk,
                                           'DOC_NUMBER',
                                           p_DOC_NUMBER,
                                           p_DOC_NUMBER_old);
            PREVIOUS_SAVE_CUSTOMER_PARAMS (p_rnk,
                                           'DOC_DATE',
                                           p_DOC_DATE,
                                           p_DOC_DATE_old);
            PREVIOUS_SAVE_CUSTOMER_PARAMS (p_rnk,
                                           'DOC_ORGAN',
                                           p_DOC_ORGAN,
                                           p_DOC_ORGAN_old);
            PREVIOUS_SAVE_CUSTOMER_PARAMS (p_rnk,
                                           'PHOTO_DATE',
                                           p_PHOTO_DATE,
                                           p_PHOTO_DATE_old);
            PREVIOUS_SAVE_CUSTOMER_PARAMS (p_rnk,
                                           'ADDRESS_F',
                                           p_ADDRESS_F,
                                           p_ADDRESS_F_old);
            PREVIOUS_SAVE_CUSTOMER_PARAMS (p_rnk,
                                           'ADDRESS_U',
                                           p_ADDRESS_U,
                                           p_ADDRESS_U_old);
         END;
      ELSE
         NULL;
      END IF;
   END PREVIOUS_SAVE_CUSTOMER_CHANGES;

  ---
 function dpt_out_kv(p_deposit_id dpt_deposit.deposit_id%type) return int
 is
  l_payval int;
 begin
     begin
      select max(substr(cra.flags, 5,1))
        into l_payval
        from CUST_REQ_ACCESS cra, CUST_REQUESTS cr
       where cr.req_id = cra.req_id
         and cra.contract_id = p_deposit_id
         and cr.req_state = 1
         and cr.REQ_BDATE = bankdate;
     exception when no_data_found then l_payval := 1;
     end;
     return l_payval;
 end;

  --
  -- ������� ������������� ����������� ��������� ���� � ��
  --
  function GET_ARCHIVE_DKBO_DOCID
  ( p_acc                in w4_acc.acc_pk%type,
    p_rnk                in deal.customer_id%type,
    p_struct_code        in ead_struct_codes.id%type,
    p_template           in ead_docs.template_id%type
  ) return number
    result_cache
  is
   l_res number := null;
   l_type_id number;
   l_state_id number;
   p_id number;
  begin

    ead_integration.get_dkbo_settings(l_type_id, l_state_id);
    if (l_type_id is null and l_state_id is null)
     then return null;
    else
        begin
      SELECT d.id  into p_id
        FROM attribute_number_value a
        JOIN deal d
          ON d.id = a.object_id
         AND a.value = p_acc
        JOIN attribute_kind k
          ON k.id = a.attribute_id
         AND k.attribute_code = 'DKBO_ACC_LIST'
        JOIN object_type t
          ON t.id = d.deal_type_id
         AND t.type_code = 'DKBO';  

        exception when no_data_found then p_id := null; return null;
        end;

        begin
         select case when SIGN_DATE is not null then id
                          else -id
                     end
                  into l_res
               from
               (select ed.sign_date, ed.id, ed.crt_date, max(ed.crt_date) over (partition by template_id order by crt_date desc) max_crt_date
                from ead_docs ed
               where ed.AGR_ID = p_id
                 and ED.EA_STRUCT_ID = p_struct_code
                 and ED.RNK = p_rnk
                 and ed.template_id = p_template)
               where crt_date = max_crt_date;
        exception
          when NO_DATA_FOUND then
            bars_audit.error('EBP.GET_ARCHIVE_DKBO_DOCID : �� �������� ������� ����� ��������� ��� ��� = '|| to_char(p_rnk) || ' ����� ���� = ' || to_char(p_id) || ' � ����� �� = ' || p_struct_code || ' � �������� ' || p_template);
            l_res := null;
        end;
       end if;
   return l_res;
  end;
END EBP;
/
 show err;
 
PROMPT *** Create  grants  EBP ***
grant EXECUTE on EBP to BARS_ACCESS_DEFROLE;
grant EXECUTE on EBP to DPT_ROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/ebp.sql =========*** End *** =======
 PROMPT ===================================================================================== 
 