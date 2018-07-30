begin
  execute immediate 'grant execute on bars_error to msp';
  execute immediate 'grant execute on bars_audit to msp';
  execute immediate 'grant execute on bars_login to msp';
  execute immediate 'grant execute on lob_utl to msp';
  execute immediate 'grant execute on as_zip to msp';
  execute immediate 'grant execute on import_flat_file to msp';
  execute immediate 'grant select on tmp_imp_file to msp';
  execute immediate 'grant select on staff$base to msp';
  execute immediate 'grant execute on gl to msp';
  execute immediate 'grant execute on bc to msp';
end;
/
