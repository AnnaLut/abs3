
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/issubstitute.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.ISSUBSTITUTE (
    HostUserId NUMBER,
    SbstUserId NUMBER) RETURN NUMBER
IS
    ItsOk       NUMBER;

BEGIN
    IF HostUserId = SbstUserId THEN
        RETURN 1;
    END IF;

    BEGIN
        SELECT id_whom INTO ItsOk FROM staff_substitute
            WHERE id_who = HostUserId AND id_whom = SbstUserId;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        ItsOk := 0;
    END;

    IF ItsOk > 0 THEN
        RETURN 1;
    ELSE
        RETURN 0;
    END IF;

END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/issubstitute.sql =========*** End *
 PROMPT ===================================================================================== 
 