CREATE OR REPLACE PACKAGE INTG_WB
IS
  --
  -- пакет процедур для работы интеграции веб банкинга "Вклады населения-WEB"
  -- часть 1 продуктовый ряд депозитов
  --
  g_header_version  CONSTANT VARCHAR2(64)  := 'version 1.07 05.04.2017';
  
  procedure header_mode (gmode in int);
  
  FUNCTION header_version RETURN varchar2;
  FUNCTION body_version   RETURN varchar2;

  type r_dpttype is record (id number, sjson clob);
  type t_dpttype is table of r_dpttype;

  subtype r_dptvidd is dpt_vidd%rowtype;
  type t_dptvidd is table of r_dptvidd;

  subtype r_dpt_desc is dpt_types_param%rowtype;
  type t_dpt_desc is table of r_dpt_desc;


  function get_dpt_vidd(p_id in number, p_period in varchar2, p_lcv in varchar2, p_comproc in number, p_FREQ_K in varchar2) return t_dptvidd pipelined;
  function form_rec(p_title varchar2, p_val varchar2) return varchar2;
  function form_object(p_title varchar2, p_val clob) return clob;
  function form_object_lvl(p_title varchar2, p_val clob) return clob;
  function formatISO_8601(duration_years in int, duration_month in int, duration_days in int) return varchar2;

  function get_type_currencies(p_type_id int) return clob;
  function get_type_periods(p_type_id int, p_kv int) return clob;
  function get_type_interestPayment(p_type_id int) return varchar2;
  function get_type_reinvestInterest(p_type_id int) return varchar2;
  function get_vidd_reinvestInterest(p_vidd int) return varchar2;
  function get_type_interests(p_type_id int, p_kv int, p_period varchar2) return varchar2;
  function get_type_topupAmount(p_type_id int) return varchar2;
  function get_type_earlyClose(p_type_id int) return varchar2;
  function get_type_withdrawal(p_type_id int) return varchar2;
  function get_type_autoProlAllowed(p_type_id int) return varchar2;
  function get_type_highPriority(p_type_id int) return varchar2;
  function get_type_clientSegments(p_type_id int) return varchar2;
  function get_type_descriptions(p_type_id int) return t_dpt_desc pipelined;

  function get_dpt_product(p_id in number) return t_dpttype pipelined;
  function get_dpt_products return t_dpttype pipelined;
  --procedure ins_json(id in int, sjson1 in clob, sjson2 in clob);
  function get_loyality_rate(p_vidd dpt_vidd.vidd%type, p_kv tabval.kv%type) return number;
  procedure frx2ea(p_deposit_id in dpt_deposit.deposit_id%type, p_rnk in customer.rnk%type, p_flags in dpt_vidd_flags.id%type);
  procedure makeblob(dpt_id in dpt_deposit.deposit_id%type, report in blob, flags in dpt_vidd_flags.id%type);
