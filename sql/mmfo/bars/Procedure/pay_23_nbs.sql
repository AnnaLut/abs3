PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PAY_23_nbs.sql =========*** Run *** ==
PROMPT ===================================================================================== 

PROMPT *** Create  procedure PAY_23 ***

CREATE OR REPLACE PROCEDURE BARS.PAY_23_nbs (P_dat01_ DATE, mode_ NUMBER DEFAULT 0, p_user number default null, nal_ number)  IS

/* ������ 3.0 19-06-2017 20-01-2017   26-07-2016  18-05-2016 (24-02-2016, 04-01-2016, 18-09-2015)

   ���������� ������/�������� �� �������
   -------------------------------------

8) 19-06-2017  -   �������� � �������� ������ �� �� ���������� � PRVN_FLOW (cp_ucenka)
----------------- 351 --------------------
7) 20-01-2017  -   ���� �� �������� 351
----------------- 23  --------------------
6) 26-07-2016 LUDA ���� ����� � �������� (error_type = 1)
5) 18-05-2016 LUDA �������� � �������� ������ �� �� (��������� �������) + ������ �� �����.
4) 13-05-2016 LUDA �������� � �������� ������ �� �� (��������� �������)
3) 24-02-2016 LUDA �������� � �������� ������ �� ��
2) 04-01-2016 LUDA �������� �� ������ ������ � FINEVARE - ����������� ��� �������
1) 04-01-2016 LUDA ��� �������� � NBU23_REZ_OTCN ��������� DAT_MI
   26-08-2015 LUDA ��������� update rez_protocol set crc = null where dat=dat31_;
   07-05-2015 LUDA �������� �� ��������� �������� ������ �� ����� ������ ������
   11-03-2015 LUDA �������� �������� �� ������������ ���������� �������
   10-12-2014 LUDA �������� ����������� �����
   22-04-2014 LUDA ��������� REZERV_23 � ������ ��� �� PAY_23_ob22
------------------
   p_user   -  � ����� NULL
------------------
   Mode_= 0 -  � ����������
        = 1 -  ����� ��������
------------------
   nal_ = 0 -  �� ����.� ���������� ���� {����������.}(��� �����.% �� �����. < 30 ���) +��
          1 -  ����.   � ���������� ���� {����������.}(��� �����.% �� �����. < 30 ���)
          2 -  ����
          5 -  ����.   � ���������� ���� {����������.}(��� �����.% �� �����. > 30 ���)
          6 -  �� ����.� ���������� ���� {����������.}(��� �����.% �� �����. > 30 ���)
          7 -  ֳ�� ������ (��� �����.% �� �����. >30 ���)
          8 -  ����������� ����� (����.   � ���������� ����)
          9 -  ����������� ����� (�� ����.� ���������� ����)
          A -  �� ����.� ���������� ���� {�����������}(��� �����.% �� �����. < 30 ���)
          B -  ����.   � ���������� ���� {�����������}(��� �����.% �� �����. < 30 ���)
          C -  ����.   � ���������� ���� {�����������}(��� �����.% �� �����. > 30 ���)
          D -  �� ����.� ���������� ���� {�����������}(��� �����.% �� �����. > 30 ���)

*/

oo           oper%rowtype  ;

l_finevare   NUMBER ;  l_row_id14   NUMBER ;  l_row_id13   NUMBER ;  l_row_id18   NUMBER ;  l_user       NUMBER ;  l_user_id    NUMBER ;
l_user_err   NUMBER ;  l_kat        NUMBER ;  l_rez        NUMBER ;  l_fl         NUMBER ;  l_rez_pay    NUMBER ;  l_pay        NUMBER ;
l_rnk        NUMBER ;  l_ref        INT    ;

