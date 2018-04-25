PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/package/dynamic_layout_ui.sql =========***
PROMPT ===================================================================================== 
 
CREATE OR REPLACE PACKAGE BARS.dynamic_layout_ui is

  --
  -- Автор  : VIT
  -- Создан : 10.07.2016
  --
  -- Purpose : Пакет для роботи з Динамічними макетами проводок
  --

  -- Public constant declarations
  g_header_version  constant varchar2(64) := 'version 1.0.2 27/09/2016';
  g_awk_header_defs constant varchar2(512) := '';

  /*  Список изменений
  26.09.2016 Сухова  Добавлена проц оплаты для статических макетов pay_Static_layout
  27.09.2016 Козачок Добавлены процедуры для работы функции "Створення розпорядження по вибору"
             (add_static_layout, calculate_static_layout)
  */

  --------------------------------------------------------------------------------
  -- header_version - повертає версію заголовку пакету
  --
  function header_version return varchar2;

  --------------------------------------------------------------------------------
  -- body_version - повертає версію тіла пакету
  --
  function body_version return varchar2;

  --------------------------------------------------------------------------------
  -- clear_dynamic_layout -очищае заголовок
  --
  procedure clear_dynamic_layout;

  --------------------------------------------------------------------------------
  -- create_dynamic_layout - створюємо заголовок динамічного макету
  --
  procedure create_dynamic_layout(p_mode in number,
                                  p_dk   in number,
                                  p_nls  in ope_lot.nls%type,
                                  p_bs   in ope_lot.bs1%type,
                                  p_ob   in ope_lot.ob1%type,
                                  p_grp  in ope_lot.grp%type,
                                  flag number default 0);
  --------------------------------------------------------------------------------
  -- update_dynamic_layout - редагування заголовоку динамічного макету
  --
  procedure update_dynamic_layout(p_nd            in tmp_dynamic_layout.nd%type,
                                  p_datd          in tmp_dynamic_layout.datd%type,
                                  p_dat_from      in tmp_dynamic_layout.date_from%type,
                                  p_dat_to        in tmp_dynamic_layout.date_to%type,
                                  p_dates_to_nazn in tmp_dynamic_layout.dates_to_nazn%type,
                                  p_nazn          in tmp_dynamic_layout.nazn%type,
                                  p_summ          in tmp_dynamic_layout.summ%type,
                                  p_corr          in tmp_dynamic_layout.correction%type);

  --------------------------------------------------------------------------------
  -- update_dynamic_layout_detail  - редагування деталей динамічного макету
  --
  procedure update_dynamic_layout_detail(p_id        in tmp_dynamic_layout_detail.id%type,
                                         p_persents  in tmp_dynamic_layout_detail.percent%type,
                                         p_summ_a    in tmp_dynamic_layout_detail.summ_a%type,
                                         p_total_sum in tmp_dynamic_layout.summ%type);
  --------------------------------------------------------------------------------
  -- update_kv_b  - зміна коду валюти рахунків Б
  --
  procedure update_kv_b(p_kvb in tmp_dynamic_layout_detail.kv%type);

  --------------------------------------------------------------------------------
  -- calculate_dynamic_layout  - розрахувати суми проведень
  --
  procedure calculate_dynamic_layout(p_id in number,  flag number default 0);

  --------------------------------------------------------------------------------
  -- calculate_static_layout  - розрахувати суми проведень
  --
  procedure calculate_static_layout;

  --------------------------------------------------------------------------------
  -- add_static_layout - додавання/редагування дочірнього запису
  --
  procedure add_static_layout(p_id      in tmp_dynamic_layout_detail.id%type,
                              p_dk      in tmp_dynamic_layout_detail.dk%type,
                              p_nd      in tmp_dynamic_layout_detail.nd%type,
                              p_kv      in tmp_dynamic_layout_detail.kv%type,
                              p_nlsa    in tmp_dynamic_layout_detail.nls_a%type,
                              p_nam_a   in tmp_dynamic_layout_detail.nama%type,
                              p_okpo_a  in tmp_dynamic_layout_detail.okpoa%type,
                              p_mfo_b   in tmp_dynamic_layout_detail.mfob%type,
                              p_nls_b   in tmp_dynamic_layout_detail.nls_b%type,
                              p_nam_b   in tmp_dynamic_layout_detail.namb%type,
                              p_okpo_b  in tmp_dynamic_layout_detail.okpob%type,
                              p_percent in tmp_dynamic_layout_detail.percent%type,
                              p_sum_a   in tmp_dynamic_layout_detail.summ_a%type,
                              p_sum_b   in tmp_dynamic_layout_detail.summ_b%type,
                              p_delta   in tmp_dynamic_layout_detail.delta%type,
                              p_tt      in tmp_dynamic_layout_detail.tt%type,
                              p_vob     in tmp_dynamic_layout_detail.vob%type,
                              p_nazn    in tmp_dynamic_layout_detail.nazn%type,
                              p_ord     in mf1.ord%type,
                              flag number default 0);
  --------------------------------------------------------------------------------
  -- delete_static_layout - видалення дочірнього запису
  --
  procedure delete_static_layout(p_grp in tmp_dynamic_layout_detail.nls_count%type,
                                 p_id  in tmp_dynamic_layout_detail.id%type);

  --------------------------------------------------------------------------------
  -- pay_dynamic_layout  - виконати проведення
  --
  procedure pay_dynamic_layout(p_mak number, p_nd varchar2);

  --------------------------------------------------------------------------------
  -- pay_Static_layout  - виконати проведення
  --
  procedure pay_Static_layout(p_mak number);

end dynamic_layout_ui;

