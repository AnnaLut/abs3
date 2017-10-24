-- ======================================================================================
-- Module : UPL - Вивантаження даних до DWH
-- Author : V.Kharin
-- Date   : 05.07.2017
-- Update : 05.07.2017 - KVA обработка всех МФО в БД
-- синхронизация BPK_ACC_UPDATE vs BPK_ACC
-- синхронизация W4_ACC_UPDATE  vs W4_ACC
-- ======================================================================================

ALTER SESSION ENABLE PARALLEL DML;

declare
  l_global_bd      date;
  l_kf             varchar2(6);
begin
  --l_kf := '300465';               -- закомментировать если выполнять для всех РУ в ММФО, иначе только для этого МФО
  for lc_kf in (select kf from bars.mv_kf where kf = l_kf or l_kf = '' or l_kf is null)
  loop
    DBMS_OUTPUT.PUT_LINE('Start BPK/W4 sinchronize for = ' || lc_kf.kf);
    begin
        l_kf := lc_kf.kf;
        bars.bc.go(l_kf);
        l_global_bd := bars.glb_bankdate; -- глобальная банковская дата
        --LOCK TABLE BPK_ACC        IN EXCLUSIVE MODE NOWAIT;
        --LOCK TABLE BPK_ACC_UPDATE IN EXCLUSIVE MODE NOWAIT;
        --LOCK TABLE W4_ACC         IN EXCLUSIVE MODE NOWAIT;
        --LOCK TABLE W4_ACC_UPDATE  IN EXCLUSIVE MODE NOWAIT;

        --есть в основной - нет в update либо с chgaction = 'D'
        -- добавляем с chgaction=U
        --BPK
        Insert /*+ APPEND */ into BARS.BPK_ACC_UPDATE
           (idupd, chgaction, effectdate, chgdate, doneby,
            acc_pk, acc_ovr, acc_9129, acc_tovr, kf, 
            acc_3570, acc_2208, nd, product_id, acc_2207, acc_3579, acc_2209, fin23, obs23, kat23, 
            k23, acc_w4, dat_end, fin, kol_sp,  s250, grp, global_bdate)
        select /*+ parallel */
            bars_sqnc.get_nextval('S_BPKACC_UPDATE', l_kf) idupd,
            'U' chgaction,
            NVL( greatest( (select MAX(EFFECTDATE) dt    --максимальный из update
                              from BARS.BPK_ACC_UPDATE u2
                             where u2.nd = n.nd
                           ),
                           (select max(a.daos) dt        -- либо максимальная дата открытия счета
                              from bars.accounts a
                             where a.acc in (n.acc_pk, n.acc_ovr, n.acc_9129, n.acc_tovr, n.acc_3570, n.acc_2208, n.acc_2207, n.acc_3579, n.acc_2209)
                           )
                         ),
                 bars.gl.bd) EFFECTDATE,                 -- либо текущая (по умолчанию)
            SYSDATE as CHGDATE,
            1 as DONEBY,
            n.acc_pk, n.acc_ovr, n.acc_9129, n.acc_tovr, n.kf, 
            n.acc_3570, n.acc_2208, n.nd, n.product_id, n.acc_2207, n.acc_3579, n.acc_2209, n.fin23, n.obs23, n.kat23, 
            n.k23, n.acc_w4, n.dat_end, n.fin, n.kol_sp,  n.s250, n.grp,
            l_global_bd global_bdate
          from BARS.BPK_ACC n left join
               (select *
                  from BARS.BPK_ACC_UPDATE
                 where IDUPD in ( select MAX(IDUPD)
                                    from BARS.BPK_ACC_UPDATE
                                   group by nd )
               ) u on (u.nd = n.nd)
         where u.nd is null
            or u.chgaction = 'D';
        DBMS_OUTPUT.PUT_LINE('Sinchronize BPK_ACC_UPDATE(1) = ' || sql%rowcount || ' row(s) inserted =');
        COMMIT;

        --W4
        Insert /*+ APPEND */ into BARS.W4_ACC_UPDATE
           (idupd, chgaction, effectdate, chgdate, doneby, 
            nd, acc_pk, acc_ovr, acc_9129, acc_3570, acc_2208, acc_2627, acc_2207, acc_3579, acc_2209, 
            card_code, acc_2625x, acc_2627x, acc_2625d, acc_2628, acc_2203, fin, fin23, obs23, kat23, 
            k23, dat_begin, dat_end, dat_close, pass_date, pass_state, kol_sp, s250, grp, global_bdate)
        select /*+ parallel */
			bars_sqnc.get_nextval('s_w4acc_update', l_kf) idupd,
            'U' chgaction,
            NVL( greatest( (select MAX(EFFECTDATE) dt          --максимальный из update
                              from BARS.W4_ACC_UPDATE u2
                             where u2.nd = n.nd
                           ),
                           (select max(a.daos) dt              -- либо максимальная дата открытия счета
                              from bars.accounts a
                             where a.acc in (n.acc_pk, n.acc_ovr, n.acc_9129, n.acc_3570, n.acc_2208, n.acc_2627, n.acc_2207, n.acc_3579, n.acc_2209, n.acc_2625x, n.acc_2627x, n.acc_2625d, n.acc_2628, n.acc_2203)
                           )
                         ),
                 bars.gl.bd) EFFECTDATE,                       -- либо текущая (по умолчанию)
            SYSDATE as CHGDATE,
            1 as DONEBY,
            n.nd, n.acc_pk, n.acc_ovr, n.acc_9129, n.acc_3570, n.acc_2208, n.acc_2627, n.acc_2207, n.acc_3579, n.acc_2209, 
            n.card_code, n.acc_2625x, n.acc_2627x, n.acc_2625d, n.acc_2628, n.acc_2203, n.fin, n.fin23, n.obs23, n.kat23, 
            n.k23, n.dat_begin, n.dat_end, n.dat_close, n.pass_date, n.pass_state, n.kol_sp, n.s250, n.grp,
            l_global_bd global_bdate
          from BARS.W4_ACC n left join
               (select *
                  from BARS.W4_ACC_UPDATE
                 where IDUPD in ( select MAX(IDUPD)
                                    from BARS.W4_ACC_UPDATE
                                   group by nd )
               ) u on (u.nd = n.nd)
         where u.nd is null
            or u.chgaction = 'D';
        DBMS_OUTPUT.PUT_LINE('Sinchronize W4_ACC_UPDATE(1) = ' || sql%rowcount || ' row(s) inserted =');
        COMMIT;



        --есть в update и не 'D' - нет в основной
        -- добавляем с chgaction=D
        --BPK
        Insert /*+ APPEND */ into BARS.BPK_ACC_UPDATE
           (idupd, chgaction, effectdate, chgdate, doneby,
            acc_pk, acc_ovr, acc_9129, acc_tovr, kf, 
            acc_3570, acc_2208, nd, product_id, acc_2207, acc_3579, acc_2209, fin23, obs23, kat23, 
            k23, acc_w4, dat_end, fin, kol_sp,  s250, grp, global_bdate)
        select /*+ parallel */
			bars_sqnc.get_nextval('S_BPKACC_UPDATE', l_kf) idupd,
            'D' chgaction,
            NVL( greatest( (select MAX(EFFECTDATE) dt          --максимальный из update
                              from BARS.BPK_ACC_UPDATE u2
                             where u2.nd = u.nd
                           ),
                           (select max(a.dazs) dt              -- либо максимальная дата открытия счета
                              from bars.accounts a
                             where a.acc in (u.acc_pk)
                           )
                         ),
                 bars.gl.bd) EFFECTDATE,                       -- либо текущая (по умолчанию)
            SYSDATE as CHGDATE,
            1 as DONEBY,
            u.acc_pk, u.acc_ovr, u.acc_9129, u.acc_tovr, u.kf, 
            u.acc_3570, u.acc_2208, u.nd, u.product_id, u.acc_2207, u.acc_3579, u.acc_2209, u.fin23, u.obs23, u.kat23, 
            u.k23, u.acc_w4, u.dat_end, u.fin, u.kol_sp,  u.s250, u.grp,
            l_global_bd global_bdate
          from (select *
                  from BARS.BPK_ACC_UPDATE
                 where IDUPD in ( select MAX(IDUPD)
                                    from BARS.BPK_ACC_UPDATE
                                   group by nd )
               ) u left join
               BARS.BPK_ACC n on (u.nd = n.nd)
         where n.nd is null
           and u.chgaction != 'D';
        DBMS_OUTPUT.PUT_LINE('Sinchronize BPK_ACC_UPDATE(2) = ' || sql%rowcount || ' row(s) inserted =');
        COMMIT;

        --W4
        Insert /*+ APPEND */ into BARS.W4_ACC_UPDATE
           (idupd, chgaction, effectdate, chgdate, doneby, 
            nd, acc_pk, acc_ovr, acc_9129, acc_3570, acc_2208, acc_2627, acc_2207, acc_3579, acc_2209, 
            card_code, acc_2625x, acc_2627x, acc_2625d, acc_2628, acc_2203, fin, fin23, obs23, kat23, 
            k23, dat_begin, dat_end, dat_close, pass_date, pass_state, kol_sp, s250, grp, global_bdate)
        select /*+ parallel */
			bars_sqnc.get_nextval('s_w4ACC_update', l_kf) idupd,
            'D' chgaction,
            NVL( greatest( (select MAX(EFFECTDATE) dt          --максимальный из update
                              from BARS.W4_ACC_UPDATE u2
                             where u2.nd = u.nd
                           ),
                           (select max(a.dazs) dt              -- либо максимальная дата открытия счета
                              from bars.accounts a
                             where a.acc in (u.acc_pk)
                           )
                         ),
                 bars.gl.bd) EFFECTDATE,                       -- либо текущая (по умолчанию)
            SYSDATE as CHGDATE,
            1 as DONEBY,
            u.nd, u.acc_pk, u.acc_ovr, u.acc_9129, u.acc_3570, u.acc_2208, u.acc_2627, u.acc_2207, u.acc_3579, u.acc_2209, 
            u.card_code, u.acc_2625x, u.acc_2627x, u.acc_2625d, u.acc_2628, u.acc_2203, u.fin, u.fin23, u.obs23, u.kat23, 
            u.k23, u.dat_begin, u.dat_end, u.dat_close, u.pass_date, u.pass_state, u.kol_sp, u.s250, u.grp,
            l_global_bd global_bdate
          from (select *
                  from BARS.W4_ACC_UPDATE
                 where IDUPD in ( select MAX(IDUPD)
                                    from BARS.W4_ACC_UPDATE
                                   group by nd )
               ) u left join
               BARS.W4_ACC n on (u.nd = n.nd)
         where n.nd is null
           and u.chgaction != 'D';
        DBMS_OUTPUT.PUT_LINE('Sinchronize W4_ACC_UPDATE(2) = ' || sql%rowcount || ' row(s) inserted =');
        COMMIT;

        --синхронизация BPK_ACC_UPDATE
        --BPK
        Insert /*+ APPEND */ into BARS.BPK_ACC_UPDATE
           (idupd, chgaction, effectdate, chgdate, doneby,
            acc_pk, acc_ovr, acc_9129, acc_tovr, kf, 
            acc_3570, acc_2208, nd, product_id, acc_2207, acc_3579, acc_2209, fin23, obs23, kat23, 
            k23, acc_w4, dat_end, fin, kol_sp,  s250, grp, global_bdate)
        select /*+ parallel */
			   bars_sqnc.get_nextval('S_BPKACC_UPDATE', l_kf) idupd,
               'U' chgaction,
               COALESCE(u.EFFECTDATE, bars.gl.bd ) EFFECTDATE, 
               SYSDATE as CHGDATE,
               1 as DONEBY,
               n.acc_pk, n.acc_ovr, n.acc_9129, n.acc_tovr, n.kf, 
               n.acc_3570, n.acc_2208, n.nd, n.product_id, n.acc_2207, n.acc_3579, n.acc_2209, n.fin23, n.obs23, n.kat23, 
               n.k23, n.acc_w4, n.dat_end, n.fin, n.kol_sp,  n.s250, n.grp,
               l_global_bd global_bdate
          from BARS.BPK_ACC n
               left join
               (select *
                  from BARS.BPK_ACC_UPDATE
                 where IDUPD in ( select MAX(IDUPD)
                                    from BARS.BPK_ACC_UPDATE
                                   group by nd )
               ) u on (u.nd = n.nd)
         where u.nd is null
            or u.acc_pk <> n.acc_pk
            or COALESCE(u.acc_ovr,    0) <> COALESCE(n.acc_ovr, 0)   
            or COALESCE(u.acc_9129,   0) <> COALESCE(n.acc_9129, 0)  
            or COALESCE(u.acc_tovr,   0) <> COALESCE(n.acc_tovr, 0)  
            or COALESCE(u.acc_3570,   0) <> COALESCE(n.acc_3570, 0)  
            or COALESCE(u.acc_2208,   0) <> COALESCE(n.acc_2208, 0)  
            or COALESCE(u.product_id, 0) <> COALESCE(n.product_id, 0)
            or COALESCE(u.acc_2207,   0) <> COALESCE(n.acc_2207, 0)  
            or COALESCE(u.acc_3579,   0) <> COALESCE(n.acc_3579, 0)  
            or COALESCE(u.acc_2209,   0) <> COALESCE(n.acc_2209, 0)  
            or COALESCE(u.acc_w4,     0) <> COALESCE(n.acc_w4, 0)    
            or COALESCE(u.fin,        0) <> COALESCE(n.fin, 0)       
            or COALESCE(u.fin23,      0) <> COALESCE(n.fin23, 0)     
            or COALESCE(u.obs23,      0) <> COALESCE(n.obs23, 0)     
            or COALESCE(u.kat23,      0) <> COALESCE(n.kat23, 0)     
            or COALESCE(u.k23,        0) <> COALESCE(n.k23, 0)       
            or 'xy' || u.dat_end         <> 'xy' || n.dat_end        
            or COALESCE(u.kol_sp,     0) <> COALESCE(n.kol_sp, 0)    
            or COALESCE(u.s250,     '_') <> COALESCE(n.s250, '_' )   
            or COALESCE(u.grp,        0) <> COALESCE(n.grp, 0);

        DBMS_OUTPUT.PUT_LINE('Sinchronize BPK_ACC_UPDATE(3) = ' || sql%rowcount || ' row(s) inserted =');
        COMMIT;

        --синхронизация W4_ACC_UPDATE
        --W4
        Insert /*+ APPEND */ into BARS.W4_ACC_UPDATE
           (idupd, chgaction, effectdate, chgdate, doneby, 
            nd, acc_pk, acc_ovr, acc_9129, acc_3570, acc_2208, acc_2627, acc_2207, acc_3579, acc_2209, 
            card_code, acc_2625x, acc_2627x, acc_2625d, acc_2628, acc_2203, fin, fin23, obs23, kat23, 
            k23, dat_begin, dat_end, dat_close, pass_date, pass_state, kol_sp, s250, grp, global_bdate)
        select /*+ parallel */
			  bars_sqnc.get_nextval('s_w4ACC_update', l_kf) idupd,
              'U' chgaction,
               COALESCE(u.EFFECTDATE, bars.gl.bd ) EFFECTDATE,
               SYSDATE as CHGDATE,
               1 as DONEBY,
               n.nd, n.acc_pk, n.acc_ovr, n.acc_9129, n.acc_3570, n.acc_2208, n.acc_2627, n.acc_2207, n.acc_3579, n.acc_2209, 
               n.card_code, n.acc_2625x, n.acc_2627x, n.acc_2625d, n.acc_2628, n.acc_2203, n.fin, n.fin23, n.obs23, n.kat23, 
               n.k23, n.dat_begin, n.dat_end, n.dat_close, n.pass_date, n.pass_state, n.kol_sp, n.s250, n.grp,
               l_global_bd global_bdate
          from BARS.W4_ACC n
               left join
               (select *
                  from BARS.W4_ACC_UPDATE
                 where IDUPD in ( select MAX(IDUPD)
                                    from BARS.W4_ACC_UPDATE
                                   group by nd )
               ) u on (u.nd = n.nd)
         where u.nd is null
            or u.acc_pk                    <> n.acc_pk
            or COALESCE(u.acc_ovr, 0)      <> COALESCE(n.acc_ovr,  0)
            or COALESCE(u.acc_9129, 0)     <> COALESCE(n.acc_9129, 0)
            or COALESCE(u.acc_3570, 0)     <> COALESCE(n.acc_3570, 0)
            or COALESCE(u.acc_2208, 0)     <> COALESCE(n.acc_2208, 0)
            or COALESCE(u.acc_2627, 0)     <> COALESCE(n.acc_2627, 0)
            or COALESCE(u.acc_2207, 0)     <> COALESCE(n.acc_2207, 0)
            or COALESCE(u.acc_3579, 0)     <> COALESCE(n.acc_3579, 0)
            or COALESCE(u.acc_2209, 0)     <> COALESCE(n.acc_2209, 0)
            or COALESCE(u.card_code, '_')  <> COALESCE(n.card_code, '_')
            or COALESCE(u.acc_2625x, 0)    <> COALESCE(n.acc_2625x, 0)
            or COALESCE(u.acc_2627x, 0)    <> COALESCE(n.acc_2627x, 0)
            or COALESCE(u.acc_2625d, 0)    <> COALESCE(n.acc_2625d, 0)
            or COALESCE(u.acc_2628, 0)     <> COALESCE(n.acc_2628,  0)
            or COALESCE(u.acc_2203, 0)     <> COALESCE(n.acc_2203,  0)
            or COALESCE(u.fin, 0)          <> COALESCE(n.fin,       0)
            or COALESCE(u.fin23, 0)        <> COALESCE(n.fin23,    0)
            or COALESCE(u.obs23, 0)        <> COALESCE(n.obs23, 0)
            or COALESCE(u.kat23, 0)        <> COALESCE(n.kat23, 0)
            or COALESCE(u.k23, 0)          <> COALESCE(n.k23, 0)
            or 'xy' || u.dat_begin         <> 'xy' || n.dat_begin
            or 'xy' || u.dat_end           <> 'xy' || n.dat_end
            or 'xy' || u.dat_close         <> 'xy' || n.dat_close
            or 'xy' || u.pass_date         <> 'xy' || n.pass_date
            or 'xy' || u.pass_state        <> 'xy' || n.pass_state
            or COALESCE(u.kol_sp, 0)       <> COALESCE(n.kol_sp, 0)
            or COALESCE(u.s250, '_')       <> COALESCE(n.s250, '_')
            or COALESCE(u.grp, 0)          <> COALESCE(n.grp, 0);

        DBMS_OUTPUT.PUT_LINE('Sinchronize W4_ACC_UPDATE(3) = ' || sql%rowcount || ' row(s) inserted =');
        COMMIT;

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

COMMIT;

