

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_VISALIST.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_VISALIST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_VISALIST ("REF", "COUNTER", "SQNC", "MARK", "MARKID", "CHECKGROUP", "USERNAME", "DAT", "INCHARGE") AS 
  select o.ref as ref, -- кто ввел
  0 as Counter, 0 as Sqnc,
  'Ввел документ' as Mark, 0 as MarkID, NULL as CheckGroup, s.fio as UserName,
  pdat as Dat,
  0 as Incharge
from oper o, staff$base s
where o.userid=s.id
union all
select  o.ref as ref, -- наложенные визы
        ct.priority as Counter, ov.sqnc as Sqnc,
	    decode(status,1,'Визировал',2,'Оплатил',3,'Сторнировал',NULL) as Mark,
	    decode(status,1,1,2,2,3,3,NULL) as MarkID,
	   	ov.groupname as CheckGroup,
		ov.username as UserName,
		ov.dat as Dat,
		ov.F_IN_CHARGE as Incharge
from oper o, oper_visa ov, chklist_tts ct
where o.ref=ov.ref
and ov.passive is null
and ov.status in (1,2,3)
and ov.GROUPID=ct.IDCHK
and o.tt=ct.TT
union all
select  o.ref as ref, -- визы на упр. к/с, при сторнировании
        NULL as Counter, ov.sqnc as Sqnc,
	    decode(status,1,'Визировал',2,'Визировал',3,'Сторнировал',NULL) as Mark,
	    decode(status,1,1,2,2,3,3,NULL) as MarkID,
	   	ov.groupname as CheckGroup,
		ov.username as UserName,
        ov.dat as Dat,
		ov.F_IN_CHARGE as Incharge
from oper o, oper_visa ov
where o.ref=ov.ref
and ov.passive is null
and ov.status in (1,2,3)
and (ov.groupid is null or ov.groupid not in (select idchk from chklist_tts where tt=o.tt))
union all
select  o.ref as ref,  -- ожидающие визы
        ct.priority as Counter, 999999999999999 as Sqnc,
	    'Ожидает' as Mark,
	    4 as MarkID,
	   	c.NAME as CheckGroup,
		NULL as UserName,
		NULL as Dat,
		c.F_IN_CHARGE as Incharge
from oper o, chklist_tts ct, chklist c
where o.tt=ct.TT
and ct.IDCHK=c.IDCHK
and ct.IDCHK not in (select groupid from oper_visa where ref=o.ref and passive is null and groupid is not null)
and o.sos>=0 and o.sos<5
and chk.doc_is_valid(o.ref, ct.SQLVAL)=1;

PROMPT *** Create  grants  V_VISALIST ***
grant SELECT                                                                 on V_VISALIST      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_VISALIST      to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_VISALIST      to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_VISALIST      to WR_CHCKINNR_ALL;
grant SELECT                                                                 on V_VISALIST      to WR_CHCKINNR_CASH;
grant SELECT                                                                 on V_VISALIST      to WR_CHCKINNR_SELF;
grant SELECT                                                                 on V_VISALIST      to WR_CHCKINNR_SUBTOBO;
grant SELECT                                                                 on V_VISALIST      to WR_CHCKINNR_TOBO;
grant SELECT                                                                 on V_VISALIST      to WR_DOCLIST_TOBO;
grant SELECT                                                                 on V_VISALIST      to WR_DOCVIEW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_VISALIST.sql =========*** End *** ===
PROMPT ===================================================================================== 
