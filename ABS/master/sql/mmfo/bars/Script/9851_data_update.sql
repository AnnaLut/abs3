
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/patch_data_CCK_CPROD.sql =========*** R
PROMPT ===================================================================================== 

begin
bars_policy_adm.disable_policies('CCK_CPROD');
bc.go('/');
end;
/

delete from cck_cprod where 1=1;

   INSERT INTO CCK_CPROD(CPROD_ID,CPROD_NAME,PROD_VKB) VALUES (1,'�� ������ ������������ ������/������ �� ��������� ��','�107.0.01');
   INSERT INTO CCK_CPROD(CPROD_ID,CPROD_NAME,PROD_VKB) VALUES (2,'������ �� 100% �������','�102.0.01');
   INSERT INTO CCK_CPROD(CPROD_ID,CPROD_NAME,PROD_VKB) VALUES (3,'��������� ������ ����������� ���������','');
   INSERT INTO CCK_CPROD(CPROD_ID,CPROD_NAME,PROD_VKB) VALUES (4,'�� ���������� ������� �����','');
   INSERT INTO CCK_CPROD(CPROD_ID,CPROD_NAME,PROD_VKB) VALUES (5,'����������� �������','');
   INSERT INTO CCK_CPROD(CPROD_ID,CPROD_NAME,PROD_VKB) VALUES (6,'�� ��������� ���������� � �������� ���� ����������','');
   INSERT INTO CCK_CPROD(CPROD_ID,CPROD_NAME,PROD_VKB) VALUES (7,'�������, ������� ������� �� �������','');
   INSERT INTO CCK_CPROD(CPROD_ID,CPROD_NAME,PROD_VKB) VALUES (8,'�������, ��������� ������� �� �������','');
   INSERT INTO CCK_CPROD(CPROD_ID,CPROD_NAME,PROD_VKB) VALUES (9,'����� �������','');
   INSERT INTO CCK_CPROD(CPROD_ID,CPROD_NAME,PROD_VKB) VALUES (10,'���������� �������','');
   INSERT INTO CCK_CPROD(CPROD_ID,CPROD_NAME,PROD_VKB) VALUES (11,'����','');
   INSERT INTO CCK_CPROD(CPROD_ID,CPROD_NAME,PROD_VKB) VALUES (12,'�������� ����������','');
   INSERT INTO CCK_CPROD(CPROD_ID,CPROD_NAME,PROD_VKB) VALUES (13,'����������','�103.0.01');
   INSERT INTO CCK_CPROD(CPROD_ID,CPROD_NAME,PROD_VKB) VALUES (14,'���������� ��������','�104.0.01');
   INSERT INTO CCK_CPROD(CPROD_ID,CPROD_NAME,PROD_VKB) VALUES (15,'�NATIONAL POOLING PLUS�','�105.0.01');
   INSERT INTO CCK_CPROD(CPROD_ID,CPROD_NAME,PROD_VKB) VALUES (16,'�������������� ������ �� ����������� ��','�108.0.01');

COMMIT;

begin
bars_policy_adm.enable_policies('CCK_CPROD');
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/patch_data_CCK_CPROD.sql =========*** E
PROMPT ===================================================================================== 
