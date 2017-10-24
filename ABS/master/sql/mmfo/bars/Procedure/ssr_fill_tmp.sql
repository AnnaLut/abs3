

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SSR_FILL_TMP.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SSR_FILL_TMP ***

  CREATE OR REPLACE PROCEDURE BARS.SSR_FILL_TMP (sdat_ varchar2,sdat2_ varchar2) IS
tmpVar NUMBER;
fdat_ date;
count_ integer;
nls_ varchar2(14);
mfo_ varchar2(14);
s_ integer;
s1_ integer;
s2_ integer;
count1_ integer;
count2_ integer;

/******************************************************************************
   NAME:       ssr_fill_tmp
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        16.01.2008          1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     ssr_fill_tmp
      Sysdate:         16.01.2008
      Date and Time:   16.01.2008, 11:39:48, and 16.01.2008 11:39:48
      Username:         (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/

CURSOR A1 IS
   select a.pdat,a.nls,a.mfo,sum(a.s),sum(a.sos5),sum(a.s3),sum(a.sos3),sum(a.s1),sum(a.sos1)
   from
   (select pdat,nlsb nls,mfob mfo,sum(s) s,count(ref) sos5,0 s3,0 sos3,0 s1,0 sos1
   from oper
   where pdat between to_date(sdat_) and to_date(sdat2_)+1 and sos=5 and dk=1 and (tt='SSR' or (tt='C06' and nlsa=2906401)) and kv=840 and dk=1
   group by pdat,nlsb,mfob
   union all
   select pdat,nlsa nls,mfoa mfo,0,0,sum(s) s3,count(ref) sos3,0,0
   from oper
   where pdat between to_date(sdat_) and to_date(sdat2_)+1 and sos>=5 and dk=1 and tt='R00' and nlsb=2906401 and kv=840
   group by pdat,nlsa,mfoa
   union all
   select pdat,nlsb nls,mfob mfo,0,0,0,0,sum(s) s1,count(ref) sos1
   from oper
   where pdat between to_date(sdat_) and to_date(sdat2_)+1 and sos>=5 and dk=0 and kv=840 and nlsa in
   (290680126,
    290610125,
    290640124,
    290670123,
    290600122,
    290630121,
    290660120,
    290600119,
    290630118,
    290660117,
    290690116,
    290620115,
    290650114,
    290680113,
    290610112,
    290640111,
    290610109,
    290640108,
    290670107,
    290600106,
    290630105,
    290660104,
    290690103,
    290620102,
    290650101
   )
   group by pdat,nlsb,mfob) a
   group by pdat,nls,mfo;

BEGIN
   tmpVar := 0;
   delete from ssr_tmp_count where fdat between to_date(sdat_) and to_date(sdat2_)+1;


   OPEN A1; LOOP FETCH A1 INTO fdat_,nls_,mfo_,s_,count_,s1_,count1_,s2_,count2_; EXIT WHEN A1%NOTFOUND;
   INSERT INTO ssr_tmp_count (fdat,nls,mfo,s,sos5,s3,sos3,s1,sos1) values (trunc(fdat_),nls_,mfo_,s_,count_,s1_,count1_,s2_,count2_);
   END LOOP;CLOSE A1;

   commit;


   EXCEPTION
     WHEN NO_DATA_FOUND THEN
       NULL;
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END ssr_fill_tmp;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SSR_FILL_TMP.sql =========*** End 
PROMPT ===================================================================================== 
