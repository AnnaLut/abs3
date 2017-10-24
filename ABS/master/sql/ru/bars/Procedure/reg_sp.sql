

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/REG_SP.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure REG_SP ***

  CREATE OR REPLACE PROCEDURE BARS.REG_SP (acc_ NUMBER, nbs_ VARCHAR2,
               s230_ VARCHAR2 DEFAULT NULL,
               ktk_  VARCHAR2 DEFAULT NULL,
               kvk_  VARCHAR2 DEFAULT NULL,
               kekd_ VARCHAR2 DEFAULT NULL)
IS

BEGIN

IF s230_ IS NOT NULL OR
   ktk_  IS NOT NULL OR
   kvk_  IS NOT NULL OR
   kekd_ IS NOT NULL THEN

   UPDATE specparam SET s230=s230_,ktk=ktk_,kvk=kvk_,kekd=kekd_
    WHERE acc=acc_;

   IF SQL%ROWCOUNT = 0 THEN
      INSERT INTO specparam (acc,s230,ktk,kvk,kekd)
                VALUES (acc_,s230_,ktk_,kvk_,kekd_);
   END IF;

END IF;

FOR c IN (SELECT idg,ids,sps,ktk,s230 FROM nbs_spec WHERE nbs=nbs_)
  LOOP
    IF c.s230 ='0' OR
       c.s230=s230_ AND c.ktk ='0' OR
       c.s230=s230_ AND c.ktk=ktk_ THEN

       UPDATE specparam SET idg=c.idg,ids=c.ids,sps=c.sps
        WHERE acc=acc_;

       IF SQL%ROWCOUNT = 0 THEN
          INSERT INTO specparam (acc,idg,ids,sps)
                  VALUES (acc_,c.idg,c.ids,c.sps);
       END IF;
       EXIT;
    END IF;

END LOOP;
END;
/
show err;

PROMPT *** Create  grants  REG_SP ***
grant EXECUTE                                                                on REG_SP          to ABS_ADMIN;
grant EXECUTE                                                                on REG_SP          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on REG_SP          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/REG_SP.sql =========*** End *** ==
PROMPT ===================================================================================== 
