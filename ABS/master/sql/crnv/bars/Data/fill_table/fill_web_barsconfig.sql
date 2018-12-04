prompt WEB_BARSCONFIG

begin
  insert into web_barsconfig (grouptype, key, val, comm) values (1, 'Crypto.DebugMode', '0', 'Режим відладки - 0 - вимкнено, 1 - базова, 2 - детальна');
exception
  when dup_val_on_index then
    update web_barsconfig set val = '1' where key = 'Crypto.DebugMode'; 
end;
/

begin
  insert into web_barsconfig (grouptype, key, val, comm) values (1, 'Crypto.VerifyMode', '1', 'Режим верифікації підпису');
exception
  when dup_val_on_index then
    update web_barsconfig set val = '1' where key = 'Crypto.VerifyMode'; 
end;
/

begin
  insert into web_barsconfig (grouptype, key, val, comm) values (1, 'Crypto.SignMixedMode', '1', 'Одночасна робота з декількома крипто провайдерами (VEGA+VEGA2)');
exception
  when dup_val_on_index then
    update web_barsconfig set val = '1' where key = 'Crypto.SignMixedMode'; 
end;
/

begin
  insert into web_barsconfig (grouptype, key, val, comm) values (1, 'Crypto.CryptoServer', 'http://10.10.10.96:8000/bars.security/rest/', 'Адреса серверу верифікації підпису(VEGA2)');
exception
  when dup_val_on_index then
    update web_barsconfig set val = 'http://10.10.10.96:8000/bars.security/rest/' where key = 'Crypto.CryptoServer'; 
end;
/
