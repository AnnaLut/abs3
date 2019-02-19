create or replace function GET_ACC_3570_SUBSIDY -- процедура для проверки и открытия счета 3570 для начисления
(
 p_rnk accounts.rnk%type
)
---------------------------------------------------------------------------
---
---    Ф-я поиска 3570/03 для начисления комиссии за вал.переказ ЮЛ
---
---------------------------------------------------------------------------

 return accounts.nls%type is            --  Искомый ГРН-счет-плательщик комиссии

-- l_rnk   accounts.rnk%type;   --  РНК входящего счета
 l_acc1  accounts.acc%type;   --  ACC входящего счета
 l_kol   int := 0;
 
 l_nbs   accounts.nbs%type := '3570';  --  Бал 3570
 l_kv    accounts.kv%type  := 980;   -- Валюта счета 3570
 l_grp   groups_acc.id%type := 14;   --Группа счета 3570
 l_ob22  accounts.ob22%type := '62'; -- ob22 счета 3570
 l_NLS1  accounts.nls%type;   --  Новый номер счета
 l_NLS2  accounts.nls%type;   --  Искомый счет
 l_nms   customer.nmk%type;   -- НАименование клиента


 l_p4  int; -- возвращаемый параметр

begin

 ------    Находим RNK и ACC  входящего лицевого счета:
 Begin
   begin
    select substr(nmk,1,38)
      into l_nms
      from customer 
     where rnk = p_rnk;
   exception when no_data_found then raise_application_error(-20000, 'Клієнта з вказаним РНК не знайдено! (p_rnk:'||p_rnk||')');
   end;
  
    Select ACC
      into l_acc1
      From Accounts
     where rnk = p_rnk
       and nbs = l_nbs
       and ob22 = l_ob22
       and kv = l_kv
       and dazs is null;

   Exception when NO_DATA_FOUND then
      begin
         l_nls1 := Get_NLS(l_kv,l_nbs);
         op_reg_ex(mod_=> 99,
                   p1_ =>0,
                   p2_=>0,
                   p3_=> l_grp,
                   p4_=>l_p4,
                   rnk_=> p_rnk,
                   nls_ => l_nls1,
                   kv_ => l_kv,
                   nms_=> substr(l_nms, 1, 70),
                   tip_=> 'ODB' ,
                   isp_ => gl.Auid,
                   accR_=> l_acc1);

         Accreg.setAccountSParam(l_acc1, 'OB22', l_ob22) ;
         Accreg.setAccountSParam(l_acc1, 'R011', '1' );
         Accreg.setAccountSParam(l_acc1, 'S180', '1' );
         Accreg.setAccountSParam(l_acc1, 'R013', '2' );
                  Accreg.setAccountSParam(l_acc1, 'S240', '5');
      End;
 End;


 ----------------------------------------------------------------

 l_kol := 0;
 FOR k in ( Select nls from Accounts
             where RNK = p_rnk and NBS = l_nbs and OB22=l_ob22
               and KV  = l_kv   and DAZS is null
            order by DAOS desc
          )
 loop
    l_kol  := l_kol + 1;
    l_NLS2 := k.nls ;   ---  В l_NLS2 - самый "старый" 3570
 end loop;

 ----------------------------------------------------------------

 RETURN l_NLS2;

end GET_ACC_3570_SUBSIDY;
/
