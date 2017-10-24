

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_DPT_LIMIT_QUERY.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_DPT_LIMIT_QUERY ***

  CREATE OR REPLACE TRIGGER BARS.TI_DPT_LIMIT_QUERY 
  BEFORE INSERT ON "BARS"."DPT_LIMIT_QUERY"
  REFERENCING FOR EACH ROW
  declare
  l_sqnc   number;
begin
  select s_dpt_limit_query.nextval into l_sqnc from dual;
  :new.limit_id := l_sqnc;
end;



/
ALTER TRIGGER BARS.TI_DPT_LIMIT_QUERY ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_DPT_LIMIT_QUERY.sql =========*** 
PROMPT ===================================================================================== 
