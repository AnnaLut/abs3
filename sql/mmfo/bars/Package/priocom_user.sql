
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/priocom_user.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.PRIOCOM_USER is
/**
	����� priocom_user �������� ��������� ��� ������ ������������
	��������� ������� �������
*/

G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'version 1.6 08/07/2008';

G_AWK_HEADER_DEFS CONSTANT VARCHAR2(512) := '';

/**
 * header_version - ���������� ������ ��������� ������
 */
function header_version return varchar2;

/**
 * body_version - ���������� ������ ���� ������
 */
function body_version return varchar2;


function unique_session_id return varchar2;


function ref_stub(p_ref in number) return number;

/**
 * allow_open_acc - ���������� ���� ����������/���������� �������� ��������� ������
 */
function allow_open_acc return integer;
/**
 * create_person - ����������� �������-�������
 */
procedure create_person(
	-- output variables
	p_code			    out	integer,			-- ��������� ��� �볺��� � ���
	-- input variables
	p_mfo               in  varchar2,           -- ���
	p_kod_fil			in	integer,			-- ��� ������
	p_ident			    in	varchar2,			-- ��� � ��������� ��������� (�� 14 �������)
	p_lname			    in	varchar2,			-- ������� (�� 64 �������)
	p_fname			    in	varchar2,			-- ��� (�� 64 �������)
	p_sname			    in	varchar2,			-- ��-������� (�� 64 �������)
	p_birthday		    in	date,				-- ���� ����������
	p_birthplace		in	varchar2,			-- ���� ���������� (�� 64 �������)
	p_isStockholder	    in	integer,			-- ������ ���������: 1/0
	p_isVIP			    in	integer,			-- ������ VIP- �볺���: 1/0
	p_isResident		in	integer,			-- ������ ���������: 1/0
	p_regdate			in	date,				-- ���� ��������
	p_debtorclass		in	integer,			-- ���� ������������
	p_gender			in	varchar2,			-- ����� (�/�)
	p_addr			    in	varchar2,			-- ������� ������
	p_k040			    in	varchar2,			-- ����� ���(k040)
	p_k060			    in	varchar2,			-- ��� ��������� ���(k060)
	p_paspdouble		in	varchar2,			-- ����� ���������, �� ������� �����
	p_paspseries		in	varchar2,			-- ���� ���������, �� ������� �����
	p_paspdate		    in	date,				-- ���� ������ ���������, �� ������� �����
	p_paspissuer		in	varchar2			-- ��� ������� ��������, �� ������� �����
);


/**
 * test_create_person
 */
procedure test_create_person;

/**
 * truncate_acc_list - ������� ��������� ������� tmp_priocom_acc_list
 */
procedure truncate_acc_list;

/**
 * truncate_clients - ������� ��������� ������� tmp_priocom_clients
 */
procedure truncate_clients;

/**
 * truncate_clients_jur - ������� ��������� ������� tmp_priocom_clients_jur
 */
procedure truncate_clients_jur;

/**
 * register_clients - ����������� �������� �� ������ �� tmp_priocom_clients
 */
procedure register_clients;

/**
 * register_clients - ����������� �������� ����� �� ������ �� tmp_priocom_clients_jur
 */
procedure register_clients_jur;

/**
 * truncate_accounts - ������� tmp_priocom_accounts
 */
procedure truncate_accounts;

/**
 * truncate_doc_list - ������� ��������� ������� tmp_priocom_doc_list
 */
procedure truncate_doc_list;

/**
 * truncate_nbs_list - ������� ��������� ������� tmp_priocom_nbs_list
 */
procedure truncate_nbs_list;

/**
 * open_accounts - �������� ������
 */
procedure open_accounts;

/**
 * pay_documents - ������ ����������
 */
procedure pay_documents(p_bankdate in date, p_fname in varchar2);

/**
 * final_documents_proc - ��������� ��������� ����� ����������
 * @param p_bankdate - ���� �����
 * @param p_fname    - ��� �����
 */
procedure final_documents_proc(p_bankdate in date, p_fname in varchar2);

/**
 * query_limit_on_deposit - ������ �� ���������/������ ������ �� �������� ���������� ����
 * @param p_mfo         - ��� ���
 * @param p_operdate    - ���� ��������� ������������ ���
 * @param p_currency    - ��� ������
 * @param p_id_cart     - ������������� ���������
 * @param p_account     - ����� ����������� �������
 * @param p_suma        - ���� �� �������� (����� ��� ������), ��� �������� � �������
 * @param p_lname       - �������
 * @param p_fname       - ���
 * @param p_sname       - ��-�������
 * @param p_block       - ������� ����������\�������������: 0 - �����������, 1 � ������������
 */
procedure query_limit_on_deposit(p_mfo in varchar2, p_operdate in date, p_currency in integer,
    p_id_cart in varchar2, p_account in varchar2, p_suma in number,
    p_lname in varchar2, p_fname in varchar2, p_sname in varchar2, p_block in integer);

/**
 * get_ob22 - ���������� ������������ ob22
 */
function get_ob22 return varchar2;

/**
 * get_cl_type - ���������� ��� ������� ��� ����� �����: 3-��,5-���
 */
function get_cl_type return varchar2;

/**
 * proc_limit_on_deposit - ���������/������ ������ �� �������
 */
procedure proc_limit_on_deposit(p_limit_id in integer);

/**
 * remove_dpt_limit_query - ������� ������ �� ������� dpt_limit_query
 */
procedure remove_dpt_limit_query(p_limit_id in integer);

/**
 * export_daily_documents - ������������ ��������� �� ����
 * @param p_export_type - 0-�������� �� ������� ���������� �� p_datebeg,
 *                        1-�������� �� ������� ������� �� p_datebeg,
 *                        2-�������� ��� �� ������ p_datebeg-p_dateend
 * @param p_datebeg - ���� ������ ������� (��� ���� ������ ��� p_export_type in (0,1))
 * @param p_dateend - ���� ��������� �������
 * @param
 */
procedure export_daily_documents(p_export_type in integer, p_datebeg in date, p_dateend in date);

/**
 * insert_acc_list - ������� ������ ������� ������
 * @param p_acc_list - ������ ������� ������ ����� �������
 */
procedure insert_acc_list(p_acc_list in varchar2);

/**
 * insert_nbs_list - ������� ������ ���������� ������� ������
 * @param p_nbs_list - ������ ���������� ������� ������ ����� �������
 */
procedure insert_nbs_list(p_nbs_list in varchar2);

/**
 * insert_doc_list - ������� ��������������� ����������
 * @param p_doc_list - ������ ��������������� ����������
 */
procedure insert_doc_list(p_doc_list in varchar2);

/**
 * prepare_doc_for_revise - ���������� ���������� ��� �������
 * @param p_date - ���������� ����
 */
procedure prepare_doc_for_revise(p_date in date);

/**
 * login_request - ������ �� ���������� � �������� (������ �� ���� �������� �������)
 */
procedure login_request;

end priocom_user;
/
CREATE OR REPLACE PACKAGE BODY BARS.PRIOCOM_USER is
/**
	����� priocom_user �������� ��������� ��� ������ ������������
	��������� ������� �������

*/

G_BODY_VERSION  CONSTANT VARCHAR2(64)  := 'version 1.17 01/12/2008';

G_AWK_BODY_DEFS CONSTANT VARCHAR2(512) := '';

-- ���������� ���������� ������
--============================================================
G_PRC_ISP           INTEGER;     -- ����������� �����
G_PRC_GRP           INTEGER;     -- ������ �����
G_PRC_PRI           VARCHAR2(3); -- ��� ���������� ��������
G_PRC_PRE           VARCHAR2(3); -- ��� ������� ��������
G_OB22              VARCHAR2(2); -- ������������ OB22
G_CL_TYPE           VARCHAR2(1); -- ��� ������� 3-��,5-���
G_PRC_QTM           INTEGER;     -- ����� �������� ��������� � �������
G_ALLOW_OPEN_ACC    INTEGER;     -- ���� ����������/���������� �������� ��������� ������
                                 -- (�������� ��. ��. ������������ ������������ priocom_credit_nbs)
--============================================================

-- ���������� ���������� �� ���������� ��������� � �������
MQ_EMPTY_OR_TIMEOUT_EXCEPTION EXCEPTION;
PRAGMA EXCEPTION_INIT(MQ_EMPTY_OR_TIMEOUT_EXCEPTION, -25228);

/**
 * header_version - ���������� ������ ��������� ������
 */
function header_version return varchar2 is
begin
  return 'Package header PRIOCOM_USER '||G_HEADER_VERSION||'.'||chr(10)
	   ||'AWK definition: '||chr(10)
	   ||G_AWK_HEADER_DEFS;
end header_version;

/**
 * body_version - ���������� ������ ���� ������
 */
function body_version return varchar2 is
begin
  return 'Package body PRIOCOM_USER '||G_BODY_VERSION||'.'||chr(10)
	   ||'AWK definition: '||chr(10)
	   ||G_AWK_BODY_DEFS;
end body_version;

/**
 * load_params - �������� �������� ���������� ������
 */
procedure load_params is
begin
  select to_number(val) into G_PRC_ISP from params where par='PRC_ISP';
  select to_number(val) into G_PRC_GRP from params where par='PRC_GRP';
  select val into G_PRC_PRI from params where par='PRC_PRI';
  select to_number(val) into G_PRC_QTM from params where par='PRC_QTM';
  -- ��-��������� ��������� ��������� ���� ��� ���� �����������
  G_ALLOW_OPEN_ACC := 0;
end load_params;

function ref_stub(p_ref in number) return number is
begin
  priocom_audit.trace('��������� ��������, REF='||p_ref);
  return p_ref;
end ref_stub;

function unique_session_id return varchar2 is
begin
  priocom_audit.trace('unique_session_id() invoked');
  for c in (select odbid from priocom_export_documents where unique_session_id=dbms_session.unique_session_id)
  loop
    priocom_audit.trace('odbid = '||c.odbid);
  end loop;
  return dbms_session.unique_session_id;
end unique_session_id;

function allow_open_acc return integer is
begin
  return G_ALLOW_OPEN_ACC;
end allow_open_acc;

/**
 * reset_bankdate - ������������� ���������� ����
 */
procedure reset_bankdate is
  erm			varchar2 (200);
  ern			constant positive := 015;
  err			exception;
  l_bankdate    date;
  l_is_open     integer;
begin
  l_bankdate := bankdate_g;
  select to_number(val) into l_is_open from params where par='RRPDAY';
  if l_is_open=0 then
    erm := '0001 - ��������� ���� '||to_char(l_bankdate,'DD.MM.YYYY')||' �������. ������ ���������.';
    raise err;
  end if;
  gl.pl_dat(l_bankdate);
exception
    when err then
        priocom_audit.error(erm);
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
    when others then
        declare
            l_sqlerrm varchar2(4000);
        begin
            l_sqlerrm := substr(SQLERRM, 1, 1024);
            priocom_audit.error(substr(l_sqlerrm||chr(10)||dbms_utility.format_error_backtrace,1,3500));
            raise;
        end;