dat31_       date   ;  dat01_       date   ;  l_dat        date   ; 


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
   insert into srezerv_errors ( dat      , userid  , error_type  , nbs  , s080                     , custtype  , kv  , branch  ,
                                nbs_rez  , nbs_7f  , nbs_7r      , sz   , error_txt                , desrc     )
                       values ( dat01_   , user_id , p_error_type, p_nbs, p_s080                   , p_custtype, p_kv, p_branch,
                                p_nbs_rez, p_nbs_7f, p_nbs_7r    , p_sz , substr(p_error_txt,1,999), p_desrc   );
   COMMIT;
end;
---------------------------------------

begin

   if MODE_ = 1 THEN
      --logger.info('PAY23 0 : mode_ = ' || mode_) ;
      DELETE FROM srezerv_errors;
      commit;
   end if;

   IF P_DAT01_ IS NULL then  dat01_ := ROUND(SYSDATE,'MM');
   else                      dat01_ := p_dat01_;
   end if;

   dat01_ := trunc(gl.bdate,'MM');
   -- ���� ��� ����������� �����
   --   dat01_   := to_date('01-01-2016','dd-mm-yyyy'); -- ����� ����
   --   gl.bdate := to_date('29-01-2016','dd-mm-yyyy'); -- ��������� ���� ��� ����� ����������

   l_fl := 0;


begin
   for k in ( select n.rowid RI, a.dazs,a.nbs, n.acc, n.nls nls_old, a.nls nls_new, a.ob22 ob22_new, 1 kat, substr(a.nls,1,4) nbs_new
                  from nbu23_rez n, accounts a,specparam s
                  where n.fdat=dat01_ and n.acc=a.acc and a.acc=s.acc  )
   LOOP
      if k.dazs is not null THEN
         begin
            select r020_new, ob_new into k.nbs_new,  k.ob22_new from transfer_2017 where r020_old=k.nbs and ob_old=k.ob22_new;
         EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
         end;
      end if;     
      update nbu23_rez set nls = k.nls_new, ob22=k.ob22_new, nbs = k.nbs_new, kat = 1 where rowid = k.ri;
   end LOOP;
   commit;
end;

