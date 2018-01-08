
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/accp_reports.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.ACCP_REPORTS is

  -- Author  : ivan.galisevych
  -- Created : 12.12.2015
  -- Purpose : Package for form reports for commision compensation payments (ACCP)

  g_header_version constant varchar2(64) := 'version 1.00 12/12/2015';

  -- рахунки, з яких здійснюється перерахування коштів
  D_NLS2909      constant varchar2(4) := '2909';
  D_NLS2909_OB22 constant varchar2(4) := '08';

  D_NLS2902      constant varchar2(4) := '2902';
  D_NLS2902_OB22 constant varchar2(4) := '03';

  -- рахунки, на які здійснюється перерахування коштів
  K_NLS2600 constant varchar2(4) := '2600';
  K_NLS2603 constant varchar2(4) := '2603';

  -- область дії договору
  SCOPE_CITY   constant integer := 1;
  SCOPE_DOMAIN constant integer := 2;
  SCOPE_ALL    constant integer := 3;

  type recordreportdata is record(
       name          varchar2(70),
       ndog          varchar2(20),
       ddog          date,
       okpo          varchar2(10),
       scope_dog     number(2),
       order_fee     number(2),
       amount_fee    number(5,2),
       fee_mfo       varchar2(6),
       fee_nls       varchar2(15),
       fee_okpo      varchar2(10),
       branch        varchar2(30),
       nls           varchar2(15),
       sum_pays      number,
       sum_ret_pays  number,
       sum_fee       number,
       sum_ret_fee   number,
       cnt_pays      number,
       sf_1          number,
       sf_2          number,
       sf_3          number,
       period_start  date,
       period_end    date);

  type TableReportData is table of recordreportdata;

  -- header_version - возвращает версию заголовка пакета
  function header_version return varchar2;
  -- body_version - возвращает версию тела пакета
  function body_version return varchar2;

  procedure get_docs(p_startdate in date,
                     p_enddate   in date,
                     p_okpo      in accp_orgs.okpo%type);

  function GetDataRep4(p_okpo in accp_orgs.okpo%type) return TableReportData
    pipelined;

