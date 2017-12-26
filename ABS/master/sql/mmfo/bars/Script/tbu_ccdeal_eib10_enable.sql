begin 
  execute_immediate ('ALTER TRIGGER TBU_CCDEAL_EIB10 ENABLE');
  EXCEPTION WHEN OTHERS THEN
    NULL;
end;
/
