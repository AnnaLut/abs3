update passp p 
set p.NRF = '������� ����������� ������ � ������ ��������',
    p.name = '������� ��.������ � ������ ������'
where p.passp = 1;

commit;

update passp p 
set p.NRF = '������� ����������� ������ � ������ ������',
    p.name = '������� ��.������ � ������ ������'
where p.passp = 7;

commit;