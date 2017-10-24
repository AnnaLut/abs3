

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/OP_BR_SX1.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure OP_BR_SX1 ***

  CREATE OR REPLACE PROCEDURE BARS.OP_BR_SX1 
(PP_BRANCH varchar2, p_ob22 char  ) is

/*

 03-11-2011 Sta ����������� ����.������ � CCK_AN_TMP

 30-09-2011  ������� �������� ������, ����� ������ DATE_CLOSED is null

 09-06-2011 ��� Branch 2+ (����� ������ � p_Branc, � �� � PP_BRANCH)
 27-12-2010 ���� �� ���������, ������� ������� � ��������� OP_BMASK

 ����-�i���.���. �� 1-� �i�����i ��� ������ 2,2+,3 �i���
 FunNSIEdit("[PROC=>OP_BR_SX1(:sPar1,:sPar2)][PAR=>:sPar1(SEM=�����,TYPE=S,REF=BRANCH_VAR),:sPar2(SEM=�i��i���,TYPE=S,REF=VALUABLES)][MSG=>OK OP_BR_SX1 !]")

*/

---------------------------------------------------------------------------
  acc_  int    ;  nls_ varchar2(15) ; l_nms     varchar2 (50) ; l_isp int ;
  ob22_ char(2);  nbs_ char(4)      ; P_BRANCH  varchar2 (30) ; l_grp int ;
---------------------------------------------------------------------------

FUNCTION GRP_SX (NBS_ char ) RETURN int IS
-- ���������� ������ �������
  GRP_ int;
begin
  If    nbs_ in ('9819','9820','9821') then GRP_ :=  30;
  elsIf nbs_ in ('9899','9891','9893') then GRP_ := 107;
  end if;
  return GRP_;
end;

----------------------------------------
PROCEDURE SPC_op (p_TOBO VARCHAR2, p_ACC NUMBER, p_ob22 char) IS
  -- ������������� � �������� �����
  BEGIN
     update accounts      set tobo = p_TOBO where acc=p_ACC ;
     update specparam_int set ob22 = p_OB22 where acc=p_ACC ;
     if SQL%rowcount = 0 then
        insert into specparam_int (acc, ob22) values (p_ACC,p_OB22);
     end if;
  END;
---====================================

begin

  execute immediate 'truncate TABLE CCK_AN_TMP';

for B in (select branch from branch
          where length(branch) in (15,22)
            and branch like  PP_BRANCH
            and DATE_CLOSED is  null
            )
LOOP
  tuda;
  P_BRANCH :=   B.BRANCH  ;

  begin
    select isp into l_isp from accounts where kv=980 and nbs like '100%'
       and branch=P_BRANCH and dazs is null and rownum=1;
  EXCEPTION WHEN NO_DATA_FOUND THEN
     raise_application_error(-20333,
     '     ��.��� �� ����� ����� '||p_branch,TRUE);
  END;
  --------------------
  for k in (select * from valuables v
            where nvl(not_9819,0)<>1 and exists
              (select 1 from sb_ob22 where v.ob22=r020||ob22 and D_CLOSE is null
               and  v.ob22  like  p_ob22 )
            )