/*
   if p_user is null and nal_ = 0 THEN
      begin
         select max(row_id) into l_row_id14 from rez_log where fdat=dat01_ and kod=-14;
         --logger.info('ZAL23-0 : l_row_id14= ' || l_row_id14) ;
         if l_row_id14 is NULL THEN
            --logger.info('ZAL23-1 : l_row_id14= ' || l_row_id14) ;
            z23.to_log_rez (user_id , 99 , dat01_ ,'�� ������� ���������� ������������ �� '||dat01_);
            raise_application_error(-20001,'�� ������� ���������� ������������ �� '||dat01_);
         end if;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         --logger.info('ZAL23-2 : l_row_id14= ' || l_row_id14) ;
         z23.to_log_rez (user_id , 99 , dat01_ ,'�� ������� ���������� ������������ �� '||dat01_);
         raise_application_error(-20001,'�� ������� ���������� ������������ �� '||dat01_);
      END;

      begin
         select max(row_id) into l_row_id13 from rez_log where fdat=dat01_ and kod=-13;
         if l_row_id13 is null THEN
            z23.to_log_rez (user_id , 99 , dat01_ ,'�� ������� �. 1.1. ���������� ���������� ������ �� �������� 351 (��������) �� '||dat01_);
            raise_application_error(-20002,'�� ������� �. 1.1. ���������� ���������� ������ �� �������� 351 (��������) �� '||dat01_);
         end if;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         z23.to_log_rez (user_id , 99 , dat01_ ,'�� ������� �. 1.1. ���������� ���������� ������ �� �������� 351 (��������) �� '||dat01_);
         raise_application_error(-20002,'�� ������� �. 1.1. ���������� ���������� ������ �� �������� 351 (��������) �� '||dat01_);
      END;
      -- �������� �� ������ ������ � FINEVARE
      l_finevare := nvl(F_Get_Params('REZ_FINEVARE', 0) ,0);  -- ������ �� FINEVARE
      if l_finevare = 1 THEN
         begin
            select sum(nvl(rez39,0)) into l_rez from nbu23_rez where fdat=dat01_;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            z23.to_log_rez (user_id , 99 , dat01_ ,'�� ���������� ���� � FINEVARE �� '||dat01_);
            raise_application_error(-20007,'�� ���������� ���� � FINEVARE �� '||dat01_);
         end;
         if l_rez = 0 THEN
            z23.to_log_rez (user_id , 99 , dat01_ ,'�� ���������� ���� � FINEVARE �� '||dat01_);
            raise_application_error(-20007,'�� ���������� ���� � FINEVARE �� '||dat01_);
         end if;
      end if;

      --begin
      --   for k in (select * from nbu23_rez where fdat=dat01_ and kat is null and id not like 'CACP%')
      --   LOOP
      --      p_error( 10, k.NBS||'/'||k.OB22,null, null, k.kv, k.branch,null,
      --               null, null, k.bv*100,k.nls||'/'||k.nd||' ���� ���.���.'|| k.id, null);
      --      l_FL:=1;
      --   END LOOP;
      --   if l_fl=1 THEN
      --      raise_application_error(-20006,'���� ������� �����, ���������� ��� 2902 - ��� -������� �� ���� ' ||dat01_);
      --   end if;
      --END;

      if l_row_id13 < l_row_id14 THEN
         z23.to_log_rez (user_id , 99 , dat01_ ,'ϳ��� ���������� ������������ �� �������� 1.1. ���������� ���������� ������ �� �������� 351 �� '||dat01_);
         raise_application_error(-20003,'ϳ��� ���������� ������������ �� �������� 1.1. ���������� ���������� ������ �� �������� 351 �� '||dat01_);
      end if;

      begin
         select max(row_id), user_id into l_row_id18,l_user_id from rez_log
         where  fdat=dat01_ and kod=-18  and rownum=1 group by user_id ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         if mode_ = 0 THEN
            z23.to_log_rez (user_id , 99 , dat01_ ,'�� ������� 98. ����� �������� �� '||dat01_);
            raise_application_error(-20004,'�� ������� 98. ����� �������� �� '||dat01_);
         end if;
      END;
      --������� ������ ��� ������� ��� ���������� � �����������
      insert into srezerv_errors (dat,userid, error_type, nbs, s080, custtype, kv, branch,  sz, error_txt, nbs_7f)
      select dat01_, user_id, 3, r.nbs||'/'||r.ob22, null,null ,r.kv,
             rtrim(substr(r.branch||'/',1,instr(r.branch||'/','/',1,3)-1),'/')||'/' branch,
             sum(nvl(r.rez*100,0)) sz,
             substr('S080 = '||r.kat||', ��� �볺��� - '||decode(r.custtype,2, '��.��.',3, 'Գ�.��.','')||'. ������� - '
                    ||ConcatStr(r.nls),1,999),r.kv
      from nbu23_rez r
      where fdat = dat01_ and nvl(r.rez,0) <> 0
            and not exists (select 1 from srezerv_ob22 o
                            where r.nbs = o.nbs and r.ob22 = decode(o.ob22,'0',r.ob22,o.ob22) and
                                  decode(r.kat,1,1,2) = decode(o.s080,'0',decode(r.kat,1,1,2),o.s080) and
                                  r.custtype = decode(o.custtype,'0',r.custtype,o.custtype) and
                                  r.kv = decode(o.kv,'0',r.kv,o.kv) )
      group by r.nbs,r.ob22, r.kat,r.custtype ,r.kv,rtrim(substr(r.branch||'/',1,instr(r.branch||'/','/',1,3)-1),'/')||'/';
      commit;

      begin
         select userid into l_user_err from srezerv_errors where userid=user_ID and rownum=1;
         raise_application_error(-20005,'� ������� ��� ��������� �������� (���������T� ��� 2902 ���-�������) �� '||dat01_);
      EXCEPTION WHEN NO_DATA_FOUND THEN  null;
      END;
   end if;
*/
   dat31_ := gl.bdate; --Dat_last_work(p_dat01_ - 1);
   if mode_ = 0 THEN
      z23.to_log_rez (user_id , 17 , dat01_ ,'������ �������� - �������� ');
   else
      z23.to_log_rez (user_id , 18 , dat01_ ,'������ �������� - ����� ');
   end if;
   delete from srezerv_errors;
   if mode_ = 0 and (p_user is null or p_user = -1) THEN
      -- ��� ����� ������������ �������� ��������� �������, ��� �������� ������������
      -- � ����� �������� ������� �������������.
      update rez_protocol set crc = null where dat=dat31_;
   END IF;
   -- ����������� ����������
   if nal_ = 0 THEN  -- ���������������� 
      rezerv_23(dat01_);
      -- ���������/�� ���������
      PAY_23_ob22_nbs(dat01_, mode_, p_user,'0',nal_);
      PAY_23_ob22_nbs(dat01_, mode_, p_user,'1',nal_);
      PAY_23_ob22_nbs(dat01_, mode_, p_user,'5',nal_);
      PAY_23_ob22_nbs(dat01_, mode_, p_user,'6',nal_);
      -- ����������� �����
      PAY_23_ob22_nbs(dat01_, mode_, p_user,'A',nal_);
      PAY_23_ob22_nbs(dat01_, mode_, p_user,'B',nal_);
      PAY_23_ob22_nbs(dat01_, mode_, p_user,'C',nal_);
      PAY_23_ob22_nbs(dat01_, mode_, p_user,'D',nal_);
      -- ������ ������
      PAY_23_ob22_nbs(dat01_, mode_, p_user,'3',nal_);
      PAY_23_ob22_nbs(dat01_, mode_, p_user,'4',nal_);
      PAY_23_ob22_nbs(dat01_, mode_, p_user,'7',nal_);
      -- ���������� ������ �������
      P_2400_23(dat01_);

   else 
      rezerv_23_f(dat01_); --������������ 
      PAY_23_ob22_nbs(dat01_, mode_, p_user,'0',nal_);
      PAY_23_ob22_nbs(dat01_, mode_, p_user,'1',nal_);
      PAY_23_ob22_nbs(dat01_, mode_, p_user,'5',nal_);
      -- ����������� �����
      PAY_23_ob22_nbs(dat01_, mode_, p_user,'B',nal_);
      PAY_23_ob22_nbs(dat01_, mode_, p_user,'C',nal_);
      -- ������ ������
      PAY_23_ob22_nbs(dat01_, mode_, p_user,'3',nal_);
      PAY_23_ob22_nbs(dat01_, mode_, p_user,'4',nal_);
      PAY_23_ob22_nbs(dat01_, mode_, p_user,'7',nal_);
      -- ���������� ������ �������             
      P_2400_23_nbs(dat01_);

   end if;
   if mode_ = 0 THEN
      l_ref := bars_sqnc.get_nextval('s_REZ_OTCN');
      insert INTO NBU23_REZ_OTCN
            (ref        , FDAT , ID    , RNK    , NBS     , KV       , ND     , CC_ID   , ACC    , NLS     , BRANCH  , FIN       , OBS       ,
             KAT        , K    , IRR   , ZAL    , BV      , PV       , REZ    , REZQ    , DD     , DDD     , BVQ     , CUSTTYPE  , IDR       ,
             WDATE      , OKPO , NMK   , RZ     , ISTVAL  , R013     , REZN   , REZNQ   , ARJK   , PVZ     , PVZQ    , ZALQ      , PVQ       ,
             SDATE      , IR   , R011  , S180   , NLS_REZ , NLS_REZN , S250   , ACC_REZ , FIN_R  , ACC_REZN, ZAL_BL  , ZAL_BLQ   , DISKONT   ,
             ISP        , OB22 , TIP   , SPEC   , OB22_REZ, OB22_REZN, IR0    , IRR0    , ND_CP  , SUM_IMP , SUMQ_IMP, PV_ZAL    , VKR       ,
             S_L        , SQ_L , ZAL_SV, ZAL_SVQ, GRP     , KOL_SP   , PVP    , BV_30   , BVQ_30 , REZ_30  , REZQ_30 , NLS_REZ_30, ACC_REZ_30,
             OB22_REZ_30, BV_0 , BVQ_0 , REZ_0  , REZQ_0  , REZ39    , KAT39  , REZQ39  , S250_39, REZ23   , KAT23   , REZQ23    , S250_23   ,
             DAT_MI     , TIPA , BVU   , BVUQ   , EAD     , EADQ     , CR     , CRQ     , KOL_351, FIN_351 , KPZ     , KL_351    , LGD       ,
             OVKR       , P_DEF, OVD   , OPD    , RC      , RCQ      , ZAL_351, ZALQ_351, CCF    , TIP_351 , PD_0    , FIN_Z     , ISTVAL_351,
             RPB
            )
      select l_ref      , FDAT , ID    , RNK    , NBS     , KV       , ND     , CC_ID   , ACC    , NLS     , BRANCH  , FIN       , OBS       ,
             KAT        , K    , IRR   , ZAL    , BV      , PV       , REZ    , REZQ    , DD     , DDD     , BVQ     , CUSTTYPE  , IDR       ,
             WDATE      , OKPO , NMK   , RZ     , ISTVAL  , R013     , REZN   , REZNQ   , ARJK   , PVZ     , PVZQ    , ZALQ      , PVQ       ,
             SDATE      , IR   , R011  , S180   , NLS_REZ , NLS_REZN , S250   , ACC_REZ , FIN_R  , ACC_REZN, ZAL_BL  , ZAL_BLQ   , DISKONT   ,
             ISP        , OB22 , TIP   , SPEC   , OB22_REZ, OB22_REZN, IR0    , IRR0    , ND_CP  , SUM_IMP , SUMQ_IMP, PV_ZAL    , VKR       ,
             S_L        , SQ_L , ZAL_SV, ZAL_SVQ, GRP     , KOL_SP   , PVP    , BV_30   , BVQ_30 , REZ_30  , REZQ_30 , NLS_REZ_30, ACC_REZ_30,
             OB22_REZ_30, BV_0 , BVQ_0 , REZ_0  , REZQ_0  , REZ39    , KAT39  , REZQ39  , S250_39, REZ23   , KAT23   , REZQ23    , S250_23   ,
             DAT_MI     , TIPA , BVU   , BVUQ   , EAD     , EADQ     , CR     , CRQ     , KOL_351, FIN_351 , KPZ     , KL_351    , LGD       ,
             OVKR       , P_DEF, OVD   , OPD    , RC      , RCQ      , ZAL_351, ZALQ_351, CCF    , TIP_351 , PD_0    , FIN_Z     , ISTVAL_351,
             RPB
      From   nbu23_rez
      where  fdat=dat01_ and nd = decode(p_user, null, nd, -1, nd, p_user);

      if p_USER IS NULL or p_user = -1 then
         INSERT INTO rez_protocol (userid, dat,dat_bank,dat_sys,ref,crc)  VALUES ( user_id, dat31_, gl.bdate, SYSDATE,l_ref,'1');
      END IF;
      commit;

      z23.to_log_rez (user_id , -17 , dat01_ ,'����� �������� - �������� ');
   else
      z23.to_log_rez (user_id , -18 , dat01_ ,'����� �������� - ����� ');
   end if;
   -- ?? ���� ������ ���� �� ��������� ??
   -- s_new_ := 0;
   -- select count(*) into s_new_ from  srezerv_errors;
end;
/
show err;

PROMPT *** Create  grants  PAY_23_nbs ***
grant EXECUTE                                                                on PAY_23_nbs          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on PAY_23_nbs          to RCC_DEAL;
grant EXECUTE                                                                on PAY_23_nbs          to START1;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PAY_23_nbs.sql =========*** End *** ==
PROMPT ===================================================================================== 
