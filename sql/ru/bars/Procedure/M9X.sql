prompt .........................................................................................................
prompt 2) Компиляция процедуры построения снимков-9  PROCEDURE BARS.M9x 
prompt .........................................................................................................

CREATE OR REPLACE PROCEDURE BARS.M9x ( x_Mfo varchar2) is 
  p_Mfo varchar2 (6) ; ----- := x_Mfo ;

  -- Sta  12.07.2018 11:30
  -- Паровозик для перепостроения снимков AGG_MONBALS за все 6 месяцев .
  -- Использовать в случае влияния на баланс МСФЗ-9 ручными и прочими НЕ-автороводками
  -- Пример : БЭК хоздебиторки, Реклассификация (перенос остатков), разбор 3939_8 и др.   
  Beg_Dat01 date := to_date('01.01.2018','dd.mm.yyyy') ;  
  End_Dat01 date := to_date('01.06.2018','dd.mm.yyyy') ;
  l_Viename varchar2(20) ;
  ------------------------------------------------------------------------
  l_Dat01   date ;  l_msg1 varchar (200); l_msg2 varchar (200);  s_Dat01 char(10);

------------**************************************************************
procedure snp9 ( P_DAT01 DATE )  IS  -- пОДГОТОВКА МЕСЯЧНОГО СНИМКА С УчЕТОМ ПЕРЕХОДНЫХ ПРОВОДОК
                  
  M_DAT01 DATE; I_DAT01 int  ;  b_DAT  DATE ;  KF_ varchar2 (6);
  agg                    agg_monbals9%rowtype;

  e_ptsn_not_exsts       exception;
  pragma exception_init( e_ptsn_not_exsts, -02149 );
  ---------------------------------------------------
  DAT22_ DATE := to_date('22-06-2018', 'dd-mm-yyyy');
  DAT27_ DATE := to_date('27-06-2018', 'dd-mm-yyyy');
  DAT28_ DATE := to_date('28-06-2018', 'dd-mm-yyyy');

  DAT02_ DATE := to_date('02-07-2018', 'dd-mm-yyyy');
  DAT10_ DATE := to_date('10-07-2018', 'dd-mm-yyyy');
  ---------------------------------------------------
 fl_  int ;
 Datx1 date :=to_date ('01-12-2017', 'dd-mm-yyyy');
 Datx2 date :=to_date ('01-01-2018', 'dd-mm-yyyy');
 Datx3 date :=to_date ('01-02-2018', 'dd-mm-yyyy');
 Datx4 date :=to_date ('01-03-2018', 'dd-mm-yyyy');
 Datx5 date :=to_date ('01-04-2018', 'dd-mm-yyyy');
 Datx6 date :=to_date ('01-06-2018', 'dd-mm-yyyy');
 ------------------------


BEGIN
 M_DAT01  := Trunc (P_DAT01 , 'MM' ) ;
 M_DAT01  := add_months(M_DAT01, -1) ;
 I_DAT01  := to_char ( M_DAT01, 'J' ) - 2447892 ;
 KF_      := gl.aMFO;
