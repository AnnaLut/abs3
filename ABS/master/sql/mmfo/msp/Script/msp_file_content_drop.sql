PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/Script/msp_file_content_drop.sql =========*** Run
PROMPT ===================================================================================== 

begin
  execute immediate 'drop table msp.msp_file_content';
exception
  when others then
    if sqlcode in (-00942) then
      null;
    else
      raise;
    end if;
end;
/

begin
  execute immediate 'drop table msp.msp_file_content_type';
exception
  when others then
    if sqlcode in (-00942) then
      null;
    else
      raise;
    end if;
end;
/

begin
  execute immediate 'drop sequence msp_file_content_seq';
exception
  when others then
    if sqlcode in (-02289) then
      null;
    else
      raise;
    end if;
end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/Script/msp_file_content_drop.sql =========*** End
PROMPT =====================================================================================