end reset_bankdate;

/**
 * create_person - ����������� �������-�������
 */
procedure create_person(
	-- output variables
	p_code			    out	integer,			-- ��������� ��� �볺��� � ���
	-- input variables
	p_mfo               in  varchar2,           -- ���
	p_kod_fil			in	integer,			-- ��� ������
	p_ident			    in	varchar2,			-- ��� � ��������� ��������� (�� 14 �������)
	p_lname			    in	varchar2,			-- ������� (�� 64 �������)
	p_fname			    in	varchar2,			-- ��� (�� 64 �������)
	p_sname			    in	varchar2,			-- ��-������� (�� 64 �������)
	p_birthday		    in	date,				-- ���� ����������
	p_birthplace		in	varchar2,			-- ���� ���������� (�� 64 �������)
	p_isStockholder	    in	integer,			-- ������ ���������: 1/0
	p_isVIP			    in	integer,			-- ������ VIP- �볺���: 1/0
	p_isResident		in	integer,			-- ������ ���������: 1/0
	p_regdate			in	date,				-- ���� ��������
	p_debtorclass		in	integer,			-- ���� ������������
	p_gender			in	varchar2,			-- ����� (�/�)
	p_addr			    in	varchar2,			-- ������� ������
	p_k040			    in	varchar2,			-- ����� ���(k040)
	p_k060			    in	varchar2,			-- ��� ��������� ���(k060)
	p_paspdouble		in	varchar2,			-- ����� ���������, �� ������� �����
	p_paspseries		in	varchar2,			-- ���� ���������, �� ������� �����
	p_paspdate		    in	date,				-- ���� ������ ���������, �� ������� �����
	p_paspissuer		in	varchar2			-- ��� ������� ��������, �� ������� �����
) is
	erm				    varchar2 (200);
	ern				    constant positive := 001;
	err				    exception;

	l_rnk				customer.rnk%type;
	l_nmk               customer.nmk%type;
	l_nmkk              customer.nmkk%type;
begin
  priocom_audit.trace('��������� ��������� priocom_user.create_person()');
  if p_mfo<>gl.kf then
    erm := '0001 - ��� ������ ������';
    raise err;
  end if;
  -- �������� �� ������� � ���� ������� � ������������ ��������� �����������
  if p_ident is null or p_ident is not null and p_ident='9999999999' then -- �����.��� �� �����
    -- ���� �� ����� � ������ ��������
    begin
	  select rnk into l_rnk from person where ser=p_paspseries and numdoc=p_paspdouble;
	  erm := '0002 - �볺�� � ����������� ������ '||p_paspseries||' '||p_paspdouble||' ��� ����.';
      raise err;
	exception
	  when no_data_found then
	    null;  -- �� ����� � ���������
	  when too_many_rows then
	    begin
	      select rnk into l_rnk from person where ser=p_paspseries and numdoc=p_paspdouble
	      and bday=p_birthday;
	      erm := '0002 - �볺�� � ����������� ������ '||p_paspseries||' '||p_paspdouble||', ����� ���������� '
	        ||to_char(p_birthday,'DD.MM.YYYY')||' ��� ����.';
          raise err;
	    exception
	      when no_data_found then
	        null;  -- ���� �������� �� �������, ������� ������ �����
	      when too_many_rows then
	        erm := '0002 - �볺��� � ����������� ������ '||p_paspseries||' '||p_paspdouble||', ����� ���������� '
	        ||to_char(p_birthday,'DD.MM.YYYY')||' ���� ����� ������. ������� � ��������.';
            raise err;
	    end;
	end;
  else
    begin
      priocom_audit.trace('��� = '||p_ident||', ����� = '||p_paspseries||', ����� = '||p_paspdouble);
      select c.rnk into l_rnk from customer c, person p
      where c.rnk=p.rnk and c.okpo=p_ident and p.ser=p_paspseries and p.numdoc=p_paspdouble;
      erm := '0002 - �볺�� � �����. ����� '||p_ident||' �� ����������� ������ '||p_paspseries||' '||p_paspdouble||
      ' ��� ����.';
      raise err;
    exception
      when no_data_found then
	    null;  -- �� ����� � ���������
	    priocom_audit.trace('�볺��� �� �������� ��������� ���������� �� ��������');
	  when too_many_rows then
	    begin
	      select c.rnk into l_rnk from customer c, person p
	      where c.rnk=p.rnk and c.okpo=p_ident and p.ser=p_paspseries and p.numdoc=p_paspdouble
	      and p.bday=p_birthday;
	      erm := '0002 - �볺�� � ����� '||p_ident||' �� ����������� ������ '||p_paspseries||' '
	        ||p_paspdouble||', ����� ���������� '||to_char(p_birthday,'DD.MM.YYYY')||' ��� ����.';
          raise err;
	    exception
	      when no_data_found then
	        null;  -- ���� �������� �� �������, ������� ������ �����
	      when too_many_rows then
	        erm := '0002 - �볺��� � ����� '||p_ident||' �� ����������� ������ '||p_paspseries||' '
	        ||p_paspdouble||', ����� ���������� '||to_char(p_birthday,'DD.MM.YYYY')
	        ||' ���� ����� ������. ������� � ��������.';
            raise err;
	    end;
    end;
  end if;
  l_nmk := substr(trim(p_lname)||' '||trim(p_fname)||' '||trim(p_sname),1,70);
  l_nmkk := substr(trim(p_lname)||' '||substr(trim(p_fname),1,1)||'.'||substr(trim(p_sname),1,1)||'.',1,35);
  KL.setCustomerAttr(
	  Rnk_           => l_rnk,   		-- Customer number
	  Custtype_      => 3,				-- ��� �������: 1-����, 2-��.����, 3-���.����
	  Nd_            => NULL,		    -- p_cc_id,	-- � ��������
	  Nmk_           => l_nmk,			-- ������������ �������
	  Nmkv_	         => l_nmk,	        -- ������������ ������� �������������
	  Nmkk_          => l_nmkk,	        -- ������������ ������� �������
	  Adr_           => substr(p_addr,1,70),	        -- ����� �������
	  Codcagent_     => case            -- ���������� ����-��������  -- ��������������
	                    when p_isResident=1 then 5
	                    when p_isResident=0 then 6
	                    else NULL
	                    end,
	  Country_       => to_number(p_k040),		-- ������
	  Prinsider_     => to_number(p_k060),	    -- ������� ���������
	  Tgr_           => 2,	            -- ��� ���.�������  2 - ����� ���� (�i�.��i�)
	  Okpo_          => p_ident,	    -- ����
	  Stmt_          => NULL,	        -- ������ �������
	  Sab_           => NULL,	        -- ��.���
	  DATEOn_        => p_regdate,	    -- ���� �����������
	  Taxf_          => NULL,	        -- ��������� ���
	  CReg_          => NULL,	        -- ��� ���.��
	  CDst_          => NULL,	        -- ��� �����.��
	  Adm_           => NULL,	        -- �����.�����
	  RgTax_         => NULL,	        -- ��� ����� � ��
	  RgAdm_         => NULL,	        -- ��� ����� � ���.
	  DATET_         => NULL,		    -- ���� ��� � ��
	  DATEA_         => NULL,		    -- ���� ���. � �������������
	  Ise_           => NULL,	        -- ����. ���. ���������
	  Fs_            => NULL,		    -- ����� �������������
	  Oe_            => NULL,	        -- ������� ���������
	  Ved_           => NULL,	        -- ��� ��. ������������
	  Sed_           => NULL,		    -- ����� ��������������
	  Notes_         => '������������ ��������� ��������',	-- ����������
	  Notesec_       => NULL,	        -- ���������� ��� ������ ������������
	  CRisk_         => p_debtorclass,	        -- ��������� �����
	  Pincode_       => NULL,	        --
	  RnkP_          => NULL,	        -- ���. ����� ��������
	  Lim_           => NULL,	        -- ����� �����
	  NomPDV_        => NULL,	        -- � � ������� ����. ���
	  MB_            => NULL,	 	    -- �������. ������ �������
	  BC_            => NULL,           -- ������� ��������� �����
	  Tobo_          => Tobopack.getTobo, -- ��� �������������� ���������
	  Isp_           => G_PRC_ISP         -- �������� ������� (�����. �����������)
    );
    update customer set nd=rnk where rnk=l_rnk;
    KL.setPersonAttr(
	  Rnk_           => l_rnk,
	  Sex_           => case
	                    when p_gender='�' then 1
	                    when p_gender='�' then 2
	                    else 0
	                    end,
	  Passp_         => 1,  -- �������
	  Ser_           => p_paspseries,
	  Numdoc_        => p_paspdouble,
	  PDate_         => p_paspdate,
	  Organ_         => p_paspissuer,
	  BDay_          => p_birthday,
	  BPlace_        => p_birthplace,
	  TelD_          => NULL,
	  TelW_          => NULL
	);
    kl.setCustomerElement(l_rnk, 'LNAME', p_lname, 0);
    kl.setCustomerElement(l_rnk, 'FNAME', p_fname, 0);
    kl.setCustomerElement(l_rnk, 'MNAME', p_sname, 0);
    if p_isVIP=1 then
        kl.setCustomerElement(l_rnk, 'VIP_K', '1', 0);
    end if;
    priocom_audit.info('������������� ����� �볺��. RNK='||l_rnk||'.');
    p_code := l_rnk;
exception
    when err then
        priocom_audit.error(erm);
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
    when others then
        declare
            l_sqlerrm varchar2(4000);
        begin
            l_sqlerrm := substr(SQLERRM, 1, 1024);
            priocom_audit.error(substr(l_sqlerrm||chr(10)||dbms_utility.format_error_backtrace,1,3500));
            raise;
        end;
end create_person;

/**
 * test_create_person
 */
procedure test_create_person is
  l_code  integer;
begin
  priocom_user.create_person(
	-- output variables
	p_code			    => l_code,			-- ��������� ��� �볺��� � ���
	-- input variables
	p_mfo               => gl.kf,
	p_kod_fil			=> NULL,			-- ��� ������
	p_ident			    => '99999',			-- ��� � ��������� ��������� (�� 14 �������)
	p_lname			    => '����������',			-- ������� (�� 64 �������)
	p_fname			    => '����',			-- ��� (�� 64 �������)
	p_sname			    => '��������',			-- ��-������� (�� 64 �������)
	p_birthday		    => to_date('01.02.1970','DD.MM.YYYY'),				-- ���� ����������
	p_birthplace		=> '������������',			-- ���� ���������� (�� 64 �������)
	p_isStockholder	    => 1,			-- ������ ���������: 1/0
	p_isVIP			    => 1,			-- ������ VIP- �볺���: 1/0
	p_isResident		=> 1,			-- ������ ���������: 1/0
	p_regdate			=> bankdate_g,				-- ���� ��������
	p_debtorclass		=> 2,			-- ���� ������������
	p_gender			=> '�',			-- ����� (�/�)
	p_addr			    => '��. �������������� 12',			-- ������� ������
	p_k040			    => '804',			-- ����� ���(k040)
	p_k060			    => '99',			-- ��� ��������� ���(k060)
	p_paspdouble		=> '012048',			-- ����� ���������, �� ������� �����
	p_paspseries		=> 'CC',			-- ���� ���������, �� ������� �����
	p_paspdate		    => to_date('01.02.1987','DD.MM.YYYY'),				-- ���� ������ ���������, �� ������� �����
	p_paspissuer		=> 'г��������� �� ����'			-- ��� ������� ��������, �� ������� �����
  );
  dbms_output.put_line('������������� �볺��, RNK='||l_code);
