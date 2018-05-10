PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/package/nota.sql =========*** Run *** ======
PROMPT ===================================================================================== 

CREATE OR REPLACE PACKAGE BARS.NOTA is

  G_HEADER_VERSION constant varchar2(64) := 'version 1.12 16.01.2018';
  --------------------------------------------------------------------

  ATTR_CODE_TIN                  constant varchar2(30 char) := 'NOTARY_TIN';
  ATTR_CODE_FIRST_NAME           constant varchar2(30 char) := 'NOTARY_FIRST_NAME';
  ATTR_CODE_MIDDLE_NAME          constant varchar2(30 char) := 'NOTARY_MIDDLE_NAME';
  ATTR_CODE_LAST_NAME            constant varchar2(30 char) := 'NOTARY_LAST_NAME';
  ATTR_CODE_DATE_OF_BIRTH        constant varchar2(30 char) := 'NOTARY_DATE_OF_BIRTH';
  ATTR_CODE_PASSPORT_SERIES      constant varchar2(30 char) := 'NOTARY_PASSPORT_SERIES';
  ATTR_CODE_PASSPORT_NUMBER      constant varchar2(30 char) := 'NOTARY_PASSPORT_NUMBER';
  ATTR_CODE_ADDRESS              constant varchar2(30 char) := 'NOTARY_ADDRESS';
  ATTR_CODE_PASSPORT_ISSUER      constant varchar2(30 char) := 'NOTARY_PASSPORT_ISSUER';
  ATTR_CODE_PASSPORT_ISSUED      constant varchar2(30 char) := 'NOTARY_PASSPORT_ISSUED';
  ATTR_CODE_PHONE_NUMBER         constant varchar2(30 char) := 'NOTARY_PHONE_NUMBER';
  ATTR_CODE_MOBILE_PHONE_NUMBER  constant varchar2(30 char) := 'NOTARY_MOBILE_PHONE_NUMBER';
  ATTR_CODE_EMAIL                constant varchar2(30 char) := 'NOTARY_EMAIL';
  ATTR_CODE_NOTARY_TYPE          constant varchar2(30 char) := 'NOTARY_TYPE';
  ATTR_CODE_CERT_NUMBER          constant varchar2(30 char) := 'NOTARY_CERT_NUMBER';
  ATTR_CODE_CERT_ISSUE_DATE      constant varchar2(30 char) := 'NOTARY_CERT_ISSUE_DATE';
  ATTR_CODE_CERT_CANCEL_DATE     constant varchar2(30 char) := 'NOTARY_CERT_CANCEL_DATE';
  ATTR_CODE_STATE                constant varchar2(30 char) := 'NOTARY_STATE';

  ATTR_CODE_DOCUMENT_TYPE             constant varchar2(30 char) := 'NOTARY_DOCUMENT_TYPE';
  ATTR_CODE_IDCARD_DOCUMENT_NUM    constant varchar2(30 char) := 'NOTARY_IDCARD_DOCUMENT_NUMBER';
  ATTR_CODE_IDCARD_NOTATION_NUM    constant varchar2(30 char) := 'NOTARY_IDCARD_NOTATION_NUMBER';
  ATTR_CODE_PASSPORT_EXPIRY           constant varchar2(30 char) := 'NOTARY_PASSPORT_EXPIRY';
  
  ATTR_CODE_ACCR_START_DATE      constant varchar2(30 char) := 'NOTARY_ACCR_START_DATE';
  ATTR_CODE_ACCR_EXPIRY_DATE     constant varchar2(30 char) := 'NOTARY_ACCR_EXPIRY_DATE';
  ATTR_CODE_ACCR_CLOSE_DATE      constant varchar2(30 char) := 'NOTARY_ACCR_CLOSE_DATE';
  ATTR_CODE_ACCR_ACCOUNT_NUMBER  constant varchar2(30 char) := 'NOTARY_ACCR_ACCOUNT_NUMBER';
  ATTR_CODE_ACCR_ACCOUNT_MFO     constant varchar2(30 char) := 'NOTARY_ACCR_ACCOUNT_MFO';
  ATTR_CODE_ACCR_STATE           constant varchar2(30 char) := 'NOTARY_ACCR_STATE';
  ATTR_CODE_ACCR_BRANCHES        constant varchar2(30 char) := 'NOTARY_ACCR_BRANCHES';
  ATTR_CODE_ACCR_BRANCH_TREES    constant varchar2(30 char) := 'NOTARY_ACCR_BRANCH_TREES';
  ATTR_CODE_ACCR_SEG_OF_BUSINESS constant varchar2(30 char) := 'NOTARY_ACCR_SEG_OF_BUSINESS';

  LT_NOTARY_DOCUMENT_TYPE        constant varchar2(30 char) := 'NOTARY_DOCUMENT_TYPE';
  NOTARY_DOCUMENT_TYPE_PASSPORT          constant integer           := 1; 
  NOTARY_DOCUMENT_TYPE_IDCARD            constant integer           := 7; 
  
  LT_NOTARY_TYPE                 constant varchar2(30 char) := 'NOTARY_TYPE';
  NOTARY_TYPE_STATE              constant integer           := 1; -- державний нотаріус
  NOTARY_TYPE_PRIVATE            constant integer           := 2; -- приватний нотаріус

  LT_NOTARY_STATE                constant varchar2(30 char) := 'NOTARY_STATE';
  NOTARY_STATE_ACTIVE            constant integer           := 1;
  NOTARY_STATE_CLOSED            constant integer           := 2;

  LT_ACCREDITATION_TYPE          constant varchar2(30 char) := 'NOTARY_ACCREDITATION_TYPE';
  ACCR_TYPE_GENERAL              constant integer           := 1;
  ACCR_TYPE_ONE_TIME             constant integer           := 2;

  LT_ACCREDITATION_STATE         constant varchar2(30 char) := 'NOTARY_ACCREDITATION_STATE';
  ACCR_STATE_NEW_REQUEST         constant integer           := 0;
  ACCR_STATE_ACTIVE              constant integer           := 1;
  ACCR_STATE_CLOSED              constant integer           := 2;
  ACCR_STATE_ONE_TIME_OFF        constant integer           := 3;

  LT_NOTARY_SEGMENT_OF_BUSINESS  constant varchar2(30 char) := 'NOTARY_SEGMENT_OF_BUSINESS'; -- напрямки акредитації нотаріусів
  BUSINESS_SEG_RETAIL            constant integer           := 1; -- роздрібний бізнес
  BUSINESS_SEG_CORPORATE         constant integer           := 2; -- корпоративний бізнес
  BUSINESS_SEG_SMALL_AND_MIDDLE  constant integer           := 3; -- малий та середній бізнес
  BUSINESS_SEG_GENERAL           constant integer           := 4; -- загальний напрямок акредитації


  procedure create_nota     (p_TIN                           varchar2,
                             p_adr                           varchar2,
                             p_datp                          date    ,  -- дата рождения
                             p_email                         varchar2,
                             p_last_name                     varchar2,  -- фамилия
                             p_first_name                    varchar2,  -- имя
                             p_middle_name                   varchar2,  -- отчество
                             p_phone_number                  varchar2,
                             p_MOBILE_PHONE_NUMBER           varchar2,
                             p_PASSPORT_SERIES               varchar2,
                             p_PASSPORT_NUMBER               varchar2,
                             p_PASSPORT_ISSUER               varchar2,
                             p_PASSPORT_ISSUED               date    ,
                             p_NOTARY_TYPE                   number  ,
                             p_CERTIFICATE_NUMBER            varchar2,
                             p_CERTIFICATE_ISSUE_DATE        date    ,
                             p_CERTIFICATE_CANCELATION_DATE  date    ,
                             p_RNK                           number  ,
                             p_MFORNK                        varchar2,
               p_DOCUMENT_TYPE                 number,
                             p_IDCARD_DOCUMENT_NUMBER        number,
                             p_IDCARD_NOTATION_NUMBER        varchar2,
                             p_PASSPORT_EXPIRY               date,
                             p_ret                       out number  ,
                             p_err                       out varchar2);

  procedure edit_nota       (p_id                            number  ,
                             p_TIN                           varchar2,
                             p_adr                           varchar2,
                             p_datp                          date    ,  -- дата рождения
                             p_email                         varchar2,
                             p_last_name                     varchar2,  -- фамилия
                             p_first_name                    varchar2,  -- имя
                             p_middle_name                   varchar2,  -- отчество
                             p_phone_number                  varchar2,
                             p_MOBILE_PHONE_NUMBER           varchar2,
                             p_PASSPORT_SERIES               varchar2,
                             p_PASSPORT_NUMBER               varchar2,
                             p_PASSPORT_ISSUER               varchar2,
                             p_PASSPORT_ISSUED               date    ,
                             p_NOTARY_TYPE                   number  ,
                             p_CERTIFICATE_NUMBER            varchar2,
                             p_CERTIFICATE_ISSUE_DATE        date    ,
                             p_CERTIFICATE_CANCELATION_DATE  date    ,
                             p_RNK                           number  ,
                             p_MFORNK                        varchar2,
               p_DOCUMENT_TYPE                 number,
                             p_IDCARD_DOCUMENT_NUMBER        number,
                             p_IDCARD_NOTATION_NUMBER        varchar2,
                             p_PASSPORT_EXPIRY               date,
                             p_err                       out varchar2);

  procedure add_accr        (p_notary_id                     number       ,
                             p_accreditation_type_id         number       ,
                             p_START_DATE                    date         ,
                             p_expiry_DATE                   date         ,
                             p_account_number                varchar2     ,
                             p_account_mfo                   varchar2     ,
                             p_state_id                      number       ,
                             p_branches                      varchar2_list,
                             p_segments_of_business          number_list  ,
                             p_ret                       out number       ,
                             p_err                       out varchar2);

  procedure edit_accr       (p_accr_id                       number       ,
                             p_accreditation_type_id         number       ,
                             p_START_DATE                    date         ,
                             p_expiry_DATE                   date         ,
                             p_account_number                varchar2     ,
                             p_account_mfo                   varchar2     ,
                             p_state_id                      number       ,
                             p_branches                      varchar2_list,
                             p_segments_of_business          number_list  ,
                             p_ret                       out varchar2);

    procedure close_notary(
        p_notary_id in integer);

    procedure activate_notary(
        p_notary_id in integer);

    procedure close_accr(
        p_accr_id number,
        p_ret out varchar2);

    procedure redemption_accr(
        p_accr_id number,
        p_ret out varchar2);

    function read_accreditation(
        p_accreditation_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return notary_accreditation%rowtype;

    procedure process_accreditation_request(
        p_sender_mfo          varchar2,
        p_notary_type         integer,
        p_certificate_number  varchar2,
        p_first_name          varchar2,
        p_middle_name         varchar2,
        p_last_name           varchar2,
        p_date_of_birth       date,
        p_accreditation_type  integer,
        p_tin                 varchar2,
        p_passport_series     varchar2,
        p_passport_number     varchar2,
        p_passport_issuer     varchar2,
        p_passport_issued     date,
        p_address             varchar2,
        p_phone_number        varchar2,
        p_mobile_phone_number varchar2,
        p_email               varchar2,
        p_rnk                 integer ,
        p_account_number      varchar2,
        p_DOCUMENT_TYPE                 number,
        p_IDCARD_DOCUMENT_NUMBER        number,
        p_IDCARD_NOTATION_NUMBER        varchar2,
        p_PASSPORT_EXPIRY                 date);

    procedure process_alter_request(
        p_sender_mfo          varchar2,
        p_notary_type         integer,
        p_certificate_number  varchar2,
        p_account_number      varchar2);

  function  header_version return varchar2;

  function  body_version return varchar2;
  
  function Get_Accr_Branches(p_accr_id notary_accreditation.id%type) return string;
  function Get_Accr_BranchNames(p_accr_id notary_accreditation.id%type) return string;
  function Get_Accr_Seg_of_Business(p_accr_id notary_accreditation.id%type) return string;

END nota;
/
CREATE OR REPLACE PACKAGE BODY BARS.NOTA AS

  G_BODY_VERSION constant varchar2(64) := 'version 1.21 26.02.2018';
  ------------------------------------------------------------------

    function read_notary(
        p_notary_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return notary%rowtype
    is
        l_notary_row notary%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_notary_row
            from   notary t
            where  t.id = p_notary_id
            for update;
        else
            select *
            into   l_notary_row
            from   notary t
            where  t.id = p_notary_id;
        end if;

        return l_notary_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Нотаріус з ідентифікатором {' || p_notary_id || '} не знайдений');
             else return null;
             end if;
    end;

    function read_notary(
        p_certificate_number in varchar2,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return notary%rowtype
    is
        l_notary_row notary%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_notary_row
            from   notary t
            where  t.certificate_number = p_certificate_number
            for update;
        else
            select *
            into   l_notary_row
            from   notary t
            where  t.certificate_number = p_certificate_number;
        end if;

        return l_notary_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Нотаріус за номером свідоцтва {' || p_certificate_number || '} не знайдений');
             else return null;
             end if;
    end;

    function read_accreditation(
        p_accreditation_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return notary_accreditation%rowtype
    is
        l_accreditation_row notary_accreditation%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_accreditation_row
            from   notary_accreditation t
            where  t.id = p_accreditation_id
            for update;
        else
            select *
            into   l_accreditation_row
            from   notary_accreditation t
            where  t.id = p_accreditation_id;
        end if;

        return l_accreditation_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Акредитація нотаріуса з ідентифікатором {' || p_accreditation_id || '} не знайдена');
             else return null;
             end if;
    end;

    function get_last_accreditation(
        p_notary_id in integer,
        p_accreditation_mfo in varchar2,
        p_allowed_states in number_list,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return notary_accreditation%rowtype
    is
        l_rowid urowid;
        l_accreditation_row notary_accreditation%rowtype;
    begin
        select min(f.rowid) keep (dense_rank last order by f.id)
        into   l_rowid
        from   notary_accreditation f
        where  f.notary_id = p_notary_id and
               f.account_mfo = p_accreditation_mfo and
               f.close_date is null and
               (f.expiry_date is null or f.expiry_date >= bankdate()) and
               f.state_id member of p_allowed_states;

        if (l_rowid is not null) then
            if (p_lock) then
                select *
                into   l_accreditation_row
                from   notary_accreditation t
                where  t.rowid = l_rowid
                for update;
            else
                select *
                into   l_accreditation_row
                from   notary_accreditation t
                where  t.rowid = l_rowid;
            end if;

            return l_accreditation_row;
        else
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Акредитація для нотаріуса {' || p_notary_id ||
                                                 '} для МФО {' || p_accreditation_mfo || '} не знайдена');
             else return null;
             end if;
        end if;
    end;
    
  procedure check_notary_uniqueness(
        p_exclude_notary_id in integer,
        p_tin in varchar2,
        p_certificate_number in varchar2,
        p_error_code out integer,
        p_error_message out varchar2)
    is
        pragma autonomous_transaction;
        l_duplicate_notary_id integer;
        l_duplicate_notary_name varchar2(300 char);
        l_duplicate_notary_state_id integer;
    begin
        if (p_tin is not null and p_tin <> '0000000000') then
            select min(n.id) keep (dense_rank last order by n.id),
                   min(trim(n.middle_name || ' ' || n.first_name || ' ' || n.last_name)) keep (dense_rank last order by n.id),
                   min(n.state_id) keep (dense_rank last order by n.id)
            into   l_duplicate_notary_id, l_duplicate_notary_name, l_duplicate_notary_state_id
            from   notary n
            where  (p_exclude_notary_id is null or n.id <> p_exclude_notary_id) and
                   n.tin = p_tin;

            if (l_duplicate_notary_name is not null) then
                if (l_duplicate_notary_state_id = nota.NOTARY_STATE_CLOSED) then
                    attribute_utl.set_value(l_duplicate_notary_id, nota.ATTR_CODE_STATE, nota.NOTARY_STATE_ACTIVE,
                                            'Відновлення нотаріуса в переліку активних у зв''язку зі спробою вводу такого самого ІПН');
                end if;
                p_error_code := -3;
                p_error_message := 'Нотаріус "' || l_duplicate_notary_name ||
                                   '" з ідентифікаційним кодом {'|| p_tin || '} вже зареєстрований';
            end if;
        end if;

        if (p_error_code is null) then
            if (p_certificate_number is not null) then
                select min(n.id) keep (dense_rank last order by n.id),
                       min(trim(n.middle_name || ' ' || n.first_name || ' ' || n.last_name)) keep (dense_rank last order by n.id),
                       min(n.state_id) keep (dense_rank last order by n.id)
                into   l_duplicate_notary_id, l_duplicate_notary_name, l_duplicate_notary_state_id
                from   notary n
                where  (p_exclude_notary_id is null or n.id <> p_exclude_notary_id) and
                       n.certificate_number = p_certificate_number;

                if (l_duplicate_notary_name is not null) then
                    if (l_duplicate_notary_state_id = nota.NOTARY_STATE_CLOSED) then
                        attribute_utl.set_value(l_duplicate_notary_id, nota.ATTR_CODE_STATE, nota.NOTARY_STATE_ACTIVE,
                                                'Відновлення нотаріуса в переліку активних у зв''язку зі спробою вводу такого самого номера реєстраційного посвідчення');
                    end if;

                    p_error_code := -3;
                    p_error_message := 'Нотаріус "' || l_duplicate_notary_name ||
                                       '" з номером посвідчення {'|| p_certificate_number || '} вже зареєстрований';
                end if;
            end if;
        end if;

        commit;
    exception
        when others then
             rollback;
             raise;
    end;
    
  procedure create_nota     (p_TIN                           varchar2,
                             p_adr                           varchar2,
                             p_datp                          date    ,  -- дата рождения
                             p_email                         varchar2,
                             p_last_name                     varchar2,  -- фамилия
                             p_first_name                    varchar2,  -- имя
                             p_middle_name                   varchar2,  -- отчество
                             p_phone_number                  varchar2,
                             p_MOBILE_PHONE_NUMBER           varchar2,
                             p_PASSPORT_SERIES               varchar2,
                             p_PASSPORT_NUMBER               varchar2,
                             p_PASSPORT_ISSUER               varchar2,
                             p_PASSPORT_ISSUED               date    ,
                             p_NOTARY_TYPE                   number  ,
                             p_CERTIFICATE_NUMBER            varchar2,
                             p_CERTIFICATE_ISSUE_DATE        date    ,
                             p_CERTIFICATE_CANCELATION_DATE  date    ,
                             p_RNK                           number  ,
                             p_MFORNK                        varchar2,
               p_DOCUMENT_TYPE                 number,
                             p_IDCARD_DOCUMENT_NUMBER        number,
                             p_IDCARD_NOTATION_NUMBER        varchar2,
                             p_PASSPORT_EXPIRY               date,
                             p_ret                       out number  ,
                             p_err                       out varchar2)
  IS
    l_serd  varchar2(64);
    l_nid   number;
    l_1     int;
  begin --#main

    bars_audit.trace('NOTA: p_TIN='||p_TIN);

    l_serd := replace(upper(p_PASSPORT_SERIES),'A','А');
    l_serd := replace(l_serd,'B','В');
    l_serd := replace(l_serd,'C','С');
    l_serd := replace(l_serd,'E','Е');
    l_serd := replace(l_serd,'H','Н');
    l_serd := replace(l_serd,'I','І');
    l_serd := replace(l_serd,'K','К');
    l_serd := replace(l_serd,'M','М');
    l_serd := replace(l_serd,'O','О');
    l_serd := replace(l_serd,'P','Р');
    l_serd := replace(l_serd,'T','Т');
    l_serd := replace(l_serd,'X','Х');

    begin --#1
      p_ret := null;
      p_err := null;
      
    check_notary_uniqueness(null, p_tin, p_certificate_number, p_ret, p_err);  
     
    if (p_ret is null) then
      begin --#2
         insert into notary (id)
         values (s_notary.nextval)
         returning id
         into l_nid; 
      
         begin --#3
          attribute_utl.set_value(l_nid,ATTR_CODE_TIN,                p_TIN);
          attribute_utl.set_value(l_nid,ATTR_CODE_FIRST_NAME,         p_first_name);
          attribute_utl.set_value(l_nid,ATTR_CODE_MIDDLE_NAME,        p_middle_name);
          attribute_utl.set_value(l_nid,ATTR_CODE_LAST_NAME,          p_last_name);
          attribute_utl.set_value(l_nid,ATTR_CODE_DATE_OF_BIRTH,      p_datp);
          attribute_utl.set_value(l_nid,ATTR_CODE_PASSPORT_SERIES,    p_PASSPORT_SERIES);
          attribute_utl.set_value(l_nid,ATTR_CODE_PASSPORT_NUMBER,    p_PASSPORT_NUMBER);
          attribute_utl.set_value(l_nid,ATTR_CODE_ADDRESS,            p_adr);
          attribute_utl.set_value(l_nid,ATTR_CODE_PASSPORT_ISSUER,    p_PASSPORT_ISSUER);
          attribute_utl.set_value(l_nid,ATTR_CODE_PASSPORT_ISSUED,    p_PASSPORT_ISSUED);
          attribute_utl.set_value(l_nid,ATTR_CODE_PHONE_NUMBER,       p_phone_number);
          attribute_utl.set_value(l_nid,ATTR_CODE_MOBILE_PHONE_NUMBER,p_MOBILE_PHONE_NUMBER);
          attribute_utl.set_value(l_nid,ATTR_CODE_EMAIL,              p_email);
          attribute_utl.set_value(l_nid,ATTR_CODE_NOTARY_TYPE,        p_NOTARY_TYPE);
          attribute_utl.set_value(l_nid,ATTR_CODE_CERT_NUMBER,        p_CERTIFICATE_NUMBER);
          attribute_utl.set_value(l_nid,ATTR_CODE_CERT_ISSUE_DATE,    p_CERTIFICATE_ISSUE_DATE);
          attribute_utl.set_value(l_nid,ATTR_CODE_CERT_CANCEL_DATE,   p_CERTIFICATE_CANCELATION_DATE);
          attribute_utl.set_value(l_nid,ATTR_CODE_DOCUMENT_TYPE,         p_DOCUMENT_TYPE);
          attribute_utl.set_value(l_nid,ATTR_CODE_IDCARD_DOCUMENT_NUM,   p_IDCARD_DOCUMENT_NUMBER);
          attribute_utl.set_value(l_nid,ATTR_CODE_IDCARD_NOTATION_NUM,   p_IDCARD_NOTATION_NUMBER);
          attribute_utl.set_value(l_nid,ATTR_CODE_PASSPORT_EXPIRY,       p_PASSPORT_EXPIRY);
          attribute_utl.set_value(l_nid,ATTR_CODE_STATE,              nota.NOTARY_STATE_ACTIVE);

        exception when OTHERS then --#3
          rollback to notary_id;
          p_ret := -4;
          p_err := sqlerrm||' '||dbms_utility.format_error_backtrace;
        end; --#3
        
        if p_mfornk is not null and p_rnk is not null then
          begin -- region
            insert
            into   notary_region (NOTARY_ID,KF,RNK)
                          values (l_nid,p_mfornk,p_rnk);
          exception when dup_val_on_index then
            update notary_region
            set    rnk=p_rnk
            where  NOTARY_ID=l_nid and
                   kf=p_mfornk;
                    when others then
--          raise_application_error(-30000,sqlerrm);
            rollback to notary_id;
            p_ret := -1;
            p_err := sqlerrm||' '||dbms_utility.format_error_backtrace;
          end;
        end if;
        p_ret := l_nid;
      end; --#2
     end if;
    exception when OTHERS then --#1
--    raise_application_error(-30000,sqlerrm);
      rollback to notary_id;
      p_ret := -2;
      p_err := sqlerrm||' '||dbms_utility.format_error_backtrace;
    end; --#1
  end; --#main;

--

  procedure edit_nota       (p_id                            number  ,
                             p_TIN                           varchar2,
                             p_adr                           varchar2,
                             p_datp                          date    ,  -- дата рождения
                             p_email                         varchar2,
                             p_last_name                     varchar2,  -- фамилия
                             p_first_name                    varchar2,  -- имя
                             p_middle_name                   varchar2,  -- отчество
                             p_phone_number                  varchar2,
                             p_MOBILE_PHONE_NUMBER           varchar2,
                             p_PASSPORT_SERIES               varchar2,
                             p_PASSPORT_NUMBER               varchar2,
                             p_PASSPORT_ISSUER               varchar2,
                             p_PASSPORT_ISSUED               date    ,
                             p_NOTARY_TYPE                   number  ,
                             p_CERTIFICATE_NUMBER            varchar2,
                             p_CERTIFICATE_ISSUE_DATE        date,
                             p_CERTIFICATE_CANCELATION_DATE  date,
                             p_RNK                           number  ,
                             p_MFORNK                        varchar2,
               p_DOCUMENT_TYPE                 number,
                             p_IDCARD_DOCUMENT_NUMBER        number,
                             p_IDCARD_NOTATION_NUMBER        varchar2,
                             p_PASSPORT_EXPIRY               date,
                             p_err                       out varchar2)
  is
    l_1    int;
  begin
    p_err := null;
    if p_id is not null then
--    begin
--      select id
--      into   l_1
--      from   notary
--      where  p_TIN<>'0000000000' and
--             tin=p_TIN           and
--             rownum<2;
--      if l_1<>p_id then
--        p_err := 'TIN '||p_TIN||' not unique';
--      end if;
--    exception when no_data_found then
--      null;
--    end;
--    if p_err is null then
      begin
        attribute_utl.set_value(p_id,ATTR_CODE_TIN,                p_TIN);
        attribute_utl.set_value(p_id,ATTR_CODE_FIRST_NAME,         p_first_name);
        attribute_utl.set_value(p_id,ATTR_CODE_MIDDLE_NAME,        p_middle_name);
        attribute_utl.set_value(p_id,ATTR_CODE_LAST_NAME,          p_last_name);
        attribute_utl.set_value(p_id,ATTR_CODE_DATE_OF_BIRTH,      p_datp);
        attribute_utl.set_value(p_id,ATTR_CODE_PASSPORT_SERIES,    p_PASSPORT_SERIES);
        attribute_utl.set_value(p_id,ATTR_CODE_PASSPORT_NUMBER,    p_PASSPORT_NUMBER);
        attribute_utl.set_value(p_id,ATTR_CODE_ADDRESS,            p_adr);
        attribute_utl.set_value(p_id,ATTR_CODE_PASSPORT_ISSUER,    p_PASSPORT_ISSUER);
        attribute_utl.set_value(p_id,ATTR_CODE_PASSPORT_ISSUED,    p_PASSPORT_ISSUED);
        attribute_utl.set_value(p_id,ATTR_CODE_PHONE_NUMBER,       p_phone_number);
        attribute_utl.set_value(p_id,ATTR_CODE_MOBILE_PHONE_NUMBER,p_MOBILE_PHONE_NUMBER);
        attribute_utl.set_value(p_id,ATTR_CODE_EMAIL,              p_email);
        attribute_utl.set_value(p_id,ATTR_CODE_NOTARY_TYPE,        p_NOTARY_TYPE);
        attribute_utl.set_value(p_id,ATTR_CODE_CERT_NUMBER,        p_CERTIFICATE_NUMBER);
        attribute_utl.set_value(p_id,ATTR_CODE_CERT_ISSUE_DATE,    p_CERTIFICATE_ISSUE_DATE);
        attribute_utl.set_value(p_id,ATTR_CODE_CERT_CANCEL_DATE,   p_CERTIFICATE_CANCELATION_DATE);
    attribute_utl.set_value(p_id,ATTR_CODE_DOCUMENT_TYPE,         p_DOCUMENT_TYPE);
        attribute_utl.set_value(p_id,ATTR_CODE_IDCARD_DOCUMENT_NUM,   p_IDCARD_DOCUMENT_NUMBER);
        attribute_utl.set_value(p_id,ATTR_CODE_IDCARD_NOTATION_NUM,   p_IDCARD_NOTATION_NUMBER);
        attribute_utl.set_value(p_id,ATTR_CODE_PASSPORT_EXPIRY,       p_PASSPORT_EXPIRY);
        if p_rnk is not null and p_mfornk is not null then
          begin -- region
            insert
            into   notary_region (NOTARY_ID,KF,RNK)
                          values (p_id,p_mfornk,p_rnk);
          exception when dup_val_on_index then
            update notary_region
            set    rnk=p_rnk
            where  NOTARY_ID=p_id and
                   kf=p_mfornk;
                    when others then
            p_err := sqlerrm||' '||dbms_utility.format_error_backtrace;
          end;
        end if;
      exception when no_data_found then
        p_err := sqlerrm||' '||dbms_utility.format_error_backtrace;
      end;
--    end if;
    end if;
  end;

--

  procedure add_accr        (p_notary_id                     number       ,
                             p_accreditation_type_id         number       ,
                             p_START_DATE                    date         ,
                             p_expiry_DATE                   date         ,
                             p_account_number                varchar2     ,
                             p_account_mfo                   varchar2     ,
                             p_state_id                      number       ,
                             p_branches                      varchar2_list,
                             p_segments_of_business          number_list  ,
                             p_ret               out         number       ,
                             p_err               out         varchar2)
  is
    l_accr_id  number;
  begin
    p_ret     := null;
    p_err     := null;
    l_accr_id := s_notary_accreditation.nextval;
    begin
      savepoint notary_accreditation_id;
      insert
      into   notary_accreditation (id       ,
                                   notary_id,
                                   accreditation_type_id)
                           values (l_accr_id  ,
                                   p_notary_id,
                                   p_accreditation_type_id);
      attribute_utl.set_value(l_accr_id,ATTR_CODE_ACCR_START_DATE,     p_start_date);
      attribute_utl.set_value(l_accr_id,ATTR_CODE_ACCR_EXPIRY_DATE,    p_expiry_date);
      attribute_utl.set_value(l_accr_id,ATTR_CODE_ACCR_ACCOUNT_NUMBER, p_account_number);
      attribute_utl.set_value(l_accr_id,ATTR_CODE_ACCR_ACCOUNT_MFO,    p_account_mfo);
      attribute_utl.set_value(l_accr_id,ATTR_CODE_ACCR_STATE,          nvl(p_state_id,ACCR_STATE_NEW_REQUEST));
--    attribute_utl.set_value(l_accr_id,ATTR_CODE_ACCR_BRANCHES,       tools.varchar2_list_to_string_list(p_branches));
      attribute_utl.set_value(l_accr_id,ATTR_CODE_ACCR_BRANCHES,       p_branches );
      attribute_utl.set_value(l_accr_id,ATTR_CODE_ACCR_SEG_OF_BUSINESS,p_segments_of_business);
      p_ret := l_accr_id;
    exception when OTHERS then
      rollback to notary_accreditation_id;
      p_ret := -1;
      p_err := sqlerrm||' '||dbms_utility.format_error_backtrace;
    end;
  end;

--

  procedure edit_accr       (p_accr_id                       number       ,
                             p_accreditation_type_id         number       ,
                             p_START_DATE                    date         ,
                             p_expiry_DATE                   date         ,
                             p_account_number                varchar2     ,
                             p_account_mfo                   varchar2     ,
                             p_state_id                      number       ,
                             p_branches                      varchar2_list,
                             p_segments_of_business          number_list  ,
                             p_ret               out         varchar2)
  is
  begin
    begin
--    attribute_utl.set_value(p_accr_id,LT_ACCREDITATION_TYPE,         p_accreditation_type_id);
      update notary_accreditation
      set    ACCREDITATION_TYPE_ID=p_accreditation_type_id
      where  id=p_accr_id;
      attribute_utl.set_value(p_accr_id,ATTR_CODE_ACCR_START_DATE,     p_start_date);
      attribute_utl.set_value(p_accr_id,ATTR_CODE_ACCR_EXPIRY_DATE,    p_expiry_date);
      attribute_utl.set_value(p_accr_id,ATTR_CODE_ACCR_ACCOUNT_NUMBER, p_account_number);
      attribute_utl.set_value(p_accr_id,ATTR_CODE_ACCR_ACCOUNT_MFO,    p_account_mfo);
      attribute_utl.set_value(p_accr_id,ATTR_CODE_ACCR_STATE,          nvl(p_state_id,ACCR_STATE_NEW_REQUEST));
--    attribute_utl.set_value(p_accr_id,ATTR_CODE_ACCR_BRANCHES,       tools.varchar2_list_to_string_list(p_branches));
      attribute_utl.set_value(p_accr_id,ATTR_CODE_ACCR_BRANCHES,       p_branches );
      attribute_utl.set_value(p_accr_id,ATTR_CODE_ACCR_SEG_OF_BUSINESS,p_segments_of_business);
      p_ret := null;
    exception when no_data_found then
      p_ret := sqlerrm||' '||dbms_utility.format_error_backtrace;
    end;
  end;

  function get_notary_name(
      p_notary_row in notary%rowtype)
  return varchar2
  is
  begin
      return trim(p_notary_row.middle_name || ' ' || p_notary_row.first_name || ' ' || p_notary_row.last_name);
  end;

  procedure close_notary(
      p_notary_id in integer)
  is
      l_notary_row notary%rowtype;
  begin
      l_notary_row := read_notary(p_notary_id, p_lock => true);
      if (l_notary_row.state_id = nota.NOTARY_STATE_CLOSED) then
          raise_application_error(-20000, 'Нотаріус {' || get_notary_name(l_notary_row) || '} вже закритий');
      end if;

      attribute_utl.set_value(p_notary_id, nota.ATTR_CODE_STATE, nota.NOTARY_STATE_CLOSED);
  end;

  procedure activate_notary(
      p_notary_id in integer)
  is
      l_notary_row notary%rowtype;
  begin
      l_notary_row := read_notary(p_notary_id, p_lock => true);
      if (l_notary_row.state_id = nota.NOTARY_STATE_ACTIVE) then
          raise_application_error(-20000, 'Нотаріус {' || get_notary_name(l_notary_row) || '} вже активний');
      end if;

      attribute_utl.set_value(p_notary_id, nota.ATTR_CODE_STATE, nota.NOTARY_STATE_ACTIVE);
  end;

--

  procedure close_accr      (p_accr_id                       number,
                             p_ret                       out varchar2)
  is
    l_accr_type  notary_accreditation.accreditation_type_id%type;
    l_close_dat  notary_accreditation.close_date%type;
  begin
    begin
      select accreditation_type_id,
             close_date
      into   l_accr_type,
             l_close_dat
      from   NOTARY_ACCREDITATION
      where  id=p_accr_id;
      if l_close_dat is null then
        attribute_utl.set_value(p_accr_id,ATTR_CODE_ACCR_CLOSE_DATE,sysdate);
        if l_accr_type=1 then
          attribute_utl.set_value(p_accr_id,ATTR_CODE_ACCR_STATE,ACCR_STATE_CLOSED);
        else
          attribute_utl.set_value(p_accr_id,ATTR_CODE_ACCR_STATE,ACCR_STATE_ONE_TIME_OFF);
        end if;
        p_ret := null;
      else
        p_ret := 'ACCREDITATION '||to_char(p_accr_id)||' already closed';
      end if;
    exception when no_data_found then
      p_ret := sqlerrm||' '||dbms_utility.format_error_backtrace;
    end;
  end;

--

  procedure redemption_accr  (p_accr_id                       number,
                              p_ret                       out varchar2)
  is
    l_accr_type  notary_accreditation.accreditation_type_id%type;
    l_STATE_ID   notary_accreditation.STATE_ID%type;
    l_close_dat  notary_accreditation.close_date%type;
  begin
    bars_audit.info('redemption_accr ' || p_accr_id);
    begin
      select accreditation_type_id,
             STATE_ID             ,
             close_date
      into   l_accr_type,
             l_STATE_ID ,
             l_close_dat
      from   NOTARY_ACCREDITATION
      where  id=p_accr_id;
      if l_close_dat is null then
        if l_STATE_ID=ACCR_STATE_CLOSED or l_STATE_ID=ACCR_STATE_ONE_TIME_OFF then
          p_ret := 'ACCREDITATION '||to_char(p_accr_id)||' already redemption';
        else
          if l_accr_type=1 then
            attribute_utl.set_value(p_accr_id,ATTR_CODE_ACCR_STATE,ACCR_STATE_CLOSED);
          else
            attribute_utl.set_value(p_accr_id,ATTR_CODE_ACCR_STATE,ACCR_STATE_ONE_TIME_OFF);
          end if;
        end if;
        p_ret := null;
      else
        p_ret := 'ACCREDITATION '||to_char(p_accr_id)||' already closed';
      end if;
    exception when no_data_found then
        bars_audit.error('redemption_accr' || chr(10) || sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
        p_ret := sqlerrm||' '||dbms_utility.format_error_backtrace;
    end;
  end;

    -- обробка запиту на акредитацію/оновлення даних по нотаріусу
    procedure process_accreditation_request(
        p_sender_mfo          varchar2,
        p_notary_type         integer,
        p_certificate_number  varchar2,
        p_first_name          varchar2,
        p_middle_name         varchar2,
        p_last_name           varchar2,
        p_date_of_birth       date,
        p_accreditation_type  integer,
        p_tin                 varchar2,
        p_passport_series     varchar2,
        p_passport_number     varchar2,
        p_passport_issuer     varchar2,
        p_passport_issued     date,
        p_address             varchar2,
        p_phone_number        varchar2,
        p_mobile_phone_number varchar2,
        p_email               varchar2,
        p_rnk                 integer ,
        p_account_number      varchar2,
        p_DOCUMENT_TYPE                 number,
        p_IDCARD_DOCUMENT_NUMBER        number,
        p_IDCARD_NOTATION_NUMBER        varchar2,
        p_PASSPORT_EXPIRY               date)
    is
        l_notary_row notary%rowtype;
        l_accreditation_row notary_accreditation%rowtype;
        l_error_message varchar2(32767 byte);

        procedure log_error
        is
        begin
            bars_audit.error('nota.process_accreditation_request' || chr(10) ||
                     l_error_message || chr(10) ||
                     'p_sender_mfo          : ' || p_sender_mfo          || chr(10) ||
                     'p_notary_type         : ' || p_notary_type         || chr(10) ||
                     'p_certificate_number  : ' || p_certificate_number  || chr(10) ||
                     'p_first_name          : ' || p_first_name          || chr(10) ||
                     'p_middle_name         : ' || p_middle_name         || chr(10) ||
                     'p_last_name           : ' || p_last_name           || chr(10) ||
                     'p_date_of_birth       : ' || p_date_of_birth       || chr(10) ||
                     'p_accreditation_type  : ' || p_accreditation_type  || chr(10) ||
                     'p_tin                 : ' || p_tin                 || chr(10) ||
                     'p_passport_series     : ' || p_passport_series     || chr(10) ||
                     'p_passport_number     : ' || p_passport_number     || chr(10) ||
                     'p_passport_issuer     : ' || p_passport_issuer     || chr(10) ||
                     'p_passport_issued     : ' || p_passport_issued     || chr(10) ||
                     'p_address             : ' || p_address             || chr(10) ||
                     'p_phone_number        : ' || p_phone_number        || chr(10) ||
                     'p_mobile_phone_number : ' || p_mobile_phone_number || chr(10) ||
                     'p_email               : ' || p_email               || chr(10) ||
                     'p_rnk                 : ' || p_rnk                 || chr(10) ||
                     'p_account_number      : ' || p_account_number      || chr(10) ||
                     'p_DOCUMENT_TYPE       : ' || p_DOCUMENT_TYPE       || chr(10) ||
                     'p_IDCARD_DOCUMENT_NUMBER      : ' || p_IDCARD_DOCUMENT_NUMBER      || chr(10) ||
                     'p_IDCARD_NOTATION_NUMBER      : ' || p_IDCARD_NOTATION_NUMBER      || chr(10) ||
                     'p_PASSPORT_EXPIRY     : ' || p_PASSPORT_EXPIRY);
        end;
    begin
        l_notary_row := read_notary(p_certificate_number, p_lock => true, p_raise_ndf => false);

        if (l_notary_row.id is null) then
            -- нотаріус не знайдений - відповідно, акредитації по ньому також відсутні
            -- можна створювати нового нотаріуса
            create_nota(p_tin,
                        p_address,
                        p_date_of_birth,
                        p_email,
                        p_last_name,
                        p_first_name,
                        p_middle_name,
                        p_phone_number,
                        p_mobile_phone_number,
                        p_passport_series,
                        p_passport_number,
                        p_passport_issuer,
                        p_passport_issued,
                        p_notary_type,
                        p_certificate_number,
                        null, -- РУ не зберігає та не передає дату початку дії свідоцтва про реєстрацію, але ця дата може заповнюватися в ЦА
                        null,
                        p_rnk,
                        p_sender_mfo,
            p_DOCUMENT_TYPE,
                        p_IDCARD_DOCUMENT_NUMBER,
                        p_IDCARD_NOTATION_NUMBER,
                        p_PASSPORT_EXPIRY,
                        l_notary_row.id,
                        l_error_message);

            if (l_notary_row.id is null or l_notary_row.id <= 0) then
                -- від'ємне значення l_notary_row.id означає, що при створенні нотаріуса відбулась помилка і l_error_message містить її опис
                -- залогуємо помилку і виходимо з процедури - повертати помилку нікому, оскільки процес запускається job'ом
                -- в подальшому було б добре створити спеціальну таблицю запитів від РУ і вести історію їх обробки (в т.ч. реєструвати помилки обробки)
                -- також необхідний буде інтерфейс користувача в ЦА для моніторингу обробки заявок від РУ
                log_error();
                rollback;
                return;
            end if;
        else
            -- нотаріус вже існує - перевіримо коректність його типу та відсутність діючої акредитації
            if (l_notary_row.notary_type <> p_notary_type) then
                raise_application_error(-20000, 'Тип нотаріуса в ЦА {' || list_utl.get_item_name(nota.LT_NOTARY_TYPE, l_notary_row.notary_type) ||
                                                '} не відповідає типу нотаріуса РУ {' || list_utl.get_item_name(nota.LT_NOTARY_TYPE, p_notary_type) || '}');
            end if;

            if (l_notary_row.DOCUMENT_TYPE <> p_DOCUMENT_TYPE) then
                raise_application_error(-20000, 'Тип документу {' || list_utl.get_item_name(nota.LT_NOTARY_DOCUMENT_TYPE, l_notary_row.DOCUMENT_TYPE) ||
                                                '} не відповідає типу документа {' || list_utl.get_item_name(nota.LT_NOTARY_DOCUMENT_TYPE, p_DOCUMENT_TYPE) || '}');
            end if;

            l_accreditation_row := get_last_accreditation(l_notary_row.id,
                                                          p_sender_mfo,
                                                          number_list(nota.ACCR_STATE_NEW_REQUEST, nota.ACCR_STATE_ACTIVE),
                                                          p_raise_ndf => false);

            if (l_accreditation_row.id is not null) then
                raise_application_error(-20000, 'Акредитація для РУ {' || p_sender_mfo || '} вже зареєстрована');
            end if;
        end if;

        -- нотаріус вже існує, або був щойно створений
        -- діючі акредитації для p_sender_mfo відсутні - зареєструємо запит на отримання акредитації
        add_accr(l_notary_row.id,
                 p_accreditation_type,
                 null,
                 null,
                 p_account_number,
                 p_sender_mfo,
                 null,
                 null,
                 null,
                 l_accreditation_row.id,
                 l_error_message);

        if (l_accreditation_row.id is null or l_accreditation_row.id <= 0) then
            rollback;
            log_error();
        end if;
    exception
        when others then
             rollback;
             l_error_message := sqlerrm || chr(10) || dbms_utility.format_error_backtrace();
             log_error();
    end;

    procedure process_alter_request(
        p_sender_mfo          varchar2,
        p_notary_type         integer,
        p_certificate_number  varchar2,
        p_account_number      varchar2)
    is
        l_notary_row notary%rowtype;
        l_accreditation_row notary_accreditation%rowtype;
    begin
        l_notary_row := read_notary(p_certificate_number);

        if (l_notary_row.notary_type <> p_notary_type) then
            raise_application_error(-20000, 'Тип нотаріуса в ЦА {' || list_utl.get_item_name(nota.LT_NOTARY_TYPE, l_notary_row.notary_type) ||
                                            '} не відповідає типу нотаріуса РУ {' || list_utl.get_item_name(nota.LT_NOTARY_TYPE, p_notary_type) || '}');
        end if;

        l_accreditation_row := get_last_accreditation(l_notary_row.id,
                                                      p_sender_mfo,
                                                      number_list(nota.ACCR_STATE_NEW_REQUEST, nota.ACCR_STATE_ACTIVE),
                                                      p_lock => true);

        attribute_utl.set_value(l_accreditation_row.id, nota.ATTR_CODE_ACCR_ACCOUNT_NUMBER, p_account_number);
    exception
        when others then
             rollback;
             bars_audit.error('nota.process_alter_request' || chr(10) ||
                              sqlerrm || chr(10) || dbms_utility.format_error_backtrace() || chr(10) ||
                              'p_sender_mfo         : ' || p_sender_mfo         || chr(10) ||
                              'p_notary_type        : ' || p_notary_type        || chr(10) ||
                              'p_certificate_number : ' || p_certificate_number || chr(10) ||
                              'p_account_number     : ' || p_account_number);
    end;

--

  function header_version return varchar2

  is
  begin
    return G_HEADER_VERSION;
  end;

  function body_version   return varchar2
  is
  begin
    return G_BODY_VERSION;
  end;

  function Get_Accr_Branches(p_accr_id notary_accreditation.id%type) return string is
  begin
--  return tools.words_to_string(attribute_utl.get_string_values(p_accr_id, ATTR_CODE_ACCR_BRANCHES));
    return tools.words_to_string(tools.varchar2_list_to_string_list(attribute_utl.get_string_values(p_accr_id, ATTR_CODE_ACCR_BRANCHES)));
  end Get_Accr_Branches;

  function Get_Accr_BranchNames(p_accr_id notary_accreditation.id%type) return string is
    result string_list;
  begin
    select trim(nb) bulk collect into result from banks
     inner join table(attribute_utl.get_string_values(p_accr_id, ATTR_CODE_ACCR_BRANCHES)) on mfo = column_value;
    return tools.words_to_string(result);
  end Get_Accr_BranchNames;

  function Get_Accr_Seg_of_Business(p_accr_id notary_accreditation.id%type) return string is
    result string_list;
  begin
    select list_item_name bulk collect into result from v_list_items
     inner join table(attribute_utl.get_number_values(p_accr_id, ATTR_CODE_ACCR_SEG_OF_BUSINESS)) on list_item_id = column_value
    where list_code = 'NOTARY_SEGMENT_OF_BUSINESS';
    return tools.words_to_string(result);
  end Get_Accr_Seg_of_Business;
  
  
END nota;
/

show err;

PROMPT *** Create  grants  NOTA ***
grant EXECUTE                                                                on NOTA            to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/package/nota.sql =========*** End *** ======
PROMPT ===================================================================================== 
