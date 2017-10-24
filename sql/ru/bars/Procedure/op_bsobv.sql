

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/OP_BSOBV.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure OP_BSOBV ***

  CREATE OR REPLACE PROCEDURE BARS.OP_BSOBV 
(p_mode     int,     -- 0 = ��� ��i� �����i� 2,
                     -- 1 = ��� ������ ������ 2,2+,3 �i���,
                     -- 2=��� �i����� ��(2,2+,3)
 p_KV       int,     -- ��� ���, �� ���������� 980
 P_BBBBOO   varchar2,
 P1_BRANCH  varchar2,
 P2_BRANCH  varchar2,
 P3_BRANCH  varchar2,
 P4_BRANCH  varchar2
 ) is

/*

 27.06.2013 Sta ����-�������� ������ � ����� ���, �� ���������� 980

 ��� ������
����-�i���.���. �� ��+��22 ��� ��i� �����i� 2	   FunNSIEdit("[PROC=>OP_BSOBV(0,:V,:A,'''','''','''','''')][PAR=>:A(SEM=������,REF=V_NBSOB22)][MSG=>OK]")
����-�i���.���. �� ��+��22 ��� ������ 2,2+,3 �i��� FunNSIEdit("[PROC=>OP_BSOBV(1,:V,:A,:B,'''','''',''''  )][PAR=>:A(SEM=������,REF=V_NBSOB22),:B(SEM=�����,REF=BRANCH_VAR)][MSG=>OK]")
����-�i���.���. �� ��+��22 ��� �i����� ��(2,2+,3)  FunNSIEdit("[PROC=>OP_BSOBV(2,:V,:A,:B,:C,:D,:E        )][PAR=>:A(SEM=������,REF=V_NBSOB22),:B(SEM=�-1,REF=BRANCH_VAR),:C(SEM=�-2,REF=BRANCH_VAR),:D(SEM=�-3,REF=BRANCH_VAR),:E(SEM=�-4,REF=BRANCH_VAR)][MSG=>OK]")

 ��� ����
����-�i���.���. �� ��+��22 ��� ��i� �����i� 2	   FunNSIEdit("[PROC=>OP_BS_OB(:sPar1)][PAR=>:sPar1(SEM=������,TYPE=S,REF=V_NBSOB22)][MSG=>OK OP_BS_OB!]")
����-�i���.���. �� ��+��22 ��� ������ 2,2+,3 �i��� FunNSIEdit("[PROC=>OP_BS_OB1(:sPar1,:sPar2)][PAR=>:sPar1(SEM=�����,TYPE=S,REF=BRANCH_VAR),:sPar2(SEM=������,TYPE=S,REF=V_NBSOB22)][MSG=>OK OP_BS_OB1!]")
����-�i���.���. �� ��+��22 ��� �i����� ��(2,2+,3)  FunNSIEdit("[PROC=>OP_BS_OB2(:A,:B,:C,:D,:E)][PAR=>:A(SEM=������,TYPE=S,REF=V_NBSOB22),:B(SEM=�-1,TYPE=S,REF=BRANCH_VAR),:C(SEM=�-2,TYPE=S,REF=BRANCH_VAR),:D(SEM=�-3,TYPE=S,REF=BRANCH_VAR),:E(SEM=�-4,TYPE=S,REF=BRANCH_VAR)][MSG=>OK]")

*/

------------------------------------------------------------------------
begin

  tuda;
  PUL.Set_Mas_Ini( 'OP_BSOB_KV', to_char( NVL(p_KV,gl.baseval)),'KV ��� ����-���� ��' );

  If    p_mode = 0 then  OP_BS_OB ( P_BBBBOO );                                             -- ��� ��i� �����i� 2,
  ElsIf p_mode = 1 then  OP_BS_OB1( P1_BRANCH, P_BBBBOO ) ;                                 -- ��� ������ ������ 2,2+,3 �i���,
  elsIf p_mode = 2 then  OP_BS_OB2( P_BBBBOO, P1_BRANCH, P2_BRANCH, P3_BRANCH, P4_BRANCH ); -- ��� �i����� ��(2,2+,3)
  end if;

end OP_BSOBV;
/
show err;

PROMPT *** Create  grants  OP_BSOBV ***
grant EXECUTE                                                                on OP_BSOBV        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on OP_BSOBV        to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/OP_BSOBV.sql =========*** End *** 
PROMPT ===================================================================================== 