end test_create_person;

/**
 * truncate_acc_list - ������� ��������� ������� tmp_priocom_acc_list
 */
procedure truncate_acc_list is
begin
    execute immediate 'truncate table tmp_priocom_acc_list';
    priocom_audit.trace('������� ������� tmp_priocom_acc_list');
end truncate_acc_list;

/**
 * truncate_doc_list - ������� ��������� ������� tmp_priocom_doc_list
 */
procedure truncate_doc_list is
begin
    execute immediate 'truncate table tmp_priocom_doc_list';
    priocom_audit.trace('������� ������� tmp_priocom_doc_list');
end truncate_doc_list;

/**
 * truncate_nbs_list - ������� ��������� ������� tmp_priocom_nbs_list
 */
procedure truncate_nbs_list is
begin
    execute immediate 'truncate table tmp_priocom_nbs_list';
    priocom_audit.trace('������� ������� tmp_priocom_nbs_list');
end truncate_nbs_list;

/**
 * truncate_clients - ������� ��������� ������� tmp_priocom_clients
 */
procedure truncate_clients is
begin
    execute immediate 'truncate table tmp_priocom_clients';
    priocom_audit.trace('������� ������� tmp_priocom_clients');
end truncate_clients;

/**
 * truncate_clients_jur - ������� ��������� ������� tmp_priocom_clients_jur
 */
procedure truncate_clients_jur is
begin
    execute immediate 'truncate table tmp_priocom_clients_jur';
    priocom_audit.trace('������� ������� tmp_priocom_clients_jur');
end truncate_clients_jur;

/**
 * register_clients - ����������� �������� �� ������ �� tmp_priocom_clients
 */
procedure register_clients is
    cursor cls is select * from tmp_priocom_clients for update nowait;
    l_client    tmp_priocom_clients%rowtype;
    l_code      integer;
    l_sqlcode   number;
    l_sqlerrm   varchar2(4000);
begin
    priocom_audit.trace('��������� ��������� ��������� �볺���: register_clients');
    -- ����������������� �� ������ ���. ����. ����
    reset_bankdate;
    open cls;
    loop
        fetch cls into l_client;
        exit when cls%notfound;
        savepoint before_create_person;
        begin
            priocom_user.create_person(
                p_code			    => l_code,
                p_mfo               => l_client.mfo,
	            p_kod_fil			=> l_client.kod_fil,
	            p_ident			    => l_client.ident,
	            p_lname			    => l_client.lname,
	            p_fname			    => l_client.fname,
	            p_sname			    => l_client.sname,
	            p_birthday		    => l_client.birthday,
	            p_birthplace		=> l_client.birthplace,
	            p_isStockholder	    => l_client.isStockholder,
	            p_isVIP			    => l_client.isVIP,
	            p_isResident		=> l_client.isResident,
	            p_regdate			=> l_client.regdate,
	            p_debtorclass		=> l_client.debtorclass,
	            p_gender			=> l_client.gender,
	            p_addr			    => l_client.addr,
	            p_k040			    => l_client.k040,
	            p_k060			    => l_client.k060,
	            p_paspdouble		=> l_client.paspdouble,
	            p_paspseries		=> l_client.paspseries,
	            p_paspdate		    => l_client.paspdate,
	            p_paspissuer		=> l_client.paspissuer
            );
            update tmp_priocom_clients set code=l_code,result=0,message=null
            where current of cls;
        exception when others then
            rollback to before_create_person;
            l_sqlcode := SQLCODE;
            l_sqlerrm := trim(substr(SQLERRM,1,4000));
            update tmp_priocom_clients set code=null,result=l_sqlcode,message=l_sqlerrm
            where current of cls;
            priocom_audit.error('������� ��� ��������� �볺���. ��� '||l_sqlcode||'.'
            ||chr(10)||substr(l_sqlerrm,1,3900));
        end;
    end loop;
    close cls;
end register_clients;

/**
 * create_jur - ����������� ������
 */
procedure create_jur(p_company in tmp_priocom_clients_jur%rowtype, p_code out number) is
    erm				    varchar2 (200);
    ern				    constant positive := 013;
    err				    exception;
    l_rnk               customer.rnk%type;
    l_sed               customer.sed%type;
begin
  priocom_audit.trace('��������� ��������� priocom_user.create_jur()');
  if p_company.mfo<>gl.kf then
    erm := '0001 - ��� ������ ������';
    raise err;
  end if;
  -- �������� �� ������� � ���� ������� � ������������ ��������� �����������
  if p_company.okpo<>'99999' then
    begin
      select rnk into l_rnk from customer where okpo=p_company.okpo and rownum=1;
      erm := '0002 - ������� �� �������� ����='||p_company.okpo||' ��� ���� � ���. RNK='||l_rnk;
      raise err;
    exception when no_data_found then null;
    end;
  end if;
  begin
    select k051 into l_sed from kl_k050 where k050=p_company.k050;
  exception when no_data_found then
    l_sed := null;
  end;
  KL.setCustomerAttr(
	  Rnk_           => l_rnk,   		-- Customer number
	  Custtype_      => 2,				-- ��� �������: 1-����, 2-��.����, 3-���.����
	  Nd_            => NULL,		    -- p_cc_id,	-- � ��������
	  Nmk_           => p_company.name,			-- ������������ �������
	  Nmkv_	         => p_company.name,	        -- ������������ ������� �������������
	  Nmkk_          => p_company.sysname,	        -- ������������ ������� �������
	  Adr_           => p_company.legaladdr,	        -- ����� �������
	  Codcagent_     => case            -- ����������� ����-��������  -- ��������������
	                    when p_company.isResident=1 then 3
	                    when p_company.isResident=0 then 4
	                    else NULL
	                    end,
	  Country_       => case
	                    when p_company.isResident=1 then 804
	                    else NULL
	                    end,		-- ������
	  Prinsider_     => p_company.k060,	    -- ������� ���������
	  Tgr_           => 1,	            -- ��� ���.�������  1 - ����� ������
	  Okpo_          => p_company.okpo,	    -- ����
	  Stmt_          => NULL,	        -- ������ �������
	  Sab_           => NULL,	        -- ��.���
	  DATEOn_        => p_company.regdate,	    -- ���� �����������
	  Taxf_          => p_company.salestaxcode,	        -- ��������� ���
	  CReg_          => p_company.taxregionnum,	        -- ��� ���.��
	  CDst_          => p_company.taxadminnum,	        -- ��� �����.��
	  Adm_           => p_company.pubadminplace,	        -- �����.�����
	  RgTax_         => p_company.taxnum,	        -- ��� ����� � ��
	  RgAdm_         => p_company.pubadminnum,	        -- ��� ����� � ���.
	  DATET_         => p_company.taxregdate,		    -- ���� ��� � ��
	  DATEA_         => p_company.pubadmindate,		    -- ���� ���. � �������������
	  Ise_           => p_company.k070,	        -- ����. ���. ���������
	  Fs_            => p_company.k080,		    -- ����� �������������
	  Oe_            => p_company.k090,	        -- ������� ���������
	  Ved_           => p_company.k110,	        -- ��� ��. ������������
	  Sed_           => l_sed,		    -- ����� ��������������
	  Notes_         => '������������ ��������� ��������',	-- ����������
	  Notesec_       => NULL,	        -- ���������� ��� ������ ������������
	  CRisk_         => p_company.debtorclass,	        -- ��������� �����
	  Pincode_       => NULL,	        --
	  RnkP_          => NULL,	        -- ���. ����� ��������
	  Lim_           => NULL,	        -- ����� �����
	  NomPDV_        => NULL,	        -- � � ������� ����. ���
	  MB_            => case	 	    -- �������. ������ �������
	                    when p_company.smallbis=1 then '1'
	                    when p_company.smallbis=0 then '9'
	                    else null
	                    end,
	  BC_            => NULL,           -- ������� ��������� �����
	  Tobo_          => Tobopack.getTobo, -- ��� �������������� ���������
	  Isp_           => G_PRC_ISP         -- �������� ������� (�����. �����������)
    );
    p_code := l_rnk;
    update customer set nd=rnk where rnk=l_rnk;
    if p_company.isVIP=1 then
        kl.setCustomerElement(l_rnk, 'VIP_K', '1', 0);
    end if;
    kl.setCorpAttr(
      Rnk_           => l_rnk,
      Nmku_          => null,
      Ruk_           => p_company.fiodirector,
      Telr_          => p_company.legaladdr_phone,
      Buh_           => p_company.fiosyn,
      Telb_          => null,
      TelFax_        => p_company.legaladdr_fax,
      EMail_         => p_company.legaladdr_email,
      SealId_        => null
    );
    -- ������ ���������
    kl.setCustomerElement(l_rnk, 'WORKU', p_company.posdirector, 0);
    -- �������� ������
    kl.setCustomerElement(l_rnk, 'FADR ', p_company.addr, 0);
    -- �������� ������
    kl.setCustomerElement(l_rnk, 'ADRP ', p_company.addr, 0);
    -- �������� ������
    kl.setCustomerElement(l_rnk, 'ADRU ', p_company.legaladdr, 0);
    -- email
    kl.setCustomerElement(l_rnk, 'EMAIL', p_company.legaladdr_email, 0);
    -- ������ ������� ������
    kl.setCustomerElement(l_rnk, 'FGIDX', p_company.addr_postind, 0);
    -- ���������� ��� ����������
    kl.setCustomerElement(l_rnk, 'OSN  ', p_company.fiofounder||', ��� '||p_company.okpofounder, 0);
    -- ������ � ������
    priocom_audit.info('������������ �������� �����. RNK='||l_rnk||', ����='||p_company.okpo);
exception
    when err then
        priocom_audit.error(erm);
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
    when others then
        declare
            l_sqlerrm varchar2(4000);
        begin
            l_sqlerrm := substr(SQLERRM, 1, 1024);
            priocom_audit.error(substr(l_sqlerrm||chr(10)||dbms_utility.format_error_backtrace,1,3500));
            raise;
        end;
end create_jur;

/**
 * register_clients_jur - ����������� �������� ����� �� ������ �� tmp_priocom_clients_jur
 */
procedure register_clients_jur is
    cursor cls is select * from tmp_priocom_clients_jur where result is null for update nowait;
    l_client    tmp_priocom_clients_jur%rowtype;
    l_code      integer;
    l_sqlcode   number;
    l_sqlerrm   varchar2(4000);
