begin
update obpc_trans_out
set w4_msgcode = 'PAYSAL'
where tt = 'CL5';
end;
/
commit;

