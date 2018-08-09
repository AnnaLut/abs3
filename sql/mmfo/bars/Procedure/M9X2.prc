CREATE OR REPLACE PROCEDURE BARS.M9x2 ( x_Mfo varchar2) is
  agg                    agg_monbals9%rowtype;
---=============================================================
  procedure INS9 (x_dat date)  IS    fl_  int ; -- вставка записи
  begin
     begin  select 1 into fl_ from AGG_MONBALS9 where  acc  = AGG.acc   and kf = AGG.KF  and fdat = x_dat;
     exception when no_data_found  then 
        Insert into AGG_MONBALS9 ( FDAT, KF, ACC, RNK, kv)  values (x_dat, agg.KF, agg.ACC, agg.RNK, agg.kv ) ;
        update AGG_MONBALS9 set OST=0, OSTQ=0, DOS=0, DOSQ=0, KOS=0, KOSQ=0, CRDOS=0, CRDOSQ=0, CRKOS=0, CRKOSQ=0, CUDOS=0, CUDOSQ=0, CUKOS=0, CUKOSQ=0, DOS9=0, DOSQ9=0, KOS9=0, KOSQ9=0
               where acc  = AGG.acc   and kf = AGG.KF  and fdat = x_dat ;
     end ;
  end ;  -- procedure INS9 
  ------------------------
  procedure snp9  IS  -- пОДГОТОВКА МЕСЯЧНОГО СНИМКА С УчЕТОМ ПЕРЕХОДНЫХ ПРОВОДОК
     ---------------------------------------------------
     DAT22_ DATE := to_date('22-06-2018', 'dd-mm-yyyy');
     DAT27_ DATE := to_date('27-06-2018', 'dd-mm-yyyy');
     DAT28_ DATE := to_date('28-06-2018', 'dd-mm-yyyy');
     DAT02_ DATE := to_date('02-07-2018', 'dd-mm-yyyy');
     DAT10_ DATE := to_date('10-07-2018', 'dd-mm-yyyy');
     ---------------------------------------------------
     Datx1  date :=to_date ('01-12-2017', 'dd-mm-yyyy');
     Datx2  date :=to_date ('01-01-2018', 'dd-mm-yyyy');
     Datx3  date :=to_date ('01-02-2018', 'dd-mm-yyyy');
     Datx4  date :=to_date ('01-03-2018', 'dd-mm-yyyy');
     Datx5  date :=to_date ('01-04-2018', 'dd-mm-yyyy');
     Datx6  date :=to_date ('01-06-2018', 'dd-mm-yyyy');
     ------------------------
  BEGIN  
     logger.info('AGG_MONBALS9*Накопление по МФО='||gl.aMfo);
     FOR K IN
       (Select ACC, VDAT, KV, RNK,  SUM(Decode(dk,0,S,0)) D9, SUM(Decode(dk,1,S,0)) K9
        From (
              --1 Все проводки, которые имеют признак «FRS9» и сделаны до 01.07.2018, будут учтены в «Снимках-9» по соответствующему полю oper.VDAT – Так называемая «дата валютирования»
              SELECT 1 PR,  o.acc, P.vdat, a.kv, A.RNK,  O.DK, SUM(o.S) S, Sum(o.SQ)  SQ  -- обычные пров
              FROM TEST_OPER_frs9 P, OPLDOK O, accounts a
              WHERE p.KF  = gl.aMfo  and O.acc = a.ACC AND  O.FDAT > DAT22_ AND O.FDAT < DAT28_   AND O.SOS = 5  AND O.REF  = P.REF          --and a.acc= p_acc
              GROUP BY o.acc,  P.vdat, a.kv, A.RNK,  O.DK
              union ALL
              --2 Все проводки, которые имеют признак «FRS9» и сделаны после  01.07.2018  и имеют признак «КОРР» с датой валютирования = 27.06.2018, будут учтены в «Снимках-9» по соответствующему значению доп.реквизита  с тэгом DATN = operw.tag = DATN
              SELECT 2, O.acc, TO_DATE(W.VALUE, 'DD.MM.YYYY'), a.kv, A.RNK,  O.DK, SUM(o.S) S, Sum(o.SQ)  SQ -- корр.пров
              FROM OPLDOK O, TEST_OPER_frs9 P, accounts a, OPERW W
              WHERE p.KF  = gl.aMfo  and  p.vdat = DAT27_  AND P.VOB = 96   And O.acc = a.ACC AND  O.FDAT > DAT28_  AND O.SOS = 5  AND O.REF  = P.REF   AND   P.REF = W.ref AND W.TAG = 'DATN'     --and a.acc= p_acc
              GROUP BY o.acc, W.VALUE, a.kv, A.RNK,  O.DK
              union ALL
              --3 Все проводки, которые имеют признак «FRS9» и сделаны после  01.07.2018  но НЕ  имеют признак «КОРР» будут учтены в «Снимках-9» по соответствующему полю oper.VDAT – Так называемая «дата валютирования» - аналогично п.1.
              SELECT 3 PR,  o.acc, P.vdat, a.kv, A.RNK, O.DK, SUM(o.S) S, Sum(o.SQ)  SQ  -- обычные пров
              FROM OPLDOK O, TEST_OPER_frs9  P, accounts a
              WHERE p.KF  = gl.aMfo AND P.VOB <> 96   and O.acc = a.ACC AND  O.FDAT >=DAT02_  AND O.FDAT <=DAT10_   AND O.SOS = 5  AND O.REF  = P.REF    --and a.acc= p_acc
              GROUP BY o.acc, P.vdat, a.kv, A.RNK, O.DK
             ) XX  group by   ACC,   VDAT,   KV,   RNK  order by ACC, VDAT 
        )
        
        loop AGG.KF    := gl.aMfo ;   AGG.rnk   := K.rnk  ;  AGG.kv    := K.kv    ;  AGG.FDAT  := k.VDAT  ;   AGG.ACC   := k.ACC   ;
             INS9(x_dat => Datx1) ;   INS9(x_dat =>Datx2) ;  INS9(x_dat => Datx3) ;  INS9(x_dat => Datx4) ;   INS9(x_dat => Datx5) ; INS9 (x_dat => Datx6);
             update AGG_MONBALS9 set DOS9 = k.d9, KOS9 = k.k9   where fdat  = AGG.FDAT  and acc = AGG.acc  and kf  = AGG.KF ;           -------------------- Спец.обороты только этого месяца
             update AGG_MONBALS9 set OST  = OST - k.d9 + k.k9   where fdat >= AGG.FDAT  and acc = AGG.acc  and kf  = AGG.KF ;           -------------------- Остатки,  начиная с этого месяца 
        end loop;  ---K
        commit;
        --------------------------
        update agg_monbals9 set OSTq = gl.p_icurval(kv,OST,last_day(fdat) ),  DOSq9= gl.p_icurval(kv,DOS9,last_day(fdat) ),  KOSq9=gl.p_icurval(kv,KOS9,last_day(fdat) )  where kv <> 980 and kf = gl.aMfo;
        commit;
           --------------------------
  End ;  --- procedure snp9  IS  -- пОДГОТОВКА МЕСЯЧНОГО СНИМКА С УчЕТОМ ПЕРЕХОДНЫХ ПРОВОДОК
  ----====================================================================================================================
begin
  For mfo in ( select  * from mv_KF where NVL(x_Mfo, KF) = KF  order by kf)
  loop  bc.go (mfo.KF);  SNP9 ;  END LOOP  ; -- mfo
end M9x2 ;
/