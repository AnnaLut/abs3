
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/pfu_ru_epp_utl.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.PFU_RU_EPP_UTL is

  -- Author  : VITALII.KHOMIDA
  -- Created : 02.06.2016 19:46:36
  -- Purpose :
  g_header_version constant varchar2(64) := 'version 3.00 20/12/2016';
  g_header_defs    constant varchar2(512) := '';

  procedure import_files(p_fileid    in number,
                         p_filecode  in varchar2,
                         p_kf        in varchar2,
                         p_sign      in raw default null,
                         p_file_data in blob,
                         p_state     out number,
                         p_message   out varchar2,
                         p_stack     out varchar2);
  procedure get_filestate(p_fileid  in number,
                          p_state   out number,
                          p_message out varchar2);
  function get_respfile(p_fileid in number) return blob;

  procedure pfu_files_processing;

  procedure cm_error_process;

  procedure create_epp_rnk(p_eppnum in pfu_epp_line_processing.epp_number%type,
                           p_rnk in customer.rnk%type);

  function get_epp_receipt(p_fileid in number) return clob;


  procedure create_epp(p_fileid in number);

  procedure set_file_state(p_fileid  in number,
                           p_state   in number,
                           p_message in varchar2);

  procedure set_file_state(p_fileid  in number,
                           p_state   in number,
                           p_message in varchar2,
                           p_resp    in clob);

end;
/
CREATE OR REPLACE PACKAGE BODY BARS.PFU_RU_EPP_UTL is

  g_body_version constant varchar2(64) := 'version 4.00 18/01/2017';
  g_body_defs    constant varchar2(512) := '';


  type t_epp is table of pfu_epp_line_processing%rowtype index by pls_integer;
  g_openaccstate constant number := 2;
  g_keytype         constant varchar2(30)  := 'WAY_DOC';

  type t_actrec is record(id number,
                          state_id number,
                          message varchar2(4000));

  type t_accreclist is table of t_actrec;

  -- header_version - возвращает версию заголовка пакета
  function header_version return varchar2 is
  begin
    return 'Package header crypto_utl ' || g_header_version || '.' || chr(10) || 'AWK definition: ' || chr(10) || g_header_defs;
  end header_version;

  -------------------------------------------------------------------------------
  -- body_version - возвращает версию тела пакета
  function body_version return varchar2 is
  begin
    return 'Package body crypto_utl ' || g_body_version || '.' || chr(10) || 'AWK definition: ' || chr(10) || g_body_defs;
  end body_version;

  function get_filetypeid(p_filecode in varchar2) return number is
    l_id number;
  begin
    select p.id
      into l_id
      from pfu_filetypes p
     where upper(p.code) = upper(p_filecode);
    return l_id;
  exception
    when no_data_found then
      l_id := null;
      return l_id;
  end;

  procedure import_files(p_fileid    in number,
                         p_filecode  in varchar2,
                         p_kf        in varchar2,
                         p_sign      in raw default null,
                         p_file_data in blob,
                         p_state     out number,
                         p_message   out varchar2,
                         p_stack     out varchar2) is
    l_filetype  number;
    l_tmpb      blob;
    l_file_data clob;
    l_warning    integer;
    l_dest_offset integer := 1;
    l_src_offset integer := 1;
    l_blob_csid number := dbms_lob.default_csid;
    l_lang_context number := dbms_lob.default_lang_ctx;

    h           varchar2(100) := 'pfu_ru_utl.import_files. ';
  begin

   -- bars_audit.info(h || 'Start. Fileid=' || p_fileid);
    l_filetype  := get_filetypeid(p_filecode);
    l_tmpb      := utl_compress.lz_uncompress(p_file_data);

    dbms_lob.createtemporary(l_file_data, false);

    dbms_lob.converttoclob(dest_lob     => l_file_data,
                           src_blob     => l_tmpb,
                           amount       => dbms_lob.lobmaxsize,
                           dest_offset  => l_dest_offset,
                           src_offset   => l_src_offset,
                           blob_csid    => l_blob_csid,
                           lang_context => l_lang_context,
                           warning      => l_warning);


    if l_filetype is not null then
      insert into pfu_ca_files
        (id, file_data, file_type, sign, kf)
      values
        (p_fileid, l_file_data, l_filetype, p_sign, p_kf);
     -- bars_audit.info(h || 'File imported. Fileid=' || p_fileid);

      insert into pfu_ca_files_tracking
        (id, file_id)
      values
        (bars.s_pfu_ca_files_tracking.nextval, p_fileid);

      p_state   := 0;
      p_message := 'OK';
    else
      p_state   := 2;
      p_message := 'Невідомий формат файлу';
    end if;

  exception
    when dup_val_on_index then
      p_state   := 1;
      p_message := 'Файл вже відправлявся';
    when others then
      p_state   := 99;
      p_message := 'Невідома помилка';
      p_stack   := dbms_utility.format_error_stack() || chr(10) ||
                   dbms_utility.format_error_backtrace();

  end;

  procedure get_filestate(p_fileid  in number,
                          p_state   out number,
                          p_message out varchar2) is

    h varchar2(100) := 'pfu_ru_utl.get_filesate. ';
  begin

    -- bars_audit.info(h || 'Start. Fileid=' || p_fileid);

    select t.state, t.message
      into p_state, p_message
      from pfu_ca_files t
     where t.id = p_fileid;

    -- bars_audit.info(h || 'End. Return State=' || p_state || ' Message="' ||
    --p_message || '"');
  exception
    when no_data_found then
      p_state   := 99;
      p_message := 'Файл не знайдено ID=' || p_fileid;
      -- bars_audit.info(h || 'Error. File not found. Fileid=' || p_fileid);
  end;

  function get_respfile(p_fileid in number) return blob is
    l_resp         clob;
    l_warning      integer;
    l_dest_offset  integer := 1;
    l_src_offset   integer := 1;
    l_blob_csid    number := dbms_lob.default_csid;
    l_lang_context number := dbms_lob.default_lang_ctx;
    l_blob         blob;
    h              varchar2(100) := 'pfu_ru_utl.get_respfile. ';
  begin
    --bars_audit.info(h || 'Start. Fileid=' || p_fileid);

    dbms_lob.createtemporary(l_blob, false);

    select t.resp_data
      into l_resp
      from pfu_ca_files t
     where t.id = p_fileid;

    if l_resp is not null then
      dbms_lob.converttoblob(dest_lob     => l_blob,
                             src_clob     => l_resp,
                             amount       => dbms_lob.lobmaxsize,
                             dest_offset  => l_dest_offset,
                             src_offset   => l_src_offset,
                             blob_csid    => l_blob_csid,
                             lang_context => l_lang_context,
                             warning      => l_warning);

      -- bars_audit.info(h || 'End. OK');

      l_blob := utl_compress.lz_compress(l_blob);
    end if;
    return l_blob;

  exception
    when no_data_found then
      -- bars_audit.info(h || 'Error. File not found. Fileid=' || p_fileid);
      return l_blob;
  end;

  procedure set_file_state(p_fileid  in number,
                           p_state   in number,
                           p_message in varchar2) is
  begin
    update pfu_ca_files t
       set t.state   = p_state,
           t.message = p_message
     where t.id = p_fileid;

    insert into pfu_ca_files_tracking
      (id, file_id, state, message)
    values
      (s_pfu_ca_files_tracking.nextval, p_fileid, p_state, p_message);
  end;

  procedure set_file_state(p_fileid  in number,
                           p_state   in number,
                           p_message in varchar2,
                           p_resp    in clob) is
  begin
    update pfu_ca_files t
       set t.state    = p_state,
           t.message  = p_message,
           t.resp_data = p_resp
     where t.id = p_fileid;

    insert into pfu_ca_files_tracking
      (id, file_id, state, message)
    values
      (s_pfu_ca_files_tracking.nextval, p_fileid, p_state, p_message);
  end;

  function get_client(p_okpo    in varchar2,
                      p_paspser in varchar2,
                      p_paspnum in varchar2,
                      p_bdate   in date,
                      p_typedoc in number,
                      p_code    out number) return number is
    l_irnk         number := null;
    l_count_okpo   number;
    l_count_passp  number;
    l_count_passpd number;
    /* p_code = 0 - не знайдено
     *          1 - Ok знайдено по всім реквізитам
     *          2 - Знайдено по ІНН, не співпадає серія та номер документа
     *          3 - Знайдено по ІНН чи документі, не співпадає дата народження
    */
  begin
    p_code := 0;
    if substr(p_okpo, 1, 5) = '99999' or substr(p_okpo, 1, 5) = '00000' then

      select count(*), sum(decode(p.bday, p_bdate, 1, 0))
        into l_count_passp, l_count_passpd
        from person p, customer c
       where (p_typedoc = 1 and p.passp = p_typedoc and c.custtype = 3 and
             ((p.ser = p_paspser and p.numdoc = p_paspnum and
             p.rnk = c.rnk and nvl(trim(c.sed), '00') = '00') or
             (p.ser = p_paspser and p.numdoc = p_paspnum and
             p.rnk = c.rnk and nvl(trim(c.sed), '00') = '00' and
             p.bday = p_bdate))) or
             (p_typedoc = 7 and p.passp = p_typedoc and c.custtype = 3 and
             ((p.numdoc = p_paspnum and p.rnk = c.rnk and
             nvl(trim(c.sed), '00') = '00') or
             (p.numdoc = p_paspnum and p.rnk = c.rnk and
             nvl(trim(c.sed), '00') = '00' and p.bday = p_bdate)));

      if l_count_passp > 0 and l_count_passpd > 0 then

        select min(c.rnk) keep (dense_rank first order by v.rnk desc nulls last, c.rnk desc)
        into   l_irnk
        from   customer c
        join   person p on p.rnk = c.rnk and
                           p.passp = p_typedoc and
                           p.numdoc = p_paspnum and
                           p.bday = p_bdate and
                           ((p_typedoc = 1 and p.ser = p_paspser) or (p_typedoc = 7))
        left join v_cm_client v on c.rnk = v.rnk and
                                   v.oper_status in (1, 2, 3)
        where  c.custtype = 3 and
               nvl(trim(c.sed), '00') = '00';
