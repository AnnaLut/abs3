

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/AGG_02.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure AGG_02 ***

  CREATE OR REPLACE PROCEDURE BARS.AGG_02 ( p_MM_YYYY varchar2 ) is
 --��������� ���������� �������� ������� �� �������� �������� ����� � ������ ������ 10 ���� ����������
 DAT31_ date;
 DAT01_ date; --������ ����� ��������� ���.
 Fdat_  date;
 nTmp_  int;
/* ��������. gl.BDATE  = 05.12.2013
             p_MM_YYYY =    11.2013 -- ��������  ������
             DAT01_    = 01.11.2013 -- ������    ���� ��������� �������
             DAT31_    = 30.11.2013 -- ��������� ���� ��������� �������
*/

begin

  tuda;
  begin
    nTmp_ := length( p_MM_YYYY) ;
    If    nTmp_ = 5 then dat01_ := to_date ( '01-' || p_MM_YYYY ,'dd-mm-yy'   );
    ElsIf nTmp_ = 7 then dat01_ := to_date ( '01-' || p_MM_YYYY ,'dd-mm-yyyy' );
    Else                 dat01_ := to_date ( '01-' || p_MM_YYYY               );
    end if;
  exception when others then raise_application_error(-20100,'\8999 ������ ��.���i��� ������� ����: MM-20YY ��� MM-YY ��� MON-YY');
  end ;

  DAT31_ :=  add_months( Dat01_, 1 ) - 1;  -- ��������� ���.���� ���� ������

  If to_number ( to_char(gl.bdate,'DD') ) < 3  then -- ������ � ������ ��� ������ ���
      -- ��� ���������  ����������� ��������� 2 ���.���
      Fdat_ := DAT31_;
      begin
         select 1 into nTmp_ from fdat where fdat = Fdat_; -- ���� ����.���� ��� ���.
      EXCEPTION WHEN NO_DATA_FOUND THEN
         bars_accm_sync.sync_snap('BALANCE', Fdat_, 0);
         commit;
         Fdat_ := DAT31_ - 1;
         begin
            select 1 into nTmp_ from fdat where fdat = Fdat_; -- ���� ����.����. � ����.���� ���� ���������.
         EXCEPTION WHEN NO_DATA_FOUND THEN
            bars_accm_sync.sync_snap('BALANCE', Fdat_, 0);
            commit;
         end;
      end;
  end if;
  PUL.Set_Mas_Ini       ( 'MONBAL', '1' , '����� ����������� ���.������' );
  bars_accm_sync.sync_AGG('MONBAL', DAT01_, 0);
  commit;


end AGG_02 ;
/
show err;

PROMPT *** Create  grants  AGG_02 ***
grant EXECUTE                                                                on AGG_02          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on AGG_02          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/AGG_02.sql =========*** End *** ==
PROMPT ===================================================================================== 
