
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_sep_rates.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_SEP_RATES is


  -- global consts
  G_HEADER_VERSION constant varchar2(64)  := 'version 1.01 20/12/2007';

  ----
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2;

  ----
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2;

  ----
  -- get_next_start_date - возвращает дату начала следующего периода
  --
  function get_next_start_date return date;

  ----
  -- get_next_start_date - возвращает дату окончания следующего периода
  --
  function get_next_finish_date(p_start_date in date) return date;

  --
  -- fill_daily_totals - населяет таблицу sep_daily_totals за указанный день
  --
  procedure fill_daily_totals(p_date in date);

  --
  -- fill_period_totals - агрегирует данные за период p_id
  --
  procedure fill_period_totals(p_id in integer);

  --
  -- create_payments_by_period - порождает платежи по списанию средств за период p_id
  --
  procedure create_payments_by_period(p_id in integer);

  --
  -- create_period - создает новый период для указаного интервала, возвращает id периода.
  --
  procedure create_period(p_start_date in date, p_finish_date in date, p_id in out integer);

end bars_sep_rates;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_SEP_RATES is

  ----
  -- global consts
  --
  G_BODY_VERSION constant varchar2(64)  := 'version 1.04 26/12/2007';

  ----
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2 is
  begin
    return 'Package header '||G_HEADER_VERSION;
  end header_version;

  ----
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2 is
  begin
    return 'Package body '||G_BODY_VERSION;
  end body_version;

  ----
  -- get_next_start_date - возвращает дату начала следующего периода
  --
  function get_next_start_date return date is
    l_fdat          date;
    l_cal           sep_rates_calendar%rowtype;
  begin
    select * into l_cal from sep_rates_calendar where id=(select max(id) from sep_rates_calendar);
    select min(fdat) into l_fdat from fdat where fdat>l_cal.finish_date;
    return l_fdat;
  end get_next_start_date;

  ----
  -- get_next_start_date - возвращает дату окончания следующего периода
  --
  function get_next_finish_date(p_start_date in date) return date is
    l_fdat  date;
  begin
    select max(fdat) into l_fdat from fdat where fdat<=add_months(p_start_date,1) and fdat>p_start_date;
    return l_fdat;
  end get_next_finish_date;

  --
  -- fill_daily_totals - населяет таблицу sep_daily_totals за указанный день
  --
  procedure fill_daily_totals(p_date in date) is
    ern       constant positive := 1;
    erm       varchar2(250);
    err       exception;
    l_dat     date;
    l_fn_b    varchar2(12);
    l_fn_a    varchar2(12);
    l_fn_c    varchar2(12);
    l_fn_v    varchar2(12);
    l_aSAB    char(4);
  begin
    bars_audit.trace('start');
    begin
        select fdat into l_dat from fdat where fdat=p_date;
    exception when no_data_found then
        erm := '1 - Дата '||to_char(p_date,'DD.MM.YYYY')||' не является банковским рабочим днем';
        raise err;
    end;
    -- предварительно удаляем данные за день
    delete from sep_daily_totals where fdat=p_date;
    --
    if sql%rowcount>0 then
        bars_audit.info('Удалены данные из таблицы sep_daily_totals за дату '||to_char(p_date, 'DD.MM.YYYY'));
    end if;
    begin
       select  sab into l_aSAB from banks$base where mfo = gl.aMFO;
    exception when no_data_found then
        erm := 'Не вдалося визначити SAB для поточного банку mfo='||gl.aMFO||';';
        raise err;
    end;

    l_fn_b := '$A'||l_aSAB||'%';
    l_fn_a := '$B'||l_aSAB||'%';
    l_fn_c := '$C'||l_aSAB||'%';
    l_fn_v := '$V'||l_aSAB||'%';
    -- наполняем таблицу данными
    insert into sep_daily_totals(fdat, mfo,
        cnt_1,cnt_2,cnt_3,cnt_4,cnt_5,cnt_6,cnt_7,cnt_8,
        sum_1,sum_2,sum_3,sum_4,sum_5,sum_6,sum_7,sum_8,
        sum_total)
    select p_date, mfo,
        cnt_1,cnt_2,cnt_3,cnt_4,cnt_5,cnt_6,cnt_7,cnt_8,
        sum_1,sum_2,sum_3,sum_4,sum_5,sum_6,sum_7,sum_8,
        sum_1+sum_2+sum_3+sum_4+sum_5+sum_6+sum_7+sum_8 as sum_total
    from
    (
    select mfo,
        cnt_1,cnt_2,cnt_3,cnt_4,cnt_5,cnt_6,cnt_7,cnt_8,
        cnt_1 * (select rate from sep_rates_mod3 where id=1) as sum_1,
        cnt_2 * (select rate from sep_rates_mod3 where id=2) as sum_2,
        cnt_3 * (select rate from sep_rates_mod3 where id=3) as sum_3,
        cnt_4 * (select rate from sep_rates_mod3 where id=4) as sum_4,
        cnt_5 * (select rate from sep_rates_mod3 where id=5) as sum_5,
        cnt_6 * (select rate from sep_rates_mod3 where id=6) as sum_6,
        cnt_7 * (select rate from sep_rates_mod3 where id=7) as sum_7,
        cnt_8 * (select rate from sep_rates_mod3 where id=8) as sum_8
    from
    (   select mfo, sum(sep1) cnt_1, sum(sep2) cnt_2, sum(sep3) cnt_3, sum(sep4) cnt_4,
                    sum(ssp1) cnt_5, sum(ssp2) cnt_6, sum(ssp3) cnt_7, sum(ssp4) cnt_8
        from (
            -- 1. СЭП. 08:30-16:00 утренний
            select mfoa mfo,count(*) sep1, 0 sep2, 0 sep3, 0 sep4, 0 ssp1, 0 ssp2, 0 ssp3, 0 ssp4
            from arc_rrp p,zag_b b
            where p.fn_b=b.fn and p.dat_b=b.dat and p.dat_b>=p_date and p.dat_b<p_date+1 and p.fn_b like l_fn_b
              and to_char(b.dat_2,'HH24')<'16' and (p.prty is null or p.prty in (0,3))
            group by mfoa
            union all
            -- 2. СЭП. 16:00-19:00 дневной
            select mfoa,0,count(*),0,0,0,0,0,0
            from arc_rrp p,zag_b b
            where p.fn_b=b.fn and p.dat_b=b.dat and p.dat_b>=p_date and p.dat_b<p_date+1 and p.fn_b like l_fn_b
              and to_char(b.dat_2,'HH24')>='16' and to_char(b.dat_2,'HH24')<'19'  and (p.prty is null or p.prty in (0,3))
            group by mfoa
            union all
            -- 3. СЭП. 19:00-24:00 вечерний
            select mfoa,0,0,count(*),0,0,0,0,0
            from arc_rrp p,zag_b b
            where p.fn_b=b.fn and p.dat_b=b.dat and p.dat_b>=p_date and p.dat_b<p_date+1 and p.fn_b like l_fn_b
              and to_char(b.dat_2,'HH24')>='19' and (p.prty is null or p.prty in (0,3))
            group by mfoa
            union all
            -- 4. СЭП. ответные платежи
            select mfob,0,0,0,count(*),0,0,0,0
            from arc_rrp p,zag_a a
            where p.fn_a=a.fn and p.dat_a=a.dat and p.dat_a>=p_date and p.dat_a<p_date+1 and p.fn_a like l_fn_a
              and (p.prty is null or p.prty in (0,3))
            group by mfob
            union all
            -- 5. ССП. 08:30-16:00 утренний
            select mfoa, 0 sep1, 0 sep2, 0 sep3, 0 sep4, count(*) ssp1, 0 ssp2, 0 ssp3, 0 ssp4
            from arc_rrp p,zag_b b
            where p.fn_b=b.fn and p.dat_b=b.dat and p.dat_b>=p_date and p.dat_b<p_date+1 and p.fn_b like l_fn_b
              and to_char(b.dat_2,'HH24')<'16' and p.prty=1
            group by mfoa
            union all
            -- 6. ССП. 16:00-19:00 дневной
            select mfoa,0,0,0,0,0,count(*),0,0
            from arc_rrp p,zag_b b
            where p.fn_b=b.fn and p.dat_b=b.dat and p.dat_b>=p_date and p.dat_b<p_date+1 and p.fn_b like l_fn_b
              and to_char(b.dat_2,'HH24')>='16' and to_char(b.dat_2,'HH24')<'19'  and p.prty=1
            group by mfoa
            union all
            -- 7. ССП. 19:00-24:00 вечерний
            select mfoa,0,0,0,0,0,0,count(*),0
            from arc_rrp p,zag_b b
            where p.fn_b=b.fn and p.dat_b=b.dat and p.dat_b>=p_date and p.dat_b<p_date+1 and p.fn_b like l_fn_b
              and to_char(b.dat_2,'HH24')>='19' and p.prty=1
            group by mfoa
            union all
            -- 8. ССП. ответные платежи
            select mfob,0,0,0,0,0,0,0,count(*)
            from arc_rrp p,zag_a a
            where p.fn_a=a.fn and p.dat_a=a.dat and p.dat_a>=p_date and p.dat_a<p_date+1
              and (p.fn_a like l_fn_c or p.fn_a like l_fn_v)
              and p.prty=1
            group by mfob
        )
        group by mfo
  )
  );
  if sql%rowcount=0 then
    -- если платежей за день не было, вставляем нулевую строку с МФО ГБ как признак рассчитанного дня
    insert into sep_daily_totals(fdat, mfo,
        cnt_1,cnt_2,cnt_3,cnt_4,cnt_5,cnt_6,cnt_7,cnt_8,
        sum_1,sum_2,sum_3,sum_4,sum_5,sum_6,sum_7,sum_8,
        sum_total)
    values( p_date, gl.aMFO,
        0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,
        0);
  end if;
  bars_audit.info('Таблица sep_daily_totals населена данными за дату '||to_char(p_date, 'DD.MM.YYYY'));

  bars_audit.trace('finish');

  exception when err then
     raise_application_error(-(20000+ern), erm, TRUE);
  end fill_daily_totals;

  --
  -- fill_period_totals - агрегирует данные за период p_id
  --
  procedure fill_period_totals(p_id in integer) is
    ern       constant positive := 2;
    erm       varchar2(250);
    err       exception;
    l_period  sep_rates_calendar%rowtype;
    l_dat     date;
  begin
    bars_audit.trace('start');
    begin
        select * into l_period from sep_rates_calendar where id=p_id;
    exception when no_data_found then
        erm := '1 - Период № '||p_id||' не найден';
        raise err;
    end;
    if l_period.closed='Y' then
        erm := '2 - Период № '||p_id||' закрыт, работа невозможна';
        raise err;
    end if;

    -- проверяем все ли рабочие дни рассчитаны
    begin
        select fdat into l_dat from fdat where fdat between l_period.start_date and l_period.finish_date
        and fdat not in
        (select fdat from sep_daily_totals where fdat between l_period.start_date and l_period.finish_date)
        and rownum=1;
        -- нашли хотя бы один нерассчитанный день, выбрасываем ошибку
        erm := '3 - В периоде № '||p_id||' присутствуют нерассчитанные дни. Обратитесь к администратору.';
        raise err;
    exception when no_data_found then
        null; -- нерассчитанных дней нету
    end;
    -- удаляем старые записи
    delete from sep_rates_totals where id=p_id;
    if sql%rowcount>0 then
        bars_audit.info('Из таблицы sep_rates_totals удалены старые данные по периоду № '||p_id);
    end if;

    insert into sep_rates_totals(id, mfo,
        cnt_1, cnt_2, cnt_3, cnt_4, cnt_5, cnt_6, cnt_7, cnt_8,
        sum_1, sum_2, sum_3, sum_4, sum_5, sum_6, sum_7, sum_8,
        sum_total)
    select p_id, mfo,
        sum(cnt_1) p_cnt_1, sum(cnt_2) p_cnt_2, sum(cnt_3) p_cnt_3, sum(cnt_4) p_cnt_4,
        sum(cnt_5) p_cnt_5, sum(cnt_6) p_cnt_6, sum(cnt_7) p_cnt_7, sum(cnt_8) p_cnt_8,
        sum(sum_1) p_sum_1, sum(sum_2) p_sum_2, sum(sum_3) p_sum_3, sum(sum_4) p_sum_4,
        sum(sum_5) p_sum_5, sum(sum_6) p_sum_6, sum(sum_7) p_sum_7, sum(sum_8) p_sum_8,
        sum(sum_total) p_sum_total
    from sep_daily_totals where fdat between l_period.start_date and l_period.finish_date
    group by p_id, mfo;
    bars_audit.info('Таблица sep_rates_totals населена данными за период № '||p_id);

    update sep_rates_calendar set total_sum=(select sum(sum_total) from sep_rates_totals where id=p_id)
    where id=p_id;
    bars_audit.info('Установлена общая сумма расчетов по периоду № '||p_id);

    bars_audit.trace('finish');
  exception when err then
     raise_application_error(-(20000+ern), erm, TRUE);
  end fill_period_totals;

  --
  -- create_payments_by_period - порождает платежи по списанию средств за период p_id
  --
  procedure create_payments_by_period(p_id in integer) is
    ern       constant positive := 2;
    erm       varchar2(250);
    err       exception;
    l_period  sep_rates_calendar%rowtype;
    l_pay_req sep_filial_pay_details%rowtype;
    l_nls     varchar2(14);
    l_name    varchar2(38);
    l_okpo    varchar2(14);
    l_tts     tts%rowtype;
    l_ref     number;
    l_sumkom  number;
    l_txt     varchar2(160);
    l_txt2    varchar2(160);
    l_sos     bars.oper.sos%type;
  begin
    bars_audit.trace('start');
    begin
        select * into l_period from sep_rates_calendar where id=p_id;
    exception when no_data_found then
        erm := '1 - Период № '||p_id||' не найден';
        raise err;
    end;
    if l_period.closed='Y' then
        erm := '2 - Период № '||p_id||' закрыт, работа невозможна';
        raise err;
    end if;
    if l_period.total_sum is null then
        erm := '2 - Суммы по периоду № '||p_id||' не просчитаны. Выполните просчет сумм.';
        raise err;
    end if;
    -- читаем параметры своего котлового счета в расчетах за СЭП
    begin
        select val into l_nls from params where par='SEP3_NLS';
    exception when no_data_found then
        erm := '3 - Параметр SEP3_NLS не найден';
        raise err;
    end;
    begin
        select substr(val,1,38) into l_name from params where par='SEP3_NAM';
    exception when no_data_found then
        erm := '4 - Параметр SEP3_NAM не найден';
        raise err;
    end;
    begin
        select val into l_okpo from params where par='SEP3_IDA';
    exception when no_data_found then
        erm := '5 - Параметр SEP3_IDA не найден';
        raise err;
    end;
    begin
        select val into l_txt from params where par='SEP3_TXT';
        l_txt := replace(l_txt, '%1', to_char(l_period.start_date,'DD.MM.YYYY'));
        l_txt := replace(l_txt, '%2', to_char(l_period.finish_date,'DD.MM.YYYY'));
        l_txt := rpad(l_txt,160);
    exception when no_data_found then
        erm := '6 - Параметр SEP3_TXT не найден';
        raise err;
    end;

    begin
        select val into l_txt2 from params where par='SEP3_TX2';
        l_txt2 := replace(l_txt2, '%1', to_char(l_period.start_date,'DD.MM.YYYY'));
        l_txt2 := replace(l_txt2, '%2', to_char(l_period.finish_date,'DD.MM.YYYY'));
        l_txt2 := rpad(l_txt2,160);
    exception when no_data_found then
        erm := '6 - Параметр SEP3_TX2 не найден';
        raise err;
    end;

    -- поехали
    for c in (select * from sep_rates_totals where id=p_id and sum_total > 0 for update nowait) loop
        -- читаем платежные реквизиты
        begin
            select * into l_pay_req from sep_filial_pay_details where mfo=c.mfo;
        exception when no_data_found then
            erm := '7 - Платежные реквизиты для МФО='||c.mfo||' не найдены. Заполните справочник SEP_FILIAL_PAY_DETAILS.';
            raise err;
        end;
        -- порождаем платеж
        select * into l_tts from tts where tt=l_pay_req.tt;
        if l_tts.dk<>0 then
            erm := '8 - Операция '||l_tts.tt||' должна иметь тип DK=0(Реальный дебет)';
            raise err;
        end if;
        gl.ref(l_ref);
        gl.in_doc2(
                ref_    => l_ref,
                tt_     => l_pay_req.tt,
                vob_    => case when gl.aMFO=l_pay_req.mfo then 6 else 2 end, -- для себя 6(мемордер), для других 2(плат. требование)
                nd_     => substr(to_char(l_ref),1,10),
                pdat_   => sysdate,
                vdat_   => gl.bDATE,
                dk_     => 0,
                kv_     => gl.baseval,
                s_      => c.sum_total,
                kv2_    => gl.baseval,
                s2_     => c.sum_total,
                sq_     => c.sum_total,
                sk_     => null,
                data_   => gl.bDATE,
                datp_   => gl.bDATE,
                nam_a_  => l_name,
                nlsa_   => l_nls,
                mfoa_   => gl.aMFO,
                nam_b_  => l_pay_req.nmk,
                nlsb_   => l_pay_req.nls,
                mfob_   => l_pay_req.mfo,
                nazn_   => l_txt,
                d_rec_  => null,
                id_a_   => l_okpo,
                id_b_   => l_pay_req.okpo,
                id_o_   => null,
                sign_   => null,
                sos_    => 0,
                prty_   => 0
        );
        -- пишем доп.реквизиты с детальной расшифровкой суммы
        -- СЭП. Тариф 1
        insert into operw(ref,tag,value)
        select l_ref, 'П1', 'СЕП: з 08:30 до 16:00 відправлено '
               ||replace(to_char(c.cnt_1,'FM9,999,999,990'),',',' ')||' платежів за тарифом '
               ||replace(to_char(rate/100,'FM9,999,999,990.009999'),',',' ')||' грн., комісія '
               ||replace(to_char(c.sum_1/100,'FM9,999,999,990.009999'),',',' ')||' грн.'
        from sep_rates_mod3 where id=1;
        -- СЭП. Тариф 2
        insert into operw(ref,tag,value)
        select l_ref, 'П2', 'СЕП: з 16:00 до 19:00 відправлено '
               ||replace(to_char(c.cnt_2,'FM9,999,999,990'),',',' ')||' платежів за тарифом '
               ||replace(to_char(rate/100,'FM9,999,999,990.009999'),',',' ')||' грн., комісія '
               ||replace(to_char(c.sum_2/100,'FM9,999,999,990.009999'),',',' ')||' грн.'
        from sep_rates_mod3 where id=2;
        -- СЭП. Тариф 3
        insert into operw(ref,tag,value)
        select l_ref, 'П3', 'СЕП: з 19:00 до 24:00 відправлено '
               ||replace(to_char(c.cnt_3,'FM9,999,999,990'),',',' ')||' платежів за тарифом '
               ||replace(to_char(rate/100,'FM9,999,999,990.009999'),',',' ')||' грн., комісія '
               ||replace(to_char(c.sum_3/100,'FM9,999,999,990.009999'),',',' ')||' грн.'
        from sep_rates_mod3 where id=3;
        -- СЭП. Тариф 4 - ответные
        insert into operw(ref,tag,value)
        select l_ref, 'П4', 'СЕП: отримано '
               ||replace(to_char(c.cnt_4,'FM9,999,999,990'),',',' ')||' відповідних платежів за тарифом '
               ||replace(to_char(rate/100,'FM9,999,999,990.009999'),',',' ')||' грн., комісія '
               ||replace(to_char(c.sum_4/100,'FM9,999,999,990.009999'),',',' ')||' грн.'
        from sep_rates_mod3 where id=4;
        -- ССП. Тариф 5
        insert into operw(ref,tag,value)
        select l_ref, 'П5', 'СТП: з 08:30 до 16:00 відправлено '
               ||replace(to_char(c.cnt_5,'FM9,999,999,990'),',',' ')||' платежів за тарифом '
               ||replace(to_char(rate/100,'FM9,999,999,990.009999'),',',' ')||' грн., комісія '
               ||replace(to_char(c.sum_5/100,'FM9,999,999,990.009999'),',',' ')||' грн.'
        from sep_rates_mod3 where id=5;
        -- ССП. Тариф 6
        insert into operw(ref,tag,value)
        select l_ref, 'П6', 'СТП: з 16:00 до 19:00 відправлено '
               ||replace(to_char(c.cnt_6,'FM9,999,999,990'),',',' ')||' платежів за тарифом '
               ||replace(to_char(rate/100,'FM9,999,999,990.009999'),',',' ')||' грн., комісія '
               ||replace(to_char(c.sum_6/100,'FM9,999,999,990.009999'),',',' ')||' грн.'
        from sep_rates_mod3 where id=6;
        -- ССП. Тариф 7
        insert into operw(ref,tag,value)
        select l_ref, 'П7', 'СТП: з 19:00 до 24:00 відправлено '
               ||replace(to_char(c.cnt_7,'FM9,999,999,990'),',',' ')||' платежів за тарифом '
               ||replace(to_char(rate/100,'FM9,999,999,990.009999'),',',' ')||' грн., комісія '
               ||replace(to_char(c.sum_7/100,'FM9,999,999,990.009999'),',',' ')||' грн.'
        from sep_rates_mod3 where id=7;
        -- ССП. Тариф 8 - ответные
        insert into operw(ref,tag,value)
        select l_ref, 'П8', 'СТП: отримано '
               ||replace(to_char(c.cnt_8,'FM9,999,999,990'),',',' ')||' відповідних платежів за тарифом '
               ||replace(to_char(rate/100,'FM9,999,999,990.009999'),',',' ')||' грн., комісія '
               ||replace(to_char(c.sum_8/100,'FM9,999,999,990.009999'),',',' ')||' грн.'
        from sep_rates_mod3 where id=8;
        -- платим
        gl.dyntt2 (
              l_sos, to_number(substr(l_tts.flags,38,1)), 1,
              l_ref, gl.bDATE, null, l_tts.tt, l_tts.dk,
              gl.baseval, gl.aMFO, l_nls, c.sum_total,
              gl.baseval, l_pay_req.mfo, l_pay_req.nls, c.sum_total, c.sum_total, null);
        -- все хорошо, сохраним референс
        update sep_rates_totals set ref=l_ref where id=c.id and mfo=c.mfo;
        bars_audit.info('Порожден документ REF='||l_ref||' по периоду № '||c.id||', МФО='||c.mfo);

        -- платим фиксированую комисию
        select rate into l_sumkom from sep_rates_mod3 where id=9;
        gl.ref(l_ref);
        gl.in_doc2(
                ref_    => l_ref,
                tt_     => l_pay_req.tt,
                vob_    => case when gl.aMFO=l_pay_req.mfo then 6 else 2 end, -- для себя 6(мемордер), для других 2(плат. требование)
                nd_     => substr(to_char(l_ref),1,10),
                pdat_   => sysdate,
                vdat_   => gl.bDATE,
                dk_     => 0,
                kv_     => gl.baseval,
                s_      => l_sumkom,
                kv2_    => gl.baseval,
                s2_     => l_sumkom,
                sq_     => l_sumkom,
                sk_     => null,
                data_   => gl.bDATE,
                datp_   => gl.bDATE,
                nam_a_  => l_name,
                nlsa_   => l_nls,
                mfoa_   => gl.aMFO,
                nam_b_  => l_pay_req.nmk,
                nlsb_   => l_pay_req.nls,
                mfob_   => l_pay_req.mfo,
                nazn_   => l_txt2,
                d_rec_  => null,
                id_a_   => l_okpo,
                id_b_   => l_pay_req.okpo,
                id_o_   => null,
                sign_   => null,
                sos_    => 0,
                prty_   => 0
        );
        -- платим
        gl.dyntt2 (
              l_sos, to_number(substr(l_tts.flags,38,1)), 1,
              l_ref, gl.bDATE, null, l_tts.tt, l_tts.dk,
              gl.baseval, gl.aMFO, l_nls, l_sumkom,
              gl.baseval, l_pay_req.mfo, l_pay_req.nls, l_sumkom, l_sumkom, null);
        -- все хорошо, сохраним референс
        update sep_rates_totals set ref2=l_ref where id=c.id and mfo=c.mfo;
        bars_audit.info('Порожден документ REF='||l_ref||' по периоду № '||c.id||', МФО='||c.mfo||' - разовая комисия за услуги СЕП');
    end loop;
    -- закроем период
    update sep_rates_calendar set closed='Y' where id=p_id;
    bars_audit.info('Период № '||p_id||' закрыт');

    bars_audit.trace('finish');
  exception when err then
     raise_application_error(-(20000+ern), erm, TRUE);
  end create_payments_by_period;


  --
  -- create_period - создает новый период для указаного интервала, возвращает id периода.
  --
  procedure create_period(p_start_date in date, p_finish_date in date, p_id in out integer) is
    begin
      if p_id is null then
        insert into sep_rates_calendar(start_date, finish_date) values (p_start_date, p_finish_date) returning id into p_id;
      else
        update sep_rates_calendar set start_date = p_start_date, finish_date = p_finish_date where id = p_id;
      end if;
  end create_period;

begin
  -- Initialization
  null;
end bars_sep_rates;
/
 show err;
 
PROMPT *** Create  grants  BARS_SEP_RATES ***
grant EXECUTE                                                                on BARS_SEP_RATES  to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_sep_rates.sql =========*** End 
 PROMPT ===================================================================================== 
 