END INTG_WB;
/
CREATE OR REPLACE PACKAGE BODY INTG_WB
IS
  --
  -- пакет процедур для работы интеграции веб банкинга "Вклады населения-WEB"
  -- часть 1 продуктовый ряд депозитов
  --
  g_body_version  CONSTANT VARCHAR2(64)  := 'version 1.31 02.08.2017';
  G_ERRMOD        CONSTANT VARCHAR2 (3) := 'BCK';
  g_is_error      CONSTANT BOOLEAN := FALSE;
  g_cur_rep_id    CONSTANT NUMBER := -1;
  g_cur_block_id  CONSTANT NUMBER := -1;
  G_XMLHEAD       CONSTANT VARCHAR2 (100) := '<?xml version="1.0" encoding="utf-8"?>' ;
  g_prod_mode     NUMBER := 1; -- брать активные/неактивные продукты 1- брать и активные и неактивные продукты/субпродукты; 2 - брать только активные продукты.субпродукты

  procedure header_mode (gmode in int) is
    begin 
      g_prod_mode := gmode;
      end;

  FUNCTION header_version RETURN VARCHAR2
    IS
    BEGIN
      RETURN 'Package header INTG_WB '||g_header_version;
    END header_version;

    FUNCTION body_version RETURN VARCHAR2
    IS
    BEGIN
      RETURN 'Package body INTG_WB '||g_body_version;
    END body_version;

    function formatISO_8601(duration_years in int, duration_month in int, duration_days in int) return varchar2
    is
     l_result varchar2(500) := 'P';
     l_years int := nvl(duration_years,0);
     l_months int := nvl(duration_month,0);
     l_days int := nvl(duration_days,0);
    begin
     if l_months >= 12
     then
      l_years := l_years + floor(l_months/12);
      l_months := l_months -  l_years*12;
     end if;
     if (l_years > 0) then l_result := l_result ||to_char(l_years)|| 'Y'; end if;
     if (l_months > 0) then l_result := l_result ||to_char(l_months)|| 'M'; end if;
     if l_days > 0 then l_result := l_result ||to_char(l_days) || 'D'; end if;

     return l_result;
    end;



    function form_rec(p_title varchar2, p_val varchar2) return varchar2
    is
     l_result varchar2(32000);
    begin
     if (nvl(p_title,' ') != ' ')
     then l_result := '"'||p_title||'":"'|| p_val ||'"';
     else l_result :=  p_val ;
     end if;
     return l_result;
    end;


    function form_object(p_title varchar2, p_val clob) return clob
    is
     l_result clob := null;
    begin
     dbms_lob.createtemporary(l_result,FALSE);
     if (nvl(p_title,' ') = ' ')
     then dbms_lob.append(l_result,'{'|| p_val ||'}');
     else dbms_lob.append(l_result,'"'||p_title||'":{'|| p_val ||'}');
     end if;
     return l_result;
    end;

   function form_object_lvl(p_title varchar2, p_val clob) return clob
    is
     l_result clob := null;
    begin
     dbms_lob.createtemporary(l_result,FALSE);
     if (nvl(p_title,' ') = ' ')
     then dbms_lob.append(l_result,'[{'|| p_val ||']}');
     else dbms_lob.append(l_result,'"'||p_title||'":['|| p_val ||']');
     end if;
     return l_result;
    end;

   function get_type_currencies(p_type_id int) return clob
    is
     l_result clob := null;
     l_counter number(10) := 0;
    begin
     dbms_lob.createtemporary(l_result,FALSE);
     dbms_lob.append(l_result, '"currencies":[');
     for k in ( SELECT intg_wb.form_object (
                           '',
                              intg_wb.form_rec ('code', lcv)
                           || ','
                           || intg_wb.form_rec ('maxPeriod', intg_wb.formatISO_8601 (0,DURATION,DURATION_DAYS))
                           || ','
                           || intg_wb.form_rec ('minAmount', MIN_SUMM)
                           || ','
                           || intg_wb.form_rec ('maxAmount', 1000000000)
                           || ','
                           || intg_wb.get_type_periods (type_id, kv)) str
                FROM (SELECT DISTINCT kv, lcv,
                                      type_id,
                                      min_summ,
                                      FLOOR (duration / 30) duration,
                                      duration / 30 - FLOOR (duration / 30) duration_days
                        FROM (SELECT dv1.kv, t.lcv,
                                     dv1.type_id,
                                     dv1.MIN_SUMM,
                                     MAX (DV1.DURATION * 30 + DV1.DURATION_DAYS) OVER (PARTITION BY dv1.kv, dv1.type_id, dv1.MIN_SUMM) duration
                                FROM dpt_vidd dv1, tabval t
                               WHERE dv1.type_id = p_type_id
                                 AND t.kv = dv1.kv
                                 --and dv1.flag = 1
                                 and (dv1.flag = 1 or g_prod_mode = 1)
                                 )))
    loop
     if l_counter = 0
     then dbms_lob.append(l_result, k.str);
     else dbms_lob.append(l_result, ',' || k.str);
     end if;
        l_counter := l_counter +1;
    end loop;
    dbms_lob.append(l_result,']');

    return l_result;
    end;

  function get_type_periods(p_type_id int, p_kv int) return clob
   is
   l_result clob := null;
   l_clob   clob := null;

   type l_record is record (lclob clob);
   type l_table is table of l_record;
   l_t l_table;
    begin
     dbms_lob.createtemporary(l_result,FALSE);
     dbms_lob.createtemporary(l_clob,FALSE);
     select *
       bulk collect
       into l_t
       from (
     select intg_wb.form_object ('', intg_wb.form_rec ('code',dd)|| ','
                      --|| intg_wb.get_vidd_reinvestInterest(vidd) || ','
                      || case when intg_wb.get_vidd_reinvestInterest(vidd) is not null
                              then intg_wb.get_vidd_reinvestInterest(vidd) || ','
                         end
                      || concatstr (intg_wb.get_type_interests (p_type_id,p_kv,dd))) from
     (SELECT dd, min(vidd) vidd--, comproc
                 FROM (select intg_wb.formatISO_8601 (0,DV1.DURATION,DV1.DURATION_DAYS) dd, dv1.vidd, comproc
                            from dpt_vidd dv1
                 WHERE     dv1.type_id = p_type_id
                   AND dv1.kv = p_kv
                   --and DV1.FLAG = 1
                   and (dv1.flag = 1 or g_prod_mode = 1)
                   AND NVL (DV1.DURATION, 0) + NVL (DV1.DURATION_DAYS, 0) > 0)
               group by dd--, comproc
              )
        group by dd, vidd);
     for i in 1 ..  l_t.count
     loop
      dbms_lob.append(l_clob, l_t(i).lclob);
      if i < l_t.count then dbms_lob.append(l_clob,',');end if;
     end loop;

    dbms_lob.append(l_result, intg_wb.form_object_lvl ('periods',l_clob) );
    return l_result;
    end;

  function get_type_interests(p_type_id int, p_kv int, p_period varchar2) return varchar2 is
     l_result varchar2(32000);
    begin
           SELECT concatstr (intg_wb.form_object (
                  '',
                        intg_wb.form_rec ('minAmount', s)
                     || ','
                     || intg_wb.form_rec ('value', rate)))
          INTO l_result
          FROM (select type_id, rate, min(s) s, kv, br_id from
                ( SELECT DISTINCT dv.type_id,
                                  t.rate+intg_wb.get_loyality_rate(dv.vidd, dv.kv) rate,
                                  greatest(nvl(t.s/100,0),nvl(dv.min_summ,0)) s,
                                  dv.kv,
                                  dv.br_id,
                                  dv.vidd
                    FROM ( select dv1.type_id, dv1.kv, dv1.br_id, dv1.min_summ, dv1.vidd
                             from dpt_vidd dv1
                            where dv1.type_id = p_type_id
                              AND dv1.kv = p_kv
                              --AND dv1.flag = 1
                              and (dv1.flag = 1 or g_prod_mode = 1)
                              AND intg_wb.formatISO_8601 (0,
                                                     DV1.DURATION,
                                                     DV1.DURATION_DAYS) = p_period ) dv, br_tier_ex t
                   WHERE      t.br_id = dv.br_id
                         AND t.kv = dv.kv)
                group by type_id, rate,kv, br_id
                order by rate
				) bn;
     if (l_result = '{}' or l_result is null) then
        SELECT concatstr (intg_wb.form_object (
                  '',
                     intg_wb.form_rec ('minAmount', 0.00)
                             || ','
                             || intg_wb.form_rec ('value',
                                                  getbrat (gl.bd,
                                                           dv1.br_id,
                                                           dv1.kv,
                                                           0))))
          INTO l_result
          FROM dpt_vidd dv1
         WHERE     dv1.type_id = p_type_id
               AND dv1.kv = p_kv
               --AND dv1.flag = 1
               and (dv1.flag = 1 or g_prod_mode = 1)
               AND intg_wb.formatISO_8601 (0, DV1.DURATION, DV1.DURATION_DAYS) = p_period;
     end if;

       SELECT intg_wb.form_object_lvl (
              'interestRates',l_result)
      into l_result
      from dual;


    return l_result;
    end;

    function get_type_interestPayment(p_type_id int) return varchar2
    is
    l_result varchar2(32000);
    begin
      select intg_wb.form_object_lvl ('interestPayment', concatstr(str))
      into l_result
      from
       (SELECT DISTINCT
               CASE
                  WHEN freq = 1 THEN '"daily"'
                  WHEN freq = 3 THEN '"weekly"'
                  WHEN freq = 5 THEN '"monthly"'
                  WHEN freq = 7 THEN '"quarterly"'
                  WHEN freq = 180 THEN '"halfyearly"'
                  WHEN freq = 360 THEN '"yearly"'
                  WHEN freq = 400 THEN '"at_maturity"'
               END str
          FROM (SELECT dv1.kv, dv1.type_id, dv1.FREQ_K
                  FROM dpt_vidd dv1
                 WHERE dv1.type_id = p_type_id
                   --AND dv1.flag = 1
                   and (dv1.flag = 1 or g_prod_mode = 1)
                   ) dv,
               FREQ f
         WHERE dv.FREQ_K = f.freq);

     return l_result;
    end;

    function get_type_reinvestInterest(p_type_id int) return varchar2
    is
    l_result varchar2(32000) := '';
    l_count number;
    begin
     select count(distinct comproc)
       into l_count
       from dpt_vidd
      where type_id = p_type_id
        --and flag = 1
        and (flag = 1 or g_prod_mode = 1)
        ;

     if l_count = 1 then
     select intg_wb.form_rec ('reinvestInterest', str)
       into l_result
       from
       (SELECT case when min(COMPROC) = 0 then 'false' else 'true' end str
          FROM dpt_vidd dv1
         WHERE dv1.type_id = p_type_id
           --AND dv1.flag = 1
           and (dv1.flag = 1 or g_prod_mode = 1)
           );
     end if;
     return l_result;
    end;

    function get_vidd_reinvestInterest(p_vidd int) return varchar2
    is
    l_result varchar2(32000);
    l_count int;
    begin
        SELECT COUNT(*)
          INTO l_count
          FROM (SELECT DISTINCT comproc
                  FROM dpt_vidd
                 WHERE (type_id, kv, intg_wb.formatISO_8601 (0,DURATION,DURATION_DAYS)) in (
                SELECT dv1.type_id, dv1.kv, intg_wb.formatISO_8601 (0,dv1.DURATION,dv1.DURATION_DAYS)
                  FROM dpt_vidd dv1
                 WHERE dv1.vidd = p_vidd
                   --AND dv1.flag = 1
                   and (dv1.flag = 1 or g_prod_mode = 1)
                   )
                GROUP BY comproc);

        if l_count = 1 then
        select intg_wb.form_rec ('reinvestInterest', str)
          into l_result
           from
           (SELECT case when COMPROC = 0 then 'false' else 'true' end str
              FROM dpt_vidd dv1
             WHERE dv1.vidd = p_vidd
               --and dv1.flag = 1
               and (dv1.flag = 1 or g_prod_mode = 1)
               );
        else l_result := '';
        end if;

     return l_result;
    end;

    function get_type_descriptions(p_type_id int) return t_dpt_desc pipelined
    is
    l_dpt_desc r_dpt_desc;
    begin
     begin
       select *
         into l_dpt_desc
         from dpt_types_param
        where type_id = p_type_id;
     exception when no_data_found then
       select p_type_id, '', '', '', '', '', '', '', '', '', '', '', '', 0, 0
         into l_dpt_desc
         from dual;
     end;
     pipe row (l_dpt_desc);
    end;
    function get_type_topupAmount(p_type_id int) return varchar2
    is
    l_result varchar2(32000);
    begin
    with dtm as (select TYPE_ID, TOPUPAMOUNT_UK, TOPUPAMOUNT_EN, TOPUPAMOUNT_RU FROM TABLE(intg_wb.get_type_descriptions(p_type_id)))
    select intg_wb.form_object('topupAmount',
                intg_wb.form_object_lvl('currencies', concatstr(intg_wb.form_object('',str)))|| ','
                    || intg_wb.form_object('description', intg_wb.form_rec('',
                                                                            intg_wb.form_rec('uk',max(dtm.TOPUPAMOUNT_UK))||','||
                                                                            intg_wb.form_rec('en',max(dtm.TOPUPAMOUNT_EN))||','||
                                                                            intg_wb.form_rec('ru',max(dtm.TOPUPAMOUNT_RU))||','||
                                                                            intg_wb.form_rec('default',max(dtm.TOPUPAMOUNT_EN))
                                                                          )
                                          )
                              )
      into l_result
       from
       (SELECT intg_wb.form_rec ('code', t.lcv)
                ||','|| intg_wb.form_rec ('minAmount', nvl(min(dv1.limit),0))
                ||','|| intg_wb.form_rec ('maxAmount', nvl(min(dv1.MAX_LIMIT),1000000000)) str
          FROM dpt_vidd dv1, tabval t
         WHERE dv1.type_id = p_type_id
           and dv1.kv = t.kv
           --and dv1.flag = 1
           and (dv1.flag = 1 or g_prod_mode = 1)
         group by t.lcv), dtm;

     return l_result;
    end;

    function get_type_earlyClose(p_type_id int) return varchar2
    is
    l_result varchar2(32000);
    begin
    /* "earlyClose": {
          "description": {
            "ru": "По истечении 181 дня - 7% в рублях и 1,5% годовых в долларах",
            "default": "After 181 days - 7% in rubles and 1.5% in dollars"
          }*/
     with dtm as (select TYPE_ID, earlyClose_UK, earlyClose_EN, earlyClose_RU FROM TABLE(intg_wb.get_type_descriptions(p_type_id)))
        select intg_wb.form_object('earlyClose',
                intg_wb.form_object('description',
                   intg_wb.form_rec('', intg_wb.form_rec('uk',max(dtm.earlyClose_UK))||','||
                                        intg_wb.form_rec('en',max(dtm.earlyClose_EN))||','||
                                        intg_wb.form_rec('ru',max(dtm.earlyClose_RU))||','||
                                        intg_wb.form_rec('default',max(dtm.earlyClose_EN)))))
      into l_result
       from dtm;
      return l_result;
    end;


    function get_type_withdrawal(p_type_id int) return varchar2
    is
    l_result varchar2(32000);
    begin
     with dtm as (select TYPE_ID, withdrawal_UK, withdrawal_EN, withdrawal_RU FROM TABLE(intg_wb.get_type_descriptions(p_type_id)))
      select intg_wb.form_object('withdrawal',
                intg_wb.form_object('description',
                   intg_wb.form_rec('', intg_wb.form_rec('uk',max(dtm.withdrawal_UK))||','||
                                        intg_wb.form_rec('en',max(dtm.withdrawal_EN))||','||
                                        intg_wb.form_rec('ru',max(dtm.withdrawal_RU))||','||
                                        intg_wb.form_rec('default',max(dtm.withdrawal_EN)))))
      into l_result
       from dtm;
        return l_result;
    end;

    function get_type_autoProlAllowed(p_type_id int) return varchar2
    is
    l_result varchar2(32000);
    begin
      /*"withdrawal": {
          "description": {
            "ru": "Не более 30% от первоначальной суммы вклада",
            "default": "Not more than 30% of the initial deposit amount"} */

       SELECT intg_wb.form_rec ('autoProlongationAllowed', case when nvl(max(dv1.FL_DUBL),0) = 0 then 'false' else 'true' end )
          INTO l_result
          FROM dpt_vidd dv1
         WHERE dv1.type_id = p_type_id
           --and dv1.flag = 1
           and (dv1.flag = 1 or g_prod_mode = 1)
           ;

        return l_result;
    end;

    function get_type_highPriority(p_type_id int) return varchar2
    is
    l_result varchar2(32000);
    begin
    SELECT intg_wb.form_rec ('highPriority', case when nvl(dt.SORT_ORD,0) >= 2 then 'false' else 'true' end )
          INTO l_result
          FROM dpt_types dt
         WHERE dt.type_id = p_type_id;
        return l_result;
    end;
    function get_type_clientSegments(p_type_id int) return varchar2
    is
    l_result varchar2(32000);
    begin
      select intg_wb.form_object_lvl ('clientSegments', concatstr(intg_wb.form_rec('',str)))
      into l_result
          FROM((SELECT case when PENSIONER = 1 then '"PENSIONER"' else null end str
                  FROM dpt_types_param dt
                 WHERE dt.type_id = p_type_id)
                 union all
                 (SELECT case when EMPLOYEE = 1 then '"employee"' else null end str
                  FROM dpt_types_param dt
                 WHERE dt.type_id = p_type_id));
    /*  "clientSegments": [
          "pensioner",
          "employee"*/

        return l_result;
    end;


    function get_dpt_product(p_id in number) return t_dpttype pipelined
    is
    l_dpttype r_dpttype;
    l_result clob := null;
    l_sjson2 clob := null;
    l_sjson3 clob := null;
    l_sjson4 clob := null;
    l_sjson5 clob := null;
    l_sjson6 clob := null;
    l_sjson7 clob := null;
    l_sjson8 clob := null;
    l_sjson9 clob := null;
    l_sjson10 clob := null;
    l_branch branch.branch%type;
    begin
     if (sys_context('bars_context','user_mfo')  is null) then BARS_CONTEXT.SET_POLICY_GROUP('WHOLE'); end if;
     dbms_lob.createtemporary(l_result,FALSE);
                  SELECT dt.type_id,
                         intg_wb.form_object('',intg_wb.form_rec('id',dt.type_id)||','||
                            intg_wb.form_rec('status',case when dt.FL_ACTIVE = 1 and dt.FL_WEBBANKING = 1 then 'active' else 'inactive' end)||','||
                            intg_wb.form_object('name', (intg_wb.form_rec('uk', replace(dt.type_name,'"',''))||',' ||intg_wb.form_rec('default',replace(dt.type_name,'"','')))) ||',' ||
                            intg_wb.form_object('description',intg_wb.form_rec('uk',replace(dt.DESCRIPTION_UK,'"',''))||','||
                                                              intg_wb.form_rec('en',replace(dt.DESCRIPTION_EN,'"',''))||','||
                                                              intg_wb.form_rec('ru',replace(dt.DESCRIPTION_RU,'"',''))||','||
                                                              intg_wb.form_rec('default',replace(dt.type_name,'"',''))))sjson1,
                         intg_wb.get_type_currencies(dt.type_id) sjson2,
                         intg_wb.get_type_interestPayment(dt.type_id) sjson3,
                         case when intg_wb.get_type_reinvestInterest(dt.type_id) != ''
                         then intg_wb.get_type_reinvestInterest(dt.type_id) end sjson4,
                         intg_wb.get_type_topupAmount(dt.type_id) sjson5,
                         intg_wb.get_type_earlyClose(dt.type_id) sjson6,
                         intg_wb.get_type_withdrawal(dt.type_id) sjson7,
                         intg_wb.get_type_autoProlAllowed(dt.type_id) sjson8,
                         intg_wb.get_type_highPriority(dt.type_id) sjson9,
                         intg_wb.get_type_clientSegments(dt.type_id) sjson10
                    into l_dpttype.id, l_dpttype.sjson, l_sjson2, l_sjson3, l_sjson4, l_sjson5, l_sjson6, l_sjson7, l_sjson8, l_sjson9, l_sjson10
                    FROM (  SELECT dt1.type_id,
                                   dt1.type_name,
                                   dt1.type_code,
                                   dt1.FL_ACTIVE,
                                   dt1.FL_WEBBANKING,
                                   DTM.DESCRIPTION_UK,
                                   DTM.DESCRIPTION_EN,
                                   DTM.DESCRIPTION_RU
                              FROM dpt_types dt1, dpt_types_param dtm
                             WHERE (dt1.type_id = p_id OR p_id IS NULL) AND dt1.type_id = dtm.type_id(+)
                               AND dt1.fl_demand = 0) dt,
                             dpt_vidd dv
                   WHERE dt.type_code = dv.type_cod
                   --and dv.flag = 1
                   and (dv.flag = 1 or g_prod_mode = 1)
                   group by dt.type_id, dt.type_name, dt.type_code,dt.FL_ACTIVE, dt.FL_WEBBANKING, DT.DESCRIPTION_UK, DT.DESCRIPTION_EN, DT.DESCRIPTION_RU;
      --INTG_WB.ins_json(l_dpttype.id, l_dpttype.sjson, l_sjson2);
      l_dpttype.sjson := substr(l_dpttype.sjson, 1, length(l_dpttype.sjson)-1);
      dbms_lob.append(l_result, l_dpttype.sjson); dbms_lob.append(l_result, ',');
      dbms_lob.append(l_result, l_sjson2);        dbms_lob.append(l_result, ',');
      dbms_lob.append(l_result, l_sjson3);        dbms_lob.append(l_result, ',');
      if l_sjson4 is not null then
      dbms_lob.append(l_result, l_sjson4);        dbms_lob.append(l_result, ',');
      end if;
      dbms_lob.append(l_result, l_sjson5);        dbms_lob.append(l_result, ',');
      dbms_lob.append(l_result, l_sjson6);        dbms_lob.append(l_result, ',');
      dbms_lob.append(l_result, l_sjson7);        dbms_lob.append(l_result, ',');
      dbms_lob.append(l_result, l_sjson8);        dbms_lob.append(l_result, ',');
      dbms_lob.append(l_result, l_sjson9);        dbms_lob.append(l_result, ',');
      dbms_lob.append(l_result, l_sjson10);
      dbms_lob.append(l_result, '}');
      l_dpttype.sjson := l_result;
      pipe row (l_dpttype);
    end;

    function get_dpt_products return t_dpttype pipelined
    is
    l_dpttype r_dpttype;
    begin
     g_prod_mode := 2;
     for k in (select ss.* from dpt_types dt, table(intg_wb.get_dpt_product(dt.type_id)) ss where dt.FL_WEBBANKING =1 and FL_ACTIVE = 1)
     loop
      l_dpttype.id := k.id;
      l_dpttype.sjson :=k.sjson;
      pipe row (l_dpttype);
     end loop;
     g_prod_mode := 1;
    end;
    /*
    procedure ins_json(id in int, sjson1 in clob, sjson2 in clob)
    is
    pragma autonomous_transaction;
    begin
    insert into tmp_json(id, sjson1, sjson2) values (id, sjson1, sjson2);
    commit;
    end;*/

    function get_dpt_vidd(p_id in number, p_period in varchar2, p_lcv in varchar2, p_comproc in number, p_FREQ_K in varchar2) return t_dptvidd pipelined
    is
    l_dptvidd r_dptvidd;
    l_kv number;
    l_freq_k number;
    begin
     begin
      select kv
        into l_kv
        from tabval
       where lcv = p_lcv;
     exception when no_data_found then return;
     end;

     l_freq_k :=CASE
                  WHEN p_FREQ_K = 'DAILY"' then 1
                  WHEN p_FREQ_K = 'WEEKLY' then 3
                  WHEN p_FREQ_K = 'MONTHLY' then 5
                  WHEN p_FREQ_K = 'QUARTERLY'then 7
                  WHEN p_FREQ_K = 'HALFYEARLY' then 180
                  WHEN p_FREQ_K = 'YEARLY' then 360
                  WHEN p_FREQ_K = 'AT_MATURITY' then 400
                  ELSE 5-- По умолчанию ежемесячно
                END;

     begin
     select *
       into l_dptvidd
       from dpt_vidd
      where type_id = p_id
        and kv = l_kv
        and intg_wb.formatISO_8601 (0, DURATION, DURATION_DAYS) = p_period and rownum = 1
        --and FLAG = 1
        and (flag = 1 or g_prod_mode = 1)
        and comproc = p_comproc
        --and flag = 1
        and FREQ_K = l_freq_k;
      exception when no_data_found then return;
      end;

      pipe row (l_dptvidd);
    end;
    function get_loyality_rate(p_vidd dpt_vidd.vidd%type, p_kv tabval.kv%type) return number
	is
	l_result number := 0;
	begin
	 begin
	  select nvl(val,0)
	    into l_result
	    from dpt_bonus_settings
	   where dpt_vidd = p_vidd and bonus_id =3
	     and kv = p_kv;
	 exception when no_data_found then
	   begin
		   select nvl(val,0)
			into l_result
			from dpt_bonus_settings
		   where dpt_type = (select type_id
                         from dpt_vidd
                         where vidd = p_vidd
                         and (flag = 1 or g_prod_mode = 1)
                         --and flag = 1
                         )
			 and kv = p_kv and bonus_id = 3;
	   exception when no_data_found then l_result := 0;
	   end;
	   when too_many_rows then
	   begin
		   select nvl(val,0)
			into l_result
			from dpt_bonus_settings
		   where dpt_type = (select type_id
                         from dpt_vidd
                         where vidd = p_vidd
                         and (flag = 1 or g_prod_mode = 1)
                         --and flag = 1
                         )
		     and dpt_vidd = p_vidd
             and bonus_id = 3
			 and kv = p_kv;
	   exception when no_data_found then l_result := 0;
	   end;
	 end;

	return l_result;
	end;

   --
   -- Возвращает параметр из web_config
   --
   FUNCTION get_param_webconfig (par VARCHAR2)
      RETURN web_barsconfig.val%TYPE
   IS
      l_res   web_barsconfig.val%TYPE;
   BEGIN
      SELECT val
        INTO l_res
        FROM web_barsconfig
       WHERE key = par;
      RETURN TRIM (l_res);
   EXCEPTION WHEN NO_DATA_FOUND THEN raise_application_error (-20000, 'Не найден KEY=' || par || ' в таблице web_barsconfig!');
   END;
   FUNCTION EXTRACT (p_xml         IN XMLTYPE,
                     p_xpath       IN VARCHAR2,
                     p_mandatory   IN NUMBER)
      RETURN VARCHAR2
   IS
   BEGIN
      BEGIN
         RETURN p_xml.EXTRACT (p_xpath).getStringVal ();
      EXCEPTION WHEN OTHERS
         THEN
            IF p_mandatory IS NULL OR g_is_error
            THEN RETURN NULL;
            ELSE
               IF SQLCODE = -30625
               THEN bars_error.raise_nerror (g_errmod, 'XMLTAG_NOT_FOUND',p_xpath,g_cur_block_id,g_cur_rep_id);
               ELSE RAISE;
               END IF;
            END IF;
      END;
   END;

   procedure frx2ea(p_deposit_id in dpt_deposit.deposit_id%type, p_rnk in customer.rnk%type, p_flags in dpt_vidd_flags.id%type)
   is
      l_result     ead_docs.id%type;
      l_request    soap_rpc.t_request;
      l_response   soap_rpc.t_response;
      l_rnk        number;
      l_tmp        XMLTYPE;
      l_message    VARCHAR2 (4000);
      l_clob       CLOB;
      l_web_usermap_row web_usermap%rowtype;
      title        constant varchar2(14) := 'intg_wb.frx2ea';
      l_TECH_USER  varchar2(20) := 'TECH_W4';
      l_kf         varchar2(6);

   FUNCTION g_wsproxy_username RETURN string
   IS
      l_wsproxy_username   VARCHAR2 (100);
   BEGIN
      SELECT MIN (b.val)
        INTO l_wsproxy_username
        FROM web_barsconfig b
       WHERE b.key = 'ead.WSProxy.UserName';

      RETURN l_wsproxy_username;
   END g_wsproxy_username;

   FUNCTION g_wsproxy_password
      RETURN VARCHAR2
   IS
      l_wsproxy_password   VARCHAR2 (100);
   BEGIN
      SELECT MIN (b.val)
        INTO l_wsproxy_password
        FROM web_barsconfig b
       WHERE b.key = 'ead.WSProxy.Password';

      RETURN l_wsproxy_password;
   END g_wsproxy_password;

   BEGIN
     begin
         select kf
           into l_kf
           from mv_kf
          where rownum = 1;
           ikf(l_kf);
           l_TECH_USER := rukey(l_TECH_USER);
     exception when no_data_found then null;
     end;

     l_TECH_USER := g_wsproxy_username(); -- 25.06.2017

    bars_audit.info(title || 'started p_deposit_id=>' || to_char(p_deposit_id) ||', p_rnk=>' || to_char(p_rnk));
    if (p_rnk is null) then
       begin
         select rnk
           into l_rnk
           from dpt_deposit
          where deposit_id = p_deposit_id;
        exception when no_data_found then
         begin
          select rnk
            into l_rnk
            from dpt_deposit_clos
           where deposit_id = p_deposit_id
             and action_id = 0;
         exception when no_data_found then return;
         end;
        end;
    else l_rnk := p_rnk;
    end if;
      --подготовить реквест
      l_request :=
         soap_rpc.new_request (
            p_url           => get_param_webconfig('WB_EADDOC_URL'),
            p_namespace     => 'http://tempuri.org/',
            p_method        => 'MakeFRX_Blob',
            p_wallet_dir    => get_param_webconfig('WB_EADDOC_WALLETDIR'),
            p_wallet_pass   => get_param_webconfig('WB_EADDOC_WALLETPASS'));
       begin
            select *
            into   l_web_usermap_row
            from   web_usermap t
            where  t.webuser = lower(l_TECH_USER);
       exception
        when no_data_found then  raise_application_error(-20000, 'Користувач з ідентифікатором {' || to_char(l_TECH_USER) || '} не знайдений');

       end;

      --добавить параметры
      soap_rpc.ADD_PARAMETER (l_request, 'dpt_id', TO_CHAR (p_deposit_id));
      soap_rpc.ADD_PARAMETER (l_request, 'rnk', TO_CHAR (l_rnk));
      soap_rpc.ADD_PARAMETER (l_request, 'flags', TO_CHAR (p_flags));
      soap_rpc.ADD_PARAMETER (l_request, 'userName', l_TECH_USER);