begin
    priocom_audit.trace('��������� ��������� ��������� �����: register_clients_jur');
    -- ����������������� �� ������ ���. ����. ����
    reset_bankdate;
    open cls;
    loop
        fetch cls into l_client;
        exit when cls%notfound;
        savepoint before_create_jur;
        begin
            priocom_user.create_jur(p_company => l_client, p_code => l_code);
            update tmp_priocom_clients_jur set code=l_code,result=0,message=null
            where current of cls;
        exception when others then
            rollback to before_create_jur;
            l_sqlcode := SQLCODE;
            l_sqlerrm := trim(substr(SQLERRM,1,4000));
            update tmp_priocom_clients_jur set code=null,result=l_sqlcode,message=l_sqlerrm
            where current of cls;
            priocom_audit.error('������� ��� ��������� �������. ��� '||l_sqlcode||'.'
            ||chr(10)||substr(l_sqlerrm,1,3900));
        end;
    end loop;
    close cls;
end register_clients_jur;

/**
 * truncate_accounts - ������� tmp_priocom_accounts
 */
procedure truncate_accounts is
begin
    execute immediate 'truncate table tmp_priocom_accounts';
    priocom_audit.trace('������� ������� tmp_priocom_accounts');
end truncate_accounts;


/**
 * ���������� ������� ���� �������� ������ ��������� ��� ��������� ������
 */
function make_sber_nls(p_acc_row in tmp_priocom_accounts%rowtype) return varchar2 is
   	erm			varchar2 (200);
	ern			constant positive := 007;
	err			exception;

    l_nls       varchar2(14);
    l_mask      nlsmask.mask%type;
begin
    begin
      select mask into l_mask from nlsmask where maskid='PRC_'||p_acc_row.r020;
    exception when no_data_found then
      erm := '1 - ����� ������� �� ������. ���������� = '||p_acc_row.r020;
      raise err;
    end;
    G_OB22      := p_acc_row.ob22;
    G_CL_TYPE   := case
                     when p_acc_row.cl_type=1 then '3'
                     when p_acc_row.cl_type=2 then '5'
                     else '0'
                   end;
    -- ���������� ����������� ���������� ������� �������
    l_nls := F_NEWNLS2(null, 'PRC_'||p_acc_row.r020, p_acc_row.r020, p_acc_row.code, null);
    return l_nls;
exception
    when err then
        priocom_audit.error(erm);
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
end make_sber_nls;

/**
 * open_single_account - �������� �����
 */
procedure open_single_account(p_acc_row in tmp_priocom_accounts%rowtype,
                              p_acc out integer, p_nls out varchar2, p_kv out integer) is
  	erm			varchar2 (200);
	ern			constant positive := 002;
	err			exception;

    l_acc       integer;
    l_nls       varchar2(14);
    l_kv        integer;
    l_ret       number;
    l_nms       varchar2(70);
    l_pap_id    integer;
    l_nmk       customer.nmk%type;
    l_nbs       priocom_credit_nbs.nbs%type;
begin
    if p_acc_row.mfo<>gl.kf then
        erm := '0001 - ��� ������ ������';
        raise err;
    end if;
    if p_acc_row.code is not null then
        begin
            select nmk into l_nmk from customer where rnk=p_acc_row.code;
        exception when no_data_found then
            erm := '0002 - ��� �볺���('||p_acc_row.code||') �� ��������';
            raise err;
        end;
    end if;
    -- ���� ������ ���� � ������� ���������� ����. �������
    begin
      select nbs into l_nbs from priocom_credit_nbs where nbs=p_acc_row.r020;
    exception when no_data_found then
      erm := '0003 - �������� ������ ���������� ��������� ������� �� ����������� '||p_acc_row.r020;
      raise err;
    end;
    -- ���������� ������� ����
    l_nls := make_sber_nls(p_acc_row);
    bars_audit.trace('����������� �������� ����� �������: '||l_nls);
    -- ��������� ����
    l_ret := null;
    -- ������������ � ������������� �����(!! TODO: �������� ��� ��������� ���������, �.�. ������������ �� ���������� !!)

    if p_acc_row.code is not null then
        l_nms := l_nmk;
    elsif p_acc_row.idcontract is not null then
        l_nms := '������� �� ��������� '||p_acc_row.idcontract;
    else
        l_nms := '������� ���������';
    end if;
    op_reg_ex(99, 0, 0, G_PRC_GRP, l_ret, p_acc_row.code, l_nls, p_acc_row.currency, l_nms,
    'ODB', G_PRC_GRP, l_acc);
    -- ����� ��������� ���� � ��������� �����������
    update accounts set blkd=99,blkk=99 where acc=l_acc;
    -- s040 ������� ������ ���� �������� �����
    -- ����� �������� accounts.mdate - ���� �������
    if p_acc_row.s050 is not null then
        update accounts set mdate=p_acc_row.s050 where acc=l_acc;
    end if;
    -- ������� � SPECPARAM
    if  p_acc_row.cfpledge is not null or
        p_acc_row.s080 is not null or
        p_acc_row.s120 is not null or
        p_acc_row.s180 is not null or
        p_acc_row.s181 is not null or
        p_acc_row.s182 is not null or
        p_acc_row.s190 is not null or
        p_acc_row.s200 is not null or
        p_acc_row.r011 is not null or
        p_acc_row.r013 is not null
    then
        insert into specparam(
            acc,
            s031,
            s080,
            s120,
            s180,
            s181,
            s182,
            s190,
            s200,
            r011,
            r013)
        values(
            l_acc,
            p_acc_row.cfpledge,
            p_acc_row.s080,
            p_acc_row.s120,
            p_acc_row.s180,
            p_acc_row.s181,
            p_acc_row.s182,
            p_acc_row.s190,
            p_acc_row.s200,
            p_acc_row.r011,
            p_acc_row.r013
        );
    end if;
    -- ������� � SPECPARAM_INT
    if  p_acc_row.ob22              is not null or
        p_acc_row.idcontract        is not null or
        p_acc_row.creditsupplycode  is not null or
        p_acc_row.kl_kpr            is not null or
        p_acc_row.kod_bizn          is not null or
        p_acc_row.ndog_z            is not null or
        p_acc_row.currency_z        is not null or
        p_acc_row.s040_z            is not null or
        p_acc_row.s050_z            is not null or
        p_acc_row.lsumm             is not null
    then
        insert into specparam_int(
            acc,
            ob22,
            priocom_idcontract,
            priocom_cr_supplycode,
            priocom_kl_kpr,
	        priocom_kod_bizn,
	        priocom_ndog_z,
	        priocom_currency_z,
	        priocom_s040_z,
	        priocom_s050_z,
            priocom_lsumm)
        values(
            l_acc,
            p_acc_row.ob22,
            p_acc_row.idcontract,
            p_acc_row.creditsupplycode,
            p_acc_row.kl_kpr,
            p_acc_row.kod_bizn,
            p_acc_row.ndog_z,
            p_acc_row.currency_z,
            p_acc_row.s040_z,
            p_acc_row.s050_z,
            p_acc_row.lsumm);
    end if;
    -- ����������� %-������
    if p_acc_row.procent is not null then
        -- ���������� ������� ������/������� ��� �����������
        select decode(pap,1,0,1) into l_pap_id from ps where nbs=p_acc_row.r020;
        insert into int_accn(acc,id,metr,basem,basey,freq,s,io,stp_dat,acr_dat)
        values(l_acc, l_pap_id, 0, 0, 0, 1, 0, 0,
        to_date('01.01.1901','DD.MM.YYYY'), to_date('01.01.1901','DD.MM.YYYY'));
        insert into int_ratn(acc,id,bdat,ir)
        values(l_acc, l_pap_id, gl.bDATE, p_acc_row.procent);
    end if;
    -- ����������� out-����������
    priocom_audit.info('³������ ������� (NLS,KV,ACC)=('||l_nls||','||l_kv||','||l_acc||')');
    p_acc := l_acc;
    p_nls := l_nls;
    p_kv  := l_kv;
exception
    when err then
        priocom_audit.error(erm);
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
    when others then
        declare
            l_sqlerrm varchar2(4000);
        begin
            l_sqlerrm := substr(SQLERRM, 1, 1024);
            priocom_audit.error(substr(l_sqlerrm||chr(10)||dbms_utility.format_error_backtrace,1,3500));
            raise;
        end;
end open_single_account;

/**
 * open_accounts - �������� ������
 */
procedure open_accounts is
    cursor c is select * from tmp_priocom_accounts where result is null for update nowait;
    l_acc_row   tmp_priocom_accounts%rowtype;
    l_sqlcode   number;
    l_sqlerrm   varchar2(4000);
    l_acc       integer;
    l_nls       varchar2(14);
    l_kv        integer;
begin
    priocom_audit.trace('��������� ��������� �������� ������� open_accounts');
    G_ALLOW_OPEN_ACC := 1; -- ��������� ���� �������� ������
    -- ����������������� �� ������ ���. ����. ����
    reset_bankdate;
    open c;
    loop
        fetch c into l_acc_row;
        exit when c%notfound;
        savepoint before_open_single_account;
        begin
            open_single_account(l_acc_row, l_acc, l_nls, l_kv);
            update tmp_priocom_accounts set account=l_nls,result=0,message=null
            where current of c;
        exception when others then
            rollback to before_open_single_account;
            l_sqlcode := SQLCODE;
            l_sqlerrm := trim(substr(SQLERRM,1,4000));
            update tmp_priocom_accounts set account=null,result=l_sqlcode,message=l_sqlerrm
            where current of c;
            priocom_audit.error('������� ��� ������� �������. ��� '||l_sqlcode||'.'
            ||chr(10)||substr(l_sqlerrm,1,3900));
        end;
    end loop;
    close c;
end open_accounts;

/**
 * pay_doc - ������ ������ ���������
 */
procedure pay_doc(p_doc in priocom_documents%rowtype, p_ref out integer) is
  	erm			varchar2 (200);
	ern			constant positive := 003;
	err			exception;

    l_acc_a     accounts%rowtype;
    l_acc_b     accounts%rowtype;
    l_new_ref   integer;
    l_cust_a    customer%rowtype;
    l_cust_b    customer%rowtype;
    l_flag      varchar2(1);
    l_vob       vob.vob%type;
    l_sk        oper.sk%type;
    l_stat		fdat.stat%type;
    l_cur_date  date;
