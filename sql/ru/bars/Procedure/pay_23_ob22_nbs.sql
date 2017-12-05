PROMPT ===================================================================================== 
PROMPT *** Run *** ======= Scripts /Sql/BARS/Procedure/PAY_23_OB22_NBS.sql ========*** Run *
PROMPT ===================================================================================== 

PROMPT *** Create  procedure PAY_23_OB22_NBS ***

  CREATE OR REPLACE PROCEDURE BARS.PAY_23_OB22_NBS (dat01_ DATE, mode_ NUMBER DEFAULT 0, p_user number default null,
                                                    nal_ varchar2, nn number)  IS

/* ��+���          ������ 3.0 13-06-2017  17-03-2017 23-11-2016  29-07-2016 27-07-2016  18-05-2016  

10) 23-06-2017  -   ������ ����� ��������� gl.payv ������ paytt
 9) 17-03-2017  -   R013 ��  1590,1592,2400,2401,3590 �� ������� �� ��������� �����
 8) 23-11-2016 LUDA ��� ��� 7 ������ ��� � ������ ������������� ���. ����� , ���� �� ����� �� 1||��� �������
 7) 22-11-2016 LUDA ������� ����� ��� �������� ������� (������ � ��� CANNOT INSERT NULL INTO ("BARS"."CUSTOMER"."TOBO") )
 6) 29-07-2016 LUDA Dat_last --> Dat_last_work
 5) 27-07-2016 LUDA ��� �������� 7 ��. ���� ���=1 --> RNK_b
 4) 27-07-2016 LUDA ������ ����� ��� �������� ������� (�����? ���� �� �����)
 3) 18-05-2016 LUDA ������+����� �� ������� ����� (��� ����������)   
 2) 13-05-2016 LUDA ����� ����� �� �����
 1) 24-02-2016 LUDA ������������ �������� �� ����� (�������� REZ_PAY)
------------------ 13-01-2016
13-01-2016         Update DAOS ������ ���� ��� >= 01-01-YYYY
06-01-2016         ��� �������� ������ ARE (AR* - ������)
04-01-2016         �������� ���������� ������� � ������������ �������
10-12-2015    LUDA ��������� ����������� ������������ ������ �� ������ ��������
                   (������������ ��� �������� ��������).
------------------ 18.09.15
31-07-2015    LUDA �������� ����� ��� nal = 5 - ���������� � ���������
                   ��� ���.% (r013 = 5 - ����� 30 ����)
08-06-2015    LUDA ���������� ������� ��� 2401 ��������
08-06-2015    LUDA NLS_ - 14 ������
08-06-2015    LUDA ����� �� ������ ������� �����
27-03-2015    LUDA ������ ������� � ���������� �������� (REZ_PROTOCOL) � PAY_23
25-02-2015    LUDA ������ k.r_acc:=acc_  � ������ 458.
16-12-2014    LUDA ��������� ������� REF � ������� REZ_DOC_MAKET
10-12-2014    LUDA �� ������������� �������� �� ����� �������� ������ - ���������
25-11-2014    LUDA �������� ����������� �����
25-11-2014    LUDA ��� �������� ������ 1890,2890,3590 �������� ������� (custtype=1-����)
07-11-2014    LUDA ���������� 7 ������ ���� ���� ������.
05-11-2014    LUDA ��������   PUL_dat(sdat01_,'')
22-04-2014    LUDA ������ ��������� ������������ �������� � ��������� ���
                   ������������� ���������� � ���
18-04-2014    LUDA �� ����� ������������ R013
27-02-2014    LUDA ����������� ���� �������� ��� ��������� ������
                   (���� �������� ������������� ��������� �������
                    ���� ������ ������ ��� ����� ����������� ������)
21-01-2014    LUDA ������ ��������� ������������ �������� � ��������� ���
                   ������������� ���������� � ���

   Mode_= 0 - � ����������
        = 1 - ����� ��������

   nal_ = 0 - �� ����.� ���������� ���� {����������.}(��� �����.% �� �����. < 30 ���) +��
        = 1 - ����.   � ���������� ���� {����������.}(��� �����.% �� �����. < 30 ���)
        = 2 - ����
        = 5 - ����.   � ���������� ���� {����������.}(��� �����.% �� �����. > 30 ���)
        = 6 - �� ����.� ���������� ���� {����������.}(��� �����.% �� �����. > 30 ���)
        = 7 - ֳ�� ������      (��� �����.% �� �����. >30 ���)
        = 8 - ����������� ����� (����.   � ���������� ����)
        = 9 - ����������� ����� (�� ����.� ���������� ����)
        = A - �� ����.� ���������� ���� {�����������}(��� �����.% �� �����. < 30 ���) 
        = B - ����.   � ���������� ���� {�����������}(��� �����.% �� �����. < 30 ���)
        = C - ����.   � ���������� ���� {�����������}(��� �����.% �� �����. > 30 ���)
        = D - �� ����.� ���������� ���� {�����������}(��� �����.% �� �����. > 30 ���)

*/
  doform_nazn           varchar2(100);
  doform_nazn_korr      varchar2(100);
  doform_nazn_korr_year varchar2(100);

  rasform_nazn           varchar2(100);
  rasform_nazn_korr      varchar2(100);
  rasform_nazn_korr_year varchar2(100);

  par        NBS_OB22_PAR_REZ%rowtype;
  b_date     date;
  dat31_     date;
  vv_        int;
  p4_        int;
  l_MMFO     int;  
  l_day_year NUMBER;
  r7702_acc  number;
  mon_       NUMBER;
  year_      NUMBER;
  vob_       number;
  otvisp_    number;
  fl         number(1);
  s_old_     number;
  s_old_q    number;
  s_new_     number;
  s_val_     number;
  userid_    number;
  l_user     number;
  diff_      number;
  ref_       number;
  REZPROV_   NUMBER         DEFAULT 0;
  nn_        number;
  l_rez_pay  number;
  l_pay      number;  
  r7702_     varchar2(20);
  nazn_      varchar2(500);
  tt_        varchar2(3);
  nam_a_     varchar2(50);
  nam_b_     varchar2(50);
  r7702_bal  varchar2(50);
  kurs_      varchar2(500);
  okpoa_     varchar2(14);
  error_str  varchar2(1000);
  ru_        varchar2(50);
  sdat01_    char(10);
  l_absadm   staff$base.logname%type;
  GRP_       accounts.grp%type:= 21;
  rnk_b      accounts.rnk%type;
  acc_       accounts.acc%type;
  nls_       accounts.nls%type;
  maska_     accounts.nls%type;
  isp_       accounts.isp%type;
  nms_       accounts.nms%type;
  l_acc      accounts.acc%type;
  rnk_       accounts.rnk%type;
  nmk_       customer.nmk%type;
  nmkl_      customer.nmk%type;
  nmklk_     customer.nmk%type;
  k050_      customer.k050%type;
  s080_      specparam.s080%type;
  s090_      specparam.s090%type;
  r013_      specparam.r013%type;
  l_code     regions.code%type;
  name_mon_  META_MONTH.name_plain%type;
  rz_        nbu23_rez.rz%type;
  l_nd       oper.nd%type; 
  e_nofound_7form    exception;
  e_nofound_7rasform exception;
  l_branch   accounts.branch%type := '/' || gl.amfo || '/'; 

  TYPE CurTyp IS REF CURSOR;
  c0 CurTyp;

  ---------------------------------------
  procedure p_error( p_error_type  NUMBER,
                     p_nbs         VARCHAR2,
                     p_s080        VARCHAR2,
                     p_custtype    VARCHAR2,
                     p_kv          VARCHAR2,
                     p_branch      VARCHAR2,
                     p_nbs_rez     VARCHAR2,
                     p_nbs_7f      VARCHAR2,
                     p_nbs_7r      VARCHAR2,
                     p_sz          NUMBER,
                     p_error_txt   VARCHAR2,
                     p_desrc       VARCHAR2)
  is
  PRAGMA AUTONOMOUS_TRANSACTION;
  begin
     insert into srezerv_errors ( dat,userid, error_type, nbs, s080, custtype, kv, branch, nbs_rez, nbs_7f, nbs_7r,
                                  sz, error_txt, desrc)
                         values (dat01_, userid_, p_error_type, p_nbs, p_s080, p_custtype, p_kv, p_branch, p_nbs_rez,
                                 p_nbs_7f, p_nbs_7r, p_sz, substr(p_error_txt,1,999), p_desrc) ;
     COMMIT;
  end;
  ---------------------------------------
  procedure pap_77 (p_acc  NUMBER,p_pap NUMBER) is
     l_fl NUMBER;
     begin 
        select 1 into l_fl from accounts  where acc= p_acc and pap<>p_pap;
        update accounts set pap = p_pap where acc= p_acc;
     EXCEPTION WHEN NO_DATA_FOUND THEN  NULL;

  end pap_77;
  ---------------------------------------

