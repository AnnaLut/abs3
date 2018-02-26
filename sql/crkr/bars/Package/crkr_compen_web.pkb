create or replace package body crkr_compen_web is

  -- Private constant declarations
  g_body_version constant varchar2(120) := 'Version Body 1.28 21.02.2018 17:33';

  --������� ������
  STATE_COMPEN_OPEN      constant pls_integer := 1; --³������� �����
  STATE_COMPEN_CLOSE     constant pls_integer := 3; --�������� �����
  STATE_COMPEN_BLOCK     constant pls_integer := 99; --�������� ����� ����������
  STATE_COMPEN_BLOCK_BUR constant pls_integer := 91; --���������� � ��'���� � ������
  STATE_COMPEN_BLOCK_HER constant pls_integer := 92; --���������� � ��'���� � ����������� �������� (�� ����� heritage)

  --������� ��������
  STATE_OPER_NEW          constant pls_integer := 0; --������������ ��������
  STATE_OPER_WAIT_CONFIRM constant pls_integer := 10; --����� ������������
  STATE_OPER_COMPLETED    constant pls_integer := 20; --��������� ��������
  STATE_OPER_CANCELED     constant pls_integer := 30; --�������� �������
  STATE_OPER_ERROR        constant pls_integer := 40; --�������� ������� ��/��� ������� �������� ��-�����

  --���� ��������
  TYPE_OPER_PAY_BUR       constant pls_integer := 2; --�������� ������� �� ��������� �� ������
  TYPE_OPER_PAY_DEP       constant pls_integer := 1; --�������� ������� �� ������
  TYPE_OPER_ACT_BUR       constant pls_integer := 6; --�������� ����������� �� ���������
  TYPE_OPER_ACT_DEP       constant pls_integer := 5; --�������� �����������
  TYPE_OPER_ACT_HER       constant pls_integer := 17; --�������� �����������  �� �������
  TYPE_OPER_DEACT_DEP     constant pls_integer := 7; --�������� �������������
  TYPE_OPER_DEACT_BUR     constant pls_integer := 8; --�������� ������������� �� �������
  TYPE_OPER_WDI           constant pls_integer := 3; --���������� ������ � ������ ������
  TYPE_OPER_WDO           constant pls_integer := 4; --�������� ������ �� ����� �����
  TYPE_OPER_CHANGE_D      constant pls_integer := 11; --���� ���������
  TYPE_OPER_CHANGE_DA     constant pls_integer := 12; --���� ���������(����������� �� dbcode)
  TYPE_OPER_CHANGE_DB     constant pls_integer := 13; --���� ���������(����������� �� rnk)
  TYPE_OPER_REQ_DEACT_DEP constant pls_integer := 9;  --����� �� ����� �����������
  TYPE_OPER_REQ_DEACT_BUR constant pls_integer := 10;  --����� �� ����� ����������� �� ���������
  TYPE_OPER_BENEF_ADD     constant pls_integer := 31;  --��������� ����������
  TYPE_OPER_BENEF_MOD     constant pls_integer := 32;  --����������� ����������
  TYPE_OPER_BENEF_DEL     constant pls_integer := 33;  --��������� ����������

  --������� ������ �� �������
  STATE_REG_NEW           constant pls_integer := 0; --������������� ����� ������ (������ ���� �� ������ ��� � �� ���'������ ���������)
  STATE_REG_SEND_OK       constant pls_integer := 1; --���� �������� � ���, ������� �������(���� �� ��������� ������ ���������)
  STATE_REG_SEND_ERR      constant pls_integer := 2; --������� ���� ��������
  STATE_REG_PAY_COMPLETED constant pls_integer := 3; --������ �����������
  STATE_REG_PAY_CANCELED  constant pls_integer := 4; --������ �������
  STATE_REG_PAY_BLOCK     constant pls_integer := 5; --���������� ������ �����������
  STATE_REG_FORM_ERR      constant pls_integer := 6; --������� ��� ���������
  STATE_REG_INITIAL       constant pls_integer := 9; --���������� �������� � ���

  --���� ������ �� �������
  TYPE_REG_PAY_DEP constant pls_integer := 1; --������� �볺���
  TYPE_REG_PAY_BUR constant pls_integer := 2; --������� �볺��� �� ���������

  --����� ��� ������� ��� �� ��������� � ����� ��������
  type t_arr_dbcode_sum is table of pls_integer index by varchar2(32);
  
  G_LOG            constant varchar2(30) := 'crkr_compen_web.';

  -- Function and procedure implementations
  function header_version return varchar2 is
  begin
    return g_header_version;
  end;

  function body_version return varchar2 is
  begin
    return g_body_version;
  end;

  function get_compen(p_id in number) return compen_portfolio%rowtype is
    l_portfolio compen_portfolio%rowtype;
  begin
    select * into l_portfolio from compen_portfolio t where t.id = p_id;
    return l_portfolio;
  exception
    when no_data_found then
      raise_application_error(-20000,
                              '�� �������� �������������� ������� ID: ' || p_id);
  end;

  function b_not_eq(p_old varchar2, p_new varchar2) return boolean as
  begin
    if (p_old != p_new) or (p_old is null and p_new is not null) or (p_old is not null and p_new is null) then
      return true;
      else return false;
    end if;
  end;
  function b_not_eq(p_old date, p_new date) return boolean as
  begin
    if (p_old != p_new) or (p_old is null and p_new is not null) or (p_old is not null and p_new is null) then
      return true;
      else return false;
    end if;
  end;
  function b_not_eq(p_old number, p_new number) return boolean as
  begin
    if (p_old != p_new) or (p_old is null and p_new is not null) or (p_old is not null and p_new is null) then
      return true;
      else return false;
    end if;
  end;

  function analiz_change_client(p_old customer_crkr_update%rowtype, p_new customer_crkr_update%rowtype)
    return varchar2 as
    l_txt               varchar2(2000);
    l_old_country       country.name%type;
    l_new_country       country.name%type;
  begin
    if b_not_eq(p_old.name,p_new.name) then
      l_txt := l_txt||'ϲ� c����: '||p_old.name||' ����: '||p_new.name||chr(13)||chr(10);
    end if;
    if b_not_eq(p_old.inn,p_new.inn) then
      l_txt := l_txt||'��� c����: '||p_old.inn||' ����: '||p_new.inn||chr(13)||chr(10);
    end if;
    if b_not_eq(p_old.id_sex,p_new.id_sex) then
      l_txt := l_txt||'����� c����: '||p_old.id_sex||' ����: '||p_new.id_sex||chr(13)||chr(10);
    end if;
    if b_not_eq(p_old.birth_date,p_new.birth_date) then
      l_txt := l_txt||'���� ���������� c����: '||p_old.birth_date||' ����: '||p_new.birth_date||chr(13)||chr(10);
    end if;
    if b_not_eq(p_old.rezid,p_new.rezid) then
      l_txt := l_txt||'������������ c����: '||p_old.rezid||' ����: '||p_new.rezid||chr(13)||chr(10);
    end if;
    if b_not_eq(p_old.id_doc_type,p_new.id_doc_type) then
      l_txt := l_txt||'��� ��������� c����: '||p_old.id_doc_type||' ����: '||p_new.id_doc_type||chr(13)||chr(10);
    end if;
    if b_not_eq(p_old.ser,p_new.ser) then
      l_txt := l_txt||'���� c����: '||p_old.ser||' ����: '||p_new.ser||chr(13)||chr(10);
    end if;
    if b_not_eq(p_old.numdoc,p_new.numdoc) then
      l_txt := l_txt||'�������� � c����: '||p_old.numdoc||' ����: '||p_new.numdoc||chr(13)||chr(10);
    end if;
    if b_not_eq(p_old.eddr_id,p_new.eddr_id) then
      l_txt := l_txt||'����� � c����: '||p_old.eddr_id||' ����: '||p_new.eddr_id||chr(13)||chr(10);
    end if;
    if b_not_eq(p_old.actual_date,p_new.actual_date) then
      l_txt := l_txt||'ĳ����� �� c����: '||p_old.actual_date||' ����: '||p_new.actual_date||chr(13)||chr(10);
    end if;
    if b_not_eq(p_old.country_id,p_new.country_id) then
      select name into l_old_country from country where country = p_old.country_id;
      select name into l_new_country from country where country = p_new.country_id;
      l_txt := l_txt||'����� c����: '||l_old_country||' ����: '||l_new_country||chr(13)||chr(10);
    end if;
    if b_not_eq(p_old.birth_place,p_new.birth_place) then
      l_txt := l_txt||'̳��� ���������� c����: '||p_old.birth_place||' ����: '||p_new.birth_place||chr(13)||chr(10);
    end if;
    if b_not_eq(p_old.date_of_issue,p_new.date_of_issue) then
      l_txt := l_txt||'���� ������ c����: '||p_old.date_of_issue||' ����: '||p_new.date_of_issue||chr(13)||chr(10);
    end if;
    if b_not_eq(p_old.tel,p_new.tel) then
      l_txt := l_txt||'������� c����: '||p_old.tel||' ����: '||p_new.tel||chr(13)||chr(10);
    end if;
    if b_not_eq(p_old.tel_mob,p_new.tel_mob) then
      l_txt := l_txt||'�������(���) c����: '||p_old.tel_mob||' ����: '||p_new.tel_mob||chr(13)||chr(10);
    end if;
    if b_not_eq(p_old.branch,p_new.branch) then
      l_txt := l_txt||'³������� c����: '||p_old.branch||' ����: '||p_new.branch||chr(13)||chr(10);
    end if;
    if b_not_eq(p_old.notes,p_new.notes) then
      l_txt := l_txt||'������� c����: '||p_old.notes||' ����: '||p_new.notes||chr(13)||chr(10);
    end if;
    if b_not_eq(p_old.date_registry,p_new.date_registry) then
      l_txt := l_txt||'���� ����������� c����: '||p_old.date_registry||' ����: '||p_new.date_registry||chr(13)||chr(10);
    end if;
    if b_not_eq(p_old.zip,p_new.zip) then
      l_txt := l_txt||'������ c����: '||p_old.zip||' ����: '||p_new.zip||chr(13)||chr(10);
    end if;
    if b_not_eq(p_old.domain,p_new.domain) then
      l_txt := l_txt||'������� c����: '||p_old.domain||' ����: '||p_new.domain||chr(13)||chr(10);
    end if;
    if b_not_eq(p_old.region,p_new.region) then
      l_txt := l_txt||'����� c����: '||p_old.region||' ����: '||p_new.region||chr(13)||chr(10);
    end if;
    if b_not_eq(p_old.locality,p_new.locality) then
      l_txt := l_txt||'̳��� c����: '||p_old.locality||' ����: '||p_new.locality||chr(13)||chr(10);
    end if;
    if b_not_eq(p_old.address,p_new.address) then
      l_txt := l_txt||'������ c����: '||p_old.address||' ����: '||p_new.address||chr(13)||chr(10);
    end if;
    if b_not_eq(p_old.mfo,p_new.mfo) then
      l_txt := l_txt||'��� c����: '||p_old.mfo||' ����: '||p_new.mfo||chr(13)||chr(10);
    end if;
    if b_not_eq(p_old.nls,p_new.nls) then
      l_txt := l_txt||'������� c����: '||p_old.nls||' ����: '||p_new.nls||chr(13)||chr(10);
    end if;
    if b_not_eq(p_old.secondary,p_new.secondary) then
      l_txt := l_txt||'����������� c����: '||p_old.secondary||' ����: '||p_new.secondary||chr(13)||chr(10);
    end if;
    if b_not_eq(p_old.okpo,p_new.okpo) then
      l_txt := l_txt||'������ c����: '||p_old.okpo||' ����: '||p_new.okpo||chr(13)||chr(10);
    end if;
    if b_not_eq(p_old.date_val_reg,p_new.date_val_reg) then
      l_txt := l_txt||'���� ����������� c����: '||p_old.date_val_reg||' ����: '||p_new.date_val_reg||chr(13)||chr(10);
    end if;

    return l_txt;
  end;


  function analiz_change_benef(p_compen_id compen_benef.id_compen%type, p_idb compen_benef.idb%type)
    return varchar2 as
    l_txt               varchar2(2000);
    l_old               compen_benef_update%rowtype;
    l_new               compen_benef%rowtype;
    l_old_country       country.name%type;
    l_new_country       country.name%type;
  begin
    select b.* into l_old from compen_benef_update b where b.id_compen = p_compen_id and b.idb = p_idb
                                                       and b.idupd = (select max(prev) from ( select lag(idupd) over (order by idupd) as prev from compen_benef_update
                                                                                               where id_compen = p_compen_id and idb = p_idb));
    select b.* into l_new from compen_benef b where b.id_compen = p_compen_id and b.idb = p_idb;
    if b_not_eq(l_old.code, l_new.code) then
      l_txt := l_txt||'��� ����������: '||l_old.code||' ����: '||l_new.code||chr(13)||chr(10);
    end if;
    if b_not_eq(l_old.fiob, l_new.fiob) then
      l_txt := l_txt||'ϲ� ����������: '||l_old.fiob||' ����: '||l_new.fiob||chr(13)||chr(10);
    end if;
    if b_not_eq(l_old.countryb, l_new.countryb) then
      select name into l_old_country from country where country = l_old.countryb;
      select name into l_new_country from country where country = l_new.countryb;
      l_txt := l_txt||'����� ����������: '||l_old_country||' ����: '||l_new_country||chr(13)||chr(10);
    end if;
    if b_not_eq(l_old.fulladdressb, l_new.fulladdressb) then
      l_txt := l_txt||'������ ����������: '||l_old.fulladdressb||' ����: '||l_new.fulladdressb||chr(13)||chr(10);
    end if;
    if b_not_eq(l_old.icodb, l_new.icodb) then
      l_txt := l_txt||'��� ����������: '||l_old.icodb||' ����: '||l_new.icodb||chr(13)||chr(10);
    end if;
    if b_not_eq(l_old.doctypeb, l_new.doctypeb) then
      l_txt := l_txt||'��� ��������� ����������: '||l_old.doctypeb||' ����: '||l_new.doctypeb||chr(13)||chr(10);
    end if;
    if b_not_eq(l_old.docserialb, l_new.docserialb) then
      l_txt := l_txt||'���� ��������� ����������: '||l_old.docserialb||' ����: '||l_new.docserialb||chr(13)||chr(10);
    end if;
    if b_not_eq(l_old.docnumberb, l_new.docnumberb) then
      l_txt := l_txt||'����� ��������� ����������: '||l_old.docnumberb||' ����: '||l_new.docnumberb||chr(13)||chr(10);
    end if;
    if b_not_eq(l_old.docorgb, l_new.docorgb) then
      l_txt := l_txt||'����� �� ����� �������� ����������: '||l_old.docorgb||' ����: '||l_new.docorgb||chr(13)||chr(10);
    end if;
    if b_not_eq(l_old.docdateb, l_new.docdateb) then
      l_txt := l_txt||'���� ��������� ����������: '||l_old.docdateb||' ����: '||l_new.docdateb||chr(13)||chr(10);
    end if;
    if b_not_eq(l_old.clientsexb, l_new.clientsexb) then
      l_txt := l_txt||'����� ����������: '||l_old.clientsexb||' ����: '||l_new.clientsexb||chr(13)||chr(10);
    end if;
    if b_not_eq(l_old.clientphoneb, l_new.clientphoneb) then
      l_txt := l_txt||'������� ����������: '||l_old.clientphoneb||' ����: '||l_new.clientphoneb||chr(13)||chr(10);
    end if;
    if b_not_eq(l_old.percent, l_new.percent) then
      l_txt := l_txt||'������� ����������: '||l_old.percent||' ����: '||l_new.percent||chr(13)||chr(10);
    end if;

    return l_txt;
  end;

  function f_dbcode(p_doc_type number, p_ser varchar2, p_numdoc varchar2) return varchar2
    is
  begin
    return crkr_compen.f_dbcode(case p_doc_type
                                               when 1 then
                                                1
                                               when 11 then
                                                -1
                                               when 3 then
                                                -2
                                               when 15 then
                                                -4
                                               when 98 then
                                                -3
                                               when 7 then  --�������� � �����(ID-������)
                                                -7
                                               else
                                                p_doc_type
                                             end,
                                             p_ser,
                                             p_numdoc);
  end;

  procedure create_customer(p_name          in varchar2,
                            p_inn           in varchar2,
                            p_sex           in varchar2,
                            p_birth_date    in date,
                            p_rezid         in number,
                            p_doc_type      in integer,
                            p_ser           in varchar2,
                            p_numdoc        in varchar2,
                            p_date_of_issue in date,
                            p_organ         in varchar2,
                            p_eddr_id       in varchar2,
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
                            p_rnk           in out number) is

    l_branch                   branch.branch%type;
    l_branch_name              branch.name%type;
    l_date_doc                 date;
    l_date_registry            date;
    l_date_val_reg             date;
    l_dbcode                   varchar2(32) := f_dbcode(p_doc_type, case when p_doc_type = 7 then p_eddr_id else p_ser end, p_numdoc);
    l_fio                      customer_crkr_update.user_fio%type;
    l_country_id               number(3) := nvl(p_country_id, 804);

    l_customer_crkr_update_old customer_crkr_update%rowtype;
    l_customer_crkr_update_new customer_crkr_update%rowtype;

  begin
    bars_audit.trace('START create_customer '||'p_rnk=>' || p_rnk || ' p_name=>' || p_name || ' p_ser=>'||p_ser||' p_numdoc=>'||p_numdoc);
    if p_sex is null then
      raise_application_error(-20000, '��������� �����');
    end if;
    begin
      select r.branch
        into l_branch
        from compen_clients c, customer r
       where c.rnk = r.rnk
         and substr(r.branch, 1,8) <> substr(sys_context('bars_context', 'user_branch'),1,8)
         and c.dbcode = l_dbcode
         and c.secondary =  p_secondary
         and c.open_cl is not null
         and rownum < 2;
      select b.name
        into l_branch_name
        from branch b
       where b.branch = l_branch;

      raise_application_error(-20000, '�볺�� ������������� � �� ' ||l_branch||' '||l_branch_name);

    exception
      when NO_DATA_FOUND then
        null;
    end;

    if p_rnk is null then
      begin
        select r.branch
          into l_branch
          from compen_clients c, customer r
         where c.rnk = r.rnk
           and c.dbcode = l_dbcode
           and c.secondary =  nvl(p_secondary,0)
           and c.open_cl is not null
           and rownum < 2;
        select b.name
          into l_branch_name
          from branch b
         where b.branch = l_branch;
        raise_application_error(-20000, '�볺��'||case when p_secondary = 1 then '-�����������' else '' end||' ������������� � �� '||l_branch||' '|| l_branch_name);
        exception
        when NO_DATA_FOUND then
          null;
      end;

      else
       begin
        select max(r.branch)
        into l_branch
        from compen_clients c, customer r
       where c.rnk = r.rnk
         and r.rnk <> p_rnk
         and c.dbcode = l_dbcode
         and c.secondary =  p_secondary
         and c.open_cl is not null;
       select b.name
        into l_branch_name
        from branch b
       where b.branch = l_branch;

       raise_application_error(-20000,
                              '�볺�� � ������ ����������� ������ ������������� � �� ' ||l_branch||' '||
                              l_branch_name||' ');
            exception
                    when NO_DATA_FOUND then
                              null;
       end;
    end if;

    l_date_doc := (trunc(p_birth_date) + interval '16' year);

    if (p_date_of_issue < l_date_doc) then
      raise_application_error(-20000,
                              '̳� ����� ���������� �� ����� ������ ��������� ����� 16 ����!');
    end if;

    if p_secondary = 1 and p_okpo is null then
      raise_application_error(-20000,
                              '������ ��� ������!');
    end if;

    kl.setcustomerattr(rnk_       => p_rnk, -- Customer number
                       custtype_  => 3, -- ��� �������: 1-����, 2-��.����, 3-���.����
                       nd_        => null, -- � ��������
                       nmk_       => p_name, -- ������������ �������
                       nmkv_      => f_translate_kmu(p_name), -- ������������ ������� �������������
                       nmkk_      => null, -- ������������ ������� �������
                       adr_       => substr(p_domain || ' ' || p_region || ' ' ||
                                            p_locality || ' ' || p_address,
                                            1,
                                            70), -- ����� �������
                       codcagent_ => case
                                       when p_rezid = 1 then
                                        5
                                       else
                                        6
                                     end, -- ��������������
                       country_   => l_country_id, -- ������
                       prinsider_ => 99, -- ������� ���������
                       tgr_       => 2, -- ��� ���.�������
                       okpo_      => trim(p_inn), -- ����
                       stmt_      => 0, -- ������ �������
                       sab_       => null, -- ��.���
                       dateon_    => trunc(sysdate), -- ���� �����������
                       taxf_      => null, -- ��������� ���
                       creg_      => -1, -- ��� ���.��
                       cdst_      => -1, -- ��� �����.��
                       adm_       => null, -- �����.�����
                       rgtax_     => null, -- ��� ����� � ��
                       rgadm_     => null, -- ��� ����� � ���.
                       datet_     => null, -- ���� ��� � ��
                       datea_     => null, -- ���� ���. � �������������
                       ise_       => null, -- ����. ���. ���������
                       fs_        => null, -- ����� �������������
                       oe_        => null, -- ������� ���������
                       ved_       => null, -- ��� ��. ������������
                       sed_       => null, -- ����� ��������������
                       notes_     => p_notes, -- ����������
                       notesec_   => null, -- ���������� ��� ������ ������������
                       crisk_     => 1, -- ��������� �����
                       pincode_   => null, --
                       rnkp_      => null, -- ���. ����� ��������
                       lim_       => null, -- ����� �����
                       nompdv_    => null, -- � � ������� ����. ���
                       mb_        => 9, -- �������. ������ �������
                       bc_        => 0, -- ������� ��������� �����
                       tobo_      => p_branch, -- ��� �������������� ���������
                       isp_       => null -- �������� ������� (�����. �����������)
                       );

    kl.setcustomeraddressbyterritory(rnk_         => p_rnk,
                                     typeid_      => 1,
                                     country_     => l_country_id,
                                     zip_         => p_zip,
                                     domain_      => p_domain,
                                     region_      => p_region,
                                     locality_    => p_locality,
                                     address_     => p_address,
                                     territoryid_ => null);

    kl.setpersonattr(rnk_    => p_rnk,
                     sex_    => p_sex,
                     passp_  => p_doc_type,
                     ser_    => p_ser,
                     numdoc_ => p_numdoc,
                     pdate_  => p_date_of_issue,
                     organ_  => p_organ,
                     bday_   => p_birth_date,
                     bplace_      => p_bplace,
                     teld_   => p_tel,
                     telw_   => null,
                     telm_   => p_tel_mob,
                     actual_date_ => p_actual_date,
                     eddr_id_     => p_eddr_id
                     );

    merge into compen_clients t
    using (select p_rnk rnk,
                  p_name name,
                  l_dbcode p_dbcode,
                  p_mfo mfo,
                  p_nls nls,
                  trunc(p_date_val) date_val_reg,
                  p_secondary secondary,
                  p_okpo      okpo
             from dual) o
    on (t.rnk = o.rnk)
    when not matched then
      insert
        (rnk, fio, dbcode, mfo, nls, date_val_reg, secondary, okpo)
      values
        (o.rnk, o.name, o.p_dbcode, o.mfo, o.nls, o.date_val_reg, o.secondary, o.okpo)
    when matched then
      update
         set t.fio    = o.name,
             t.dbcode = o.p_dbcode,
             t.mfo    = o.mfo,
             t.nls    = o.nls,
             t.date_val_reg = o.date_val_reg,
             t.secondary    = o.secondary,
             t.okpo         = o.okpo
       where t.rnk = o.rnk;


    --����������� ����� ���
    select t.fio into l_fio from staff$base t where t.id = user_id();

    l_customer_crkr_update_new.id               := s_customer_crkr_update.nextval;
    l_customer_crkr_update_new.rnk              := p_rnk;
    l_customer_crkr_update_new.name             := p_name;
    l_customer_crkr_update_new.inn              := p_inn;
    l_customer_crkr_update_new.id_sex           := p_sex;
    l_customer_crkr_update_new.birth_date       := p_birth_date;
    l_customer_crkr_update_new.rezid            := p_rezid;
    l_customer_crkr_update_new.id_doc_type      := p_doc_type;
    l_customer_crkr_update_new.ser              := p_ser;
    l_customer_crkr_update_new.numdoc           := p_numdoc;
    l_customer_crkr_update_new.date_of_issue    := p_date_of_issue;
    l_customer_crkr_update_new.tel              := p_tel;
    l_customer_crkr_update_new.tel_mob          := p_tel_mob;
    l_customer_crkr_update_new.branch           := p_branch;
    l_customer_crkr_update_new.notes            := p_notes;
    l_customer_crkr_update_new.date_registry    := trunc(sysdate);
    l_customer_crkr_update_new.zip              := p_zip;
    l_customer_crkr_update_new.domain           := p_domain;
    l_customer_crkr_update_new.region           := p_region;
    l_customer_crkr_update_new.locality         := p_locality;
    l_customer_crkr_update_new.address          := p_address;
    l_customer_crkr_update_new.mfo              := p_mfo;
    l_customer_crkr_update_new.nls              := p_nls;
    l_customer_crkr_update_new.secondary        := p_secondary;
    l_customer_crkr_update_new.okpo             := p_okpo;
    l_customer_crkr_update_new.date_val_reg     := p_date_val;
    l_customer_crkr_update_new.user_id          := user_id();
    l_customer_crkr_update_new.user_fio         := l_fio;
    l_customer_crkr_update_new.lastedit         := sysdate;
    l_customer_crkr_update_new.birth_place      := p_bplace;
    l_customer_crkr_update_new.actual_date      := p_actual_date;
    l_customer_crkr_update_new.eddr_id          := p_eddr_id;
    l_customer_crkr_update_new.country_id       := l_country_id;

    begin
      select *
      into l_customer_crkr_update_old
      from customer_crkr_update where id = (select max(id) from customer_crkr_update where rnk = p_rnk);
      l_customer_crkr_update_new.date_registry    := l_customer_crkr_update_old.date_registry;--�� �������� � ��������� ����� ����� - ����� ��� ���� ����� ����� �����
      l_customer_crkr_update_new.change_info      := analiz_change_client(l_customer_crkr_update_old, l_customer_crkr_update_new);
      --������ ���� � ����� �� �������� ��� ��� ����������� ��� � ��������
      for cur in (select r.reg_id from compen_payments_registry r
                           where r.rnk = p_rnk
                             and r.state_id in (STATE_REG_NEW, STATE_REG_PAY_BLOCK, STATE_REG_SEND_ERR)
                  for update
                                                                           )
      loop
        update compen_payments_registry r
           set
             r.mfo_client   = l_customer_crkr_update_new.mfo,
             r.nls          = l_customer_crkr_update_new.nls,
             r.okpo         = nvl(l_customer_crkr_update_new.okpo, l_customer_crkr_update_new.inn), --���� �����������, �� �� ���� ������, � ������ ������� ��� �볺���
             r.msg          = null,
             r.date_val_reg = l_customer_crkr_update_new.date_val_reg,
             r.changedate   = sysdate
         where r.reg_id = cur.reg_id;
      end loop;
    exception
      when no_data_found then
        l_customer_crkr_update_new.change_info := '��������� �볺���';
    end;

    insert into customer_crkr_update
         values l_customer_crkr_update_new;
  end;

  procedure i_row_portfolio_upd(p_portfolio in compen_portfolio%rowtype) is
  begin
    insert into compen_portfolio_update
      (idupd,
       id,
       fio,
       country,
       postindex,
       obl,
       rajon,
       city,
       address,
       fulladdress,
       icod,
       doctype,
       docserial,
       docnumber,
       docorg,
       docdate,
       clientbdate,
       clientbplace,
       clientsex,
       clientphone,
       registrydate,
       nsc,
       ida,
       nd,
       sum,
       ost,
       dato,
       datl,
       attr,
       card,
       datn,
       ver,
       stat,
       tvbv,
       branch,
       kv,
       status,
       date_import,
       dbcode,
       percent,
       kkname,
       ob22,
       rnk,
       branchact,
       reason_change_status,
       heritage_ost,
       rnk_bur,
       branchact_bur,
       ostasvo,
       branch_crkr,
       status_prev,
       user_id,
       user_fio)
    values
      (s_compen_portfolio_update.nextval,
       p_portfolio.id,
       p_portfolio.fio,
       p_portfolio.country,
       p_portfolio.postindex,
       p_portfolio.obl,
       p_portfolio.rajon,
       p_portfolio.city,
       p_portfolio.address,
       p_portfolio.fulladdress,
       p_portfolio.icod,
       p_portfolio.doctype,
       p_portfolio.docserial,
       p_portfolio.docnumber,
       p_portfolio.docorg,
       p_portfolio.docdate,
       p_portfolio.clientbdate,
       p_portfolio.clientbplace,
       p_portfolio.clientsex,
       p_portfolio.clientphone,
       p_portfolio.registrydate,
       p_portfolio.nsc,
       p_portfolio.ida,
       p_portfolio.nd,
       p_portfolio.sum,
       p_portfolio.ost,
       p_portfolio.dato,
       p_portfolio.datl,
       p_portfolio.attr,
       p_portfolio.card,
       p_portfolio.datn,
       p_portfolio.ver,
       p_portfolio.stat,
       p_portfolio.tvbv,
       p_portfolio.branch,
       p_portfolio.kv,
       p_portfolio.status,
       p_portfolio.date_import,
       p_portfolio.dbcode,
       p_portfolio.percent,
       p_portfolio.kkname,
       p_portfolio.ob22,
       p_portfolio.rnk,
       p_portfolio.branchact,
       p_portfolio.reason_change_status,
       p_portfolio.heritage_ost,
       p_portfolio.rnk_bur,
       p_portfolio.branchact_bur,
       p_portfolio.ostasvo,
       p_portfolio.branch_crkr,
       p_portfolio.status_prev,
       user_id,
       (select t.fio from staff$base t where t.id = user_id));
  end;

  function get_reg_type_id(p_regcode in varchar2) return number is
    l_id number;

  begin
    select t.type_id
      into l_id
      from compen_registry_types t
     where upper(t.reg_code) = upper(p_regcode);
    return l_id;
  exception
    when no_data_found then
      raise_application_error(-20000,
                              '�������� ��� �������: ' || p_regcode);
  end;

  function get_oper_type_id(p_opercode in varchar2) return number is
    l_id number;

  begin
    select t.type_id
      into l_id
      from compen_oper_types t
     where upper(t.oper_code) = upper(p_opercode);
    return l_id;
  exception
    when no_data_found then
      raise_application_error(-20000,
                              '�������� ��� ��������: ' || p_opercode);
  end;

  function i_compen_oper(p_opercode     in varchar2,
                         p_compen_id    in number,
                         p_compen_bound in number,
                         p_rnk          in number,
                         p_amount       in number,
                         p_purpose      in varchar2,
                         p_reg_id       in compen_oper.reg_id%type default null,
                         p_ref_id       in compen_oper.ref_id%type default null,
                         p_ben_id       in compen_oper.benef_idb%type default null)
    return number is
    l_id            number;
    l_typeid        number := get_oper_type_id(p_opercode);
    l_ost           compen_portfolio.ost%type;
    l_kv            compen_portfolio.kv%type;
    l_rnk_actual    compen_portfolio.rnk%type;
    l_compen_status compen_portfolio.status%type;
    l_dbcode        compen_portfolio.dbcode%type;
    l_cnt           number;
  begin
    bars_audit.info(G_LOG || 'i_compen_oper' || ' Start p_opercode=>' ||
                    p_opercode || ' p_compen_id=>' || p_compen_id ||' p_compen_bound=>' || p_compen_bound ||
                    ' p_rnk=>' || p_rnk);    
    select c.ost, c.kv, c.rnk, c.status, c.dbcode
      into l_ost, l_kv, l_rnk_actual, l_compen_status, l_dbcode
      from compen_portfolio c
     where c.id = p_compen_id;

    if l_compen_status != STATE_COMPEN_OPEN then
      case
        when l_compen_status = 0 then
          raise_application_error(-20000, '��������������� ����� �������������� ���� �������!');
        when p_opercode = 'REBRANCH' then null;--��� �����, ���������� � ������ ������� �����
        when p_opercode like 'REQ_DEACT%' then null;--��� �����, ����� �� ����� ����������� � ������ ������� �����
        when l_compen_status = STATE_COMPEN_CLOSE and
             p_opercode in ('CHANGE_DA', 'CHANGE_DB') then
             null;--��������� ���� ������������ ������(����������) �������� �� ��� ���������
        when p_opercode in ('DEACT_DEP', 'DEACT_BUR') then
          null; --��� �����, �������������� ����� ������
        when l_compen_status = STATE_COMPEN_CLOSE then
          raise_application_error(-20000,
                                  '��������������� ����� ��������!');
        when l_compen_status = STATE_COMPEN_BLOCK_BUR and
             p_opercode = 'PAY_DEP' then
          raise_application_error(-20000,
                                  '��������������� ����� ���������� � ��''���� � ������������� ��������� �� ���������!');
        when l_compen_status = STATE_COMPEN_BLOCK_HER and
             p_opercode = 'PAY_DEP' then
          raise_application_error(-20000,
                                  '��������������� ����� ���������� � ��''���� � ����������� ��������!');
        when l_compen_status = STATE_COMPEN_BLOCK_HER and
             p_opercode = 'WDO' then
             null; --��� �����, ������� ���� ��� ����� �������� ����� ����� ��������� � ���������� ����� � ������ ������� �����
        when l_compen_status = STATE_COMPEN_BLOCK_HER and
             p_opercode like 'CHANGE_D%' then
             null; --��� �����, �������� ���� ��������� ���������, �� ������ ����� ��� ���� ����� ���������� ����������� �� ������
        when l_compen_status = STATE_COMPEN_BLOCK_BUR and
             p_opercode like 'CHANGE_D%' then
             null; --��� �����, �������� ���� ��������� ���������, �� ������ ����� ��� ���� ����� ���������� ����������� �� ������
        when l_compen_status = STATE_COMPEN_BLOCK_BUR and
             p_opercode = 'PAY_BUR' then
          null; --��� �����, ������� �� ��������� � ������ ������� ����� ����������
        when l_compen_status = STATE_COMPEN_BLOCK_BUR and
             p_opercode = 'ACT_DEP' then
          null; --��� �����,   ������������ � ������ ������� �����
        when l_compen_status = STATE_COMPEN_BLOCK_BUR and
             p_opercode = 'ACT_BUR' then
          null; --���� ����� ������������ �� ��������� ����������� ������������ �� ���������
        when l_compen_status = STATE_COMPEN_BLOCK and
             p_opercode in ('CHANGE_DA', 'CHANGE_DB') then
          null;--��������� ���� ������������ ������(����������) �������� �� ��� ���������
        when l_compen_status = STATE_COMPEN_OPEN and
             p_opercode = 'ACT_HER' then null;--����������� ����� ������ �� �������
        when l_compen_status in (STATE_COMPEN_BLOCK_BUR, STATE_COMPEN_BLOCK_HER) and
             p_opercode like 'BEN%' then null;--���������� � ������������ ���������
        when l_compen_status = STATE_COMPEN_BLOCK then
          raise_application_error(-20000,
                                  '��������������� ����� ����������!');
        else
          raise_application_error(-20000,
                                  '��������������� ����� �� ���� � ������ ³�������!');
      end case;
    end if;

    if p_opercode = 'PAY_DEP' and l_rnk_actual is null then
      raise_application_error(-20000,
                              '��������������� ����� ��������������!');
    end if;

    if l_rnk_actual != p_rnk then
      --��� ������ ������� ���� ��������� �������� ������ ?
      raise_application_error(-20000,
                              '��������������� ����� ������������ �� ���� �����!');
    end if;

    if p_amount > l_ost and l_typeid != TYPE_OPER_WDI /*����������� ���� ���������*/
     then
      raise_application_error(-20000,
                              '��� id=' || p_compen_id ||
                              ' ������� �� ��������������� �����: ' ||
                              l_ost);
    end if;

    if p_opercode = 'PAY_BUR' then
      --��������� �� ��� ���� ������� �� ���������
      select count(1)
        into l_cnt
        from compen_oper c
       where c.compen_id = p_compen_id
         and c.oper_type = TYPE_OPER_PAY_BUR;
      if l_cnt > 0 then
        raise_application_error(-20000,
                                '�� ���������������� ������� ��� ���� ������� �� ��������� ');
      end if;

    end if;

    l_id := s_compen_oper.nextval;
    insert into compen_oper
      (oper_id,
       oper_type,
       compen_id,
       compen_bound,
       rnk,
       amount,
       state,
       msg,
       reg_id,
       ref_id,
       benef_idb,
       user_id)
    values
      (l_id,
       l_typeid,
       p_compen_id,
       p_compen_bound,
       p_rnk,
       p_amount,
       STATE_OPER_NEW,
       p_purpose,
       p_reg_id,
       p_ref_id,
       p_ben_id,
       user_id);
       
    bars_audit.info(G_LOG || 'i_compen_oper End');          
    return l_id;
  end;

  --���� ������� ������
  procedure set_compen_status(p_compen_id            compen_portfolio.id%type,
                              p_status_id            compen_portfolio.status%type,
                              p_reason_change_status compen_portfolio.reason_change_status%type default null,
                              p_unblock              number default null) is
    l_portfolio compen_portfolio%rowtype;
  begin

    select *
    into l_portfolio
    from compen_portfolio
    where id = p_compen_id
    for update;

    if l_portfolio.status = STATE_COMPEN_CLOSE then
        raise_application_error(-20010, '����� ��������');
    end if;

    if p_unblock is null then --�� ��������� ���� ��� �������������
      if p_status_id = STATE_COMPEN_BLOCK_BUR then --������ ��������� �� ���������
        if l_portfolio.status = STATE_COMPEN_BLOCK_HER then
          raise_application_error(-20000, '����� ��� ���������� � ��''���� � ����������� ��������!');
        end if;
        if l_portfolio.status = STATE_COMPEN_BLOCK then
          raise_application_error(-20010, '����� ������������ ��-������');
        end if;
      end if;

      if p_status_id = STATE_COMPEN_BLOCK_HER then --������ ��������� �� �������
        if l_portfolio.status = STATE_COMPEN_BLOCK then
          raise_application_error(-20010, '����� ������������ ��-������');
        end if;
        if l_portfolio.doctype not in (96, 97, 94) then --96-������; 97-�������� ��� �������� 94 ���
          raise_application_error(-20000, '����� �������� �� ������ ����� ���������� ��������');
        end if;
      end if;
    end if;


    if l_portfolio.status != p_status_id then --��������� ����� ���� ������ �����
      update compen_portfolio
         set status               = p_status_id,
             close_date           = case p_status_id
                                      when STATE_COMPEN_OPEN then
                                       null
                                      when STATE_COMPEN_CLOSE then
                                       sysdate --���������
                                      else
                                       close_date
                                    end,
             reason_change_status = p_reason_change_status,
             heritage_ost         = case p_status_id
                                      when STATE_COMPEN_BLOCK_HER then --���� ���������� �� ������ �� �������������� �������� ������� ������
                                       ost                             --�� ��� ���� ��������������� ����� ��� �� ������ ���� ��� �������������
                                       else
                                         heritage_ost
                                    end,
             status_prev          = status,
             datl                 = sysdate
       where id = p_compen_id
      returning id, fio, country, postindex, obl, rajon, city, address, fulladdress, icod, doctype, docserial, docnumber, docorg, docdate, clientbdate, clientbplace, clientsex, clientphone, registrydate, nsc, ida, nd, sum, ost, dato, datl, attr, card, datn, ver, stat, tvbv, branch, kv, status, date_import, dbcode, percent, kkname, ob22, rnk, branchact, close_date, reason_change_status, heritage_ost, rnk_bur, branchact_bur, ostasvo, branch_crkr, status_prev, type_person, name_person, edrpo_person into l_portfolio;
      if sql%rowcount = 0 then
        raise_application_error(-20000,
                                '�� �������� �������������� ������� ID: ' ||
                                p_compen_id);
      end if;
      i_row_portfolio_upd(l_portfolio);

    end if;

/*  ����� � ��������(�� �������� ���������)
    if p_status_id = STATE_COMPEN_BLOCK_BUR then
      --���� �� ���������
      --����������� �� ������ ��������� ��� �������� � ����� ��� ������������
      if l_portfolio.dbcode is not null then
        for cur in (select id
                      from compen_portfolio
                     where dbcode = l_portfolio.dbcode
                       and id <> l_portfolio.id
                       and status not in
                           (STATE_COMPEN_CLOSE,
                            STATE_COMPEN_BLOCK,
                            STATE_COMPEN_BLOCK_BUR,
                            STATE_COMPEN_BLOCK_HER)
                       for update skip locked) loop
          set_compen_status(cur.id,
                            STATE_COMPEN_BLOCK_BUR,
                            '����������� �� dbcode ��� ����������� ������� ���� �� ���������');
        end loop;
      end if;
      --����������� �� ������ ��������� ���� � �������� ��� �������� � ����� ��� ������������
      if l_portfolio.rnk is not null then
        for cur in (select id
                      from compen_portfolio
                     where rnk = l_portfolio.rnk
                       and id <> l_portfolio.id
                       and status not in
                           (STATE_COMPEN_CLOSE,
                            STATE_COMPEN_BLOCK,
                            STATE_COMPEN_BLOCK_BUR,
                            STATE_COMPEN_BLOCK_HER)
                       for update skip locked) loop
          set_compen_status(cur.id,
                            STATE_COMPEN_BLOCK_BUR,
                            '����������� �� rnk ��� ����������� ������� ���� �� ���������');
        end loop;
      end if;

    end if;
    if p_status_id = STATE_COMPEN_BLOCK_HER then
      --���� ��������
      --����������� �� ������ ��������� ��� �������� � ����� ��� ������������ (��� ������������ �� ��������� - ����� ����� ����������� ������ �� ��� �������� �� �������)
      if l_portfolio.dbcode is not null then
        for cur in (select id
                      from compen_portfolio
                     where dbcode = l_portfolio.dbcode
                       and id <> l_portfolio.id
                       and status not in
                           (STATE_COMPEN_CLOSE,
                            STATE_COMPEN_BLOCK,
                            STATE_COMPEN_BLOCK_HER)
                       for update skip locked) loop
          set_compen_status(cur.id,
                            STATE_COMPEN_BLOCK_HER,
                            '����������� �� dbcode ��� ���������� ������� ���� �� �������');
        end loop;
      end if;
      if l_portfolio.rnk is not null then
        for cur in (select id
                      from compen_portfolio
                     where rnk = l_portfolio.rnk
                       and id <> l_portfolio.id
                       and status not in
                           (STATE_COMPEN_CLOSE,
                            STATE_COMPEN_BLOCK,
                            STATE_COMPEN_BLOCK_HER)
                       for update skip locked) loop
          set_compen_status(cur.id,
                            STATE_COMPEN_BLOCK_HER,
                            '����������� �� rnk ��� ���������� ������� ���� �� �������');
        end loop;

      end if;

    end if;
*/

  end;

  procedure get_parameters_web_service(p_url_wapp          out varchar2,
                                       p_Authorization_val out varchar2,
                                       p_timeout           out number,
                                       p_walett_path       out varchar2,
                                       p_walett_pass       out varchar2) is
  begin
    p_url_wapp := GetGlobalOption('CA_URL');
    if p_url_wapp is null then
      p_url_wapp := 'http://10.10.10.101:9088/barsroot/api/cagrc';
    end if;
    if substr(p_url_wapp, -1, 1) <> '/' then
      p_url_wapp := p_url_wapp || '/';
    end if;

    if GetGlobalOption('CA_LOGIN') is null then
      --�� ������� ������� ���������� ��������
      p_Authorization_val := 'Basic ' ||
                             utl_raw.cast_to_varchar2(utl_encode.base64_encode(utl_raw.cast_to_raw('absadm:qwerty')));
    else
      p_Authorization_val := 'Basic ' ||
                             utl_raw.cast_to_varchar2(utl_encode.base64_encode(utl_raw.cast_to_raw(GetGlobalOption('CA_LOGIN') || ':' ||
                                                                                                   GetGlobalOption('CA_PASS'))));
    end if;
    p_walett_path := GetGlobalOption('CA_WALLET_PATH');
    p_walett_pass := GetGlobalOption('CA_WALLET_PASS');

    begin
      p_timeout := greatest(to_number(GetGlobalOption('CA_TIMEOUT'), 60));
    exception
      when others then
        p_timeout := 300;
    end;
  end;

  procedure i_row_benef_update(p_cb in compen_benef%rowtype) is
  begin
    insert into compen_benef_update
      (idupd,
       id_compen,
       idb,
       code,
       fiob,
       countryb,
       fulladdressb,
       icodb,
       doctypeb,
       docserialb,
       docnumberb,
       eddr_id,
       docorgb,
       docdateb,
       clientbdateb,
       clientsexb,
       clientphoneb,
       regdate,
       lastedit,
       userid,
       percent,
       user_id,
       branch)
    values
      (s_compen_benef_update.nextval,
       p_cb.id_compen,
       p_cb.idb,
       p_cb.code,
       p_cb.fiob,
       p_cb.countryb,
       p_cb.fulladdressb,
       p_cb.icodb,
       p_cb.doctypeb,
       p_cb.docserialb,
       p_cb.docnumberb,
       p_cb.eddr_id,
       p_cb.docorgb,
       p_cb.docdateb,
       p_cb.clientbdateb,
       p_cb.clientsexb,
       p_cb.clientphoneb,
       p_cb.regdate,
       sysdate,
       user_id,
       p_cb.percent,
       p_cb.user_id,
       p_cb.branch);
  end;


  --��������� � ��� ���� �� �����������
  function send_info_actual(p_branch_from branch.branch%type,
                            p_branch_to   branch.branch%type,
                            p_s           number,
                            p_type        number,
                            p_err         out varchar2) return number is
    l_ref_id number;

    l_url_wapp          varchar2(256);
    l_Authorization_val varchar2(256);
    l_walett_path       varchar2(256);
    l_walett_pass       varchar2(256);
    l_action            varchar2(32);
    g_response          wsm_mgr.t_response;
    l_result            varchar2(32767);
    l_timeout           number;
  begin
    if p_s <= 0 then
      return null;
    end if;
    get_parameters_web_service(l_url_wapp,
                               l_Authorization_val,
                               l_timeout,
                               l_walett_path,
                               l_walett_pass);

    utl_http.set_transfer_timeout(l_timeout);

    l_action := 'payactual';

    begin
      wsm_mgr.prepare_request(p_url          => l_url_wapp,
                              p_action       => l_action,
                              p_http_method  => wsm_mgr.G_HTTP_POST,
                              p_content_type => wsm_mgr.g_ct_json,
                              p_wallet_path  => l_walett_path,
                              p_wallet_pwd   => l_walett_pass);
      wsm_mgr.add_header(p_name  => 'Authorization',
                         p_value => l_Authorization_val);
      wsm_mgr.add_parameter(p_name  => 'branch_from',
                            p_value => p_branch_from);
      wsm_mgr.add_parameter(p_name => 'branch_to', p_value => p_branch_to);
      wsm_mgr.add_parameter(p_name => 'type', p_value => case p_type when TYPE_OPER_ACT_BUR then 'BUR' when TYPE_OPER_ACT_DEP then 'DEP' end);
      wsm_mgr.add_parameter(p_name => 'summa', p_value => '' || p_s);

      wsm_mgr.execute_request(g_response);
      l_result := g_response.cdoc; -- ���� ���� ����� - � clob �����
      bars_audit.info('service ' || l_action || ' end - ' ||
                      substr(l_result, 1, 3000));
      if substr(l_result, 1, 3) in ('400', '401', '404', '500') and length(l_result) > 3 then
        p_err    := l_result;
        l_ref_id := -1;
        bars_audit.error('crkr_compen_web.send_info_actual: service ' || l_action ||' error:'||p_err);
        --dbms_output.put_line(p_err); --debug
        return l_ref_id;
      end if;
    exception
      when others then
        p_err    := sqlerrm || ' - ' || dbms_utility.format_error_backtrace;
        l_ref_id := -1;
        bars_audit.error('crkr_compen_web.send_info_actual: service ' || l_action ||' error:'||p_err);
        --dbms_output.put_line(p_err); --debug
        return l_ref_id;
    end;
    --
    l_ref_id := l_result;
    return l_ref_id;
  end;

  --��������� � ��� ���� �� ���� �����������
  function send_info_deactual(p_branch_from branch.branch%type,
                              p_branch_to   branch.branch%type,
                              p_s           number,
                              p_err         out varchar2) return number is
    l_ref_id number;

    l_url_wapp          varchar2(256);
    l_Authorization_val varchar2(256);
    l_walett_path       varchar2(256);
    l_walett_pass       varchar2(256);
    l_action            varchar2(32);
    g_response          wsm_mgr.t_response;
    l_result            varchar2(32767);
    l_timeout           number;
  begin
    if p_s <= 0 then
      l_ref_id := 0;
      return null;
    end if;
    get_parameters_web_service(l_url_wapp,
                               l_Authorization_val,
                               l_timeout,
                               l_walett_path,
                               l_walett_pass);

    utl_http.set_transfer_timeout(l_timeout);

    l_action := 'paydeactual';

    begin
      wsm_mgr.prepare_request(p_url          => l_url_wapp,
                              p_action       => l_action,
                              p_http_method  => wsm_mgr.G_HTTP_POST,
                              p_content_type => wsm_mgr.g_ct_json,
                              p_wallet_path  => l_walett_path,
                              p_wallet_pwd   => l_walett_pass);
      wsm_mgr.add_header(p_name  => 'Authorization',
                         p_value => l_Authorization_val);
      wsm_mgr.add_parameter(p_name  => 'branch_from',
                            p_value => p_branch_from);
      wsm_mgr.add_parameter(p_name => 'branch_to', p_value => p_branch_to);
      wsm_mgr.add_parameter(p_name => 'summa', p_value => '' || p_s );

      wsm_mgr.execute_request(g_response);
      l_result := g_response.cdoc; -- ���� ���� ����� - � clob �����
      bars_audit.info('service ' || l_action || ' end - ' ||
                      substr(l_result, 1, 3000));
      if substr(l_result, 1, 3) in ('400', '401', '404', '500') and
         length(l_result) > 3 then
        p_err    := l_result;
        l_ref_id := -1;
        --dbms_output.put_line(p_err); --debug
        bars_audit.error('crkr_compen_web.send_info_deactual: service ' || l_action ||' error:'||p_err);
        return l_ref_id;
      end if;
    exception
      when others then
        p_err    := sqlerrm || ' - ' || dbms_utility.format_error_backtrace;
        l_ref_id := -1;
        --dbms_output.put_line(p_err); --debug
        bars_audit.error('crkr_compen_web.send_info_actual: service ' || l_action ||' error:'||p_err);
        return l_ref_id;
    end;
    --
    l_ref_id := l_result;
    return l_ref_id;
  end;

  --³�������� � �� ����� �� ����� ���������
  function send_cancel_oper(p_reg      number) return varchar2 is
    l_url_wapp          varchar2(256);
    l_Authorization_val varchar2(256);
    l_walett_path       varchar2(256);
    l_walett_pass       varchar2(256);
    l_action            varchar2(32);
    g_response          wsm_mgr.t_response;
    l_result            varchar2(32767);
    l_res               varchar2(32767);
    l_timeout           number;
  begin
    l_url_wapp := GetGlobalOption('CA_URL');
    if l_url_wapp is null then
      l_url_wapp := 'http://10.10.10.101:9088/barsroot/api/cagrc';
    end if;
    if substr(l_url_wapp, -1, 1) <> '/' then
      l_url_wapp := l_url_wapp || '/';
    end if;

    if GetGlobalOption('CA_LOGIN') is null then
      --�� ������� ������� ���������� ��������
      l_Authorization_val := 'Basic ' ||
                             utl_raw.cast_to_varchar2(utl_encode.base64_encode(utl_raw.cast_to_raw('absadm:qwerty')));
    else
      l_Authorization_val := 'Basic ' ||
                             utl_raw.cast_to_varchar2(utl_encode.base64_encode(utl_raw.cast_to_raw(GetGlobalOption('CA_LOGIN') || ':' ||
                                                                                                   GetGlobalOption('CA_PASS'))));
    end if;
    l_walett_path := GetGlobalOption('CA_WALLET_PATH');
    l_walett_pass := GetGlobalOption('CA_WALLET_PASS');

    begin
      l_timeout := greatest(to_number(GetGlobalOption('CA_TIMEOUT'), 60));
    exception
      when others then
        l_timeout := 300;
    end;
    utl_http.set_transfer_timeout(l_timeout);

    l_action := 'backref';

    begin
      wsm_mgr.prepare_request(p_url          => l_url_wapp,
                              p_action       => l_action,
                              p_http_method  => wsm_mgr.G_HTTP_POST,
                              p_content_type => wsm_mgr.g_ct_json,
                              p_wallet_path  => l_walett_path,
                              p_wallet_pwd   => l_walett_pass);
      wsm_mgr.add_header(p_name  => 'Authorization',
                         p_value => l_Authorization_val);
      wsm_mgr.add_parameter(p_name => 'p_clob', p_value => to_char(p_reg));

      wsm_mgr.execute_request(g_response);
      l_result := g_response.cdoc; -- ���� ���� ����� - � clob �����
      l_result := replace(l_result, '"', ''); --� ���� ���� ��������� � ������?
      bars_audit.info('service ' || l_action || ' end - ' ||
                      substr(l_result, 1, 3000));
      if substr(l_result, 1, 3) in ('400', '401', '404', '500') and length(l_result) > 3 then
        l_res := substr('*'||l_result,1,2000);
        --dbms_output.put_line(l_res); --debug
        bars_audit.error('crkr_compen_web.send_cancel_oper: service ' || l_action ||' error:'||substr(l_result, 1, 3000));
        return l_res;
      end if;

      l_res := substr(l_result,1,2000);
      return l_res;
    exception
      when others then
        l_res := substr('*'||sqlerrm || ' - ' || dbms_utility.format_error_backtrace,1,2000);
        bars_audit.error('crkr_compen_web.send_cancel_oper: service ' || l_action ||' error:'||substr(l_result, 1, 3000));
        --dbms_output.put_line(l_res); --debug
        return l_res;
    end;
  end;

  procedure mark_open_client(p_rnk compen_clients.rnk%type) is
    l_planned_day              date;
    l_customer_crkr_update_old customer_crkr_update%rowtype;
    l_customer_crkr_update_new customer_crkr_update%rowtype;
    l_fio                      customer_crkr_update.user_fio%type;
  begin
    l_planned_day := get_planned_day;
    update compen_clients c
    set c.date_val_reg = l_planned_day,
        c.open_cl = sysdate
    where c.rnk = p_rnk
      and c.open_cl is null;
    if sql%rowcount > 0 then
      begin
        select *
        into l_customer_crkr_update_old
        from customer_crkr_update where id = (select max(id) from customer_crkr_update where rnk = p_rnk);

        l_customer_crkr_update_new     := l_customer_crkr_update_old;
        select t.fio into l_fio from staff$base t where t.id = user_id();

        l_customer_crkr_update_new.date_val_reg     := l_planned_day;
        l_customer_crkr_update_new.id               := s_customer_crkr_update.nextval;
        l_customer_crkr_update_new.user_id          := user_id();
        l_customer_crkr_update_new.user_fio         := l_fio;
        l_customer_crkr_update_new.lastedit         := sysdate;
        l_customer_crkr_update_new.change_info      := analiz_change_client(l_customer_crkr_update_old, l_customer_crkr_update_new);
        insert into customer_crkr_update
        values l_customer_crkr_update_new;
      exception
        when no_data_found then
          null;
      end;
    end if;
  end;

  --���� ������� ��������
  procedure set_oper_status(p_oper_id              compen_oper.oper_id%type,
                            p_status_id            compen_oper.state%type,
                            p_reason_change_status compen_oper.msg%type default null,
                            p_oper_ost             compen_oper.oper_ost%type default null) is
    l_oper            compen_oper%rowtype;
    l_portfolio       compen_portfolio%rowtype;
    l_portfolio_donor compen_portfolio%rowtype;

    l_oper_ref  compen_oper.ref_id%type;
    l_err       varchar2(32767);

    l_user_id   number;
    l_date      date;

    l_oper_id             compen_oper.oper_id%type;
    l_oper_auto_act_id    compen_oper.oper_id%type;

    l_oper_state          compen_oper.state%type;
    l_oper_ost            compen_oper.oper_ost%type   := p_oper_ost;

    l_compen_list         number_list := number_list();
    l_oper_arr_id         number_list := number_list();

    l_cbu                      compen_benef_update%rowtype;
    l_cb                       compen_benef%rowtype;

    l_compen_id                compen_portfolio.id%type;

    l_cnt                      pls_integer;

    procedure change_doc(p_oper_id compen_oper.oper_id%type, p_compen_id compen_portfolio.id%type)
      is
      l_doc   compen_oper_dbcode%rowtype;
    begin
      bars_audit.info(G_LOG || 'set_oper_status.change_doc ' || ' Start p_oper_id=>' || p_oper_id || ' p_compen_id=>' || p_compen_id );              
      select * into l_doc from compen_oper_dbcode where oper_id = p_oper_id;
      select * into l_portfolio from compen_portfolio where id = p_compen_id for update;
      insert into compen_portfolio_dbcode_old(compen_id,
                                              dbcode,
                                              doctype,
                                              docserial,
                                              docnumber,
                                              docorg,
                                              docdate,
                                              state_compen_prev,
                                              oper_id,
                                              type_person,
                                              name_person,
                                              edrpo_person)
                                       values(l_portfolio.id,
                                              l_portfolio.dbcode,
                                              l_portfolio.doctype,
                                              l_portfolio.docserial,
                                              l_portfolio.docnumber,
                                              l_portfolio.docorg,
                                              l_portfolio.docdate,
                                              l_portfolio.status,
                                              p_oper_id,
                                              nvl(l_portfolio.type_person, 0),
                                              l_portfolio.name_person,
                                              l_portfolio.edrpo_person);
      update compen_portfolio p
      set  p.doctype   = l_doc.doctype,
           p.docserial = l_doc.docserial,
           p.docnumber = l_doc.docnumber,
           p.docorg    = l_doc.docorg,
           p.docdate   = l_doc.docdate,
           p.dbcode    = l_doc.dbcode,
           p.type_person  = nvl(l_doc.type_person, 0),
           p.name_person  = l_doc.name_person,
           p.edrpo_person = l_doc.edrpo_person,
           p.datl      = sysdate
      where p.id = p_compen_id
      returning id, fio, country, postindex, obl, rajon, city, address, fulladdress, icod, doctype, docserial, docnumber, docorg, docdate, clientbdate, clientbplace, clientsex, clientphone, registrydate, nsc, ida, nd, sum, ost, dato, datl, attr, card, datn, ver, stat, tvbv, branch, kv, status, date_import, dbcode, percent, kkname, ob22, rnk, branchact, close_date, reason_change_status, heritage_ost, rnk_bur, branchact_bur, ostasvo, branch_crkr, status_prev, type_person, name_person, edrpo_person into l_portfolio;
      --� ����� �����
      i_row_portfolio_upd(l_portfolio);
      delete from compen_oper_dbcode where oper_id = p_oper_id;
       --��� ���������
      begin 
        set_compen_status(p_compen_id, l_doc.state_compen, '����������� ���������� ��� ��� ���������');
        exception
          when others then
            if sqlcode = -20010 then -- '����� ��������', '����� ������������ ��-������'
              null; --���� ������ ��������, ��� ������ ������ ������ �� �� ����
              else raise;
            end if;
      end;        
      bars_audit.info(G_LOG || 'set_oper_status.change_doc End p_oper_id=>' || p_oper_id);      
    end;

    procedure undo_change_document(p_oper_id compen_oper.oper_id%type, p_compen_id compen_portfolio.id%type)
      is
        l_compen_dbcode_old        compen_portfolio_dbcode_old%rowtype;
    begin
      bars_audit.info(G_LOG || 'set_oper_status.undo_change_document ' || ' Start p_oper_id=>' || p_oper_id || ' p_compen_id=>' || p_compen_id );                    
      select * into l_compen_dbcode_old from compen_portfolio_dbcode_old where oper_id = p_oper_id;
      select * into l_portfolio from compen_portfolio where id = p_compen_id;

          --�������� �� ����� �� ���������� ����
      insert into compen_oper_dbcode(oper_id,
                                     dbcode,
                                     doctype,
                                     docserial,
                                     docnumber,
                                     docorg,
                                     docdate,
                                     state_compen,
                                     type_person,
                                     name_person,
                                     edrpo_person)
             values                  (l_compen_dbcode_old.oper_id,
                                      l_portfolio.dbcode,
                                      l_portfolio.doctype,
                                      l_portfolio.docserial,
                                      l_portfolio.docnumber,
                                      l_portfolio.docorg,
                                      l_portfolio.docdate,
                                      l_portfolio.status,
                                      nvl(l_portfolio.type_person, 0),
                                      l_portfolio.name_person,
                                      l_portfolio.edrpo_person
                                      );
      --������ ����� �������� � ��������� ������
      update compen_portfolio p
      set  p.doctype   = l_compen_dbcode_old.doctype,
           p.docserial = l_compen_dbcode_old.docserial,
           p.docnumber = l_compen_dbcode_old.docnumber,
           p.docorg    = l_compen_dbcode_old.docorg,
           p.docdate   = l_compen_dbcode_old.docdate,
           p.dbcode    = l_compen_dbcode_old.dbcode,
           p.type_person  = nvl(l_compen_dbcode_old.type_person, 0),
           p.name_person  = l_compen_dbcode_old.name_person,
           p.edrpo_person = l_compen_dbcode_old.edrpo_person,
           p.datl      = sysdate
      where p.id = p_compen_id
      returning id, fio, country, postindex, obl, rajon, city, address, fulladdress, icod, doctype, docserial, docnumber, docorg, docdate, clientbdate, clientbplace, clientsex, clientphone, registrydate, nsc, ida, nd, sum, ost, dato, datl, attr, card, datn, ver, stat, tvbv, branch, kv, status, date_import, dbcode, percent, kkname, ob22, rnk, branchact, close_date, reason_change_status, heritage_ost, rnk_bur, branchact_bur, ostasvo, branch_crkr, status_prev, type_person, name_person, edrpo_person into l_portfolio;
      --� ����� �����
      i_row_portfolio_upd(l_portfolio);
      begin
        set_compen_status(p_compen_id, l_compen_dbcode_old.state_compen_prev, '���������� ������� ��� ���� ���� ���������', 1);
        exception
          when others then
            if sqlcode = -20010 then -- '����� ��������', '����� ������������ ��-������'
              null; --���� ������ ��������, ��� ������ ������ ������ �� �� ����
              else raise;
            end if;
      end;      
      delete from compen_portfolio_dbcode_old where oper_id = p_oper_id;
      bars_audit.info(G_LOG || 'set_oper_status.undo_change_document End p_oper_id=>' || p_oper_id);            
     end;
  begin
    bars_audit.info(G_LOG || 'set_oper_status' || ' Start p_oper_id=>' || p_oper_id || ' p_status_id=>' || p_status_id );        
    select * into l_oper from compen_oper where oper_id = p_oper_id for update;

    if p_status_id = STATE_OPER_COMPLETED then
      l_user_id := user_id;
      l_date    := sysdate;
      if l_oper.oper_type = TYPE_OPER_WDI then--�� �� ����������
        select * into l_portfolio from compen_portfolio where id = l_oper.compen_id for update;
        select * into l_portfolio_donor from compen_portfolio where id = l_oper.compen_bound for update;
        if l_portfolio_donor.status != STATE_COMPEN_BLOCK_HER then
           raise_application_error(-20000, '����� � ����� ������������ ������� ���� � ������ - ���������� �� ������� ');
        end if;
        l_portfolio_donor.ost := l_portfolio_donor.ost - l_oper.amount;
        l_portfolio_donor.sum := l_portfolio_donor.sum - l_oper.amount;
        l_portfolio_donor.datl := sysdate;
        if l_portfolio_donor.ost < 0 then
           raise_application_error(-20000,
                              '����������� ����� �� ������� ID : ' ||
                              l_portfolio_donor.id || '. �������: ' ||
                              l_portfolio_donor.ost / 100);
        end if;

        l_portfolio.ost := l_portfolio.ost + l_oper.amount;
        l_portfolio.sum := l_portfolio.sum + l_oper.amount;
        l_portfolio.datl := sysdate;

        update compen_portfolio t
           set t.ost  = l_portfolio_donor.ost,
               t.sum  = l_portfolio_donor.sum,
               t.datl = l_portfolio_donor.datl
         where t.id = l_portfolio_donor.id;
        i_row_portfolio_upd(l_portfolio_donor);
        if l_portfolio_donor.ost = 0 then
          set_compen_status(l_portfolio_donor.id,
                            STATE_COMPEN_CLOSE,
                            '����������� �������� � �������� ��������');
        end if;

        update compen_portfolio t
         set t.ost  = l_portfolio.ost,
             t.sum  = l_portfolio.sum,
             t.datl = l_portfolio.datl
        where t.id = l_portfolio.id;
        i_row_portfolio_upd(l_portfolio);

        l_oper_ost := l_portfolio.ost;

        select co.oper_id, co.compen_id into l_oper_id, l_compen_id from compen_oper co where co.compen_id = l_oper.compen_bound/*(select p.id from compen_oper o, compen_portfolio p
                                                                                                              where o.compen_bound = p.id and o.oper_id = p_oper_id)*/
                                                                                        and co.oper_type = TYPE_OPER_WDO
                                                                                        and co.compen_bound = l_oper.compen_id;
        select count(*) into l_cnt from compen_oper o where o.oper_type in (TYPE_OPER_CHANGE_D, TYPE_OPER_CHANGE_DA, TYPE_OPER_CHANGE_DB)
                                                        and o.state not in (STATE_OPER_CANCELED, STATE_OPER_COMPLETED)
                                                        and o.compen_id = l_compen_id;
        if l_cnt > 0 then
          raise_application_error(-20000,'���� ����������� �������� ���� ��������� �� ����� � ����� ���������� �����');
        end if;
        set_oper_status(l_oper_id, STATE_OPER_COMPLETED, null, l_portfolio_donor.ost);

        --����������� �������� �������� ����������� ��� �������
        l_oper_auto_act_id := i_compen_oper('ACT_HER',
                                   l_oper.compen_id,
                                   null,
                                   l_oper.rnk,
                                   l_oper.amount,
                                   null,--'����������� ��� ��������� ��������',
                                   null,
                                  null);
        --���� �� ����� �볺��� ��� ��� ����������� ����� ������� ��
        cancel_reg_pay(l_oper.rnk, 'PAY_DEP', ' ��� ��������� ������������� ������ �� �������');
        mark_open_client(l_oper.rnk);
        --����� �� ���� ������


      end if; --end ����������
      if l_oper.oper_type in (TYPE_OPER_ACT_BUR, TYPE_OPER_ACT_DEP, TYPE_OPER_ACT_HER ) then
        if  l_oper.oper_type = TYPE_OPER_ACT_HER then --��� �� ����������� ��������� �� ���� �������� ���������� ���������
          select max(co.state) into l_oper_state
          from compen_oper co where co.compen_id = l_oper.compen_id and co.oper_type = TYPE_OPER_WDI and co.state not in (STATE_OPER_COMPLETED, STATE_OPER_CANCELED);
          if l_oper_state is not null then
            raise_application_error(-20000,'�������� ����������� �������� ����������');
          end if;
        end if;
        select * into l_portfolio from compen_portfolio where id = l_oper.compen_id;
        if l_oper.oper_type in (TYPE_OPER_ACT_DEP, TYPE_OPER_ACT_HER) and l_portfolio.ob22 = '01' then
          l_portfolio.ob22 := '23';
          l_portfolio.datl := sysdate;
          update compen_portfolio t
           set t.ob22  = l_portfolio.ob22,
               t.datl = l_portfolio.datl
          where t.id = l_portfolio.id;
          i_row_portfolio_upd(l_portfolio);
        end if;

        l_oper_ref := send_info_actual(substr(l_portfolio.branch_crkr, 1, 8),
                                           case when l_oper.oper_type = TYPE_OPER_ACT_BUR then substr(l_portfolio.branchact_bur, 1, 8) else substr(l_portfolio.branchact, 1, 8) end,
                                           l_oper.amount,
                                           l_oper.oper_type,
                                           l_err);
        if l_oper_ref = -1 then
            raise_application_error(-20000,'������� ������� ��� �������� ���������� �� ����������� � ���. ' ||
                                      l_err);
        end if;

      end if;
      if l_oper.oper_type in (TYPE_OPER_PAY_BUR, TYPE_OPER_PAY_DEP) then
        select * into l_portfolio from compen_portfolio where id = l_oper.compen_id for update;
        if l_portfolio.ost - l_oper.amount < 0 then
           logger.error('set_oper_status: �������� �������! �� ��������������� �����'||l_oper.compen_id||' �� ������� ����� ��� ��������! �������� ������: '||p_oper_id);
           raise_application_error(-20000,'�������� �������! �� ��������������� ����� �� ������� ����� ��� ��������!');
        end if;
        update compen_portfolio p
           set p.ost = p.ost - l_oper.amount,
               p.sum = p.sum - l_oper.amount,
               p.datl = sysdate
         where p.id = l_oper.compen_id
         returning p.ost, p.sum, p.datl into l_portfolio.ost, l_portfolio.sum, l_portfolio.datl;

         i_row_portfolio_upd(l_portfolio);

         l_oper_ost := l_portfolio.ost;

         if l_portfolio.ost = 0 then
            set_compen_status(l_oper.compen_id, STATE_COMPEN_CLOSE,
                              '����������� �������� � �������� ��������');
         end if;

      end if;
      if l_oper.oper_type = TYPE_OPER_CHANGE_D then--��������� �� ������� ����� ���� ��������� �� ����� ��� �������
        change_doc(l_oper.oper_id, l_oper.compen_id);
        --������� ��������� �� ��� �������� �� ������� � ������� ����
        select * into l_portfolio from compen_portfolio where id = l_oper.compen_id;
        if l_portfolio.rnk is not null then
          cancel_reg_pay(l_portfolio.rnk, 'PAY_DEP', '��� �������� �������� ��� ������� �� ���������');
        end if;
        if l_portfolio.rnk_bur is not null then
          cancel_reg_pay(l_portfolio.rnk_bur, 'PAY_BUR', '��� �������� �������� ��� ������� �� ���������');
          --�������� 12.10.2016 �.12: ������ �������: ���� ����� ����������� �� ��������� ����������� ���� ���������� ����� ����� ��� ���������� ��������
          if l_portfolio.doctype in (96,97,94) then--96-������; 97-�������� ��� �������� 94-���
            l_compen_list.extend;l_compen_list(l_compen_list.last) := l_portfolio.id;
            deactualization_compen(l_portfolio.rnk_bur, l_compen_list,'ACT_BUR');--����������� ������������� �� ���������
            /*select o.oper_id into l_oper_id
            from compen_oper o where o.compen_id = l_portfolio.id and o.oper_type = TYPE_OPER_DEACT_BUR and o.state = STATE_OPER_NEW;
            set_oper_status(l_oper_id,STATE_OPER_COMPLETED,'����������� ��� �������� ��������');*/
          end if;
        end if;
        for cur in (select o.oper_id, o.compen_id from compen_oper o where o.oper_type in (TYPE_OPER_CHANGE_DA, TYPE_OPER_CHANGE_DB) and o.state = STATE_OPER_NEW and o.compen_bound = l_oper.compen_id)
        loop
          change_doc(cur.oper_id, cur.compen_id);
          set_oper_status(cur.oper_id, STATE_OPER_COMPLETED,'�����������');
        end loop;
        l_oper_ost := l_portfolio.ost;
      end if;
    end if;--STATE_OPER_COMPLETED

    if p_status_id = STATE_OPER_NEW then
      if l_oper.oper_type = TYPE_OPER_WDI then--��� ��������� ����������� �������� �� ��������� �������� (�������� � ���������(WDO)-����������� ���������(WDI))
        --�������� �������� ��������
        select co.oper_id, co.compen_id into l_oper_id, l_compen_id from compen_oper co where co.compen_id = l_oper.compen_bound/*(select p.id from compen_oper o, compen_portfolio p
                                                                   where o.compen_bound = p.id and o.oper_id = p_oper_id)*/
                                                                   and co.oper_type = TYPE_OPER_WDO
                                                                   and co.compen_bound = l_oper.compen_id;
        --set_oper_status(l_oper_id, STATE_OPER_NEW);
        l_oper_id := null;
        for cur in (select * from compen_oper o where o.compen_id = l_compen_id and o.oper_type in (TYPE_OPER_CHANGE_D, TYPE_OPER_WDO) and o.state = STATE_OPER_COMPLETED
                    order by o.oper_id desc)
        loop
          if cur.oper_type = TYPE_OPER_CHANGE_D then
            l_oper_id := cur.oper_id;
            exit;
          end if;
          if cur.oper_type = TYPE_OPER_WDO then
            l_oper_id := null;
            exit;
          end if;
        end loop;
        --��������� �������� ���� ��������� �� ������������ ���� ���� �� ���� ������������ ������� �� ��� �� ���� ����������� �� ��������� ��������
        if l_oper_id is not null then
          undo_change_document(l_oper_id, l_compen_id);
          set_oper_status(l_oper_id, STATE_OPER_NEW,'���������� ��� ��������� ��������:'||p_reason_change_status);
          --������� ���� �� ���������
          for cur in (select o.oper_id, o.compen_id from compen_oper o where o.oper_type in (TYPE_OPER_CHANGE_DA, TYPE_OPER_CHANGE_DB) and o.state = STATE_OPER_COMPLETED and o.compen_bound = l_compen_id)
          loop
            undo_change_document(cur.oper_id, cur.compen_id);
            set_oper_status(cur.oper_id, STATE_OPER_NEW,'�����������');
          end loop;

        end if;
      end if;
    end if;

    if p_status_id = STATE_OPER_CANCELED then
      if l_oper.oper_type = TYPE_OPER_CHANGE_D then
        delete from compen_oper_dbcode where oper_id = l_oper.oper_id;
        for cur in (select o.oper_id, o.compen_id from compen_oper o where o.oper_type in (TYPE_OPER_CHANGE_DA, TYPE_OPER_CHANGE_DB) and o.state = STATE_OPER_NEW and o.compen_bound = l_oper.compen_id)
        loop
          delete from compen_oper_dbcode where oper_id = cur.oper_id;
          set_oper_status(cur.oper_id, STATE_OPER_CANCELED,'�����������');
        end loop;
      end if;
      if l_oper.oper_type in (TYPE_OPER_ACT_BUR, TYPE_OPER_ACT_DEP, TYPE_OPER_ACT_HER) then
        select * into l_portfolio from compen_portfolio where id = l_oper.compen_id for update;
        update compen_portfolio p
           set p.rnk           = case l_oper.oper_type when TYPE_OPER_ACT_DEP then null when TYPE_OPER_ACT_HER then null when TYPE_OPER_ACT_BUR then p.rnk end,
               p.branchact     = case l_oper.oper_type when TYPE_OPER_ACT_DEP then null when TYPE_OPER_ACT_HER then null when TYPE_OPER_ACT_BUR then p.branchact end,
               p.rnk_bur       = case l_oper.oper_type when TYPE_OPER_ACT_DEP then p.rnk_bur when TYPE_OPER_ACT_HER then p.rnk_bur when TYPE_OPER_ACT_BUR then null end,
               p.branchact_bur = case l_oper.oper_type when TYPE_OPER_ACT_DEP then p.branchact_bur when TYPE_OPER_ACT_HER then p.branchact_bur when TYPE_OPER_ACT_BUR then null end,
               p.datl = sysdate
         where p.id = l_oper.compen_id
         returning p.rnk, p.branchact, p.rnk_bur, p.branchact_bur, p.datl into l_portfolio.rnk, l_portfolio.branchact, l_portfolio.rnk_bur, l_portfolio.branchact_bur, l_portfolio.datl;
         i_row_portfolio_upd(l_portfolio);
      end if;
      if l_oper.oper_type = TYPE_OPER_WDI then
        select co.oper_id into l_oper_id from compen_oper co where co.compen_id = (select p.id from compen_oper o, compen_portfolio p
                                                                                   where o.compen_bound = p.id and o.oper_id = p_oper_id)
                                                               and co.oper_type = TYPE_OPER_WDO
                                                               and co.compen_bound = l_oper.compen_id;
        set_oper_status(l_oper_id, STATE_OPER_CANCELED);
      end if;
      --����� �� ��������� ��� ������������
      if l_oper.oper_type = TYPE_OPER_BENEF_ADD then
        delete_benef(l_oper.compen_id, l_oper.benef_idb, 'Y');
      end if;
      if  l_oper.oper_type = TYPE_OPER_BENEF_MOD then
        select c.* into l_cbu from compen_benef_update c where c.id_compen = l_oper.compen_id and c.idb = l_oper.benef_idb
                                                          and c.idupd = (select max(prev) from ( select lag(idupd) over (order by idupd) as prev from compen_benef_update
                                                                                                  where id_compen = l_oper.compen_id and idb =  l_oper.benef_idb));
        registr_benef(p_id_compen    => l_cbu.id_compen,
                      p_code         => l_cbu.code,
                      p_fio          => l_cbu.fiob,
                      p_country      => l_cbu.countryb,
                      p_fulladdress  => l_cbu.fulladdressb,
                      p_icod         => l_cbu.icodb,
                      p_doctype      => l_cbu.doctypeb,
                      p_docserial    => l_cbu.docserialb,
                      p_docnumber    => l_cbu.docnumberb,
                      p_eddr_id      => l_cbu.eddr_id,
                      p_docorgb      => l_cbu.docorgb,
                      p_docdate      => l_cbu.docdateb,
                      p_cliebtbdate  => l_cbu.clientbdateb,
                      p_clientsex    => l_cbu.clientsexb,
                      p_clientphone  => l_cbu.clientphoneb,
                      p_percent      => l_cbu.percent,
                      p_idb          => l_cbu.idb,
                      p_without_oper => 'Y');

      end if;
      if l_oper.oper_type = TYPE_OPER_BENEF_DEL then
        update compen_benef b
        set b.removedate = null
        where b.id_compen = l_oper.compen_id and b.idb = l_oper.benef_idb
        returning b.id_compen,b.idb,b.code,b.fiob,b.countryb,b.fulladdressb,b.icodb,b.doctypeb,b.docserialb,b.docnumberb,b.docorgb,b.docdateb,b.clientbdateb,b.clientsexb,b.clientphoneb,b.regdate,b.removedate,b.percent,b.branch,b.user_id,b.eddr_id into l_cb;
        i_row_benef_update(l_cb);
      end if;
      --
    end if;


    update compen_oper
       set state         = p_status_id,
           changedate    = sysdate,
           changeuser_id = user_id(),
           msg           = nvl(p_reason_change_status, msg),
           visa_user_id  = case when l_user_id is null then visa_user_id else l_user_id end,
           visa_date     = case when l_date is null then visa_date else l_date end,
           ref_id        = case when l_oper_ref is null then ref_id else l_oper_ref end,
           oper_ost      = l_oper_ost
     where oper_id = p_oper_id
    returning oper_id, oper_type, compen_id, compen_bound, rnk, amount, regdate, changedate, state, msg, branch, mfo, reg_id, ref_id, user_id, visa_user_id, visa_date, changeuser_id, oper_ost, benef_idb into l_oper;
    if sql%rowcount = 0 then
      raise_application_error(-20000,
                              '�� �������� �������� ID: ' || p_oper_id);
    end if;
    --������

    --���� ��� ��������� ������� ����������� ���� ���� ��������
    if p_status_id = STATE_OPER_COMPLETED then
/*       --����������� ��� �� �������
       if l_oper.oper_type = TYPE_OPER_WDI then--���� ��� ������ ����, �� ����������� �������� �����������
         set_oper_status(l_oper_auto_act_id, STATE_OPER_COMPLETED,'����������� ����������� ��� ��������� ��������');
       end if;*/
       if l_oper.oper_type in (TYPE_OPER_REQ_DEACT_BUR, TYPE_OPER_REQ_DEACT_DEP) then --��� ���������� �������� ������ �� ����� ����������� �������������� ����� ������� ���������.
         l_compen_list.extend;l_compen_list(l_compen_list.last) := l_oper.compen_id;
         deactualization_compen(l_oper.rnk, l_compen_list, case when l_oper.oper_type = TYPE_OPER_REQ_DEACT_DEP then 'ACT_DEP' else 'ACT_BUR' end);
       end if;
       if l_oper.oper_type in (TYPE_OPER_DEACT_BUR, TYPE_OPER_DEACT_DEP) then
         --���� ���� ������������� ������������� ������� ��������� �� ������ ������ ������(� ��� ����� ���� ������� �������� ������������� ���� � ������ ϳ�����������)
         for cur in (select * from compen_oper o where o.oper_type = decode(l_oper.oper_type, TYPE_OPER_DEACT_BUR, TYPE_OPER_REQ_DEACT_BUR, TYPE_OPER_REQ_DEACT_DEP)
                                                   and o.state not in (STATE_OPER_CANCELED, STATE_OPER_COMPLETED)
                                                   and o.compen_id = l_oper.compen_id)
         loop
           set_oper_status(cur.oper_id, STATE_OPER_CANCELED, '����������� ����� ������ ��� �������� ³���� �����������');
         end loop;

         --���������� �������� ����������� � ������ �������
         if l_oper.oper_type = TYPE_OPER_DEACT_BUR then
           l_oper_arr_id.extend;l_oper_arr_id(l_oper_arr_id.last) :=  TYPE_OPER_ACT_BUR;
           else
             l_oper_arr_id.extend;l_oper_arr_id(l_oper_arr_id.last) :=  TYPE_OPER_ACT_DEP;
             l_oper_arr_id.extend;l_oper_arr_id(l_oper_arr_id.last) :=  TYPE_OPER_ACT_HER;
         end if;
         for cur in (select * from compen_oper o where o.compen_id = l_oper.compen_id and o.oper_type in  (select value(tt) from table(l_oper_arr_id) tt)
                                                   and o.state != STATE_OPER_CANCELED)
         loop
           set_oper_status(cur.oper_id, STATE_OPER_CANCELED,'³���� ��� �������������');
         end loop;

       end if;
       if l_oper.oper_type = TYPE_OPER_ACT_BUR then
          add_to_registry_bur(p_compen_id => l_oper.compen_id);--�������������� � ����� �� ���������
       end if;

    end if;

    bars_audit.info(G_LOG || 'set_oper_status End');
    exception 
      when others then 
        bars_audit.error(G_LOG || 'set_oper_status ' ||dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace());
        raise;    
  end;

  --������� ���������� ������� ����/��������
  --p_par - ��`� ������/��������
  function get_compen_param_val(p_par varchar2) return varchar2 is
    l_val number;
  begin
    select d.val
      into l_val
      from compen_params_data d
     where d.par = upper(p_par)
       and d.is_enable = 1
       and sysdate between d.date_from and d.date_to
       and rownum < 2;--����� ���������?
    return l_val;
  exception
    when no_data_found then
      l_val := null;
      return l_val;
  end;

  function get_asvo_payments(p_rnk in number) return number is
    l_result number;
  begin
    select nvl(sum(t.sumop), 0)
      into l_result
      from compen_motions t
      join compen_portfolio cp
        on t.id_compen = cp.id
       and (cp.rnk = p_rnk
            or cp.dbcode = (select dbcode from compen_clients c where c.rnk = p_rnk))
       and t.typo = 'WK'
       and t.stat <> 'S'
       and t.datl > date '2008-01-01';
    return l_result;
  end;

  procedure get_crkr_payments(p_rnk     in number,
                              p_payd    out number,
                              p_blocked out number) is
  begin

    select nvl(sum(case
                     when t.state = STATE_OPER_COMPLETED then
                      t.amount
                     else
                      0
                   end),
               0) payd,
           nvl(sum(case
                     when t.state = STATE_OPER_WAIT_CONFIRM then --todo:��������� �������� �������
                      t.amount
                     else
                      0
                   end),
               0) blocked
      into p_payd, p_blocked
      from compen_oper t
      join compen_portfolio cp
        on t.compen_id = cp.id
       and t.oper_type = TYPE_OPER_PAY_DEP
       and cp.rnk = p_rnk;
  end;

  function get_payments(p_rnk in number) return number is
    l_result       number := 0;
    l_asvo_payd    number;
    l_crkr_payd    number;
    l_crkr_blocked number;
  begin
    l_asvo_payd := get_asvo_payments(p_rnk) / 100;
    get_crkr_payments(p_rnk, l_crkr_payd, l_crkr_blocked);
    l_result := l_asvo_payd + l_crkr_payd / 100 + l_crkr_blocked / 100;
    return l_result;
  end;


  --��������(� �������) �� ������ ������ ��� �� ������������ �����������
  function get_payment_bur_lim_dbcode(p_dbcode compen_portfolio.dbcode%type) return number
    is
    l_limit         number := to_number(get_compen_param_val('COMPEN_BURIAL')) * 100;
    l_sum_block     number := 0;
    l_sum           number;
  begin
    if l_limit is null then
      raise_application_error(-20000, '˳�� �� ��������� �������������');
    end if;
    select nvl(sum(o.amount), 0) into l_sum_block
    from compen_portfolio p, compen_oper o
    where p.id = o.compen_id and o.oper_type = TYPE_OPER_ACT_BUR
      and p.dbcode = p_dbcode
      and status = STATE_COMPEN_BLOCK_BUR;
    --� � ���� � ���� �� �������� �� ���������?

    l_sum := greatest(l_limit - l_sum_block , 0);
    return l_sum;
  end;

  --������� ������ ������� ��������� �� ���������(� ����������� ���� �� �������� ������� �� ���������� ������� �� ���������)
  function get_payment_bur_amount(p_rnk in number, p_dbcode_sum out t_arr_dbcode_sum) return number is
    result         number := 0;
    l_limit        number := to_number(get_compen_param_val('COMPEN_BURIAL')) * 100;
    l_sum_reg      number;
    l_sum_noreg    number;
    l_sum_ost      number := 0;
    l_sum_ost_all  number := 0;
    l_cnt          number;
  begin
    if l_limit is null then
      raise_application_error(-20000, '˳�� �� ��������� �������������');
    end if;

    --diver: ������� ��������� ������ � ����� ������ � ����� �� �� ���������� �� ���������
    --       � ����� ����� �������� �����

    for cur in (select p.dbcode
                from compen_portfolio p
                where p.rnk_bur = p_rnk
                --and status = STATE_COMPEN_BLOCK_BUR
                group by p.dbcode)
    loop
      select count(*)
      into   l_cnt
      from compen_payments_registry r, compen_portfolio p
      where r.rnk = p.rnk_bur and p.dbcode = cur.dbcode
        and r.rnk = p_rnk and r.state_id in (STATE_REG_SEND_OK, STATE_REG_PAY_COMPLETED);

      if l_cnt > 0 then   --��� � ������� �� ����� � ��� �� �� �� ����� ������ (����� �� ���������)
         l_sum_reg := 0;
         l_sum_noreg := 0;
        else
         select nvl(sum(o.amount), 0)  into l_sum_reg --���� ��� � �����
         from compen_portfolio p, compen_oper o
         where p.id = o.compen_id and o.oper_type = TYPE_OPER_ACT_BUR and o.reg_id is not null
         and p.dbcode = cur.dbcode
         and p.rnk_bur = p_rnk;
         --and status = STATE_COMPEN_BLOCK_BUR;--������ ����� ��� �������

         select nvl(sum(o.amount), 0)  into l_sum_noreg --���� �� ������� � �����
         from compen_portfolio p, compen_oper o
         where p.id = o.compen_id and o.oper_type = TYPE_OPER_ACT_BUR and o.reg_id is null and o.state = STATE_OPER_COMPLETED
         and p.dbcode = cur.dbcode
         and p.rnk_bur = p_rnk
         and p.status = STATE_COMPEN_BLOCK_BUR;
      end if;

      l_sum_ost := least(l_limit, l_sum_noreg);
      p_dbcode_sum(cur.dbcode) := l_sum_ost;
      l_sum_ost_all := l_sum_ost_all + l_sum_ost + l_sum_reg;

    end loop;

    Result := l_sum_ost_all;
    --
    return Result;
  end;


  --������� ������ ������� ���������(� ����������� ����, ������ �� �������� ������� �� ���������� �������)
  function get_payment_amount(p_rnk in number) return number is
    result     number := 0;
    l_payments number := get_payments(p_rnk);
    /*l_limit    number := to_number(nvl(trim(getglobaloption('COMPEN_LIMIT')),
    0));*/
    l_limit   number := to_number(get_compen_param_val('COMPEN_LIMIT'));
    l_sum_ost number;
  begin
    if l_limit is null then
      raise_application_error(-20000, '˳�� �������������');
    end if;
    Result := greatest(l_limit - l_payments, 0);
    --diver: ������� ��������� ������ � ����� ������ � ����� �� ��
    select nvl(sum(cp.ost), 0)
      into l_sum_ost
      from compen_portfolio cp, compen_oper o
     where cp.rnk = p_rnk
       and cp.status = STATE_COMPEN_OPEN
       and cp.id = o.compen_id and cp.rnk = o.rnk
       and o.oper_type in (TYPE_OPER_ACT_DEP, TYPE_OPER_ACT_HER)
       and o.state = STATE_OPER_COMPLETED
       ;
    Result := least(Result, l_sum_ost / 100);
    --
    return Result;
  end;


  --�����������
  --           p_opercode:
  --                          ACT_DEP - ����������� ��������������� ������
  --                          ACT_BUR - ����������� ��������������� ������ �� ���������
  procedure actualization_compen(p_rnk      in number,
                                 p_compenid in number,
                                 p_opercode in varchar2) is
    l_portfolio compen_portfolio%rowtype;
    l_oper_id   compen_oper.oper_id%type;
    l_amount    compen_oper.amount%type;

    l_cnt       pls_integer;
    l_rnk_bur   compen_portfolio.rnk_bur%type;

    l_customer_crkr_update_old customer_crkr_update%rowtype;
    l_customer_crkr_update_new customer_crkr_update%rowtype;

    l_planned_day              date;
    l_fio                      customer_crkr_update.user_fio%type;

    ora_lock exception;
    pragma exception_init(ora_lock, -54);
  begin
    if p_opercode not in ('ACT_DEP', 'ACT_BUR') then
      raise_application_error(-20000, '�������� p_opercode ������� ������');
    end if;
    if p_rnk is null then
      raise_application_error(-20000, '�������� p_rnk ���������');
    end if;


    select t.*
      into l_portfolio
      from compen_portfolio t
     where t.id = p_compenid
       for update nowait;

    select count(*) into l_cnt from compen_oper o where o.compen_id = p_compenid and o.oper_type = TYPE_OPER_WDO and o.state = STATE_OPER_COMPLETED;
    if l_cnt > 0 then
      raise_application_error(-20000, '������� �������� �������� �� ���������� ��������');
    end if;

    if (l_portfolio.rnk is null and p_opercode='ACT_DEP') or (l_portfolio.rnk_bur is null and p_opercode='ACT_BUR') then
      if l_portfolio.status != STATE_COMPEN_OPEN and
         l_portfolio.status != STATE_COMPEN_BLOCK_BUR then
        case l_portfolio.status
          when 0 then
            raise_application_error(-20000, '��������������� ����� �������������� ���� �������!');
          when STATE_COMPEN_CLOSE then
            raise_application_error(-20000, '��������������� ����� ��������!');
          when STATE_COMPEN_BLOCK_HER then
            raise_application_error(-20000, '��������������� ����� ���������� � ��''���� � ����������� ��������');
          when STATE_COMPEN_BLOCK then
            raise_application_error(-20000, '��������������� ����� ����������!');
          else
            raise_application_error(-20000, '��������������� ����� �� ���� � ������ ³�������!');
        end case;
      else
        --������� �������� ����� ������������
        if l_portfolio.status = STATE_COMPEN_BLOCK_BUR and p_opercode='ACT_DEP' then
          raise_application_error(-20000, '��������������� ����� ���������� � ��''���� � ������ ���������!');
        end if;
        if l_portfolio.status = STATE_COMPEN_BLOCK_BUR and p_opercode='ACT_BUR' and l_portfolio.rnk is not null then
          raise_application_error(-20000, '��������������� ����� �������������! �������� ������� ������� �����������');
        end if;
        if l_portfolio.status != STATE_COMPEN_BLOCK_BUR and p_opercode='ACT_BUR' then
          raise_application_error(-20000, '��������������� ����� ������� �������� ���� ������������ � ��''���� � ������ ���������!');
        end if;

        if p_opercode='ACT_BUR' then
          if l_portfolio.doctype not in (95, 98) then
            raise_application_error(-20000, '�� ����� ������� ������ �������� �� �������� ��� ������');
          end if;

          select count(*)
          into   l_cnt
          from compen_payments_registry r, compen_portfolio p
          where r.rnk = p.rnk_bur and p.dbcode = l_portfolio.dbcode
            and r.state_id in (STATE_REG_SEND_OK, STATE_REG_PAY_COMPLETED);

          if l_cnt > 0 then
            raise_application_error(-20000, '��� ��������� ������ �� ������� �� �������� ��� ������, ��������� ���������� �� �������');
          end if;

          begin
            select t.rnk_bur
              into l_rnk_bur
            from compen_portfolio t
            where t.dbcode = l_portfolio.dbcode
              and t.rnk_bur is not null
            group by t.rnk_bur;

            if l_rnk_bur != p_rnk then
              raise_application_error(-20000, '���� ���� ����� �� ������ ������ ������� �� ��������� �� ������ �������� ��� ������');
            end if;

            exception
              when no_data_found then null;
              when too_many_rows then
                raise_application_error(-20000, '���� ���� ����� �� ������ ������ ������� �� ��������� �� ������ �������� ��� ������');
          end;
        end if;

        update compen_portfolio t
           set t.rnk = case
                         when p_opercode = 'ACT_BUR' then
                          t.rnk
                         else
                          p_rnk
                       end, --���� �� ��������� �� �������� ����
               t.branchact = case
                               when  p_opercode = 'ACT_BUR' then
                                 t.branchact
                               else
                                 sys_context('bars_context', 'user_branch')
                             end,
/*               t.branch_crkr = case
                                 when  p_opercode = 'ACT_BUR' then
                                   t.branch_crkr
                                 else
                                   sys_context('bars_context', 'user_branch')
                               end,   */
               --����'���� ���������� � ������ � ������ ��볺���
               t.rnk_bur = case
                         when p_opercode = 'ACT_BUR' then
                           p_rnk
                         else
                           t.rnk_bur
                       end,
               t.branchact_bur = case
                                   when  p_opercode = 'ACT_BUR' then
                                     sys_context('bars_context', 'user_branch')
                                   else
                                     t.branchact_bur
                                  end,
/*               t.ob22 = case when t.ob22 = '01' then '23'
                             else t.ob22
                        end,       �� ����������������� */
               t.datl      = sysdate
         where t.id = p_compenid
        returning t.rnk, t.branchact, t.rnk_bur, t.branchact_bur, t.branch_crkr, t.ob22, t.datl into l_portfolio.rnk, l_portfolio.branchact, l_portfolio.rnk_bur, l_portfolio.branchact_bur, l_portfolio.branch_crkr, l_portfolio.ob22, l_portfolio.datl;


        if p_opercode = 'ACT_BUR' then
            l_amount := get_payment_bur_lim_dbcode(l_portfolio.dbcode);
            l_amount := least(l_amount, l_portfolio.ost);
          else
            l_amount := l_portfolio.ost;
        end if;
        l_oper_id := i_compen_oper(p_opercode,
                                   p_compenid,
                                   null,
                                   p_rnk,
                                   l_amount,
                                   null,
                                   null,
                                   null);
        --set_oper_status(l_oper_id, /**/STATE_OPER_COMPLETED); --�������� ������� ������ ���������!!!!!
        --set_oper_status(l_oper_id, /**/STATE_OPER_WAIT_CONFIRM); --������� ���� ������ ����������� � ³������� ���� ���������
        i_row_portfolio_upd(l_portfolio);

      end if;
      --���� �� ����� �볺��� ��� ��� ����������� ����� ������� ��
      cancel_reg_pay(p_rnk, 'PAY_'||substr(p_opercode, 5), ' ��� ��������� ������������� ������');
      l_planned_day := get_planned_day;
      update compen_clients c
      set c.date_val_reg = l_planned_day,
          c.open_cl = sysdate
      where c.rnk = p_rnk;
      if sql%rowcount > 0 then
        begin
          select *
          into l_customer_crkr_update_old
          from customer_crkr_update where id = (select max(id) from customer_crkr_update where rnk = p_rnk);

          l_customer_crkr_update_new     := l_customer_crkr_update_old;
          select t.fio into l_fio from staff$base t where t.id = user_id();

          l_customer_crkr_update_new.date_val_reg     := l_planned_day;
          l_customer_crkr_update_new.id               := s_customer_crkr_update.nextval;
          l_customer_crkr_update_new.user_id          := user_id();
          l_customer_crkr_update_new.user_fio         := l_fio;
          l_customer_crkr_update_new.lastedit         := sysdate;
          l_customer_crkr_update_new.change_info      := analiz_change_client(l_customer_crkr_update_old, l_customer_crkr_update_new);
          insert into customer_crkr_update
          values l_customer_crkr_update_new;
        exception
          when no_data_found then
            null;
        end;
      end if;

    else
      if p_opercode = 'ACT_DEP' then
        if l_portfolio.rnk = p_rnk then
              raise_application_error(-20000,
                              '������������: ����� id=' || p_compenid ||
                              ' ��� ������������� ��� �볺���� ' ||
                              l_portfolio.rnk);
        end if;
        --����� ��� ����� ��������������
        raise_application_error(-20000,
                              '����� id=' || p_compenid ||
                              ' �������� ������ �볺��� RNK=' ||
                              l_portfolio.rnk);

      end if;
      if p_opercode = 'ACT_BUR' then
        if l_portfolio.rnk_bur = p_rnk then
              raise_application_error(-20000,
                              '������������: ����� id=' || p_compenid ||
                              ' ��� ����''������ �� ������� �� ��������� �� ����� �볺��� ' ||
                              l_portfolio.rnk);
        end if;
        --
        raise_application_error(-20000,
                              '����� id=' || p_compenid ||
                              ' �������� ������ ���������� �� ��������� RNK=' ||
                              l_portfolio.rnk_bur);

      end if;


    end if;
  exception
    when ora_lock then
      raise_application_error(-20000,
                              '����� ' || p_compenid ||
                              ' ����������� ����� ������������');
  end;

  procedure actualization_compen(p_rnk in number, p_compenid in number) is
  begin
    actualization_compen(p_rnk, p_compenid, 'ACT_DEP');
  end;

  procedure set_registry_status(p_reg_id   compen_payments_registry.reg_id%type,
                                p_state_id compen_payments_registry.state_id%type,
                                p_msg      compen_payments_registry.msg%type default null,
                                p_ref      compen_payments_registry.ref_oper%type default null)
    is
    l_state_id         compen_payments_registry.state_id%type;
  begin
    select state_id into l_state_id from compen_payments_registry where reg_id = p_reg_id;
    if l_state_id != p_state_id then
        if p_state_id = STATE_REG_PAY_COMPLETED then
          for cur in (select o.oper_id from compen_oper o
                      where o.reg_id = p_reg_id and o.oper_type in (TYPE_OPER_PAY_DEP, TYPE_OPER_PAY_BUR))
          loop
            set_oper_status(cur.oper_id, STATE_OPER_COMPLETED);
          end loop;
        end if;
        if p_state_id = STATE_REG_PAY_CANCELED then
          for cur in (select o.oper_id from compen_oper o
                      where o.reg_id = p_reg_id and o.oper_type in (TYPE_OPER_PAY_DEP, TYPE_OPER_PAY_BUR))
          loop
            set_oper_status(cur.oper_id, STATE_OPER_CANCELED);
          end loop;
        end if;

        update compen_payments_registry
           set state_id   = p_state_id,
               msg        = p_msg,
               changedate = sysdate,
               ref_oper   = case when p_ref is null then ref_oper else p_ref end,
               user_id_send = case when p_state_id = STATE_REG_INITIAL then user_id() else user_id_send end
         where reg_id = p_reg_id;
         --������?
    end if;
  end;
    --���� � ������ ������� ��� �� ������� � ��� ������� �� �� �볺���, �������� ���������� � ������(��� ���������)
  procedure cancel_reg_pay(p_rnk        in number,
                           p_regcode    varchar2,
                           p_add_msg    varchar2) is
    l_reg_type      compen_payments_registry.type_id%type := get_reg_type_id(p_regcode);
    l_oper_type     compen_oper.oper_type%type := get_oper_type_id(p_regcode);
--    l_opertype_act  compen_oper.oper_type%type := get_oper_type_id('ACT' || substr(p_regcode,4));
    l_oper_type_act_arr number_list := number_list();

    procedure del_from_reg(p_reg_id compen_payments_registry.reg_id%type) is
    begin
        --�������� �������� �� � ������ ��� ���������� (�������� ������ ������� �� ������)
        delete from compen_oper
        where reg_id = p_reg_id
         and state = STATE_OPER_NEW
         and oper_type = l_oper_type;
        --����� ������ ��� ��������� � ����� (�������� �����������)
        update compen_oper
           set reg_id = null,
              changedate = sysdate
        where reg_id = p_reg_id
         and oper_type in  (select value(tt) from table(l_oper_type_act_arr) tt);
        --������ STATE_REG_NEW � STATE_REG_SEND_ERR � STATE_REG_FORM_ERR
        delete from compen_payments_registry where reg_id = p_reg_id and state_id in (STATE_REG_NEW, STATE_REG_SEND_ERR, STATE_REG_FORM_ERR);
        --�������� ��� STATE_REG_PAY_BLOCK
        update compen_payments_registry set amount = 0, changedate = sysdate, msg = '���� ���������'
         where reg_id = p_reg_id and state_id = STATE_REG_PAY_BLOCK;
    end;
    --���������� �������
    procedure cancel_oper_grc(p_reg_id compen_payments_registry.reg_id%type)
    is
      l_answ varchar2(2000);
    begin
      l_answ := send_cancel_oper(p_reg_id);
      if substr(l_answ,1,1) = '*' then
        if l_answ like '%DOC-00033 ������ ���������� ������%' then
          --�������� � ��� ��� ����� ���������
          set_registry_status(p_reg_id, STATE_REG_PAY_CANCELED, '³���� ������� '||p_add_msg);
          --����� ������ ��� ��������� � ����� (�������� �����������)
          update compen_oper
             set reg_id = null,
                changedate = sysdate
          where reg_id = p_reg_id
           and oper_type in  (select value(tt) from table(l_oper_type_act_arr) tt);
          else
            raise_application_error(-20000, '������� ������� ��� �������� ���������� �� ���� ������� � ���. ' ||
                                      l_answ);
        end if;
        elsif l_answ = '-1' then
          set_registry_status(p_reg_id, STATE_REG_PAY_CANCELED, '³���� ������� '||p_add_msg);
          --����� ������ ��� ��������� � ����� (�������� �����������)
          update compen_oper
             set reg_id = null,
                changedate = sysdate
          where reg_id = p_reg_id
           and oper_type in  (select value(tt) from table(l_oper_type_act_arr) tt);
        elsif to_number(l_answ) >= 5 then
          set_registry_status(p_reg_id, STATE_REG_PAY_COMPLETED);
      end if;
    end;
  begin
    if p_regcode = 'PAY_BUR' then
       l_oper_type_act_arr.extend;l_oper_type_act_arr(l_oper_type_act_arr.last) :=  TYPE_OPER_ACT_BUR ;
         else
          l_oper_type_act_arr.extend;l_oper_type_act_arr(l_oper_type_act_arr.last) :=  TYPE_OPER_ACT_DEP ;
          l_oper_type_act_arr.extend;l_oper_type_act_arr(l_oper_type_act_arr.last) :=  TYPE_OPER_ACT_HER ;
    end if;

    for cur in (select * from compen_payments_registry r where r.rnk = p_rnk and r.type_id = l_reg_type for update nowait)
    loop
      case cur.state_id
        when STATE_REG_PAY_COMPLETED then null;--����� �� ������, ����� ��� �������
        when STATE_REG_NEW         then del_from_reg(cur.reg_id);
        when STATE_REG_SEND_ERR    then del_from_reg(cur.reg_id);
        when STATE_REG_FORM_ERR    then del_from_reg(cur.reg_id);
        when STATE_REG_PAY_BLOCK   then del_from_reg(cur.reg_id);
        when STATE_REG_SEND_OK     then cancel_oper_grc(cur.reg_id);
        when STATE_REG_INITIAL     then raise_application_error(-20000, '���������� �������� ���������� � ���. ��������� ������� �������� �����...');
        when STATE_REG_PAY_CANCELED then null;--����� �� ������, ��� � ��� ����� ����
      end case;
    end loop;
  end;

  procedure deactualization_compen(p_rnk         in number,
                                   p_compen_list in number_list default number_list(),
                                   p_opercode in varchar2 default 'ACT_DEP') is
    l_oper_id compen_oper.oper_id%type;

    l_oper_ref compen_oper.ref_id%type;
    l_err      varchar2(32767);

    l_cnt      pls_integer;

    l_amount    compen_oper.amount%type;

    l_oper_arr_id number_list := number_list();

    ora_lock exception;
    pragma exception_init(ora_lock, -54);

  begin
    if p_compen_list.count = 0 then
      raise_application_error(-20000, '���������� �� ���� ����� ��� ����� �����������');
    end if;

    --���� � ������ ������� ��� �� ������� � ��� ������� �� �� �볺���, �������� ���������� � ������(��� ���������)
    case p_opercode
      when 'ACT_DEP' then cancel_reg_pay(p_rnk,'PAY_DEP',' ���� �����������');
      when 'ACT_BUR' then cancel_reg_pay(p_rnk,'PAY_BUR',' ���� �����������');
    end case;


      bars_audit.info('deactualization_compen' || 'Start. Manually');
      for c_com in (select *
                      from compen_portfolio
                     where (rnk = p_rnk or rnk_bur = p_rnk)
                       and id in
                           (select value(tt) from table(p_compen_list) tt)
                       for update nowait) loop

        --�������� ������� ��������� ��������
        if (p_opercode = 'ACT_DEP' and c_com.rnk != p_rnk) or (p_opercode = 'ACT_BUR' and c_com.rnk_bur != p_rnk) then
          raise_application_error(-20000, '�������� p_opercode �������� ������');
        end if;

        if p_opercode = 'ACT_BUR' then
          l_oper_arr_id.extend;l_oper_arr_id(l_oper_arr_id.last) :=  TYPE_OPER_ACT_BUR ;
          else
            l_oper_arr_id.extend;l_oper_arr_id(l_oper_arr_id.last) :=  TYPE_OPER_ACT_DEP ;
            l_oper_arr_id.extend;l_oper_arr_id(l_oper_arr_id.last) :=  TYPE_OPER_ACT_HER ;
        end if;
        select count(*) into l_cnt
        from compen_oper o where o.compen_id = c_com.id and o.oper_type in  (select value(tt) from table(l_oper_arr_id) tt)
                             and o.state not in (STATE_OPER_CANCELED, STATE_OPER_COMPLETED);

        if l_cnt > 0 then
          raise_application_error(-20000, '���� ����������� �������� �����������. �� �������� ������� ��������� ��� �������');
        end if;

        if p_opercode = 'ACT_BUR' then
            select o.amount into l_amount
            from compen_oper o where o.oper_id = (select max(co.oper_id) from compen_oper co where co.compen_id = c_com.id and co.rnk = p_rnk and co.oper_type = TYPE_OPER_ACT_BUR and co.state = STATE_OPER_COMPLETED);
            --���� ���� ������� �� ��������� �� ������� �������� ����������� 0
          else
            l_amount := c_com.ost;
        end if;
        if l_amount > 0 then
          l_oper_ref := send_info_deactual(substr(c_com.branch_crkr, 1, 8),
                                           case when  p_opercode = 'ACT_BUR' then substr(c_com.branchact_bur, 1, 8) else   substr(c_com.branchact, 1, 8) end,
                                           l_amount,
                                           l_err);
          if l_oper_ref is null or l_oper_ref = -1 then
            bars_audit.error('crkr_compen_web.deactualization_compen:  error:'||substr(l_err, 1, 3000));
            raise_application_error(-20000,
                                    '������� ������� ��� �������� ���������� �� ���� ����������� � ���. ' ||
                                    l_err);
          end if;
        end if;


        l_oper_id := i_compen_oper('DEACT_'||substr(p_opercode, 5),
                                   c_com.id,
                                   null,
                                   p_rnk,
                                   l_amount,
                                   '',
                                   null,
                                   l_oper_ref);

        update compen_portfolio
           set rnk = case
                         when p_opercode = 'ACT_BUR' then
                          rnk
                         else
                          null
                       end,
               branchact = case
                               when  p_opercode = 'ACT_BUR' then
                                 branchact
                               else
                                 null
                             end,
               rnk_bur = case
                         when p_opercode = 'ACT_BUR' then
                           null
                         else
                           rnk_bur
                       end,
               branchact_bur = case
                                   when  p_opercode = 'ACT_BUR' then
                                     null
                                   else
                                     branchact_bur
                                  end,
               ob22 = case when ob22 = '23' and p_opercode = 'ACT_DEP' then '01'
                             else ob22
                      end,
               datl = sysdate
         where id = c_com.id
        returning rnk, branchact, rnk_bur, branchact_bur, ob22, datl into c_com.rnk, c_com.branchact, c_com.rnk_bur, c_com.branchact_bur, c_com.ob22, c_com.datl;
        i_row_portfolio_upd(c_com);

        set_oper_status(l_oper_id, STATE_OPER_COMPLETED);

      end loop;

  exception
    when ora_lock then
      raise_application_error(-20000,
                              '�볺�� RNK =' || p_rnk ||
                              ' �������������� ����� ������������');
  end;

  --����� �� ������������� ������
  --           p_opercode:
  --                          REQ_DEACT_DEP - ����� �� ����� ����������� ��������������� ������
  --                          REQ_DEACT_BUR - ����� �� ����� ����������� ��������������� ������ �� ���������
  procedure request_deactualization_compen(p_rnk         in number,
                                           p_compen_list in number_list default number_list(),
                                           p_opercode    in varchar2 default 'REQ_DEACT_DEP',
                                           p_reason      in varchar2 default null
                                           ) is
    l_oper_id        compen_oper.oper_id%type;
    l_oper_type_id   compen_oper_types.type_id%type := get_oper_type_id(p_opercode);

    l_oper_ref       compen_oper.ref_id%type;
    l_err            varchar2(32767);

    l_amount         compen_oper.amount%type;

    l_cnt            pls_integer;

    ora_lock exception;
    pragma exception_init(ora_lock, -54);

  begin
    if p_compen_list.count = 0 then
      raise_application_error(-20000, '���������� �� ���� ����� ��� ������ �� ����� �����������');
    end if;

    if p_opercode not in ('REQ_DEACT_DEP', 'REQ_DEACT_BUR') then
      raise_application_error(-20000, '������ ������� ��� ��������, ��������� REQ_DEACT_DEP ��� REQ_DEACT_BUR');
    end if;

    for c_com in (select *
                      from compen_portfolio
                     where (rnk = p_rnk or rnk_bur = p_rnk)
                       and id in
                           (select value(tt) from table(p_compen_list) tt)
                       for update nowait) loop
      --�������� ������� ��������� ��������
      if (p_opercode = 'REQ_DEACT_DEP' and c_com.rnk != p_rnk) or (p_opercode = 'REQ_DEACT_BUR' and c_com.rnk_bur != p_rnk) then
        raise_application_error(-20000, '�������� p_opercode �������� ������');
      end if;
      --�������� �� � ����� ������������ ����� �����������
      select count(*) into l_cnt
      from compen_oper o
      where o.rnk = p_rnk and o.compen_id = c_com.id and o.oper_type = l_oper_type_id and o.state not in (STATE_OPER_CANCELED, STATE_OPER_COMPLETED);
      if l_cnt > 0 then
        raise_application_error(-20000, '�� ������ '||c_com.id||' ���� ������������ ����� �� ����� �����������');
      end if;
      --�������� �� � ����������� ����������
      select count(*) into l_cnt
      from compen_oper o
      where o.rnk = p_rnk and o.compen_id = c_com.id and o.oper_type = decode(l_oper_type_id, TYPE_OPER_REQ_DEACT_DEP, TYPE_OPER_ACT_DEP, TYPE_OPER_ACT_BUR) and o.state not in (STATE_OPER_CANCELED, STATE_OPER_COMPLETED);
      if l_cnt > 0 then
        raise_application_error(-20000, '�� ������ '||c_com.id||' ���� ����������� �����������. ������� ������� ��� ��������� ������ �����������');
      end if;

      if p_opercode = 'REQ_DEACT_BUR' then
            select o.amount into l_amount
            from compen_oper o where o.oper_id = (select max(co.oper_id) from compen_oper co where co.compen_id = c_com.id and co.rnk = p_rnk and co.oper_type = TYPE_OPER_ACT_BUR and co.state = STATE_OPER_COMPLETED);
            --���� ���� ������� �� ��������� �� ������� �������� ����������� 0
          else
            l_amount := c_com.ost;
      end if;


      l_oper_id := i_compen_oper(p_opercode,
                                   c_com.id,
                                   null,
                                   p_rnk,
                                   l_amount,
                                   p_reason,
                                   null,
                                   null);


      set_oper_status(l_oper_id, STATE_OPER_WAIT_CONFIRM); --����� �� ��� ����������

    end loop;

  exception
    when ora_lock then
      raise_application_error(-20000,
                              '�볺�� RNK =' || p_rnk ||
                              ' ������������ ����� ������������');
  end;



  -- ������� �� �������������� ������� (����� ������)
  --           p_opercode:
  --                          PAY_DEP - ������� ��������������� ������
  --                          PAY_BUR - ������� ��������������� ������ �� ���������
  function payment_compen(p_rnk      in number,
                          p_amount   in number,
                          p_opercode in varchar2,
                          p_dbcode   in varchar2 default null) return integer is
    l_payment_max number;
    l_id          compen_payments_registry.reg_id%type;
    l_regtype     compen_payments_registry.type_id%type := get_reg_type_id(p_opercode);
    l_client      compen_clients%rowtype;

    l_msg         compen_payments_registry.msg%type;
    l_branch_act  customer.branch%type;
    l_okpo        customer.okpo%type;

  begin
    if p_opercode not in ('PAY_DEP', 'PAY_BUR') then
      raise_application_error(-20000,
                              '�������� p_opercode ������� ������');
    end if;
    if p_amount is null then
      raise_application_error(-20000,
                              '������������� p_amount');
    end if;
/*
--!�� ��� ����� ����������� ..���� ��� ������ ������� �������� ����������� ����
    case p_opercode
      when 'PAY_DEP' then
        l_payment_max := get_payment_amount(p_rnk); --���� ������� � ������������� ���������� ���������
      when 'PAY_BUR' then
        l_payment_max := get_payment_bur_amount(p_rnk);
    end case;

    if p_amount > l_payment_max then
      raise_application_error(-20000,
                              '��� �볺��� rnk=' || p_rnk ||
                              ' ����������� ���� ������: ' || l_payment_max);
    end if;
--!
*/
    select * into l_client from compen_clients c where c.rnk = p_rnk;
    if l_client.mfo is null or l_client.nls is null then
      l_msg := '������� �����, �� �� �볺��� �� ������� ��� ��� �������';
    end if;
    select branch, okpo into l_branch_act, l_okpo from customer where rnk = p_rnk;--�� �볺�� �������������

    begin
      --���� ����� �� �볺��� ��� ������������� ��� ������������ ������ �� �������, �� ������� ����
      --� � �� ������������ ��� ���� ������� ��� ������� (���� �������� ��������)
      select r.reg_id
        into l_id
        from compen_payments_registry r
       where r.rnk = p_rnk
         and r.type_id = l_regtype
         and nvl(r.dbcode,'-0') = nvl(p_dbcode,'-0')
         and r.state_id in (STATE_REG_NEW, STATE_REG_PAY_BLOCK, STATE_REG_SEND_ERR)
         for update;

      -- ��� p_amount -1 ���� �� �����
      update compen_payments_registry r
         set r.amount     =  case when p_amount = -1 then r.amount else p_amount end,
             r.mfo_client = l_client.mfo,
             r.nls        = l_client.nls,
             r.okpo       = nvl(l_client.okpo, l_okpo), --���� �����������, �� �� ���� ������, � ������ ������� ��� �볺���
             r.msg        = l_msg,
             r.date_val_reg = l_client.date_val_reg,
             r.changedate = sysdate
       where r.reg_id = l_id;

    exception
      when NO_DATA_FOUND then
        l_id := s_compen_payments_registry.nextval;
        insert into compen_payments_registry
          (reg_id, rnk, amount, state_id, type_id, mfo_client, nls, okpo, kv, msg, branch_act, dbcode, date_val_reg)
        values
          (l_id,
           p_rnk,
           case when p_amount = -1 then 0 else p_amount end,
           STATE_REG_NEW,
           l_regtype,
           l_client.mfo,
           l_client.nls,
           nvl(l_client.okpo, l_okpo),
           980,
           l_msg,
           l_branch_act,
           p_dbcode,
           l_client.date_val_reg);
      when TOO_MANY_ROWS then
        raise_application_error(-20000,
                                '�������� ����� ������ ��� ����������� ��� ���������: rnk='||p_rnk||' regtype='||l_regtype||' dbcode='||p_dbcode);

    end;

    --������

    return l_id;
  end;

  --���������� ����� �� ����� ������������� �������
  --           p_opercode:
  --                          PAY_DEP - ���������� ����� �� ������� ���������������� ������
  --                          PAY_BUR - ���������� ����� �� ������� ���������������� ������ �� ���������
  procedure create_payments_registry(p_opercode    compen_oper_types.oper_code%type default 'PAY_DEP',
                                     p_data_from   compen_clients.date_val_reg%type,
                                     p_date_to     compen_clients.date_val_reg%type) is
    l_id            compen_oper.oper_id%type;
    l_amount        compen_oper.amount%type;
    l_amount_max    compen_oper.amount%type;
    l_opertypes_act number_list := number_list();
    l_opertype      compen_oper.oper_type%type := get_oper_type_id(p_opercode);

    l_reg_id       compen_payments_registry.reg_id%type;
    l_dbcode_sum   t_arr_dbcode_sum;--���������� ���� �� ����� ��������

    l_portfolio    compen_portfolio%rowtype;

    indx           varchar2(32);
  begin
    if p_opercode not in ('PAY_DEP', 'PAY_BUR') then
      raise_application_error(-20000,
                              '�������� p_opercode ������� ������');
    end if;

    if p_opercode = 'PAY_BUR' then
      l_opertypes_act.extend;l_opertypes_act(l_opertypes_act.last) := TYPE_OPER_ACT_BUR;
      else
        l_opertypes_act.extend;l_opertypes_act(l_opertypes_act.last) := TYPE_OPER_ACT_DEP;
        l_opertypes_act.extend;l_opertypes_act(l_opertypes_act.last) := TYPE_OPER_ACT_HER;
    end if;

    --����� ����� ����������� ������
    for cur in (select co.rnk
                  from compen_oper co, compen_clients c
                 where co.rnk = c.rnk and c.date_val_reg between p_data_from and p_date_to
                   and co.oper_type in (select value(t) from table(l_opertypes_act) t)
                   and co.state = STATE_OPER_COMPLETED
                   and co.reg_id is null --� ����� ���������
                 group by co.rnk) loop



      if p_opercode = 'PAY_DEP' then
        l_amount_max := get_payment_amount(cur.rnk) * 100; --���� ������� � ������������� ���������� ���������
        l_amount := l_amount_max;

        --����� ������� (��������, ��� �������� ���� ��� � � ������ ����(+������� ��� ��������) ��� ����������� �� ������� )
        l_reg_id := payment_compen(cur.rnk, l_amount, p_opercode);

        --�������� �������� �� � ������ ��� ����������
        delete from compen_oper
        where reg_id = l_reg_id
         and state = STATE_OPER_NEW
         and oper_type = l_opertype;

        --�������� �� ������ ����������� ������ �� �볺���
        --� ��������� ������ � ������ � ��������� �����
        for cur_compen in (select p.id, p.ost
                             from compen_portfolio p, compen_oper o
                            where p.id = o.compen_id and o.oper_type in (select value(t) from table(l_opertypes_act) t) and o.state = STATE_OPER_COMPLETED
                              and p.rnk = cur.rnk
                              and p.status = STATE_COMPEN_OPEN
                            order by p.ost asc) loop
          if l_amount > 0 then
            if l_amount > cur_compen.ost then
              l_amount := l_amount - cur_compen.ost;
              l_id     := i_compen_oper(p_opercode,
                                        cur_compen.id,
                                        null,
                                        cur.rnk,
                                        cur_compen.ost,
                                        null,
                                        l_reg_id);
            else
              l_id     := i_compen_oper(p_opercode,
                                        cur_compen.id,
                                        null,
                                        cur.rnk,
                                        l_amount,
                                        null,
                                        l_reg_id);
              l_amount := 0;
            end if;
          end if;
        end loop;

              --����������� �� ����������� ��� ��������
       update compen_oper
         set changedate = sysdate,
             reg_id     = l_reg_id
       where rnk = cur.rnk--�� ����� �볺���
         and oper_type in (select value(t) from table(l_opertypes_act) t)
         and state = STATE_OPER_COMPLETED
         and reg_id is null; --� ����� ���������

      end if;--'PAY_DEP'
      if p_opercode = 'PAY_BUR' then
        --���� �����. � ������������ ������ ������ � ����� �� ����� � ��� ����� ���������� �����...
        --�� ��������� ��� ����� � �� ��� ���� � ����� �� �� �� ������ ������������
        --���� ��� ������� � ������ ������������� �� �� ���� ����������� �� ���������
        --���� ������ ���� �������� �� �������� ������� ����� ��������(����� �������� ������� ������� � ������)
        l_amount_max := get_payment_bur_amount(cur.rnk, l_dbcode_sum);
        l_amount := l_amount_max;
        if l_dbcode_sum.count > 0 then
          indx := l_dbcode_sum.FIRST;
          while indx is not null
          loop
            l_amount := l_dbcode_sum(indx);
            --����� ������� (��������, ��� �������� ���� ��� � � ������ ����(+������� ��� ��������) ��� ����������� �� ������� )
            l_reg_id := payment_compen(cur.rnk, l_amount, p_opercode, indx);

            for cur_compen in (select p.id, p.ost, o.amount, o.oper_id
                                 from compen_portfolio p, compen_oper o
                                where p.id = o.compen_id and o.oper_type = TYPE_OPER_ACT_BUR and o.state = STATE_OPER_COMPLETED and o.reg_id is null
                                  and p.status = STATE_COMPEN_BLOCK_BUR
                                  and p.dbcode = indx
                                for update of o.oper_id
                                ) loop
              if l_amount > 0 then
                if cur_compen.ost < cur_compen.amount then
                    --������ �� �� ���� � ������� ����� �� �����
                    set_registry_status(l_reg_id, STATE_REG_FORM_ERR, '������� �� ����� '||cur_compen.id||' ����� �� ����������� ��� �����������');
                  else
                      l_amount := l_amount - cur_compen.amount;
                      l_id     := i_compen_oper(p_opercode,
                                                cur_compen.id,
                                                null,
                                                cur.rnk,
                                                cur_compen.amount,
                                                null,
                                                l_reg_id);
                end if;
              end if;
              --����������� �� ����������� ���������
              update compen_oper
                 set changedate = sysdate,
                     reg_id     = l_reg_id
               where oper_id = cur_compen.oper_id;

            end loop;
            indx := l_dbcode_sum.NEXT(indx);
          end loop;
        end if;
      end if;

      if l_amount > 0 then
        null; --���� ���������� ��������� �����, �� ��� ������������ ����� ��� � � �볺��� �� ��� ��������
        raise_application_error(-20000,
                                '�������� ������� ������: ����������� ���� ��� ������� ����� ��� � �� ��������');
      end if;

      --������?

    end loop;

  end;

  --��������� ������ ������� � �� ��� ���� ���������
  procedure get_payments_compen_xml(p_regcode     varchar2,
                                     p_data_from   compen_payments_registry.date_val_reg%type,
                                     p_date_to     compen_payments_registry.date_val_reg%type,
                                     p_sum         OUT number,
                                     p_cnt         OUT number) is
    l_reg_type  compen_payments_registry.type_id%type := get_reg_type_id(p_regcode);
  begin
    select count(*) , sum(r.amount) / 100
      into p_cnt, p_sum
      from compen_payments_registry r
      --����� ������ ���� ����� ��� ���� � ���
     where r.state_id in (STATE_REG_NEW, STATE_REG_SEND_ERR) --��� �� �� ���� ���� ������� ��� ��������
       and r.type_id = l_reg_type
       and r.amount > 0
       and r.date_val_reg between p_data_from and p_date_to;
  end;

  --��������� �������(���������) � ��� (xml)
  --           p_regcode:
  --                          PAY_DEP - ������������� ������
  --                          PAY_BUR - ������������� ������ �� ���������
  procedure send_payments_compen_xml(p_regcode     varchar2,
                                     p_data_from   compen_payments_registry.date_val_reg%type,
                                     p_date_to     compen_payments_registry.date_val_reg%type,
                                     p_sum         OUT number,
                                     p_cnt         OUT number) is
    l_clob clob;

    type t_compen_payment is record(
      id     compen_payments_registry.reg_id%type,
      amount compen_payments_registry.amount%type,
      kv     compen_payments_registry.kv%type,
      mfo    compen_payments_registry.mfo_client%type,
      nls    compen_payments_registry.nls%type,
      ctype  compen_payments_registry.type_id%type,
      okpo   compen_payments_registry.okpo%type,
      ser    varchar2(32), --��� ���� ��� ����� ���� �� �����
      docnum person.numdoc%type,
      fio    compen_clients.fio%type,
      secondary compen_clients.secondary%type,
      sign   raw(2000),
      date_key date
      );
    l_compen_payment t_compen_payment;

    type t_compen_answer is record(
      id  number,
      ref oper.ref%type,
      err varchar2(4000));
    l_compen_answer t_compen_answer;

    l_domdoc    dbms_xmldom.domdocument;
    l_root_node dbms_xmldom.domnode;

    l_supp_element dbms_xmldom.domelement;

    l_sup_node      dbms_xmldom.domnode;
    l_supp_node     dbms_xmldom.domnode;
    l_suppp_node    dbms_xmldom.domnode;
    l_supplier_node dbms_xmldom.domnode;

    l_supp_text dbms_xmldom.domtext;

    l_parser dbms_xmlparser.parser;
    l_doc    dbms_xmldom.domdocument;
    l_rows   dbms_xmldom.domnodelist;
    l_row    dbms_xmldom.domnode;

    l_compen_payments_id   number_list;
    l_compen_oper_id       number_list;
    l_cnt                number default 0;

    l_url_wapp          varchar2(256);
    l_Authorization_val varchar2(256);
    l_walett_path       varchar2(256);
    l_walett_pass       varchar2(256);
    l_action            varchar2(32);
    g_response          wsm_mgr.t_response;
    l_result            varchar2(32767);
    l_timeout           number;

    l_batch_id compen_batch.batch_id%type;
    l_msg      compen_batch.msg%type;

    l_reg_type  compen_payments_registry.type_id%type := get_reg_type_id(p_regcode);
    l_oper_type compen_oper_types.type_id%type := get_oper_type_id(p_regcode);

    l_ignore    boolean;

    l_amount    compen_payments_registry.amount%type;

    l_date      date;
    l_key       ow_keys.key_value%type;
    l_src       varchar2(4000);

    --l_start            number default dbms_utility.get_time;--debug
  begin
    if p_regcode not in ('PAY_DEP', 'PAY_BUR') then
      raise_application_error(-20000,
                              '�������� p_regcode ������� ������');
    end if;
    l_date := trunc(sysdate);
    l_key :=  crypto_utl.get_key_value(l_date,'CRKR_TRANSFER');
    p_sum := 0;
    p_cnt := 0;
    dbms_lob.createtemporary(l_clob, true, dbms_lob.call);
    -- Create an empty XML document
    l_domdoc := dbms_xmldom.newdomdocument;
    -- Create a root node
    l_root_node := dbms_xmldom.makenode(l_domdoc);
    -- Create a new Supplier Node and add it to the root node
    l_sup_node   := dbms_xmldom.appendchild(l_root_node,
                                            dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
                                                                                           'root')));
    l_suppp_node := dbms_xmldom.appendchild(l_sup_node,
                                            dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
                                                                                           'body')));

    select r.reg_id bulk collect
      into l_compen_payments_id
      from compen_payments_registry r
      --����� ������ ���� ����� ��� ���� � ���
     where r.state_id in (STATE_REG_NEW, STATE_REG_SEND_ERR) --��� �� �� ���� ���� ������� ��� ��������
       and r.type_id = l_reg_type
       and r.amount > 0
       and r.date_val_reg between p_data_from and p_date_to
       for update;

    --��������� ������� �������� ��� � ���� ���� ���� �� ������� �� ��� ������ ���������
    select o.oper_id bulk collect
    into l_compen_oper_id
    from compen_oper o
    where o.oper_type = l_oper_type
      and o.reg_id in (select value(t) from table(l_compen_payments_id) t)
    for update;

    --�������� ����� ���� ������ ���������
    l_batch_id := s_compen_batch.nextval;
    insert into compen_batch
      (batch_id, state)
    values
      (l_batch_id, 'CREATE');

    for indx in 1 .. l_compen_payments_id.count loop
      select o.reg_id, o.amount, o.kv, o.mfo_client, o.nls, o.type_id, o.okpo, case when p.passp = 7 then p.eddr_id else  p.ser end, p.numdoc, c.fio, c.secondary, null, l_date
        into l_compen_payment
        from compen_payments_registry o, person p, compen_clients c
       where o.reg_id = l_compen_payments_id(indx)
         and o.rnk    = p.rnk
         and o.rnk    = c.rnk;

       l_ignore := false;
       if l_compen_payment.mfo is null or l_compen_payment.nls is null then --�� ���� ������� ��� ��� ������� �� ������ ���������� ������
          --�������� ��������, ���� ��� �������
          select c.mfo, c.nls, c.okpo
          into l_compen_payment.mfo, l_compen_payment.nls, l_compen_payment.okpo
          from compen_clients c, compen_payments_registry r
          where c.rnk = r.rnk
            and r.reg_id = l_compen_payments_id(indx);

          if l_compen_payment.mfo is null or l_compen_payment.nls is null then--�, ��� � �� �������, ��������
              l_ignore := true;
              update compen_payments_registry o
                 set o.msg = '������������ ��������� �������. �� ������� ��� ��� ������� �볺���'
              where o.reg_id = l_compen_payments_id(indx);
            else
              l_ignore := false;
              --������� �� � �����
              update compen_payments_registry o
                 set o.mfo_client = l_compen_payment.mfo,
                     o.nls        = l_compen_payment.nls,
                     o.okpo       = l_compen_payment.okpo,
                     o.msg        = null
              where o.reg_id = l_compen_payments_id(indx);
          end if;

       end if;

       if not l_ignore then
          l_cnt := l_cnt + 1;

          insert into compen_payments_batch
            (compen_payment_id, batch_id)
          values
            (l_compen_payment.id, l_batch_id);

          --������ � ����� ��� ���������� ������ �� ��� ��� ��������� ���������
          begin
            insert into compen_registry_queue(reg_id) values(l_compen_payment.id);
            exception
              when dup_val_on_index then null;
              when others then raise;
          end;
          --������ ������
          set_registry_status(l_compen_payment.id, STATE_REG_INITIAL);


          l_src := l_compen_payment.id||l_compen_payment.amount||l_compen_payment.kv||l_compen_payment.mfo||l_compen_payment.nls||l_compen_payment.ctype||l_compen_payment.okpo||l_compen_payment.ser||l_compen_payment.docnum||l_compen_payment.fio||l_compen_payment.secondary;
          l_compen_payment.sign := dbms_crypto.mac(src => utl_i18n.string_to_raw(l_src, 'UTF8'),
                                                   typ => dbms_crypto.hmac_sh1,
                                                   key => utl_i18n.string_to_raw(l_key, 'UTF8'));
          -- For each record, create a new Supplier element
          -- and add to the Supplier Parent node
          l_supplier_node := dbms_xmldom.appendchild(l_suppp_node,
                                                     dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
                                                                                                    'row')));

          l_supp_element := dbms_xmldom.createelement(l_domdoc, 'id');
          l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                    dbms_xmldom.makenode(l_supp_element));
          l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
                                                       l_compen_payment.id);
          l_supp_node    := dbms_xmldom.appendchild(l_supp_node,
                                                    dbms_xmldom.makenode(l_supp_text));

          l_supp_element := dbms_xmldom.createelement(l_domdoc, 'amount');
          l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                    dbms_xmldom.makenode(l_supp_element));
          l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
                                                       l_compen_payment.amount);
          l_supp_node    := dbms_xmldom.appendchild(l_supp_node,
                                                    dbms_xmldom.makenode(l_supp_text));

          l_supp_element := dbms_xmldom.createelement(l_domdoc, 'kv');
          l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                    dbms_xmldom.makenode(l_supp_element));
          l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
                                                       l_compen_payment.kv);
          l_supp_node    := dbms_xmldom.appendchild(l_supp_node,
                                                    dbms_xmldom.makenode(l_supp_text));

          l_supp_element := dbms_xmldom.createelement(l_domdoc, 'mfo');
          l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                    dbms_xmldom.makenode(l_supp_element));
          l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
                                                       l_compen_payment.mfo);
          l_supp_node    := dbms_xmldom.appendchild(l_supp_node,
                                                    dbms_xmldom.makenode(l_supp_text));

          l_supp_element := dbms_xmldom.createelement(l_domdoc, 'nls');
          l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                    dbms_xmldom.makenode(l_supp_element));
          l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
                                                       l_compen_payment.nls);
          l_supp_node    := dbms_xmldom.appendchild(l_supp_node,
                                                    dbms_xmldom.makenode(l_supp_text));

          l_supp_element := dbms_xmldom.createelement(l_domdoc, 'ctype');
          l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                    dbms_xmldom.makenode(l_supp_element));
          l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
                                                       l_compen_payment.ctype);
          l_supp_node    := dbms_xmldom.appendchild(l_supp_node,
                                                    dbms_xmldom.makenode(l_supp_text));

          l_supp_element := dbms_xmldom.createelement(l_domdoc, 'ser');
          l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                    dbms_xmldom.makenode(l_supp_element));
          l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
                                                       l_compen_payment.ser);
          l_supp_node    := dbms_xmldom.appendchild(l_supp_node,
                                                    dbms_xmldom.makenode(l_supp_text));

          l_supp_element := dbms_xmldom.createelement(l_domdoc, 'docnum');
          l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                    dbms_xmldom.makenode(l_supp_element));
          l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
                                                       l_compen_payment.docnum);
          l_supp_node    := dbms_xmldom.appendchild(l_supp_node,
                                                    dbms_xmldom.makenode(l_supp_text));

          l_supp_element := dbms_xmldom.createelement(l_domdoc, 'okpo');
          l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                    dbms_xmldom.makenode(l_supp_element));
          l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
                                                       l_compen_payment.okpo);
          l_supp_node    := dbms_xmldom.appendchild(l_supp_node,
                                                    dbms_xmldom.makenode(l_supp_text));

          l_supp_element := dbms_xmldom.createelement(l_domdoc, 'fio');
          l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                    dbms_xmldom.makenode(l_supp_element));
          l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
                                                       l_compen_payment.fio);
          l_supp_node    := dbms_xmldom.appendchild(l_supp_node,
                                                    dbms_xmldom.makenode(l_supp_text));

          l_supp_element := dbms_xmldom.createelement(l_domdoc, 'secondary');
          l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                    dbms_xmldom.makenode(l_supp_element));
          l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
                                                       l_compen_payment.secondary);
          l_supp_node    := dbms_xmldom.appendchild(l_supp_node,
                                                    dbms_xmldom.makenode(l_supp_text));


          l_supp_element := dbms_xmldom.createelement(l_domdoc, 'sign');
          l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                    dbms_xmldom.makenode(l_supp_element));
          l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
                                                       l_compen_payment.sign);
          l_supp_node    := dbms_xmldom.appendchild(l_supp_node,
                                                    dbms_xmldom.makenode(l_supp_text));

          l_supp_element := dbms_xmldom.createelement(l_domdoc, 'date_key');
          l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                    dbms_xmldom.makenode(l_supp_element));
          l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
                                                       to_char(l_compen_payment.date_key,'DDMMYYYY'));
          l_supp_node    := dbms_xmldom.appendchild(l_supp_node,
                                                    dbms_xmldom.makenode(l_supp_text));


       end if;



    end loop;
    commit;--����� ��������� �������� ����� �� ������ �� ����� �� ������ ��������� � ���
    select batch_id into l_batch_id from compen_batch where batch_id = l_batch_id
    for update;

    dbms_xmldom.writetoclob(l_domdoc, l_clob);
    dbms_xmldom.freedocument(l_domdoc);

    --dbms_output.put_line(round( (dbms_utility.get_time-l_start)/100, 2 ) || ' seconds...');--debug
    --dbms_output.put_line('³������������ � ������� '||l_cnt||' � '||l_compen_payments_id.count);--debug
    --dbms_output.put_line('����� LOB: '||dbms_lob.getlength(l_clob));--debug

    --��� ��������� �� ��� ������ xml
    --l_clob := '<?xml version="1.0"?>'||chr(10)||l_clob;

    -- bars_audit.info('_compen.: begin'); ������������� �������?
    get_parameters_web_service(l_url_wapp,
                               l_Authorization_val,
                               l_timeout,
                               l_walett_path,
                               l_walett_pass);
    utl_http.set_transfer_timeout(l_timeout);

    l_action := 'paymentscompen';

    begin
      wsm_mgr.prepare_request(p_url          => l_url_wapp,
                              p_action       => l_action,
                              p_http_method  => wsm_mgr.G_HTTP_POST,
                              p_content_type => wsm_mgr.g_ct_json,
                              p_wallet_path  => l_walett_path,
                              p_wallet_pwd   => l_walett_pass);
      wsm_mgr.add_header(p_name  => 'Authorization',
                         p_value => l_Authorization_val);
      wsm_mgr.add_parameter(p_name => 'p_clob', p_value => l_clob);
      wsm_mgr.execute_request(g_response);
      l_result := g_response.cdoc; -- ���� ���� ����� - � clob �����

      --return; --ҳ�� ������ ������');

      if substr(l_result, 1, 3) in ('400', '401', '404', '500') and length(l_result) > 3 then
        --dbms_output.put_line('l_result=' || substr(l_result, 1, 1024) || '...'); --debug
        bars_audit.error('crkr_compen_web.send_payments_compen_xml: service ' || l_action ||' error:'||substr(l_result, 1, 3000));
        update compen_batch
           set state = 'ERROR', msg = substr(l_result, 1, 1024)
         where batch_id = l_batch_id;
        --��������� � �������� ������
        for cur in (select reg_id from compen_payments_registry
                     where state_id = STATE_REG_INITIAL
                       and reg_id in (select p.compen_payment_id from compen_payments_batch p where p.batch_id = l_batch_id))
        loop
          set_registry_status(cur.reg_id, STATE_REG_NEW);
        end loop;
        commit;
        raise_application_error(-20000,
                                '��� �������� � ��� �������� �������: ' ||
                                substr(l_result, 1, 255) || '...');
      else
        update compen_batch
           set state = 'SUCCEEDED'
         where batch_id = l_batch_id;
      end if;
    exception
      when others then
        --dbms_output.put_line(sqlerrm || ' - ' || dbms_utility.format_error_backtrace); --debug
        l_msg := substr(sqlerrm || ' - ' || dbms_utility.format_error_backtrace, 1, 1024);
        bars_audit.error('crkr_compen_web.send_payments_compen_xml: service ' || l_action ||' error:'||substr(l_result, 1, 3000));
        update compen_batch
           set state = 'ERROR', msg = l_msg
         where batch_id = l_batch_id;
        --��������� � �������� ������
        for cur in (select reg_id from compen_payments_registry
                     where state_id = STATE_REG_INITIAL
                       and reg_id in (select p.compen_payment_id from compen_payments_batch p where p.batch_id = l_batch_id))
        loop
          set_registry_status(cur.reg_id, STATE_REG_NEW);
        end loop;
        commit;
        raise_application_error(-20000,
                                '��� �������� � ��� �������� �������: ' ||
                                substr(l_msg, 1, 255) || '...');
    end;

    --dbms_output.put_line(round( (dbms_utility.get_time-l_start)/100, 2 ) || ' seconds...');--debug
    --dbms_output.put_line('�������� �������(����� 255 �������): '||substr(l_result, 1, 255));--debug
    --dbms_output.put_line('����� LOB: '||dbms_lob.getlength(l_result));--debug

    --���������� �������
    l_result := replace(l_result, '"', ''); --� ���� ���� ��������� � ������?
    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, l_result);
    l_doc := dbms_xmlparser.getdocument(l_parser);

    l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'row');
    for i in 0 .. dbms_xmldom.getlength(l_rows) - 1 loop
      l_row := dbms_xmldom.item(l_rows, i);

      l_compen_answer.id  := to_number(dbms_xslprocessor.valueof(l_row,
                                                                 'id/text()'));
      l_compen_answer.ref := to_number(dbms_xslprocessor.valueof(l_row,
                                                                 'ref/text()'));

      if l_compen_answer.ref = 0 then
        update compen_payments_registry
           set state_id   = STATE_REG_SEND_OK, --�������� ������� ��� �������� ���������� � ���
               msg   = '����� �� ��������� ��������� � ���',
               changedate = sysdate,
               user_id_send = sys_context('bars_global', 'user_id')
         where reg_id = l_compen_answer.id
         returning amount into l_amount;
        p_sum := p_sum + l_amount / 100;
        p_cnt := p_cnt + 1;
        /*--������� ���'���� ��������
        ������ ��� �������� �� ��������� � ��� �� �����? !!!�"!!
        for cur_oper in (select oper_id from compen_oper
                         where reg_id = l_compen_answer.id
                           and state  = STATE_OPER_NEW
                           and oper_type = l_oper_type
                         )
        loop
          set_oper_status(cur_oper.oper_id, STATE_OPER_WAIT_CONFIRM);
        end loop;*/

      else
        l_compen_answer.err := dbms_xslprocessor.valueof(l_row,
                                                         'err/text()');
        bars_audit.error('crkr_compen_web.send_payments_compen_xml: service ' || l_action ||' REG_ID='||l_compen_answer.id||' error:'||substr(l_compen_answer.err, 1, 3500));
        update compen_payments_registry
           set state_id   = STATE_REG_SEND_ERR, --�������� ������� ��� ������� ��� �������� ���������
               msg        = substr(l_compen_answer.err, 1, 4000),
               changedate = sysdate,
               user_id_send = sys_context('bars_global', 'user_id')
         where reg_id = l_compen_answer.id;
      end if;
      --������

    end loop;

  end;


  --������� ������ �� ��������� ������� ������ � ���
  --For JOB
  procedure request_grc_state_oper
    is

    l_clob clob;

    type t_compen_answer is record(
      reg compen_payments_registry.reg_id%type,
      ref oper.ref%type,
      sos number);
    l_compen_answer t_compen_answer;

    l_domdoc    dbms_xmldom.domdocument;
    l_root_node dbms_xmldom.domnode;

    l_supp_element dbms_xmldom.domelement;

    l_sup_node      dbms_xmldom.domnode;
    l_supp_node     dbms_xmldom.domnode;
    l_suppp_node    dbms_xmldom.domnode;
    l_supplier_node dbms_xmldom.domnode;

    l_supp_text dbms_xmldom.domtext;

    l_parser dbms_xmlparser.parser;
    l_doc    dbms_xmldom.domdocument;
    l_rows   dbms_xmldom.domnodelist;
    l_row    dbms_xmldom.domnode;

    l_arr_compen_req     number_list;
    l_cnt                number default 0;

    l_url_wapp          varchar2(256);
    l_Authorization_val varchar2(256);
    l_walett_path       varchar2(256);
    l_walett_pass       varchar2(256);
    l_action            varchar2(32);
    g_response          wsm_mgr.t_response;
    l_result            varchar2(32767);
    l_timeout           number;

    l_msg      compen_batch.msg%type;

    l_reg_id   compen_payments_registry.reg_id%type;

    --l_start            number default dbms_utility.get_time;--debug

    procedure ok(p_ref compen_payments_registry.ref_oper%type, p_reg compen_payments_registry.reg_id%type)
      is
    begin
      set_registry_status(p_reg, STATE_REG_PAY_COMPLETED,null,p_ref);
      delete from compen_registry_queue where reg_id = p_reg;
    end;
    procedure refuse(p_ref compen_payments_registry.ref_oper%type, p_reg compen_payments_registry.reg_id%type, p_msg compen_payments_registry.msg%type)
      is
    begin
      set_registry_status(p_reg, STATE_REG_PAY_CANCELED, p_msg, p_ref);
      delete from compen_registry_queue where reg_id = p_reg;
    end;
    procedure err(p_reg compen_payments_registry.reg_id%type, p_msg compen_payments_registry.msg%type)
      is
    begin
      set_registry_status(p_reg, STATE_REG_SEND_ERR, p_msg);
      delete from compen_registry_queue where reg_id = p_reg;
    end;
    procedure note(p_ref compen_payments_registry.ref_oper%type, p_reg compen_payments_registry.reg_id%type, p_msg compen_payments_registry.msg%type)
      is
    begin
      update compen_payments_registry r
         set r.msg = p_msg,
             r.changedate = sysdate,
             ref_oper   = p_ref
       where r.reg_id = p_reg;
    end;

  begin


    get_parameters_web_service(l_url_wapp,
                                 l_Authorization_val,
                                 l_timeout,
                                 l_walett_path,
                                 l_walett_pass);
    utl_http.set_transfer_timeout(l_timeout);

    l_action := 'getsosref';

    /* ��������� ������ �����, �� �������, ��� �� �� ������ �� ��������
       - ���������� ������, ��� � �.�.
    */
    for cur in (select * from compen_batch where state = 'CREATE'
                                             /*and create_date < localtimestamp - interval '0 0:10:00' day to second*/
                                              )
    loop
      --����� ������ ������  � ����� ���������� �� �������� � ���
      select compen_payment_id into l_reg_id from compen_payments_batch where batch_id = cur.batch_id
                                                            and rownum < 2;

      dbms_lob.createtemporary(l_clob, true, dbms_lob.call);
      -- Create an empty XML document
      l_domdoc := dbms_xmldom.newdomdocument;
      -- Create a root node
      l_root_node := dbms_xmldom.makenode(l_domdoc);
      -- Create a new Supplier Node and add it to the root node
      l_sup_node   := dbms_xmldom.appendchild(l_root_node,
                                            dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
                                                                                           'root')));
      l_suppp_node := dbms_xmldom.appendchild(l_sup_node,
                                            dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
                                                                                           'body')));
      l_supplier_node := dbms_xmldom.appendchild(l_suppp_node,
                                            dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
                                                                                           'row')));

      l_supp_element := dbms_xmldom.createelement(l_domdoc, 'check_in_batch');
      l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                               dbms_xmldom.makenode(l_supp_element));
      l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
                                                   l_reg_id);
      l_supp_node    := dbms_xmldom.appendchild(l_supp_node,
                                                      dbms_xmldom.makenode(l_supp_text));

      dbms_xmldom.writetoclob(l_domdoc, l_clob);
      dbms_xmldom.freedocument(l_domdoc);

      begin
        wsm_mgr.prepare_request(p_url          => l_url_wapp,
                                p_action       => l_action,
                                p_http_method  => wsm_mgr.G_HTTP_POST,
                                p_content_type => wsm_mgr.g_ct_json,
                                p_wallet_path  => l_walett_path,
                                p_wallet_pwd   => l_walett_pass);
        wsm_mgr.add_header(p_name  => 'Authorization',
                           p_value => l_Authorization_val);
        wsm_mgr.add_parameter(p_name => 'p_clob', p_value => l_clob);
        wsm_mgr.execute_request(g_response);
        l_result := g_response.cdoc; -- ���� ���� ����� - � clob �����

        if substr(l_result, 1, 3) in ('400', '401', '404', '500') and length(l_result) > 3 then
           --dbms_output.put_line('l_result=' || substr(l_result, 1, 1024) || '...'); --debug
           --bars_audit.error(substr(l_result, 1, 4000));
           bars_audit.error('crkr_compen_web.request_grc_state_oper: service ' || l_action ||' error:'||substr(l_result, 1, 3000));
           else
              --���������� �������
              l_result := replace(l_result, '"', ''); --� ���� ���� ��������� � ������?
              l_parser := dbms_xmlparser.newparser;
              dbms_xmlparser.parseclob(l_parser, l_result);
              l_doc := dbms_xmlparser.getdocument(l_parser);

              l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'row');
              l_row := dbms_xmldom.item(l_rows, 0);

              l_compen_answer.sos := to_number(dbms_xslprocessor.valueof(l_row,
                                                                         'sos/text()'));
              if l_compen_answer.sos = 1 then
                update compen_batch b set b.state = 'SUCCEEDED' where b.batch_id = cur.batch_id;
                for cur1 in (select reg_id from compen_payments_registry
                               where state_id = STATE_REG_INITIAL
                                 and reg_id in (select p.compen_payment_id from compen_payments_batch p where p.batch_id = cur.batch_id))
                loop
                  update compen_payments_registry
                       set state_id   = STATE_REG_SEND_OK, --�������� ������� ��� �������� ���������� � ���
                           msg   = '����� �� ��������� ��������� � ���',
                           changedate = sysdate
                     where reg_id = cur1.reg_id;
                    --������� ���'���� ��������
                    for cur_oper in (select oper_id from compen_oper
                                     where reg_id = cur1.reg_id
                                       and state  = STATE_OPER_NEW
                                       and oper_type in (TYPE_OPER_PAY_DEP, TYPE_OPER_PAY_BUR)
                                     )
                    loop
                      set_oper_status(cur_oper.oper_id, STATE_OPER_WAIT_CONFIRM);
                    end loop;
                end loop;

                else
                  update compen_batch b set b.state = 'ERROR', b.msg = '��� ��� ��������' where b.batch_id = cur.batch_id;
                  for cur1 in (select reg_id from compen_payments_registry
                               where state_id = STATE_REG_INITIAL
                                 and reg_id in (select p.compen_payment_id from compen_payments_batch p where p.batch_id = cur.batch_id))
                  loop
                    set_registry_status(cur1.reg_id, STATE_REG_SEND_ERR,'��� ��� ��������');
                    delete from compen_registry_queue r where r.reg_id = cur1.reg_id;
                  end loop;
              end if;
        end if;
      exception
        when others then
          --dbms_output.put_line(sqlerrm || ' - ' || dbms_utility.format_error_backtrace); --debug
          --bars_audit.error(substr(sqlerrm || ' - ' ||dbms_utility.format_error_backtrace, 1, 4000));
          bars_audit.error('crkr_compen_web.request_grc_state_oper: service ' || l_action ||' error:'||substr(sqlerrm || ' - ' ||dbms_utility.format_error_backtrace, 1, 3000));
      end;

    end loop;
    commit;

    --������� �����: ������ �� ������� ������
    dbms_lob.createtemporary(l_clob, true, dbms_lob.call);
    -- Create an empty XML document
    l_domdoc := dbms_xmldom.newdomdocument;
    -- Create a root node
    l_root_node := dbms_xmldom.makenode(l_domdoc);
    -- Create a new Supplier Node and add it to the root node
    l_sup_node   := dbms_xmldom.appendchild(l_root_node,
                                            dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
                                                                                           'root')));
    l_suppp_node := dbms_xmldom.appendchild(l_sup_node,
                                            dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
                                                                                           'body')));

    select r.reg_id bulk collect
      into l_arr_compen_req
      from compen_registry_queue r,
           compen_payments_registry p
      where r.reg_id = p.reg_id
        and r.reg_id not in (select pb.compen_payment_id from compen_payments_batch pb, compen_batch b where pb.batch_id = b.batch_id and b.state = 'CREATE')
      for update;

    if l_arr_compen_req.count > 0 then
      for indx in 1 .. l_arr_compen_req.count loop

            l_cnt := l_cnt + 1;

            -- For each record, create a new Supplier element
            -- and add to the Supplier Parent node
            l_supplier_node := dbms_xmldom.appendchild(l_suppp_node,
                                                       dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
                                                                                                      'row')));

            l_supp_element := dbms_xmldom.createelement(l_domdoc, 'reg');
            l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                      dbms_xmldom.makenode(l_supp_element));
            l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
                                                         l_arr_compen_req(indx));
            l_supp_node    := dbms_xmldom.appendchild(l_supp_node,
                                                      dbms_xmldom.makenode(l_supp_text));

      end loop;

      dbms_xmldom.writetoclob(l_domdoc, l_clob);
      dbms_xmldom.freedocument(l_domdoc);

      --dbms_output.put_line(round( (dbms_utility.get_time-l_start)/100, 2 ) || ' seconds...');--debug
      --dbms_output.put_line('³������������ � ������� '||l_cnt||' � '||l_compen_payments_id.count);--debug
      --dbms_output.put_line('����� LOB: '||dbms_lob.getlength(l_clob));--debug

      --��� ��������� �� ��� ������ xml
      --l_clob := '<?xml version="1.0"?>'||chr(10)||l_clob;

      -- bars_audit.info('_compen.: begin'); ������������� �������?

      begin
        wsm_mgr.prepare_request(p_url          => l_url_wapp,
                                p_action       => l_action,
                                p_http_method  => wsm_mgr.G_HTTP_POST,
                                p_content_type => wsm_mgr.g_ct_json,
                                p_wallet_path  => l_walett_path,
                                p_wallet_pwd   => l_walett_pass);
        wsm_mgr.add_header(p_name  => 'Authorization',
                           p_value => l_Authorization_val);
        wsm_mgr.add_parameter(p_name => 'p_clob', p_value => l_clob);
        wsm_mgr.execute_request(g_response);
        l_result := g_response.cdoc; -- ���� ���� ����� - � clob �����

        if substr(l_result, 1, 3) in ('400', '401', '404', '500') and length(l_result) > 3 then
           --dbms_output.put_line('l_result=' || substr(l_result, 1, 1024) || '...'); --debug
           --bars_audit.error(substr(l_result, 1, 4000));
           bars_audit.error('crkr_compen_web.request_grc_state_oper: service ' || l_action ||' error:'||substr(l_result, 1, 3000));
           return;
        end if;
      exception
        when others then
          --dbms_output.put_line(sqlerrm || ' - ' || dbms_utility.format_error_backtrace); --debug
          --bars_audit.error(substr(sqlerrm || ' - ' ||dbms_utility.format_error_backtrace, 1, 4000));
          bars_audit.error('crkr_compen_web.request_grc_state_oper: service ' || l_action ||' error:'||substr(sqlerrm || ' - ' ||dbms_utility.format_error_backtrace, 1, 3000));
          return;
      end;

      --dbms_output.put_line(round( (dbms_utility.get_time-l_start)/100, 2 ) || ' seconds...');--debug
      --dbms_output.put_line('�������� �������(����� 255 �������): '||substr(l_result, 1, 255));--debug
      --dbms_output.put_line('����� LOB: '||dbms_lob.getlength(l_result));--debug

      --���������� �������
      l_result := replace(l_result, '"', ''); --� ���� ���� ��������� � ������?
      l_parser := dbms_xmlparser.newparser;
      dbms_xmlparser.parseclob(l_parser, l_result);
      l_doc := dbms_xmlparser.getdocument(l_parser);

      l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'row');
      for i in 0 .. dbms_xmldom.getlength(l_rows) - 1 loop
        l_row := dbms_xmldom.item(l_rows, i);
        l_compen_answer.reg := to_number(dbms_xslprocessor.valueof(l_row,
                                                                   'reg/text()'));
        l_compen_answer.ref := to_number(dbms_xslprocessor.valueof(l_row,
                                                                   'ref/text()'));
        l_compen_answer.sos := to_number(dbms_xslprocessor.valueof(l_row,
                                                                   'sos/text()'));

        begin
          case l_compen_answer.sos
            when -100 then null;
            when -102 then refuse(l_compen_answer.ref, l_compen_answer.reg, '��� � ���: �� ���� ������ ������ ������');
            when -9   then refuse(l_compen_answer.ref, l_compen_answer.reg, '��� � ���: �� ���� ��������');
            when -101 then err(l_compen_answer.reg, dbms_xslprocessor.valueof(l_row,'info/text()'));
            when 5 then ok(l_compen_answer.ref, l_compen_answer.reg);
            when 7 then ok(l_compen_answer.ref, l_compen_answer.reg);
            when 0 then note(l_compen_answer.ref, l_compen_answer.reg, null);
            when 1 then note(l_compen_answer.ref, l_compen_answer.reg, null);
            when 3 then note(l_compen_answer.ref, l_compen_answer.reg, null);
            when -1 then refuse(l_compen_answer.ref, l_compen_answer.reg, '�������� ������� � ���');
            else note(l_compen_answer.ref, l_compen_answer.reg, '�������� ���� �������� � ���');
          end case;
          update compen_registry_queue q set q.ref_oper = l_compen_answer.ref, q.last_date_req = sysdate where q.reg_id = l_compen_answer.reg;
          exception when others then
            bars_audit.error('crkr_compen_web.request_grc_state_oper: service ' || l_action ||' error:'||' reg_id='||l_compen_answer.reg||' '||substr(sqlerrm || ' - ' ||dbms_utility.format_error_backtrace, 1, 3000));
       end;

      end loop;

    end if;


  end;

  /*
    --�������� � ������ json � ���������� ������ ²���������

    --  ̳����: - ������ ������� (����� ��-�� �������������� CLOB)
    --          - ������� ���������� �����
    --          ����: 152.39 seconds... ³��������� � ������� 20000 � 20000 ����� LOB: 1538965
    --     ����� xml 17.33 seconds...  ³��������� � ������� 20000 � 20000 ����� LOB: 2838998

    function send_payments_compen_json(p_mfo        compen_payments_registry.mfo%type,
                                      p_branch     varchar2)
    return clob is
      l_clob             clob;

      type t_compen_payment is record (id            compen_payments_registry.id%type,
                                       amount        compen_payments_registry.amount%type,
                                       kv            compen_payments_registry.kv%type,
                                       mfo           compen_payments_registry.mfo%type,
                                       nls           compen_payments_registry.nls%type
                                       );
      l_compen_payment   t_compen_payment;

      l_compen_payments_id  number_list;
      l_cnt              number default 0;
      l_elem             varchar2(1024);

      l_start            number default dbms_utility.get_time;--debug
    begin

      l_clob := '[';

      select id
      bulk collect into l_compen_payments_id
      from compen_payments_registry
      where state = 0
        and (p_mfo is null or p_mfo = mfo)
      for update;

      for indx in 1..l_compen_payments_id.count
      loop

        update compen_payments_registry
        set state = 10
        where id = l_compen_payments_id(indx)
          and state = 0
        returning id, amount, kv, mfo, nls into l_compen_payment;

        if sql%rowcount = 1 then
          if l_cnt > 0 then
            l_clob := l_clob||',';
          end if;
          l_cnt := l_cnt + 1;

          l_elem := '{"id":"'||l_compen_payment.id||'",'
                          ||'"amount":"'||l_compen_payment.amount||'",'
                          ||'"kv":"'||l_compen_payment.kv||'",'
                          ||'"mfo":"'||l_compen_payment.mfo||'",'
                          ||'"nls":"'||l_compen_payment.nls||'"}';
          dbms_lob.writeappend(l_clob,length(l_elem),l_elem);
        end if;

      end loop;
      l_clob := l_clob||']';

      --��� ��������� �� ��� ������ json


      dbms_output.put_line(round( (dbms_utility.get_time-l_start)/100, 2 ) || ' seconds...');--debug
      dbms_output.put_line('³��������� � ������� '||l_cnt||' � '||l_compen_payments_id.count);--debug
      dbms_output.put_line('����� LOB: '||dbms_lob.getlength(l_clob));--debug

      return l_clob;
    end;

  */
  /*
    --���������� ������� �������(������ ���� � ������ ����)
    --  ̳����: - ������ ������� ( ������ PL/JSON)
    --          - ������� ���������� �����
    --          ����: 549.28 seconds...
    --     ����� xml  17.09 seconds...
    function receive_payments_compen_json(p_clob clob) return clob
    is
      l_clob                  clob; --�������

      type t_compen_payment   is record (id           compen_payments_registry.id%type,
                                        amount        compen_payments_registry.amount%type,
                                        kv            compen_payments_registry.kv%type,
                                        mfo           compen_payments_registry.mfo%type,
                                        nls           compen_payments_registry.nls%type
                                        );
      type t_a_compen_payment is table of t_compen_payment;
      l_compen_payments       t_a_compen_payment := t_a_compen_payment();

      l_list                  json_list;

      l_start                 number default dbms_utility.get_time;--debug
    begin

      l_list := json_list(p_clob);

      --l_list.print;--debug

      for i in 1..l_list.count
      loop
        l_compen_payments.extend;
        l_compen_payments(l_compen_payments.last).id := to_number(json_ext.get_string(json(l_list.get(i)),'id'));
        --json(l_list.get(i)).path('id').get_number;
        --json_ext.get_number(json(l_list.get(i)),'id');
        l_compen_payments(l_compen_payments.last).amount := to_number(json_ext.get_string(json(l_list.get(i)),'amount'));
        l_compen_payments(l_compen_payments.last).kv := to_number(json_ext.get_string(json(l_list.get(i)),'kv'));
        l_compen_payments(l_compen_payments.last).mfo := json_ext.get_string(json(l_list.get(i)),'mfo');
        l_compen_payments(l_compen_payments.last).nls := json_ext.get_string(json(l_list.get(i)),'nls');
      end loop;

      dbms_output.put_line(round( (dbms_utility.get_time-l_start)/100, 2 ) || ' seconds...');--debug
      dbms_output.put_line('������ �������� '||l_compen_payments.count||' ������: '||l_compen_payments(1).id||' �� ���� '||l_compen_payments(1).amount||' ������� '||l_compen_payments(1).nls);

      return l_clob;
    end;
  */

  --³�������� � �� ���������� ��� ����������
  procedure send_rebranch(p_summa      in varchar2,
                          p_ob22       in varchar2,
                          p_branchfrom in varchar2,
                          p_branchto   in varchar2,
                          p_err        out varchar2,
                          p_ret        out int) is
    l_url_wapp          varchar2(256);
    l_Authorization_val varchar2(256);
    l_walett_path       varchar2(256);
    l_walett_pass       varchar2(256);
    l_action            varchar2(32);
    g_response          wsm_mgr.t_response;
    l_result            varchar2(32767);
    l_timeout           number;
  begin
    l_url_wapp := GetGlobalOption('CA_URL');
    if l_url_wapp is null then
      l_url_wapp := 'http://10.10.10.101:9088/barsroot/api/cagrc';
    end if;
    if substr(l_url_wapp, -1, 1) <> '/' then
      l_url_wapp := l_url_wapp || '/';
    end if;

    if GetGlobalOption('CA_LOGIN') is null then
      --�� ������� ������� ���������� ��������
      l_Authorization_val := 'Basic ' ||
                             utl_raw.cast_to_varchar2(utl_encode.base64_encode(utl_raw.cast_to_raw('absadm:qwerty')));
    else
      l_Authorization_val := 'Basic ' ||
                             utl_raw.cast_to_varchar2(utl_encode.base64_encode(utl_raw.cast_to_raw(GetGlobalOption('CA_LOGIN') || ':' ||
                                                                                                   GetGlobalOption('CA_PASS'))));
    end if;
    l_walett_path := GetGlobalOption('CA_WALLET_PATH');
    l_walett_pass := GetGlobalOption('CA_WALLET_PASS');

    begin
      l_timeout := greatest(to_number(GetGlobalOption('CA_TIMEOUT'), 60));
    exception
      when others then
        l_timeout := 300;
    end;
    utl_http.set_transfer_timeout(l_timeout);

    l_action := 'rebran';

    begin
      wsm_mgr.prepare_request(p_url          => l_url_wapp,
                              p_action       => l_action,
                              p_http_method  => wsm_mgr.G_HTTP_POST,
                              p_content_type => wsm_mgr.g_ct_json,
                              p_wallet_path  => l_walett_path,
                              p_wallet_pwd   => l_walett_pass);
      wsm_mgr.add_header(p_name  => 'Authorization',
                         p_value => l_Authorization_val);
      wsm_mgr.add_parameter(p_name => 'summa', p_value => p_summa);
      wsm_mgr.add_parameter(p_name => 'ob22', p_value => p_ob22);
      wsm_mgr.add_parameter(p_name  => 'branchfrom',
                            p_value => p_branchfrom);
      wsm_mgr.add_parameter(p_name  => 'branchto',
                            p_value => p_branchto);
/*      wsm_mgr.add_parameter(p_name  => 'outputCode',
                            p_value => p_ret);  */

      wsm_mgr.execute_request(g_response);
      l_result := g_response.cdoc; -- ���� ���� ����� - � clob �����
      bars_audit.info('service ' || l_action || ' end - ' ||
                      substr(l_result, 1, 3000));
      if substr(l_result, 1, 3) in ('400', '401', '404', '500') and
         length(l_result) > 3 then
        p_err := l_result;
        p_ret := -1;
        dbms_output.put_line(p_err); --debug
        return;
      end if;
    exception
      when others then
        p_err := sqlerrm || ' - ' || dbms_utility.format_error_backtrace;
        p_ret := -1;
        dbms_output.put_line(p_err); --debug
        return;
    end;
  end;





  --��������� ����������� ������
  procedure rebranch_crca(p_branch_from      branch.branch%type,
                          p_branch_to        branch.branch%type,
                          p_res         out  varchar2)
  is
    i  number :=0;
    ii number :=0;
    x number :=0;
    l_cnt pls_integer;
    l_err varchar2(32767);
    l_code number;

    l_id  compen_oper.oper_id%type;
    l_ost compen_portfolio.ost%type;

    TYPE t_arr_compen_id IS TABLE OF compen_portfolio.id%TYPE;
    l_arr_compen_id t_arr_compen_id;

    TYPE t_arr_compen_ost IS TABLE OF compen_portfolio.ost%TYPE;
    l_arr_compen_ost t_arr_compen_ost;

    TYPE t_arr_compen_act IS TABLE OF compen_portfolio.branchact%TYPE;
    l_arr_compen_act t_arr_compen_act;

    procedure rebran_noact_oper_and_send(p_branch_from      branch.branch%type,
                                         p_branch_to        branch.branch%type,
                                         p_ost              compen_portfolio.ost%type,
                                         p_ob22             compen_portfolio.ob22%type
                                   ) as
      pragma autonomous_transaction;
          l_arr_compen_oper number_list := number_list();
    begin
      l_arr_compen_id  := null;
      l_arr_compen_ost := null;
      l_arr_compen_act := null;
      update compen_portfolio
      set branch_crkr = p_branch_to
      where ob22 = p_ob22
      and branch_crkr = p_branch_from
      returning id, ost, branchact bulk collect into l_arr_compen_id, l_arr_compen_ost, l_arr_compen_act;

      for j in l_arr_compen_id.FIRST .. l_arr_compen_id.LAST
      loop
        if l_arr_compen_act(j) is null then
          l_ost := l_arr_compen_ost(j);
          else
            select count(*) into l_cnt
            from compen_oper o where o.compen_id = l_arr_compen_id(j)
                                 and o.oper_type in (TYPE_OPER_ACT_DEP, TYPE_OPER_ACT_HER)
                                 and o.state = STATE_OPER_COMPLETED;--���곺���� �� �� �������� ����������� �������������� ��� �������� �������������
            if l_cnt = 0 then
              l_ost := l_arr_compen_ost(j);
              else
                l_ost := 0;
                l_arr_compen_act(j) := null;--���������������� �
            end if;
        end if;
        l_id := i_compen_oper('REBRANCH',
                              l_arr_compen_id(j),
                              null,
                              null,
                              l_ost,
                              null,
                              null,
                              null);
        set_oper_status(l_id, STATE_OPER_COMPLETED, case when l_arr_compen_act(j) is null then '���� ������ ���������������� ������ '||chr(10)||p_branch_from||' �� '||p_branch_to else '���� ������ �� �������������� ����� '||chr(10)||p_branch_from||' �� '||p_branch_to end);
        if  l_arr_compen_act(j) is not null then
          l_arr_compen_oper.extend; l_arr_compen_oper(l_arr_compen_oper.last) := l_id;
        end if;
      end loop;

      if p_ost > 0 then
        send_rebranch(p_summa        =>p_ost,
                      p_ob22         =>p_ob22,
                      p_branchfrom   =>p_branch_from,
                      p_branchto     =>p_branch_to,
                      p_err          =>l_err,
                      p_ret          =>l_code);
        else
          l_code := null;
      end if;
      if l_code < 0 then
        x := x + l_arr_compen_id.COUNT;
        p_res := p_res||chr(13)||l_err;
        logger.error('rebranch_crca:������� ��������� ����������� ��� ob22='||p_ob22||' p_branchfrom='||p_branch_from||' p_branchto='||p_branch_to||' no actual cnt='||l_arr_compen_id.COUNT||' error:'||l_err);
        rollback;
        else
          i := i + l_arr_compen_id.COUNT;
          update compen_oper set ref_id = l_code
          where oper_id in (select value(t) from table(l_arr_compen_oper) t);
          logger.info('rebranch_crca:�������� ���������� ��� ob22='||p_ob22||' p_branchfrom='||p_branch_from||' p_branchto='||p_branch_to||' no actual oper_cnt='||l_arr_compen_oper.COUNT||'", ���������� �'||user_id());
          commit;
      end if;

      exception when others then
        p_res := p_res||chr(13)||sqlerrm;
        logger.error('rebranch_crca:������� ��������� ����������� ��� ob22='||p_ob22||' p_branchfrom='||p_branch_from||' p_branchto='||p_branch_to||' no actual  error:'||substr(p_res,1,3000));
        x := x + 1;
        rollback;

    end;

    procedure rebran_act_oper_and_send(p_branch_from      branch.branch%type,
                                       p_branch_to        branch.branch%type,
                                       p_ost              compen_portfolio.ost%type,
                                       p_ob22             compen_portfolio.ob22%type
                                   ) as
      pragma autonomous_transaction;
          l_arr_compen_oper number_list := number_list();
          l_ost compen_portfolio.ost%type := p_ost;
    begin
      l_arr_compen_id  := null;
      l_arr_compen_ost := null;
      update compen_portfolio
      set branchact = p_branch_to
      where ob22 = p_ob22
      and branchact = p_branch_from
      returning id, ost bulk collect into l_arr_compen_id, l_arr_compen_ost;

      for j in l_arr_compen_id.FIRST .. l_arr_compen_id.LAST
      loop
        select count(*) into l_cnt
        from compen_oper o where o.compen_id = l_arr_compen_id(j)
                             and o.oper_type in (TYPE_OPER_ACT_DEP, TYPE_OPER_ACT_HER)
                             and o.state = STATE_OPER_COMPLETED;--���곺���� �� �� �������� ����������� �������������� ��� �������� �������������
        if l_cnt > 0 then
          l_id := i_compen_oper('REBRANCH',
                                l_arr_compen_id(j),
                                null,
                                null,
                                l_arr_compen_ost(j),
                                null,
                                null,
                                l_code);
          set_oper_status(l_id, STATE_OPER_COMPLETED, '���������� �������������� ������ '||chr(10)||p_branch_from||' �� '||p_branch_to);
          l_arr_compen_oper.extend; l_arr_compen_oper(l_arr_compen_oper.last) := l_id;
          else --�������������������, ���� �����
            l_ost := l_ost - l_arr_compen_ost(j);
        end if;
      end loop;

      if l_ost > 0 then
        send_rebranch(p_summa        =>l_ost,
                      p_ob22         =>p_ob22,
                      p_branchfrom   =>p_branch_from,
                      p_branchto     =>p_branch_to,
                      p_err          =>l_err,
                      p_ret          =>l_code);
        else
          l_code := null;
      end if;
      if l_code < 0 then
        x := x + l_arr_compen_id.COUNT;
        p_res := p_res||chr(13)||chr(10)||l_err;
        logger.error('rebranch_crca:������� ��������� ����������� ��� ob22='||p_ob22||' p_branchfrom='||p_branch_from||' p_branchto='||p_branch_to||' branchact cnt='||l_arr_compen_id.COUNT||' error:'||l_err);
        rollback;
        else
          ii := ii + l_arr_compen_id.COUNT;
          update compen_oper set ref_id = l_code
          where oper_id in (select value(t) from table(l_arr_compen_oper) t);
          logger.info('rebranch_crca:�������� ���������� ��� ob22='||p_ob22||' p_branchfrom='||p_branch_from||' p_branchto='||p_branch_to||' branchact '||' oper_cnt='||l_arr_compen_oper.COUNT||', ���������� �'||user_id());
          commit;
      end if;

      exception when others then
        p_res := p_res||chr(13)||sqlerrm;
        logger.error('rebranch_crca:������� ��������� ����������� ��� ob22='||p_ob22||' p_branchfrom='||p_branch_from||' p_branchto='||p_branch_to||' branchact  error:'||substr(p_res,1,3000));
        x := x + 1;
        rollback;
    end;

  begin

    --���� ������ ������ (branch_crkr) �� ���������� �� ���������� ����� �� ���������������
    for k in (select * from (select p.ob22,
                                    p.branch_crkr,
                                    --���� ����������� ���������, �� � ���� �� ��������
                                    sum(decode(p.branchact, null, p.ost, case when (select count(*) from compen_oper o where o.compen_id = p.id
                                                                                                        and o.oper_type in (TYPE_OPER_ACT_DEP, TYPE_OPER_ACT_HER)
                                                                                                        and o.state = STATE_OPER_COMPLETED
                                                                                    ) > 0 then 0
                                                                               else p.ost
                                                                          end
                                               )
                                        ) ost
                              from compen_portfolio p
                              where p.branch_crkr = p_branch_from
                              group by p.ob22, p.branch_crkr)
                       /*where  ost > 0*/)
    loop
      rebran_noact_oper_and_send(p_branch_from, p_branch_to, k.ost, k.ob22);
    end loop;

    --���� ������ �������������� ������ (branchact) �� ���������� �� ���������� ����� �� �������������
    for k in (select * from (select p.ob22, p.branchact, sum(p.ost) ost
                              from compen_portfolio p
                             where p.branchact = p_branch_from
                              group by p.ob22, p.branchact)
                       /*where  ost > 0*/)
    loop
      rebran_act_oper_and_send(p_branch_from, p_branch_to, k.ost, k.ob22);
    end loop;

    --� ������ �� ���� �������
    insert into compen_portfolio_rebran(branch_from, branch_to, err_cnt, succ_compen, succ_act)
                                 values(p_branch_from, p_branch_to, x, i , ii);

    if x=0 then
      p_res:='�������� ���������� � ������ "'||p_branch_from||'" �� ����� "'||p_branch_to||'", ������� = '||i||' , ������� �������������='||ii;
      else
        p_res:='���������� � ������ "'||p_branch_from||'" �� ����� "'||p_branch_to||'" �������� � ���������, ��������� �� ������������, ������� = '||i||' �������������='||ii||', ���������� = '||x
               ||' ���� �������:  '||p_res;
        logger.error('crkr_compen_web.rebranch_crca '||substr(p_res, 1, 3000));
    end if;
  end;

  --���������� ������ � ������ ������
  procedure compen_write_down(p_compen_from in number,
                              p_compen_to   in number,
                              p_rnk         in number,
                              p_amount      in number,
                              p_purpose     in varchar2) is
    l_compen_from  compen_portfolio%rowtype := get_compen(p_compen_from);
    l_compen_to    compen_portfolio%rowtype := get_compen(p_compen_to);
    l_id_donor     compen_oper.oper_id%type;
    l_id_recipient compen_oper.oper_id%type;
    l_wdi_count    pls_integer;
  begin
    if p_compen_from = p_compen_to then
      --��� ���� � ���� ��������� ..�����
      raise_application_error(-20000,
                              '���������� � ���� � ������ �� ���� ������������ ��������� (p_compen_from='||p_compen_from||' p_compen_to='||p_compen_to||')');
    end if;

    if p_amount is null or p_amount <= 0 then
      raise_application_error(-20000,
                              '���� �������� ������ ���� ����� �� ����');
    end if;

    if l_compen_from.close_date is not null then
      raise_application_error(-20000,
                              '������� ������� ID : ' || l_compen_from.id);
    end if;
    if l_compen_to.close_date is not null then
      raise_application_error(-20000,
                              '������� ������� ID : ' || l_compen_to.id);
    end if;
    if l_compen_from.status = 0 then
      raise_application_error(-20000,
                              '��������������� ����� ' || l_compen_from.id ||
                              ' �������������� ���� �������!');
    end if;

    if l_compen_from.status != STATE_COMPEN_BLOCK_HER then
      raise_application_error(-20000,
                              '��������� ����� ����� � ������ ���� ������������ � ��''���� � ����������� ��������');
    end if;
    --��������� �� ��� ���� �����������. ������� ������ �� �����. �� ������ ����� ��������� ������� ����������� ����� ����� �� ���������
    select count(*)
      into l_wdi_count
    from compen_oper o
    where o.compen_id = p_compen_to
      and o.oper_type = TYPE_OPER_WDI;
    if l_wdi_count > 0 then
      raise_application_error(-20000,
                              '��� ���� ���������� �� ��� �����');
    end if;

    if l_compen_from.ost < p_amount * 100 then
      raise_application_error(-20000,
                              '����������� ����� �� ������� ID : ' ||
                              l_compen_from.id || '. �������: ' ||
                              l_compen_from.ost / 100);
    end if;

    l_id_donor     := i_compen_oper('WDO',
                                    p_compen_from, --�������� �������� � ����� ������
                                    p_compen_to,
                                    p_rnk,
                                    p_amount * 100,
                                    p_purpose);
    l_id_recipient := i_compen_oper('WDI',
                                    p_compen_to, --�������� ����������� �� ��� �����
                                    p_compen_from,
                                    p_rnk,
                                    p_amount *100,
                                    p_purpose);

    mark_open_client(p_rnk);

  end;


  --³������� ������ ������ � ���������� ����� ���������
  procedure open_new_compen_transfer(p_rnk              in number,
                                     p_compen_donor_id  in number,
                                     p_amount           in number)

   is
    l_cust            v_customer_crkr%rowtype;
    l_branch          varchar2(30) := sys_context('bars_context', 'user_branch');
    l_portfolio       compen_portfolio%rowtype;
    l_portfolio_donor compen_portfolio%rowtype;
    l_cnt             pls_integer;

    l_name            customer.nmk%type;
    l_inn             customer.okpo%type;
    l_id_sex          person.sex%type;
    l_birth_date      person.bday%type;
    l_id_doc_type     person.passp%type;
    l_ser             person.ser%type;
    l_numdoc          person.numdoc%type;
    l_date_of_issue   person.pdate%type;
    l_organ           person.organ%type;
    l_zip             customer_address.zip%type;
    l_domain          customer_address.domain%type;
    l_region          customer_address.region%type;
    l_locality        customer_address.locality%type;
    l_address         customer_address.address%type;
    l_dbcode          compen_clients.dbcode%type;
  begin

    /* ������� ������� ���� ������ �������� �� ����������/�������� ��� ��������. 
    select count(*)
    into l_cnt
    from compen_oper o_d, compen_oper o_r
    where o_d.compen_id = p_compen_donor_id
      and o_d.oper_type = TYPE_OPER_WDO and o_d.state != STATE_OPER_CANCELED
      --
      and o_d.compen_id = o_r.compen_bound
      --
      and o_r.oper_type = TYPE_OPER_WDI and o_r.state != STATE_OPER_CANCELED
      and o_r.rnk = p_rnk;

    if l_cnt > 0 then
      raise_application_error(-20000, ' ��� ���� ���������� � ����� ������ �� ����� �볺��� ���������');
    end if;
    */ 
    --select * into l_cust from v_customer_crkr t where t.rnk = p_rnk;

    select c.nmk name, c.okpo inn, p.sex id_sex, p.bday birth_date, p.passp id_doc_type, p.ser, p.numdoc,
          p.pdate date_of_issue, p.organ, a.zip, a.domain, a.region, a.locality, a.address, cc.dbcode
     into l_name, l_inn, l_id_sex, l_birth_date,  l_id_doc_type, l_ser, l_numdoc, l_date_of_issue, l_organ, l_zip, l_domain, l_region, l_locality, l_address, l_dbcode
     from customer c,
          person p,
          (select rnk,
                  zip,
                  domain,
                  region,
                  locality,
                  address
             from customer_address) a,
          compen_clients cc
    where c.rnk = p.rnk and c.rnk = a.rnk and c.rnk = cc.rnk
      and cc.rnk = p_rnk;

    select * into l_portfolio_donor from compen_portfolio t where t.id = p_compen_donor_id;

    l_portfolio.id           := s_compen_portfolio.nextval;
    l_portfolio.fio          := l_name;
    l_portfolio.country      := 804;
    l_portfolio.postindex    := l_zip;
    l_portfolio.obl          := l_domain;
    l_portfolio.rajon        := l_region;
    l_portfolio.city         := l_locality;
    l_portfolio.address      := l_address;
    l_portfolio.fulladdress  := null;
    l_portfolio.icod         := l_inn;
    l_portfolio.doctype      := l_id_doc_type;
    l_portfolio.docserial    := l_ser;
    l_portfolio.docnumber    := l_numdoc;
    l_portfolio.docorg       := l_organ;
    l_portfolio.docdate      := l_date_of_issue;
    l_portfolio.clientbdate  := l_birth_date;
    l_portfolio.clientbplace := null;
    l_portfolio.clientsex    := l_id_sex;
    l_portfolio.clientphone  := null;
    l_portfolio.registrydate := sysdate;
    l_portfolio.nsc          := null;
    l_portfolio.ida          := null;
    l_portfolio.nd           := null;
    l_portfolio.sum          := 0;
    l_portfolio.ost          := 0;
    l_portfolio.dato         := sysdate;
    l_portfolio.datl         := null;
    l_portfolio.attr         := null;
    l_portfolio.card         := null;
    l_portfolio.datn         := null;
    l_portfolio.ver          := null;
    l_portfolio.stat         := null;
    l_portfolio.tvbv         := null;
    l_portfolio.branch       := l_portfolio_donor.branch;
    l_portfolio.kv           := 980;
    l_portfolio.status       := 1;
    l_portfolio.date_import  := null;
    l_portfolio.dbcode       := l_dbcode;
    l_portfolio.percent      := 0;
    l_portfolio.kkname       := l_portfolio_donor.kkname;
    l_portfolio.ob22         := l_portfolio_donor.ob22;
    l_portfolio.rnk          := p_rnk;
    l_portfolio.branchact    := l_branch;
    l_portfolio.branch_crkr  := l_portfolio_donor.branch;

    insert into compen_portfolio values l_portfolio;

    compen_write_down(p_compen_donor_id, l_portfolio.id, p_rnk, p_amount, '���������� ��������');

    i_row_portfolio_upd(l_portfolio);


  exception
    when no_data_found then
      raise_application_error(-20000,
                              '�볺��� ���: ' || p_rnk || ' �� ��������');
  end;


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
                          p_without_oper in char default null
                          ) is
    l_count     pls_integer;
    l_cb        compen_benef%rowtype;
    l_oper_id   compen_oper.oper_id%type;
    l_oper_type compen_oper.oper_type%type;
  begin

    select count(*)
      into l_count
      from compen_benef t
     where t.id_compen = p_id_compen
       and t.code = p_code
       and t.icodb = trim(p_icod)
       and t.removedate is null;

    if l_count > 0 and p_idb is null then

      raise_application_error(-20000,
                              '���������� � ���: ' || p_icod ||
                              ', ��� ������������� �� ' || case p_code when 'N' then
                              '����������' when 'D' then '����. �����'
                              end || ' �� ������ ID: ' || p_id_compen);

    end if;

    l_cb.id_compen    := p_id_compen;
    l_cb.idb := case
                  when p_idb is null then
                   s_compen_benef.nextval
                  else
                   p_idb
                end;
    l_cb.code         := p_code;
    l_cb.fiob         := p_fio;
    l_cb.countryb     := p_country;
    l_cb.fulladdressb := p_fulladdress;
    l_cb.icodb        := p_icod;
    l_cb.doctypeb     := p_doctype;
    l_cb.docserialb   := p_docserial;
    l_cb.docnumberb   := p_docnumber;
    l_cb.docorgb      := p_docorgb;
    l_cb.docdateb     := p_docdate;
    l_cb.clientbdateb := p_cliebtbdate;
    l_cb.clientsexb   := p_clientsex;
    l_cb.clientphoneb := p_clientphone;
    l_cb.percent      := p_percent;
    l_cb.eddr_id      := p_eddr_id;
    l_cb.user_id      := user_id();
    l_cb.branch       := sys_context('bars_context','user_branch');

    if p_idb is null then

      l_cb.regdate := sysdate;

      insert into compen_benef values l_cb;

      l_oper_id := i_compen_oper('BEN_ADD',
                                 p_id_compen,
                                 null,
                                 null,
                                 0,
                                 null,
                                 null,
                                 null,
                                 l_cb.idb);


    else

      update compen_benef t
         set id_compen    = l_cb.id_compen,
             idb          = l_cb.idb,
             code         = l_cb.code,
             fiob         = l_cb.fiob,
             countryb     = l_cb.countryb,
             fulladdressb = l_cb.fulladdressb,
             icodb        = l_cb.icodb,
             doctypeb     = l_cb.doctypeb,
             docserialb   = l_cb.docserialb,
             docnumberb   = l_cb.docnumberb,
             eddr_id      = l_cb.eddr_id,
             docorgb      = l_cb.docorgb,
             docdateb     = l_cb.docdateb,
             clientbdateb = l_cb.clientbdateb,
             clientsexb   = l_cb.clientsexb,
             clientphoneb = l_cb.clientphoneb,
             percent      = l_cb.percent
       where t.idb = l_cb.idb
      returning t.regdate into l_cb.regdate;

      if nvl(p_without_oper, 'N') != 'Y' then
        --�������� �� � ��� ����������� �������� �� ����� ����������
        begin
          select o.oper_type
          into l_oper_type
          from compen_oper o
          where o.compen_id = p_id_compen and o.benef_idb = l_cb.idb
            and o.oper_type in (TYPE_OPER_BENEF_ADD, TYPE_OPER_BENEF_MOD, TYPE_OPER_BENEF_DEL) and o.state not in (STATE_OPER_CANCELED, STATE_OPER_COMPLETED);

          case l_oper_type
            when TYPE_OPER_BENEF_ADD then raise_application_error(-20000, '�������� ��������� ����������� �� �����������');
            when TYPE_OPER_BENEF_MOD then raise_application_error(-20000, '���� ����������� �������� ����������� �����������');
            when TYPE_OPER_BENEF_DEL then raise_application_error(-20000, '���� ����������� �������� ��������� �����������');
          end case;

          exception
            when NO_DATA_FOUND then null;
        end;


        l_oper_id := i_compen_oper('BEN_MOD',
                                   p_id_compen,
                                   null,
                                   null,
                                   0,
                                   null,
                                   null,
                                   null,
                                   l_cb.idb);

      end if;
    end if;

    i_row_benef_update(l_cb);

  end;

  procedure delete_benef(p_id_compen    number,
                         p_idb          integer,
                         p_without_oper char default null) is
    l_cb       compen_benef%rowtype;
    l_oper_id  compen_oper.oper_id%type;
    l_oper_type compen_oper.oper_type%type;
  begin
    update compen_benef
       set removedate = sysdate
     where id_compen = p_id_compen and idb = p_idb
    returning id_compen, idb, code, fiob, countryb, fulladdressb, icodb, doctypeb, docserialb, docnumberb, docorgb, docdateb, clientbdateb, clientsexb, clientphoneb, regdate, removedate, percent, branch, user_id, eddr_id into l_cb;

    if nvl(p_without_oper, 'N') != 'Y' then

      --�������� �� � ��� ����������� �������� �� ����� ����������
      begin
        select o.oper_type
        into l_oper_type
        from compen_oper o
        where o.compen_id = p_id_compen and o.benef_idb = p_idb
          and o.oper_type in (TYPE_OPER_BENEF_ADD, TYPE_OPER_BENEF_MOD, TYPE_OPER_BENEF_DEL) and o.state not in (STATE_OPER_CANCELED, STATE_OPER_COMPLETED);

        case l_oper_type
          when TYPE_OPER_BENEF_ADD then raise_application_error(-20000, '�������� ��������� ����������� �� �����������');
          when TYPE_OPER_BENEF_MOD then raise_application_error(-20000, '���� ����������� �������� ����������� �����������');
          when TYPE_OPER_BENEF_DEL then raise_application_error(-20000, '���� ����������� �������� ��������� �����������');
        end case;

        exception
          when NO_DATA_FOUND then null;
      end;

      l_oper_id := i_compen_oper('BEN_DEL',
                                   p_id_compen,
                                   null,
                                   null,
                                   0,
                                   null,
                                   null,
                                   null,
                                   p_idb);
    end if;

    i_row_benef_update(l_cb);
  end;


  /* ������� ����� ������ ������ � ���� ����� ���������
        * p_nsc - ����� ������                  --|}_��� ����������� ��� ��������������� �� �������� ����������
          p_fio - Գ���� �� �������            --|}                   �� ������������� � ������ ���
          p_compen_id - ���� �������� �� ����� ����
  */
  function get_compens_write_down(p_nsc         compen_portfolio.nsc%type,
                                  p_fio         compen_portfolio.fio%type default null,
                                  p_compen_id   compen_portfolio.id%type default null)
    return sys_refcursor is
    l_cursor sys_refcursor;
  begin

    if p_compen_id is null and p_nsc is null then
      raise_application_error(-20000,
                              '�������� p_nsc ��������� ');
    end if;


    if p_compen_id is null then
      open l_cursor for
        select t.id,
               t.kkname,
               t.nsc,
               t.fio,
               t.registrydate,
               t.dato,
               t.datn,
               t.sum / 100 sum,
               t.ost / 100 ost,
               t.heritage_ost / 100 heritage_ost,
               s.status_name,
               t.branch,
               t.branchact
          from compen_portfolio t, compen_portfolio_status s
         where t.status = s.status_id
           and (t.rnk is null or substr(t.branchact, 2, 6) = sys_context('bars_context','user_mfo'))
           and t.nsc = p_nsc
           and (p_fio is null or lower(t.fio) like lower(p_fio) || '%');
       else
         open l_cursor for
           select t.id,
               t.kkname,
               t.nsc,
               t.fio,
               t.registrydate,
               t.dato,
               t.datn,
               t.sum / 100 sum,
               t.ost / 100 ost,
               t.heritage_ost / 100 heritage_ost,
               s.status_name,
               t.branch,
               t.branchact
          from compen_portfolio t, compen_portfolio_status s
         where t.id = p_compen_id and t.status = s.status_id;
       end if;
    return l_cursor;
  end;

  --���������� ������� ���������(����)
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
                                   p_err_text  out varchar2) is
    l_count number;
    l_err   number;
  begin
    p_err_code := 0;
    p_err_text := '���� ���������!';
    l_err      := 0;

/*    if (p_date_from < gl.bd) then
      p_err_code := 1;
      p_err_text := '���� ������� 䳿 ' ||
                    to_char(p_date_from, 'dd.mm.yyyy') ||
                    ' ����� �� ������� ��������� ���� ' ||
                    to_char(gl.bd, 'dd.mm.yyyy');
      return;
    end if;*/

/*    p_err_text := 'p_param='||p_param||';p_type='||p_type||';p_id='||p_id||';p_val='||p_val||';p_kf='||p_kf||';p_branch='||p_branch||';p_all='||p_all||';p_is_enable='||p_is_enable||';';
    p_err_code := 1;
    return;*/

    if (p_date_from > p_date_to) then
      p_err_code := 1;
      p_err_text := '���� ������� 䳿 ' ||
                    to_char(p_date_from, 'dd.mm.yyyy') ||
                    ' ����� �� ���� ��������� ' ||
                    to_char(p_date_to, 'dd.mm.yyyy');
      return;
    end if;

    if (p_type = 1) then
      select count(d.id)
        into l_err
        from compen_params_data d
       where d.par = p_param
         and d.is_enable = 1;
    elsif (p_type = 2) then
      select count(d.id)
        into l_err
        from compen_params_data d
       where d.par = p_param
         and d.is_enable = 1
         and nvl(d.kf,' ') = nvl(p_kf, ' ');
    elsif (p_type = 3) then
      select count(d.id)
        into l_err
        from compen_params_data d
       where d.par = p_param
         and d.is_enable = 1
         and nvl(d.branch, ' ') = nvl(p_branch, ' ');
    end if;

    if (p_id is not null and p_id != 0) then
      update compen_params_data d
         set d.val       = p_val,
             d.date_from = p_date_from,
             d.date_to   = p_date_to,
             d.is_enable = p_is_enable,
             d.userid    = bars.user_id,
             d.upd_date  = sysdate
       where d.id = p_id;
    else
      if l_err = 0 then
        if p_all = 0 then
          insert into compen_params_data
            (id,
             par,
             val,
             kf,
             branch,
             date_from,
             date_to,
             is_enable,
             userid,
             upd_date)
          values
            (s_compen_params_data_id.nextval,
             p_param,
             p_val,
             p_kf,
             p_branch,
             p_date_from,
             p_date_to,
             p_is_enable,
             bars.user_id,
             sysdate);
        elsif p_all = 1 and p_type = 3 then
          for c in (select branch from branch) loop
            insert into compen_params_data
              (id,
               par,
               val,
               kf,
               branch,
               date_from,
               date_to,
               is_enable,
               userid,
               upd_date)
            values
              (s_compen_params_data_id.nextval,
               p_param,
               p_val,
               p_kf,
               c.branch,
               p_date_from,
               p_date_to,
               p_is_enable,
               bars.user_id,
               sysdate);
          end loop;
        end if;
      else
        p_err_code := 1;
        p_err_text := 'ĳ���� ������� ��� ����';
      end if;
    end if;
  exception
    when others then
      p_err_code := -1;
      p_err_text := sqlerrm;
  end set_compen_param_value;


  --���� ��������� �� ����� � ��� ����� ��������� ��� ���������� ��������
  procedure change_compen_document(p_compen_id      compen_portfolio.id%type,
                                   p_doc_type       passp.passp%type,
                                   p_ser            compen_portfolio.docserial%type,
                                   p_numdoc         compen_portfolio.docnumber%type,
                                   p_date_of_issue  compen_portfolio.docdate%type,
                                   p_organ          compen_portfolio.docorg%type,
                                   p_type_person    compen_portfolio.type_person%type,
                                   p_name_person    compen_portfolio.name_person%type default null,
                                   p_edrpo_person   compen_portfolio.edrpo_person%type default null) is

    l_dbcode_new     compen_portfolio.dbcode%type;
    l_dbcode_old     compen_portfolio.dbcode%type;
    l_compen_state   compen_portfolio_status.status_id%type;
    l_portfolio      compen_portfolio%rowtype;
    l_oper_id        compen_oper.oper_id%type;
    l_oper_parent_id compen_oper.oper_id%type;
    l_rnk_compen     compen_portfolio.rnk%type;
    l_cnt            pls_integer;
  begin
    bars_audit.info(G_LOG || 'change_compen_document' || ' Start p_compen_id=>' ||
                    p_compen_id || ' p_doc_type=>' || p_doc_type ||' p_type_person=>' || p_type_person);
    if p_doc_type is null then
      raise_application_error(-20000,'��������� ��� ���������');
    end if;
    if p_ser is null and nvl(p_type_person,0) = 0 then
      raise_application_error(-20000,'�������� ���� ���������');
    end if;
    if p_numdoc is null then
      raise_application_error(-20000,'��������� ����� ���������');
    end if;

    select count(*) into l_cnt from compen_oper_dbcode d, compen_oper o where o.compen_id = p_compen_id and d.oper_id = o.oper_id;
    if l_cnt > 0 then
      raise_application_error(-20000,'�� ������ ��� � ���������� ���� ���������. �� �������� ������� ������� ��� ����������');
    end if;

    select *
    into l_portfolio
    from compen_portfolio where id = p_compen_id;

    if l_portfolio.status = STATE_COMPEN_CLOSE then
      raise_application_error(-20000,'����� ��������');
    end if;

    l_dbcode_old := l_portfolio.dbcode;
    l_rnk_compen := l_portfolio.rnk;

    l_dbcode_new := f_dbcode(p_doc_type, p_ser, p_numdoc);
    --��������� �� � �������� passp � ��������� (98-�������� ��� ������; 95-�������� ��� ������ (�����������); 96-������; 97-�������� ��� ��������); 94 - ������ ������

    case p_doc_type
      when 95 then
        l_compen_state := STATE_COMPEN_BLOCK_BUR;
      when 98 then
        l_compen_state := STATE_COMPEN_BLOCK_BUR;
      when 96 then
        l_compen_state := STATE_COMPEN_BLOCK_HER;
      when 97 then
        l_compen_state := STATE_COMPEN_BLOCK_HER;
      when 94 then
        l_compen_state := STATE_COMPEN_BLOCK_HER;
      else
        raise_application_error(-20000,'�������� ��� ��������� (��������� �������� ��� ������, ������ ��� �������� ��� ��������)');
    end case;


     --������� �� �� �������� ��� �������
     l_oper_parent_id := i_compen_oper('CHANGE_D',--���� ���������(������)
                                 p_compen_id,
                                 null,
                                 null,--RNK �� �� ���� �� �������� ������� ������� �볺��� �� �������, � ���� ��� ������ ���� ���������� ��� ������� ���������
                                      --��������� �������� �������� �� �������� "RNK" IS NOT NULL
                                 0,
                                 null,
                                 null,
                                 null);

     --�������� ���������� ����
     insert into compen_oper_dbcode(oper_id,
                                   dbcode,
                                   doctype,
                                   docserial,
                                   docnumber,
                                   docorg,
                                   docdate,
                                   state_compen,
                                   type_person,
                                   name_person,
                                   edrpo_person)
           values                  (l_oper_parent_id,
                                    l_dbcode_new,
                                    p_doc_type,
                                    p_ser,
                                    p_numdoc,
                                    p_organ,
                                    p_date_of_issue,
                                    l_compen_state,
                                    nvl(p_type_person, 0),
                                    p_name_person,
                                    p_edrpo_person
                                    );


     --������ ���� ������ ��������� �� ������
    if l_dbcode_old is not null then
      --�������� �� ����Ͳ ��� � �������(��� �� ���� ��������� ��� IT ���� ���������� �� ����� dbcode=null)
      if instr(l_dbcode_old,'*') > 0 then
        select count(*) into l_cnt from compen_portfolio where dbcode = l_dbcode_old and id <> p_compen_id;
        if l_cnt > 0 then
          raise_application_error(-20001, 'dbcode �� ������������� ������ "*" � ������ ����� ����, ������� "�������" ��� �������� ��������� dbcode. ��������� �� ��-����� ��� ����������� ��������');
        end if;
      end if;
      select count(*) into l_cnt from compen_portfolio where dbcode = l_dbcode_old and id <> p_compen_id;
      if l_cnt > 50 then
        raise_application_error(-20001, '������ ���''������ ������ �� dbcode, ������� "�������" ��� �������� ��������� dbcode. ��������� �� ��-����� ��� ����������� ��������');
      end if;

      for cur in (select * from compen_portfolio where dbcode = l_dbcode_old and id <> p_compen_id)
        loop
          --������� �� �� �������� ��� �������
          l_oper_id := i_compen_oper('CHANGE_DA',--���� ��������� ����������� �� ������
                                       cur.id,
                                       p_compen_id,
                                       null,--RNK �� �� ���� �� �������� ������� ������� �볺��� �� �������, � ���� ��� ������ ���� ���������� ��� ������� ���������
                                            --��������� �������� �������� �� �������� "RNK" IS NOT NULL
                                       0,
                                       null,
                                       null,
                                       null);
          --�������� ���������� ����
          insert into compen_oper_dbcode(oper_id,
                                   dbcode,
                                   doctype,
                                   docserial,
                                   docnumber,
                                   docorg,
                                   docdate,
                                   state_compen,
                                   type_person,
                                   name_person,
                                   edrpo_person)
           values                  (l_oper_id,
                                    l_dbcode_new,
                                    p_doc_type,
                                    p_ser,
                                    p_numdoc,
                                    p_organ,
                                    p_date_of_issue,
                                    l_compen_state,
                                    nvl(p_type_person,0),
                                    p_name_person,
                                    p_edrpo_person);
        end loop;
    end if;

     --������ ���� ������ ��������� �� �������� �� ����� ���������(��� ��� ������� ����� �� ������)
    if l_rnk_compen is not null then
      for cur in (select * from compen_portfolio where dbcode <> l_dbcode_new and rnk = l_rnk_compen and id <> p_compen_id)
        loop
          --������� �� �� �������� ��� �������
          l_oper_id := i_compen_oper('CHANGE_DB',--���� ��������� ����������� �� rnk
                                       cur.id,
                                       p_compen_id,
                                       null,--RNK �� �� ���� �� �������� ������� ������� �볺��� �� �������, � ���� ��� ������ ���� ���������� ��� ������� ���������
                                            --��������� �������� �������� �� �������� "RNK" IS NOT NULL
                                       0,
                                       null,
                                       null,
                                       null);
          --�������� ���������� ����
          insert into compen_oper_dbcode(oper_id,
                                   dbcode,
                                   doctype,
                                   docserial,
                                   docnumber,
                                   docorg,
                                   docdate,
                                   state_compen,
                                   type_person,
                                   name_person,
                                   edrpo_person)
           values                  (l_oper_id,
                                    l_dbcode_new,
                                    p_doc_type,
                                    p_ser,
                                    p_numdoc,
                                    p_organ,
                                    p_date_of_issue,
                                    l_compen_state,
                                    nvl(p_type_person, 0),
                                    p_name_person,
                                    p_edrpo_person);
        end loop;
    end if;

    set_oper_status(l_oper_parent_id, STATE_OPER_COMPLETED);
    bars_audit.info(G_LOG || 'change_compen_document End');  
    exception 
      when others then 
        bars_audit.error(G_LOG || 'change_compen_document ' ||dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace());
        raise;
  end;


  --����������� ������ ������ �� ���������� �������
  procedure set_registry_status_block(p_reg_list       number_list default number_list(),
                                      p_info     out   varchar2)
    is
    l_block        pls_integer := 0;
    l_block_sum    pls_integer := 0;
    l_ignor        pls_integer := 0;
  begin
    for cur in (select * from compen_payments_registry where reg_id in
                           (select value(tt) from table(p_reg_list) tt)
                for update nowait)
    loop
      if cur.state_id in (STATE_REG_NEW, STATE_REG_SEND_ERR) then --������ �������
        l_block := l_block + 1;
        l_block_sum := l_block_sum + cur.amount;

        set_registry_status(cur.reg_id, STATE_REG_PAY_BLOCK);

         else
           l_ignor := l_ignor + 1; --�������� ���������� ��� �� ������� �� �
      end if;

    end loop;

    p_info := '����������� '||l_block||' ������ ��� ���������� ������� �� ���� '||l_block_sum /100;
    if l_ignor > 0 then
      p_info := p_info || chr(10)||chr(13) || '������������ '||l_ignor||' ������ (����� ��������� ����� ������ �������)';
    end if;
  end;

  --������������� ������ ������ �� ���������� �������
  procedure set_registry_status_no_block(p_reg_list       number_list default number_list(),
                                         p_info     out   varchar2)
    is
    l_block        pls_integer := 0;
    l_block_sum    pls_integer := 0;
    l_ignor        pls_integer := 0;
  begin
    for cur in (select * from compen_payments_registry where reg_id in
                           (select value(tt) from table(p_reg_list) tt)
                for update nowait)
    loop
      if cur.state_id = STATE_REG_PAY_BLOCK  then --����� ���������� �������
        l_block := l_block + 1;
        l_block_sum := l_block_sum + cur.amount;

        set_registry_status(cur.reg_id, STATE_REG_NEW);

         else
           l_ignor := l_ignor + 1; --�������� ������������� ��� �� ������� �� �
      end if;

    end loop;

    p_info := '������������ '||l_block||' ������ �� ���������� ������� �� ���� '||l_block_sum/100;
    if l_ignor > 0 then
      p_info := p_info || chr(10)||chr(13) || '������������ '||l_ignor||' ������ (����� ����������� ����� ����� ���������� �������)';
    end if;
  end;


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
)
    is
    l_regtype      compen_payments_registry.type_id%type := get_reg_type_id(p_regcode);
    l_opertype_act compen_oper.oper_type%type            := get_oper_type_id('ACT' ||
                                                                  substr(p_regcode,
                                                                         4));
  begin
    if p_regcode not in ('PAY_DEP', 'PAY_BUR') then
      raise_application_error(-20000,
                              '�������� p_opercode ������� ������');
    end if;

    select count(*)
    into p_count_compen_all
    from compen_portfolio p;

    select count(*)
    into p_count_act_all
    from compen_clients p;

    select count(*)
    into p_count_act_reg
    from
        (select r.rnk
        from compen_payments_registry r
        where r.type_id = l_regtype
        group by r.rnk);


    select count(*)
    into p_count_compen_new
    from compen_oper o
    where o.oper_type = l_opertype_act
      and o.reg_id is null
      and o.state != STATE_OPER_CANCELED;


    select nvl(sum(r.amount),0) /100
    into p_sum_state_new
    from compen_payments_registry r
    where r.type_id  = l_regtype
      and r.state_id in (STATE_REG_NEW, STATE_REG_SEND_ERR, STATE_REG_INITIAL);

    select nvl(sum(r.amount),0) / 100
    into p_sum_state_formed
    from compen_payments_registry r
    where r.type_id  = l_regtype
      and r.state_id = STATE_REG_SEND_OK;

    select nvl(sum(r.amount),0) / 100
    into p_sum_state_payed
    from compen_payments_registry r
    where r.type_id  = l_regtype
      and r.state_id = STATE_REG_PAY_COMPLETED;

    select nvl(sum(r.amount),0) /100
    into p_sum_state_block
    from compen_payments_registry r
    where r.type_id  = l_regtype
      and r.state_id = STATE_REG_PAY_BLOCK;


    select count(*)
    into p_count_compen_reg
    from compen_portfolio p, compen_oper o
    where o.compen_id = p.id
      and o.oper_type = l_opertype_act
      and o.state = STATE_OPER_COMPLETED;

    select min(o.regdate), max(o.regdate)
    into p_date_first, p_date_last
    from compen_oper o
    where o.oper_type = l_opertype_act;

  end;

  --������� ���� ��� �������: ����� ����� �� ������ ������ � ������ �� ����� �� � ����� ���� �������, �� ������ ����� �� �� ������ ����
  --           p_opercode:
  --                          PAY_DEP - ������� ���������������� ������
  --                          PAY_BUR - ������� ���������������� ������ �� ���������
  procedure get_analize_pay(p_opercode        in   compen_oper_types.oper_code%type default 'PAY_DEP',
                            p_mfo             in   varchar2,        --���
                            p_date_from       in   date,            --���� �
                            p_date_to         in   date,            --���� ��
                            p_analiz_cur      out  sys_refcursor,   --��������: ������ � �����������
                            p_all_sum         out  number           --��������: ������ ������ �� �����
    )
    is
  begin
    null;
  end;

  /*��� ������������ ������ ������ � ����� (�� ���������)*/
  --��� �� �� ���� ������. ������������� �� ������ ���������� ��������
  procedure add_to_registry_bur(p_compen_id     compen_portfolio.id%type) is
    l_portfolio      compen_portfolio%rowtype;
    l_oper_state     compen_oper.state%type;
    l_reg_id         compen_payments_registry.reg_id%type;
    l_amount         compen_payments_registry.amount%type;
    l_amount_oper    compen_oper.amount%type;
    l_id             compen_oper.oper_id%type;
    l_oper_act       compen_oper.oper_id%type;
  begin
    if p_compen_id is null then
      raise_application_error(-20000, '�������� p_compen_id ���������');
    end if;

    select t.*  into l_portfolio   from compen_portfolio t   where t.id = p_compen_id;

    if l_portfolio.status != STATE_COMPEN_BLOCK_BUR then
      raise_application_error(-20000, '����� �� ���� ������������ ��� ������� �� ���������');
    end if;

    if l_portfolio.rnk_bur is null then
      raise_application_error(-20000, '�� ���� �������� ��������� �������');
    end if;

    if l_portfolio.doctype not in (98,95) then --98-�������� ��� ������; 95-�������� ��� ������ (�����������)
      raise_application_error(-20000, '�� ���� �������� �������� ����������� ������ ���������');
    end if;

    select o.state, o.amount, o.oper_id, o.reg_id
    into l_oper_state, l_amount_oper, l_oper_act, l_reg_id
    from compen_oper o
    where o.compen_id = p_compen_id
      and o.rnk = l_portfolio.rnk_bur
      and o.oper_type = TYPE_OPER_ACT_BUR
      and o.state != STATE_OPER_CANCELED;

    if l_oper_state != STATE_OPER_COMPLETED then
      raise_application_error(-20000, '�������� ����������� �� ��������� ������ ���� ���������');
    end if;

    if l_reg_id is not null then
      raise_application_error(-20000, '��� ������ � �����');
    end if;

    l_reg_id := payment_compen(l_portfolio.rnk_bur, -1 , 'PAY_BUR', l_portfolio.dbcode);--�������� ����

    if l_amount_oper > 0 then
      select p.amount
      into l_amount
      from  compen_payments_registry p
      where p.reg_id = l_reg_id;


      l_id     := i_compen_oper('PAY_BUR',
                                p_compen_id,
                                null,
                                l_portfolio.rnk_bur,
                                l_amount_oper,
                                null,
                                l_reg_id);


      l_amount := l_amount + l_amount_oper;
      l_reg_id := payment_compen(l_portfolio.rnk_bur, l_amount , 'PAY_BUR', l_portfolio.dbcode);--�������� ����
     end if;
     --����������� �� ����������� ���������
     update compen_oper
        set changedate = sysdate,
             reg_id     = l_reg_id
     where oper_id = l_oper_act;

  end;

  --�������� ��� �� �������� (���-����)
  --ҳ���� �� ������ �� ����� �����������
  procedure apply_act_visa_bk(p_oper_list in number_list default number_list())
    is
    l_oper_state compen_oper.state%type;
  begin
    for cur in (select * from compen_oper where oper_id in
                           (select value(tt) from table(p_oper_list) tt))
    loop

      if cur.state != STATE_OPER_ERROR then
        raise_application_error(-20000, '������� �������� ������ �������� '||cur.oper_id);
      end if;
      if cur.oper_type  not in (TYPE_OPER_REQ_DEACT_BUR, TYPE_OPER_REQ_DEACT_DEP) then
        raise_application_error(-20000, '³������ ����� ����� ������ �� ����� ����������� (�������� �'||cur.oper_id||')');
      end if;

      set_oper_status(cur.oper_id, STATE_OPER_COMPLETED);

    end loop;

  end;

  --�������� ��� �� �������� (��������)
  procedure apply_act_visa(p_oper_list in number_list default number_list())
    is
    l_oper_state compen_oper.state%type;
  begin
    for cur in (select * from compen_oper where oper_id in
                           (select value(tt) from table(p_oper_list) tt))
    loop

      if cur.state != STATE_OPER_WAIT_CONFIRM then
        raise_application_error(-20000, '������� �������� ������ �������� '||cur.oper_id);
      end if;

      if cur.oper_type in (TYPE_OPER_REQ_DEACT_BUR, TYPE_OPER_REQ_DEACT_DEP) then
--         set_oper_status(cur.oper_id, STATE_OPER_ERROR); --�������� ����� ����������� �� ������ ������� ����� � ��-����
         set_oper_status(cur.oper_id, STATE_OPER_COMPLETED); --05/05/2017 ����� ������� ���������� �������� ����� � �� ����.
        else
         set_oper_status(cur.oper_id, STATE_OPER_COMPLETED);
      end if;
    end loop;

  end;
  --��������� ��������� (��������)
  procedure refuse_act_visa(p_oper_list in number_list default number_list(), p_reason varchar2)
    is
    l_oper_state compen_oper.state%type;
  begin
    if p_reason is null then
        raise_application_error(-20000, '������� ������� ���������� ��������� ');
    end if;

    for cur in (select * from compen_oper where oper_id in
                           (select value(tt) from table(p_oper_list) tt))
    loop

      if cur.state != STATE_OPER_WAIT_CONFIRM then
        raise_application_error(-20000, '������� �������� ������ �������� '||cur.oper_id);
      end if;

      set_oper_status(cur.oper_id, STATE_OPER_NEW, p_reason);
    end loop;

  end;

  --�������� ������� (��������)
  procedure error_act_visa(p_oper_list in number_list default number_list(), p_reason varchar2)
    is
    l_oper_state compen_oper.state%type;
  begin
    raise_application_error(-20000, '�������� ����� ������� ��� ���������');
    if p_reason is null then
      raise_application_error(-20000, '������ ������� ');
    end if;
    for cur in (select * from compen_oper where oper_id in
                           (select value(tt) from table(p_oper_list) tt))
    loop

      if cur.state != STATE_OPER_WAIT_CONFIRM then
        raise_application_error(-20000, '������� �������� ������ �������� '||cur.oper_id);
      end if;

      set_oper_status(cur.oper_id, STATE_OPER_ERROR, p_reason);
    end loop;

  end;


  --���� ��� �� ���������(����)
  procedure apply_act_visa_self(p_oper_list in number_list default number_list())
    is
    l_oper_state compen_oper.state%type;
  begin
    for cur in (select * from compen_oper where oper_id in
                           (select value(tt) from table(p_oper_list) tt))
    loop

      if cur.state != STATE_OPER_NEW then
        raise_application_error(-20000, '������� �������� ������ �������� '||cur.oper_id);
      end if;
      if cur.user_id != user_id() then
        raise_application_error(-20000, '�� ��� �������� '||cur.oper_id);
      end if;


      set_oper_status(cur.oper_id, STATE_OPER_WAIT_CONFIRM);
    end loop;

  end;
  --���� ������ �� ���������(����)
  procedure refuse_act_visa_self(p_oper_list in number_list default number_list(), p_reason varchar2)
    is
    l_oper_state compen_oper.state%type;
  begin
    for cur in (select * from compen_oper where oper_id in
                           (select value(tt) from table(p_oper_list) tt))
    loop

      if cur.state != STATE_OPER_NEW then
        raise_application_error(-20000, '������� �������� ������ �������� '||cur.oper_id);
      end if;
      if cur.user_id != user_id() then
        raise_application_error(-20000, '�� ��� �������� '||cur.oper_id);
      end if;


      set_oper_status(cur.oper_id, STATE_OPER_CANCELED, p_reason);
    end loop;

  end;

  --��������� ��������� (���)
  procedure refuse_act_visa_bk(p_oper_list in number_list default number_list(), p_reason varchar2)
    is
    l_oper_state compen_oper.state%type;
  begin
    for cur in (select * from compen_oper where oper_id in
                           (select value(tt) from table(p_oper_list) tt))
    loop

      if cur.state != STATE_OPER_ERROR then
        raise_application_error(-20000, '������� �������� ������ �������� '||cur.oper_id);
      end if;

      set_oper_status(cur.oper_id, STATE_OPER_NEW, p_reason);
    end loop;

  end;

  --������� ��� ���� �����������
  function get_planned_day return date
    is
    l_days  pls_integer := nvl(to_number(get_compen_param_val('COMPEN_OFFSET_DAYS')), 30);
  begin
    return trunc(sysdate + l_days);
  end;

  function convert_doctype_asvo_to_crkr(p_doctype number) return number
    is
  begin
    return case p_doctype
             when -1 then 11 --����������� ������� ��.������
             when -2 then 3  --�������� ���  ����������
             when -3 then 98 --�������� ��� ������
             when -4 then 15 --��������� ���������� �����
             else p_doctype
           end;
  end;


  --������� ���������� �� ������� ��� ���������
  function get_compen_new_doc(p_compen_id compen_portfolio.id%type)
    return sys_refcursor is
    l_cursor sys_refcursor;
  begin
    open l_cursor for
      select convert_doctype_asvo_to_crkr(p.doctype) doctype            , p.docserial              , p.docnumber              , p.docorg           , p.docdate,             nvl(p.type_person, 0) type_person,                 p.name_person,                 p.edrpo_person,
             (select name from passp where passp=d.doctype) new_doctype , d.docserial new_docserial, d.docnumber new_docnumber, d.docorg new_docorg, d.docdate new_docdate, nvl(d.type_person, 0) new_type_person, d.name_person new_name_person, d.edrpo_person new_edrpo_person
      from compen_portfolio p
        left join compen_oper o on (o.compen_id = p.id and o.oper_type in (TYPE_OPER_CHANGE_D, TYPE_OPER_CHANGE_DA, TYPE_OPER_CHANGE_DB) and o.state not in (STATE_OPER_CANCELED, STATE_OPER_COMPLETED))
        left join compen_oper_dbcode d on (o.oper_id = d.oper_id)
      where p.id = p_compen_id;
    return l_cursor;
  end;

  --0 - �� ����
  --1 - �볺�� � ����� ���������� ��� �
  function check_customer_by_document(p_passp       passp.passp%type,
                                      p_ser         person.ser%type,
                                      p_docnum      person.numdoc%type,
                                      p_eddr_id     person.eddr_id%type,
                                      p_secondary   compen_clients.secondary%type,
                                      p_branch_name out branch.name%type
                                      )
  return number as
    l_b            number(1);
    l_branch       customer.branch%type;
    l_dbcode       varchar2(32) := f_dbcode(p_passp, case when p_passp = 7 then p_eddr_id else p_ser end, p_docnum);
  begin
    begin
       select r.branch
          into l_branch
          from compen_clients c, customer r
         where c.rnk = r.rnk
           and c.dbcode = l_dbcode
           and c.secondary =  nvl(p_secondary,0)
           and c.open_cl is not null
           and rownum < 2;

       select b.name
         into p_branch_name
         from branch b
        where b.branch = l_branch;
        return 1;
        exception
        when NO_DATA_FOUND then
          null;
    end;
    return 0;
  end;

  --������������� ������ ���-������
  procedure unblock_compen(p_compen_id compen_portfolio.id%type) is
    l_status      compen_portfolio.status%type;
    l_status_prev compen_portfolio.status_prev%type;
  begin
    select status, status_prev
    into   l_status, l_status_prev
    from compen_portfolio
    where id = p_compen_id
    for update;
    if l_status = STATE_COMPEN_BLOCK then
      set_compen_status(p_compen_id, nvl(l_status_prev, STATE_COMPEN_OPEN), NULL, 1);
      else
        raise_application_error(-20000, '������� �������� ������ ������ '||p_compen_id);
    end if;
  end;

  /*=============*/
  -- ��������� ���� ������
  /* � ���� cobudep_dev
     ������� �� ��������

  --
  g_pmt_date_offset   constant number := 4;
  g_issue_date_offset constant number := 30;

  g_crm_url            constant varchar2(300) := 'http://10.254.14.201/newservice.asmx';
  g_crm_url_test       constant varchar2(300) := 'http://10.254.14.201/testservice.asmx';
  g_crm_namespace      constant varchar2(300) := 'http://tempuri.org/';
  --

  function get_cur_issue_date return ussr2_issue_dates.issue_date%type is
    l_issue_date ussr2_issue_dates.issue_date%type;
    l_dw         number;
  begin
    select trunc(sysdate) + g_issue_date_offset,
           to_number(to_char(sysdate, 'D', 'NLS_DATE_LANGUAGE=RUSSIAN'))
      into l_issue_date, l_dw
      from dual;
    if (l_dw = 7) then
      l_issue_date := l_issue_date + 1;
    end if;

    return l_issue_date;
  end get_cur_issue_date;

  -- ��������� ���� ������ ����� �� CRM
  procedure get_crm_issue_data(p_rnk              in number, -- ��� ������� (���)
                               p_branch           in varchar2, -- ��� ������ ���� ������ ������ � ������������ ������
                               p_clstatus         in varchar2, -- ������ ������� 1 - ������, 2 - �������, 3 - �����
                               p_issue_date       out date, -- ���� ������
                               p_issue_branch     out varchar2, -- ��� ������ ������ � ������������ ������
                               p_issue_branch_adr out varchar2 -- ����� ������ ������ � ������������ ������
                               ) is
    l_crm_url varchar2(300) := case (g_is_test_env)
                                 when 0 then
                                  g_crm_url
                                 else
                                  g_crm_url_test
                               end;

    l_reqs_cnt    number := 0;
    l_req_success boolean := false;

    l_request  soap_rpc.t_request;
    l_response soap_rpc.t_response;

    l_xmltype xmltype;

    l_code          number;
    l_message       varchar2(500);
    l_time          date;
    l_branch        varchar2(500);
    l_branchaddress varchar2(500);

    procedure parse_response(p_xml           in xmltype,
                             p_code          out number,
                             p_message       out varchar2,
                             p_time          out date,
                             p_branch        out varchar2,
                             p_branchaddress out varchar2) is
    begin
      select to_number(extractValue(p_xml,
                                    g_crm_path || 'result_code/text()')) as code,
             extractValue(p_xml, g_crm_path || 'result_message/text()') as message,
             to_date(extractValue(p_xml, g_crm_path || 'result_time/text()'),
                     'YYYY-MM-DD"T"HH24:MI:SS') as time,
             extractValue(p_xml, g_crm_path || 'result_branch/text()') as branch,
             extractValue(p_xml,
                          g_crm_path || 'result_branchaddress/text()') as branchaddress
        into p_code, p_message, p_time, p_branch, p_branchaddress
        from dual;
    end parse_response;
  begin
    logger.info('ussr2_act_pack.get_crm_issue_date ������ ��������� � CRM (-1) (p_rnk = ' ||
                p_rnk || ', p_branch = ' || p_branch || ')');

    -- ����������� �������
    l_request := soap_rpc.new_request(l_crm_url,
                                      g_crm_namespace,
                                      g_crm_method);

    -- �������� ���������
    soap_rpc.add_parameter(l_request, 'ClientID', to_char(p_rnk));
    soap_rpc.add_parameter(l_request, 'BranchName', p_branch);
    soap_rpc.add_parameter(l_request, 'ClStatus', p_clstatus);

    -- ������� ����� ���-�������
    while (l_reqs_cnt < g_crm_max_reqs and not l_req_success) loop
      l_reqs_cnt := l_reqs_cnt + 1;

      begin
        l_response    := soap_rpc.invoke(l_request);
        l_xmltype     := xmltype(replace(l_response.doc.getClobVal(),
                                         'xmlns',
                                         'mlns'));
        l_req_success := true;
      exception
        when others then
          logger.info('ussr2_act_pack.get_crm_issue_date ��������� ������� �' ||
                      l_reqs_cnt || ' ��������� � CRM (1) (p_rnk = ' ||
                      p_rnk || ', p_branch = ' || p_branch || '): ' ||
                      sqlerrm);
      end;
    end loop;

    -- ���� ����� �������
    if (l_req_success) then
      begin
        parse_response(l_xmltype,
                       l_code,
                       l_message,
                       l_time,
                       l_branch,
                       l_branchaddress);
      exception
        when others then
          logger.info('ussr2_act_pack.get_crm_issue_date ������ ������� ������ �� CRM (2) (p_rnk = ' ||
                      p_rnk || ', p_branch = ' || p_branch ||
                      ', l_xmltype = ' || l_xmltype.getclobval() || '): ' ||
                      sqlerrm);

          select get_cur_issue_date,
                 p_branch,
                 b.cityname || ', ' || b.address
            into p_issue_date, p_issue_branch, p_issue_branch_adr
            from alegrob b
           where b.num = p_branch;

          logger.info('ussr2_act_pack.get_crm_issue_date ��� ��������� ���� � ����� ������ �������������� ��-�� ������ ������� ������ �� CRM (8) (p_rnk = ' ||
                      p_rnk || ', p_branch = ' || p_branch ||
                      ', p_issue_date = ' || p_issue_date ||
                      ', p_issue_branch = ' || p_issue_branch ||
                      ', p_issue_branch_adr = ' || p_issue_branch_adr || ')');

          return;
      end;

      -- ���� ���������� �������
      case l_code
        when 0 then
          -- ��� ��
          p_issue_date       := l_time;
          p_issue_branch     := l_branch;
          p_issue_branch_adr := l_branchaddress;

          logger.info('ussr2_act_pack.get_crm_issue_date �������� ��������� � CRM (3) (p_rnk = ' ||
                      p_rnk || ', p_branch = ' || p_branch ||
                      ', l_xmltype = ' || l_xmltype.getclobval() || ')');
        when 1 then
          -- ����� ������
          logger.info('ussr2_act_pack.get_crm_issue_date ����� ������ ��� ��������� � CRM (4) (p_rnk = ' ||
                      p_rnk || ', p_branch = ' || p_branch ||
                      ', l_message = ' || l_message || ', l_xmltype = ' ||
                      l_xmltype.getclobval() || ')');

          select get_cur_issue_date,
                 p_branch,
                 b.cityname || ', ' || b.address
            into p_issue_date, p_issue_branch, p_issue_branch_adr
            from alegrob b
           where b.num = p_branch;

          logger.info('ussr2_act_pack.get_crm_issue_date ��� ��������� ���� � ����� ������ �������������� ��-�� ����� ������ CRM (7) (p_rnk = ' ||
                      p_rnk || ', p_branch = ' || p_branch ||
                      ', p_issue_date = ' || p_issue_date ||
                      ', p_issue_branch = ' || p_issue_branch ||
                      ', p_issue_branch_adr = ' || p_issue_branch_adr || ')');

          return;
        when 2 then
          -- �� ������� ���������
          logger.info('ussr2_act_pack.get_crm_issue_date �� ������� ��������� ��� ��������� � CRM (5) (p_rnk = ' ||
                      p_rnk || ', p_branch = ' || p_branch ||
                      ', l_message = ' || l_message || ', l_xmltype = ' ||
                      l_xmltype.getclobval() || ')');

          bars_error.raise_nerror(g_mod_code,
                                  'CRM_DATE_ERROR',
                                  2,
                                  '�� ������� ��������� p_rnk = ' || p_rnk ||
                                  ', p_branch = ' || p_branch);
      end case;
    else
      select get_cur_issue_date, p_branch, b.cityname || ', ' || b.address
        into p_issue_date, p_issue_branch, p_issue_branch_adr
        from alegrob b
       where b.num = p_branch;

      logger.info('ussr2_act_pack.get_crm_issue_date ��� ��������� ���� � ����� ������ �������������� ��-�� ��������� ������ ��������� � CRM (9) (p_rnk = ' ||
                  p_rnk || ', p_branch = ' || p_branch ||
                  ', p_issue_date = ' || p_issue_date ||
                  ', p_issue_branch = ' || p_issue_branch ||
                  ', p_issue_branch_adr = ' || p_issue_branch_adr || ')');

      return;
    end if;
  end get_crm_issue_data;
  */
  /*=============*/

begin
  -- Initialization
  null;
end;
/
grant execute on crkr_compen_web to bars_access_defrole;