begin
    if p_doc.mfo_a<>p_doc.mfo_b or p_doc.mfo_a<>gl.kf then
        erm := '0001 - ���_�, ���_� ������ ������';
        raise err;
    end if;
    begin
        select * into l_acc_a from accounts where kv=p_doc.currency and nls=p_doc.account1;
        select * into l_cust_a from customer where rnk=(select rnk from cust_acc where acc=l_acc_a.acc);
    exception when no_data_found then
        erm := '0002 - ������� �� ��������('||p_doc.currency||','||p_doc.account1||')';
        raise err;
    end;
    begin
        select * into l_acc_b from accounts where kv=p_doc.currency and nls=p_doc.account2;
        select * into l_cust_b from customer where rnk=(select rnk from cust_acc where acc=l_acc_b.acc);
    exception when no_data_found then
        erm := '0003 - ������� �� ��������('||p_doc.currency||','||p_doc.account2||')';
        raise err;
    end;
    if l_acc_a.blkd!=0 then
        erm := '0004 - ������� ('||l_acc_a.kv||','||l_acc_a.nls||') ����������� �� �����';
        raise err;
    end if;
    if l_acc_b.blkk!=0 then
        erm := '0005 - ������� ('||l_acc_b.kv||','||l_acc_b.nls||') ����������� �� ������';
        raise err;
    end if;
    -- ������������ � ����� ��������� �� ����������� ������������ priocom_vob
    begin
      select bars_vob_code into l_vob from priocom_vob where priocom_vob_code=p_doc.dockind;
    exception when no_data_found then
      priocom_audit.info('�����! �� �������� ���������� ���� ��������� � '
      ||p_doc.dockind||'. �������� �� 6 - ��������.');
      l_vob := 6; -- �� ����� ==> ��������
    end;
    -- ������������ � �������� ���������
    l_sk := NULL;
    if substr(l_acc_b.nls,1,4) in ('1001','1002') then -- �� ������� ����� ?
      l_sk := 61;
    end if;

    -- �������� � ����� ������ ���������
    begin
    	select nvl(stat,0) into l_stat from fdat where fdat=p_doc.paydate;
        if l_stat<>0 then
        	erm := '0006 - ������ ���-�� � ��� '||to_char(p_doc.paydate,'DD.MM.YYYY')||' ����������.';
        	raise err;
        end if;
    exception when no_data_found then
    	erm := '0007 - ��������� ���� '||to_char(p_doc.paydate,'DD.MM.YYYY')||' �� � ����������.';
        raise err;
    end;

    -- ��� �������� ��������, ������ ��������� ����, ���� ����
    l_cur_date := gl.bd;
    if gl.bd<>p_doc.paydate then
    	gl.pl_dat(p_doc.paydate);
    end if;
    begin
        gl.ref(l_new_ref);
        gl.in_doc2(
            l_new_ref,
            G_PRC_PRI,
            l_vob,
            substr(to_char(p_doc.docid),1,10),
            SYSDATE,
            gl.bd,
            1,
            p_doc.currency,
            p_doc.docsum,
            p_doc.currency,
            p_doc.docsum,
            p_doc.nationalcursum,
            l_sk,
            p_doc.paydate,
            gl.bd,
            substr(l_acc_a.nms,1,38),
            l_acc_a.nls,
            p_doc.mfo_a,
            substr(l_acc_b.nms,1,38),
            l_acc_b.nls,
            p_doc.mfo_b,
            p_doc.paydestination,
            NULL,
            l_cust_a.okpo,
            l_cust_b.okpo,
            NULL,
            NULL,
            0,
            0
        );
        select substr(flags,38,1) into l_flag from tts where tt=G_PRC_PRI;
        paytt(l_flag, l_new_ref, gl.bd, G_PRC_PRI, 1, p_doc.currency, p_doc.account1, p_doc.docsum,
                                           p_doc.currency, p_doc.account2, p_doc.docsum
        );
        chk.put_visa(l_new_ref,G_PRC_PRI,NULL,0,substr(p_doc.abs_key,3),p_doc.abs_sign,NULL);
        p_ref := l_new_ref;
        -- ���������� ���������� ����
        if l_cur_date<>gl.bd then
			gl.pl_dat(l_cur_date);
        end if;
    exception when others then
    	-- ���������� ���������� ����
        if l_cur_date<>gl.bd then
			gl.pl_dat(l_cur_date);
        end if;
        raise;
    end;
    priocom_audit.info('�������� ��������. FNAME='||p_doc.fname||', ROWNUMBER='||p_doc.rownumber||', REF='||p_ref);
exception
    when err then
        priocom_audit.error(erm);
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
    when others then
        declare
            l_sqlerrm varchar2(4000);
        begin
            l_sqlerrm := substr(SQLERRM, 1, 1024);
            priocom_audit.error(substr(l_sqlerrm||chr(10)||dbms_utility.format_error_backtrace,1,3500));
            raise;
        end;
end pay_doc;

-- ������/��������� ��� � ������� �������� �����������
procedure sign_import(p_bankdate in date, p_fname in varchar2) is
    pragma autonomous_transaction;

  	erm			varchar2 (200);
	ern			constant positive := 006;
	err			exception;

    enqueue_options         dbms_aq.enqueue_options_t;
    dequeue_options         dbms_aq.dequeue_options_t;
    message_properties      dbms_aq.message_properties_t;
    message_handle          RAW(16);
    message                 bars.t_priocom_exchange;
    l_cnt                   number;
    l_total_timeout         number;
    l_start                 number;
    l_current               number;

begin
    -- �������� ��������� � ������� ��� ��������� �������� ����������
    message := bars.t_priocom_exchange('SIGN_IMPORT',
        'BANKDATE='||to_char(p_bankdate,'DD.MM.YYYY')||',FNAME='||p_fname);
    dbms_aq.enqueue(
        queue_name          => 'bars.priocom_inbound_queue',
        enqueue_options     => enqueue_options,
        message_properties  => message_properties,
        payload             => message,
        msgid               => message_handle
    );
    commit;
    priocom_audit.info('����� ��������� '||p_fname||' �� '||to_char(p_bankdate,'DD.MM.YYYY')
    ||' �������� �� ��������/���������� ���');

    -- ������ ���-�� ���-��� � �����, ����� ���������� ����� ��������
    select count(*) into l_cnt from priocom_documents where operdate=p_bankdate and fname=p_fname;
    -- ���� �� ������ (G_PRC_QTM + ���-�� ����������) ������
    l_total_timeout := G_PRC_QTM + l_cnt;
    dequeue_options.wait := l_total_timeout;
    dequeue_options.deq_condition := 'tab.user_data.selector=''SIGN_IMPORT'''
    ||' and tab.user_data.message=''BANKDATE='||to_char(p_bankdate,'DD.MM.YYYY')||',FNAME='||p_fname||'''';
    -- ������� ��������� �� ��������� ������ ������
    begin
        dbms_aq.dequeue(
            queue_name          => 'bars.priocom_outbound_queue',
            dequeue_options     => dequeue_options,
            message_properties  => message_properties,
            payload             => message,
            msgid               => message_handle
        );
        commit;
        priocom_audit.info('����� ��������� '||p_fname||' �� '||to_char(p_bankdate,'DD.MM.YYYY')
        ||' ��������� �������� ��������� ������.');
    exception when MQ_EMPTY_OR_TIMEOUT_EXCEPTION then
        erm := '0001 - ������ ��������� ������ �� �������. ��� ����������: '||l_total_timeout||' ������.';
    end;
    begin
        -- ������ ��������� �� Inbound-�������, ���� ��� �� ���� ���������� �������� �������� �������
        dequeue_options.wait := dbms_aq.no_wait;
        dequeue_options.deq_condition := 'tab.user_data.selector=''SIGN_IMPORT'''
        ||' and tab.user_data.message=''BANKDATE='||to_char(p_bankdate,'DD.MM.YYYY')||',FNAME='||p_fname||'''';
        dbms_aq.dequeue(
            queue_name          => 'bars.priocom_inbound_queue',
            dequeue_options     => dequeue_options,
            message_properties  => message_properties,
            payload             => message,
            msgid               => message_handle
        );
        commit;
        priocom_audit.trace('����� ��������� '||p_fname||' �� '||to_char(p_bankdate,'DD.MM.YYYY')
        ||' �������� �� ������ �����.');
    exception when MQ_EMPTY_OR_TIMEOUT_EXCEPTION then
        null;
    end;
    if erm is not null then
        raise err;
    end if;
exception
    when err then
        priocom_audit.error(erm);
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
    when others then
        declare
            l_sqlerrm varchar2(4000);
        begin
            l_sqlerrm := substr(SQLERRM, 1, 1024);
            priocom_audit.error(substr(l_sqlerrm||chr(10)||dbms_utility.format_error_backtrace,1,3500));
            raise;
        end;
end sign_import;

/**
 * login_request - ������ �� ���������� � �������� (������ �� ���� �������� �������)
 */
procedure login_request is
    pragma autonomous_transaction;

   	erm			varchar2 (200);
	ern			constant positive := 012;
	err			exception;

    enqueue_options         dbms_aq.enqueue_options_t;
    dequeue_options         dbms_aq.dequeue_options_t;
    message_properties      dbms_aq.message_properties_t;
    message_handle          RAW(16);
    message                 bars.t_priocom_exchange;
    l_total_timeout         number;
    l_start                 number;
    l_current               number;
begin
    -- �������� ��������� � ������� ������������� ���������� �� ���������� ��������
    message := bars.t_priocom_exchange('LOGIN_REQUEST', NULL);
    dbms_aq.enqueue(
        queue_name          => 'bars.priocom_inbound_queue',
        enqueue_options     => enqueue_options,
        message_properties  => message_properties,
        payload             => message,
        msgid               => message_handle
    );
    commit;
    priocom_audit.info('����� �� �''������� �������� �� ������� ��������� ������');
    l_total_timeout := G_PRC_QTM;
    dequeue_options.wait := l_total_timeout;
    dequeue_options.deq_condition := 'tab.user_data.selector=''LOGIN_REQUEST''';
    -- ������� ��������� �� ��������� ������ ������
    begin
        dbms_aq.dequeue(
            queue_name          => 'bars.priocom_outbound_queue',
            dequeue_options     => dequeue_options,
            message_properties  => message_properties,
            payload             => message,
            msgid               => message_handle
        );
        commit;
        priocom_audit.info('�������� ������������ �� �''������� �� ������� ��������� ������.');
    exception when MQ_EMPTY_OR_TIMEOUT_EXCEPTION then
        erm := '0001 - ������ ��������� ������ �� �������. ��� ����������: '||l_total_timeout||' ������.';
    end;
    begin
        -- ������ ��������� �� Inbound-�������, ���� ��� �� ���� ���������� �������� �������� �������
        dequeue_options.wait := dbms_aq.no_wait;
        dequeue_options.deq_condition := 'tab.user_data.selector=''LOGIN_REQUEST''';
        dbms_aq.dequeue(
            queue_name          => 'bars.priocom_inbound_queue',
            dequeue_options     => dequeue_options,
            message_properties  => message_properties,
            payload             => message,
            msgid               => message_handle
        );
        commit;
        priocom_audit.trace('����� �� �''������� �������� �� �����.');
    exception when MQ_EMPTY_OR_TIMEOUT_EXCEPTION then
        null;
    end;
    if erm is not null then
        raise err;
    end if;
exception
    when err then
        priocom_audit.error(erm);
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
    when others then
        declare
            l_sqlerrm varchar2(4000);
        begin
            l_sqlerrm := substr(SQLERRM, 1, 1024);
            priocom_audit.error(substr(l_sqlerrm||chr(10)||dbms_utility.format_error_backtrace,1,3500));
            raise;
        end;
end login_request;