--      soap_rpc.ADD_PARAMETER (l_request, 'password', coalesce(l_web_usermap_row.webpass, l_web_usermap_row.adminpass));
      soap_rpc.ADD_PARAMETER (l_request, 'password', g_wsproxy_password());
      bars_audit.info(title || ' l_request.body=>' ||l_request.body);
            
      --позвать метод веб-сервиса
      l_response := soap_rpc.invoke (l_request);
      
      bars_audit.info(title || ' l_response=>' ||l_clob);
    end;
    procedure makeblob(dpt_id in dpt_deposit.deposit_id%type, report in blob, flags in dpt_vidd_flags.id%type)
    is
    l_archdoc_id dpt_deposit.archdoc_id%type;
    l_kf         varchar2(6);
    begin 
      --костыль для представления надо норм механизм    
      select kf /*substr(branch,2,6)*/ into l_kf from dpt_deposit
          where deposit_id = dpt_id;          
          
      bc.go(l_kf);
      
         begin
         select archdoc_id
           into l_archdoc_id
           from dpt_deposit
          where deposit_id = dpt_id and wb='Y';
         exception when no_data_found then bars_audit.error('intg_wb:makeblob failed deposit is not web-online'); return;
         end;

         update ead_docs
            set scan_data = report, type_id='SCAN', ea_struct_id = case when flags =38 then 541 when flags = 39 then 543 when flags = 40 then 542 end,
            template_id = null,
            sign_date = sysdate,
            page_count = 1
          where id = l_archdoc_id
            and (ea_struct_id = case when flags =38 then 212 when flags in(39,40) then 213 end or ea_struct_id in (541,542,543))
            and agr_id = dpt_id;
      bc.home();
    end;
END INTG_WB;
/


Prompt Grants on PACKAGE INTG_WB TO BARS_ACCESS_DEFROLE to BARS_ACCESS_DEFROLE;
GRANT EXECUTE ON BARS.INTG_WB TO BARS_ACCESS_DEFROLE
/
