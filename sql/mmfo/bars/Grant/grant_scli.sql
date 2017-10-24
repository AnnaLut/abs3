begin
   execute immediate 'grant select, insert, update, delete on SCLI_ZKP to BARS_ACCESS_DEFROLE';
   execute immediate 'grant select, insert, update, delete on SCLI_R20 to BARS_ACCESS_DEFROLE';
end;
/
commit;