
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/dat_spz.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.DAT_SPZ (P_ACC NUMBER, -- ����
        P_dat date  , -- ���� �� ������� �����
        p_zo  int     -- = 1 � ������ ����
        ) RETURN date is
/*
 24.12.2015 Sta C�� ���� ���� ������ � SALDOA. ostf= 0. dos=kos
 17.12.2015 Sta �� ������ � ��� � ����� ���� �������
 12.11.2015 Sta  �������� ����������� - �������� ���������
 06.11.2015 Sta  �����-����� �������.
 20.10.2015 Sta  ����� ���.���� ������ ���� �� ������ saldoa.FDAT
 05.10.2015 Sta ��� ������ ���������, ��� ���������� ��������� � ��� � �������� , ��������, ��� ��������. ��� �� ��
 09.07.2015 Sta = c ������ ����.��������
 ���������� �������� ���� ��������� � ������ ��������� ���������, ������� ������ "����� ������" ���������
*/

  KOS_   number ;   -- ������� ����� ��������  �� �������� ����
  KOZ_   number ;   -- ���� ���� >  ��� ���� � ����� ��� <= ���.����
  L_DAT01 DATE  ;   -- ���.����
  d_DAT   DATE  ;   -- � ���� ���.����
  Z_DAT05 DATE  ;   -- ���.���� � ������ ����
  l_ZO    int   ;
  DOZ_  number  ;
  m_Dat DATE    ; m_Kol int ;  m_Ost number; -- ����������� �� SALDOA
  g_Dat Date    ;  -- ����������� ����. ��� �� �� ������� ������
begin

/* ������� ��� �������� ������ ���������.
   ������ � (��)������������ ����������� ���� � ������� ����.

  m_Kol = ���������� �������� �� �����
  m_Dat = ����������� ���� �������� �� �����
  d_Dat = ���.���� ����� ���������� ������������� �� ������� ��� �� �Ļ
  KOS   = ������� ����� ��������  �� �������� ����

1) ���� m_Kol = 1 � ���.������� :
   � ����  d_Dat = �����, �� m_Dat,
   � ����� d_Dat
   � �����.
---- ����� ���������� ���������, ������� ������� (� ������� ����� ���) �� ��������. � ������ ����� �� ��������.

2) �����, �.�. ���� �����-�� ������� �����
   � ��������� ��� ��� FDAT, ����� ���� ���.�������, ������� � ������ �������
     ��� ���� - ������ ���� ��������� �� d_Dat, ���� �� �� ������,
     ��� ����� ��� ���������� ����������� �������� ��������, ��� ������������ ����������� � ���.

   � ��� ������� �� ��� :
     �������� ����� ���������� �������  DOS ������ ���
     �� ����� ����� ���������� �������� KOS
     KOS(�����)  = KOS(�����) � DOS(���)

   � ��� ���� = FDAT, ��� ������ KOS(�����) < 0 ��������� ���� ���������. �����.
   � ���� ������ ���, �.�. ��� ���.������� ������� ����������� (KOS=0), �� ��������� ���. �����.

*/

  L_DAT01 := NVL( P_DAT, GL.BDATE);
  Z_DAT05 := L_DAT01 + 5   ;
  g_Dat   := L_DAT01 - 100 ;

  if  P_ZO = 0 then L_ZO := 0;
  else              L_ZO := 1;
  end if;

  -- ������� ����� ��������
  select Nvl(sum(S.kos),0),  min(fdat), count(*), min(ostf-dos+kos)
  INTO             KOS_ ,    m_Dat,     m_Kol   , m_Ost
  from saldoa S where  S.acc = P_ACC and S.fdat <= L_DAT01  ;


  begin select to_date(value, 'dd-mm-yyyy') into d_Dat from accountsw where acc = p_acc and tag = 'DATVZ' ; -- ���� ���������� ������������� �� �������
  exception when no_data_found then   null;
  end ;

  If d_DAT is null then  -- ���� ���������� ������������� �� ��� ( ����� ������� )
     begin select  to_date( t.txt , 'dd-mm-yyyy')   into d_Dat  from nd_txt t, nd_acc n
           where n.acc = p_acc and n.nd = t.nd and t.tag = 'DATSP' ;  ----���� ���������� ������������ �� �������� ������
     exception when no_data_found then   null;
     end ;

  end if ;
  d_Dat := NVL( d_Dat, m_Dat);

  If m_Kol = 1 and m_Ost < 0 then  return NVL(d_Dat, m_Dat) ;  end if; -- ������. �� ��������� ���
  ------------------------------------------------------------------------

  IF L_ZO = 1 THEN   -- ������� ��������� ����/��������
     select NVL(sum(o.s),0)  INTO KOZ_
     from  opldok o,
         (SELECT FDAT FROM SALDOA WHERE ACC = P_ACC AND KOS > 0 AND ( fdat >= L_DAT01 AND fdat <= Z_DAT05)   ) S
     where O.acc = P_acc AND O.FDAT = S.FDAT AND o.sos = 5 and o.dk = 1 AND EXISTS  (SELECT 1 FROM OPER P WHERE P.REF = O.ref  and P.vob = 96 and P.vdat <= L_DAT01) ;
     KOS_ := KOS_ + KOZ_ ;
  END IF;

  --����� ����������?� �������� �� SALDOA
  For k in (select d_DAT FDAT, dos-ostf  DOS from saldoa  where acc = p_acc and fdat = m_Dat                                  union all
            select       fdat,           dos from saldoa  where acc = P_ACC and dos > 0 and fdat > m_Dat and fdat <= l_DAT01
            order by 1)
  loop KOS_ := KOS_ - k.DOS;  If KOS_ < 0 then  return k.FDAT ;  end if ; ------- ��������� ���� ���� ��� ����, ������ � �������� ������ !!!!
  end loop;                   -------------------------------------------

  If l_ZO = 1 then  --- ����� �� ��������� ����/�������� - �������� �� OPLDOK !!!!!!
     select NVL( sum(o.s),0)  INTO DOZ_
     from  opldok o,
          (SELECT FDAT FROM SALDOA WHERE ACC = P_ACC AND DOS > 0 AND ( fdat >= L_DAT01 AND fdat <= Z_DAT05)   ) S
     where O.acc = P_acc AND O.FDAT = S.FDAT AND o.sos = 5 and o.dk = 0 AND EXISTS  (SELECT 1 FROM OPER P WHERE P.REF = O.ref  and P.vob = 96 and P.vdat <= L_DAT01) ;
     KOS_ := KOS_ - DOZ_ ;    If KOS_ < 0 then RETURN l_DAT01 ;  end if ; ------- ��������� ����, �������� ���� !
  end if;                     -------------------------------------------

  RETURN to_date(null);  -- ��������� ���

end DAT_SPZ;
/
 show err;
 
PROMPT *** Create  grants  DAT_SPZ ***
grant EXECUTE                                                                on DAT_SPZ         to BARSUPL;
grant EXECUTE                                                                on DAT_SPZ         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DAT_SPZ         to START1;
grant EXECUTE                                                                on DAT_SPZ         to UPLD;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/dat_spz.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 