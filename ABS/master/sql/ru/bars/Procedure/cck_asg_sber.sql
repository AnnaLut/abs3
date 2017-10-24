

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CCK_ASG_SBER.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CCK_ASG_SBER ***

  CREATE OR REPLACE PROCEDURE BARS.CCK_ASG_SBER (tip_ in number, mode_ int default 1) is
begin
/*
  27.07.2016 ��������� �������� mode_, ���� ���� �������� ��������:
        mode_ = 1 ��������� ������ (������������ ������� ������� 2625)
        mode_ = 2 ��������� ������ (�� ������������ ������� ������� 2625)
  07.07.2015 ��� ����������� ��.������� ���������: 3739*SG, 2620*DEP,  2625.BPk
  ����.��������� ��� �� �������� ������� �� ����-���������.
  ������� � ����� ���������� �� �� � ��
  �� ��� ��������. ���������-��������� �.�. ����
http://svn.unity-bars.com.ua:8080/svn/bars/Releases/Customers/State Savings Bank of Ukraine/Projects/COBUSUP/Public/Delta89/Add/sql/bars/004cck_asg_sber.sql
*/

-- tip ������� 2 �� 3 ��
if nvl( Tip_,0) NOT  in (2,3) then cck.CC_ASG ( 0 ); end if;
------------------------------------------------------------
for k in (select d.nd
            from accounts a, nd_acc n, cc_deal d
            where d.nd   = n.nd  AND  a.acc  = n.acc
              and d.sos  < 15    and  d.sos >= 10
              AND (a.tip ='SG '  OR   a.nbs  = '2620' OR a.nbs = '2625' )
              AND (a.OSTC >= 0    AND  a.ostC = a.ostB OR a.nbs = '2625' )
              AND (d.vidd in ( 1, 2, 3) and tip_ = 2
                   OR
                   d.vidd in (11,12,13) and tip_ = 3
                  )
           )
loop     cck.CC_ASG ( -k.nd, mode_ );  end loop;

end;
/
show err;

PROMPT *** Create  grants  CCK_ASG_SBER ***
grant EXECUTE                                                                on CCK_ASG_SBER    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CCK_ASG_SBER    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CCK_ASG_SBER.sql =========*** End 
PROMPT ===================================================================================== 
