begin
  begin
    insert into op_field (TAG, NAME, FMT, BROWSER, NOMODIFY, VSPO_CHAR, CHKR, DEFAULT_VALUE, TYPE, USE_IN_ARCH)
    values ('F092 ', '�������� F092 ��� ������� ���', null, 'TagBrowse("SELECT F092 kod, TXT naim FROM F092")', null, null, null, null, null, 1);
  exception
    when DUP_VAL_ON_INDEX then
      update op_field
         set NAME = '�������� F092 ��� ������� ���',
             FMT = null,
             BROWSER = 'TagBrowse("SELECT F092 kod, TXT naim FROM F092")', --�������� ����� ������� � KOD_F092
             NOMODIFY = null,
             VSPO_CHAR = null,
             CHKR = null,
             DEFAULT_VALUE = null,
             TYPE = null,
             USE_IN_ARCH = 1
       where TAG = 'F092 ';
  end;
  
  begin
    insert into op_rules (TT, TAG, OPT, USED4INPUT, ORD, VAL, NOMODIFY) --����� ��� F092 ��� ���� ���������� FX2
    values ('FX2', 'F092 ', 'O', 1, 2, null, null);
  exception
    when DUP_VAL_ON_INDEX then
      update op_rules
         set OPT = 'O',
             USED4INPUT = 1,
             ORD = 2,
             VAL = null,
             NOMODIFY = null
       where TT = 'FX2'
         and TAG = 'F092 ';
  end;
  
  commit;
end;
/
