
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fostzn.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FOSTZN 
(p_ACC  INT,
 p_DAT date, -- �������� ����. �.�. ����, �� ������� ���� ����� �������
 p_DDD DATE DEFAULT null -- �� ���������� . ������ ����   null
 ) RETURN DECIMAL IS

/*
26-10-2010 ����������� ���� ��� : 31, 01, . . ., 05,06, . . . , 15,16, . . ., 31
  ���� ������, ������ ��� 31 �����

26.10.2010 Sta ��������� ��� � ������ ����.��������.
  c NULL - �����.���������
  �������� ������������ �� � ��� (� ������� CP)
*/

  DD_ int;
  s_DAT date ; -- ����.����.����

  DAT_01 date ;  -- ���� ������ ������ ����. >= 01 �����
  DAT_15 date ;  -- ���� ���������� ������ ���� = 15 �����

  nn1_   DECIMAL := 0 ;
  nn2_   DECIMAL := 0 ;

BEGIN

  --�����-1. ����� ������������ ������� �� ���.����
  BEGIN
    SELECT ostf-dos+kos   INTO nn1_   from saldoa
    WHERE acc=p_ACC AND FDAT=(select max(fdat) from saldoa where acc=p_ACC and fdat <= p_DAT ) ;
  EXCEPTION WHEN NO_DATA_FOUND THEN nn1_:=0;
  END;

  DD_ := to_number( to_char( p_DAT, 'DD' ) );

  If  DD_ < 15 then

     -- �) 01-14 ��� ������ ��� ��� ��� ���
     --    ����. � ������� ��� ��������
     --  + �.�. � �������
     DAT_01 := p_DAT + 1 ;

  ElsIf DD_ >= 15 and DD_ <= 25  then

     -- �) 15-25  ����. ������ �� ����. ��� ��� ��������
     RETURN nn1_ ;

  Else

     -- ����.����.����
     select min(fdat) into  s_DAT from fdat where fdat > p_DAT ;

     If to_char( s_DAT, 'YYYYMM' ) = to_char( p_DAT, 'YYYYMM' ) then

        -- �) ��� ������� 26 27 28 29 30 �����, �� �� ��������� � ���
        --    ����. ������ �� ����.
        RETURN nn1_ ;

     Else

        -- �) (26 27 28 29 30) 31 ��� ��������� ��� ���� � ���.
        --   + ����. �.�. ������ � �������
        DAT_01 := s_DAT;

     end if;

 end if;

 DAT_15 := trunc (  DAT_01,'MM') + 14;

  --�����-2. ��������� ������ �� ����
  select Nvl( sum( o.S * decode (o.dk,0,-1,1) ),0 )  into nn2_  from opldok o
  where fdat >=  DAT_01 and FDAT <= DAT_15 and acc=p_ACC
    and exists (select 1 from oper where ref=o.REF and vob in (96,99) );

  nn1_ := nn1_ + nn2_;
  RETURN  nn1_;

END FOSTZn;
/
 show err;
 
PROMPT *** Create  grants  FOSTZN ***
grant EXECUTE                                                                on FOSTZN          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FOSTZN          to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fostzn.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 