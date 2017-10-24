

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/GETMASK.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure GETMASK ***

  CREATE OR REPLACE PROCEDURE BARS.GETMASK (id_    BINARY_INTEGER
                   ) IS
sec_  RAW(64);
j     INTEGER;

smask_ RAW(64);
dmask_ RAW(64);
kmask_ RAW(64);

BEGIN

FOR i IN 0..2 LOOP
   j:=POWER(2,i);
   sec_:='0000';
   FOR c IN (SELECT ida FROM groups_staff_acc WHERE ida < 512 AND idg IN (
             SELECT g.idg FROM groups_staff g
              WHERE NVL(g.approve,0)=1
                AND DATE_IS_VALID( g.adate1,g.adate2,g.rdate1,g.rdate2 )=1
                AND BITAND(g.secg,j)=j
                AND g.idu IN (
             SELECT s2.id_whom from staff_substitute s2
              WHERE s2.id_who = id_
                AND DATE_IS_VALID(s2.date_start,s2.date_finish,NULL,NULL)=1
              UNION
             SELECT id_ from dual))) LOOP

      IF c.ida<16 THEN
         sec_:=UTL_RAW.BIT_OR(NVL(sec_,'0000'),
               UTL_RAW.SUBSTR(
               UTL_RAW.CAST_FROM_BINARY_INTEGER(
               POWER(2,16-MOD(c.ida,16)-1)),3,2));
      ELSE
         sec_:=UTL_RAW.BIT_OR(NVL(sec_,'0000'),
               UTL_RAW.OVERLAY(
               UTL_RAW.CAST_FROM_BINARY_INTEGER(
               POWER(2,16-MOD(c.ida,16)-1)),'0000',2*TRUNC(c.ida/16)-1));
      END IF;

   END LOOP;

   sec_:=UTL_RAW.OVERLAY(sec_, '0000',1,64);

   IF    i=0 THEN
     kmask_ := sec_;
   ELSIF i=1 THEN
     dmask_ := sec_;
   ELSIF i=2 THEN
     smask_ := sec_;
   END IF;

END LOOP;

 dbms_output.put_line(smask_);

END;

 
/
show err;

PROMPT *** Create  grants  GETMASK ***
grant EXECUTE                                                                on GETMASK         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/GETMASK.sql =========*** End *** =
PROMPT ===================================================================================== 