/
CREATE OR REPLACE PACKAGE BODY dynamic_layout_ui is

  --
  -- Автор : VIT
  -- Создан : 09.10.2016
  --
  -- Purpose : Пакет для роботи з макетами проводок
  --

  -- Private constant declarations
  g_body_version  constant varchar2(64) := 'version 1.0.6 13/12/2016';
  g_awk_body_defs constant varchar2(512) := '';
  g_dbgcode       constant varchar2(40) := 'BARS.dynamic_layout_ui.';
  CRLF            constant varchar2(5) := '\r\n'; --'.';

  RES_OK  constant number(1) := 0;
  RES_ERR constant number(1) := -1;

  /*  Список изменений
  30.01.2018 http://jira.unity-bars.com:11000/browse/COBUMMFO-6492 Для статичних макетів додано визначення okpo_a
  24.05.2017 Гриценя для процедур create_dynamic_layout, create_dynamic_layout_detail, add_static_layout
  додано параметр flag для специфічної роботи функції Макети юридичних осіб.
  26.09.2016 Сухова  Добавлена проц оплаты для статических макетов pay_Static_layout
  27.09.2016 Козачок Добавлены процедуры для работы функции "Створення розпорядження по вибору"
             (add_static_layout, calculate_static_layout)
  07.11.2016 Козачок исправление багов по заявке COBUMMFOTEST-56
  23.11.2016 Козачок изменения согласно заявке COBUMMFO-3127
  13.12.2016 Козачок изменения согласно заявке COBUMMFO-3270
             в процедуре calculate_dynamic_layout изменено очередность условий
             было  elsif c.summ_a != 0 then  elsif c.percent != 0 then
             стало  elsif c.percent != 0 then  elsif c.summ_a != 0 then
  */

  --------------------------------------------------------------------------------
  -- header_version - повертає версію заголовку пакету
  --
  function header_version return varchar2 is
  begin
    return 'Package header ' || g_dbgcode || ' ' || g_header_version || '.' || chr(10) || 'AWK definition: ' || chr(10) || g_awk_header_defs;
  end header_version;

  --------------------------------------------------------------------------------
  -- body_version - повертає версію тіла пакету
  --
  function body_version return varchar2 is
  begin
    return 'Package body ' || g_dbgcode || ' ' || g_body_version || '.' || chr(10) || 'AWK definition: ' || chr(10) || g_awk_body_defs;
  end body_version;

  --------------------------------------------------------------------------------
  -- clear_dynamic_layout -очищае заголовок
  --
  procedure clear_dynamic_layout is
  begin
    delete from bars.tmp_dynamic_layout i where i.userid = bars.user_id;
    delete from bars.tmp_dynamic_layout_detail d
     where d.userid = bars.user_id;
  end clear_dynamic_layout;

  --------------------------------------------------------------------------------
  -- create_dynamic_layout_detail - створюємо рядки динамічного макету
  -- p_mode = 1 - статические пакеты в которых указан счет А один для всех (берется из ope_lot)
  -- p_mode = 2 - динамические макеты 2
  -- p_mode = 3 - динамические макеты 3
  -- p_mode = 4 - статические пакеты в которых не указан счет А (берёться и mf1)
  procedure create_dynamic_layout_detail(p_mode  in number,
                                         p_nls   in ope_lot.nls%type,
                                         p_bs    in ope_lot.bs1%type,
                                         p_ob    in ope_lot.ob1%type,
                                         p_kv    in ope_lot.kv%type,
                                         p_grp   in ope_lot.grp%type,
                                         p_count out number,
                                         flag number default 0) is
    l_mode_select_param varchar2(256);
    l_count             number;
    l_user_branch       branch.branch%type default sys_context('bars_context',
                                                               'user_branch');
  begin

    if p_mode in (1, 4) then
      l_count := p_grp;
    end if;
    if p_mode = 1 then

      insert into Tmp_Dynamic_Layout_Detail value
        (select m.id,
                nvl(o.dk, nvl(m.dk, 1)) dk,
                null nd,
                m.kva kv,
                null branch,
                null branch_name,
                nvl(m.nlsa, o.nls) nls_a,
                nvl(m.nam_a, substr(a.nms, 1, 38)) nama,
                m.okpoa,
                m.mfob,
                b.nb mfob_name,
                m.nlsb,
                m.nam_b,
                m.okpob,
                nvl(m.prc, 0) percent,
                case when flag = 0 then 0 + nvl(m.delta, 0) else 0 end suma_a,
                case when flag = 0 then 0 + nvl(m.delta, 0) else 0 end suma_b,
                nvl(m.delta, 0),
                m.tt,
                m.vob,
                nvl(m.nazn, o.nazn1) nazn,
                m.ref,
                p_grp nls_count,
                bars.user_id
           from bars.mf1 m, bars.ope_lot o, bars.accounts a, bars.banks b
          where m.grp = o.grp
            and m.grp = p_grp
            and o.nls = a.nls
            and m.mfob = b.mfo);

      --calculate_dynamic_layout(null);
    end if;

    if p_mode = 4 then

      insert into Tmp_Dynamic_Layout_Detail value
        (select m.id,
                nvl(o.dk, nvl(m.dk, 1)) dk,
                null nd,
                m.kva kv,
                null branch,
                nvl(decode(a.ostc / 100, '0', '0.00', a.ostc / 100), '0.00') branch_name,
                nvl(m.nlsa, ' ') nls_a,
                nvl(m.nam_a, substr(a.nms, 1, 38)) nama,
                m.okpoa,
                m.mfob,
                b.nb mfob_name,
                m.nlsb,
                m.nam_b,
                m.okpob,
                nvl(m.prc, 0) percent,
                nvl(a.ostc + nvl(m.delta, 0), 0) suma_a,
                nvl(a.ostc + nvl(m.delta, 0), 0) suma_b,
                nvl(m.delta, 0),
                m.tt,
                m.vob,
                nvl(m.nazn, o.nazn1) nazn,
                m.ref,
                p_grp nls_count,
                bars.user_id
           from bars.mf1 m, bars.ope_lot o, bars.accounts a, bars.banks b
          where m.grp = p_grp
            and m.grp = o.grp
            and m.nlsa = a.nls(+)
            and m.kva = a.kv(+)
            and m.mfob = b.mfo
         --and m.nlsa is not null
         );

      --calculate_dynamic_layout(null);
    end if;

    if p_mode = 2 then
      for c in (select rownum rn,
                       b.branch,
                       b.name,
                       a.nls,
                       a.kv,
                       (select count(*)
                          from accounts
                         where dazs is null
                           and nbs = p_bs
                           and ob22 = p_ob
                           and branch = b.branch
                           and kv = p_kv) kol
                  from branch2 b, v_gl a
                 where b.date_closed is null
                   and substr(nbs_ob22_null(p_bs, p_ob, b.branch), 1, 14) =
                       a.nls
                   and b.branch like l_user_branch || '%'
                   and a.kv = p_kv
                 order by b.branch desc) loop
        insert into tmp_dynamic_layout_detail
        values
          (c.rn,
           null,
           null,
           c.kv,
           c.branch,
           c.name,
           p_nls,
           '',
           '',
           '',
           '',
           c.nls,
           '',
           '',
           0,
           0,
           0,
           0,
           '',
           '',
           '',
           '',
           c.kol,
           bars.user_id);
        l_count := c.rn;
      end loop;
    elsif p_mode = 3 then
      for c in (select rownum rn,
                       b.branch,
                       b.name,
                       a.nls,
                       a.kv,
                       (select count(*)
                          from accounts
                         where dazs is null
                           and nbs = p_bs
                           and ob22 = p_ob
                           and substr(branch, 1, 15) =
                               substr(b.branch, 1, 15)
                           and kv = 980) kol
                  from branch2 b, v_gl a
                 where b.date_closed is null
                   and substr(nbs_ob22_null(p_bs, p_ob, b.branch), 1, 14) =
                       a.nls
                   and b.branch like l_user_branch || '%'
                   and length(l_user_branch) = 15
                   and a.kv = p_kv
                 order by b.branch desc) loop
        insert into tmp_dynamic_layout_detail
        values
          (c.rn,
           null, -- dk
           null,
           c.kv,
           c.branch,
           c.name,
           p_nls,
           '',
           '',
           '',
           '',
           c.nls,
           '',
           '',
           0,
           0,
           0,
           0,
           '',
           '',
           '',
           '',
           c.kol,
           bars.user_id);
        l_count := c.rn;
      end loop;
    end if;
    --end if;
    p_count := l_count;
  end create_dynamic_layout_detail;

  --------------------------------------------------------------------------------
  -- create_dynamic_layout - створюємо заголовок динамічного макету
  -- p_mode = 1 - статические пакеты в которых указан счет А один для всех (берется из ope_lot)
  -- p_mode = 2 - динамические макеты 2
  -- p_mode = 3 - динамические макеты 3
  -- p_mode = 4 - статические пакеты в которых не указан счет А (берёться и mf1)
  procedure create_dynamic_layout(p_mode in number,
                                  p_dk   in number,
                                  p_nls  in ope_lot.nls%type,
                                  p_bs   in ope_lot.bs1%type,
                                  p_ob   in ope_lot.ob1%type,
                                  p_grp  in ope_lot.grp%type,
                                  flag number default 0) is
    l_count_nls          bars.accounts.nls%type;
    l_tmp_dynamic_layout bars.tmp_dynamic_layout%rowtype;
    l_branch_count       bars.tmp_dynamic_layout.branch_count%type;
    l_total_persents     number(5, 2);
    l_total_summ         number;
    l_parent_summ        number;
    l_kv                 number;
    l_sql                varchar2(4000);
  begin
  /* logger.info ('DYN p_mode: '||p_mode);
   logger.info ('DYN p_dk: '||p_dk);
   logger.info ('DYN p_nls : '||p_nls);
   logger.info ('DYN p_bs:  '||p_bs);
   logger.info ('DYN p_ob:  '||p_ob);
   logger.info ('DYN p_grp: '||p_grp);
   logger.info ('DYN flag:  '||flag);*/
   
   --Додано уточнення по коду валюти http://jira.unity-bars.com.ua:11000/browse/COBUMMFO-5296
   if p_mode <> 4 then 
    begin   
       l_sql := 'begin select kv into :l_kv from ope_lot where nls = '||p_nls;
       
         if p_ob is null then
           l_sql := l_sql || ' and ob1 is null';
         else
           l_sql := l_sql || ' and ob1 = '|| p_ob;
         end if;
     
         if p_bs is null then
           l_sql := l_sql || ' and bs1 is null';
         else
           l_sql := l_sql || ' and bs1 = '|| p_bs;
         end if;
     
         if p_grp is null then
           l_sql := l_sql || ' and grp is null';
         else
           l_sql := l_sql || ' and grp = '|| p_grp ;
         end if;
     
        l_sql := l_sql || '; end;';
     
        execute immediate l_sql using out l_kv;
       end;
      end if ;  
     /*logger.info ('DYN l_kv:  '|| l_kv);
     logger.info ('DYN -----------------------------------------');*/
     --перевіряємо наявність рахунку А та чи він відкритий
    if p_mode != 4 then
      select count(a.nls)
        into l_count_nls
        from bars.accounts a
       where a.nls = p_nls
       and a.kv  = l_kv
       and a.dazs is null;
    end if;

    if l_count_nls = 1 or p_mode = 4 then

      l_tmp_dynamic_layout.dk            := nvl(p_dk, 0);
      l_tmp_dynamic_layout.userid        := bars.user_id;
      l_tmp_dynamic_layout.dates_to_nazn := 0;
      l_tmp_dynamic_layout.correction    := 0;
      l_tmp_dynamic_layout.typed_percent := 0;
      l_tmp_dynamic_layout.typed_summ    := 0;
      l_tmp_dynamic_layout.branch_count  := 0;
      l_tmp_dynamic_layout.datd          := gl.bd;
      l_tmp_dynamic_layout.date_from     := trunc(trunc(bars.gl.bd, 'mm') - 1,
                                                  'mm');
      l_tmp_dynamic_layout.date_to       := trunc(bars.gl.bd, 'mm') - 1;
      l_tmp_dynamic_layout.summ          := 0;

      if p_mode = 2 then
        l_tmp_dynamic_layout.nazn := '2:Динамічний макет';
      elsif p_mode = 3 then
        l_tmp_dynamic_layout.nazn := '3:Динамічний макет';
      end if;

      if p_mode != 4 then
        select a.nls, a.ostc, substr(a.nms, 1, 38), a.kv
          into l_tmp_dynamic_layout.nls_a,
               l_tmp_dynamic_layout.ostc,
               l_tmp_dynamic_layout.nms,
               l_tmp_dynamic_layout.kv_a
          from bars.accounts a
         where a.nls = p_nls
           and a.kv  = l_kv
           and dazs is null;
      end if;

      create_dynamic_layout_detail(p_mode,
                                   p_nls,
                                   p_bs,
                                   p_ob,
                                   l_tmp_dynamic_layout.kv_a,
                                   p_grp,
                                   l_branch_count,
                                   flag);

      l_tmp_dynamic_layout.branch_count := l_branch_count;

      insert into tmp_dynamic_layout values l_tmp_dynamic_layout;

      if p_mode in (1, 4) then
        select sum(d.percent), sum(d.summ_a)
          into l_total_persents, l_total_summ
          from bars.tmp_dynamic_layout_detail d
         where d.userid = bars.user_id;

        update bars.tmp_dynamic_layout l
           set l.typed_percent = l_total_persents,
               l.typed_summ    = l_total_summ
         where l.userid = bars.user_id;
      end if;
    else
      raise_application_error(-20001,
                              'Не знайдено рахунок А або він закритий');
    end if;

  end create_dynamic_layout;

  --------------------------------------------------------------------------------
  -- update_dynamic_layout - редагування заголовоку динамічного макету
  --
  procedure update_dynamic_layout(p_nd            in tmp_dynamic_layout.nd%type,
                                  p_datd          in tmp_dynamic_layout.datd%type,
                                  p_dat_from      in tmp_dynamic_layout.date_from%type,
                                  p_dat_to        in tmp_dynamic_layout.date_to%type,
                                  p_dates_to_nazn in tmp_dynamic_layout.dates_to_nazn%type,
                                  p_nazn          in tmp_dynamic_layout.nazn%type,
                                  p_summ          in tmp_dynamic_layout.summ%type,
                                  p_corr          in tmp_dynamic_layout.correction%type) is
  begin
    update tmp_dynamic_layout t
       set t.nd            = p_nd,
           t.datd          = p_datd,
           t.date_from     = p_dat_from,
           t.date_to       = p_dat_to,
           t.dates_to_nazn = p_dates_to_nazn,
           t.nazn          = p_nazn,
           t.summ          = p_summ,
           t.correction    = p_corr
     where t.userid = bars.user_id;

    update tmp_dynamic_layout_detail d
       set d.nd = p_nd
     where d.userid = bars.user_id;

  end update_dynamic_layout;

  --------------------------------------------------------------------------------
  -- update_dynamic_layout_detail  - редагування деталей динамічного макету
  --
  procedure update_dynamic_layout_detail(p_id        in tmp_dynamic_layout_detail.id%type,
                                         p_persents  in tmp_dynamic_layout_detail.percent%type,
                                         p_summ_a    in tmp_dynamic_layout_detail.summ_a%type,
                                         p_total_sum in tmp_dynamic_layout.summ%type) is
    l_total_persents number(38, 2);
    l_total_summ     number;
    l_parent_summ    number;

  begin
    update tmp_dynamic_layout l
       set l.summ = p_total_sum
     where l.userid = bars.user_id;
    /* if p_persents != 0 and p_summ_a != 0 then
      raise_application_error(-20003,
                              'Необхідно задати або суму розподілу на бранч або вітсоток від загальної суми розподілу');
    end if;*/

    update tmp_dynamic_layout_detail d
       set d.percent = p_persents, d.summ_a = p_summ_a
     where d.id = p_id
       and d.userid = bars.user_id;

    calculate_dynamic_layout(p_id);

    select l.summ
      into l_parent_summ
      from tmp_dynamic_layout l
     where l.userid = bars.user_id;

    select sum(d.percent), sum(d.summ_a)
      into l_total_persents, l_total_summ
      from tmp_dynamic_layout_detail d
     where d.userid = bars.user_id;

    /*if l_total_persents > 100 or l_total_persents < 0 then
      --rollback;
      raise_application_error(-20002,
                              'Загальний відсоток не дорівнює 100');
    else*/
    update tmp_dynamic_layout l
       set l.typed_percent = l_total_persents, l.typed_summ = l_total_summ
     where l.userid = bars.user_id;

    update tmp_dynamic_layout_detail d
       set d.percent = p_persents
     where d.id = p_id
       and d.userid = bars.user_id
       and p_persents != 0;
    -- end if;

    /* if l_total_summ > l_parent_summ then
      --rollback;
      raise_application_error(-20002,
                              'Введена сума ' || l_total_summ / 100 ||
                              ' більне суми розподілу ' ||
                              l_parent_summ / 100);
    else*/

    update tmp_dynamic_layout_detail d
       set d.summ_a = p_summ_a
     where d.id = p_id
       and d.userid = bars.user_id
       and p_summ_a != 0;
    -- end if;
  end update_dynamic_layout_detail;

  --------------------------------------------------------------------------------
  -- update_kv_b  - зміна коду валюти рахунків Б
  --
  procedure update_kv_b(p_kvb in tmp_dynamic_layout_detail.kv%type) is
  begin
    update bars.tmp_dynamic_layout_detail d
       set d.kv = p_kvb
     where d.userid = bars.user_id;
  end update_kv_b;

  --------------------------------------------------------------------------------
  -- calculate_dynamic_layout  - розрахувати суми проведень
  --
  procedure calculate_dynamic_layout(p_id in number, flag number default 0) is
    l_layout_summ number;
  begin

    select l.summ
      into l_layout_summ
      from tmp_dynamic_layout l
     where l.userid = bars.user_id;

    for c in (select d.id, d.percent, d.summ_a, d.branch, d.summ_b, d.delta
                from tmp_dynamic_layout_detail d
               where d.userid = bars.user_id
                 and d.id = nvl(p_id, d.id)) loop

      /*logger.info('static_layout start calculate_dynamic_layout' || c.id ||
                  ' - ' || c.percent || ' - ' || c.summ_a || ' - ' ||
                  c.branch || ' - ' || c.summ_b || ' - ' || c.delta);*/

      if (l_layout_summ != 0) then
        if c.percent = 0 and c.summ_a != 0 then
          update tmp_dynamic_layout_detail l
             set l.percent = case
                               when c.summ_a / (l_layout_summ / 100) > 999 then
                                999
                               else
                                c.summ_a / (l_layout_summ / 100)
                             end,
                 l.summ_b  = c.summ_a + nvl(c.delta, 0)
           where l.id = c.id
             and l.userid = bars.user_id;

        elsif c.summ_a = 0 and c.percent != 0 then
          update tmp_dynamic_layout_detail l
             set l.summ_a =
                 (l_layout_summ / 100) * c.percent + nvl(c.delta, 0),
                 l.summ_b =
                 (l_layout_summ / 100) * c.percent + nvl(c.delta, 0)
           where l.id = c.id
             and l.userid = bars.user_id;
        elsif c.percent != 0 then

          update tmp_dynamic_layout_detail l
             set l.summ_a =
                 (l_layout_summ / 100) * c.percent + nvl(c.delta, 0),
                 l.summ_b =
                 (l_layout_summ / 100) * c.percent + nvl(c.delta, 0)
           where l.id = c.id
             and l.userid = bars.user_id;

        elsif c.summ_a != 0 then
          update tmp_dynamic_layout_detail l
             set l.percent = case
                               when c.summ_a / (l_layout_summ / 100) > 999 then
                                999
                               else
                                c.summ_a  / (l_layout_summ / 100)
                             end,
                 l.summ_b  = c.summ_a + nvl(c.delta, 0)
           where l.id = c.id
             and l.userid = bars.user_id;

             --додавання логіки тільки  для макетів юридичних осіб
             --коли процентна ставка = 0 і введено тільки константу (DELTA)
        elsif (flag = 1 and c.summ_a = 0 and c.percent = 0 and nvl(c.delta, 0) != 0) then
              update tmp_dynamic_layout_detail l
                set  l.summ_a  = nvl(c.delta, 0),
                     l.summ_b  = nvl(c.delta, 0)
              where l.id = c.id
              and l.userid = bars.user_id;

        end if;
      end if;
    end loop;
  end calculate_dynamic_layout;

  --------------------------------------------------------------------------------
  -- calculate_static_layout  - розрахувати суми проведень
  --
  procedure calculate_static_layout is
    l_total_persents number(38, 3);
    l_total_summ     number;
    l_parent_summ    number;
  begin
    select sum(d.percent), sum(d.summ_a)
      into l_total_persents, l_total_summ
      from tmp_dynamic_layout_detail d
     where d.userid = bars.user_id;

    update tmp_dynamic_layout l
       set l.typed_percent = case
                               when l_total_persents > 999 then
                                999
                               else
                                l_total_persents
                             end,
           l.typed_summ    = l_total_summ
     where l.userid = bars.user_id;
  end calculate_static_layout;

  --------------------------------------------------------------------------------
  -- add_static_layout - додавання/редагування дочірнього запису
  --
  procedure add_static_layout(p_id      in tmp_dynamic_layout_detail.id%type,
                              p_dk      in tmp_dynamic_layout_detail.dk%type,
                              p_nd      in tmp_dynamic_layout_detail.nd%type,
                              p_kv      in tmp_dynamic_layout_detail.kv%type,
                              p_nlsa    in tmp_dynamic_layout_detail.nls_a%type,
                              p_nam_a   in tmp_dynamic_layout_detail.nama%type,
                              p_okpo_a  in tmp_dynamic_layout_detail.okpoa%type,
                              p_mfo_b   in tmp_dynamic_layout_detail.mfob%type,
                              p_nls_b   in tmp_dynamic_layout_detail.nls_b%type,
                              p_nam_b   in tmp_dynamic_layout_detail.namb%type,
                              p_okpo_b  in tmp_dynamic_layout_detail.okpob%type,
                              p_percent in tmp_dynamic_layout_detail.percent%type,
                              p_sum_a   in tmp_dynamic_layout_detail.summ_a%type,
                              p_sum_b   in tmp_dynamic_layout_detail.summ_b%type,
                              p_delta   in tmp_dynamic_layout_detail.delta%type,
                              p_tt      in tmp_dynamic_layout_detail.tt%type,
                              p_vob     in tmp_dynamic_layout_detail.vob%type,
                              p_nazn    in tmp_dynamic_layout_detail.nazn%type,
                              p_ord     in mf1.ord%type,
                              flag number default 0 ) is
    l_mf1            bars.mf1%rowtype;
    l_dyn            bars.tmp_dynamic_layout_detail%rowtype;
    l_total_persents number(5, 2);
    l_total_summ     number;
    l_parent_summ    number;
    l_header_nazn    ope_lot.nazn1%type;
    l_ostc           number(38, 2);
    l_okpo_a         bars.tmp_dynamic_layout_detail.okpoa%type;
  begin

    begin
      select a.nls, substr(a.nms, 1, 38), a.ostc / 100
        into l_mf1.nlsa, l_mf1.nam_a, l_ostc
        from bars.accounts a
       where a.nls = p_nlsa
         and (a.dazs is null or a.dazs > gl.bd)
         and a.kv = p_kv;
    exception
      when no_data_found then
        raise_application_error(-20001,
                                'Рахунок А закритий або від не існує');
    end;

    l_mf1.kva := p_kv;

    begin
      select b.mfo, b.nb
        into l_mf1.mfob, l_dyn.mfob_name
        from bars.banks b
       where b.mfo = p_mfo_b
         and b.blk = 0;
    exception
      when no_data_found then
        raise_application_error(-20001,
                                'МФО отримувача не існує або заблоковано');
    end;

    l_mf1.nlsb := p_nls_b;
    l_mf1.kvb  := p_kv;

    begin
      select t.tt into l_mf1.tt from bars.tts t where t.tt = p_tt;
    exception
      when no_data_found then
        raise_application_error(-20001,
                                'Вказаний вид операції не знайдено');
    end;

    begin
      select v.vob into l_mf1.vob from bars.vob v where v.vob = p_vob;
    exception
      when no_data_found then
        raise_application_error(-20001,
                                'Вказаний вид документу не знайдено');
    end;
   ----------------------*******Для макетів юр осіб********** 
    l_okpo_a := p_okpo_a;
   
    if ( flag = 1 and p_okpo_a is null) then
        begin 
        
            select distinct okpo into l_okpo_a from customer 
            where rnk = (select rnk from accounts where nls=p_nlsa and kv = p_kv)
                  and date_off is null ;
        end;         
     end if;     
    ------------------***************************************
    if ( flag = 1 and p_okpo_a is null) then
        begin

            select distinct okpo into l_okpo_a from customer
            where rnk = (select rnk from accounts where nls=p_nlsa and kv = p_kv)
                  and date_off is null ;
        end;
     end if;
    ------------------***************************************
    l_mf1.nd    := null;
    l_mf1.datd  := gl.bd;
    l_mf1.s     := null;
    l_mf1.nam_b := p_nam_b;
    l_mf1.nazn  := p_nazn;
    
    if flag =1 then l_mf1.okpoa := l_okpo_a;
               else begin 
			        --http://jira.unity-bars.com:11000/browse/COBUMMFO-6492
                    select distinct okpo into l_okpo_a from customer where rnk = (select rnk from accounts where nls=p_nlsa and kv = p_kv) and date_off is null;
                    l_mf1.okpoa := l_okpo_a;
                    end;
    end if;
    
