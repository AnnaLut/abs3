declare
  l_mod  varchar2(3) := 'ATM';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_exc  number      := -20203;
  xx OP_FIELD%rowtype;
  yy OP_RULES%rowtype;
begin suda;
  bars_error.add_module (l_mod, '������/������� � ���',0);
  bars_error.add_message(l_mod, 101, l_exc, l_ukr, '���.������ �� ������� ���� ��������' , '', 1,   'ATM_ERR1');
--bars_error.add_message(l_mod, 101, l_exc, l_rus, '������ ������������ ��������13 (%s)', '', 1, 'INVALID_K013');
  bars_error.add_message(l_mod, 102, l_exc, l_ukr, '���.������ �� ������� ����������� ��.' , '', 1, 'ATM_ERR2');
  bars_error.add_message(l_mod, 103, l_exc, l_ukr, '³������ ���.����.REFX = ���."���� "' , '', 1,    'ATM_ERR3');
  bars_error.add_message(l_mod, 104, l_exc, l_ukr, '���.REFX �� ������� ������ "����"' , '', 1,     'ATM_ERR4');
  bars_error.add_message(l_mod, 105, l_exc, l_ukr, '��������� �����' , '', 1,                          'ATM_ERR5');
  ------------------------
  xx.name := '���. ��� ����������';  xx.tag  := 'REFX '; xx.use_in_arch :=0;
  update OP_FIELD set name = xx.name where tag = xx.tag ; if SQL%rowcount = 0 then    Insert into OP_FIELD values xx ;  end if;

  yy.tt := '015'; yy.tag := xx.tag; yy.USED4INPUT := 1; yy.ord := 0; yy.OPT := 'M';
  update OP_RULES set USED4INPUT = 1, ord= 0 where tag = yy.tag and tt = yy.tt ; if SQL%rowcount = 0 then    Insert into OP_RULES  values yy ;  end if ;

end;
/
commit;