/*
        -- альтернативний варіант
        select rnk
        into   l_irnk
        from   (select c.rnk, row_number() over (order by v.rnk desc nulls last, c.rnk desc) rn
                from   customer c
                join   person p on p.rnk = c.rnk and
                                   p.passp = p_typedoc and
                                   p.numdoc = p_paspnum and
                                   p.bday = p_bdate and
                                   ((p_typedoc = 1 and p.ser = p_paspser) or (p_typedoc = 7))
                left join v_cm_client v on c.rnk = v.rnk and
                                           v.oper_status in (1, 2, 3)
                where  c.custtype = 3 and
                       nvl(trim(c.sed), '00') = '00')
        where rn = 1;
*//*
        -- старий варіант
        select rnk
          into l_irnk
          from(select c.rnk, row_number() over(order by v.rnk desc nulls last, c.rnk desc) rn
                 from customer c, person p,v_cm_client v
                where c.rnk = v.rnk(+) and v.oper_status(+) in (1, 2, 3) and
                     (p_typedoc = 1 and p.passp = p_typedoc and c.custtype = 3 and
               p.ser = p_paspser and p.numdoc = p_paspnum and
               p.rnk = c.rnk and nvl(trim(c.sed), '00') = '00' and
               p.bday = p_bdate) or
               (p_typedoc = 7 and p.passp = p_typedoc and c.custtype = 3 and
               p.numdoc = p_paspnum and p.rnk = c.rnk and
                      nvl(trim(c.sed), '00') = '00' and p.bday = p_bdate))
         where rn = 1;
*/
        p_code := 1;
        update customer cus
           set cus.date_off = null
         where cus.rnk = l_irnk;

      else
        /*if l_count_passp > 0 and l_count_passpd = 0 then
          p_code := 3;
        else*/
          p_code := 0;
