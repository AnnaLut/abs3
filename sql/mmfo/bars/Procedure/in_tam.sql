CREATE OR REPLACE PROCEDURE BARS.in_tam_mm (
ret_       OUT  NUMBER,
fn_mm_      VARCHAR2,
fn_mc_      VARCHAR2,
dat_        DATE,
mdat_         DATE,
n_mm_        NUMBER,
n_mc_        NUMBER,
num_cst_    VARCHAR2,
num_year_    VARCHAR2,
num_num_    VARCHAR2,
mfo_uah_old_     VARCHAR2,
mfo_uah_new_     VARCHAR2
) IS

ern               CONSTANT POSITIVE := 441;
erm               VARCHAR2(256);   -- максимальная длина 2048
err               EXCEPTION;
-- ----------------------------------

BEGIN
   
/*   BARS_AUDIT.INFO('in_tam_mm in => fn_mm_ = '||fn_mm_        
    ||' fn_mc_ = '||fn_mc_      
    ||' dat_ = '||dat_        
    ||' mdat_ = '||mdat_       
    ||' n_mm_ = '||n_mm_       
    ||' n_mc_ = '||n_mc_       
    ||' num_cst_ = '||num_cst_    
    ||' num_year_ = '||num_year_   
    ||' num_num_ = '||num_num_    
    ||' mfo_uah_old_ = '||mfo_uah_old_
    ||' mfo_uah_new_ = '||mfo_uah_new_);*/

  ret_ := 99;

   UPDATE zag_mc SET n=n+1
               WHERE fn=fn_mm_ AND TRUNC(dat)=TRUNC(dat_);

   IF SQL%ROWCOUNT = 0 THEN
      INSERT INTO zag_mc( fn, dat, n, otm)
                  VALUES( fn_mm_,dat_,1, 0);
   END IF;

   UPDATE customs_decl SET outdated=1, fn_mm=fn_mm_, mdat_new=mdat_,n_mm=n_mm_,uah_mfo_new=mfo_uah_new_, ccy_mfo_new=mfo_uah_new_
   WHERE    UAH_MFO=mfo_uah_old_
        AND CNUM_CST=num_cst_
        AND CNUM_YEAR=num_year_
        AND CNUM_NUM=num_num_;
  ret_ := 0;

RETURN;

EXCEPTION
  WHEN err THEN
     raise_application_error(-(20000+ern),'\-'||erm,TRUE);
  WHEN DUP_VAL_ON_INDEX THEN
       ret_ := 701;         -- Previously received file
  WHEN OTHERS THEN
     raise_application_error(-(20000+ern),SQLERRM,TRUE);
END in_tam_mm;
/


grant execute on in_tam_mm to toss;