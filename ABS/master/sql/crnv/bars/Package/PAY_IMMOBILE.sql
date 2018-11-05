CREATE OR REPLACE PACKAGE BARS.PAY_IMMOBILE
IS
   g_header_version   CONSTANT VARCHAR2 (64) := 'version 1.44  25/02/2016';

 function get_nls2924foracc(p_nls in varchar2) return varchar2;
 -- Процедура виплати клієнту
 procedure pay_immobile_crnv(p_key asvo_immobile.key%type);
 --маркування для відправки на доходи РУ
 procedure before_send2ru(p_key number);
 -- Процедура повернення на доходи РУ
 procedure send2ru(p_key asvo_immobile.key%type);

 procedure pay_grc;
 procedure pay_job;

/**
 * header_version - возвращает версию заголовка пакета NERUHOMI
 */
   FUNCTION header_version
      RETURN VARCHAR2;

/**
 * body_version - возвращает версию тела пакета NERUHOMI
 */
   FUNCTION body_version
      RETURN VARCHAR2;
-------------------
END PAY_IMMOBILE;
/

CREATE OR REPLACE PACKAGE BODY BARS.PAY_IMMOBILE IS
  g_body_version CONSTANT VARCHAR2(64) := 'version 1.39  17/08/2018';
  g_mfo varchar2(9);

 function get_nls2924foracc(p_nls in varchar2)
  return varchar2 is
  l_nls2924 varchar2(19);
begin

  begin
    select nls
      into l_nls2924
      from grc_v_w4_tr2924 t
     where t.branch = (select substr(branch, 1, 15)
                         from grc_accounts a
                        where a.nls = p_nls and rownum = 1);
  exception
    when no_data_found then
      raise_application_error(-20000, 'Для рахунку '||p_nls||' не знайдено рахунок 2924!' );
  end;

  return(l_nls2924);
