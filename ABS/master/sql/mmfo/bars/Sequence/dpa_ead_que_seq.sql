PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/bars/sequence/dpa_ead_que_seq.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence dpa_ead_que_seq ***

begin 
  execute immediate '
    create sequence dpa_ead_que_seq
    minvalue 1
    maxvalue 9999999999999999999999999999
    start with 1
    increment by 1
    cache 20
  ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
  end; 
/

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/bars/sequence/dpa_ead_que_seq.sql =========*** End 
PROMPT ===================================================================================== 
