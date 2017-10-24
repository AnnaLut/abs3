

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/INS_PODOTK.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger INS_PODOTK ***

  CREATE OR REPLACE TRIGGER BARS.INS_PODOTK 
  INSTEAD OF INSERT OR DELETE OR UPDATE ON "BARS"."PODOTK"
  REFERENCING FOR EACH ROW
  begin
 if inserting then
  if :new.fio is not null and :new.fio<>' ' then
    insert into podotc (ID, TAG,VAL) values (:new.id,'FIO',:new.fio);
  end if;
  if :new.nls is not null and :new.nls<>' ' then
    insert into podotc (ID, TAG,VAL) values (:new.id,'NLS',:new.nls);
  end if;
  if :new.atrt is not null and :new.atrt<>' ' then
  insert into podotc (ID, TAG,VAL) values (:new.id,'ATRT',:new.atrt);
  end if;
  if :new.adres is not null and :new.adres<>' ' then
  insert into podotc (ID, TAG,VAL) values (:new.id,'ADRES',:new.adres);
  end if;
  if :new.pasp is not null and :new.pasp<>' ' then
  insert into podotc (ID, TAG,VAL) values (:new.id,'PASP',:new.pasp);
  end if;
  if :new.paspn is not null and :new.paspn<>' ' then
  insert into podotc (ID, TAG,VAL) values (:new.id,'PASPN',:new.paspn);
  end if;
  if :new.dt_r is not null and :new.dt_r<>' ' then
  insert into podotc (ID, TAG,VAL) values (:new.id,'DT_R',:new.dt_r);
  end if;
 else
   if updating then
    begin
     if :new.fio is not null and :new.fio<>' ' then
	  if :old.fio is null then
	   insert into podotc (ID, TAG,VAL) values (:old.id,'FIO',:new.fio);
  	  else
       update podotc set VAL=:new.fio where id=:old.id and tag='FIO';
	  end if;
	 else delete from podotc where id=:old.id and tag='FIO';
	 end if;
     if :new.nls is not null and :new.nls<>' ' then
	  if :old.nls is null then
	   insert into podotc (ID, TAG,VAL) values (:old.id,'NLS',:new.nls);
  	  else
       update podotc set VAL=:new.nls where id=:old.id and tag='NLS';
	  end if;
	 else delete from podotc where id=:old.id and tag='NLS';
	 end if;
     if :new.atrt is not null and :new.atrt<>' ' then
	  if :old.atrt is null then
	   insert into podotc (ID, TAG,VAL) values (:old.id,'ATRT',:new.atrt);
  	  else
       update podotc set VAL=:new.atrt where id=:old.id and tag='ATRT';
	  end if;
	 else delete from podotc where id=:old.id and tag='ATRT';
	 end if;
     if :new.adres is not null and :new.adres<>' ' then
	  if :old.adres is null then
	   insert into podotc (ID, TAG,VAL) values (:old.id,'ADRES',:new.adres);
  	  else
       update podotc set VAL=:new.adres where id=:old.id and tag='ADRES';
	  end if;
	 else delete from podotc where id=:old.id and tag='ADRES';
	 end if;
     if :new.pasp is not null and :new.pasp<>' ' then
	  if :old.pasp is null then
	   insert into podotc (ID, TAG,VAL) values (:old.id,'PASP',:new.pasp);
  	  else
       update podotc set VAL=:new.pasp where id=:old.id and tag='PASP';
	  end if;
	 else delete from podotc where id=:old.id and tag='PASP';
	 end if;
     if :new.paspn is not null and :new.paspn<>' ' then
	  if :old.paspn is null then
	   insert into podotc (ID, TAG,VAL) values (:old.id,'PASPN',:new.paspn);
  	  else
       update podotc set VAL=:new.paspn where id=:old.id and tag='PAPSN';
	  end if;
	 else delete from podotc where id=:old.id and tag='PASPN';
	 end if;
     if :new.dt_r is not null and :new.dt_r<>' ' then
	  if :old.dt_r is null then
	   insert into podotc (ID, TAG,VAL) values (:old.id,'DT_R',:new.dt_r);
  	  else
       update podotc set VAL=:new.dt_r where id=:old.id and tag='DT_R';
	  end if;
	 else delete from podotc where id=:old.id and tag='DT_R';
	 end if;
	end;
   else
    if deleting then
	  begin
	  delete from podotc where id=:old.id;
	  end;
	end if;
   end if;
 end if;
end;



/
ALTER TRIGGER BARS.INS_PODOTK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/INS_PODOTK.sql =========*** End *** 
PROMPT ===================================================================================== 