end get_nls2924foracc;

  -- Процедура виплати клієнту
  procedure pay_immobile_crnv(p_key asvo_immobile.key%type) is
    l_rec_asvo      asvo_immobile%rowtype;
    l_rec_alien     alien_immobile%rowtype;
    l_mfo_a         varchar2(9) := f_ourmfo_g();
    l_ref           oper.ref%type;
    l_ref2          oper.ref%type;
    l_tt            tts.tt%type := 'NDP';
    l_vob           oper.vob%type := 6;
    l_dk            oper.dk%type := 1;
    l_bankdate      date;
    l_nam_a         oper.nam_a%type := 'Рахунок банку відправника';
    l_nls_a         oper.nlsa%type;
    l_okpo_a        oper.id_b%type := f_ourokpo();
    l_nam_b         oper.nam_b%type;
    l_mfo_b         varchar2(9);
    l_nazn          varchar2(300);
    l_ost           number;
    l_err           varchar2(4000);
    l_nls_b_opl     varchar2(15);
    l_rec_resources exchange_of_resources%rowtype;
    l_nls_a2        varchar2(14);
    l_nls_b2        varchar2(14);
    l_nls_b2_opl    varchar2(14);
    l_dk2           oper.dk%type := 0;
    l_nazn2         oper.nazn%type := 'Повернення ресурсів';
    l_okpo_a2       oper.id_a%type := f_ourokpo();
    l_okpo_b2       oper.id_a%type;
    l_nam_a2        varchar2(38);
    l_nam_b2        varchar2(38);
    l_branch        branch.branch%type;

    procedure DefineNazn(p_nls alien_immobile.nls%type, p_comments alien_immobile.comments%type) is
    begin
      -- Призначення. Визначаємо номер нерухомого вкладу
      l_nazn := case l_rec_asvo.source when 'BARS' then to_char(l_rec_asvo.dptid) else to_char(l_rec_asvo.nls) end;
      -- Призначення. Визначаємо зміст згідно рахунку
      l_nazn := case
                  when p_nls like ('3141%') then --не перекодовується
                   p_comments || ', ' || l_rec_asvo.fio || ', ' || l_rec_asvo.idcode || ', номер нерухомого вкладу №' || l_nazn
                  when p_nls like ('2909%') then --Для рублей берем из alien_immobile.comments
                   p_comments 
                  else
                   'Виплата нерухомого вкладу №' || l_nazn || ', ' || l_rec_asvo.fio
                end;
      l_nazn := substr(l_nazn, 1, 160);
    end DefineNazn;

  begin
    --Вичитаєм рядок з таблиці нерухомих
    select a.*
      into l_rec_asvo
      from asvo_immobile a
     where a.key = p_key
       for update;
    select e.*
      into l_rec_resources
      from exchange_of_resources e
     where e.mfo = substr(l_rec_asvo.branch, 2, 6);

    begin
      select c.okpo
        into l_okpo_b2
        from customer c, custbank b
       where b.mfo = substr(l_rec_asvo.branch, 2, 6)
         and b.rnk = c.rnk
         and rownum = 1;
    exception
      when no_data_found then
        raise_application_error(-20000,
                                'Не знайдено ОКПО отримувача (Дт. платіж)!');
    end;
    --Блок ініціалізації
    begin
      l_bankdate  := gl.bd;
      l_nls_a     := vkrzn(substr(l_mfo_a, 1, 5),
                           case l_rec_asvo.bsd
                             when '2620' then
                              '2620_030' || substr(l_rec_asvo.branch, 2, 6)
                             when '2630' then
                              '2630_046' || substr(l_rec_asvo.branch, 2, 6)
                             when '2635' then
                              '2630_046' || substr(l_rec_asvo.branch, 2, 6)--'2635_038' || substr(l_rec_asvo.branch, 2, 6)
                           end);
      l_nls_b_opl := vkrzn(substr(l_mfo_a, 1, 5),
                           '3739_' || substr(l_rec_asvo.bsd, 3, 2) ||
                           substr(l_rec_asvo.branch, 2, 6));

      l_nam_b := substr(l_rec_asvo.fio, 1, 38);
      l_mfo_b := substr(l_rec_asvo.branch, 2, 6);
      l_ost   := l_rec_asvo.ost - f_part_sum_immobile(p_key);

      --Реквізити для повернення ресурсів
      l_nls_a2     := l_rec_resources.nls_3902;
      l_nls_b2     := l_rec_resources.nls_3903;
      l_nls_b2_opl := vkrzn(substr(l_mfo_a, 1, 5),
                            '3739_99' || substr(l_rec_asvo.branch, 2, 6));

      --Назва відправника
      begin
        select substr(nms, 1, 38)
          into l_nam_a
          from accounts
         where nls = l_nls_a
           and kv = l_rec_asvo.kv;
      exception
        when no_data_found then
          begin
                      select substr(nms, 1, 38), nls
                          into l_nam_a, l_nls_a
                          from accounts
                         where nlsalt = l_nls_a
                           and kv = l_rec_asvo.kv;
          exception
              when no_data_found then
              raise_application_error(-20001,
                                  'Не знайдено рахунок "' || l_nls_a ||
                                  '", валюта "' || l_rec_asvo.kv || '"!');
          end;
      end;
      --Назва відправника
      begin
        select substr(nms, 1, 38)
          into l_nam_a2
          from accounts
         where nls = l_nls_a2
           and kv = l_rec_asvo.kv;
      exception
        when no_data_found then
          raise_application_error(-20001,
                                  'Не знайдено рахунок "' || l_nls_a2 ||
                                  '", валюта "' || l_rec_asvo.kv || '"!');
      end;

      begin
        select substr(nb, 1, 38) nb
          into l_nam_b2
          from banks
         where mfo = substr(l_rec_asvo.branch, 2, 6);
      exception
        when no_data_found then
          raise_application_error(-20000,
                                  'Не знайдено МФО "' ||
                                  substr(l_rec_asvo.branch, 2, 6) || '"!');
      end;

    end;
    if l_rec_asvo.fl in (8, -4) then

      --Перевіримо наявність рахунку отримувача
      begin
        select ai.*
          into l_rec_alien
          from alien_immobile ai
         where ai.key = p_key
           for update;
      exception
        when no_data_found then
          raise_application_error(-20000,
                                  'Не заповнено рахунок одержувача!');
      end;
      -- Додаю після випадку коли був рахунок пустий
      if (l_rec_alien.nls is null) then
        raise_application_error(-20000,
                                'Не заповнено рахунок одержувача!');
      end if;

      begin
        select branch
          into l_branch
          from staff$base
         where id = l_rec_alien.userid;
      exception
        when no_data_found then
          raise_application_error(-20000,
                                  'Не вдалося визначити бранч користувача #' ||
                                  l_rec_alien.userid);
      end;

      DefineNazn(l_rec_alien.nls, l_rec_alien.comments);
      --Блок оплати для виплати всієї суми
      begin
        savepoint sp_before;

        gl.ref(l_ref);

        insert into oper
          (ref,
           tt,
           vob,
           nd,
           dk,
           pdat,
           vdat,
           datd,
           datp,
           nam_a,
           nlsa,
           mfoa,
           id_a,
           nam_b,
           nlsb,
           mfob,
           id_b,
           kv,
           s,
           kv2,
           s2,
           nazn,
           userid,
           sk,
           branch,
           tobo,
           d_rec)
        values
          (l_ref,
           l_tt,
           l_vob,
           l_ref,
           l_dk,
           sysdate,
           l_bankdate,
           l_bankdate,
           l_bankdate,
           l_nam_a,
           l_nls_a,
           l_mfo_a,
           l_okpo_a,
           substr(l_rec_alien.fio, 1, 38),
           l_rec_alien.nls,
           l_rec_alien.mfob,
           l_rec_alien.okpob,
           l_rec_asvo.kv,
           l_ost,
           l_rec_asvo.kv,
           l_ost,
           substr(l_nazn, 1, 160),
           l_rec_alien.userid,
           null,
           l_branch,
           l_branch,
--           case when l_rec_alien.okpob = '0000000000' then
           case when l_rec_alien.okpob in (lpad('0',9,'0'), lpad('0',10,'0')) then
           '#ф' || nvl(l_rec_alien.pasp_s || l_rec_alien.pasp_n, '000000') else null end);
        paytt(null,
              l_ref,
              l_bankdate,
              l_tt,
              l_dk,
              l_rec_asvo.kv,
              l_nls_a,
              l_ost,
              l_rec_asvo.kv,
              l_nls_b_opl,
              l_ost);

        set_operw(l_ref, 'REF92', l_rec_asvo.key);

        --повернення ресурсу
        gl.ref(l_ref2);

        insert into oper
          (ref,
           tt,
           vob,
           nd,
           dk,
           pdat,
           vdat,
           datd,
           datp,
           nam_a,
           nlsa,
           mfoa,
           id_a,
           nam_b,
           nlsb,
           mfob,
           id_b,
           kv,
           s,
           kv2,
           s2,
           nazn,
           userid,
           sk,
           branch,
           tobo)
        values
          (l_ref2,
           l_tt,
           l_vob,
           l_ref2,
           l_dk2,
           sysdate,
           l_bankdate,
           l_bankdate,
           l_bankdate,
           l_nam_a2,
           l_nls_a2,
           l_mfo_a,
           l_okpo_a2,
           l_nam_b2,
           l_nls_b2,
           l_mfo_b,
           l_okpo_b2,
           l_rec_asvo.kv,
           l_ost,
           l_rec_asvo.kv,
           l_ost,
           substr(l_nazn2 || 'відділення ' || l_branch || ',' || case
                  l_rec_asvo.source when 'BARS' then
                  to_char(l_rec_asvo.dptid) else to_char(l_rec_asvo.nls)
                  end || ',' || substr(l_rec_alien.fio, 1, 38) || ', ' ||
                  l_rec_alien.okpob || ',' || l_rec_alien.nls,
                  1,
                  160),
           l_rec_alien.userid,
           null,
           l_branch,
           l_branch);
        paytt(null,
              l_ref2,
              l_bankdate,
              l_tt,
              l_dk2,
              l_rec_asvo.kv,
              l_nls_a2,
              l_ost,
              l_rec_asvo.kv,
              l_nls_b2_opl,
              l_ost);
        set_operw(l_ref2, 'REF92', l_rec_asvo.key);
        update asvo_immobile
           set fl = 9, refpay = l_ref, date_off = l_bankdate
         where key = p_key;
        insert into crnv_to_grc (ref) values (l_ref);
        insert into crnv_to_grc (ref) values (l_ref2);
      exception
        when others then
          rollback to sp_before;
          l_err := sqlerrm;
          update asvo_immobile
             set fl = -4, errmsg = l_err
           where key = p_key;
      end;
    end if;
    --Якщо флаг 10 значить э виплата частками і вона може бути не одна
    if l_rec_asvo.fl in (10, 13, -5) then
      begin
        for k in (select *
                    from part_pay_immobile
                   where key = p_key
                     and status = 0) loop
          begin

            begin
              select branch
                into l_branch
                from staff$base
               where id = k.userid;
            exception
              when no_data_found then
                raise_application_error(-20000,
                                        'Не вдалося визначити бранч користувача #' ||
                                        k.userid);
            end;
            DefineNazn(k.nls, k.comments);

            savepoint sp_before;

            gl.ref(l_ref);

            insert into oper
              (ref,
               tt,
               vob,
               nd,
               dk,
               pdat,
               vdat,
               datd,
               datp,
               nam_a,
               nlsa,
               mfoa,
               id_a,
               nam_b,
               nlsb,
               mfob,
               id_b,
               kv,
               s,
               kv2,
               s2,
               nazn,
               userid,
               sk,
               branch,
               tobo,
               d_rec)
            values
              (l_ref,
               l_tt,
               l_vob,
               l_ref,
               l_dk,
               sysdate,
               l_bankdate,
               l_bankdate,
               l_bankdate,
               l_nam_a,
               l_nls_a,
               l_mfo_a,
               l_okpo_a,
               substr(k.fio, 1, 38),
               k.nls,
               k.mfob,
               k.okpob,
               l_rec_asvo.kv,
               k.sum,
               l_rec_asvo.kv,
               k.sum,
               substr(l_nazn, 1, 160),
               k.userid,
               null,
               l_branch,
               l_branch,
--               case when k.okpob = '0000000000' then
               case when l_rec_alien.okpob in (lpad('0',9,'0'), lpad('0',10,'0')) then
                 '#ф' || nvl(k.pasp_s || k.pasp_n, '000000') else null end);
            paytt(null,
                  l_ref,
                  l_bankdate,
                  l_tt,
                  l_dk,
                  l_rec_asvo.kv,
                  l_nls_a,
                  k.sum,
                  l_rec_asvo.kv,
                  l_nls_b_opl,
                  k.sum);
            set_operw(l_ref, 'REF92', l_rec_asvo.key);
            --повернення ресурсів
            gl.ref(l_ref2);

            insert into oper
              (ref,
               tt,
               vob,
               nd,
               dk,
               pdat,
               vdat,
               datd,
               datp,
               nam_a,
               nlsa,
               mfoa,
               id_a,
               nam_b,
               nlsb,
               mfob,
               id_b,
               kv,
               s,
               kv2,
               s2,
               nazn,
               userid,
               sk,
               branch,
               tobo)
            values
              (l_ref2,
               l_tt,
               l_vob,
               l_ref,
               l_dk2,
               sysdate,
               l_bankdate,
               l_bankdate,
               l_bankdate,
               l_nam_a2,
               l_nls_a2,
               l_mfo_a,
               l_okpo_a2,
               l_nam_b2,
               l_nls_b2,
               l_mfo_b,
               l_okpo_b2,
               l_rec_asvo.kv,
               k.sum,
               l_rec_asvo.kv,
               k.sum,
               substr(l_nazn2 || 'відділення ' || l_branch || ',' || case
                      l_rec_asvo.source when 'BARS' then
                      to_char(l_rec_asvo.dptid) else
                      to_char(l_rec_asvo.nls)
                      end || ',' || substr(k.fio, 1, 38) || ', ' || k.okpob || ',' ||
                      k.nls,
                      1,
                      160),
               k.userid,
               null,
               l_branch,
               l_branch);
            paytt(null,
                  l_ref2,
                  l_bankdate,
                  l_tt,
                  l_dk2,
                  l_rec_asvo.kv,
                  l_nls_a2,
                  k.sum,
                  l_rec_asvo.kv,
                  l_nls_b2_opl,
                  k.sum);
            set_operw(l_ref2, 'REF92', l_rec_asvo.key);

            update part_pay_immobile
               set status = 1, refpay = l_ref
             where key = k.key
               and pdat = k.pdat;
            insert into crnv_to_grc (ref) values (l_ref);
            insert into crnv_to_grc (ref) values (l_ref2);
          end;
        end loop;
        update asvo_immobile
           set fl       = 11,
               date_off = case
                            when l_rec_asvo.ost = f_part_sum_immobile(p_key) then
                             l_bankdate
                            else
                             null
                          end
         where key = p_key;
      exception
        when others then
          rollback to sp_before;
          l_err := sqlerrm;
          update asvo_immobile
             set fl = -5, errmsg = l_err
           where key = p_key;
      end;
    end if;
  end pay_immobile_crnv;

  --маркування для відправки на доходи РУ
  PROCEDURE before_send2ru(p_key number) is
    l_err      varchar2(4000);
    l_rec_asvo asvo_immobile%rowtype;
  BEGIN
    savepoint sp_before;

    select a.*
      into l_rec_asvo
      from asvo_immobile a
     where a.key = p_key
       for update;

    if l_rec_asvo.fl in (14, -6, 15) then
      null;
    else
      update asvo_immobile set fl = 14 where key = p_key;

      insert into send2ru_que (key, userid) values (p_key, user_id);
    end if;
  exception
    when others then
      rollback to sp_before;
      l_err := SQLERRM;
      --ставим отметку про ошибку
      update asvo_immobile set fl = -6, errmsg = l_err where key = p_key;
  END before_send2ru;

  --Процедура оплати на доходи РУ
  procedure send2ru(p_key asvo_immobile.key%type) is
    l_rec_asvo      asvo_immobile%rowtype;
    l_rec_alien     alien_immobile%rowtype;
    l_mfo_a         varchar2(9) := f_ourmfo_g();
    l_ref           oper.ref%type;
    l_ref2          oper.ref%type;
    l_tt            tts.tt%type := 'NDP';
    l_vob           oper.vob%type := 6;
    l_dk            oper.dk%type := 1;
    l_bankdate      date;
    l_nam_a         oper.nam_a%type := 'Рахунок банку відправника';
    l_nls_a         oper.nlsa%type;
    l_okpo_a        oper.id_b%type := f_ourokpo();
    l_nam_b         oper.nam_b%type;
    l_mfo_b         varchar2(9);
    l_nazn          varchar2(160);
    l_ost           number;
    l_err           varchar2(4000);
    l_nls_b_opl     varchar2(15);
    l_rec_resources exchange_of_resources%rowtype;
    l_nls_a2        varchar2(14);
    l_nls_b2        varchar2(14);
    l_nls_b2_opl    varchar2(14);
    l_dk2           oper.dk%type := 0;
    l_nazn2         oper.nazn%type := 'Повернення ресурсів';
    l_okpo_a2       oper.id_a%type := f_ourokpo();
    l_okpo_b2       oper.id_a%type;
    l_nam_a2        varchar2(38);
    l_nam_b2        varchar2(38);
    l_branch        branch.branch%type;
    l_userid        number;

  begin
    --Вичитаєм рядок з таблиці нерухомих
    select a.*
      into l_rec_asvo
      from asvo_immobile a
     where a.key = p_key
       for update;
    select e.*
      into l_rec_resources
      from exchange_of_resources e
     where e.mfo = substr(l_rec_asvo.branch, 2, 6);
    select userid
      into l_userid
      from send2ru_que s
     where s.key = p_key
       for update;

    begin
      select c.okpo, substr(c.nmk, 1, 38)
        into l_okpo_b2, l_nam_b
        from customer c, custbank b
       where b.mfo = substr(l_rec_asvo.branch, 2, 6)
         and b.rnk = c.rnk
         and rownum = 1;
    exception
      when no_data_found then
        raise_application_error(-20000,
                                'Не знайдено ОКПО отримувача (Дт. платіж)!');
    end;
    --Блок ініціалізації
    begin
      l_bankdate  := gl.bd;
      l_nls_a     := vkrzn(substr(l_mfo_a, 1, 5),
                           case l_rec_asvo.bsd
                             when '2620' then
                              '2620_030' || substr(l_rec_asvo.branch, 2, 6)
                             when '2630' then
                              '2630_046' || substr(l_rec_asvo.branch, 2, 6)
                             when '2635' then
                              '2630_046' || substr(l_rec_asvo.branch, 2, 6)--'2635_038' || substr(l_rec_asvo.branch, 2, 6)
                           end);
      l_nls_b_opl := vkrzn(substr(l_mfo_a, 1, 5),
                           '3739_' || substr(l_rec_asvo.bsd, 3, 2) ||
                           substr(l_rec_asvo.branch, 2, 6));

      -- l_nam_b := substr(l_rec_asvo.fio, 1, 38);
      l_mfo_b := substr(l_rec_asvo.branch, 2, 6);
      l_nazn  := substr('Перерахування на доходи нерухомого вкладу №' ||
                        case l_rec_asvo.source
                          when 'BARS' then
                           to_char(l_rec_asvo.dptid)
                          else
                           to_char(l_rec_asvo.nls)
                        end || ', ' || l_rec_asvo.fio,
                        1,
                        160);
      l_ost   := l_rec_asvo.ost - f_part_sum_immobile(p_key);

      --Реквізити для повернення ресурсів
      l_nls_a2     := l_rec_resources.nls_3902;
      l_nls_b2     := l_rec_resources.nls_3903;
      l_nls_b2_opl := vkrzn(substr(l_mfo_a, 1, 5),
                            '3739_99' || substr(l_rec_asvo.branch, 2, 6));

      --Назва відправника
      begin
        select substr(nms, 1, 38)
          into l_nam_a
          from accounts
         where nls = l_nls_a
           and kv = l_rec_asvo.kv;
      exception
        when no_data_found then
          begin
                      select substr(nms, 1, 38), nls
                          into l_nam_a, l_nls_a
                          from accounts
                         where nlsalt = l_nls_a
                           and kv = l_rec_asvo.kv;
          exception
              when no_data_found then
              raise_application_error(-20001,
                                  'Не знайдено рахунок "' || l_nls_a ||
                                  '", валюта "' || l_rec_asvo.kv || '"!');
          end;
      end;
      --Назва відправника
      begin
        select substr(nms, 1, 38)
          into l_nam_a2
          from accounts
         where nls = l_nls_a2
           and kv = l_rec_asvo.kv;
      exception
        when no_data_found then
          raise_application_error(-20001,
                                  'Не знайдено рахунок "' || l_nls_a2 ||
                                  '", валюта "' || l_rec_asvo.kv || '"!');
      end;

      begin
        select substr(nb, 1, 38) nb
          into l_nam_b2
          from banks
         where mfo = substr(l_rec_asvo.branch, 2, 6);
      exception
        when no_data_found then
          raise_application_error(-20000,
                                  'Не знайдено МФО "' ||
                                  substr(l_rec_asvo.branch, 2, 6) || '"!');
      end;

    end;
    if l_rec_asvo.fl in (14, -6) then
      ---помічені для відправки в РУ та з помилками відправки на РУ(6-клас)

      begin
        select branch
          into l_branch
          from staff$base s
         where s.id = l_userid;
      exception
        when no_data_found then
          l_branch := sys_context('bars_context', 'user_branch');
      end;

      --Блок оплати для виплати всієї суми
      begin
        savepoint sp_before;

        gl.ref(l_ref);

        insert into oper
          (ref,
           tt,
           vob,
           nd,
           dk,
           pdat,
           vdat,
           datd,
           datp,
           nam_a,
           nlsa,
           mfoa,
           id_a,
           nam_b,
           nlsb,
           mfob,
           id_b,
           kv,
           s,
           kv2,
           s2,
           nazn,
           userid,
           sk,
           branch,
           tobo,
           d_rec)
        values
          (l_ref,
           l_tt,
           l_vob,
           l_ref,
           l_dk,
           sysdate,
           l_bankdate,
           l_bankdate,
           l_bankdate,
           l_nam_a,
           l_nls_a,
           l_mfo_a,
           l_okpo_a,
           l_nam_b,
           vkrzn(substr(l_mfo_b, 1, 5), '3739_000400000'),
           l_mfo_b,
           l_okpo_b2,
           l_rec_asvo.kv,
           l_ost,
           l_rec_asvo.kv,
           l_ost,
           substr(l_nazn, 1, 160),
           l_userid,
           null,
           l_branch,
           l_branch,
           '#CIMMOB:' || l_rec_asvo.branch || '#'); --Посилаю D_REC для підбору 6-го класу по бранчу
        paytt(null,
              l_ref,
              l_bankdate,
              l_tt,
              l_dk,
              l_rec_asvo.kv,
              l_nls_a,
              l_ost,
              l_rec_asvo.kv,
              l_nls_b_opl,
              l_ost);

        set_operw(l_ref, 'REF92', l_rec_asvo.key);

        --повернення ресурсу
        gl.ref(l_ref2);

        insert into oper
          (ref,
           tt,
           vob,
           nd,
           dk,
           pdat,
           vdat,
           datd,
           datp,
           nam_a,
           nlsa,
           mfoa,
           id_a,
           nam_b,
           nlsb,
           mfob,
           id_b,
           kv,
           s,
           kv2,
           s2,
           nazn,
           userid,
           sk,
           branch,
           tobo)
        values
          (l_ref2,
           l_tt,
           l_vob,
           l_ref2,
           l_dk2,
           sysdate,
           l_bankdate,
           l_bankdate,
           l_bankdate,
           l_nam_a2,
           l_nls_a2,
           l_mfo_a,
           l_okpo_a2,
           l_nam_b2,
           l_nls_b2,
           l_mfo_b,
           l_okpo_b2,
           l_rec_asvo.kv,
           l_ost,
           l_rec_asvo.kv,
           l_ost,
           substr(l_nazn2 || ' відділення ' || l_branch || ',' || case
                  l_rec_asvo.source when 'BARS' then
                  to_char(l_rec_asvo.dptid) else to_char(l_rec_asvo.nls) end,
                  1,
                  160),
           l_userid,
           null,
           l_branch,
           l_branch);
        paytt(null,
              l_ref2,
              l_bankdate,
              l_tt,
              l_dk2,
              l_rec_asvo.kv,
              l_nls_a2,
              l_ost,
              l_rec_asvo.kv,
              l_nls_b2_opl,
              l_ost);
        set_operw(l_ref2, 'REF92', l_rec_asvo.key);
        update asvo_immobile
           set fl = 15, refpay = l_ref, date_off = l_bankdate
         where key = p_key;
        delete from send2ru_que where key = p_key;
        insert into crnv_to_grc (ref) values (l_ref);
        insert into crnv_to_grc (ref) values (l_ref2);
      exception
        when others then
          rollback to sp_before;
          l_err := sqlerrm;
          update asvo_immobile
             set fl = -6, errmsg = l_err
           where key = p_key;
      end;
    end if;

  end send2ru;

  -- Оплата в ГОУ
  procedure pay_grc is
    l_ref1 oper.ref%type;
    l_ref2 oper.ref%type;
    l_ref  oper.ref%type;

    l_sos     oper.sos%type;
    l_sos_grc oper.sos%type;
    l_tt      oper.tt%type;

    l_grc_staffid staff.id%type := 1;

    l_rec number;
    l_err number;

    -- дата ГРЦ
    l_grc_date date := grc_gl.bd;

    g_grc_nls_t00 accounts.nls%type;
    g_grc_nls_t0D accounts.nls%type;

    g_grc_tt_real tts.tt%type;
    g_grc_tt_info tts.tt%type := '514';
    l_errmsg      varchar2(4000);

  begin

    --  контекст по дблінку -- 16.11.2013
    bars.bars_login.login_user@barsdb.grc.ua(null, null, null, null);
    g_mfo := f_ourmfo_g@barsdb.grc.ua;
    --
    bars.bars_context.subst_branch@barsdb.grc.ua('/' || g_mfo || '/');

    --  получаем номер транзитного счета для Кт платежа
    begin
      select nls
        into g_grc_nls_t00
        from grc_accounts
       where tip = 'T00'
         and kv = 980
         and ob22 = '10';
    exception
      when others then
        raise_application_error(-20000,
                                'Невозможно получить счет T00 ГРЦ',
                                true);
    end;

    --  получаем номер транзитного счета для Дт платежа
    begin
      select nls
        into g_grc_nls_t0D
        from grc_accounts
       where tip = 'T0D'
         and kv = 980;
    exception
      when others then
        raise_application_error(-20000,
                                'Невозможно получить счет T0D ГРЦ',
                                true);
    end;

    bars_audit.info('Старт ');

    -- устанавливаем политику WHOLE
    bars_context.set_policy_group('WHOLE');

    begin

      -- оплата документов в ГРЦ
      for cur_o in (select o.*
                      from oper o, crnv_to_grc c
                     where o.ref = c.ref) loop
        begin
          savepoint before_act_pay;
          -- проверка параметров документов
          if (cur_o.vdat > l_grc_date) then
            raise_application_error(-20000,
                                    'REF=' || cur_o.ref ||
                                    'Дата валютування ' ||
                                    to_char(cur_o.vdat, 'dd.mm.yyyy') ||
                                    ' більша за банківську дату в ГРЦ ' ||
                                    to_char(l_grc_date, 'dd.mm.yyyy'));
          end if;
          if (cur_o.sign is null) then
            raise_application_error(-20000,
                                    'REF=' || cur_o.ref || ' - ' ||
                                    'На документ не накладено підпис СЕП');
          end if;

          if (cur_o.mfoa != g_mfo) then
            raise_application_error(-20000,
                                    'REF=' || cur_o.ref || ' - ' ||
                                    'МФО-А документу не дорівнює МФО ГРЦ ' ||
                                    g_mfo);
          end if;

          select o.sos into l_sos from oper o where o.ref = cur_o.ref;

          if not (l_sos in (4, 5)) then
            raise_application_error(-20000,
                                    'REF=' || cur_o.ref ||
                                    ' - Не проведено в ЦРНВ');
          end if;

          --  Определяем операцию Реальний/Информационний
          case cur_o.dk
            when 1 then
              if cur_o.kv = 980 then
                if (cur_o.mfob = '300465') then
				    if cur_o.nlsb like '2625%' then
				          l_tt := 'PKR';
				     else l_tt := 'DP2';
				     end if;
                else
                  l_tt := 'DP3';
                end if;
              else
                if (cur_o.mfob = '300465') then
				   	 if cur_o.nlsb like '2625%' then
				          l_tt := 'PKR';
				     else l_tt := 'DPI';
				     end if;
                else
                  l_tt := 'DPJ';
                end if;
              end if;
            else
              l_tt := g_grc_tt_info;
          end case;

          -- формируем платеж в ГРЦ
          grc_gl.ref(l_ref);
          insert into grc_oper
            (ref,
             tt,
             vob,
             nd,
             pdat,
             vdat,
             dk,
             kv,
             s,
             kv2,
             s2,
             sk,
             datd,
             datp,
             nam_a,
             nlsa,
             mfoa,
             nam_b,
             nlsb,
             mfob,
             nazn,
             d_rec,
             id_a,
             id_b,
             id_o,
             sign,
             sos,
             prty,
             sq,
             ref_a,
             userid,
             nextvisagrp)
          values
            (l_ref,
             l_tt,
             cur_o.vob,
             cur_o.nd,
             sysdate,
             trim(cur_o.vdat),
             cur_o.dk,
             cur_o.kv,
             cur_o.s,
             cur_o.kv2,
             cur_o.s2,
             cur_o.sk,
             trim(cur_o.datd),
             trim(cur_o.datp),
             cur_o.nam_a,
             cur_o.nlsa,
             cur_o.mfoa,
             cur_o.nam_b,
             cur_o.nlsb,
             cur_o.mfob,
             cur_o.nazn,
             cur_o.d_rec,
             cur_o.id_a,
             cur_o.id_b,
             cur_o.id_o,
             cur_o.sign,
             0,
             0,
             cur_o.sq,
             cur_o.ref_a,
             l_grc_staffid,
             '!!');

          -- оплата платежа в ГРЦ
          if (cur_o.dk = 1) then
            grc_gl.payv(0,
                        l_ref,
                        l_grc_date,
                        l_tt,
                        1,
                        cur_o.kv,
                        cur_o.nlsa,
                        cur_o.s,
                        cur_o.kv,
                        case when cur_o.mfob = 300465 then get_nls2924foracc(cur_o.nlsb) else
                        g_grc_nls_t00 end,
                        cur_o.s);
            l_ref1 := l_ref;
          else
            grc_gl.payv(0,
                        l_ref,
                        l_grc_date,
                        l_tt,
                        0,
                        cur_o.kv,
                        cur_o.nlsa,
                        cur_o.s,
                        cur_o.kv,
                        case when cur_o.mfob = 300465 then cur_o.nlsb else
                        g_grc_nls_t0D end,
                        cur_o.s);
            l_ref2 := l_ref;
          end if;
          grc_gl.pay2(2, l_ref, l_grc_date);

          -- Отправка в СЄП
          select o.sos into l_sos_grc from grc_oper o where o.ref = l_ref;
          if (l_sos_grc = 5) then
            if cur_o.mfob != 300465 then
              grc_sep.in_sep(l_err,
                             l_rec,
                             cur_o.mfoa,
                             cur_o.nlsa,
                             cur_o.mfob,
                             cur_o.nlsb,
                             cur_o.dk,
                             cur_o.s,
                             cur_o.vob,
                             cur_o.nd,
                             cur_o.kv,
                             trim(cur_o.datd),
                             trim(cur_o.datp),
                             cur_o.nam_a,
                             cur_o.nam_b,
                             cur_o.nazn,
                             null,
                             case when cur_o.d_rec is null then '10' else '11' end,
                             cur_o.id_a,
                             cur_o.id_b,
                             cur_o.id_o,
                             nvl(case when length(cur_o.ref_a)>9 then substr(cur_o.ref_a,-9) else  cur_o.ref_a end, case when length(l_ref)>9 then substr(l_ref,-9) else  l_ref end) ,
                             0,
                             cur_o.sign,
                             null,
                             null,
                             sysdate,
                             cur_o.d_rec,
                             0,
                             l_ref);
            else
              null;
            end if;
          end if;

          --  проверяем успешность оплати в СЄП
          if not (l_sos_grc = 5 and l_err = 0 and l_rec > 0) then
            raise_application_error(-20000,
                                    'REF=' || cur_o.ref ||
                                    'Помилки оплати СЕП: ' || 'err = ' ||
                                    l_err || ', rec = ' || l_rec);
          end if;

          delete from crnv_to_grc where ref = cur_o.ref;
        exception
          when others then
            rollback to before_act_pay;
            l_errmsg := sqlerrm;
            update crnv_to_grc set errmsg = l_errmsg where ref = cur_o.ref;
        end;
      end loop;

    end;

    bars_audit.info('Фініш оплати');

  end pay_grc;

  procedure pay_job is
  begin
    tuda;
    for c in (select *
                from asvo_immobile
               where fl in (8, 10, 13, -4, -5, 14, -6)) loop
      begin
        if c.fl in (14, -6) then
          pay_immobile.send2ru(c.key);
        else
          pay_immobile.pay_immobile_crnv(c.key);
        end if;
      exception
        when others then
          null;
      end;
    end loop;
    begin
      pay_immobile.pay_grc;
    exception
      when others then
        null;
    end;
  end pay_job;

  /*
  * header_version - возвращает версию заголовка пакета NERUHOMI
  */
  FUNCTION header_version RETURN VARCHAR2 IS
  BEGIN
    RETURN 'Package header PAY_IMMOBILE ' || g_header_version;
  END header_version;

  /*
  * body_version - возвращает версию тела пакета NERUHOMI
  */
  FUNCTION body_version RETURN VARCHAR2 IS
  BEGIN
    RETURN 'Package body PAY_IMMOBILE ' || g_body_version;
  END body_version;

END PAY_IMMOBILE;
/

