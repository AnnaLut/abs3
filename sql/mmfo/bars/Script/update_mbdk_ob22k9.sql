begin
update mbdk_OB22 set k9=1 where vidd in(1211,1510,1512,1513,1521,1522,1523,1524);
commit;
end;
/