end accp_reports;
/
CREATE OR REPLACE PACKAGE BODY BARS.ACCP_REPORTS is
  -- Версія пакету
  g_body_version constant varchar2(64) := 'version 1.04 13/04/2016';
  g_dbgcode      constant varchar2(20) := 'accp_reports';

  -- header_version - возвращает версию заголовка пакета
  function header_version return varchar2 is
  begin
    return 'Package header ' || g_dbgcode || ' ' || g_header_version || '.';
  end header_version;
  -- body_version - возвращает версию тела пакета
  function body_version return varchar2 is
  begin
    return 'Package body ' || g_dbgcode || ' ' || g_body_version || '.';
  end body_version;

  -------------------------------------------------------
  -- get_docs
  -- получить документы для отчетов
  --
  -------------------------------------------------------
  procedure get_docs(p_startdate in date,
                     p_enddate   in date,
                     p_okpo      in accp_orgs.okpo%type) is
    l_trace varchar2(1000) := g_dbgcode ||'.get_docs:';
    l_orgs_row    accp_orgs%rowtype;
    l_startdate date := trunc(p_startdate);
    l_stopdate  date := trunc(p_enddate);
    l_cnt       pls_integer;
    l_fee_amount  number;
    l_fee_int     number;

  begin
    bars_audit.info('get_docs start ' || to_char(p_startdate) || ' ' ||
                    to_char(p_enddate) || ' ' || p_okpo);

    -- clean tmp table after count
    delete from TMP_ACCP_DOCS where okpo_org = p_okpo;
    -- intrate for commision
    begin
      select *
        into l_orgs_row
        from accp_orgs
       where okpo = p_okpo;
    exception
      when no_data_found then
        return;
    end;
    -- платежі
    for d in 0..(l_stopdate - l_startdate) loop
      l_cnt:=0;
      for c in (SELECT a.branch,
                       o.mfoa,
                       o.mfob,
                       o.nam_a,
                       o.nam_b,
                       o.id_a,
                       o.id_b,
                       o.nazn,
                       o.tt,
                       o.REF,
                       o.s,
                       p.fdat,
                       o.nlsa,
                       o.nlsb,
                       o.kv
                  FROM opldok p, oper o, accounts a
                 WHERE p.sos = 5
                   and p.dk = 0
                   AND p.acc = a.acc
                   and p.ref = o.ref
                   and p.tt = o.tt
                   AND fdat = (l_startdate + d)
                   and ((a.nbs = D_NLS2909 and a.ob22 = D_NLS2909_OB22) or
                       (a.nbs = D_NLS2902 and a.ob22 = D_NLS2902_OB22))
                   and (o.nlsb like K_NLS2600 || '%' or
                       o.nlsb like K_NLS2603 || '%')
                   and o.id_b = p_okpo
                   and (o.mfob, o.nlsb) in
                       (select mfo, nls
                          from v_accp_accounts
                         where okpo = p_okpo
                           and check_on = 1)
                   and a.branch in
                       (select branch
                          from v_accp_branch
                         where obl like (select case scope_dog
                                                  when 1 then
                                                   '1'
                                                  when 2 then
                                                   '2'
                                                  else
                                                   '%'
                                                end obl
                                           from accp_orgs
                                          where okpo = p_okpo))) loop



        l_fee_amount   := case when  l_orgs_row.fee_type_id = 1 then c.s * l_orgs_row.amount_fee / 100   -- фиксированный %
                               when  l_orgs_row.fee_type_id = 2 then f_tarif(l_orgs_row.fee_by_tarif, 980, c.nlsa, c.s  )    -- на основании тарифов
                               else  0
                          end;


        bars_audit.trace(l_trace|| c.ref||', fee_amount='||l_fee_amount||',  l_orgs_row.fee_type_id = '||l_orgs_row.fee_type_id||'  c.s='||c.s);

        insert into tmp_accp_docs
          (okpo_org,
           typepl,
           ref,
           branch,
           fdat,
           nlsa,
           nlsb,
           mfoa,
           mfob,
           nam_a,
           nam_b,
           id_a,
           id_b,
           s,
           s_fee,
           order_fee,
           amount_fee,
           nazn,
           period_start,
           period_end)
        values
          (p_okpo,
           1,
           c.ref,
           c.branch,
           c.fdat,
           c.nlsa,
           c.nlsb,
           c.mfoa,
           c.mfob,
           c.nam_a,
           c.nam_b,
           c.id_a,
           c.id_b,
           c.s,
           l_fee_amount,
           l_orgs_row.order_fee,
           l_orgs_row.amount_fee,
           c.nazn,
           p_startdate,
           p_enddate);
        -- BARS_AUDIT.INFO('get_docs loop ' || to_char(c.ref ));
         l_cnt:=l_cnt+1;
      end loop;
      BARS_AUDIT.trace('get_docs loop #'||d||' '|| to_char(l_startdate + d)||', cnt='||l_cnt);
    end loop;

    -- повернення
    for d in 0..(l_stopdate - l_startdate) loop
      for c in (SELECT a.branch,
                       o.mfoa,
                       o.mfob,
                       o.nam_a,
                       o.nam_b,
                       o.id_a,
                       o.id_b,
                       o.nazn,
                       o.tt,
                       o.REF,
                       -o.s as s,
                       p.fdat,
                       o.nlsa,
                       o.nlsb
                  FROM opldok p, oper o, accounts a
                 where p.sos = 5
                   and p.dk = 1
                   AND p.acc = a.acc
                   and p.ref = o.ref
                   and p.tt = o.tt
                   and fdat = (l_startdate + d)
                   and ((a.nbs = D_NLS2909 and a.ob22 = D_NLS2909_OB22) or
                       (a.nbs = D_NLS2902 and a.ob22 = D_NLS2902_OB22))
                   and (o.nlsa like K_NLS2600 || '%' or
                       o.nlsa like K_NLS2603 || '%')
                   and o.id_a = p_okpo
                   and (o.mfoa, o.nlsa) in
                       (select mfo, nls
                          from v_accp_accounts
                         where okpo = p_okpo
                           and check_on = 1)
                   and a.branch in
                       (select branch
                          from v_accp_branch
                         where obl like (select case scope_dog
                                                  when 1 then
                                                   '1'
                                                  when 2 then
                                                   '2'
                                                  else
                                                   '%'
                                                end obl
                                           from accp_orgs
                                          where okpo = p_okpo))) loop

        insert into tmp_accp_docs
          (okpo_org,
           typepl,
           ref,
           branch,
           fdat,
           nlsa,
           nlsb,
           mfoa,
           mfob,
           nam_a,
           nam_b,
           id_a,
           id_b,
           s,
           s_fee,
           order_fee,
           amount_fee,
           nazn,
           period_start,
           period_end)
        values
          (p_okpo,
           2,
           c.ref,
           c.branch,
           c.fdat,
           c.nlsa,
           c.nlsb,
           c.mfoa,
           c.mfob,
           c.nam_a,
           c.nam_b,
           c.id_a,
           c.id_b,
           c.s,
           c.s * l_orgs_row.amount_fee / 100,
           l_orgs_row.order_fee,
           l_orgs_row.amount_fee,
           c.nazn,
           p_startdate,
           p_enddate);
      end loop;
      BARS_AUDIT.trace('get_docs back part, loop #'||d||', '|| to_char(l_startdate + d));
    end loop;
    BARS_AUDIT.INFO('get_docs finish ' || to_char(p_startdate) || ' ' ||
                    to_char(p_enddate) || ' ' || p_okpo);

    --
    commit;
  end get_docs;

