

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_OBPCTRANSTRAN.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_OBPCTRANSTRAN ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_OBPCTRANSTRAN 
before insert or update of transit_acc on obpc_trans_tran
for each row
declare

procedure check_acc (p_mode number, p_kv number, p_acc number, p_trantype varchar2)
is
  l_bof number;
  l_dk  number;
  l_nls accounts.nls%type;
  i     number;
begin

  if p_acc is not null and p_trantype is not null then

     select bof, dk into l_bof, l_dk
       from obpc_trans
      where tran_type = p_trantype;

     -- 0 - счет д.б. 2924
     if p_mode = 0 then

        begin
           select nls into l_nls
             from accounts
            where acc = p_acc
              and nls like '2924%';
        exception when no_data_found then
           -- Необходимо ввести счет 2924 для транзита!
           bars_error.raise_nerror('BPK', 'ONLY_2924_IN_TRANSIT');
        end;

     -- 2 - счет м.б. (6 или 2900(05) для вал)/7 класс для операций, иниц. ПЦ
     elsif p_mode = 2 and l_bof = 0 then

        select 1 into i
          from obpc_trans_in
         where tran_type = p_trantype and pay_flg = 2;

        begin
           select nls into l_nls
             from accounts
            where acc = p_acc
              and ( l_dk = 0 and (nls like '6%' or nls like '2900%' and ob22 = '05' and p_kv <> 980)
                 or l_dk = 1 and nls like '7%' );
        exception when no_data_found then
           -- Для дополнительной проводки по транзакции p_trantype допустимы только счета 6/7 класса!
           bars_error.raise_nerror('BPK', 'ONLY_67_IN_TRANSIT', p_trantype, iif_s(l_dk,0,'6(2900/05)','6(2900/05)','7'));
        end;

     end if;

  end if;

exception when no_data_found then null;
end;

begin

  -- 0 - счет д.б. 2924
  -- 2 - счет м.б. 6/7 класс
  check_acc(0, :new.kv, :new.transit_acc, :new.tran_type);
  check_acc(2, :new.kv, :new.acc_f_short, :new.tran_type);
  check_acc(2, :new.kv, :new.acc_f_long,  :new.tran_type);
  check_acc(2, :new.kv, :new.acc_u_short, :new.tran_type);
  check_acc(2, :new.kv, :new.acc_u_long,  :new.tran_type);

end;
/
ALTER TRIGGER BARS.TBIU_OBPCTRANSTRAN ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_OBPCTRANSTRAN.sql =========*** 
PROMPT ===================================================================================== 
