begin
  execute immediate 'grant select on pfu_pensioner to msp with grant option';
  execute immediate 'grant select on pfu_pensacc to msp with grant option';
  execute immediate 'grant select on pfu_pens_block_type to msp';
  execute immediate 'grant select on transport_unit to msp';
  execute immediate 'grant select on transport_unit_type to msp';

end;
/ 
