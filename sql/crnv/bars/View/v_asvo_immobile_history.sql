

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_asvo_immobile_history.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view v_asvo_immobile_history ***

create or replace view v_asvo_immobile_history as
select decode(tag
              ,'FIO','ϲ�'
              ,'IDCODE','���������������� ���'
              ,'DOCTYPE','��������'
              ,'PASP_S','����'
              ,'PASP_N','�����'
              ,'PASP_W','��� ������'
              ,'PASP_D','���� ������'
              ,'BIRTHDAT','���� ����������'
              ,'BIRTHPL','̳��� ����������'
              ,'REGION','�������'
              ,'DISTRICT','�����'
              ,'CITY','̳���'
              ,'ADDRESS','������'
              ,'PHONE_H','������� �1'
              ,'PHONE_J','������� �2'
              ,'FL','������'
              ,tag) tag, --��������
       key,
       old, --����� ��������
       new, --���� ��������
       chgdate, --���� ����
       donebuy, --��� ����
       (select fio from staff$base where id = donebuy) fio --ϲ� �����������
  from asvo_immobile_history
;

PROMPT *** Create  grants  v_asvo_immobile_history ***
grant SELECT                                                                 on v_asvo_immobile_history        to BARS_ACCESS_DEFROLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_asvo_immobile_history.sql =========*** End *** =====
PROMPT ===================================================================================== 
