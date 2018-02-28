begin
-------352457
update pfu.pfu_pensioner p 
set p.LAST_RU_IDUPD =316630022 
where kf = '352457';

update pfu.pfu_pensacc p 
set p.LAST_RU_IDUPD = 27822786022
where kf = '352457';

----353553
update pfu.pfu_pensacc p 
set p.LAST_RU_IDUPD = 27822765926 
where kf = '353553';
commit;

end;
/
