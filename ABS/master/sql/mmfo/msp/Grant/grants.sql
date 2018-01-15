begin
  execute immediate 'grant select, update on msp_file_records to bars';
  execute immediate 'grant select on MSP_ACC_TRANS_2909 to bars';
end;
/