BEGIN

   l_rez_pay   := nvl(F_Get_Params('REZ_PAY', 0) ,0); -- ������������  ������� �� ����� (1 - ����)
   select id into l_absadm from staff$base where logname = 'ABSADM';   
   logger.info('PAY1 : l_rez_pay= ' || l_rez_pay) ;
   if l_rez_pay = 1 THEN 
         l_pay := 1;
   else  l_pay := 0;
   end if;

   sdat01_    := to_char( DAT01_,'dd.mm.yyyy');
   PUL_dat(sdat01_,'');
   l_day_year := 27; -- �-�� ���� � ������ ����, ����� �������� �������������� �� �������� , � �������
   nn_        := 22;
   if mode_ = 0 THEN
      z23.to_log_rez (user_id , nn_ , dat01_ ,'������ �������� - �������� (����� ���� ������) '||'nal='||nal_);
   else
      z23.to_log_rez (user_id , nn_ , dat01_ ,'������ �������� - �����  (����� ���� ������)'||'nal='||nal_);
   end if;
   dat31_ := gl.bdate;  --Dat_last_work(dat01_-1); -- ��������� ������� ���� ������
   if p_user  = -1 THEN -- ����������������� ��������
      l_user := -1;
   else
      l_user := p_user;
   end if;

   select EXTRACT(month  FROM dat31_), EXTRACT(YEAR  FROM dat31_) INTO mon_, year_ from dual; -- ����� ������, ���
   select name_plain INTO name_mon_ from META_MONTH where n=mon_;

   doform_nazn            := '���������� ������� �� '||name_mon_||' '||year_;
   doform_nazn_korr       := '���.�������� �� '||name_mon_||' '||year_ ||' �� ����.������� ';
   doform_nazn_korr_year  := '���.���� �������� �� '||name_mon_||' '||year_ ||' �� ����.������� ';

   rasform_nazn           := '��������� ������� �� ' || dat31_; -- ||name_mon_||' '||year_ ;
   rasform_nazn_korr      := '���.�������� �� '||name_mon_||' '||year_ ||' �� �����.������� ';
   rasform_nazn_korr_year := '���.���� �������� �� '||name_mon_||' '||year_ ||' �� �����.������� ';

   userid_ := user_id;

   s_new_ := 0;
   if nal_='0' and l_user is null THEN
      --�������� �� ���������� ���������
      --��������, ���� �� �� ������� ���� ������� ������������� �������� �� ��������
      SELECT count(*) INTO s_new_ FROM oper
      WHERE tt = 'ARE' and vdat = dat31_ AND sos not in (5, -1); --�������� �� ���������� ���������

      if s_new_ > 0 then
         bars_error.raise_error('REZ',4);
      end if;
   end if;

   if nal_='0' THEN
