begin
 insert into web_barsconfig(GROUPTYPE, KEY, CSHARPTYPE, VAL, COMM)
 values (1,'WB_EADDOC_URL',null,'https:// /barsroot/webservices/makefrx.asmx','���� �� ��������� ��������� ���������� �������� �������� � ����������');
exception when dup_val_on_index then
 update web_barsconfig
    set val = 'https:// /barsroot/webservices/makefrx.asmx'
  where KEY = 'WB_EADDOC_URL';
end;
/

commit;

begin
 insert into web_barsconfig(GROUPTYPE, KEY, CSHARPTYPE, VAL, COMM)
 values (1,'WB_EADDOC_WALLETDIR',null,'file:c:\ssl','���� �� wallet-dir ��������� ���������� �������� �������� � ����������');
exception when dup_val_on_index then
 update web_barsconfig
    set val = 'file:c:\ssl'
  where KEY = 'WB_EADDOC_WALLETDIR';
end;
/

commit;

begin
 insert into web_barsconfig(GROUPTYPE, KEY, CSHARPTYPE, VAL, COMM)
 values (1,'WB_EADDOC_WALLETPASS',null,'qwerty123','������ �� wallet ������ ��������� ���������� �������� �������� � ����������');
exception when dup_val_on_index then
 update web_barsconfig
    set val = 'qwerty123'
  where KEY = 'WB_EADDOC_WALLETPASS';
end;
/

commit;

begin
 Insert into WEB_BARSCONFIG (GROUPTYPE, KEY, COMM)
  Values (1, 'EBK.WalletDir', 'EBK - ���� �� ���������� Wallet' );
exception
  when dup_val_on_index then null;
end;
/

commit;

begin
 Insert into WEB_BARSCONFIG (GROUPTYPE, KEY, COMM)
  Values (1, 'EBK.WalletPass', 'EBK - ������ �� ���������� Wallet' );
exception
  when dup_val_on_index then null;
end;
/

commit;

begin
  Insert into WEB_BARSCONFIG ( GROUPTYPE, KEY, COMM )
  Values ( 1, 'EBK.UserPassword', 'EBK - ������ �����������' );
exception
  when dup_val_on_index then null;
end;
/

commit;

begin
  Insert into WEB_BARSCONFIG ( GROUPTYPE, KEY, VAL, COMM )
  Values ( 1, 'EBK.Url', 'http://10.104.0.21/barsroot/CDMService/', 'EBK - ������ ���-������' );
exception
  when dup_val_on_index then null;
end;
/

commit;