-- отримання даних для Акту 4
function GetDataRep4(p_okpo in accp_orgs.okpo%type) return TableReportData
  pipelined is
  l_row   RecordReportData;
  l_r_org accp_orgs%rowtype;
  l_bottom_sum    number :=0;
  l_bottom_sumfee number :=0;
  l_bottom_sumret number :=0;
  l_bottom_sumret_fee number :=0;
  l_bottom_cnt    pls_integer :=0;

  l_bottom_sf1 number :=0;
  l_bottom_sf2 number :=0;
  l_bottom_sf3 number :=0;

begin
  begin
    select * into l_r_org from accp_orgs where okpo = p_okpo;
  exception
    when no_data_found then
      return;
  end;
  -- параметри організації
  l_row.name       := l_r_org.name;
  l_row.ndog       := l_r_org.ndog;
  l_row.ddog       := l_r_org.ddog;
  l_row.okpo       := l_r_org.okpo;
  l_row.scope_dog  := l_r_org.scope_dog;
  l_row.order_fee  := l_r_org.order_fee;
  l_row.amount_fee := l_r_org.amount_fee;
  l_row.fee_mfo    := l_r_org.fee_mfo;
  l_row.fee_nls    := l_r_org.fee_nls;
  l_row.fee_okpo   := l_r_org.fee_okpo;

  for cur in (select branch, decode(typepl, 1, nlsb, 2, nlsa) nls, period_start, period_end
                from tmp_accp_docs t
               where okpo_org = p_okpo
                 and t.check_on = 1
               group by branch, decode(typepl, 1, nlsb, 2, nlsa),period_start, period_end) loop
    l_row.branch:=cur.branch;
    l_row.nls :=cur.nls;
    l_row.period_start:=cur.period_start;
    l_row.period_end:=cur.period_end;
    /*
    select nvl(sum(t.s)/100,0), nvl(sum(t.s_fee)/100,0), count(1)
      into l_row.sum_pays, l_row.sum_fee, l_row.cnt_pays
      from tmp_accp_docs t
     where okpo_org = p_okpo and t.check_on = 1
       and branch=cur.branch and nlsb=cur.nls and typepl=1;
     */
      select
          s as sum_pays,
          case
           when l_row.order_fee=2 then sf_2
           when l_row.order_fee=3 then sf_3
           else sf_1
          end as sum_fee,
          cnt_pays,
          sf_1, sf_2, sf_3
       into l_row.sum_pays, l_row.sum_fee, l_row.cnt_pays, l_row.sf_1, l_row.sf_2, l_row.sf_3
    from
     (-- загальна сума за період
      select
            sum(sum_pays_d) s,     -- сума платежів
            sum(sum_fee_p)  sf_1,  -- сума комісій по кожному платежу
            sum(round(sum_fee_d,2))  sf_2, -- сума комісій за день
            round(sum(sum_pays_d)*l_row.amount_fee/100,2) sf_3, -- комісія за місяць
            sum(cnt_pays) cnt_pays  -- кількість платежів
       from
            ( -- групуємо по днях
            select fdat,
                   sum(s)/100     sum_pays_d, -- сума документів за день (грн)
                   sum(s_fee)/100 sum_fee_p,  -- сума комісій по кожному платежу за день (для суми за місяць)
                   sum(s)/100*(l_row.amount_fee/100) sum_fee_d, -- комісія за день
                   count(1) cnt_pays
              from tmp_accp_docs t
              where okpo_org = p_okpo and t.check_on = 1
                and branch=cur.branch and nlsb=cur.nls and typepl=1
          group by fdat));

    l_bottom_sum:=l_bottom_sum+l_row.sum_pays;
    l_bottom_sumfee:=l_bottom_sumfee+l_row.sum_fee;
    l_bottom_cnt := l_bottom_cnt + l_row.cnt_pays;

    l_bottom_sf1:=l_bottom_sf1+l_row.sf_1;
    l_bottom_sf2:=l_bottom_sf2+l_row.sf_2;
    l_bottom_sf3:=l_bottom_sf3+l_row.sf_3;
    /*
    select nvl(sum(t.s)/100,0), nvl(sum(t.s_fee)/100,0)
      into l_row.sum_ret_pays, l_row.sum_ret_fee
      from tmp_accp_docs t
     where okpo_org = p_okpo and t.check_on = 1
       and branch=cur.branch and nlsa=cur.nls and typepl=2;
     */
          select
          s as sum_pays,
          case
           when l_row.order_fee=2 then sf_2
           when l_row.order_fee=3 then sf_3
           else sf_1
          end as sum_fee
      into l_row.sum_ret_pays, l_row.sum_ret_fee
    from
     (-- загальна сума за період
      select
            sum(sum_pays_d) s,     -- сума платежів
            sum(sum_fee_p)  sf_1,  -- сума комісій по кожному платежу
            sum(round(sum_fee_d,2))  sf_2, -- сума комісій за день
            round(sum(sum_pays_d)*l_row.amount_fee/100,2) sf_3, -- комісія за місяць
            sum(cnt_pays) cnt_pays  -- кількість платежів
       from
            ( -- групуємо по днях
            SELECT fdat,
                   sum(s)/100     sum_pays_d, -- сума документів за день (грн)
                   sum(s_fee)/100 sum_fee_p,  -- сума комісій по кожному платежу за день (для суми за місяць)
                   sum(s)/100*(l_row.amount_fee/100) sum_fee_d, -- комісія за день
                   count(1) cnt_pays
              FROM TMP_ACCP_DOCS t
              where okpo_org = p_okpo and t.check_on = 1
                and branch=cur.branch and nlsa=cur.nls and typepl=2
          GROUP BY fdat));

    l_bottom_sumret:=l_bottom_sumret+nvl(l_row.sum_ret_pays,0);
    l_bottom_sumret_fee:=l_bottom_sumret_fee+nvl(l_row.sum_ret_fee,0);

    -- від суми комісії віднімаємо суму комісії по поверненнях (sum_ret_fee з знаком -)
    l_row.sum_fee := nvl(l_row.sum_fee,0) + nvl(l_row.sum_ret_fee,0);

    pipe row(l_row);
  end loop;
  --final row
  /*
  l_row.branch:=null;
  l_row.nls :=null;
  l_row.sum_pays:=l_bottom_sum;
  l_row.sum_fee :=l_bottom_sumfee;
  l_row.sum_ret_pays:=l_bottom_sumret;
  l_row.sum_ret_fee :=l_bottom_sumret_fee;
  l_row.cnt_pays  := l_bottom_cnt;

  l_row.sf_1 :=l_bottom_sf1;
  l_row.sf_2 :=l_bottom_sf2;
  l_row.sf_3 :=l_bottom_sf3;

  pipe row(l_row);
  */

end GetDataRep4;

begin
  -- Initialization
  null;
end accp_reports;
/
 show err;
 
PROMPT *** Create  grants  ACCP_REPORTS ***
grant EXECUTE                                                                on ACCP_REPORTS    to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/accp_reports.sql =========*** End **
 PROMPT ===================================================================================== 
 