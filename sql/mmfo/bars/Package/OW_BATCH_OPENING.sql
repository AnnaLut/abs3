

 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/OW_BATCH_OPENING.sql =========*** 
 PROMPT ===================================================================================== 
 
CREATE OR REPLACE PACKAGE "BARS"."OW_BATCH_OPENING" is

  -- Author  : VITALII.KHOMIDA
  -- Created : 13.04.2017 11:46:26
  -- Purpose :
  g_header_version constant varchar2(64) := 'version 1.003 02/10/2017';

  other_file  constant number := 0; -- будь-яке пакетне відкритя
  salary_file constant number := 1; -- зарплатні файли
  kk_file     constant number := 2; -- картка киянина
  esk_file    constant number := 3; -- студентські квитки
  mp_file     constant number := 4; -- муніципальні проекти
  c_width     constant number := 480; -- ширина фото
  c_height    constant number := 640; -- висота фото

  type t_fileinf is record(
    file_name varchar2(250),
    file_data blob,
    file_ext  varchar2(10));

  type t_fileinflist is table of t_fileinf;
  -- header_version - возвращает версию заголовка пакета
  function header_version return varchar2;

  -- body_version - возвращает версию тела пакета
  function body_version return varchar2;

  procedure import_file(p_filename in varchar2,
                        p_filebody in blob,
                        p_filetype in number default 0,
                        p_fileid   out number);

  FUNCTION split_key(p_key     IN VARCHAR2) RETURN VARCHAR2;

  -- импорт ахфива gzip (gz), который содержит xlm с фото формата BASE64
  PROCEDURE import_file_gz(p_filename         IN VARCHAR2
                          ,p_filebody         IN BLOB
                          ,p_external_file_id IN VARCHAR2
                          ,p_filetype         in number
                          ,p_fileid           OUT NUMBER);

  procedure create_deal(p_fileid in number,
                        -- p_proect_id is not null - SALARY
                        -- p_proect_id is null - PENSION, SOCIAL
                        p_proect_id in number,
                        p_card_code in varchar2,
                        p_branch    in varchar2,
                        p_isp       in number);

  procedure form_ticket(p_fileid     in number,
                        p_ticketname out varchar2,
                        p_ticketdata out clob);

    -- процедура принимает архив на пакетное открытие в формате блоб, и возращает тикет в формате клоб
  PROCEDURE batch_get_process(p_filename         IN VARCHAR2
                             ,p_filebody         IN BLOB
                             ,p_external_file_id IN VARCHAR2
                             ,p_filetype         in number
                             ,p_ticketdata       OUT BLOB);

end;
/
  grant DEBUG,EXECUTE  ON "BARS"."OW_BATCH_OPENING" TO "BARSTRANS";
  grant DEBUG,EXECUTE  ON "BARS"."OW_BATCH_OPENING" TO "BARS_ACCESS_DEFROLE";
/  
  
