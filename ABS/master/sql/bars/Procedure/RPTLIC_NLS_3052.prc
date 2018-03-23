CREATE OR REPLACE procedure BARS.rptlic_nls_3052 (p_date1   date,
                                                  p_date2   date)
as
begin


execute immediate 'truncate table tmp_lic';
execute immediate 'truncate table tmp_licM';



     -- BARS.BARS_RPTLIC.VALIDATE_NLSMASK(p_mask);

     insert into  tmp_lic (acc, nls, kv, nms)
     select acc, nls, kv, nms
       from accounts
      where (dazs is null or dazs >= p_date2) and  nbs in (select nbs from lic_nbs_dksu)
           ;



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
                            P_KV      =>0,
                            P_MLTVAL  =>2,
                            P_VALEQV  =>1,
                            P_VALREV  =>1,
                            P_SQLID   =>2);


end;
/

GRANT execute ON BARS.rptlic_nls_3052 TO BARS_ACCESS_DEFROLE;

GRANT execute ON BARS.rptlic_nls_3052 TO START1;