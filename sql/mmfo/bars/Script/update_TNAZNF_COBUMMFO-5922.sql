begin
update TNAZNF t
set t.txt = '#(''Погашення простроченої заборгованості за користування системою <Клієнт-Банк>'')'
where t.n = 5;
update E_TARIF t
set t.npk_3579 = replace(t.npk_3579,'за :R_DATE');
update E_TARIF t
set t.npk_3579 = replace(t.npk_3579,'за:R_DATE');
update E_TARIF t
set t.npk_3579 = replace(t.npk_3579,' :R_DATE');
update E_TARIF t
set t.npk_3579 = replace(t.npk_3579,':R_DATE');
  commit;
end;
/



