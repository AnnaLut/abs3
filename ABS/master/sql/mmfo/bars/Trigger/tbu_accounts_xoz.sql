

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOUNTS_XOZ.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_ACCOUNTS_XOZ ***

  CREATE OR REPLACE TRIGGER BARS.TBU_ACCOUNTS_XOZ 
  BEFORE UPDATE OF ostc, ostb, ostf ON accounts
  FOR EACH ROW
   WHEN (   old.tip IN ( 'XOZ','W4X')    AND NEW.pap = 1    ) declare    MDAT_ date ;
           sos_   opldok.sos%type  ;
           dk_    opldok.dk%type   ;
           s_     opldok.s%type    ; P_ number; Z_ int ;
           fdat_  opldok.fdat%type ;
           tt_    opldok.tt%type   ;
BEGIN

/*
29.08.2017 Sta Авто-квитовка в АБС по самой старой дате - НЕ ПОНРАВИЛАСЬ . . . Отключаем . Ждем новых предложений по авто-квитовке.
Может быть Парус все-таки  подставит нам плечо ???

 10.08.2017 Sta  Бек частичной оплаты по кредиты ( закрытие)
            автоматичним  закриттям  XOZ під час оплати авто-проводок від ПАРУС(чи любих інших по кредиту рах. XOZ)
            Сам рахунок нам відомо. Невідома дата виникнення запису в XOZ-картотеці, з якої починати таке авто-закриття.
            • Логічно закривати всі суми, починаючи з самої старої дати.
              Але це підходить для випадку, коли у вас рах .XOZ відкрито під кожну угоду, а не під клієнта (як зараз) .
              Однак, такі випадки -  кілька великих важливих угод на одному рах. XOZ ,
              по яким зроблено проплату , але закриття йде в зворотньому порядку, - бувають край рідко ,  їх слід все-таки розділити.
            • Також , лише як пропозицію на майбутнє (поки що навіть цього не роблю, а лише розмірковую) ,
              рекомендую під час введення первинного документу в ПАРУС  (це накладна ?  акт ?  тощо )
              вводити і ретранслювати в призначенні пл (або в доп.рекв) автопроводок $A
              додатковий ( НЕ обов`язковий ! ) реквізит  із серії дат у вигляді *(dd.mm.yy)
              Він і буде рекомендованою цим користувачем датою , з якої починати закриття – на відміну від автоматичної = самій старій.

 09.08.2017 Sta ВЫТЕРЕТЬ REF2 + DATZ
 28.07.2017 Sta Уже не верю и gl.astmt. а только gl.aref
 26.07.2017 Sta ХОЗ  в инвалюте
 21.07.2017 Sta  ---------- не верю gl.opl...... верю только gl.aref and  gl.astmt
 19.07.2017 СУХОВА. 1) Ввести новый тип счета W4X для бал.счетов 3550, 3551 ( хоз.деб для ПЦ)
                    2)	В модуле ХОЗ.деб считать равноценными типы счетов XOZ И W4X
------------------------------------------------------------------
 N |dk | tt  | sos | Что это
---|---|-----|-----|----------------------------------------------
*1 | 0 | ___ | 1   | чистый дебет по плану = ничего не делаем
*2 | 0 | ___ | 5   | чистый дебет по факту = помещение в картотеку
*3 | 1 | BAK | _   | Убой дебета = изъять из картотеки
---|---|-----|-----|----------------------------------------------
*4 | 1 | ___ | _   | Любой чистый кредит   = ничего не делать
*5 | 0 | BAK | _   | Снятие с визы или Бэк кредита = вытереть реф2, если он есть
------------------------------------------------------------------
*/

  If :new.OPT = 1 then RETURN; end if; -- для таких счетов этот триггер НЕ МОЖЕТ работать
  -------------------------------------------------------------------------------------------
  If     :new.OSTC >  :old.OSTC then sos_ := 5; dk_:= 1 ;
  ElsIf  :new.OSTC <  :old.OSTC then sos_ := 5; dk_:= 0 ;
  ElsIf  :new.OSTB >  :old.OSTB then sos_ := 1; dk_:= 1 ;
  ElsIf  :new.OSTB <  :old.OSTB then sos_ := 1; dk_:= 0 ;
  ElsIf  :new.OSTF >  :old.OSTF then sos_ := 3; dk_:= 1 ;
  ElsIf  :new.OSTF <  :old.OSTF then sos_ := 2; dk_:= 0 ;
  Else   RETURN ;
  end if;

  If sos_ = 5 then s_  := ABS( :old.ostc - :new.ostc) ;
  else             s_  := ABS( :old.ostB - :new.ostB) ;
  end if;

 ---------------------------------------------
