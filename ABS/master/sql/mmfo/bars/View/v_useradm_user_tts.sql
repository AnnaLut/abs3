

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USERADM_USER_TTS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USERADM_USER_TTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USERADM_USER_TTS ("TT", "NAME", "APPROVED", "REVOKED", "DISABLED", "SUBSTED", "ADATE1", "ADATE2", "RDATE1", "RDATE2") AS 
  select a.tt, a.name, c.approved, c.revoked, c.disabled, c.substed,
       c.adate1, c.adate2, c.rdate1, c.rdate2
  from (select b.tt,
               nvl(b.approve, 0)                                        approved,
               nvl(b.revoked, 0)                                        revoked,
               1-date_is_valid(b.adate1, b.adate2, b.rdate1, b.rdate2)  disabled,
               0                                                        substed,
               b.adate1, b.adate2, b.rdate1, b.rdate2
          from staff_tts b
         where b.id = sys_context('bars_useradm', 'user_id')
         union all
         select b.tt,
                1 approved, 0 revoked, 0 disabled, 1 substed,
                null adate1, null adate2, null rdate1, null rdate2
           from staff_tts b, staff_substitute s
          where b.id=s.id_whom
            and b.tt not in (select tt from staff_tts where id=s.id_who and approve = 1)
            and s.id_who = sys_context('bars_useradm', 'user_id')
            and b.approve = 1
            and date_is_valid(b.adate1, b.adate2, b.rdate1, b.rdate2)  = 1
            and date_is_valid(s.date_start, s.date_finish, null, null) = 1
         group by b.tt
	) c, tts a
where a.tt=c.tt
 ;

PROMPT *** Create  grants  V_USERADM_USER_TTS ***
grant SELECT                                                                 on V_USERADM_USER_TTS to ABS_ADMIN;
grant SELECT                                                                 on V_USERADM_USER_TTS to BARSREADER_ROLE;
grant SELECT                                                                 on V_USERADM_USER_TTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_USERADM_USER_TTS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_USERADM_USER_TTS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USERADM_USER_TTS.sql =========*** End
PROMPT ===================================================================================== 
