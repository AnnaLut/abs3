PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Sequence/PFU_NO_TURNOVER_LIST_SEQ.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  sequence PFU_NO_TURNOVER_LIST_SEQ ***


begin
    execute immediate 'create sequence PFU.PFU_NO_TURNOVER_LIST_SEQ minvalue 1 maxvalue 9999999999999999999999999999 start with 1 increment by 1 cache 20';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Sequence/PFU_NO_TURNOVER_LIST_SEQ.sql =========**
PROMPT ===================================================================================== 
