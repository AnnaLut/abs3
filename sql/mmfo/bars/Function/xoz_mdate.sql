create or replace FUNCTION XOZ_MDATE 
(
  p_acc   number,     
  p_fdat  date,
  p_nbs   varchar2,
  p_ob22  varchar2, 
  p_mdate date  ) return DATE  is

-- 14.06.2017 Sta ������� �������� �� ������� XOZ ��� ������������� � ��������
--                ���������� XOZ_ob22_cl ��� ����������� ���� ���������
   l_mdate DATE ;
   sp specparam%rowtype   ;

begin

  begin select  (p_fdat + x.KDX )  into l_mdate   from  XOZ_ob22_cl x where x.deb = p_nbs||p_ob22  and x.kdx > 0 ;    
  EXCEPTION WHEN NO_DATA_FOUND THEN 

     begin  select * into sp from specparam where acc = p_ACC;
            If sp.s180 = '3' then l_MDATE := p_FDAT +   7 ;            -- �i� 0 ��  7 ���
            ElsIf sp.s180 = '4' then l_MDATE := p_FDAT +  21 ;            -- �i� 8 �� 21 ���
            ElsIf sp.s180 = '5' then l_MDATE := p_FDAT +  30 ;            -- �i� 22 �� 31 ���
            ElsIf sp.s180 = '6' then l_MDATE := p_FDAT +  90 ;            -- �i� 32 �� 92 ��i�
            ElsIf sp.s180 = '7' then l_MDATE := p_FDAT + 183 ;            -- �i� 93 �� 183 ��i�
            ElsIf sp.s180 = 'A' then l_MDATE := p_FDAT + 274 ;            -- �i� 184 �� 274 ��i�
            ElsIf sp.s180 = 'B' then l_MDATE := add_months(p_FDAT,  12);  -- �i� 275 �� 365(366) ��i�
            ElsIf sp.s180 = 'C' then l_MDATE := add_months(p_FDAT,  18);  -- ³� 366(367) �� 548(549) ��i�
            ElsIf sp.s180 = 'D' then l_MDATE := add_months(p_FDAT,  24);  -- ³� 549(550) ��� �� 2 ����
            ElsIf sp.s180 = 'E' then l_MDATE := add_months(p_FDAT,  36);  -- ������ 2 �� 3 ����
            ElsIf sp.s180 = 'F' then l_MDATE := add_months(p_FDAT,  60);  -- ������ 3 �� 5 ����
            ElsIf sp.s180 = 'G' then l_MDATE := add_months(p_FDAT, 120);  -- ������ 5 �� 10 ����
            ElsIf sp.s180 = 'H' then l_MDATE := add_months(p_FDAT,1200);  -- ����� 10 ����
            end if;
     EXCEPTION WHEN NO_DATA_FOUND THEN null;
     end ; -- ����� � specparam
  end    ; -- ����� � xoz_ob22_cl

  l_mdate := NVL( l_mdate, p_mdate) ;


   RETURN l_mdate;
end XOZ_MDATE ;
/
show err;