loop

   /*  1) ��� �i�����i - 9819(I��i �i�����i i ���������),
                     9820(������ �i���� �����i�),
                     9821(������ �������� ���i��)
   */
   ob22_ := substr(k.ob22,5,2);
   nbs_  := substr(k.ob22,1,4);
   begin
     select a.acc into  acc_ from accounts a,  specparam_int s
     where a.acc=s.acc  and  a.branch=p_BRANCH and a.nbs =NBS_
       and s.ob22=ob22_ and  a.dazs is null    and rownum=1 ;
     GOTO nexrec1;
   EXCEPTION WHEN NO_DATA_FOUND THEN  null;
   end;

   l_GRP  := GRP_SX (nbs_);
   OP_BMASK (P_BRANCH, NBS_, OB22_, l_GRP, l_isp, null, NLS_, ACC_);
   SPC_op (p_BRANCH, ACC_, ob22_);
   ---------------------------
   <<nexrec1>> null;
   ----------------------------

   /* 2) ��� �i�����i � �����i - 9899 ��� 9819(I��i �i�����i i ���������),
                             9891 ��� 9820(������ �i���� �����i�),
                             9893 ��� 9821(������ �������� ���i��)
   */

   If k.ob22_dor is null OR length(p_BRANCH) <> 15 then
      GOTO nexrec2;
   end if;
   OB22_ := k.ob22_dor;

   If    k.ob22 like '9819__' then NBS_:='9899'; l_NMS := 'I��i �i�����i ';
   elsif k.ob22 like '9820__' then NBS_:='9891'; l_NMS := '������ �� ';
   elsif k.ob22 like '9821__' then NBS_:='9893'; l_NMS := '������ ������ ��. ';
   end if;

   begin
     select a.acc into  acc_ from accounts a,  specparam_int s
     where a.acc=s.acc  and  a.branch=p_BRANCH and a.nbs =NBS_
       and s.ob22=ob22_ and  a.dazs is null    and rownum=1 ;
     GOTO nexrec2;
   EXCEPTION WHEN NO_DATA_FOUND THEN  null;
   end;

   begin
     select replace (substr(ob22||'/'||txt,1,50),'�','i')  into l_nms
     from sb_ob22
     where d_close is null and r020 = nbs_ and ob22=ob22_;
   EXCEPTION WHEN NO_DATA_FOUND THEN  null;
   end;

   l_NMS := substr( l_NMS || ' � �����i',1,50);
   l_GRP := GRP_SX (nbs_);
   OP_BMASK (P_BRANCH, NBS_, OB22_, l_GRP, l_ISP, l_NMS, NLS_, ACC_);
   SPC_op (p_BRANCH, ACC_, ob22_);
   ---------------------------
   <<nexrec2>> null;
   ---------------------------
   /* 3) ������� �i�����i �������i(�������i) - 9812   */

   If k.ob22_spl is null then
      GOTO nexrec3;
   end if;
   OB22_ := k.ob22_spl;
   NBS_  :='9812';

/*
   If    k.ob22 like '9819__' then NBS_:='9899'; l_NMS :='�������i I��i �i�����i � �����i';
   elsif k.ob22 like '9820__' then NBS_:='9891'; l_NMS :='�������i ������ �� � �����i';
   elsif k.ob22 like '9821__' then NBS_:='9893'; l_NMS :='�������i ������ ���.��.� �����i';
   end if;

 */

   begin
     select a.acc into  acc_ from accounts a,  specparam_int s
     where a.acc=s.acc  and  a.branch=p_BRANCH and a.nbs =NBS_
       and s.ob22=ob22_ and  a.dazs is null    and rownum=1 ;
     GOTO nexrec3;
   EXCEPTION WHEN NO_DATA_FOUND THEN  null;
   end;

   l_GRP  := GRP_SX (nbs_);
   OP_BMASK (P_BRANCH, NBS_, OB22_, l_GRP, l_ISP, null, NLS_, ACC_);
   SPC_op (p_BRANCH, ACC_, ob22_);
   ---------------------------
   <<nexrec3>> null;
   ---------------------------

   /* 4) �������i �i�����i � �����i - 9899 ��� 9819(I��i �i�����i i ���������),
                                      9891 ��� 9820(������ �i���� �����i�),
                                      9893 ��� 9821(������ �������� ���i��)
   */

   If k.ob22_dors is null OR length(p_BRANCH) <> 15 then
      GOTO nexrec4;
   end if;
   OB22_ := k.ob22_dors;
   If    k.ob22 like '9819__' then NBS_:='9899'; l_NMS := 'I��i �i�����i ';
   elsif k.ob22 like '9820__' then NBS_:='9891'; l_NMS := '������ �� ';
   elsif k.ob22 like '9821__' then NBS_:='9893'; l_NMS := '������ ������ ��. ';
   end if;
   begin
     select a.acc into  acc_ from accounts a,  specparam_int s
     where a.acc=s.acc  and  a.branch=p_BRANCH and a.nbs =NBS_
       and s.ob22=ob22_ and  a.dazs is null    and rownum=1 ;
     GOTO nexrec4;
   EXCEPTION WHEN NO_DATA_FOUND THEN  null;
   end;
   l_NMS := substr('�������i '|| l_NMS||' � �����i',1,38);
   l_GRP := GRP_SX (nbs_);
   OP_BMASK (P_BRANCH, NBS_, OB22_, l_GRP, l_ISP, l_nms, NLS_, ACC_);
   SPC_op (p_BRANCH, ACC_, ob22_);
   ---------------------------
   <<nexrec4>> null;
   ---------------------------

 end loop; --  ����� ����� � �� ���������

END LOOP ; --  ����� ����� B �� �������

end OP_BR_SX1 ;
/
show err;

PROMPT *** Create  grants  OP_BR_SX1 ***
grant EXECUTE                                                                on OP_BR_SX1       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on OP_BR_SX1       to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/OP_BR_SX1.sql =========*** End ***
PROMPT ===================================================================================== 