--logger.info('ZZZ-*0*'|| gl.aref|| '*' || gl.astmt ||'*'|| sos_|| '*'|| dk_||'*' );



  begin select tt, fdat, dk              into tt_, fdat_, dk_            from  opldok where ref = gl.aref and stmt = gl.astmt and acc = :new.acc and dk= dk_;
  EXCEPTION WHEN NO_DATA_FOUND THEN
     begin select tt, fdat, dk, stmt    into tt_, fdat_, dk_, gl.astmt  from  opldok where ref = gl.aref and acc = :new.acc and dk= dk_ and rownum=1 ;
     EXCEPTION WHEN NO_DATA_FOUND THEN return;
     end;
  end;
--logger.info ('ZZZ-00*'||:new.nls ||':'|| :new.acc|| '*'||gl.aref||':'|| gl.astmt||':'||  dk_||':'|| fdat_ ||'*'|| tt_||'*'|| s_||'*') ;


  If    dk_ = 0 and tt_ != 'BAK' and sos_ < 5 then null ;  --logger.info ('ZZZ-1) чистый дебет по плану = ничего не делаем');
  ElsIf dk_ = 0 and tt_ != 'BAK' and sos_ = 5 then         --logger.info ('ZZZ-2) чистый дебет по факту = помещение в картотеку');
     begin MDAt_ :=  XOZ_MDATE (:new.acc, fdat_, :new.nbs, :new.ob22, :new.mdate ) ;
--logger.info('XXX-2*'|| :new.acc ||','|| fdat_ ||','|| :new.nbs ||','|| :new.ob22 ||','|| :new.mdate ||'*') ;
           INSERT INTO XOZ_ref (acc,ref1,stmt1,s,s0,fdat,mdate) values (:new.acc, gl.aref, gl.astmt, s_, s_, fdat_, MDAt_ );
--logger.info('XXX-3*'|| MDAt_|| '*' );
     exception when others then    if SQLCODE = -00001 then null;  else   raise;   end if;
     end;
  elsIf dk_ = 1 and tt_  = 'BAK'  then           ----logger.info ('ZZZ-3) Убой дебета = изъять из картотеки');
        delete from XOZ_ref where ref1 = gl.aref and stmt1 = gl.astmt ;
--elsIf dk_ = 1 and tt_ != 'BAK'  then null ; --logger.info ('ZZZ-4) Любой чистый кредит   = ничего не делать');

  elsIf dk_ = 1 and tt_ != 'BAK'  and sos_ < 5 then
     NULL ;
/* --logger.info ('ZZZ-4.a) авто-закрытие в исторической последовательности');

        for x in (select rx.rowid RI,  rx.* from xoz_ref rx where rx.acc = :new.acc and rx.ref2 is null and rx.s >0 order by rx.fdat, rx.s)
        loop
           if s_ <= 0 then EXIT; end if;
           P_ := least ( x.s, s_);  -- XOZ.OPL_REF_H2( :ACC, :REF1, :STMT1, :VDAT, :S0, :R, :Z, :P, null ) --:R(SEM=Реф.док закриття...,TYPE=N),:Z(SEM=Корр=1,TYPE=N),:P(SEM=Сума ЧАСТКИ закриття,TYPE=N)
             update xoz_ref SET ref2 = gl.aRef, datz = gl.doc.vdat, s0 = P_ where rowid = x.RI;

           If P_ < x.S  then  x.s := x.s - P_;
              INSERT INTO XOZ_ref (acc,ref1,stmt1,s,s0,fdat,mdate) values (:new.acc, x.ref1, bars_sqnc.get_nextval('s_stmt'), x.s, x.s, x.fdat,x.MDATE );
              EXIT;
           end if ; -- часткове закриття
           S_ := S_ - P_ ;

        end loop ; -- x
*/
  elsIf dk_ = 0 and tt_  = 'BAK'  then                    --logger.info ('ZZZ-5)  Снятие с визы или Бэк кредита = вытереть реф2, если он есть');
        update XOZ_ref set ref2 = null, DATZ = NULL, s = s0  where ref2 = gl.aref  ;

  else null; ---------- отсальное ?????
  end if ;

END tbu_accounts_xoz ;
/
ALTER TRIGGER BARS.TBU_ACCOUNTS_XOZ ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOUNTS_XOZ.sql =========*** En
PROMPT ===================================================================================== 