--    l_mf1.okpoa := case when flag =1 then l_okpo_a else
--                                                        (select distinct okpo into l_okpo_a from customer 
--                                                        where rnk = (select rnk from accounts where nls=p_nlsa and kv = p_kv) and date_off is null) 
--                                                         
--                                                        end; /*f_ourokpo */
    l_mf1.okpob := p_okpo_b;

    begin
      select distinct d.nls_count
        into l_mf1.grp
        from bars.Tmp_Dynamic_Layout_Detail d
       where d.userid = bars.user_id;
    exception
      when others then
        select l.branch_count
          into l_mf1.grp
          from bars.Tmp_Dynamic_Layout l
         where l.userid = bars.user_id;
    end;

    l_mf1.ref   := null;
    l_mf1.sos   := 5;
    l_mf1.id := case
                  when p_id = 0 then
                   null --s_mf1.nextval
                  else
                   p_id
                end;
    l_mf1.s_100 := null;
    l_mf1.dk    := p_dk;
    l_mf1.prc   := p_percent;
    l_mf1.delta := nvl(p_delta, 0) * 100;
    l_mf1.ord   := p_ord;

    select o.nazn1
      into l_header_nazn
      from ope_lot o
     where o.grp = l_mf1.grp;

    if (p_nazn = l_header_nazn) then
      l_mf1.nazn := null;
    end if;

    update bars.mf1 m
       set m.nlsa  = l_mf1.nlsa,
           m.kva   = l_mf1.kva,
           m.mfob  = l_mf1.mfob,
           m.nlsb  = l_mf1.nlsb,
           m.kvb   = l_mf1.kvb,
           m.tt    = l_mf1.tt,
           m.vob   = l_mf1.vob,
           m.datd  = l_mf1.datd,
           m.nam_a = l_mf1.nam_a,
           m.nam_b = l_mf1.nam_b,
           m.nazn  = l_mf1.nazn,
           m.okpoa = l_mf1.okpoa,
           m.okpob = l_mf1.okpob,
           m.dk    = l_mf1.dk,
           m.prc   = l_mf1.prc,
           m.delta = l_mf1.delta,
           m.ord   = l_mf1.ord
     where m.id = p_id;
    if sql%rowcount = 0 then
      l_mf1.kf:= sys_context('bars_context','user_mfo');
      insert into bars.mf1 m values l_mf1;
      select max(id) into l_mf1.id from mf1 where grp = l_mf1.grp;
    end if;

    select l.nazn
      into l_dyn.nazn
      from bars.tmp_dynamic_layout l
     where l.userid = bars.user_id;

    /*bars_audit.info('static_layout ' || p_sum_a || ' - ' || p_delta ||
                    ' - ' || l_mf1.prc || ' - ' || l_mf1.id);*/

    update bars.tmp_dynamic_layout_detail d
       set d.dk          = l_mf1.dk,
           d.nd          = p_nd,
           d.kv          = l_mf1.kva,
           d.branch_name = l_ostc,
           d.nls_a       = l_mf1.nlsa,
           d.nama        = l_mf1.nam_a,
           d.okpoa       = l_mf1.okpoa,
           d.mfob        = l_mf1.mfob,
           d.mfob_name   = l_dyn.mfob_name,
           d.nls_b       = l_mf1.nlsb,
           d.namb        = l_mf1.nam_b,
           d.okpob       = l_mf1.okpob,
           d.percent     = l_mf1.prc,
           d.summ_a = case when flag =1 then p_sum_a * 100
                           else
                              case
                                when p_sum_a = 0 and l_mf1.prc != 0 then
                                 nvl(p_delta, 0) * 100
                                else
                                 p_sum_a * 100 + nvl(p_delta, 0) * 100
                              end
                            end,
           d.summ_b = case when flag =1 then p_sum_a * 100
                           else
                              case
                                when p_sum_a = 0 and l_mf1.prc != 0 then
                                 nvl(p_delta, 0) * 100
                                else
                                 p_sum_a * 100 + nvl(p_delta, 0) * 100
                              end
                           end,
           d.delta       = p_delta * 100,
           d.tt          = l_mf1.tt,
           d.vob         = l_mf1.vob,
           d.nazn        = nvl(l_mf1.nazn, l_dyn.nazn)
     where d.id = l_mf1.id
       and d.userid = bars.user_id;
    if sql%rowcount = 0 then
      insert into bars.tmp_dynamic_layout_detail
      values
        (l_mf1.id,
         l_mf1.dk,
         p_nd,
         l_mf1.kva,
         null,
         l_ostc,
         l_mf1.nlsa,
         l_mf1.nam_a,
         l_mf1.okpoa,
         l_mf1.mfob,
         l_dyn.mfob_name,
         l_mf1.nlsb,
         l_mf1.nam_b,
         l_mf1.okpob,
         l_mf1.prc,
         case when flag = 0 then p_sum_a * 100 + nvl(p_delta, 0) * 100 else p_sum_a * 100 end ,
         case when flag = 0 then p_sum_a * 100 + nvl(p_delta, 0) * 100 else p_sum_a * 100 end,
         l_mf1.delta,
         l_mf1.tt,
         l_mf1.vob,
         nvl(l_mf1.nazn, l_dyn.nazn),
         null,
         l_mf1.grp,
         bars.user_id);
    end if;

    select sum(d.percent), sum(d.summ_a)
      into l_total_persents, l_total_summ
      from tmp_dynamic_layout_detail d
     where d.userid = bars.user_id;

    update tmp_dynamic_layout l
       set l.typed_percent = l_total_persents,
           l.typed_summ    = l_total_summ,
           l.nd            = p_nd
     where l.userid = bars.user_id;

    /*update tmp_dynamic_layout l
      set l.typed_percent = l_total_persents, l.typed_summ = l_total_summ
    where l.userid = bars.user_id;*/
    --bars_audit.info('l_mf1.id=' || l_mf1.id);
    calculate_dynamic_layout(l_mf1.id);

  exception
    when others then
      bars_audit.info('static_layout ' ||
                      DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
      raise;
  end add_static_layout;

  --------------------------------------------------------------------------------
  -- delete_static_layout - видалення дочірнього запису
  --
  procedure delete_static_layout(p_grp in tmp_dynamic_layout_detail.nls_count%type,
                                 p_id  in tmp_dynamic_layout_detail.id%type) is
    l_total_persents number(5, 2);
    l_total_summ     number;
    l_parent_summ    number;
  begin

    delete from bars.tmp_dynamic_layout_detail d
     where d.nls_count = p_grp
       and d.id = p_id
       and d.userid = bars.user_id;
    delete from bars.mf1 m
     where m.grp = p_grp
       and m.id = p_id;

    select sum(d.percent), sum(d.summ_a)
      into l_total_persents, l_total_summ
      from tmp_dynamic_layout_detail d
     where d.userid = bars.user_id;

    update tmp_dynamic_layout l
       set l.typed_percent = l_total_persents, l.typed_summ = l_total_summ
     where l.userid = bars.user_id;

  end delete_static_layout;

  --------------------------------------------------------------------------------
  -- pay_dynamic_layout  - виконати проведення
  --
  procedure pay_dynamic_layout(p_mak number, p_nd varchar2) is
    oo oper%rowtype;
    aa TMP_DYNAMIC_LAYOUT%rowtype; --  Макет динамічних проводок (заголовок)
  begin

    begin
      select z.*
        into aa
        from TMP_DYNAMIC_LAYOUT z
       where z.nd = p_nd
         and z.USERID = gl.aUid
         and z.ref is null
         FOR UPDATE OF z.ref;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        raise_application_error(-20000,
                                'Не знайдено в заг.№ док ' || p_nd ||
                                ' для користувача ' || gl.aUid);
    END;

    If nvl(aa.SUMM, 0) < 1 then
      raise_application_error(-20000, 'Не вірна за.сума');
    end if;

    select nvl(sum(d.SUMM_A), 0)
      into oo.s
      from TMP_DYNAMIC_LAYOUT_DETAIL d --- Деталі макету динамічних проводок
     where d.nd = aa.nd
       and d.userid = aa.userid
       and d.SUMM_A >= 1;

    If oo.s <> aa.SUMM then
      raise_application_error(-20000,
                              'Не збалансовано по сумі зал та деталі');
    end if;

    If aa.dk = 1 then
      oo.tt  := 'SMO';
      oo.Vob := -6;
    else
      oo.TT  := 'ZMO';
      oo.Vob := -7;
    end if;
    oo.dk    := aa.dk;
    oo.nd    := aa.nd;
    oo.kv    := aa.kv_a;
    oo.nd    := substr(p_nd, 1, 10);
    oo.datd  := aa.datd;
    oo.nam_a := substr(aa.nms, 1, 38);
    oo.nazn  := substr(aa.nazn, 1, 160); -- DATES_TO_NAZN -Ознака додавання дати з та дати по до призначення платежу(0 - ні, 1 - так
    If aa.CORRECTION = 1 then
      oo.vob := 96;
    end if;

    for bb in (select *
                 from TMP_DYNAMIC_LAYOUT_DETAIL
                where summ_a >= 1
                  and userid = bars.user_id) loop
      If oo.ref is null then
        gl.REF(oo.REF);
        begin
          select substr(nms, 1, 38)
            into oo.nam_b
            from accounts
           where kv = bb.kv
             and nls = bb.nls_b;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            raise_application_error(-20000,
                                    'Не знайдено в дет рах Б');
        END;
        gl.in_doc3(ref_   => oo.REF,
                   tt_    => oo.tt,
                   vob_   => oo.vob,
                   nd_    => oo.nd,
                   pdat_  => SYSDATE,
                   vdat_  => gl.bdate,
                   dk_    => oo.dk,
                   kv_    => oo.kv,
                   s_     => oo.S,
                   kv2_   => bb.kv,
                   s2_    => null,
                   sk_    => NULL,
                   data_  => oo.datd,
                   datp_  => gl.bdate,
                   nam_a_ => oo.nam_a,
                   nlsa_  => aa.nls_a,
                   mfoa_  => gl.aMfo,
                   nam_b_ => oo.nam_b,
                   nlsb_  => bb.nls_b,
                   mfob_  => gl.aMfo,
                   nazn_  => oo.nazn,
                   d_rec_ => NULL,
                   id_a_  => gl.aOkpo,
                   id_b_  => gl.Aokpo,
                   id_o_  => NULL,
                   sign_  => NULL,
                   sos_   => 1,
                   prty_  => NULL,
                   uid_   => NULL);
      end if;
      gl.payv(0,
              oo.REF,
              gl.bdate,
              'PS1',
              oo.dk,
              oo.kv,
              aa.nls_a,
              bb.summ_a,
              bb.kv,
              bb.nls_b,
              bb.summ_b);
      update opldok
         set txt = bb.BRANCH
       where ref = oo.Ref
         and stmt = gl.aStmt;
    end loop;
    update TMP_DYNAMIC_LAYOUT
       set REF = oo.ref
     where nd = p_nd
       and USERID = gl.aUid;
  end pay_dynamic_layout;

  --------------------------------------------------------------------------------
  -- pay_Static_layout  - виконати проведення
  --
  procedure pay_Static_layout(p_mak number) is
    oo oper%rowtype;
  begin
    for bb in (select *
                 from TMP_DYNAMIC_LAYOUT_DETAIL
                where summ_a >= 1
                  and userid = bars.user_id) loop
   --   bars_audit.info('pay_Static_layout id = ' || bb.id);
      gl.REF(oo.REF);
      gl.in_doc3(ref_   => oo.REF,
                 tt_    => bb.tt,
                 vob_   => bb.vob,
                 nd_    => nvl(bb.nd,
                               trim(substr('          ' || oo.ref, -10))),
                 pdat_  => SYSDATE,
                 vdat_  => gl.bdate,
                 dk_    => bb.dk,
                 kv_    => bb.kv,
                 s_     => bb.SUMM_A,
                 kv2_   => bb.kv,
                 s2_    => bb.SUMM_A,
                 sk_    => NULL,
                 data_  => gl.bdate,
                 datp_  => gl.bdate,
                 nam_a_ => bb.NAMA,
                 nlsa_  => bb.nls_a,
                 mfoa_  => gl.aMfo,
                 nam_b_ => bb.NAMB,
                 nlsb_  => bb.nls_b,
                 mfob_  => bb.MFOB,
                 nazn_  => bb.nazn,
                 d_rec_ => NULL,
                 id_a_  => bb.OkpoA,
                 id_b_  => bb.okpoB,
                 id_o_  => NULL,
                 sign_  => NULL,
                 sos_   => 1,
                 prty_  => NULL,
                 uid_   => NULL);

      paytt(0,
            oo.REF,
            gl.bdate,
            bb.tt,
            bb.dk,
            bb.kv,
            bb.nls_a,
            bb.summ_a,
            bb.kv,
            bb.nls_b,
            bb.summ_a);
      update opldok
         set txt = bb.BRANCH
       where ref = oo.Ref
         and stmt = gl.aStmt
         and bb.BRANCH is not null;

      update TMP_DYNAMIC_LAYOUT_DETAIL
         set REF = oo.ref
       where id = bb.id
         and USERID = gl.aUid;

      --bars_audit.info('ref=' || oo.ref);

    end loop;
  end pay_Static_layout;

begin
  -- Initialization
  null;
end dynamic_layout_ui;
/

 show err;
 
PROMPT *** Create  grants  DYNAMIC_LAYOUT_UI ***
grant EXECUTE on DYNAMIC_LAYOUT_UI to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/package/dynamic_layout_ui.sql =========*** E
PROMPT ===================================================================================== 