

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/RPTLIC_NLS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure RPTLIC_NLS ***

  CREATE OR REPLACE PROCEDURE BARS.RPTLIC_NLS (p_date1   date,
                                             p_date2   date,
                                             p_nls     varchar2 ,--           default '%',
                                             p_kv      smallint ,--            default 0,
                                             p_isp     number              default 0,
                                             p_branch  branch.branch%type  default sys_context('bars_context','user_branch'),
                                             p_inform  smallint            default 0)
as
begin


execute immediate 'truncate table tmp_lic';
execute immediate 'truncate table tmp_licM';



     -- BARS.BARS_RPTLIC.VALIDATE_NLSMASK(p_mask);

     insert into  tmp_lic (acc, nls, kv, nms)
     select acc, nls, kv, nms
       from accounts
      where (dazs is null or dazs >= p_date2) and  nls=p_nls
        and kv = p_kv ;



    --  LIC_DYNSQL
    --
    --   ������������ ������� �� ������������� ������� �� ����������� REPVP_DYNSQL
    --
    --   p_date1   -  ���� �
    --   p_date2   -  ���� ��
    --   p_inform  -  �������������� ��������� (=1 - �������, =0 - �� �������)
    --   p_kv      -  (0-���)
    --   p_mltval  -  �������� (���� =2, �������� ����� � ������ � �������)
    --   p_valeqv  -  � �������������
    --   p_valrev  -  � ����������� (revaluation)
    --   p_sqlid   -  � �������. �������    �� ����������� REPVP_DYNSQL

     BARS_RPTLIC.LIC_SQLDYN(P_DATE1   =>p_date1,
                            P_DATE2   =>p_date2,
                            P_INFORM  =>0,
                            P_KV      =>p_kv,
                            P_MLTVAL  =>2,
                            P_VALEQV  =>1,
                            P_VALREV  =>1,
                            P_SQLID   =>2);


end;
/
show err;

PROMPT *** Create  grants  RPTLIC_NLS ***
grant EXECUTE                                                                on RPTLIC_NLS      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on RPTLIC_NLS      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/RPTLIC_NLS.sql =========*** End **
PROMPT ===================================================================================== 