--------------------------------------------------------------------------------

 AGG.KF       := gl.aMfo ;  --  -- Снимки и КФ
 AGG.FDAT     := M_DAT01 ;
 AGG.CALDT_ID := I_DAT01 ;
 AGG.CRDOS    :=  0  ;
 AGG.CRDOSQ   :=  0  ;
 AGG.CRKOS    :=  0  ;
 AGG.CRKOSQ   :=  0  ;
 AGG.CUDOS    :=  0  ;
 AGG.CUDOSQ   :=  0  ;
 AGG.CUKOS    :=  0  ;
 AGG.CUKOSQ   :=  0  ;

 FOR K IN (
Select ACC, VDAT, KV, RNK, DK, SUM(S) S, Sum(SQ)  SQ
From (
--1) Все проводки, которые имеют признак «FRS9» и сделаны до 01.07.2018, будут учтены в «Снимках-9» по соответствующему полю oper.VDAT – Так называемая «дата валютирования»
SELECT 1 PR,  o.acc, P.vdat, a.kv, A.RNK,  O.DK, SUM(o.S) S, Sum(o.SQ)  SQ  -- обычные пров
           FROM TEST_OPER_frs9 P, OPLDOK O, accounts a
           WHERE p.KF  = KF_   And  p.vdat < p_dat01  
--and a.acc= p_acc 
             and O.acc = a.ACC AND  O.FDAT > DAT22_ AND O.FDAT < DAT28_   AND O.SOS = 5  AND O.REF  = P.REF  
           GROUP BY o.acc,  P.vdat, a.kv, A.RNK,  O.DK
union ALL
--2) Все проводки, которые имеют признак «FRS9» и сделаны после  01.07.2018  и имеют признак «КОРР» с датой валютирования = 27.06.2018, будут учтены в «Снимках-9» по соответствующему значению доп.реквизита  с тэгом DATN = operw.tag = DATN
SELECT 2, O.acc, TO_DATE(W.VALUE, 'DD.MM.YYYY'), a.kv, A.RNK,  O.DK, SUM(o.S) S, Sum(o.SQ)  SQ -- корр.пров
           FROM OPLDOK O, TEST_OPER_frs9 P, accounts a, OPERW W 
           WHERE p.KF  = KF_   and  p.vdat = DAT27_  AND P.VOB = 96
--and a.acc= p_acc 
             And O.acc = a.ACC AND  O.FDAT > DAT28_  AND O.SOS = 5  AND O.REF  = P.REF   AND   P.REF = W.ref  AND TO_DATE(W.VALUE, 'DD.MM.YYYY') < P_DAT01  AND W.TAG = 'DATN'
           GROUP BY o.acc, W.VALUE, a.kv, A.RNK,  O.DK
union ALL
--3) Все проводки, которые имеют признак «FRS9» и сделаны после  01.07.2018  но НЕ  имеют признак «КОРР» будут учтены в «Снимках-9» по соответствующему полю oper.VDAT – Так называемая «дата валютирования» - аналогично п.1.
SELECT 3 PR,  o.acc, P.vdat, a.kv, A.RNK, O.DK, SUM(o.S) S, Sum(o.SQ)  SQ  -- обычные пров
           FROM OPLDOK O, TEST_OPER_frs9  P, accounts a
           WHERE p.KF  = KF_   And  p.vdat < p_dat01 AND P.VOB <> 96 