--      DELETE FROM srezerv_errors;
      DELETE FROM rez_doc_maket;
   end if;

   b_date  := gl.BDATE; -- bankdate;
   otvisp_ := nvl(GetGlobalOption('REZ_ISP'),userid_);

   BEGIN
      SELECT TO_NUMBER (NVL (val, '0')) INTO REZPROV_ FROM params WHERE par = 'REZPROV';
   EXCEPTION WHEN NO_DATA_FOUND THEN rezprov_ := 0;
   END;

   BEGIN
      SELECT SUBSTR (val, 1, 14) INTO okpoa_ FROM params WHERE par = 'OKPO';
   EXCEPTION WHEN NO_DATA_FOUND THEN  okpoa_ := '';
   END;

   -- ���������� ����� MMFO ?
   begin 
      select count(*) into l_MMFO from mv_kf;
      if l_MMFO > 1 THEN             l_MMFO := 1; -- �����    MMFO
      ELSE                           l_MMFO := 0; -- ����� �� MMFO 
      end if;
   EXCEPTION WHEN NO_DATA_FOUND THEN l_MMFO := 0; -- ����� �� MMFO
   end ;
   if l_MMFO = 1 THEN
      begin
         select code into l_code from regions where kf = sys_context('bars_context','user_mfo'); 
      EXCEPTION WHEN NO_DATA_FOUND THEN l_code := '';
      end;
   end if; 
   if nn <>0  THEN 
   --������� ������ ��� ��������
   DECLARE
      TYPE r0Typ IS RECORD (
           COUNTRY  CUSTOMER.COUNTRY%type,
           NBS_REZ  srezerv_ob22.NBS_REZ%TYPE,
           OB22_REZ srezerv_ob22.OB22_REZ%TYPE,
           NBS_7f   srezerv_ob22.NBS_7f%TYPE,
           OB22_7f  srezerv_ob22.OB22_7f%TYPE,
           NBS_7r   srezerv_ob22.NBS_7r%TYPE,
           OB22_7r  srezerv_ob22.OB22_7r%TYPE,
           kv       accounts.kv%TYPE,
           rz       nbu23_rez.rz%TYPE,
           branch   accounts.branch%TYPE,
           sz       number,
           szn      number,
           sz_30    number,
           s080     specparam.s080%TYPE,
           pr       srezerv_ob22.pr%TYPE,
           r_s080   specparam.s080%TYPE,
           r013     specparam.r013%TYPE,
           nd       nbu23_rez.nd%TYPE,
           cc_id    nbu23_rez.cc_id%TYPE,
           nd_cp    nbu23_rez.nd_cp%TYPE,
           r_acc    VARCHAR2(1000),
           r_nls    VARCHAR2(1000),
           f7_acc   VARCHAR2(1000),
           f7_nls   VARCHAR2(1000),
           r7_acc   VARCHAR2(1000),
           r7_nls   VARCHAR2(1000),
           cnt      int );
      k r0Typ;

   begin

   
      if nal_ in ('1','5','7','B','C','D') THEN

         OPEN c0 FOR
         select t.country, t.NBS_REZ, t.OB22_REZ, t.NBS_7f, t.OB22_7f, t.NBS_7r, t.OB22_7r, t.kv   , t.rz    , t.branch, t.sz,
                t.szn    , t.sz_30  , t.s080    , t.pr    , t.r_s080 , t.r013  , t.nd     , t.cc_id, t.nd_cp ,
                ConcatStr(ar.acc) r_acc         , ConcatStr(ar.nls) r_nls      , ConcatStr(a7_f.acc) f7_acc  ,
                ConcatStr(a7_f.nls) f7_nls      , ConcatStr(a7_r.acc) r7_acc   , ConcatStr(a7_r.nls) r7_nls  , count(*) cnt
         from ( select c.country, o.NBS_REZ , o.OB22_REZ, o.NBS_7f  , o.OB22_7f, o.NBS_7r, o.OB22_7r, o.pr , o.r013 , nvl(r.rz,1) rz, r.KV, 
                       null nd  , null cc_id, null nd_cp, rtrim(substr(r.branch||'/',1,instr(r.branch||'/','/',1,3)-1),'/')||'/' branch,
                       sum(nvl(r.rez   *100,0)) sz      , sum(nvl(r.rezn*100,0)) szn  ,
                       sum(nvl(r.rez_30*100,0)) sz_30   , decode(r.kat,1,1,9,9,2) s080, r.kat r_s080
                from nbu23_rez r
                join customer       c on (r.rnk = c.rnk)
                join srezerv_ob22_f o on (r.nbs = o.nbs and o.nal=nal_ AND r.arjk=decode(o.nal,'2','1','0') AND
                                        r.s250=decode(nal_,'A','8','B','8','C','8','D','8',decode(r.s250,'8','Z',r.s250)) and
                                        nvl(r.ob22,0)= decode(o.ob22,'0',nvl(r.ob22,0),o.ob22) and
                                        decode(r.kat,1,1,2) = decode(o.s080,'0',decode(r.kat,1,1,2),o.s080) and
                                        nvl(r.custtype,0)= decode(o.custtype,'0',nvl(r.custtype,0),o.custtype) and
                                        r.kv = decode(o.kv,'0',r.kv,o.kv) )
                where fdat = dat01_  and substr(r.id,1,4) <> 'CACP' and r.nd = decode(l_user,null,r.nd,-1,r.nd,l_user)
                      and nvl(decode(nal_,'0',rezn,'A',rezn,2,rezn,5,rez_30,'C',rez_30,6,rez_30,'D',rez_30,8,r.rez,rez_0),0) <> 0
                group by c.country,o.NBS_REZ, o.OB22_REZ, o.NBS_7f, o.OB22_7f, o.NBS_7r, o.OB22_7r, o.pr, o.r013, r.KV, r.rz,
                         rtrim(substr(r.branch||'/',1,instr(r.branch||'/','/',1,3)-1),'/')||'/',decode(r.kat,1,1,9,9,2),r.kat
              ) t
         --���� �������
         left join v_gls080 ar on ( t.NBS_REZ = ar.nbs    and t.OB22_REZ = ar.ob22  and ar.rz    = t.rz    and t.KV = ar.kv  and  
                                    t.branch  = ar.BRANCH and ar.dazs is null       and t.r_s080 = ar.s080 and t.country = ar.country)
         --���� 7 ������ ������������
         left join accounts a7_f   on (t.NBS_7f = a7_f.nbs    and t.OB22_7f = a7_f.ob22 and t.kv = a7_f.kv and 
                                       a7_f.nls like '3739_9999903' and l_branch = a7_f.BRANCH and a7_f.dazs is null)
         --���� 7 ������ ����������
         left join accounts a7_r   on (t.NBS_7r = a7_r.nbs    and t.OB22_7r = a7_r.ob22 and t.kv = a7_r.kv and 
                                       a7_r.nls like '3739_9999903'and  l_branch = a7_r.BRANCH and  a7_r.dazs is null)
         group by t.country, t.NBS_REZ, t.OB22_REZ, t.NBS_7f, t.OB22_7f, t.NBS_7r, t.OB22_7r, t.kv, t.rz, t.branch, t.sz, t.szn, t.sz_30,
                  t.s080   , t.pr     , t.nd      , t.cc_id , t.nd_cp  , t.r_s080, t.r013   ;

      elsif nal_ in ('3','7') THEN

         OPEN c0 FOR
         select t.country, t.NBS_REZ, t.OB22_REZ, t.NBS_7f, t.OB22_7f, t.NBS_7r, t.OB22_7r, t.kv   , t.rz   , t.branch, t.sz, 
                t.szn    , t.sz_30  , t.s080    , t.pr    , t.r_s080 , t.r013  , t.nd     , t.cc_id, t.nd_cp, 
                ConcatStr(ar.acc) r_acc         , ConcatStr(ar.nls) r_nls      , ConcatStr(a7_f.acc) f7_acc , 
                ConcatStr(a7_f.nls) f7_nls      , ConcatStr(a7_r.acc) r7_acc   , ConcatStr(a7_r.nls) r7_nls, count(*) cnt
         from ( select c.country, o.NBS_REZ, o.OB22_REZ, o.NBS_7f, o.OB22_7f, o.NBS_7r, o.OB22_7r, o.pr, o.r013,nvl(r.rz,1) rz, r.KV,
                       '1' cc_id,0 nd,r.nd_cp,rtrim(substr(r.branch||'/',1,instr(r.branch||'/','/',1,3)-1),'/')||'/' branch,
                       sum(nvl(r.rez*100,0)) sz,sum(nvl(r.rezn*100,0)) szn,sum(nvl(r.rez_30*100,0)) sz_30,
                       decode(r.kat,1,1,9,9,2) s080,r.kat r_s080
                from nbu23_rez r
                join customer     c on (r.rnk = c.rnk)
                join srezerv_ob22_f o on (r.nbs = o.nbs and o.nal=decode(nal_,'3','1',nal_) AND r.arjk=decode(o.nal,'2',1,0) AND
                                        nvl(r.ob22,0)= decode(o.ob22,'0',nvl(r.ob22,0),o.ob22) and
                                        decode(r.kat,1,1,2) = decode(o.s080,'0',decode(r.kat,1,1,2),o.s080) and
                                        nvl(r.custtype,0)= decode(o.custtype,'0',nvl(r.custtype,0),o.custtype) and
                                        r.kv = decode(o.kv,'0',r.kv,o.kv) )
                where fdat = dat01_ and nvl(decode(nal_,'3',rez-rez_30,rez_30),0) <> 0 and id like 'CACP%' AND
                      r.nls NOT in ('31145020560509','31145020560510','31141039596966','31148011314426')
                      and r.nd = decode(l_user,null,r.nd,-1,r.nd,l_user)
                group by c.country, o.NBS_REZ, o.OB22_REZ, o.NBS_7f, o.OB22_7f, o.NBS_7r, o.OB22_7r,o.pr, o.r013,'1', r.KV, r.rz,0,
                         r.nd_cp, rtrim(substr(r.branch||'/',1,instr(r.branch||'/','/',1,3)-1),'/')||'/',
                         decode(r.kat,1,1,9,9,2),r.kat ) t
         --���� �������
         left join v_gls080 ar on (t.NBS_REZ = ar.nbs      and t.OB22_REZ = ar.ob22   and ar.rz =t.rz        and t.KV = ar.kv   and
                                   t.branch  = ar.BRANCH   and ar.dazs is null        and t.r_s080 = ar.s080 and t.nd_cp=ar.nkd and 
                                   t.country = ar.country)
         --���� 7 ������ ������������
         left join accounts a7_f   on (t.NBS_7f  = a7_f.nbs    and t.OB22_7f  = a7_f.ob22 and t.kv = a7_f.kv 
                                   and a7_f.nls like '3739_9999903' and l_branch  = a7_f.BRANCH and a7_f.dazs is null)
         --���� 7 ������ ����������
         left join accounts a7_r   on (t.NBS_7r  = a7_r.nbs    and t.OB22_7r  = a7_r.ob22 and t.kv = a7_r.kv 
                                   and a7_r.nls like '3739_9999903' and l_branch  = a7_r.BRANCH and a7_r.dazs is null)
         group by t.country, t.NBS_REZ, t.OB22_REZ, t.NBS_7f, t.OB22_7f, t.NBS_7r, t.OB22_7r, t.kv, t.nd, t.rz, t.branch, t.sz, t.szn,
                  t.sz_30  , t.s080   , t.pr      , t.cc_id , t.nd_cp  , t.r_s080, t.r013;
      else

         OPEN c0 FOR
         select t.country, t.NBS_REZ, t.OB22_REZ, t.NBS_7f, t.OB22_7f, t.NBS_7r, t.OB22_7r, t.kv   , t.rz   , t.branch, t.sz, 
                t.szn    , t.sz_30  , t.s080    , t.pr    , t.r_s080 , t.r013  , t.nd     , t.cc_id, t.nd_cp, 
                ConcatStr(ar.acc) r_acc         , ConcatStr(ar.nls) r_nls      , ConcatStr(a7_f.acc) f7_acc, 
                ConcatStr(a7_f.nls) f7_nls      , ConcatStr(a7_r.acc) r7_acc   , ConcatStr(a7_r.nls) r7_nls, count(*) cnt
         from ( select c.country, o.NBS_REZ, o.OB22_REZ, o.NBS_7f, o.OB22_7f, o.NBS_7r, o.OB22_7r, o.pr, o.r013, nvl(r.rz,1) rz, r.KV,
                       r.nd     , r.cc_id  , r.nd_cp   , rtrim(substr(r.branch||'/',1,instr(r.branch||'/','/',1,3)-1),'/')||'/' branch,
                       sum(nvl(r.rez*100,0)) sz,sum(nvl(r.rezn*100,0)) szn,0 sz_30, decode(r.kat,1,1,9,9,2) s080, r.kat r_s080
                from nbu23_rez r
                join customer     c on (r.rnk = c.rnk)
                join srezerv_ob22_f o on (r.nbs = o.nbs and o.nal=decode(nal_,'3',0,4,1,nal_) AND r.arjk=decode(o.nal,'2',1,0) AND
                                        nvl(r.ob22,0)= decode(o.ob22,'0',nvl(r.ob22,0),o.ob22) and
                                        decode(r.kat,1,1,2) = decode(o.s080,'0',decode(r.kat,1,1,2),o.s080) and
                                        nvl(r.custtype,0)= decode(o.custtype,'0',nvl(r.custtype,0),o.custtype) and
                                        r.kv = decode(o.kv,'0',r.kv,o.kv) )
                where fdat = dat01_ and nvl(decode(nal_,'0',rezn,2,rezn,3,rez,r.rez),0) <> 0 and
                      r.nls in ('31145020560509','31145020560510','31141039596966','31148011314426')
                      and r.nd = decode(l_user,null,r.nd,-1,r.nd,l_user)
                group by C.COUNTRY,o.NBS_REZ, o.OB22_REZ, o.NBS_7f, o.OB22_7f, o.NBS_7r, o.OB22_7r, o.pr, o.r013, r.nd, r.cc_id,
                         r.KV, r.rz, r.nd_cp, rtrim(substr(r.branch||'/',1,instr(r.branch||'/','/',1,3)-1),'/')||'/',
                         decode(r.kat,1,1,9,9,2),r.kat ) t
         --���� �������
         left join v_gls080 ar on (t.NBS_REZ = ar.nbs      and t.OB22_REZ = ar.ob22   and ar.rz    = t.rz    and t.KV    = ar.kv  and
                                   t.branch  = ar.BRANCH   and ar.dazs is null        and t.r_s080 = ar.s080 and t.nd_cp = ar.nkd and 
                                   t.country = ar.country)
         --���� 7 ������ ������������
         left join accounts a7_f   on (t.NBS_7f  = a7_f.nbs    and t.OB22_7f  = a7_f.ob22 and t.kv = a7_f.kv 
                                       and a7_f.nls like '3739_9999903' and l_branch  = a7_f.BRANCH and a7_f.dazs is null)
         --���� 7 ������ ����������
         left join accounts a7_r   on (t.NBS_7r  = a7_r.nbs    and t.OB22_7r  = a7_r.ob22 and t.kv = a7_r.kv 
                                       and a7_r.nls like '3739_9999903' and l_branch = a7_r.BRANCH  and a7_r.dazs is null)
         group by t.country,t.NBS_REZ, t.OB22_REZ, t.NBS_7f, t.OB22_7f, t.NBS_7r, t.OB22_7r, t.kv, t.rz, t.branch, t.sz, t.szn,
                  t.sz_30  , t.s080  , t.pr      , t.nd    , t.cc_id  , t.nd_cp , t.r_s080 , t.r013;

      end if;

      loop
         FETCH c0 INTO k;
         EXIT WHEN c0%NOTFOUND;

         fl   := 0;
         -- acc_ := k.r_acc;
         -- logger.info('PAY1 : nls_= ' || k.r_nls||'/'||k.kv) ;
         -- logger.info('PAY2 : acc_= ' || acc_) ;
         -- logger.info('PAY3 : R013= ' || k.r013) ;
         --�������� ������������ ������
         if k.cnt > 1 then
            -- ��� ������ ����� ������� ������� ��������� ������� ������
            if instr(k.r_nls,',') > 0 then
               p_error( 12, k.NBS_REZ||'/'||k.OB22_REZ,null, null, k.kv, k.branch, k.NBS_REZ||'/'||k.OB22_REZ,
                        k.kv, null, k.sz,k.r_nls||(case k.r_s080 when 0 then '' else ' s080='||k.r_s080 end), null);
               fl := 1;

            end if;
            -- ��� ������ ����� 7 ������ (��� ������������) ������� ��������� ������� ������
            if instr(k.f7_nls,',') > 0 then
               p_error( 12, k.NBS_7f||'/'|| k.OB22_7f,null, null, 980, k.branch, k.NBS_REZ||'/'||k.OB22_REZ,
                        k.kv, null, k.sz,k.f7_nls, '������� ������� - '||k.r_nls);
               fl := 2;

            end if;
            -- ��� ������ ����� 7 ������ (��� ����������) ������� ��������� ������� ������
            if instr(k.r7_nls,',') > 0 then
               p_error( 12, k.NBS_7r||'/'|| k.OB22_7r,null, null, 980, k.branch,  k.NBS_REZ||'/'||k.OB22_REZ,
                        k.kv, null, k.sz,k.r7_nls, '������� ������� - '||k.r_nls);
               fl := 3;

            end if;
         end if;
         if fl <> 1 THEN
            acc_ := k.r_acc;
         end if;

         -- ����������� ���������� ������� � �����
         begin
            select * into par from NBS_OB22_PAR_REZ_NEW  where nbs_rez = k.nbs_rez and ob22_rez in (k.ob22_rez,'0') and rz=k.rz;
         EXCEPTION  WHEN NO_DATA_FOUND THEN 
            par.par_rnk   := 'REZ_RNK_UL';
            par.nmk       := '�� (����������)';
            par.cu        := 2;
            par.Codcagent := 3;
            par.ISE       := '11002';
            par.ved       := '51900';
            par.sed       := '12';
            par.nazn      := '(?)';
         END;
         nazn_ := par.nazn;
         if l_user is not null and l_user <> -1 THEN
            nazn_ := nazn_ ||' (�������)';
         end if;

         --�������� ������� �� ����������� ����� � ����
         if k.r_acc is null then
            if REZPROV_ = 1 then
               -- ���� �� ������ - ��������� ������ ����
               acc_:=null;
               nmk_:='������� ';
               nmk_ := nmk_ || par.nmk || '/(' || k.country || ')';
               K050_ := par.sed||'0';
               begin
                  select rnk into rnk_b from BRANCH_COUNTRY_RNK where branch = k.branch and tag = par.par_rnk and country = k.country;
                  --logger.info('PAY1 -1: nbs_rez= ' || k.nbs_rez||' ob22_rez='||k.ob22_rez || ' RNK_B=' || rnk_b ) ;
                  update customer set date_off = NULL where rnk = rnk_b and date_off is not null;
               -- select val into rnk_b from BRANCH_PARAMETERS where length(branch)=15 and tag=tag_ and branch =k.branch;
               EXCEPTION  WHEN NO_DATA_FOUND THEN
                  BEGIN
                     select substr(name,22,15) into ru_ from branch where branch=k.branch;
                  EXCEPTION  WHEN NO_DATA_FOUND THEN ru_:='';
                  END;

                  -- �����������
                  rnk_   := bars_sqnc.get_nextval('s_customer'); 
                  nmkl_  := substr(trim(NMK_),1,70);    
                  nmklk_ := substr(nmkl_,1,38);

                  kl.open_client (Rnk_,           -- Customer number
                                  par.cu,         -- Custtype_-- ��� �������: 1-����, 2-��.����, 3-���.����
                                  null,           -- � ��������
                                  nmkl_,          -- Nmk_,       -- ������������ �������
                                  NMkl_,          -- Nmk_,       -- ������������ ������� �������������
                                  nmklk_,         -- ������������ ������� �������
                                  ru_,            -- Adr_-- ����� �������
                                  par.Codcagent,  -- ��������������
                                  k.Country,      -- ������
                                  99,             -- Prinsider_, -- ������� ���������
                                  1,              -- Tgr_, -- ��� ���.�������
                                  okpoa_,         -- ����
                                  null,           -- Stmt_,     -- ������ �������
                                  null,           -- Sab_,      -- ��.���
                                  b_date,         -- DateOn_,    -- ���� �����������
                                  null,           -- Taxf_,      -- ��������� ���
                                  null,           -- CReg_,      -- ��� ���.��
                                  null,           -- CDst_,     -- ��� �����.��
                                  null,           -- Adm_,      -- �����.�����
                                  null,           -- RgTax_,    -- ��� ����� � ��
                                  null,           -- RgAdm_,    -- ��� ����� � ���.
                                  null,           -- DateT_,    -- ���� ��� � ��
                                  null,           -- DateA_,    -- ���� ���. � �������������
                                  par.Ise,        -- ����. ���. ���������
                                  '10',           -- FS ����� �������������
                                  '96120',        -- OE,        -- ������� ���������
                                  par.Ved,        -- ��� ��. ������������
                                  par.Sed,        -- ����� ��������������
                                  K050_,          -- ���������� k050
                                  null,           -- Notes_,    -- ����������
                                  null,           -- Notesec_   -- ���������� ��� ������ ������������
                                  null,           -- CRisk_,    -- ��������� �����
                                  null,           -- Pincode_,  --
                                  null,           -- RnkP_,     -- ���. ����� ��������
                                  null,           -- Lim_,      -- ����� �����
                                  null,           -- NomPDV_,   -- � � ������� ����. ���
                                  null,           -- MB_,       -- �������. ������ �������
                                  0,              -- BC_,       -- ������� ��������� �����
                                  null,           -- Tobo_,     -- ��� �������������� ���������
                                  null            -- Isp_       -- �������� ������� (�����. �����������)
                                  );
                  begin
                     INSERT INTO BRANCH_COUNTRY_RNK ( BRANCH, COUNTRY, TAG,  RNK ) VALUES (k.branch, k.country, par.par_rnk, rnk_);
                  EXCEPTION WHEN others then
                     if SQLCODE = -00001 then
                        update BRANCH_COUNTRY_RNK set rnk = rnk_ where branch = k.branch and tag = par.par_rnk;
                     end if;
                  end;

                  rnk_b:=rnk_;
                  --logger.info('PAY1 0 : nbs_rez= ' || k.nbs_rez||' ob22_rez='||k.ob22_rez || ' RNK_B=' || rnk_b ) ;
               end;

               if k.r_s080='0' then
                  s080_:=k.s080;
               else
                  s080_:=k.r_s080;
               end if;

               SELECT UPPER(NVL(k.NBS_REZ,SUBSTR(MASK,1,4))||SUBSTR(MASK,5,8))||k.OB22_REZ INTO maska_
               FROM   nlsmask WHERE  maskid='REZ';
               nls_ := f_newnls2 (NULL, 'REZ' ,k.NBS_REZ, RNK_b, 1, k.kv, maska_);
               nls_ := vkrzn( substr(gl.aMfo,1,5), NLS_);
               k.r_nls := nls_;
               select substr(trim('('||k.ob22_rez||')'|| decode(mode_,3,trim(k.CC_ID),'')
                                     || nmk_ || substr(k.branch,8,8)),1,70) into nms_ from dual;
               begin
                  select isp into isp_  from accounts
                  where kv = k.kv and branch = k.branch and nbs = k.NBS_REZ and dazs is null and isp <> l_absadm and rownum = 1;
                  EXCEPTION WHEN NO_DATA_FOUND THEN isp_ := l_absadm;
               end;

               begin
                  select acc into l_acc from accounts where nls=nls_ and kv=k.kv and dazs is not null;
                  update accounts set dazs = null where acc=l_acc;
               EXCEPTION WHEN NO_DATA_FOUND THEN null;
               END;
               if isp_ = 20094 THEN isp_ := l_absadm; end if;
               logger.info('PAY1 : nbs_rez= ' || k.nbs_rez||' ob22_rez='||k.ob22_rez || ' isp_=' || isp_ || ' NLS_=' || nls_ || ' KV=' || k.kv) ;
               op_reg(99,0,0,GRP_,p4_,rnk_b,nls_,k.kv,nms_,'ODB',isp_,acc_);
               --logger.info('PAY55 : nls_= ' || nls_||' '||acc_) ;
               k.r_acc:=acc_;
               update accounts set                 daos=dat31_ where acc= acc_ and daos > dat31_ ;
               update accounts set tobo = k.branch             where acc= acc_ and tobo <> k.branch ;

               update specparam_int set ob22=k.OB22_REZ where acc=acc_;
               if sql%rowcount=0 then
                  insert into specparam_int(acc,ob22) values(acc_, k.OB22_REZ);
               end if;
               update accounts set ob22 = k.OB22_REZ where acc= acc_ and (ob22 <> k.OB22_REZ or ob22 is null) ;

               if k.kv=980 THEN
                  s090_:='1';
               ELSE
                  s090_:='5';
               END IF;

               update specparam set s080=s080_,s090=s090_,nkd=k.nd_cp where acc=acc_;
               if sql%rowcount=0 then
                  insert into specparam (acc,s080,s090,nkd) values(acc_, s080_,s090_,k.nd_cp);
               end if;
            else
               p_error( 11, k.NBS_REZ||'/'||k.OB22_REZ,k.r_s080, null, k.kv, k.branch,k.NBS_REZ||'/'||k.OB22_REZ, k.kv, null,
                        k.sz, k.NBS_REZ||'/'||k.OB22_REZ||(case k.r_s080 when 0 then '' else ' s080='||k.r_s080 end), null);
               fl := 4;
            end if;
            if k.r_s080='0' then
               s080_:=k.s080;
            else
               s080_:=k.r_s080;
            end if;

         end if;
         -- ��� ���������� ���������� R013 ��� 2400
         --logger.info('PAY6 : acc_= ' || acc_) ;
         --logger.info('PAY7 : k.nbs_rez= ' || k.nbs_rez) ;
         --logger.info('PAY8 : k.r013= ' || k.r013) ;
         if    acc_ is not null and k.nbs_rez = '3190' and k.r013=1 THEN
               k.r013 := 'A';
         elsif acc_ is not null and k.nbs_rez = '3190' and k.r013=2 THEN
               k.r013 := 'B';
         end if;
         if mode_ = 0 THEN

            --logger.info('PAY9 : k.r013= ' || k.r013) ;
            --logger.info('PAY9 : acc_  = ' || acc_) ;
            update specparam set r013=nvl(k.r013,r013) where acc=acc_;
            if sql%rowcount=0 then
               insert into specparam (acc,r013) values(acc_, k.r013);
            end if;
         end if;

         --�������� ������ �� ������ ���� 7 ������
         if k.f7_acc is null then
            if REZPROV_ = 1 then
               acc_:=null;
               nls_ := '373909999903';
               nls_ := vkrzn( substr(gl.aMfo,1,5), NLS_);
               nms_ := '���������� ��� ���������-����������� �������';
               k.f7_nls := nls_;

               begin
                  select isp, rnk into isp_, rnk_b from accounts
                  where kv=k.kv and branch = l_branch and nbs =k.NBS_7F and ostc<>0 and dazs is null and isp<>l_absadm and rownum=1;
               EXCEPTION WHEN NO_DATA_FOUND THEN isp_ :=l_absadm; rnk_b :=to_number('1' || l_code);
               end;
               bars_audit.error('111 ����='|| nls_);

               begin
                  select acc into l_acc from accounts where nls=nls_ and kv=k.kv and dazs is not null;
                  -- ��� ������ ��� �������� �����
                  -- ���������������
                  update accounts set dazs = null, tobo = l_branch where acc=l_acc;
                  update specparam_int set ob22=k.OB22_7F where acc=l_acc;
                  if sql%rowcount=0 then
                     insert into specparam_int(acc,ob22) values(l_acc, k.OB22_7F);
                  end if;
                  update accounts set ob22 = k.OB22_7F    where acc=l_acc and (ob22 <> k.OB22_7F or ob22 is null) ;
                  k.f7_acc := l_acc;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  op_reg(99, 0, 0, GRP_, p4_, rnk_b, nls_, k.kv, nms_, 'ODB', isp_, acc_);
                  k.f7_acc:=acc_;
                  -- update accounts set tobo = k.branch,daos=dat31_ where acc= acc_;
                  update accounts set                 daos=dat31_ where acc= acc_ and daos > dat31_ ;
                  update accounts set tobo = l_branch             where acc= acc_ and tobo <> l_branch ;

                  update specparam_int set ob22=k.OB22_7F where acc=acc_;
                  if sql%rowcount=0 then
                     insert into specparam_int(acc,ob22) values(acc_, k.OB22_7F);
                  end if;
                  update accounts set ob22=k.OB22_7F  where acc= acc_ and (ob22 <> k.OB22_7F or ob22 is null) ;
               end;
            Else
               p_error( 8, k.NBS_7f||'/'|| k.OB22_7f,null, null, 980, k.branch, k.NBS_REZ||'/'||k.OB22_REZ,
                        k.kv, null, k.sz, k.NBS_7f||'/'|| k.OB22_7f,  '������� ������� - '||k.r_nls);
               fl := 4;
            end if;
         end if;

         --�������� ������ �� ������ ���� 7 ������
         if k.r7_acc is null then
            if REZPROV_ = 1 then
               acc_:=null;
               nls_ := '373909999903';
               nls_ := vkrzn( substr(gl.aMfo,1,5), NLS_);
               nms_ := '���������� ��� ���������-����������� �������';
               k.r7_nls := nls_;

               begin
                  select isp, rnk into isp_,rnk_b  from accounts
                  where kv=k.kv and branch = l_branch and nbs =k.NBS_7R and ostc<>0 and dazs is null and isp<>l_absadm and rownum=1;
               EXCEPTION WHEN NO_DATA_FOUND THEN isp_ := l_absadm; rnk_b :=to_number('1' || l_code);
               end;
               bars_audit.error('222 ����='|| nls_);

               begin
                  select acc into l_acc from accounts where nls=nls_ and kv=k.kv and dazs is not null;
                  -- ��� ������ ��� �������� �����
                  update accounts set dazs=null, tobo=l_branch where acc=l_acc;
                  update specparam_int set ob22=k.OB22_7R where acc=l_acc;
                  if sql%rowcount=0 then
                     insert into specparam_int(acc,ob22) values(l_acc, k.OB22_7R);
                  end if;
                  update accounts set ob22 = k.OB22_7R where acc=l_acc and (ob22 <> k.OB22_7R or ob22 is null);
                  k.r7_acc:=l_acc;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  op_reg(99,0,0,GRP_,p4_,rnk_b,nls_,k.kv,nms_,'ODB',isp_,acc_);
                  k.r7_acc:=acc_;
                  --update accounts set tobo = k.branch,daos=dat31_ where acc= acc_;
                  update accounts set                 daos=dat31_ where acc= acc_ and daos > dat31_ ;
                  update accounts set tobo = l_branch             where acc= acc_ and tobo <> l_branch ;

                  update specparam_int set ob22=k.OB22_7R where acc=acc_;
                  if sql%rowcount=0 then
                     insert into specparam_int(acc,ob22) values(acc_, k.OB22_7R);
                  end if;
                  update accounts set ob22 = k.OB22_7R where acc=acc_ and (ob22 <> k.OB22_7R or ob22 is null);
               end;
            else
               p_error( 8, k.NBS_7r||'/'|| k.OB22_7r,null, null, 980, k.branch,  k.NBS_REZ||'/'||k.OB22_REZ,
                        k.kv, null,  k.sz, k.NBS_7r||'/'|| k.OB22_7r,  '������� ������� - '||k.r_nls);
                fl := 4;
            end if;
         end if;

         begin
            savepoint sp;
            error_str :=null;
            --������������ ��������
            if fl = 0 then
               tt_    := '015';
               vob_   := 6;        
               s_old_ := 0;      
