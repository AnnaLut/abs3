

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIUD_PODOTCH.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIUD_PODOTCH ***

  CREATE OR REPLACE TRIGGER BARS.TIUD_PODOTCH 
instead of insert or update or delete on podotch for each row begin
  if inserting then
    insert into podotc(id, tag ,val) values(:new.id, 'FIO', :new.fio);
    insert into podotc(id, tag ,val) values(:new.id, 'ATRT', :new.atrt);
    insert into podotc(id, tag ,val) values(:new.id, 'PASP', :new.pasp);
    insert into podotc(id, tag ,val) values(:new.id, 'PASPN', :new.paspn);
   
   if :new.dt_r  is not null then 
    insert into podotc(id, tag ,val) values(:new.id, 'DT_R', :new.dt_r);
   end if;
   
   if :new.adres is not null then  
    insert into podotc(id, tag ,val) values(:new.id, 'ADRES', :new.adres);
   end if;
    
   if :new.nls is not null then
    insert into podotc(id, tag ,val) values(:new.id, 'NLS', :new.nls);
   end if; 
   
  elsif updating then
   begin
     update podotc set val=:new.fio where id=:new.id and tag='FIO';
    if sql%rowcount=0 then
        insert into podotc(id, tag ,val) values(:new.id, 'FIO', :new.fio);
    end if;   
    update podotc set val=:new.atrt where id=:new.id and tag='ATRT';
    if sql%rowcount=0 then
        insert into podotc(id, tag ,val) values(:new.id, 'ATRT', :new.atrt);
    end if;   
     update podotc set val=:new.pasp where id=:new.id and tag='PASP';
    if sql%rowcount=0 then
        insert into podotc(id, tag ,val) values(:new.id, 'PASP', :new.pasp);
    end if;   
    update podotc set val=:new.paspn where id=:new.id and tag='PASPN';
    if sql%rowcount=0 then
        insert into podotc(id, tag ,val) values(:new.id, 'PASPN', :new.paspn);
    end if; 
      
    if :new.adres is not null then
     update podotc set val=:new.adres where id=:new.id and tag='ADRES';
      if sql%rowcount=0 then
         insert into podotc(id, tag ,val) values(:new.id, 'ADRES', :new.adres);
      end if;
     end if;
     
    if :new.nls is not null then   
      update podotc set val=:new.nls where id=:new.id and tag='NLS';
       if sql%rowcount=0 then
         insert into podotc(id, tag ,val) values(:new.id, 'NLS', :new.nls);
       end if;   
    end if;
    
     if :new.dt_r is not null then
       update podotc set val=:new.dt_r where id=:new.id and tag='DT_R';
        if sql%rowcount=0 then
          insert into podotc(id, tag ,val) values(:new.id, 'DT_R', :new.dt_r);
        end if;  
     end if;   
   end; 
   
  elsif deleting then
    delete from podotc where id=:old.id and tag in ('FIO','ATRT','ADRES','NLS','PASP','PASPN','DT_R');
  end if;
end; 
/
ALTER TRIGGER BARS.TIUD_PODOTCH ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIUD_PODOTCH.sql =========*** End **
PROMPT ===================================================================================== 
