
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/cim_reports.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
CREATE OR REPLACE PACKAGE CIM_REPORTS
is
   --
   --  CIM_REPORTS
   --  Currency Inspection Module - Модуль валютного контролю
   --

-- g_header_version    constant varchar2 (64) := 'version 1.00.01 17/07/2015';
--   g_header_version    constant varchar2 (64) := 'version 1.00.02 16/11/2015';
   g_header_version    constant varchar2 (64) := 'version 1.01.00 25/06/2018';

   g_awk_header_defs   constant varchar2 (512) := '';


   --------------------------------------------------------------------------------
   -- Типи
   --
   type t_val is record (
     rrrrw                varchar2(5),
     val                  number
   );
   type t_arr_val is table of t_val;

   type t_indicators_f503 is record (
     contr_id             number,
     p2010                number,
     p2011                number,
     p2012                number,
     p2013                number,
     p2014                number,
     p2016                number,
     p2017                number,
     p2018                number,
     p2020                number,
     p2021                number,
     p2022                number,
     p2023                number,
     p2024                number,
     p2025                number,
     p2026                number,
     p2027                number,
     p2028                number,
     p2029                number,
     p2030                number,
     p2031                number,
     p2032                number,
     p2033                number,
     p2034                number,
     p2035                number,
     p2036                number,
     p2037                number,
     p2038                number,
     p2042                number
   );
   
    type t_indicators_f504 is record (
     contr_id             number,
     p090                 number,
     p212                 t_arr_val,

     p213                 t_arr_val,
     p201                 t_arr_val,
     p222                 t_arr_val,
     p223                 t_arr_val,
     p292                 t_arr_val,
     p293                 t_arr_val
   );


    type t_contracts is record ( 
      contr_id                cim_contracts.contr_id%type, 
      contr_type              cim_contracts.contr_type%type, 
      contr_type_name         cim_contract_types.contr_type_name%type, 
      num                     cim_contracts.num%type,  
      subnum                  cim_contracts.subnum%type, 
      rnk                     cim_contracts.rnk%type, 
      okpo                    customer.okpo%type, 
      nmk                     customer.nmk%type, 
      nmkk                    customer.nmkk%type, 
      custtype                customer.custtype%type, 
      nd                      customer.nd%type,
      status_id               cim_contracts.status_id%type, 
      status_name             cim_contract_statuses.status_name%type,
      comments                cim_contracts.comments%type,       
      branch_own              cim_contracts.branch%type,           
      branch_own_name         branch.name%type,
      kv                      cim_contracts.kv%type,           
      s                       cim_contracts.s%type,           
      open_date               cim_contracts.open_date%type,           
      close_date              cim_contracts.close_date%type,           
      owner_uid               cim_contracts.owner_uid%type,           
      owner_fio               staff$base.fio%type,
      benef_id                cim_contracts.benef_id%type,           
      benef_name              cim_beneficiaries.benef_name%type,
      benef_adr               cim_beneficiaries.benef_adr%type,
      country_id              cim_beneficiaries.country_id%type,
      country_name            country.name%type,
      deadline                cim_contracts_trade.deadline%type,
      branch_service          cim_contracts.service_branch%type,           
      branch_service_name     branch.name%type
                               );
    type t_arr_contracts is table of t_contracts;                           
   --------------------------------------------------------------------------------
   -- Константи
   --
   --------------------------------------------------------------------------------
   -- Глобальні константи
   --

   --------------------------------------------------------------------------------
   -- Глобальні змінні
   --

   --------------------------------------------------------------------------------
   -- header_version - повертає версію заголовка пакету
   --
   function header_version return varchar2;

   --------------------------------------------------------------------------------
   -- body_version - повертає версію тіла пакету
   --
   function body_version return varchar2;

function p_f503(p_date in date :=bankdate, p_contr_id in number :=null, p_error out varchar2) return clob;

function p_f504(p_date in date :=bankdate, p_contr_id in number :=null, p_error out varchar2) return clob;

function p_f531(p_date in date :=bankdate, p_error out varchar2) return clob;

  --Процедура заселення/дозаселення попередніми данними для подальшої зміни і вигрузки
  procedure prepare_f503_change(p_date_to date);
  --текст для збереження в файл
  procedure get_text_file_f503(p_clob out clob, p_namefile out varchar2);
  procedure get_text_file_f504(p_clob out clob, p_namefile out varchar2);

  --Процедура заселення/дозаселення попередніми данними для подальшої зміни і вигрузки
  procedure prepare_f504_change(p_date_to date);
  --додавання показника до редагуємого звіту f504
  procedure add_indicator_f504(p_f504_id        cim_f504_detail.f504_id%type,
                               p_indicator_id   cim_f504_detail.indicator_id%type,
                               p_noprognosis    cim_f504_detail.noprognosis%type,
                               p_rrrr           cim_f504_detail.rrrr%type,
                               p_w              cim_f504_detail.w%type,
                               p_val            cim_f504_detail.val%type);

  --установка контексту для додавання в БМД
  procedure set_context_f504_detail(p_f504_id        cim_f504_detail.f504_id%type,
                                    p_indicator_id   cim_f504_detail.indicator_id%type);

  --додавання для механізмку БМД
  procedure add_f504_row(p_p101         cim_f504.p101%type,
                         p_z            cim_f504.z%type,
                         p_r_agree_no   cim_f504.r_agree_no%type,
                         p_p103         cim_f504.p103%type,
                         p_pval         cim_f504.pval%type,
                         p_t            cim_f504.t%type,
                         p_m            cim_f504.m%type,
                         p_p107         cim_f504.p107%type,
                         p_p108         cim_f504.p108%type,
                         p_p184         cim_f504.p184%type,
                         p_p140         cim_f504.p140%type,
                         p_p142         cim_f504.p142%type,
                         p_p020         cim_f504.p020%type,
                         p_p141         cim_f504.p141%type,
                         p_p143         cim_f504.p143%type,
                         p_p960         cim_f504.p960%type,
                         p_p310         cim_f504.p310%type,
                         p_p050         cim_f504.p050%type,
                         p_p060         cim_f504.p060%type,
                         p_p090         cim_f504.p090%type,
                         p_p999         cim_f504.p999%type
                         );
   --Синхронізація з ВК => Звіт
   procedure sync_f503;
   procedure sync_f504;

   procedure get_indicators_f503(p_contract_n number, p_date_z_begin date, p_date_z_end date, p_indicators_f503 out t_indicators_f503);
   procedure get_indicators_f504(p_contract_n number, p_date_to date, p_date_z_begin date, p_indicators_f504 in out t_indicators_f504);
   
  function get_contracts_list(p_mfo         varchar2,--cim_contracts.kf%type, 
                              p_date_from   cim_contracts.open_date%type, 
                              p_date_to     cim_contracts.open_date%type,
                              p_contr_type  varchar2,--cim_contracts.contr_type%type,
                              p_kv          varchar2,--cim_contracts.kv%type,
                              p_status      varchar2--cim_contracts.status_id%type
                              )  
   return t_arr_contracts pipelined PARALLEL_ENABLE;

END cim_reports;
/
CREATE OR REPLACE PACKAGE BODY CIM_REPORTS
is
   --
   --  CIM_REPORTS
   --

-- g_body_version      constant varchar2 (64) := 'version 1.00.01 17/07/2015';
-- g_body_version      constant varchar2 (64) := 'version 1.00.02 16/11/2015';
-- g_body_version      constant varchar2 (64) := 'version 1.00.03 04/04/2016';
-- g_body_version      constant varchar2 (64) := 'version 1.00.04 08/08/2016';
-- g_body_version      constant varchar2 (64) := 'version 1.00.05 20/09/2016';
   g_body_version      constant varchar2 (64) := 'version 1.01.13 20/07/2018';
   g_awk_body_defs     constant varchar2 (512) := '';


   --------------------------------------------------------------------------------
   -- header_version - повертає версію заголовка пакету
   --
   function header_version return varchar2
   is
   begin
      return    'Package header CIM_REPORTS '
             || g_header_version
             || '.'
             || CHR (10)
             || 'AWK definition: '
             || CHR (10)
             || g_awk_header_defs;
   end header_version;

   --------------------------------------------------------------------------------
   -- body_version - повертає версію тіла пакету
   --
   function body_version return varchar2
   is
   begin
      return    'Package body CIM_REPORTS '
             || g_body_version
             || '.'
             || CHR (10)
             || 'AWK definition: '
             || CHR (10)
             || g_awk_body_defs;
   end body_version;

function num_code(p_n in number) return varchar2
is
begin
  return substr('123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ0',p_n,1);
end num_code;

function p_f503(p_date in date :=bankdate, p_contr_id in number :=null, p_error out varchar2) return clob
is l_txt varchar2(4000); -- Текст повідомлення
   l_txt_clob clob;
   l_result clob;

   cursor c_contract is
     select c.contr_id, credit_type, date_term_change, case when credit_type=0 then '1' when creditor_type=11 then '3' else '2' end as m,
       lpad(substr(okpo,1,10),10,'0')||case when credit_type=0 or creditor_type=11 then '00001' else lpad(r_agree_no,5,'0') end||
       case when credit_type=0 then '00000000' else to_char(r_agree_date,'DDMMYYYY') end||to_char(kv,'fm009')||'0'/*!!!*/||'=' as z,
       translatewin2dos(substr(nmkk,1,27)) as p1000, case when credit_type=0 then '00000000' else to_char(r_agree_date,'DDMMYYYY') end as p1200,
       translatewin2dos(substr(benef_name,1,54)) as p1300,
       decode(creditor_type,11,'1',to_char(creditor_type,'fm9')) as p1400,
       to_char(borrower_id,'fm9') as p0100, to_char(credit_type,'fm9') as p1500, to_char(credit_prepay,'fm9') as p1600,
       (select nvl(case when max(payment_period)=min(payment_period) then to_char(max(decode(payment_period,14,4,payment_period)),'fm9')
                                                                     else '6' end,'6')
         from cim_credgraph_period where contr_id=c.contr_id) as p1700,
       to_char(f503_reason,'fm9') as p1800, to_char(c.country_id,'fm000') as p0300,
       nvl2(c.f503_percent_type, to_char(decode(c.f503_percent_type, 1, 3, c.f503_percent_type), 'fm0'), '') as p0400,
       translatewin2dos(substr(c.num, 1, 16)) as p0500, to_char(c.open_date, 'DDMMYYYY') as p0600, nvl2(c.f503_percent_margin, to_char(c.f503_percent_margin, 'fm99990.0000'), '') as p0700,
       case when c.f503_percent_type=2 then c.f503_percent_base||' '||c.f503_percent_base_t||' '||c.f503_percent_base_val else '' end as p0800,
       nvl2(c.s, to_char(c.s, 'fm9999999999999990'), '') as p0900, to_char(credit_term,'fm9') as p1900, to_char(f503_state,'fm9') as p3000,
       nvl2(c.f503_percent, to_char(c.f503_percent, 'fm990.000'), '') as p9500, c.f503_purpose as p9600,
       c.close_date as p3100, c.f503_change_info as p9800, translatewin2dos(f503_note) as p9900
     from v_cim_credit_contracts c
    where open_date<=last_day(add_months(p_date,-1)) and status_id!=1 and status_id!=9 and
          status_id!=10 and (p_contr_id is null or contr_id=p_contr_id);

   l_c c_contract%rowtype;
   l_sysdate date;
   l_oblcode varchar2(2);
   l_date_z_begin date;
   l_date_z_end date;
   l_filename varchar2(122);
   l_n number:=0; --Кількість стрічок

   l_k number;
   l_zt number;
   l_dt number;
   l_dp number;
   l_dk number;
   l_dpe number;
   l_zp number;

   l_p_snt number;
   l_p_pspt number;
   l_p_sp number;
   l_p_psk number;
   l_p_rsk number;
   l_p_spe1 number;
   l_p_spe2 number;
   l_p_rspt number;
   l_p_svp number;

   l_p_rez_st number;
   l_p_rep_st number;
   l_p_rev_st number;
   l_p_rez_sp number;
   l_p_rep_sp number;
   l_p_rev_sp number;
   l_p_s number;
   l_p_bt number;
   l_p2024 number;
   l_p2031 number;


   l_p_pp number; --погашені проценти (непрострочені)

   l_e_zt number;
   l_e_dt number;
   l_e_dp number;
   l_e_zp number;
   l_e_s number;

   l_mindat date;
   l_maxdat date;

   l_kod char(1) := 'B'; --Якщо вказано невірно то при імпорті в сторонне ПО може виникати : Код схеми надання не відповідає літері F в назві файлу. Має корилювати з першими двума цифрами в заголовку в самому файлі;

begin
  select concatstr('#'||to_char(contr_id,'fm999999999')) into l_txt from v_cim_credit_contracts c
    where open_date<=last_day(add_months(p_date,-1)) and status_id!=1 and status_id!=9 and
          status_id!=10 and (p_contr_id is null or contr_id=p_contr_id) and (f503_reason is null or f503_state is null);
  if l_txt is not null then
    p_error:='Не задано обов`язкові реквізити звіту Ф503 у контрактах:'||chr(13)||chr(10)||l_txt;
    return '';
  else
    l_sysdate:=sysdate;
    select nvl(par_value,'XXX') into l_filename from cim_params where  par_name='EL_COD_OBL'; --!!!
    l_filename:='#6A'||l_filename||num_code(to_number(to_char(l_sysdate,'MM')))||
      num_code(to_number(to_char(l_sysdate,'DD')))||'.'||l_kod||num_code(to_number(to_char(p_date,'MM')))||'1';
  end if;
  p_error:=l_filename; l_txt:=null;
  l_date_z_begin:=to_date('01/01/'||to_char(add_months(p_date,-1),'YYYY'),'DD/MM/YYYY'); l_date_z_end:=last_day(add_months(p_date,-1));

  dbms_lob.createtemporary(l_txt_clob, false);
  for l_c in c_contract loop
    cim_mgr.create_credgraph(l_c.contr_id);
--    select count(*) into l_k from cim_credgraph_tmp where dat<to_date('01.01.3000','DD.MM.YYYY');
--    if l_k>0 then
      if l_c.p0400='2' then
        l_txt:=l_txt
          ||l_c.m||'0700'||l_c.z||l_c.p0700||chr(13)||chr(10)
          ||l_c.m||'0800'||l_c.z||l_c.p0800||chr(13)||chr(10);
        l_n:=l_n+2;
      end if;

      l_txt:=l_txt
        ||l_c.m||'0200'||l_c.z||'0000'||chr(13)||chr(10)
        ||l_c.m||'0300'||l_c.z||l_c.p0300||chr(13)||chr(10)

        ||l_c.m||'0400'||l_c.z||l_c.p0400||chr(13)||chr(10)
        ||l_c.m||'0500'||l_c.z||l_c.p0500||chr(13)||chr(10)
        ||l_c.m||'0600'||l_c.z||l_c.p0600||chr(13)||chr(10)
        ||l_c.m||'0900'||l_c.z||l_c.p0900||chr(13)||chr(10)

        ||l_c.m||'1000'||l_c.z||l_c.p1000||chr(13)||chr(10)
        ||l_c.m||'1200'||l_c.z||l_c.p1200||chr(13)||chr(10)
        ||l_c.m||'1300'||l_c.z||l_c.p1300||chr(13)||chr(10)
        ||l_c.m||'1400'||l_c.z||l_c.p1400||chr(13)||chr(10)
        ||l_c.m||'0100'||l_c.z||l_c.p0100||chr(13)||chr(10)
        ||l_c.m||'1500'||l_c.z||l_c.p1500||chr(13)||chr(10)
        ||l_c.m||'1600'||l_c.z||l_c.p1600||chr(13)||chr(10)
        ||l_c.m||'1700'||l_c.z||l_c.p1700||chr(13)||chr(10)
        ||l_c.m||'1800'||l_c.z||l_c.p1800||chr(13)||chr(10)
        ||l_c.m||'1900'||l_c.z||l_c.p1900||chr(13)||chr(10);
      l_n:=l_n+2+4+10;
