

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/XV_3800_1.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure XV_3800_1 ***

  CREATE OR REPLACE PROCEDURE BARS.XV_3800_1 
(p_branch  branch.branch%type,
 p_KV      tabval.kv%type
 ) is

/*
Авто- открытие счетов вал по 1-й валюте и по одному Бранчу-2
*/
 mfo5_   varchar2(5)   ;
  BRANCH_ varchar2(15) ;
  txt_      char(18)   ;
  val_  varchar2(10)   ;
  RNK_           int   ;
  BBBB_      char(4)   ;
  nls3800_ varchar2(15);  nms3800_ varchar2(38); acc3800_  int ;
  nls3801_ varchar2(15);  nms3801_ varchar2(38); acc3801_  int ;
  p4_            int   ;
  absadm_        int   :=20094;
  acc6204_       int   ;  acc_rrd_       int   ; acc_RRS_  int ;
  OB62_      char(2)   ;  nls6_ varchar2(15)   ;
  ----------------------
  ern CONSTANT POSITIVE := 333;  erm varchar2(300);
   nms6_ varchar2(38)  ;
  DK_            int  ;  ref_           int  ;  s_          number  ;  OB22_      char(2)  ;
  brG_  varchar2(15)  ;

begin

 mfo5_ := substr(gl.aMfo,1,5);

 If length(p_branch) < 15 then BRANCH_ := '/' || gl.amfo ||'/000000/' ;
 else                          BRANCH_ := substr ( p_branch,1,15)     ;
 end if;

 for o in (select ob22, substr(txt,1,38) NMS from sb_ob22
           where r020='3800' and ob22 in ('03','10','16') )
 loop

    If    o.ob22 = '03' then txt_:= 'доходи та витрати ';
    ElsIf o.ob22 = '10' then txt_:= 'купiвля-продаж гот';
    ElsIf o.ob22 = '16' then txt_:= 'формування резерву';
    --ElsIf o.ob22 = '20' then txt_:= 'купiвля-продаж Б/Г';
    end if;

    BBBB_ := substr(branch_,-5,4);
    --найти нужный РНК
    begin
      select val into val_ from BRANCH_PARAMETERS where  branch=branch_ and tag='RNK';
      RNK_:= to_number(val_);
    EXCEPTION WHEN NO_DATA_FOUND THEN   rnk_:= gl.aRNK;
    end;

    --открыть нужный 3800/вал
    nls3800_ := vkrzn( mfo5_,'38000'||  BBBB_  || o.ob22 );
    begin
        select acc into acc3800_
        from accounts where nls=nls3800_ and kv=p_kv and dazs is not null;
        update accounts set dazs= null where acc=acc3800_;
    EXCEPTION WHEN NO_DATA_FOUND THEN null;
    end;
    nms3800_ :='ВП  '|| p_KV || txt_||'. Бранч '||BBBB_;
    op_reg(99,0,0,18,p4_,RNK_,nls3800_,p_kv,nms3800_,'ODB',absadm_,acc3800_);
    update accounts set tobo=branch_, daos = daos-10 where acc=acc3800_;
    update specparam_int set ob22=o.OB22 where acc=acc3800_;
    if SQL%rowcount = 0 then
       insert into specparam_int(acc,ob22) values(acc3800_, o.ob22);
    end if;

    --открыть нужный 3801/980
    nls3801_ := vkrzn( mfo5_,'38010'||substr(nls3800_,6,9)|| p_kv );
    begin
      select acc into acc3801_
      from accounts where nls=nls3801_ and kv=980 and dazs is not null;
      update accounts set dazs= null where acc=acc3801_;
    EXCEPTION WHEN NO_DATA_FOUND THEN null;
    end;
    nms3801_ :='ЕВП '|| p_KV || txt_||'. Бранч '||BBBB_;
    op_reg (99,0,0,18,p4_,RNK_,nls3801_,980,nms3801_,'ODB',absadm_,acc3801_);
    update accounts set tobo=branch_, daos = daos-10 where acc=acc3801_;
    update specparam_int set ob22=o.OB22 where acc=acc3801_;
    if SQL%rowcount = 0 then
       insert into specparam_int(acc,ob22) values(acc3801_, o.ob22);
    end if;

    acc6204_ := null;  acc_rrd_ := null;  acc_rrs_ := null;
    ----------найти нужный 6204 -1
    ob62_ := '01';
    OP_BS_OB1 (branch_,'620401' ) ;
    nls6_ :=nbs_ob22_null('6204',ob62_,branch_);
    begin
       select acc into acc6204_ from accounts where kv=980 and nls=nls6_;
    EXCEPTION  WHEN NO_DATA_FOUND THEN null;
    end;
    ----------найти нужный 6204 -2
    If o.OB22='10' then ob62_ :='10'; OP_BS_OB1 (branch_,'620410' ) ;
    else                ob62_ :='08'; OP_BS_OB1 (branch_,'620408' ) ;
    end if;
    nls6_:=nbs_ob22_null('6204',ob62_,branch_);
    begin
       select acc into acc_RRd_ from accounts where kv=980 and nls=nls6_;
    EXCEPTION  WHEN NO_DATA_FOUND THEN null;
    end;
    -------найти нужный 6204 -3
    If o.OB22='10' then ob62_ := '09'; OP_BS_OB1 (branch_,'620409' ) ;
    else                ob62_ := '05'; OP_BS_OB1 (branch_,'620405' ) ;
    end if;
    nls6_:=nbs_ob22_null('6204',ob62_,branch_);
    begin
       select acc into acc_RRs_ from accounts where kv=980 and nls=nls6_;
    EXCEPTION  WHEN NO_DATA_FOUND THEN null;
    end;
    --вставить в VP_LIST
    Update vp_list set COMM    = substr(nms3800_,1,30),
                       ACC3801 = acc3801_,
                       ACC6204 = acc6204_,
                       ACC_RRR = acc_rrd_,
                       ACC_RRD = acc_rrd_,
                       ACC_RRS = acc_rrs_
          where acc3800=acc3800_;
    if SQL%rowcount = 0 then
       insert into vp_list (ACC3800,COMM,ACC3801,ACC6204,ACC_RRR,ACC_RRD,ACC_RRS)
       values (acc3800_,substr(nms3800_,1,30), acc3801_,acc6204_,acc_rrd_, acc_rrd_,acc_rrs_);
    end if;

end loop;     -- o
--  commit;
end xv_3800_1;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/XV_3800_1.sql =========*** End ***
PROMPT ===================================================================================== 
