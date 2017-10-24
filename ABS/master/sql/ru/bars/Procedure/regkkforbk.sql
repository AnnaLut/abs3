

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/REGKKFORBK.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure REGKKFORBK ***

  CREATE OR REPLACE PROCEDURE BARS.REGKKFORBK (p_surname   in varchar2, --1. Прізвище
                                       p_name      in varchar2, --2. Ім’я
                                       p_fname     in varchar2, --3. По-батькові
                                       p_latname   in varchar2, --4. Ім’я та прізвище латиною
                                       p_password  in varchar2, --5. Слово-пароль
                                       p_sex       in integer, --6. Стать
                                       p_birthdate in date, --7. Дата народження
                                       p_series    in varchar2, --8. Серія документа
                                       p_num       in varchar2, --9. № документа
                                       p_issdate   in date, --10. Дата видачі документу
                                       p_issuer    in varchar2, --11. Ким виданий документ
                                       p_identcode in varchar2, --12. ІНН

                                       p_region    in varchar2, --14. Область проживання
                                       p_area      in varchar2, --15. Район проживання
                                       p_city      in varchar2, --16. Місто проживання
                                       p_address   in varchar2, --17. Адреса проживання
                                       p_house     in varchar2, --18. Номер будинку (та квартири)
                                       p_zipcode   in varchar2, --19. Поштовий індекс
                                       p_phone     in varchar2, --20. Номер стаціонарного телефону
                                       p_mphone    in varchar2, --21. Номер мобільного телефону
                                       p_email     in varchar2, --22 Адреса e-mail
                                       p_typedoc   in integer, --23. Код типу документу
                                       p_photodata in blob, --Фотокартка
                                       p_branch    in varchar2,
                                       p_card_code in varchar2,
                                       p_is_social in number,
                                       p_errcode   out number,
                                       p_errmsg    out varchar2,
                                       p_rnk       in out number,
                                       p_nls       out varchar2) is

  /* p_errcode = 0 - ОК
  *             1 - Знайдено по ІНН, не співпадає серія та номер документа
  *             2 - Знайдено по ІНН чи документі, не співпадає дата народження
  *             3 - Помилка при відкриті клієнта: текст помилки
  *             4 - Помилка при відкриті картки: текст помилки
  *            99 - Технічна помилка
  *
  */
  l_code      number;
  l_nd        number;
  l_card_code varchar2(100) := p_card_code;
  l_nls       accounts.nls%type;
  l_w4kkw     number;
  l_w4kkr     number;
  l_w4kka     number;
  l_w4kkt     number;
  l_w4kks     number;
  l_w4kkb     number;
  l_w4kkz     number;
  l_k013      number;
  l_acc       number;
  l_reqid     number;

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
       where c.date_off is null and
             ((p_typedoc = 1 and p.passp = 1 and c.custtype = 3 and
             ((p.ser = p_paspser and p.numdoc = p_paspnum and
             p.rnk = c.rnk and nvl(trim(c.sed), '00') = '00') or
             (p.ser = p_paspser and p.numdoc = p_paspnum and
             p.rnk = c.rnk and nvl(trim(c.sed), '00') = '00' and
             p.bday = p_bdate))) or
             (p_typedoc = 3 and p.passp = 7 and c.custtype = 3 and
             ((p.numdoc = p_paspnum and p.rnk = c.rnk and
             nvl(trim(c.sed), '00') = '00') or
             (p.numdoc = p_paspnum and p.rnk = c.rnk and
             nvl(trim(c.sed), '00') = '00' and p.bday = p_bdate))));
      if l_count_passp > 0 and l_count_passpd > 0 then
        select rnk
          into l_irnk
          from(
               select c.rnk, row_number() over(order by v.rnk desc nulls last, c.rnk desc) rn
                 from customer c, person p, v_cm_client v
                where c.date_off is null and c.rnk = v.rnk(+) and v.oper_status(+) in (1, 2, 3) and
                      ((p_typedoc = 1 and p.passp = 1 and c.custtype = 3 and
               p.ser = p_paspser and p.numdoc = p_paspnum and
               p.rnk = c.rnk and nvl(trim(c.sed), '00') = '00' and
               p.bday = p_bdate) or
               (p_typedoc = 3 and p.passp = 7 and c.custtype = 3 and
               p.numdoc = p_paspnum and p.rnk = c.rnk and
                      nvl(trim(c.sed), '00') = '00' and p.bday = p_bdate)))
         where rn = 1;
        p_code := 1;
      else
        if l_count_passp > 0 and l_count_passpd = 0 then
          p_code := 3;
        else
          p_code := 0;
        end if;
      end if;
    else

      -- ищем клиентов с ОКПО
      select count(*)
        into l_count_okpo
        from customer c, person p
       where c.rnk = p.rnk and c.okpo = p_okpo and c.custtype = 3 and
             nvl(trim(c.sed), '00') = '00' and c.date_off is null ;

      -- есть клиенты с ОКПО и паспортными данными
      if l_count_okpo = 0 then
        p_code := 0;
      else
        select count(*)
          into l_count_okpo
          from customer c, person p
         where c.rnk = p.rnk and c.date_off is null and c.okpo = p_okpo and c.custtype = 3 and
               nvl(trim(c.sed), '00') = '00' and
               ((p_typedoc = 1 and p.passp = 1 and p.ser = p_paspser and
               p.numdoc = p_paspnum) or
               (p_typedoc = 3 and p.passp = 7 and p.numdoc = p_paspnum));
        if l_count_okpo = 0 then
          p_code := 2;
        else
          select count(*)
            into l_count_okpo
            from customer c, person p
           where c.rnk = p.rnk and c.date_off is null and
                 c.okpo = p_okpo and c.custtype = 3 and
                 p.bday = p_bdate and nvl(trim(c.sed), '00') = '00' and
                 ((p_typedoc = 1 and p.passp = 1 and p.ser = p_paspser and
                 p.numdoc = p_paspnum) or
                 (p_typedoc = 3 and p.passp = 7 and p.numdoc = p_paspnum));
          if l_count_okpo = 0 then
            p_code := 3;
          else
            select rnk
              into p_rnk
              from(
                   select c.rnk, row_number() over(order by v.rnk desc nulls last, c.rnk desc) rn
                     from customer c, person p, v_cm_client v
                    where c.rnk = p.rnk and c.date_off is null and c.rnk = v.rnk(+) and v.oper_status(+) in (1, 2, 3) and
                          c.okpo = p_okpo and c.custtype = 3 and
                   p.bday = p_bdate and nvl(trim(c.sed), '00') = '00' and
                   ((p_typedoc = 1 and p.passp = 1 and p.ser = p_paspser and
                   p.numdoc = p_paspnum) or
                          (p_typedoc = 3 and p.passp = 7 and p.numdoc = p_paspnum)))
             where rn = 1;
          end if;
        end if;
      end if;
    end if;

    return l_irnk;

  end;
  procedure create_customer is
    l_nmk  varchar2(70);
    l_nmkv varchar2(70);
    l_nmkk varchar2(38);
    l_adr  varchar2(70);
  begin

    -- LastName - фамилия, FirstName - имя
    l_nmk  := substr(trim(p_surname || ' ' || p_name || ' ' || p_fname),
                     1,
                     70);
    l_nmkv := substr(f_translate_kmu(trim(l_nmk)), 1, 70);
    l_nmkk := substr(p_surname || ' ' || p_name, 1, 38);

    select substr(trim(p_region) ||
                   nvl2(trim(p_area), ' ' || trim(p_area), '') ||
                   nvl2(trim(p_city), ' ' || trim(p_city), '') ||
                   nvl2(trim(p_address || ', ' || p_house),
                        ' ' || trim(p_address || ', ' || p_house),
                        ''),
                   1,
                   70)
      into l_adr
      from dual;

    kl.setcustomerattr(rnk_       => p_rnk, -- Customer number
                       custtype_  => 3, -- Тип клиента: 1-банк, 2-юр.лицо, 3-физ.лицо
                       nd_        => null, -- № договора
                       nmk_       => l_nmk, -- Наименование клиента
                       nmkv_      => l_nmkv, -- Наименование клиента международное
                       nmkk_      => l_nmkk, -- Наименование клиента краткое
                       adr_       => l_adr, -- Адрес клиента
                       codcagent_ => 5, -- Характеристика
                       country_   => 804, -- Страна
                       prinsider_ => 99, -- Признак инсайдера
                       tgr_       => 2, -- Тип гос.реестра
                       okpo_      => trim(p_identcode), -- ОКПО
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
                       tobo_      => p_branch, -- Код безбалансового отделения
                       isp_       => null -- Менеджер клиента (ответ. исполнитель)
                       );

    kl.setcustomeren(p_rnk  => p_rnk,
                     p_k070 => nvl(getglobaloption('CUSTK070'), '00000'), -- ise
                     p_k080 => nvl(getglobaloption('CUSTK080'), '00'), -- fs
                     p_k110 => '00000', -- ved
                     p_k090 => '00000', -- oe
                     p_k050 => '000', -- k050
                     p_k051 => '00' -- sed
                     );

    kl.setcustomerelement(rnk_ => p_rnk,
                          tag_ => 'FGIDX',
                          val_ => trim(p_zipcode),
                          otd_ => 0);

    kl.setcustomerelement(rnk_ => p_rnk,
                          tag_ => 'FGOBL',
                          val_ => trim(p_region),
                          otd_ => 0);

    kl.setcustomerelement(rnk_ => p_rnk,
                          tag_ => 'FGDST',
                          val_ => trim(p_area),
                          otd_ => 0);

    kl.setcustomerelement(rnk_ => p_rnk,
                          tag_ => 'FGTWN',
                          val_ => trim(p_city),
                          otd_ => 0);

    kl.setcustomerelement(rnk_ => p_rnk,
                          tag_ => 'FGADR',
                          val_ => trim(p_address || ', ' || p_house),
                          otd_ => 0);

    kl.setcustomeraddressbyterritory(rnk_         => p_rnk,
                                     typeid_      => 1,
                                     country_     => 804,
                                     zip_         => substr(trim(p_zipcode),
                                                            1,
                                                            20),
                                     domain_      => substr(trim(p_region),
                                                            1,
                                                            30),
                                     region_      => substr(trim(p_area),
                                                            1,
                                                            30),
                                     locality_    => substr(trim(p_city),
                                                            1,
                                                            30),
                                     address_     => substr(trim(p_address || ', ' ||
                                                                 p_house),
                                                            1,
                                                            100),
                                     territoryid_ => null);

    kl.setcustomeraddressbyterritory(rnk_         => p_rnk,
                                     typeid_      => 2,
                                     country_     => 804,
                                     zip_         => substr(trim(p_zipcode),
                                                            1,
                                                            20),
                                     domain_      => substr(trim(p_region),
                                                            1,
                                                            30),
                                     region_      => substr(trim(p_area),
                                                            1,
                                                            30),
                                     locality_    => substr(trim(p_city),
                                                            1,
                                                            30),
                                     address_     => substr(trim(p_address || ', ' ||
                                                                 p_house),
                                                            1,
                                                            100),
                                     territoryid_ => null);

    kl.setpersonattr(rnk_    => p_rnk,
                     sex_    => p_sex,
                     passp_  => case
                                  when p_typedoc = 1 then
                                   1
                                  when p_typedoc = 2 then
                                   3
                                  else
                                   7
                                end,
                     ser_    => trim(p_series),
                     numdoc_ => trim(p_num),
                     pdate_  => trim(p_issdate),
                     organ_  => substr(trim(p_issuer), 1, 70),
                     bday_   => p_birthdate,
                     bplace_ => null,
                     teld_   => p_phone,
                     telw_   => null);

    -- LastName - фамилия, FirstName - имя
    kl.setcustomerelement(rnk_ => p_rnk,
                          tag_ => 'SN_FN',
                          val_ => p_name,
                          otd_ => 0);

    kl.setcustomerelement(rnk_ => p_rnk,
                          tag_ => 'SN_LN',
                          val_ => p_surname,
                          otd_ => 0);

    if p_fname is not null then
      kl.setcustomerelement(rnk_ => p_rnk,
                            tag_ => 'SN_MN',
                            val_ => p_fname,
                            otd_ => 0);
    end if;
    --
    if p_email is not null then
      kl.setcustomerelement(rnk_ => p_rnk,
                            tag_ => 'EMAIL',
                            val_ => p_email,
                            otd_ => 0);
    end if;
    if p_mphone is not null then
      kl.setcustomerelement(rnk_ => p_rnk,
                            tag_ => 'MPNO ',
                            val_ => p_mphone,
                            otd_ => 0);
    end if;

  end create_customer;
