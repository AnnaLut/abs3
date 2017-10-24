

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/XV_3800.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure XV_3800 ***

  CREATE OR REPLACE PROCEDURE BARS.XV_3800 
(p_MFO     varchar2 default null,
 branch2_  varchar2 default null,
 GL_BDATE  date   -- ����, ������� ���� ��� ����� � ��������� �������� ��������
 ) is

/*
05.02.2014 ����� �� 6204 - �������
13.02.2012 ������ 20 ��������� ��� ��22 in ('03','10','16'     )
17.06.2011 Sta ��������� ������ 954

23-02-2011 Sta �� ������ ������� �i��������� ���i 3800 �� 3801 ���� �i�� ������
06-01-2011 Sta ���������� 100% ������� ���� ������ �� 6204
               ��� ������ ��������� OP_BS_OB1 (b.branch,'6204��' ) ;

 ������� ����� 3800 � 3801 ���  ������� ������-2 �
 ��� ������ kv not (959,961,962)
  �
 ��� ��22 in ('03','10','16','20')
 �������� ������������ VP_LIST.

 ��������� ����� 3800_������,  3801_���������,
 ���� - ��� ������
 ��   - ��� ��22
 ���  - ��� ���

*/
  ern CONSTANT POSITIVE := 333;
  erm varchar2(300);

  MFO_ varchar2 (6)    ;
  nls3800_ varchar2(15);  nms3800_ varchar2(38); acc3800_ int;
  nls3801_ varchar2(15);  nms3801_ varchar2(38); acc3801_ int;

  p4_            int  ;
  acc6204_       int  ;
  acc_rrd_       int  ;
  acc_RRS_       int  ;
  nls6_ varchar2(15)  ;   nms6_ varchar2(38)  ; OB62_  char(2);
  DK_            int  ;
  ref_           int  ;
  s_          number  ;
  OB22_      char(2)  ;
  RNK_           int  ;
  val_  varchar2(10)  ;
  brG_  varchar2(15)  ;
  BRANCH_ varchar2(30);
  absadm_        int  :=20094;
  mfo5_   varchar2(5) ;
  BBBB_      char(4)  ;
  txt_      char(18)  ;
begin

 tuda;

 MFO_ := Nvl(p_MFO,gl.aMFO);

 If GL_BDATE is not null then
    -- ���������� ������ ����, ��� ����������
    begin      insert into fdat (fdat,stat) values (GL_BDATE,9);
    exception when OTHERS then  null;
    end;
    gl.pl_dat(GL_BDATE);
 end if;

 mfo5_ := substr(gl.aMfo,1,5); brG_ := '/' || MFO_ || '/000000/';

for o in (select ob22, substr(txt,1,38) NMS from sb_ob22 where r020='3800' and ob22 in ('03','10','16') and d_close is null )
loop
  If    o.ob22 = '03' then txt_:= '������ �� ������� ';
  ElsIf o.ob22 = '10' then txt_:= '���i���-������ ';
  ElsIf o.ob22 = '16' then txt_:= '���������� �������';
