CREATE OR REPLACE TRIGGER tbu_accounts_xoz
  BEFORE UPDATE OF ostc, ostb, ostf ON accounts 
  FOR EACH ROW
  WHEN (   old.tip IN ( 'XOZ','W4X')    AND NEW.pap = 1    )
/*
30.08.2017 Sta Полная переделка (упрощение) триггера
*/
declare    MDAT_ date ;  sos_   opldok.sos%type  ; 
BEGIN
  If :new.OPT = 1 then RETURN; end if; -- для таких счетов этот триггер НЕ МОЖЕТ работать 
  -------------------------------------------------------------------------------------------
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

--logger.info ('ZZZ-20)'|| k.ref ||'*'|| k.stmt ||'*'||k.s||'*'||k.dk||'*'||k.sos||'*'||k.tt||'*');
--logger.info ('ZZZ-21) чистый дебет по факту = помещение в картотеку');
           begin MDAt_ :=  XOZ_MDATE (:new.acc, gl.bdate, :new.nbs, :new.ob22, :new.mdate ) ;
                 INSERT INTO XOZ_ref (acc,ref1,stmt1,s,s0,fdat,mdate) values (k.acc, k.ref, k.stmt, k.s, k.s, gl.bdate, MDAt_ );
           exception when others then    if SQLCODE = -00001 then null;  else   raise;   end if; 
           end;

     elsIf k.dk = 1 and k.tt = 'BAK'              then -------------------------
--logger.info ('ZZZ-30)'|| k.ref ||'*'|| k.stmt ||'*'||k.s||'*'||k.dk||'*'||k.sos||'*'||k.tt||'*');
--logger.info ('ZZZ-31) Убой дебета = изъять из картотеки');
           delete from XOZ_ref where ref1 = k.ref ; -----and stmt1 = k.stmt ;

     elsIf k.dk = 0 and k.tt = 'BAK'              then -------------------------
--logger.info ('ZZZ-40)'|| k.ref ||'*'|| k.stmt ||'*'||k.s||'*'||k.dk||'*'||k.sos||'*'||k.tt||'*');
--logger.info ('ZZZ-41)  Снятие с визы или Бэк кредита = вытереть реф2, если он есть');
           update XOZ_ref set ref2 = null, DATZ = NULL, s = s0  where ref2 = k.ref  ;
     end if ;

  end loop ;

END tbu_accounts_xoz ;
/