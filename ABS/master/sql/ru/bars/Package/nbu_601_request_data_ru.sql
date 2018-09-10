PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/PACKAGE/nbu_601_request_data_ru.sql =========*** Run *** 
PROMPT ===================================================================================== 

create or replace package nbu_601_request_data_ru is

    ----
    -- package nbu_601 - пакет процедур для наполнения данными витрин по проекту 601
    ----
    type t_601_kol is record
    (
         rnk         cc_deal.rnk%type,
         nd          cc_deal.nd%type,
         sales       number,             -- показник сукупного обсягу реалізації (sales);
         ebit        number,             -- показник фінансового результату від операційної діяльності (ebit);
         ebitda      number,             -- показник фінансового результату від звичайної діяльності до оподаткування фінансових витрат і нарахування амортизації (ebitda);
         totaldebt   number,             -- показник концентрації залучених коштів (total net debt).
         ismember    number,             -- зазначається приналежність боржника до групи юридичних осіб, що перебувають під спільним контролем (так/ні) – 1 знак: 1 – так; 2 – ні
         salesgr     number,             -- під спільним контролем(sales) – показник сукупного обсягу реалізації (sales);
         ebitgr      number,             -- під спільним контролем(ebit) – показник фінансового результату від операційної діяльності (ebit);
         ebitdagr    number,             -- під спільним контролем(ebitda) – показник фінансового результату від звичайної діяльності до оподаткування фінансових витрат і нарахування амортизації (ebitda);
         totaldebtgr number,             -- під спільним контролем(totaldebt)– показник концентрації залучених коштів (total net debt).
         classgr     number);            -- під спільним контролем  (classgr) – зазначається клас групи, визначений на підставі консолідованої/комбінованої фінансової звітності

    g_601 t_601_kol;

    --выполнять первым!!
    --наполнение  nbu_w4_bpk
    procedure  p_nbu_w4_bpk (kf_ in varchar2);

    --наполнение физ.лиц!!!
    --person_fo
    procedure p_nbu_person_fo (kf_ in varchar2);

    --document_fo
    procedure p_nbu_document_fo (kf_ in varchar2);

    --address_fo
    procedure p_nbu_address_fo (kf_ in varchar2);

    --наполнение юр.лиц!!!
    --person_uo
    procedure  p_nbu_person_uo (kf_ in varchar2);

    ---розмір фінансових показників діяльності боржника.
    procedure p_nbu_finperformance_uo (kf_ in varchar2);

    procedure p_nbu_groupur_uo(kf_ in varchar2);
    --розмір фінансових показників діяльності групи юридичних осіб, що знаходяться під спільним контролем
    procedure p_nbu_finperformancegr_uo (kf_ varchar2);

    ----p_nbu_finperformancepr_uo
    procedure p_nbu_finperformancepr_uo(kf_ in varchar2);

    -----ownerjur_uo власники істотної участі – юридичні особи
    procedure  p_nbu_ownerjur_uo (kf_ in varchar2);

    -----ownerpp_uo власники істотної участі – фізичні особи
    procedure  p_nbu_ownerpp_uo (kf_ in varchar2);

    --nbu_partners_uo
    procedure  p_nbu_partners_uo (kf_ in varchar2);

    --заполнение кредитов (бпк)
    procedure  p_nbu_credit_bpk (kf_ in varchar2);

    --заполнение кредитов + вызов процедуры наполнение бпк
    procedure  p_nbu_credit (kf_ in varchar2);

    ----nbu_credit_dep
    procedure  p_nbu_credit_pledge (kf_ in varchar2);

    ---nbu_credit_tranche
    procedure  p_nbu_credit_tranche (kf_ in varchar2);

    ----заполнение залогов
    procedure  p_nbu_pledge_dep  (kf_ in varchar2);
