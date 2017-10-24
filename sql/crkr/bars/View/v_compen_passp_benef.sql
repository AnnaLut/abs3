create or replace view v_compen_passp_benef as
select * from passp p
where p.passp in (1, --������� ����������� ������
                  3, --�������� ���  ����������
                  7, --������� ID-������(��������)
--                 98, --�������� ��� ������
--                 95, --�������� ��� ������ (�����������)
                 13, --������� �����������
                 11 --����������� ������� ��.������
--                 15, --��������� ���������� �����
--                 96, --������
--                 97  --�������� ��� ��������
                 )
order by p.name;

COMMENT ON TABLE v_compen_passp_benef  IS '������ ���� ���������, �� ��� ����������� �� ���������';
GRANT SELECT ON v_compen_passp_benef TO BARS_ACCESS_DEFROLE;