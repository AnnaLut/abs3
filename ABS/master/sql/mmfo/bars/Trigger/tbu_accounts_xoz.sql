

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
29.08.2017 Sta ����-�������� � ��� �� ����� ������ ���� - �� ����������� . . . ��������� . ���� ����� ����������� �� ����-��������.
����� ���� ����� ���-����  ��������� ��� ����� ???

 10.08.2017 Sta  ��� ��������� ������ �� ������� ( ��������)
            ������������  ���������  XOZ �� ��� ������ ����-�������� �� �����(�� ����� ����� �� ������� ���. XOZ)
            ��� ������� ��� �����. ������� ���� ���������� ������ � XOZ-���������, � ��� �������� ���� ����-��������.
            � ������ ��������� �� ����, ��������� � ���� ����� ����.
              ��� �� �������� ��� �������, ���� � ��� ��� .XOZ ������� �� ����� �����, � �� �� �볺��� (�� �����) .
              �����, ��� ������� -  ����� ������� �������� ���� �� ������ ���. XOZ ,
              �� ���� �������� �������� , ��� �������� ��� � ����������� �������, - ������� ���� ���� ,  �� ��� ���-���� ��������.
            � ����� , ���� �� ���������� �� ������� (���� �� ����� ����� �� �����, � ���� ����������) ,
              ���������� �� ��� �������� ���������� ��������� � �����  (�� �������� ?  ��� ?  ���� )
              ������� � ������������� � ���������� �� (��� � ���.����) ������������ $A
              ���������� ( �� ����`������� ! ) �������  �� ��� ��� � ������ *(dd.mm.yy)
              ³� � ���� �������������� ��� ������������ ����� , � ��� �������� �������� � �� ����� �� ����������� = ���� �����.

 09.08.2017 Sta �������� REF2 + DATZ
 28.07.2017 Sta ��� �� ���� � gl.astmt. � ������ gl.aref
 26.07.2017 Sta ���  � ��������
 21.07.2017 Sta  ---------- �� ���� gl.opl...... ���� ������ gl.aref and  gl.astmt
 19.07.2017 ������. 1) ������ ����� ��� ����� W4X ��� ���.������ 3550, 3551 ( ���.��� ��� ��)
                    2)	� ������ ���.��� ������� ������������ ���� ������ XOZ � W4X
------------------------------------------------------------------
 N |dk | tt  | sos | ��� ���
---|---|-----|-----|----------------------------------------------
*1 | 0 | ___ | 1   | ������ ����� �� ����� = ������ �� ������
*2 | 0 | ___ | 5   | ������ ����� �� ����� = ��������� � ���������
*3 | 1 | BAK | _   | ���� ������ = ������ �� ���������
---|---|-----|-----|----------------------------------------------
*4 | 1 | ___ | _   | ����� ������ ������   = ������ �� ������
*5 | 0 | BAK | _   | ������ � ���� ��� ��� ������� = �������� ���2, ���� �� ����
------------------------------------------------------------------
*/

  If :new.OPT = 1 then RETURN; end if; -- ��� ����� ������ ���� ������� �� ����� ��������
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


  If    dk_ = 0 and tt_ != 'BAK' and sos_ < 5 then null ;  --logger.info ('ZZZ-1) ������ ����� �� ����� = ������ �� ������');
  ElsIf dk_ = 0 and tt_ != 'BAK' and sos_ = 5 then         --logger.info ('ZZZ-2) ������ ����� �� ����� = ��������� � ���������');
     begin MDAt_ :=  XOZ_MDATE (:new.acc, fdat_, :new.nbs, :new.ob22, :new.mdate ) ;
--logger.info('XXX-2*'|| :new.acc ||','|| fdat_ ||','|| :new.nbs ||','|| :new.ob22 ||','|| :new.mdate ||'*') ;
           INSERT INTO XOZ_ref (acc,ref1,stmt1,s,s0,fdat,mdate) values (:new.acc, gl.aref, gl.astmt, s_, s_, fdat_, MDAt_ );
--logger.info('XXX-3*'|| MDAt_|| '*' );
     exception when others then    if SQLCODE = -00001 then null;  else   raise;   end if;
     end;
  elsIf dk_ = 1 and tt_  = 'BAK'  then           ----logger.info ('ZZZ-3) ���� ������ = ������ �� ���������');
        delete from XOZ_ref where ref1 = gl.aref and stmt1 = gl.astmt ;
--elsIf dk_ = 1 and tt_ != 'BAK'  then null ; --logger.info ('ZZZ-4) ����� ������ ������   = ������ �� ������');

  elsIf dk_ = 1 and tt_ != 'BAK'  and sos_ < 5 then
     NULL ;
/* --logger.info ('ZZZ-4.a) ����-�������� � ������������ ������������������');

        for x in (select rx.rowid RI,  rx.* from xoz_ref rx where rx.acc = :new.acc and rx.ref2 is null and rx.s >0 order by rx.fdat, rx.s)
        loop
           if s_ <= 0 then EXIT; end if;
           P_ := least ( x.s, s_);  -- XOZ.OPL_REF_H2( :ACC, :REF1, :STMT1, :VDAT, :S0, :R, :Z, :P, null ) --:R(SEM=���.��� ��������...,TYPE=N),:Z(SEM=����=1,TYPE=N),:P(SEM=���� ������ ��������,TYPE=N)
             update xoz_ref SET ref2 = gl.aRef, datz = gl.doc.vdat, s0 = P_ where rowid = x.RI;

           If P_ < x.S  then  x.s := x.s - P_;
              INSERT INTO XOZ_ref (acc,ref1,stmt1,s,s0,fdat,mdate) values (:new.acc, x.ref1, bars_sqnc.get_nextval('s_stmt'), x.s, x.s, x.fdat,x.MDATE );
              EXIT;
           end if ; -- �������� ��������
           S_ := S_ - P_ ;

        end loop ; -- x
*/
  elsIf dk_ = 0 and tt_  = 'BAK'  then                    --logger.info ('ZZZ-5)  ������ � ���� ��� ��� ������� = �������� ���2, ���� �� ����');
        update XOZ_ref set ref2 = null, DATZ = NULL, s = s0  where ref2 = gl.aref  ;

  else null; ---------- ��������� ?????
  end if ;

END tbu_accounts_xoz ;
/
ALTER TRIGGER BARS.TBU_ACCOUNTS_XOZ ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOUNTS_XOZ.sql =========*** En
PROMPT ===================================================================================== 
