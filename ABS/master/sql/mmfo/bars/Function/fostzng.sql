
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fostzng.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FOSTZNG 
(p_ACC  INT,
 p_DAT date, -- �������� ����. �.�. ����, �� ������� ���� ����� �������
 p_DDD DATE DEFAULT null -- �� ���������� . ������ ����   null
 ) RETURN DECIMAL IS

  DD_ int;
  s_DAT date ; -- ����.����.����

  DAT_01 date ;  -- ���� ������ ������ ����. >= 01 �����
  DAT_15 date ;  -- ���� ���������� ������ ���� = 15 �����

  nn1_   DECIMAL := 0 ;
  nn2_   DECIMAL := 0 ;
  nn3_   DECIMAL := 0 ;

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
 if  extract(MONTH from p_DAT) not in (12)
 then
  DAT_15 := trunc (  DAT_01,'MM') + 14;
 else  
  DAT_15 := trunc (  DAT_01,'MM') + 30;
 end if; 

  --�����-2. ��������� ������ �� ����

    SELECT NVL (SUM (o.S * DECODE (o.dk, 0, -1, 1)), 0)
      INTO nn2_
      FROM opldok o
     WHERE     fdat >= DAT_01
           AND FDAT <= DAT_15
           AND acc = p_ACC
           AND EXISTS
                  (SELECT 1
                     FROM oper
                    WHERE REF = o.REF AND vob IN (96, 99));

  nn1_ := nn1_ + nn2_;
  -- ����� �������
    SELECT NVL (SUM (o.S * DECODE (o.dk, 0, -1, 1)), 0)
      INTO nn3_
      FROM opldok o
     WHERE     fdat >= DAT_01
           AND FDAT <= DAT_15+16
           AND acc = p_ACC
           AND EXISTS
                  (SELECT 1
                     FROM oper
                    WHERE REF = o.REF AND vob =99 and tt = '097');
  nn1_ := nn1_ + nn3_;
  RETURN  nn1_;

END FOSTZng;
/
 show err;
 
PROMPT *** Create  grants  FOSTZNG ***
grant EXECUTE                                                                on FOSTZNG         to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fostzng.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 