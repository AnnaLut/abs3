

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/UPDATE_CORP_ACCOUNTS.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure UPDATE_CORP_ACCOUNTS ***

  CREATE OR REPLACE PROCEDURE BARS.UPDATE_CORP_ACCOUNTS (
   --
   --  процедура для изменения параметров  счета корп. клиента
   --  auth    : anny
   --  created : 24/10/2010
   --  modified: 02/03/2011
   --
   p_acc     number,    -- счет
   p_kodu    number,    -- код установи
   p_kodtrkk number,    -- код тркк
   p_useinvp char,      -- использование в вписке
   p_altcorp number )   -- альтернативный код корп. клиента
is
   l_kodupf   number;
begin

   if p_useinvp <> 'Y'  and p_useinvp <> 'N'  then
      bars_error.raise_nerror('REP', 'NOT_CORRECT_USEVP',p_useinvp );
   end if;

   if p_kodu is not null then
      begin
         select kod_upf into l_kodupf
           from org_pfu where kod_upf = p_kodu;
      exception when no_data_found then
         bars_error.raise_nerror('REP', 'NOT_SUCH_KODU' , to_char(p_kodu));
      end;
   end if;

   begin
      insert into specparam_int(acc, typnls)
      values(p_acc, p_kodtrkk);
   exception when dup_val_on_index then
      update specparam_int set typnls = p_kodtrkk where acc= p_acc;
   end;

   begin
      insert into accountsw(acc, tag, value)
      values(p_acc, 'KODU',  p_kodu);
   exception when dup_val_on_index then
      update accountsw  set value = p_kodu where acc= p_acc and tag = 'KODU';
   end;


   begin
      insert into accountsw(acc, tag, value)
      values(p_acc, 'CORPV',  p_useinvp);
   exception when dup_val_on_index then
      update accountsw  set value = p_useinvp where acc= p_acc and tag = 'CORPV';
   end;


   if (p_altcorp is not null) then
      begin
         insert into rnkp_kod_acc(rnk, kodk, acc)
         select rnk, p_altcorp, acc from accounts where acc = p_acc;
      exception when dup_val_on_index then
         update rnkp_kod_acc  set kodk = p_altcorp where acc= p_acc;
      end;
   end if;

  if (p_altcorp is null) then
      delete from rnkp_kod_acc where acc = p_acc;
   end if;

end;
/
show err;

PROMPT *** Create  grants  UPDATE_CORP_ACCOUNTS ***
grant EXECUTE                                                                on UPDATE_CORP_ACCOUNTS to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on UPDATE_CORP_ACCOUNTS to CORP_CLIENT;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/UPDATE_CORP_ACCOUNTS.sql =========
PROMPT ===================================================================================== 
