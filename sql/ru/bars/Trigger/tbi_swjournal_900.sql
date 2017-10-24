

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_SWJOURNAL_900.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_SWJOURNAL_900 ***

  CREATE OR REPLACE TRIGGER BARS.TBI_SWJOURNAL_900 
before insert on sw_journal
for each row
declare
  acc_ number;

begin
   if nvl(:new.swref,0) = 0  then
      select s_sw_journal.nextval into :new.swref from dual;
   end if;

   -- sta управдение признаком дк для (900,910)х(o/i)
   -- по отношению к корсчету в абс
   ------------
   --  |910|900|
   ------------
   -- o| д | к |
   -- i| к | д |
   ------------

   acc_:=nvl(:new.accd, :new.acck);

      if ( :new.mt = 910  and   :new.io_ind = 'O' ) or
         ( :new.mt = 900  and   :new.io_ind = 'I' ) then
           :new.accd :=   acc_; :new.acck  := null ;

   elsif ( :new.mt = 900  and   :new.io_ind = 'O' ) or
         ( :new.mt = 910  and   :new.io_ind = 'I' ) then
           :new.acck :=   acc_; :new.accd  := null ;
   end if;

end;
/
ALTER TRIGGER BARS.TBI_SWJOURNAL_900 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_SWJOURNAL_900.sql =========*** E
PROMPT ===================================================================================== 
