

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_2400_23_NBS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_2400_23_NBS ***

  CREATE OR REPLACE PROCEDURE BARS.P_2400_23_NBS (dat01_ DATE )  IS
-- ���������� ��������� ���������� ������ ��������������
REZ_PORT_  NUMBER  DEFAULT 0;
/*
  ver 18-02-2016 (18-09-2015, 03-08-2015, 31-12-2014)
*/

begin
  REZ_PORT_:=nvl(F_Get_Params('REZ_PORTFEL', 0) ,0);
    update nbu23_rez set nls_rez =null,nls_rezn =null,nls_rez_30 =null,
                       acc_rez =null,acc_rezn =null,acc_rez_30 =null,
                       ob22_rez=null,ob22_rezn=null,ob22_rez_30=null
  where  fdat=dat01_;
  z23.to_log_rez (user_id , 19 , dat01_ ,'������ ���������� ������ �������');
  P_2400_nbs(dat01_, '0')   ; -- �� ���������
  P_2400_nbs(dat01_, '1')   ; -- ���������
  P_2400_nbs(dat01_, '5')   ; -- ��������� ���.% ����� 30 ����
  --P_2400(dat01_, '6')   ; -- �� ��������� ���.% ����� 30 ����

  --P_2400(dat01_, 'A')   ; -- ��������� ���.% ����� 30 ����
  P_2400_nbs(dat01_, 'B')   ; -- ��������� ���.% ����� 30 ����
  P_2400_nbs(dat01_, 'C')   ; -- ��������� ���.% ����� 30 ����
  --P_2400(dat01_, 'D')   ; -- ��������� ���.% ����� 30 ����

  P_2400_nbs(dat01_, '3'); -- ������ ������
  P_2400_nbs(dat01_, '4'); -- 3119 ���
  P_2400_nbs(dat01_, '7'); --

  z23.to_log_rez (user_id , -19 , dat01_ ,'����� ���������� ������ �������');
end;
/
show err;

PROMPT *** Create  grants  P_2400_23_NBS ***
grant EXECUTE                                                                on P_2400_23_NBS   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_2400_23_NBS   to RCC_DEAL;
grant EXECUTE                                                                on P_2400_23_NBS   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_2400_23_NBS.sql =========*** End
PROMPT ===================================================================================== 
