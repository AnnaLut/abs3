

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TR_V_CUST_CORPORATIONS.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TR_V_CUST_CORPORATIONS ***

  CREATE OR REPLACE TRIGGER BARS.TR_V_CUST_CORPORATIONS 
instead of insert or update or delete on V_CUSTOMER_CORPORATIONS--(rnk, EXTERNAL_ID, org_id)
declare
  l_flag number := 0;
begin
  begin
         select 1 into l_flag from V_ORG_CORPORATIONS t
         where (t.base_extid = :new.external_id and (t.EXTERNAL_ID = :new.org_id or :new.org_id is null))
         or (:new.EXTERNAL_ID is null and :new.org_id is null);--проверяем, соответствует ли подразделение родительской корпорации
  exception
    when NO_DATA_FOUND then l_flag := 0;
    when TOO_MANY_ROWS then l_flag := 1; --unsure
  end;
  if UPDATING then
    if l_flag = 1 then
      begin
        insert into customerw(rnk, tag, value, isp) values (:new.rnk, 'OBPCP', :new.external_id, 0);
      exception
        when dup_val_on_index then
         update customerw
         set value = :new.external_id
         where rnk = :new.rnk
         and   tag = 'OBPCP';
      end;
      begin
        insert into customerw(rnk, tag, value, isp) values (:new.rnk, 'OBCRP', :new.org_id, 0);
      exception
        when dup_val_on_index then
          update customerw
          set value = :new.org_id
          where rnk = :new.rnk
          and tag = 'OBCRP';
      end;
    end if;
  elsif DELETING then
    delete from customerw where rnk = :old.rnk and (tag = 'OBPCP' or tag = 'OBCRP');
  end if;
end;


/
ALTER TRIGGER BARS.TR_V_CUST_CORPORATIONS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TR_V_CUST_CORPORATIONS.sql =========
PROMPT ===================================================================================== 
