
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bpk_credits.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BPK_CREDITS 
is

  --
  -- constants
  --
  g_header_version  constant varchar2(64)  := 'version 1.01 02.10.2015';

  --
  -- Службові функції (версія пакету)
  --
  function header_version return varchar2;
  function body_version   return varchar2;

  --
  -- fill_bpk_credit_deal
  --
  --   p_date        - звітна дата
  --   p_param       - параметр запуску:
  --                   1 - формування даних по субдоговорах  з  врахуванням коригуючих оборотів
  --                   0 - формування даних по субдоговорах без врахуванням коригуючих оборотів
  --                null - лише донаповнення списку договорів які відповідають умовам відбору для вивантаження у FineVare
  --
  procedure fill_bpk_credit_deal
  ( p_date           in     date
  , p_param          in     pls_integer default 0
  );

  --
  -- fill_bpk_credit_data
  --
  --   p_report_date - звітна дата
  --   p_adjustment  - (1-з/0-без) коригуючих
  --
  procedure fill_bpk_credit_data
  ( p_report_date    in     date
  , p_adjustment     in     pls_integer default 0
  );

  procedure set_accw_DATEOFKK;

end BPK_CREDITS;
/
CREATE OR REPLACE PACKAGE BODY BARS.BPK_CREDITS 
is
  --
  -- constants
  --
  g_body_version             constant varchar2(64)  := 'version 1.09 16.11.2017';

  --
  -- variables
  --
  l_rep_dt        date;


  --
  -- types
  --
  type r_close_dt_type is record ( deal_nd   bpk_credit_deal.deal_nd%type
                                 , close_dt  bpk_credit_deal.close_dt%type );
  type t_close_dt_type is table of r_close_dt_type;
  t_close_dt           t_close_dt_type;

  --
  -- повертає версію заголовка пакета
  --
  function header_version
    return varchar2
  is
  begin
    return 'Package DPU_AGR header '||g_header_version||'.';
  end header_version;

  --
  -- повертає версію тіла пакета
  --
  function body_version
    return varchar2
  is
  begin
    return 'Package DPU_AGR body ' || g_body_version || '.';
  end body_version;
  ------------------------------------------------------------------------------
  --COBUMMFO-8742
  --встановлення параметру DATEOFKK «Дата визнання кредиту проблемним на КК» 
  --на карковий рахунок  
  --визначається кількість днів прострочення % та тіла по кредиту за БПК
  --при кількості >90 - виставляється параметр DATEOFKK
   procedure set_accw_DATEOFKK
    as  
/* -------ver. 1   
   l_deltaDay integer:=90;     
   l_tagToSet varchar(10):='DATEOFKK';
   l_ob22_2207 varchar(10):='87';
   l_ob22_2209 varchar(10):='I3';
  begin    
   for rec in (  
     select  w.acc_pk
      from w4_acc w 
      inner join 
             --2203 Прострочена заборгованість за кредитами------ 
            (select   
              wa.acc_pk,a_2207.nls,a_2207.ostc
--              ,(select  max(fdat) from saldoa where acc =wa.acc_2207   and ostf = 0 ) date_ost
              ,dat_spz(wa.acc_2207,bankdate,1)date_ost
             from w4_acc wa
                  inner join accounts a_2207 on a_2207.acc=wa.acc_2207 and a_2207.ostc<>0 and a_2207.ob22=l_ob22_2207 
             where wa.acc_2207 is not null )  t_2203 
             ----------------------------------------------------
      on t_2203.acc_pk=w.acc_pk
      inner join 
             --2208 Прострочені нараховані доходи за кредитами--- 
            (select   
              wa.acc_pk,a_2209.nls,a_2209.ostc
--              ,(select  max(fdat) from saldoa where acc =wa.acc_2209   and ostf = 0 ) date_ost
              ,dat_spz(wa.acc_2209,bankdate,1)date_ost
             from w4_acc wa
                  inner join accounts a_2209 on a_2209.acc=wa.acc_2209 and a_2209.ostc<>0 and a_2209.ob22=l_ob22_2209 
             where wa.acc_2209 is not null ) t_2208 
             ----------------------------------------------------
      on t_2208.acc_pk=w.acc_pk
    where    ( bankdate-t_2203.date_ost >l_deltaDay  or bankdate-t_2208.date_ost >l_deltaDay)
              and not  exists (select 1 from accountsw where acc=w.acc_pk and tag=l_tagToSet )
                ) 
   loop --встановлення параметру
      accreg.setAccountwParam(rec.acc_pk,l_tagToSet,bankdate );
   end loop;*/
   -------ver. 2 
 l_mfo_cnt  integer;
 l_try number;
 l_status number;
 v_taskname varchar2(15):='SET_DATEOFKK';
     
 
