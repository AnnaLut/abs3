CREATE OR REPLACE TRIGGER tbu_accounts_xoz
  BEFORE UPDATE OF ostc, ostb, ostf ON accounts 
  FOR EACH ROW
  WHEN (   old.tip IN ( 'XOZ','W4X')    AND NEW.pap = 1    )
declare MDAT_   date   ; 
        sos_    int    ; 
--      l_Ref1  number ;
--      l_Stmt1 number ;
--      l_RefD  number ;
        l_RZ varchar2 (250); 
        l_RX varchar2 (250); 
        l_REFD number  ;
        l_S    number  ;
BEGIN
/*
24.09.2018 Sta Авто-квитовка деб.запросов
30.08.2017 Sta Полная переделка (упрощение) триггера
*/

  If :new.OPT = 1 then RETURN; end if; -- для таких счетов этот триггер НЕ МОЖЕТ работать 
  -------------------------------------------------------------------------------------------
  If  :new.OSTC >  :old.OSTC then 
      begin select to_number (ND), s  into l_REFD, l_S
              from oper where ref = gl.aReF and tt ='R01' and dk = 1 and mfoa ='300465' and nlsa ='3739200703017' and kv = 980 and mfob = gl.aMfo ;
            select z.ROWID, x.ROWID 
              into l_RZ, l_RX 
              from xoz_ref x , XOZ_DEB_ZAP z 
             where z.KF   = gl.aMfo  and z.refd  = l_REFD  
               and z.Ref1 = x.Ref1   and z.stmt1 = x.stmt1 and z.RefD = x.Refd and z.Kf = x.KF   
               and z.sos  = 2 
               and x.acc  = :new.acc and x.ref2 is null    and x.datz is null  and x.s  = l_S  ;
            update xoz_ref     x SET x.ref2    = gl.aRef, x.datz = gl.bdate where rowid = l_RX ;
            update XOZ_DEB_ZAP z set z.ref2_KF = gl.aRef, z.sos  = 3        where rowid = l_RZ ;
     exception when others then  null;
     end;
     RETURN ;
  end if;

  If     :new.OSTC >  :old.OSTC then sos_ := 5; 
  ElsIf  :new.OSTC <  :old.OSTC then sos_ := 5; 
  ElsIf  :new.OSTB >  :old.OSTB then sos_ := 1; 
  ElsIf  :new.OSTB <  :old.OSTB then sos_ := 1; 
  ElsIf  :new.OSTF >  :old.OSTF then sos_ := 3; 
  ElsIf  :new.OSTF <  :old.OSTF then sos_ := 2; 
  Else   RETURN ;
  end if;
  -----------------------------------------------------------------------------

  for k in (select * from opldok where ref = gl.aRef and acc =:new.acc order by decode (tt,'BAK',2,1 ) ) ---and dk = 0 ) --and sos = 5)
  loop
     If    k.dk = 0 and k.tt != 'BAK' and sos_ = 5 and k.fdat <= gl.bdate  then -------------------------
--logger.info ('ZZZ-21) чистый дебет по факту = помещение в картотеку');
           begin MDAt_ :=  XOZ_MDATE (:new.acc, gl.bdate, :new.nbs, :new.ob22, :new.mdate ) ;
                 INSERT INTO XOZ_ref (acc,ref1,stmt1,s,s0,fdat,mdate) values (k.acc, k.ref, k.stmt, k.s, k.s, gl.bdate, MDAt_ );
           exception when others then    if SQLCODE = -00001 then null;  else   raise;   end if; 
           end;
     elsIf k.dk = 1 and k.tt = 'BAK'              then -------------------------
--logger.info ('ZZZ-31) Убой дебета = изъять из картотеки');
           delete from XOZ_ref where ref1 = k.ref ; -----and stmt1 = k.stmt ;
     elsIf k.dk = 0 and k.tt = 'BAK'              then -------------------------
--logger.info ('ZZZ-41)  Снятие с визы или Бэк кредита = вытереть реф2, если он есть');
           update XOZ_ref set ref2 = null, DATZ = NULL, s = s0  where ref2 = k.ref  ;
     end if ;

  end loop ;

END tbu_accounts_xoz ;
/
