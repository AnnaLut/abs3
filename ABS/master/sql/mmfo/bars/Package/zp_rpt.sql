create or replace package zp_rpt is

  gc_head_version  constant varchar2(64)  := 'version 1.0 04.12.2017';

  -----------------------------------------------------------------------------------------
  --  t_akt1_data
  --
  --    Тип для звіту "Акт виконаних робіт" -- AKT1.frx
  --  
  type r_akt1_data is record (
    f_ourmfo gl.aMfo%type,
    tax      number,
    taxtxt   varchar2(100),
    s        number,
    sumtxt   varchar2(100)
    );
  type t_akt1_data is table of r_akt1_data;

  -----------------------------------------------------------------------------------------
  --  t_rahunk1_data
  --
  --    Тип для звіту "Рахунок на сплату банківських послуг за період" -- rahunk1.frx
  --  
  type r_rahunk1_data is record (
    s            number,
    sumtxt       varchar2(100),
    vdat         varchar2(100),
    tarif        varchar2(30),
    posl         number,
    name         varchar2(500),
    username     staff$base.fio%type,
    name_branch  branch_attribute_value.attribute_value%type,
    nls_3570     accounts.nls%type,
    mfo          varchar2(100),
    branch_okpo  varchar2(4000),
    address      varchar2(4000),
    phones       varchar2(4000),
    nmk          customer.nmk%type,
    okpo         varchar2(100)
    );
  type t_rahunk1_data is table of r_rahunk1_data;

  -----------------------------------------------------------------------------------------
  --  t_rahunok_data
  --
  --    Тип для звіту "Рахунок загальний" -- rahunok.frx
  --  
  type r_rahunok_data is record (
    s            number,
    cnt          number,
    sumtxt       varchar2(100),
    vdat         varchar2(100),
    posl         number,
    name         varchar2(500),
    username     staff$base.fio%type,
    name_branch  branch_attribute_value.attribute_value%type,
    nls_3570     accounts.nls%type,
    mfo          varchar2(100),
    branch_okpo  varchar2(4000),
    address      varchar2(4000),
    phones       varchar2(4000),
    nmk          customer.nmk%type,
    okpo         varchar2(100)    
    );
  type t_rahunok_data is table of r_rahunok_data;

  --
  -- определение версии заголовка пакета
  --
  function header_version return varchar2;
  --
  -- определение версии тела пакета
  --
  function body_version   return varchar2;
  
  -----------------------------------------------------------------------------------------
  --  fill_akt1
  --
  --    Дані для звіту "Акт виконаних робіт" -- AKT1.frx
  --  
  function fill_akt1(
    p_rnk    in zp_payroll.rnk%type,
    p_sdate1 in varchar2,
    p_sdate2 in varchar2
    ) return t_akt1_data pipelined;

  -----------------------------------------------------------------------------------------
  --  fill_rahunk1
  --
  --    Дані для звіту "Рахунок на сплату банківських послуг за період" -- rahunk1.frx
  --  
  function fill_rahunk1(
    p_rnk    in zp_payroll.rnk%type,
    p_sdate1 in varchar2,
    p_sdate2 in varchar2
    ) return t_rahunk1_data pipelined;

  -----------------------------------------------------------------------------------------
  --  fill_rahunok
  --
  --    Дані для звіту "Рахунок загальний" -- rahunok.frx
  --  
  function fill_rahunok(p_rnk in zp_payroll.rnk%type) return t_rahunok_data pipelined;

