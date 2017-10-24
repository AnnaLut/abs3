
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_pop_otcn.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_POP_OTCN (Dat_ DATE, type_ NUMBER,
                                       sql_acc_ VARCHAR2,
                                       datp_ IN DATE DEFAULT NULL,
                                       add_KP_ in number default 0,
                                       tp_sql_ in number default 0
                                          )
RETURN NUMBER IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	������� ���������� ������ ��� ������������ ����������
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 03/03/2012 (09/08/2011)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
���������:
 Dat_ - �������� ����
 type_- ��� ���������� (1 - ������ ������� �� ����
                        2 - ������� + �������������� ��������
                        3 - ������� + �������������� �������
                            (�� �������� � ������. �����, � �������)
                             + �������� �������
                        4 - ������������ ������� ������ (�4, 81 � �.�.)
                        5 - ������������ ��������� (��� ��� 3, �� ��������
                            ��������� ���������)
 sql_acc_ - ������ �������������� ���-�� ������ ����������� � �������
 datp_    - ���� ������ ������� (��� type_ = 5)
 add_KP_  - ���������� ������ REF_KOR � KOR_PROV (0 - ���, 1 - ��)
 tp_sql_  - ��� ������� � sql_acc_ (=0 - ����� �� NBS, = 1 - �� ACC)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
    ret_ number;
begin
    ret_ :=  F_Pop_Otcn_SNP(Dat_,  type_,  sql_acc_,  datp_, tp_sql_, add_KP_);

    return ret_;
END;
/
 show err;
 
PROMPT *** Create  grants  F_POP_OTCN ***
grant EXECUTE                                                                on F_POP_OTCN      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_POP_OTCN      to RPBN001;
grant EXECUTE                                                                on F_POP_OTCN      to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_pop_otcn.sql =========*** End ***
 PROMPT ===================================================================================== 
 