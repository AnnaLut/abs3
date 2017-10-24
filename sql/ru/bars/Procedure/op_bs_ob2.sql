

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/OP_BS_OB2.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure OP_BS_OB2 ***

  CREATE OR REPLACE PROCEDURE BARS.OP_BS_OB2 
(P_BBBBOO   varchar2,
 P1_BRANCH  varchar2,
 P2_BRANCH  varchar2,
 P3_BRANCH  varchar2,
 P4_BRANCH  varchar2
 ) is


/*
 27-06-2013 ��� ��� ���, ����� �����
    ����-�i���.���. �� ��+��22 ��� �i����� ��(2,2+,3)
    FunNSIEdit("[PROC=>OP_BSOBV(2,:V,:A,:B,:C,:D,:E)][PAR=>:A(SEM=������,REF=V_NBSOB22),:B(SEM=�-1,REF=BRANCH_VAR),:C(SEM=�-2,REF=BRANCH_VAR),:D(SEM=�-3,REF=BRANCH_VAR),:E(SEM=�-4,REF=BRANCH_VAR)][MSG=>OK]")

 29-07-2011 Sta ����������. ����-�i���.���. �� ��+��22 ��� ���������� ������� (�� 1-�� �� 9-�� ����) 2,2+,3 ������

*/

l_dc sb_ob22.d_close%type;
------------------------------------------------------------------------
begin
  If GetGlobalOption('HAVETOBO') = '2' then   EXECUTE IMMEDIATE  'begin  tuda;  end; ';  end if;

  If length(P_BBBBOO) <>6 then       raise_application_error(-20100,  '     : ���� ����.�� ='  || P_BBBBOO || ' �� 6-�� ����i� !' ) ;
  end if;

  begin
    select d_close into l_dc from sb_ob22   where r020 = substr(P_BBBBOO,1,4) and ob22 = substr(P_BBBBOO,5,2) ;
    If l_dc <= gl.bdate then         raise_application_error(-20100, '     : ���� ����.�� ='  || P_BBBBOO || ' '|| l_dc || ' ��� �������  � ���i����� SB_OB22 ! ' );
    end if;
  EXCEPTION WHEN NO_DATA_FOUND THEN  raise_application_error(-20100,   '     : ���� ����.�� ='  || P_BBBBOO || ' �� �������� � ���i����� SB_OB22 ! ' );
  end;

  if P1_BRANCH is not null then   OP_BS_OB1 ( P1_BRANCH, P_BBBBOO );  end if;
  if P2_BRANCH is not null then   OP_BS_OB1 ( P2_BRANCH, P_BBBBOO );  end if;
  if P3_BRANCH is not null then   OP_BS_OB1 ( P3_BRANCH, P_BBBBOO );  end if;
  if P4_BRANCH is not null then   OP_BS_OB1 ( P4_BRANCH, P_BBBBOO );  end if;

end OP_BS_OB2;
/
show err;

PROMPT *** Create  grants  OP_BS_OB2 ***
grant EXECUTE                                                                on OP_BS_OB2       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on OP_BS_OB2       to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/OP_BS_OB2.sql =========*** End ***
PROMPT ===================================================================================== 
