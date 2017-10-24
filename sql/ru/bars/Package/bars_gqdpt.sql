
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_gqdpt.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_GQDPT 
is


    -----------------------------------------------------------------
    -- Constants
    --
    --
    g_headerVersion   constant varchar2(64)  := 'version 1.00 03.11.2006';
    g_headerDefs      constant varchar2(512) := '';



    -----------------------------------------------------------------
    -- HEADER_VERSION()
    --
    --     ������� ���������� ������ � ������� ��������� ������
    --
    --
    --
    function header_version return varchar2;

    -----------------------------------------------------------------
    -- BODY_VERSION()
    --
    --     ������� ���������� ������ � ������� ���� ������
    --
    --
    --
    function body_version return varchar2;


    -----------------------------------------------------------------
    -- CREATE_BALANCE_QUERY()
    --
    --     ��������� �������� ������� �� ��������� ����������/�������
    --     �� ����������� ��������
    --
    --     ���������:
    --
    --         p_querytype        ��� �������
    --                                 0 - �������������� ������
    --                                 1 - ������� ���������
    --                                 2 - ������� ������ � ���������
    --
    --         p_branch           ��� ���������, � ������� ������ �������
    --
    --         p_dptnum           ����� ����������� ��������
    --
    --         p_custfirstname    ��� �������
    --
    --         p_custmiddlename   ��������� �������
    --
    --         p_custlastname     ������� �������
    --
    --         p_custidcode       ����������������� ��� �������
    --
    --         p_custdocserial    ����� ��������� �������
    --
    --         p_custdocnumber    ����� ��������� �������
    --
    --         p_custdocdate      ���� ������ ��������� �������
    --
    --         p_amount           ����� � ������
    --
    --         p_queryid          ������������� ���������� �������
    --
    procedure create_balance_query(
        p_querytype       in   number,
        p_branch          in   branch.branch%type,
        p_dptnum          in   dpt_deposit.nd%type,
        p_custfirstname   in   varchar2,
        p_custmiddlename  in   varchar2,
        p_custlastname    in   varchar2,
        p_custidcode      in   customer.okpo%type,
        p_custdocserial   in   person.ser%type,
        p_custdocnumber   in   person.numdoc%type,
        p_custdocdate     in   person.pdate%type,
        p_amount          in   number,
        p_queryid         out  gq_query.query_id%type );

    -----------------------------------------------------------------
    -- GET_BALANCE_QUERY()
    --
    --     ��������� ��������� ���������� ������� �� ����������� ��������
    --
    --     ���������:
    --
    --         p_queryid          ������������� �������
    --
    --         p_querystatus      ��������� �������
    --                              0 - �� ���������
    --                              1 - ������� ���������
    --                              2 - ��������� � �������
    --
    --         p_errmsg           ����� ������
    --                            ��������������� ��� ��������� 2
    --
    --         p_dptaccnum        ����� ����������� �����
    --
    --         p_dptacccur        ��� ������ ����������� �����
    --
    --         p_dptaccbal        ������� �� ���������� �����
    --
    --         p_dptaccbalavl     ��������� ������� �� ���������� �����
    --
    --         p_intaccnum        ����� ����� ����������� ���������
    --
    --         p_intacccur        ��� ������ ����� ����������� ���������
    --
    --         p_intaccbal        ������� �� ����� ����������� ���������
    --
    --         p_intaccbalavl     ��������� ������� �� ����� �����������
    --                            ���������
    --
    --         p_transfamount     ������������� �� ������� �����
    --
    procedure get_balance_query(
        p_queryid         in   gq_query.query_id%type,
        p_querystatus     out  gq_query.query_status%type,
        p_errmsg          out  varchar2,
        p_dptaccnum       out  accounts.nls%type,
        p_dptacccur       out  accounts.kv%type,
        p_dptaccbal       out  accounts.ostc%type,
        p_dptaccbalavl    out  accounts.ostc%type,
        p_intaccnum       out  accounts.nls%type,
        p_intacccur       out  accounts.kv%type,
        p_intaccbal       out  accounts.ostc%type,
        p_intaccbalavl    out  accounts.ostc%type,
        p_transfamount    out  accounts.ostc%type,
        p_transfdocref    out  oper.ref%type,
        p_branch          out  branch.branch%type,
        p_dptnum          out  dpt_deposit.nd%type,
        p_custfirstname   out  varchar2,
        p_custmiddlename  out  varchar2,
        p_custlastname    out  varchar2,
        p_custidcode      out  customer.okpo%type,
        p_custdocserial   out  person.ser%type,
        p_custdocnumber   out  person.numdoc%type,
        p_custdocdate     out  person.pdate%type,
        p_amount          out   number               );


    -----------------------------------------------------------------
    -- PROCESS_BALANCE_QUERY()
    --
    --     ��������� ��������� ������� �� ����������� ��������
    --
    --     ���������:
    --
    --         p_request          ������
    --
    --         p_status           ��������� ��������� �������
    --                              1 - ������� ���������
    --                              2 - ��������� � �������
    --
    --         p_response         ����� �� ������
    --
    --
    procedure process_balance_query(
        p_request         in   gq_query.request%type,
        p_status          out  gq_query.query_status%type,
        p_response        out  gq_query.response%type      );

end bars_gqdpt;
/

 show err;
 
PROMPT *** Create  grants  BARS_GQDPT ***
grant EXECUTE                                                                on BARS_GQDPT      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_GQDPT      to DPT_ROLE;
grant EXECUTE                                                                on BARS_GQDPT      to START1;
grant EXECUTE                                                                on BARS_GQDPT      to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_gqdpt.sql =========*** End *** 
 PROMPT ===================================================================================== 
 