/**
 * pay_documents - ������ ����������
 */
procedure pay_documents(p_bankdate in date, p_fname in varchar2) is
  	erm			varchar2 (200);
	ern			constant positive := 011;
	err			exception;

    cursor c_doc is select * from priocom_documents where operdate=p_bankdate and fname=p_fname
                        and ref is null -- ���������, ����� �� ����������������
                        and otm = 1 -- ������ ��������� ������/��������� ���
                        and errmessage is null -- ������ �� ��������� �� ����
                        order by rownumber
                        for update nowait;
    doc         priocom_documents%rowtype;
    l_sqlcode   number;
    l_sqlerrm   varchar2(4000);
    l_ref       integer;
    l_cnt       integer;
begin
    priocom_audit.trace('��������� ��������� ������ ��������� pay_documents. ����� '
        ||p_fname||' �� '||to_char(p_bankdate,'DD.MM.YYYY'));
    -- ����������������� �� ������ ���. ����. ����
    reset_bankdate;
    -- ������/��������� ��� � ������� �������� �����������
    sign_import(p_bankdate, p_fname);
    -- �������� ��������� � �����
    open c_doc;
    l_cnt := 0;
    loop
        fetch c_doc into doc;
        exit when c_doc%notfound;
        l_cnt := l_cnt + 1;
        savepoint before_pay;
        begin
            priocom_user.pay_doc(doc, l_ref);
            update priocom_documents set errmessage=null, ref=l_ref, otm=2 where current of c_doc;
        exception when others then
            rollback to before_pay;
            l_sqlcode := SQLCODE;
            l_sqlerrm := trim(substr(SQLERRM,1,4000));
            update priocom_documents set errmessage=l_sqlerrm, ref=null where current of c_doc;
            priocom_audit.error('������� ��� ����� ���������. ��� '||l_sqlcode||'.'
            ||chr(10)||substr(l_sqlerrm,1,3900));
        end;
    end loop;
    close c_doc;
    -- ���� � ����� ���������� ��������� ���������� �� ����, ����������� ����������
    if l_cnt=0 then
      erm := '0001 - � ����� '||p_fname||' �� '||to_char(p_bankdate,'DD.MM.YYYY')||' ������ ���������, �� ��������� �������';
      raise err;
    end if;
exception
    when err then
        priocom_audit.error(erm);
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
    when others then
        declare
            l_sqlerrm varchar2(4000);
        begin
            l_sqlerrm := substr(SQLERRM, 1, 1024);
            priocom_audit.error(substr(l_sqlerrm||chr(10)||dbms_utility.format_error_backtrace,1,3500));
            raise;
        end;
end pay_documents;

/**
 * final_documents_proc - ��������� ��������� ����� ����������
 * @param p_bankdate - ���� �����
 * @param p_fname    - ��� �����
 */
procedure final_documents_proc(p_bankdate in date, p_fname in varchar2) is
  	erm			varchar2 (200);
	ern			constant positive := 014;
	err			exception;
	l_row       priocom_documents%rowtype;
begin
    priocom_audit.trace('��������� ��������� �������� ������� ����� ���������. ����� '
    ||p_fname||' �� '||to_char(p_bankdate,'DD.MM.YYYY'));
    -- ���� ���� �� ���� ���������� �������� � �����
    begin
        select * into l_row from priocom_documents where operdate=p_bankdate and fname=p_fname
        and ref is not null and otm = 2 and errmessage is null and rownum=1;
    exception when no_data_found then
        -- ���� �����, ������� ��� ������� ���� �����
        delete from priocom_documents where operdate=p_bankdate and fname=p_fname;
        if sql%rowcount=0 then
            erm := '����� '||p_fname||' �� '||to_char(p_bankdate,'DD.MM.YYYY')||' �� ��������';
            raise err;
        end if;
        bars_audit.info('�������� ����� '||p_fname||' �� '||to_char(p_bankdate,'DD.MM.YYYY')||'. ʳ������ ���������: '
        ||sql%rowcount);
    end;
exception
    when err then
        priocom_audit.error(erm);
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
    when others then
        declare
            l_sqlerrm varchar2(4000);
        begin
            l_sqlerrm := substr(SQLERRM, 1, 1024);
            priocom_audit.error(substr(l_sqlerrm||chr(10)||dbms_utility.format_error_backtrace,1,3500));
            raise;
        end;
end final_documents_proc;

/**
 * query_limit_on_deposit - ������ �� ���������/������ ������ �� �������� ���������� ����
 * @param p_mfo         - ��� ���
 * @param p_operdate    - ���� ��������� ������������ ���
 * @param p_currency    - ��� ������
 * @param p_id_cart     - ������������� ���������
 * @param p_account     - ����� ����������� �������
 * @param p_suma        - ���� �� �������� (����� ��� ������), ��� �������� � �������
 * @param p_lname       - �������
 * @param p_fname       - ���
 * @param p_sname       - ��-�������
 * @param p_block       - ������� ����������\�������������: 0 - �����������, 1 � ������������
 */
-- TODO: ���������� �������� �� ����� ������
procedure query_limit_on_deposit(p_mfo in varchar2, p_operdate in date, p_currency in integer,
    p_id_cart in varchar2, p_account in varchar2, p_suma in number,
    p_lname in varchar2, p_fname in varchar2, p_sname in varchar2, p_block in integer) is
  	erm			varchar2 (200);
	ern			constant positive := 004;
	err			exception;

    l_acc       accounts.acc%type;
    l_ostc      accounts.ostc%type;
    l_dptrow    dpt_deposit%rowtype;
begin
    priocom_audit.trace('��������� ��������� ������ �� ���������� ����������� �������');
    begin
        select acc,ostc into l_acc,l_ostc from accounts
        where nls=p_account and kv=p_currency;
    exception when no_data_found then
        erm := '0001 - ������� �� ��������('||p_currency||','||p_account||')';
        raise err;
    end;
    if p_operdate<>gl.bd then
        erm := '0002 - ��������� ���� ������ �� �������';
        raise err;
    end if;
    if p_block not in (0,1) then
        erm := '0003 - �������� ��������� p_block ������ ������';
        raise err;
    end if;
    if p_suma>l_ostc then
        erm := '0004 - ���� ������� �������� ���� ������';
        raise err;
    end if;
    begin
        select * into l_dptrow from dpt_deposit where acc=l_acc;
    exception when no_data_found then
        erm := '0005 - �� �������� ������� � �������� ('||p_currency||','||p_account||')';
        raise err;
    end;
    if l_dptrow.dat_end<=gl.bd then
        erm := '0006 - ������� ��� �������';
        raise err;
    end if;
    insert into dpt_limit_query(mfo,operdate,currency,id_cart,account,suma,lname,fname,sname,block)
    values(p_mfo,p_operdate,p_currency,p_id_cart,p_account,p_suma,p_lname,p_fname,p_sname,p_block);
    priocom_audit.info('�������� ����� �� ��������� ��������: (kv,nls,block,sum)=('
    ||p_currency||','||p_account||','||p_block||','||p_suma||')');
exception
    when err then
        priocom_audit.error(erm);
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
    when others then
        declare
            l_sqlerrm varchar2(4000);
        begin
            l_sqlerrm := substr(SQLERRM, 1, 1024);
            priocom_audit.error(substr(l_sqlerrm||chr(10)||dbms_utility.format_error_backtrace,1,3500));
            raise;
        end;
end query_limit_on_deposit;

/**
 * proc_limit_on_deposit - ���������/������ ������ �� �������
 */
-- TODO: ���������� �������� �� ����� ������
procedure proc_limit_on_deposit(p_limit_id in integer) is

  	erm			varchar2 (200);
	ern			constant positive := 005;
	err			exception;

	l_limit     dpt_limit_query%rowtype;
	l_dptrow    dpt_deposit%rowtype;
	l_vv        v_dpt_limit_query%rowtype;
begin
    begin
        select * into l_limit from dpt_limit_query where limit_id=p_limit_id;
    exception when no_data_found then
        erm := '0001 - �� �������� ����� � '||p_limit_id||' �� ��������� ��������';
        raise err;
    end;
    select * into l_vv from v_dpt_limit_query where limit_id=p_limit_id;
    select * into l_dptrow from dpt_deposit where deposit_id=l_vv.deposit_id;
    -- ������������� ����� �� ����
    if      l_vv.block=0 then
        update accounts set lim=lim-l_vv.suma where acc=l_vv.acc;
    elsif   l_vv.block=1 then
        update accounts set lim=lim+l_vv.suma where acc=l_vv.acc;
    end if;
    -- ����� ������ � ������� ��������� ��������
    insert into dpt_deposit_clos
        (deposit_id, nd, vidd, acc, kv, rnk,
         freq, datz, dat_begin, dat_end,
         mfo_p, nls_p, name_p, okpo_p,
         limit, deposit_cod, comments,
         action_id, actiion_author, "WHEN")
    values
        (l_dptrow.deposit_id, l_dptrow.nd, l_dptrow.vidd, l_dptrow.acc, l_dptrow.kv, l_dptrow.rnk,
         l_dptrow.freq, l_dptrow.datz, l_dptrow.dat_begin, l_dptrow.dat_end,
         l_dptrow.mfo_p, l_dptrow.nls_p, l_dptrow.name_p, l_dptrow.okpo_p,
         l_dptrow.limit, l_dptrow.deposit_cod,
         case
            when l_vv.block=0 then '����������� ��� ������� '||l_vv.suma
            when l_vv.block=1 then '����� ��� ������� '||l_vv.suma
         end,
         case
            when l_vv.block=0 then 15
            when l_vv.block=1 then 16
         end,
         user_id, sysdate);
    if      l_vv.block=0 then
        priocom_audit.info('����������� ��� �� ���������� ������� ('||l_vv.currency||','||l_vv.account
                          ||'), ����='||l_vv.suma);
    elsif   l_vv.block=1 then
        priocom_audit.info('����� ��� � ����������� ������� ('||l_vv.currency||','||l_vv.account
                          ||'), ����='||l_vv.suma);
    end if;
    delete from dpt_limit_query where limit_id=p_limit_id;
exception
    when err then
        priocom_audit.error(erm);
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
    when others then
        declare
            l_sqlerrm varchar2(4000);
        begin
            l_sqlerrm := substr(SQLERRM, 1, 1024);
            priocom_audit.error(substr(l_sqlerrm||chr(10)||dbms_utility.format_error_backtrace,1,3500));
            raise;
        end;
end proc_limit_on_deposit;

/**
 * remove_dpt_limit_query - ������� ������ �� ������� dpt_limit_query
 */
procedure remove_dpt_limit_query(p_limit_id in integer) is
begin
  delete from dpt_limit_query where limit_id=p_limit_id;
  priocom_audit.info('�������� ����� � '||p_limit_id||' �� ��������� ����������� �������');
end remove_dpt_limit_query;

/**
 * get_ob22 - ���������� ������������ ob22
 */
function get_ob22 return varchar2 is
begin
    return G_OB22;
end get_ob22;

