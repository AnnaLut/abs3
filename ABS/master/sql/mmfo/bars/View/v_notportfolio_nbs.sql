create or replace view v_notportfolio_nbs as
select p.nbs, p.xar, p.pap, p.name, p.class, p.chknbs, p.auto_stop, p.d_close, p.sb
from   ps p
join   notportfolio_nbs n on p.nbs = n.nbs
where  n.userid = sys_context('bars_global', 'user_id') or
       n.userid is null;
