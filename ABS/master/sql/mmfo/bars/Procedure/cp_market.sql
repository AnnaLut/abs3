

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CP_MARKET.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CP_MARKET ***

  CREATE OR REPLACE PROCEDURE BARS.CP_MARKET 
          (p_dat date default bankdate, p_days int default 0)
is
-- *** v.2.1 03/11/2010 ***
--p_dat  date := bankdate_g;
--p_days int :=5;
p_mode int:=0;
dat_end date := p_dat;
dat_beg date := p_dat - p_days ;

begin
LOGGER.info('CP_MARKET start dat_b='||dat_beg||' dat_e='||dat_end);
--dbms_output.put_line('CP_MARKET start');
--dbms_output.put_line('CP_MARKET dat_b='||dat_beg||' dat_e='||dat_end);
for l in (select  o.ref, max(s.INITIATOR) in_r , max(s.MARKET) m_t
          from opldok o, SPECPARAM_CP_OB s
          where o.acc= s.acc
                and fdat >= dat_beg and fdat <= dat_end + 1
                and (s.initiator is not NULL or s.market is not NULL)
   --   and o.ref>=26910000 and o.ref <26916400
   --   and o.ref in (select ref from cp_deal)     -- !  otl
          group by o.ref)
loop
--LOGGER.trace('CP_MARKET: ref => %s, in_r => %s, m_t => %s',
--             to_char(l.ref), to_char(l.in_r), to_char(l.m_t));
--LOGGER.info('CP_MARKET: ref => %s, in_r => %s, m_t => %s', l.ref, l.in_r, l.m_t);
LOGGER.trace('CP_MARKET: ref ='||l.ref||' in_r ='||l.in_r||' m_t ='||l.m_t);

   begin
   if l.in_r is not NULL then
--   dbms_output.put_line('ref='||l.ref||' CP_IN='||l.in_r);
   logger.trace('ref='||l.ref||' CP_IN='||l.in_r);
   insert into operw (ref,tag,value) values (l.ref,'CP_IN',l.in_r);
   end if;
   exception when DUP_VAL_ON_INDEX then NULL;
   if p_mode=1 then
   update operw set  value=l.in_r where tag='CP_IN' and ref=l.ref;
   else
   update operw set value=l.in_r where tag='CP_IN' and ref=l.ref and value is NULL;
   end if;
   end;

   begin
   if l.m_t is not NULL then
--   dbms_output.put_line('ref='||l.ref||' CP_MR='||l.m_t);
   logger.trace('ref='||l.ref||' CP_MR='||l.m_t);
   insert into operw (ref,tag,value) values (l.ref,'CP_MR',l.m_t);
   end if;
   exception when DUP_VAL_ON_INDEX then NULL;
   if p_mode=1 then
   update operw set  value=l.m_t where tag='CP_MR' and ref=l.ref;
   else
   update operw set value=l.m_t where tag='CP_MR' and ref=l.ref and value is NULL;
   end if;
   end;

end loop;
-- commit;
-- ROLLBACK;
LOGGER.info('CP_MARKET finish');
end;
/
show err;

PROMPT *** Create  grants  CP_MARKET ***
grant EXECUTE                                                                on CP_MARKET       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CP_MARKET       to CP_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CP_MARKET.sql =========*** End ***
PROMPT ===================================================================================== 
