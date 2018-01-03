begin
update TNAZNF t
set t.txt = '#(''Погашення простроченої заборгованості за користування системою <Клієнт-Банк>'')'
where t.n = 5;
  commit;
end;
/
