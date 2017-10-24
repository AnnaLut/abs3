
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_nls_mb.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_NLS_MB (
  nbs_  in  varchar2,
  rnk_  in  int,
  ACRB_ in  int,
  kv_   in  int, 
  p_test in varchar2) return varchar2  IS

rez_  int;               -- �������������
mfo_  varchar2(12);      -- ��� �������.
mfo5_ varchar2(12);      -- ��� ����
nbsn_ char(4)     ;      -- �� ��� %%
SS_   varchar2(14);      -- ��� ���� ��� ���������
dddd_ varchar2(4) ;      -- ��� �����
lik_  varchar2(14);      -- ����� �����
mas_  varchar2(14);
dat_  date;

ern  CONSTANT POSITIVE := 208;err  EXCEPTION; erm  VARCHAR2(80);

BEGIN

   SELECT to_date(p.val,'MM/DD/YYYY')
   INTO dat_ FROM params p WHERE p.par='BANKDATE';

   SELECT b.nbsn, p.val  INTO nbsn_, mfo5_
   FROM proc_dr b, params p
   WHERE b.nbs=nbs_ AND p.par='MFO' AND  ROWNUM=1;

-- ��� �� ���������
   BEGIN
     -- ��� �� ���������  SS_
     SELECT a.nls
     INTO SS_
     FROM   accounts a, cust_acc cu, int_accn i, accounts n
     WHERE a.acc=i.acc  AND a.kv  =kv_ AND a.nbs =nbs_ AND a.acc =cu.acc  AND
           cu.rnk=rnk_  AND a.ostc=0   AND a.ostb=0    AND a.ostf=0       AND
           i.acra=n.acc AND n.ostc=0   AND n.ostb=0    AND n.ostf=0       AND
          (a.mdate < dat_ OR a.mdate IS NULL)          AND a.dazs is null AND
          (n.mdate < dat_ OR n.mdate IS NULL)          AND n.dazs is null AND
           i.acrb=decode(gl.amfo,'300001',ACRB_,i.acrb) AND
                  ROWNUM=1
     ORDER BY substr(a.nls,6,9) ;
   exception when NO_DATA_FOUND THEN
     -- ���, ��� --����������� ��������� (������) �����
     SS_:=F_NEWNLS2(null, 'MBK', nbs_, RNK_,null);
   END;
   return (SS_);
END F_NLS_MB ;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_nls_mb.sql =========*** End *** =
 PROMPT ===================================================================================== 
 