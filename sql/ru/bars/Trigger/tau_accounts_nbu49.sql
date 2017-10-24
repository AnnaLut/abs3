

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_ACCOUNTS_NBU49.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_ACCOUNTS_NBU49 ***

  CREATE OR REPLACE TRIGGER BARS.TAU_ACCOUNTS_NBU49 
  after update of ostc
  on BARS.ACCOUNTS
  for each row
   WHEN (   (    old.NBS in ('2600','2650')
             or (old.NBS='2604' and old.OB22 in (1,3,5))
             or (old.NBS like '25__' and
                old.NBS not in ('2560','2565','2568','2570','2571','2572'))
           )
           and old.ostc > new.ostc
       ) declare
  oo oper%rowtype;
  ost_ number    ; -- ���������� �������
  s_   number    ; -- ����� ��������
  nTmp_ int      ;
begin

  S_ := :old.ostc - :new.ostc ; -- ����� ��������


--- ��������� �� �������� "��������"  OK�O='20077720':

  Begin
     select 1 into nTmp_
     from   Customer
     where  rnk = :old.rnk and OKPO in ('20077720');
     RETURN ;
  EXCEPTION WHEN NO_DATA_FOUND THEN  null;
  End;

--- ��������� �� �������� �����:

  If gl.amfo = '300465' and :old.NMS like '%�����%'  then
     RETURN ;
  End If;


  begin

     Select * into oo from oper  where ref = gl.Aref;
     If oo.mfoa = gl.amfo and oo.mfob like '8%'   OR
        oo.sk in (40,50,59)           then

        RETURN ; -- ��� ��. - ������ ������ �� ��������:

        /* �������� ������������� HE ����������������� ����������� ���:
           1. ������i �� �������, ���i������ ����i� � ��� �����-����������
              ���������� �� 8.
           2. ������� �����i��� �����, ����i�, �������i�, ���i������ ������,
              �i��������:
              �)  ������� �����i��� �����, �������i�.    ���=40
              �)  ������� ����i�, ���i������ ������       ���=50,59
        */

     end if;
  EXCEPTION WHEN NO_DATA_FOUND THEN
     RETURN; -- ����� �� �.�. - ����� ����������� ���� � GL.
  End;


  If gl.amfo = '300120' then  ost_ := :old.ostc            ; -- "��������." - �� ��������� lim
  else
     if :old.lim > 0  then    ost_ := :old.ostc + :old.lim ; -- ��������� ������ ��� (lim > 0)
     else                     ost_ := :old.ostc            ; -- ����������� ������� (lim < 0) �� ���������.
     end if;
  end if;


  If  :old.dapp = gl.bdate then
      ost_ := ost_ - :old.kos + :old.dos;
      s_   := s_   + :old.DOS ;
  end if;  -- ��.�������  c ������ ������ ��� � ���� ����

  If ost_ - s_ >= 0 then
     RETURN; -- 2) ��� ��. ��������� �� ��.�������, �.�. � ��������� 49
  end if;


  -- �������� ��� ��������, ������� �� ���������� ������������, ���������  �������� 49.
  -- ��������, �.�. ��� ���������� �/�
  begin
     Select 1 into s_ from operw  where ref = gl.Aref and tag ='NBU49' ;
     RETURN;  -- 3) �� ���������� ������������
  EXCEPTION WHEN NO_DATA_FOUND THEN null;
  end;


-- ��������:  ����� ��� 'BAK'-�������� ?
  begin
     Select 1 into s_ from opldok where ref = gl.Aref and dk=0 and tt='BAK' and acc =:old.acc  and rownum=1 ;
     RETURN;  -- 4)  ��� 'BAK'-�������� ����������� �����������
  EXCEPTION WHEN NO_DATA_FOUND THEN null;
  end;


-- �������� ������������� ��� �49 �� 06.02.2014 (��.���.:%s, ���.���.:%s)
-- raise_application_error(-20203, '�������� ��������� ��� �49 �i� 06.02.2014 (���.���.:' || :old.nls || ', ���.���.:' || gl.Aref || ')');*/
  bars_error.raise_nerror('BRS', 'BROKEN_ACT_NBU49', :old.nls, gl.Aref);


end tau_accounts_NBU49;
/
ALTER TRIGGER BARS.TAU_ACCOUNTS_NBU49 DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_ACCOUNTS_NBU49.sql =========*** 
PROMPT ===================================================================================== 
