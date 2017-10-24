

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/IN_TAM.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure IN_TAM ***

  CREATE OR REPLACE PROCEDURE BARS.IN_TAM (
ret_       OUT  NUMBER,
fn_		VARCHAR2,
dat_  		DATE,
n_    		NUMBER,
len_  		NUMBER,
cdat_		DATE,
isnull_		NUMBER,
ndat_		DATE,
mdat_		DATE,
ctype_		VARCHAR2,
cnum_cst_	VARCHAR2,
cnum_year_	VARCHAR2,
cnum_num_	VARCHAR2,
mvm_feat_	VARCHAR2,
s_okpo_		VARCHAR2,
s_name_		VARCHAR2,
s_adres_	VARCHAR2,
s_type_		NUMBER,
s_taxid_	VARCHAR2,
r_okpo_		VARCHAR2,
r_name_		VARCHAR2,
r_adres_	VARCHAR2,
r_type_		NUMBER,
r_taxid_	VARCHAR2,
f_okpo_		VARCHAR2,
f_name_		VARCHAR2,
f_adres_	VARCHAR2,
f_type_		NUMBER,
f_taxid_	VARCHAR2,
f_country_	VARCHAR2,
uah_nls_	VARCHAR2,
uah_mfo_	VARCHAR2,
ccy_nls_	VARCHAR2,
ccy_mfo_	VARCHAR2,
kv_	    	NUMBER,
kurs_		NUMBER,
s_	  	NUMBER,
allow_dat_	DATE,
cmode_code_	NUMBER,
character_  NUMBER,
rezerv_		VARCHAR2,
doc_		VARCHAR2,
sdate_		DATE,
reserve2_	VARCHAR2,
sign_key_	VARCHAR2,
sign_		RAW ) IS

ern               CONSTANT POSITIVE := 441;
erm               VARCHAR2(256);   -- максимальная длина 2048
err               EXCEPTION;
-- ----------------------------------

BEGIN

   ret_ := 99;

   UPDATE zag_mc SET n=n+1
               WHERE fn=fn_ AND TRUNC(dat)=TRUNC(dat_);

   IF SQL%ROWCOUNT = 0 THEN
      INSERT INTO zag_mc( fn, dat, n, otm)
                  VALUES( fn_,dat_,1, 0);
   END IF;

   INSERT INTO customs_decl
 (fn,dat,n,len,cdat,isnull,ndat,mdat,ctype,cnum_cst,cnum_year,cnum_num,
  mvm_feat,s_okpo,s_name,s_adres,s_type,s_taxid,
           r_okpo,r_name,r_adres,r_type,r_taxid,
           f_okpo,f_name,f_adres,f_type,f_taxid,
  f_country,uah_nls,uah_mfo,ccy_nls,ccy_mfo,kv,kurs,s,
  allow_dat,cmode_code,character,reserv,doc,sdate,reserve2,sign_key,sign)
  VALUES
 (fn_,dat_,n_,len_,cdat_,isnull_,ndat_,mdat_,
  ctype_,cnum_cst_,cnum_year_,cnum_num_,
  mvm_feat_,s_okpo_,s_name_,s_adres_,s_type_,s_taxid_,
            r_okpo_,r_name_,r_adres_,r_type_,r_taxid_,
            f_okpo_,f_name_,f_adres_,f_type_,f_taxid_,
  f_country_,uah_nls_,uah_mfo_,ccy_nls_,ccy_mfo_,kv_,kurs_,s_,
  allow_dat_,cmode_code_,character_, rezerv_,doc_,sdate_,reserve2_,
	sign_key_,sign_);

  ret_ := 0;

RETURN;

EXCEPTION
  WHEN err THEN
     raise_application_error(-(20000+ern),'\'||erm,TRUE);
  WHEN DUP_VAL_ON_INDEX THEN
  	 ret_ := 701;		 -- Previously received file
  WHEN OTHERS THEN
     raise_application_error(-(20000+ern),SQLERRM,TRUE);
END in_tam;
/
show err;

PROMPT *** Create  grants  IN_TAM ***
grant EXECUTE                                                                on IN_TAM          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on IN_TAM          to TOSS;
grant EXECUTE                                                                on IN_TAM          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/IN_TAM.sql =========*** End *** ==
PROMPT ===================================================================================== 