end;
/
create or replace package body nbu_601_request_data_ru is

    g_balance_accounts string_list := string_list('2010', '2018', '2020', '2027', '2028', '2029', '2030', '2037', '2038', '2039', '2060', '2062',
                                                  '2063', '2067', '2068', '2069', '2071', '2077', '2078', '2079', '2082', '2083', '2087', '2088',
                                                  '2089', '2102', '2103', '2107', '2108', '2109', '2112', '2113', '2117', '2118', '2119', '2122',
                                                  '2123', '2127', '2128', '2129', '2132', '2133', '2137', '2138', '2139', '2202', '2203', '2207',
                                                  '2208', '2209', '2211', '2217', '2218', '2219', '2220', '2227', '2228', '2229', '2232', '2233',
                                                  '2237', '2238', '2239', '2607', '2627', '2657', '3578', '3579', '9020', '9023', '9122', '9129');

    procedure fill_company_k110(
        p_okpo in varchar2,
        p_k110 out varchar2,
        p_ec_year out date)
    is
    begin
        select min(f.ved) keep (dense_rank last order by f.fdat) ,
               trunc(max(f.fdat) - 1, 'YEAR')
        into   p_k110, p_ec_year
        from   fin_fm f
        where  f.okpo = p_okpo and
               f.ved is not null ;
    end;

    ----------------------------
    function get_indicator(
        p_okpo in number,
        p_dat  in date,
        p_kod  in varchar2)
    return number
    is
        l_tmp number;
        fz_   varchar2(1) := fin_nbu.f_fm(p_okpo, p_dat);
        dat_  date := p_dat;
        okpo_ number := p_okpo;
    begin
        case (p_kod)
        when 'SALES' then
             if (fz_ = 'N') then
                 l_tmp := fin_nbu.zn_f2('2000', 4, dat_, okpo_) + fin_nbu.zn_f2('2010', 4, dat_, okpo_);
             else
                 l_tmp := fin_nbu.zn_f2('2000', 4, dat_, okpo_);
             end if;
        when 'EBIT' then
             if (fz_ = 'N') then
                 l_tmp := fin_nbu.zn_f2('2190', 4, dat_, okpo_) - fin_nbu.zn_f2('2195', 4, dat_, okpo_);
             else
                 l_tmp := fin_nbu.zn_f2('2000', 4, dat_, okpo_) - fin_nbu.zn_f2('2050', 4, dat_, okpo_);
             end if;
        when 'EBITDA' then
             if (fz_ = 'N') then
                 l_tmp := fin_nbu.zn_f2('2190', 4, dat_, okpo_) - fin_nbu.zn_f2('2195', 4, dat_, okpo_) +  fin_nbu.zn_f2('2515', 4, dat_, okpo_);
             else
                 l_tmp := null;
             end if;
        when 'TOTAL_NET_DEBT' then
             if (fz_ = 'N') then
                 l_tmp := fin_nbu.zn_f1('1510', 4, dat_, okpo_) + fin_nbu.zn_f1('1515', 4, dat_, okpo_) + fin_nbu.zn_f1('1600', 4, dat_, okpo_) + fin_nbu.zn_f1('1610', 4, dat_, okpo_) - fin_nbu.zn_f1('1165', 4, dat_, okpo_);
             else
                 l_tmp := fin_nbu.zn_f1('1595', 4, dat_, okpo_) + fin_nbu.zn_f1('1600', 4, dat_, okpo_) + fin_nbu.zn_f1('1610', 4, dat_, okpo_) - fin_nbu.zn_f1('1165', 4, dat_, okpo_);
             end if;
        else
            l_tmp := null;
        end case;

        return l_tmp;
    exception
        when no_data_found then
             return null;
    end;

    --------------------------------
    -- наполнение физ.лиц
    procedure p_nbu_person_fo (kf_ in varchar2)
    is
    begin
        bc.go (kf_);

        begin
            execute immediate 'alter table NBU_PERSON_FO truncate partition for (''' || kf_ || ''') reuse storage';
        end;

        for fiz in (select c.rnk,
                           (select w.value from customerw w where w.tag = 'SN_LN' and w.rnk = c.rnk) as lastname,
                           (select w.value from customerw w where w.tag = 'SN_FN' and w.rnk = c.rnk) as firstname,
                           (select w.value from customerw w where w.tag = 'SN_MN' and w.rnk = c.rnk) as middlename,
                           decode(c.codcagent, 5, 'true', 'false') codcagent,
                           c.okpo,
                           p.bday,
                           decode(c.codcagent, 6, c.country, null) countrycodnerez,
                           case when length(c.prinsider)=1 then  to_char(0||c.prinsider) else to_char(c.prinsider) end prinsider,
                           case when c.codcagent in (5,6) and c.okpo is not null then c.okpo
                                when c.codcagent=6 and (OKPO is null or OKPO like '%0000000%') then ('I'||p.SER||p.NUMDOC)
                                 end K020,
                           case when c.okpo is not null then 11
                                when c.okpo is null and c.codcagent in (5,6) then decode (p.passp, 1,14, 2,49, 3,49, 6,49, 4,49, 5,21, 11,15, 12,16, 13,32, 14,18, 99,49, 15,49, 16,49, 17,49, 7,12, 18,11)
                                when c.OKPO is null and p.passp is null and p.numdoc is null then 33
                             end codDocum

                    from   customer c
                    join   person p on p.rnk = c.rnk
                    where  c.sed <> 91 and
                           c.custtype = 3 and
                           c.rnk in (select a.rnk
                                     from   accounts a
                                     where  a.kf = kf_ and
                                            (a.nbs member of g_balance_accounts or (a.nbs in ('2600', '2620', '2625', '2650', '2655') and a.ostq < 0)) and
                                            a.acc in (select acc from nd_acc where kf = kf_
                                                      union
                                                      select acc from nbu_w4_bpk where kf = kf_))) loop

            insert into bars.nbu_person_fo
            values (fiz.rnk,                      -- rnk             number(38) not null,
                    fiz.lastname,                 -- lastname        varchar2(100),
                    fiz.firstname,                -- firstname       varchar2(100),
                    fiz.middlename,               -- middlename      varchar2(100),
                    fiz.codcagent,                -- isrez           varchar2(5),
                    fiz.okpo,                     -- inn             varchar2(20),
                    fiz.bday,                     -- birthday        date,
                    fiz.countrycodnerez,          -- countrycodnerez varchar2(3),
                    fiz.prinsider,                -- k060            varchar2(2),
                    null,                         -- status          varchar2(30),
                    null,
					          kf_,                          -- kf              varchar2(6) not null,
                    fiz.K020,                     --К020             VARCHAR2(20),
                    fiz.codDocum                  --codDocum         NUMBER(2)
                    );
        end loop;
        commit;
        bars_context.home();
    end;

    -------------------
    procedure p_nbu_document_fo (
        kf_ in varchar2)
    is
    begin
        bc.go (kf_);
        begin
            execute immediate 'alter table nbu_document_fo truncate partition for (''' || kf_ || ''') reuse storage';
        end;

        for doc in (select pf.rnk,
                           case when p.passp = 11 then 2
                                when p.passp = 7 then 3
                                when p.passp in (-1, 2, 3, 4, 5, 6, 12, 13, 14, 15, 16, 17, 18, 99) then 4
                           else p.passp
                           end passp,
                           p.ser, p.numdoc, p.pdate
                    from   nbu_person_fo pf,
                           person p
                    where  pf.rnk = p.rnk and pf.kf = kf_) loop
            begin
                insert into nbu_document_fo
                values (doc.rnk, doc.passp, doc.ser, doc.numdoc, doc.pdate, null,null,kf_);
            exception
                when dup_val_on_index then
                     null;
            end;
        end loop;

        commit;

        bars_context.home();
    end;

    -----------------------
    procedure p_nbu_address_fo(
        kf_ in varchar2)
    is
    begin
        bc.go (kf_);

        begin
            execute immediate 'alter table nbu_address_fo truncate partition for (''' || kf_ || ''') reuse storage';
        end;

        for address in (select pf.rnk, k.ko,ad.region, zip, locality, nvl(ad.street,cw.street) street, nvl(home,cw.buildnum) as home , homepart, room
                               from   bars.customer_address ad,bars.nbu_person_fo pf,bars.customer c
                                 left join bars.kodobl_reg k on k.c_reg=c.c_reg
                                       left join (select b.rnk, max(case when  tag='FGADR' then  regexp_substr(b.value,'[^,]+',1,1) else null end) as street,
                                                                 max(case when  tag='W4KKB' then  b.value else null end) as buildnum
                                                          from bars.customerw b where b.tag in ('FGADR','W4KKB')
                                                          group by rnk) cw on cw.rnk=c.rnk
                                                          where  ad.rnk = pf.rnk  and c.rnk=pf.rnk and ad.type_id=1) loop

            insert into nbu_address_fo
            values (address.rnk,
                    address.ko,
                    address.region,
                    address.zip,
                    address.locality,
                    address.street,
                    address.home,
                    address.homepart,
                    address.room,
                    null,
					          null,
                    kf_);
        end loop;

        commit;

        bars_context.home();
    end;

    -------------------------------------------
    procedure p_nbu_person_uo(
        kf_ in varchar2)
    is
        l_k110 varchar2(5 char);
        l_ec_year date;
        l_ved varchar2 (10);
        l_cus_year date;
    begin
        bc.go (kf_);

        execute immediate 'alter table nbu_person_uo truncate partition for (''' || kf_ || ''') reuse storage';

        for ur in (select distinct c.rnk,
                          c.nmk,
                          decode(c.codcagent,3,'true',5,'true','false') isrez,
                          c.okpo,
                          nvl(c.datea,c.date_on)as datea,
                          nvl(trim(c.rgadm),c.okpo)as rgadm,
                          c.country,
                          nvl((select 'true'
                               from   rez_cr r
                               where  r.rnk = c.rnk and
                                      r.kol24 = '100' and
                                      r.fdat = trunc(sysdate, 'mm') and
                                      rownum = 1), 'false') ismember,
                          --
                          coalesce((select 'true' from rez_cr r , cust_bun b,cust_rel cr
                                     where r.kol24 in ('[001]','[100]',001,100) and b.id_rel=cr.id and cr.id in (12,51)
                                     and r.rnk=c.rnk and b.rnka=c.rnk  and r.fdat = trunc(sysdate,'mm') and rownum = 1),
                                   (select 'false' from rez_cr r
                                     where r.kol24 in ('[001]','[100]',001,100)
                                     and r.rnk=c.rnk and r.fdat = trunc(sysdate,'mm') and rownum = 1),
                                   (select null from rez_cr cr where  cr.rnk=c.rnk and cr.fdat = trunc(sysdate,'mm') and (cr.kol24 in ('000','[000]') or cr.kol24 is null) and rownum = 1 )) isController,
                          ----
                          nvl((select 'true'
                               from   d8_cust_link_groups d8
                               where  d8.okpo = c.okpo and
                                      rownum = 1), 'false') as ispartner,
                          case when length(c.prinsider)=1 then  to_char(0||c.prinsider) else to_char(c.prinsider) end k060,
                          ---
                          case when (c.codcagent=3
                                    or (c.codcagent=5 and  c.sed=91 and c.ise in ('14200', '14100', '14201', '14101')))
                            then c.okpo
                               when (c.codcagent=4
                                 or (c.codcagent=6 and c.sed=91 and c.ise in ('14200', '14100', '14201', '14101')))
                                 and (c.okpo  is null or c.okpo like '%0000000%')  then ('I'||c.OKPO)
								                  when c.codcagent=4
                                 and (c.okpo  is not null)  then ('I'||c.OKPO)
                                 when c.codcagent=6 and c.sed=91 and c.ise='20008'
                                  then ('I'||c.OKPO)
                          end k020,
                          case when c.okpo is not null and
                          (c.codcagent in (3,4) or (c.codcagent in (5,6) and c.sed=91 and c.ise in ('14200', '14100', '14201', '14101')))
                           then decode (c.tgr, 1,51,2,51, 3,52, 9,99)
                               when c.okpo is null then 62
                          end codDocum

                   from   customer c
                   where  c.rnk in (select a.rnk
                                    from   accounts a
                                    where  a.kf = kf_ and
                                           (a.nbs member of g_balance_accounts or (a.nbs in ('2600', '2620', '2625', '2650', '2655') and a.ostq < 0)) and
                                           a.acc in (select n.acc from nd_acc n where n.kf = kf_
                                                     union
                                                     select b.acc from nbu_w4_bpk b where b.kf = kf_)) and
                           (c.custtype = 2 or (c.custtype = 3 and c.sed = 91))
                           and rnk<>137562103-- убрать!!
                           ) loop

           fill_company_k110(ur.okpo, l_k110, l_ec_year);


          if l_k110 is null then
            begin
              select distinct c.ved,cw.value into l_ved, l_cus_year
               from customer c,cc_deal d,customerw cw where c.okpo=ur.okpo and c.rnk=ur.rnk and ur.rnk=d.rnk and c.rnk=cw.rnk and cw.tag='IDDPR';
            exception
                when others then
                  bars.logger.info('nbu_person_uo='||l_ved||' ' ||l_k110||' '||ur.okpo||' '||ur.rnk);
            end;
             end if;


            insert into bars.nbu_person_uo
            values (ur.rnk,               -- rnk             number(38),
                    ur.nmk,               -- nameur          varchar2(254),
                    ur.isrez,             -- isrez           varchar2(5),
                    ur.okpo,              -- codedrpou       varchar2(20),
                    ur.datea,             -- registryday     date,
                    ur.rgadm,             -- numberregistry  varchar2(32),
                    nvl(l_k110,l_ved),    -- k110            varchar2(5),
                    nvl(l_ec_year,l_cus_year),  -- ec_year         date,
                    ur.country,           -- countrycodnerez varchar2(3),
                    ur.ismember,          -- ismember        varchar2(5),
                    ur.isController,      -- iscontroller    varchar2(5),
                    ur.ispartner,         -- ispartner       varchar2(5),
                    null,                 -- isaudit         varchar2(5),
                    ur.k060,              -- k060            varchar2(2),
                    null,                 -- status          varchar2(30),
                    null,
				            kf_,                  -- kf              varchar2(6),
                    ur.K020,              --К020             VARCHAR2(20),
                    ur.CODDOCUM           --CODDOCUM         NUMBER(2)
                    );
        end loop;

        commit;

        bars_context.home();
    end;

    --------------------
    procedure p_nbu_finperformance_uo(
        kf_ in varchar2)
    is
        l_sales number;
        l_ebit number;
        l_ebitda number;
        l_totaldebt number;
    begin
        bc.go (kf_);

        begin
            execute immediate 'alter table nbu_finperformance_uo truncate partition for (''' || kf_ || ''') reuse storage';
        end;

        for i in (select *
                  from   (select p.rnk,
                                 p.codedrpou,
                                 (select min(case when h.val_date = date '0001-01-01' then null else h.val_date end) keep (dense_rank last order by h.nd)
                                  from   fin_dat a
                                  join   fin_nd_hist h on h.fdat = a.fdat and
                                                          h.idf = 51 and
                                                          h.kod = 'ZVTP' and
                                                          h.nd = a.nd and
                                                          h.rnk = a.rnk
                                  where  a.rnk = p.rnk and
                                         a.fdat = trunc(sysdate, 'mm') and
                                         a.nd <> -1) z_dat
                          from   nbu_person_uo p
                          where  p.kf = kf_ and
                                 p.codedrpou is not null
                          group by p.rnk, p.codedrpou) z_dat
                  where z_dat is not null) loop
             begin
            l_sales:= nvl(get_indicator(i.codedrpou, i.z_dat, 'SALES'),0);
            exception when others  then
             if
               sqlcode=-20000 then bars.logger.info('finperformance_uo_sales- '||' '||i.codedrpou||' '||i.rnk||' '||i.z_dat);
             end if;
           end;
           begin
            l_ebit:= nvl(get_indicator(i.codedrpou, i.z_dat, 'EBIT'),0);
            exception  when others  then
             if
               sqlcode=-20000 then bars.logger.info('finperformance_uo_ebit- '||' '||i.codedrpou||' '||i.rnk||' '||i.z_dat);
             end if;
           end;
           begin
            l_ebitda:= nvl(get_indicator(i.codedrpou, i.z_dat, 'EBITDA'),0);
            exception  when others  then
             if
               sqlcode=-20000 then bars.logger.info('finperformance_uo_ebitda- '||' '||i.codedrpou||' '||i.rnk||' '||i.z_dat);
             end if;
           end;
           begin
            l_totaldebt:= nvl(get_indicator(i.codedrpou, i.z_dat, 'TOTAL_NET_DEBT'),0);
              exception  when others  then
              if
               sqlcode=-20000 then bars.logger.info('finperformance_uo_total_debt- '||' '||i.codedrpou||' '||i.rnk||' '||i.z_dat);
              end if;
            end;
         /* l_sales     := get_indicator(i.codedrpou, i.z_dat, 'SALES');
            l_ebit      := get_indicator(i.codedrpou, i.z_dat, 'EBIT');
            l_ebitda    := get_indicator(i.codedrpou, i.z_dat, 'EBITDA');
            l_totaldebt := get_indicator(i.codedrpou, i.z_dat, 'TOTAL_NET_DEBT');*/

            insert into bars.nbu_finperformance_uo
            values (i.rnk,                -- rnk       number(38),
                    l_sales,              -- sales     number(32),
                    l_ebit,               -- ebit      number(32),
                    l_ebitda,             -- ebitda    number(32),
                    l_totaldebt,          -- totaldebt number(32),
                    null,                 -- status    varchar2(30),
                    null,
					kf_);                 -- kf        varchar2(6)
        end loop;

        commit;
    end;
    --------------------------------
    procedure p_nbu_groupur_uo(kf_ in varchar2)
       is
       begin
       bc.go (kf_);

       begin
            execute immediate 'alter table nbu_groupur_uo truncate partition for (''' || kf_ || ''') reuse storage';
       end;

       for groupur  in (select distinct  p.rnk, decode(c.codcagent,3,'true','false') isRezGr,
                                 null as whois,c.okpo,nmk,country
                           from  customer c, nbu_person_uo p,cust_bun b
                           where c.rnk=p.rnk and p.iscontroller is not null and p.rnk=b.rnka
                           union
                           select distinct  p.rnk, decode (country,804,'true','false') isRezGr,
                               case when p.ismember='true' and r.rel_id=51 then 1 end whois,c.okpo,name,c.country
                           from  customer_extern c, nbu_person_uo p,customer_rel r
                           where p.rnk=r.rnk and r.rel_rnk=c.id and p.iscontroller is not null)loop
                          insert into nbu_groupur_uo (rnk,
                                                      whois,
                                                      isrezgr,
                                                      codedrpougr,
                                                      nameurgr,
                                                      countrycodgr,
                                                      status,
                                                      status_message,
                                                      kf)
                                       values (groupur.rnk,
                                               groupur.whois,
                                               groupur.isRezGr,
                                               groupur.okpo,
                                               groupur.nmk,
                                               groupur.country,
                                               null,
                                               null,
                                               kf_);
          end loop;
        commit;
    end;

    ---------------------------------
    procedure p_nbu_finperformancegr_uo(
       kf_ in varchar2)
    is
        l_salesgr     number;
        l_ebitgr      number;
        l_ebitdagr    number;
        l_totaldebtgr number;
        l_okpo_grp    varchar2(30 char);
        z_dat         date;
    begin
        bc.go (kf_);

        begin
            execute immediate 'alter table nbu_finperformancegr_uo truncate partition for (''' || kf_ || ''') reuse storage';
        end;


        for i in (select *
                  from   (select p.rnk, p.codedrpou,
                                 min(case when h.kod = 'NGRK' then h.s else null end) last_ngrk, -- is_member
                                 min(case when h.kod = 'GRKL' then h.s else null end) last_grkl, -- class
                                 min(case when h.kod = 'NUMG' then h.s else null end) last_numg  -- group_okpo
                          from   nbu_person_uo p
                          join   fin_dat a on a.rnk = p.rnk and
                                              a.fdat = trunc(sysdate, 'mm') and
                                              a.nd <> -1
                          left join fin_nd_hist h on h.fdat = a.fdat and
                                                     h.idf = 51 and
                                                     h.kod in ('NGRK', 'GRKL', 'NUMG') and
                                                     h.nd = a.nd and
                                                     h.rnk = a.rnk and
                                                     h.s is not null
                          where  p.kf = kf_ and
                                 p.codedrpou is not null
                          group by p.rnk, p.codedrpou)
                  where last_ngrk = 1 and last_numg is not null) loop

            begin
                select okpo
                into   l_okpo_grp
                from   fin_cust
                where  okpo like '_9' || lpad(i.last_numg, 10, '0') and
                       custtype = 5 and
                       rownum = 1;

                select max(fdat)
                into   z_dat
                from   fin_fm
                where  okpo = l_okpo_grp;


          begin
                l_salesgr:=  nvl(get_indicator(l_okpo_grp, z_dat, 'SALES'),0);
                exception when others  then
                  if
                   sqlcode=-20000 then bars.logger.info('finperformancegr_uo_sales- '||' '||i.codedrpou||' '||i.rnk||' '||z_dat);
                  end if;
           end;
           begin
                l_ebitgr:= nvl(get_indicator(l_okpo_grp, z_dat, 'EBIT'),0);
                exception when others  then
                  if
                   sqlcode=-20000 then bars.logger.info('finperformancegr_uo_ebit- '||' '||i.codedrpou||' '||i.rnk||' '||z_dat);
                  end if;
           end;
           begin
                l_ebitdagr:=nvl(get_indicator(l_okpo_grp, z_dat, 'EBITDA'),0);
                exception when others  then
                  if
                   sqlcode=-20000 then bars.logger.info('finperformancegr_uo_ebitda- '||' '||i.codedrpou||' '||i.rnk||' '||z_dat);
                  end if;
            end;
            begin
                l_totaldebtgr:=nvl(get_indicator(l_okpo_grp, z_dat, 'TOTAL_NET_DEBT'),0);
               exception when others  then
                  if
                   sqlcode=-20000 then bars.logger.info('finperformancegr_uo_total_debt- '||' '||i.codedrpou||' '||i.rnk||' '||z_dat);
                  end if;
            end;


                insert into nbu_finperformancegr_uo
                values (i.rnk,             -- rnk         number(38),
                        l_salesgr,         -- salesgr     number(32),
                        l_ebitgr,          -- ebitgr      number(32),
                        l_ebitdagr,        -- ebitdagr    number(32),
                        l_totaldebtgr,     -- totaldebtgr number(32),
                        i.last_grkl,       -- classgr     varchar2(3),
                        null,              -- status      varchar2(30),
                        null,
						kf_);              -- kf          varchar2(6)
            exception
                when no_data_found then
                     null;
            end;
        end loop;

        commit;
    end;

-----------------------------
----
procedure p_nbu_finperformancepr_uo( kf_ in varchar2)
    is
        l_salespr     number;
        l_ebitpr      number;
        l_ebitdapr    number;
        l_totaldebtpr number;
        l_okpo_pr    varchar2(30 char);
        z_dat         date;
    begin
        bc.go (kf_);

        begin
            execute immediate 'alter table nbu_finperformancepr_uo truncate partition for (''' || kf_ || ''') reuse storage';
        end;


        for i in (select *
                  from   (select p.rnk, p.codedrpou,
                                 min(case when h.kod = 'NGRK' then h.s else null end) last_nprk, -- is_member
                                 min(case when h.kod = 'GRKL' then h.s else null end) last_prkl, -- class
                                 min(case when h.kod = 'NUMG' then h.s else null end) last_numg  -- group_okpo
                          from   nbu_person_uo p
                          join   fin_dat a on a.rnk = p.rnk and
                                              a.fdat = trunc(sysdate, 'mm') and
                                              a.nd <> -1
                          left join fin_nd_hist h on h.fdat = a.fdat and
                                                     h.idf = 51 and
                                                     h.kod in ('NGRK', 'GRKL', 'NUMG') and
                                                     h.nd = a.nd and
                                                     h.rnk = a.rnk and
                                                     h.s is not null
                          where  p.kf = kf_ and
                                 p.codedrpou is not null and p.iscontroller is not null
                          group by p.rnk, p.codedrpou)
                  where last_nprk = 1 and last_numg is not null) loop

            begin
                select okpo
                into   l_okpo_pr
                from   fin_cust
                where  okpo like '_9' || lpad(i.last_numg, 10, '0') and
                       custtype = 5 and
                       rownum = 1;

                select max(fdat)
                into   z_dat
                from   fin_fm
                where  okpo = l_okpo_pr;

             begin
                l_salespr:=  nvl(get_indicator(l_okpo_pr, z_dat, 'SALES'),0);
                 exception when others  then
                  if
                   sqlcode=-20000 then bars.logger.info('finperformancepr_uo_sales- '||' '||i.codedrpou||' '||i.rnk||' '||z_dat);
                  end if;
             end;
              begin
                l_ebitpr := nvl(get_indicator(l_okpo_pr, z_dat, 'EBIT'),0);
                exception when others  then
                  if
                   sqlcode=-20000 then bars.logger.info('finperformancepr_uo_ebit- '||' '||i.codedrpou||' '||i.rnk||' '||z_dat);
                  end if;
             end;
             begin
                l_ebitdapr:=nvl(get_indicator(l_okpo_pr, z_dat, 'EBITDA'),0);
                exception when others  then
                  if
                   sqlcode=-20000 then bars.logger.info('finperformancepr_uo_ebitda- '||' '||i.codedrpou||' '||i.rnk||' '||z_dat);
                  end if;
             end;
             begin
                l_totaldebtpr :=nvl(get_indicator(l_okpo_pr, z_dat, 'TOTAL_NET_DEBT'),0);
                exception when others  then
                  if
                   sqlcode=-20000 then bars.logger.info('finperformancepr_uo_total_net_debt- '||' '||i.codedrpou||' '||i.rnk||' '||z_dat);
                  end if;
             end;

                insert into nbu_finperformancepr_uo (rnk,
                                                     sales,
                                                     ebit,
                                                     ebitda,
                                                     totaldebt,
                                                     status,
                                                     status_message,
                                                     kf)
                             values(i.rnk,
                                    l_salespr,
                                    l_ebitpr,
                                    l_ebitdapr,
                                    l_totaldebtpr,
                                    null,
                                    null,
                                    kf_);
            exception
                when no_data_found then
                     null;
            end;
        end loop;

        commit;
    end;

    -------------------------------------------
    -----ownerjur_uo
    procedure  p_nbu_ownerjur_uo (kf_ in varchar2)
      is
    begin
        bc.go (kf_);
        begin
        execute immediate 'alter table NBU_OWNERJUR_UO truncate partition for (''' || kf_ || ''') reuse storage';
        end;
        for n in (select b.rnka as rnk,b.rnkb,b.name,decode (b.country_u,804,'true','false') isrezoj,b.okpo_u,
          case when  c.datea is null then to_date('01.01.1990','dd.mm.yyyy') else c.datea end registrydayoj,
           case when c.rgadm is null then '0' else c.rgadm end numberregistryoj
             ,b.country_u,min(b.vaga1) as vaga1,' ' status
                  from cust_bun b
                  left join customer c on   b.rnka=c.rnk
                  where b.vaga1>10 and (b.edate>sysdate or b.edate is null) and b.custtype_u=1
                        and b.id_rel in (1,4)
                        group by b.rnka,b.rnkb,b.name,decode (b.country_u,804,'true','false'),b.okpo_u,c.datea,c.rgadm,b.country_u) -- юр
                  loop
                    begin
                  insert into bars.nbu_ownerjur_uo  ( rnk,rnkb,nameoj,isrezoj,codedrpouoj,registrydayoj,numberregistryoj,countrycodoj,percentoj,status,kf) values
                         (n.rnk,n.rnkb,n.name,n.isrezoj,n.okpo_u,n.registrydayoj,n.numberregistryoj,n.country_u,n.vaga1,n.status,kf_);
                         exception when dup_val_on_index then null;
                    end;
                  end loop;
     commit;
    bars_context.home();
    end;

    ----------------------------------------
    --ownerpp_uo
    procedure  p_nbu_ownerpp_uo (kf_ in varchar2)
      is
    begin
        bc.go (kf_);
         begin
        execute immediate 'alter table NBU_OWNERPP_UO truncate partition for (''' || kf_ || ''') reuse storage';
        end;
        for n in /*(select rnka as rnk,rnkb,name,decode (country_u,804,'true','false') isrezoj,okpo_u,country_u,min(vaga1) as vaga1 ,' ' status,
                         ad.zip,nvl(ad.street,cw.street) street, nvl(ad.home,cw.buildnum) as home,ad.room
                  from bars.customer_address ad, cust_bun c
                       left join (select b.rnk, max(case when  tag='FGADR' then  regexp_substr(b.value,'[^,]+',1,1) else null end) as street,
                                                                 max(case when  tag='W4KKB' then  b.value else null end) as buildnum
                                                          from bars.customerw b where b.tag in ('FGADR','W4KKB')
                                                          group by rnk) cw on cw.rnk=c.rnk
                  where c.rnka=ad.rnk and vaga1>10 and (edate>sysdate or edate is null) and custtype_u=2
                        and id_rel in (1,4)
                group by rnka,rnkb,name,decode (country_u,804,'true','false'),okpo_u,country_u)-- физ*/



                (select rnka as rnk,rnkb,name,decode (country_u,804,'true','false') isrezoj,okpo_u,country_u,min(vaga1) as vaga1 ,' ' status,
                         ad.zip,nvl(ad.street,cw.street) street, nvl(ad.home,cw.buildnum) as home,ad.room
                  from cust_bun c, bars.customer_address ad
                       left join (select b.rnk, max(case when  tag='FGADR' then  regexp_substr(b.value,'[^,]+',1,1) else null end) as street,
                                                                 max(case when  tag='W4KKB' then  b.value else null end) as buildnum
                                                          from bars.customerw b where b.tag in ('FGADR','W4KKB')
                                                          group by rnk) cw on cw.rnk=ad.rnk
                  where c.rnka=ad.rnk and vaga1>10 and (edate>sysdate or edate is null) and custtype_u=2 and ad.type_id=1
                        and id_rel in (1,4)
                group by rnka,rnkb,name,decode (country_u,804,'true','false'),okpo_u,country_u, ad.zip,nvl(ad.street,cw.street), nvl(ad.home,cw.buildnum),ad.room)

                  loop
                    begin
                  insert into bars.nbu_ownerpp_uo  ( rnk,rnkb,lastname,isrez,inn,countrycod,percent,status,kf,zip,streetaddress,houseno,flatno) values
                         (n.rnk,n.rnkb,n.name,n.isrezoj,n.okpo_u,n.country_u,n.vaga1,n.status,kf_,n.zip,n.street,n.home,n.room);
                         exception when dup_val_on_index then null;
                     end;
                   end loop;
      commit;
    bars_context.home();
    end;

    procedure p_nbu_partners_uo(
        kf_ in varchar2)
    is
    begin
        bc.go(kf_);

        execute immediate 'alter table nbu_partners_uo truncate partition for (''' || kf_ || ''') reuse storage';

        for search_rnk in (select c.rnk
                           from   customer c,
                                  d8_cust_link_groups d8
                           where  c.rnk not in (select rnk from bars.nbu_partners_uo) and
                                  c.okpo = d8.okpo) loop
            for okpo_cust in (select c1.okpo from customer c1 where c1.rnk = search_rnk.rnk) loop
                for d8_link_group in (select link_group from d8_cust_link_groups where okpo = okpo_cust.okpo) loop
                    for okpo_d8 in (select okpo from d8_cust_link_groups where link_group = d8_link_group.link_group) loop

                        insert into nbu_partners_uo (rnk, codedrpoupr, kf)
                        values (search_rnk.rnk, okpo_d8.okpo, kf_);

                        for cust_data in (select c.rnk,
                                                 case when  c.codcagent = 3 then 'true'
                                                      when  c.codcagent = 5 then 'true'
                                                      else 'false'
                                                 end codcagent,
                                                 c.nmk,
                                                 c.country
                                          from   customer c
                                          where  c.okpo = okpo_d8.okpo) loop

                            update nbu_partners_uo cd
                            set    cd.isrezpr = cust_data.codcagent,
                                   cd.nameurpr = cust_data.nmk,
                                   cd.countrycodpr = cust_data.country
                            where  codedrpoupr = okpo_d8.okpo and
                                   cd.kf = kf_;
                        end loop;
                    end loop;
                end loop;
            end loop;
        end loop;
        commit;
    end;


    --заполнение кредитов (бпк)
    procedure p_nbu_credit_bpk(
        kf_ in varchar2)
    is
    begin
        bc.go (kf_);
        for person in (select rnk_client.rnk,bpk.nd,'' as ordernum,(select decode( c.custtype,3,'true',2,'false')  from customer c where c.rnk=rnk_client.rnk) as flagosoba,
                              case when bpk.nbs=2202  then '01'
                                   when bpk.nbs=2203  then '02'
                                   when bpk.nbs  in ('2625', '2605',9129) then '08'      
                               end typecredit,
                               'cc_deal' as table_name,
                               (select nkd from specparam where acc=bpk.acc_pk) as numberdog,
                               case
                                  when bpk.sdate is not null then bpk.sdate
                                    else (select a.daos  from accounts  a where a.acc=bpk.acc_pk)
                                      end dogday,
                                case
                                   when bpk.wdate is not null then bpk.wdate
                                    else (select a.mdate  from accounts  a where a.acc=bpk.acc_pk)
                                      end endday,
                               sumzagal1.sum_zagal as sumzagal,
                               bpk.kv as r030,
                               proc.proccredit,
                               sum_lim.sumpay as sumpay,
                               nvl((select decode(dt.txt, '5', 1, '7', 2, '180', 3, '120', 4, '360', 4, '400', 5, '40', 6) as freq
                                from   nd_txt dt
                                where  bpk.nd = dt.nd and
                                       dt.kf = kf_ and
                                       dt.tag = 'FREQ'),1) as periodbase,
                               nvl((select decode(dt.txt, '5', 1, '7', 2, '180', 3, '120', 4, '360', 4, '400', 5, '40', 6) as freq
                                from   nd_txt dt
                                where  bpk.nd = dt.nd and
                                       dt.kf = kf_ and
                                       dt.tag = 'FREQP'),1) as periodproc,
                               sumarrears.sum_ost as sumarrears,
                               sp.sp_sum  as arrearbase ,
                               spn.spn_sum as arrearproc,
                               nbu23_rez.daybase,
                               nbu23_rez.daybase as dayproc,
                               bpk.dat_close as factendday,
                               '' as flagz,
                               nbu23_rez.fin as klass,
                               nbu23_rez.cr as risk
                       from (select rnk,kf from nbu_person_fo
                             union
                             select rnk,kf from nbu_person_uo) rnk_client,
                             nbu_w4_bpk bpk

                      --загальна сума (ліміт кредитної лінії)
					             /*left join
                          (select a.acc ,a.kv , lim as sum_zagal   from accounts a) sumzagal
                                        on sumzagal.acc=bpk.acc_pk and
                                        sumzagal.kv=bpk.kv*/
                       left join
                          (select a.acc, min(a.dos) keep (dense_rank first order by a.fdat) as sum_zagal
                                  from saldoa a, accounts a1
                                  where a.acc=a1.acc and a1.nbs=9129
                                  group by  a.acc ) sumzagal1 on sumzagal1.acc=bpk.acc
					             -- sp
                       left join (select nd, kv, sum(sp) sp_sum
                                  from   (select distinct bpk.nd, bpk.kv, bpk.acc,
                                                 ost_korr(bpk.acc, add_months(trunc(sysdate, 'mm'), -1), null, null) sp
                                          from  nbu_w4_bpk bpk
                                          where  bpk.tip='SP ')
                                  group by nd, kv) sp on bpk.nd = sp.nd and
                                                         bpk.kv = sp.kv
                       -- spn
                       left join (select nd, kv, sum(spn) spn_sum
                                  from   (select distinct bpk.nd, bpk.kv, bpk.acc,
                                                 ost_korr(bpk.acc, add_months(trunc(sysdate, 'mm'), -1), null, null) spn
                                          from   nbu_w4_bpk bpk
                                          where  bpk.tip = 'SPN')
                                  group by nd, kv) spn on bpk.nd = spn.nd and
                                                          bpk.kv=spn.kv
                       --залишок заборгованості за кредитною операцією
                       left join (select nd, kv, sum(sum_ost) as sum_ost
                                  from   (select bpk.nd, bpk.kv, (ag.ost + ag.crkos - ag.crdos) sum_ost
                                          from   agg_monbals ag,
                                                 nbu_w4_bpk bpk
                                          where
                                          ag.fdat = add_months(trunc(sysdate, 'mm'), -1) and
                                          --ag.fdat = trunc(sysdate, 'mm') and
                                                 bpk.tip in ('SS ', 'SP ', 'SN ', 'SPN', 'SNO', 'SNA','CR9') and
                                                 bpk.acc = ag.acc)
                                  group by nd, kv) sumarrears on bpk.nd = sumarrears.nd and bpk.kv = sumarrears.kv
                       left join (select nd, decode(max(kol_351), null, 0, max(kol_351)) daybase,
                                         max(fin) fin,
                                         sum(cr) * 100 as cr
                                  from   nbu23_rez
                                  where  fdat = trunc(sysdate, 'mm')
                                  group by nd) nbu23_rez on nbu23_rez.nd = bpk.nd
                       left join (select t.acc, max(t.ir) keep (dense_rank last order by bdat) as proccredit
                                  from   int_ratn t
                                  where  t.id = 0 and bdat < trunc(sysdate, 'mm')
                                  group by t.acc) proc on proc.acc = bpk.acc_pk
                                                -- and bpk.nbs in ('2625', '2202', '2203', '2605', '2062', '2063','9129') --номінальна процентна ставка

                       --sumpay
                       left join(select nd ,sum(sumo+sumk) as sumpay
                                       from cc_lim
                                       where fdat between  add_months(trunc(sysdate,'mm'),-1) and add_months(trunc(sysdate,'mm'),11) and sumo>0
                                       group by nd) sum_lim on sum_lim.nd=bpk.nd
                       --

                       where rnk_client.rnk = bpk.rnk and rnk_client.kf = kf_
					   and bpk.nbs in (2625,2202,2203,2605,9129,3578) and  sumzagal1.sum_zagal+0 is not null and sumzagal1.sum_zagal+0 is not null  )

          loop
            begin
           insert into nbu_credit ( rnk,nd,ordernum,flagosoba,typecredit,numdog,dogday,endday,sumzagal,r030,proccredit,sumpay,periodbase ,periodproc, sumarrears, arrearbase,arrearproc,
                                    daybase,dayproc,factendday,flagz,klass,risk ,status,kf)
                                  values
                              (person.rnk,person.nd,person.ordernum,person.flagosoba,person.typecredit,person.numberdog,person.dogday,person.endday,person.sumzagal,person.r030,
                               person.proccredit,person.sumpay,person.periodbase,person.periodproc,person.sumarrears,person.arrearbase,person.arrearproc,
                               person.daybase,person.dayproc,person.factendday,person.flagz,person.klass,person.risk,'',kf_);
             exception when dup_val_on_index then null;
             end;
        end loop;
      commit;
    end;

     --заполнение кредитов + вызов процедуры наполнение бпк
    procedure  p_nbu_credit (kf_ in varchar2)
      is
      l_in_sp  number;
      l_in_spn  number;
      begin
       bc.go (kf_);
       begin
        execute immediate 'alter table NBU_CREDIT truncate partition for (''' || kf_ || ''') reuse storage';
        end;
       begin
       p_nbu_w4_bpk (kf_); -- наполненик данным по бпк
       commit;
       p_nbu_credit_bpk (kf_);-- инсерт в nbu_credit с nbu_w4_bpk
       commit;
        end;

    for person in (select distinct d.rnk,
                                     d.nd,
                                     '' as ordernum,
                                     (select decode(custtype,3,'true',2,'false') as custtype
                                      from   cc_vidd t
                                      where  d.vidd=t.vidd) as flagosoba,
                                     case when (d.prod like '2062%' or  d.prod like '2202%') and ad.aim=62 and d.vidd in(1,11)  then '01'
                                          when  (d.prod like '2063%' or  d.prod like '2203%') and ad.aim in (62,40) and d.vidd in(1,11)  then '02'
                                          when   d.prod like '204%' and ad.aim=62  then '02'
                                          when   d.prod like '204%' and ad.aim=77  then '03'
                                          when  (d.prod like '207%' or  d.prod like '221%') then '03'
                                          when   d.prod like '203%' then '04'
                                          when  (d.prod like '202%' or  d.prod like '222%') then '05'
                                          when  (d.prod like '2082%' or  d.prod like '2232%') then '06'
                                          when  (d.prod like '2083%' or  d.prod like '2233%') then '07'
                                          when  d.vidd in(10,110)  then '08'
                                          when  d.prod like '220%' and ad.aim=0  then '07'
                                          when  d.prod like '239%' and ad.aim=62  then '09'
                                          when  d.prod like '204%' and ad.aim=0  then '09'
                                          when  d.prod like '211%' and ad.aim=100  then '09'
                                          when  d.prod like '210%' and ad.aim=210 and d.vidd in (1,2)  then '09'
                                          when  d.prod like '210%' and ad.aim=210 and d.vidd=2  then '09'
                                          when  d.prod like '206%'  and d.vidd=1 and d.ndg is not null then '09'
                                          when  (d.prod like '206%' or  d.prod like '220%')  and d.vidd in(2,3,12,13)  then '09'
                                          when  (d.prod like '9020%' or d.prod like '9000%') and ad.aim=98 then '10'
                                          when  (d.prod like '9023%' or d.prod like '9003%') and ad.aim=97 then '12'
                                          when  d.prod like '9122%' and ad.aim=99 then '13'
                                     end typecredit,
                                     'cc_deal' as table_name,
                    case when d.cc_id like '%\%' then replace (d.cc_id,'\','\\')||'--'||d.nd else d.cc_id||'--'||d.nd end
                                     as numberdog,
                                     --d.cc_id||'--'||d.nd as numberdog,
                                      case
                                        when  d.sdate is not null then d.sdate
                                          else (select a.daos from accounts a where a.acc=ad.accs)
                                            end dogday,
                                       case
                                        when  d.wdate is not null then d.wdate
                                          else (select a.mdate from accounts a where a.acc=ad.accs)
                                            end endday,
                                     sumzagal.sum_zagal as sumzagal,
                                     ltrim(ad.kv) as r030,
                                     ltrim(nvl(proc.proccredit,proc1.proccredit)) as proccredit,
                                     sum_lim.sumpay as sumpay,
                                     /*(select ltrim(decode(dt.txt,5,1,7,2,180,3,120,4,360,4,400,5,40,6,2,6))  as freq from nd_txt dt where d.nd=dt.nd  and dt.kf=kf_ and dt.tag='FREQ' and regexp_like(dt.txt, '^\d{1,}$')) as periodbase,*/
                                     (select ltrim(decode(dt.txt,5,1,7,2,180,3,120,4,360,4,400,5,40,6,2,6,30,1))  as freq from nd_txt dt where d.nd=dt.nd  and dt.kf=kf_ and dt.tag='FREQ') as periodbase,
                                     nvl((select ltrim(decode(dt.txt,5,1,7,2,180,3,120,4,360,4,400,5,40,6,2,6,30,1))  as freq from nd_txt dt where d.nd=dt.nd  and dt.kf=kf_ and dt.tag='FREQP')
                                        ,(select ltrim(decode(dt.txt,5,1,7,2,180,3,120,4,360,4,400,5,40,6,2,6,30,1))  as freq from nd_txt dt where d.nd=dt.nd  and dt.kf=kf_ and dt.tag='FREQ')) as periodproc,
                                     --sumarrears.sum_ost as sumarrears,
                                     (abs(sumarrears.sum_ost)+abs(nvl(sumacommission.sum_ostcom,0))) as sumarrears,
                                     ltrim(nbu23_rez.daybase) as daybase,
                                     ltrim(nbu23_rez.daybase) as dayproc,
                                     a.dazs as factendday,
                                     case when d.vidd in (337,103,101,11,13,12) then
                                                                 (select case when w.value is not null then  value
                                                                     else 'false'
                                                                     end
                                                                     from accountsw w
                                                                     where w.tag='DATEOFKK' and w.acc=a.acc)
                                          when  d.vidd in (3,26 ,237 ,102,17,2,1) then (select t.txt from nd_txt t where tag='NOSHOP' and t.nd=d.nd)
                                       end flagz,
                                     ltrim(nbu23_rez.fin) as klass,
                                     nbu23_rez.cr as risk,
                                    case when  (d.prod like '2082%' or  d.prod like '2232%') then 'true'
                                         when  (d.prod like '2083%' or  d.prod like '2233%') then 'true'
                                           end flagInsurance
                     from (select rnk,kf from nbu_person_fo
                           union
                           select rnk,kf from nbu_person_uo) rnk_client ,
                           cc_deal d,
                           cc_add ad

                     left join --загальна сума (ліміт кредитної лінії)
                          /*(select cd.nd ,ca.kv, (cd.limit*100) as  sum_zagal
                            from cc_deal cd, cc_add ca where ca.nd=cd.nd  ) sumzagal on ad.nd = sumzagal.nd and ad.kv = sumzagal.kv*/

                            (select distinct cd.nd ,ca.kv, --((cd.sdog*100)+nvl(b.amount_com,0)) as  sum_zagal
                                              (cd.sdog*100) as  sum_zagal     
                                             from cc_add ca,cc_deal cd
                                             /*left join (select a.nd,sum(a.amount_com) as amount_com from(
                                                            select distinct ad.nd,na.acc,ad.kv,a.kv,
                                                               case  when ad.kv<>a.kv then (select (abs(s.ostc)*(c.rate_o)) as amount_com from accounts s where s.acc=a.acc and s.kv=a.kv and s.kv=c.kv and c.vdate=trunc(sysdate,'dd'))
                                                               else abs(a.ostc) end amount_com
                                                            from accounts a, cur_rates c,nd_acc na,cc_add ad where ad.nd=na.nd and na.acc=a.acc and a.kv=c.kv and  nbs in (3578,3579))a
                                                            group by a.nd) b on b.nd=cd.nd*/
                                                       where ca.nd=cd.nd)sumzagal on ad.nd = sumzagal.nd and ad.kv = sumzagal.kv


                    left join--залишок заборгованості за кредитною операцією
                           (select nd ,kv, sum (sum_ost) as sum_ost
                            from (select n.nd, a2.kv,(ag.ost + ag.crkos - ag.crdos) sum_ost
                                  from   agg_monbals ag,
                                         nd_acc n,
                                         accounts a2
                                  where ag.fdat = add_months(trunc(sysdate,'mm'),-1) and
                                        a2.tip in ('SS ','SP ', 'SN ','SPN','SNO','CR9','SRR'/*,'SK0'*/) and
                                        n.acc = a2.acc and
                                        n.acc = ag.acc)
                            group by nd, kv) sumarrears on ad.nd = sumarrears.nd and ad.kv = sumarrears.kv
                    left join--комисия
                           (select nd, sum (sum_ost) as sum_ostcom
                            from (select n.nd, a2.kv,(ag.ost + ag.crkos - ag.crdos) sum_ost
                                  from   agg_monbals ag,
                                         nd_acc n,
                                         accounts a2
                                  where ag.fdat = add_months(trunc(sysdate,'mm'),-1) and
                                        a2.nbs ='3578' and
                                        n.acc = a2.acc and
                                        n.acc = ag.acc)
                            group by nd) sumacommission on ad.nd = sumacommission.nd
                    left join
                          (select nd,
                                  decode(max(kol_351), null, 0, max(kol_351)) daybase,
                                  max(fin) fin,
                                  sum(cr)*100 as cr
                           from   nbu23_rez
                           where  fdat = trunc(sysdate,'mm')
                           group by nd) nbu23_rez on nbu23_rez.nd = ad.nd

                    --sumpay
                    /*left join(select nd ,sum(sumo+sumk) as sumpay
                                       from cc_lim
                                       where fdat between  add_months(trunc(sysdate,'mm'),-1) and add_months(trunc(sysdate,'mm'),11) and sumo>0
                                       group by nd) sum_lim on sum_lim.nd=ad.nd*/
                    left join(select a.nd ,sum(sumo+sumk) as sumpay
                                       from cc_lim_arc a, cc_deal c
                                       where fdat between  add_months(trunc(sysdate,'mm'),-1) and add_months(trunc(sysdate,'mm'),11) and sumo>0
                                       and a.nd=c.nd 
                                       and mdat = (select max(mdat) from cc_lim_arc aa where aa.nd=c.nd) 
                                       group by a.nd) sum_lim on sum_lim.nd=ad.nd                          
                    --номінальна процентна ставка
                    left join (select t.acc, max(t.ir) keep(dense_rank last order by bdat) as proccredit
                           from int_ratn t,
                                accounts t2,
                                nd_acc t4
                           where  t.id = 0 and t4.acc = t2.acc and t2.tip in('SS','SP','XS')and t.acc=t4.acc  and bdat< trunc(sysdate,'mm')
                           group by t.acc) proc on proc.acc = ad.accs
                    ----------------------
                    left join (select d.nd,t.acc, max(t.ir) keep(dense_rank last order by bdat) as proccredit
                           from int_ratn t,
                                accounts t2,
                                nd_acc t4,
                                cc_deal d
                           where  t.id = 0 and t4.acc = t2.acc and t2.tip in('LIM')and t.acc=t4.acc  and bdat< trunc(sysdate,'mm')
                                  and d.nd=t4.nd
                                  and d.ndg is not null
                           group by d.nd,t.acc) proc1 on proc1.nd = ad.nd,
                          nd_acc n,
                          nd_txt nt,
                          accounts a
                     where rnk_client.rnk = d.rnk and
                           rnk_client.kf = d.kf and
                           ad.nd = d.nd and
                           d.nd = n.nd and
                           a.acc = n.acc and
                           n.kf = a.kf and
                           a.tip = 'LIM' and
                           a.nls like '8999%' and
                           (a.dazs is null or a.dazs >= add_months(trunc(sysdate, 'mm'), -1))
                           --and
                           --proc.acc = ad.accs
                           and d.nd=nt.nd
                           and nt.tag <>'PR_TR'-- убираем транши
                           )

          loop
            begin
           insert into nbu_credit ( rnk,nd,ordernum,flagosoba,typecredit,numdog,dogday,endday,sumzagal,r030
                       ,proccredit,sumpay,arrearbase,periodbase ,periodproc, sumarrears,
                                    daybase,dayproc,factendday,flagz,klass,risk,flagInsurance,status,kf)
                                  values
                              (person.rnk,person.nd,person.ordernum,person.flagosoba,person.typecredit,person.numberdog,person.dogday,person.endday,person.sumzagal,person.r030,
                               person.proccredit,person.sumpay,'',person.periodbase,person.periodproc,person.sumarrears,person.daybase,person.dayproc,person.factendday,person.flagz
                               ,person.klass,person.risk,person.flagInsurance,'',kf_);
                               exception when others then
                               if sqlcode=-1438 then
                                 dbms_output.put_line(person.rnk||':'||person.nd);
                                  end if;
                                --end;

                                -- dup_val_on_index then null;
             end;

           ----- проверка на наличия sp
           begin
             select count(*) into l_in_sp from accounts ca,nd_acc n where n.nd=person.nd  and ca.kv=person.r030 and n.acc=ca.acc and ca.tip='SP ';
           end;
           ----- проверка на наличия spn
            begin
             select count(*) into l_in_spn from accounts ca,nd_acc n where n.nd=person.nd  and ca.kv=person.r030 and n.acc=ca.acc and ca.tip='SPN';
            end;
           ----подсчет сумы sp
           if l_in_sp>=1 then
             begin
              for sp in (select nd,kv, sum (sp) sp_sum  from (
                                        select distinct n.nd,a2.kv,a2.acc,ost_korr(a2.acc,dat_next_u(trunc(sysdate,'mm'),-1),null,null) sp
                                        from  nd_acc n,  accounts a2
                                        where  person.nd=n.nd and a2.kv=person.r030 and n.acc = a2.acc and a2.tip='SP')
                                       group by nd,kv)
                   loop
                    update  nbu_credit set arrearbase=sp.sp_sum where nd=person.nd and  r030=sp.kv;
                   end loop;
                   end;
                   end if;

             ----подсчет сумы spn
             if l_in_spn>=1 then
                   begin
                   for spn in (select nd,kv,sum  (spn) spn_sum  from (
                                          select distinct n.nd,a2.kv,a2.acc,ost_korr(a2.acc,dat_next_u(trunc(sysdate,'mm'),-1),null,null) spn
                                          from  nd_acc n,  accounts a2
                                          where  person.nd=n.nd and a2.kv=person.r030 and n.acc = a2.acc and a2.tip='SPN')
                                          group by nd,kv)
                   loop
                     update  nbu_credit set arrearproc=spn.spn_sum where nd=person.nd and  r030=spn.kv;
                   end loop;
                   end;
              end if;
        end loop;
     commit;
     -- bars_context.home();
       end;


    ----nbu_credit_dep
    procedure  p_nbu_credit_pledge (kf_ in varchar2)
    is
       begin
         bc.go (kf_) ;
        begin
        execute immediate 'alter table NBU_CREDIT_PLEDGE truncate partition for (''' || kf_ || ''') reuse storage';
        end;
    for cre_dep in (select d.rnk,d.nd,p.acc,sumpledge.sumpledges,pricepledge.sumpricepledge from  cc_deal d,
                    (select  nd,sum (sall) sumpledges from
                    (select a.nd,a.accz,sum (a.sall) sall from tmp_rez_obesp23 a where trunc(dat,'mm')= trunc(sysdate,'mm')  group by a.nd,a.accz)
                        group by nd ) sumpledge,
                    (select nd,sum (sall) sumpricepledge from
                    (select a.nd,a.accz,sum (a.sall) sall from tmp_rez_obesp23 a where trunc(dat,'mm')= trunc(sysdate,'mm')  group by a.nd,a.accz)
                  group by nd) pricepledge, nd_acc na ,pawn_acc p
      where d.nd=sumpledge.nd and  d.nd=pricepledge.nd and d.nd=na.nd and na.acc=p.acc)
      loop
        begin
      insert into nbu_credit_pledge (rnk,nd,acc_ple,sumpledge,pricepledge,status,kf) values
                             (cre_dep.rnk,cre_dep.nd,cre_dep.acc,cre_dep.sumpledges,cre_dep.sumpricepledge,'',kf_);
                             exception when dup_val_on_index then null;
                             end;

      end loop;
      commit;
     bars_context.home();
    end;


    --заполнение залогов
  procedure  p_nbu_pledge_dep (kf_ in varchar2)
    is
    begin
    bc.go(kf_);
        begin
        execute immediate 'alter table NBU_PLEDGE_DEP truncate partition for (''' || kf_ || ''') reuse storage';
        end;
     for n in (select distinct ac.rnk,ac.acc,'' as ordernum,nvl(case when p.cc_idz like '%\%' then replace (p.cc_idz,'\','\\')else p.cc_idz end,'б\\н') as numberpledge,
                 case when p.sdatz  is not null then p.sdatz
                      when p.sdatz is null then c1.creditdate end as pledgeday,
                (select s031  from cc_pawn cp where cp.pawn=p.pawn) as s031 , ac.kv as r030,
                fost(ac.acc,dat_next_u(trunc(sysdate,'mm'),-1))  as sumppladge,p.sv as  pricepledge, '' as lastpledgeday ,'' as codrealty,'' as ziprealty
                       ,'' as squarerealty,'' as real6income,'' as noreal6income,'' as flaginsurancepledge , dep.nd as numdogdp, dep.date_begin as dogdaydp, dep.kv as r030dp , limit as  sumdp, '' as status ,
                       case when (select s031  from cc_pawn cp where cp.pawn=p.pawn)=34 then  fost(ac.acc,dat_next_u(trunc(sysdate,'mm'),-1))  end sumBail,
                       case when (select s031  from cc_pawn cp where cp.pawn=p.pawn) in (11 , 12,  13, 14, 16, 20, 23, 31, 60, 61, 62, 63, 64, 65) then
                             fost(ac.acc,dat_next_u(trunc(sysdate,'mm'),-1))end sumGuarantee
                   from accounts ac
                                   left join (select rnk,max(c.dogday) creditdate from nbu_credit c
                                         group by rnk) c1 on c1.rnk=ac.rnk ,
                                 pawn_acc p
                                    left join( select nd,d.acc,a.kv as kv ,dat_begin as date_begin , sum as limit , dpu_id as  deposit_id from dpu_deal d ,  accounts a
                                          where a.acc=d.acc
                                          union
                                          select nd,acc,kv,dat_begin as date_begin, limit,deposit_id from dpt_deposit) dep on dep.deposit_id=p.deposit_id
                      where ac.acc=p.acc)
                      loop
    insert into  nbu_pledge_dep(rnk,acc,ordernum,numberpledge,pledgeday,s031,r030,sumpledge,pricepledge,lastpledgeday,codrealty,ziprealty,squarerealty, real6income,
                                 noreal6income,flaginsurancepledge,numdogdp,dogdaydp,r030dp,sumdp,status,kf,sumBail,sumGuarantee) values
                                 (n.rnk,n.acc,n.ordernum, n.numberpledge,n.pledgeday,n.s031,n.r030,n.sumppladge,n.pricepledge,n.lastpledgeday ,n.codrealty,
                                 n.ziprealty,n.squarerealty,n.real6income,n.noreal6income,n.flaginsurancepledge,n.numdogdp,n.dogdaydp,n.r030dp,n.sumdp,n.status,kf_,
                                 n.sumBail,n.sumGuarantee) ;
                      end loop;
            commit;
        bars_context.home();
    end;

--заполнение траншей
  procedure  p_nbu_credit_tranche (kf_ in varchar2)
    is
    l_in_sp number;
    l_in_spn number;
    begin
    bc.go(kf_);
        begin
        execute immediate 'alter table NBU_CREDIT_TRANCHE truncate partition for (''' || kf_ || ''') reuse storage';
        end;
        for tranche in (select distinct person.rnk,d.nd, --to_char(tr.npp)||'--'||d.nd as numDogTr,
                               case when to_char(tr.npp) like '%\%' then to_char(replace(tr.npp,'\','\\')||'--'||d.nd) else to_char(tr.npp||'--'||d.nd) end
                                     as numDogTr,
                                tr.fdat as dogDayTr, tr.sv as sumZagalTr ,tr.dapp as endDayTr, a.kv as r030Tr,proc.proccredit,
                               (select ltrim(decode(dt.txt,5,1,7,2,180,3,120,4,360,4,400,5,40,6,2,6,30,1))  as freq from nd_txt dt where d.nd=dt.nd  and dt.kf=kf_ and dt.tag='FREQ' ) as periodbasetr,
                               nvl((select ltrim(decode(dt.txt,5,1,7,2,180,3,120,4,360,4,400,5,40,6,2,6,30,1))  as freq from nd_txt dt where d.nd=dt.nd  and dt.kf=kf_ and dt.tag='FREQP')
                                ,(select ltrim(decode(dt.txt,5,1,7,2,180,3,120,4,360,4,400,5,40,6,2,6,30,1))  as freq from nd_txt dt where d.nd=dt.nd  and dt.kf=kf_ and dt.tag='FREQ')) as periodproctr,
                               --(select decode(dt.txt,5,1,7,2,180,3,120,4,360,4,400,5,40,6)  as freq from nd_txt dt where d.nd=dt.nd  and dt.kf=kf_ and dt.tag='FREQP' and regexp_like(dt.txt, '^\d{1,}$')) as periodproctr,
                                 sumarrears.sum_ost as  sumArrearsTr,
                                 nbu23_rez.daybase as  dayBaseTr,
                                 nbu23_rez.daybase as dayProcTr,
                                 tr.d_fakt as factEndDayTr,
                                 nbu23_rez.fin as klasstr,
                                 nbu23_rez.cr as risktr,
                                 person.kf
                              from (select rnk,kf from nbu_person_fo
                              union
                              select rnk, kf from  nbu_person_uo) person,
                              (select t.acc, max(t.ir) keep(dense_rank last order by bdat) as proccredit
                                                 from int_ratn t,
                                                 accounts t2,
                                                 nd_acc t4
                                                 where  t.id = 0 and t4.acc = t2.acc and t2.tip = 'SS 'and t.acc=t4.acc  and bdat< trunc(sysdate,'mm')
                                                 group by t.acc) proc --номінальна процентна ставка
                                 ,cc_deal d
                --klass
                left join
                          (select nd,
                                  decode(max(kol_351), null, 0, max(kol_351)) daybase,
                                  max(fin) fin,
                                  sum(cr)*100 as cr
                           from   nbu23_rez
                           where  fdat = trunc(sysdate,'mm')
                           group by nd) nbu23_rez on nbu23_rez.nd = d.nd

                              ,nd_acc na, cc_trans tr,accounts a, nd_txt nt, cc_add ad

                --Залишок заборгованості за траншем
                left join (select nd ,kv, sum (sum_ost) as sum_ost
                            from (select n.nd, a2.kv,(ag.ost + ag.crkos - ag.crdos) sum_ost
                                  from   agg_monbals ag,
                                         nd_acc n,
                                         accounts a2
                                  where ag.fdat = add_months(trunc(sysdate,'mm'),-1) and
                                        a2.tip in ('SS','SP') and
                                        n.acc = a2.acc and
                                        n.acc = ag.acc)
                            group by nd, kv) sumarrears on ad.nd = sumarrears.nd and ad.kv = sumarrears.kv

                   where person.rnk=d.rnk and person.kf=d.kf and d.nd=na.nd  and d.nd=ad.nd  and proc.acc = ad.accs
                         and na.acc=a.acc and na.acc=tr.acc and nt.nd=d.nd and nt.tag ='PR_TR' and nt.txt=1 and tr.fdat>=add_months(trunc(sysdate,'mm'),-1) and tr.fdat<trunc(sysdate,'mm')
            ----добавлено мультивалютные кредиты!!! COBUMMFO-7982
            union
            select distinct person.rnk, d.nd, d.cc_id as numDogTr,
                                        case
                                        when  d.sdate is not null then d.sdate
                                          else (select a.daos from accounts a where a.acc=ad.accs)
                                        end  dogDayTr,
                                        sumzagal.sum_zagal as sumZagalTr,
                                        case
                                        when  d.wdate is not null then d.wdate
                                          else (select a.mdate from accounts a where a.acc=ad.accs)
                                        end endDayTr,
                                        a.kv as r030Tr,
                                        proc.proccredit,
                               (select  ltrim(decode(dt.txt,5,1,7,2,180,3,120,4,360,4,400,5,40,6,2,6,30,1))  as freq from nd_txt dt where d.nd=dt.nd  and dt.kf=kf_ and dt.tag='FREQ' ) as periodbasetr,
                                nvl((select ltrim(decode(dt.txt,5,1,7,2,180,3,120,4,360,4,400,5,40,6,2,6,30,1))  as freq from nd_txt dt where d.nd=dt.nd  and dt.kf=kf_ and dt.tag='FREQP')
                                    ,(select ltrim(decode(dt.txt,5,1,7,2,180,3,120,4,360,4,400,5,40,6,2,6,30,1))  as freq from nd_txt dt where d.nd=dt.nd  and dt.kf=kf_ and dt.tag='FREQ')) as periodproctr,
                               --(select decode(dt.txt,5,1,7,2,180,3,120,4,360,4,400,5,40,6)  as freq from nd_txt dt where d.nd=dt.nd  and dt.kf=kf_ and dt.tag='FREQP' and regexp_like(dt.txt, '^\d{1,}$')) as periodproctr,
                                sumarrears.sum_ost as  sumArrearsTr,
                                 nbu23_rez.daybase as  dayBaseTr,
                                 nbu23_rez.daybase as dayProcTr,
                                 a.dazs as factEndDayTr,
                                 nbu23_rez.fin as klasstr,
                                 nbu23_rez.cr as risktr,
                                 person.kf
                              from (select rnk,kf from nbu_person_fo
                              union
                              select rnk, kf from  nbu_person_uo) person,
                              (select t.acc, max(t.ir) keep(dense_rank last order by bdat) as proccredit
                                                 from int_ratn t,
                                                 accounts t2,
                                                 nd_acc t4
                                                 where  t.id = 0 and t4.acc = t2.acc and t2.tip = 'SS 'and t.acc=t4.acc  and bdat< trunc(sysdate,'mm')
                                                 group by t.acc) proc --номінальна процентна ставка
                                 ,cc_deal d
               --klass
                left join
                          (select nd,
                                  decode(max(kol_351), null, 0, max(kol_351)) daybase,
                                  max(fin) fin,
                                  sum(cr)*100 as cr
                           from   nbu23_rez
                           where  fdat = trunc(sysdate,'mm')
                           group by nd) nbu23_rez on nbu23_rez.nd = d.nd

                              ,nd_acc na, cc_trans tr,accounts a,  cc_add ad


                left join --загальна сума (ліміт кредитної лінії)
                         /* (select cd.nd ,ca.kv, (cd.limit*100) as  sum_zagal
                            from cc_deal cd, cc_add ca where ca.nd=cd.nd  ) sumzagal on ad.nd = sumzagal.nd and ad.kv = sumzagal.kv  */

                            (select distinct cd.nd ,ca.kv, --((cd.sdog*100)+nvl(b.amount_com,0)) as  sum_zagal
                                             (cd.sdog*100) as sum_zagal
                                             from cc_add ca,cc_deal cd
                                             /*left join (select a.nd,sum(a.amount_com) as amount_com from(
                                                            select distinct ad.nd,na.acc,ad.kv,a.kv,
                                                               case  when ad.kv<>a.kv then (select (abs(s.ostc)*(c.rate_o)) as amount_com from accounts s where s.acc=a.acc and s.kv=a.kv and s.kv=c.kv and c.vdate=trunc(sysdate,'dd'))
                                                               else abs(a.ostc) end amount_com
                                                            from accounts a, cur_rates c,nd_acc na,cc_add ad where ad.nd=na.nd and na.acc=a.acc and a.kv=c.kv and  nbs in (3578,3579))a
                                                            group by a.nd) b on b.nd=cd.nd*/
                                                       where ca.nd=cd.nd) sumzagal on ad.nd = sumzagal.nd and ad.kv = sumzagal.kv


                --Залишок заборгованості за траншем
                left join (select nd ,kv, sum (sum_ost) as sum_ost
                            from (select n.nd, a2.kv,(ag.ost + ag.crkos - ag.crdos) sum_ost
                                  from   agg_monbals ag,
                                         nd_acc n,
                                         accounts a2
                                  where ag.fdat = add_months(trunc(sysdate,'mm'),-1) and
                                        a2.tip in ('SS','SP','SRR') and
                                        n.acc = a2.acc and
                                        n.acc = ag.acc)
                            group by nd, kv) sumarrears on ad.nd = sumarrears.nd and ad.kv = sumarrears.kv

                   where person.rnk=d.rnk and person.kf=d.kf and d.nd=na.nd  and d.nd=ad.nd  and proc.acc = ad.accs
                         and na.acc=a.acc and na.acc=tr.acc and d.ndg in (select ndg from cc_deal d where d.vidd in(2,3)  and d.ndg is not null) and
                          (a.dazs is null or a.dazs >= add_months(trunc(sysdate, 'mm'), -1))
                 )
              loop
                       insert into nbu_credit_tranche(rnk,
                                                      nd,
                                                      numdogtr,
                                                      dogdaytr,
                                                      enddaytr,
                                                      sumzagaltr,
                                                      r030tr,
                                                      proccredittr,
                                                      periodbasetr,
                                                      periodproctr,
                                                      sumarrearstr,
                                                      daybasetr,
                                                      dayproctr,
                                                      factenddaytr,
                                                      klasstr,
                                                      risktr,
                                                      kf)
                                     values   (tranche.rnk,
                                               tranche.nd,
                                               tranche.numdogtr,
                                               tranche.dogdaytr,
                                               tranche.enddaytr,
                                               tranche.sumzagaltr,
                                               tranche.r030tr,
                                               '',
                                               tranche.periodbasetr,
                                               tranche.periodproctr,
                                               tranche.sumarrearstr,
                                               tranche.daybasetr,
                                               tranche.dayproctr,
                                               tranche.factenddaytr,
                                               tranche.klasstr,
                                               tranche.risktr,
                                               tranche.kf);



           ----- проверка на наличия sp
           begin
             select count(*) into l_in_sp from accounts ca,nd_acc n where n.nd=tranche.nd  and ca.kv=tranche.r030Tr and n.acc=ca.acc and ca.tip='SP ';
           end;
           ----- проверка на наличия spn
            begin
             select count(*) into l_in_spn from accounts ca,nd_acc n where n.nd=tranche.nd  and ca.kv=tranche.r030Tr and n.acc=ca.acc and ca.tip='SPN';
            end;
           ----подсчет сумы sp
           if l_in_sp>=1 then
             begin
              for sp in (select nd,kv, sum (sp) sp_sum  from (
                                        select distinct n.nd,a2.kv,a2.acc,ost_korr(a2.acc,dat_next_u(trunc(sysdate,'mm'),-1),null,null) sp
                                        from  nd_acc n,  accounts a2
                                        where  tranche.nd=n.nd and a2.kv=tranche.r030Tr and n.acc = a2.acc and a2.tip='SP')
                                       group by nd,kv)
                   loop
                    update  nbu_credit_tranche set arrearbasetr=sp.sp_sum where nd=tranche.nd and  r030Tr=sp.kv;
                   end loop;
                   end;
                   end if;

             ----подсчет сумы spn
             if l_in_spn>=1 then
                   begin
                   for spn in (select nd,kv,sum  (spn) spn_sum  from (
                                          select distinct n.nd,a2.kv,a2.acc,ost_korr(a2.acc,dat_next_u(trunc(sysdate,'mm'),-1),null,null) spn
                                          from  nd_acc n,  accounts a2
                                          where  tranche.nd=n.nd and a2.kv=tranche.r030Tr and n.acc = a2.acc and a2.tip='SPN')
                                          group by nd,kv)
                   loop
                     update  nbu_credit_tranche set arrearproctr=spn.spn_sum where nd=tranche.nd and  r030Tr=spn.kv;
                   end loop;
                   end;
              end if;
        end loop;
     commit;

end;



 --------------------
    procedure p_nbu_w4_bpk(
        kf_ in varchar2)
    is
        p_dat01 date := trunc(sysdate, 'mm');
        l_dat31 date;
    begin
        bc.go(kf_);
        l_dat31 := dat_last_work(p_dat01 - 1);  -- последний рабочий день месяца

        -- pul_dat(to_char(p_dat01,'dd-mm-yyyy'),'');

        execute immediate 'alter table nbu_w4_bpk truncate partition for (''' || kf_ || ''') reuse storage';

        for k in (select w.* from w4_acc w
                  where  w.dat_close is null or
                         w.dat_close >= add_months(trunc(sysdate, 'mm'), -1)) loop

            for s in (select a.acc, a.rnk, a.nbs, a.nls, a.kv, a.ob22, ost_korr(a.acc, p_dat01, null, a.nbs) as ost_korr,
                             k.dat_close,
                             decode (acc, k.acc_pk, 'SP ', k.acc_ovr, 'SS ', k.acc_9129, 'CR9', k.acc_2208, 'SN ',
                                          k.acc_2627, 'SP ', k.acc_3579, 'SK9', k.acc_2207, 'SP ', k.acc_2209, 'SPN',
                                          k.acc_2625x, 'SP ', k.acc_2627x, 'SP ', k.acc_2625d, 'SP ', k.acc_2203, 'SS ') tip
                      from   accounts a
                      where  a.acc in (k.acc_pk, k.acc_ovr, k.acc_9129, k.acc_2208, k.acc_2207, k.acc_2627,
                                       k.acc_3579, k.acc_2209, k.acc_2625x, k.acc_2627x, k.acc_2625d, k.acc_2203) and a.nbs not in ('3550', '3551') and
                             ost_korr(a.acc, l_dat31, to_char(trunc(l_dat31, 'MM'), 'J' ) - 2447892, a.nbs) < 0) loop

                insert into nbu_w4_bpk (nd, kv, nls, nbs, ob22, acc, tip, tip_kart, fin23, rnk, sdate, wdate, acc_pk, kf, sum_zagal, dat_close)
                values (k.nd, s.kv, s.nls, s.nbs, s.ob22, s.acc, s.tip, 42, k.fin23, s.rnk, k.dat_begin, k.dat_end, k.acc_pk, kf_, s.ost_korr, k.dat_close);
            end loop;
        end loop;

        for k in (select w.* from bpk_acc w
                  where  w.dat_close is null or
                         w.dat_close >= add_months(trunc(sysdate, 'mm'), -1)) loop
            for s in (select a.acc, a.rnk, a.nbs, a.nls, a.kv, a.ob22, ost_korr(a.acc, p_dat01, null, a.nbs) as ost_korr, k.dat_close,
                             decode (acc, k.acc_pk, 'SP ', k.acc_ovr, 'SS ', k.acc_9129, 'CR9', k.acc_2208, 'SN ',
                                          k.acc_2207, 'SP ', k.acc_3579, 'SK9', k.acc_2209, 'SPN') tip
                      from   accounts a
                      where  a.acc in (k.acc_pk, k.acc_ovr, k.acc_9129, k.acc_2208, k.acc_2207, k.acc_3579, k.acc_2209) and a.nbs not in ('3550', '3551') and
                             ost_korr(a.acc, l_dat31, to_char(trunc(l_dat31, 'MM'), 'J' ) - 2447892, a.nbs) < 0) loop

                insert into nbu_w4_bpk (nd, kv, nls, nbs, ob22, acc, tip, tip_kart, fin23, rnk, sdate, wdate, acc_pk, kf, sum_zagal, dat_close)
                values (k.nd, s.kv, s.nls, s.nbs, s.ob22, s.acc, s.tip, 41, k.fin23, s.rnk, null, k.dat_end, k.acc_pk, kf_, s.ost_korr, s.dat_close);
            end loop;
        end loop;

        commit;
    end;
/*
    ---------------------------
    function indicator_601(
        p_rnk number,
        p_nd  number,
        p_dat date)
    return t_601_kol
    is
        l_601 t_601_kol;
        l_okpo customer.okpo%type;
        z_dat date; -- дата звітності яка береться до разрахунку 351
        l_okpo_grp number;
    begin
        l_601.rnk :=  p_rnk;
        l_601.nd  :=  p_nd;

        l_okpo := customer_utl.get_customer_okpo(p_rnk);

        z_dat :=  fin_nbu.zn_p_nd_date_hist('ZVTP', 51, p_dat, p_nd, p_rnk);

        l_601.sales     := get_indicator(l_okpo, z_dat, 'SALES');
        l_601.ebit      := get_indicator(l_okpo, z_dat, 'EBIT');
        l_601.ebitda    := get_indicator(l_okpo, z_dat, 'EBITDA');
        l_601.totaldebt := get_indicator(l_okpo, z_dat, 'TOTAL_NET_DEBT');

        l_601.ismember  := fin_nbu.zn_p_nd_hist('NGRK', 51, p_dat, p_nd, p_rnk);
        l_601.classgr   := fin_nbu.zn_p_nd_hist('GRKL', 51, p_dat, p_nd, p_rnk);

        if (l_601.ismember = 1) then
            begin
                select okpo
                into   l_okpo_grp
                from   fin_cust
                where  okpo like '_' || lpad(lpad(fin_nbu.zn_p_nd_hist('NUMG', 51, p_dat, p_nd, p_rnk), 10, '0'), 11, '9') and
                       custtype = 5 and
                       rownum = 1;

                select max(fdat)
                into   z_dat
                from   fin_fm
                where  okpo = l_okpo_grp;

                -- dbms_output.put_line('OkpoGrp='||l_okpo_grp||' ZdatGrp='||to_char(z_dat));

                l_601.salesgr     :=  get_indicator(l_okpo_grp, z_dat, 'SALES');
                l_601.ebitgr      :=  get_indicator(l_okpo_grp, z_dat, 'EBIT');
                l_601.ebitdagr    :=  get_indicator(l_okpo_grp, z_dat, 'EBITDA');
                l_601.totaldebtgr :=  get_indicator(l_okpo_grp, z_dat, 'TOTAL_NET_DEBT');
            exception
                when no_data_found then
                     null;
            end;
        end if;

        return l_601;
    exception
         when others then
              return null;
    end;
*/
end;
/
grant execute on nbu_601_request_data_ru to barstrans;
grant execute on nbu_601_request_data_ru to bars_access_defrole;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/PACKAGE/nbu_601_request_data_ru.sql =========*** End *** 
PROMPT ===================================================================================== 