--ElsIf o.ob22 = '20' then txt_:= '���i���-������ �/�';
  end if;

  for b in (select branch   from   branch   where  length(branch)=15 and  bc.extract_mfo(branch)=MFO_)
  loop
    If NVL(branch2_,b.branch)<>b.branch then goto NOT_B; end if;

    BBBB_ := substr(b.branch,-5,4);
    --����� ������ ���
    begin select val into val_ from BRANCH_PARAMETERS where  branch=b.branch and tag='RNK';
          RNK_:= to_number(val_);
    EXCEPTION WHEN NO_DATA_FOUND THEN rnk_ := 1;
    end;

    for k in (select distinct kv from accounts where kv not in (980,959,961,962,954) and nls not like '3800%'
                and kv in (select kv from tabval where d_close is null)  )
    loop

      --������� ������ 3800/���
      nls3800_ := vkrzn( mfo5_,'38000'||  BBBB_  || o.ob22 );
      begin select acc into acc3800_   from accounts where nls=nls3800_ and kv=k.kv and dazs is not null;
            update accounts set dazs= null where acc=acc3800_;
      EXCEPTION WHEN NO_DATA_FOUND THEN null;
      end;
      nms3800_ :='��  '|| k.KV || txt_||'. ����� '||BBBB_;
      op_reg(99,0,0,18,p4_,RNK_,nls3800_,k.kv,nms3800_,'ODB',absadm_,acc3800_);
      update accounts set tobo=b.branch, daos = daos-10 where acc=acc3800_;
      update specparam_int set ob22=o.OB22 where acc=acc3800_;
      if SQL%rowcount = 0 then insert into specparam_int(acc,ob22) values(acc3800_, o.ob22); end if;

      --������� ������ 3801/980
      nls3801_ := vkrzn( mfo5_,'38010'||substr(nls3800_,6,9)|| k.kv );
      begin select acc into acc3801_ from accounts where nls=nls3801_ and kv=980 and dazs is not null;
            update accounts set dazs= null where acc=acc3801_;
      EXCEPTION WHEN NO_DATA_FOUND THEN null;
      end;

      nms3801_ :='��� '|| k.KV || txt_||'. ����� '||BBBB_;
      op_reg (99,0,0,18,p4_,RNK_,nls3801_,980,nms3801_,'ODB',absadm_,acc3801_);
      update accounts set tobo=b.branch, daos = daos-10 where acc=acc3801_;
      update specparam_int set ob22=o.OB22 where acc=acc3801_;
      if SQL%rowcount = 0 then insert into specparam_int(acc,ob22) values(acc3801_, o.ob22); end if;

      acc6204_ := null;  acc_rrd_ := null;  acc_rrs_ := null;

      ----------�K�-1)  �����/������� ������ 6204/01 ��� 6204/17 �� ���������� ������� ������� � �������� �����;
      If o.ob22 = '16' then ob62_ := '17' ; else  ob62_ := '01';         end if;
      OP_BS_OB1 (b.branch,'6204'||ob62_ ) ; nls6_ := nbs_ob22_null('6204',ob62_,b.branch);
      If nls6_ is null then nls6_ := nbs_ob22_null('6204',ob62_,brG_);   end if;
      If nls6_ is not null then
         begin select acc into acc6204_ from accounts where kv=980 and nls=nls6_;
         EXCEPTION  WHEN NO_DATA_FOUND THEN null;
         end;
      end if;

      If acc6204_ is null then nls6_ := vkrzn( mfo5_,'62040' || BBBB_ || ob62_ );  nms6_ := ob62_||':���-1. ����� '|| BBBB_;
         op_reg (99,0,0,18,p4_,RNK_,nls6_,980,nms6_,'ODB',absadm_,acc6204_);
         update accounts  set tobo=b.branch, daos = daos-10 where acc= acc6204_ ;
         update specparam_int set ob22=OB62_                where acc= acc6204_ ;
         if SQL%rowcount = 0 then insert into specparam_int(ob22,acc) values (ob62_, acc6204_); end if;
      end if;

      ------�K�-2)  ����� ������ 6204 -2
      If o.OB22='16' then ob62_ :='17';      else  ob62_ :='08';  end if;
      OP_BS_OB1 (b.branch,'6204'||ob62_ ) ;  nls6_ := nbs_ob22_null('6204',ob62_,b.branch);
      If nls6_ is null then  nls6_ := nbs_ob22_null('6204',ob62_,brG_); end if;
      If nls6_ is not null then
         begin select acc into acc_RRd_ from accounts where kv=980 and nls=nls6_;
         EXCEPTION  WHEN NO_DATA_FOUND THEN null;
         end;
      end if;

      If acc_rrd_ is null then  nls6_ := vkrzn( mfo5_,'62040' || BBBB_ || ob62_ );  nms6_ := ob62_||':���-2. ����� '|| BBBB_;
         op_reg (99,0,0,18,p4_,RNK_,nls6_,980,nms6_,'ODB',absadm_,acc_rrd_);
         update accounts  set tobo=b.branch, daos = daos-10 where acc= acc_rrd_ ;
         update specparam_int set ob22=OB62_                where acc= acc_rrd_ ;
         if SQL%rowcount = 0 then  insert into specparam_int(ob22,acc) values (ob62_,acc_rrd_); end if;
      end if;

      ----PK�-3)  - ����� ������ 6204 -3
      If o.OB22='16' then ob62_ := '17';    else ob62_ := '05';  end if;
      OP_BS_OB1 (b.branch,'6204'||ob62_ ) ; nls6_:=nbs_ob22_null('6204',ob62_,b.branch);
      If nls6_ is null then   nls6_:=nbs_ob22_null('6204',ob62_,brG_); end if;
      If nls6_ is not null then
         begin select acc into acc_RRs_ from accounts where kv=980 and nls=nls6_;
         EXCEPTION  WHEN NO_DATA_FOUND THEN null;
         end;
      end if;

      If acc_rrs_ is null then nls6_ := vkrzn( mfo5_,'62040'   || BBBB_  || ob62_ ); nms6_ := ob62_||':���-3. ����� '|| BBBB_;
         op_reg (99,0,0,18,p4_,RNK_,nls6_,980,nms6_,'ODB',absadm_,acc_rrs_);
         update accounts  set tobo=b.branch, daos = daos-10 where acc= acc_rrs_ ;
         update specparam_int set ob22=OB62_                where acc= acc_rrs_ ;
         if SQL%rowcount = 0 then insert into specparam_int(ob22,acc) values (ob62_,acc_rrs_);  end if;
      end if;

      --�������� � VP_LIST
      Update vp_list set  COMM = substr(nms3800_,1,30), ACC3801 = acc3801_,  ACC6204 = acc6204_,  ACC_RRR = acc_rrd_,
                                                        ACC_RRD = acc_rrd_,  ACC_RRS = acc_rrs_   where acc3800=acc3800_;
      if SQL%rowcount = 0 then
         insert into vp_list   (ACC3800,COMM,ACC3801,ACC6204,ACC_RRR,ACC_RRD,ACC_RRS)
         values (acc3800_,substr(nms3800_,1,30),  acc3801_,acc6204_,acc_rrd_, acc_rrd_,acc_rrs_);
      end if;

    end loop; -- k

    <<NOT_B>> null;

  end loop;   -- b
end loop;     -- o
--  commit;
--  suda;
end xv_3800;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/XV_3800.sql =========*** End *** =
PROMPT ===================================================================================== 