-- v_ob22_2207 varchar(10):='87';
-- v_ob22_2209 varchar(10):='I3';
 v_chunk_stmt varchar2(128) := 'select kf as START_ID, kf as END_ID from bars.mv_kf ';
 v_task_statement varchar2(4000) := q'[
begin 

 bars.bc.go(:START_ID);
 logger.info('SET_DATEOFKK run for '||:END_ID);

 for rec in 
   (
     select wa.acc_pk ,wa.kf
     from w4_acc wa      
             inner join accounts a_2207 on a_2207.acc=wa.acc_2207 and a_2207.ostc<>0 and a_2207.ob22='87' 
             inner join accounts a_2209 on a_2209.acc=wa.acc_2209 and a_2209.ostc<>0 and a_2209.ob22='I3'            
     where       
      ( 
        bankdate-(dat_spz(wa.acc_2207,bankdate,1)) >90
        or 
        bankdate-(dat_spz(wa.acc_2209,bankdate,1)) >90
      ) 
      and not  exists (select 1 from accountsw where acc=wa.acc_pk and tag='DATEOFKK' )      
   )
 loop
    --встановлення параметру
    accreg.setAccountwParam(rec.acc_pk,'DATEOFKK',bankdate);
    logger.info ('SET_DATEOFKK:'||rec.kf||':'|| rec.acc_pk);               
 end loop;  
            
  commit;
  bc.home;     
exception 
  when others then 
        logger.info('SET_DATEOFKK Error:'||sqlerrm);
end;
]';

 task_doesnt_exist exception;
 pragma exception_init(task_doesnt_exist, -29498);

begin
    begin
        DBMS_PARALLEL_EXECUTE.DROP_TASK (v_taskname);
    exception
        when task_doesnt_exist then null;
    end;
  
    select count(*) into l_mfo_cnt from mv_kf;
  
    dbms_parallel_execute.create_task(v_taskname);
  
    dbms_parallel_execute.create_chunks_by_sql(task_name => v_taskname,
                                             sql_stmt  => v_chunk_stmt,
                                             by_rowid  => false);
                                             
  -- запуск задачи по всем МФО
    dbms_parallel_execute.run_task(task_name      => v_taskname,
                                 sql_stmt       => v_task_statement,
                                 language_flag  => dbms_sql.native,
                                 parallel_level => l_mfo_cnt);    
  --== проверка окончания работы таски
    l_try    := 0;
    l_status := dbms_parallel_execute.task_status(v_taskname);
    while (l_try < 2 and l_status != dbms_parallel_execute.finished) loop
        l_try := l_try + 1;
        dbms_parallel_execute.resume_task(v_taskname);
        l_status := dbms_parallel_execute.task_status(v_taskname);
    end loop;                                         
    commit;

    exception
        when others then
             bars_audit.error(' error during execution procedure set_accw_DATEOFKK: ' ||
                         dbms_utility.format_error_stack() || chr(10) ||
                         dbms_utility.format_error_backtrace());                                                                          

