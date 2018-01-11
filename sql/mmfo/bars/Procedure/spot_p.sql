

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SPOT_P.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SPOT_P ***

  CREATE OR REPLACE PROCEDURE BARS.SPOT_P ( Mode_ int, dat_ date DEFAULT gl.bdate) IS
 /*
  13.09.2017 Sta COBUMMFO-4222.sql
   ��������-������ ����� �� ������ ���� ��������� � �����, � �������.
   �� �� ������� ��������� ������ ���.���.���. �� ��� ����. � �� ���� ����.
   ��������, ������ ���� �������� ��������, �� ������ ����, � ���� �� ���� �������������.

   1) �������� � �������� ���� �������. �������� ����� ���� � �������� �� ������ "�������_�������� ���� ������� ���.���"
   2) ��� ����. ��� �Ѳ �������� ������������ �������� �������� ����� ������� ��������� ���������
   ��������    - ����� ����.   � �������� - ������� ����
  -----------------
  15.11.2016 Sta ��� ����. ��������� �� ������ ���
  31-07-2009 ���������� ��� ��
   ��� ����� �������� ��*   ��� �������� ��� ��������� ����� (��� ���������) ���.���.
  05.11.2007 �� �������� ���, ������� �������� ����������� � 01.01.2006
*/

  like_ varchar2(9);
  SN_   number; SN1_ number; SI_  number; KV1_ int; KV2_ int;  S1_   number; S2_  number;   DK_ int;
  K980 int :=gl.baseval;  NLS_3800 varchar2(15);
BEGIN
  like_ := '/' || gl.aMfo || '/%' ;

  If Mode_ = 0 then   DELETE from SPOT where vdate = DAT_ and branch like like_ ; end if ;  -- ��������� �� ������ ���

  -- ����������� ��������� ������ ��������
  gl.paysos0;
  commit;

  FOR X IN (select a.kv, c.acc, nvl(GREATEST(c.rate_k, c.rate_p),0)  RATE, s.ostf VX, s.DOS, s.KOS, s.ostf-s.dos+s.kos ISX , a.NLS, a.branch
             from spot C, saldoa s, accounts a
             where c.branch like like_ and c.vdate = (select max(vdate) from SPOT  where acc=c.acc AND vdate < DAT_ ) and s.acc= c.ACC and s.fdat = DAT_ and a.acc = c.ACC )
  LOOP  -- ���� ��������� ���� �� ��� ���� ���� ��������, ������� ��������� ��
     If x.ISX <> 0 then
        if sign (x.VX) <> sign(x.ISX) OR x.VX > 0 and x.ISX > 0 and x.KOS > 0 OR  x.VX < 0 and x.ISX < 0 and x.DOS > 0   then
           SN_ := 0 ; SI_ := 0 ; SN1_ := 0 ;    If x.ISX > 0 then  DK_ := 1 ; else  DK_ := 0 ;  end if ;

           FOR k in (select o.tt, o.dk, o.nlsa, o.nlsb,  p.S, o.kv KV1, o.kv2, o.s S1, o.S2, o.REF
                     from opldok p, oper o  where p.acc = X.ACC and p.ref = o.ref and p.sos = 5 and p.fdat = DAT_ and p.dk = DK_ and p.S > 0 )
           LooP
              If    k.S not in (k.S1,k.S2) or X.KV not in (k.KV1,k.KV2) or 960 in (k.KV1,k.KV2)   then  SN1_ := gl.p_icurval(x.kv,k.S,DAT_) ;  -- �������� �������� ��������
              ElsIf X.KV = k.KV1 and k.kv2 = K980                                                 then  SN1_ := k.S2  ;                        -- ������������ �������-������� �� ���
              ElsIf X.KV = k.KV2 and k.kv1 = K980                                                 then  SN1_ := k.S1  ;                        -- ������������ �������-������� �� ���
              Else  If x.KV = k.KV1  then  KV2_ := k.KV2 ; S2_ := k.S2 ;  else   KV2_ := k.KV1 ; S2_ := k.S1 ; end if ;                        -- ���������
                    If x.VX = 0 and x.ISX > 0 OR x.VX < 0 and x.ISX < 0                           then  SN1_ := gl.p_Icurval(x.KV,k.S,DAT_);   -- � ������� �������� � �����  ��� ���������� ��������
                    else  begin select Round(S2_*c.rate_k,0)                                      into  SN1_    from spot c, accounts a
                                where a.nls=NLS_3800 and a.kv=c.kv and c.acc=a.acc and c.rate_k>0 and c.kv=KV2_ and c.vdate = (select max(vdate) from SPOT where kv=c.kv and acc=c.acc AND vdate<DAT_);
                          EXCEPTION  WHEN NO_DATA_FOUND THEN                                            SN1_ := gl.p_Icurval(x.KV,k.S,DAT_);
                          end;
                    end if;
              end if;
                SI_ := SI_ + k.S ;  SN_ := SN_ + SN1_ ;
           end loop;  -- k
           ---------------------------
           If    x.VX > 0 and x.ISX >  0  then x.RATE := (x.RATE*x.VX + SN_)/ (x.VX+SI_);         -- ������ �������  ++
           elsIf x.VX = 0 and x.ISX >  0  then x.RATE := SN_/ SI_;                                -- �� 0 � �������  0+
           elsIf x.VX < 0 and x.ISX >= 0  then
              If x.ISX> 0                 then x.RATE := SN_/ SI_;  else  x.RATE := 0 ; end if ;  -- ���������� �� �������� �� ���� -+
           ElsIf x.VX < 0 and x.ISX <  0  then x.RATE := (x.RATE*(-x.VX) + SN_)/ (-x.VX+SI_) ;    -- ������ ��������   --
           elsIf x.VX = 0 and x.ISX <  0  then x.RATE := SN_/ SI_;                                -- �� 0 � ��������   0-
           elsIf x.VX > 0 and x.ISX <= 0  then
              If x.ISX< 0                 then x.RATE := SN_/ SI_;  else  x.RATE := 0 ;  end if ; -- ���������� �� ���� �� �������� +-
           end if;
        end if;
     else                                      x.RATE := 0;
     end if;

     if mode_= 0 then  INSERT into SPOT (kv,acc,vdate,RATE_k,rate_p, branch)  values (x.KV,X.acc,DAT_,x.RATE,x.RATE, x.branch );    end if;

  END LOOp;  -- x
------------
END SPOT_p;
/
show err;

PROMPT *** Create  grants  SPOT_P ***
grant EXECUTE                                                                on SPOT_P          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on SPOT_P          to START1;
grant EXECUTE                                                                on SPOT_P          to TECH005;
grant EXECUTE                                                                on SPOT_P          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SPOT_P.sql =========*** End *** ==
PROMPT ===================================================================================== 
