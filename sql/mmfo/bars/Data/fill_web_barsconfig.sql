-- new params for https connection 
-- work with wallet

begin
 Insert into WEB_BARSCONFIG (GROUPTYPE, KEY, COMM)
  Values (1, 'EBK.WalletDir', 'EBK - ���� �� ���������� Wallet' );
exception
  when dup_val_on_index then null;
end;
/

begin
 Insert into WEB_BARSCONFIG (GROUPTYPE, KEY, COMM)
  Values (1, 'EBK.WalletPass', 'EBK - ������ �� ���������� Wallet' );
exception
  when dup_val_on_index then null;
end;
/

begin
  Insert into WEB_BARSCONFIG ( GROUPTYPE, KEY, COMM )
  Values ( 1, 'EBK.UserPassword', 'EBK - ������ �����������' );
exception
  when dup_val_on_index then null;
end;
/

begin
  Insert into WEB_BARSCONFIG ( GROUPTYPE, KEY, VAL, COMM )
  Values ( 1, 'EBK.Url', 'http://10.104.0.21/barsroot/CDMService/', 'EBK - ������ ���-������' );
exception
  when dup_val_on_index then null;
end;
/

COMMIT;

-- COBUMMFO-4080

begin
  Insert
    into WEB_BARSCONFIG ( GROUPTYPE, KEY, VAL, COMM )
  Values ( 1, 'SOC.PensionDir', 'D:\DPT\Pension', 'SOC - ������� ��� ����� ����������� �������� ������' );
exception
  when dup_val_on_index then null;
end;
/

begin
  Insert
    into WEB_BARSCONFIG ( GROUPTYPE, KEY, VAL, COMM )
  Values ( 1, 'SOC.SocialDir', 'D:\DPT\Social', 'SOC - ������� ��� ����� �� ����������� ���������� ������' );
exception
  when dup_val_on_index then null;
end;
/

COMMIT;