end set_accw_DATEOFKK;
  ------------------------------------------------------------------------------
  -- fill_bpk_credit_deal  -- (до)наповнення портфеля договорів
  --
  --   p_date  - дата
  --   p_param - параметр запуску
  --
  procedure fill_bpk_credit_deal
  ( p_date           in     date
  , p_param          in     pls_integer default 0
  ) is
    title  constant  varchar2(60) := 'bpk_credits.fill_bpk_credit_deal';
    l_min_dt         date;
    l_kf             bpk_credit_deal.kf%type;
  begin

    bars_audit.info( title || ': Розпочато наповнення портфелю договорів кредитних лімітів по БПК ( p_date => ' ||
                     to_char(p_date,'dd/mm/yyyy') || ', p_param => ' || to_char(p_param) || ' ).');

    if ( p_date is Null )
    then
      l_rep_dt := trunc(sysdate,'MM');
    else
      l_rep_dt := trunc(p_date ,'MM');
    end if;

    l_min_dt := add_months(l_rep_dt,-1);

    l_kf := sys_context('bars_context','user_mfo');

    bars_audit.info( title || ': l_min_dt = ' || to_char(l_min_dt,'dd/mm/yyyy')
                           || ', l_kf = '     || l_kf || ' ).' );

    -- синхронізація дат закриття договорів (реанімований або закритий)
    -- зміна значення дати закриття на даний момент не передбачається!
    select d.DEAL_ND, b.DAT_CLOSE
      bulk collect
      into t_close_dt
      from ( select KF, ND, DAT_CLOSE, 'W4'  as PC_TYPE
               from BARS.W4_ACC
              union all
             select KF, ND, DAT_CLOSE, 'BPK' as PC_TYPE
               from BARS.BPK_ACC
           ) b
      join BARS.BPK_CREDIT_DEAL d
        on ( b.KF = d.KF and b.ND = d.CARD_ND and b.PC_TYPE = d.PC_TYPE )
     where ( b.DAT_CLOSE Is Null     and d.CLOSE_DT Is Not Null )
        or ( b.DAT_CLOSE Is Not Null and d.CLOSE_DT Is Null     );

    if ( t_close_dt.count > 0 )
    then

      FORALL i IN t_close_dt.first .. t_close_dt.last
      update BARS.BPK_CREDIT_DEAL
         set CLOSE_DT = t_close_dt(i).CLOSE_DT
       where DEAL_ND  = t_close_dt(i).DEAL_ND;

      bars_audit.info(title || ': Updated '||to_char(sql%rowcount)||' records.' );

      t_close_dt.delete();

    end if;

    -- донаповнення договорами ( + рекодування ідентифікаторів для DWH )
    insert /*+ APPEND */
      into BARS.BPK_CREDIT_DEAL
         ( KF, CARD_ND,  DEAL_ND,  DEAL_SUM, DEAL_KV,  DEAL_RNK,
           OPEN_DT,  MATUR_DT, CLOSE_DT, CREATE_DT,
           ACC_9129, ACC_OVR,  ACC_2208, ACC_2207, ACC_2209, PC_TYPE )
    select /*+ parallel */ o.KF
         , o.ND
         , bars_sqnc.get_nextval('S_CC_DEAL')
         , o.LIM, o.KV, o.RNK
         , o.DATE_BEGIN, o.DATE_END, o.DATE_CLOSE, SYSDATE
         , o.ACC_9129, o.ACC_OVR, o.ACC_2208, o.ACC_2207, o.ACC_2209, o.PC_TYPE
      from ( select a.KV, a.RNK,
                    coalesce(a.LIM,0) as LIM,
                    a.daos as DATE_BEGIN,
                    add_months(a.daos, 12) as DATE_END,
                    a.dazs as DATE_CLOSE,
                    b.KF, b.ND, b.ACC_9129, b.ACC_OVR, b.ACC_2208, b.ACC_2207, b.ACC_2209,
                    'BPK' as PC_TYPE
               from BARS.BPK_ACC  b
               join BARS.ACCOUNTS a
                 on ( a.ACC = b.ACC_PK )
              where coalesce( ACC_9129, ACC_OVR, ACC_2208, ACC_2207, ACC_2209, 0 ) > 0
                and a.DAOS < l_rep_dt      -- рахунок БПК відкритий до звітної дати
                and 1 <= ( select count(1) -- є хоча б один не закритий рахунок
                             from BARS.ACCOUNTS
                            where ACC in ( ACC_9129, ACC_OVR, ACC_2208, ACC_2207, ACC_2209 )
                              and ( DAZS is Null OR ( DAZS >= l_min_dt AND DAPP >= l_min_dt ) )
                         )
              union all
             select a.KV, a.RNK,
                    coalesce(a.LIM,0) as LIM,
                    b.DAT_BEGIN as DATE_BEGIN,
                    b.DAT_END   as DATE_END,
                    b.DAT_CLOSE as DATE_CLOSE,
                    b.KF, b.ND, ACC_9129, ACC_OVR, ACC_2208, ACC_2207, ACC_2209,
                    'W4' PC_TYPE
               from BARS.W4_ACC b
               join BARS.ACCOUNTS a
                 on ( a.acc = b.acc_pk )
              where coalesce( ACC_9129, ACC_OVR, ACC_2208, ACC_2207, ACC_2209, 0 ) > 0
                and a.daos < l_rep_dt      -- рахунок БПК відкритий до звітної дати
                and 1 <= ( select count(1) -- є хоча б один не закритий рахунок
                             from BARS.ACCOUNTS
                            where ACC in ( ACC_9129, ACC_OVR, ACC_2208, ACC_2207, ACC_2209 )
                              and ( DAZS is Null OR ( DAZS >= l_min_dt AND DAPP >= l_min_dt ) )
                         )
           ) o
      left
      join BARS.BPK_CREDIT_DEAL dc
        on ( dc.KF = o.KF and dc.CARD_ND = o.ND )
     where dc.CARD_ND Is Null; -- Ще відсутні в портфелі

    bars_audit.info( title || ': Завершено наповнення портфелю договорів (вставлено ' ||
                     to_char(sql%rowcount) || ' записів.' );
    commit;

    -- наповнення даних по залишкам на рахунках договорів кредитних лімітів БПК на звітну дату
    if ( p_param in (0,1) )
    then
      fill_bpk_credit_data( p_report_date => l_rep_dt,
                            p_adjustment  => p_param );
    end if;

  end fill_bpk_credit_deal;


  ------------------------------------------------------------------------------
  -- fill_bpk_credit_data
  --
  --   p_report_date - звітна дата
  --   p_adjustment  - коригуючі обороти:
  --                   0 - без коригуючих
  --                   1 - з коригуючими
  --
  procedure fill_bpk_credit_data
  ( p_report_date   in   date
  , p_adjustment    in   pls_integer default 0
  ) is
    title      constant  varchar2(60) := 'bpk_credits.fill_bpk_credit_data';
    l_err_tag            varchar2(30);
    l_create_dt          bpk_credit_deal_var.create_dt%type;
    l_balance_dt         agg_monbals.fdat%type;
  begin

    bars_audit.info( title || ': Розпочато наповнення даних по договорам кредитних лімітів БПК на звітну дату ' ||
                     to_char(p_report_date,'dd/mm/yyyy') ||
                     case when p_adjustment = 1 then ' з коригуючими.' else ' без коригуючих.' end );

    l_create_dt := sysdate;

    if ( p_report_date is Null )
    then
      l_rep_dt := trunc(sysdate      ,'MM');
    else
      l_rep_dt := trunc(p_report_date,'MM');
    end if;

    delete BPK_CREDIT_DEAL_VAR
     where REPORT_DT = p_report_date
       and ADJ_FLG   = p_adjustment;

    l_balance_dt := add_months(l_rep_dt,-1); -- перший день звітного міс.

    l_err_tag := to_char(p_report_date,'dd/mm/yyyy') || '-' || to_char(p_adjustment);

    delete BPK_CREDIT_DEAL_VAR_ERRLOG
     where ORA_ERR_TAG$ = l_err_tag;

    insert /*+ APPEND */
      into BPK_CREDIT_DEAL_VAR
         ( REPORT_DT, KF, DEAL_ND, DEAL_SUM, DEAL_RNK, RATE, MATUR_DT, SS, SN, SP, SPN, CR9, CREATE_DT, ADJ_FLG )
    select /*+ PARALLEL */
           l_rep_dt,
           cd.KF,
           cd.DEAL_ND,
           cd.LIM,
           coalesce(cd.RNK, cd.DEAL_RNK) as RNK,
           acrn.fprocn(cd.acc_ovr, 0, l_rep_dt-1) as RATE,
           coalesce(cd.DAT_END, cd.MDATE) as MDATE,
           nvl(cd.SS, 0) as SS,
           nvl(cd.SN, 0) as SN,
           nvl(cd.SP, 0) as SP,
           nvl(cd.SPN,0) as SPN,
           nvl(cd.CR9,0) as CR9,
           l_create_dt,
           p_adjustment
      from ( select dc.KF
                  , dc.DEAL_ND
                  , dc.DEAL_RNK
                  , w4.ACC_OVR
                  , w4.DAT_END
                  , max(case when  a.ACC = w4.ACC_OVR then a.MDATE    else Null end) MDATE
                  , max(case when  a.ACC = w4.ACC_OVR then a.RNK      else Null end) RNK
                  , max(case when  a.ACC = w4.ACC_OVR then abs(a.LIM) else    0 end) LIM
                  , sum(case when ms.ACC = w4.ACC_OVR
                             then case when p_adjustment = 1 then (ms.OST - ms.CRDOS + ms.CRKOS) else ms.OST end
                             else 0 end) SS
                  , sum(case when ms.ACC = w4.ACC_2208
                             then case when p_adjustment = 1 then (ms.OST - ms.CRDOS + ms.CRKOS) else ms.OST end
                             else 0 end) SN
                  , sum(case when ms.ACC = w4.ACC_2207
                             then case when p_adjustment = 1 then (ms.OST - ms.CRDOS + ms.CRKOS) else ms.OST end
                             else 0 end) SP
                  , sum(case when ms.ACC = w4.ACC_2209
                             then case when p_adjustment = 1 then (ms.OST - ms.CRDOS + ms.CRKOS) else ms.OST end
                             else 0 end) SPN
                  , sum(case when ms.ACC = w4.ACC_9129
                             then case when p_adjustment = 1 then (ms.OST - ms.CRDOS + ms.CRKOS) else ms.OST end
                             else 0 end) CR9
               from BPK_CREDIT_DEAL dc,
                    ( select KF, ND, ACC_9129, ACC_OVR, ACC_2208, ACC_2207, ACC_2209, DAT_END
                           , 'W4' PC_TYPE
                        from W4_ACC_UPDATE
                       where IDUPD in ( select max(u.IDUPD)
                                          from W4_ACC_UPDATE u
                                         where u.EFFECTDATE < l_rep_dt
                                         group by u.ND )
                       union all
                      select KF, ND, ACC_9129, ACC_OVR, ACC_2208, ACC_2207, ACC_2209, DAT_END
                           , 'BPK' as PC_TYPE
                        from BPK_ACC
                    ) w4,
                    table(sys.ODCINumberList(w4.ACC_9129, w4.ACC_OVR, w4.ACC_2208, w4.ACC_2207, w4.ACC_2209)) l,
                    AGG_MONBALS ms,
                    ACCOUNTS     a
              where w4.KF      = dc.KF
                and w4.ND      = dc.CARD_ND
                and w4.PC_TYPE = dc.PC_TYPE
                and a.ACC      = l.COLUMN_VALUE
                and ms.acc(+)  = l.COLUMN_VALUE
                and ms.FDAT(+) = l_balance_dt
              group by dc.KF, dc.DEAL_ND, dc.DEAL_RNK, w4.ACC_OVR, w4.DAT_END, dc.CLOSE_DT
             having ( dc.CLOSE_DT Is Null
                      OR
                      dc.CLOSE_DT >= l_balance_dt
                      OR
                      dc.CLOSE_DT <  l_balance_dt AND sum(ms.OST) <> 0 )
           ) cd;
    /*
    LOG ERRORS
    INTO BPK_CREDIT_DEAL_VAR_ERRLOG ( l_err_tag )
    REJECT LIMIT UNLIMITED;
    */

    bars_audit.info( title || ': внесено ' || to_char(sql%rowcount) || ' записів.' );

    commit;

    bars_audit.info( title || ': Завершено наповнення даних по договорам кредитних лімітів БПК.' );

  end fill_bpk_credit_data;

  ---
BEGIN

  NULL;

END BPK_CREDITS;
/
 show err;
 
PROMPT *** Create  grants  BPK_CREDITS ***
grant EXECUTE                                                                on BPK_CREDITS     to BARSUPL;
grant EXECUTE                                                                on BPK_CREDITS     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BPK_CREDITS     to OW;
grant EXECUTE                                                                on BPK_CREDITS     to UPLD;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bpk_credits.sql =========*** End ***
 PROMPT ===================================================================================== 
 