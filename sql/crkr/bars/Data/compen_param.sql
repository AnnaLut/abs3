delete from  PARAMS$BASE where par in ('CA_LOGIN','CA_PASS');

begin
  insert
  into    PARAMS$GLOBAL (par,
                         val,
                         comm)
                 values ('CA_URL',
                         'http://10.10.10.101:9088/barsroot/api/cagrc',  -- ��� ������
                         '���-������ �A');
exception when dup_val_on_index then
  null;
          when others then
  raise;
end;
/

--

begin
  insert
  into    PARAMS$GLOBAL (par,
                         val,
                         comm)
                 values ('CA_LOGIN',
                         '&&CA_LOGIN',     -- ����� ��������� �������� �����
                         '���� �A');
exception when dup_val_on_index then
  null;
          when others then
  raise;
end;
/

--

begin
  insert
  into    PARAMS$GLOBAL (par,
                         val,
                         comm)
                 values ('CA_PASS',
                         '&&CA_PASS',  -- ����� ��������� �������� ������
                         '������ �A');
exception when dup_val_on_index then
  null;
          when others then
  raise;
end;
/

--

begin
  insert
  into    PARAMS$GLOBAL (par,
                         val,
                         comm)
                 values ('CA_WALLET_PATH',
                         '&CA_WALLET_PATH',
                         '������ �A');
exception when dup_val_on_index then
  null;
          when others then
  raise;
end;
/

--

begin
  insert
  into    PARAMS$GLOBAL (par,
                         val,
                         comm)
                 values ('CA_WALLET_PASS',
                         '&CA_WALLET_PASS',
                         '������ �A');
exception when dup_val_on_index then
  null;
          when others then
  raise;
end;
/

--

begin
  insert
  into    PARAMS$GLOBAL (par,
                         val,
                         comm)
                 values ('CA_TIMEOUT',
                         '&&CA_TIMEOUT',
                         '�������');
exception when dup_val_on_index then
  null;
          when others then
  raise;
end;
/


commit;
