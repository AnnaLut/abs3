-- ======================================================================================
-- Module : UPL - Вивантаження даних до DWH
-- Author : V.Kharin
-- Date   : 05.07.2017
-- Update : 20.12.2017 - KVA обработка всех МФО в БД
-- синхронизация W4_ACC_UPDATE  vs W4_ACC
-- ======================================================================================

ALTER SESSION ENABLE PARALLEL DML;


declare
  l_global_bd      date;
  l_kf             varchar2(6);
begin

  for lc_kf in (select kf from bars.mv_kf where kf = l_kf or l_kf = '' or l_kf is null)
  loop
    DBMS_OUTPUT.PUT_LINE('Start W4_ACC sinchronize for = ' || lc_kf.kf);
    begin
        l_kf := lc_kf.kf;
        bars.bc.go(l_kf);
        l_global_bd := bars.glb_bankdate; -- глобальная банковская дата

        Insert /*+ APPEND */ into BARS.W4_ACC_UPDATE
           (idupd, chgaction, effectdate, chgdate, doneby, 
            nd, acc_pk, acc_ovr, acc_9129, acc_3570, acc_2208, acc_2627, acc_2207, acc_3579, acc_2209, 
            card_code, acc_2625x, acc_2627x, acc_2625d, acc_2628, acc_2203, fin, fin23, obs23, kat23, 
            k23, dat_begin, dat_end, dat_close, pass_date, pass_state, kol_sp, s250, grp, global_bdate, kf)
        with db as (select id from bars.staff$base where logname = 'BARSUPL')
        select  bars_sqnc.get_nextval('s_w4acc_update', coalesce(n.KF, u.KF)) as idupd,
                case when n.nd is null then 'D' else decode(u.chgaction, null, 'I', 'U') end as chgaction,
                NVL( greatest( coalesce(u.EFFECTDATE, to_date('01/01/1900', 'dd/mm/yyyy')), -- максимальный из update
                               (select max(a.daos) dt               -- либо максимальная дата открытия счета
                                  from bars.accounts a
                                 where a.acc in (n.acc_pk, n.acc_ovr, n.acc_9129, n.acc_3570, n.acc_2208, n.acc_2627, n.acc_2207,
                                                 n.acc_3579, n.acc_2209, n.acc_2625x, n.acc_2627x, n.acc_2625d, n.acc_2628, n.acc_2203)
                               )),
                     bars.gl.bd)                     as effectdate, -- либо текущая (по умолчанию)
                sysdate                              as chgdate,
                db.id                                as doneby,
                coalesce(n.nd,         u.nd)         as nd,
                coalesce(n.acc_pk ,    u.acc_pk )    as acc_pk ,
                coalesce(n.acc_ovr,    u.acc_ovr)    as acc_ovr,
                coalesce(n.acc_9129,   u.acc_9129)   as acc_9129,
                coalesce(n.acc_3570,   u.acc_3570)   as acc_3570,
                coalesce(n.acc_2208,   u.acc_2208)   as acc_2208,
                coalesce(n.acc_2627,   u.acc_2627)   as acc_2627,
                coalesce(n.acc_2207,   u.acc_2207)   as acc_2207,
                coalesce(n.acc_3579,   u.acc_3579)   as acc_3579,
                coalesce(n.acc_2209 ,  u.acc_2209 )  as acc_2209 ,
                coalesce(n.card_code,  u.card_code)  as card_code,
                coalesce(n.acc_2625x,  u.acc_2625x)  as acc_2625x,
                coalesce(n.acc_2627x,  u.acc_2627x)  as acc_2627x,
                coalesce(n.acc_2625d,  u.acc_2625d)  as acc_2625d,
                coalesce(n.acc_2628,   u.acc_2628)   as acc_2628,
                coalesce(n.acc_2203,   u.acc_2203)   as acc_2203,
                coalesce(n.fin,        u.fin)        as fin,
                coalesce(n.fin23,      u.fin23)      as fin23,
                coalesce(n.obs23,      u.obs23)      as obs23,
                coalesce(n.kat23,      u.kat23)      as kat23,
                coalesce(n.k23,        u.k23)        as k23,
                coalesce(n.dat_begin,  u.dat_begin)  as dat_begin,
                coalesce(n.dat_end,    u.dat_end)    as dat_end,
                coalesce(n.dat_close,  u.dat_close)  as dat_close,
                coalesce(n.pass_date,  u.pass_date)  as pass_date,
                coalesce(n.pass_state, u.pass_state) as pass_state,
                coalesce(n.kol_sp,     u.kol_sp)     as kol_sp,
                coalesce(n.s250,       u.s250)       as s250,
                coalesce(n.grp,        u.grp)        as grp,
                l_global_bd                          as global_bdate,
                coalesce(n.kf,         u.kf)         as kf
          from (select *
                  from BARS.W4_ACC_UPDATE
                 where IDUPD in ( select MAX(IDUPD)
                                    from BARS.W4_ACC_UPDATE
                                   group by nd )
               ) u
               full outer join
               BARS.W4_ACC n on (u.nd = n.nd and u.kf = n.kf and u.chgaction != 'D'),
               db
         where (decode(n.ACC_PK,    u.ACC_PK,    1,0) =0 or
                decode(n.ACC_OVR,   u.ACC_OVR,   1,0) =0 or
                decode(n.ACC_9129,  u.ACC_9129,  1,0) =0 or
                decode(n.ACC_3570,  u.ACC_3570,  1,0) =0 or
                decode(n.ACC_2208,  u.ACC_2208,  1,0) =0 or
                decode(n.ACC_2627,  u.ACC_2627,  1,0) =0 or
                decode(n.ACC_2207,  u.ACC_2207,  1,0) =0 or
                decode(n.ACC_3579,  u.ACC_3579,  1,0) =0 or
                decode(n.ACC_2209,  u.ACC_2209,  1,0) =0 or
                decode(n.CARD_CODE, u.CARD_CODE, 1,0) =0 or
                decode(n.ACC_2625X, u.ACC_2625X, 1,0) =0 or
                decode(n.ACC_2627X, u.ACC_2627X, 1,0) =0 or
                decode(n.ACC_2625D, u.ACC_2625D, 1,0) =0 or
                decode(n.ACC_2628,  u.ACC_2628,  1,0) =0 or
                decode(n.ACC_2203,  u.ACC_2203,  1,0) =0 or
                decode(n.FIN,       u.FIN,       1,0) =0 or
                decode(n.FIN23,     u.FIN23,     1,0) =0 or
                decode(n.OBS23,     u.OBS23,     1,0) =0 or
                decode(n.KAT23,     u.KAT23,     1,0) =0 or
                decode(n.K23,       u.K23,       1,0) =0 or
                decode(n.DAT_BEGIN, u.DAT_BEGIN, 1,0) =0 or
                decode(n.DAT_END,   u.DAT_END,   1,0) =0 or
                decode(n.DAT_CLOSE, u.DAT_CLOSE, 1,0) =0 or
                decode(n.PASS_DATE, u.PASS_DATE, 1,0) =0 or
                decode(n.PASS_STATE,u.PASS_STATE,1,0) =0 or
                decode(n.KOL_SP,    u.KOL_SP,    1,0) =0 or
                decode(n.S250,      u.S250,      1,0) =0 or
                decode(n.GRP,       u.GRP,       1,0) =0 )
           and (u.chgaction is null or u.chgaction != 'D');
        DBMS_OUTPUT.PUT_LINE('Sinchronize W4_ACC_UPDATE = ' || sql%rowcount || ' row(s) inserted =');
        COMMIT;
        --rollback;

    exception when others then
       if sqlcode = -6550 then null;
       else
          rollback;
          raise;
       end if;
    end;
  end loop;
