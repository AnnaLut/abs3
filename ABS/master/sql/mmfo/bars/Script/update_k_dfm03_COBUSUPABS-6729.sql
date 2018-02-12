begin
update bars.k_dfm03
set d_close = date'2017-11-01'
where code = '463';
commit;
end;
/