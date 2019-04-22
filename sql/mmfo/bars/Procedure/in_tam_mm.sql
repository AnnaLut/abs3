PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/in_tam_mm.sql =========*** Run
PROMPT ===================================================================================== 

PROMPT *** Create  procedure in_tam_mm ***

CREATE OR REPLACE PROCEDURE BARS.in_tam_mm (
ret_       OUT  NUMBER,
fn_mm_      VARCHAR2,
fn_mc_      VARCHAR2,
dat_        DATE,
mdat_     	DATE,
n_mm_    	NUMBER,
n_mc_	    NUMBER,
num_cst_	VARCHAR2,
num_year_	VARCHAR2,
num_num_	VARCHAR2,
mfo_uah_old_     VARCHAR2,
mfo_uah_new_     VARCHAR2
) IS

ern               CONSTANT POSITIVE := 441;
erm               VARCHAR2(256);   -- максимальная длина 2048
err               EXCEPTION;
-- ----------------------------------

BEGIN

   ret_ := 99;

   UPDATE zag_mc SET n=n+1
               WHERE fn=fn_mm_ AND TRUNC(dat)=TRUNC(dat_);

   IF SQL%ROWCOUNT = 0 THEN
      INSERT INTO zag_mc( fn, dat, n, otm)
                  VALUES( fn_mm_,dat_,1, 0);
   END IF;

   UPDATE customs_decl SET outdated=1, fn_mm=fn_mm_, mdat_new=mdat_,n_mm=n_mm_,uah_mfo_new=mfo_uah_new_
   WHERE FN=fn_mc_
		AND N=n_mc_ 
		AND UAH_MFO=mfo_uah_old_
		AND CNUM_CST=num_cst_ 
	    AND CNUM_YEAR=num_year_
		AND CNUM_NUM=num_num_;
  ret_ := 0;

RETURN;

EXCEPTION
  WHEN err THEN
     raise_application_error(-(20000+ern),'\-'||erm,TRUE);
  WHEN DUP_VAL_ON_INDEX THEN
  	 ret_ := 701;		 -- Previously received file
  WHEN OTHERS THEN
     raise_application_error(-(20000+ern),SQLERRM,TRUE);
END in_tam_mm;
/
show err;

PROMPT *** Create  grants  in_tam_mm ***
grant EXECUTE                                                                on in_tam_mm to ABS_ADMIN;
grant EXECUTE                                                                on in_tam_mm to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on in_tam_mm to WR_ALL_RIGHTS;
