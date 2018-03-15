PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_NBU_601_request_id.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_NBU_601_request_id ***

begin 
  execute immediate '
  CREATE SEQUENCE  BARS.S_NBU_601_request_id
minvalue 1
maxvalue 9999999999999999999999999999
start with 96
increment by 1
cache 20';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
  end; 
  /


PROMPT *** Create  grants  S_NBU_601_request_id ***
grant SELECT                                                                 on S_NBU_601_request_id to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_NBU_601_request_id.sql =========*** End 
PROMPT ===================================================================================== 
