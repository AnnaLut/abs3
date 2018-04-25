BEGIN
  
  bc.go('/');
  FOR cur IN (SELECT kf FROM bars.mv_kf) LOOP
    bc.go(cur.kf);
    delete from bars.int_ratn ir --������� ��� ������
    where ir.bdat = to_date('26.04.2018','DD.MM.YYYY') -- ������������� � 26 ������
    and ir.br is not null -- �� ��������������
    and ir.id = 1 -- ������������� ��� ������
    and ir.acc in (select acc from bars.tmp_int_ddpt tid where tid.kf = cur.kf); -- ����� ���� � �������, ������� �������� � ������������ ��� �����
    
    commit;
   END LOOP;
   
  bc.home;

end;
/
show error
