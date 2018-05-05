create or replace package cp_rep_dgp is

  -- Author  : SERHII.HONCHARUK
  -- Created : 25.09.2017 10:34:23
  -- Purpose : фін. звітність по ЦП (DGP-7, 8, 9)

  G_HEADER_VERSION constant varchar2(64) := 'v.1.0  25.09.2017';

  procedure prepare_dgp(p_date_from cp_dgp_zv.date_from%type,
                        p_date_to   cp_dgp_zv.date_to%type,
                        p_type_id   cp_dgp_zv_type.type_id%type);

end cp_rep_dgp;
/
create or replace package body cp_rep_dgp is
  G_BODY_VERSION constant varchar2(64) := 'v.1.8  17.04.2018';
  G_TRACE        constant varchar2(20) := 'CP_REP_DGP.';
  -----
  cursor G_CUR (p_nlsb_arr string_list, p_date_from date, p_date_to date)

  is
              select e.ID,
                     e.RYN,
                     e.ACC,
                     e.REF,
                     -a.ostc / 100 sa,
                     o.nd,
                     o.vdat dat_k,
                     ar.sumb / 100 sumb,
                     ar.ref_repo,
                     ar.n / 100 sumn,
                     ar.nom, 
                     ar.stiket,
                     ar.op,
                     ar.ref_main, -- rnbu
                     substr(a.nls, 1, 4) nbs1,
                     o.s / 100 s_kupl,
                     a.kv,
                     a.pap,
                     a.rnk,
                     k.rnk rnk_e,
                     a.grp,
                     a.isp,
                     a.mdate,
                     a.nls,
                     substr(a.nms, 1, 38) nms,
                     e.accD,
                     e.accP,
                     e.accR,
                     e.accR2,
                     e.accR3,
                     e.AccS,
                     substr(d.nms, 1, 38) nms_d,
                     substr(p.nms, 1, 38) nms_p,
                     substr(r.nms, 1, 38) nms_r,
                     substr(r2.nms, 1, 38) nms_r2,
                     substr(s.nms, 1, 38) nms_s,
                     a.pap pap_n,
                     d.pap pap_d,
                     p.pap pap_p,
                     s.pap pap_s,
                     r.pap pap_r,
                     r2.pap pap_r2,
                     k.cp_id,
                     k.emi,
                     k.DATP dat_pg,
                     k.dat_em,
                     k.ir,
                     k.cena,
                     nvl(k.cena_start, k.cena) cena_start,
                     -d.ostc / 100 sd,
                     d.nls NLSD,
                     -p.ostc / 100 sp,
                     p.nls NLSP,
                     -nvl(r.ostc, 0) / 100 sr,
                     r.nls NLSR,
                     -nvl(r2.ostc, 0) / 100 sr2,
                     r2.nls NLSR2,
                     -s.ostc / 100 ss,
                     s.nls nlss,
                     k.ky,
                     k.name,
                     c.okpo,
                     c.nmkk nmk,
                     k.dox,
                     e.initial_ref,
                     e.dat_bay,
                     e.op e_op,
                     e.ref_new,
                     e.dat_ug,
                     ks.title,
                     nvl(c.prinsider, 99) prinsider,
                     e.accunrec,
                     e.accexpr
                from cp_deal  e,
                     cp_kod   k,
                     cp_spec_cond ks,
                     oper     o,
                     cp_arch  ar,
                     accounts a,
                     accounts d,
                     accounts p,
                     accounts r,
                     accounts r2,
                     accounts r3,
                     accounts s,
                     customer c
               where (e.acc = a.acc and substr(a.nls, 1, 1) != '8' and
                     k.dox > 1 or nvl(e.accd, e.accp) = a.acc and k.dox = 1)
                 --and (a.dapp > p_date_from - 3 or a.ostc != 0 or a.ostb != 0)
                 and substr(a.nls, 1, 4) in (select column_value from table( p_nlsb_arr ))
                 and o.vdat between p_date_from and p_date_to --
                 and e.id = k.id
                 and k.rnk = c.rnk(+)
                 and o.ref = e.ref
                 and e.ref = ar.ref
                 and e.accd = d.acc(+)
                 and e.accp = p.acc(+)
                 and e.accr = r.acc(+)
                 and e.accr2 = r2.acc(+)
                 and e.accr3 = r3.acc(+)
                 and e.accs = s.acc(+)
                 and k.spec_cond_id = ks.id(+)
                 and k.tip = 1 --and k.country=804  --and k.kv=980
                 --and nvl(k.datp, to_date('01/01/2050', 'dd/mm/yyyy')) > p_date_from
                 --and rez.ostc96(e.acc, p_date_from - 1) != 0
                    --  and k.dox > 1        -- 1 - акції 2 - БЦП
                 and o.sos = 5 --- and k.emi in (0,6) -- держ/НЕ держ/інв
               order by 4; --1,3,4
  -----------------------------------------------------------------


  function header_version return varchar2 is
  begin
    return 'package header cp_rep_dgp: ' || G_HEADER_VERSION || chr(10);
  end header_version;
  -----------------------------------------------------------------
  function body_version return varchar2 is
  begin
    return 'package body cp_rep_dgp: ' || G_BODY_VERSION || chr(10);
  end body_version;
  -----------------------------------------------------------------
  function get_type_bcp(p_id cp_kod.id%type) return varchar2 is
    l_t_bcp varchar2(1) := 'S';
  begin
    /* існує дод. реквізити на ЦП
       select * from CP_KODW t where t.tag = 'TYPCP'
       поки банк надав наступний алгоритм:
       "Признак дисконтных можно определить так:
       Справочник -"вид доходности" = 2 (боргови)+ справочник "коды ЦП" (годовая номин % ставка) = 0.
       Это и будут дисконтные бумаги"
    */
    begin
      select 'D' into l_t_bcp from cp_kod c where c.id = p_id and c.dox = 2 and nvl(c.ir,0) = 0;
      exception
        when NO_DATA_FOUND then
          l_t_bcp := 'S';
    end;
    return l_t_bcp;
  end;

  function get_class_cp(p_id cp_kod.id%type, p_nlsb varchar2, p_nlspb varchar2) return varchar2 is
    l_pf        cp_vidd.pf%type;
    l_class_cp  varchar2(1);
  begin
    begin
      select v.pf into l_pf from cp_kod c, cp_vidd v where c.id = p_id and c.emi = v.emi and v.vidd in (p_nlsb, p_nlspb);
    exception
      when NO_DATA_FOUND then
        l_pf := 99;
    end;
    if l_pf = 1 then
      l_class_cp := 2;
    elsif l_pf = 4 then
      l_class_cp := 1;
    elsif l_pf = 3 then
      l_class_cp := 3;
    else
      l_class_cp := null;
    end if;
    return l_class_cp;
  end;

  function get_cp_refw(p_ref cp_deal.ref%type, p_tag cp_refw.tag%type) return varchar2 is
    l_val cp_refw.value%type;
  begin
    begin
      select substr(value, 1, 255) into l_val from cp_refw where ref = p_ref and tag = p_tag;
      exception
        when NO_DATA_FOUND then
          l_val := null;
    end;
    return l_val;
  end;

  function get_cp_kodw(p_id cp_kod.id%type, p_tag cp_kodw.tag%type) return varchar2 is
    l_val cp_kodw.value%type;
  begin
    begin
      select substr(value, 1, 255) into l_val from cp_kodw where id = p_id and tag = p_tag;
      exception
        when NO_DATA_FOUND then
          l_val := null;
    end;
    return l_val;
  end;

  function get_pay_period(l_ky cp_kod.ky%type) return varchar2 is
    l_period varchar2(255);
  begin
    if l_ky = 1 then
      l_period := 'щорічно';
    elsif l_ky = 2 then
      l_period := 'раз на півроку';
    elsif l_ky = 4 then
      l_period := 'щоквартально';
    elsif l_ky = 12 then --на всяк випадок
      l_period := 'щомісячно';
    else
      l_period := 'невказано';
    end if;
    return l_period;
  end;

  function get_kontragent(p_ref int,
                          p_isk varchar2 default 'Контрагенту',
                          p_vx  int default 1) return varchar is
    l_title         constant varchar2(25) := 'get_kontragent: ';                          
    l_ref  int;
    ttt1   varchar2(4000);
    pos    int; --  Контрагенту  :АБ "ПОЛТАВА-Банк"
    l_isk  varchar2(15); --  Вiд контрагенту:
    l_name varchar2(30);
  begin
    l_ref := P_ref;
    l_isk := P_isk;
    begin
      select get_stiket(l_ref) into ttt1 from dual;
      exception
        when others then
          bars_audit.error(G_TRACE || l_title ||' l_ref='||l_ref||' '|| substr(dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace(), 1, 2000));
          ttt1 := null;
    end;
    if ttt1 is null then
      return '***?';
    end if;
    select instr(ttt1, l_isk, 1, p_vx) into pos from dual;
    if pos != 0 then
      l_name := substr(ttt1, pos + 14, 30);
    else
      l_name := '??';
    end if;
    return l_name;
  end get_kontragent;

  --% ставка на дату
  function get_hist_ir(p_id cp_kod.id%type, p_date date) return number is
    l_ir cp_kod_update.ir%type;
  begin
    begin
      select ir into l_ir from cp_kod_update c where c.idupd = (select max(idupd) from cp_kod_update where id = p_id and effectdate <= p_date);
      exception
        when NO_DATA_FOUND then
          l_ir := null;
    end;
    return l_ir;
  end;

  function get_cena_voprosa(p_id cp_kod.id%type, p_date date, p_cena cp_kod.cena%type, p_cena_start cp_kod.cena_start%type)   return number is
    l_cena     cp_kod.cena%type;
  begin
    if p_cena != p_cena_start then
      begin
        select p_cena_start - sum(nvl(a.nom, 0))
          into l_cena
          from cp_dat a
         where a.id = p_id
           and a.DOK <= p_date;
         exception
           when NO_DATA_FOUND then l_cena := p_cena_start;
      end;
      else
        l_cena := p_cena_start;
    end if;
    return  l_cena;
  end;

  function get_count_cp(p_id cp_kod.id%type, p_date date, p_cena cp_kod.cena%type, p_cena_start cp_kod.cena_start%type, p_acc cp_deal.acc%type,
                        p_nom out number ) --копитом вгрудь залишок на дату (номінальна вартість)
  return number is
    l_cena     cp_kod.cena%type;
    l_cnt_cp   number;
  begin
    l_cena := get_cena_voprosa(p_id, p_date + 1, p_cena, p_cena_start);

    select -rez.ostc96(p_acc, p_date) / 100 into p_nom from dual;

    l_cnt_cp := round(p_nom / l_cena, 0);

    return l_cnt_cp;
  end get_count_cp;


  function get_turnaround(p_ref opldok.ref%type, p_acc opldok.acc%type) return number is
    l_sum number := 0;
  begin
    --чого тут зразу в эквіваленті не взяти? скозлив зі староъ версії формування звіту бо там було проставлено у поля що вірно сума тягнеться
    select nvl(sum(decode(o.dk, 0, 1, 0) * o.s), 0) / 100 --, nvl(sum(decode(o.dk,0,1,0)*o.sq),0)/100,
      into l_sum
      from opldok o
     where o.ref = p_ref
       and acc = p_acc;
    return l_sum;
  end;

  function get_days_delay(p_ref cp_deal.ref%type, p_date date) return number is
    l_c number;
  begin
    for cur in (select p.days_corr
                from prvn_loss_delay_days p
                where p.ref_agr = p_ref
                  and p.reporting_date =
                                          (select max(reporting_date) from prvn_loss_delay_days
                                           where ref_agr = p_ref and reporting_date <= p_date)
                 order by p.zo desc)
    loop     --пріоритет з zo = 1
      l_c := cur.days_corr;
      return l_c;
    end loop;
    return l_c;
  end;

  function get_riven(p_id cp_kod.id%type, p_date date) return number is
    l_r number;
  begin
    select c.hierarchy_id
    into l_r
    from cp_hierarchy_hist c where c.cp_id = p_id
                                 and c.fdat = (select max(fdat)
                                               from cp_hierarchy_hist
                                               where cp_id = p_id and fdat <= p_date);
    return l_r;
    exception
      when no_data_found then
        return null;
  end;


  function get_is_default(p_ref cp_deal.ref%type, p_date date) return number is
    l_c number;
  begin
    /*Підказка від Людмила Марценюк
    ID_CALC_SET - дата - всегда последний день месяца ГГММДДСС
    СС - номер сессии приема файла (наверно возможно за одну дату несколько сессий , но в расчет должна быть одна максимальная)
    */
    /* СС в розрахунок не брав */
    
    /* 19.03.2018 від Людмила Марценюк
       Меняется структура таблицы  prvn_fv_rez
       Индексы учтем, но наверное в новой таблице. 
       IS_DEFAULT - вообще убрали.
    select is_default
      into l_c
      from bars.prvn_fv_rez
     where unique_bars_is = '9/' || p_ref
       and substr(id_calc_set, 1, 6) =
                                      (select max(substr(id_calc_set, 1, 6))
                                        from bars.prvn_fv_rez
                                       where unique_bars_is = '9/' || p_ref
                                         and to_date(substr(id_calc_set, 1, 6), 'YYMMDD') <= p_date)
       and rownum = 1;
    return l_c;
    exception
      when NO_DATA_FOUND then
        l_c := null;
        return l_c;
        
     */
    return null;    
  end;

  function get_ss_kor(p_accs cp_deal.accs%type, p_date date) return number is
    l_c number;
  begin
    if p_accs is not null then
        select sum(decode(o.dk, 0, 1, 1, -1) * o.sq) / 100
          into l_c                                                                         --3115 - згортання переоцінки - ручні корегуючі
          from opldok o, opldok o2
         where o.dk = 1 - o2.dk
           and o.stmt = o2.stmt
           and o.tt = '096'
           and o2.tt = '096'
           and o.ref = o2.ref
           and o2.acc = p_accs
           and o2.fdat <= p_date
           and o.sos = 5;
    end if;
    return nvl(l_c, 0);
  end;

  function get_rezq39(p_ref cp_deal.ref%type, p_date date) return number is
    l_c number;
  begin
    -- Сума резерву, розрахованого згідно вимог МСБО 39 на початок звітного періоду
      select sum(rezq39)
      into l_c
      from nbu23_rez where tipa=9 and nd = p_ref and
                           fdat = (select max(fdat) from  nbu23_rez
                                   where tipa=9 and nd = p_ref and
                                   fdat <= p_date);
      return l_c;
  end;

  procedure send_msg( p_txt varchar2 )
  is
  begin
    if getglobaloption('BMS')='1' then -- BMS Признак: 1-установлена рассылка сообщений
    -- bms.add_subscriber( gl.aUid);
       bms.enqueue_msg( p_txt, dbms_aq.no_delay, dbms_aq.never, gl.aUid );
    end if;