--and a.acc= p_acc 
             and O.acc = a.ACC AND  O.FDAT >=DAT02_  AND O.FDAT <=DAT10_   AND O.SOS = 5  AND O.REF  = P.REF 
           GROUP BY o.acc,  P.vdat, a.kv, A.RNK, O.DK
) XX
group by ACC, VDAT, KV, RNK, DK
 )

 loop      iF k.kv <> GL.BASEVAL THEN K.SQ := GL.P_ICURVAL(  k.KV, K.s, K.vdat ) ; END IF;

     AGG.acc    := K.acc ;
     AGG.rnk    := K.rnk ;
     AGG.kv     := K.kv  ;
     AGG.ost    := (2*k.dk-1) * K.S  ;
     AGG.ostq   := (2*k.dk-1) * K.Sq ;
     -------------------------------
     AGG.DOS        := 0 ;
     AGG.DOSQ       := 0 ;
     AGG.KOS        := 0 ;
     AGG.KOSQ       := 0 ;
     AGG.DOS9       := 0 ;
     AGG.DOSQ9      := 0 ;
     AGG.KOS9       := 0 ;
     AGG.KOSQ9      := 0 ;

     If k.DK = 0 then   If TRUNC(k.VDAT,'MM')= m_DAT01 then  AGG.DOS := k.S ;  AGG.DOSq := k.SQ;  AGG.DOS9 := k.S ;  AGG.DOSq9 := k.SQ;  end if ;
     else               If TRUNC(k.VDAT,'MM')= m_DAT01 then  AGG.KOS := k.S ;  AGG.KOSq := k.SQ;  AGG.KOS9 := k.S ;  AGG.KOSq9 := k.SQ;  end if ;
     end if;

     begin  select 1 into fl_ from AGG_MONBALS9 where  acc  = AGG.acc   and kf = AGG.KF  and rownum = 1; 
     exception when no_data_found    then
        Insert into AGG_MONBALS9 ( FDAT, KF, ACC, RNK, kv)  values (Datx1, agg.KF, agg.ACC, agg.RNK, agg.kv ) ;
        Insert into AGG_MONBALS9 ( FDAT, KF, ACC, RNK, kv)  values (Datx2, agg.KF, agg.ACC, agg.RNK, agg.kv );
        Insert into AGG_MONBALS9 ( FDAT, KF, ACC, RNK, kv)  values (Datx3, agg.KF, agg.ACC, agg.RNK, agg.kv );
        Insert into AGG_MONBALS9 ( FDAT, KF, ACC, RNK, kv)  values (Datx4, agg.KF, agg.ACC, agg.RNK, agg.kv );
        Insert into AGG_MONBALS9 ( FDAT, KF, ACC, RNK, kv)  values (Datx5, agg.KF, agg.ACC, agg.RNK, agg.kv );
        Insert into AGG_MONBALS9 ( FDAT, KF, ACC, RNK, kv)  values (Datx6, agg.KF, agg.ACC, agg.RNK, agg.kv );

        update AGG_MONBALS9 set OST=0, OSTQ=0, DOS=0, DOSQ=0, KOS=0, KOSQ=0, CRDOS=0, CRDOSQ=0, CRKOS=0, CRKOSQ=0, CUDOS=0, CUDOSQ=0, CUKOS=0, CUKOSQ=0, DOS9=0, DOSQ9=0, KOS9=0, KOSQ9=0  
               where acc  = AGG.acc   and kf      = AGG.KF  ;
     end ;

     update AGG_MONBALS9 set KV      = AGG.KV,
                             OST     = NVL(OST,0)  + AGG.OST,                      --\ Приращение остатка
                             OSTq    = NVL(OSTq,0) + AGG.OSTq,                     --/
                             DOS     = NVL(DOS, 0) + AGG.DOS,               --\ Приращение к месячним оборотам
                             DOSq    = nvl(DOSq,0) + AGG.DOSq,              --/
                             DOS9    = NVL(DOS9, 0) + AGG.DOS9,             --\ Спец.обороты этого месяца
                             DOSq9   = nvl(DOSq9,0) + AGG.DOSq9,             --/
                             -------------------------------------------------
                             kOS     = NVL(kOS, 0) + AGG.kOS,               --\ Приращение к месячним оборотам
                             kOSq    = nvl(kOSq,0) + AGG.kOSq,              --/
                             kOS9    = NVL(kOS9, 0) + AGG.kOS9,             --\ Спец.обороты этого месяца
                             kOSq9   = nvl(kOSq9,0) + AGG.kOSq9             --/
                       where fdat    = AGG.FDAT
                         and acc     = AGG.acc
                         and kf      = AGG.KF  ;

 end loop;
 --------------------------
 commit;

 DECLARE  -- p_dat01 date; -- 01/01/2018 = отч.дата
    M01_DAT  date := add_months(p_DAT01, -1) ; -- 01/12/2017, 01/01/2018, 01/02/2018, 01/03/2018, 01/04/2018, 01/05/2018  = первый кал.день отч.мес  
    R31_DAT  date := DAT_NEXT_U(p_dat01, -1) ; -- 29/12/2017, 31/01/2018, 28/02/2018, 30/03/2018, 27/04/2018, 31/05/2018  = последний раб.день отч.мес    
 begin 
    update  agg_monbals9  set OSTq  = gl.p_icurval ( kv, OST , R31_DAT ) ,
                              DOSq  = gl.p_icurval ( kv, DOS , R31_DAT ) ,
                              KOSq  = gl.p_icurval ( kv, KOS , R31_DAT ) ,
                              DOSq9 = gl.p_icurval ( kv, DOS9, R31_DAT ) ,
                              KOSq9 = gl.p_icurval ( kv, KOS9, R31_DAT ) 
    where kv <> 980 and kf = p_mfo and fdat = M01_DAT ;
 
 end ; 
  
