begin
update TNAZNF t
set t.txt = '#(''��������� ����������� ������������� �� ������������ �������� <�볺��-����>'')'
where t.n = 5;
update E_TARIF t
set t.npk_3579 = replace(t.npk_3579,'�� :R_DATE');
update E_TARIF t
set t.npk_3579 = replace(t.npk_3579,'��:R_DATE');
update E_TARIF t
set t.npk_3579 = replace(t.npk_3579,' :R_DATE');
update E_TARIF t
set t.npk_3579 = replace(t.npk_3579,':R_DATE');
  commit;
end;
/



