PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Data/pfu_bnk_state2_mapping.sql =========*** Run *** =
PROMPT ===================================================================================== 

merge into pfu_bnk_state2_mapping m
using (select 1 as id, 2 as pfu_result, 'ser_num' as pfu_tag, '�� ������� ���� �� ����� ��������� � �������� �볺���� ���' as msg from dual
       union all
       select 2 as id, 2 as pfu_result, 'date_birth' as pfu_tag, '�� ������� ���� ���������� � �������� �볺���� ���' as msg from dual
       union all
       select 3 as id, 2 as pfu_result, '' as pfu_tag, '������������ ������� �����, ��������� �� ���, ��� �� ���������' as msg from dual
       union all
       select 4 as id, 4 as pfu_result, '' as pfu_tag, '������� ����������� ������: ORA-20097: BPK-00107 ���������� ��������� ����� � ����� 9 ��� ���� Instant' as msg from dual
       union all
       select 5 as id, 4 as pfu_result, '' as pfu_tag, '������� ����������� ������: ORA-20097: BPK-00102 �� ������� 26258551504945 � ����������� �����' as msg from dual
       union all
       select 6 as id, 4 as pfu_result, '' as pfu_tag, '������� �������� ������: ORA-20097: BPK-00052 �� ��������� ����`����� �������� �볺���' as msg from dual
       union all
       select 7 as id, 4 as pfu_result, '' as pfu_tag, '������� �������� ������: ORA-20097: BPK-00051 �������� ��� ������' as msg from dual
       union all
       select 8 as id, 4 as pfu_result, 'lnf_lat' as pfu_tag, '������� �������� ������: ORA-20000: �������� ������� ������� � ���� �� �������, �� �����������, �� ���� 25' as msg from dual
       union all
       select 9 as id, 4 as pfu_result, '' as pfu_tag, '������� ����������� ������: ORA-20097: BRS-00203 �����i���i� ����� ��''���� "BARS.ACCOUNTS" ����������' as msg from dual
       union all
       select 10 as id, 4 as pfu_result, '' as pfu_tag, '������� ����������� ������: ORA-01400: ���������� �������� NULL � ("BARS"."ACCOUNTSW"."KF")' as msg from dual
       union all
       select 11 as id, 4 as pfu_result, '' as pfu_tag, '������� ����������� ������: ORA-01400: cannot insert NULL into ("BARS"."ACCOUNTSW"."KF")' as msg from dual
       union all
       select 12 as id, 4 as pfu_result, 'ser_num' as pfu_tag, '������� �������� ������: ORA-20097: BPK-00059 ���������� ���� ���������' as msg from dual
       union all
       select 13 as id, 3 as pfu_result, 'bank_num' as pfu_tag, '�� ������ ������ � �����' as msg from dual
       union all
       select 14 as id, 2 as pfu_result, '' as pfu_tag, '������ � ����������� ������ � ������� ��������, � �� ������ RegNumberClient' as msg from dual
       ) t on (t.id = m.id)
when matched then 
  update set m.pfu_result = t.pfu_result, 
             m.msg = t.msg
when not matched then
  insert (m.id, m.pfu_result, m.pfu_tag, m.msg)
  values (t.id, t.pfu_result, t.pfu_tag, t.msg);

commit;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/pfu_bnk_state2_mapping.sql =========*** End *** =
PROMPT ===================================================================================== 