END ; -- снимок  за 1 месяц 
------------**************************************************************


 procedure SEND_MSG( p_txt varchar2 ) is
 begin     bars_audit.info( p_txt ); end SEND_MSG;
  -------------------------------------------------

begin   

--- подготовительные работы по всем МФО сразу

logger.info ('AGG_MONBALS9*Start x_Mfo ='|| x_Mfo ||'*'  );

  begin  execute immediate  'drop INDEX BARS.AGG_MONBALS9_IDX ';
  exception when others then   null ;
  end;
logger.info ('AGG_MONBALS9*drop INDEX BARS.AGG_MONBALS9_IDX' );

  begin  execute immediate  'Truncate table BARS.AGG_MONBALS9 ';
  exception when others then   null ;
  end;

logger.info ('AGG_MONBALS9*Truncate table BARS.AGG_MONBALS9' );

For k in ( select  * from mv_KF where (x_Mfo is null or x_MFO = KF )   )
loop 

/*
  -- удалить партицию по всем датам+МФО

 begin  execute immediate   'alter table AGG_MONBALS9 truncate subpartition for ( to_date(''01.12.2017'',''dd.mm.yyyy''),'''||k.KF||''')';
 exception when others then   null ;
 end;

 begin  execute immediate   'alter table AGG_MONBALS9 truncate subpartition for ( to_date(''01.01.2018'',''dd.mm.yyyy''),'''||k.KF||''')';
 exception when others then   null ;
 end;

 begin  execute immediate   'alter table AGG_MONBALS9 truncate subpartition for ( to_date(''01.02.2018'',''dd.mm.yyyy''),'''||k.KF||''')';
 exception when others then   null ;
 end;

 begin  execute immediate   'alter table AGG_MONBALS9 truncate subpartition for ( to_date(''01.03.2018'',''dd.mm.yyyy''),'''||k.KF||''')';
 exception when others then   null ;
 end;

 begin  execute immediate   'alter table AGG_MONBALS9 truncate subpartition for ( to_date(''01.04.2018'',''dd.mm.yyyy''),'''||k.KF||''')';
 exception when others then   null ;
 end;

 begin  execute immediate   'alter table AGG_MONBALS9 truncate subpartition for ( to_date(''01.05.2018'',''dd.mm.yyyy''),'''||k.KF||''')';
 exception when others then   null ;
 end;

*/

  BC.go( k.KF);
  -- добавить эти же партиции 
  Insert into AGG_MONBALS9 ( FDAT,KF, ACC,RNK,OST,OSTQ,DOS,DOSQ,KOS,KOSQ,CRDOS,CRDOSQ,CRKOS,CRKOSQ,CUDOS,CUDOSQ,CUKOS,CUKOSQ,CALDT_ID, DOS9,DOSQ9,KOS9,KOSQ9, kv)
  select m.FDAT,k.KF,m.ACC,a.RNK,m.OST,m.OSTQ,m.DOS,m.DOSQ,m.KOS,m.KOSQ,m.CRDOS,m.CRDOSQ,m.CRKOS,m.CRKOSQ,m.CUDOS,m.CUDOSQ,m.CUKOS,m.CUKOSQ, m.CALDT_ID, 0 ,0   ,0,  0,a.kv
    from AGG_MONBALS  m, accounts a   
    where a.acc= m.acc 
     and  m.fdat in ( to_date ( '01.12.2017' , 'dd.mm.yyyy' ) ,
                      to_date ( '01.01.2018' , 'dd.mm.yyyy' ) ,
                      to_date ( '01.02.2018' , 'dd.mm.yyyy' ) ,
                      to_date ( '01.03.2018' , 'dd.mm.yyyy' ) ,
                      to_date ( '01.04.2018' , 'dd.mm.yyyy' ) ,
                      to_date ( '01.05.2018' , 'dd.mm.yyyy' )
                     ) ;

  commit;
