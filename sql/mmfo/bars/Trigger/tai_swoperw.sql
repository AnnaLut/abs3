

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_SWOPERW.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_SWOPERW ***

  CREATE OR REPLACE TRIGGER BARS.TAI_SWOPERW 
  AFTER INSERT ON "BARS"."SW_OPERW"
  REFERENCING FOR EACH ROW
  declare

l_mt    sw_journal.mt%type;
l_curr  sw_journal.currency%type;
l_amnt  sw_journal.amount%type;
l_tmp   sw_operw.value%type;
l_pos   number;

begin

   --
   -- Set amount for MT102 message from 32A tag
   --

   if (:new.tag = '32' and :new.opt = 'A') then

       select mt into l_mt
         from sw_journal
        where swref = :new.swref;

       if (l_mt = 102)  then

           l_curr := substr(:new.value, 7, 3);
           l_tmp  := substr(:new.value, 10);
           l_pos  := 2 - (length(l_tmp) - instr(l_tmp, ','));

           while (l_pos > 0)
           loop
               l_tmp := l_tmp || '0';
               l_pos := l_pos - 1;
           end loop;

           l_amnt := to_number(replace(l_tmp, ','));
           update sw_journal
              set currency = l_curr,
                  amount   = l_amnt
            where swref = :new.swref;

       end if;

   end if;

end;



/
ALTER TRIGGER BARS.TAI_SWOPERW ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_SWOPERW.sql =========*** End ***
PROMPT ===================================================================================== 
