begin
update tickets_par 
set txt = q'[SELECT nls from opl where ref=:nRecID and dk=1 and substr(nls,1,2)='65' and rownum=1]'
where par= 'NLS_KOM6';
end;
/
commit;
/