/**
 * get_cl_type - ���������� ��� ������� ��� ����� �����: 3-��,5-���
 */
function get_cl_type return varchar2 is
begin
    return G_CL_TYPE;
end get_cl_type;

-- ������/��������� ��� � ������� �������� ����������� (��� �������� ����������)
procedure sign_export(p_us_id in varchar2) is
    pragma autonomous_transaction;

  	erm			varchar2 (200);
	ern			constant positive := 009;
	err			exception;

    enqueue_options         dbms_aq.enqueue_options_t;
    dequeue_options         dbms_aq.dequeue_options_t;
    message_properties      dbms_aq.message_properties_t;
    message_handle          RAW(16);
    message                 bars.t_priocom_exchange;
    l_cnt                   number;
    l_total_timeout         number;
    l_start                 number;
    l_current               number;

begin
    -- ������ ���-�� ���-��� � �����, ����� ���������� ����� ��������
    select count(*) into l_cnt from priocom_export_documents where unique_session_id=p_us_id;
    -- ���� ���������� 0, ������ � ���������, ����� � ����
    if l_cnt=0 then
        return;
    end if;
    -- �������� ��������� � ������� ��� ��������� ���������� �� �������
    message := bars.t_priocom_exchange('SIGN_EXPORT','UNIQUE_SESSION_ID='||p_us_id);
    dbms_aq.enqueue(
        queue_name          => 'bars.priocom_inbound_queue',
        enqueue_options     => enqueue_options,
        message_properties  => message_properties,
        payload             => message,
        msgid               => message_handle
    );
    commit;
    priocom_audit.info('��������� ��� � '||p_us_id||' �������� ��� ���������� ���');

    -- ���� �� ������ (G_PRC_QTM + ���-�� ����������) ������
    l_total_timeout := G_PRC_QTM + l_cnt;
    dequeue_options.wait := l_total_timeout;
    dequeue_options.deq_condition := 'tab.user_data.selector=''SIGN_EXPORT'''
    ||' and tab.user_data.message=''UNIQUE_SESSION_ID='||p_us_id||'''';
    -- ������� ��������� �� ��������� ������ ������
    begin
        dbms_aq.dequeue(
            queue_name          => 'bars.priocom_outbound_queue',
            dequeue_options     => dequeue_options,
            message_properties  => message_properties,
            payload             => message,
            msgid               => message_handle
        );
        commit;
        priocom_audit.info('��������� ��� � '||p_us_id||' �������� �������� ��������� ������.');
    exception when MQ_EMPTY_OR_TIMEOUT_EXCEPTION then
        erm := '0001 - ������ ��������� ������ �� �������. ��� ����������: '||l_total_timeout||' ������.';
    end;
    begin
        -- ������ ��������� �� Inbound-�������, ���� ��� �� ���� ���������� �������� �������� �������
        dequeue_options.wait := dbms_aq.no_wait;
        dequeue_options.deq_condition := 'tab.user_data.selector=''SIGN_EXPORT'''
        ||' and tab.user_data.message=''UNIQUE_SESSION_ID='||p_us_id||'''';
        dbms_aq.dequeue(
            queue_name          => 'bars.priocom_inbound_queue',
            dequeue_options     => dequeue_options,
            message_properties  => message_properties,
            payload             => message,
            msgid               => message_handle
        );
        commit;
        priocom_audit.info('��������� ��� � '||p_us_id||' �������� �� ������ �����.');
    exception when MQ_EMPTY_OR_TIMEOUT_EXCEPTION then
        null;
    end;
    if erm is not null then
        raise err;
    end if;
exception
    when err then
        priocom_audit.error(erm);
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
    when others then
        declare
            l_sqlerrm varchar2(4000);
        begin
            l_sqlerrm := substr(SQLERRM, 1, 1024);
            priocom_audit.error(substr(l_sqlerrm||chr(10)||dbms_utility.format_error_backtrace,1,3500));
            raise;
        end;
end sign_export;

/**
 * export_daily_documents - ������������ ��������� �� ����
 * @param p_export_type - 0-�������� �� ������� ���������� �� p_datebeg,
 *                        1-�������� �� ������� ������� �� p_datebeg,
 *                        2-�������� ��� �� ������ p_datebeg-p_dateend
 * @param p_datebeg - ���� ������ ������� (��� ���� ������ ��� p_export_type in (0,1))
 * @param p_dateend - ���� ��������� �������
 * @param
 */
procedure export_daily_documents(p_export_type in integer, p_datebeg in date, p_dateend in date) is
  	erm			varchar2 (200);
	ern			constant positive := 008;
	err			exception;

	type        opl_cursor is ref cursor;

    c           opl_cursor;
    l_ref       number;
    l_stmt      number;
    dt          opldok%rowtype;
    kt          opldok%rowtype;
    doc         oper%rowtype;
    ex          priocom_export_documents%rowtype;
    us_id       varchar2(24);
    min_stmt    number;
    l_parent    integer;  -- ������� ������������ �������� (1-parent,0-child)
    l_kv_a      accounts.kv%type;
    l_nls_a     accounts.nls%type;
    l_nms_a     varchar2(38);
    l_nls_b     accounts.nls%type;
    l_nms_b     varchar2(38);
    l_okpo_a    customer.okpo%type;
    l_okpo_b    customer.okpo%type;
    l_dk        oper.dk%type;
    l_mb        integer; -- ������� ��������
begin
    priocom_audit.trace('��������� ��������� �������� ��������i�'||CHR(10)||'p_export_type='||p_export_type
    ||CHR(10)||'p_datebeg='||to_char(p_datebeg,'DD.MM.YYYY')||CHR(10)||'p_dateend='||to_char(p_dateend,'DD.MM.YYYY'));

    if p_datebeg<to_date('26/04/2002','DD/MM/YYYY') then
        erm := '0001 - ���� ������� ���_��� ������� ���� �� ����� 26/04/2002, ������ '||to_char(p_datebeg, 'DD/MM/YYYY');
        raise err;
    end if;
    -- ������� ������ ������� �� ������� ������(������� ��������� ������� ������)
    for fd in (select unique unique_session_id from priocom_export_documents)
    loop
      if not dbms_session.is_session_alive(fd.unique_session_id) then
        delete from priocom_export_documents where unique_session_id=fd.unique_session_id;
      end if;
    end loop;
    -- ������ ��������� ����� ������ �� ����������� �������
    us_id := dbms_session.unique_session_id;
    delete from priocom_export_documents where unique_session_id=us_id;
    priocom_audit.trace('unique_session_id = '||us_id);
    -- �������� ������ �� ���������
    if    p_export_type=0 then
        open c for  -- �� ������ ����������
        select unique p.ref, p.stmt from opldok p, accounts a
        where p.fdat=p_datebeg and p.acc=a.acc and p.sos=5
          and a.nbs in (select nbs from tmp_priocom_nbs_list)
          and p.ref not in (select ref from priocom_documents where ref is not null)
          and p.ref not in (select docid from tmp_priocom_doc_list)
          and to_number('1'||lpad(p.ref,14,'0')||lpad(p.stmt,14,'0')) not in
		      (select docid from tmp_priocom_doc_list);
    elsif p_export_type=1 then
        open c for  -- �� ������ �������
        select unique p.ref, p.stmt from opldok p, accounts a
        where p.fdat=p_datebeg and p.acc=a.acc and p.sos=5
          and a.nls in (select nls from tmp_priocom_acc_list)
          and p.ref not in (select ref from priocom_documents where ref is not null)
          and p.ref not in (select docid from tmp_priocom_doc_list)
          and to_number('1'||lpad(p.ref,14,'0')||lpad(p.stmt,14,'0')) not in
		      (select docid from tmp_priocom_doc_list);
    elsif p_export_type=2 then
        open c for  -- ������� ��������� ���������� �� ������
        select unique p.ref, p.stmt from opldok p, accounts a
        where p.fdat between p_datebeg and p_dateend
          and p.acc=a.acc and p.sos=5
          and a.nls in (select nls from tmp_priocom_acc_list);
    else
        erm := '0001 - �������� ��������� p_export_type ������ ���i���: '||p_export_type;
        raise err;
    end if;
    loop
        <<fetch_next>>
        fetch c into l_ref,l_stmt;
        exit when c%notfound;
        priocom_audit.trace('fetch next, l_ref='||l_ref||', l_stmt='||l_stmt);
        -- ������ ��������� ��������
        select * into dt from opldok where ref=l_ref and stmt=l_stmt and dk=0;
        select * into kt from opldok where ref=l_ref and stmt=l_stmt and dk=1;
        priocom_audit.trace('opldok fetched, ref='||l_ref||', stmt='||l_stmt);
        -- ������ ��� ��������
        select * into doc from oper where ref=l_ref;
        priocom_audit.trace('oper fetched, ref='||l_ref);
        -- �������������� ������
        select kv,nls,substr(nms,1,38)
			  into l_kv_a,l_nls_a,l_nms_a from accounts where acc=dt.acc;
        priocom_audit.trace('accounts fetched, nls_a='||l_kv_a);
        select nls,trim(substr(nms,1,38))
                          into l_nls_b,l_nms_b        from accounts where acc=kt.acc;
        priocom_audit.trace('accounts fetched, nls_b='||l_nls_b);
        select nvl(okpo,'99999') into l_okpo_a        from customer c, cust_acc ca
        where c.rnk=ca.rnk and ca.acc=dt.acc;
        priocom_audit.trace('customer fetched, l_okpo_a='||l_okpo_a);
        select nvl(okpo,'99999') into l_okpo_b        from customer c, cust_acc ca
        where c.rnk=ca.rnk and ca.acc=kt.acc;
        priocom_audit.trace('customer fetched, l_okpo_b='||l_okpo_b);
        l_dk := case when doc.dk is not null then doc.dk else 1 end;
        if doc.mfoa is not null and doc.mfob is not null and doc.mfoa<>doc.mfob then
            l_mb := 1;
        else
            l_mb := 0;
        end if;
        -- �������
        ex := null;
        ex.unique_session_id := us_id;
        -- �������: �������� ������������ ��� ��������
        select min(stmt) into min_stmt from opldok where ref=l_ref and tt=doc.tt;
        if l_stmt=min_stmt then
            priocom_audit.trace('stmt=min_stmt='||min_stmt);
            l_parent             := 1;  -- ������������ ��������
            ex.odbid             := l_ref;
            ex.ref               := l_ref;
            ex.stmt              := l_stmt;
            ex.otm               := 0;
            ex.dockind           := case when doc.vob is not null and doc.vob in (1,6)
                                         then doc.vob
                                         else 6
                                    end;
            ex.docstatus         := 5;
            ex.currency          := l_kv_a;
            ex.docdate           := case when doc.datd is not null then doc.datd else dt.fdat end;
            ex.account1          := case
                                    when l_mb=1 and l_dk=1 then doc.nlsa
                                    when l_mb=1 and l_dk=0 then doc.nlsb
                                    else l_nls_a
                                    end;
            ex.account2          := case
                                    when l_mb=1 and l_dk=1 then doc.nlsb
                                    when l_mb=1 and l_dk=0 then doc.nlsa
                                    else l_nls_b
                                    end;
            ex.docsum            := dt.s;
            ex.nationalcursum    := dt.sq;
            ex.mfo_a             := case
                                    when l_mb=1 and l_dk=1 then doc.mfoa
                                    when l_mb=1 and l_dk=0 then doc.mfob
                                    else gl.aMFO
                                    end;
            ex.mfo_b             := case
                                    when l_mb=1 and l_dk=1 then doc.mfob
                                    when l_mb=1 and l_dk=0 then doc.mfoa
                                    else gl.aMFO
                                    end;
            ex.docid             := case when doc.nd is not null then doc.nd else substr(l_ref,1,10) end;
            ex.payer             := case
                                    when l_dk=1 and doc.nam_a is not null then doc.nam_a
                                    when l_dk=0 and doc.nam_b is not null then doc.nam_b
                                    else l_nms_a
                                    end;
            ex.recipient         := case
                                    when l_dk=1 and doc.nam_b is not null then doc.nam_b
                                    when l_dk=0 and doc.nam_a is not null then doc.nam_a
                                    else l_nms_b
                                    end;
            ex.paydestination    := case
                                    when doc.nazn is not null then doc.nazn
                                    else case
                                         when dt.txt is not null then dt.txt
                                         else dt.tt
                                         end
                                    end;
            ex.paydate           := dt.fdat;
            ex.okpo1             := case
                                    when l_dk=1 and doc.id_a is not null then doc.id_a
                                    when l_dk=0 and doc.id_b is not null then doc.id_b
                                    else l_okpo_a
                                    end;
            ex.okpo2             := case
                                    when l_dk=1 and doc.id_b is not null then doc.id_b
                                    when l_dk=0 and doc.id_a is not null then doc.id_a
                                    else l_okpo_b
                                    end;
        else
            priocom_audit.trace('stmt<>min_stmt='||min_stmt);
            l_parent := 0;  -- �������� ��������
            ex.odbid             := to_number('1'||lpad(l_ref,14,'0')||lpad(l_stmt,14,'0'));
            ex.ref               := l_ref;
            ex.stmt              := l_stmt;
            ex.otm               := 0;
            ex.dockind           := 6;
            ex.docstatus         := 5;
            ex.currency          := l_kv_a;
            ex.docdate           := case when doc.datd is not null then doc.datd else dt.fdat end;
            ex.account1          := l_nls_a;
            ex.account2          := l_nls_b;
            ex.docsum            := dt.s;
            ex.nationalcursum    := dt.sq;
            ex.mfo_a             := gl.aMFO;
            ex.mfo_b             := gl.aMFO;
            ex.docid             := case when doc.nd is not null then doc.nd else substr(l_ref,1,10) end;
            ex.payer             := l_nms_a;
            ex.recipient         := l_nms_b;
            ex.paydestination    := case
                                    when dt.txt is not null then dt.txt
                                    else dt.tt
                                    end;
            ex.paydate           := dt.fdat;
            ex.okpo1             := l_okpo_a;
            ex.okpo2             := l_okpo_b;
        end if;
        priocom_audit.trace('insert into priocom_export_documents(), odbid='||ex.odbid);
        insert into priocom_export_documents values ex;
    end loop;
    close c;
    commit;
    priocom_audit.trace('transaction fixed');
    sign_export(us_id);
    commit;
exception
    when err then
        priocom_audit.error(erm);
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
    when others then
        declare
            l_sqlerrm varchar2(4000);
        begin
            l_sqlerrm := substr(SQLERRM, 1, 1024);
            priocom_audit.error(substr(l_sqlerrm||chr(10)||dbms_utility.format_error_backtrace,1,3500));
            raise;
        end;
end export_daily_documents;

/**
 * prepare_doc_for_revise - ���������� ���������� ��� �������
 * @param p_date - ���������� ����
 */
procedure prepare_doc_for_revise(p_date in date) is
  	erm			varchar2 (200);
	ern			constant positive := 010;
	err			exception;

    cursor c is
        select unique p.ref, p.stmt, 5 status from opldok p, accounts a
        where p.fdat=p_date
          and p.acc=a.acc and p.sos=5
          and a.nls in (select nls from tmp_priocom_acc_list)
        union all
        select unique p.ref, p.stmt, 4 status from opldok_back p, accounts a
        where p.fdat=p_date
          and p.acc=a.acc and p.sos=5 and p.tt<>'BAK'
          and a.nls in (select nls from tmp_priocom_acc_list);

    l_ref       number;
    l_stmt      number;
    l_status    number;
    dt          opldok%rowtype;
    kt          opldok%rowtype;
    dt_back     opldok_back%rowtype;
    kt_back     opldok_back%rowtype;
    doc         oper%rowtype;
    ex          tmp_priocom_doc_revise%rowtype;
    l_kv        accounts.kv%type;
    l_nlsa      accounts.nls%type;
    l_nlsb      accounts.nls%type;
    min_stmt    number;
    l_dk        oper.dk%type;
    l_mb        integer; -- ������� ��������
    l_s         number;
begin
    priocom_audit.trace('��������� ��������� ����� ���������'||CHR(10)||'pdate='||to_char(p_date,'DD.MM.YYYY'));
    execute immediate 'truncate table tmp_priocom_doc_revise';
    open c;
    loop
        <<fetch_next>>
        fetch c into l_ref, l_stmt, l_status;
        exit when c%notfound;

        -- ������ ��� ��������
        select * into doc from oper where ref=l_ref;

        -- ������ ��������� �������� � ��. ���.
        if l_status=5 then
            select * into dt from opldok where ref=l_ref and stmt=l_stmt and dk=0;
            select * into kt from opldok where ref=l_ref and stmt=l_stmt and dk=1;
            select kv,nls into l_kv, l_nlsa from accounts where acc=dt.acc;
            select nls into l_nlsb from accounts where acc=kt.acc;
            select min(stmt) into min_stmt from opldok where ref=l_ref and tt=doc.tt;
            l_s := dt.s;
        else
            select * into dt_back from opldok_back where ref=l_ref and stmt=l_stmt and dk=0 and tt<>'BAK';
            select * into kt_back from opldok_back where ref=l_ref and stmt=l_stmt and dk=1 and tt<>'BAK';
            select kv,nls into l_kv, l_nlsa from accounts where acc=dt_back.acc;
            select nls into l_nlsb from accounts where acc=kt_back.acc;
            select min(stmt) into min_stmt from opldok_back where ref=l_ref and tt=doc.tt;
            l_s := dt_back.s;
        end if;

        l_dk := case when doc.dk is not null then doc.dk else 1 end;
        if doc.mfoa is not null and doc.mfob is not null and doc.mfoa<>doc.mfob then
            l_mb := 1;
        else
            l_mb := 0;
        end if;

        ex := NULL;
        ex.ref       := l_ref;
        ex.stmt      := l_stmt;
        ex.status    := l_status;
        ex.currency  := l_kv;
        ex.docsum    := l_s;
        if l_stmt=min_stmt then -- ������������ ��������
            ex.doc_id            := l_ref;
            ex.account1          := case
                                    when l_mb=1 and l_dk=1 then doc.nlsa
                                    when l_mb=1 and l_dk=0 then doc.nlsb
                                    else l_nlsa
                                    end;
            ex.account2          := case
                                    when l_mb=1 and l_dk=1 then doc.nlsb
                                    when l_mb=1 and l_dk=0 then doc.nlsa
                                    else l_nlsb
                                    end;
            ex.mfo_a             := case
                                    when l_mb=1 and l_dk=1 then doc.mfoa
                                    when l_mb=1 and l_dk=0 then doc.mfob
                                    else gl.aMFO
                                    end;
            ex.mfo_b             := case
                                    when l_mb=1 and l_dk=1 then doc.mfob
                                    when l_mb=1 and l_dk=0 then doc.mfoa
                                    else gl.aMFO
                                    end;
        else                    -- �������� ��������
            ex.doc_id    := to_number('1'||lpad(l_ref,14,'0')||lpad(l_stmt,14,'0'));
            ex.account1  := l_nlsa;
            ex.account2  := l_nlsb;
            ex.mfo_a     := gl.aMFO;
            ex.mfo_b     := gl.aMFO;
        end if;
        insert into tmp_priocom_doc_revise values ex;
    end loop; -- cursor c
    close c;
exception
    when err then
        priocom_audit.error(erm);
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
    when others then
        declare
            l_sqlerrm varchar2(4000);
        begin
            l_sqlerrm := substr(SQLERRM, 1, 1024);
            priocom_audit.error(substr(l_sqlerrm||chr(10)||dbms_utility.format_error_backtrace,1,3500));
            raise;
        end;
end prepare_doc_for_revise;

/**
 * insert_acc_list - ������� ������ ������� ������
 * @param p_acc_list - ������ ������� ������ ����� �������
 */
procedure insert_acc_list(p_acc_list in varchar2) is
  i number;
  j number;
begin
  priocom_audit.trace('������ ������ �������� �������: '||substr(p_acc_list,1,3900));
  j   := 1;
  i   := instr(p_acc_list,',');
  while i>0 loop
    insert into tmp_priocom_acc_list(nls) values(trim(substr(p_acc_list,j,i-j)));
    j := i+1;
    i := instr(p_acc_list,',',j);
  end loop;
  insert into tmp_priocom_acc_list(nls) values(trim(substr(p_acc_list,j)));
end insert_acc_list;

/**
 * insert_nbs_list - ������� ������ ���������� ������� ������
 * @param p_nbs_list - ������ ���������� ������� ������ ����� �������
 */
procedure insert_nbs_list(p_nbs_list in varchar2) is
  i number;
  j number;
begin
  priocom_audit.trace('������ ������ ���������� �������: '||substr(p_nbs_list,1,3900));
  j   := 1;
  i   := instr(p_nbs_list,',');
  while i>0 loop
    insert into tmp_priocom_nbs_list(nbs) values(trim(substr(p_nbs_list,j,i-j)));
    j := i+1;
    i := instr(p_nbs_list,',',j);
  end loop;
  insert into tmp_priocom_nbs_list(nbs) values(trim(substr(p_nbs_list,j)));
end insert_nbs_list;

/**
 * insert_doc_list - ������� ��������������� ����������
 * @param p_doc_list - ������ ��������������� ����������
 */
procedure insert_doc_list(p_doc_list in varchar2) is
  i number;
  j number;
begin
  priocom_audit.trace('������ ������ �������������� ���������: '||substr(p_doc_list,1,3900));
  j   := 1;
  i   := instr(p_doc_list,',');
  while i>0 loop
    insert into tmp_priocom_doc_list(docid) values(trim(substr(p_doc_list,j,i-j)));
    j := i+1;
    i := instr(p_doc_list,',',j);
  end loop;
  insert into tmp_priocom_doc_list(docid) values(trim(substr(p_doc_list,j)));
end insert_doc_list;


begin
  load_params;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/priocom_user.sql =========*** End **
 PROMPT ===================================================================================== 
 