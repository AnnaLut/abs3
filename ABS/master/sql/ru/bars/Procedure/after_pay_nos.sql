CREATE OR REPLACE procedure BARS.after_pay_nos(p_ref oper.ref%type) is
l_swref sw_journal.swref%type;
l_swref_nos sw_journal.swref%type;
r_oper oper%rowtype;
r_oper_visa oper_visa%rowtype;
begin

 tuda;

 begin
  select o.* into r_oper_visa from oper_visa o
    where o.sqnc=(select min(sqnc) from oper_visa where ref=p_ref);
 exception when NO_DATA_FOUND then
     r_oper_visa.userid:=1;
 end;

 --Знаходим sw_ref 190/290 повідомлення
 begin
  select swref into l_swref
   from sw_oper
    where ref=p_ref;
 exception when NO_DATA_FOUND then
    l_swref:=null;
  end;
  --Знаходим sw_ref NOS
  if (l_swref is not null) then
    l_swref_nos:=bars_swift.get_message_relmsg(l_swref);
  end if;

  if(l_swref_nos is not null) then
   begin
     select o.* into r_oper from oper o, sw_oper s
      where o.ref=s.ref
      and s.swref=l_swref_nos;
   exception when NO_DATA_FOUND then RETURN;
    end;

   if(r_oper.sos=1 and r_oper.nextvisagrp!='47') then
        bars_audit.info(' На Ref:'||r_oper.ref||' не накладено 71 візу!');
   else
       if(r_oper.sos=1 and r_oper.nextvisagrp='47') then
        gl.pay(2, r_oper.ref, gl.bd);
        update oper set currvisagrp='47', nextvisagrp='!!' where ref=r_oper.ref;
        insert into oper_visa(ref, dat, userid, groupid, status, sqnc, username, usertabn, groupname, f_in_charge)
            values(r_oper.ref, sysdate, r_oper_visa.userid, 71, 2, bars_sqnc.get_nextval('s_visa'), r_oper_visa.username, r_oper_visa.usertabn, '71_Підбір НОСТРО', 1);
       else
        null;
       end if;
   end if;

  end if;

 end after_pay_nos;
/