/*
               if l_user is not null THEN
                  vob_    := 6;
                  s_old_  := 0;  -- ���������� ������ 
               else
                  -- ���������� ����������� ��� VOB
                  if b_date - dat31_ > l_day_year and dat01_=to_date('01-01-2016','dd-mm-yyyy')  THEN
                     vob_ := 99; -- �������������� �������
                     begin
                        select ostc into s_old_ from accounts where acc=k.r_acc; -- ��� ������� ������� �������
                     EXCEPTION WHEN NO_DATA_FOUND THEN s_old_ := 0;
                     end;
                  ElsIf TO_CHAR (b_date, 'YYYYMM') > TO_CHAR (dat31_, 'YYYYMM') THEN
                     vob_ := 96; -- ��������������
                     select ost_korr(k.r_acc,dat31_,null,k.nbs_rez) INTO s_old_ from dual; -- ���������� ������ -  ������� � ���������.
                  ELSE
                     vob_ := 6;  -- �������
                     select ost_korr(k.r_acc,dat31_,null,k.nbs_rez) INTO s_old_ from dual; -- ���������� ������ -  ������� � ���������.
                  END IF;
               end if;
*/
               --����� ����� �������
               if    nal_ ='3'                  THEN  s_new_ := k.sz;
               elsif nal_ in ('4','8')          THEN  s_new_ := k.sz;
               elsif nal_ in ('5','C')          THEN  s_new_ := k.sz_30;
               elsif nal_ in ('6','D')          THEN  s_new_ := k.sz_30;
               elsif nal_ ='7'                  THEN  s_new_ := k.sz_30;
               else
                  if    k.sz_30<>0              THEN  s_new_ := k.sz-k.sz_30;
                  else                                s_new_ := k.sz;
                  end if;
               end if;

               error_str := error_str||'1';
               --������ ���������
               --logger.info('PAY11 : s_new_= ' || s_new_) ;
               --logger.info('PAY11 : s_old_= ' || s_old_) ;
               --logger.info('KORR99-11: vob_= ' || vob_||'s_old_='||s_old_||':s_new-'||s_new_||'-'||k.r_nls) ;
               if s_new_ - s_old_ <> 0 then

                  if s_new_ > s_old_ then-- ���������� �������

                     r7702_acc := k.f7_acc;
                     r7702_    := k.f7_nls;
                     r7702_bal := k.NBS_7f||'/'||k.OB22_7f;
                     pap_77 (k.f7_acc,1); -- ������������� �������� ������-������� �� 7 ��.

                  else--���������� �������

                     r7702_acc := k.r7_acc;
                     r7702_    := k.r7_nls;
                     r7702_bal := k.NBS_7r||'/'||k.OB22_7r;
                     pap_77 (k.r7_acc,2);
                  end if;
                  error_str := error_str||'2';
                  IF mode_ = 0 THEN
                     gl.REF (ref_);
                     l_nd := substr(to_char(ref_),-10);
                  end if;

