begin
  bars_policy_adm.disable_policies('WCS_PARTNERS_ALL');  
end;
/

update wcs_partners_all w
set w.compensation = 1,
    w.percent = 10
where w.type_id = 'TECH_MARKET'
  and w.ptn_nls = '26002003045900'
  and w.ptn_okpo = '32346937';


update wcs_partners_all w
set w.compensation = 0,
    w.percent = null
where not (w.type_id = 'TECH_MARKET'
  and w.ptn_nls = '26002003045900'
  and w.ptn_okpo = '32346937');


begin
  bars_policy_adm.enable_policies('WCS_PARTNERS_ALL');  
end;
/


commit;

