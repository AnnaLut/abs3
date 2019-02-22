

CREATE OR REPLACE TRIGGER "BARS".TI_OPER_RKO after insert on OPER
for each row
WHEN ( new.KV = 980                                           and
       new.TT in ('001','002','IB1','IB2','CL1','CL2')         and 
       substr(new.NLSA,1,4) in ('2600', '2602', '2603', '2604', '2650')
     )
declare
 ostb_  accounts.OSTB%type := null;   
 lim_   accounts.LIM%type := null;   
begin

  Select OSTB, LIM into ostb_, lim_  From ACCOUNTS where NLS = :new.NLSA and KV=980 ;

  if  ostb_ + lim_ < :new.S  then
      insert into RKO_REF (REF) values (:new.REF);
  end if;

exception when no_data_found then
  null;
end;
/



