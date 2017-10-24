delete from  PARAMS$BASE where par in ('CA_LOGIN','CA_PASS');

begin
  insert
  into    PARAMS$GLOBAL (par,
                         val,
                         comm)
                 values ('CA_URL',
                         'http://10.10.10.101:9088/barsroot/api/cagrc',  -- это пример
                         'веб-сервер ЦA');
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
                         '&&CA_LOGIN',     -- здесь поставить реальный логин
                         'логін ЦA');
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
                         '&&CA_PASS',  -- здесь поставить реальный пароль
                         'пароль ЦA');
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
                         'валлет ЦA');
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
                         'валлет ЦA');
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
                         'таймаут');
exception when dup_val_on_index then
  null;
          when others then
  raise;
end;
/


commit;