begin
  p_errcode := 0;
  savepoint s_reg;
/*  l_rnk := get_client(p_okpo    => p_identcode,
                      p_paspser => p_series,
                      p_paspnum => p_num,
                      p_bdate   => p_birthdate,
                      p_typedoc => p_typedoc,
                      p_code    => l_code);*/
--  if l_code in (0, 1) then
    if p_rnk is null then
      begin
        create_customer;
      exception
        when others then
          rollback to s_reg;
          p_errcode := 3;
          p_errmsg  := substr('Помилка при відкриті клієнта: ' ||
                              dbms_utility.format_error_stack() || chr(10) ||
                              dbms_utility.format_error_backtrace(),
                              1,
                              4000);
      end;
    end if;

    -- Проверка на заполнение атрибутов поКК
    select nvl(sum(decode(t.tag, 'W4KKW', 1, 0)), 0),
           nvl(sum(decode(t.tag, 'W4KKR', 1, 0)), 0),
           nvl(sum(decode(t.tag, 'W4KKA', 1, 0)), 0),
           nvl(sum(decode(t.tag, 'W4KKT', 1, 0)), 0),
           nvl(sum(decode(t.tag, 'W4KKS', 1, 0)), 0),
           nvl(sum(decode(t.tag, 'W4KKB', 1, 0)), 0),
           nvl(sum(decode(t.tag, 'W4KKZ', 1, 0)), 0),
           nvl(sum(decode(t.tag, 'K013', 1, 0)), 0)
      into l_w4kkw, l_w4kkr, l_w4kka, l_w4kkt, l_w4kks, l_w4kkb, l_w4kkz, l_k013
      from customerw t
     where t.tag in
           ('W4KKW', 'W4KKR', 'W4KKA', 'W4KKT', 'W4KKS', 'W4KKB', 'W4KKZ', 'K013') and
           rnk = p_rnk;
    if l_w4kkw = 0 then
      kl.setcustomerelement(rnk_ => p_rnk,
                            tag_ => 'W4KKW',
                            val_ => p_password,
                            otd_ => 0);
    end if;
    if l_w4kkr = 0 then
      kl.setcustomerelement(rnk_ => p_rnk,
                            tag_ => 'W4KKR',
                            val_ => 1,
                            otd_ => 0);
    end if;
    if l_w4kka = 0 then
      kl.setcustomerelement(rnk_ => p_rnk,
                            tag_ => 'W4KKA',
                            val_ => 1,
                            otd_ => 0);
    end if;
    if l_w4kkt = 0 then
      kl.setcustomerelement(rnk_ => p_rnk,
                            tag_ => 'W4KKT',
                            val_ => 1,
                            otd_ => 0);
    end if;
    if l_w4kks = 0 then
      kl.setcustomerelement(rnk_ => p_rnk,
                            tag_ => 'W4KKS',
                            val_ => 'Не задано',
                            otd_ => 0);
    end if;
    if l_w4kkb = 0 then
      kl.setcustomerelement(rnk_ => p_rnk,
                            tag_ => 'W4KKB',
                            val_ => 'Не задано',
                            otd_ => 0);
    end if;
    if l_w4kkz = 0 then
      kl.setcustomerelement(rnk_ => p_rnk,
                            tag_ => 'W4KKZ',
                            val_ => p_zipcode,
                            otd_ => 0);
    end if;
    if l_k013 = 0 then
      kl.setcustomerelement(rnk_ => p_rnk,
                            tag_ => 'K013',
                            val_ => '5',
                            otd_ => 0);
    end if;
    if p_errcode = 0 then
      begin
        insert into customer_images
          (rnk, type_img, image)
        values
          (p_rnk, 'PHOTO_JPG', empty_blob());
      exception
        when dup_val_on_index then
          null;
      end;
      update customer_images
         set image = p_photodata
       where rnk = p_rnk and type_img = 'PHOTO_JPG';
      -- регистрация БПК
      begin
        if l_card_code is null then
           if nvl(p_is_social,0) = 1 then
              l_card_code := 'SOC_SOCPOL_UAH_VCUKK';
           else
              l_card_code := 'STND_UAH_18_VCUKK';
           end if;
        end if;
        bars_ow.open_card(p_rnk          => p_rnk,
                          p_nls          => null,
                          p_cardcode     => l_card_code,
                          p_branch       => p_branch,
                          p_embfirstname => substr(p_latname,
                                                   1,
                                                   instr(p_latname, ' ') - 1),
                          p_emblastname  => substr(p_latname,
                                                   instr(p_latname, ' ') + 1),
                          p_secname      => p_password||'123',
                          p_work         => null,
                          p_office       => null,
                          p_wdate        => null,
                          p_salaryproect => null,
                          p_term         => null,
                          p_branchissue  => p_branch,
                          p_nd           => l_nd,
                          p_reqid        => l_reqid
                         );
        update accounts
           set nbs  = null,
               dazs = bankdate
         where acc = (select acc_pk from w4_acc where nd = l_nd)
        returning nls, acc into l_nls, l_acc;

        update cm_client_que
           set personalisationname = 'W'
         where acc = l_acc and oper_type in(1, 5) and oper_status = 1 and card_type = l_card_code;

        accreg.setAccountSParam(l_acc, 'W4_ECN', 'W');

        p_nls     := l_nls;
        p_errcode := 0;
        p_errmsg  := 'ОК';
      exception
        when others then
          rollback to s_reg;

          p_errcode := 4;
          p_errmsg  := substr('Помилка при відкриті картки: ' ||
                              dbms_utility.format_error_stack() || chr(10) ||
                              dbms_utility.format_error_backtrace(),
                              1,
                              4000);
      end;
    end if;
/*  else
    if l_code = 2 then
      p_errcode := 1;
      p_errmsg  := 'Вже зареєстровано клієнта з ІПН ' || p_identcode ||
                   ' не співпадає серія та номер документу';
    elsif l_code = 3 then
      p_errcode := 2;
      p_errmsg  := 'Вже зареєстровано клієнта з ІПН ' || p_identcode ||
                   ' не співпадає дата народження';

    end if;
  end if;*/
exception
  when others then
    rollback to s_reg;

    p_errcode := 99;
    p_errmsg  := substr('Технічка помилка: ' ||
                        dbms_utility.format_error_stack() || chr(10) ||
                        dbms_utility.format_error_backtrace(),
                        1,
                        4000);
end regkkforbk;
/
show err;

PROMPT *** Create  grants  REGKKFORBK ***
grant EXECUTE                                                                on REGKKFORBK      to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/REGKKFORBK.sql =========*** End **
PROMPT ===================================================================================== 
