

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CHG_RATN_BRID.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CHG_RATN_BRID ***

  CREATE OR REPLACE PROCEDURE BARS.CHG_RATN_BRID 
( p_kf    in     br_normal_edit.kf%type
) is
begin

  update ( select r.KF, r.ACC, r.ID, r.BDAT, r.BR
             from INT_RATN r
            where ( KF, BR ) = ( select b.KF, b.BR_ID
                                   from BRATES_KF b
                                  where b.KF    = p_kf
                                    and b.KF    = r.KF
                                    and b.BR_ID = r.BR )
         ) t
     set t.BR = ( select NEW_BR_ID
                    from BRATES_KF b
                   where b.KF = t.KF
                     and b.BR_ID = t.BR );
/*
  update INT_RATN r
     set r.BR = ( select NEW_BR_ID
                    from BRATES_KF b
                   where b.KF    = '300465'
                     and b.KF    = r.KF
                     and b.BR_ID = r.BR )
   where r.KF    = '300465'
     and r.BR Is Not Null;
*/

end CHG_RATN_BRID;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CHG_RATN_BRID.sql =========*** End
PROMPT ===================================================================================== 
