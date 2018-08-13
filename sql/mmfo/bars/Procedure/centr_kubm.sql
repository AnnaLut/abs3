

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CENTR_KUBM.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CENTR_KUBM ***

  CREATE OR REPLACE PROCEDURE BARS.CENTR_KUBM 
( p_VDATE     IN  bank_metals$local.fdat%Type ,
  p_KOD       IN  varchar2 ,
  p_VES       IN  varchar2 ,
  p_COMM      IN  varchar2 ,
  p_cena_kupi IN  varchar2 ,
  p_cena_prod IN  varchar2 ,
  p_RET      OUT int
 ) IS
  -----------------------------------------
  l_cena_prod  BANK_METALS.cena_prod%Type ;
  l_cena_kupi  BANK_METALS.cena_kupi%Type ;
  l_kod        BANK_METALS.kod%Type       ;
  -----------------------------------------
  fdat_ bank_metals$local.fdat%Type;
  pDAT_ date  ;                   -- ���� ���������� ������
  nDAT_ date  := trunc(p_VDATE) ; -- ���� �����     ������
  nkod_ number;
begin

/*
1. ��� �������� ��������� ������� � ���  ����� ����� ��  ��������� ��� ���� ����  ��  ����,
   �  ����� ��������� ����  �� ����� ����� ����� , �����:
   ���� ��� ������� 䳿 ����� �� ������ ������� ������ �� �������� ��� (�� ����������� ������� ����� ������ ��� �� ������� ���),
   �� ����� �� ������������, ����������  ��������  ����������� ��� ����������� ��� ������� 䳿 �����.
*/

  select max(fdat) into  fdat_ from bank_metals$local where kod = p_KOD and kf =  sys_context('bars_context','user_mfo');
  pDAT_ := Trunc(fdat_)   ; -- ���� ���������� ������

  If pDAT_ =  nDAT_ then
     -- � ������� ������ ���, ��������.
     If p_VDATE <= sysdate  then bars_error.raise_nerror('KBM', 'SYSDATE_AGAIN', to_char(p_VDATE,'dd.mm.yyyy hh24:mi:ss'), to_char(sysdate,'dd.mm.yyyy hh24:mi:ss'));


    -- then raise_application_error(-20100,
    --     '2.����+��� ���������  ����i� = ' || to_char(p_VDATE,'dd.mm.yyyy hh24:mi:ss') ||
    --    '  �   � � � � � �   ��' ||
    --     '  ����+��� ��������i� ����i� = ' || to_char(fDat_  ,'dd.mm.yyyy hh24:mi:ss') ||
    --     ' ����� ��� ! '
    --      );
     end if ;
  ElsIf nDAT_ > pDAT_ then
     -- � ������� ������ ���, ������ ���. ������.
     null;
  ElsIf nDAT_ < pDAT_
      -- �� ������� ����. ������ ��.
      then bars_error.raise_nerror('KBM', 'LAST_DAY', to_char(nDat_,'dd.mm.yyyy'), to_char(pDat_,'dd.mm.yyyy'));

  --then
      -- �� ������� ����. ������ ��.
    --        raise_application_error(-20100,
      --   '1.���� �����  ����i� = ' || to_char(nDat_,'dd.mm.yyyy') ||
        -- '  �   � � � � � �   ��' ||
         --'  ���� ������ ����i� = ' || to_char(pDat_,'dd.mm.yyyy')
         -- );

  end if;

--logger.info('BM p_Kod='||p_Kod ||
--           ' p_cena_prod='|| p_cena_prod||
--           ' p_cena_kupi=' || p_cena_kupi);

  l_kod       := to_number( p_Kod ) ;
  l_cena_prod := to_number( replace( trim(p_cena_prod), ',', '.' ) )*100 ;
  l_cena_kupi := to_number( replace( trim(p_cena_kupi), ',', '.' ) )*100 ;

  update BANK_METALS set cena_prod = l_cena_prod, cena_kupi = l_cena_kupi where kod  = l_kod;

BEGIN
  insert into BANK_METALS$LOCAL (                  BRANCH,          KOD ,   CENA,        CENA_K   , fdat )
  select  substr( sys_context('bars_context','user_branch'),1,8), l_Kod , nvl(l_cena_prod,0), nvl(l_cena_kupi,0) , p_VDATE
  from dual
--  where exists (select 1 from BANK_METALS$LOCAL where kod = l_kod and rownum=1)
  ;
  exception
  when others then
    if (sqlcode = -00001)
             then
                         logger.info('kurs-00001-'||substr( sys_context('bars_context','user_branch'),1,8)||'-'||l_Kod||'-'||p_VDATE);
                         null;
                         --02291
    elsif (sqlcode = -02291)
             then
                         logger.info('KURS_BM-20001 - ������� �������� �����  ��- '||l_kod|| ' :������� � �������� ���������� ������');
                         null;
    else raise;
    end if;
  END;

  p_RET   := 0;
  RETURN  ;

end centr_kubm;
/
show err;

PROMPT *** Create  grants  CENTR_KUBM ***
grant EXECUTE                                                                on CENTR_KUBM      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CENTR_KUBM      to START1;
grant EXECUTE                                                                on CENTR_KUBM      to TECH005;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CENTR_KUBM.sql =========*** End **
PROMPT ===================================================================================== 
