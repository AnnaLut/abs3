

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_ACCI_KLPACC.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_ACCI_KLPACC ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_ACCI_KLPACC 
after insert or update of pers, high on acci
for each row
declare
  tow_  number;
begin
  if (inserting and (:new.pers=1 or :new.high=1))        or
     (updating and ((:new.pers=1 and nvl(:old.pers,0)=0) or
                    (:new.high=1 and nvl(:old.high,0)=0))) then
    begin

      select distinct tow
      into   tow_
      from   klp_plpo
      where  otw=(select isp
                  from   accounts
                  where  acc=:new.acc)    and
             dti>sysdate                  and
             (dto>sysdate or dto is null) and
             mrk=1;

      begin
        insert
        into   klpacc (neom,
                       acc)
               values (tow_,
                       :new.acc);
      exception when dup_val_on_index then
        update klpacc
        set    neom=tow_
        where  acc=:new.acc;
      end;

      update klp
      set    eom=tow_
      where  fl<3 and
             (nvl(mfoa,f_ourmfo),nls,kv)=(select f_ourmfo,nls,kv
                                          from   accounts
                                          where  acc=:new.acc);
    exception when no_data_found then
      null;
    end;
  end if;

--if (updating and :new.pers=0 and :new.high=0) then

--    delete
--    from   klpacc
--    where  acc=:new.acc;

--    update klp
--    set    eom=(select isp
--                from   accounts
--                where  acc=:new.acc)
--    where  fl<3 and
--           (nvl(mfoa,f_ourmfo),nls,kv)=(select f_ourmfo,nls,kv
--                                        from   accounts
--                                        where  acc=:new.acc);
--end if;

end taiu_acci_klpacc;



/
ALTER TRIGGER BARS.TAIU_ACCI_KLPACC ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_ACCI_KLPACC.sql =========*** En
PROMPT ===================================================================================== 
