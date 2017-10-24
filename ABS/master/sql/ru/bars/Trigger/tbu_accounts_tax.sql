

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOUNTS_TAX.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_ACCOUNTS_TAX ***

  CREATE OR REPLACE TRIGGER BARS.TBU_ACCOUNTS_TAX 
BEFORE UPDATE OF dazs, vid
ON accounts
FOR EACH ROW
declare
-----------------------------------------------------------------------------
-- version 2.16 26.12.16    Суфтин:  l_bankdate := :new.dazs; -- gl.bdate;
-----------------------------------------------------------------------------

   l_nbs           varchar2(4);
   mfo_            varchar2(12);
   okpo_           varchar2(14);
   tgr_            number(1);
   nls_            varchar2(15);
   pos_            number(1);
   kv_             number;
   rez_in          number;
   rez_out         number;
   nmk_            varchar2(38);
   creg_           number(38);
   cdst_           number(38);
   ot_             number;
   acc_            number;
   l_adress        customer.adr%type;
   l_custtype      customer.custtype%type;
   l_passp         varchar2(14);
   l_bankdate      date;
   l_acc_blkid     number;
   l_trace         varchar2(1000):= 'IN_REE: ';

begin
   -- Account already closed, do nothing
   if (:old.dazs is not null) AND (:new.dazs is not null) then
      return;
   end if;

   -- Nothing changes, do nothing
   if ((:new.vid  = :old.vid)  OR (:new.vid is null AND :old.vid is null)) and
      ((:new.dazs = :old.dazs) OR (:new.dazs is null AND :old.dazs is null)) then
      return;
   end if;

   -- Accounts type not interested TaxPolice
   if ( :new.vid = :old.vid and :new.vid = 0     )                OR
      ( :old.vid is null    and :new.vid is null )                OR
      ( :new.vid<>:old.vid  and :new.vid <> 0 and :old.vid <> 0)
        then
      return;
   end if;

   -- Accounts nbs not interested TaxPolice
   begin
      select unique nbs into l_nbs from dpa_nbs where type in ('DPA','DPK','DPP') and nbs=:new.nbs;
   exception when no_data_found then
      return;
   end;


   l_bankdate := nvl(:new.DAZS, gl.BDATE);    --  26.12.16 Суфтин


   -- Account resurected!
   if (:old.dazs is not null) AND (:new.dazs is null) then
      delete from ree_tmp where nls=:old.nls and ot=3 and odat=l_bankdate and fn_o is null;
      if sql%rowcount = 0 then null;
      else
         return;
      end if;
   end if;

   -- счета с кодом "Не введено в дию" в ДПА сразу не отпрвляются
   l_acc_blkid := nvl(to_number(getglobaloption('ACC_BLKID')),0);
   if l_acc_blkid > 0 and :old.blkd = l_acc_blkid and :new.blkd = l_acc_blkid then
      return;

   elsif :old.blkd = l_acc_blkid and :new.blkd <> l_acc_blkid then

      -- считаем как открытие счета
      ot_ := 1;

   else

      if (:old.dazs is null) and (:new.dazs is not null) then
         select nvl(min(value),3) into ot_ from accountsw where acc = :old.acc and tag = 'DPAOTYPE';
      else
         if ( :new.vid <> :old.vid OR :old.vid is null ) then
            if :new.vid = 0 then
               ot_ := 3;
            else
               ot_ := 1;
            end if;
         else
               ot_ := 2;
         end if;
      end if;

   end if;

   mfo_ := gl.amfo;
   nls_ := :new.nls;
   pos_ := :new.pos;
   kv_  := :new.kv;
   acc_ := :new.acc;

   -- данные клиента
   select adr, okpo, tgr, nvl(nmkk,substr(nmk,1,38)), c_reg, c_dst, codcagent, custtype
   into   l_adress, okpo_, tgr_, nmk_, creg_, cdst_, rez_in, l_custtype
   from   customer
   where  rnk = :new.rnk;

   -- резидентность
   select rezid into rez_out from codcagent where codcagent=rez_in;

   -- для религиозных берутся данные паспорта
   if l_custtype = 3 and substr(okpo_,1,5) in ('99999', '00000') then
      begin
         select substr(trim(ser) || trim(numdoc), 1, 14) into l_passp
           from person
          where rnk = :new.rnk and passp = 1;
      exception when no_data_found then
         l_passp := null;
      end;
      if l_passp is null then
         return;
      else
         okpo_ := l_passp;
         tgr_  := 4;
         -- tgr = 4 - сер_я та номер паспорта ф_зичної особи, яка через свої
         -- рел_г_йн_ переконання в_дмовилась в_д прийняття реєстрац_йного
         -- номера обл_кової картки платника податк_в та пов_домила про це
         -- в_дпов_дний орган ДПС _ має в_дм_тку у паспорт_
      end if;
   end if;

   -- если счет откр и закр в один и тот же день - удалить запись на открытие
   if ot_ = 3 then
      delete from ree_tmp
      where nls  = nls_
        and kv   = kv_
        and ot   = 1
        and odat = l_bankdate
        and fn_o is null;

      if sql%rowcount > 0 then
         bars_audit.info(l_trace||'Рахунок '||nls_||'('||kv_||') було вiдкрито та закрито в один день ('||to_char(l_bankdate,'dd-mm-yyyy')||') iнформацiя не пiде на ДПI');
         return;
      end if;
   end if;

   update ree_tmp
      set
          mfo   = mfo_,
          id_a  = okpo_,
          rt    = tgr_,
          ot    = ot_,
          c_ag  = rez_out,
          nmk   = nmk_,
          nmkw  = nmk_,
          c_reg = creg_,
          c_dst = cdst_,
          prz   = pos_
    where nls  = nls_
      and kv   = kv_
      and ot   = ot_
      and odat = l_bankdate
      and fn_o is null;

   if sql%rowcount=0 then

       -- если счет ранимировали  - проставим прихнак открытия счета (для налоговой)
       if ot_ = 2 then
          ot_:= 1;
       end if;

      insert into ree_tmp (
             mfo, id_a, rt, ot, nls, odat, kv, c_ag,
             nmk, nmkw, c_reg, c_dst, prz )
      values (
             mfo_, okpo_, tgr_, ot_, nls_, l_bankdate, kv_, rez_out,
             nmk_, nmk_, creg_, cdst_, pos_ );
   end if;

EXCEPTION WHEN NO_DATA_FOUND THEN
   return;
end;
/
ALTER TRIGGER BARS.TBU_ACCOUNTS_TAX ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOUNTS_TAX.sql =========*** En
PROMPT ===================================================================================== 
