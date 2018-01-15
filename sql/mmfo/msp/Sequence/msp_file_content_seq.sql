PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/sequence/msp_file_content_seq.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence msp_file_content_seq ***

begin 
  execute immediate '
    create sequence msp_file_content_seq
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
PROMPT *** End *** ========== Scripts /sql/msp/sequence/msp_file_content_seq.sql =========*** End 
PROMPT ===================================================================================== 
