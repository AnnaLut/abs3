

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_RATES.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_RATES ***

  CREATE OR REPLACE PROCEDURE BARS.P_RATES 
( p_sdat   in     varchar2  -- dd/mm/yyyy
, p_kv     in     cur_rates$base.kv%type
, p_bsum   in     cur_rates$base.bsum%type
, p_rate_o in     cur_rates$base.rate_o%type
) IS
  l_dat           date;
  -- 28.04.2016 - BAA: переніс в процедуру переоцінку з тригерів (COBUSUPABS-3988)
BEGIN

  l_dat := to_date(p_sdat,'DD/MM/YYYY');

  for k in ( select TOBO as branch
               from TOBO
              where TOBO like '/'||f_ourmfo_g||'/%' )
  loop

    begin

      update BARS.CUR_RATES$BASE
         set RATE_O   = p_rate_o
           , BSUM     = p_bsum
           , OFFICIAL = 'Y'
       where VDATE    = l_dat
         and KV       = p_kv
         and BRANCH   = k.BRANCH;

      if sql%rowcount=0
      then
        insert
          into BARS.CUR_RATES$BASE
          ( KV, VDATE, BSUM, RATE_O, BRANCH, OFFICIAL )
        values
          ( p_kv, l_dat, p_bsum, p_rate_o, k.BRANCH, 'Y' );
      end if;

      -- для размеченных "наперёд" коммерческих курсов меняем оффициальный курс
      update BARS.CUR_RATES$BASE
         set RATE_O = p_rate_o
           , BSUM   = p_bsum
           , RATE_B = rate_b*p_bsum/bsum
           , RATE_S = rate_s*p_bsum/bsum
       where BRANCH   = k.BRANCH
         and VDATE    > l_dat
         and KV       = p_kv
         and OFFICIAL = 'N';

    end;

  end loop;

  -- переоцінка
  gl.p_pvp( p_kv, l_dat );

END P_RATES;
/
show err;

PROMPT *** Create  grants  P_RATES ***
grant EXECUTE                                                                on P_RATES         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_RATES.sql =========*** End *** =
PROMPT ===================================================================================== 