end zp_rpt;
/
create or replace package body zp_rpt is

  gc_body_version constant varchar2(64)   := 'version 1.0 04.12.2017';

  -- версія заголовка пакета
  function header_version return varchar2 is
  begin
    return 'Package header: '||gc_head_version;
  end header_version;
  --
  -- версія тіла пакета
  --
  function body_version return varchar2 is
  begin
    return 'Package body  : '||gc_body_version;
  end body_version;

  -----------------------------------------------------------------------------------------
  --  fill_akt1
  --
  --    Дані для звіту "Акт виконаних робіт" -- AKT1.frx
  --  
  function fill_akt1(
    p_rnk    in zp_payroll.rnk%type,
    p_sdate1 in varchar2,
    p_sdate2 in varchar2
    ) return t_akt1_data pipelined
  is
    l_data t_akt1_data;
  begin
    select f_ourmfo,
           sum(cms) tax,
           trim(
             substr(f_sumpr (sum(cms)*100, 980, 'F'),
                     1,
                     100)
             ) taxtxt,
           sum(s) s,
           trim(
             substr (f_sumpr ( sum(s)*100, 980, 'F'),
                     1,
                     100)
             ) sumtxt
    bulk collect into l_data
    from v_zp_payroll z
    where z.rnk = p_rnk
         and z.pr_Date between to_date( p_sdate1, 'dd.mm.yyyy') and to_date(p_sdate2, 'dd.mm.yyyy')
    group by zp_id;
    
    if l_data.count = 0 then
      raise no_data_found;
    end if;
    
    for i in l_data.first..l_data.last
    loop
      pipe row(l_data(i));
    end loop;
  
  exception 
    when no_data_found then
      raise_application_error(-20001, 'Відсутні дані для звіту "Акт виконаних робіт"');
    when others then
      raise_application_error(-20000, 'Помилка формування звіту "Акт виконаних робіт"' || chr(10) || dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end fill_akt1;

  -----------------------------------------------------------------------------------------
  --  fill_rahunk1
  --
  --    Дані для звіту "Рахунок на сплату банківських послуг за період" -- rahunk1.frx
  --  
  function fill_rahunk1(
    p_rnk    in zp_payroll.rnk%type,
    p_sdate1 in varchar2,
    p_sdate2 in varchar2
    ) return t_rahunk1_data pipelined
  is
    l_data t_rahunk1_data;
  begin
    select s,
         trim (substr (f_sumpr (cms*100, 980, 'F'), 1, 100)) sumtxt,
         vdat,
         trim(to_char(round(cms/s*100,2),'90D99')|| ' %') tarif,
         cms posl,
            trim (substr (zp.tarif_name, 1, length (zp.tarif_name) - 1))
         || '" згідно договору про надання послуг з обслуговування зарплатного проекту №'
         || zp.deal_id
         || ' від '
         || to_char (zp.start_date, 'dd/mm/yyyy')
            name,
         (select t.fio
            from staff$base t
           where t.id = zp.user_id)
            username,
         (select bav.attribute_value
            from branch_attribute_value bav
           where     bav.attribute_code = 'NAME_BRANCH'
                 and bav.branch_code = zp.branch)
            name_branch,
         zp.nls_3570,
         'МФО ' || zp.kf mfo,
         'Код ЄДРПОУ ' || (select bav.attribute_value
            from branch_attribute_value bav
           where bav.attribute_code = 'OKPO' and bav.branch_code = zp.branch)
            branch_okpo,
         (case
             when (select bav.attribute_value
                     from branch_attribute_value bav
                    where     bav.attribute_code = 'ADDRESS'
                          and bav.branch_code = zp.branch)
                     is not null
             then
                (select bav.attribute_value
                   from branch_attribute_value bav
                  where     bav.attribute_code = 'ADDRESS'
                        and bav.branch_code = zp.branch)
             else
                (select bav.attribute_value
                   from branch_attribute_value bav
                  where     bav.attribute_code = 'ADR_BRANCH'
                        and bav.branch_code = zp.branch)
          end)
            address,
         (select 'Тел.' || bav.attribute_value
            from branch_attribute_value bav
           where bav.attribute_code = 'PHONES' and bav.branch_code = zp.branch)
            phones,
         zp.nmk nmk,
         'Код ЄДРПОУ ' || zp.okpo okpo
    bulk collect into l_data
    from (select zpp.s,
                 zpp.cms,
                    to_char (extract (day from zpp.pr_date))
                 || ' '
                 || decode (to_char (zpp.pr_date, 'MM'),
                            '01', 'січня',
                            '02', 'лютого',
                            '03', 'березня',
                            '04', 'квітня',
                            '05', 'травня',
                            '06', 'червня',
                            '07', 'липня',
                            '08', 'серпня',
                            '09', 'вересня',
                            '10', 'жовтня',
                            '11', 'листопада',
                            '12', 'грудня',
                            null)
                 || ' '
                 || to_char (extract (year from zpp.pr_date))
                 || ' р.'
                    vdat
          from v_zp_payroll zpp
          where zpp.rnk = p_rnk
                and zpp.sos = 5
                and zpp.pr_date between to_date(p_sdate1, 'dd.mm.yyyy') and to_date(p_sdate2,'dd.mm.yyyy')
          order by zpp.pr_date),
          v_zp_deals zp
    where zp.sos >= 0 and zp.rnk = p_rnk;
     
    if l_data.count = 0 then
      raise no_data_found;
    end if;
    
    for i in l_data.first..l_data.last
    loop
      pipe row(l_data(i));
    end loop;
  
  exception 
    when no_data_found then
      raise_application_error(-20001, 'Відсутні дані для звіту "Рахунок на сплату банківських послуг за період"');
    when others then
      raise_application_error(-20000, 'Помилка формування звіту "Рахунок на сплату банківських послуг за період". ' || chr(10) || dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end fill_rahunk1;

  -----------------------------------------------------------------------------------------
  --  fill_rahunok
  --
  --    Дані для звіту "Рахунок загальний" -- rahunok.frx
  --
  function fill_rahunok(p_rnk in zp_payroll.rnk%type) return t_rahunok_data pipelined
  is
    l_data t_rahunok_data;
  begin
    select s,
           cnt, 
           trim (substr (f_sumpr (cms * 100, 980, 'F'), 1, 100)) sumtxt,
           vdat,
           --zp.max_tarif tarif,
           cms posl,
           trim (substr (zp.tarif_name, 1, length (zp.tarif_name) - 1))
            || '" згідно договору про надання послуг з обслуговування зарплатного проекту №'
            || zp.deal_id
            || ' від '
            || to_char (zp.start_date, 'dd/mm/yyyy')
            name,
           (select t.fio
              from staff$base t
             where t.id = zp.user_id)
              username,
           (select bav.attribute_value
              from branch_attribute_value bav
             where     bav.attribute_code = 'NAME_BRANCH'
                   and bav.branch_code = zp.branch)
              name_branch,
           zp.nls_3570,
           'МФО ' || zp.kf mfo,
              'Код ЄДРПОУ '
           || (select bav.attribute_value
                 from branch_attribute_value bav
                where bav.attribute_code = 'OKPO' and bav.branch_code = zp.branch)
              branch_okpo,
           (case
               when (select bav.attribute_value
                       from branch_attribute_value bav
                      where     bav.attribute_code = 'ADDRESS'
                            and bav.branch_code = zp.branch)
                       is not null
               then
                  (select bav.attribute_value
                     from branch_attribute_value bav
                    where     bav.attribute_code = 'ADDRESS'
                          and bav.branch_code = zp.branch)
               else
                  (select bav.attribute_value
                     from branch_attribute_value bav
                    where     bav.attribute_code = 'ADR_BRANCH'
                          and bav.branch_code = zp.branch)
            end)
              address,
           (select bav.attribute_value
              from branch_attribute_value bav
             where bav.attribute_code = 'PHONES' and bav.branch_code = zp.branch)
              phones,
           zp.nmk nmk,
           'Код ЄДРПОУ ' || zp.okpo okpo
    bulk collect into l_data
    from (  select sum (zpp.s) s,
                   sum (zpp.cms) cms,
                   sum (zpp.cnt) cnt,
                      to_char (extract (day from max (zpp.pr_date)))
                   || ' '
                   || decode (to_char (max (zpp.pr_date), 'MM'),
                              '01', 'січня',
                              '02', 'лютого',
                              '03', 'березня',
                              '04', 'квітня',
                              '05', 'травня',
                              '06', 'червня',
                              '07', 'липня',
                              '08', 'серпня',
                              '09', 'вересня',
                              '10', 'жовтня',
                              '11', 'листопада',
                              '12', 'грудня',
                              null)
                   || ' '
                   || to_char (extract (year from max (zpp.pr_date)))
                   || ' р.'
                      vdat
              from v_zp_payroll zpp
             where zpp.sos = 5 and zpp.rnk = p_rnk
          group by 1),
         v_zp_deals zp
    where zp.sos >= 0 and zp.rnk = p_rnk;
      
    if l_data.count = 0 then
      raise no_data_found;
    end if;
    
    for i in l_data.first..l_data.last
    loop
      pipe row(l_data(i));
    end loop;
  
  exception 
    when no_data_found then
      raise_application_error(-20001, 'Відсутні дані для звіту "Рахунок загальний"');
    when others then
      raise_application_error(-20000, 'Помилка формування звіту "Рахунок загальний". ' || chr(10) || dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end fill_rahunok;

begin
  -- Initialization
  null;
end zp_rpt;
/
show err;
/
grant execute on bars.zp_rpt to  bars_access_defrole;
/
