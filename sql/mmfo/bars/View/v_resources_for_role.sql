

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_RESOURCES_FOR_ROLE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_RESOURCES_FOR_ROLE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_RESOURCES_FOR_ROLE ("ROLE_ID", "ROLE_CODE", "ROLE_NAME", "ROLE_STATE", "RESOURCE_ID", "RESOURCE_TYPE", "RESOURCE_TYPE_ID", "RESOURCE_CODE", "RESOURCE_NAME", "CURRENT_ACCESS_MODE_NAME", "NEW_ACCESS_MODE_NAME", "APPROVEMENT") AS 
  (SELECT rr.id role_id,                                -- ������������� ����
           rr.role_code,                                           -- ��� ����
           rr.role_name,                                           -- ��� ����
           list_utl.get_item_code ('STAFF_ROLE_STATE', rr.state_id)   role_state, -- ��� ��������� ���� (ACTIVE - �����������, LOCKED - �����������, ������� ����� ���� �� ��������, ����� ���� ������������ ���������������, CLOSED - �������, ������� ����� ���� �� ��������, ���� �� ����� ���� ������������)
           t.resource_id,                             -- ������������� �������
           ort.resource_name resource_type,                -- ��� ���� �������
           ort.id resource_type_id,                                             -- ��� ���� �������
           resource_utl.get_resource_code (t.resource_type_id, t.resource_id)
              resource_code,                                    -- ��� �������
           resource_utl.get_resource_name (t.resource_type_id, t.resource_id)
              resource_name,                               -- �������� �������
           list_utl.get_item_name (
              rel.access_mode_list_id,
              NVL (r.access_mode_id, rel.no_access_item_id))
              current_access_mode_name, -- ������� ������� ������� ���� � ������� �������
           list_utl.get_item_name (rel.access_mode_list_id,
                                   t.last_access_mode_id)
              new_access_mode_name,       -- ������� ������� ������� � �������
           CASE
              WHEN t.last_resolution_type_id IS NULL
              THEN
                 '�� ������������'
              ELSE
                 'ϳ�����������'
           END
              approvement -- ������� ����, ��� ������� ������� ������� �����������
      FROM (  SELECT s.grantee_type_id,
                     s.grantee_id,
                     s.resource_type_id,
                     s.resource_id,
                     MIN (s.access_mode_id)
                        KEEP (DENSE_RANK LAST ORDER BY s.id)
                        last_access_mode_id,
                     MIN (s.resolution_type_id)
                        KEEP (DENSE_RANK LAST ORDER BY s.id)
                        last_resolution_type_id
                FROM adm_resource_activity s
            GROUP BY s.grantee_type_id,
                     s.grantee_id,
                     s.resource_type_id,
                     s.resource_id) t
           JOIN adm_resource_type art
              ON     art.id = t.grantee_type_id
                 AND art.resource_code IN ('STAFF_ROLE')
           JOIN adm_resource_type ort
              ON ort.id = t.resource_type_id
           JOIN adm_resource_type_relation rel
              ON     rel.grantee_type_id = art.id
                 AND rel.resource_type_id = ort.id
           JOIN staff_role rr
              ON rr.id = t.grantee_id
           -- and  rr.role_code in ('RHO125') -- ����������� ���� �����
           LEFT JOIN adm_resource r
              ON     r.grantee_type_id = t.grantee_type_id
                 AND r.grantee_id = t.grantee_id
                 AND r.resource_type_id = t.resource_type_id
                 AND r.resource_id = t.resource_id);

PROMPT *** Create  grants  V_RESOURCES_FOR_ROLE ***
grant SELECT                                                                 on V_RESOURCES_FOR_ROLE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_RESOURCES_FOR_ROLE.sql =========*** E
PROMPT ===================================================================================== 
