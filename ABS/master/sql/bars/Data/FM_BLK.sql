begin
    update params$global
    set val = '98'
    where par = 'FM_BLK';
commit;
end;
/