--             
                  -- ������ �������� ������ ������ ��� ������� � OPER
                  SELECT SUBSTR (a.nms, 1, 38), SUBSTR (b.nms, 1, 38) INTO nam_a_, nam_b_
                  FROM accounts a, accounts b WHERE a.acc = k.r_acc and b.acc = r7702_acc;

                  if s_new_ > s_old_ then
                     diff_ := (-s_old_ + s_new_);
                     error_str := error_str||'6';
                     -- ���������� �������
                     IF    vob_ = 99 THEN nazn_ := doform_nazn_korr_year || nazn_;
                     ElsIf vob_ = 96 THEN nazn_ := doform_nazn_korr      || nazn_;
                     Else                 nazn_ := doform_nazn           || nazn_;
                     END IF;

                     error_str := error_str||'7';

                     IF mode_ = 0 THEN
                        --gl.REF (ref_);
--                        if length(ref_) < 10 THEN l_x := 1                ; l_y := length(ref_);  
--                        else                      l_x := length(ref_)+1-10; l_y := 10;
--                        end if;
--                        l_nd := substr(ref_,l_x,l_y); 
                        INSERT INTO oper (REF   , tt    , vob   , nd     , dk    , pdat   , vdat  , datd  , datp  , nam_a , nlsa   ,   mfoa, 
                                          id_a  , nam_b , nlsb  , mfob   , id_b  , kv     , s     , kv2   , s2    , nazn  , userid)
                                  VALUES (ref_  , tt_   , vob_  , l_nd   , 0     , SYSDATE, dat31_, b_date, b_date, nam_a_, k.r_nls,gl.amfo, 
                                          okpoa_, nam_b_, r7702_, gl.amfo, okpoa_, k.kv   , diff_ , k.kv  , diff_ , 
                                          nazn_ , otvisp_) ;

                        error_str := error_str||'8';

                        gl.payv (l_pay, ref_, dat31_, tt_, 0, k.kv, k.r_nls, diff_, k.kv, r7702_, diff_ );
                     
                        error_str := error_str||'9';
                     end if;
                     -- logger.info('KORR99-12+: vob_= ' || vob_||'diff_='||diff_||':s_new-'||s_new_||'-'||k.r_nls) ;
                     INSERT INTO rez_doc_maket (tt    , vob    , pdat   , vdat     , datd  , datp  , nam_a , nlsa   , mfoa  , id_a   , nam_b, nlsb      , 
                                                mfob  , id_b   , kv     , s        , kv2   , s2    , nazn  , userid , dk    , branch_a, ref  )
                                        VALUES (tt_   , k.s080 , SYSDATE, dat31_   , b_date, b_date, nam_a_, k.r_nls, k.nbs_rez||'/'||k.ob22_rez        , 
                                                okpoa_, nam_b_ , r7702_ , r7702_bal, okpoa_, k.kv  , diff_ , k.kv   , diff_ , 
                                                nazn_ , userid_, 1      , k.branch , ref_ );

                     error_str := error_str||' 10';

                  else
                     --���������� �������
                     diff_ := (s_old_ - s_new_);
                     error_str := error_str||' 11';
                     IF    vob_ = 99 THEN nazn_ := rasform_nazn_korr_year || nazn_;
                     ElsIf vob_ = 96 THEN nazn_ := rasform_nazn_korr      || nazn_;
                     Else                 nazn_ := rasform_nazn           || nazn_;
                     END IF;

                     error_str := error_str||' 12';
                     IF mode_ = 0 THEN
                        INSERT INTO oper (REF   , tt    , vob   , nd     , dk    , pdat   , vdat  , datd  , datp  , nam_a , nlsa   , mfoa   , 
                                          id_a  , nam_b , nlsb  , mfob   , id_b  , kv     , s     , kv2   , s2    , nazn  , userid )
                                  VALUES (ref_  , tt_   , vob_  , l_nd   , 1     , SYSDATE, dat31_, b_date, b_date, nam_a_, k.r_nls, gl.amfo, 
                                          okpoa_, nam_b_, r7702_, gl.amfo, okpoa_, k.kv   , diff_ , k.kv  , diff_ , 
                                          nazn_ , otvisp_ );

                        error_str := error_str||' 13';
                        gl.payv (l_pay, ref_, dat31_, tt_, 1, k.kv, k.r_nls, diff_, k.kv, r7702_, diff_);
                        error_str := error_str||' 14';
                     end if;
                     -- logger.info('KORR99-13-: vob_= ' || vob_||'diff_='||diff_||':s_new-'||s_new_||'-'||k.r_nls) ;
                     INSERT INTO rez_doc_maket (tt    , vob    , pdat   , vdat     , datd  , datp  , nam_a , nlsa   , mfoa, id_a    , nam_b , nlsb       , 
                                                mfob  , id_b   , kv     , s        , kv2   , s2    , nazn  , userid , dk  , branch_a, ref   )
                                       VALUES  (tt_   , k.s080 , SYSDATE, dat31_   , b_date, b_date, nam_a_, k.r_nls, k.nbs_rez||'/'||k.ob22_rez         , 
                                                okpoa_, nam_b_ , r7702_ , r7702_bal, okpoa_, k.kv  , diff_ , k.kv   , diff_ , 
                                                nazn_ , userid_, 0      , k.branch , ref_  );

                     error_str := error_str||' 15';

                  END IF;
                  -- ������ �� ��������� - ��� ����� ������� � rez_doc_maket � ��������� dk = -1
                  -- ����� ������������ ��� ������ ��������������� �� ��������� ���� ����
               else
                  -- logger.info('KORR99-14-0: vob_= ' || vob_||'diff_='||diff_||':s_new-'||s_new_||'-'||k.r_nls) ;
                  INSERT INTO rez_doc_maket (tt     , vob   , pdat     , vdat  , datd  , datp  , nam_a , nlsa   , mfoa    , id_a    , nam_b , nlsb  , 
                                             mfob   , id_b  , kv       , s     ,kv2    , s2    , nazn  , userid , dk      , branch_a, ref   )
                                     VALUES (tt_    , k.s080, SYSDATE  , dat31_, b_date, b_date, null  , k.r_nls, k.nbs_rez||'/'||k.ob22_rez, okpoa_, 
                                             null   , null  , r7702_bal, okpoa_, k.kv  , diff_ , k.kv  , diff_  , null  ,
                                             userid_, -1    , k.branch ,ref_   );

                  error_str := error_str||' 16';
               end if;
            end if;

         exception when others then
            rollback to sp;
            p_error( 5, null,null, null, k.kv, k.branch,k.NBS_REZ||'/'||k.OB22_REZ, k.kv, null, k.sz,
                     k.NBS_REZ||'/'||k.OB22_REZ||','||k.NBS_7f||'/'|| k.OB22_7f||','||k.NBS_7r||'/'|| k.OB22_7r||
                     substr(sqlerrm,instr(sqlerrm,':')+1), error_str);
         end;

      end loop;
      CLOSE c0;
   END;
   else
   -----------------------------------------------------------
   --��������������� ��� ��� ������ �� ������� ������� ������ �� ������������ (�.�. = 0)
   --(��� � nbu23_rez)

   DECLARE TYPE r0Typ IS RECORD (
                r_acc    accounts.acc%TYPE,
                OB22_REZ srezerv_ob22.OB22_REZ%TYPE,
                NBS_REZ  srezerv_ob22.NBS_REZ%TYPE,
                branch   accounts.branch%TYPE,
                r_nls    accounts.nls%TYPE,
                kv       accounts.kv%TYPE,
                sz       accounts.ostc%TYPE,
                NBS_7r   srezerv_ob22.NBS_7r%TYPE,
                OB22_7r  srezerv_ob22.OB22_7r%TYPE,
                r7_acc   VARCHAR2(1000),
                r7_nls   VARCHAR2(1000),
                pr       srezerv_ob22.pr%TYPE);
      k r0Typ;
   begin
      if l_user is null THEN
         if nal_ in ('0','1','2','5','6','A','B','C','D') THEN

            OPEN c0 FOR
            select a.acc r_acc, a.ob22 OB22_REZ, a.nbs NBS_REZ, rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/' branch,
                   a.nls r_nls, a.kv, a.ostc sz, o.NBS_7R, o.OB22_7R, ConcatStr(a7.acc) r7_acc, ConcatStr(a7.nls) r7_nls,o.pr
            from accounts a
            left join srezerv_ob22_r o on a.nbs = o.nbs_rez and a.ob22 = o.ob22_rez
            left join accounts a7 on (o.NBS_7R = a7.nbs and o.OB22_7R = a7.ob22 and a.kv = a7.kv and a7.nls like '3739_9999903' and 
                                  l_branch = a7.BRANCH and a7.dazs is null )
            where a.nbs in ('1590','1592',               -- ������i� �� �i�����i������� �����
                            '1890','2890','3590','3599', -- ���i������� �����������i���
                            '2400','2401','3690') and
                  o.nal=decode(nal_,'3','0',nal_) and a.dazs is null and a.ostc <> 0
                  --�� ������������� ��������
                  and not exists (select 1 from rez_doc_maket r  where r.userid = userid_ and r.nlsa = a.nls and  r.kv = a.kv)
                  --��� ������
                  and not exists (select 1 from srezerv_errors r
                                  where r.error_type <> 1 and  r.nbs_rez = a.nbs||'/'||a.ob22 and r.nbs_7f = a.kv and r.userid = userid_
                                        and r.branch = rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/' )
            group by a.acc, a.ob22, a.nbs, rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/' ,
                     a.nls, a.kv, o.NBS_7R, o.OB22_7R,o.pr,a.ostc ;
         else
            OPEN c0 FOR
            select a.acc r_acc, a.ob22 OB22_REZ, a.nbs NBS_REZ, rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/' branch,
                   a.nls r_nls, a.kv, a.ostc sz, o.NBS_7R, o.OB22_7R, ConcatStr(a7.acc) r7_acc, ConcatStr(a7.nls) r7_nls,o.pr
            from accounts a
            left join srezerv_ob22_r o on a.nbs = o.nbs_rez and a.ob22 = o.ob22_rez
            left join accounts a7 on (o.NBS_7R = a7.nbs     and o.OB22_7R = a7.ob22 and a.kv = a7.kv and a7.nls like '3739_9999903' and 
                                      l_branch = a7.BRANCH  and a7.dazs is null )
            where a.nbs in ('1490','1492','3190','3191', -- �� � �������i �� ������
                            '1491','1493','3290','3291'  -- �� � �������i �� ���������
                            ) and o.nal=decode(nal_,'3','0','4','1',nal_) and a.dazs is null and a.ostc <> 0
            --�� ������������� ��������
            and not exists (select 1 from rez_doc_maket r  where r.userid = userid_ and r.nlsa = a.nls and  r.kv = a.kv)
            --��� ������
            and not exists (select 1 from srezerv_errors r
                            where r.error_type <> 1 and  r.nbs_rez = a.nbs||'/'||a.ob22 and r.nbs_7f = a.kv and r.userid = userid_ and
                                  r.branch = rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/' )
            group by a.acc, a.ob22, a.nbs, rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/' ,
                     a.nls, a.kv, o.NBS_7R, o.OB22_7R,o.pr,a.ostc;
   
         end if;

         loop
            FETCH c0 INTO k;
            EXIT WHEN c0%NOTFOUND;

            logger.info('PAY1 : nbs_rez/ob22= ' || k.nbs_rez||'/'||k.ob22_rez|| ' NLS='||k.r_nls) ;   
            logger.info('PAY2 : nbs_7R/OB22_7R= ' || k.nbs_7R||'/'||k.ob22_7r|| ' NLS='||k.r7_nls) ;   
            fl := 0;
   
            if k.NBS_7R is null then
               p_error( 8, k.NBS_rez||'/'|| k.OB22_rez,null, null, k.kv, k.branch,k.NBS_REZ||'/'||k.OB22_REZ,
                        k.kv, null, k.sz,k.r7_nls,  '������� ������� - '||k.r_nls);
               fl := 5;
            logger.info('PAY3 : nbs_7R/OB22_7R=null ') ;      
            -- ��� ������ ����� 7 ������ (��� ����������) ������� ��������� ������� ������
            elsif instr(k.r7_nls,',') > 0 then
               p_error( 7, k.NBS_7r||'/'|| k.OB22_7r,null, null, 980, k.branch,  k.NBS_REZ||'/'||k.OB22_REZ,
                         k.kv, null, k.sz,k.r7_nls,  '������� ������� - '||k.r_nls);
               fl := 5;
             logger.info('PAY4 : nbs_7R/OB22_7R= ' || k.nbs_7R||'/'||k.ob22_7r|| ' NLS='||k.r7_nls) ;   
            --����� �� �������
            elsif k.r7_acc is null then
               begin
                  nls_     := '373909999903' ;
                  nls_     := vkrzn( substr(gl.aMfo,1,5), NLS_);
                  nms_     := '���������� ��� ���������-����������� �������';
                  k.r7_nls := nls_;
                  isp_     := l_absadm;
                  rnk_b    := to_number('1' || l_code);
                  logger.info('PAY5 : nbs_7R/OB22_7R= ' || k.nbs_7R||'/'||k.ob22_7r|| ' NLS='||nls_ || ' KV='||k.kv) ;
                  logger.info('PAY6 : nbs_7R/OB22_7R= ' || k.nbs_7R||'/'||k.ob22_7r|| ' Branch='||l_branch) ;
                  begin
                     select acc into l_acc from accounts where nls = nls_ and kv = k.kv and (dazs is not null or tobo <> l_branch);
                     -- ��� ������ ��� �������� �����
                     update accounts set dazs = null, tobo = l_branch where acc = l_acc;
                     --update specparam_int set ob22=k.OB22_7R where acc=l_acc;
                     --if sql%rowcount=0 then
                     --   insert into specparam_int(acc,ob22) values(l_acc, k.OB22_7R);
                     --end if;
                     update accounts set ob22 = k.OB22_7R where acc=l_acc and (ob22 <> k.OB22_7R or ob22 is null);
                     k.r7_acc:=l_acc;
                  EXCEPTION WHEN NO_DATA_FOUND THEN
                     op_reg(99,0,0,GRP_,p4_,rnk_b,nls_,k.kv,nms_,'ODB',isp_,acc_);
                     k.r7_acc:=acc_;
                     --update accounts set tobo = k.branch,daos=dat31_ where acc= acc_;
                     update accounts set                 daos=dat31_ where acc= acc_ and daos > dat31_ ;
                     update accounts set tobo = l_branch             where acc= acc_ and tobo <> l_branch ;
   
                     --update specparam_int set ob22=k.OB22_7R where acc=acc_;
                     --if sql%rowcount=0 then
                     --   insert into specparam_int(acc,ob22) values(acc_, k.OB22_7R);
                     --end if;
                     update accounts set ob22 = k.OB22_7R where acc=acc_ and (ob22 <> k.OB22_7R or ob22 is null);
                  end;
   
                  --p_error( 8, k.NBS_7r||'/'|| k.OB22_7r,null, null, 980, k.branch, k.NBS_REZ||'/'||k.OB22_REZ,
                  --         k.kv, null,  k.sz, k.NBS_7r||'/'|| k.OB22_7r, '������� ������� - '||k.r_nls);
                  --fl := 5;
               end;
            end if;
            --logger.info('PAY1 : nbs_rez/ob22= ' || k.nbs_rez||'/'||k.ob22_rez|| ' NLS='||k.r_nls) ;
            begin
               savepoint sp;
               -- ����������� ���������� ������� � �����
   
               error_str :=null;
               --������������ ��������
               logger.info('PAY5 : nbs_rez/ob22= ' || k.nbs_rez ||'/'||k.ob22_rez|| ' FL='||FL) ;   
               if fl = 0 then
                  begin
                     select * into par from NBS_OB22_PAR_REZ_OLD where nbs_rez = k.nbs_rez and ob22_rez in (k.ob22_rez,'0') and rz=1;
                  EXCEPTION  WHEN NO_DATA_FOUND THEN 
                     par.nazn      := '(?)';
                  END;
                  nazn_ := par.nazn;
   
                  --��� ��������
                  tt_ := '015';
                  -- ���������� ����������� ��� VOB
                  vob_ := 6;  -- �������
                  -- ������ ���������� �������
                  s_old_ := k.sz;
            logger.info('PAY6 : nbs_rez/ob22= ' || k.nbs_rez ||'/'||k.ob22_rez|| ' s_old_='||s_old_) ;   
                  -- logger.info('KORR99-3: vob_= ' || vob_||'ostc='||s_old_||'-'||k.r_acc||'-'||k.r_nls) ;
                  --����� ����� �������
                  s_new_ := 0;
   
                  error_str := error_str||'1';
                  r7702_acc := k.r7_acc;
                  r7702_ := k.r7_nls;
   
                  -- ������ �������� ������ ������ ��� ������� � OPER
                  SELECT SUBSTR (a.nms, 1, 38), SUBSTR (b.nms, 1, 38) INTO nam_a_, nam_b_ FROM accounts a, accounts b
                  WHERE a.acc = k.r_acc and b.acc = r7702_acc;
   
                  error_str := error_str||'2';
                  -- �������� �� ��������������� �������
                  IF mode_ = 0  THEN
                     gl.REF (ref_);
                     l_nd := substr(to_char(ref_),-10);
                  END IF;
   
                  error_str := error_str||'4';
   
                  --���������� �������
                  diff_ := (s_old_ - s_new_);
logger.info('PAY7 : nbs_rez/ob22= ' || k.nbs_rez ||'/'||k.ob22_rez|| ' diff_ ='||diff_) ;   
                  -- logger.info('KORR99-5: vob_= ' || vob_||'old ='||s_old_||':new-'||s_new_||'-'||k.r_nls) ;
                  error_str := error_str||'5';
   
                  IF    vob_ = 99 THEN nazn_ := rasform_nazn_korr_year || nazn_;
                  ElsIf vob_ = 96 THEN nazn_ := rasform_nazn_korr      || nazn_;
                  Else                 nazn_ := rasform_nazn           || nazn_; 
                  END IF;
   
                  error_str := error_str||'6';
                  if diff_ <> 0 THEN
                     IF mode_ = 0 then
   
                        INSERT INTO oper (REF   , tt    , vob    , nd    , dk  , pdat   , vdat  , datd  , datp  , nam_a , nlsa      , mfoa   , id_a   ,  
                                          nam_b , nlsb  , mfob   , id_b  , kv  , s      , kv2   , s2    , nazn  , userid)
                                  VALUES (ref_  , tt_   , vob_   , l_nd  , 1   , SYSDATE, dat31_, b_date, b_date, nam_a_, k.r_nls   , gl.amfo, okpoa_ , 
                                          nam_b_, r7702_, gl.amfo, okpoa_, k.kv, diff_  , k.kv  , diff_ , nazn_  , otvisp_);
                        error_str := error_str||'7';
                        gl.payv (l_pay, ref_, dat31_, tt_, 1, k.kv, k.r_nls, diff_, k.kv, r7702_, diff_ );
                        error_str := error_str||'8';
           
                     end if;
   
                     INSERT INTO rez_doc_maket (tt   , vob , pdat , vdat   , datd  , datp      , nam_a , nlsa   , mfoa, id_a      , nam_b , nlsb, 
                                                mfob , id_b, kv   , s      , kv2   , s2        , nazn  , userid , dk  , branch_a  , ref   )
                                        VALUES (tt_  , nvl(k.pr,0), SYSDATE, dat31_, b_date    , b_date, nam_a_ , k.r_nls,
                                                k.nbs_rez||'/'||k.ob22_rez , okpoa_, nam_b_    , r7702_, k.NBS_7R||'/'||k.OB22_7R , okpoa_, k.kv, 
                                                diff_, k.kv , diff_, nazn_ , userid_, 2   , k.branch  , ref_  );
                     error_str := error_str||'9';
                  end if;
               end if;
   
               exception when others then rollback to sp;
               p_error( 9, null,null, null, k.kv, k.branch,k.NBS_REZ||'/'||k.OB22_REZ, k.kv, null, k.sz,
                        k.NBS_REZ||'/'||k.OB22_REZ||','||k.NBS_7r||'/'|| k.OB22_7r|| substr(sqlerrm,instr(sqlerrm,':')+1),error_str );
            end;
         end loop;
         CLOSE c0;
      end if;
   END;
   end if;

   if mode_ = 0 THEN
      z23.to_log_rez (user_id , -nn_ , dat01_ ,'����� �������� - �������� '||'nal='||nal_);
   else
      z23.to_log_rez (user_id , -nn_ , dat01_ ,'����� �������� - ����� '||'nal='||nal_);
   end if;

   rez.p_unload_data;

END PAY_23_OB22_nbs  ;
/
show err;

grant EXECUTE                                                                on PAY_23_OB22_NBS     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on PAY_23_OB22_NBS     to RCC_DEAL;
grant EXECUTE                                                                on PAY_23_OB22_NBS     to START1;

PROMPT ===================================================================================== 
PROMPT *** End *** ======== Scripts /Sql/BARS/Procedure/PAY_23_OB22_NBS.sql =======*** End *
PROMPT ===================================================================================== 
