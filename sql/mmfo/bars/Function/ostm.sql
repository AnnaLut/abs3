create or replace FUNCTION OSTM ( p_acc number, -- ACC �����
                p_dat date   -- ����� ���� ��� ������ MM.YYYY  (  �� 01.MM.YYYY ��    31.MM.YYYY )
               )  return number  is  l_OSTM number ;  z_Dat date := TRUNC ( p_dat, 'MM'); 
-- ��������� ������� �� ��������� ������ ������ ���� ��� (��� ���������� ������ ) - �� �������� �����������
BEGIN
    begin  select ost + CRkos-CRdos   into l_OSTM    From  AGG_MONBALS    where acc = p_ACC and fdat = z_Dat ;
    EXCEPTION WHEN NO_DATA_FOUND THEN      l_OSTM := Fost( p_ACC , p_Dat);
    End;
    RETURN l_OSTM ;
END          OSTM ;
/
 show err;
 
PROMPT *** Create  grants OSTM ***
grant EXECUTE   on OSTM        to BARS_ACCESS_DEFROLE;
grant EXECUTE   on OSTM        to START1;

-----------------------

