create or replace function sdo_autopay_check_corp2 (p_ext_doc doc_import%rowtype) return smallint is
begin
 return 0;
end;
/

grant execute on  bars.sdo_autopay_check_corp2 to barsaq;