logger.info ('AGG_MONBALS9*'||k.KF|| ' добавить RU' );
   BC.go( '/');

end loop ; --mfo
------------------------------------

  begin  execute immediate  'CREATE UNIQUE INDEX BARS.AGG_MONBALS9_IDX ON BARS.AGG_MONBALS9 (KF, FDAT, ACC) ';
  exception when others then   null ;
  end;

logger.info ('AGG_MONBALS9*CREATE UNIQUE INDEX BARS.AGG_MONBALS9_IDX' );

For mfo in ( select  * from mv_KF where (x_Mfo is null or x_MFO = KF ) )


loop 
  p_Mfo := mfo.KF;
  ----------------
  select 'AGG_MONBALS9*'|| MFO ||':'|| name into l_msg1 from  BANKS_RU where mfo = p_Mfo ; 
  bc.go ( p_MFO );

  -- 2) Помесячно  :
  l_Dat01 := Beg_Dat01 ;
  WHILE l_Dat01 <= End_Dat01   
  LOOP  s_Dat01 := to_char (l_Dat01, 'dd.mm.yyyy') ;
        l_Msg2 := '*Перестройка AGG_MONBALS, дата = '||s_Dat01 ;
        SeND_MSG (p_txt =>  l_Msg1 || '*BEG:' || l_Msg2 );     
        ------------------------------------------------------------------------------------
        SNP9 ( l_Dat01 ) ; 
        commit;                      
        SeND_MSG (p_txt =>  l_Msg1 || '*END:' || l_Msg2 );
        ------------------------------------------------------------------------------------
       l_dat01:= add_months( l_dat01, +1);
  END LOOP  ;    
 --------------------------
  l_Viename := 'V_OSA_'||p_Mfo ;
  execute immediate 
 ' CREATE OR REPLACE  VIEW '|| l_Viename || 
 ' AS  SELECT TO_DATE (''01012018'', ''ddmmyyyy'') FDAT, T.*  FROM TEST_PRVN_OSAQ_01012018_'|| p_Mfo ||' T  UNION ALL
       SELECT TO_DATE (''01022018'', ''ddmmyyyy'') FDAT, T.*  FROM TEST_PRVN_OSAQ_01022018_'|| p_Mfo ||' T  UNION ALL
       SELECT TO_DATE (''01032018'', ''ddmmyyyy'') FDAT, T.*  FROM TEST_PRVN_OSAQ_01032018_'|| p_Mfo ||' T  UNION ALL
       SELECT TO_DATE (''01042018'', ''ddmmyyyy'') FDAT, T.*  FROM TEST_PRVN_OSAQ_01042018_'|| p_Mfo ||' T  UNION ALL
       SELECT TO_DATE (''01052018'', ''ddmmyyyy'') FDAT, T.*  FROM TEST_PRVN_OSAQ_01052018_'|| p_Mfo ||' T  UNION ALL
       SELECT TO_DATE (''01062018'', ''ddmmyyyy'') FDAT, T.*  FROM TEST_PRVN_OSAQ_01062018_'|| p_Mfo ||' T ';
end loop; --  mfo 
--------------------

end M9x ;
/


prompt .........................................................................................................
prompt 3) И ее непосредственное выполнение , т.е. формирование снимков.
prompt .........................................................................................................

Exec  M9x ( x_Mfo => null ) ;

prompt .........................................................................................................
prompt 4) OK M9x ( x_Mfo => null )
prompt .........................................................................................................
