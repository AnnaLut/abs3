CREATE OR REPLACE PROCEDURE BARS.M9x1  is  --- подготовительные работы по всем МФО сразу

begin    BC.go( '/');

  logger.info('AGG_MONBALS9*Полная очистка всех МФО');

  begin  execute immediate  'drop INDEX BARS.AGG_MONBALS9_IDX ';
  exception when others then   null ;
  end;

  execute immediate  'Truncate table BARS.AGG_MONBALS9 ';
  
  For k in ( select  * from mv_KF )
  loop  BC.go( k.KF);
     -- добавить эти же партиции
     Insert into AGG_MONBALS9 ( FDAT,KF, ACC,RNK,OST,OSTQ,DOS,DOSQ,KOS,KOSQ,CRDOS,CRDOSQ,CRKOS,CRKOSQ,CUDOS,CUDOSQ,CUKOS,CUKOSQ,CALDT_ID, DOS9,DOSQ9,KOS9,KOSQ9, kv)
     select m.FDAT,k.KF,m.ACC,a.RNK,m.OST,m.OSTQ,m.DOS,m.DOSQ,m.KOS,m.KOSQ,m.CRDOS,m.CRDOSQ,m.CRKOS,m.CRKOSQ,m.CUDOS,m.CUDOSQ,m.CUKOS,m.CUKOSQ, m.CALDT_ID, 0 ,0   ,0,  0,a.kv
       from AGG_MONBALS  m, accounts a
       where a.acc= m.acc and m.kf=k.kf
        and  m.fdat in ( to_date ( '01.12.2017' , 'dd.mm.yyyy' ) ,
                         to_date ( '01.01.2018' , 'dd.mm.yyyy' ) ,
                         to_date ( '01.02.2018' , 'dd.mm.yyyy' ) ,
                         to_date ( '01.03.2018' , 'dd.mm.yyyy' ) ,
                         to_date ( '01.04.2018' , 'dd.mm.yyyy' ) ,
                         to_date ( '01.05.2018' , 'dd.mm.yyyy' )
                         ) ;
     commit;
  end loop ; --mfo
  BC.go( '/');
------------------------------------
  begin  execute immediate  'CREATE UNIQUE INDEX BARS.AGG_MONBALS9_IDX ON BARS.AGG_MONBALS9 (KF, FDAT, ACC) ';
  exception when others then   null ;
  end;

end M9x1 ;
/