
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/function/check_uploaded_t0.sql =========*
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARSUPL.CHECK_UPLOADED_T0 
( p_provision_dt  date -- дата резерву
) return number
is
  --
  -- ver 1.3   02/02/2016
  --
  l_result     number;
  l_curnt_dt   date;
  l_first_dt   date;
begin

  l_curnt_dt := trunc(sysdate);
  l_first_dt := trunc(nvl(p_provision_dt,l_curnt_dt),'MM');

  if ( l_first_dt > l_curnt_dt )
  then -- для прогнозного розрахунку майбутнього резерву
    l_result := 0;
  else --
    select nvl2(max(ID),1,0)
      into l_result
      from ( select ID
               from BARSUPL.UPL_STATS
              where GROUP_ID = 7
                and UPL_BANKDATE between l_first_dt and l_curnt_dt
                and REC_TYPE = 'GROUP'
                and UPL_ERRORS Is Null
              union
             select ID
               from BARSUPL.UPL_STATS_ARCHIVE
              where GROUP_ID = 7
                and UPL_BANKDATE between l_first_dt and l_curnt_dt
                and REC_TYPE = 'GROUP'
                and UPL_ERRORS Is Null );
  end if;

  if ( l_result = 1 )
  then -- перевірка на активність джоба розрахунку резерву запущеного під час вивантаження Т0
    begin
      select 0
        into l_result
        from SYS.V_$SESSION
       where TYPE   = 'USER'
         and STATUS = 'ACTIVE'
         and ACTION = 'CALCULATE_PROVISION'
         and SID    = SYS_CONTEXT('USERENV','SID');
    exception
      when NO_DATA_FOUND then
        null;
        -- l_result := 1;
    end;
  end if;

  RETURN l_result;

end CHECK_UPLOADED_T0;
/
 show err;
 
PROMPT *** Create  grants  CHECK_UPLOADED_T0 ***
grant EXECUTE                                                                on CHECK_UPLOADED_T0 to BARS;
grant EXECUTE                                                                on CHECK_UPLOADED_T0 to UPLD;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARSUPL/function/check_uploaded_t0.sql =========*
 PROMPT ===================================================================================== 
 