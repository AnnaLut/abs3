

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_ACCOUNTS_TAX.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_ACCOUNTS_TAX ***

  CREATE OR REPLACE TRIGGER BARS.TAI_ACCOUNTS_TAX 
AFTER INSERT ON accounts
FOR EACH ROW
declare
-----------------------------------------------------------------------------
-- version 2.10 25.04.13
-----------------------------------------------------------------------------

   nbs_            varchar2 (4);
   mfo_            varchar2 (12);
   okpo_           varchar2 (14);
   tgr_            number (1);
   bank_date       date;
   nls_            varchar2 (15);
   pos_            number (1);
   kv_             number;
   rez_in          number;
   rez_out         number;
   nmk_            varchar2 (38);
   creg_           number   (38);
   cdst_           number   (38);
   ot_             number;
   acc_            number;
   l_adr           customer.adr%type;
   l_custtype      customer.custtype%type;
   l_passp         varchar2(14);
begin
   -- Account already closed, do nothing
   if :new.dazs is not null then
      return;
   end if;

   -- Account type don't interest Tax Police, do nothing...
   if :new.vid = 0 OR :new.vid is null then
      return;
   end if;

   -- балансовые счета только из табл. dpa_nbs
   select unique nbs into nbs_ from dpa_nbs where type in ('DPA','DPK','DPP') and nbs=:new.nbs;


   bank_date := gl.bdate;
   mfo_ := gl.amfo;
   nls_ := :new.nls;
   pos_ := :new.pos;
   kv_  := :new.kv;
   acc_ := :new.acc;
   ot_  := 1;

   -- данные клиента
   select okpo, tgr, nvl(nmkk,substr(nmk,1,38)), c_reg, c_dst, codcagent, adr, custtype
   into   okpo_, tgr_, nmk_, creg_, cdst_, rez_in, l_adr, l_custtype
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

   insert into ree_tmp
      (mfo, id_a, rt, ot, nls, odat, kv, c_ag, nmk, nmkw, c_reg, c_dst, prz
      )
   values
      (mfo_, okpo_, tgr_, ot_, nls_, bank_date, kv_, rez_out, nmk_, nmk_, creg_, cdst_, pos_
       );


exception when no_data_found then
   return;
end;
/
ALTER TRIGGER BARS.TAI_ACCOUNTS_TAX ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_ACCOUNTS_TAX.sql =========*** En
PROMPT ===================================================================================== 