--        end if;
      end if;
    else

      -- ищем клиентов с ОКПО
      select count(*)
        into l_count_okpo
        from customer c, person p
       where c.rnk = p.rnk and /*c.date_off is null and*/ c.okpo = p_okpo and
             c.custtype = 3 and nvl(trim(c.sed), '00') = '00';

      -- есть клиенты с ОКПО и паспортными данными
      if l_count_okpo = 0 then
        p_code := 0;
      else

        /*select count(*)
          into l_count_okpo
          from customer c, person p
         where c.rnk = p.rnk and c.date_off is null and c.okpo = p_okpo and
               c.custtype = 3 and nvl(trim(c.sed), '00') = '00' and
               ((p_typedoc = 1 and p.passp = p_typedoc and
               p.ser = p_paspser and p.numdoc = p_paspnum) or
               (p_typedoc = 7 and p.passp = p_typedoc and
               p.numdoc = p_paspnum));

        if l_count_okpo = 0 then
          p_code := 2;
        else

          select count(*)
            into l_count_okpo
            from customer c, person p
           where c.rnk = p.rnk and c.date_off is null and c.okpo = p_okpo and c.custtype = 3 and
                 p.bday = p_bdate and nvl(trim(c.sed), '00') = '00' and
                 ((p_typedoc = 1 and p.passp = p_typedoc and
                 p.ser = p_paspser and p.numdoc = p_paspnum) or
                 (p_typedoc = 7 and p.passp = p_typedoc and
                 p.numdoc = p_paspnum));

          if l_count_okpo = 0 then
            p_code := 3;
          else*/
            select count(*)
              into l_count_okpo
              from customer c, person p, v_cm_client v
             where c.rnk = p.rnk /*and c.date_off is null*/ and c.rnk = v.rnk(+) and
                   v.oper_status(+) in (1, 2, 3) and c.okpo = p_okpo and c.custtype = 3 and nvl(trim(c.sed), '00') = '00';
          if l_count_okpo != 0 then
            select rnk
              into l_irnk
              from (select c.rnk, row_number() over(order by v.rnk desc nulls last, c.rnk desc) rn
                      from customer c, person p, v_cm_client v
                     where c.rnk = p.rnk /*and c.date_off is null*/ and c.rnk = v.rnk(+) and
                           v.oper_status(+) in (1, 2, 3) and c.okpo = p_okpo and
                           c.custtype = 3 and nvl(trim(c.sed), '00') = '00'/*and p.bday = p_bdate and  and
                   ((p_typedoc = 1 and p.passp = p_typedoc and
                   p.ser = p_paspser and p.numdoc = p_paspnum) or
                   (p_typedoc = 7 and p.passp = p_typedoc and
                          p.numdoc = p_paspnum))*/)
             where rn = 1;

            if l_irnk is not null then
              p_code :=1;
              update customer cus
                 set cus.date_off = null
               where cus.rnk = l_irnk;
            end if;
          end if;
        --end if;
      end if;
    end if;

    return l_irnk;

  end;

  function get_pens_deal(p_rnk in number, p_cardcode out varchar2, p_prodcode in out varchar2) return number is
    l_nd number;
  begin

    select max(w.nd)
      into l_nd
      from w4_acc w
      join accounts a
        on w.acc_pk = a.acc and a.rnk = p_rnk and a.dazs is null and
           w.dat_close is null
      join w4_card t
        on w.card_code = t.code
     where t.product_code = p_prodcode;

     if l_nd is not null then
        select w.card_code
          into p_cardcode
          from w4_acc w
         where w.nd = l_nd;
     end if;

    return l_nd;
  end;

  function create_customer(p_pfu_row in pfu_epp_line_processing%rowtype)
    return number is
    l_nmk     varchar2(70);
    l_nmkv    varchar2(70);
    l_nmkk    varchar2(38);
    l_adr     varchar2(70);
    l_rnk     number;
    l_mob     varchar2(15);
    l_phone   varchar2(15);
    l_tmp     number;
    l_phones  varchar2(30);
    l_pos     number;
    l_country number;
  begin

    -- LastName - фамилия, FirstName - имя
    l_nmk  := substr(trim(p_pfu_row.last_name || ' ' ||
                          p_pfu_row.first_name || ' ' ||
                          p_pfu_row.middle_name),
                     1,
                     70);
    l_nmkv := substr(f_translate_kmu(trim(l_nmk)), 1, 70);
    l_nmkk := substr(p_pfu_row.last_name || ' ' || p_pfu_row.first_name,
                     1,
                     38);
    -- Получаем номера телефонов
    if instr(p_pfu_row.phone_numbers, ',') > 0 then
      l_phones := p_pfu_row.phone_numbers;

      loop
        exit when l_phones is null;
        l_pos := instr(l_phones, ',');
        if l_pos = 0 then
          l_phone  := trim(l_phones);
          l_phones := null;
        else
          l_phone  := trim(substr(l_phones, 1, l_pos - 1));
          l_phones := trim(substr(l_phones, l_pos + 1));
        end if;
        if l_phone is not null then
          select count(*)
            into l_tmp
            from phone_mob_code t
           where t.code = substr(trim(l_phone), -9, 2);
          if l_tmp > 0 then
            l_mob   := l_phone;
            l_phone := null;
          end if;
        end if;
      end loop;
    else
      select count(*)
        into l_tmp
        from phone_mob_code t
       where t.code = substr(trim(p_pfu_row.phone_numbers), -9, 2);
      if l_tmp > 0 then
        l_mob := trim(p_pfu_row.phone_numbers);
      else
        l_phone := p_pfu_row.phone_numbers;
      end if;
    end if;

    select substr(trim(p_pfu_row.legal_region) ||
                   nvl2(trim(p_pfu_row.legal_district),
                        ' ' || trim(p_pfu_row.legal_district),
                        '') || nvl2(trim(p_pfu_row.legal_settlement),
                                    ' ' || trim(p_pfu_row.legal_settlement),
                                    '') ||
                   nvl2(trim(p_pfu_row.legal_street || ', ' ||
                             p_pfu_row.legal_house || ', ' ||
                             p_pfu_row.legal_house ||
                             nvl2(trim(p_pfu_row.legal_apartment),
                                  ' ' || trim(p_pfu_row.legal_apartment),
                                  '')),
                        ' ' ||
                        trim(p_pfu_row.legal_street || ', ' ||
                             p_pfu_row.legal_house || ', ' ||
                             p_pfu_row.legal_house ||
                             nvl2(trim(p_pfu_row.legal_apartment),
                                  ' ' || trim(p_pfu_row.legal_apartment),
                                  '')),
                        ''),
                   1,
                   70)
      into l_adr
      from dual;

    select nvl(min(t.country), 804)
      into l_country
      from country t
     where upper(t.name) = upper(trim(p_pfu_row.legal_country));

    kl.setcustomerattr(rnk_       => l_rnk, -- Customer number
                       custtype_  => 3, -- Тип клиента: 1-банк, 2-юр.лицо, 3-физ.лицо
                       nd_        => null, -- № договора
                       nmk_       => l_nmk, -- Наименование клиента
                       nmkv_      => l_nmkv, -- Наименование клиента международное
                       nmkk_      => l_nmkk, -- Наименование клиента краткое
                       adr_       => l_adr, -- Адрес клиента
                       codcagent_ => 5, -- Характеристика
                       country_   => l_country, -- Страна
                       prinsider_ => 99, -- Признак инсайдера
                       tgr_       => 2, -- Тип гос.реестра
                       okpo_      => trim(p_pfu_row.tax_registration_number), -- ОКПО
                       stmt_      => 0, -- Формат выписки
                       sab_       => null, -- Эл.код
                       dateon_    => bankdate, -- Дата регистрации
                       taxf_      => null, -- Налоговый код
                       creg_      => -1, -- Код обл.НИ
                       cdst_      => -1, -- Код район.НИ
                       adm_       => null, -- Админ.орган
                       rgtax_     => null, -- Рег номер в НИ
                       rgadm_     => null, -- Рег номер в Адм.
                       datet_     => null, -- Дата рег в НИ
                       datea_     => null, -- Дата рег. в администрации
                       ise_       => null, -- Инст. сек. экономики
                       fs_        => null, -- Форма собственности
                       oe_        => null, -- Отрасль экономики
                       ved_       => null, -- Вид эк. деятельности
                       sed_       => null, -- Форма хозяйствования
                       notes_     => null, -- Примечание
                       notesec_   => null, -- Примечание для службы безопасности
                       crisk_     => 1, -- Категория риска
                       pincode_   => null, --
                       rnkp_      => null, -- Рег. номер холдинга
                       lim_       => null, -- Лимит кассы
                       nompdv_    => null, -- № в реестре плат. ПДВ
                       mb_        => 9, -- Принадл. малому бизнесу
                       bc_        => 0, -- Признак НЕклиента банка
                       tobo_      => p_pfu_row.branch, -- Код безбалансового отделения
                       isp_       => null -- Менеджер клиента (ответ. исполнитель)
                       );

    kl.setcustomeren(p_rnk  => l_rnk,
                     p_k070 => nvl(getglobaloption('CUSTK070'), '00000'), -- ise
                     p_k080 => nvl(getglobaloption('CUSTK080'), '00'), -- fs
                     p_k110 => '00000', -- ved
                     p_k090 => '00000', -- oe
                     p_k050 => '000', -- k050
                     p_k051 => '00' -- sed
                     );

    kl.setcustomerelement(rnk_ => l_rnk,
                          tag_ => 'FGIDX',
                          val_ => trim(p_pfu_row.legal_zip_code),
                          otd_ => 0);

    kl.setcustomerelement(rnk_ => l_rnk,
                          tag_ => 'FGOBL',
                          val_ => trim(p_pfu_row.legal_region),
                          otd_ => 0);

    kl.setcustomerelement(rnk_ => l_rnk,
                          tag_ => 'FGDST',
                          val_ => trim(p_pfu_row.legal_district),
                          otd_ => 0);

    kl.setcustomerelement(rnk_ => l_rnk,
                          tag_ => 'FGTWN',
                          val_ => trim(p_pfu_row.legal_settlement),
                          otd_ => 0);

    kl.setcustomerelement(rnk_ => l_rnk,
                          tag_ => 'FGADR',
                          val_ => trim(p_pfu_row.legal_street || ', ' ||
                                       p_pfu_row.legal_house || ', ' ||
                                       p_pfu_row.legal_house),
                          otd_ => 0);

    kl.setcustomeraddressbyterritory(rnk_         => l_rnk,
                                     typeid_      => 1,
                                     country_     => 804,
                                     zip_         => substr(trim(p_pfu_row.legal_zip_code),
                                                            1,
                                                            20),
                                     domain_      => substr(trim(p_pfu_row.legal_region),
                                                            1,
                                                            30),
                                     region_      => substr(trim(p_pfu_row.legal_district),
                                                            1,
                                                            30),
                                     locality_    => substr(trim(p_pfu_row.legal_settlement),
                                                            1,
                                                            30),
                                     address_     => substr(trim(p_pfu_row.legal_street || ', ' ||
                                                                 p_pfu_row.legal_house || ', ' ||
                                                                 p_pfu_row.legal_house),
                                                            1,
                                                            100),
                                     territoryid_ => null);

    kl.setcustomeraddressbyterritory(rnk_         => l_rnk,
                                     typeid_      => 2,
                                     country_     => 804,
                                     zip_         => substr(trim(p_pfu_row.actual_zip_code),
                                                            1,
                                                            20),
                                     domain_      => substr(trim(p_pfu_row.actual_region),
                                                            1,
                                                            30),
                                     region_      => substr(trim(p_pfu_row.actual_district),
                                                            1,
                                                            30),
                                     locality_    => substr(trim(p_pfu_row.actual_settlement),
                                                            1,
                                                            30),
                                     address_     => substr(trim(p_pfu_row.actual_street || ', ' ||
                                                                 p_pfu_row.actual_house || ', ' ||
                                                                 p_pfu_row.actual_house),
                                                            1,
                                                            100),
                                     territoryid_ => null);

   kl.setpersonattr(rnk_    => l_rnk,
                     sex_    => case p_pfu_row.gender
                                  when 0 then
                                   1
                                  else
                                   2
                                end,
                     passp_  => p_pfu_row.document_type,
                     ser_    => case p_pfu_row.document_type
                                  when 1 then
                                   substr(p_pfu_row.document_id, 1, 2)
                                  else
                                   null
                                end,
                     numdoc_ => case p_pfu_row.document_type
                                  when 1 then
                                   substr(p_pfu_row.document_id, 4)
                                  else
                                   trim(p_pfu_row.document_id)
                                end,
                     pdate_  => trim(p_pfu_row.document_issue_date),
                     organ_  => substr(trim(p_pfu_row.document_issuer),
                                       1,
                                       70),
                     bday_   => p_pfu_row.date_of_birth,
                     bplace_ => null,
                     teld_   => l_phone,
                     telw_   => null);

    -- LastName - фамилия, FirstName - имя
    kl.setcustomerelement(rnk_ => l_rnk,
                          tag_ => 'SN_FN',
                          val_ => p_pfu_row.first_name,
                          otd_ => 0);

    kl.setcustomerelement(rnk_ => l_rnk,
                          tag_ => 'SN_LN',
                          val_ => p_pfu_row.last_name,
                          otd_ => 0);

    if p_pfu_row.middle_name is not null then
      kl.setcustomerelement(rnk_ => l_rnk,
                            tag_ => 'SN_MN',
                            val_ => p_pfu_row.middle_name,
                            otd_ => 0);
    end if;

    if l_mob is not null then
      kl.setcustomerelement(rnk_ => l_rnk,
                            tag_ => 'MPNO ',
                            val_ => l_mob,
                            otd_ => 0);
    end if;

    kl.setcustomerelement(rnk_ => l_rnk,
                          tag_ => 'K013',
                          val_ => '5',
                          otd_ => 0);
    return l_rnk;
  end create_customer;

  procedure get_nls_maxterm(p_nd   in number,
                            p_nls  out varchar2,
                            p_term out number) is
  begin
     select a.nls, t.maxterm
           into p_nls, p_term
           from w4_acc w
           join w4_card t
             on w.card_code = t.code and w.nd = p_nd
          /* join w4_product wp
             on t.product_code = wp.code
           join w4_tips wt
             on wp.tip = wt.tip*/
           join accounts a
             on w.acc_pk = a.acc;
  end;

  procedure create_epp(p_fileid in number) is
    l_epp   t_epp;
    l_rnk   customer.rnk%type;
    l_code  pls_integer;
    l_nls   varchar2(15);
    l_nd    number;
    l_reqid number;
    l_term  number;
    l_state number;
    l_count number;
    l_first_name varchar2(100);
    l_last_name  varchar2(100);
    l_cmclient cm_client_que%rowtype;
    l_cardcode     VARCHAR2(32);
    l_productcode  VARCHAR2(32);
  begin
    select * bulk collect
      into l_epp
      from pfu_epp_line_processing t
     where t.state_id = g_openaccstate
     and t.file_id = p_fileid;

    if l_epp.count > 0 then

      for i in l_epp.first .. l_epp.last
      loop
        l_code := 0;
        l_nd   := null;
        if l_epp(i).document_type = 1 then
          if regexp_like(trim(l_epp(i).document_id), '^[0-9]{9}$') then
            l_epp(i).document_type := 7;

          elsif regexp_like(trim(l_epp(i).document_id),
                            '^[А-ЯІЇҐ]{2} [0-9]{6}$') then
            l_epp(i).document_type := 1;
          end if;
        end if;
        l_rnk := get_client(p_okpo    => l_epp(i).tax_registration_number,
                            p_paspser => case when  l_epp(i).document_type = 1 then substr(l_epp(i).document_id, 1, 2) else null end,
                            p_paspnum => case when  l_epp(i).document_type = 1 then substr(l_epp(i).document_id, 4) else l_epp(i).document_id end,
                            p_bdate   => l_epp(i).date_of_birth,
                            p_typedoc => l_epp(i).document_type,
                            p_code    => l_code);
        savepoint s_reg;
        if l_rnk is null then
          savepoint s_kreg;
          begin
            l_rnk := create_customer(l_epp(i));
          exception
            when others then
              rollback to s_kreg;
              l_epp(i).message := 'Помилка при відкриті клієнта: ' ||
                                  dbms_utility.format_error_stack() ||
                                  chr(10) ||
                                  dbms_utility.format_error_backtrace();
              l_code := 4;

          end;
        end if;

        if l_code in (0, 1) then
          --Добавить поиск договора с продуктом,если нет открываем новый иначе перевыпускаем карту
          --добавить поддержку 9 типа заявок в см
          --добавить функцию активации счета
          -- регистрация БПК
          --добавить увеличения срока действия карты после перевыпуска

          kl.setcustomerelement(rnk_ => l_rnk,
                                tag_ => 'PENSN',
                                val_ => l_epp(i).epp_number,
                                otd_ => 0);
          if l_code = 1 then
            l_productcode := case when l_epp(i).type_pens = 1 then 'PENS_SOC_MIGRANT'
                                  when l_epp(i).type_pens = 2 then 'PENS_ARSL_MIGRANT'
                                  else 'PENS_SOC_MIGRANT' end;
            l_nd := get_pens_deal(l_rnk, l_cardcode, l_productcode);
          end if;
          savepoint s_cardreg;
          if l_nd is null then
            begin
              l_first_name := trim(f_translate_kmu(l_epp(i).first_name));
              l_count := length(l_first_name);
              if (instr(l_epp(i).last_name,'-') > 0) then
                 l_last_name := trim(f_translate_kmu(substr(l_epp(i).last_name, 1, instr(l_epp(i).last_name,'-') - 1)));
              elsif (instr(l_epp(i).last_name,' ') > 0) then
                 l_last_name := trim(f_translate_kmu(substr(l_epp(i).last_name, 1, instr(l_epp(i).last_name,' ') - 1)));
              else
                 l_last_name := trim(f_translate_kmu(l_epp(i).last_name));
              end if;
              if (l_count + length(l_last_name) > 24) then
                 l_last_name := substr(l_last_name, 1, 24 - l_count);
              end if;
              bars_ow.open_card(p_rnk          => l_rnk,
                                p_nls          => null,
                                p_cardcode     => case when l_epp(i).type_pens = 1 then 'PENS_SOC_MIGRANT_NSMEP'
                                                       when l_epp(i).type_pens = 2 then 'PENS_ARSL_MIGRANT_NSMEP'
                                                       else 'PENS_SOC_MIGRANT_NSMEP' end,
                                p_branch       => l_epp(i).branch,
                                p_embfirstname => l_first_name,
                                p_emblastname  => l_last_name,
                                p_secname      => l_epp(i).last_name,
                                p_work         => null,
                                p_office       => null,
                                p_wdate        => null,
                                p_salaryproect => null,
                                p_term         => null,
                                p_branchissue  => l_epp(i).branch,
                                p_nd           => l_nd,
                                p_reqid        => l_reqid);
              update accounts
                 set nbs  = null,
                     dazs = bankdate
               where acc = (select acc_pk from w4_acc where nd = l_nd)
              returning nls into l_nls;

               update pfu_epp_line_processing pelp
                 set pelp.reqid = l_reqid
               where pelp.epp_number = l_epp(i).epp_number;

              l_epp(i).nls := l_nls;

            exception
              when others then
                rollback to s_cardreg;
                l_epp(i).message := 'Помилка відкриття картки: ' ||
                                    dbms_utility.format_error_stack() ||
                                    chr(10) ||
                                    dbms_utility.format_error_backtrace();
                l_code := 5;
            end;
          else
            begin
              if (l_productcode = 'PENS_SOC_MIGRANT') and (l_cardcode != 'PENS_SOC_MIGRANT_NSMEP') then
                 update w4_acc w
                    set w.card_code = 'PENS_SOC_MIGRANT_NSMEP'
                  where w.nd = l_nd;
              elsif (l_productcode = 'PENS_ARSL_MIGRANT') and (l_cardcode != 'PENS_ARSL_MIGRANT_NSMEP') then
                 update w4_acc w
                    set w.card_code = 'PENS_ARSL_MIGRANT_NSMEP'
                  where w.nd = l_nd;
              end if;
              get_nls_maxterm(l_nd, l_epp(i).nls, l_term);

              bars_ow.set_term(p_nd   => l_nd,
                               p_bdat => trunc(sysdate),
                               p_term => l_term);
              l_cmclient := bars_ow.f_add_deal_to_cmque(p_nd => l_nd,
                                                        p_opertype => 9);
              update cm_client_que t
                 set t.delivery_br = l_epp(i).branch
               where t.id = l_cmclient.id;

              update pfu_epp_line_processing pelp
                 set pelp.reqid = l_cmclient.id
               where pelp.epp_number = l_epp(i).epp_number;

            exception
              when others then
                rollback to s_cardreg;
                l_epp(i).message := 'Помилка перевипуску картки: ' ||
                                    dbms_utility.format_error_stack() ||
                                    chr(10) ||
                                    dbms_utility.format_error_backtrace();
                l_code := 6;
            end;

          end if;
        end if;

        if l_code in (0, 1) then
          update pfu_epp_line_processing t
             set t.state_id = 20,
                 t.message  = 'Створено заявку на випуск ЕПП',
                 t.nls      = l_epp(i).nls
           where t.id = l_epp(i).id;
        else
          rollback to s_reg;
          if l_code = 2 then
            l_epp(i).message := 'Не співпадає серія та номер документа з існуючим клієнтом РНК(' ||
                                l_rnk || ')';
            l_state := 11;
          elsif l_code = 3 then
            l_epp(i).message := 'Не співпадає дата народження з існуючим клієнтом РНК(' ||
                                l_rnk || ')';
            l_state := 12;
          elsif l_code = 4 then

            l_state := 13;
          elsif l_code = 5 then
            l_state := 14;
          elsif l_code = 6 then
            l_state := 15;
          end if;
          update pfu_epp_line_processing t
             set t.state_id = l_state,
                 t.message  = l_epp(i).message
           where t.id = l_epp(i).id;
        end if;
      end loop;
    end if;
  end;

  procedure create_epp_rnk(p_eppnum in pfu_epp_line_processing.epp_number%type,
                           p_rnk in customer.rnk%type) is
    l_epp   pfu_epp_line_processing%rowtype;
    l_nls   varchar2(15);
    l_nd    number;
    l_rnk   number;
    l_code  number;
    l_reqid number;
    l_term  number;
    l_state number;
    l_count number;
    l_clob clob;
    l_first_name varchar2(100);
    l_last_name  varchar2(100);
    l_cmclient cm_client_que%rowtype;
    l_cardcode     VARCHAR2(32);
    l_productcode  VARCHAR2(32);
  begin
    select *
      into l_epp
      from pfu_epp_line_processing t
     where t.epp_number = p_eppnum;
    l_rnk := p_rnk;
    l_code := 0;

    if p_rnk is null then
       l_rnk := get_client(p_okpo    => l_epp.tax_registration_number,
                            p_paspser => case when  l_epp.document_type = 1 then substr(l_epp.document_id, 1, 2) else null end,
                            p_paspnum => case when  l_epp.document_type = 1 then substr(l_epp.document_id, 4) else l_epp.document_id end,
                            p_bdate   => l_epp.date_of_birth,
                            p_typedoc => l_epp.document_type,
                            p_code    => l_code);
       if l_rnk is null then
         begin
            l_rnk := create_customer(l_epp);
         exception
          when others then
             l_epp.message := 'Помилка при відкриті клієнта: ' ||
                                 dbms_utility.format_error_stack() ||
                                 chr(10) ||
                                 dbms_utility.format_error_backtrace();
             l_code := 4;

           end;
        end if;
    end if;

    l_nd   := null;
    if l_epp.document_type = 1 then
       if regexp_like(trim(l_epp.document_id), '^[0-9]{9}$') then
          l_epp.document_type := 7;
       elsif regexp_like(trim(l_epp.document_id),'^[А-ЯІЇҐ]{2} [0-9]{6}$') then
          l_epp.document_type := 1;
       end if;
    end if;

    kl.setcustomerelement(rnk_ => l_rnk,
                          tag_ => 'PENSN',
                          val_ => l_epp.epp_number,
                          otd_ => 0);
    if l_code = 1 or p_rnk is not null then
      l_productcode := case when l_epp.type_pens = 1 then 'PENS_SOC_MIGRANT'
                            when l_epp.type_pens = 2 then 'PENS_ARSL_MIGRANT'
                            else 'PENS_SOC_MIGRANT' end;
      l_nd := get_pens_deal(l_rnk, l_cardcode, l_productcode);
    end if;

    if l_code = 0 then
        if l_nd is null then
           begin
              l_first_name := trim(f_translate_kmu(l_epp.first_name));
              l_count := length(l_first_name);
              if (instr(l_epp.last_name,'-') > 0) then
                 l_last_name := trim(f_translate_kmu(substr(l_epp.last_name, 1, instr(l_epp.last_name,'-') - 1)));
              elsif (instr(l_epp.last_name,' ') > 0) then
                 l_last_name := trim(f_translate_kmu(substr(l_epp.last_name, 1, instr(l_epp.last_name,' ') - 1)));
              else
                 l_last_name := trim(f_translate_kmu(l_epp.last_name));
              end if;
              if (l_count + length(l_last_name) > 24) then
                 l_last_name := substr(l_last_name, 1, 24 - l_count);
              end if;
              bars_ow.open_card(p_rnk          => l_rnk,
                                p_nls          => null,
                                p_cardcode     => case when l_epp.type_pens = 1 then 'PENS_SOC_MIGRANT_NSMEP'
                                                       when l_epp.type_pens = 2 then 'PENS_ARSL_MIGRANT_NSMEP'
                                                       else 'PENS_SOC_MIGRANT_NSMEP' end,
                                p_branch       => l_epp.branch,
                                p_embfirstname => l_first_name,
                                p_emblastname  => l_last_name,
                                p_secname      => l_epp.last_name,
                                p_work         => null,
                                p_office       => null,
                                p_wdate        => null,
                                p_salaryproect => null,
                                p_term         => null,
                                p_branchissue  => l_epp.branch,
                                p_nd           => l_nd,
                                p_reqid        => l_reqid);
              update accounts
                 set nbs  = null,
                     dazs = bankdate
               where acc = (select acc_pk from w4_acc where nd = l_nd)
              returning nls into l_nls;

              update pfu_epp_line_processing pelp
                 set pelp.reqid = l_reqid
               where pelp.epp_number = l_epp.epp_number;

              l_epp.nls := l_nls;

             exception
               when others then
                 l_epp.message := 'Помилка відкриття картки: ' ||
                                  dbms_utility.format_error_stack() ||
                                  chr(10) ||
                                  dbms_utility.format_error_backtrace();
                    l_code := 5;
                end;
        else
            begin
              if (l_productcode = 'PENS_SOC_MIGRANT') and (l_cardcode != 'PENS_SOC_MIGRANT_NSMEP') then
                 update w4_acc w
                    set w.card_code = 'PENS_SOC_MIGRANT_NSMEP'
                  where w.nd = l_nd;
              elsif (l_productcode = 'PENS_ARSL_MIGRANT') and (l_cardcode != 'PENS_ARSL_MIGRANT_NSMEP') then
                 update w4_acc w
                    set w.card_code = 'PENS_ARSL_MIGRANT_NSMEP'
                  where w.nd = l_nd;
              end if;
              get_nls_maxterm(l_nd, l_epp.nls, l_term);

              bars_ow.set_term(p_nd   => l_nd,
                               p_bdat => trunc(sysdate),
                               p_term => l_term);
              l_cmclient := bars_ow.f_add_deal_to_cmque(p_nd => l_nd,
                                                        p_opertype => 9);
              update cm_client_que t
                 set t.delivery_br = l_epp.branch
               where t.id = l_cmclient.id;

              update pfu_epp_line_processing pelp
                 set pelp.reqid = l_cmclient.id
               where pelp.epp_number = l_epp.epp_number;

              exception
                when others then
                l_epp.message := 'Помилка перевипуску картки: ' ||
                                 dbms_utility.format_error_stack() ||
                                 chr(10) ||
                                 dbms_utility.format_error_backtrace();
                l_code := 6;
            end;
        end if;
    end if;

    if l_code in (0, 1) then
      update pfu_epp_line_processing t
         set t.state_id = 20,
             t.message  = 'Створено заявку на випуск ЕПП',
             t.nls      = l_epp.nls
       where t.id = l_epp.id;
    else
      if l_code = 2 then
        l_epp.message := 'Не співпадає серія та номер документа з існуючим клієнтом РНК(' ||
                            l_rnk || ')';
        l_state := 11;
      elsif l_code = 3 then
        l_epp.message := 'Не співпадає дата народження з існуючим клієнтом РНК(' ||
                            l_rnk || ')';
        l_state := 12;
      elsif l_code = 4 then

        l_state := 13;
      elsif l_code = 5 then
        l_state := 14;
      elsif l_code = 6 then
        l_state := 15;
      end if;
      update pfu_epp_line_processing t
         set t.state_id = l_state,
             t.message  = l_epp.message
       where t.id = l_epp.id;
    end if;
  end;

  function get_line_buffer(
      p_line_row in pfu_epp_line_processing%rowtype)
  return varchar2
  is
  begin
     return lpad(p_line_row.id                               ,           10, '0') ||
            rpad(nvl(p_line_row.epp_number             , ' '),                12) ||
            rpad(nvl(to_char(p_line_row.epp_expiry_date,'ddmmyyyy'), ' '),     8) ||
            rpad(nvl(p_line_row.person_record_number   , ' '),                10) ||
            rpad(nvl(p_line_row.last_name              , ' '),                70) ||
            rpad(nvl(p_line_row.first_name             , ' '),                50) ||
            rpad(nvl(p_line_row.middle_name            , ' '),                50) ||
            rpad(nvl(to_char(p_line_row.gender)        , ' '),                 1) ||
            rpad(nvl(to_char(p_line_row.date_of_birth,'ddmmyyyy'), ' '),       8) ||
            rpad(nvl(p_line_row.phone_numbers          , ' '),                30) ||
            rpad(nvl(p_line_row.embossing_name         , ' '),               172) ||
            rpad(nvl(p_line_row.tax_registration_number, ' '),                10) ||
            rpad(nvl(to_char(p_line_row.document_type) , ' '),                 2) ||
            rpad(nvl(p_line_row.document_id            , ' '),                10) ||
            rpad(nvl(to_char(p_line_row.document_issue_date,'ddmmyyyy'), ' '), 8) ||
            rpad(nvl(p_line_row.document_issuer        , ' '),               100) ||
            rpad(nvl(to_char(p_line_row.displaced_person_flag), ' '),          1) ||
            rpad(nvl(p_line_row.legal_country          , ' '),                50) ||
            rpad(nvl(p_line_row.legal_zip_code         , ' '),                 6) ||
            rpad(nvl(p_line_row.legal_region           , ' '),                50) ||
            rpad(nvl(p_line_row.legal_district         , ' '),               100) ||
            rpad(nvl(p_line_row.legal_settlement       , ' '),               100) ||
            rpad(nvl(p_line_row.legal_street           , ' '),               100) ||
            rpad(nvl(p_line_row.legal_house            , ' '),                 5) ||
            rpad(nvl(p_line_row.legal_house_part       , ' '),                 2) ||
            rpad(nvl(p_line_row.legal_apartment        , ' '),                 5) ||
            rpad(nvl(p_line_row.actual_country         , ' '),                50) ||
            rpad(nvl(p_line_row.actual_zip_code        , ' '),                 6) ||
            rpad(nvl(p_line_row.actual_region          , ' '),                50) ||
            rpad(nvl(p_line_row.actual_district        , ' '),               100) ||
            rpad(nvl(p_line_row.actual_settlement      , ' '),               100) ||
            rpad(nvl(p_line_row.actual_street          , ' '),               100) ||
            rpad(nvl(p_line_row.actual_house           , ' '),                 5) ||
            rpad(nvl(p_line_row.actual_house_part      , ' '),                 2) ||
            rpad(nvl(p_line_row.actual_apartment       , ' '),                 5) ||
            rpad(nvl(p_line_row.bank_mfo               , ' '),                 6) ||
            rpad(nvl(p_line_row.bank_num               , ' '),                30) ||
            rpad(nvl(p_line_row.bank_name              , ' '),               100) ||
            rpad(nvl(p_line_row.branch                 , ' '),                30) ||
            rpad(nvl(p_line_row.type_pens              , ' '),                 1);
  end;

  function get_epp_receipt(p_fileid in number) return clob is
    l_clob              clob;
    l_domdoc            dbms_xmldom.domdocument;
    l_root_node         dbms_xmldom.domnode;

    l_supp_element dbms_xmldom.domelement;

    l_supp_node    dbms_xmldom.domnode;

    l_supp_tnode   dbms_xmldom.domnode;

    l_supp_text    dbms_xmldom.domtext;

    l_supplier_element  dbms_xmldom.domelement;
    l_supplier_node     dbms_xmldom.domnode;
    l_sup_node          dbms_xmldom.domnode;
    l_suppp_node         dbms_xmldom.domnode;

  begin

    dbms_lob.createtemporary(l_clob, true, 12);
    -- Create an empty XML document
    l_domdoc := dbms_xmldom.newdomdocument;

    -- Create a root node
    l_root_node := dbms_xmldom.makenode(l_domdoc);

    -- Create a new Supplier Node and add it to the root node
    l_sup_node := dbms_xmldom.appendchild(l_root_node,
                                          dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
                                                                                         'root')));
    l_suppp_node := dbms_xmldom.appendchild(l_sup_node,
                                          dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
                                                                                         'body')));


    for sup_rec in (select t.id, t.nls, cq.card_type, cq.cntm, cq.rnk, t.state_id, t.message
                      from pfu_epp_line_processing t
                      join pfu_ca_files p on t.file_id = p.id and p.state = 10
                      left join cm_client_que cq on cq.id = t.reqid
                      where t.file_id = p_fileid )
    loop

      -- For each record, create a new Supplier element
      -- and add this new Supplier element to the Supplier Parent node
      l_supplier_element := dbms_xmldom.createelement(l_domdoc, 'row');
      l_supplier_node    := dbms_xmldom.appendchild(l_suppp_node,
                                                    dbms_xmldom.makenode(l_supplier_element));

      -- Each Supplier node will get a Number node which contains the Supplier Number as text
      l_supp_element := dbms_xmldom.createelement(l_domdoc,
                                                       'id');
      l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                     dbms_xmldom.makenode(l_supp_element));
      l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
                                                        sup_rec.id);
      l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                                     dbms_xmldom.makenode(l_supp_text));

      l_supp_element := dbms_xmldom.createelement(l_domdoc,
                                                       'nls');
      l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                     dbms_xmldom.makenode(l_supp_element));
      l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
                                                        sup_rec.nls);
      l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                                     dbms_xmldom.makenode(l_supp_text));

      l_supp_element := dbms_xmldom.createelement(l_domdoc,
                                                       'card_type');
      l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                     dbms_xmldom.makenode(l_supp_element));
      l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
                                                        sup_rec.card_type);
      l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                                     dbms_xmldom.makenode(l_supp_text));

      l_supp_element := dbms_xmldom.createelement(l_domdoc,
                                                       'cntm');
      l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                     dbms_xmldom.makenode(l_supp_element));
      l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
                                                        sup_rec.cntm);
      l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                                     dbms_xmldom.makenode(l_supp_text));

      l_supp_element := dbms_xmldom.createelement(l_domdoc,
                                                       'rnk');
      l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                     dbms_xmldom.makenode(l_supp_element));
      l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
                                                        sup_rec.rnk);
      l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                                     dbms_xmldom.makenode(l_supp_text));

      l_supp_element := dbms_xmldom.createelement(l_domdoc,
                                                       'state_id');
      l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                     dbms_xmldom.makenode(l_supp_element));
      l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
                                                        sup_rec.state_id);
      l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                                     dbms_xmldom.makenode(l_supp_text));

      l_supp_element := dbms_xmldom.createelement(l_domdoc,
                                                       'message');
      l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                     dbms_xmldom.makenode(l_supp_element));
      l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
                                                        sup_rec.message);
      l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                                     dbms_xmldom.makenode(l_supp_text));

    end loop;

    dbms_xmldom.writetoclob(l_domdoc, l_clob);
    dbms_xmldom.freedocument(l_domdoc);
    return l_clob;
  exception
    when others then
      return l_clob;
  end;

  procedure epp_processing(p_file_data in clob, p_fileid in number) is
    l_parser dbms_xmlparser.parser;
    l_doc    dbms_xmldom.domdocument;
    l_rows   dbms_xmldom.domnodelist;
    l_row    dbms_xmldom.domnode;

    l_fileheader dbms_xmldom.domnodelist;
    l_header     dbms_xmldom.domnode;
    l_epp_lines  t_epp;
    l_src       clob;
    l_tmp varchar2(256);
    l_filesign raw(128);
    l_clob clob;
  begin
    dbms_lob.createtemporary(l_src, true);

    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, p_file_data);
    l_doc  := dbms_xmlparser.getdocument(l_parser);

    l_fileheader := dbms_xmldom.getelementsbytagname(l_doc, 'header');
    l_header     := dbms_xmldom.item(l_fileheader, 0);

    l_tmp := dbms_xslprocessor.valueof(l_header, 'sign/text()');
    l_filesign := l_tmp;

    l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'client');

    for i in 0..dbms_xmldom.getlength(l_rows) - 1 loop

        l_row := dbms_xmldom.item(l_rows, i);
        l_epp_lines(i).id                      := to_number(dbms_xslprocessor.valueof(l_row, 'id/text()'));
        l_epp_lines(i).file_id                 := p_fileid;
        l_epp_lines(i).epp_number              := substr(dbms_xslprocessor.valueof(l_row, 'epp_number/text()'),1,12);
        l_epp_lines(i).person_record_number    := substr(dbms_xslprocessor.valueof(l_row, 'person_record_number/text()'),1,10);
        l_epp_lines(i).last_name               := substr(dbms_xslprocessor.valueof(l_row, 'last_name/text()'),1,70);
        l_epp_lines(i).first_name              := substr(dbms_xslprocessor.valueof(l_row, 'first_name/text()'),1,50);
        l_epp_lines(i).middle_name             := substr(dbms_xslprocessor.valueof(l_row, 'middle_name/text()'),1,50);
        l_epp_lines(i).gender                  := dbms_xslprocessor.valueof(l_row, 'gender/text()');
        l_epp_lines(i).date_of_birth           := to_date(dbms_xslprocessor.valueof(l_row, 'date_of_birth/text()'),'dd.mm.yyyy');
        l_epp_lines(i).phone_numbers           := substr(dbms_xslprocessor.valueof(l_row, 'phone_numbers/text()'),1,30);
        l_epp_lines(i).embossing_name          := substr(dbms_xslprocessor.valueof(l_row, 'embossing_name/text()'),1,172);
        l_epp_lines(i).tax_registration_number := substr(dbms_xslprocessor.valueof(l_row, 'tax_registration_number/text()'),1,10);
        l_epp_lines(i).document_type           := to_number(dbms_xslprocessor.valueof(l_row, 'document_type/text()'));
        l_epp_lines(i).document_id             := substr(dbms_xslprocessor.valueof(l_row, 'document_id/text()'),1,10);
        l_epp_lines(i).document_issue_date     := to_date(dbms_xslprocessor.valueof(l_row, 'document_issue_date/text()'),'dd.mm.yyyy');
        l_epp_lines(i).document_issuer         := substr(dbms_xslprocessor.valueof(l_row, 'document_issuer/text()'),1,100);
        l_epp_lines(i).displaced_person_flag   := to_number(dbms_xslprocessor.valueof(l_row, 'displaced_person_flag/text()'));
        l_epp_lines(i).bank_mfo                := substr(dbms_xslprocessor.valueof(l_row, 'bank_mfo/text()'),1,6);
        l_epp_lines(i).bank_num                := substr(dbms_xslprocessor.valueof(l_row, 'bank_num/text()'),1,10);
        l_epp_lines(i).bank_name               := substr(dbms_xslprocessor.valueof(l_row, 'bank_name/text()'),1,100);
        l_epp_lines(i).branch                  := substr(dbms_xslprocessor.valueof(l_row, 'branch/text()'),1,30);
        l_epp_lines(i).type_pens               := dbms_xslprocessor.valueof(l_row, 'pens_type/text()');
        l_epp_lines(i).epp_expiry_date         := to_date(dbms_xslprocessor.valueof(l_row, 'date_andpp/text()'),'dd.mm.yyyy');
        l_epp_lines(i).legal_country           := substr(dbms_xslprocessor.valueof(l_row, 'legal_country/text()'),1,50);
        l_epp_lines(i).legal_zip_code          := substr(dbms_xslprocessor.valueof(l_row, 'legal_zip_code/text()'),1,6);
        l_epp_lines(i).legal_region            := substr(dbms_xslprocessor.valueof(l_row, 'legal_region/text()'),1,50);
        l_epp_lines(i).legal_district          := substr(dbms_xslprocessor.valueof(l_row, 'legal_district/text()'),1,100);
        l_epp_lines(i).legal_settlement        := substr(dbms_xslprocessor.valueof(l_row, 'legal_settlement/text()'),1,100);
        l_epp_lines(i).legal_street            := substr(dbms_xslprocessor.valueof(l_row, 'legal_street/text()'),1,100);
        l_epp_lines(i).legal_house             := substr(dbms_xslprocessor.valueof(l_row, 'legal_house/text()'),1,5);
        l_epp_lines(i).legal_house_part        := substr(dbms_xslprocessor.valueof(l_row, 'legal_house_part/text()'),1,2);
        l_epp_lines(i).legal_apartment         := substr(dbms_xslprocessor.valueof(l_row, 'legal_apartment/text()'),1,5);
        l_epp_lines(i).actual_country          := substr(dbms_xslprocessor.valueof(l_row, 'actual_country/text()'),1,50);
        l_epp_lines(i).actual_zip_code         := substr(dbms_xslprocessor.valueof(l_row, 'actual_zip_code/text()'),1,6);
        l_epp_lines(i).actual_region           := substr(dbms_xslprocessor.valueof(l_row, 'actual_region/text()'),1,50);
        l_epp_lines(i).actual_district         := substr(dbms_xslprocessor.valueof(l_row, 'actual_district/text()'),1,100);
        l_epp_lines(i).actual_settlement       := substr(dbms_xslprocessor.valueof(l_row, 'actual_settlement/text()'),1,100);
        l_epp_lines(i).actual_street           := substr(dbms_xslprocessor.valueof(l_row, 'actual_street/text()'),1,100);
        l_epp_lines(i).actual_house            := substr(dbms_xslprocessor.valueof(l_row, 'actual_house/text()'),1,5);
        l_epp_lines(i).actual_house_part       := substr(dbms_xslprocessor.valueof(l_row, 'actual_house_part/text()'),1,2);
        l_epp_lines(i).actual_apartment        := substr(dbms_xslprocessor.valueof(l_row, 'actual_apartment/text()'),1,5);
        l_tmp                                  := substr(dbms_xslprocessor.valueof(l_row, 'sign/text()'),1,128);
        l_epp_lines(i).sign                    := l_tmp;

       /*if crypto_utl.check_mac_sh1(p_src  => get_line_buffer(l_epp_lines(i)),
                                    p_key  => crypto_utl.get_key_value(sysdate, g_keytype),
                                    p_sign => l_tmp) then*/
          l_epp_lines(i).state_id := 2;
          l_epp_lines(i).message := 'Цифровий підпис пройшов перевірку';
    /*    else
          l_epp_lines(i).state_id := 1;
          l_epp_lines(i).message := 'Цифровий підпис не пройшов перевірку';
        end if;
*/
        dbms_lob.append(l_src, nvl(l_tmp, lpad('0',128 , '0' )));
    end loop;

    dbms_xmlparser.freeparser(l_parser);
    dbms_xmldom.freedocument(l_doc);

   -- if l_filesign is null or crypto_utl.check_mac_sh1(p_src => l_src, p_key => crypto_utl.get_key_value(sysdate, g_keytype) , p_sign => l_filesign) then

      set_file_state(p_fileid, 2, 'Цифровий підпис пройшов перевірку');

      forall k in indices of l_epp_lines
        insert into pfu_epp_line_processing values l_epp_lines(k);

      create_epp(p_fileid);

      set_file_state(p_fileid, 10, 'Заявки на випуск карт сформовано');

      l_clob := get_epp_receipt(p_fileid);

      if l_clob is not null then
        set_file_state(p_fileid, 20, 'Квитанцію сформовано', l_clob);
      end if;
