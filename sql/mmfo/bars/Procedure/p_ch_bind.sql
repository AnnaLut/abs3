

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CH_BIND.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CH_BIND ***

  CREATE OR REPLACE PROCEDURE BARS.P_CH_BIND (p_dat1 varchar2, p_dat2 varchar2, p_mask varchar2 default '0', p_deys int default 0, p_fl int default 0) is
-- ***  v. 21/07-09   ***
-- попередній контроль введених значень пар-в діапазону дат
-- попередній контроль введеного значення пар-ра маска рах-ку
-- p_fl - =0 обмеження по датах включене (флаг для можливого розширення логіки)

result int;
dat1 date; dat2 date;
dat_b date;

 ern CONSTANT POSITIVE   := 208; err EXCEPTION; erm VARCHAR2(80);

begin
dat1:=to_date(p_dat1);
dat2:=to_date(p_dat2);

dat_b:= to_date('20090601','YYYYMMDD');  -- MIN дата для формування

logger.trace('P_ch_bind '||'dat1='||dat1||' dat2='||dat2);

if dat2 > dat1 then
   if dat1<dat_b and p_fl=0 then
   erm:='0.Вказана НЕ дозволена початкова дата';
   raise err;
   end if;
   if dat2 - dat1 > p_deys then
   erm:='1.Вказано НЕ дозволений діапазон дат';
   raise err; end if;
   -- legal value
elsif dat2 < dat1 then
   erm:='2.Вказано НЕ дозволений діапазон дат';
   raise err;
else NULL;
   if dat1<dat_b and p_fl=0 then
   erm:='3.Вказано НЕ дозволений діапазон дат';
   raise err;
   end if;
   -- legal value
end if;

if p_mask<>'0' then

   if trim(p_mask)='%' then   --  and p_fl=0
      erm:='Вказана НЕ дозволена маска рах-ку %';
      raise err;
   end if;
   if substr(p_mask,1,1) ='2' then
      if length(p_mask) < 5 then        -- ||'%'
         erm:='Вказана НЕ дозволена маска рах-ку(<4 знаків)';
         raise err;
      end if;
   end if;
else NULL;
-- norma  p_mask NO used
end if;

    EXCEPTION when err then
    begin
--    logger.trace('P_ch_bind '||erm);
    raise_application_error(-(20000+ern),'\9333 - '||erm,TRUE);
  -- bars_error.raise_nerror('REP', erm, par1);
    end;
end;
 
/
show err;

PROMPT *** Create  grants  P_CH_BIND ***
grant EXECUTE                                                                on P_CH_BIND       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_CH_BIND       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CH_BIND.sql =========*** End ***
PROMPT ===================================================================================== 
