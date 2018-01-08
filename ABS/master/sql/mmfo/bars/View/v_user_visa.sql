

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USER_VISA.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USER_VISA ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USER_VISA ("GRPID", "GRPID_HEX", "GRPNAME") AS 
  SELECT distinct a.IDCHK as GRPID, a.IDCHK_HEX as GRPID_HEX, a.NAME as GRPNAME
	FROM CHKLIST a, STAFF_CHK b
	WHERE a.IDCHK = b.CHKID
		and b.ID in
			(SELECT ID_WHOM
			FROM STAFF_SUBSTITUTE
			WHERE ID_WHO = getcurrentuserid and date_is_valid(DATE_START, DATE_FINISH, NULL, NULL) = 1
				UNION
			SELECT getcurrentuserid
			FROM dual)
		and decode( (SELECT NVL(min(to_number(VAL)),0) FROM PARAMS WHERE PAR = 'LOSECURE'), 0, NVL(b.APPROVE, 0), 1) = 1
		and decode( (SELECT NVL(min(to_number(VAL)),0) FROM PARAMS WHERE PAR = 'LOSECURE'), 0, date_is_valid(b.ADATE1, b.ADATE2, b.RDATE1, b.RDATE2), 1) = 1
      		and decode( (SELECT NVL(min(to_number(VAL)),0) FROM PARAMS WHERE PAR = 'SELFVISA'), 0, -2, a.IDCHK) <> (SELECT NVL(min(to_number(VAL)),0) FROM PARAMS WHERE PAR = 'SELFVISA');

PROMPT *** Create  grants  V_USER_VISA ***
grant SELECT                                                                 on V_USER_VISA     to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_USER_VISA     to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_USER_VISA     to WR_CHCKINNR_ALL;
grant SELECT                                                                 on V_USER_VISA     to WR_CHCKINNR_CASH;
grant SELECT                                                                 on V_USER_VISA     to WR_CHCKINNR_SELF;
grant SELECT                                                                 on V_USER_VISA     to WR_CHCKINNR_SUBTOBO;
grant SELECT                                                                 on V_USER_VISA     to WR_CHCKINNR_TOBO;
grant SELECT                                                                 on V_USER_VISA     to WR_VERIFDOC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USER_VISA.sql =========*** End *** ==
PROMPT ===================================================================================== 
