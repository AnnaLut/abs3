PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/script/create_payment_type.sql =========*** Run
PROMPT ===================================================================================== 

PROMPT *** insert payment_type ***
begin
  execute immediate
    'update msp_envelope_files_info 
       set payment_type = case when instr(filename,''.'')>37 then substr(filename, 30, 2) else substr(filename, 25, 2) end 
     where payment_type is null and filename is not null';
end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/script/create_payment_type.sql =========*** End
PROMPT ===================================================================================== 
