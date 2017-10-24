-- new params for https connection 
-- work with wallet

begin
 Insert into WEB_BARSCONFIG (GROUPTYPE, KEY, COMM)
  Values (1, 'EBK.WalletDir', 'EBK - Ўл€х до створеного Wallet' );
exception
  when dup_val_on_index then null;
end;
/

begin
 Insert into WEB_BARSCONFIG (GROUPTYPE, KEY, COMM)
  Values (1, 'EBK.WalletPass', 'EBK - ѕароль до створеного Wallet' );
exception
  when dup_val_on_index then null;
end;
/

begin
  Insert into WEB_BARSCONFIG ( GROUPTYPE, KEY, COMM )
  Values ( 1, 'EBK.UserPassword', 'EBK - ѕароль користувача' );
exception
  when dup_val_on_index then null;
end;
/

begin
  Insert into WEB_BARSCONFIG ( GROUPTYPE, KEY, VAL, COMM )
  Values ( 1, 'EBK.Url', 'http://10.104.0.21/barsroot/CDMService/', 'EBK - јдреса веб-серв≥су' );
exception
  when dup_val_on_index then null;
end;
/

COMMIT;

-- COBUMMFO-4080

begin
  Insert
    into WEB_BARSCONFIG ( GROUPTYPE, KEY, VAL, COMM )
  Values ( 1, 'SOC.PensionDir', 'D:\DPT\Pension', 'SOC - каталог для файлів зарахування пенсійних виплат' );
exception
  when dup_val_on_index then null;
end;
/

begin
  Insert
    into WEB_BARSCONFIG ( GROUPTYPE, KEY, VAL, COMM )
  Values ( 1, 'SOC.SocialDir', 'D:\DPT\Social', 'SOC - каталог для файлів на зарахування соціальних виплат' );
exception
  when dup_val_on_index then null;
end;
/

COMMIT;
