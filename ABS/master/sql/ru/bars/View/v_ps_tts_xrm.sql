prompt create view bars.v_ps_tts_xrm
create or replace view bars.v_ps_tts_xrm
as
select  p.id,
        p.tt,
		p.nbs,
		p.dk,
		p.ob22
from ps_tts p
join v_tts_xrm t on p.tt = t.tt;

grant select, delete, update, insert on bars.v_ps_tts_xrm to bars_access_defrole;
