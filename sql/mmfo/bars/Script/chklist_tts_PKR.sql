--COBUMMFO-9551
declare
l_cnt number;
begin
  select count(*) into l_cnt
    from bars.chklist_tts cts 
   where cts.tt='PKR' 
         and cts.idchk=7;
  if l_cnt = 1 then
    update bars.chklist_tts cts
       set sqlval='( f_is_resident(kv, nlsa, ref) = 0 
    or kv<>980 
    and 
    ( substr(NLSA,1,4) = ''2600'' 
        and (substr(NLSB,1,4) = ''2605'' or (substr(NLSB,1,4) = ''2600'' and nvl(f_get_ob22(KV, NLSB), ''14'')=''14'') or (substr(NLSB,1,4) = ''2650'' and nvl(f_get_ob22(KV, NLSB), ''12'')=''12'') ) 
        or ( substr(NLSA,1,4) in ( ''2620'', ''2909'', ''3739'', ''2924'', ''3720'') ) 
        and( substr(NLSB,1,4) = ''2625'' or (substr(NLSB,1,4) = ''2620'' and nvl(f_get_ob22(KV, NLSB), ''36'')=''36''))
        or ( substr(NLSA,1,4) in (''2520'',''2541'',''2542'') ) 
        and ( substr(NLSB,1,4)=''2520'' 
                and nvl(f_get_ob22(KV, NLSB), ''02'')=''02'' 
                or ( substr(NLSB,1,4) in (''2541'',''2542'') ) 
                and nvl(f_get_ob22(KV, NLSB), ''01'')=''01'' 
            ) 
    ) 
) and (F_CHECK_NLS_OKPO(KV,NLSA,NLSB)=1)'
       where cts.tt='PKR' 
        and cts.idchk=7;
  end if;
end;
/
commit;
/
