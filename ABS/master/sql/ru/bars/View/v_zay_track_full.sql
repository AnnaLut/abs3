

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZAY_TRACK_FULL.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZAY_TRACK_FULL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ZAY_TRACK_FULL ("ID", "MFO", "REQ_ID", "TRACK_ID", "CHANGE_TIME", "FIO", "VIZA", "SOS", "STATUS_NAME", "ID_PREV") AS 
  select t.id,
       substr(f_ourmfo_g,1,6),
       null,
       t.track_id,
       t.change_time,
       s.fio,
       t.new_viza viza,
       t.new_sos sos,
       decode(
          t.new_sos,
          0, decode (
                t.new_viza,
                0, '������� ��������������',
                -1, '����� � ����',
                1, decode (
                      nvl (t.old_viza, 0),
                      0, decode (
                            nvl (z.id_prev, 0),
                            0, '������������ ����� ZAY2',
                               '��������� ������ '
                            || z.id_prev),
                      '������������ ����� ZAY2'),
                2, decode (
                      nvl (t.old_viza, 0),
                      0, decode (
                            nvl (z.id_prev, 0),
                            0, '������������ ����� ZAY3',
                               '��������� ������ '
                            || z.id_prev),
                      '������������ ����� ZAY3'),
                ''),
          0.5, '������������� �������, ��������������',
          1, '������������� �������, ������������',
          2, '��������',
          -1, '�������',
          '') stan_name,
       z.id_prev
  from zay_track t, staff$base s, zayavka z
 where t.userid = s.id and z.id = t.id
union all
select z.id, t.mfo, t.req_id, t.track_id, t.change_time, t.fio,
       t.viza, t.sos, t.viza_name, null
  from zay_track_ru t, zayavka_ru z
 where t.mfo = z.mfo and t.req_id = z.req_id
 order by 1, 2;

PROMPT *** Create  grants  V_ZAY_TRACK_FULL ***
grant SELECT                                                                 on V_ZAY_TRACK_FULL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ZAY_TRACK_FULL to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZAY_TRACK_FULL.sql =========*** End *
PROMPT ===================================================================================== 