--    end if;
    select count(*) into l_k from cim_credgraph_tmp where dat<=l_date_z_end;
    if l_k>0 then
      select count(*) into l_k from cim_credgraph_tmp where dat=l_date_z_begin;
      if l_k=1 then
        select round(zt/100,0), round(dt/100,0), round(dp/100,0),  round(smp/100,2) into l_zt, l_dt, l_dp, l_p_s
          from cim_credgraph_tmp where dat=l_date_z_begin;
      else
        select count(*) into l_k from cim_credgraph_tmp where dat<l_date_z_begin;
        if l_k>0 then
          select max(dat) into l_mindat from cim_credgraph_tmp where dat<=l_date_z_begin;
          select round(zt/100,0), round(dt/100,0), round(dp/100,0), round(smp/100,2) into l_zt, l_dt, l_dp, l_p_s
            from cim_credgraph_tmp where dat=l_mindat;
        else
          l_zt:=0; l_dt:=0; l_dp:=0; l_p_s:=0;
        end if;
      end if;
      if l_zt!=0 then l_txt:=l_txt||l_c.m||'2010'||l_c.z||to_char(l_zt,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if l_dt!=0 then l_txt:=l_txt||l_c.m||'2011'||l_c.z||to_char(l_dt,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if l_dp!=0 then l_txt:=l_txt||l_c.m||'2012'||l_c.z||to_char(l_dp,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;

      select round(nvl(sum(psk)-sum(rsk),0)/100,0), round(nvl(sum(pspe)-sum(rspe),0)/100,0), round(nvl(sum(smp)-sum(svp),0)/100,2), max(dat)
        into l_dk, l_dpe, l_zp, l_mindat  from cim_credgraph_tmp where dat<l_date_z_begin;
        l_zp:=l_zp+l_p_s;
      if l_dk!=0 then l_txt:=l_txt||l_c.m||'2013'||l_c.z||to_char(l_dk,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if l_dpe!=0 then l_txt:=l_txt||l_c.m||'2014'||l_c.z||to_char(l_dpe,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if l_zt+l_dp+l_dk+l_dpe!=0 then
        l_txt:=l_txt||l_c.m||'2039'||l_c.z||to_char(l_zt+l_dp+l_dk+l_dpe,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1;
      end if;
      --if l_zp-l_dp!=0 then l_txt:=l_txt||l_c.m||'2015'||l_c.z||to_char(round(l_zp-l_dp,2),'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;

      select count(*) into l_k from cim_credgraph_tmp where dat>=l_date_z_begin and dat<=l_date_z_end;
      if l_k>0 then
        select round(nvl(sum(rsnt),0)/100,0), round(nvl(sum(pspt),0)/100,0), round(nvl(sum(sp),0)/100,0), round(nvl(sum(psk),0)/100,0),
               round(nvl(sum(rsk),0)/100,0), round(nvl(sum(pspe),0)/100,0), round(nvl(sum(rspe),0)/100,0), round(nvl(sum(rspt),0)/100,0),
               round(nvl(sum(svp),0)/100,0), max(dat), sum(case when svp-dp>0 then svp-dp else 0 end),
               round(nvl(sum(case when rspt>0 and dt<=pspt then case when rspt<pspt+bt-dt then 0 else rspt-pspt-bt+dt end else rspt end),0)/100,0),
                round(nvl(sum(case when svp>0 and dp<=sp then case when svp<sp-case when zp<0 then zp else 0 end-dp then 0
                                                                   else svp-sp+ case when zp<0 then zp else 0 end +dp end else svp end),0)/100,0)--!?
               --round(nvl(max(bt),0)/100,0)
          into l_p_snt, l_p_pspt, l_p_sp, l_p_psk, l_p_rsk, l_p_spe1, l_p_spe2, l_p_rspt, l_p_svp, l_maxdat, l_p_pp, l_p2024, l_p2031-- l_p_bt
          from cim_credgraph_tmp where dat>=l_date_z_begin and dat<=l_date_z_end;
        select round(nvl(bt,0)/100,2) into l_p_bt from cim_credgraph_tmp where dat=l_maxdat;
      else
        l_p_snt:=0; l_p_pspt:=0; l_p_sp:=0; l_p_psk:=0; l_p_rsk:=0; l_p_spe1:=0; l_p_spe2:=0; l_p_rspt:=0; l_p_svp:=0;
        l_p_pp:=0; l_p2024:=0; l_p2031:=0; l_p_bt:=0;
      end if;

      if l_mindat is not null then
        select nvl(l_p_bt-round(nvl(bt,0)/100,2),0) into l_p_bt from cim_credgraph_tmp where dat=l_mindat;
      end if;
      if l_p_spe1<l_p_spe2-l_dpe then l_p_spe1:=l_p_spe2-l_dpe; end if; if l_p_psk<l_p_rsk-l_dk then l_p_psk:=l_p_rsk-l_dk; end if;

      l_p_rez_st:=0; l_p_rep_st:=0; l_p_rev_st:=0; l_p_rez_sp:=0; l_p_rep_sp:=0; l_p_rev_sp:=0;
      select nvl(sum(case when pay_flag=2 and type_id=7 then s_vk else 0 end),0), nvl(sum(case when pay_flag=2 and type_id=6 then s_vk else 0 end),0),
        nvl(sum(case when pay_flag=2 and type_id=5 then s_vk else 0 end),0), nvl(sum(case when pay_flag=3 and type_id=7 then s_vk else 0 end),0),
        nvl(sum(case when pay_flag=3 and type_id=6 then s_vk else 0 end),0), nvl(sum(case when pay_flag=3 and type_id=5 then s_vk else 0 end),0)
        into l_p_rez_st, l_p_rep_st, l_p_rev_st, l_p_rez_sp, l_p_rep_sp, l_p_rev_sp
        from v_cim_bound_payments where vdat>=l_date_z_begin and vdat<=l_date_z_end and contr_id=l_c.contr_id;
      l_p_rspt:=l_p_rspt-l_p_rez_st-l_p_rep_st-l_p_rev_st; l_p_svp:=l_p_svp-l_p_rez_sp-l_p_rep_sp-l_p_rev_sp;

      if l_p_snt!=0 then l_txt:=l_txt||l_c.m||'2016'||l_c.z||to_char(l_p_snt,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if l_p_pspt!=0 then l_txt:=l_txt||l_c.m||'2017'||l_c.z||to_char(l_p_pspt,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if l_p_sp!=0 then l_txt:=l_txt||l_c.m||'2018'||l_c.z||to_char(l_p_sp,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if l_p_psk!=0 then l_txt:=l_txt||l_c.m||'2020'||l_c.z||to_char(l_p_psk,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if l_p_spe1!=0 then l_txt:=l_txt||l_c.m||'2021'||l_c.z||to_char(l_p_spe1,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if l_p_rspt!=0 then l_txt:=l_txt||l_c.m||'2022'||l_c.z||to_char(l_p_rspt,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if l_p_bt!=0 then l_txt:=l_txt||l_c.m||'2023'||l_c.z||to_char(l_p_bt,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if l_p2024!=0 then l_txt:=l_txt||l_c.m||'2024'||l_c.z||to_char(l_p2024,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;

      if l_p_rez_st+l_p_rep_st+l_p_rev_st!=0 then
        l_txt:=l_txt||l_c.m||'2025'||l_c.z||to_char(l_p_rez_st+l_p_rep_st+l_p_rev_st,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1;
      end if;
      if l_p_rez_st!=0 then l_txt:=l_txt||l_c.m||'2026'||l_c.z||to_char(l_p_rez_st,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if l_p_rep_st!=0 then l_txt:=l_txt||l_c.m||'2027'||l_c.z||to_char(l_p_rep_st,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if l_p_rev_st!=0 then l_txt:=l_txt||l_c.m||'2028'||l_c.z||to_char(l_p_rev_st,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;

      if l_p_svp!=0 then l_txt:=l_txt||l_c.m||'2029'||l_c.z||to_char(l_p_svp,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if l_p_svp>l_p_sp+l_dp then
        l_txt:=l_txt||l_c.m||'2030'||l_c.z||to_char(l_p_svp-l_p_sp-l_dp,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1;
      end if;
      if l_p2031!=0 then l_txt:=l_txt||l_c.m||'2031'||l_c.z||to_char(l_p2031,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;

      if l_p_rez_sp+l_p_rep_sp+l_p_rev_sp!=0 then
        l_txt:=l_txt||l_c.m||'2032'||l_c.z||to_char(l_p_rez_sp+l_p_rep_sp+l_p_rev_sp,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1;
      end if;
      if l_p_rez_sp!=0 then l_txt:=l_txt||l_c.m||'2033'||l_c.z||to_char(l_p_rez_sp,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if l_p_rep_sp!=0 then l_txt:=l_txt||l_c.m||'2034'||l_c.z||to_char(l_p_rep_sp,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if l_p_rev_sp!=0 then l_txt:=l_txt||l_c.m||'2035'||l_c.z||to_char(l_p_rev_sp,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;

      if l_p_rsk!=0 then l_txt:=l_txt||l_c.m||'2036'||l_c.z||to_char(l_p_rsk,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if l_p_spe2!=0 then l_txt:=l_txt||l_c.m||'2037'||l_c.z||to_char(l_p_spe2,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      l_p_s:=l_p_rspt+l_p_rez_st+l_p_rep_st+l_p_rev_st+l_p_svp+l_p_rez_sp+l_p_rep_sp+l_p_rev_sp+l_p_rsk+l_p_spe2;
      if l_p_s!=0 then l_txt:=l_txt||l_c.m||'2040'||l_c.z||to_char(l_p_s,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      l_e_zt:=l_zt+l_p_snt-l_p_rspt-l_p_rez_st-l_p_rep_st-l_p_rev_st;
      if l_e_zt!=0 then l_txt:=l_txt||l_c.m||'2041'||l_c.z||to_char(l_e_zt,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;

      select round(nvl(dt,0)/100,0), round(nvl(dp,0)/100,0) into l_e_dt, l_e_dp
        from cim_credgraph_tmp where dat=(select max(dat) from cim_credgraph_tmp where dat<=l_date_z_end+1);
      if l_e_dt!=0 then l_txt:=l_txt||l_c.m||'2038'||l_c.z||to_char(l_e_dt,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if l_e_dp!=0 then l_txt:=l_txt||l_c.m||'2042'||l_c.z||to_char(l_e_dp,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if l_dk+l_p_psk-l_p_rsk!=0 then
        l_txt:=l_txt||l_c.m||'2043'||l_c.z||to_char(l_dk+l_p_psk-l_p_rsk,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1;
      end if;
      if l_dpe+l_p_spe1-l_p_spe2!=0 then
        l_txt:=l_txt||l_c.m||'2044'||l_c.z||to_char(l_dpe+l_p_spe1-l_p_spe2,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1;
      end if;

      select round(nvl(sum(smp)-sum(svp),0)/100,0) into l_e_zp  from cim_credgraph_tmp where dat<=l_date_z_end;
      select count(*) into l_e_s from cim_credgraph_tmp where dat=l_date_z_end+1;
      if l_e_s=1 then
        select round(nvl(smp,0)/100,0) into l_e_s  from cim_credgraph_tmp where dat=l_date_z_end+1; l_e_zp:=l_e_zp+l_e_s;
      else l_e_s:=0;
      end if;
      l_e_s:=l_e_zt +l_e_dp +l_dk+l_p_psk-l_p_rsk +l_dpe+l_p_spe1-l_p_spe2;
      if l_e_s!=0 then l_txt:=l_txt||l_c.m||'2045'||l_c.z||to_char(l_e_s,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      --if l_e_zp-l_e_dp!=0 then l_txt:=l_txt||l_c.m||'2046'||l_c.z||to_char(l_e_zp-l_e_dp,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
    end if;

    l_txt:=l_txt||l_c.m||'9500'||l_c.z||l_c.p9500||chr(13)||chr(10); l_n:=l_n+1;
    l_txt:=l_txt||l_c.m||'9600'||l_c.z||to_char(l_c.p9600,'fm99')||chr(13)||chr(10); l_n:=l_n+1;
    l_txt:=l_txt||l_c.m||'3100'||l_c.z||to_char(l_c.p3100,'DDMMYYYY')||chr(13)||chr(10); l_n:=l_n+1;
--    if last_day(add_months(trunc(p_date),-2))<l_c.date_term_change and l_c.date_term_change<=l_date_z_end then
   --   l_txt:=l_txt||l_c.m||'9800'||l_c.z||'+'||chr(13)||chr(10); l_n:=l_n+1;
--    end if;
    l_txt:=l_txt||l_c.m||'9800'||l_c.z||l_c.p9800||chr(13)||chr(10); l_n:=l_n+1;
    if l_c.p9900 is not null then l_txt:=l_txt||l_c.m||'9900'||l_c.z||l_c.p9900||chr(13)||chr(10); l_n:=l_n+1; end if;
    l_txt:=l_txt||l_c.m||'3000'||l_c.z||l_c.p3000||chr(13)||chr(10); l_n:=l_n+1;

    dbms_lob.append(l_txt_clob, l_txt); l_txt:=null;
  end loop;
  --l_date_z_begin:=last_day(add_months(p_date,-2))+1;
  select nvl(par_value,'XX') into l_oblcode from bars.cim_params where par_name='OBL_CODE';
  select nvl2(b040, substr(b040, length(b040)-11, 12), 'XXXXXXXXXXXX') into l_txt from branch where branch='/'||f_ourmfo||'/';
  l_txt:=lpad(' ',100,' ')||chr(13)||chr(10)||
    rpad('02=01'||to_char(p_date,'MMYYYY')||'=01'||to_char(l_date_z_end,'MMYYYY')||'='||to_char(l_date_z_end,'DDMMYYYY')
         ||'='||to_char(l_sysdate,'DDMMYYYY')||'='||to_char(l_sysdate,'HH24MM')||'='||to_char(gl.amfo,'fm000000')||'=12='
         ||to_char(l_n,'fm000000000')||'='||l_filename||'= IDKEY=',148,' ')||chr(13)||chr(10)
         ||'#1='||l_oblcode||'='||l_txt||chr(13)||chr(10);
  dbms_lob.createtemporary(l_result, false); dbms_lob.append(l_result, l_txt); dbms_lob.append(l_result, l_txt_clob);
  return l_result;
end  p_f503;

function p_f504(p_date in date :=bankdate, p_contr_id in number :=null, p_error out varchar2) return clob
is l_txt varchar2(4000); -- Текст повідомлення
   l_txt_clob clob;
   l_result clob;

   cursor c_contract is
     select contr_id, credit_type, case when credit_type=0 then '1' when creditor_type=11 then '3' else '2' end as m,
       lpad(substr(okpo,1,10),10,'0')||case when credit_type=0 or creditor_type=11 then '00001' else lpad(r_agree_no,5,'0') end as z,
       case when credit_type=0 then '00000000' else to_char(r_agree_date,'DDMMYYYY') end||to_char(kv,'fm009')||'0'/*!!!*/||'=' as e,
       translatewin2dos(substr(c.num, 1, 16)) as p050, to_char(c.open_date, 'DDMMYYYY') as p060, to_char(c.s, 'fm9999999999999990') as p090,
       c.f503_purpose as p960, c.close_date as p310,
       translatewin2dos(substr(nmkk,1,27)) as p101,  case when credit_type=0 then '00000000' else to_char(r_agree_date,'DDMMYYYY') end as p103,
       translatewin2dos(substr(benef_name,1,54)) as p107, decode(creditor_type,11,'1',to_char(creditor_type,'fm9')) as p108,
       to_char(credit_type,'fm9') as p140, to_char(credit_prepay,'fm9') as p141,
       (select nvl(case when max(payment_period)=min(payment_period) then to_char(max(decode(payment_period,14,4,payment_period)),'fm9') else '6' end,'6')
         from cim_credgraph_period where contr_id=c.contr_id) as p142, to_char(f504_reason,'fm9') as p143, translatewin2dos(f504_note) as p999,
       to_char(credit_term,'fm9') as p184, s
     from v_cim_credit_contracts c
    where open_date<=last_day(add_months(p_date,-1)) and status_id != 1 and status_id!=9 and
          status_id != 10 and (p_contr_id is null or contr_id=p_contr_id);

   l_c c_contract%rowtype;
   l_sysdate date;
   l_filename varchar2(122);
   l_oblcode varchar2(2);
   l_date_begin date;
   l_date_end date;
   l_n number:=0; --Кількість стрічок

   l_b_y number;

   l_date_z_begin date;

   l_p212 number;
   l_p213 number;
   l_p201 number;
   l_p222 number;
   l_p223 number;
   l_p292 number;
   l_p293 number;

   l_act_m number;
   l_act_y varchar2(4);
   l_rm number;
   l_y_txt varchar2(5);
   l_prognoz number;
   l_f_incom number; -- Сума майбутніх надходжень
   l_snt number;
   l_spt number;
   l_maxdat date;
   l_dat date;

   l_kod char(1) := 'B'; --Якщо вказано невірно то при імпорті в сторонне ПО може виникати : Код схеми надання не відповідає літері F в назві файлу. Має корилювати з першими двума цифрами в заголовку в самому файлі;
begin
  select concatstr('#'||to_char(contr_id,'fm999999999')) into l_txt from v_cim_credit_contracts c
    where open_date<=last_day(add_months(p_date,-1)) and status_id!=1 and status_id!=9 and
          status_id!=10 and (p_contr_id is null or contr_id=p_contr_id) and f504_reason is null;
  if l_txt is not null then
    p_error:='Не задано підстави подання звіту Ф504 у контрактах:'||chr(13)||chr(10)||l_txt; return '';
  else
    l_sysdate:=sysdate;
    select nvl(par_value,'XXX') into l_filename from cim_params where  par_name='EL_COD_OBL';
    l_filename:='#35'||l_filename||num_code(to_number(to_char(l_sysdate,'MM')))||
      num_code(to_number(to_char(l_sysdate,'DD')))||'.'||l_kod||num_code(to_number(to_char(p_date,'MM')))||'1';
  end if;
  p_error:=l_filename; l_txt:=null;

  dbms_lob.createtemporary(l_txt_clob, false);
  for l_c in c_contract loop
    l_txt:=l_c.m||'050'||l_c.z||'00000'||l_c.e||l_c.p050||chr(13)||chr(10)
         ||l_c.m||'060'||l_c.z||'00000'||l_c.e||l_c.p060||chr(13)||chr(10)
         ||l_c.m||'090'||l_c.z||'00000'||l_c.e||l_c.p090||chr(13)||chr(10)
         ||l_c.m||'101'||l_c.z||'00000'||l_c.e||l_c.p101||chr(13)||chr(10)
         ||l_c.m||'103'||l_c.z||'00000'||l_c.e||l_c.p103||chr(13)||chr(10)
         ||l_c.m||'107'||l_c.z||'00000'||l_c.e||l_c.p107||chr(13)||chr(10)

         ||l_c.m||'108'||l_c.z||'00000'||l_c.e||l_c.p108||chr(13)||chr(10)
         ||l_c.m||'140'||l_c.z||'00000'||l_c.e||l_c.p140||chr(13)||chr(10)
         ||l_c.m||'141'||l_c.z||'00000'||l_c.e||l_c.p141||chr(13)||chr(10)
         ||l_c.m||'142'||l_c.z||'00000'||l_c.e||l_c.p142||chr(13)||chr(10)
         ||l_c.m||'143'||l_c.z||'00000'||l_c.e||l_c.p143||chr(13)||chr(10)
         ||l_c.m||'184'||l_c.z||'00000'||l_c.e||l_c.p184||chr(13)||chr(10)
         ||l_c.m||'020'||l_c.z||'00000'||l_c.e||'0000'||chr(13)||chr(10)
         ||l_c.m||'960'||l_c.z||'00000'||l_c.e||to_char(l_c.p960,'fm99')||chr(13)||chr(10)
         ||l_c.m||'310'||l_c.z||'00000'||l_c.e||to_char(l_c.p310,'DDMMYYYY')||chr(13)||chr(10); l_n:=l_n+9+6;
    if l_c.p999 is not null then l_txt:=l_txt||l_c.m||'999'||l_c.z||'00000'||l_c.e||l_c.p999||chr(13)||chr(10); l_n:=l_n+1; end if;

    cim_mgr.create_credgraph(l_c.contr_id);
    select count(*), max(dat) into l_p212, l_maxdat from cim_credgraph_tmp where dat != to_date('01/01/3000','DD/MM/YYYY');
    l_b_y:=to_number(to_char(p_date,'YYYY')); l_date_z_begin:=last_day(add_months(p_date,-1))+1;
    if l_p212>0 then
      select count(*) into l_p212 from cim_credgraph_tmp where dat<l_date_z_begin;
      if l_p212>0 then
        select nvl(sum(rsnt),0), nvl(sum(rspt),0) into l_p212, l_p213 from cim_credgraph_tmp where dat<l_date_z_begin;
      else l_p212:=0; l_p213:=0;
      end if;
      l_f_incom:=l_c.s*100-l_p212;
      select nvl(sum(psnt),0), nvl(sum(pspt),0) into l_p222, l_p223 from cim_credgraph_tmp
        where dat>=l_date_z_begin and dat != to_date('01/01/3000','DD/MM/YYYY');
      select nvl(max(dt),0) into l_p201 from cim_credgraph_tmp where dat = l_date_z_begin;
      if l_p212+l_p222 != l_p213+l_p223+l_p201 or l_p212+l_p222 != l_c.s*100 then
        l_prognoz:=0; l_snt:=round(l_c.s-l_p212/100,0); l_spt:=l_c.s*100-l_p213-l_p223;
      else
        l_prognoz:=1;
      end if;
      l_p212:=0; l_p213:=0; l_p201:=0; l_p222:=0; l_p223:=0;
      l_act_m:=to_number(to_char(l_date_z_begin,'MM')); l_act_y:=to_char(l_date_z_begin,'YYYY'); l_rm:=0;
      for l in (select * from cim_credgraph_tmp
                  where dat>=l_date_z_begin and dat<to_date('01/01/'||to_char(l_b_y+10,'fm9999'),'DD/MM/YYYY') order by dat) loop
        l_dat:=l.dat;
        if l_act_y=to_char(l.dat,'YYYY') and (l_rm=1 or l_act_m=to_number(to_char(l.dat,'MM'))) then
          l_p212:=l_p212+l.xpspt; l_p213:=l_p213+l.xsp; l_p201:=l_p201+l.psnt; l_p222:=l_p222+l.pspt; l_p223:=l_p223+l.sp;
        else
          if l_rm=0 then l_y_txt:=l_act_y||num_code(l_act_m); else l_y_txt:=l_act_y||'0'; end if;
          if l_p212 != 0 then l_txt:=l_txt||l_c.m||'212'||l_c.z||l_y_txt||l_c.e||round(l_p212/100,0)||chr(13)||chr(10); l_n:=l_n+1; end if;
          if l_p213 != 0 then l_txt:=l_txt||l_c.m||'213'||l_c.z||l_y_txt||l_c.e||round(l_p213/100,0)||chr(13)||chr(10); l_n:=l_n+1; end if;
          if l_prognoz=0 and l.dat = l_maxdat then l_p222:=l_p222+l_spt; end if;
          /* COBUSUPABS-6031 if l_p222 != 0 and l_f_incom>0
            then l_txt:=l_txt||l_c.m||'222'||l_c.z||l_y_txt||l_c.e||round(l_p222/100,0)||chr(13)||chr(10); l_n:=l_n+1; end if;
          if l_prognoz=1 then
            if l_p223 != 0 and l_f_incom>0
              then l_txt:=l_txt||l_c.m||'223'||l_c.z||l_y_txt||l_c.e||round(l_p223/100,0)||chr(13)||chr(10); l_n:=l_n+1; end if;
            if l_p201 != 0 then l_txt:=l_txt||l_c.m||'201'||l_c.z||l_y_txt||l_c.e||round(l_p201/100,0)||chr(13)||chr(10); l_n:=l_n+1; end if;
          end if;
          */
          l_p212:=l.xpspt; l_p213:=l.xsp; l_p201:=l.psnt; l_p222:=l.pspt; l_p223:=l.sp;
          l_act_m:=to_number(to_char(l.dat,'MM')); l_act_y:=to_char(l.dat,'YYYY');
          if l_act_y-to_number(to_char(l_date_z_begin,'YYYY'))>1 then l_rm:=1; else l_rm:=0; end if; --1 - річний
        end if;
      end loop;

      if l_rm=0 then l_y_txt:=l_act_y||num_code(l_act_m); else l_y_txt:=l_act_y||'0'; end if;
      if l_p212 != 0 then l_txt:=l_txt||l_c.m||'212'||l_c.z||l_y_txt||l_c.e||round(l_p212/100,0)||chr(13)||chr(10); l_n:=l_n+1; end if;
      if l_p213 != 0 then l_txt:=l_txt||l_c.m||'213'||l_c.z||l_y_txt||l_c.e||round(l_p213/100,0)||chr(13)||chr(10); l_n:=l_n+1; end if;
      if l_prognoz=0 and l_dat = l_maxdat then l_p222:=l_p222+l_spt; end if;
      /* COBUSUPABS-6031
      if l_p222 != 0 and l_f_incom>0 then
        l_txt:=l_txt||l_c.m||'222'||l_c.z||l_y_txt||l_c.e||round(l_p222/100,0)||chr(13)||chr(10); l_n:=l_n+1;
      end if;
      if l_prognoz=1 then
         if l_p223 != 0 and l_f_incom>0
           then l_txt:=l_txt||l_c.m||'223'||l_c.z||l_y_txt||l_c.e||round(l_p223/100,0)||chr(13)||chr(10); l_n:=l_n+1; end if;
         if l_p201 != 0 then l_txt:=l_txt||l_c.m||'201'||l_c.z||l_y_txt||l_c.e||round(l_p201/100,0)||chr(13)||chr(10); l_n:=l_n+1; end if;
      end if;
      */
      select round(nvl(sum(xpspt),0)/100,0), round(nvl(sum(xsp),0)/100,0), round(nvl(sum(psnt),0)/100,0), round(nvl(sum(pspt),0)/100,0),
             round(nvl(sum(sp),0)/100,0)  into l_p212, l_p213, l_p201, l_p222, l_p223
        from cim_credgraph_tmp where dat>=to_date('01/01/'||to_char(l_b_y+10,'fm9999'),'DD/MM/YYYY') and dat != to_date('01/01/3000','DD/MM/YYYY');
      if l_p212 != 0 then l_txt:=l_txt||l_c.m||'212'||l_c.z||'88888'||l_c.e||l_p212||chr(13)||chr(10); l_n:=l_n+1; end if;
      if l_p213 != 0 then l_txt:=l_txt||l_c.m||'213'||l_c.z||'88888'||l_c.e||l_p213||chr(13)||chr(10); l_n:=l_n+1; end if;
      /* COBUSUPABS-6031 if l_p201 != 0 then l_txt:=l_txt||l_c.m||'201'||l_c.z||'88888'||l_c.e||l_p201||chr(13)||chr(10); l_n:=l_n+1; end if;
      if l_p222 != 0 and l_f_incom>0
        then l_txt:=l_txt||l_c.m||'222'||l_c.z||'88888'||l_c.e||l_p222||chr(13)||chr(10); l_n:=l_n+1; end if;
      if l_p223 != 0 and l_f_incom>0
        then l_txt:=l_txt||l_c.m||'223'||l_c.z||'88888'||l_c.e||l_p223||chr(13)||chr(10); l_n:=l_n+1; end if;
      if l_prognoz=0 and l_snt>0 then l_txt:=l_txt||l_c.m||'201'||l_c.z||'99999'||l_c.e||l_snt||chr(13)||chr(10); l_n:=l_n+1; end if;
      */
      select round(nvl(max(dt),0)/100,0), round(nvl(max(dp),0)/100,0) into l_p292, l_p293 from cim_credgraph_tmp where dat=l_date_z_begin;
      if l_p292 != 0 then l_txt:=l_txt||l_c.m||'292'||l_c.z||'99999'||l_c.e||l_p292||chr(13)||chr(10); l_n:=l_n+1; end if;
      if l_p293 != 0 then l_txt:=l_txt||l_c.m||'293'||l_c.z||'99999'||l_c.e||l_p293||chr(13)||chr(10); l_n:=l_n+1; end if;
    else l_txt:=l_txt||translatewin2dos('Контракт #'||l_c.contr_id||'не має графіка.')||chr(13)||chr(10);
    end if;

    dbms_lob.append(l_txt_clob, l_txt); l_txt:=null;
  end loop;
  select nvl(par_value,'XX') into l_oblcode from bars.cim_params where par_name='OBL_CODE';
  select nvl2(b040, substr(b040, length(b040)-11, 12), 'XXXXXXXXXXXX') into l_txt from branch where branch='/'||f_ourmfo||'/';
  l_txt:=lpad(' ',100,' ')||chr(13)||chr(10)||
    rpad('02=01'||to_char(p_date,'MMYYYY')||'=01'||to_char(l_date_z_begin-1,'MMYYYY')||'='||to_char(last_day(l_date_z_begin-1),'DDMMYYYY')
         ||'='||to_char(l_sysdate,'DDMMYYYY')||'='||to_char(l_sysdate,'HH24MM')||'='||to_char(gl.amfo,'fm000000')||'=12='
         ||to_char(l_n,'fm000000000')||'='||l_filename||'= IDKEY=',148,' ')||chr(13)||chr(10)
         ||'#1='||l_oblcode||'='||l_txt||chr(13)||chr(10);
  dbms_lob.createtemporary(l_result, false); dbms_lob.append(l_result, l_txt); dbms_lob.append(l_result, l_txt_clob);
  return l_result;
end  p_f504;

function p_f531(p_date in date :=bankdate, p_error out varchar2) return clob
is l_txt varchar2(4000); -- Текст повідомлення
   l_txt_clob clob;
   l_result clob;

   l_filename varchar2(122);
   l_oblcode varchar2(3);
   l_date_z_end date;
   l_n number:=0; --Кількість стрічок
   l_n_contr number :=0; -- Порядковий номер контракту
   l_contr_num varchar2(60);
   l_contr_date date;
   l_okpo varchar2(14):='x';
   l_b041 varchar2(12):='x';
   l_sysdate date;
   l_last_date date;

   l_last_p21 date;
   l_p27 number :=1;
   l_benef_name varchar2(256);
   l_p22 number;
begin
  if sys_context('bars_context','user_mfo') is null then
    bars_audit.error('CIM p_f531 : user_id '||user_id()||' kf '||sys_context('bars_context','user_mfo'));
    raise_application_error(-20001,'Представтесь відділенням');
  end if;

  bars_audit.info('CIM p_f531  '||p_date||': :'||user_id||':');
  l_sysdate:=trunc(sysdate);
  select nvl(substr(par_value,1,3),'XXX') into l_oblcode from cim_params where par_name='EL_COD_OBL';
  l_filename:='#36'||l_oblcode||num_code(to_number(to_char(l_sysdate,'MM')))||
              num_code(to_number(to_char(l_sysdate,'DD')))||'.E'||num_code(to_number(to_char(p_date,'MM')))||'1';
  p_error:=l_filename; select nvl(substr(par_value,1,2),'XX') into l_oblcode from cim_params where  par_name='OBL_CODE';

  dbms_lob.createtemporary(l_txt_clob, false); l_date_z_end:=last_day(add_months(p_date,-1))+1;
  select nvl(max(create_date), add_months(l_date_z_end,-1)) into l_last_date from cim_f36 where branch like sys_context('bars_context', 'user_mfo_mask');

  if l_last_date=l_date_z_end and
          (to_char(l_sysdate,'yyyymm')=to_char(l_last_date,'yyyymm') and to_number(to_char(l_sysdate,'dd'))<=10 or
           to_number(to_char(l_sysdate,'yyyymm'))<to_number(to_char(l_last_date,'yyyymm'))) or
        add_months(l_last_date,1)=l_date_z_end and
          (to_number(to_char(l_sysdate,'yyyymm'))+1=to_number(to_char(l_date_z_end,'yyyymm')) and to_number(to_char(l_sysdate,'dd'))>10 or
           to_number(to_char(l_sysdate,'yyyymm'))+1>to_number(to_char(l_date_z_end,'yyyymm')) )
  --      or to_char(p_date,'yyyymm')='201505'
  then

    delete from cim_f36 where create_date=l_date_z_end and branch like sys_context('bars_context', 'user_mfo_mask');
    insert into cim_f36 (b041, k020, p17, p16, doc_date, p21, p14, p01, p22, p15, p18, create_date)
                 values (0, 0, '0', to_date('01/01/2015', 'dd/mm/yyyy'), '01012015', to_date('01/01/2015', 'dd/mm/yyyy'), 0, 0, 0, 0, 0, l_date_z_end);
    for l in
    (
      select * from (
        select case when a.p15 is null or a.p22=3 then a.f_b041 else a.b041 end as b041, case when a.p15 is null or a.p22=3 then a.f_k020 else a.k020 end as k020,
               case when a.p15 is null or a.p22=3 then a.f_p01 else a.p01 end as p01,
               decode(a.p22, 3, nvl(a.f_p02_old, a.f_p02), a.p02) as p02, decode(a.p22, 3, nvl(a.f_p06_old, a.f_p06), a.p06) as p06,
               substr(decode(a.p22, 3, nvl(a.f_p07_old, a.f_p07), a.p07), 1, 135) as p07, decode(a.p22, 3, nvl(a.f_p08_old, a.f_p08), a.p08) as p08,
               decode(a.p22, 3, a.f_p09, a.p09) as p09, decode(a.p22, 3, 0, cim_mgr.val_convert(to_date(l_date_z_end-1), a.p15, a.p14, 980)) as p13,
               nvl2(a.p15, a.p14, a.f_p14) as p14, decode(a.p22, 3, 0, a.p15) as p15, case when a.p15 is null or a.m_p22=3 then a.f_p16 else a.p16 end as p16,
               case when a.p15 is null or a.m_p22=3 then a.f_p17 else a.p17 end as p17,
               decode(a.p22, 1, a.p18, a.f_p18) as p18, decode(a.p22, 3, a.f_p19, a.p19) as p19, nvl2(a.p15, decode(a.p22, 1, a.p20, a.f_p20), a.f_p20) as p20,
               case when a.p15 is null or a.m_p22=3 then a.f_p21 else nvl(a.f_p21,a.p21) end as p21, a.p22, decode(a.p22, 2, l_date_z_end, null) as p23,
               decode(a.p22, 3, case when a.p15=0 then a.max_pdat else null end, null) as p24, case when a.p27=0 then null else to_char(a.p27, 'fm999') end as p27, a.doc_date,
               case when a.p22=2 and a.f_p21<>a.p21 then a.p21 else null end as p21_new
               /*row_number() over ( partition by a.k020, decode(a.p22, 3, nvl(a.f_p08_old, a.f_p08), a.p08),
               case when a.p15 is null or a.m_p22=3 then a.f_p17 else a.p17 end order by a.p16 ) as p27*/
         from
         ( select nvl(m.m_p22,
                      case when x.p15=0 or x.p21<add_months(l_date_z_end,-120) or x.p15 is null then 3
                           when x.f_b041 is null then 1
                           when x.f_p02 != e.k112 or x.f_p06 != k.nmk or x.f_p07 != nvl(x.adr, k.adr) or x.f_p08 != substr(b.benef_name,1,135) or
                                x.f_p09 != b.country_id or x.f_p15 != x.p15 or x.f_p19 != x.p19 then 2 else -1 end ) as p22,
                      x.b041, x.k020, x.p01, e.k112 as p02, x.f_p02, x.f_p02_old, k.nmk as p06 , x.f_p06, x.f_p06_old, nvl(x.adr, k.adr) as p07, x.f_p07, x.f_p07_old,
                      substr(b.benef_name,1,135) as p08, x.f_p08, x.f_p08_old, to_char(b.country_id, 'fm000') as p09, x.f_p09, x.p14, x.p15, x.p16, x.p17, x.p18, x.f_p18,
                      x.p19, x.f_p19, x.p20, x.f_p20, x.p21, x.max_pdat, x.contr_id, x.doc_date,
                      x.f_b041, x.f_k020, x.f_p01, x.f_p14, x.f_p16, x.f_p17, x.f_p21, x.f_p21_new, m.m_p22, x.p27
             from
             ( select x.*, (select substr(b.b040,9,12) from branch b where b.branch=x.branch) as b041,
                      (select nvl2(zip, zip || ', ', '') || case when upper(domain) like '%МІСТО%' and upper(domain) like '%'||upper(locality)||'%' then '' else nvl2(domain, domain || ', ', '') end ||
                              case when upper(region) like '%МІСТО%' and upper(region) like '%'||upper(locality)||'%' then '' else nvl2(region, region || ', ', '') end ||
                              nvl2(locality, locality || ', ', '') || address
                         from customer_address a where a.type_id=1 and a.rnk=x.rnk) as adr,
                      nvl2(x.min_ddat, case when x.p21+1095<l_date_z_end then 4 else 0 end,case when x.p21+1095<l_date_z_end then 1 else 2 end) as p19
                 from
                 ( select min(d.min_ddat) as min_ddat, max(d.max_pdat) as max_pdat, d.p01, d.p14, d.p21, sum(d.p15) as p15, max(d.p20) as p20,
                          c.branch, max(c.rnk) as rnk, c.benef_id, lpad(c.okpo,10,'0') as k020, c.num as p17, c.open_date as p16, min(t.subject_id)+1 as p18,
                          max(f.b041) as f_b041, max(f.p02) as f_p02, max(f.p06) as f_p06, max(f.p07) as f_p07, max(f.p08) as f_p08,
                          max(f.p09) as f_p09, max(f.p15) as f_p15, max(f.p18) as f_p18, max(f.p19) as f_p19, max(f.p20) as f_p20,
                          max(f.p02_old) as f_p02_old, max(f.p06_old) as f_p06_old, max(f.p07_old) as f_p07_old, max(f.p08_old) as f_p08_old,
                          max(d.contr_id) as contr_id, nvl(d.doc_date, f.doc_date) as doc_date, max(f.k020) as f_k020, max(f.p01) as f_p01,
                          max(f.p14) as f_p14, max(f.p16) as f_p16, max(f.p17) as f_p17, max(f.p21) as f_p21, max(f.p21_new) as f_p21_new, max(t.p27_f531) as p27
                     from
                     ( select to_char(max(d.doc_date),'ddmmyyyy') as doc_date, max(d.contr_id) as contr_id, max(d.p14) as p14, max(d.p21) as p21,
                              decode(max(d.d_k), 0, 2, 1) as p01, max(d.p20) as p20, min(case when d.l_doc_date>last_day(d.p21) then d.l_doc_date else null end) as min_ddat,
                              max(l_create_date) as max_pdat, round( (1-nvl(sum(d.ls), 0)/max(d.s_vk))*max(d.s), 0) as p15
                         from
                         ( select d.p14, d.p21, d.p20, d.d_k, d.type_id, d.bound_id, d.contr_id, d.s, d.s_vk, d.doc_date, d.ls, d.l_create_date,
                                  decode(d.d_k, 0, nvl2(d.vmd_id, (select v.dat from customs_decl v join cim_vmd_bound b on v.cim_id=b.vmd_id where b.bound_id=d.vmd_id),
                                                                  (select v.allow_date from cim_acts v join cim_act_bound b on v.act_id=b.act_id where b.bound_id=d.act_id)),
                                                   nvl2(d.payment_id, (select v.vdat from oper v join cim_payments_bound b on v.ref=b.ref where b.bound_id=d.payment_id),
                                                                      (select v.val_date from cim_fantom_payments v join cim_fantoms_bound b on v.fantom_id=b.fantom_id where b.bound_id=d.fantom_id))
                                        ) as l_doc_date
                             from
                             ( select o.kv as p14, cim_mgr.get_control_date(0, 0, d.bound_id, d.pay_flag)+1 as p21, d.borg_reason as p20,
                                      0 as d_k, 0 as type_id, d.bound_id, d.contr_id, (d.s+d.comiss) as s, d.s_cv as s_vk, NVL( (SELECT MAX (fdat) FROM opldok WHERE REF = o.REF ), o.vdat ) as doc_date,
                                      l.s as ls, l.create_date as l_create_date, l.payment_id, l.fantom_id, l.vmd_id, l.act_id
                                 from cim_payments_bound d JOIN oper o ON o.REF = d.REF
                                      left outer join cim_link l on l.delete_date is null and l.create_date<l_date_z_end  and l.payment_id=d.bound_id
                                where d.delete_date is null and
                                      d.contr_id is not null and contr_id != 0
                                  and d.branch like sys_context('bars_context', 'user_mfo_mask')
                               union all
                               select f.kv as p14, cim_mgr.get_control_date(0, f.payment_type, d.bound_id, d.pay_flag)+1 as p21, d.borg_reason as p20,
                                      0 as d_k, f.payment_type as type_id, d.bound_id, d.contr_id, (d.s+d.comiss) as s, d.s_cv as s_vk, f.val_date as doc_date,
                                      l.s as ls, l.create_date as l_create_date, l.payment_id, l.fantom_id, l.vmd_id, l.act_id
                                 from cim_fantoms_bound d JOIN cim_fantom_payments f ON f.fantom_id = d.fantom_id
                                      left outer join cim_link l on l.delete_date is null and l.create_date<l_date_z_end  and l.fantom_id=d.bound_id
                                where d.delete_date is null and
                                       f.payment_type in (1, 4) and d.contr_id is not null and contr_id != 0
                                  and d.branch like sys_context('bars_context', 'user_mfo_mask')
                               union all
                               select v.kv as p14, cim_mgr.get_control_date(1, 0, d.bound_id)+1 as p21, d.borg_reason as p20,
                                      1 as d_k, 0 as type_id, d.bound_id, d.contr_id, d.s_vt as s, d.s_vk, v.allow_dat as doc_date,
                                      l.s as ls, l.create_date as l_create_date, l.payment_id, l.fantom_id, l.vmd_id, l.act_id
                                 from cim_vmd_bound d join customs_decl v on v.cim_id=d.vmd_id
                                      left outer join cim_link l on l.delete_date is null and l.create_date<l_date_z_end  and l.vmd_id=d.bound_id
                                where d.delete_date is null
                                  and d.branch like sys_context('bars_context', 'user_mfo_mask')
                               union all
                               select v.kv as p14, cim_mgr.get_control_date(1, v.act_type, d.bound_id)+1 as p21, d.borg_reason as p20,
                                      1 as d_k, v.act_type as type_id, d.bound_id, d.contr_id, d.s_vt as s, d.s_vk, v.allow_date as doc_date,
                                      l.s as ls, l.create_date as l_create_date, l.payment_id, l.fantom_id, l.vmd_id, l.act_id
                                 from cim_act_bound d join cim_acts v on v.act_type in (1, 3, 4) and v.act_id=d.act_id
                                      left outer join cim_link l on l.delete_date is null and l.create_date<l_date_z_end  and l.act_id=d.bound_id
                                where d.delete_date is null
                                  and d.branch like sys_context('bars_context', 'user_mfo_mask') ) d ) d
                       group by d.d_k, d.type_id, d.bound_id ) d
                     join cim_contracts c on c.contr_type+1=d.p01 and c.contr_id=d.contr_id
                     join cim_contracts_trade t on t.contr_id=d.contr_id
                     full outer join v_cim_f36 f
                       on f.b041 != 0 and f.p01=d.p01 and f.p14=d.p14 and f.doc_date=d.doc_date and nvl(f.p21_new, f.p21)=d.p21 and f.k020=lpad(c.okpo,10,'0') and f.p16=c.open_date and f.p17=c.num and f.branch like sys_context('bars_context', 'user_mfo_mask')
                    where f.p22 is not null or d.p21>=l_date_z_end-3653 and d.p21<l_date_z_end and d.p15>0
                   group by c.benef_id, c.branch, c.okpo, c.num, c.open_date, d.p14, d.p21, d.p01, d.doc_date, f.p01, f.p14, f.p21, f.k020, f.p16, f.p17, f.doc_date) x ) x
             left outer join customer k on k.rnk=x.rnk
             left outer join cim_beneficiaries b on b.benef_id=x.benef_id
             left outer join kl_k110 e on e.d_close is null and e.k110=k.ved
             left outer join ( select 3 as m_p22 from dual union all select 1 as m_p22 from dual ) m
               on x.b041 != x.f_b041 and x.p15>0 and x.f_b041 is not null and x.p15 is not null ) a
              where a.p22>0 )
      order by b041, k020, p17, p08, p16, p21, p01
    )
    loop
      begin
        insert into cim_f36 (b041, k020, doc_date, p01, p02, p06, p07, p08, p09, p13, p14, p15, p16, p17, p18, p19, p20, p21, p21_new, p22, p23, p24, p27, create_date)
                     values (l.b041, l.k020, l.doc_date, l.p01, l.p02, l.p06, l.p07, l.p08, l.p09, l.p13, l.p14, l.p15, l.p16, l.p17, l.p18,
                             l.p19, l.p20, l.p21, l.p21_new, l.p22, l.p23, l.p24, l.p27, l_date_z_end);
      --COBUMMFO-9323
      exception
        when dup_val_on_index then
          update cim_f36 f36
             set f36.p02 = l.p02,
                 f36.p06 = l.p06,
                 f36.p07 = l.p07,
                 f36.p08 = l.p08,
                 f36.p09 = l.p09,
                 f36.p13 = l.p13,
                 f36.p15 = l.p15,
                 f36.p18 = l.p18,
                 f36.p19 = l.p19,
                 f36.p20 = l.p20,
                 f36.p21_new = l.p21_new,
                 f36.p22 = l.p22,
                 f36.p23 = l.p23,
                 f36.p24 = l.p24,
                 f36.p27 = l.p27
           where f36.BRANCH = sys_context('bars_context', 'user_branch')
             and f36.B041 = l.b041
             and f36.K020 = l.k020
             and f36.P17 = l.p17
             and f36.P16 = l.p16
             and f36.DOC_DATE = l.doc_date
             and f36.P21 = l.p21
             and f36.P14 = l.p14
             and f36.P01 = l.p01
             and f36.CREATE_DATE = l_date_z_end;
      ----
      end;
    end loop;
    commit;
  elsif l_date_z_end>l_last_date then
--    (l_date_z_end<l_last_date or l_last_date=l_date_z_end and to_char(l_sysdate,'mmyyyy')=to_char(l_last_date,'mmyyyy') and to_number(to_char(l_sysdate,'dd'))>7) and to_char(p_date,'yyyymm') != '201505' ) then
    p_error:='Формування звіту #36 за '||to_char(l_date_z_end,'dd.mm.yyyy')||'р. неможливе! Дата останнього сформованого звіту #36 - '||to_char(l_last_date,'dd.mm.yyyy')||'р.'; return '';
  end if;

  for l in
  ( select f.b041, f.k020, f.p01, f.p02, f.p06, f.p07, f.p08, f.p09, f.p13, f.p14, f.p15, f.p16, f.p17, f.p18, f.p19, f.p20, f.p21, f.p22, f.p23, f.p24, f.doc_date, f.p27
      from cim_f36 f
           /* join
           ( select k020, p16, p17, p08, row_number() over ( partition by k020, p16, p17 order by p08) as p27, count (p08) over ( partition by k020, p16, p17 ) as n_p27
               from
               ( select distinct k020, p16, p17, p08
                   from cim_f36 where b041 != 0 and create_date=l_date_z_end group by k020, p16, p17, p08 ) ) a
           on a.k020=F.K020 and a.p16=f.p16 and a.p17=f.p17 and a.p08=f.p08 */
     where f.b041 != 0 and f.create_date=l_date_z_end
       and f.branch like sys_context('bars_context', 'user_mfo_mask')
     order by f.b041, f.k020, f.p16, f.p17, f.p08, f.p21, f.p01 )
  loop
    if l_okpo != l.k020 or l_contr_date != l.p16 or l_contr_num != l.p17 then
    /*  if l.p27=1 then
        if l.p17=l_contr_num and l.p08 != l_benef_name and l_p22=l.p22 then l_p27:=l_p27+1; else l_p27:=1; end if;
      end if;*/
      l_okpo:=l.k020; l_contr_date:=l.p16; l_contr_num:= l.p17; l_n_contr:=l_n_contr+1;  l_p22:=l.p22;
    elsif l_last_p21=l.p21 then
      l_n_contr:=l_n_contr+1;
    end if;
    l_txt:=''; l_n:=l_n+16; l_last_p21:=l.p21;
    if l_b041 != l.b041 then
      l_b041:=l.b041; l_txt:='#1='||l_oblcode||'='||l_b041||chr(13)||chr(10);
    end if;
    l_txt:=l_txt||'01'||l.k020||to_char(l_n_contr,'fm0000')||l.doc_date||'='||l.p01||chr(13)||chr(10);
    l_txt:=l_txt||'02'||l.k020||to_char(l_n_contr,'fm0000')||l.doc_date||'='||l.p02||chr(13)||chr(10);
    l_txt:=l_txt||'06'||l.k020||to_char(l_n_contr,'fm0000')||l.doc_date||'='||translatewin2dos(l.p06)||chr(13)||chr(10);
    l_txt:=l_txt||'07'||l.k020||to_char(l_n_contr,'fm0000')||l.doc_date||'='||translatewin2dos(l.p07)||chr(13)||chr(10);
    l_txt:=l_txt||'08'||l.k020||to_char(l_n_contr,'fm0000')||l.doc_date||'='||translatewin2dos(l.p08)||chr(13)||chr(10);
    l_txt:=l_txt||'09'||l.k020||to_char(l_n_contr,'fm0000')||l.doc_date||'='||l.p09||chr(13)||chr(10);
    l_txt:=l_txt||'13'||l.k020||to_char(l_n_contr,'fm0000')||l.doc_date||'='||l.p13||chr(13)||chr(10);
    l_txt:=l_txt||'14'||l.k020||to_char(l_n_contr,'fm0000')||l.doc_date||'='||l.p14||chr(13)||chr(10);
    l_txt:=l_txt||'15'||l.k020||to_char(l_n_contr,'fm0000')||l.doc_date||'='||l.p15||chr(13)||chr(10);
    l_txt:=l_txt||'16'||l.k020||to_char(l_n_contr,'fm0000')||l.doc_date||'='||to_char(l.p16,'ddmmyyyy')||chr(13)||chr(10);
    l_txt:=l_txt||'17'||l.k020||to_char(l_n_contr,'fm0000')||l.doc_date||'='||translatewin2dos(l.p17)||chr(13)||chr(10);
    l_txt:=l_txt||'18'||l.k020||to_char(l_n_contr,'fm0000')||l.doc_date||'='||l.p18||chr(13)||chr(10);
    l_txt:=l_txt||'19'||l.k020||to_char(l_n_contr,'fm0000')||l.doc_date||'='||l.p19||chr(13)||chr(10);
    l_txt:=l_txt||'20'||l.k020||to_char(l_n_contr,'fm0000')||l.doc_date||'='||l.p20||chr(13)||chr(10);
    l_txt:=l_txt||'21'||l.k020||to_char(l_n_contr,'fm0000')||l.doc_date||'='||to_char(l.p21,'ddmmyyyy')||chr(13)||chr(10);
    l_txt:=l_txt||'22'||l.k020||to_char(l_n_contr,'fm0000')||l.doc_date||'='||l.p22||chr(13)||chr(10);
    case l.p22
      when 2 then
        l_txt:=l_txt||'23'||l.k020||to_char(l_n_contr,'fm0000')||l.doc_date||'='||to_char(l.p23,'ddmmyyyy')||chr(13)||chr(10);
        l_n:=l_n+1;
      when 3 then
        l_txt:=l_txt||'24'||l.k020||to_char(l_n_contr,'fm0000')||l.doc_date||'='||nvl(to_char(l.p24, 'ddmmyyyy'),'????????')||chr(13)||chr(10); l_n:=l_n+1;
      else null;
    end case;
    if l.p27>0 and l.p27 is not null then
      l_txt:=l_txt||'27'||l.k020||to_char(l_n_contr,'fm0000')||l.doc_date||'='||l.p27||chr(13)||chr(10); l_n:=l_n+1;
    end if;
    dbms_lob.append(l_txt_clob, l_txt);
  end loop;

  l_txt:=lpad(' ',100,' ')||chr(13)||chr(10)||
    rpad('05='||to_char(l_date_z_end,'DDMMYYYY')||'='||to_char(last_day(add_months(p_date,-2))+1,'DDMMYYYY')||'='||to_char(l_date_z_end-1,'DDMMYYYY')
         ||'='||to_char(l_sysdate,'DDMMYYYY=HH24MM')||'=300465=21='||to_char(l_n,'fm000000000')||'='||l_filename||'= IDKEY=',148,' ')||chr(13)||chr(10);
  if l_n=0 then
    begin
      select substr(b.b040,9,12) into l_b041 from branch b where b.branch='/'||f_ourmfo||'/';
      exception
        when NO_DATA_FOUND then
          p_error := 'Не існує інформації в довіднику підрозділів для '||'/'||f_ourmfo||'/';
    end;
    l_txt:=l_txt||'#1='||l_oblcode||'='||l_b041||chr(13)||chr(10);
  end if;
  dbms_lob.createtemporary(l_result, false); dbms_lob.append(l_result, l_txt); dbms_lob.append(l_result, l_txt_clob);
  return l_result;
end  p_f531;

  --текст для збереження в файл
  procedure get_text_file_f503(p_clob out clob, p_namefile out varchar2)
    as
    l_sysdate          date;
    l_txt              varchar2(4000);
    l_txt_clob         clob;
    l_p_date           varchar2(8) := pul.get_mas_ini_val('cim_p_date');--DDMMYYYY
    --l_date_z_begin     date;
    l_date_z_end       date;
    l_znyvt            varchar2(28); --ZZZZZZZZZZNNNNNYYYYYYYYVVVT
    l_n                number:=0; --Кількість стрічок
    l_oblcode          varchar2(2);

    l_2039             number;
    l_2025             number;
    l_2040             number;
    l_2041             number;
    l_2043             number;
    l_2044             number;
    l_2045             number;

    l_kod char(1) := 'B'; --Якщо вказано невірно то при імпорті в сторонне ПО може виникати : Код схеми надання не відповідає літері F в назві файлу. Має корилювати з першими двума цифрами в заголовку в самому файлі;
  begin
    l_sysdate := sysdate;
    --l_date_z_begin := to_date('01/01/'||to_char(add_months(to_date(l_p_date,'DDMMYYYY'),-1),'YYYY'),'DD/MM/YYYY');
    l_date_z_end   := last_day(add_months(to_date(l_p_date,'DDMMYYYY'),-1));

    select nvl(par_value,'XXX') into p_namefile from cim_params where par_name='EL_COD_OBL'; --!!!
    p_namefile:='#6A'||p_namefile||num_code(to_number(to_char(l_sysdate,'MM')))
                     ||num_code(to_number(to_char(l_sysdate,'DD')))||'.'||l_kod||num_code(to_number(substr(l_p_date,3,2)))||'1';

    dbms_lob.createtemporary(l_txt_clob, false);
    for cur in (select * from cim_f503 c where c.branch like sys_context('bars_context','user_mfo_mask'))
    loop
      l_znyvt := lpad(cur.z,10,'0')||lpad(cur.r_agree_no,5,'0')
                 ||case when cur.p1200 is null then '00000000' else to_char(cur.p1200,'DDMMYYYY') end
                 ||lpad(cur.pval,3,'0')||cur.t
                 ||'=';


      if cur.p0400=2 then
        l_txt:=l_txt
          ||cur.m||'0700'||l_znyvt||to_char(cur.p0700, 'fm99990.0000')||chr(13)||chr(10)
          ||cur.m||'0800'||l_znyvt||cur.p0800_1||' '||cur.p0800_2||' '||cur.p0800_3||chr(13)||chr(10);
        l_n:=l_n+2;
      end if;

      l_txt:=l_txt
        ||cur.m||'0200'||l_znyvt||cur.p0200||chr(13)||chr(10)
        ||cur.m||'0300'||l_znyvt||cur.p0300||chr(13)||chr(10)

        ||cur.m||'0400'||l_znyvt||cur.p0400||chr(13)||chr(10)
        ||cur.m||'0500'||l_znyvt||translatewin2dos(cur.p0500)||chr(13)||chr(10)
        ||cur.m||'0600'||l_znyvt||to_char(cur.p0600,'DDMMYYYY')||chr(13)||chr(10)
        ||cur.m||'0900'||l_znyvt||to_char(cur.p0900, 'fm9999999999999990')||chr(13)||chr(10)

        ||cur.m||'1000'||l_znyvt||translatewin2dos(cur.p1000)||chr(13)||chr(10)
        ||cur.m||'1200'||l_znyvt||to_char(cur.p1200,'DDMMYYYY')||chr(13)||chr(10)
        ||cur.m||'1300'||l_znyvt||translatewin2dos(cur.p1300)||chr(13)||chr(10)
        ||cur.m||'1400'||l_znyvt||cur.p1400||chr(13)||chr(10)
        ||cur.m||'0100'||l_znyvt||num_code(cur.p0100)||chr(13)||chr(10)
        ||cur.m||'1500'||l_znyvt||cur.p1500||chr(13)||chr(10)
        ||cur.m||'1600'||l_znyvt||cur.p1600||chr(13)||chr(10)
        ||cur.m||'1700'||l_znyvt||cur.p1700||chr(13)||chr(10)
        ||cur.m||'1800'||l_znyvt||cur.p1800||chr(13)||chr(10)
        ||cur.m||'1900'||l_znyvt||cur.p1900||chr(13)||chr(10);
      l_n:=l_n+2+4+10;

      if nvl(cur.p2010,0)!=0 then l_txt:=l_txt||cur.m||'2010'||l_znyvt||to_char(cur.p2010,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if nvl(cur.p2011,0)!=0 then l_txt:=l_txt||cur.m||'2011'||l_znyvt||to_char(cur.p2011,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if nvl(cur.p2012,0)!=0 then l_txt:=l_txt||cur.m||'2012'||l_znyvt||to_char(cur.p2012,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if nvl(cur.p2013,0)!=0 then l_txt:=l_txt||cur.m||'2013'||l_znyvt||to_char(abs(cur.p2013),'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if nvl(cur.p2014,0)!=0 then l_txt:=l_txt||cur.m||'2014'||l_znyvt||to_char(abs(cur.p2014),'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;

      l_2039 := nvl(cur.p2010,0) + nvl(cur.p2012,0) + nvl(cur.p2013,0) + nvl(cur.p2014,0);
      if l_2039!=0 then l_txt:=l_txt||cur.m||'2039'||l_znyvt||to_char(l_2039,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;

      if nvl(cur.p2016,0)!=0 then l_txt:=l_txt||cur.m||'2016'||l_znyvt||to_char(cur.p2016,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if nvl(cur.p2017,0)!=0 then l_txt:=l_txt||cur.m||'2017'||l_znyvt||to_char(cur.p2017,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if nvl(cur.p2018,0)!=0 then l_txt:=l_txt||cur.m||'2018'||l_znyvt||to_char(cur.p2018,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if nvl(cur.p2020,0)!=0 then l_txt:=l_txt||cur.m||'2020'||l_znyvt||to_char(cur.p2020,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if nvl(cur.p2021,0)!=0 then l_txt:=l_txt||cur.m||'2021'||l_znyvt||to_char(cur.p2021,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if nvl(cur.p2022,0)!=0 then l_txt:=l_txt||cur.m||'2022'||l_znyvt||to_char(cur.p2022,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if nvl(cur.p2023,0)!=0 then l_txt:=l_txt||cur.m||'2023'||l_znyvt||to_char(cur.p2023,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if nvl(cur.p2024,0)!=0 then l_txt:=l_txt||cur.m||'2024'||l_znyvt||to_char(cur.p2024,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;

      l_2025 := nvl(cur.p2026,0) + nvl(cur.p2027,0) + nvl(cur.p2028,0);
      if l_2025!=0 then l_txt:=l_txt||cur.m||'2025'||l_znyvt||to_char(l_2025,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;

      if nvl(cur.p2026,0)!=0 then l_txt:=l_txt||cur.m||'2026'||l_znyvt||to_char(cur.p2026,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if nvl(cur.p2027,0)!=0 then l_txt:=l_txt||cur.m||'2027'||l_znyvt||to_char(cur.p2027,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if nvl(cur.p2028,0)!=0 then l_txt:=l_txt||cur.m||'2028'||l_znyvt||to_char(cur.p2028,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if nvl(cur.p2029,0) < nvl(cur.p2030,0) + nvl(cur.p2031,0) then
        null;--повинна бути помилка: «П.13<п.13.1+п.13.2; Дані за кредитом не прийнято!  » (наразі подавляеться на вебі)
      end if;
      if nvl(cur.p2029,0)!=0 then l_txt:=l_txt||cur.m||'2029'||l_znyvt||to_char(cur.p2029,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if nvl(cur.p2030,0)!=0 then l_txt:=l_txt||cur.m||'2030'||l_znyvt||to_char(cur.p2030,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if nvl(cur.p2031,0)!=0 then l_txt:=l_txt||cur.m||'2031'||l_znyvt||to_char(cur.p2031,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if nvl(cur.p2032,0) != nvl(cur.p2033,0) + nvl(cur.p2034,0) + nvl(cur.p2035,0) then
        null;--повинна бути помилка: «П.14#п.14.1+п.14.2+п.14.3 ; Дані за кредитом не прийнято!  » (наразі подавляеться на вебі)
      end if;
      if nvl(cur.p2032,0)!=0 then l_txt:=l_txt||cur.m||'2032'||l_znyvt||to_char(cur.p2032,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if nvl(cur.p2033,0)!=0 then l_txt:=l_txt||cur.m||'2033'||l_znyvt||to_char(cur.p2033,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if nvl(cur.p2034,0)!=0 then l_txt:=l_txt||cur.m||'2034'||l_znyvt||to_char(cur.p2034,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if nvl(cur.p2035,0)!=0 then l_txt:=l_txt||cur.m||'2035'||l_znyvt||to_char(cur.p2035,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;

      if nvl(cur.p2036,0)!=0 then l_txt:=l_txt||cur.m||'2036'||l_znyvt||to_char(cur.p2036,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if nvl(cur.p2037,0)!=0 then l_txt:=l_txt||cur.m||'2037'||l_znyvt||to_char(cur.p2037,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;

      l_2040 := nvl(cur.p2022,0)+nvl(cur.p2025,0)+nvl(cur.p2029,0)+nvl(cur.p2032,0)+nvl(cur.p2036,0)+nvl(cur.p2037,0);
      if l_2040!=0 then l_txt:=l_txt||cur.m||'2040'||l_znyvt||to_char(l_2040,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;

      l_2041 := nvl(cur.p2010,0)+nvl(cur.p2016,0)-nvl(cur.p2022,0)-nvl(cur.p2025,0);
      if l_2041!=0 then l_txt:=l_txt||cur.m||'2041'||l_znyvt||to_char(l_2041,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;

      if nvl(cur.p2038,0)!=0 then l_txt:=l_txt||cur.m||'2038'||l_znyvt||to_char(cur.p2038,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;
      if nvl(cur.p2042,0)!=0 then l_txt:=l_txt||cur.m||'2042'||l_znyvt||to_char(cur.p2042,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;

      l_2043 := nvl(cur.p2013,0) + nvl(cur.p2020,0) - nvl(cur.p2036,0);
      if l_2043!=0 then l_txt:=l_txt||cur.m||'2043'||l_znyvt||to_char(l_2043,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;

      l_2044 := nvl(cur.p2014,0) + nvl(cur.p2021,0) - nvl(cur.p2037,0);
      if l_2044!=0 then l_txt:=l_txt||cur.m||'2044'||l_znyvt||to_char(l_2044,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;

      l_2045 := l_2041 + nvl(cur.p2042,0) + l_2043 + l_2044;
      if l_2045!=0 then l_txt:=l_txt||cur.m||'2045'||l_znyvt||to_char(l_2045,'fm9999999999999999')||chr(13)||chr(10); l_n:=l_n+1; end if;

      l_txt:=l_txt||cur.m||'9500'||l_znyvt||to_char(cur.p9500, 'fm990.000')||chr(13)||chr(10); l_n:=l_n+1;

      if cur.p9600 is not null then
        l_txt:=l_txt||cur.m||'9600'||l_znyvt||to_char(cur.p9600,'fm99')||chr(13)||chr(10); l_n:=l_n+1;
      end if;


      l_txt:=l_txt||cur.m||'3100'||l_znyvt||to_char(cur.p3100,'DDMMYYYY')||chr(13)||chr(10); l_n:=l_n+1;
      l_txt:=l_txt||cur.m||'9800'||l_znyvt||cur.p9800||chr(13)||chr(10); l_n:=l_n+1;
      if cur.p9900 is not null then l_txt:=l_txt||cur.m||'9900'||l_znyvt||translatewin2dos(cur.p9900)||chr(13)||chr(10); l_n:=l_n+1; end if;
      l_txt:=l_txt||cur.m||'3000'||l_znyvt||cur.p3000||chr(13)||chr(10); l_n:=l_n+1;
      l_txt:=l_txt||cur.m||'3200'||l_znyvt||cur.p3200||chr(13)||chr(10); l_n:=l_n+1;
      l_txt:=l_txt||cur.m||'3300'||l_znyvt||lpad(cur.p3300,3,'0')||chr(13)||chr(10); l_n:=l_n+1;

      dbms_lob.append(l_txt_clob, l_txt); l_txt:=null;

    end loop;

    select nvl(par_value,'XX') into l_oblcode from bars.cim_params where par_name='OBL_CODE';
    select nvl2(b040, substr(b040, length(b040)-11, 12), 'XXXXXXXXXXXX') into l_txt from branch where branch='/'||f_ourmfo||'/';
    l_txt:=lpad(' ',100,' ')||chr(13)||chr(10)||
    rpad('02=01'||substr(l_p_date,3)||'=01'||to_char(l_date_z_end,'MMYYYY')||'='||to_char(l_date_z_end,'DDMMYYYY')
         ||'='||to_char(l_sysdate,'DDMMYYYY')||'='||to_char(l_sysdate,'HH24MM')||'='||to_char(gl.amfo,'fm000000')||'=12='
         ||to_char(l_n,'fm000000000')||'='||p_namefile||'= IDKEY=',148,' ')||chr(13)||chr(10)
         ||'#1='||l_oblcode||'='||l_txt||chr(13)||chr(10);
    dbms_lob.createtemporary(p_clob, false);
    dbms_lob.append(p_clob, l_txt);
    dbms_lob.append(p_clob, l_txt_clob);

  end;

  --текст для збереження в файл
  procedure get_text_file_f504(p_clob out clob, p_namefile out varchar2)
    as
    l_sysdate          date;
    l_txt              varchar2(4000);
    l_txt_clob         clob;
    l_p_date           varchar2(8) := pul.get_mas_ini_val('cim_p_date');--DDMMYYYY
    --l_client_sess_id   varchar2(64):= bars_login.get_session_clientid;
    l_date_z_begin     date;
    l_zn0yvt           varchar2(33); --ZZZZZZZZZZNNNNN00000YYYYYYYYVVVT=
    l_zn               varchar2(15); --ZZZZZZZZZZNNNNN
    l_yvt              varchar2(13); --YYYYYYYYVVVT=
    l_n                number:=0; --Кількість стрічок
    l_oblcode          varchar2(2);
    l_rw               varchar2(5);
    l_88888            number;
    l_yyyy             number := to_number(substr(l_p_date, 5)); --to_number(to_char(bankdate, 'YYYY'));

    type t_rrrr0 is table of pls_integer index by varchar2(5);
    l_rrrr0            t_rrrr0;
    l_indx_rrrrw       varchar2(5);

    l_kod char(1) := 'B'; --Якщо вказано невірно то при імпорті в сторонне ПО може виникати : Код схеми надання не відповідає літері F в назві файлу. Має корилювати з першими двума цифрами в заголовку в самому файлі;

    function rrrrw(p_rrrr varchar2, p_w varchar2) return varchar2 is
      l_rrrrw varchar2(5);
    begin
      if to_number(p_rrrr) between l_yyyy+2 and l_yyyy+9 then
        l_rrrrw := p_rrrr||'0';
        elsif to_number(p_rrrr) >= l_yyyy+10 then
          l_rrrrw := '88888';
        else l_rrrrw := p_rrrr||translatewin2dos(p_w);
      end if;

      return l_rrrrw;
    end;

  begin
    l_sysdate := sysdate;
    --l_date_z_begin := to_date('01/01/'||to_char(add_months(to_date(l_p_date,'DDMMYYYY'),-1),'YYYY'),'DD/MM/YYYY');
    l_date_z_begin := last_day(add_months(to_date(l_p_date,'DDMMYYYY'),-1))+1;

    select nvl(par_value,'XXX') into p_namefile from cim_params where  par_name='EL_COD_OBL';
    p_namefile:='#35'||p_namefile||num_code(to_number(to_char(l_sysdate,'MM')))
                     ||num_code(to_number(to_char(l_sysdate,'DD')))||'.'||l_kod||num_code(to_number(substr(l_p_date,3,2)))||'1';

    dbms_lob.createtemporary(l_txt_clob, false);
    for cur in (select * from cim_f504 c where c.branch like sys_context('bars_context','user_mfo_mask'))
    loop
      l_zn0yvt := lpad(cur.z,10,'0')||lpad(cur.r_agree_no,5,'0')
                 ||'00000'
                 ||case when cur.p103 is null then '00000000' else to_char(cur.p103,'DDMMYYYY') end
                 ||lpad(cur.pval,3,'0')||cur.t
                 ||'=';
      l_zn  := lpad(cur.z,10,'0')||lpad(cur.r_agree_no,5,'0');
      l_yvt := case when cur.p103 is null then '00000000' else to_char(cur.p103,'DDMMYYYY') end
                 ||lpad(cur.pval,3,'0')||cur.t
                 ||'=';

      l_txt:=cur.m||'050'||l_zn0yvt||translatewin2dos(cur.p050)||chr(13)||chr(10)
           ||cur.m||'060'||l_zn0yvt||to_char(cur.p060,'DDMMYYYY')||chr(13)||chr(10)
           ||cur.m||'090'||l_zn0yvt||cur.p090||chr(13)||chr(10)
           ||cur.m||'101'||l_zn0yvt||translatewin2dos(cur.p101)||chr(13)||chr(10)
           ||cur.m||'103'||l_zn0yvt||to_char(cur.p103,'DDMMYYYY')||chr(13)||chr(10)
           ||cur.m||'107'||l_zn0yvt||translatewin2dos(cur.p107)||chr(13)||chr(10)

           ||cur.m||'010'||l_zn0yvt||num_code(cur.p010)||chr(13)||chr(10)

           ||cur.m||'108'||l_zn0yvt||cur.p108||chr(13)||chr(10)
           ||cur.m||'140'||l_zn0yvt||cur.p140||chr(13)||chr(10)
           ||cur.m||'141'||l_zn0yvt||cur.p141||chr(13)||chr(10)
           ||cur.m||'142'||l_zn0yvt||cur.p142||chr(13)||chr(10)
           ||cur.m||'143'||l_zn0yvt||cur.p143||chr(13)||chr(10)
           ||cur.m||'184'||l_zn0yvt||cur.p184||chr(13)||chr(10)
           ||cur.m||'020'||l_zn0yvt||cur.p020||chr(13)||chr(10)
           ||cur.m||'310'||l_zn0yvt||to_char(cur.p310,'DDMMYYYY')||chr(13)||chr(10)

           ||cur.m||'320'||l_zn0yvt||cur.p320||chr(13)||chr(10)

           ||cur.m||'040'||l_zn0yvt||cur.p040||chr(13)||chr(10)

           ||cur.m||'330'||l_zn0yvt||lpad(cur.p330,3,'0')||chr(13)||chr(10)
           ||cur.m||'080'||l_zn0yvt||cur.p080||chr(13)||chr(10)
           ||cur.m||'070'||l_zn0yvt||cur.p070||chr(13)||chr(10)
           ||cur.m||'950'||l_zn0yvt||cur.p950||chr(13)||chr(10)

           ||cur.m||'030'||l_zn0yvt||cur.p030||chr(13)||chr(10)
           ;
       l_n:=l_n+8+1+6+1+1+4+1;

      if cur.p960 is not null then
         l_txt:=l_txt||cur.m||'960'||l_zn0yvt||to_char(cur.p960,'fm99')||chr(13)||chr(10); l_n:=l_n+1;
      end if;


       if cur.p999 is not null then l_txt:=l_txt||cur.m||'999'||l_zn0yvt||translatewin2dos(cur.p999)||chr(13)||chr(10); l_n:=l_n+1; end if;

       --д). якщо користувач вибирає з таблиці «рік» 10-й та подальші роки, наступні за поточним (наприклад: 2016 - поточний рік, тоді 2025р. - 10-й рік, 2026р. - 11-й рік і т.д.) в файлі #35
       --сегмент RRRRW  приймає значення 88888, при цьому суми в рядку «Значення» форми №504 по таким рокам сумуються,
       --а в файлі #35 подаються загальними сумами за показниками 212, 213, 201, 222, 223, 292, 293.
       --
       --Якщо користувач вибирає з таблиці «рік» один з 8-ми (восьми) років які слідують за наступним після поточного року (наприклад: 2016 поточний рік, а 2017 наступний за поточним рік, тоді такі роки з 2018р. по 2025р.) та вибирає з таблиці «місяць» декілька місяців, то при транформуванні даних в файл #35 так:
       ---  сегмент W приймає значення 0;
       ---  суми в рядку «Значення» форми №504 по таким місяцям сумуються, а в файлі #35 подаються загальною сумою.
       --По вищевикладеним умовам здійснюється трансформації за показниками: 212, 213, 201, 222, 223, 292, 293.

       l_88888 := 0;
       l_rrrr0.delete;
       for cur_detail in (select * from cim_f504_detail2 d
                         where d.f504_id = cur.f504_id
                           and d.indicator_id = 212)
       loop
         l_rw := rrrrw(cur_detail.rrrr,cur_detail.w);

         case
           when l_rw = '88888' then l_88888 := l_88888 + cur_detail.val;
           when substr(l_rw, 5, 1) = '0' then
                                          if l_rrrr0.exists(l_rw) then
                                            l_rrrr0(l_rw) := l_rrrr0(l_rw) + cur_detail.val;
                                            else
                                              l_rrrr0(l_rw) := cur_detail.val;
                                          end if;
           else
             l_txt:=l_txt||cur.m||'212'||l_zn||l_rw||l_yvt||cur_detail.val||chr(13)||chr(10); l_n:=l_n+1;
         end case;
       end loop;
       l_indx_rrrrw := l_rrrr0.FIRST;
       if l_indx_rrrrw is not null then
          loop
            l_txt:=l_txt||cur.m||'212'||l_zn||l_indx_rrrrw||l_yvt||l_rrrr0(l_indx_rrrrw)||chr(13)||chr(10); l_n:=l_n+1;
            l_indx_rrrrw := l_rrrr0.next(l_indx_rrrrw);
            EXIT WHEN l_indx_rrrrw IS NULL;
          end loop;
       end if;
       if l_88888 > 0 then
         l_txt:=l_txt||cur.m||'212'||l_zn||'88888'||l_yvt||l_88888||chr(13)||chr(10); l_n:=l_n+1;
       end if;

       l_88888 := 0;
       l_rrrr0.delete;
       for cur_detail in (select * from cim_f504_detail2 d
                         where d.f504_id = cur.f504_id
                           and d.indicator_id = 213)
       loop
         l_rw := rrrrw(cur_detail.rrrr,cur_detail.w);

         case
           when l_rw = '88888' then l_88888 := l_88888 + cur_detail.val;
           when substr(l_rw, 5, 1) = '0' then
                                          if l_rrrr0.exists(l_rw) then
                                            l_rrrr0(l_rw) := l_rrrr0(l_rw) + cur_detail.val;
                                            else
                                              l_rrrr0(l_rw) := cur_detail.val;
                                          end if;

           else
             l_txt:=l_txt||cur.m||'213'||l_zn||l_rw||l_yvt||cur_detail.val||chr(13)||chr(10); l_n:=l_n+1;
         end case;
       end loop;
       l_indx_rrrrw := l_rrrr0.FIRST;
       if l_indx_rrrrw is not null then
          loop
            l_txt:=l_txt||cur.m||'213'||l_zn||l_indx_rrrrw||l_yvt||l_rrrr0(l_indx_rrrrw)||chr(13)||chr(10); l_n:=l_n+1;
            l_indx_rrrrw := l_rrrr0.next(l_indx_rrrrw);
            EXIT WHEN l_indx_rrrrw IS NULL;
          end loop;
       end if;
       if l_88888 > 0 then
         l_txt:=l_txt||cur.m||'213'||l_zn||'88888'||l_yvt||l_88888||chr(13)||chr(10); l_n:=l_n+1;
       end if;
      /* COBUSUPABS-6031
       l_88888 := 0;
       l_rrrr0.delete;
       for cur_detail in (select * from cim_f504_detail d
                         where d.f504_id = cur.f504_id
                           and d.indicator_id = 201)
       loop
         if cur_detail.noprognosis = 1 then
           l_txt:=l_txt||cur.m||'201'||l_zn||'99999'||l_yvt||cur_detail.val||chr(13)||chr(10); l_n:=l_n+1;
           else
             l_rw := rrrrw(cur_detail.rrrr,cur_detail.w);
             case
               when l_rw = '88888' then l_88888 := l_88888 + cur_detail.val;
               when substr(l_rw, 5, 1) = '0' then
                                              if l_rrrr0.exists(l_rw) then
                                                l_rrrr0(l_rw) := l_rrrr0(l_rw) + cur_detail.val;
                                                else
                                                  l_rrrr0(l_rw) := cur_detail.val;
                                              end if;
               else
                 l_txt:=l_txt||cur.m||'201'||l_zn||l_rw||l_yvt||cur_detail.val||chr(13)||chr(10); l_n:=l_n+1;
             end case;
         end if;

       end loop;
       l_indx_rrrrw := l_rrrr0.FIRST;
       if l_indx_rrrrw is not null then
          loop
            l_txt:=l_txt||cur.m||'201'||l_zn||l_indx_rrrrw||l_yvt||l_rrrr0(l_indx_rrrrw)||chr(13)||chr(10); l_n:=l_n+1;
            l_indx_rrrrw := l_rrrr0.next(l_indx_rrrrw);
            EXIT WHEN l_indx_rrrrw IS NULL;
          end loop;
       end if;
       if l_88888 > 0 then
         l_txt:=l_txt||cur.m||'201'||l_zn||'88888'||l_yvt||l_88888||chr(13)||chr(10); l_n:=l_n+1;
       end if;

       l_88888 := 0;
       l_rrrr0.delete;
       for cur_detail in (select * from cim_f504_detail2 d
                         where d.f504_id = cur.f504_id
                           and d.indicator_id = 222)
       loop
         l_rw := rrrrw(cur_detail.rrrr,cur_detail.w);

         case
           when l_rw = '88888' then l_88888 := l_88888 + cur_detail.val;
           when substr(l_rw, 5, 1) = '0' then
                                          if l_rrrr0.exists(l_rw) then
                                            l_rrrr0(l_rw) := l_rrrr0(l_rw) + cur_detail.val;
                                            else
                                              l_rrrr0(l_rw) := cur_detail.val;
                                          end if;

           else
             l_txt:=l_txt||cur.m||'222'||l_zn||l_rw||l_yvt||cur_detail.val||chr(13)||chr(10); l_n:=l_n+1;
         end case;
       end loop;
       l_indx_rrrrw := l_rrrr0.FIRST;
       if l_indx_rrrrw is not null then
          loop
            l_txt:=l_txt||cur.m||'222'||l_zn||l_indx_rrrrw||l_yvt||l_rrrr0(l_indx_rrrrw)||chr(13)||chr(10); l_n:=l_n+1;
            l_indx_rrrrw := l_rrrr0.next(l_indx_rrrrw);
            EXIT WHEN l_indx_rrrrw IS NULL;
          end loop;
       end if;
       if l_88888 > 0 then
         l_txt:=l_txt||cur.m||'222'||l_zn||'88888'||l_yvt||l_88888||chr(13)||chr(10); l_n:=l_n+1;
       end if;

       l_88888 := 0;
       l_rrrr0.delete;
       for cur_detail in (select * from cim_f504_detail2 d
                         where d.f504_id = cur.f504_id
                           and d.indicator_id = 223)
       loop
         l_rw := rrrrw(cur_detail.rrrr,cur_detail.w);

         case
           when l_rw = '88888' then l_88888 := l_88888 + cur_detail.val;
           when substr(l_rw, 5, 1) = '0' then
                                          if l_rrrr0.exists(l_rw) then
                                            l_rrrr0(l_rw) := l_rrrr0(l_rw) + cur_detail.val;
                                            else
                                              l_rrrr0(l_rw) := cur_detail.val;
                                          end if;

           else
             l_txt:=l_txt||cur.m||'223'||l_zn||l_rw||l_yvt||cur_detail.val||chr(13)||chr(10); l_n:=l_n+1;
         end case;
       end loop;
       l_indx_rrrrw := l_rrrr0.FIRST;
       if l_indx_rrrrw is not null then
          loop
            l_txt:=l_txt||cur.m||'223'||l_zn||l_indx_rrrrw||l_yvt||l_rrrr0(l_indx_rrrrw)||chr(13)||chr(10); l_n:=l_n+1;
            l_indx_rrrrw := l_rrrr0.next(l_indx_rrrrw);
            EXIT WHEN l_indx_rrrrw IS NULL;
          end loop;
       end if;
       if l_88888 > 0 then
         l_txt:=l_txt||cur.m||'223'||l_zn||'88888'||l_yvt||l_88888||chr(13)||chr(10); l_n:=l_n+1;
       end if;
       */
       l_88888 := 0;
       l_rrrr0.delete;
       for cur_detail in (select * from cim_f504_detail d
                         where d.f504_id = cur.f504_id
                           and d.indicator_id = 292)
       loop
         if cur_detail.noprognosis = 1 then
           l_txt:=l_txt||cur.m||'292'||l_zn||'99999'||l_yvt||cur_detail.val||chr(13)||chr(10); l_n:=l_n+1;
           else
             l_rw := rrrrw(cur_detail.rrrr,cur_detail.w);
             case
               when l_rw = '88888' then l_88888 := l_88888 + cur_detail.val;
               when substr(l_rw, 5, 1) = '0' then
                                          if l_rrrr0.exists(l_rw) then
                                            l_rrrr0(l_rw) := l_rrrr0(l_rw) + cur_detail.val;
                                            else
                                              l_rrrr0(l_rw) := cur_detail.val;
                                          end if;

               else
                 l_txt:=l_txt||cur.m||'292'||l_zn||l_rw||l_yvt||cur_detail.val||chr(13)||chr(10); l_n:=l_n+1;
             end case;
         end if;

       end loop;
       l_indx_rrrrw := l_rrrr0.FIRST;
       if l_indx_rrrrw is not null then
          loop
            l_txt:=l_txt||cur.m||'292'||l_zn||l_indx_rrrrw||l_yvt||l_rrrr0(l_indx_rrrrw)||chr(13)||chr(10); l_n:=l_n+1;
            l_indx_rrrrw := l_rrrr0.next(l_indx_rrrrw);
            EXIT WHEN l_indx_rrrrw IS NULL;
          end loop;
       end if;
       if l_88888 > 0 then
         l_txt:=l_txt||cur.m||'292'||l_zn||'88888'||l_yvt||l_88888||chr(13)||chr(10); l_n:=l_n+1;
       end if;

       l_88888 := 0;
       l_rrrr0.delete;
       for cur_detail in (select * from cim_f504_detail d
                         where d.f504_id = cur.f504_id
                           and d.indicator_id = 293)
       loop
         if cur_detail.noprognosis = 1 then
           l_txt:=l_txt||cur.m||'293'||l_zn||'99999'||l_yvt||cur_detail.val||chr(13)||chr(10); l_n:=l_n+1;
           else
             l_rw := rrrrw(cur_detail.rrrr,cur_detail.w);
             case
               when l_rw = '88888' then l_88888 := l_88888 + cur_detail.val;
               when substr(l_rw, 5, 1) = '0' then
                                          if l_rrrr0.exists(l_rw) then
                                            l_rrrr0(l_rw) := l_rrrr0(l_rw) + cur_detail.val;
                                            else
                                              l_rrrr0(l_rw) := cur_detail.val;
                                          end if;

               else
                 l_txt:=l_txt||cur.m||'293'||l_zn||l_rw||l_yvt||cur_detail.val||chr(13)||chr(10); l_n:=l_n+1;
             end case;
         end if;

       end loop;
       l_indx_rrrrw := l_rrrr0.FIRST;
       if l_indx_rrrrw is not null then
          loop
            l_txt:=l_txt||cur.m||'293'||l_zn||l_indx_rrrrw||l_yvt||l_rrrr0(l_indx_rrrrw)||chr(13)||chr(10); l_n:=l_n+1;
            l_indx_rrrrw := l_rrrr0.next(l_indx_rrrrw);
            EXIT WHEN l_indx_rrrrw IS NULL;
          end loop;
       end if;
       if l_88888 > 0 then
         l_txt:=l_txt||cur.m||'293'||l_zn||'88888'||l_yvt||l_88888||chr(13)||chr(10); l_n:=l_n+1;
       end if;


       dbms_lob.append(l_txt_clob, l_txt); l_txt:=null;

    end loop;


     select nvl(par_value,'XX') into l_oblcode from bars.cim_params where par_name='OBL_CODE';
     select nvl2(b040, substr(b040, length(b040)-11, 12), 'XXXXXXXXXXXX') into l_txt from branch where branch='/'||f_ourmfo||'/';
     l_txt:=lpad(' ',100,' ')||chr(13)||chr(10)||
            rpad('02=01'||substr(l_p_date,3)||'=01'||to_char(l_date_z_begin-1,'MMYYYY')||'='||to_char(last_day(l_date_z_begin-1),'DDMMYYYY')
            ||'='||to_char(l_sysdate,'DDMMYYYY')||'='||to_char(l_sysdate,'HH24MM')||'='||to_char(gl.amfo,'fm000000')||'=12='
            ||to_char(l_n,'fm000000000')||'='||p_namefile||'= IDKEY=',148,' ')||chr(13)||chr(10)
            ||'#1='||l_oblcode||'='||l_txt||chr(13)||chr(10);



    dbms_lob.createtemporary(p_clob, false);
    dbms_lob.append(p_clob, l_txt);
    dbms_lob.append(p_clob, l_txt_clob);

  end;


  procedure get_indicators_f503(p_contract_n number, p_date_z_begin date, p_date_z_end date, p_indicators_f503 out t_indicators_f503)
    as
     l_k number;

     l_mindat date;
     l_maxdat date;
  begin
    cim_mgr.create_credgraph(p_contract_n);

    select count(*) into l_k from cim_credgraph_tmp where dat<=p_date_z_end;
    if l_k>0 then
      select count(*) into l_k from cim_credgraph_tmp where dat=p_date_z_begin;
      if l_k=1 then
        select round(zt/100,0), round(dt/100,0), round(dp/100,0)
          into p_indicators_f503.p2010, p_indicators_f503.p2011, p_indicators_f503.p2012
          from cim_credgraph_tmp where dat = p_date_z_begin;
      else
        select count(*) into l_k from cim_credgraph_tmp where dat<p_date_z_begin;
        if l_k>0 then
          select max(dat) into l_mindat from cim_credgraph_tmp where dat<=p_date_z_begin;
          select round(zt/100,0), round(dt/100,0), round(dp/100,0)
            into p_indicators_f503.p2010, p_indicators_f503.p2011, p_indicators_f503.p2012
            from cim_credgraph_tmp where dat=l_mindat;
        else
          p_indicators_f503.p2010 := 0;
          p_indicators_f503.p2011 := 0;
          p_indicators_f503.p2012 := 0;
        end if;
      end if;

      select round(nvl(sum(psk)-sum(rsk),0)/100,0), round(nvl(sum(pspe)-sum(rspe),0)/100,0), max(dat)
        into p_indicators_f503.p2013, p_indicators_f503.p2014, l_mindat
        from cim_credgraph_tmp where dat<p_date_z_begin;


      select count(*) into l_k from cim_credgraph_tmp where dat>=p_date_z_begin and dat<=p_date_z_end;
      if l_k>0 then
        select round(nvl(sum(rsnt),0)/100,0), round(nvl(sum(pspt),0)/100,0), round(nvl(sum(sp),0)/100,0), round(nvl(sum(psk),0)/100,0),
               round(nvl(sum(rsk),0)/100,0), round(nvl(sum(pspe),0)/100,0), round(nvl(sum(rspe),0)/100,0), round(nvl(sum(rspt),0)/100,0),
               round(nvl(sum(svp),0)/100,0), max(dat),
               round(nvl(sum(case when rspt>0 and dt<=pspt then case when rspt<pspt+bt-dt then 0 else rspt-pspt-bt+dt end else rspt end),0)/100,0),
               round(nvl(sum(case when svp>0 and dp<=sp then case when svp<sp-case when zp<0 then zp else 0 end-dp then 0
                                                                   else svp-sp+ case when zp<0 then zp else 0 end +dp end else svp end),0)/100,0)--!?
               --round(nvl(max(bt),0)/100,0)
          into p_indicators_f503.p2016, p_indicators_f503.p2017, p_indicators_f503.p2018, p_indicators_f503.p2020, p_indicators_f503.p2036, p_indicators_f503.p2021,
               p_indicators_f503.p2037, p_indicators_f503.p2022, p_indicators_f503.p2029, l_maxdat, p_indicators_f503.p2024, p_indicators_f503.p2031-- l_p_bt
          from cim_credgraph_tmp where dat>=p_date_z_begin and dat<=p_date_z_end;
        select round(nvl(bt,0)/100,2)
          into p_indicators_f503.p2023
          from cim_credgraph_tmp where dat=l_maxdat;
      else
        p_indicators_f503.p2016 := 0;
        p_indicators_f503.p2017 := 0;
        p_indicators_f503.p2018 := 0;
        p_indicators_f503.p2020 := 0;
        p_indicators_f503.p2036 := 0;
        p_indicators_f503.p2021 := 0;
        p_indicators_f503.p2037 := 0;
        p_indicators_f503.p2022 := 0;
        p_indicators_f503.p2029 := 0;
        p_indicators_f503.p2024 := 0;
        p_indicators_f503.p2031 := 0;
        p_indicators_f503.p2023 := 0;
      end if;

      if l_mindat is not null then
        select nvl(p_indicators_f503.p2023-round(nvl(bt,0)/100,2),0) into p_indicators_f503.p2023 from cim_credgraph_tmp where dat=l_mindat;
      end if;
      if p_indicators_f503.p2021 < p_indicators_f503.p2037-p_indicators_f503.p2014 then p_indicators_f503.p2021 := p_indicators_f503.p2037-p_indicators_f503.p2014; end if;
      if p_indicators_f503.p2020 < p_indicators_f503.p2036-p_indicators_f503.p2013 then p_indicators_f503.p2020 := p_indicators_f503.p2036-p_indicators_f503.p2013; end if;

      p_indicators_f503.p2026 := 0;
      p_indicators_f503.p2027 := 0;
      p_indicators_f503.p2028 := 0;
      p_indicators_f503.p2033 := 0;
      p_indicators_f503.p2034 := 0;
      p_indicators_f503.p2035 := 0;
      select nvl(sum(case when pay_flag=2 and type_id=7 then s_vk else 0 end),0), nvl(sum(case when pay_flag=2 and type_id=6 then s_vk else 0 end),0),
        nvl(sum(case when pay_flag=2 and type_id=5 then s_vk else 0 end),0), nvl(sum(case when pay_flag=3 and type_id=7 then s_vk else 0 end),0),
        nvl(sum(case when pay_flag=3 and type_id=6 then s_vk else 0 end),0), nvl(sum(case when pay_flag=3 and type_id=5 then s_vk else 0 end),0)
        into p_indicators_f503.p2026, p_indicators_f503.p2027, p_indicators_f503.p2028, p_indicators_f503.p2033, p_indicators_f503.p2034, p_indicators_f503.p2035
        from v_cim_bound_payments where vdat>=p_date_z_begin and vdat<=p_date_z_end and contr_id=p_contract_n;
      p_indicators_f503.p2022 := p_indicators_f503.p2022-p_indicators_f503.p2026-p_indicators_f503.p2027-p_indicators_f503.p2028;
      p_indicators_f503.p2029 := p_indicators_f503.p2029-p_indicators_f503.p2033-p_indicators_f503.p2034-p_indicators_f503.p2035;



      p_indicators_f503.p2025 := p_indicators_f503.p2026+p_indicators_f503.p2027+p_indicators_f503.p2028;

      if p_indicators_f503.p2029 > p_indicators_f503.p2018+p_indicators_f503.p2012 then
        p_indicators_f503.p2030 := p_indicators_f503.p2029-p_indicators_f503.p2018-p_indicators_f503.p2012;
      end if;

      p_indicators_f503.p2032 := p_indicators_f503.p2033+p_indicators_f503.p2034+p_indicators_f503.p2035;

      select round(nvl(dt,0)/100,0)
        into p_indicators_f503.p2038
        from cim_credgraph_tmp
       where dat=(select max(dat) from cim_credgraph_tmp where dat<=p_date_z_end+1);
    end if;

  end;


  procedure get_indicators_f504(p_contract_n number, p_date_to date, p_date_z_begin date, p_indicators_f504 in out t_indicators_f504)
    as
     l_maxdat       date;
     l_date_z_begin date;

     l_f_incom      number; -- Сума майбутніх надходжень
     l_prognoz      number;
     l_snt          number;
     l_spt          number;

     l_act_m        number;
     l_act_y        varchar2(4);
     l_rm           number;
     l_dat          date;
     l_y_txt        varchar2(5);
     l_b_y          number;

     l_p212 number;
     l_p213 number;
     l_p201 number;
     l_p222 number;
     l_p223 number;
     l_p292 number;
     l_p293 number;
  begin
    p_indicators_f504.p212 := t_arr_val();
    p_indicators_f504.p213 := t_arr_val();
    p_indicators_f504.p201 := t_arr_val();
    p_indicators_f504.p222 := t_arr_val();
    p_indicators_f504.p223 := t_arr_val();
    p_indicators_f504.p292 := t_arr_val();
    p_indicators_f504.p293 := t_arr_val();
    cim_mgr.create_credgraph(p_contract_n);
    select count(*), max(dat) into l_p212, l_maxdat from cim_credgraph_tmp where dat != to_date('01/01/3000','DD/MM/YYYY');
    --dbms_output.put_line('count='||l_p212||' l_maxdat='||to_char(l_maxdat, 'DD.MM.YYYY'));
    l_b_y:=to_number(to_char(p_date_to,'YYYY'));
    l_date_z_begin := p_date_z_begin+1;
    if l_p212 > 0 then
      select count(*) into l_p212 from cim_credgraph_tmp where dat<l_date_z_begin;
      if l_p212 > 0 then
        select nvl(sum(rsnt),0), nvl(sum(rspt),0) into l_p212, l_p213 from cim_credgraph_tmp where dat<l_date_z_begin;
        else l_p212:=0; l_p213:=0;
      end if;
      l_f_incom:=p_indicators_f504.p090*100-l_p212;
      select nvl(sum(psnt),0), nvl(sum(pspt),0) into l_p222, l_p223 from cim_credgraph_tmp
        where dat>=l_date_z_begin and dat != to_date('01/01/3000','DD/MM/YYYY');
      select nvl(max(dt),0) into l_p201 from cim_credgraph_tmp where dat = l_date_z_begin;
      if l_p212+l_p222 != l_p213+l_p223+l_p201 or l_p212+l_p222 != p_indicators_f504.p090*100 then
        l_prognoz:=0;
        l_snt:=round(p_indicators_f504.p090-l_p212/100,0);
        l_spt:=p_indicators_f504.p090*100-l_p213-l_p223;
      else
        l_prognoz:=1;
      end if;
      l_p212:=0; l_p213:=0; l_p201:=0; l_p222:=0; l_p223:=0;
      l_act_m:=to_number(to_char(l_date_z_begin,'MM')); l_act_y:=to_char(l_date_z_begin,'YYYY'); l_rm:=0;
      for l in (select * from cim_credgraph_tmp
                  where dat>=l_date_z_begin and dat<to_date('01/01/'||to_char(l_b_y+10,'fm9999'),'DD/MM/YYYY') order by dat) loop
        l_dat:=l.dat;
        if l_act_y=to_char(l.dat,'YYYY') and (l_rm=1 or l_act_m=to_number(to_char(l.dat,'MM'))) then
          l_p212:=l_p212+l.xpspt;
          l_p213:=l_p213+l.xsp;
          l_p201:=l_p201+l.psnt;
          l_p222:=l_p222+l.pspt;
          l_p223:=l_p223+l.sp;
        else
          if l_rm=0 then l_y_txt:=l_act_y||num_code(l_act_m); else l_y_txt:=l_act_y||'0'; end if;

          if l_p212 != 0 then
            p_indicators_f504.p212.extend;
            p_indicators_f504.p212(p_indicators_f504.p212.last).rrrrw := l_y_txt;
            p_indicators_f504.p212(p_indicators_f504.p212.last).val   := round(l_p212/100,0);
          end if;
          if l_p213 != 0 then
            p_indicators_f504.p213.extend;
            p_indicators_f504.p213(p_indicators_f504.p213.last).rrrrw := l_y_txt;
            p_indicators_f504.p213(p_indicators_f504.p213.last).val   := round(l_p213/100,0);
          end if;

          if l_prognoz=0 and l.dat = l_maxdat then l_p222:=l_p222+l_spt; end if;
          if l_p222 != 0 and l_f_incom>0 then
            p_indicators_f504.p222.extend;
            p_indicators_f504.p222(p_indicators_f504.p222.last).rrrrw := l_y_txt;
            p_indicators_f504.p222(p_indicators_f504.p222.last).val   := round(l_p222/100,0);
          end if;
          if l_prognoz=1 then
            if l_p223 != 0 and l_f_incom>0 then
              p_indicators_f504.p223.extend;
              p_indicators_f504.p223(p_indicators_f504.p223.last).rrrrw := l_y_txt;
              p_indicators_f504.p223(p_indicators_f504.p223.last).val   := round(l_p223/100,0);
            end if;
            if l_p201 != 0 then
              p_indicators_f504.p201.extend;
              p_indicators_f504.p201(p_indicators_f504.p201.last).rrrrw := l_y_txt;
              p_indicators_f504.p201(p_indicators_f504.p201.last).val   := round(l_p201/100,0);
            end if;
          end if;
          l_p212:=l.xpspt; l_p213:=l.xsp; l_p201:=l.psnt; l_p222:=l.pspt; l_p223:=l.sp;
          l_act_m:=to_number(to_char(l.dat,'MM')); l_act_y:=to_char(l.dat,'YYYY');
          if l_act_y-to_number(to_char(l_date_z_begin,'YYYY'))>1 then l_rm:=1; else l_rm:=0; end if; --1 - річний

        end if;

      end loop;

      if l_rm=0 then l_y_txt:=l_act_y||num_code(l_act_m); else l_y_txt:=l_act_y||'0'; end if;
      if l_p212 != 0 then
        p_indicators_f504.p212.extend;
        p_indicators_f504.p212(p_indicators_f504.p212.last).rrrrw := l_y_txt;
        p_indicators_f504.p212(p_indicators_f504.p212.last).val   := round(l_p212/100,0);
      end if;
      if l_p213 != 0 then
        p_indicators_f504.p213.extend;
        p_indicators_f504.p213(p_indicators_f504.p213.last).rrrrw := l_y_txt;
        p_indicators_f504.p213(p_indicators_f504.p213.last).val   := round(l_p213/100,0);
      end if;
      if l_prognoz=0 and l_dat = l_maxdat then l_p222:=l_p222+l_spt; end if;
      if l_p222 != 0 and l_f_incom>0 then
        p_indicators_f504.p222.extend;
        p_indicators_f504.p222(p_indicators_f504.p222.last).rrrrw := l_y_txt;
        p_indicators_f504.p222(p_indicators_f504.p222.last).val   := round(l_p222/100,0);
      end if;
      if l_prognoz=1 then
         if l_p223 != 0 and l_f_incom>0 then
           p_indicators_f504.p223.extend;
           p_indicators_f504.p223(p_indicators_f504.p223.last).rrrrw := l_y_txt;
           p_indicators_f504.p223(p_indicators_f504.p223.last).val   := round(l_p223/100,0);
         end if;
         if l_p201 != 0 then
           p_indicators_f504.p201.extend;
           p_indicators_f504.p201(p_indicators_f504.p201.last).rrrrw := l_y_txt;
           p_indicators_f504.p201(p_indicators_f504.p201.last).val   := round(l_p201/100,0);
         end if;
      end if;

      select round(nvl(sum(xpspt),0)/100,0), round(nvl(sum(xsp),0)/100,0), round(nvl(sum(psnt),0)/100,0), round(nvl(sum(pspt),0)/100,0),
             round(nvl(sum(sp),0)/100,0)  into l_p212, l_p213, l_p201, l_p222, l_p223
        from cim_credgraph_tmp where dat>=to_date('01/01/'||to_char(l_b_y+10,'fm9999'),'DD/MM/YYYY') and dat != to_date('01/01/3000','DD/MM/YYYY');
      if l_p212 != 0 then
        p_indicators_f504.p212.extend;
        p_indicators_f504.p212(p_indicators_f504.p212.last).rrrrw := '88888';
        p_indicators_f504.p212(p_indicators_f504.p212.last).val   := round(l_p212/100,0);
      end if;
      if l_p213 != 0 then
        p_indicators_f504.p213.extend;
        p_indicators_f504.p213(p_indicators_f504.p213.last).rrrrw := '88888';
        p_indicators_f504.p213(p_indicators_f504.p213.last).val   := round(l_p213/100,0);
      end if;
      if l_p201 != 0 then
        p_indicators_f504.p201.extend;
        p_indicators_f504.p201(p_indicators_f504.p201.last).rrrrw := '88888';
        p_indicators_f504.p201(p_indicators_f504.p201.last).val   := round(l_p201/100,0);
      end if;
      if l_p222 != 0 and l_f_incom>0 then
        p_indicators_f504.p222.extend;
        p_indicators_f504.p222(p_indicators_f504.p222.last).rrrrw := '88888';
        p_indicators_f504.p222(p_indicators_f504.p222.last).val   := round(l_p222/100,0);
      end if;
      if l_p223 != 0 and l_f_incom>0 then
        p_indicators_f504.p223.extend;
        p_indicators_f504.p223(p_indicators_f504.p223.last).rrrrw := '88888';
        p_indicators_f504.p223(p_indicators_f504.p223.last).val   := round(l_p223/100,0);
      end if;
      if l_prognoz=0 and l_snt>0 then
        p_indicators_f504.p201.extend;
        p_indicators_f504.p201(p_indicators_f504.p201.last).rrrrw := '99999';
        p_indicators_f504.p201(p_indicators_f504.p201.last).val   := round(l_snt,0);
      end if;
      select round(nvl(max(dt),0)/100,0), round(nvl(max(dp),0)/100,0) into l_p292, l_p293 from cim_credgraph_tmp where dat=l_date_z_begin;
      if l_p292 != 0 then
        p_indicators_f504.p292.extend;
        p_indicators_f504.p292(p_indicators_f504.p292.last).rrrrw := '99999';
        p_indicators_f504.p292(p_indicators_f504.p292.last).val   := round(l_p292,0);
      end if;
      if l_p293 != 0 then
        p_indicators_f504.p293.extend;
        p_indicators_f504.p293(p_indicators_f504.p293.last).rrrrw := '99999';
        p_indicators_f504.p293(p_indicators_f504.p293.last).val   := round(l_p293,0);
      end if;

    else
--      l_txt:=l_txt||'Контракт #'||l_c.contr_id||'не має графіка.'||chr(13)||chr(10);
      null;
    end if;

  end;

/* Процедура заселення/дозаселення попередніми данними для подальшої зміни і вигрузки
*/
  procedure prepare_f503_change(p_date_to date)
    is
      --l_client_sess      varchar2(64) := bars_login.get_session_clientid;

      l_date_z_begin     date;
      l_date_z_end       date;

      l_indicators_f503  t_indicators_f503;

      l_date_to          date := p_date_to;

      l_arr_contr_id     number_list;

    begin
      if l_date_to is null then
        l_date_to := bankdate;
      end if;
      pul.set_mas_ini('cim_p_date',to_char(l_date_to,'DDMMYYYY'),null);
      l_date_z_begin := to_date('01/01/'||to_char(add_months(l_date_to,-1),'YYYY'),'DD/MM/YYYY');
      l_date_z_end   := last_day(add_months(l_date_to,-1));


      --населення новими
      select c.contr_id bulk collect
      into l_arr_contr_id
      from v_cim_credit_contracts c
      where open_date <= l_date_z_end
        and status_id!=1 and status_id!=9  and status_id!=10
        and branch like sys_context('bars_context','user_mfo_mask')
        and not exists (select 1 from cim_f503 f where f.contr_id = c.contr_id);

      pul.set_mas_ini('cim_work_prepare_f503_change','YES',null);
      for cur in (select * from v_cim_credit_contracts c where c.contr_id in (select value(tt) from table(l_arr_contr_id) tt))
      loop
        get_indicators_f503(cur.contr_id, l_date_z_begin, l_date_z_end, l_indicators_f503);
        insert into cim_f503(contr_id, p_date_to,  p1000, z, p0100,
                             p1300, p0300, p1400,
                             p1900, pval,  p1500,
                             m,
                             p1600, p9800,
                             p1700,
                             p0200, r_agree_no, p1200,
                             p1800, t, p9500, p9600,
                             p3100,
                             p9900, p0400,
                             p0800_1, p0800_2, p0800_3,
                             p0700, p0900, p0500, p0600,
                             p2010, p2011, p2012, p2013, p2014, p2016,
                             p2017, p2018, p2020, p2021, p2022, p2023,
                             p2024, p2025, p2026, p2027, p2028, p2029,
                             p2030, p2031, p2032, p2033, p2034, p2035,
                             p2036, p2037, p2038, p2042,
                             p3000)
        values (cur.contr_id, l_date_to, substr(cur.nmkk,1,27) /*as p1000*/, lpad(substr(cur.okpo,1,10),10,'0') /*as z*/, cur.borrower_id /*as p0100*/,
               substr(cur.benef_name,1,54) /*as p1300*/, lpad(cur.country_id,3,'0') /*as p0300*/, decode(cur.creditor_type,11,1,cur.creditor_type) /*as p1400*/,
               decode(cur.credit_term, 3 , 1, cur.credit_term) /*as p1900*/, lpad(cur.kv,3,'0') /*as pval*/, cur.credit_type /*as p1500*/,
               case when cur.credit_type=0 then 1 when cur.creditor_type=11 then 3 else 2 end /*as m*/,
               cur.credit_prepay /*as p1600*/, cur.f503_change_info /*as p9800*/,
               (select nvl(case when max(payment_period)=min(payment_period) then max(decode(payment_period,14,4,payment_period))
                                    else 6 end,6)
                  from cim_credgraph_period where contr_id=cur.contr_id) /*as p1700*/,
               '0000' /*as p0200*/, lpad(substr(cur.r_agree_no,1,5),5,'0') /*r_agree_no*/, cur.r_agree_date /*as p1200*/,
               cur.f503_reason /*as p1800*/, '0' /*as t*/, cur.f503_percent /*as p9500*/, cur.f503_purpose  /*as p9600*/,
               cur.close_date /*as p3100*/, --Раніше було : nvl2(c.close_date, c.close_date-c.open_date, '') as p9700, --має бути різниця між датою підписання і здійснення останнього платежу
               cur.f503_note /*as p9900*/, decode(cur.f503_percent_type, 1, 3, cur.f503_percent_type) /*as p0400*/,
               cur.f503_percent_base /*as p0800_1*/, cur.f503_percent_base_t /*as p0800_2*/, cur.f503_percent_base_val /*as p0800_3*/,
               cur.f503_percent_margin /*as p0700*/, cur.s /*as p0900*/, substr(cur.num, 1, 16) /*as p0500*/, cur.open_date /*as p0600*/,
               l_indicators_f503.p2010, l_indicators_f503.p2011, l_indicators_f503.p2012, l_indicators_f503.p2013, l_indicators_f503.p2014, l_indicators_f503.p2016,
               l_indicators_f503.p2017, l_indicators_f503.p2018, l_indicators_f503.p2020, l_indicators_f503.p2021, l_indicators_f503.p2022, l_indicators_f503.p2023,
               l_indicators_f503.p2024, l_indicators_f503.p2025, l_indicators_f503.p2026, l_indicators_f503.p2027, l_indicators_f503.p2028, l_indicators_f503.p2029,
               l_indicators_f503.p2030, l_indicators_f503.p2031, l_indicators_f503.p2032, l_indicators_f503.p2033, l_indicators_f503.p2034, l_indicators_f503.p2035,
               l_indicators_f503.p2036, l_indicators_f503.p2037, l_indicators_f503.p2038, l_indicators_f503.p2042,
               cur.f503_state /*as p3000*/);

      end loop;
      pul.set_mas_ini('cim_work_prepare_f503_change','NO',null);


  end;


/* Процедура заселення попередніми данними для подальшої зміни і вигрузки
*/
  procedure prepare_f504_change(p_date_to date)
    is
      l_client_sess      varchar2(64) := bars_login.get_session_clientid;

      l_date_z_begin     date;
      l_date_z_end       date;

      l_indicators_f504  t_indicators_f504;

      l_date_to          date := p_date_to;

      l_arr_contr_id     number_list;

      l_f504_id          cim_f504.f504_id%type;

    begin
      if l_date_to is null then
        l_date_to := bankdate;
      end if;
      pul.set_mas_ini('cim_p_date',to_char(l_date_to,'DDMMYYYY'),null);
      l_date_z_begin := to_date('01/01/'||to_char(add_months(l_date_to,-1),'YYYY'),'DD/MM/YYYY');
      l_date_z_end   := last_day(add_months(l_date_to,-1));



      select c.contr_id bulk collect
      into l_arr_contr_id
      from v_cim_credit_contracts c
      where open_date <= l_date_z_end
        and status_id!=1 and status_id!=9  and status_id!=10
        and branch like sys_context('bars_context','user_mfo_mask')
        and not exists (select 1 from cim_f504 f where f.contr_id = c.contr_id);

      for c in (select * from v_cim_credit_contracts c where c.contr_id in (select value(tt) from table(l_arr_contr_id) tt))
      loop
        insert into cim_f504(contr_id, p_date_to, P101, Z, R_AGREE_NO,
                             P103, PVAL, T, M,
                             P107,
                             P108, P184, P140,
                             P142,
                             P141, P020, P143,
                             P050, P060, P090, P960,
                             P310,
                             P999,
                             p010,
                             p040,
                             p070, p950, p030
                              )
              values (c.contr_id, l_date_to, substr(c.nmkk,1,27) /*as p101*/, lpad(substr(c.okpo,1,10),10,'0'), lpad(substr(c.r_agree_no,1,5),5,'0') /*r_agree_no*/,
               c.r_agree_date /*as p103*/, lpad(c.kv,3,'0') /*as pval*/, '0' /*as t*/, case when c.credit_type=0 then 1 when c.creditor_type=11 then 3 else 2 end /*as m*/,
               substr(c.benef_name,1,54) /*as p107*/,
               decode(c.creditor_type,11,1,c.creditor_type) /*as p108*/, decode(c.credit_term, 3 , 1, c.credit_term) /*as p184*/, c.credit_type /*as p140*/,
               (select nvl(case when max(payment_period)=min(payment_period) then max(decode(payment_period,14,4,payment_period))
                                     else 6 end,6)
                  from cim_credgraph_period where contr_id=c.contr_id) /*as p142*/,
               c.credit_prepay /*as p141*/, '0000' /*as p020*/,  c.f503_reason /*as p143*/,
               substr(c.num, 1, 16) /*as p050*/, c.open_date /*as p060*/, c.s /*as p090*/, c.f503_purpose /*as p960*/,
               --nvl2(c.close_date, c.close_date-c.open_date, '') /*as p970*/, --має бути різниця між датою підписання і здійснення останнього платежу
               c.close_date /*as p310*/,
               c.f504_note /*as p999*/,
               c.borrower_id /*as p010*/,
               decode(c.f503_percent_type, 1, 3, c.f503_percent_type) /*as p040*/,
               c.f503_percent_margin /*as p070*/, c.f503_percent /*as p950*/, lpad(c.country_id,3,'0') /*as p030*/)
               returning f504_id into l_f504_id;

        --розрахунок незаповнених показників

          l_indicators_f504.p090 := c.s/*p090*/;
          get_indicators_f504(c.contr_id, l_date_to, l_date_z_begin, l_indicators_f504);
          for i in 1..l_indicators_f504.p212.count loop
            insert into cim_f504_detail2(f504_det_id,
                                        f504_id,
                                        indicator_id,
                                        indicator_name,
                                        rrrr,
                                        w,
                                        val)
                    values(bars_sqnc.get_nextval('s_cim_f504'),
                           l_f504_id,
                           212,
                           'сума платежів ОС боргу(без урахування майбутніх надходжень кредиту)',
                           substr(l_indicators_f504.p212(i).rrrrw,1,4),
                           substr(l_indicators_f504.p212(i).rrrrw,5,1),
                           l_indicators_f504.p212(i).val
                    );
          end loop;
          for i in 1..l_indicators_f504.p213.count loop
            insert into cim_f504_detail2(f504_det_id,
                                        f504_id,
                                        indicator_id,
                                        indicator_name,
                                        rrrr,
                                        w,
                                        val)
                    values(bars_sqnc.get_nextval('s_cim_f504'),
                           l_f504_id,
                           213,
                           'сума платежів проц. платежів(без урахування майб надх кредиту)',
                           substr(l_indicators_f504.p213(i).rrrrw,1,4),
                           substr(l_indicators_f504.p213(i).rrrrw,5,1),
                           l_indicators_f504.p213(i).val
                    );
          end loop;
          for i in 1..l_indicators_f504.p201.count loop
            insert into cim_f504_detail(f504_det_id,
                                        f504_id,
                                        indicator_id,
                                        indicator_name,
                                        noprognosis,
                                        rrrr,
                                        w,
                                        val)
                    values(bars_sqnc.get_nextval('s_cim_f504'),
                           l_f504_id,
                           201,
                           'сума майбутнього надходження кредиту',
                           case when l_indicators_f504.p201(i).rrrrw = '99999' then 1 else 0 end,
                           substr(l_indicators_f504.p201(i).rrrrw,1,4),
                           substr(l_indicators_f504.p201(i).rrrrw,5,1),
                           l_indicators_f504.p201(i).val
                    );
          end loop;
          for i in 1..l_indicators_f504.p222.count loop
            insert into cim_f504_detail2(f504_det_id,
                                        f504_id,
                                        indicator_id,
                                        indicator_name,
                                        rrrr,
                                        w,
                                        val)
                    values(bars_sqnc.get_nextval('s_cim_f504'),
                           l_f504_id,
                           222,
                           'сума строкових платежів зі сплати ОС боргу',
                           substr(l_indicators_f504.p222(i).rrrrw,1,4),
                           substr(l_indicators_f504.p222(i).rrrrw,5,1),
                           l_indicators_f504.p222(i).val
                    );
          end loop;
          for i in 1..l_indicators_f504.p223.count loop
            insert into cim_f504_detail2(f504_det_id,
                                        f504_id,
                                        indicator_id,
                                        indicator_name,
                                        rrrr,
                                        w,
                                        val)
                    values(bars_sqnc.get_nextval('s_cim_f504'),
                           l_f504_id,
                           223,
                           'сума строкових платежів зі сплати проц. платежів',
                           substr(l_indicators_f504.p223(i).rrrrw,1,4),
                           substr(l_indicators_f504.p223(i).rrrrw,5,1),
                           l_indicators_f504.p223(i).val
                    );
          end loop;
          for i in 1..l_indicators_f504.p292.count loop
            insert into cim_f504_detail(f504_det_id,
                                        f504_id,
                                        indicator_id,
                                        indicator_name,
                                        noprognosis,
                                        rrrr,
                                        w,
                                        val)
                    values(bars_sqnc.get_nextval('s_cim_f504'),
                           l_f504_id,
                           292,
                           'сума прогнозних платежів простроченої заборгованості за ОС боргу',
                           case when l_indicators_f504.p292(i).rrrrw = '99999' then 1 else 0 end,
                           substr(l_indicators_f504.p292(i).rrrrw,1,4),
                           substr(l_indicators_f504.p292(i).rrrrw,5,1),
                           l_indicators_f504.p292(i).val
                    );
          end loop;
          for i in 1..l_indicators_f504.p293.count loop
            insert into cim_f504_detail(f504_det_id,
                                        f504_id,
                                        indicator_id,
                                        indicator_name,
                                        noprognosis,
                                        rrrr,
                                        w,
                                        val)
                    values(bars_sqnc.get_nextval('s_cim_f504'),
                           l_f504_id,
                           293,
                           'сума прогнозних платежів простроченої заборгованості за проц плат',
                           case when l_indicators_f504.p293(i).rrrrw = '99999' then 1 else 0 end,
                           substr(l_indicators_f504.p293(i).rrrrw,1,4),
                           substr(l_indicators_f504.p293(i).rrrrw,5,1),
                           l_indicators_f504.p293(i).val
                    );
          end loop;

      end loop;



  end;

  --установка контексту для додавання в БМД
  procedure set_context_f504_detail(p_f504_id        cim_f504_detail.f504_id%type,
                                    p_indicator_id   cim_f504_detail.indicator_id%type)
  as
  begin
    pul.set_mas_ini('cim_p_f504_id',p_f504_id,null);
    pul.set_mas_ini('cim_p_indicator_id',p_indicator_id,null);
  end;

  --додавання показника до редагуємого звіту f504
  procedure add_indicator_f504(p_f504_id        cim_f504_detail.f504_id%type,
                               p_indicator_id   cim_f504_detail.indicator_id%type,
                               p_noprognosis    cim_f504_detail.noprognosis%type,
                               p_rrrr           cim_f504_detail.rrrr%type,
                               p_w              cim_f504_detail.w%type,
                               p_val            cim_f504_detail.val%type)
    as
    l_indicator                cim_f504_detail.indicator_id%type := to_number(pul.get_mas_ini_val('cim_p_indicator_id'));
    l_indicator_id             cim_f504_detail.indicator_id%type;
    l_f504                     cim_f504_detail.f504_id%type := to_number(pul.get_mas_ini_val('cim_p_f504_id'));
    l_f504_id                  cim_f504_detail.f504_id%type;
    l_indicator_name           cim_f504_detail.indicator_name%type;
  begin
    if p_f504_id is null then
       l_f504_id := l_f504;
       else
         l_f504_id := p_f504_id;
    end if;
    if p_indicator_id is null then
       l_indicator_id := l_indicator;
       else
         l_indicator_id := p_indicator_id;
    end if;

    --raise_application_error(-20000,'l_indicator_id = '||l_indicator_id ||' l_f504_id='||l_f504_id);

    case l_indicator_id
      when 212 then l_indicator_name := 'сума платежів ОС боргу(без урахування майбутніх надходжень кредиту)';
      when 213 then l_indicator_name := 'сума платежів проц. платежів(без урахування майб надх кредиту)';
      when 201 then l_indicator_name := 'сума майбутнього надходження кредиту';
      when 222 then l_indicator_name := 'сума строкових платежів зі сплати ОС боргу';
      when 223 then l_indicator_name := 'сума строкових платежів зі сплати проц. платежів';
      when 292 then l_indicator_name := 'сума прогнозних платежів простроченої заборгованості за ОС боргу';
      when 293 then l_indicator_name := 'сума прогнозних платежів простроченої заборгованості за проц плат';
    end case;

    if l_indicator_id in (201, 292, 293) then
      insert into cim_f504_detail(f504_det_id,
                             f504_id,
                             indicator_id,
                             indicator_name,
                             noprognosis,
                             rrrr,
                             w,
                             val)
      values                 (bars_sqnc.get_nextval('s_cim_f504'),
                             l_f504_id,
                             l_indicator_id,
                             l_indicator_name,
                             p_noprognosis,
                             p_rrrr,
                             p_w,
                             p_val);
      else
        insert into cim_f504_detail2(f504_det_id,
                               f504_id,
                               indicator_id,
                               indicator_name,
                               rrrr,
                               w,
                               val)
        values                 (bars_sqnc.get_nextval('s_cim_f504'),
                               l_f504_id,
                               l_indicator_id,
                               l_indicator_name,
                               p_rrrr,
                               p_w,
                               p_val);
    end if;

  end;


  --додавання для механізмку БМД
  procedure add_f504_row(p_p101         cim_f504.p101%type,
                         p_z            cim_f504.z%type,
                         p_r_agree_no   cim_f504.r_agree_no%type,
                         p_p103         cim_f504.p103%type,
                         p_pval         cim_f504.pval%type,
                         p_t            cim_f504.t%type,
                         p_m            cim_f504.m%type,
                         p_p107         cim_f504.p107%type,
                         p_p108         cim_f504.p108%type,
                         p_p184         cim_f504.p184%type,
                         p_p140         cim_f504.p140%type,
                         p_p142         cim_f504.p142%type,
                         p_p020         cim_f504.p020%type,
                         p_p141         cim_f504.p141%type,
                         p_p143         cim_f504.p143%type,
                         p_p960         cim_f504.p960%type,
                         p_p310         cim_f504.p310%type,
                         p_p050         cim_f504.p050%type,
                         p_p060         cim_f504.p060%type,
                         p_p090         cim_f504.p090%type,
                         p_p999         cim_f504.p999%type
                         )
    is
  begin
     insert into cim_f504( p101,
                           z,
                           r_agree_no,
                           p103,
                           pval,
                           t,
                           m ,
                           p107,
                           p108,
                           p184,
                           p140,
                           p142,
                           p020,
                           p141,
                           p143,
                           p960,
                           p310,
                           p050,
                           p060,
                           p090,
                           p999)
     values( p_p101,
             p_z,
             p_r_agree_no,
             p_p103,
             p_pval,
             p_t,
             p_m,
             p_p107,
             p_p108,
             p_p184,
             p_p140,
             p_p142,
             p_p020,
             p_p141,
             p_p143,
             p_p960,
             p_p310,
             p_p050,
             p_p060,
             p_p090,
             p_p999);
  end;

  procedure sync_f503 as
      procedure add_auto_change_hist(p_f503_id          cim_f503_auto_change_hist.f503_id%type,
                                     p_indicator_code   cim_f503_auto_change_hist.indicator_code%type,
                                     p_indicator_name   cim_f503_auto_change_hist.indicator_name%type,
                                     p_rep_value        cim_f503_auto_change_hist.rep_value%type,
                                     p_vk_value         cim_f503_auto_change_hist.vk_value%type) as
      begin
        insert into cim_f503_auto_change_hist(f503_id,
                                              indicator_code,
                                              indicator_name,
                                              rep_value,
                                              vk_value,
                                              date_change)
        values(p_f503_id,
               p_indicator_code,
               p_indicator_name,
               p_rep_value,
               p_vk_value,
               sysdate);
      end;
  begin
      --аналіз змін
      for cur in (select f.f503_id,
                         case when c.credit_type=0 then 1 when c.creditor_type=11 then 3 else 2 end as m_vk, f.m as m_r,
                         lpad(substr(c.okpo,1,10),10,'0') as z_vk,                                           f.z as z_r,
                         lpad(substr(c.r_agree_no,1,5),5,'0') as r_agree_no_vk,                              f.r_agree_no as r_agree_no_r,
                         lpad(c.kv,3,'0') as pval_vk,                                                        f.pval as pval_r,
                         substr(c.nmkk,1,27) as p1000_vk,                                                    f.p1000 as p1000_r,
                         case when c.credit_type=0 then null else c.r_agree_date end as p1200_vk,            f.p1200 as p1200_r,
                         substr(c.benef_name,1,54)  as p1300_vk,                                             f.p1300 as p1300_r,
                         decode(c.creditor_type,11,1,c.creditor_type) as p1400_vk,                           f.p1400 as p1400_r,
                         c.credit_type as p1500_vk,                                                          f.p1500 as p1500_r,
                         c.credit_prepay as p1600_vk,                                                        f.p1600 as p1600_r,
                         c.f503_reason as p1800_vk,                                                          f.p1800 as p1800_r,
                         decode(c.credit_term, 3 , 1, c.credit_term) as p1900_vk,                            f.p1900 as p1900_r,
                         c.f503_percent as p9500_vk,                                                         f.p9500 as p9500_r,
                         c.f503_purpose as p9600_vk,                                                         f.p9600 as p9600_r,
                         c.close_date as p3100_vk,                                                           f.p3100 as p3100_r,
                         c.f503_change_info as p9800_vk,                                                     f.p9800 as p9800_r,
                         c.f503_note as p9900_vk,                                                            f.p9900 as p9900_r,
                         c.f503_state as p3000_vk,                                                           f.p3000 as p3000_r,
                         c.borrower_id as p0100_vk,                                                          f.p0100 as p0100_r,
                         lpad(c.country_id,3,'0') as p0300_vk,                                               f.p0300 as p0300_r,
                         decode(c.f503_percent_type, 1, 3, c.f503_percent_type) as p0400_vk,                 f.p0400 as p0400_r,
                         substr(c.num, 1, 16) as p0500_vk,                                                   f.p0500 as p0500_r,
                         c.open_date as p0600_vk,                                                            f.p0600 as p0600_r,
                         c.f503_percent_margin as p0700_vk,                                                  f.p0700 as p0700_r,
                         c.f503_percent_base as p0800_1_vk,                                                  f.p0800_1 as p0800_1_r,
                         c.f503_percent_base_t as p0800_2_vk,                                                f.p0800_2 as p0800_2_r,
                         c.f503_percent_base_val as p0800_3_vk,                                              f.p0800_3 as p0800_3_r,
                         c.s as p0900_vk,                                                                    f.p0900 as p0900_r
                  from v_cim_credit_contracts c, cim_f503 f where c.contr_id = f.contr_id
                    and f.kf = sys_context('bars_context','user_mfo'))
      loop
        update cim_f503
        set m        = cur.m_vk,
            z        = cur.z_vk,
            r_agree_no  = cur.r_agree_no_vk,
            pval     = cur.pval_vk,
            p1000    = cur.p1000_vk,
            p1200    = cur.p1200_vk,
            p1300    = cur.p1300_vk,
            p1400    = cur.p1400_vk,
            p1500    = cur.p1500_vk,
            p1600    = cur.p1600_vk,
            p1800    = cur.p1800_vk,
            p1900    = cur.p1900_vk,
            p9500    = cur.p9500_vk,
            p9600    = cur.p9600_vk,
            p3100    = cur.p3100_vk,
            p9800    = cur.p9800_vk,
            p9900    = cur.p9900_vk,
            p3000    = cur.p3000_vk,
            p0100    = cur.p0100_vk,
            p0300    = cur.p0300_vk,
            p0400    = cur.p0400_vk,
            p0500    = cur.p0500_vk,
            p0600    = cur.p0600_vk,
            p0700    = cur.p0700_vk,
            p0800_1  = cur.p0800_1_vk,
            p0800_2  = cur.p0800_2_vk,
            p0800_3  = cur.p0800_3_vk,
            p0900    = cur.p0900_vk
        where f503_id = cur.f503_id;

        if nvl(cur.m_r,-1)        != nvl(cur.m_vk,-1)  then
          add_auto_change_hist(cur.f503_id, 'm', 'ознака кредиту', cur.m_r, cur.m_vk);
        end if;
        if nvl(cur.z_r,'-1')        != nvl(cur.z_vk,'-1')  then
          add_auto_change_hist(cur.f503_id, 'z', 'код позичальника', cur.z_r, cur.z_vk);
        end if;
        if nvl(cur.r_agree_no_r,'-1')  != nvl(cur.r_agree_no_vk,'-1') then
          add_auto_change_hist(cur.f503_id, 'n', 'номер реєстрації договору', cur.r_agree_no_r, cur.r_agree_no_vk);
        end if;
        if nvl(cur.pval_r,'-1')     != nvl(cur.pval_vk,'-1') then
          add_auto_change_hist(cur.f503_id, 'y', 'код валюти', cur.pval_r, cur.pval_vk);
        end if;
        if nvl(cur.p1000_r,'-1')    != nvl(cur.p1000_vk,'-1') then
          add_auto_change_hist(cur.f503_id, '1000', 'назва позичальника', cur.p1000_r, cur.p1000_vk);
        end if;
        if nvl(cur.p1200_r,to_date('01011970','DDMMYYYY'))    != nvl(cur.p1200_vk,to_date('01011970','DDMMYYYY'))  then
          add_auto_change_hist(cur.f503_id, '1200', 'дата реєстрації договору', cur.p1200_r, cur.p1200_vk);
        end if;
        if nvl(cur.p1300_r,'-1')    != nvl(cur.p1300_vk,'-1')  then
          add_auto_change_hist(cur.f503_id, '1300', 'назва кредитора/кредитної лінії', cur.p1300_r, cur.p1300_vk);
        end if;
        if nvl(cur.p1400_r,'-1')    != nvl(cur.p1400_vk,'-1') then
          add_auto_change_hist(cur.f503_id, '1400', 'тип кредитора', cur.p1400_r, cur.p1400_vk);
        end if;
        if nvl(cur.p1500_r,'-1')    != nvl(cur.p1500_vk,'-1') then
          add_auto_change_hist(cur.f503_id, '1500', 'тип кредиту', cur.p1500_r, cur.p1500_vk);
        end if;
        if nvl(cur.p1600_r,'-1')    != nvl(cur.p1600_vk,'-1') then
          add_auto_change_hist(cur.f503_id, '1600', 'код можливості дострокового погашення заборгованості', cur.p1600_r, cur.p1600_vk);
        end if;
        if nvl(cur.p1800_r,'-1')    != nvl(cur.p1800_vk,'-1')  then
          add_auto_change_hist(cur.f503_id, '1800', 'код підстави подання звіту', cur.p1800_r, cur.p1800_vk);
        end if;
        if nvl(cur.p1900_r,'-1')    != nvl(cur.p1900_vk,'-1') then
          add_auto_change_hist(cur.f503_id, '1900', 'код строковості кредиту', cur.p1900_r, cur.p1900_vk);
        end if;
        if nvl(cur.p9500_r,'-1')    != nvl(cur.p9500_vk,'-1') then
          add_auto_change_hist(cur.f503_id, '9500', 'величина процентної ставки за основною сумою боргу', cur.p9500_r, cur.p9500_vk);
        end if;
        if nvl(cur.p9600_r,'-1')    != nvl(cur.p9600_vk,'-1') then
          add_auto_change_hist(cur.f503_id, '9600', 'цілі використання кредиту', cur.p9600_r, cur.p9600_vk);
        end if;
        if nvl(cur.p3100_r,to_date('01011970','DDMMYYYY'))    != nvl(cur.p3100_vk,to_date('01011970','DDMMYYYY')) then
          add_auto_change_hist(cur.f503_id, '3100', 'строк погашення кредиту', cur.p3100_r, cur.p3100_vk);
        end if;
        if nvl(cur.p9800_r,'-1')    != nvl(cur.p9800_vk,'-1') then
          add_auto_change_hist(cur.f503_id, '9800', 'інформація щодо внесення змін до договору', cur.p9800_r, cur.p9800_vk);
        end if;
        if nvl(cur.p9900_r,'-1')    != nvl(cur.p9900_vk,'-1') then
          add_auto_change_hist(cur.f503_id, '9900', 'пояснення, яким шляхом проведена реорганізація платежів', cur.p9900_r, cur.p9900_vk);
        end if;
        if nvl(cur.p3000_r,'-1')    != nvl(cur.p3000_vk,'-1') then
          add_auto_change_hist(cur.f503_id, '3000', 'стан розрахунків за кредитом на кінець звітного періоду', cur.p3000_r, cur.p3000_vk);
        end if;
        if nvl(cur.p0100_r,'-1')    != nvl(cur.p0100_vk,'-1') then
          add_auto_change_hist(cur.f503_id, '0100', 'вид позичальника', cur.p0100_r, cur.p0100_vk);
        end if;
        if nvl(cur.p0300_r,'-1')    != nvl(cur.p0300_vk,'-1') then
          add_auto_change_hist(cur.f503_id, '0300', 'код країни кредитора', cur.p0300_r, cur.p0300_vk);
        end if;
        if nvl(cur.p0400_r,'-1')    != nvl(cur.p0400_vk,'-1') then
          add_auto_change_hist(cur.f503_id, '0400', 'тип процентної ставки за кредитом', cur.p0400_r, cur.p0400_vk);
        end if;
        if nvl(cur.p0500_r,'-1')    != nvl(cur.p0500_vk,'-1')  then
          add_auto_change_hist(cur.f503_id, '0500', 'номер кредитної угоди', cur.p0500_r, cur.p0500_vk);
        end if;
        if nvl(cur.p0600_r,to_date('01011970','DDMMYYYY'))    != nvl(cur.p0600_vk,to_date('01011970','DDMMYYYY')) then
          add_auto_change_hist(cur.f503_id, '0600', 'дата кредитної угоди', cur.p0600_r, cur.p0600_vk);
        end if;
        if nvl(cur.p0700_r,'-1')    != nvl(cur.p0700_vk,'-1') then
          add_auto_change_hist(cur.f503_id, '0700', 'розмір маржі процентної ставки за кредитом', cur.p0700_r, cur.p0700_vk);
        end if;
        if nvl(cur.p0800_1_r,'-1')  != nvl(cur.p0800_1_vk,'-1') then
          add_auto_change_hist(cur.f503_id, '0800_1', 'база для обчислення плаваючої ставки за кредитом', cur.p0800_1_r, cur.p0800_1_vk);
        end if;
        if nvl(cur.p0800_2_r,'-1')  != nvl(cur.p0800_2_vk,'-1') then
          add_auto_change_hist(cur.f503_id, '0800_2', 'база для обчислення плаваючої ставки за кредитом', cur.p0800_2_r, cur.p0800_2_vk);
        end if;
        if nvl(cur.p0800_3_r,'-1')  != nvl(cur.p0800_3_vk,'-1') then
          add_auto_change_hist(cur.f503_id, '0800_3', 'база для обчислення плаваючої ставки за кредитом', cur.p0800_3_r, cur.p0800_3_vk);
        end if;
        if nvl(cur.p0900_r,'-1')    != nvl(cur.p0900_vk,'-1')  then
          add_auto_change_hist(cur.f503_id, '0900', 'загальна сума кредиту', cur.p0900_r, cur.p0900_vk);
        end if;

      end loop;

  end;

  procedure sync_f504 as
      procedure add_auto_change_hist(p_f504_id          cim_f504_auto_change_hist.f504_id%type,
                                     p_indicator_code   cim_f504_auto_change_hist.indicator_code%type,
                                     p_indicator_name   cim_f504_auto_change_hist.indicator_name%type,
                                     p_rep_value        cim_f504_auto_change_hist.rep_value%type,
                                     p_vk_value         cim_f504_auto_change_hist.vk_value%type) as
      begin
        insert into cim_f504_auto_change_hist(f504_id,
                                              indicator_code,
                                              indicator_name,
                                              rep_value,
                                              vk_value,
                                              date_change)
        values(p_f504_id,
               p_indicator_code,
               p_indicator_name,
               p_rep_value,
               p_vk_value,
               sysdate);
      end;

  begin
          --аналіз змін
      for cur in (select f.f504_id,
                         case when c.credit_type=0 then 1 when c.creditor_type=11 then 3 else 2 end as m_vk, f.m as m_r,
                         lpad(substr(c.okpo,1,10),10,'0') as z_vk,                                           f.z as z_r,
                         lpad(substr(c.r_agree_no,1,5),5,'0') as r_agree_no_vk,                              f.r_agree_no as r_agree_no_r,
                         lpad(c.kv,3,'0') as pval_vk,                                                        f.pval as pval_r,
                         substr(c.nmkk,1,27) as p101_vk,                                                     f.p101 as p101_r,
                         c.r_agree_date as p103_vk,                                                          f.p103 as p103_r,
                         substr(c.benef_name,1,54)  as p107_vk,                                              f.p107 as p107_r,
                         decode(c.creditor_type,11,1,c.creditor_type) as p108_vk,                            f.p108 as p108_r,
                         c.credit_type as p140_vk,                                                           f.p140 as p140_r,
                         c.credit_prepay as p141_vk,                                                         f.p141 as p141_r,
                         c.f503_reason as p143_vk,                                                           f.p143 as p143_r,
                         decode(c.credit_term, 3 , 1, c.credit_term) as p184_vk,                             f.p184 as p184_r,
                         c.f503_purpose as p960_vk,                                                          f.p960 as p960_r,
                         c.close_date as p310_vk,                                                            f.p310 as p310_r,
                         substr(c.num, 1, 16) as p050_vk,                                                    f.p050 as p050_r,
                         c.open_date as p060_vk,                                                             f.p060 as p060_r,
                         c.s as p090_vk,                                                                     f.p090 as p090_r,
                         c.borrower_id as p010_vk,                                                           f.p010 as p010_r,
                         c.f503_percent_margin as p070_vk,                                                   f.p070 as p070_r,
                         c.f503_percent as p950_vk,                                                          f.p950 as p950_r
                  from v_cim_credit_contracts c, cim_f504 f where c.contr_id = f.contr_id
                   and f.kf = sys_context('bars_context','user_mfo'))
      loop
        update cim_f504
        set m        = cur.m_vk,
            z        = cur.z_vk,
            r_agree_no  = cur.r_agree_no_vk,
            pval     = cur.pval_vk,
            p101 = cur.p101_vk,
            p103 = cur.p103_vk,
            p107 = cur.p107_vk,
            p108 = cur.p108_vk,
            p140 = cur.p140_vk,
            p141 = cur.p141_vk,
            p143 = cur.p143_vk,
            p184 = cur.p184_vk,
            p960 = cur.p960_vk,
            p310 = cur.p310_vk,
            p050 = cur.p050_vk,
            p060 = cur.p060_vk,
            p090 = cur.p090_vk,
            p010 = cur.p010_vk,
            p070 = cur.p070_vk,
            p950 = cur.p950_vk
        where f504_id = cur.f504_id;

        if nvl(cur.m_r,-1)        != nvl(cur.m_vk,-1)  then
          add_auto_change_hist(cur.f504_id, 'm', 'ознака кредиту', cur.m_r, cur.m_vk);
        end if;
        if nvl(cur.z_r,'-1')        != nvl(cur.z_vk,'-1')  then
          add_auto_change_hist(cur.f504_id, 'z', 'код позичальника', cur.z_r, cur.z_vk);
        end if;
        if nvl(cur.r_agree_no_r,'-1')  != nvl(cur.r_agree_no_vk,'-1') then
          add_auto_change_hist(cur.f504_id, 'n', 'номер реєстрації договору', cur.r_agree_no_r, cur.r_agree_no_vk);
        end if;
        if nvl(cur.pval_r,-1)     != nvl(cur.pval_vk,-1) then
          add_auto_change_hist(cur.f504_id, 'y', 'код валюти', cur.pval_r, cur.pval_vk);
        end if;

        if nvl(cur.p101_r,'-1')     != nvl(cur.p101_vk,'-1') then
          add_auto_change_hist(cur.f504_id, '101', 'назва позичальника', cur.p101_r, cur.p101_vk);
        end if;
        if nvl(cur.p103_r,to_date('01011970','DDMMYYYY'))     != nvl(cur.p103_vk,to_date('01011970','DDMMYYYY')) then
          add_auto_change_hist(cur.f504_id, '103', 'дата реєстрації договору', cur.p103_r, cur.p103_vk);
        end if;
        if nvl(cur.p107_r,'-1')     != nvl(cur.p107_vk,'-1') then
          add_auto_change_hist(cur.f504_id, '107', 'назва кредитора/кредитної лінії', cur.p107_r, cur.p107_vk);
        end if;
        if nvl(cur.p108_r,-1)     != nvl(cur.p108_vk,-1) then
          add_auto_change_hist(cur.f504_id, '108', 'тип кредитора', cur.p108_r, cur.p108_vk);
        end if;
        if nvl(cur.p140_r,-1)     != nvl(cur.p140_vk,-1) then
          add_auto_change_hist(cur.f504_id, '140', 'тип кредиту', cur.p140_r, cur.p140_vk);
        end if;
        if nvl(cur.p141_r,-1)     != nvl(cur.p141_vk,-1) then
          add_auto_change_hist(cur.f504_id, '141', 'код можливості дострокового погашення заборгованості', cur.p141_r, cur.p141_vk);
        end if;
        if nvl(cur.p143_r,-1)     != nvl(cur.p143_vk,-1) then
          add_auto_change_hist(cur.f504_id, '143', 'код підстави подання звіту', cur.p143_r, cur.p143_vk);
        end if;
        if nvl(cur.p184_r,-1)     != nvl(cur.p184_vk,-1) then
          add_auto_change_hist(cur.f504_id, '184', 'код строковості кредиту', cur.p184_r, cur.p184_vk);
        end if;
        if nvl(cur.p960_r,-1)     != nvl(cur.p960_vk,-1) then
          add_auto_change_hist(cur.f504_id, '960', 'цілі використання кредиту', cur.p960_r, cur.p960_vk);
        end if;
        if nvl(cur.p310_r,to_date('01011970','DDMMYYYY'))     != nvl(cur.p310_vk,to_date('01011970','DDMMYYYY')) then
          add_auto_change_hist(cur.f504_id, '310', 'строк погашення кредиту', cur.p310_r, cur.p310_vk);
        end if;
        if nvl(cur.p050_r,'-1')     != nvl(cur.p050_vk,'-1') then
          add_auto_change_hist(cur.f504_id, '050', 'номер кредитної угоди', cur.p050_r, cur.p050_vk);
        end if;
        if nvl(cur.p060_r,to_date('01011970','DDMMYYYY'))     != nvl(cur.p060_vk,to_date('01011970','DDMMYYYY')) then
          add_auto_change_hist(cur.f504_id, '060', 'дата кредитної угоди', cur.p060_r, cur.p060_vk);
        end if;
        if nvl(cur.p090_r,-1)     != nvl(cur.p090_vk,-1) then
          add_auto_change_hist(cur.f504_id, '090', 'загальна сума кредиту', cur.p090_r, cur.p090_vk);
        end if;
        if nvl(cur.p010_r,'-1')    != nvl(cur.p010_vk,'-1') then
          add_auto_change_hist(cur.f504_id, '010', 'вид позичальника', cur.p010_r, cur.p010_vk);
        end if;
        if nvl(cur.p070_r,-1)     != nvl(cur.p070_vk,-1) then
          add_auto_change_hist(cur.f504_id, '070', 'розмір маржі про-центної ставки', cur.p070_r, cur.p070_vk);
        end if;
        if nvl(cur.p950_r,-1)     != nvl(cur.p950_vk,-1) then
          add_auto_change_hist(cur.f504_id, '950', 'величина процентної ставки', cur.p950_r, cur.p950_vk);
        end if;

      end loop;

  end;

  function get_contracts_list(p_mfo         varchar2,--cim_contracts.kf%type, 
                              p_date_from   cim_contracts.open_date%type, 
                              p_date_to     cim_contracts.open_date%type,
                              p_contr_type  varchar2,--cim_contracts.contr_type%type,
                              p_kv          varchar2,--cim_contracts.kv%type,
                              p_status      varchar2--cim_contracts.status_id%type
                              ) 
  return t_arr_contracts pipelined PARALLEL_ENABLE
  is
    l_title   CONSTANT VARCHAR2 (50) := 'CIM_REPORTS.get_contracts_list: ';  
    l_branch  CONSTANT VARCHAR2 (30) := sys_context('bars_context','user_branch'); 
  
    l_t_contracts t_contracts;
    l_cur         sys_refcursor;
    
    l_sql         varchar2(4000) := 'select cc.contr_id, cc.contr_type, ct.contr_type_name, cc.num, cc.subnum, cc.rnk, c.okpo, '||chr(13)||chr(10)||
                                    '       nvl((select nmku from corps where rnk=cc.rnk), c.nmk) nmk, c.nmkk, c.custtype, c.nd, '||chr(13)||chr(10)||
                                    '       cc.status_id, cs.status_name, cc.comments,cc.branch branch_own, br.name branch_own_name, '||chr(13)||chr(10)||
                                    '       cc.kv, round(cc.s/100,2) s, cc.open_date, cc.close_date, cc.owner_uid, (select fio from staff$base where id=cc.owner_uid) owner_fio, '||chr(13)||chr(10)||
                                    '       cc.benef_id, b.benef_name, b.benef_adr, b.country_id, co.name country_name, cd.deadline, '||chr(13)||chr(10)||
                                    '       cc.service_branch, brs.name service_branch_name '||chr(13)||chr(10)||
                                    '  from cim_contracts cc '||chr(13)||chr(10)||
                                    '  join cim_contract_statuses cs on cs.status_id=cc.status_id '||chr(13)||chr(10)||
                                    '  join cim_contract_types ct on ct.contr_type_id=cc.contr_type '||chr(13)||chr(10)||
                                    '  left outer join customer c on c.rnk=cc.rnk '||chr(13)||chr(10)|| --left join бо політизована
                                    '  join cim_beneficiaries b on b.benef_id=cc.benef_id '||chr(13)||chr(10)||
                                    '  left outer join country co on co.country=b.country_id '||chr(13)||chr(10)||
                                    '  left outer join branch br on br.branch=cc.branch '||chr(13)||chr(10)||
                                    '  left outer join branch brs on brs.branch=cc.service_branch '||chr(13)||chr(10)||
                                    '  left outer join cim_contracts_trade cd on cd.contr_id=cc.contr_id '||chr(13)||chr(10);
    l_sql_where   varchar2(1000) := ' where 1=1 ';
    l_sql_order   varchar2(255)  := ' order by cc.branch, cc.contr_id';
  begin
    bars_audit.info(l_title||' Пуск l_branch='||l_branch);
    if (l_branch is not null and l_branch not in ('/', '/300465/')) or (p_mfo = 'Поточне' and sys_context('bars_context','user_mfo') is not null) then 
      --тільки ЦА або "/" може бачити все (таблиці на час розробки звіту неполітизовані тому є можливість для ЦА бачити всіх)
      --таблиця customer політизована, тому якщо в табл. corps немає записів то для 300465 найменування організаціїї буде пустим
      l_sql_where := l_sql_where||' and cc.kf = '''||sys_context('bars_context','user_mfo')||''' '||chr(13)||chr(10);
    end if;  
    
    if p_mfo is not null and p_mfo != '%' and p_mfo != 'Поточне' then
      l_sql_where := l_sql_where||' and cc.kf = '''||replace(p_mfo,'/','')||''' '||chr(13)||chr(10);
    end if;  
    if p_date_from is not null then
      l_sql_where := l_sql_where||' and cc.open_date >= to_date('''||to_char(p_date_from,'DDMMYYYY')||''',''DDMMYYYY'') '||chr(13)||chr(10);
    end if;   
    if p_date_to is not null then
      l_sql_where := l_sql_where||' and cc.open_date <= to_date('''||to_char(p_date_to,'DDMMYYYY')||''',''DDMMYYYY'') '||chr(13)||chr(10);
    end if;   
    if p_contr_type is not null and  p_contr_type != '%' then
      l_sql_where := l_sql_where||' and cc.contr_type = '||p_contr_type||' '||chr(13)||chr(10);
    end if;    
    if p_kv is not null and p_kv != '%' then
      l_sql_where := l_sql_where||' and cc.kv = '||p_kv||' '||chr(13)||chr(10);
    end if;    
    if p_status is not null and p_status != '%' then
      l_sql_where := l_sql_where||' and cc.status_id = '||p_status||' '||chr(13)||chr(10);
    end if;     
    
    bars_audit.info(l_title||' SQL = '||chr(13)||chr(10)||l_sql||l_sql_where||l_sql_order);
    open l_cur for l_sql||l_sql_where||l_sql_order;
    loop
      fetch l_cur into l_t_contracts;
      exit when l_cur%notfound;

      pipe row (l_t_contracts);     
    end loop;
    close l_cur;
  end;    


end cim_reports;
/
 show err;
 
PROMPT *** Create  grants  CIM_REPORTS ***
grant EXECUTE                                                                on CIM_REPORTS     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CIM_REPORTS     to CIM_ROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/cim_reports.sql =========*** End ***
 PROMPT ===================================================================================== 
 