CREATE OR REPLACE PACKAGE BODY "BARS"."OW_BATCH_OPENING" is

  g_body_version constant varchar2(64) := 'version 1.004 02/10/2017';

  g_modcode constant varchar2(3) := 'BPK';

  g_w4_eng_mask constant varchar2(100) := '^[A-Z0-9/.-]+$';
  g_w4_fio_char     constant varchar2(100) := '^[А-Я'||'ҐІЄЇ'||chr(39)||'-]+$';
  g_w4_email_char   constant varchar2(100) := '^[A-Z0-9@.-]+$';
  g_digit           constant varchar2(100) := '^[0-9]+$';
  g_all_char        constant varchar2(100) := '^[А-Я0-9'||'ҐІЄЇ'||chr(39)||'/., -]+$';

  type t_batch_header is table of ow_batch_files%rowtype index by pls_integer;
  type t_batch_list   is table of ow_batch_open_data%rowtype index by pls_integer;
  type t_photo_list   is table of ow_batch_photo%rowtype index by pls_integer;
  -- header_version - возвращает версию заголовка пакета
  function header_version return varchar2 is
  begin
    return 'Package header ow_batch_opening ' || g_header_version;
  end header_version;

  -------------------------------------------------------------------------------
  -- body_version - возвращает версию тела пакета
  function body_version return varchar2 is
  begin
    return 'Package body ow_batch_opening ' || g_body_version;
  end body_version;

  function get_file_ext(p_filename in varchar2) return varchar2 is
  begin
    if instr(p_filename, '.') > 0 then
      return lower(substr(p_filename, instr(p_filename, '.', -1)+1, 10));
    else
      return null;
    end if;
  end;

  procedure set_state(p_fileid in number,
                      p_state  in number) is
  pragma autonomous_transaction;
  begin
    update ow_batch_files t set t.state = p_state where t.id = p_fileid;
    commit;
  end;

  -- функиця привода rnk к нужному формату
  FUNCTION split_key(p_key     IN VARCHAR2) RETURN VARCHAR2 IS
    l_old_key VARCHAR2(38 CHAR);
    p_kf      VARCHAR2(8);
  BEGIN
    bars_sqnc.split_key(p_key     => p_key
                       ,p_old_key => l_old_key
                       ,p_kf      => p_kf);
    RETURN l_old_key;
  END split_key;

  -------------------------------------------------------------------------------
  -- create_customer
  -- Процедура регистрации клиента по файлу
  --
  procedure create_customer (
    p_client in out ow_batch_open_data%rowtype,
    p_branch        varchar2 )
  is
    l_rnk  number := null;
    l_nmk  varchar2(70);
    l_nmkv varchar2(70);
    l_nmkk varchar2(38);
    l_adr  varchar2(70);
    l_codcagent customer.codcagent%type;
    l_ise customer.ise%type;

  begin

    -- LastName - фамилия, FirstName - имя
    l_nmk  := substr(trim(p_client.last_name || ' ' || p_client.first_name || ' ' || p_client.middle_name), 1, 70);
    l_nmkv := substr(f_translate_kmu(trim(l_nmk)),1,70);
    l_nmkk := substr(p_client.last_name || ' ' || p_client.first_name, 1, 38);

    select substr(trim(p_client.addr1_domain) ||
             nvl2(trim(p_client.addr1_region),   ' ' || trim(p_client.addr1_region), '') ||
             nvl2(trim(p_client.addr1_cityname), ' ' || trim(p_client.addr1_cityname), '') ||
             nvl2(trim(p_client.addr1_street),   ' ' || trim(p_client.addr1_street), ''), 1, 70)
      into l_adr from dual;

    if p_client.resident = '1' then
      l_codcagent := 5;
      l_ise := '14300';
    else
      l_codcagent := 6;
      l_ise := '00000';
    end if;
    kl.setCustomerAttr (
       Rnk_         => l_rnk,         -- Customer number
       Custtype_    => 3,             -- Тип клиента: 1-банк, 2-юр.лицо, 3-физ.лицо
       Nd_          => null,          -- № договора
       Nmk_         => l_nmk,         -- Наименование клиента
       Nmkv_        => l_nmkv,        -- Наименование клиента международное
       Nmkk_        => l_nmkk,        -- Наименование клиента краткое
       Adr_         => l_adr,                     -- Адрес клиента
       Codcagent_   => l_codcagent,               -- Характеристика
       Country_     => p_client.country,          -- Страна
       Prinsider_   => 99,                        -- Признак инсайдера
       Tgr_         => 2,                         -- Тип гос.реестра
       Okpo_        => trim(p_client.okpo),       -- ОКПО
       Stmt_        => 0,                         -- Формат выписки
       Sab_         => null,                      -- Эл.код
       DateOn_      => bankdate,                  -- Дата регистрации
       Taxf_        => null,                      -- Налоговый код
       CReg_        => -1,                        -- Код обл.НИ
       CDst_        => -1,                        -- Код район.НИ
       Adm_         => null,                      -- Админ.орган
       RgTax_       => null,                      -- Рег номер в НИ
       RgAdm_       => null,                      -- Рег номер в Адм.
       DateT_       => null,                      -- Дата рег в НИ
       DateA_       => null,                      -- Дата рег. в администрации
       Ise_         => l_ise,                     -- Инст. сек. экономики
       Fs_          => null,                      -- Форма собственности
       Oe_          => null,                      -- Отрасль экономики
       Ved_         => null,                      -- Вид эк. деятельности
       Sed_         => null,                      -- Форма хозяйствования
       Notes_       => null,                      -- Примечание
       Notesec_     => null,                      -- Примечание для службы безопасности
       CRisk_       => 1,                         -- Категория риска
       Pincode_     => null,                      --
       RnkP_        => null,                      -- Рег. номер холдинга
       Lim_         => null,                      -- Лимит кассы
       NomPDV_      => null,                      -- № в реестре плат. ПДВ
       MB_          => 9,                         -- Принадл. малому бизнесу
       BC_          => 0,                         -- Признак НЕклиента банка
       Tobo_        => p_branch,                  -- Код безбалансового отделения
       Isp_         => null                       -- Менеджер клиента (ответ. исполнитель)
    );

    kl.setCustomerEN (
       p_rnk    => l_rnk,
       p_k070   => nvl(getglobaloption('CUSTK070'), '00000'),  -- ise
       p_k080   => nvl(getglobaloption('CUSTK080'), '00'),     -- fs
       p_k110   => '00000',                                    -- ved
       p_k090   => '00000',                                    -- oe
       p_k050   => '000',                                      -- k050
       p_k051   => '00'                                        -- sed
    );

    kl.setCustomerElement(
       Rnk_   => l_rnk,
       Tag_   => 'FGIDX',
       Val_   => trim(p_client.addr1_pcode),
       Otd_   => 0
    );

    kl.setCustomerElement(
       Rnk_   => l_rnk,
       Tag_   => 'FGOBL',
       Val_   => trim(p_client.addr1_domain),
       Otd_   => 0
    );

    kl.setCustomerElement(
       Rnk_   => l_rnk,
       Tag_   => 'FGDST',
       Val_   => trim(p_client.addr1_region),
       Otd_   => 0
    );

    kl.setCustomerElement(
       Rnk_   => l_rnk,
       Tag_   => 'FGTWN',
       Val_   => trim(p_client.addr1_cityname),
       Otd_   => 0
    );

    kl.setCustomerElement(
       Rnk_   => l_rnk,
       Tag_   => 'FGADR',
       Val_   => trim(p_client.addr1_street),
       Otd_   => 0
    );

    kl.setCustomerAddressByTerritory (
       Rnk_           => l_rnk,
       TypeId_        => 1,
       Country_       => p_client.country,
       Zip_           => substr(trim(p_client.addr1_pcode),1,20),
       Domain_        => substr(trim(p_client.addr1_domain),1,30),
       Region_        => substr(trim(p_client.addr1_region),1,30),
       Locality_      => substr(trim(p_client.addr1_cityname),1,30),
       Address_       => substr(trim(p_client.addr1_street),1,100),
       TerritoryId_   => null
    );

    if p_client.addr2_pcode is not null
    or p_client.addr2_domain is not null
    or p_client.addr2_region is not null
    or p_client.addr2_cityname is not null
    or p_client.addr2_street is not null then
       kl.setCustomerAddressByTerritory (
          Rnk_           => l_rnk,
          TypeId_        => 2,
          Country_       => p_client.country,
          Zip_           => substr(trim(p_client.addr2_pcode),1,20),
          Domain_        => substr(trim(p_client.addr2_domain),1,30),
          Region_        => substr(trim(p_client.addr2_region),1,30),
          Locality_      => substr(trim(p_client.addr2_cityname),1,30),
          Address_       => substr(trim(p_client.addr2_street),1,100),
          TerritoryId_   => null
       );
    end if;

    kl.setPersonAttr (
       Rnk_      => l_rnk,
       Sex_      => p_client.gender,
       Passp_    => nvl(p_client.type_doc, 1),
       Ser_      => trim(p_client.paspseries),
       Numdoc_   => trim(p_client.paspnum),
       Pdate_    => trim(p_client.paspdate),
       Organ_    => substr(trim(p_client.paspissuer),1,70),
       Bday_     => p_client.bday,
       Bplace_   => null,
       Teld_     => p_client.phone_home,
       Telw_        => null,
       actual_date_ => p_client.pasp_end_date,
       eddr_id_     => p_client.pasp_eddrid_id
    );

    kl.setCustomerElement(
       Rnk_   => l_rnk,
       Tag_   => 'SN_FN',
       Val_   => p_client.first_name,
       Otd_   => 0
    );

    kl.setCustomerElement(
       Rnk_   => l_rnk,
       Tag_   => 'SN_LN',
       Val_   => p_client.last_name,
       Otd_   => 0
    );

    if p_client.middle_name is not null then
       kl.setCustomerElement(
          Rnk_   => l_rnk,
          Tag_   => 'SN_MN',
          Val_   => p_client.middle_name,
          Otd_   => 0
       );
    end if;

    if p_client.phone_mob is not null then
       kl.setCustomerElement(
          Rnk_   => l_rnk,
          Tag_   => 'MPNO ',
          Val_   => p_client.phone_mob,
          Otd_   => 0
       );
    end if;

    kl.setCustomerElement(
      Rnk_   => l_rnk,
      Tag_   => 'K013',
      Val_   => '5',
      Otd_   => 0
    );

    p_client.rnk := l_rnk;

  end;

  procedure alter_client (p_rnk number, p_clientdata ow_batch_open_data%rowtype)
  is
    l_customer       customer%rowtype;
    l_person         person%rowtype;
    l_custadr1       customer_address%rowtype;
    l_custadr2       customer_address%rowtype;
    l_cust_fn        customerw.value%type;
    l_cust_ln        customerw.value%type;
    l_cust_mn        customerw.value%type;
    l_cust_mname     customerw.value%type;
    l_cust_phonemob  customerw.value%type;
    l_cust_email     customerw.value%type;
    l_cust_k013      customerw.value%type;
    l_cust_fgidx     customerw.value%type;
    l_cust_fgobl     customerw.value%type;
    l_cust_fgdst     customerw.value%type;
    l_cust_fgtwn     customerw.value%type;
    l_cust_fgadr     customerw.value%type;
    h varchar2(100) := 'bars_ow.alter_client. ';
  begin

    bars_audit.info(h || 'Start. p_rnk=>' || p_rnk);

    if p_rnk is not null then

       -- данные клиента
       begin
          select * into l_customer from customer where rnk = p_rnk;
       exception when no_data_found then null;
       end;
       begin
          select * into l_person from person where rnk = p_rnk;
       exception when no_data_found then
          l_person.pdate  := null;
          l_person.organ  := null;
          l_person.bday   := null;
          l_person.sex    := null;
          l_person.teld   := null;
       end;
       begin
          select * into l_custadr1 from customer_address where rnk = p_rnk and type_id = 1;
       exception when no_data_found then
          l_custadr1.zip      := null;
          l_custadr1.domain   := null;
          l_custadr1.region   := null;
          l_custadr1.locality := null;
          l_custadr1.address  := null;
       end;
       begin
          select * into l_custadr2 from customer_address where rnk = p_rnk and type_id = 2;
       exception when no_data_found then
          l_custadr2.zip      := null;
          l_custadr2.domain   := null;
          l_custadr2.region   := null;
          l_custadr2.locality := null;
          l_custadr2.address  := null;
       end;
       begin
          select min(decode(tag,'SN_FN',value,null)),
                 min(decode(tag,'SN_LN',value,null)),
                 min(decode(tag,'SN_MN',value,null)),
                 min(decode(tag,'PC_MF',value,null)),
                 min(decode(tag,'MPNO ',value,null)),
                 min(decode(tag,'EMAIL',value,null)),
                 min(decode(tag,'K013 ',value,null)),
                 min(decode(tag,'FGIDX',value,null)),
                 min(decode(tag,'FGOBL',value,null)),
                 min(decode(tag,'FGDST',value,null)),
                 min(decode(tag,'FGTWN',value,null)),
                 min(decode(tag,'FGADR',value,null))
            into l_cust_fn, l_cust_ln, l_cust_mn, l_cust_mname,
                 l_cust_phonemob, l_cust_email, l_cust_k013,
                 l_cust_fgidx, l_cust_fgobl, l_cust_fgdst, l_cust_fgtwn, l_cust_fgadr
            from customerw
           where rnk = p_rnk;
       exception when no_data_found then
          l_cust_phonemob := null;
          l_cust_email    := null;
       end;

       -- обновляем незаполненные данные
       if ( l_customer.nmkv is null and ( p_clientdata.eng_first_name is not null or p_clientdata.eng_last_name is not null ) )
       or ( l_customer.country is null and p_clientdata.country is not null )
       or l_customer.crisk is null then
          update customer
             set nmkv = nvl(nmkv, trim(p_clientdata.eng_last_name||' '||p_clientdata.eng_first_name)),
                 country = nvl(country, p_clientdata.country),
                 crisk   = nvl(crisk,1)
           where rnk = p_rnk;
       end if;

       if ( l_person.pdate is null
         or l_person.organ is null
         or l_person.bday  is null
         or l_person.sex   is null
         or l_person.teld  is null ) and
          ( p_clientdata.paspissuer is not null
         or p_clientdata.paspdate   is not null
         or p_clientdata.bday       is not null
         or p_clientdata.gender     is not null
         or p_clientdata.phone_home is not null ) then
          update person
             set pdate = nvl(pdate, p_clientdata.paspdate),
                 organ = nvl(organ, substr(trim(p_clientdata.paspissuer),1,70)),
                 bday  = nvl(bday,  p_clientdata.bday),
                 sex   = nvl(sex,   p_clientdata.gender),
                 teld  = nvl(teld,  p_clientdata.phone_home)
           where rnk = p_rnk;
       end if;

       if ( l_custadr1.zip      is null
         or l_custadr1.domain   is null
         or l_custadr1.region   is null
         or l_custadr1.locality is null
         or l_custadr1.address  is null ) and
          ( p_clientdata.addr1_cityname is not null
         or p_clientdata.addr1_pcode    is not null
         or p_clientdata.addr1_domain   is not null
         or p_clientdata.addr1_region   is not null
         or p_clientdata.addr1_street   is not null ) then
          update customer_address
             set zip      = nvl(zip,      p_clientdata.addr1_pcode),
                 domain   = nvl(domain,   p_clientdata.addr1_domain),
                 region   = nvl(region,   p_clientdata.addr1_region),
                 locality = nvl(locality, p_clientdata.addr1_cityname),
                 address  = nvl(address,  p_clientdata.addr1_street)
           where rnk = p_rnk and type_id = 1;
          if sql%rowcount = 0 then
             insert into customer_address (rnk, type_id, country, zip, domain, region, locality, address)
             values (p_rnk, 1, 804, p_clientdata.addr1_pcode, p_clientdata.addr1_domain, p_clientdata.addr1_region, p_clientdata.addr1_cityname ,p_clientdata.addr1_street);
          end if;
       end if;

       if l_cust_fgidx is null and p_clientdata.addr1_pcode is not null then
          kl.setCustomerElement(
             Rnk_   => p_rnk,
             Tag_   => 'FGIDX',
             Val_   => trim(p_clientdata.addr1_pcode),
             Otd_   => 0
          );
       end if;

       if l_cust_fgobl is null and p_clientdata.addr1_domain is not null then
          kl.setCustomerElement(
             Rnk_   => p_rnk,
             Tag_   => 'FGOBL',
             Val_   => trim(p_clientdata.addr1_domain),
             Otd_   => 0
          );
       end if;

       if l_cust_fgdst is null and p_clientdata.addr1_region is not null then
          kl.setCustomerElement(
             Rnk_   => p_rnk,
             Tag_   => 'FGDST',
             Val_   => trim(p_clientdata.addr1_region),
             Otd_   => 0
          );
       end if;

       if l_cust_fgtwn is null and p_clientdata.addr1_cityname is not null then
          kl.setCustomerElement(
             Rnk_   => p_rnk,
             Tag_   => 'FGTWN',
             Val_   => trim(p_clientdata.addr1_cityname),
             Otd_   => 0
          );
       end if;

       if l_cust_fgadr is null and p_clientdata.addr1_street is not null then
          kl.setCustomerElement(
             Rnk_   => p_rnk,
             Tag_   => 'FGADR',
             Val_   => trim(p_clientdata.addr1_street),
             Otd_   => 0
          );
       end if;

       if ( l_custadr2.zip      is null
         or l_custadr2.domain   is null
         or l_custadr2.region   is null
         or l_custadr2.locality is null
         or l_custadr2.address  is null ) and
          ( p_clientdata.addr2_cityname is not null
         or p_clientdata.addr2_pcode    is not null
         or p_clientdata.addr2_domain   is not null
         or p_clientdata.addr2_region   is not null
         or p_clientdata.addr2_street   is not null ) then
          update customer_address
             set zip      = nvl(zip,      p_clientdata.addr2_pcode),
                 domain   = nvl(domain,   p_clientdata.addr2_domain),
                 region   = nvl(region,   p_clientdata.addr2_region),
                 locality = nvl(locality, p_clientdata.addr2_cityname),
                 address  = nvl(address,  p_clientdata.addr2_street)
           where rnk = p_rnk and type_id = 2;
          if sql%rowcount = 0 then
             insert into customer_address (rnk, type_id, country, zip, domain, region, locality, address)
             values (p_rnk, 2, 804, p_clientdata.addr2_pcode, p_clientdata.addr2_domain, p_clientdata.addr2_region, p_clientdata.addr2_cityname ,p_clientdata.addr2_street);
          end if;
       end if;

       if l_cust_fn is null then
          begin
             insert into customerw (rnk, tag, value, isp)
             values (p_rnk, 'SN_FN', p_clientdata.first_name, 0);
          exception when dup_val_on_index then
             update customerw
                set value = p_clientdata.first_name
              where rnk = p_rnk and tag = 'SN_FN';
          end;
       end if;

       if l_cust_ln is null then
          begin
             insert into customerw (rnk, tag, value, isp)
             values (p_rnk, 'SN_LN', p_clientdata.last_name, 0);
          exception when dup_val_on_index then
             update customerw
                set value = p_clientdata.last_name
              where rnk = p_rnk and tag = 'SN_LN';
          end;
       end if;

       if l_cust_mn is null then
          begin
             insert into customerw (rnk, tag, value, isp)
             values (p_rnk, 'SN_MN', p_clientdata.middle_name, 0);
          exception when dup_val_on_index then
             update customerw
                set value = p_clientdata.middle_name
              where rnk = p_rnk and tag = 'SN_MN';
          end;
       end if;

       if l_cust_mname is null then
          begin
             insert into customerw (rnk, tag, value, isp)
             values (p_rnk, 'PC_MF', p_clientdata.mname, 0);
          exception when dup_val_on_index then
             update customerw
                set value = p_clientdata.mname
              where rnk = p_rnk and tag = 'PC_MF';
          end;
       end if;

       if l_cust_phonemob is null then
          begin
             insert into customerw (rnk, tag, value, isp)
             values (p_rnk, 'MPNO ', p_clientdata.phone_mob, 0);
          exception when dup_val_on_index then
             update customerw
                set value = p_clientdata.phone_mob
              where rnk = p_rnk and tag = 'MPNO ';
          end;
       end if;

       if l_cust_email is null then
          begin
             insert into customerw (rnk, tag, value, isp)
             values (p_rnk, 'EMAIL', p_clientdata.email, 0);
          exception when dup_val_on_index then
             update customerw
                set value = p_clientdata.email
              where rnk = p_rnk and tag = 'EMAIL';
          end;
       end if;

       if l_cust_k013 is null then
          begin
             insert into customerw (rnk, tag, value, isp)
             values (p_rnk, 'K013', '5', 0);
          exception when dup_val_on_index then
             update customerw
                set value = '5'
              where rnk = p_rnk and tag = 'K013';
          end;
       end if;

    end if;

    bars_audit.info(h || 'Finish.');

  exception when others then
    raise_application_error(-20000, 'Помилка поновлення реквізитів клієнта РНК ' || p_rnk || ' : ' || sqlerrm, true);
  end alter_client;
  --Розархівування файлів
  function get_files_list(p_zipfile in blob) return t_fileinflist is

    l_filelist as_zip.file_list := as_zip.file_list();
    l_fi_list  t_fileinflist := t_fileinflist();
  begin
    l_filelist := as_zip.get_file_list(p_zipped_blob => p_zipfile);
    for i in l_filelist.first .. l_filelist.last
    loop
      l_fi_list.extend;
      l_fi_list(i).file_name := substr(l_filelist(i), 1, 250);

      l_fi_list(i).file_data := as_zip.get_file(p_zipped_blob => p_zipfile,
                                                             p_file_name   => l_filelist(i),
                                                             p_encoding    => 'CL8MSWIN1251');
      l_fi_list(i).file_ext := get_file_ext(l_fi_list(l_fi_list.last).file_name);
    end loop;
    return l_fi_list;
  end;

  -- Отримання списку файлів
  function get_files_from_ext(p_fileinflist in t_fileinflist,
                              p_file_ext    in varchar2)
    return t_fileinflist is
    l_fi_list t_fileinflist := t_fileinflist();
  begin
    for i in p_fileinflist.first .. p_fileinflist.last
    loop
      if lower(p_fileinflist(i).file_ext) = (p_file_ext) then
        l_fi_list.extend;
        l_fi_list(l_fi_list.last) := p_fileinflist(i);
      end if;
    end loop;
    return l_fi_list;
  end;

  function convert_photo_data(p_fileinflist in t_fileinflist)
    return t_fileinflist is
    l_photo   ordimage;
    l_fi_list t_fileinflist := t_fileinflist();
  begin
    l_fi_list := p_fileinflist;
    for i in l_fi_list.first .. l_fi_list.last
    loop
      l_photo := ordimage(l_fi_list(i).file_data, 1);
      if l_photo.width <> c_width and l_photo.height <> c_height then
        ordimage.process(l_photo, 'fileFormat=JPEG, fixedScale=' || c_width || ' ' || c_height);
        l_fi_list(i).file_data := l_photo.source.localdata;
      end if;
    end loop;
    return l_fi_list;
  end;

  -- преобразовать фото до нужного размера
  FUNCTION convert_photo_data(p_photo_blob IN BLOB)
     RETURN BLOB
  IS
     l_photo     ordimage;
     l_blob      BLOB := p_photo_blob;
  BEGIN
     l_photo  := ordimage(p_photo_blob, 1);

     IF l_photo.width <> c_width AND l_photo.height <> c_height THEN
        ordimage.process(l_photo, 'fileFormat=JPEG, fixedScale=' || c_width || ' ' || c_height);
        l_blob := l_photo.source.localdata;
     END IF;

     RETURN l_blob;
  END;

  -- преобразовать тип данныйх BLOB в CLOB
  FUNCTION blob_to_clob(blob_in IN BLOB) RETURN CLOB AS
    v_clob    CLOB;
    v_varchar VARCHAR2(32767);
    v_start   PLS_INTEGER := 1;
    v_buffer  PLS_INTEGER := 32767;
  BEGIN
    dbms_lob.createtemporary(v_clob
                            ,FALSE);

    FOR i IN 1 .. ceil(dbms_lob.getlength(blob_in) / v_buffer)
    LOOP

      v_varchar := utl_raw.cast_to_varchar2(dbms_lob.substr(blob_in
                                                           ,v_buffer
                                                           ,v_start));

      dbms_lob.writeappend(v_clob
                          ,length(v_varchar)
                          ,v_varchar);
      v_start := v_start + v_buffer;
    END LOOP;
    RETURN v_clob;
  END blob_to_clob;

  FUNCTION clob_to_blob(p_clob CLOB) RETURN BLOB AS
    l_blob          BLOB;
    l_dest_offset   INTEGER := 1;
    l_source_offset INTEGER := 1;
    l_lang_context  INTEGER := dbms_lob.default_lang_ctx;
    l_warning       INTEGER := dbms_lob.warn_inconvertible_char;
  BEGIN

    dbms_lob.createtemporary(l_blob
                            ,TRUE);
    dbms_lob.converttoblob(dest_lob     => l_blob
                          ,src_clob     => p_clob
                          ,amount       => dbms_lob.lobmaxsize
                          ,dest_offset  => l_dest_offset
                          ,src_offset   => l_source_offset
                          ,blob_csid    => dbms_lob.default_csid
                          ,lang_context => l_lang_context
                          ,warning      => l_warning);
    RETURN l_blob;
  END;

  function check_phone(p_phone varchar2) return varchar2 is
    l_ret varchar2(100) := null;
  begin
    if p_phone is not null then
      for j in 1 .. length(p_phone)
      loop
        if substr(p_phone, j, 1) in
           ('+', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9') then
          l_ret := l_ret || substr(p_phone, j, 1);
        end if;
      end loop;
      l_ret := substr(l_ret, 1, 13);
    end if;
    return l_ret;
  end;

  function check_pcode(p_pcode varchar2) return varchar2 is
    l_ret varchar2(100) := null;
  begin
    l_ret := substr(trim(p_pcode), 1, 10);
    if l_ret is not null then
      if length(l_ret) < 5 then
        l_ret := substr('0000' || l_ret, -5);
      end if;
    end if;
    return l_ret;
  end;
  -------------------------------------------------------------------------------
  -- found_client
  -- функция поиска клиента по ОКПО и паспортным данным
  --
  function found_client(p_okpo    varchar2,
                        p_paspser varchar2,
                        p_paspnum varchar2,
                        p_spd     number default 0) return number is
    l_rnk         number := null;
    l_count_okpo  number;
    l_count_passp number;
    l_date_off    date;
  begin

    if p_okpo is null or substr(p_okpo, 1, 5) = '99999' or
       substr(p_okpo, 1, 5) = '00000' or p_paspser is null or
       p_paspnum is null then

      l_rnk := null;

    else

      -- ищем клиентов с ОКПО
      select count(*)
        into l_count_okpo
        from customer c
       where c.okpo = p_okpo and
             (p_spd = 0 and nvl(trim(c.sed), '00') <> '91' or
             p_spd = 1 and nvl(trim(c.sed), '00') = '91');

      -- ищем клиентов с паспортными данными
      select count(*)
        into l_count_passp
        from person p, customer c
       where p.ser = p_paspser and p.numdoc = p_paspnum and p.rnk = c.rnk and
             (p_spd = 0 and nvl(trim(c.sed), '00') <> '91' or
             p_spd = 1 and nvl(trim(c.sed), '00') = '91');

      -- есть клиенты с ОКПО и паспортными данными
      if l_count_okpo > 0 and l_count_passp > 0 then

        -- в банкке зарегистрирован один клиент с такими данными
        if l_count_okpo = 1 or l_count_passp = 1 then

          -- в customer и person это должен быть один клиент
          begin

            select c.rnk, c.date_off
              into l_rnk, l_date_off
              from customer c, person p
             where c.okpo = p_okpo and p.ser = p_paspser and
                   p.numdoc = p_paspnum and c.rnk = p.rnk and
                   (p_spd = 0 and nvl(trim(c.sed), '00') <> '91' or
                   p_spd = 1 and nvl(trim(c.sed), '00') = '91');

            -- если клиент закрыт, реанимируем его
            if l_date_off is not null then
              update customer set date_off = null where rnk = l_rnk;
            end if;

          exception
            when no_data_found then
              null;
          end;

          -- нашли нескольких клиентов с таким ОКПО
        elsif l_count_okpo > 1 then

          -- ищем среди открытых клиентов
          select max(c.rnk)
            into l_rnk
            from customer c, person p
           where c.okpo = p_okpo and p.ser = p_paspser and
                 p.numdoc = p_paspnum and c.rnk = p.rnk and
                 c.date_off is null and
                 (p_spd = 0 and nvl(trim(c.sed), '00') <> '91' or
                 p_spd = 1 and nvl(trim(c.sed), '00') = '91');

          -- среди открытых клиентов не нашли, ищем среди закрытых
          if l_rnk is null then

            select max(c.rnk)
              into l_rnk
              from customer c, person p
             where c.okpo = p_okpo and p.ser = p_paspser and
                   p.numdoc = p_paspnum and c.rnk = p.rnk and
                   c.date_off is not null and
                   (p_spd = 0 and nvl(trim(c.sed), '00') <> '91' or
                   p_spd = 1 and nvl(trim(c.sed), '00') = '91');

            -- реанимируем клиента
            if l_rnk is not null then
              update customer set date_off = null where rnk = l_rnk;
            end if;
          end if;
        end if;
      end if;
    end if;

    return l_rnk;

  end;

  function parse_file(p_id         in number,
                       p_file_data  in clob,
                       p_file_type  in number) return t_batch_list is
    l_parser     dbms_xmlparser.parser;
    l_doc        dbms_xmldom.domdocument;
    l_rows       dbms_xmldom.domnodelist;
    l_row        dbms_xmldom.domnode;
    l_batch_list t_batch_list;
  begin

    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, p_file_data);
    l_doc := dbms_xmlparser.getdocument(l_parser);

    l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'ROW');
    for i in 0 .. dbms_xmldom.getlength(l_rows) - 1
    loop
      l_row := dbms_xmldom.item(l_rows, i);
      l_batch_list(i).id  := p_id;
      l_batch_list(i).idn := i + 1;
      if p_file_type = esk_file then
        l_batch_list(i).okpo := substr(dbms_xslprocessor.valueof(l_row, 'IPN/text()'),1,14);
      else
        l_batch_list(i).okpo := substr(dbms_xslprocessor.valueof(l_row, 'OKPO/text()'),1,14);
      end if;
      l_batch_list(i).first_name := upper(substr(dbms_xslprocessor.valueof(l_row, 'FIRST_NAME/text()'),1,70));
      l_batch_list(i).last_name := upper(substr(dbms_xslprocessor.valueof(l_row, 'LAST_NAME/text()'),1,70));
      l_batch_list(i).middle_name := upper(substr(dbms_xslprocessor.valueof(l_row, 'MIDDLE_NAME/text()'),1,70));
      l_batch_list(i).type_doc := dbms_xslprocessor.valueof(l_row, 'TYPE_DOC/text()');
      l_batch_list(i).paspseries := substr(dbms_xslprocessor.valueof(l_row, 'PASPSERIES/text()'),1,16);
      l_batch_list(i).paspnum := substr(dbms_xslprocessor.valueof(l_row, 'PASPNUM/text()'),1,16);
      l_batch_list(i).paspissuer := substr(dbms_xslprocessor.valueof(l_row, 'PASPISSUER/text()'),1,128);
      l_batch_list(i).paspdate :=to_date(dbms_xslprocessor.valueof(l_row, 'PASPDATE/text()'), 'dd.mm.yyyy');
      l_batch_list(i).bday := to_date(dbms_xslprocessor.valueof(l_row, 'BDAY/text()'), 'dd.mm.yyyy');
      l_batch_list(i).country :=substr(dbms_xslprocessor.valueof(l_row, 'COUNTRY/text()'),1,3);
      l_batch_list(i).resident :=substr(dbms_xslprocessor.valueof(l_row, 'RESIDENT/text()'),1,1);
      l_batch_list(i).gender :=substr(dbms_xslprocessor.valueof(l_row, 'GENDER/text()'),1,1);
      l_batch_list(i).phone_home :=  check_phone(dbms_xslprocessor.valueof(l_row, 'PHONE_HOME/text()'));
      l_batch_list(i).phone_mob := check_phone(dbms_xslprocessor.valueof(l_row, 'PHONE_MOB/text()'));
      l_batch_list(i).email :=substr(dbms_xslprocessor.valueof(l_row, 'EMAIL/text()'),1,30);
      l_batch_list(i).eng_first_name :=substr(dbms_xslprocessor.valueof(l_row, 'ENG_FIRST_NAME/text()'),1,30);
      l_batch_list(i).eng_last_name :=substr(dbms_xslprocessor.valueof(l_row, 'ENG_LAST_NAME/text()'),1,30);
      l_batch_list(i).mname :=substr(dbms_xslprocessor.valueof(l_row, 'MNAME/text()'),1,20);
      if p_file_type = esk_file then
        l_batch_list(i).addr1_cityname :=substr(dbms_xslprocessor.valueof(l_row, 'ADDR_CITYNAME/text()'),1,100);
        l_batch_list(i).addr1_pcode :=check_pcode(dbms_xslprocessor.valueof(l_row, 'ADDR_PCODE/text()'));
        l_batch_list(i).addr1_domain :=substr(dbms_xslprocessor.valueof(l_row, 'ADDR_DOMAIN/text()'),1,48);
        l_batch_list(i).addr1_region :=substr(dbms_xslprocessor.valueof(l_row, 'ADDR_REGION/text()'),1,48);
        l_batch_list(i).addr1_street :=substr(dbms_xslprocessor.valueof(l_row, 'ADDR_STREET/text()'),1,100);
        l_batch_list(i).addr1_streettype :=substr(dbms_xslprocessor.valueof(l_row, 'ADDR_STREETTYPE/text()'),1,10);
        l_batch_list(i).addr1_streetname :=substr(dbms_xslprocessor.valueof(l_row, 'ADDR_STREETNAME/text()'),1,100);
        l_batch_list(i).addr1_bud :=substr(dbms_xslprocessor.valueof(l_row, 'ADDR_BUD/text()'),1,50);
      else
        l_batch_list(i).addr1_cityname :=substr(dbms_xslprocessor.valueof(l_row, 'ADDR1_CITYNAME/text()'),1,100);
        l_batch_list(i).addr1_pcode :=check_pcode(dbms_xslprocessor.valueof(l_row, 'ADDR1_PCODE/text()'));
        l_batch_list(i).addr1_domain :=substr(dbms_xslprocessor.valueof(l_row, 'ADDR1_DOMAIN/text()'),1,48);
        l_batch_list(i).addr1_region :=substr(dbms_xslprocessor.valueof(l_row, 'ADDR1_REGION/text()'),1,48);
        l_batch_list(i).addr1_street :=substr(dbms_xslprocessor.valueof(l_row, 'ADDR1_STREET/text()'),1,100);
        l_batch_list(i).addr1_streettype :=substr(dbms_xslprocessor.valueof(l_row, 'ADDR1_STREETTYPE/text()'),1,10);
        l_batch_list(i).addr1_streetname :=substr(dbms_xslprocessor.valueof(l_row, 'ADDR1_STREETNAME/text()'),1,100);
        l_batch_list(i).addr1_bud :=substr(dbms_xslprocessor.valueof(l_row, 'ADDR1_BUD/text()'),1,50);
      end if;
      if l_batch_list(i).addr1_bud is not null then
        l_batch_list(i).addr1_street := l_batch_list(i).addr1_street || ' ' || l_batch_list(i).addr1_bud;
      end if;
      l_batch_list(i).region_id1 :=dbms_xslprocessor.valueof(l_row, 'REGION_ID1/text()');
      l_batch_list(i).area_id1 :=dbms_xslprocessor.valueof(l_row, 'AREA_ID1/text()');
      l_batch_list(i).settlement_id1 :=dbms_xslprocessor.valueof(l_row, 'SETTLEMENT_ID1/text()');
      l_batch_list(i).street_id1 :=dbms_xslprocessor.valueof(l_row, 'STREET_ID1/text()');
      l_batch_list(i).house_id1 :=dbms_xslprocessor.valueof(l_row, 'HOUSE_ID1/text()');
      l_batch_list(i).addr2_cityname :=substr(dbms_xslprocessor.valueof(l_row, 'ADDR2_CITYNAME/text()'),1,100);
      l_batch_list(i).addr2_pcode :=check_pcode(dbms_xslprocessor.valueof(l_row, 'ADDR2_PCODE/text()'));
      l_batch_list(i).addr2_domain :=substr(dbms_xslprocessor.valueof(l_row, 'ADDR2_DOMAIN/text()'),1,48);
      l_batch_list(i).addr2_region :=substr(dbms_xslprocessor.valueof(l_row, 'ADDR2_REGION/text()'),1,48);
      l_batch_list(i).addr2_street :=substr(dbms_xslprocessor.valueof(l_row, 'ADDR2_STREET/text()'),1,100);
      l_batch_list(i).addr2_streettype :=substr(dbms_xslprocessor.valueof(l_row, 'ADDR2_STREETTYPE/text()'),1,10);
      l_batch_list(i).addr2_streetname :=substr(dbms_xslprocessor.valueof(l_row, 'ADDR2_STREETNAME/text()'),1,100);
      l_batch_list(i).addr2_bud :=substr(dbms_xslprocessor.valueof(l_row, 'ADDR2_BUD/text()'),1,50);
      if l_batch_list(i).addr2_bud is not null then
        l_batch_list(i).addr2_street := l_batch_list(i).addr2_street || ' ' || l_batch_list(i).addr2_bud;
      end if;
      l_batch_list(i).region_id2 :=dbms_xslprocessor.valueof(l_row, 'REGION_ID2/text()');
      l_batch_list(i).area_id2 :=dbms_xslprocessor.valueof(l_row, 'AREA_ID2/text()');
      l_batch_list(i).settlement_id2 :=dbms_xslprocessor.valueof(l_row, 'SETTLEMENT_ID2/text()');
      l_batch_list(i).street_id2 :=dbms_xslprocessor.valueof(l_row, 'STREET_ID2/text()');
      l_batch_list(i).house_id2 :=dbms_xslprocessor.valueof(l_row, 'HOUSE_ID2/text()');
      l_batch_list(i).work :=substr(dbms_xslprocessor.valueof(l_row, 'WORK/text()'),1,254);
      l_batch_list(i).office :=substr(dbms_xslprocessor.valueof(l_row, 'OFFICE/text()'),1,32);
      l_batch_list(i).date_w :=to_date(dbms_xslprocessor.valueof(l_row, 'DATE_W/text()'),'dd.mm.yyyy');
      l_batch_list(i).okpo_w :=substr(dbms_xslprocessor.valueof(l_row, 'OKPO_W/text()'),1,14);
      l_batch_list(i).pers_cat :=substr(dbms_xslprocessor.valueof(l_row, 'PERS_CAT/text()'),1,2);
      l_batch_list(i).aver_sum :=substr(dbms_xslprocessor.valueof(l_row, 'AVER_SUM/text()'),1,12);
      l_batch_list(i).tabn :=substr(dbms_xslprocessor.valueof(l_row, 'TABN/text()'),1,32);
      l_batch_list(i).acc_instant :=substr(dbms_xslprocessor.valueof(l_row, 'ACC_INSTANT/text()'),1,22);
      if p_file_type = kk_file then
        l_batch_list(i).kk_secret_word :=substr(dbms_xslprocessor.valueof(l_row, 'SECRET_WORD/text()'),1,32);
        l_batch_list(i).kk_regtype :=dbms_xslprocessor.valueof(l_row, 'REG_CLIENT_TYPE/text()');
        l_batch_list(i).kk_cityareaid :=dbms_xslprocessor.valueof(l_row, 'ADDR3_CITYREGION/text()');
        l_batch_list(i).kk_streettypeid :=dbms_xslprocessor.valueof(l_row, 'ADDR3_STREETTYPE/text()');
        l_batch_list(i).kk_streetname :=substr(dbms_xslprocessor.valueof(l_row, 'ADDR3_STREETNAME/text()'),1,64);
        l_batch_list(i).kk_apartment :=substr(dbms_xslprocessor.valueof(l_row, 'ADDR3_BUD/text()'),1,32);
        l_batch_list(i).kk_postcode :=check_pcode(dbms_xslprocessor.valueof(l_row, 'ADDR3_PCODE/text()'));
      end if;
      l_batch_list(i).max_term :=dbms_xslprocessor.valueof(l_row, 'MAX_TERM/text()');
      l_batch_list(i).pasp_end_date :=to_date(dbms_xslprocessor.valueof(l_row, 'PASP_END_DATE/text()'),'dd.mm.yyyy');
      l_batch_list(i).pasp_eddrid_id :=substr(dbms_xslprocessor.valueof(l_row, 'PASP_EDDRID_ID/text()'),1,14);
      l_batch_list(i).kf := sys_context('bars_context','user_mfo');
    end loop;
    return l_batch_list;
  end;

      -- обрабатывает XML with BASE64
    PROCEDURE parse_file(p_id           IN     NUMBER
                        ,p_file_data    IN     CLOB
                        ,p_file_type    IN     NUMBER
                        ,p_batch_list      OUT t_batch_list
                        ,p_photo_list      OUT t_photo_list
                        ,p_batch_header    OUT t_batch_header
                        )
    IS
       -- коллекция данныйх
       l_batch_list   t_batch_list;
       -- коллекция фото
       l_photo_list   t_photo_list;

       l_batch_header t_batch_header;
    BEGIN
       IF p_file_data IS NOT NULL THEN
         -- парсинг хедера хмл, наполнение коллекции l_batch_header, для дальнейго сохранения в таблице OW_BATCH_FILES
         SELECT xt.branch
               ,xt.isp
               ,xt.projectid
               ,xt.cardcode
           into l_batch_header(1).branch
               ,l_batch_header(1).isp
               ,l_batch_header(1).PROECT_ID
               ,l_batch_header(1).CARD_CODE
           FROM XMLTABLE('/ROWSET/HEADER'
                         PASSING (SELECT xmltype(p_file_data) z
                                    FROM dual)
                         COLUMNS branch VARCHAR2(30) PATH 'BRANCH'
                                ,isp NUMBER(22) PATH 'ISP'
                                ,projectid NUMBER(22) PATH 'PROJECTID'
                                ,cardcode VARCHAR2(32) PATH 'CARDCODE') xt;

          -- парсинг входящего клоба в формате хмл, для наполнения l_batch_list и l_photo_list
          FOR rec IN (          SELECT ROWNUM
                                      ,xt.okpo
                                      ,xt.last_name
                                      ,xt.first_name
                                      ,xt.middle_name
                                      ,xt.type_doc
                                      ,xt.paspseries
                                      ,xt.paspnum
                                      ,xt.paspissuer
                                      ,xt.paspdate
                                      ,xt.bday
                                      ,xt.country
                                      ,xt.resident
                                      ,xt.gender
                                      ,xt.phone_home
                                      ,xt.phone_mob
                                      ,xt.email
                                      ,xt.eng_first_name
                                      ,xt.eng_last_name
                                      ,xt.mname
                                      ,xt.addr1_cityname
                                      ,xt.addr1_pcode
                                      ,xt.addr1_domain
                                      ,xt.addr1_region
                                      ,xt.addr1_street
                                      ,xt.addr1_streettype
                                      ,xt.addr1_streetname
                                      ,xt.addr1_bud
                                      ,xt.addr2_cityname
                                      ,xt.addr2_pcode
                                      ,xt.addr2_domain
                                      ,xt.addr2_region
                                      ,xt.addr2_street
                                      ,xt.addr2_streettype
                                      ,xt.addr2_streetname
                                      ,xt.addr2_bud
                                      ,xt.work
                                      ,xt.office
                                      ,xt.date_w
                                      ,xt.okpo_w
                                      ,xt.pers_cat
                                      ,xt.aver_sum
                                      ,xt.tabn
                                      ,xt.acc_instant
                                      ,xt.kk_secret_word
                                      ,xt.kk_regtype
                                      ,xt.kk_cityareaid
                                      ,xt.kk_streettypeid
                                      ,xt.kk_streetname
                                      ,xt.kk_apartment
                                      ,xt.kk_postcode
                                      ,xt.max_term
                                      ,xt.pasp_end_date
                                      ,xt.pasp_eddrid_id
                                      -- преобразование бейс64 в фото
                                      ,barstrans.file_utl.decode_base64(xt.photo_data) AS photo_jpg
                                  FROM XMLTABLE('/ROWSET/ROW'
                                                PASSING                                                                                          --xmltype
                                                       (SELECT xmltype(p_file_data) z
                                                          FROM DUAL t)
                                                COLUMNS okpo VARCHAR2(14) PATH 'OKPO'
                                                       ,last_name VARCHAR2(70) PATH 'LAST_NAME'
                                                       ,first_name VARCHAR2(70) PATH 'FIRST_NAME'
                                                       ,middle_name VARCHAR2(70) PATH 'MIDDLE_NAME'
                                                       ,type_doc NUMBER(22) PATH 'TYPE_DOC'
                                                       ,paspseries VARCHAR2(16) PATH 'PASPSERIES'
                                                       ,paspnum VARCHAR2(16) PATH 'PASPNUM'
                                                       ,paspissuer VARCHAR2(128) PATH 'PASPISSUER'
                                                       ,paspdate VARCHAR2(11) PATH 'PASPDATE'
                                                       ,bday VARCHAR2(11) PATH 'BDAY'
                                                       ,country VARCHAR2(3) PATH 'COUNTRY'
                                                       ,resident VARCHAR2(1) PATH 'RESIDENT'
                                                       ,gender VARCHAR2(1) PATH 'GENDER'
                                                       ,phone_home VARCHAR2(13) PATH 'PHONE_HOME'
                                                       ,phone_mob VARCHAR2(13) PATH 'PHONE_MOB'
                                                       ,email VARCHAR2(30) PATH 'EMAIL'
                                                       ,eng_first_name VARCHAR2(30) PATH 'ENG_FIRST_NAME'
                                                       ,eng_last_name VARCHAR2(30) PATH 'ENG_LAST_NAME'
                                                       ,mname VARCHAR2(20) PATH 'MNAME'
                                                       ,addr1_cityname VARCHAR2(100) PATH 'ADDR1_CITYNAME'
                                                       ,addr1_pcode VARCHAR2(10) PATH 'ADDR1_PCODE'
                                                       ,addr1_domain VARCHAR2(48) PATH 'ADDR1_DOMAIN'
                                                       ,addr1_region VARCHAR2(48) PATH 'ADDR1_REGION'
                                                       ,addr1_street VARCHAR2(100) PATH 'ADDR1_STREET'
                                                       ,addr1_streettype NUMBER(10) PATH 'ADDR1_STREETTYPE'
                                                       ,addr1_streetname VARCHAR2(100) PATH 'ADDR1_STREETNAME'
                                                       ,addr1_bud VARCHAR2(50) PATH 'ADDR1_BUD'
                                                       ,addr2_cityname VARCHAR2(100) PATH 'ADDR2_CITYNAME'
                                                       ,addr2_pcode VARCHAR2(10) PATH 'ADDR2_PCODE'
                                                       ,addr2_domain VARCHAR2(48) PATH 'ADDR2_DOMAIN'
                                                       ,addr2_region VARCHAR2(48) PATH 'ADDR2_REGION'
                                                       ,addr2_street VARCHAR2(100) PATH 'ADDR2_STREET'
                                                       ,addr2_streettype NUMBER(10) PATH 'ADDR2_STREETTYPE'
                                                       ,addr2_streetname VARCHAR2(100) PATH 'ADDR2_STREETNAME'
                                                       ,addr2_bud VARCHAR2(50) PATH 'ADDR2_BUD'
                                                       ,WORK VARCHAR2(254) PATH 'WORK'
                                                       ,office VARCHAR2(32) PATH 'OFFICE'
                                                       ,date_w DATE PATH 'DATE_W'
                                                       ,okpo_w VARCHAR2(14) PATH 'OKPO_W'
                                                       ,pers_cat VARCHAR2(2) PATH 'PERS_CAT'
                                                       ,aver_sum NUMBER(12) PATH 'AVER_SUM'
                                                       ,tabn VARCHAR2(32) PATH 'TABN'
                                                       ,acc_instant NUMBER(22) PATH 'ACC_INSTANT'
                                                       ,kk_secret_word VARCHAR2(32) PATH 'KK_SECRET_WORD'
                                                       ,kk_regtype NUMBER(1) PATH 'KK_REGTYPE'
                                                       ,kk_cityareaid NUMBER(10) PATH 'KK_CITYAREAID'
                                                       ,kk_streettypeid NUMBER(10) PATH 'KK_STREETTYPEID'
                                                       ,kk_streetname VARCHAR2(64) PATH 'KK_STREETNAME'
                                                       ,kk_apartment VARCHAR2(32) PATH 'KK_APARTMENT'
                                                       ,kk_postcode VARCHAR2(5) PATH 'KK_POSTCODE'
                                                       ,max_term NUMBER PATH 'MAX_TERM'
                                                       ,pasp_end_date DATE PATH 'PASP_END_DATE'
                                                       ,pasp_eddrid_id VARCHAR2(14) PATH 'PASP_EDDRID_ID'
                                                       ,photo_data CLOB PATH 'PHOTO_DATA') xt)
          LOOP
             -- // наполнение коллекции данных
             l_batch_list(rec.ROWNUM).id                := p_id;
             l_batch_list(rec.ROWNUM).idn               := rec.ROWNUM;
             l_batch_list(rec.ROWNUM).okpo              := SUBSTR(rec.okpo, 1, 14);
             l_batch_list(rec.ROWNUM).first_name        := SUBSTR(UPPER(rec.first_name), 1, 70);
             l_batch_list(rec.ROWNUM).last_name         := SUBSTR(UPPER(rec.last_name), 1, 70);
             l_batch_list(rec.ROWNUM).middle_name       := UPPER(SUBSTR(rec.middle_name, 1, 70));
             l_batch_list(rec.ROWNUM).type_doc          := rec.type_doc;
             l_batch_list(rec.ROWNUM).paspseries        := SUBSTR(rec.paspseries, 1, 16);
             l_batch_list(rec.ROWNUM).paspnum           := SUBSTR(rec.paspnum, 1, 16);
             l_batch_list(rec.ROWNUM).paspissuer        := SUBSTR(rec.paspissuer, 1, 128);
             l_batch_list(rec.ROWNUM).paspdate          := TO_DATE(rec.paspdate, 'dd.mm.yyyy');
             l_batch_list(rec.ROWNUM).bday              := TO_DATE(rec.bday, 'dd.mm.yyyy');
             l_batch_list(rec.ROWNUM).country           := SUBSTR(rec.country, 1, 3);
             l_batch_list(rec.ROWNUM).resident          := SUBSTR(rec.resident, 1, 1);
             l_batch_list(rec.ROWNUM).gender            := SUBSTR(rec.gender, 1, 1);
             l_batch_list(rec.ROWNUM).phone_home        := check_phone(rec.phone_home);
             l_batch_list(rec.ROWNUM).phone_mob         := check_phone(rec.phone_mob);
             l_batch_list(rec.ROWNUM).email             := SUBSTR(rec.email, 1, 30);
             l_batch_list(rec.ROWNUM).eng_first_name    := SUBSTR(rec.eng_first_name, 1, 30);
             l_batch_list(rec.ROWNUM).eng_last_name     := SUBSTR(rec.eng_last_name, 1, 30);
             l_batch_list(rec.ROWNUM).mname             := SUBSTR(rec.mname, 1, 20);
             l_batch_list(rec.ROWNUM).addr1_cityname    := SUBSTR(rec.addr1_cityname, 1, 100);
             l_batch_list(rec.ROWNUM).addr1_pcode       := check_pcode(rec.addr1_pcode);
             l_batch_list(rec.ROWNUM).addr1_domain      := SUBSTR(rec.addr1_domain, 1, 48);
             l_batch_list(rec.ROWNUM).addr1_region      := SUBSTR(rec.addr1_region, 1, 48);
             l_batch_list(rec.ROWNUM).addr1_street      := SUBSTR(rec.addr1_street, 1, 100);
             l_batch_list(rec.ROWNUM).addr1_streettype  := SUBSTR(rec.addr1_streettype, 1, 10);
             l_batch_list(rec.ROWNUM).addr1_streetname  := SUBSTR(rec.addr1_streetname, 1, 100);
             l_batch_list(rec.ROWNUM).addr1_bud         := SUBSTR(rec.addr1_bud, 1, 50);

             IF l_batch_list(rec.ROWNUM).addr1_bud IS NOT NULL THEN
                l_batch_list(rec.ROWNUM).addr1_street  := l_batch_list(rec.ROWNUM).addr1_street || ' ' || l_batch_list(rec.ROWNUM).addr1_bud;
             END IF;

             l_batch_list(rec.ROWNUM).addr2_cityname    := SUBSTR(rec.addr2_cityname, 1, 100);
             l_batch_list(rec.ROWNUM).addr2_pcode       := check_pcode(rec.addr2_pcode);
             l_batch_list(rec.ROWNUM).addr2_domain      := SUBSTR(rec.addr2_domain, 1, 48);
             l_batch_list(rec.ROWNUM).addr2_region      := SUBSTR(rec.addr2_region, 1, 48);
             l_batch_list(rec.ROWNUM).addr2_street      := SUBSTR(rec.addr2_street, 1, 100);
             l_batch_list(rec.ROWNUM).addr2_streettype  := SUBSTR(rec.addr2_streettype, 1, 10);
             l_batch_list(rec.ROWNUM).addr2_streetname  := SUBSTR(rec.addr2_streetname, 1, 100);
             l_batch_list(rec.ROWNUM).addr2_bud         := SUBSTR(rec.addr1_bud, 1, 50);

             IF l_batch_list(rec.ROWNUM).addr2_bud IS NOT NULL THEN
                l_batch_list(rec.ROWNUM).addr2_street  := l_batch_list(rec.ROWNUM).addr2_street || ' ' || l_batch_list(rec.ROWNUM).addr2_bud;
             END IF;

             l_batch_list(rec.ROWNUM).work              := SUBSTR(rec.work, 1, 254);
             l_batch_list(rec.ROWNUM).office            := SUBSTR(rec.office, 1, 32);
             l_batch_list(rec.ROWNUM).date_w            := TO_DATE(rec.date_w, 'dd.mm.yyyy');
             l_batch_list(rec.ROWNUM).okpo_w            := SUBSTR(rec.okpo_w, 1, 14);
             l_batch_list(rec.ROWNUM).pers_cat          := SUBSTR(rec.pers_cat, 1, 2);
             l_batch_list(rec.ROWNUM).aver_sum          := SUBSTR(rec.aver_sum, 1, 12);
             l_batch_list(rec.ROWNUM).tabn              := SUBSTR(rec.tabn, 1, 32);
             l_batch_list(rec.ROWNUM).acc_instant       := SUBSTR(rec.acc_instant, 1, 22);

             l_batch_list(rec.ROWNUM).kk_secret_word    := SUBSTR(rec.kk_secret_word, 1, 32);
             l_batch_list(rec.ROWNUM).kk_regtype        := rec.kk_regtype;
             l_batch_list(rec.ROWNUM).kk_cityareaid     := rec.kk_cityareaid;
             l_batch_list(rec.ROWNUM).kk_streettypeid   := rec.kk_streettypeid;
             l_batch_list(rec.ROWNUM).kk_streetname     := rec.kk_streetname;
             l_batch_list(rec.ROWNUM).kk_apartment      := rec.kk_apartment;
             l_batch_list(rec.ROWNUM).kk_postcode       := rec.kk_postcode;

             l_batch_list(rec.ROWNUM).max_term          := rec.max_term;
             l_batch_list(rec.ROWNUM).pasp_end_date     := TO_DATE(rec.pasp_end_date, 'dd.mm.yyyy');
             l_batch_list(rec.ROWNUM).pasp_eddrid_id    := SUBSTR(rec.pasp_eddrid_id, 1, 14);
             l_batch_list(rec.ROWNUM).kf                := SYS_CONTEXT('bars_context', 'user_mfo');
             --\\ наполнение коллекции данных

             --// наполнение коллеции фото
             l_photo_list(rec.ROWNUM).id                := p_id;
             l_photo_list(rec.ROWNUM).idn               := rec.ROWNUM;
             -- конвертнуть до нужного размера
             l_photo_list(rec.ROWNUM).photo             := convert_photo_data(rec.photo_jpg);
             --\\ наполнение коллеции фото
          END LOOP;
       END IF;

       p_batch_list  := l_batch_list;
       p_photo_list  := l_photo_list;
       p_batch_header := l_batch_header;
    END parse_file;

  function check_file(p_batch_list in t_batch_list,
                      p_file_type  in number) return t_batch_list is
    l_batch_list t_batch_list := p_batch_list;
    l_msg        varchar2(254) := null;
    procedure append_msg(p_txt varchar2) is
    begin
      if l_msg is not null then
        l_msg := substr(l_msg || ';' || p_txt, 1, 254);
      else
        l_msg := substr(p_txt, 1, 254);
      end if;
    end;
  begin
    for i in l_batch_list.first .. l_batch_list.last
    loop
      l_batch_list(i).str_err := null;

      if p_file_type = esk_file then
        l_batch_list(i).country        := 804;
        l_batch_list(i).resident       := 1;
        l_batch_list(i).mname          := to_char(l_batch_list(i).paspdate, 'dd.mm.yyyy');
        --l_batch_list(i).phone_home     := null;
        --l_batch_list(i).phone_mob      := null;
        l_batch_list(i).email          := null;
      --  p_project.addr1_pcode    := null;
      --  p_project.addr2_pcode    := null;
        l_batch_list(i).addr2_domain   := null;
        l_batch_list(i).addr2_region   := null;
        l_batch_list(i).addr2_cityname := null;
        l_batch_list(i).addr2_street   := null;
        l_batch_list(i).work           := null;
        l_batch_list(i).office         := 'студент';
        l_batch_list(i).okpo_w         := null;
        l_batch_list(i).pers_cat       := null;
        l_batch_list(i).aver_sum       := null;
      end if;

      if l_batch_list(i).eng_first_name is null then
        l_batch_list(i).eng_first_name := substr(f_translate_kmu(l_batch_list(i).first_name),1,30);
      end if;
      if l_batch_list(i).eng_last_name is null then
        l_batch_list(i).eng_last_name := substr(f_translate_kmu(l_batch_list(i).last_name),1,30);
      end if;

      if l_batch_list(i).paspseries is not null then
        l_batch_list(i).paspseries := kl.recode_passport_serial(l_batch_list(i).paspseries);
      end if;

      if l_batch_list(i).okpo is null
      or l_batch_list(i).first_name is null
      or l_batch_list(i).last_name is null
      or l_batch_list(i).type_doc is null
      or l_batch_list(i).paspseries is null
      or l_batch_list(i).paspnum is null
      or l_batch_list(i).paspissuer is null
      or l_batch_list(i).paspdate is null
      or l_batch_list(i).bday is null
      or l_batch_list(i).country is null
      or l_batch_list(i).resident is null
      or l_batch_list(i).gender is null
      or l_batch_list(i).mname is null
      --or l_batch_list(i).addr1_cityname is null
      or l_batch_list(i).addr1_street is null
      or l_batch_list(i).okpo_w is null then

        append_msg('Не заповнено обов''язкові поля');
      end if;

      if length(trim(l_batch_list(i).eng_first_name||' '||l_batch_list(i).eng_last_name)) > 24 then
        append_msg('Кількість знаків Прізвище та І''мя для ембосування перевищує 24 символи');
      end if;

      if not regexp_like(l_batch_list(i).eng_first_name, g_w4_eng_mask) then
        append_msg('Ім''я що ембосується - недопустимі символи');
      end if;
      if not regexp_like(l_batch_list(i).eng_last_name, g_w4_eng_mask) then
        append_msg('Прізвище що ембосується - недопустимі символи');
      end if;
      if months_between(bankdate,l_batch_list(i).bday)/12 < 14 then
        append_msg('Клієнту менше 14 років');
      end if;
      if l_batch_list(i).addr1_pcode is not null and length(l_batch_list(i).addr1_pcode) <> 5 then
        append_msg('Довжина поля Індекс повинна бути 5 знаків');
      end if;
      if l_batch_list(i).addr2_pcode is not null and length(l_batch_list(i).addr2_pcode) <> 5 then
        append_msg('Довжина поля Індекс повинна бути 5 знаків');
      end if;
      if l_batch_list(i).paspdate >= sysdate then
        append_msg('Дата видачі паспорту повинна бути менше поточної дати');
      end if;
      if l_batch_list(i).paspdate < l_batch_list(i).bday then
        append_msg('Дата видачі паспорту повинна бути більше дати народження');
      end if;
      if instr(l_batch_list(i).paspseries,' ') > 0 then
        append_msg('Серія паспорту містить пробіли');
      end if;
      if nvl(l_batch_list(i).type_doc,0) = 1 and
        (l_batch_list(i).paspseries <> upper(l_batch_list(i).paspseries) or length(l_batch_list(i).paspseries) <> 2) then
        append_msg('Невірно заповнено серію паспорту');
      end if;
      if nvl(l_batch_list(i).type_doc,0) = 1 and
        (not regexp_like(l_batch_list(i).paspnum, g_digit) or length(l_batch_list(i).paspnum) <> 6) then
        append_msg('Невірно заповнено номер паспорту');
      end if;
      if l_batch_list(i).email is not null and not regexp_like(upper(l_batch_list(i).email), g_w4_email_char) then
        append_msg('Невірний e-mail');
      end if;
      if l_batch_list(i).phone_home is not null then
        if length(l_batch_list(i).phone_home) <> 13 then
          append_msg('Довжина номеру телефону повинна дорівнювати 13 символів');
        elsif substr(l_batch_list(i).phone_home, 1, 3) <> '+38' then
          append_msg('Номер телефону повинен починатись з +38');
        elsif not regexp_like(substr(l_batch_list(i).phone_home, 2), g_digit) then
          append_msg('Нецифри в номері телефону');
        end if;
      end if;
      if l_batch_list(i).phone_mob is not null then
        if length(l_batch_list(i).phone_mob) <> 13 then
          append_msg('Довжина номеру телефону повинна дорівнювати 13 символів');
        elsif substr(l_batch_list(i).phone_mob, 1, 3) <> '+38' then
          append_msg('Номер телефону повинен починатись з +38');
        elsif not regexp_like(substr(l_batch_list(i).phone_mob, 2), g_digit) then
          append_msg('Нецифри в номері телефону');
        end if;
      end if;
      if not regexp_like(upper(l_batch_list(i).first_name), g_w4_fio_char) then
        append_msg('Ім''я повинно містити тільки українські/російські літери');
      end if;
      if not regexp_like(upper(l_batch_list(i).last_name), g_w4_fio_char) then
        append_msg('Прізвище повинно містити тільки українські/російські літери');
      end if;
      if l_batch_list(i).middle_name is not null and not regexp_like(upper(l_batch_list(i).middle_name), g_w4_fio_char) then
        append_msg('По-батькові повинно містити тільки українські/російські літери');
      end if;
      if p_file_type = kk_file then
        if l_batch_list(i).kk_secret_word is null
        or l_batch_list(i).kk_regtype is null
        or l_batch_list(i).kk_cityareaid is null
        or l_batch_list(i).kk_streettypeid is null
        or l_batch_list(i).kk_streetname is null
        or l_batch_list(i).kk_apartment is null
        or l_batch_list(i).kk_postcode is null then
          append_msg('Не заповнено обов''язкові поля КК');
        end if;
        if l_batch_list(i).kk_streetname is not null and not regexp_like(upper(l_batch_list(i).kk_streetname), g_all_char) then
          append_msg('Назва вулиці для КК повинна містити тільки українські/російські літери');
        end if;
      end if;
      l_batch_list(i).str_err := l_msg;
      if l_batch_list(i).str_err is null and
        l_batch_list(i).okpo is not null and
        l_batch_list(i).okpo <> '000000000' and
        l_batch_list(i).okpo <> '0000000000' then
        l_batch_list(i).rnk := found_client(l_batch_list(i).okpo, l_batch_list(i).paspseries, l_batch_list(i).paspnum);
      else
        l_batch_list(i).rnk := null;
      end if;
    end loop;
    return l_batch_list;
  end;

  procedure add_data(p_batch_list in t_batch_list,
                     p_photo_list in t_fileinflist,
                     p_file_type  in number) is
    l_photo_list t_photo_list;
    l_batch_list t_batch_list := p_batch_list;
  begin
    -- заповнимо масив фото
    for i in l_batch_list.first .. l_batch_list.last
    loop
      if p_photo_list.count > 0 then
        for k in p_photo_list.first .. p_photo_list.last
        loop
          if upper(p_photo_list(k).file_name) like '%' || l_batch_list(i).okpo || '%'
          or upper(p_photo_list(k).file_name) like '%' || upper(l_batch_list(i).paspseries)||l_batch_list(i).paspnum || '%'
          or upper(p_photo_list(k).file_name) like '%' || l_batch_list(i).okpo||'_' ||upper(l_batch_list(i).paspseries)||l_batch_list(i).paspnum ||'%' then
            l_photo_list(i).id := l_batch_list(i).id;
            l_photo_list(i).idn := l_batch_list(i).idn;
            l_photo_list(i).photo := p_photo_list(k).file_data;
            l_photo_list(i).name := p_photo_list(k).file_name;
			l_photo_list(i).kf := sys_context('bars_context','user_mfo');
            exit;
          end if;
          if p_file_type in (kk_file, mp_file) and k = p_photo_list.last then
            l_batch_list(i).str_err := 'Відсутнє фото';
          end if;
        end loop;
      else
        if p_file_type in (kk_file, mp_file) then
          l_batch_list(i).str_err := 'Відсутнє фото';
        end if;
      end if;

    end loop;

    forall x in indices of l_batch_list
      insert into ow_batch_open_data values l_batch_list(x);

    forall z in indices of l_photo_list
      insert into ow_batch_photo values l_photo_list(z);

  end;

  procedure processing_file(p_file_list  in t_fileinflist,
                            p_photo_list in t_fileinflist,
                            p_zip_fname  in varchar2,
                            p_file_type   in number,
                            p_fileid     out number) is
    l_id number;
    l_file_data clob;
    l_warning    integer;
    l_dest_offset integer := 1;
    l_src_offset integer := 1;
    l_blob_csid number := dbms_lob.default_csid;
    l_lang_context number := dbms_lob.default_lang_ctx;
    l_batch_list t_batch_list;
    l_n number;
    h varchar2(100) := 'ow_batch_opening.parse_file. ';
  begin
    bars_audit.info(h || 'Start. ZIP file name: ' || p_zip_fname);

    dbms_lob.createtemporary(l_file_data, false);
    if p_file_list.count > 0 then
      bars_audit.info(h || 'Processing.' || 'p_filename=>' || p_file_list(1).file_name);
      -- обробляєм тільки 1 файл з архіву
      insert into ow_batch_files (id, file_name, zipfile_name, file_date, file_type, state)
      values (bars_sqnc.get_nextval(p_sqnc => 'S_OW_BATCH_FILES'), p_file_list(1).file_name, p_zip_fname, sysdate, p_file_type, 0)
      returning id into l_id;
      commit;
      -- конвертуємо в clob для подальшої обробки
      dbms_lob.converttoclob(dest_lob     => l_file_data,
                             src_blob     => p_file_list(1).file_data,
                             amount       => dbms_lob.lobmaxsize,
                             dest_offset  => l_dest_offset,
                             src_offset   => l_src_offset,
                             blob_csid    => l_blob_csid,
                             lang_context => l_lang_context,
                             warning      => l_warning);
     -- парсимо файл
     l_batch_list := parse_file(l_id, l_file_data, p_file_type);
     set_state(l_id, 1);
     -- перевіряємо корекнтість данних
     l_batch_list := check_file(l_batch_list, p_file_type);
     set_state(l_id, 2);
     -- вставка данних в проміжну таблицю
     add_data(l_batch_list, p_photo_list, p_file_type);
     set_state(l_id, 3);

     l_n :=  l_batch_list.COUNT;
     update ow_batch_files t set t.file_n = l_n where t.id = l_id;
     p_fileid := l_id;
    end if;
  end;

  -- обработка блоб файла, в котором фото и информация содержатся в одном xml
  PROCEDURE processing_file(p_file_blob   IN     BLOB
                           ,p_zip_fname   IN     VARCHAR2
                           ,p_file_type   IN     NUMBER
                           ,p_external_file_id in VARCHAR2
                           ,p_fileid         OUT NUMBER
                           )
  IS
    l_id         NUMBER;
    l_file_data  CLOB;
    l_file_clob  CLOB;
    l_batch_list t_batch_list;
    l_photo_list t_photo_list;
    l_batch_header t_batch_header;
    l_n          NUMBER;
    h            VARCHAR2(100) := 'ow_batch_opening.parse_file. ';
  BEGIN
    bars_audit.info(h || 'Start. ZIP file name: ' || p_zip_fname);

    dbms_lob.createtemporary(l_file_data, FALSE);
    IF length(p_file_blob) > 0 THEN
      bars_audit.info(h || 'Processing.' || 'p_filename=>' || p_file_type);
     -- bc.go(300465);
      -- обробляєм тільки 1 файл з архіву
      INSERT INTO ow_batch_files
        (id
        ,file_name
        ,zipfile_name
        ,file_date
        ,file_type
        ,state
        ,external_file_id
        )
      VALUES
        (S_OW_BATCH_FILES.NEXTVAL -- bars_sqnc.get_nextval(p_sqnc => 'S_OW_BATCH_FILES'
        ,p_zip_fname
        ,p_zip_fname
        ,SYSDATE
        ,p_file_type
        ,0
        ,p_external_file_id)
      RETURNING id INTO l_id;
      COMMIT;

      -- преобразование из блоб в клоб
      l_file_clob := ow_batch_opening.blob_to_clob(p_file_blob);

      -- парсим файл. получаем коллекции данных и фото
      parse_file(p_id           => l_id
                ,p_file_data    => l_file_clob
                ,p_file_type    => 0
                ,p_batch_list   => l_batch_list
                ,p_photo_list   => l_photo_list
                ,p_batch_header => l_batch_header);
      set_state(l_id, 1);

      -- перевіряємо корекнтість данних
      l_batch_list := check_file(l_batch_list, p_file_type);
      set_state(l_id, 2);
      -- вставка данних в проміжні таблиці
          forall x in indices of l_batch_list
            insert into ow_batch_open_data values l_batch_list(x);

          forall z in indices of l_photo_list
            insert into ow_batch_photo values l_photo_list(z);
      set_state(l_id, 3);

      l_n := l_batch_list.count;

      UPDATE ow_batch_files t
         SET t.file_n = l_n
            ,t.branch = l_batch_header(1).branch
            ,t.isp    = l_batch_header(1).isp
            ,t.proect_id = l_batch_header(1).PROECT_ID
            ,t.card_code = l_batch_header(1).CARD_CODE
       WHERE t.id = l_id;

      p_fileid := l_id;
    END IF;
  END processing_file;

  function get_photo_data(p_id  number,
                          p_idn in number) return blob is
    l_blob blob;
  begin
    select t.photo
      into l_blob
      from ow_batch_photo t
     where t.id = p_id and t.idn = p_idn;
    return l_blob;
  exception
    when no_data_found then
      return empty_blob();
  end;

  procedure import_file(p_filename in varchar2,
                        p_filebody in blob,
                        p_filetype in number default 0,
                        p_fileid   out number) is
    l_fi_list      t_fileinflist := t_fileinflist();
    l_fi_list_xml  t_fileinflist := t_fileinflist();
    l_fi_list_jpg  t_fileinflist := t_fileinflist();

    h varchar2(100) := 'ow_batch_opening.import_file. ';
  begin

    bars_audit.info(h || 'Start.'|| 'p_filename=>' || p_filename);

    --Масив файлів архіу
    l_fi_list := get_files_list(p_filebody);

    --Масив файлів на відкриття карток
    l_fi_list_xml := get_files_from_ext(l_fi_list, 'xml');

    --Масив фотографій клієнтів
    l_fi_list_jpg := get_files_from_ext(l_fi_list, 'jpg');

    --Ковертимо фотографії до заданого розміру
    l_fi_list_jpg := convert_photo_data(l_fi_list_jpg);

    -- Обробка файлу
    processing_file(l_fi_list_xml, l_fi_list_jpg, p_filename, p_filetype, p_fileid);

    bars_audit.info(h || 'p_filename=>' || p_filename);
    bars_audit.info(h || 'Finish.');
  exception when others then
    bars_audit.error(sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
    bars_error.raise_error('DOC',
                                 47,
                                 'Увага !!! '||sqlerrm || chr(10) || dbms_utility.format_error_backtrace());

  end;

  -- импорт ахфива gzip (gz), который содержит xlm с фото формата BASE64
  PROCEDURE import_file_gz(p_filename         IN VARCHAR2
                          ,p_filebody         IN BLOB
                          ,p_external_file_id IN VARCHAR2
                          ,p_filetype         IN NUMBER
                          ,p_fileid           OUT NUMBER) IS
    l_uncompressed_blob BLOB;
    h                   VARCHAR2(100) := 'ow_batch_opening.import_file. ';
  BEGIN
    --bars_audit.info(h || 'Start.' || 'p_filename=>' || p_filename);

    l_uncompressed_blob := to_blob('0');

    -- Разархивировать gzip архив в переменную l_uncompressed_blob
    utl_compress.lz_uncompress(src => p_filebody
                              ,dst => l_uncompressed_blob);

      -- Обробка файлу
      processing_file(p_file_blob        => l_uncompressed_blob
                     ,p_zip_fname        => p_filename
                     ,p_file_type        => p_filetype
                     ,p_external_file_id => p_external_file_id
                     ,p_fileid           => p_fileid);

    bars_audit.info(h || 'p_filename=>' || p_filename);
    bars_audit.info(h || 'Finish.');

  END import_file_gz;

  procedure form_ticket (
    p_fileid     in number,
    p_ticketname out varchar2,
    p_ticketdata out clob
     )
  is
    l_count     number  := 0;
    l_data      xmltype := null;
    l_xml_tmp   xmltype := null;
    l_clob_data clob;
    h varchar2(100) := 'ow_batch_opening.form_ticket. ';
  begin

    bars_audit.info(h || 'Start.');

    begin
       select 'R_' || file_name into p_ticketname from ow_batch_files where id = p_fileid;
    exception when no_data_found then
       bars_audit.info(h || 'File not found p_fileid=>' || to_char(p_fileid));
       bars_error.raise_nerror(g_modcode, 'FILE_NOT_FOUND');
    end;

    for v in (SELECT bf.external_file_id as ext_id
                    ,a.nls
                    ,ow_batch_opening.split_key(p.rnk) as rnk
                    ,(case when p.str_err is null then 1 else 0 end) as code
                    ,p.str_err
                FROM ow_batch_open_data p
                    ,ow_batch_files     bf
                    ,w4_acc             w
                    ,accounts           a
               WHERE p.id = p_fileid
                 AND p.nd = w.nd(+)
                 AND w.acc_pk = a.acc(+)
                 and p.id     = bf.id )
    loop

       l_count := l_count + 1;

       SELECT xmlelement("ROW"
                          ,xmlelement("EXT_ID"
                                     ,v.ext_id)
                          ,xmlelement("NLS"
                                     ,v.nls)
                          ,xmlelement("RNK"
                                     ,v.rnk)
                          ,xmlelement("CODE"
                                     ,v.code)
                          ,xmlelement("MSG"
                                     ,v.str_err))
       into l_xml_tmp
       from dual;

       select XmlConcat(l_data, l_xml_tmp) into l_data from dual;

    end loop;

    if l_count > 0 then

       select XmlElement("ROWSET", l_data) into l_data from dual;

       dbms_lob.createtemporary(l_clob_data,FALSE);
       dbms_lob.append(l_clob_data, '<?xml version="1.0" encoding="windows-1251"?>');
       dbms_lob.append(l_clob_data, l_data.getClobVal());
       p_ticketdata := l_clob_data;
    else

       p_ticketname := null;

    end if;

    bars_audit.info(h || 'p_ticketname=>' || p_ticketname);
    bars_audit.info(h || 'Finish.');

  end;
  -------------------------------------------------------------------------------
  -- check_opencard
  -- функция проверки перед открытием карточки
  --
  function check_opencard (
    p_rnk       in number,
    p_cardcode  in varchar2 ) return varchar2
  is
    l_msg varchar2(254) := null;
    i     number;
  begin

    -- при відкритті другого рахунку для одного і того ж клієнта
    --   в рамках одного продукту, генерувати повідомлення типу
    --   „Клієнту вже відкрито рахунок. Відкрити ще один?”
    select count(*) into i
      from w4_acc o, accounts a, w4_card c
     where o.acc_pk = a.acc and a.rnk = p_rnk
       and o.card_code = c.code
       and c.product_code = (select product_code from w4_card where code = p_cardcode);

    if i > 0 then
       l_msg := 'Клієнту вже відкрито рахунок такого продукту.';
    end if;

    return l_msg;

  end;
  -------------------------------------------------------------------------------
  -- check_salary_opencard
  -- процедура проверки перед открытием карточки по З/П файлу
  --
  procedure check_batch_opencard (
    p_id       number,
    p_cardcode varchar2 )
  is
    l_flagopen number;
    l_msg      ow_batch_open_data.str_err%type;
  begin

    for z in ( select idn, rnk, str_err, flag_open
                 from ow_batch_open_data
                where id = p_id )
    loop
       -- открываем счет
       l_flagopen := 1;
       l_msg      := null;

       -- если ошибка в данных, счет не открываем
       if z.rnk is null and z.str_err is not null then
          l_flagopen := 0;
       elsif z.rnk is not null then
          -- проверка для клиента
          l_msg := check_opencard(z.rnk, p_cardcode);

          -- если какое-то собщение, надо спросить, открывать счет или нет
          if l_msg is not null then
             l_flagopen := 2;
          end if;
       end if;

       update ow_batch_open_data
          set flag_open = l_flagopen,
              str_err = decode(z.flag_open,2,l_msg,nvl(str_err, l_msg))
        where id = p_id and idn = z.idn;

    end loop;

  end;

  procedure create_deal (
    p_fileid    in number,
    -- p_proect_id is not null - SALARY
    -- p_proect_id is null - PENSION, SOCIAL
    p_proect_id in number,
    p_card_code in varchar2,
    p_branch    in varchar2,
    p_isp       in number )
  is
    l_proect_okpo   bpk_proect.okpo%type;
    l_client_array  t_batch_list;
    l_instant_nls   accounts.nls%type;
    l_rnk           number;
    l_nd            number;
    l_reqid         number;
    l_open          boolean;
    l_flag_kk       number;
    l_photo         blob;
    h varchar2(100) := 'ow_batch_opening.create_deal. ';
  begin

    bars_audit.info(h || 'Start: p_fileid=>' || to_char(p_fileid) || ' p_proect_id=>' || to_char(p_proect_id) ||
       ' p_card_code=>' || p_card_code || ' p_branch=>' || p_branch || ' p_isp=>' || to_char(p_isp));

    if p_proect_id is not null then
       begin
          select okpo into l_proect_okpo from bpk_proect where id = p_proect_id;
       exception when no_data_found then
          bars_audit.info(h || 'Не найден З/П проект с кодом '||to_char(p_proect_id));
          bars_error.raise_nerror(g_modcode, 'PROECT_NOT_FOUND', to_char(p_proect_id));
       end;
    end if;

    if p_proect_id is not null then
       for z in ( select okpo
                    from ow_batch_open_data
                   where id = p_fileid and nd is null and str_err is null
                     and nvl(okpo,'000000000') <> '000000000'
                  having count(*) > 1
                   group by okpo )
       loop
          update ow_batch_open_data
             set str_err = 'Повторюється ЗКПО у межах файлу'
           where id = p_fileid and nd is null and str_err is null
             and okpo = z.okpo;
       end loop;
    end if;

    -- Картка
    begin
       select s.flag_kk into l_flag_kk
         from w4_card c, w4_subproduct s
        where c.code = p_card_code
          and c.sub_code = s.code;
    exception when no_data_found then
       -- Не найден продукт p_cardcode
       bars_error.raise_nerror(g_modcode, 'CARDCODE_NOT_FOUND', p_card_code);
    end;
    check_batch_opencard(p_fileid, p_card_code);
    select *
      bulk collect
      into l_client_array
      from ow_batch_open_data
     where id = p_fileid and nd is null and nvl(flag_open,0) = 1;

    for i in 1..l_client_array.count loop

       l_open := true;

       if p_proect_id is not null then
          -- проверка ОКПО:
          --   то, что заявлено в файле и то, что выбрали в приложении,
          --   должны совпадать
          if l_client_array(i).okpo_w is not null and l_proect_okpo is not null and
             l_client_array(i).okpo_w <> l_proect_okpo then
             update ow_batch_open_data
                set str_err = 'ЗКПО організації в файлі не співпадає з ЗКПО З/П проекту'
              where id = p_fileid and idn = l_client_array(i).idn;
             l_open := false;
          end if;
       end if;

       if l_open = true then

          if l_client_array(i).acc_instant is not null then
             begin
                select a.nls into l_instant_nls
                  from w4_acc_instant w, accounts a
                 where w.acc = l_client_array(i).acc_instant
                   and w.acc = a.acc;
             exception when no_data_found then
                bars_error.raise_nerror('SVC', 'ACC_NOT_FOUND', l_client_array(i).acc_instant);
             end;
          else
             l_instant_nls := null;
          end if;

          l_rnk := l_client_array(i).rnk;

          if l_rnk is null then
             -- регистрация клиента
             create_customer(l_client_array(i), p_branch);
             l_rnk := l_client_array(i).rnk;
          else
             -- обновление реквизитов клиента
             alter_client(l_rnk, l_client_array(i));
          end if;

          if l_flag_kk = 1 then
             kl.setCustomerElement(
                Rnk_   => l_rnk,
                Tag_   => 'W4KKW',
                Val_   => l_client_array(i).kk_secret_word,
                Otd_   => 0 );
             kl.setCustomerElement(
                Rnk_   => l_rnk,
                Tag_   => 'W4KKR',
                Val_   => l_client_array(i).kk_regtype,
                Otd_   => 0 );
             kl.setCustomerElement(
                Rnk_   => l_rnk,
                Tag_   => 'W4KKA',
                Val_   => l_client_array(i).kk_cityareaid,
                Otd_   => 0 );
             kl.setCustomerElement(
                Rnk_   => l_rnk,
                Tag_   => 'W4KKT',
                Val_   => l_client_array(i).kk_streettypeid,
                Otd_   => 0 );
             kl.setCustomerElement(
                Rnk_   => l_rnk,
                Tag_   => 'W4KKS',
                Val_   => l_client_array(i).kk_streetname,
                Otd_   => 0 );
             kl.setCustomerElement(
                Rnk_   => l_rnk,
                Tag_   => 'W4KKB',
                Val_   => l_client_array(i).kk_apartment,
                Otd_   => 0 );
             kl.setCustomerElement(
                Rnk_   => l_rnk,
                Tag_   => 'W4KKZ',
                Val_   => l_client_array(i).kk_postcode,
                Otd_   => 0 );
             kl.setCustomerElement(
                Rnk_   => l_rnk,
                Tag_   => 'W4KKC',
                Val_   => '2',
                Otd_   => 0 );
          end if;
          l_photo := get_photo_data(l_client_array(i).id, l_client_array(i).idn);
          if l_photo is not null then
            begin
              insert into customer_images
                (rnk, type_img, image)
              values
                (l_rnk, 'PHOTO_JPG', empty_blob());
            exception
              when dup_val_on_index then
                null;
            end;
            update customer_images
               set image = nvl(l_photo, image)
             where rnk = l_rnk and type_img = 'PHOTO_JPG';
          end if;
          -- регистрация БПК
          bars_ow.open_card (
            p_rnk           => l_rnk,
            p_nls           => l_instant_nls,
            p_cardcode      => p_card_code,
            p_branch        => p_branch,
            p_embfirstname  => l_client_array(i).eng_first_name,
            p_emblastname   => l_client_array(i).eng_last_name,
            p_secname       => l_client_array(i).mname,
            p_work          => l_client_array(i).work,
            p_office        => l_client_array(i).office,
            p_wdate         => l_client_array(i).date_w,
            p_salaryproect  => p_proect_id,
            p_term          => l_client_array(i).max_term,
            p_branchissue   => p_branch,
            p_nd            => l_nd,
            p_reqid         => l_reqid );
          update accounts set isp = p_isp where acc = (select acc_pk from w4_acc where nd = l_nd);

          -- сохранение данных по новому клиенту
          update ow_batch_open_data
             set rnk = l_rnk,
                 nd = l_nd
           where id = p_fileid and idn = l_client_array(i).idn;

       end if;

    end loop;
    set_state(p_fileid, 10);
    update ow_batch_files
       set card_code = p_card_code,
           branch = p_branch,
           isp = p_isp,
           proect_id = p_proect_id
     where id = p_fileid;

    bars_audit.info(h || 'Finish.');

  end;

  -- процедура принимает архив на пакетное открытие в формате блоб, и возращает тикет в формате заарзивированного blob
  PROCEDURE batch_get_process(p_filename         IN VARCHAR2
                             ,p_filebody         IN BLOB
                             ,p_external_file_id IN VARCHAR2
                             ,p_filetype         IN NUMBER
                             ,p_ticketdata       OUT BLOB) IS
    l_fileid            NUMBER;
    l_ticketname        VARCHAR2(300);
    l_compressed_blob   BLOB;
    l_uncompressed_blob BLOB;
    l_ticketdata_clob   CLOB;
  
    TYPE batch_files_rectype IS RECORD(
       fileid    ow_batch_files.id%TYPE
      ,proect_id ow_batch_files.proect_id%TYPE
      ,card_code ow_batch_files.card_code%TYPE
      ,branch    ow_batch_files.branch%TYPE
      ,isp       ow_batch_files.isp%TYPE);
    batch_files_rec batch_files_rectype;
  BEGIN
    l_compressed_blob   := to_blob('0');
    l_uncompressed_blob := to_blob('0');
    dbms_lob.createtemporary(l_ticketdata_clob
                            ,FALSE);
  
    -- ипорт файла и его обработка
    import_file_gz(p_filename         => p_filename
                  ,p_filebody         => p_filebody
                  ,p_external_file_id => p_external_file_id
                  ,p_filetype         => p_filetype
                  ,p_fileid           => l_fileid);
    -- если файл обработан, создаём сделки
    IF SQL%FOUND THEN
      -- переменные для создания сделки
      SELECT t.id AS fileid
            ,t.proect_id
            ,t.card_code
            ,t.branch
            ,t.isp
        INTO batch_files_rec
        FROM ow_batch_files t
       WHERE t.id = l_fileid;
      -- создаём сделку
      create_deal(p_fileid    => batch_files_rec.fileid
                 ,p_proect_id => batch_files_rec.proect_id
                 ,p_card_code => batch_files_rec.card_code
                 ,p_branch    => batch_files_rec.branch
                 ,p_isp       => batch_files_rec.isp);
      -- сделка создана, формируем тикет
      IF SQL%FOUND THEN
        form_ticket(p_fileid     => l_fileid
                   ,p_ticketname => l_ticketname
                   ,p_ticketdata => l_ticketdata_clob);
        -- преобразовать клоб в блоб
        l_uncompressed_blob := clob_to_blob(l_ticketdata_clob);
        -- заархивировать блоб
        utl_compress.lz_compress(src => l_uncompressed_blob
                                ,dst => l_compressed_blob);
      
        p_ticketdata := l_compressed_blob;
      
      END IF;
    END IF;
  
  END batch_get_process;
end;
/

 show err;
 
PROMPT *** Create  grants  OW_BATCH_OPENING ***

  grant DEBUG,EXECUTE  ON "BARS"."OW_BATCH_OPENING" TO "BARSTRANS";
  grant DEBUG,EXECUTE  ON "BARS"."OW_BATCH_OPENING" TO "BARS_ACCESS_DEFROLE";
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/OW_BATCH_OPENING.sql =========*** 
 PROMPT =====================================================================================  