--    bars_audit.info( 'OSA=>BMS:'||p_txt );
  end send_msg;

  --існує стара версія звіту: процедура cp_zv_D , таблиця tmp_cp_zv, вйуха v_cp_zv7k
  /* Населення данними для звіту DGP-007:
     "Інвестиції в боргові цінні папери, окрім державних"
  */
  procedure dgp7(p_date_from cp_dgp_zv.date_from%type,
                 p_date_to   cp_dgp_zv.date_to%type) is
    l_title         constant varchar2(25) := 'dgp7: ';
    l_cp_dgp_zv_row cp_dgp_zv%rowtype;
    l_nlsb_arr      string_list := string_list('3010', '3011', '3012', '3013', '3014', '3110', '3111', '3112', '3113', '3114', '3210', '3211', '3212', '3213', '3214');
    l_cnt           pls_integer := 0;

    --блок змінних для залишків на рахунках по даті або суми оборотів
    l_sd            number;--дисконт
    l_sp            number;--премія
    l_sr            number;--R
    l_sr2           number;--R2
    l_sr3           number;--R3
    l_ss            number;--переоцінка
    --l_ss_kor        number;--переоцінка корегуючі
    l_sn            number;--номінал
    l_sb            number;--балансова вартість (складається з суми/різниці попередніх)
    l_sr_ur         number;--невизн. доходи
    l_sr_expr       number;--проср. нарах куп.
    l_rez           number;--сума резерву
    ----------------
    l_zp            number;
    l_rp            number;
    --
    l_cena_bay_n    number;
    l_cena          number;
    l_kl            number;
    l_koeff         number;
    ----------------
    l_dat_k2        date;
    ----------------
    l_dnk           date;
    ----------------
    l_cnt_prod      pls_integer;
    l_days_cnt      pls_integer;
    l_is_default    number(1);
    --
    l_chr_start_time number;
    l_chr_end_time   number;
    --
    k               G_CUR%ROWTYPE;

  begin

    open G_CUR(l_nlsb_arr, p_date_from, p_date_to);
    loop
      FETCH G_CUR INTO k;
      EXIT WHEN G_CUR%NOTFOUND;
      l_cnt := l_cnt + 1;
      /*системні значення*/
      l_cp_dgp_zv_row.ref       := k.ref;
      l_cp_dgp_zv_row.id        := k.id;
      l_cp_dgp_zv_row.type_id   := 7;
      l_cp_dgp_zv_row.date_from := p_date_from;
      l_cp_dgp_zv_row.date_to   := p_date_to;
      l_cp_dgp_zv_row.user_id   := user_id();
      l_cp_dgp_zv_row.date_reg  := sysdate;
      l_cp_dgp_zv_row.kf        := gl.kf;
      ---------
      l_cp_dgp_zv_row.g001 := k.nbs1;                                                       --Номер балансового рахунку
      l_cp_dgp_zv_row.g002 := 'ні';                                                         --РЕПО (так/ні)
      l_cp_dgp_zv_row.g003 := nvl(get_cp_kodw(k.id, 'TPCP'), get_type_bcp(k.id));          --на тест--на уточнені(будуть заповнювати, але незручно, хочуть провалення з угод)--Тип боргового цінного паперу
      l_cp_dgp_zv_row.g004 := k.kv;                                                         --Валюта (код)
      l_cp_dgp_zv_row.g005 := get_class_cp(k.id, k.nbs1, nvl(substr(k.nlsp, 1, 4), ''));    --Класифікація цінних паперів (1-торговельні, 2-у наявності для продажу, 3-утримувані до погашення)
      l_cp_dgp_zv_row.g006 := nvl(k.title, get_cp_kodw(k.id, 'OS_UM'));                     --Наявність особливих умов
      l_cp_dgp_zv_row.g007 := nvl(k.nmk, '***');                                            --Назва емітента
      l_cp_dgp_zv_row.g008 := k.okpo;                                                        --Код ЄДРПОУ
      l_cp_dgp_zv_row.g009 := case when k.prinsider = 99 then 'ні' else 'так' end;           --на тест--на уточнені у Овчарука-Квашук--Пов'язана сторона (так/ні)
      l_cp_dgp_zv_row.g010 := get_cp_kodw(k.id, 'KLCPE');                                   --на тест--на уточнені--Класифікація цінних паперів в залежності від емітента