/*   else
      set_file_state(p_fileid, 1, 'Цифровий підпис не пройшов перевірку');
    end if;
*/
  end;

  function get_issue_receipt(p_id_list in number_list) return clob is
    l_clob      clob;
    l_domdoc    dbms_xmldom.domdocument;
    l_root_node dbms_xmldom.domnode;

    l_supp_element dbms_xmldom.domelement;

    l_supp_node dbms_xmldom.domnode;

    l_supp_tnode dbms_xmldom.domnode;

    l_supp_text dbms_xmldom.domtext;

    l_supplier_element dbms_xmldom.domelement;
    l_supplier_node    dbms_xmldom.domnode;
    l_sup_node         dbms_xmldom.domnode;
    l_suppp_node       dbms_xmldom.domnode;

  begin

    dbms_lob.createtemporary(l_clob, true, 12);
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

    for sup_rec in (select p.id,
                           case nvl(c.oper_status, 100)
                             when 2 then
                              21
                             when 10 then
                              22
                             when 3 then
                              30
                             when 100 then
                              30
                           end state_id,
                           case nvl(c.oper_status, 100)
                             when 2 then
                              'Заявка на випуск карти в обробці'
                             when 10 then
                              'Помилка при обробці: ' || c.resp_txt
                             when 3 then
                              'Заявку оброблено успішно'
                             when 100 then
                              'Заявку оброблено успішно'
                           end message
                      from table(p_id_list) t
                      join pfu_epp_line_processing p
                        on value(t) = p.id
                      join accounts a
                        on p.nls = a.nls
                      left join cm_client_que c
                        on c.acc = a.acc and c.oper_type in (1, 5, 9) and
                           c.card_br_iss = p.epp_number)
    loop

      -- For each record, create a new Supplier element
      -- and add this new Supplier element to the Supplier Parent node
      l_supplier_element := dbms_xmldom.createelement(l_domdoc, 'row');
      l_supplier_node    := dbms_xmldom.appendchild(l_suppp_node,
                                                    dbms_xmldom.makenode(l_supplier_element));

      -- Each Supplier node will get a Number node which contains the Supplier Number as text
      l_supp_element := dbms_xmldom.createelement(l_domdoc, 'id');
      l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                dbms_xmldom.makenode(l_supp_element));
      l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, sup_rec.id);
      l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                                dbms_xmldom.makenode(l_supp_text));

      l_supp_element := dbms_xmldom.createelement(l_domdoc, 'state_id');
      l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                dbms_xmldom.makenode(l_supp_element));
      l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
                                                   sup_rec.state_id);
      l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,

                                                dbms_xmldom.makenode(l_supp_text));

      l_supp_element := dbms_xmldom.createelement(l_domdoc, 'message');
      l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                dbms_xmldom.makenode(l_supp_element));
      l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
                                                   sup_rec.message);
      l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                                dbms_xmldom.makenode(l_supp_text));

    end loop;

    dbms_xmldom.writetoclob(l_domdoc, l_clob);
    dbms_xmldom.freedocument(l_domdoc);
    return l_clob;
  exception
    when others then
      return l_clob;
  end;

  procedure issuecard_processing(p_file_data in clob,
                                 p_fileid    in number) is
    l_parser  dbms_xmlparser.parser;
    l_doc     dbms_xmldom.domdocument;
    l_rows    dbms_xmldom.domnodelist;
    l_row     dbms_xmldom.domnode;
    l_id_list number_list := number_list();
    l_clob    clob;
  begin

    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, p_file_data);
    l_doc := dbms_xmlparser.getdocument(l_parser);

    l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'row');
    for i in 0 .. dbms_xmldom.getlength(l_rows) - 1
    loop
      l_row := dbms_xmldom.item(l_rows, i);
      l_id_list.extend;
      l_id_list(l_id_list.last) := to_number(dbms_xslprocessor.valueof(l_row,
                                                                       'id/text()'));
    end loop;

    set_file_state(p_fileid, 10, 'Файл оброблено');
    l_clob := get_issue_receipt(l_id_list);
    if l_clob is not null then
      set_file_state(p_fileid, 20, 'Квитанцію сформовано', l_clob);
    end if;
    dbms_xmlparser.freeparser(l_parser);
    dbms_xmldom.freedocument(l_doc);

  end;

  function get_activate_receipt(p_accreclist in t_accreclist) return clob is
    l_clob      clob;
    l_domdoc    dbms_xmldom.domdocument;
    l_root_node dbms_xmldom.domnode;

    l_supp_element dbms_xmldom.domelement;

    l_supp_node dbms_xmldom.domnode;

    l_supp_tnode dbms_xmldom.domnode;

    l_supp_text dbms_xmldom.domtext;

    l_supplier_element dbms_xmldom.domelement;
    l_supplier_node    dbms_xmldom.domnode;
    l_sup_node         dbms_xmldom.domnode;
    l_suppp_node       dbms_xmldom.domnode;

  begin

    dbms_lob.createtemporary(l_clob, true, 12);
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

    for i in p_accreclist.first .. p_accreclist.last
    loop

      -- For each record, create a new Supplier element
      -- and add this new Supplier element to the Supplier Parent node
      l_supplier_element := dbms_xmldom.createelement(l_domdoc, 'row');
      l_supplier_node    := dbms_xmldom.appendchild(l_suppp_node,
                                                    dbms_xmldom.makenode(l_supplier_element));

      -- Each Supplier node will get a Number node which contains the Supplier Number as text
      l_supp_element := dbms_xmldom.createelement(l_domdoc, 'id');
      l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                dbms_xmldom.makenode(l_supp_element));
      l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, p_accreclist(i).id);
      l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                                dbms_xmldom.makenode(l_supp_text));

      l_supp_element := dbms_xmldom.createelement(l_domdoc, 'state_id');
      l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                dbms_xmldom.makenode(l_supp_element));
      l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
                                                   p_accreclist(i).state_id);
      l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                                dbms_xmldom.makenode(l_supp_text));

      l_supp_element := dbms_xmldom.createelement(l_domdoc, 'message');
      l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                dbms_xmldom.makenode(l_supp_element));
      l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,
                                                   p_accreclist(i).message);
      l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                                dbms_xmldom.makenode(l_supp_text));

    end loop;

    dbms_xmldom.writetoclob(l_domdoc, l_clob);
    dbms_xmldom.freedocument(l_domdoc);
    return l_clob;
  exception
    when others then
      return l_clob;
  end;

  function activate_accs(p_acc_list in number_list) return t_accreclist is
    l_accreclist t_accreclist := t_accreclist();
  begin
    for i in (select value(t) f_id, p.*, a.acc
                from table(p_acc_list) t
                join pfu_epp_line_processing p
                  on value(t) = p.id
                join accounts a
                  on p.nls = a.nls)
    loop
      l_accreclist.extend;
      begin
        update accounts
           set daos = decode(dapp, null, bankdate, daos),
               dazs = null,
               nbs  = '2625'
         where acc = i.acc and dazs is not null;

        l_accreclist(l_accreclist.last).id := i.f_id;
        l_accreclist(l_accreclist.last).state_id := 30;
        l_accreclist(l_accreclist.last).message := case
                                                     when sql%rowcount > 0 then
                                                      'Рахунок активовано'
                                                     when sql%rowcount = 0 then
                                                      'Рахунок уже активовано'
                                                   end;

      exception
        when others then
          l_accreclist(l_accreclist.last).id := i.f_id;
          l_accreclist(l_accreclist.last).state_id := 29;
          l_accreclist(l_accreclist.last).message := 'Помилка при активації рахунку' ||
                                                     sqlerrm;
      end;
    end loop;

    forall k in l_accreclist.first .. l_accreclist.last
     update pfu_epp_line_processing t
         set t.state_id = l_accreclist(k).state_id,
             t.message  = l_accreclist(k).message
    where t.id = l_accreclist(k).id;

    return l_accreclist;
  end;


  procedure activateacc_procesing(p_file_data in clob, p_fileid in number) is
    l_parser  dbms_xmlparser.parser;
    l_doc     dbms_xmldom.domdocument;
    l_rows    dbms_xmldom.domnodelist;
    l_row     dbms_xmldom.domnode;
    l_id_list number_list := number_list();
    l_clob    clob;
    l_accreclist t_accreclist ;
  begin

    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, p_file_data);
    l_doc := dbms_xmlparser.getdocument(l_parser);

    l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'id');
    for i in 0 .. dbms_xmldom.getlength(l_rows) - 1
    loop
      l_row := dbms_xmldom.item(l_rows, i);
      l_id_list.extend;
      l_id_list(l_id_list.last) := to_number(dbms_xslprocessor.valueof(l_row,
                                                                       'text()'));
    end loop;

    l_accreclist := activate_accs(l_id_list);

    set_file_state(p_fileid, 10, 'Файл оброблено');
    l_clob := get_activate_receipt(l_accreclist);

    if l_clob is not null then
      set_file_state(p_fileid, 20, 'Квитанцію сформовано', l_clob);
    end if;
    dbms_xmlparser.freeparser(l_parser);
    dbms_xmldom.freedocument(l_doc);

  end;

  procedure pfu_files_processing is
    l_kf pfu_ca_files.kf%type;
  begin
    for i in (select *
                from pfu_ca_files t
               where t.state = 0
               order by t.kf
                 for update skip locked) loop
      begin
      if (l_kf is not null and l_kf != i.kf) or (l_kf is null) then
        l_kf := i.kf;
        bars.bc.go(i.kf);
        bars_ow.ow_init;
      end if;
      if i.file_type = 1 then
        epp_processing(i.file_data, i.id);
      elsif i.file_type = 2 then
        issuecard_processing(i.file_data, i.id);
      elsif i.file_type = 3 then
        activateacc_procesing(i.file_data, i.id);
      elsif i.file_type in ( 4, 13) then
        pfu_ru_file_utl.ref_state_processing(i.file_data, i.id);
      elsif i.file_type = 5 then
        pfu_ru_file_utl.get_ebp_processing(i.file_data, i.id);
      elsif i.file_type = 6 then
        pfu_ru_file_utl.get_create_paym_processing(i.file_data, i.id);
      elsif i.file_type = 7 then
        pfu_ru_file_utl.get_cardkill_processing(i.file_data, i.id);
      elsif i.file_type = 8 then
        pfu_ru_file_utl.get_cm_error_processing(i.file_data, i.id);
      elsif i.file_type = 9 then
        pfu_ru_file_utl.get_acc_rest_processing(i.file_data, i.id);
      elsif i.file_type = 10 then
        pfu_ru_file_utl.get_epp_state_processing(i.file_data, i.id);
      elsif i.file_type = 11 then
        pfu_ru_file_utl.get_restart_epp_processing(i.file_data, i.id);
      elsif i.file_type = 12 then
        pfu_ru_file_utl.get_branch_processing(i.file_data, i.id); 
      elsif i.file_type = 14 then
        pfu_ru_file_utl.get_report_processing(i.file_data, i.id);
      elsif i.file_type = 15 then
 	pfu_ru_file_utl.set_card_block_processing(i.file_data, i.id);
      elsif i.file_type = 16 then
        pfu_ru_file_utl.set_destruct_processing(i.file_data, i.id);
      elsif i.file_type = 17 then
 	pfu_ru_file_utl.set_card_unblock_processing(i.file_data, i.id);
      else
        set_file_state(i.id, 99, 'Невірний тип файлу');
      end if;
      exception
        when others then
          set_file_state(i.id,
                         98,
                         'Помилка при обробці файлу' ||
                         dbms_utility.format_error_stack() || chr(10) ||
                         dbms_utility.format_error_backtrace());
      end;
    end loop;
  end;

  procedure cm_error_process is
  begin
    for c0 in (select cc.*
                 from v_cm_client cc
                inner join pfu_epp_line_processing elp on cc.id = elp.reqid
                where elp.state_id in (20,21)
                  and cc.datemod = (select max(cc1.datemod)
                                      from v_cm_client cc1
                                     where cc1.id = cc.id)) loop
      update pfu_epp_line_processing pelp
         set pelp.state_id = case c0.oper_status when 2
                                                 then 21
                                                 when 3
                                                 then 22
                                                 when 10
                                                 then 23
                             end
       where pelp.reqid = c0.id;
   end loop;
end;

end;
/
 show err;
 
PROMPT *** Create  grants  PFU_RU_EPP_UTL ***
grant EXECUTE                                                                on PFU_RU_EPP_UTL  to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/pfu_ru_epp_utl.sql =========*** End 
 PROMPT ===================================================================================== 
 
