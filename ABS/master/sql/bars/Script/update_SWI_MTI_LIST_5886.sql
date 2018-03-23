begin
update SWI_MTI_LIST t
set t.kod_nbu = case t.id 
                when      'gm' then  '99'
                when      'sa' then  '95'
                when      'sb' then  '96'
                when      'gk' then  '11'
                when      'st' then  '94'
                when      'ss' then  '97'
                when      'mc' then  '98'
                when      'mg' then  '04'
                when      'ri' then  '22'
                when      'up' then  '01'
                when      'bz' then  '15'
                when      'cs' then  '13'
                when      'le' then  '14'
                when      'il' then  '25'
                when      'hz' then  '26'
                when      'ak' then  '06'
                when      'wu' then  '03'
                end;  
end;     
/           
   