--      raise_application_error(-20001, 'k.ryn='||k.ryn||' k.ref='||k.ref);
      select series
      into l_cp_dgp_zv_row.g011                                                             --на тест--переуточнити--Серія облігацій
      from cp_ryn where ryn = k.ryn;

      l_cp_dgp_zv_row.g012 := nvl(get_cp_refw(k.ref, 'AUKC'), k.nd);                        --Номер аукціону
      l_cp_dgp_zv_row.g013 := k.cp_id;                                                      --Міжнародний ідентифікаційний номер цінного паперу (ISIN)
      l_cp_dgp_zv_row.g014 := get_pay_period(k.ky);                                         --Періодичність сплати купону
      /*Показники групи: Залишок на початок періоду*/
      l_cp_dgp_zv_row.g015 := to_char(k.dat_ug, 'DD.MM.YYYY');                              --Дата придбання (в старому варіанті o.vdat dat_k)
      l_cp_dgp_zv_row.g016 := case when k.stiket is null then 'тікет не знайдено'
                                   else get_kontragent(k.ref) end;                          --Назва продавця
      l_cp_dgp_zv_row.g017 := to_char(nvl(get_hist_ir(k.id, p_date_from), k.ir),
                                      '99.99999');                                          --Відсоткова ставка на початок звітного періоду

      if k.kv = 980 then
          l_cp_dgp_zv_row.g018 := k.s_kupl;                                                  --тест--!!!!Ціна придбання
          else
            l_cp_dgp_zv_row.g018 := gl.p_icurval(k.kv, k.s_kupl * 100, k.dat_k) / 100;     -- -//- (в эквіваленті)
      end if;

      l_cp_dgp_zv_row.g019 := get_count_cp(k.id, p_date_from - 1, k.cena, k.cena_start, k.acc,  --Кількість на початок звітного періоду, шт.
                                           l_sn);
      if k.kv = 980 then
          l_cp_dgp_zv_row.g020 := l_sn;                                                      --Номінальна вартість на початок звітного періоду
        else
          l_cp_dgp_zv_row.g020 := gl.p_icurval(k.kv, l_sn * 100, p_date_from - 1) / 100;     -- -//- (в эквіваленті)
      end if;

      l_sd := 0; l_sp := 0;
      if k.accd is not null then
        l_sd := -rez.ostc96(k.accd, p_date_from - 1) / 100;
      end if;
      if k.accp is not null then
        l_sp := -rez.ostc96(k.accp, p_date_from - 1) / 100;
      end if;
      if k.kv = 980 then
        l_cp_dgp_zv_row.g021 := l_sd + l_sp;                                                 --Неамортизований дисконт/премія на початок звітного періоду
        else
          l_cp_dgp_zv_row.g021 := gl.p_icurval(k.kv, l_sd * 100, p_date_from - 1) / 100      -- -//- (в эквіваленті)
                                + gl.p_icurval(k.kv, l_sp * 100, p_date_from - 1) / 100;
      end if;

      l_sr := 0; l_sr2 := 0; l_sr3 := 0;
      if k.accr is not null then
        l_sr := -rez.ostc96(k.accr, p_date_from - 1) / 100;
      end if;
      if k.accr2 is not null then
        l_sr2 := -rez.ostc96(k.accr2, p_date_from - 1) / 100;
      end if;
      if k.accr3 is not null then
        l_sr3 := -rez.ostc96(k.accr3, p_date_from - 1) / 100;
      end if;
      if k.accunrec is not null then
        l_sr_ur := -rez.ostc96(k.accunrec, p_date_from - 1) / 100; --невизнані доходи
      end if;
      if k.accexpr is not null then
        l_sr_expr := -rez.ostc96(k.accexpr, p_date_from - 1) / 100; --просрочка нарах. куп
      end if;

      if k.kv = 980 then
        l_cp_dgp_zv_row.g022 := l_sr + l_sr2 + l_sr3 - l_sr_ur + l_sr_expr;                  --тест--уточнення (нач% (R+R2+R3 - !!!R (непризнанные)+ просроченные!!!)--Нараховані/ прострочені/невизнані відсотки станом на кінець дня звітної дати
        else
          l_cp_dgp_zv_row.g022 := gl.p_icurval(k.kv, l_sr * 100, p_date_from - 1) / 100      -- -//- (в эквіваленті)
                                + gl.p_icurval(k.kv, l_sr2 * 100, p_date_from - 1) / 100
                                + gl.p_icurval(k.kv, l_sr3 * 100, p_date_from - 1) / 100
                                - gl.p_icurval(k.kv, l_sr_ur * 100, p_date_from - 1) / 100
                                + gl.p_icurval(k.kv, l_sr_expr * 100, p_date_from - 1) / 100
                                ;
      end if;
      if k.kv = 980 then
        l_cp_dgp_zv_row.g023 := l_sr2 + l_sr3;                                                --Сплачений накопичений купонний дохід на початок звітного періоду
        else
          l_cp_dgp_zv_row.g023 := gl.p_icurval(k.kv, l_sr2 * 100, p_date_from - 1) / 100      ---//- (в эквіваленті)
                                + gl.p_icurval(k.kv, l_sr3 * 100, p_date_from - 1) / 100;
      end if;

      begin
        select sum(crq)
        into l_cp_dgp_zv_row.g024                                                               -- Сума кредитного ризику  сформованого на початок звітного періоду (згідно постанови № 351)
        from nbu23_rez where tipa=9 and nd = k.ref and
                             fdat = (select max(fdat) from  nbu23_rez
                                     where tipa=9 and nd = k.ref and
                                     fdat <= p_date_from );
        exception
          when NO_DATA_FOUND then
            l_cp_dgp_zv_row.g024  := null;
      end;


      l_rez := get_rezq39(k.ref, p_date_from);                                                    --тест--уточнення -- Сума резерву, розрахованого згідно вимог МСБО 39 на початок звітного періоду
      l_cp_dgp_zv_row.g025 := l_rez;
      l_rez := nvl(l_rez, 0);

      l_ss := 0;
      if k.accs is not null then
        l_ss := -rez.ostc96(k.accs, p_date_from - 1) / 100;
      end if;
      /*банком були надані приклади по корегуючим (неупорядковано, потрібно переуточнити)
          наскільки можна зрозуміти
            для резерву  (g025):
              ref 96104973401 Отримано з Finevare. Корекція доходів на суму НЕвизнаних по дог= 9/21425065701
                * в cp_deal рахунок 31189925065701 для реф. угоди купівлі 21425065701 неіснує.
                  але для звіту береться nbu23_rez - скоріше всього воно тут має враховуватися
            для переоцінки (g026):
              ref 90685271001 Згортання уцінки по обл.ПАТ "Укртелеком" с.V, к.179428, зг.п.91 розд.XV Інстр.з бух.об.опер.з ЦП та фін.ін. затв.Пост.Прав.НБУ 22.06.2015 р. №400.
      */
      /* а нафіга обороти, якщо залишок на дату береться ....
      l_ss_kor := get_ss_kor(k.accs, p_date_from - 1) / 100;
      l_ss := l_ss + l_ss_kor;
      */
      if k.kv = 980 then
        l_cp_dgp_zv_row.g026 := l_ss;                                                        --тест--уточнення --Сума переоцінки на початок звітного періоду, визначена відповідно до вимог МСФЗ
        else
          l_cp_dgp_zv_row.g026 := gl.p_icurval(k.kv, l_ss * 100, p_date_from - 1) / 100;     -- -//- (в эквіваленті)
      end if;
      /* потрібно зрозуміти що є коректуючі проведення*/
      l_sb := l_sn + (l_sd + l_sp) + (l_sr + l_sr2 + l_sr3) - l_rez  + l_ss;
      if  k.kv = 980 then
        l_cp_dgp_zv_row.g027 := l_sb;                                                        --тест--уточнення --Балансова вартість на початок звітного періоду (згідно МСФЗ)
        else
          l_cp_dgp_zv_row.g027 := gl.p_icurval(k.kv, l_sb * 100, p_date_from - 1) / 100;     -- -//- (в эквіваленті)
      end if;

      l_days_cnt := get_days_delay(k.ref, p_date_from);
      l_cp_dgp_zv_row.g028 := nvl(to_char(l_days_cnt), 'невідомо');                                    --тест--Харін відповів--уточнення у Абашидзе-- Кількість днів прострочки

      /*залежить від прострочки та ознаки Is_default  з Finevare (таблиця PRVN_FV_REZ)*/
      l_chr_start_time := dbms_utility.get_time;
      l_is_default := get_is_default(k.ref, p_date_from);
      l_chr_end_time := dbms_utility.get_time;
      if (l_chr_end_time - l_chr_start_time) / (100 * 60) > 1 then /*min*/
        bars_audit.info(G_TRACE || l_title || ' Функція get_is_default('||k.ref||','||p_date_from||') відпрацьовує '||(l_chr_end_time - l_chr_start_time) / (100 * 60)||' хвилин');
      end if;
      if l_is_default = 1 then
        l_cp_dgp_zv_row.g029 := '4';                                                           --тест--уточнення -- Категорія якості за МСФЗ на початок періоду
        else
          if l_is_default = 0 and l_days_cnt = 0 then
            l_cp_dgp_zv_row.g029 := '1';
          elsif l_is_default = 0 and l_days_cnt <= 30  then
            l_cp_dgp_zv_row.g029 := '2';
          elsif l_is_default = 0 and l_days_cnt between 30+1 and 60  then
            l_cp_dgp_zv_row.g029 := '3';
          else
            l_cp_dgp_zv_row.g029 := 'невідомо';
          end if;
      end if;

      l_cp_dgp_zv_row.g030  := get_riven(k.id, p_date_from);                                 --тест--уточнення -- Рівень на початок звітного періоду
      /*Показники групи: Придбання протягом звітного періоду*/
      if k.dat_k between p_date_from and p_date_to then
        l_dat_k2 := k.dat_k;
        else
          l_dat_k2 := null;
      end if;
      if l_dat_k2 is not null then
        l_sn := get_turnaround(k.ref, k.acc);
        if  k.kv = 980 then
          l_cp_dgp_zv_row.g031 := l_sn;                                                        -- Придбання (випуск) за звітний період (номінальна вартість)
          else
            l_cp_dgp_zv_row.g031 := gl.p_icurval(k.kv, l_sn * 100, l_dat_k2) / 100;            -- -//- (в эквіваленті)
        end if;

        l_cena_bay_n := get_cena_voprosa(k.id, k.dat_k, k.cena, k.cena_start);
        l_kl         := round(l_sn / l_cena_bay_n, 0);
        l_cp_dgp_zv_row.g032 := l_kl;                                                           -- Придбання (випуск) за звітний період, кількість
        if l_kl != 0 then
          if  k.kv = 980 then
            l_cp_dgp_zv_row.g033 := round(nvl(k.sumb, k.s_kupl) / l_kl, 2);                       -- Ціна придбання
            else
              l_cp_dgp_zv_row.g033 := gl.p_icurval(k.kv, round(nvl(k.sumb, k.s_kupl) / l_kl, 2) * 100, l_dat_k2) / 100; -- -//- (в эквіваленті)
          end if;
        end if;
        l_cp_dgp_zv_row.g034 := k.s_kupl;                                                          --тест--уточнення --Сума фактично сплачених коштів за придбані ЦП (сума за договором)

        l_sr := get_turnaround(k.ref, nvl(k.accr2, k.accr));
        /*if l_kl != 0 then
           l_cp_dgp_zv_row.g035 := round(l_sr / l_kl, 2);                                          --уточнення -- Сума сплачених накопичених купонів у ціні придбання(1шт???)
        end if;
       Я:Судячи що помарковано зеленим і система вірно формує показаник, то чи не вистачає в назві колонки помімитки - 1 шт?
       Банк: На одну штуку сплаченный накоп. в нашей таблице не надо, это наверное в АБС  добавили для информации или проверки. Нам надо общая сумма накопит сплач в цене покупки. По бух модели, это все что садится на 1418,1428 или 3118 – то есть проценты при покупке (R2 и R3)
       */
        l_cp_dgp_zv_row.g035 := l_sr;                                                              --тест


        l_cp_dgp_zv_row.g036 := f_operw(k.ref, 'CP_FC');                                         --тест--уточнення --новий довідник?

        l_cp_dgp_zv_row.g037 := to_char(l_dat_k2, 'DD.MM.YYYY');                                 --Дата придбання
        l_cp_dgp_zv_row.g038 := l_cp_dgp_zv_row.g016;                                            --Назва продавця

      end if;  --end l_dat_k2 is not null
      /*Показники групи: Залишок на кінець періоду*/
      l_cp_dgp_zv_row.g051 := to_char(k.dat_pg, 'DD.MM.YYYY');                                   --Дата погашення

      select min(offer_date)
        into l_cp_dgp_zv_row.g052                                                                --тест--уточнення -- Дата оферти (найближча після звітної дати)
        from cp_dat
        where id = k.id
          and dok > p_date_to;
      begin
        select nvl(a.dok, k.dat_pg)
          into l_dnk
          from cp_dat a
         where a.id = k.ID
           and a.DOK = (select min(dok)
                          from cp_dat
                         where id = k.id
                           and dok > p_date_to);

        exception
          when NO_DATA_FOUND then
            l_dnk := null;
      end;
      l_cp_dgp_zv_row.g053 := to_char(l_dnk, 'DD.MM.YYYY');                                      -- Дата виплати купону (найближча після звітної дати)
      l_cp_dgp_zv_row.g054 := to_char(nvl(get_hist_ir(k.id, p_date_to), k.ir),
                                      '99.99999');                                               -- Відсоткова ставка на кінець дня звітної дати

      l_sn := -rez.ostc96(k.acc, p_date_to+1) / 100;
      l_cena := get_cena_voprosa(k.id, p_date_to+1, k.cena, k.cena_start);
      l_cp_dgp_zv_row.g055 := round(l_sn / l_cena, 0);                                           --Кількість станом на кінець дня звітної дати
      if  k.kv = 980 then
          l_cp_dgp_zv_row.g056 := l_sn;                                                        -- Номінальна вартість на кінець дня звітної дати
          else
            l_cp_dgp_zv_row.g056 := gl.p_icurval(k.kv, l_sn * 100, p_date_to+1) / 100;         -- -//- (в эквіваленті)
      end if;

      l_sd := 0; l_sp := 0;
      if k.accd is not null then
        l_sd := -rez.ostc96(k.accd, p_date_to+1) / 100;
      end if;
      if k.accp is not null then
        l_sp := -rez.ostc96(k.accp, p_date_to+1) / 100;
      end if;
      if k.kv = 980 then
        l_cp_dgp_zv_row.g057 := l_sd + l_sp;                                                 --Неамортизований дисконт/премія на кінець дня звітної дати
        else
          l_cp_dgp_zv_row.g057 := gl.p_icurval(k.kv, l_sd * 100, p_date_to+1) / 100      -- -//- (в эквіваленті)
                                + gl.p_icurval(k.kv, l_sp * 100, p_date_to+1) / 100;
      end if;

      l_sr := 0; l_sr2 := 0; l_sr3 := 0;
      if k.accr is not null then
        l_sr := -rez.ostc96(k.accr, p_date_to+1) / 100;
      end if;
      if k.accr2 is not null then
        l_sr2 := -rez.ostc96(k.accr2, p_date_to+1) / 100;
      end if;
      if k.accr3 is not null then
        l_sr3 := -rez.ostc96(k.accr3, p_date_to+1) / 100;
      end if;
      if k.accunrec is not null then
        l_sr_ur := -rez.ostc96(k.accunrec, p_date_to+1) / 100; --невизнані доходи
      end if;
      if k.accexpr is not null then
        l_sr_expr := -rez.ostc96(k.accexpr, p_date_to+1) / 100; --просрочка нарах. куп
      end if;

      if k.kv = 980 then
        l_cp_dgp_zv_row.g058 := l_sr + l_sr2 + l_sr3 - l_sr_ur + l_sr_expr;                  --тест--уточнення G022 --Нараховані/ прострочені/невизнані відсотки станом на кінець дня звітної дати
        else
          l_cp_dgp_zv_row.g058 := gl.p_icurval(k.kv, l_sr * 100, p_date_to+1) / 100      -- -//- (в эквіваленті)
                                + gl.p_icurval(k.kv, l_sr2 * 100, p_date_to+1) / 100
                                + gl.p_icurval(k.kv, l_sr3 * 100, p_date_to+1) / 100
                                - gl.p_icurval(k.kv, l_sr_ur * 100, p_date_to+1) / 100
                                + gl.p_icurval(k.kv, l_sr_expr * 100, p_date_to+1) / 100
                                ;
      end if;

      if k.kv = 980 then
        l_cp_dgp_zv_row.g059 := l_sr2 + l_sr3;                                             --Накопичений (непогашений) купонний дохід на кінець дня звітної дати
        else
          l_cp_dgp_zv_row.g059 := gl.p_icurval(k.kv, l_sr2 * 100, p_date_to+1) / 100
                                + gl.p_icurval(k.kv, l_sr3 * 100, p_date_to+1) / 100 ;      -- -//- (в эквіваленті)
      end if;

      l_cp_dgp_zv_row.g060 := '-';                                                        --потрібно видалити?--уточнення-- Сума резерву, фактично сформованого на кінець дня звітної дати, грн (згідно постанови № 23)


      l_rez := get_rezq39(k.ref, p_date_to);
      l_cp_dgp_zv_row.g061 := l_rez;                                                      --тест--уточнення g025-- Сума резерву, розрахованого згідно вимог МСБО 39 на кінець дня звітної дати
      l_rez := nvl(l_rez, 0);

      l_ss := 0;
      if k.accs is not null then
        l_ss := -rez.ostc96(k.accs, p_date_to+1) / 100;
      end if;
      /* а нафіга обороти, якщо залишок на дату береться ....
      l_ss_kor := get_ss_kor(k.accs, p_date_to+1) / 100;
      l_ss := l_ss + l_ss_kor;
      */
      if k.kv = 980 then
        l_cp_dgp_zv_row.g062 := l_ss;                                                        --уточнення --Сума переоцінки на кінець дня звітної дати, визначена відповідно до вимог МСФЗ
        else
          l_cp_dgp_zv_row.g062 := gl.p_icurval(k.kv, l_ss * 100, p_date_to+1) / 100;     -- -//- (в эквіваленті)
      end if;

      l_sb := l_sn + (l_sd + l_sp) + (l_sr + l_sr2 + l_sr3) - l_rez  + l_ss;
      if  k.kv = 980 then
        l_cp_dgp_zv_row.g063 := l_sb;                                                        --тест--уточнення G027--Балансова вартість на кінець дня звітної дати (згідно МСФЗ)
        else
          l_cp_dgp_zv_row.g063 := gl.p_icurval(k.kv, l_sb * 100, p_date_to+1) / 100;     -- -//- (в эквіваленті)
      end if;

      /*Фиалкович: Такой же что и для балансовой . На данный момент балансовая = справедливой, ну и конечно поделить на пакет, т к на 1 шт*/
      if l_sn = 0 then
        l_sb := null;
        else
          l_sb := round(l_sb / round(l_sn / l_cena, 0), 2);
      end if;
      if  k.kv = 980 then
        l_cp_dgp_zv_row.g064 := l_sb;                                                        --тест--уточнення--Справедлива вартість ЦП згідно МСБО 39 на звітну дату за 1 шт
        else
          l_cp_dgp_zv_row.g064 := gl.p_icurval(k.kv, l_sb * 100, p_date_to+1) / 100;     -- -//- (в эквіваленті)
      end if;

      l_cp_dgp_zv_row.g065 := l_cp_dgp_zv_row.g063;                                          --тест--уточнення--Справедлива вартість пакету ЦП згідно МСБО 39 на звітну дату

      l_days_cnt := get_days_delay(k.ref, p_date_to);
      /*залежить від прострочки та ознаки Is_default  з Finevare (таблиця PRVN_FV_REZ)*/
      l_chr_start_time := dbms_utility.get_time;
      l_is_default := get_is_default(k.ref, p_date_to+1);
      l_chr_end_time := dbms_utility.get_time;
      if (l_chr_end_time - l_chr_start_time) / (100 * 60) > 1 then /*хвилин*/
        bars_audit.info(G_TRACE || l_title || ' Функція get_is_default('||k.ref||','||to_char(p_date_to+1, 'DD.MM.YYYY')||') відпрацьовує '||(l_chr_end_time - l_chr_start_time) / (100 * 60)||' хвилин');
      end if;
      if l_is_default = 1 then
        l_cp_dgp_zv_row.g066 := '4';                                                           --тест--уточнення g029-- Категорія якості за МСФЗ на кінець дня звітної дати
        else
          if l_is_default = 0 and l_days_cnt = 0 then
            l_cp_dgp_zv_row.g066 := '1';
          elsif l_is_default = 0 and l_days_cnt <= 30  then
            l_cp_dgp_zv_row.g066 := '2';
          elsif l_is_default = 0 and l_days_cnt between 30+1 and 60  then
            l_cp_dgp_zv_row.g066 := '3';
          else
            l_cp_dgp_zv_row.g066 := 'невідомо';
          end if;
      end if;

      l_cp_dgp_zv_row.g067 := nvl(to_char(l_days_cnt), 'невідомо');                          --тест--уточнення g028-- Кількість днів прострочки
      l_cp_dgp_zv_row.g068 := get_riven(k.id, p_date_to);                                    --тест--уточнення g030-- Рівень станом на звітну дату


      /*далі йде в розрізі продажів,
        тобіш на одну покупку додаються кількість рядків у звіт по кількості продажів
        (продажів 0 не помножає на 0 придбання :-) )
        [нажаль БМД не підтримує групування ячєйок так як Ексель]
      */
      l_cnt_prod := 0;
      for p in (select o.ref,
                  pp.nd,
                  pp.s / 100 s_p, -- сума угоди продажу всього пакета
                  o.s / 100 s,
                  o.stmt,
                  o.tt,
                  decode(vob, 096, pp.vdat, o.fdat) dat_opl,
                  pp.datp dat_ug,
                  ar.op ar_op,
                  nvl(ar.sumb, 0) / 100  ar_sumb,
                  nvl(ar.n, 0) / 100 ar_n
             from opldok o, oper pp, cp_arch ar
            where o.acc = k.acc
              and o.dk = 1
              and o.ref = pp.ref
              and o.ref = ar.ref(+)
              and o.fdat between p_date_from and p_date_to
              and o.sos = 5
              and pp.nazn like 'Продаж%'
            order by 1)
      loop
        l_cnt_prod := l_cnt_prod + 1;
        /*Показники групи: Реалізація протягом звітного періоду*/
        /*системні*/
        l_cp_dgp_zv_row.ref_sale := p.ref;
        -------
        if k.kv = 980 then
          l_cp_dgp_zv_row.g039 := p.s;                                                        --Реалізація (погашення) за звітний період (номінальна вартість)
          else
            l_cp_dgp_zv_row.g039 := gl.p_icurval(k.kv, p.s * 100, p.dat_opl) / 100;     -- -//- (в эквіваленті)
        end if;

        if k.cena != k.cena_start then
          -- уточнення номінальної ціни 1 шт
          begin
            select k.cena_start - sum(nvl(a.nom, 0)) +
                   sum(decode(a.dok, k.dat_pg, nvl(a.nom, 0), 0))
              into l_cena --  6/04-15
              from cp_dat a
             where a.id = k.ID
               and a.DOK <= p.dat_opl;
             exception
               when NO_DATA_FOUND then l_cena := k.cena;
          end;
        else
          l_cena := k.cena; -- номінальна
        end if;

        l_kl := round(p.s / nvl(l_cena, k.cena), 0);
        l_cp_dgp_zv_row.g040 := l_kl;                                                        --Реалізація (погашення) за звітний період, кількість

        if p.ar_op in (2, 3) then
          if nvl(l_kl, 1) != 0 then
            l_sn := case when nvl(p.ar_n, 0) = 0 then p.s else p.ar_n end;
            l_koeff := round(p.s / l_sn, 5);
            l_cena := round(nvl(p.ar_sumb, p.s_p) * l_koeff / nvl(l_kl, 1), 2);
          end if;
          elsif p.ar_op = 20 then
            l_cena := f_cena_cp(k.id, p.dat_opl);
          elsif p.ar_op = 22 then
            begin
              select nvl(nom, 0)
                into l_cena
                from cp_dat a
               where a.id = k.ID
                 and a.dok = (select max(dok)
                                from cp_dat
                               where id = k.id
                                 and dok < p.dat_opl);
            exception
              when NO_DATA_FOUND then
                l_cena := 0;
            end;
          else
            l_cena := 0;
        end if;

        if k.kv = 980 then
          l_cp_dgp_zv_row.g041 := l_cena;                                                        --Ціна реалізації
          else
            l_cp_dgp_zv_row.g041 := gl.p_icurval(k.kv, l_cena * 100, p.dat_opl) / 100;     -- -//- (в эквіваленті)
        end if;

        if k.kv = 980 then
          l_cp_dgp_zv_row.g042 := p.s_p;                                                        --тест--Сума фактично отриманих коштів за продані ЦП (сума за договором)
          else
            l_cp_dgp_zv_row.g042 := gl.p_icurval(k.kv, p.s_p * 100, p.dat_opl) / 100;     -- -//- (в эквіваленті)
        end if;

        select sum(o.sq) / 100 -- кредит по R/R2 при продажу
          into l_cp_dgp_zv_row.g043                                                          --Накопичений купонний дохід, отриманий у ціні реалізації
          from opldok o
         where o.acc in (k.accr, k.accr2)
           and o.dk = 1
           and o.sos = 5 -- !? OBU/BARS
           and o.ref = p.ref;

        l_cp_dgp_zv_row.g044 := f_operw(p.ref, 'CP_FC');                                     --тест--уточнення G036 --Форма проведення розрахунку

        l_cp_dgp_zv_row.g045 := to_char(p.dat_opl, 'DD.MM.YYYY');                            -- Дата реалізації

        l_cp_dgp_zv_row.g046 := nvl(nvl(get_cp_refw(p.ref, 'BRDOG'), get_cp_refw(k.ref, 'BRDOG')), p.nd);  --Номер біржової угоди

        l_cp_dgp_zv_row.g047 := trim(get_kontragent(p.ref,
                                             'д контрагенту'));                              --Назва покупця

        l_cp_dgp_zv_row.g048 := substr(get_cp_kodw(k.id, 'VYDCP'), 1, 255);                 --тест--уточнення --Вид цінного паперу
        l_cp_dgp_zv_row.g049 := get_cp_refw(p.ref, 'VDOGO');                                --тест--уточнення --Вид договору/контракту
        l_cp_dgp_zv_row.g050 := get_cp_refw(p.ref, 'VOPER');                                --тест--уточнення --Вид операції

        /*Показники групи: Доходи за цінними паперами, отримані протягом звітного періоду*/

        select sum(decode(o.dk, 0, 1, 1, -1) * o.sq) / 100
          into l_rp                                                                         --безпосередньо результат від продажу
          from opldok o, opldok o2, accounts ak
         where o.dk = 1 - o2.dk
           and o.stmt = o2.stmt
           and o.tt = 'FXT'
           and o2.tt = 'FXT'
           and o.ref = o2.ref
           and o.ref = p.ref
           and ak.acc = o2.acc
           and (
                ak.nls like '6393%' or ak.nls like '6203%' or ak.nls like '3800%' -- OBU
               )
           and o.sos = 5;

        select sum(decode(o.dk, 0, 1, 1, -1) * o.sq) / 100
          into l_zp                                                                         --3115 - згортання переоцінки при продажі
          from opldok o, opldok o2, cp_deal d
         where o.dk = 1 - o2.dk
           and o.stmt = o2.stmt
/*           and o.tt = 'FX7'
           and o2.tt = 'FX7'*/
           and o.ref = o2.ref
           and o.ref = p.ref
           and d.accs = o2.acc
           and o.sos = 5;

        l_cp_dgp_zv_row.g069 := l_rp + l_zp;                                                --тест--переуточнення через Абашидзе--Торговий дохід протягом звітного періоду

        select sum(decode(o1.dk, 0, 1, 1, -1) * o1.sq) / 100
          into l_cp_dgp_zv_row.g070                                                         --тест--6390 dk= 1, 7390 dk = 0 --доучточнення--уточнення --Визнання результату при первісному визнанні (рахунки 6390,7390)
          from opldok o1, opldok k1, accounts ak
         where o1.dk = 1 - k1.dk
           and o1.stmt = k1.stmt
/*           and o.tt = 'FXT'
           and k.tt = 'FXT'*/
           and o1.ref = k1.ref
           and o1.ref = /*p.ref*/ k.ref /*при купівлі ж ? */
           and ak.acc = k1.acc
           and (
                ak.nls like '6390%' or ak.nls like '7390%'
               )
           and o1.sos = 5;


        l_cp_dgp_zv_row.g071 := '-';                                                        --уточнення --Курсова різниця, яка виникає під час виплати купонного доходу (різниця між курсом на дату нарахування і курсом на дату фактичної виплати купонного джоходу), грн.
        /* Фіалкович: Сергей не трогай эту колонку,  если вы решили  вопрос с Сауляк по отчетности по валютной переоценке. */

        l_cp_dgp_zv_row.g072 := '-';                                                        --уточнення через Абашидзе--Результат переоцінки залишку внаслідок зміни валютних курсів протягом звітного періоду
       /* Абашидзе: Да, с Васей Хариным переговорила, он сказал, что помнит об этом вопросе, но не так легко у них взять алгоритм...
                   обещал, что в ближайшее время скажет результат*/

        select /*nvl(sum(o.s), 0) / 100,*/ nvl(sum(o.sq), 0) / 100 -- по D при амортизації на 6
            into l_cp_dgp_zv_row.g073                                                        --тест--уточнення --Амортизація дисконту протягом звітного періоду
            from opldok o
           where o.acc = k.accd
             and o.dk = 0
             and o.sos = 5
             and o.fdat >= p_date_from
             and o.fdat <= p_date_to
             --and o.tt in ('FXM', '080', '013')
             ;

        select /*nvl(sum(o.s), 0) / 100,*/ nvl(sum(o.sq), 0) / 100 -- по D при амортизації на 6
            into l_cp_dgp_zv_row.g074                                                        --тест--уточнення g073--Амортизація премії протягом звітного період
            from opldok o
           where o.acc = k.accp
             and o.dk = 0
             and o.sos = 5
             and o.fdat >= p_date_from
             and o.fdat <= p_date_to
             --and o.tt in ('FXM', '080', '013')
             ;

        select /*nvl(sum(o.s), 0) / 100, */nvl(sum(o.sq), 0) / 100 -- по R при нарахуванні на 605
          into l_cp_dgp_zv_row.g075                                                          --тест--уточнення Сума процентного доходу протягом звітного періоду
          from opldok o --, OPER P
         where o.acc = k.accr
           and o.dk = 0 --and o.ref=p.ref
           and o.sos = 5
           and o.fdat >= p_date_from
           and o.fdat <= p_date_to --and o.tt in ('FXU','FXU'
--           and o.tt in ('FX%', '080', '013')
           ;

        /* Фіалкович: Например: есть сделка, по ней за три месяца ( один раз в месяц) была проведена переоценка. В первый раз была дооценка (Дт1415, Кт5102),
                      а остальные два месяца- уценка (Дт5102 Кт 1415). В результате по счету 1415 в оборотах у нас есть и Дт и Кт.
                      Итого: Дт минус Кт равно сумма  со знаком (+) или (-). */
        select nvl(sum(case when o.dk = 0 then 0 else o.sq end), 0) / 100  - nvl(sum(case when o.dk = 1 then 0 else o.sq end), 0) / 100
          into l_cp_dgp_zv_row.g076                                                          --тест--уточнення --Сумма інших сукупних доходів та витрат від зміни у вартості цінних парерів за МСФЗ за звітний період
          from opldok o
         where o.acc = k.accs
--           and o.dk = 0
           and o.sos = 5
           and o.fdat >= p_date_from
           and o.fdat <= p_date_to
--           and o.tt in ('FX%', '080', '013')
           ;


        select nvl(sum(o.sq), 0) / 100
          into l_cp_dgp_zv_row.g077                                                          --Отриманий купон, грн
          from opldok o
         where o.acc in (k.accr, k.accr2, k.accr3)
           and o.dk = 1
           and o.sos = 5
           and o.fdat >= p_date_from
           and o.fdat <= p_date_to;
           --and o.tt in ('FX7', 'FX8', 'F80');

        insert into cp_dgp_zv values l_cp_dgp_zv_row;
      end loop;--по продажам

      l_cp_dgp_zv_row.g078 := '-';
      l_cp_dgp_zv_row.g079 := '-';
      l_cp_dgp_zv_row.g080 := '-';
      l_cp_dgp_zv_row.g081 := '-';
      l_cp_dgp_zv_row.g082 := '-';
      l_cp_dgp_zv_row.g083 := '-';
      l_cp_dgp_zv_row.g084 := '-';
      l_cp_dgp_zv_row.g085 := '-';
      l_cp_dgp_zv_row.g086 := '-';
      l_cp_dgp_zv_row.g087 := '-';
      l_cp_dgp_zv_row.g088 := '-';

      if l_cnt_prod = 0 then --жодної продажі, але ж купівля була
        insert into cp_dgp_zv values l_cp_dgp_zv_row;
      end if;
      bars_audit.trace(G_TRACE || l_title || ' l_cnt =  '||l_cnt);
    end loop;
    close G_CUR;
    bars_audit.info(G_TRACE || l_title || ' Itog l_cnt =  '||l_cnt);
    send_msg('Кінець формування DGP007: для перегляду результату при запуску звіту нажміть Ні');                
    exception
      when others then
        bars_audit.error(G_TRACE || l_title || substr(dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace(), 1, 2000));
        if G_CUR%ISOPEN then
          close G_CUR;
        end if;
        send_msg('Звіт DGP007 при формуванні отримав помилку: '||G_TRACE || l_title || substr(dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace(), 1, 2000));
        raise_application_error(-20001, G_TRACE || l_title || substr(dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace(), 1, 2000));
  end;

  /* Населення данними для звіту DGP-008:
     "Інвестиції у державні цінні папери"
  */
  procedure dgp8(p_date_from cp_dgp_zv.date_from%type,
                 p_date_to   cp_dgp_zv.date_to%type) is
    l_title         constant varchar2(25) := 'dgp8: ';
    l_cp_dgp_zv_row cp_dgp_zv%rowtype;
    l_nlsb_arr      string_list := string_list('1404', '1410', '1412', '1420', '1430', '1435', '1440');
    l_cnt           pls_integer := 0;

    --блок змінних для залишків на рахунках по даті або суми оборотів
    l_sd            number;--дисконт
    l_sp            number;--премія
    l_sr            number;--R
    l_sr2           number;--R2
    l_sr3           number;--R3
    l_ss            number;--переоцінка
    l_sn            number;--номінал
    l_sb            number;--балансова вартість (складається з суми/різниці попередніх)
    l_sr_ur         number;--невизн. доходи
    l_sr_expr       number;--проср. нарах куп.
    l_rez           number;--сума резерву
    ----------------
    l_zp            number;
    l_rp            number;
    --
    l_cena_bay_n    number;
    l_cena          number;
    l_kl            number;
    l_koeff         number;
    ----------------
    l_dat_k2        date;
    ----------------
    l_dnk           date;
    ----------------
    l_cnt_prod      pls_integer;
    l_days_cnt      pls_integer;
    l_is_default    number(1);
    --
    l_chr_start_time number;
    l_chr_end_time   number;
    --
    k               G_CUR%ROWTYPE;

  begin
    bars_audit.info(G_TRACE || l_title || ' OPEN CURSOR ');
    open G_CUR(l_nlsb_arr, p_date_from, p_date_to);
    bars_audit.info(G_TRACE || l_title || ' START LOOP ');
    loop
      FETCH G_CUR INTO k;
      EXIT WHEN G_CUR%NOTFOUND;
      l_cnt := l_cnt + 1;
      /*системні значення*/
      l_cp_dgp_zv_row.ref       := k.ref;
      l_cp_dgp_zv_row.id        := k.id;
      l_cp_dgp_zv_row.type_id   := 8;
      l_cp_dgp_zv_row.date_from := p_date_from;
      l_cp_dgp_zv_row.date_to   := p_date_to;
      l_cp_dgp_zv_row.user_id   := user_id();
      l_cp_dgp_zv_row.date_reg  := sysdate;
      l_cp_dgp_zv_row.kf        := gl.kf;
      ---------
      l_cp_dgp_zv_row.g001 := k.nbs1;                                                       --!Номер балансового рахунку
      l_cp_dgp_zv_row.g002 := 'ні';                                                         --!РЕПО (так/ні)
      l_cp_dgp_zv_row.g003 := nvl(get_cp_kodw(k.id, 'TPCP'), get_type_bcp(k.id));          --!на тест--на уточнені(будуть заповнювати, але незручно, хочуть провалення з угод)--Тип боргового цінного паперу
      l_cp_dgp_zv_row.g004 := k.kv;                                                         --!Валюта (код)
      l_cp_dgp_zv_row.g005 := get_class_cp(k.id, k.nbs1, nvl(substr(k.nlsp, 1, 4), ''));    --!Класифікація цінних паперів (1-торговельні, 2-у наявності для продажу, 3-утримувані до погашення)
      l_cp_dgp_zv_row.g006 := nvl(k.title, get_cp_kodw(k.id, 'OS_UM'));                     --!Наявність особливих умов
      l_cp_dgp_zv_row.g007 := nvl(k.nmk, '***');                                            --!Назва емітента
      l_cp_dgp_zv_row.g008 := k.okpo;                                                        --!Код ЄДРПОУ
      l_cp_dgp_zv_row.g009 := case when k.prinsider = 99 then 'ні' else 'так' end;           --!на тест--на уточнені у Овчарука-Квашук--Пов'язана сторона (так/ні)

      select series
      into l_cp_dgp_zv_row.g010                                                             --!на тест--переуточнити--Серія облігацій
      from cp_ryn where ryn = k.ryn;

      l_cp_dgp_zv_row.g011 := nvl(get_cp_refw(k.ref, 'AUKC'), k.nd);                        --!Номер аукціону
      l_cp_dgp_zv_row.g012 := k.cp_id;                                                      --!Міжнародний ідентифікаційний номер цінного паперу (ISIN)
      l_cp_dgp_zv_row.g013 := get_pay_period(k.ky);                                         --!Періодичність сплати купону
      /*Показники групи: Залишок на початок періоду*/
      l_cp_dgp_zv_row.g014 := to_char(k.dat_ug, 'DD.MM.YYYY');                              --!Дата придбання (в старому варіанті o.vdat dat_k)
      l_cp_dgp_zv_row.g015 := case when k.stiket is null then 'тікет не знайдено'
                                   else get_kontragent(k.ref) end;                          --!Назва продавця
      l_cp_dgp_zv_row.g016 := to_char(nvl(get_hist_ir(k.id, p_date_from), k.ir),
                                      '99.99999');                                          --!Відсоткова ставка на початок звітного періоду

      l_kl := k.sumn / k.nom; --кількість придбаних з cp_arch
      if k.kv = 980 then
          l_cp_dgp_zv_row.g017 := round(k.s_kupl / l_kl, 2);                                  --!тест--!!!!Ціна придбання (Фіалкович: Ощая цена верная, но цена покупки должна быть на 1 шт )
          else
            l_cp_dgp_zv_row.g017 := round((gl.p_icurval(k.kv, k.s_kupl * 100, k.dat_k) / 100 ) / l_kl, 2);     -- -//- (в эквіваленті)
      end if;

      l_cp_dgp_zv_row.g018 := get_count_cp(k.id, p_date_from - 1, k.cena, k.cena_start, k.acc,  --!Кількість на початок звітного періоду, шт.
                                           l_sn);
      if k.kv = 980 then
          l_cp_dgp_zv_row.g019 := l_sn;                                                      --!Номінальна вартість на початок звітного періоду
        else
          l_cp_dgp_zv_row.g019 := gl.p_icurval(k.kv, l_sn * 100, p_date_from - 1) / 100;     -- -//- (в эквіваленті)
      end if;

      l_sd := 0; l_sp := 0;
      if k.accd is not null then
        l_sd := -rez.ostc96(k.accd, p_date_from - 1) / 100;
      end if;
      if k.accp is not null then
        l_sp := -rez.ostc96(k.accp, p_date_from - 1) / 100;
      end if;
      if k.kv = 980 then
        l_cp_dgp_zv_row.g020 := l_sd + l_sp;                                                 --!Неамортизований дисконт/премія на початок звітного періоду
        else
          l_cp_dgp_zv_row.g020 := gl.p_icurval(k.kv, l_sd * 100, p_date_from - 1) / 100      -- -//- (в эквіваленті)
                                + gl.p_icurval(k.kv, l_sp * 100, p_date_from - 1) / 100;
      end if;

      l_sr := 0; l_sr2 := 0; l_sr3 := 0; l_sr_ur := 0; l_sr_expr := 0;
      if k.accr is not null then
        l_sr := -rez.ostc96(k.accr, p_date_from - 1) / 100;
      end if;
      if k.accr2 is not null then
        l_sr2 := -rez.ostc96(k.accr2, p_date_from - 1) / 100;
      end if;
      if k.accr3 is not null then
        l_sr3 := -rez.ostc96(k.accr3, p_date_from - 1) / 100;
      end if;
      if k.accunrec is not null then
        l_sr_ur := -rez.ostc96(k.accunrec, p_date_from - 1) / 100; --невизнані доходи
      end if;
      if k.accexpr is not null then
        l_sr_expr := -rez.ostc96(k.accexpr, p_date_from - 1) / 100; --просрочка нарах. куп
      end if;

      if k.kv = 980 then
        l_cp_dgp_zv_row.g021 := l_sr + l_sr2 + l_sr3 - l_sr_ur + l_sr_expr;                  --!тест--уточнення (нач% (R+R2+R3 - !!!R (непризнанные)+ просроченные!!!)--Нараховані/ прострочені/невизнані відсотки станом на кінець дня звітної дати
        else
          l_cp_dgp_zv_row.g021 := gl.p_icurval(k.kv, l_sr * 100, p_date_from - 1) / 100      -- -//- (в эквіваленті)
                                + gl.p_icurval(k.kv, l_sr2 * 100, p_date_from - 1) / 100
                                + gl.p_icurval(k.kv, l_sr3 * 100, p_date_from - 1) / 100
                                - gl.p_icurval(k.kv, l_sr_ur * 100, p_date_from - 1) / 100
                                + gl.p_icurval(k.kv, l_sr_expr * 100, p_date_from - 1) / 100
                                ;
      end if;
      if k.kv = 980 then
        l_cp_dgp_zv_row.g022 := l_sr2 + l_sr3;                                                --!Сплачений накопичений купонний дохід на початок звітного періоду
        else
          l_cp_dgp_zv_row.g022 := gl.p_icurval(k.kv, l_sr2 * 100, p_date_from - 1) / 100      ---//- (в эквіваленті)
                                + gl.p_icurval(k.kv, l_sr3 * 100, p_date_from - 1) / 100;
      end if;

      l_cp_dgp_zv_row.g023 := '-';                                                               --!устаріло? Сума резерву, фактично сформованого на початок звітного періоду (згідно постанови № 23), грн

      l_rez := get_rezq39(k.ref, p_date_from);
      l_cp_dgp_zv_row.g024 := l_rez;                                                             --!тест--уточнення -- Сума резерву, розрахованого згідно вимог МСБО 39 на початок звітного періоду
      l_rez := nvl(l_rez, 0);

      l_ss := 0;
      if k.accs is not null then
        l_ss := -rez.ostc96(k.accs, p_date_from - 1) / 100;
      end if;
      if k.kv = 980 then
        l_cp_dgp_zv_row.g025 := l_ss;                                                        --!тест--уточнення --Сума переоцінки на початок звітного періоду, визначена відповідно до вимог МСФЗ
        else
          l_cp_dgp_zv_row.g025 := gl.p_icurval(k.kv, l_ss * 100, p_date_from - 1) / 100;     -- -//- (в эквіваленті)
      end if;
      /*Відповідь банку по переоцінці:
            Либо действительно остаток  по счету переоценки (либо кт либо дт) с учетом , если были корректирующие проводки.
             Или , как я уже сказала из протокола расчета резерва (выше).
            Я не знаю как тянуть, что бы было верно…. Протокол – наверное конечно легче, он уже сформирован. Но приавильно ли это?
        Поки немає чіткої відповіді залишаю тягнути залишок по рахунку переоцінки
      */
      /* потрібно зрозуміти що є коректуючі проведення, тут вони не враховувались*/
      l_sb := l_sn + (l_sd + l_sp) + (l_sr + l_sr2 + l_sr3) - l_rez  + l_ss;
      if  k.kv = 980 then
        l_cp_dgp_zv_row.g026 := l_sb;                                                        --!тест--уточнення --Балансова вартість на початок звітного періоду (згідно МСФЗ)
        else
          l_cp_dgp_zv_row.g026 := gl.p_icurval(k.kv, l_sb * 100, p_date_from - 1) / 100;     -- -//- (в эквіваленті)
      end if;

      l_days_cnt := get_days_delay(k.ref, p_date_to);
      /*залежить від прострочки та ознаки Is_default  з Finevare (таблиця PRVN_FV_REZ)*/
      l_chr_start_time := dbms_utility.get_time;
      l_is_default := get_is_default(k.ref, p_date_from);
      l_chr_end_time := dbms_utility.get_time;
      if (l_chr_end_time - l_chr_start_time) / (100 * 60) > 1 then /*хвилин*/
        bars_audit.info(G_TRACE || l_title || ' Функція get_is_default('||k.ref||','||p_date_from||') відпрацьовує '||(l_chr_end_time - l_chr_start_time) / (100 * 60)||' хвилин');
      end if;
      if l_is_default = 1 then
        l_cp_dgp_zv_row.g027 := '4';                                                           --тест-- Категорія якості за МСФЗ на поч звітної дати
        else
          if l_is_default = 0 and l_days_cnt = 0 then
            l_cp_dgp_zv_row.g027 := '1';
          elsif l_is_default = 0 and l_days_cnt <= 30  then
            l_cp_dgp_zv_row.g027 := '2';
          elsif l_is_default = 0 and l_days_cnt between 30+1 and 60  then
            l_cp_dgp_zv_row.g027 := '3';
          else
            l_cp_dgp_zv_row.g027 := 'невідомо';
          end if;
      end if;

      l_cp_dgp_zv_row.g028  := get_riven(k.id, p_date_from);                                 --!тест--уточнення -- Рівень на початок звітного періоду
      /*Показники групи: Придбання протягом звітного періоду*/
      if k.dat_k between p_date_from and p_date_to then
        l_dat_k2 := k.dat_k;
        else
          l_dat_k2 := null;
      end if;
      if l_dat_k2 is not null then
        l_sn := get_turnaround(k.ref, k.acc);
        if  k.kv = 980 then
          l_cp_dgp_zv_row.g029 := l_sn;                                                        --!Придбання (випуск) за звітний період (номінальна вартість)
          else
            l_cp_dgp_zv_row.g029 := gl.p_icurval(k.kv, l_sn * 100, l_dat_k2) / 100;            -- -//- (в эквіваленті)
        end if;

        l_cena_bay_n := get_cena_voprosa(k.id, k.dat_k, k.cena, k.cena_start);
        l_kl         := round(l_sn / l_cena_bay_n, 0);
        l_cp_dgp_zv_row.g030 := l_kl;                                                           --! Придбання (випуск) за звітний період, кількість
        if l_kl != 0 then
          if  k.kv = 980 then
            l_cp_dgp_zv_row.g031 := round(nvl(k.sumb, k.s_kupl) / l_kl, 2);                       --! Ціна придбання
            else
              l_cp_dgp_zv_row.g031 := gl.p_icurval(k.kv, round(nvl(k.sumb, k.s_kupl) / l_kl, 2) * 100, l_dat_k2) / 100; -- -//- (в эквіваленті)
          end if;
        end if;
        l_cp_dgp_zv_row.g032 := k.s_kupl;                                                          --!тест--уточнення --Сума фактично сплачених коштів за придбані ЦП (сума за договором)

        l_sr := get_turnaround(k.ref, nvl(k.accr2, k.accr));
        /*if l_kl != 0 then
           l_cp_dgp_zv_row.g035 := round(l_sr / l_kl, 2);                                          --уточнення -- Сума сплачених накопичених купонів у ціні придбання(1шт???)
        end if;
       Я:Судячи що помарковано зеленим і система вірно формує показаник, то чи не вистачає в назві колонки помімитки - 1 шт?
       Банк: На одну штуку сплаченный накоп. в нашей таблице не надо, это наверное в АБС  добавили для информации или проверки. Нам надо общая сумма накопит сплач в цене покупки. По бух модели, это все что садится на 1418,1428 или 3118 – то есть проценты при покупке (R2 и R3)
       */
        l_cp_dgp_zv_row.g033 := l_sr;                                                              --!тест


        l_cp_dgp_zv_row.g034 := f_operw(k.ref, 'CP_FC');                                         --!тест--уточнення --Форма проведення розрахунку

        l_cp_dgp_zv_row.g035 := to_char(l_dat_k2, 'DD.MM.YYYY');                                 --!Дата придбання
        l_cp_dgp_zv_row.g036 := l_cp_dgp_zv_row.g015;                                            --!Назва продавця

      end if;  --end l_dat_k2 is not null
      /*Показники групи: Залишок на кінець періоду*/
      l_cp_dgp_zv_row.g049 := to_char(k.dat_pg, 'DD.MM.YYYY');                                   --!Дата погашення

      select min(offer_date)
        into l_cp_dgp_zv_row.g050                                                                --!тест--уточнення -- Дата оферти (найближча після звітної дати)
        from cp_dat
        where id = k.id
          and dok > p_date_to;
      begin
        select nvl(a.dok, k.dat_pg)
          into l_dnk
          from cp_dat a
         where a.id = k.ID
           and a.DOK = (select min(dok)
                          from cp_dat
                         where id = k.id
                           and dok > p_date_to);

        exception
          when NO_DATA_FOUND then
            l_dnk := null;
      end;
      l_cp_dgp_zv_row.g051 := to_char(l_dnk, 'DD.MM.YYYY');                                      --! Дата виплати купону (найближча після звітної дати)
      l_cp_dgp_zv_row.g052 := to_char(nvl(get_hist_ir(k.id, p_date_to), k.ir),
                                      '99.99999');                                               --! Відсоткова ставка на кінець дня звітної дати

      l_sn := -rez.ostc96(k.acc, p_date_to+1) / 100;
      l_cena := get_cena_voprosa(k.id, p_date_to+1, k.cena, k.cena_start);
      l_cp_dgp_zv_row.g053 := round(l_sn / l_cena, 0);                                           --!Кількість станом на кінець дня звітної дати
      if  k.kv = 980 then
          l_cp_dgp_zv_row.g054 := l_sn;                                                        --!Номінальна вартість на кінець дня звітної дати
          else
            l_cp_dgp_zv_row.g054 := gl.p_icurval(k.kv, l_sn * 100, p_date_to+1) / 100;         -- -//- (в эквіваленті)
      end if;

      l_sd := 0; l_sp := 0;
      if k.accd is not null then
        l_sd := -rez.ostc96(k.accd, p_date_to+1) / 100;
      end if;
      if k.accp is not null then
        l_sp := -rez.ostc96(k.accp, p_date_to+1) / 100;
      end if;
      if k.kv = 980 then
        l_cp_dgp_zv_row.g055 := l_sd + l_sp;                                                 --!Неамортизований дисконт/премія на кінець дня звітної дати
        else
          l_cp_dgp_zv_row.g055 := gl.p_icurval(k.kv, l_sd * 100, p_date_to+1) / 100      -- -//- (в эквіваленті)
                                + gl.p_icurval(k.kv, l_sp * 100, p_date_to+1) / 100;
      end if;

      l_sr := 0; l_sr2 := 0; l_sr3 := 0;
      if k.accr is not null then
        l_sr := -rez.ostc96(k.accr, p_date_to+1) / 100;
      end if;
      if k.accr2 is not null then
        l_sr2 := -rez.ostc96(k.accr2, p_date_to+1) / 100;
      end if;
      if k.accr3 is not null then
        l_sr3 := -rez.ostc96(k.accr3, p_date_to+1) / 100;
      end if;
      if k.accunrec is not null then
        l_sr_ur := -rez.ostc96(k.accunrec, p_date_to+1) / 100; --невизнані доходи
      end if;
      if k.accexpr is not null then
        l_sr_expr := -rez.ostc96(k.accexpr, p_date_to+1) / 100; --просрочка нарах. куп
      end if;

      if k.kv = 980 then
        l_cp_dgp_zv_row.g056 := l_sr + l_sr2 + l_sr3 - l_sr_ur + l_sr_expr;                  --!тест--уточнення G022 --Нараховані/ прострочені/невизнані відсотки станом на кінець дня звітної дати
        else
          l_cp_dgp_zv_row.g056 := gl.p_icurval(k.kv, l_sr * 100, p_date_to+1) / 100      -- -//- (в эквіваленті)
                                + gl.p_icurval(k.kv, l_sr2 * 100, p_date_to+1) / 100
                                + gl.p_icurval(k.kv, l_sr3 * 100, p_date_to+1) / 100
                                - gl.p_icurval(k.kv, l_sr_ur * 100, p_date_to+1) / 100
                                + gl.p_icurval(k.kv, l_sr_expr * 100, p_date_to+1) / 100
                                ;
      end if;

      if k.kv = 980 then
        l_cp_dgp_zv_row.g057 := l_sr2 + l_sr3;                                             --!Накопичений (непогашений) купонний дохід на кінець дня звітної дати
        else
          l_cp_dgp_zv_row.g057 := gl.p_icurval(k.kv, l_sr2 * 100, p_date_to+1) / 100
                                + gl.p_icurval(k.kv, l_sr3 * 100, p_date_to+1) / 100 ;      -- -//- (в эквіваленті)
      end if;

      l_cp_dgp_zv_row.g058 := '-';                                                        --!потрібно видалити?--уточнення-- Сума резерву, фактично сформованого на кінець дня звітної дати, грн (згідно постанови № 23)

      l_rez := get_rezq39(k.ref, p_date_to);
      l_cp_dgp_zv_row.g059 := l_rez;                                                      --!тест--уточнення g025-- Сума резерву, розрахованого згідно вимог МСБО 39 на кінець дня звітної дати
      l_rez := nvl(l_rez,0);

      l_ss := 0;
      if k.accs is not null then
        l_ss := -rez.ostc96(k.accs, p_date_to+1) / 100;
      end if;
      if k.kv = 980 then
        l_cp_dgp_zv_row.g060 := l_ss;                                                        --!уточнення --Сума переоцінки на кінець дня звітної дати, визначена відповідно до вимог МСФЗ
        else
          l_cp_dgp_zv_row.g060 := gl.p_icurval(k.kv, l_ss * 100, p_date_to+1) / 100;     -- -//- (в эквіваленті)
      end if;

      l_sb := l_sn + (l_sd + l_sp) + (l_sr + l_sr2 + l_sr3) - l_rez  + l_ss;
      if  k.kv = 980 then
        l_cp_dgp_zv_row.g061 := l_sb;                                                        --!тест--уточнення G027--Балансова вартість на кінець дня звітної дати (згідно МСФЗ)
        else
          l_cp_dgp_zv_row.g061 := gl.p_icurval(k.kv, l_sb * 100, p_date_to+1) / 100;     -- -//- (в эквіваленті)
      end if;

      /*Фиалкович: Такой же что и для балансовой . На данный момент балансовая = справедливой, ну и конечно поделить на пакет, т к на 1 шт*/
      if l_sn = 0 then
        l_sb := null;
        else
          l_sb := round(l_sb / round(l_sn / l_cena, 0), 2);
      end if;
      if  k.kv = 980 then
        l_cp_dgp_zv_row.g062 := l_sb;                                                        --!тест--уточнення--Справедлива вартість ЦП згідно МСБО 39 на звітну дату за 1 шт
        else
          l_cp_dgp_zv_row.g062 := gl.p_icurval(k.kv, l_sb * 100, p_date_to+1) / 100;     -- -//- (в эквіваленті)
      end if;


      l_days_cnt := get_days_delay(k.ref, p_date_to);
      /*залежить від прострочки та ознаки Is_default  з Finevare (таблиця PRVN_FV_REZ)*/
      l_chr_start_time := dbms_utility.get_time;
      l_is_default := get_is_default(k.ref, p_date_to+1);
      l_chr_end_time := dbms_utility.get_time;
      if (l_chr_end_time - l_chr_start_time) / (100 * 60) > 1 then /*хвилин*/
        bars_audit.info(G_TRACE || l_title || ' Функція get_is_default('||k.ref||','||to_char(p_date_to+1, 'DD.MM.YYYY')||') відпрацьовує '||(l_chr_end_time - l_chr_start_time) / (100 * 60)||' хвилин');
      end if;
      if l_is_default = 1 then
        l_cp_dgp_zv_row.g063 := '4';                                                           --тест-- --уточнення g027-- Категорія якості за МСФЗ на кінець дня звітної дати
        else
          if l_is_default = 0 and l_days_cnt = 0 then
            l_cp_dgp_zv_row.g063 := '1';
          elsif l_is_default = 0 and l_days_cnt <= 30  then
            l_cp_dgp_zv_row.g063 := '2';
          elsif l_is_default = 0 and l_days_cnt between 30+1 and 60  then
            l_cp_dgp_zv_row.g063 := '3';
          else
            l_cp_dgp_zv_row.g063 := 'невідомо';
          end if;
      end if;

      l_cp_dgp_zv_row.g064 := get_riven(k.id, p_date_to);                                    --!тест--уточнення g030-- Рівень станом на звітну дату


      /*далі йде в розрізі продажів,
        тобіш на одну покупку додаються кількість рядків у звіт по кількості продажів
        (продажів 0 не помножає на 0 придбання :-) )
        [нажаль БМД не підтримує групування ячєйок так як Ексель]
      */
      l_cnt_prod := 0;
      for p in (select o.ref,
                  pp.nd,
                  pp.s / 100 s_p, -- сума угоди продажу всього пакета
                  o.s / 100 s,
                  o.stmt,
                  o.tt,
                  decode(vob, 096, pp.vdat, o.fdat) dat_opl,
                  pp.datp dat_ug,
                  ar.op ar_op,
                  nvl(ar.sumb, 0) / 100  ar_sumb,
                  nvl(ar.n, 0) / 100 ar_n,
                  pp.nazn
             from opldok o, oper pp, cp_arch ar
            where o.acc = k.acc
              and o.dk = 1
              and o.ref = pp.ref
              and o.ref = ar.ref(+)
              and o.fdat between p_date_from and p_date_to
              and o.sos = 5
              and pp.nazn like 'Продаж%'
            order by 1)
      loop
        l_cnt_prod := l_cnt_prod + 1;
        bars_audit.info(G_TRACE || l_title || ' l_cnt_prod =  '||l_cnt_prod||' k.acc='||k.acc||' ref_sale='||p.ref||' ref_buy='||k.ref||' nazn='||p.nazn);
        /*Показники групи: Реалізація протягом звітного періоду*/
        /*системні*/
        l_cp_dgp_zv_row.ref_sale := p.ref;
        -------
        if k.kv = 980 then
          l_cp_dgp_zv_row.g037 := p.s;                                                        --!Реалізація (погашення) за звітний період (номінальна вартість)
          else
            l_cp_dgp_zv_row.g037 := gl.p_icurval(k.kv, p.s * 100, p.dat_opl) / 100;     -- -//- (в эквіваленті)
        end if;

        if k.cena != k.cena_start then
          -- уточнення номінальної ціни 1 шт
          begin
            select k.cena_start - sum(nvl(a.nom, 0)) +
                   sum(decode(a.dok, k.dat_pg, nvl(a.nom, 0), 0))
              into l_cena --  6/04-15
              from cp_dat a
             where a.id = k.ID
               and a.DOK <= p.dat_opl;
             exception
               when NO_DATA_FOUND then l_cena := k.cena;
          end;
        else
          l_cena := k.cena; -- номінальна
        end if;

        l_kl := round(p.s / nvl(l_cena, k.cena), 0);
        l_cp_dgp_zv_row.g038 := l_kl;                                                        --!Реалізація (погашення) за звітний період, кількість

        if p.ar_op in (2, 3) then
          if nvl(l_kl, 1) != 0 then
            l_sn := case when nvl(p.ar_n, 0) = 0 then p.s else p.ar_n end;
            l_koeff := round(p.s / l_sn, 5);
            l_cena := round(nvl(p.ar_sumb, p.s_p) * l_koeff / nvl(l_kl, 1), 2);
          end if;
          elsif p.ar_op = 20 then
            l_cena := f_cena_cp(k.id, p.dat_opl);
          elsif p.ar_op = 22 then
            begin
              select nvl(nom, 0)
                into l_cena
                from cp_dat a
               where a.id = k.ID
                 and a.dok = (select max(dok)
                                from cp_dat
                               where id = k.id
                                 and dok < p.dat_opl);
            exception
              when NO_DATA_FOUND then
                l_cena := 0;
            end;
          else
            l_cena := 0;
        end if;

        if k.kv = 980 then
          l_cp_dgp_zv_row.g039 := l_cena;                                                        --!Ціна реалізації
          else
            l_cp_dgp_zv_row.g039 := gl.p_icurval(k.kv, l_cena * 100, p.dat_opl) / 100;     -- -//- (в эквіваленті)
        end if;

        if k.kv = 980 then
          l_cp_dgp_zv_row.g040 := p.s_p;                                                        --!тест--Сума фактично отриманих коштів за продані ЦП (сума за договором)
          else
            l_cp_dgp_zv_row.g040 := gl.p_icurval(k.kv, p.s_p * 100, p.dat_opl) / 100;     -- -//- (в эквіваленті)
        end if;

        select sum(o.sq) / 100 -- кредит по R/R2 при продажу
          into l_cp_dgp_zv_row.g041                                                          --!Накопичений купонний дохід, отриманий у ціні реалізації
          from opldok o
         where o.acc in (k.accr, k.accr2)
           and o.dk = 1
           and o.sos = 5 -- !? OBU/BARS
           and o.ref = p.ref;

        l_cp_dgp_zv_row.g042 := f_operw(p.ref, 'CP_FC');                                     --!тест--уточнення G036 --Форма проведення розрахунку

        l_cp_dgp_zv_row.g043 := to_char(p.dat_opl, 'DD.MM.YYYY');                            --! Дата реалізації

        l_cp_dgp_zv_row.g044 := nvl(nvl(get_cp_refw(p.ref, 'BRDOG'), get_cp_refw(k.ref, 'BRDOG')), p.nd);  --!Номер біржової угоди

        l_cp_dgp_zv_row.g045 := trim(get_kontragent(p.ref,
                                             'д контрагенту'));                              --!Назва покупця

        l_cp_dgp_zv_row.g046 := substr(get_cp_kodw(k.id, 'VYDCP'), 1, 255);                 --!тест--уточнення --Вид цінного паперу
        l_cp_dgp_zv_row.g047 := get_cp_refw(p.ref, 'VDOGO');                                --!тест--уточнення --Вид договору/контракту
        l_cp_dgp_zv_row.g048 := get_cp_refw(p.ref, 'VOPER');                                --!тест--уточнення --Вид операції

        /*Показники групи: Доходи за цінними паперами, отримані протягом звітного періоду*/

        select sum(decode(o.dk, 0, 1, 1, -1) * o.sq) / 100
          into l_rp                                                                         --безпосередньо результат від продажу
          from opldok o, opldok o2, accounts ak
         where o.dk = 1 - o2.dk
           and o.stmt = o2.stmt
           and o.tt = 'FXT'
           and o2.tt = 'FXT'
           and o.ref = o2.ref
           and o.ref = p.ref
           and ak.acc = o2.acc
           and (
                ak.nls like '6393%' or ak.nls like '6203%' or ak.nls like '3800%' -- OBU
               )
           and o.sos = 5;

        select sum(decode(o.dk, 0, 1, 1, -1) * o.sq) / 100
          into l_zp                                                                         --3115 - згортання переоцінки при продажі
          from opldok o, opldok o2, cp_deal d
         where o.dk = 1 - o2.dk
           and o.stmt = o2.stmt
/*           and o.tt = 'FX7'
           and o2.tt = 'FX7'*/
           and o.ref = o2.ref
           and o.ref = p.ref
           and d.accs = o2.acc
           and o.sos = 5;

        l_cp_dgp_zv_row.g065 := l_rp + l_zp;                                                --!тест--переуточнення через Абашидзе--Торговий дохід протягом звітного періоду
        /*!!!!!!! потрібно ще враховувати  (в т.ч. амортизація дисконту/премії)*/
        select /*nvl(sum(o.s), 0) / 100, */nvl(sum(o.sq), 0) / 100 -- по R при нарахуванні на 605
          into l_cp_dgp_zv_row.g066                                                          --тест--уточнення Сума процентного доходу протягом звітного періоду(в т.ч. амортизація дисконту/премії)
          from opldok o --, OPER P
         where o.acc = k.accr
           and o.dk = 0 --and o.ref=p.ref
           and o.sos = 5
           and o.fdat >= p_date_from
           and o.fdat <= p_date_to --and o.tt in ('FXU','FXU'
--           and o.tt in ('FX%', '080', '013')
           ;

        select sum(decode(o1.dk, 0, 1, 1, -1) * o1.sq) / 100
          into l_cp_dgp_zv_row.g067                                                         --!тест--6390 dk= 1, 7390 dk = 0 --доучточнення--уточнення --Визнання результату при первісному визнанні (рахунки 6390,7390)
          from opldok o1, opldok k1, accounts ak
         where o1.dk = 1 - k1.dk
           and o1.stmt = k1.stmt
/*           and o.tt = 'FXT'
           and k.tt = 'FXT'*/
           and o1.ref = k1.ref
           and o1.ref = /*p.ref*/ k.ref /*при купівлі ж ? */
           and ak.acc = k1.acc
           and (
                ak.nls like '6390%' or ak.nls like '7390%'
               )
           and o1.sos = 5;


        l_cp_dgp_zv_row.g068 := '-';                                                        --!уточнення --Курсова різниця, яка виникає під час виплати купонного доходу (різниця між курсом на дату нарахування і курсом на дату фактичної виплати купонного джоходу), грн.
        /* Фіалкович: Сергей не трогай эту колонку,  если вы решили  вопрос с Сауляк по отчетности по валютной переоценке. */

        l_cp_dgp_zv_row.g069 := '-';                                                        --!уточнення через Абашидзе--Результат переоцінки залишку внаслідок зміни валютних курсів протягом звітного періоду
       /* Абашидзе: Да, с Васей Хариным переговорила, он сказал, что помнит об этом вопросе, но не так легко у них взять алгоритм...
                   обещал, что в ближайшее время скажет результат*/


        select /*nvl(sum(o.s), 0) / 100, */nvl(sum(o.sq), 0) / 100 -- по R при нарахуванні на 605
          into l_cp_dgp_zv_row.g070                                                          --!тест--уточнення Сума процентного доходу протягом звітного періоду
          from opldok o --, OPER P
         where o.acc = k.accr
           and o.dk = 0 --and o.ref=p.ref
           and o.sos = 5
           and o.fdat >= p_date_from
           and o.fdat <= p_date_to --and o.tt in ('FXU','FXU'
--           and o.tt in ('FX%', '080', '013')
           ;

        /*!*/--l_cp_dgp_zv_row.g071 := '-';                                                        --Отриманий купон.дохід за звітний період
        select nvl(sum(o.sq), 0) / 100
          into l_cp_dgp_zv_row.g071                                                          --Отриманий купон, грн
          from opldok o
         where o.acc in (k.accr, k.accr2, k.accr3)
           and o.dk = 1
           and o.sos = 5
           and o.fdat >= p_date_from
           and o.fdat <= p_date_to;
           --and o.tt in ('FX7', 'FX8', 'F80');

        select /*nvl(sum(o.s), 0) / 100,*/ nvl(sum(o.sq), 0) / 100 -- по D при амортизації на 6
            into l_cp_dgp_zv_row.g072                                                        --!тест--уточнення --Амортизація дисконту протягом звітного періоду
            from opldok o
           where o.acc = k.accd
             and o.dk = 0
             and o.sos = 5
             and o.fdat >= p_date_from
             and o.fdat <= p_date_to
             --and o.tt in ('FXM', '080', '013')
             ;

        select /*nvl(sum(o.s), 0) / 100,*/ nvl(sum(o.sq), 0) / 100 -- по D при амортизації на 6
            into l_cp_dgp_zv_row.g073                                                        --!тест--уточнення --Амортизація премії протягом звітного період
            from opldok o
           where o.acc = k.accp
             and o.dk = 0
             and o.sos = 5
             and o.fdat >= p_date_from
             and o.fdat <= p_date_to
             --and o.tt in ('FXM', '080', '013')
             ;



        /* Фіалкович: Например: есть сделка, по ней за три месяца ( один раз в месяц) была проведена переоценка. В первый раз была дооценка (Дт1415, Кт5102),
                      а остальные два месяца- уценка (Дт5102 Кт 1415). В результате по счету 1415 в оборотах у нас есть и Дт и Кт.
                      Итого: Дт минус Кт равно сумма  со знаком (+) или (-). */
        select nvl(sum(case when o.dk = 0 then 0 else o.sq end), 0) / 100  - nvl(sum(case when o.dk = 1 then 0 else o.sq end), 0) / 100
          into l_cp_dgp_zv_row.g074                                                          --!тест--уточнення --Сумма інших сукупних доходів та витрат від зміни у вартості цінних парерів за МСФЗ за звітний період
          from opldok o
         where o.acc = k.accs
--           and o.dk = 0
           and o.sos = 5
           and o.fdat >= p_date_from
           and o.fdat <= p_date_to
--           and o.tt in ('FX%', '080', '013')
           ;


        insert into cp_dgp_zv values l_cp_dgp_zv_row;
      end loop;--по продажам

      l_cp_dgp_zv_row.g075 := '-';
      l_cp_dgp_zv_row.g076 := '-';
      l_cp_dgp_zv_row.g077 := '-';
      l_cp_dgp_zv_row.g078 := '-';
      l_cp_dgp_zv_row.g079 := '-';
      l_cp_dgp_zv_row.g080 := '-';
      l_cp_dgp_zv_row.g081 := '-';
      l_cp_dgp_zv_row.g082 := '-';
      l_cp_dgp_zv_row.g083 := '-';
      l_cp_dgp_zv_row.g084 := '-';
      l_cp_dgp_zv_row.g085 := '-';
      l_cp_dgp_zv_row.g086 := '-';

      if l_cnt_prod = 0 then --жодної продажі, але ж купівля була
        insert into cp_dgp_zv values l_cp_dgp_zv_row;
      end if;
      bars_audit.trace(G_TRACE || l_title || ' l_cnt =  '||l_cnt);
    end loop;
    close G_CUR;
    bars_audit.info(G_TRACE || l_title || ' Itog l_cnt =  '||l_cnt);
    send_msg('Кінець формування DGP008: для перегляду результату при запуску звіту нажміть Ні');            
    exception
      when others then
        bars_audit.error(G_TRACE || l_title || substr(dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace(), 1, 2000));
        if G_CUR%ISOPEN then
          close G_CUR;
        end if;
        send_msg('Звіт DGP008 при формуванні отримав помилку: '||G_TRACE || l_title || substr(dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace(), 1, 2000));        
        raise_application_error(-20001, G_TRACE || l_title || substr(dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace(), 1, 2000));
  end dgp8;


  procedure info_report_progress(p_date_from cp_dgp_zv.date_from%type,
                                 p_date_to   cp_dgp_zv.date_to%type,
                                 p_type_id   cp_dgp_zv_type.type_id%type) is
  pragma autonomous_transaction;
  /*
    - на тесті було довге формування звіту і веб відвалювався по таймауту
    - при запуску звіту можливо нажати "Ні", тоді має показати або останне успішне формування або цей запис
  */
    l_id        cp_kod.id%type;
    l_cp_dgp_zv cp_dgp_zv%rowtype;
  begin

    delete from cp_dgp_zv
     where user_id = user_id()
       and type_id = p_type_id;


    select id into l_id from cp_kod where rownum = 1;
    l_cp_dgp_zv.id          := l_id;
    l_cp_dgp_zv.user_id     := user_id();
    l_cp_dgp_zv.ref         := 0;
    l_cp_dgp_zv.type_id     := p_type_id;
    l_cp_dgp_zv.date_from   := p_date_from;
    l_cp_dgp_zv.date_to     := p_date_to;
    l_cp_dgp_zv.date_reg    := sysdate;
    l_cp_dgp_zv.kf          := gl.kf;
    l_cp_dgp_zv.g001        := 'Звіт за '||to_char(p_date_from,'DD.MM.YYYYY')||'-'||to_char(p_date_to,'DD.MM.YYYY');
    l_cp_dgp_zv.g002        := 'Запущено в '||to_char(sysdate,'HH24:MI DD.MM.YYYY');
    l_cp_dgp_zv.g003        := 'Звіт формується або такий що має помилки';
    insert into  cp_dgp_zv values l_cp_dgp_zv;
    commit;
  end;


  procedure prepare_dgp(p_date_from cp_dgp_zv.date_from%type,
                        p_date_to   cp_dgp_zv.date_to%type,
                        p_type_id   cp_dgp_zv_type.type_id%type) is
    l_title      constant varchar2(25) := 'prepare_dgp: ';
    l_date_from  cp_dgp_zv.date_from%type := nvl(p_date_from, gl.bd);
    l_date_to    cp_dgp_zv.date_to%type   := nvl(p_date_to, gl.bd);
  begin
    bars_audit.info(G_TRACE || l_title || ' Start p_date_from=>' ||
                    p_date_from || ' p_date_to=>' || p_date_to ||
                    ' p_type_id=>' || p_type_id);
    info_report_progress(l_date_from, l_date_to, p_type_id);--Записати автономною транзакцією про старт процесу (в звіті є функція відмовитись від переформатування звіту)
    delete from cp_dgp_zv
     where user_id = user_id()
       and type_id = p_type_id;
    case p_type_id
      when 7 then
        dgp7(l_date_from, l_date_to);
      when 8 then
        dgp8(l_date_from, l_date_to);
    end case;
    bars_audit.info(G_TRACE || l_title || ' End');
  end prepare_dgp;

end cp_rep_dgp;
/
 show err;
 
PROMPT *** Create  grants  BARS_ALIEN_PRIVS ***
grant EXECUTE                                                                on cp_rep_dgp to WR_ALL_RIGHTS;
grant EXECUTE                                                                on cp_rep_dgp to BARS_ACCESS_DEFROLE;