end;
/

--********************
-- Количество расхождений по полям
--********************
/*
with db as (select id from bars.staff$base where logname = 'BARSUPL')
select  sum(1)                                     as TOTAL,
        sum(decode(n.ACC_PK,    u.ACC_PK,    0,1)) as ACC_PK,
        sum(decode(n.ACC_OVR,   u.ACC_OVR,   0,1)) as ACC_OVR,  
        sum(decode(n.ACC_9129,  u.ACC_9129,  0,1)) as ACC_9129, 
        sum(decode(n.ACC_3570,  u.ACC_3570,  0,1)) as ACC_3570, 
        sum(decode(n.ACC_2208,  u.ACC_2208,  0,1)) as ACC_2208, 
        sum(decode(n.ACC_2627,  u.ACC_2627,  0,1)) as ACC_2627, 
        sum(decode(n.ACC_2207,  u.ACC_2207,  0,1)) as ACC_2207, 
        sum(decode(n.ACC_3579,  u.ACC_3579,  0,1)) as ACC_3579, 
        sum(decode(n.ACC_2209,  u.ACC_2209,  0,1)) as ACC_2209, 
        sum(decode(n.CARD_CODE, u.CARD_CODE, 0,1)) as CARD_CODE,
        sum(decode(n.ACC_2625X, u.ACC_2625X, 0,1)) as ACC_2625X,
        sum(decode(n.ACC_2627X, u.ACC_2627X, 0,1)) as ACC_2627X,
        sum(decode(n.ACC_2625D, u.ACC_2625D, 0,1)) as ACC_2625D,
        sum(decode(n.ACC_2628,  u.ACC_2628,  0,1)) as ACC_2628, 
        sum(decode(n.ACC_2203,  u.ACC_2203,  0,1)) as ACC_2203, 
        sum(decode(n.FIN,       u.FIN,       0,1)) as FIN,      
        sum(decode(n.FIN23,     u.FIN23,     0,1)) as FIN23,    
        sum(decode(n.OBS23,     u.OBS23,     0,1)) as OBS23,    
        sum(decode(n.KAT23,     u.KAT23,     0,1)) as KAT23,    
        sum(decode(n.K23,       u.K23,       0,1)) as K23,      
        sum(decode(n.DAT_BEGIN, u.DAT_BEGIN, 0,1)) as DAT_BEGIN,
        sum(decode(n.DAT_END,   u.DAT_END,   0,1)) as DAT_END,  
        sum(decode(n.DAT_CLOSE, u.DAT_CLOSE, 0,1)) as DAT_CLOSE,
        sum(decode(n.PASS_DATE, u.PASS_DATE, 0,1)) as PASS_DATE,
        sum(decode(n.PASS_STATE,u.PASS_STATE,0,1)) as PASS_STATE,
        sum(decode(n.KOL_SP,    u.KOL_SP,    0,1)) as KOL_SP,   
        sum(decode(n.S250,      u.S250,      0,1)) as S250,     
        sum(decode(n.GRP,       u.GRP,       0,1)) as GRP      
  from (select *
          from BARS.W4_ACC_UPDATE
         where IDUPD in ( select MAX(IDUPD)
                            from BARS.W4_ACC_UPDATE
                           group by nd )
       ) u
       full outer join
       BARS.W4_ACC n on (u.nd = n.nd and u.kf = n.kf and u.chgaction != 'D'),
       db
 where (decode(n.ACC_PK,    u.ACC_PK,    1,0) =0 or
        decode(n.ACC_OVR,   u.ACC_OVR,   1,0) =0 or
        decode(n.ACC_9129,  u.ACC_9129,  1,0) =0 or
        decode(n.ACC_3570,  u.ACC_3570,  1,0) =0 or
        decode(n.ACC_2208,  u.ACC_2208,  1,0) =0 or
        decode(n.ACC_2627,  u.ACC_2627,  1,0) =0 or
        decode(n.ACC_2207,  u.ACC_2207,  1,0) =0 or
        decode(n.ACC_3579,  u.ACC_3579,  1,0) =0 or
        decode(n.ACC_2209,  u.ACC_2209,  1,0) =0 or
        decode(n.CARD_CODE, u.CARD_CODE, 1,0) =0 or
        decode(n.ACC_2625X, u.ACC_2625X, 1,0) =0 or
        decode(n.ACC_2627X, u.ACC_2627X, 1,0) =0 or
        decode(n.ACC_2625D, u.ACC_2625D, 1,0) =0 or
        decode(n.ACC_2628,  u.ACC_2628,  1,0) =0 or
        decode(n.ACC_2203,  u.ACC_2203,  1,0) =0 or
        decode(n.FIN,       u.FIN,       1,0) =0 or
        decode(n.FIN23,     u.FIN23,     1,0) =0 or
        decode(n.OBS23,     u.OBS23,     1,0) =0 or
        decode(n.KAT23,     u.KAT23,     1,0) =0 or
        decode(n.K23,       u.K23,       1,0) =0 or
        decode(n.DAT_BEGIN, u.DAT_BEGIN, 1,0) =0 or
        decode(n.DAT_END,   u.DAT_END,   1,0) =0 or
        decode(n.DAT_CLOSE, u.DAT_CLOSE, 1,0) =0 or
        decode(n.PASS_DATE, u.PASS_DATE, 1,0) =0 or
        decode(n.PASS_STATE,u.PASS_STATE,1,0) =0 or
        decode(n.KOL_SP,    u.KOL_SP,    1,0) =0 or
        decode(n.S250,      u.S250,      1,0) =0 or
        decode(n.GRP,       u.GRP,       1,0) =0 )
   and (u.chgaction is null or u.chgaction != 'D');
*/