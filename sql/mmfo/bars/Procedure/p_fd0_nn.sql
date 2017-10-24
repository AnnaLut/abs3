

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FD0_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FD0_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_FD0_NN (Dat_ DATE ,
                                      sheme_ varchar2 default 'G') IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : ��������� ������������ #D0 ��� �� (�������������)
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 02.12.2011 (25.11.11,04.10.11,29.09.11,27.09.11,26.09.11,
%                           05.09.11,17.11.08,07.10.08,26.08.08,19.08.08)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
���������: Dat_ - �������� ����
           sheme_ - ����� ������������
!!! ��� ������ ������� �������� "���������� ����������"

02.12.2011 ��� ����������� branch_id_ ������� BEGIN .. EXCEPTION .. END
25.11.2011 ��� ����� 10,12, 32,34, 36, 33,35, 37 ���������� ������������� 
           ����������� � ����� ������������ (������� ������� ����) 
27.10.2011 ��� ����� 10,12 � ������� �� ����� ����������� ����������� 
           ��������� ������� "and op.mod_date is null" (����������������)
06.10.2011 � ���������� 10 ����� �������� ������ �� STATUS<>3 ����
           STATUS in (2,4) 
04.10.2011 ����� �������� ������ � �������� STATUS=0
29.09.2011 ��� ����� 10,12 ������� ������� op.status > 0 ��
           op.status in (2,4) �������� ��������� 162
27.09.2011 ��� ������������ ���� DD='01' ������� �������
           op.mod_date is null (��������� �������)
           ��� DD='02' ����� ������������� ������ ��� �������
           OPR_VID3='603'
           ��� ������������ ����� 32,34,36 ����� �������
           r.status in (2,4) - ���� �����?�
26.09.2011 ������� ������� ������������ ����� 32,34,36
           (������ op.KL_DATE  ����� ������������ r.IN_DATE)
           � ���� 78 (��� ����� ����� 332...., 334...., 336....)
20.09.2011 ������� ������� ������������ ���� 14 � ������� ������������
           ����� 15, 17, 18
05.09.2011 ���?� ���? ����������� � 01.09.2001
17.11.2008 ��������� ��� ������� "5"-�����������������(����� 1,2,3,4)
           ��������� ���������������� �-�� ����� ������������
07.10.2008 � ������ ��������� ���� "tobo" ��� ����� ��� �������
           ������������ ��� ������� ��� ��������� ���������, � ��
           ��� ������� ��������� ����� (��������� ����� ������������)
26.08.2008 ����� ����������� ��� ������ 91 (nbuc_ := nbuc1_) �.�.
           � ��������� ������ �� ����������� ���������� � ������� �
           ����� ��������� ���������� � �������� ����������, � � ����
           ������ ���������� NBUC �� ����������
19.08.2008 ����������� � ������� ����� �������� (����������)
14.08.2008 � 01.09.2008 ����������� ����� ���� "11","91"
07.05.2008 �������� ������������ ���� "09"
           ������� ������ �� �������� �� ���� ������� �������
           (���������(�����������) ������ ���)
           (��������� �������������� � ����� ������������)
09.04.2008 ��� ���� 08 (�������) � ����. REQUEST ���� IN_DATE ����� TRUNC
           �.�. ������ �� �������� � ��������� STATUS 2,4
           ��� ���� 09 (������) � ����. REQUEST ���� IN_DATE ����� TRUNC
           �.�. ������ �� �������� �������� STATUS 2,4 � ��������� � ����.
           file_out � �������� �� ���� ����. ������ ����  ��������� �������
           (��������� �������������� � ����� ������������)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='D0';
typ_     number;
acc_     Number;
kv_      Number;
nls_     Varchar2(15);
nlsk_    Varchar2(15);
nlsk1_   Varchar2(15);
mfo_     Varchar2(12);
nbuc1_   Varchar2(12);
nbuc_    Varchar2(12);
tk_      Varchar2(1);
kol_     Number;
rnk_     Number;
okpo_    Varchar2(14);
data_    Date;
Dat1_    Date;
kodp_    Varchar2(10);
znap_    Varchar2(70);
userid_  Number;
ref_     number;
rez_     number;
branch_id_ Varchar2(15);
zzzzz_   varchar2(5);
dd_      varchar2(2);

-- ��������� ����������� ���� ����������
PROCEDURE p_nbuc_ is
BEGIN

    BEGIN
       select acc
          INTO acc_
       from accounts
       where nls=trim(nls_)
         and kv=kv_;
    EXCEPTION WHEN NO_DATA_FOUND THEN
       acc_ := NULL;
    END;

    if acc_ is not null then
       IF typ_>0 THEN
          nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
       ELSE
          nbuc_ := nbuc1_;
       END IF;
    end if;
END;

-----------------------------------------------------------------------------
BEGIN
   execute immediate 'ALTER SESSION SET NLS_NUMERIC_CHARACTERS=''.,''';
-------------------------------------------------------------------
   --SELECT id INTO userid_ FROM staff WHERE upper(logname)=upper(USER);
   userid_ := user_id;
   --DELETE FROM RNBU_TRACE WHERE userid = userid_;
   EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
   mfo_:=F_OURMFO();
   Dat1_ := TRUNC(Dat_,'MM'); -- ������� ������������ �i����

-- � ������ 2006 ���� ���� #D0 ����� ������������� �� ����� ���
-- � ������� ������ �� ����� (����� �������� ���������� Dat1_)
-- ������������� ������� ������ � ������������� ������ ������ ��� Dat1_
--   Dat1_ := to_date('01-01-2005','dd-mm-yyyy'); -- ������� 2005 ����

   if Dat_ = to_date('31082011','ddmmyyyy') then
      Dat1_ := to_date('01012011','ddmmyyyy'); -- ������� � ������� 2011 ����
   end if;

   -- ��������� ������������ �����
   p_proc_set(kodf_,sheme_,nbuc1_,typ_);

   nbuc_ := nbuc1_;

   BEGIN
      select id into branch_id_
      from finmon.bank
      where ust_mfo = (select val from params where par='MFO');
   EXCEPTION WHEN NO_DATA_FOUND THEN
      branch_id_ := null;     
   END;

   kol_:=0;

   -- ��� 01
   for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                    op.branch_id BRANCH_ID,
                    nvl(op.kl_date,op.kl_date_branch_id) DAT,
                    op.opr_sumg S,
                    p.cl_stp TK, p.doc_nm_r NDR, p.cl_id CL_ID
             from finmon.oper op, finmon.person_oper po, finmon.person p
             where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
           --    and op.mod_date is null
               and op.id=po.oper_id
               and op.status<>3
               and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
               and po.cl_type='1'
               and po.person_id=p.id
               and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
               and p.cl_stp in ('1','2','3','4','5') )
    loop

          tk_:=k.tk;

          if k.tk='2'  then
             tk_:='3';
          elsif k.tk='3'  then
             tk_:='2';
          elsif k.tk in ('4', '5')  then
             tk_:='1';
          end if;

          kol_:=0;

          nls_ := trim(k.nls);
          kv_  := trim(k.kv);
          p_nbuc_;

          IF (mfo_=300120 and k.branch_id=branch_id_) or
             (mfo_ not in (300120)) THEN

             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                    VALUES
                    (k.nls, k.kv, k.dat, '10100000'||tk_, to_char(k.s), nbuc_);
             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc, comm)
                    VALUES
                    (k.nls, k.kv, k.dat, '30100000'||tk_, '1', nbuc_, k.cl_id);
          END IF;

          nbuc_ := nbuc1_;
   end loop;

   if dat_ <= to_date('30082011','ddmmyyyy') then
      -- ��� 02
      for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                       op.branch_id BRANCH_ID,
                       nvl(op.kl_date,op.kl_date_branch_id) DAT,
                       kl.d050 ZZZZZ, op.opr_sumg S,
                       p.cl_stp TK, p.doc_nm_r NDR
                from finmon.oper op, finmon.person_oper po, finmon.person p,
                     kl_d050 kl
                where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
                  and op.mod_date is null
                  and op.status IN (2,4)
                  and op.id=po.oper_id
                  and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
                  and po.cl_type='1'
                  and po.person_id=p.id
                  and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
                  and p.cl_stp in ('1','2','3','4','5')
                  -----------------------------------------
                  and op.file_id is not null
                  and (op.opr_vid2=substr(kl.txt64,1,4) and substr(kl.d050,1,1)='2')
                UNION ALL
                  select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                         op.branch_id BRANCH_ID,
                         nvl(op.kl_date,op.kl_date_branch_id) DAT,
                         kl.d050 ZZZZZ, op.opr_sumg S,
                         p.cl_stp TK, p.doc_nm_r NDR
                  from finmon.oper op, finmon.person_oper po, finmon.person p,
                       kl_d050 kl
                  where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
                    and op.mod_date is null
                    and op.file_id is not null
                    and op.id=po.oper_id
                    and op.status IN (2,4)
                    and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
                    and po.cl_type='1'
                    and po.person_id=p.id
                    and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
                    and p.cl_stp in ('1','2','3','4','5')
                    -----------------------------------------
                    and ((op.opr_vid2 is null or op.opr_vid2 = '0000') and
                          substr(op.opr_vid1,15,1) <> '2' and
                          op.opr_vid3 = substr(kl.txt64,1,3) and
                          substr(kl.d050,1,1) = '3') )

       loop

             tk_:=k.tk;

             if k.tk='2'  then
                tk_:='3';
             elsif k.tk='3'  then
                tk_:='2';
             elsif k.tk in ('4', '5')  then
                tk_:='1';
             end if;

             kol_:=0;

             nls_ := trim(k.nls);
             kv_  := trim(k.kv);
             p_nbuc_;

             IF (mfo_=300120 and k.branch_id=branch_id_) or
                (mfo_ not in (300120)) THEN

                zzzzz_ := k.zzzzz;

                insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                    VALUES
                    (k.nls, k.kv, k.dat, '102'||zzzzz_||tk_, to_char(k.s), nbuc_);
                insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                    VALUES
                    (k.nls, k.kv, k.dat, '302'||zzzzz_||tk_, '1', nbuc_);
             END IF;

             nbuc_ := nbuc1_;
      end loop;
   end if;

   if dat_ > to_date('30082011','ddmmyyyy') then
      -- ��� 02
      for k in ( select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                         op.branch_id BRANCH_ID,
                         nvl(op.kl_date,op.kl_date_branch_id) DAT,
                         kl.d050 ZZZZZ, op.opr_sumg S,
                         p.cl_stp TK, p.doc_nm_r NDR
                  from finmon.oper op, finmon.person_oper po, finmon.person p,
                       kl_d050 kl
                  where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
                    and op.mod_date is null
                    and op.file_id is not null
                    and op.id=po.oper_id
                    and op.status IN (2,4)
                    and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
                    and po.cl_type='1'
                    and po.person_id=p.id
                    and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
                    and p.cl_stp in ('1','2','3','4','5')
                    -----------------------------------------
                    and ((op.opr_vid2 is null or op.opr_vid2 = '0000') and
                          substr(op.opr_vid1,15,1) <> '2' and
                          op.opr_vid3 = substr(kl.txt64,1,3) and
                          substr(kl.d050,1,1) = '3' and
                          op.opr_vid3 = '603')
               )

       loop

             tk_:=k.tk;

             if k.tk='2'  then
                tk_:='3';
             elsif k.tk='3'  then
                tk_:='2';
             elsif k.tk in ('4', '5')  then
                tk_:='1';
             end if;

             kol_:=0;

             nls_ := trim(k.nls);
             kv_  := trim(k.kv);
             p_nbuc_;

             IF (mfo_=300120 and k.branch_id=branch_id_) or
                (mfo_ not in (300120)) THEN

                zzzzz_ := '00000';

                insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                    VALUES
                    (k.nls, k.kv, k.dat, '102'||zzzzz_||tk_, to_char(k.s), nbuc_);
                insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                    VALUES
                    (k.nls, k.kv, k.dat, '302'||zzzzz_||tk_, '1', nbuc_);
             END IF;

             nbuc_ := nbuc1_;
      end loop;
   end if;

   if dat_ <= to_date('30082011','ddmmyyyy') then
      -- ��� 03
      for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                       op.branch_id BRANCH_ID,
                       nvl(op.kl_date,op.kl_date_branch_id) DAT,
                       op.opr_sumg S,
                       p.cl_stp TK, p.doc_nm_r NDR
                from finmon.oper op, finmon.person_oper po, finmon.person p  --,
                where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
                  and op.file_id is not null
                  and op.status IN (2,4)
                  and op.terrorism is not null
                  and op.terrorism<>0
                  and op.id=po.oper_id
                  and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
                  and po.cl_type='1'
                  and po.person_id=p.id
                  and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
                  and p.cl_stp in ('1','2','3','4','5') )

          loop

                tk_:=k.tk;

                if k.tk='2'  then
                   tk_:='3';
                elsif k.tk='3'  then
                   tk_:='2';
                elsif k.tk in ('4', '5')  then
                   tk_:='1';
                end if;

                kol_:=0;

                nls_ := trim(k.nls);
                kv_  := trim(k.kv);
                p_nbuc_;

                IF (mfo_=300120 and k.branch_id=branch_id_) or
                   (mfo_ not in (300120)) THEN

                   insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                       VALUES
                       (k.nls, k.kv, k.dat, '10300000'||tk_, to_char(k.s), nbuc_);
                   insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                       VALUES
                       (k.nls, k.kv, k.dat, '30300000'||tk_, '1', nbuc_);
                END IF;

                nbuc_ := nbuc1_;
      end loop;

      -- ��� 04
      for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                       op.branch_id BRANCH_ID,
                       nvl(op.kl_date,op.kl_date_branch_id) DAT,
                       op.opr_sumg S,
                       p.cl_stp TK, p.doc_nm_r NDR
                from finmon.oper op, finmon.person_oper po, finmon.person p  --,
                where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
                  and op.file_id is not null
                  and op.status IN (2,4)
                  and op.opr_vid2=''  -- ?????
                  and op.id=po.oper_id
                  and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
                  and po.cl_type='1'
                  and po.person_id=p.id
                  and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
                  and p.cl_stp in ('1','2','3','4','5') )

          loop

                tk_:=k.tk;

                if k.tk='2'  then
                   tk_:='3';
                elsif k.tk='3'  then
                   tk_:='2';
                elsif k.tk in ('4', '5')  then
                   tk_:='1';
                end if;

                kol_:=0;

                nls_ := trim(k.nls);
                kv_  := trim(k.kv);
                p_nbuc_;

                IF (mfo_=300120 and k.branch_id=branch_id_) or
                   (mfo_ not in (300120)) THEN

                   insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                       VALUES
                       (k.nls, k.kv, k.dat, '10400000'||tk_, to_char(k.s), nbuc_);
                   insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                       VALUES
                       (k.nls, k.kv, k.dat, '30400000'||tk_, '1', nbuc_);
                END IF;

                nbuc_ := nbuc1_;
      end loop;

      -- ��� 05
      for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                       op.branch_id BRANCH_ID,
                       nvl(op.kl_date,op.kl_date_branch_id) DAT,
                       op.opr_sumg S,
                       p.cl_stp TK, p.doc_nm_r NDR
                from finmon.oper op, finmon.person_oper po, finmon.person p  --,
                where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
                  and op.file_id is not null
                  and op.status IN (2,4)
                  and (substr(op.opr_vid1,15,1)='2' and op.opr_vid3='900')
                  and op.id=po.oper_id
                  and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
                  and po.cl_type='1'
                  and po.person_id=p.id
                  and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
                  and p.cl_stp in ('1','2','3','4','5') )

          loop

                tk_:=k.tk;

                if k.tk='2'  then
                   tk_:='3';
                elsif k.tk='3'  then
                   tk_:='2';
                elsif k.tk in ('4', '5')  then
                   tk_:='1';
                end if;

                kol_:=0;

                nls_ := trim(k.nls);
                kv_  := trim(k.kv);
                p_nbuc_;

                IF (mfo_=300120 and k.branch_id=branch_id_) or
                   (mfo_ not in (300120)) THEN


                   insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                       VALUES
                       (k.nls, k.kv, k.dat, '30500000'||tk_, '1', nbuc_);
                END IF;

                nbuc_ := nbuc1_;
      end loop;

      -- ��� 06
      for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                       op.branch_id BRANCH_ID,
                       nvl(op.kl_date,op.kl_date_branch_id) DAT,
                       op.opr_sumg S,
                       p.cl_stp TK, p.doc_nm_r NDR
                from finmon.oper op, finmon.person_oper po, finmon.person p  --,
                where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
                  and op.status=-1
                  and op.id=po.oper_id
                  and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
                  and po.cl_type='1'
                  and po.person_id=p.id
                  and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
                  and p.cl_stp in ('1','2','3','4','5') )

          loop

                tk_:=k.tk;

                if k.tk='2'  then
                   tk_:='3';
                elsif k.tk='3'  then
                   tk_:='2';
                elsif k.tk in ('4', '5')  then
                   tk_:='1';
                end if;

                kol_:=0;

                nls_ := trim(k.nls);
                kv_  := trim(k.kv);
                p_nbuc_;

                IF (mfo_=300120 and k.branch_id=branch_id_) or
                   (mfo_ not in (300120)) THEN

                   insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                       VALUES
                       (k.nls, k.kv, k.dat, '10600000'||tk_, to_char(k.s), nbuc_);
                   insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                       VALUES
                       (k.nls, k.kv, k.dat, '30600000'||tk_, '1', nbuc_);
                END IF;

                nbuc_ := nbuc1_;
      end loop;
   else
      -- ��� 06 � ������� D050 (ZZZZZ)
      for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                       op.branch_id BRANCH_ID,
                       nvl(op.kl_date,op.kl_date_branch_id) DAT,
                       kl.d050 ZZZZZ, op.opr_sumg S,
                       p.cl_stp TK, p.doc_nm_r NDR
                from finmon.oper op, finmon.person_oper po, finmon.person p,
                     kl_d050 kl
                where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
                  and op.mod_date is null
                  and op.status=-1
                  and ((op.opr_vid2=substr(kl.txt64,1,4) and substr(kl.d050,1,1)='2') OR
                       ((op.opr_vid2 is null or op.opr_vid2='0000') and
                        substr(op.opr_vid1,15,1)<>'2' and
                        op.opr_vid3=substr(kl.txt64,1,3) and
                        substr(kl.d050,1,1)='3'))
                  and op.id=po.oper_id
                  and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
                  and po.cl_type='1'
                  and po.person_id=p.id
                  and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
                  and p.cl_stp in ('1','2','3','4','5') )

          loop

                tk_:=k.tk;

                if k.tk='2'  then
                   tk_:='3';
                elsif k.tk='3'  then
                   tk_:='2';
                elsif k.tk in ('4', '5')  then
                   tk_:='1';
                end if;

                kol_:=0;

                nls_ := trim(k.nls);
                kv_  := trim(k.kv);
                p_nbuc_;

                IF (mfo_=300120 and k.branch_id=branch_id_) or
                   (mfo_ not in (300120)) THEN

                   insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                       VALUES
                       (k.nls, k.kv, k.dat, '106'||k.zzzzz||tk_, to_char(k.s), nbuc_);
                   insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                       VALUES
                       (k.nls, k.kv, k.dat, '306'||k.zzzzz||tk_, '1', nbuc_);
             END IF;

             nbuc_ := nbuc1_;
      end loop;
   end if;

   -- ��� 07
   for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                    op.branch_id BRANCH_ID,
                    nvl(op.kl_date,op.kl_date_branch_id) DAT,
                    op.opr_sumg S,
                    p.cl_stp TK, p.doc_nm_r NDR
             from finmon.oper op, finmon.person_oper po, finmon.person p
             where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
               and op.mod_date is not null  --ing                                                    
               and op.id=po.oper_id
               and op.file_id is not null
               and op.opr_act =3 --ing
               and op.mod_id is not null --ing
               and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
               and po.cl_type='1'
               and po.person_id=p.id
               and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
               and p.cl_stp in ('1','2','3','4','5')  )

       loop

             tk_:=k.tk;

             if k.tk='2'  then
                tk_:='3';
             elsif k.tk='3'  then
                tk_:='2';
             elsif k.tk in ('4', '5')  then
                tk_:='1';
             end if;

             kol_:=0;

             nls_ := trim(k.nls);
             kv_  := trim(k.kv);
             p_nbuc_;

             IF (mfo_=300120 and k.branch_id=branch_id_) or
                (mfo_ not in (300120)) THEN

                insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                    VALUES
                    (k.nls, k.kv, k.dat, '10700000'||tk_, to_char(k.s), nbuc_);
                insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                    VALUES
                    (k.nls, k.kv, k.dat, '30700000'||tk_, '1', nbuc_);
             END IF;

             nbuc_ := nbuc1_;
   end loop;

   if dat_ <= to_date('30082011','ddmmyyyy') then

      -- ��� 08
      for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                    op.branch_id BRANCH_ID,
                    nvl(op.kl_date,op.kl_date_branch_id) DAT,
                    op.opr_sumg S,
                    p.cl_stp TK, p.doc_nm_r NDR
             from finmon.oper op, finmon.person_oper po, finmon.person p,
                  finmon.request r
             where trunc(r.in_date)  between Dat1_ and Dat_
               and op.kl_id=r.kl_id
               and op.kl_date=r.kl_date
               and r.file_i_id is not null
               and op.status IN (2,4)
               and op.id=po.oper_id
               and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
               and po.cl_type='1'
               and po.person_id=p.id
               and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
               and p.cl_stp in ('1','2','3','4','5') )

       loop

             tk_:=k.tk;

             if k.tk='2'  then
                tk_:='3';
             elsif k.tk='3'  then
                tk_:='2';
             elsif k.tk in ('4', '5')  then
                tk_:='1';
             end if;

             kol_:=0;

             nls_ := trim(k.nls);
             kv_  := trim(k.kv);
             p_nbuc_;

             IF (mfo_=300120 and k.branch_id=branch_id_) or
                (mfo_ not in (300120)) THEN

                insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                    VALUES
                    (k.nls, k.kv, k.dat, '10800000'||tk_, to_char(k.s), nbuc_);
                insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                    VALUES
                    (k.nls, k.kv, k.dat, '30800000'||tk_, '1', nbuc_);
             END IF;

             nbuc_ := nbuc1_;
      end loop;

      -- ��� 09
      for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                    op.branch_id BRANCH_ID,
                    nvl(op.kl_date,op.kl_date_branch_id) DAT,
                    op.opr_sumg S,
                    p.cl_stp TK, p.doc_nm_r NDR
             from finmon.oper op, finmon.person_oper po, finmon.person p,
                  finmon.request r, finmon.file_out f
             where op.kl_id=r.kl_id  -- ������� ������ �� �������� �� ���� ������� ������� - ������ ���
               and f.id=r.dfile_id and trunc(f.out_date) between Dat1_ and Dat_
               and op.kl_date=r.kl_date
               and r.file_o_id is not null
               and r.status in (2,4)
               and op.status IN (2,4)
               and op.id=po.oper_id
               and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
               and po.cl_type='1'
               and po.person_id=p.id
               and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
               and p.cl_stp in ('1','2','3','4','5') )

       loop

             tk_:=k.tk;

             if k.tk='2'  then
                tk_:='3';
             elsif k.tk='3'  then
                tk_:='2';
             elsif k.tk in ('4', '5')  then
                tk_:='1';
             end if;

             kol_:=0;

             nls_ := trim(k.nls);
             kv_  := trim(k.kv);
             p_nbuc_;

             IF (mfo_=300120 and k.branch_id=branch_id_) or
                (mfo_ not in (300120)) THEN

                insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                    VALUES
                    (k.nls, k.kv, k.dat, '10900000'||tk_, to_char(k.s), nbuc_);
                insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                    VALUES
                    (k.nls, k.kv, k.dat, '30900000'||tk_, '1', nbuc_);
             END IF;

             nbuc_ := nbuc1_;
      end loop;

      -- ����� ���� "11","91" ����������� �� 01.09.2008
      if dat_ >= to_date('01092008','ddmmyyyy') then

         -- ��� 11
         for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                       op.branch_id BRANCH_ID,
                       nvl(op.kl_date,op.kl_date_branch_id) DAT,
                       op.opr_sumg S,
                       p.cl_stp TK, p.doc_nm_r NDR
                from finmon.oper op, finmon.person_oper po, finmon.person p
                where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
                  and op.id=po.oper_id
                  and op.status<>3
                  and op.dropped=1  -- ������i� ���������i � ������
                  and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
                  and po.cl_type='1'
                  and po.person_id=p.id
                  and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
                  and p.cl_stp in ('1','2','3','4','5') )
          loop

             tk_:=k.tk;

             if k.tk='2'  then
                tk_:='3';
             elsif k.tk='3'  then
                tk_:='2';
             elsif k.tk in ('4', '5')  then
                tk_:='1';
             end if;

             kol_:=0;

             nls_ := trim(k.nls);
             kv_  := trim(k.kv);
             p_nbuc_;

             IF (mfo_=300120 and k.branch_id=branch_id_) or
                (mfo_ not in (300120)) THEN

                insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                       VALUES
                       (k.nls, k.kv, k.dat, '11100000'||tk_, to_char(k.s), nbuc_);
                insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                       VALUES
                       (k.nls, k.kv, k.dat, '31100000'||tk_, '1', nbuc_);
             END IF;

             nbuc_ := nbuc1_;
         end loop;

         -- ��� 91
         for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                       op.branch_id BRANCH_ID,
                       nvl(op.kl_date,op.kl_date_branch_id) DAT,
                       op.opr_sumg S,
                       p.cl_stp TK, p.doc_nm_r NDR
                from finmon.oper op, finmon.person_oper po, finmon.person p
                where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
                  and op.id=po.oper_id
                  and op.status=4
                  and op.dropped=1  -- ������i� ���������i � ������
                  and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
                  and po.cl_type='1'
                  and po.person_id=p.id
                  and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
                  and p.cl_stp in ('1','2','3','4','5') )
          loop

             tk_:=k.tk;

             if k.tk='2'  then
                tk_:='3';
             elsif k.tk='3'  then
                tk_:='2';
             elsif k.tk in ('4', '5')  then
                tk_:='1';
             end if;

             kol_:=0;

             nls_ := trim(k.nls);
             kv_  := trim(k.kv);
             p_nbuc_;

             IF (mfo_=300120 and k.branch_id=branch_id_) or
                (mfo_ not in (300120)) THEN

                insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                       VALUES
                       (k.nls, k.kv, k.dat, '19100000'||tk_, to_char(k.s), nbuc_);
                insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                       VALUES
                       (k.nls, k.kv, k.dat, '39100000'||tk_, '1', nbuc_);
             END IF;

             nbuc_ := nbuc1_;
         end loop;
      end if;
   end if;

if dat_ > to_date('30082011','ddmmyyyy') then
   -- ��� 10, 12
   for k in /*(select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                 op.branch_id BRANCH_ID, DECODE(op.opr_nbu,0,'10','12') DD,
                 nvl(op.kl_date,op.kl_date_branch_id) DAT,
                 kl.d050 ZZZZZ, op.opr_sumg S,
                 p.cl_stp TK, p.doc_nm_r NDR
          from finmon.oper op, finmon.person_oper po, finmon.person p,
               kl_d050 kl
          where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
            and op.mod_date is null
            --and op.file_id is not null
            and op.status in (2,4)  --> 0
            and (op.opr_vid2=substr(kl.txt64,1,4) and substr(kl.d050,1,1)='2')
            and op.id=po.oper_id
            and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
            and po.cl_type='1'
            and po.person_id=p.id
            and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
            and p.cl_stp in ('1','2','3','4','5')
          UNION ALL
          select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                 op.branch_id BRANCH_ID, DECODE(op.opr_nbu,0,'10','12') DD,
                 nvl(op.kl_date,op.kl_date_branch_id) DAT,
                 kl.d050 ZZZZZ, op.opr_sumg S,
                 p.cl_stp TK, p.doc_nm_r NDR
          from finmon.oper op, finmon.person_oper po, finmon.person p,
               kl_d050 kl
          where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
            and op.status in (2,4)  --> 0
            and ((op.opr_vid2 is null or op.opr_vid2='0000') and
                  substr(op.opr_vid1,15,1)<>'2' and
                  op.opr_vid3=substr(kl.txt64,1,3) and
                  substr(kl.d050,1,1)='3' --and
                  --op.opr_vid3 not in ('603','604','605','606')
                )
            and op.id=po.oper_id
            and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
            and po.cl_type='1'
            and po.person_id=p.id
            and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
            and p.cl_stp in ('1','2','3','4','5') )*/
-------------------------------------------------------------------------------------------
            (select     substr(trim(po.account),1,15)      NLS, 
                       op.opr_val                          KV,
                       op.branch_id                        BRANCH_ID, 
                       DECODE(op.opr_nbu,0,'10','12')      DD,
                       nvl(op.kl_date,op.kl_date_branch_id)DAT,
                       kl.d050                             ZZZZZ, 
                       op.opr_sumg                         S,
                       p.cl_stp                            TK, 
                       p.doc_nm_r                          NDR
            from       finmon.file_out                     fo,
                       finmon.oper                         op, 
                       finmon.person_oper                  po, 
                       finmon.person                       p,
                       kl_d050                             kl
            where      fo.id = op.file_id
            and        fo.in_date between Dat1_ and Dat_ -- ing 04/11/2011 ������ ����������� ��������, �� ������� � �������� ������ ���������� �� � �� ������� ������ �� � �������� ������ ������. (����������� ������� � ���, ��� � �������� ������� �������� ����� ���� ������� � ������, � ����� �� ��� ���������� � ��������� ������ ��� �� ����� ���������� � ��������� ���� ������ ������� � �� ������ �� ��������� ���� (������ ���� ���������� ������). ����� �������� ������ ����������� � ��������� ������
            and        op.kl_date between Dat1_-30 and Dat_--ing -30 ��� ����, ����� ��������� ������� �������� ������, �� ������� �������� ����� ������ ������ � ��������
            and        op.id=po.oper_id
            and        po.person_id=p.id
            and        op.file_id is not null
            and        fo.out_name like 'XA%'
            and        nvl(fo.err_code,'0') = '0000'
            and        op.mod_date is null
            and        op.status in (2,4)  --> 0
            and        (op.opr_vid2=substr(kl.txt64,1,4) 
            and        substr(kl.d050,1,1)='2')
            and        NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
            and        po.cl_type='1'
            and        NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
            and        p.cl_stp in ('1','2','3','4','5'))
            
    loop

          tk_:=k.tk;

          if k.tk='2'  then
             tk_:='3';
          elsif k.tk='3'  then
             tk_:='2';
          elsif k.tk in ('4', '5')  then
             tk_:='1';
          end if;

          kol_:=0;

          nls_ := trim(k.nls);
          kv_  := trim(k.kv);
          p_nbuc_;

          IF (mfo_=300120 and k.branch_id=branch_id_) or
             (mfo_ not in (300120)) THEN

             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                 VALUES
                 (k.nls, k.kv, k.dat, '1'||k.dd||k.zzzzz||tk_, to_char(k.s), nbuc_);
             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                 VALUES
                 (k.nls, k.kv, k.dat, '3'||k.dd||k.zzzzz||tk_, '1', nbuc_);
          END IF;

          nbuc_ := nbuc1_;
   end loop;

end if;

-- ��� 13
if dat_ > to_date('30082011','ddmmyyyy') then

   for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                 op.branch_id BRANCH_ID,
                 nvl(op.kl_date,op.kl_date_branch_id) DAT,
                 op.opr_sumg S,
                 p.cl_stp TK, p.doc_nm_r NDR
          from finmon.oper op, finmon.person_oper po, finmon.person p
          where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
            and op.mod_date is null
            and op.status >= 0
            and ((op.terrorism is not null and op.terrorism <> 0) OR (op.opr_terror in (2,3)))
            and op.id=po.oper_id
            and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
            and po.cl_type='1'
            and po.person_id=p.id
            and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
            and p.cl_stp in ('1','2','3','4','5') )

    loop

          tk_:=k.tk;

          if k.tk='2'  then
             tk_:='3';
          elsif k.tk='3'  then
             tk_:='2';
          elsif k.tk in ('4', '5')  then
             tk_:='1';
          end if;

          kol_:=0;

          nls_ := trim(k.nls);
          kv_  := trim(k.kv);
          p_nbuc_;

          IF (mfo_=300120 and k.branch_id=branch_id_) or
             (mfo_ not in (300120)) THEN


             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                 VALUES
                 (k.nls, k.kv, k.dat, '11300000'||tk_, to_char(k.s), nbuc_);
             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                 VALUES
                 (k.nls, k.kv, k.dat, '31300000'||tk_, '1', nbuc_);
          END IF;

          nbuc_ := nbuc1_;
   end loop;

end if;

if dat_ > to_date('30082011','ddmmyyyy') then

   -- ��� 14   (������� K_DFM10 - ���� �������i�)
   for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                 op.branch_id BRANCH_ID,
                 nvl(op.kl_date,op.kl_date_branch_id) DAT,
                 kl.d050 ZZZZZ, op.opr_sumg S,
                 p.cl_stp TK, p.doc_nm_r NDR
          from finmon.oper op, finmon.person_oper po, finmon.person p,
               kl_d050 kl
          where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
            and op.mod_date is null
            and op.status <> 3
            and op.opr_ozn in (4,5,6,7)  -- ������i� �������i
            and ((op.opr_vid2=substr(kl.txt64,1,4) and substr(kl.d050,1,1)='2') OR
                 ((op.opr_vid2 is null or op.opr_vid2='0000') and
                  substr(op.opr_vid1,15,1)<>'2' and
                  op.opr_vid3=substr(kl.txt64,1,3) and
                  substr(kl.d050,1,1)='3'))
            and op.id=po.oper_id
            and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
            and po.cl_type='1'
            and po.person_id=p.id
            and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
            and p.cl_stp in ('1','2','3','4','5') )

    loop

          tk_:=k.tk;

          if k.tk='2'  then
             tk_:='3';
          elsif k.tk='3'  then
             tk_:='2';
          elsif k.tk in ('4', '5')  then
             tk_:='1';
          end if;

          kol_:=0;

          nls_ := trim(k.nls);
          kv_  := trim(k.kv);
          p_nbuc_;

          IF (mfo_=300120 and k.branch_id=branch_id_) or
             (mfo_ not in (300120)) THEN

             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                 VALUES
                 (k.nls, k.kv, k.dat, '114'||k.zzzzz||tk_, to_char(k.s), nbuc_);
             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                 VALUES
                 (k.nls, k.kv, k.dat, '314'||k.zzzzz||tk_, '1', nbuc_);
          END IF;

          nbuc_ := nbuc1_;
   end loop;
end if;

if dat_ > to_date('30082011','ddmmyyyy') then

   -- ��� 15   (������� K_DFM10 - ���� �������i�)
   for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                 op.branch_id BRANCH_ID,
                 nvl(op.kl_date,op.kl_date_branch_id) DAT,
                 kl.d050 ZZZZZ, op.opr_sumg S,
                 p.cl_stp TK, p.doc_nm_r NDR
          from finmon.oper op, finmon.person_oper po, finmon.person p,
               kl_d050 kl
          where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
            and op.mod_date is null
            and op.status <> 3
            and op.opr_ozn=2  -- ������i� �� ��i������ � ������ � ������������ ���������� i������i���i�
            and op.id=po.oper_id
            and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
            and po.cl_type='1'
            and po.person_id=p.id
            and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
            and p.cl_stp in ('1','2','3','4','5') )

    loop

          tk_:=k.tk;

          if k.tk='2'  then
             tk_:='3';
          elsif k.tk='3'  then
             tk_:='2';
          elsif k.tk in ('4', '5')  then
             tk_:='1';
          end if;

          kol_:=0;

          nls_ := trim(k.nls);
          kv_  := trim(k.kv);
          p_nbuc_;

          IF (mfo_=300120 and k.branch_id=branch_id_) or
             (mfo_ not in (300120)) THEN

             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                 VALUES
                 (k.nls, k.kv, k.dat, '115'||'00000'||tk_, to_char(k.s), nbuc_);
             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                 VALUES
                 (k.nls, k.kv, k.dat, '315'||'00000'||tk_, '1', nbuc_);
          END IF;

          nbuc_ := nbuc1_;
   end loop;
end if;

if dat_ > to_date('30082011','ddmmyyyy') then

   -- ��� 17   (������� K_DFM10 - ���� �������i�)
   for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                 op.branch_id BRANCH_ID,
                 nvl(op.kl_date,op.kl_date_branch_id) DAT,
                 kl.d050 ZZZZZ, op.opr_sumg S,
                 p.cl_stp TK, p.doc_nm_r NDR
          from finmon.oper op, finmon.person_oper po, finmon.person p,
               kl_d050 kl
          where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
            and op.mod_date is null
            and op.status <> 3
            and ((op.opr_vid2=substr(kl.txt64,1,4) and substr(kl.d050,1,1)='2') OR
                 ((op.opr_vid2 is null or op.opr_vid2='0000') and
                   substr(op.opr_vid1,15,1)<>'2' and
                   op.opr_vid3=substr(kl.txt64,1,3) and
                   substr(kl.d050,1,1)='3'))
            and op.opr_ozn=5  -- ������i� �������� � ������ � ��� �� �?����� ������ ����������? �������� 15,16
            and op.id=po.oper_id
            and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
            and po.cl_type='1'
            and po.person_id=p.id
            and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
            and p.cl_stp in ('1','2','3','4','5') )

    loop

          tk_:=k.tk;

          if k.tk='2'  then
             tk_:='3';
          elsif k.tk='3'  then
             tk_:='2';
          elsif k.tk in ('4', '5')  then
             tk_:='1';
          end if;

          kol_:=0;

          nls_ := trim(k.nls);
          kv_  := trim(k.kv);
          p_nbuc_;

          IF (mfo_=300120 and k.branch_id=branch_id_) or
             (mfo_ not in (300120)) THEN

             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                 VALUES
                 (k.nls, k.kv, k.dat, '117'||k.zzzzz||tk_, to_char(k.s), nbuc_);
             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                 VALUES
                 (k.nls, k.kv, k.dat, '317'||k.zzzzz||tk_, '1', nbuc_);
          END IF;

          nbuc_ := nbuc1_;
   end loop;
end if;

if dat_ > to_date('30082011','ddmmyyyy') then

   -- ��� 18   (������� K_DFM10 - ���� �������i�)
   for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                 op.branch_id BRANCH_ID,
                 nvl(op.kl_date,op.kl_date_branch_id) DAT,
                 op.opr_sumg S,
                 p.cl_stp TK, p.doc_nm_r NDR
          from finmon.oper op, finmon.person_oper po, finmon.person p
          where NVL(op.kl_date,op.kl_date_branch_id) between Dat1_ and Dat_
            and op.mod_date is null
            and op.status <> 3
            and op.opr_ozn=4  -- ������i� �������� � ������ � ��� �� �� ���������� ��� ������������������ � �����
            and op.id=po.oper_id
            and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
            and po.cl_type='1'
            and po.person_id=p.id
            and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
            and p.cl_stp in ('1','2','3','4','5') )

    loop

          tk_:=k.tk;

          if k.tk='2'  then
             tk_:='3';
          elsif k.tk='3'  then
             tk_:='2';
          elsif k.tk in ('4', '5')  then
             tk_:='1';
          end if;

          kol_:=0;

          nls_ := trim(k.nls);
          kv_  := trim(k.kv);
          p_nbuc_;

          IF (mfo_=300120 and k.branch_id=branch_id_) or
             (mfo_ not in (300120)) THEN

             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                 VALUES
                 (k.nls, k.kv, k.dat, '118'||'00000'||tk_, to_char(k.s), nbuc_);
             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                 VALUES
                 (k.nls, k.kv, k.dat, '318'||'00000'||tk_, '1', nbuc_);
          END IF;

          nbuc_ := nbuc1_;
   end loop;
end if;

if dat_ > to_date('30082011','ddmmyyyy') then

   -- ���� 20,21,23,24,25,26
   for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                 op.branch_id BRANCH_ID,
                 nvl(op.kl_date,op.kl_date_branch_id) DAT,
                 r.ri_vid RI_VID, op.opr_sumg S,
                 p.cl_stp TK, p.doc_nm_r NDR, p.cl_id CL_ID
          from finmon.oper op, finmon.person_oper po, finmon.person p,
               finmon.decision r
          where trunc(r.in_date)  between Dat1_ and Dat_
            and op.mod_date is null
            and op.ri_numb=r.ri_numb
            and op.kl_date=r.kl_date
            and r.file_i_id is not null
            and op.status IN (2,4)
            and op.id=po.oper_id
            and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
            and po.cl_type='1'
            and po.person_id=p.id
            and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
            and p.cl_stp in ('1','2','3','4','5') )

    loop

          tk_:=k.tk;

          if k.tk='2'  then
             tk_:='3';
          elsif k.tk='3'  then
             tk_:='2';
          elsif k.tk in ('4', '5')  then
             tk_:='1';
          end if;

          kol_:=0;

          nls_ := trim(k.nls);
          kv_  := trim(k.kv);
          p_nbuc_;

          if k.ri_vid=11 then
             dd_ := '20';
          elsif k.ri_vid='31' then
             dd_ := '21';
          elsif k.ri_vid='21' then
             dd_ := '23';
          elsif k.ri_vid='33' then
             dd_ := '24';
          elsif k.ri_vid='32' then
             dd_ := '25';
          else
             null;
          end if;


          IF (mfo_=300120 and k.branch_id=branch_id_) or
             (mfo_ not in (300120)) THEN

             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc, comm)
                 VALUES
                 (k.nls, k.kv, k.dat, '1'||dd_||'00000'||tk_, to_char(k.s), nbuc_, k.cl_id);
             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc, comm)
                 VALUES
                 (k.nls, k.kv, k.dat, '3'||dd_||'00000'||tk_, '1', nbuc_, k.cl_id);
          END IF;

          nbuc_ := nbuc1_;
   end loop;

end if;

if dat_ > to_date('30082011','ddmmyyyy') then
   -- ��� 32 34 
   for k in ( select          
              substr(trim(po.account),1,15)        NLS, 
              op.opr_val                           KV,
              /*op.branch_id*/ 1                   BRANCH_ID,
              nvl(op.kl_date,op.kl_date_branch_id) DAT,
              r.zap_type                           ZAP_TYPE, 
              op.opr_sumg                          S,
              p.cl_stp                             TK, 
              p.doc_nm_r                           NDR, 
              p.cl_id                              CL_ID 
            from  finmon.oper         op, 
                  finmon.person_oper  po, 
                  finmon.person       p,
                  finmon.request      r 
            where trunc(r.in_date) between Dat1_ and Dat_ -- ������ 
              and r.kl_id=op.kl_id_branch_id -- op.kl_id=r.kl_id ing 04/11/2011 ���� ������ �� op.kl_id - �� ����������� ������
              and r.kl_date=op.kl_date_branch_id -- op.kl_date=r.kl_date ing 04/11/2011 ���� ������ �� op.kl_date - �� ����������� ������
              and op.id=po.oper_id
              and po.person_id=p.id
              and op.mod_date is null
              and r.file_o_id is not null
              and op.status IN (2,4)
              and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
              and po.cl_type='1'
              and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
              and p.cl_stp in ('1','2','3','4','5') 
           )

    loop

          tk_:=k.tk;

          if k.tk='2'  then
             tk_:='3';
          elsif k.tk='3'  then
             tk_:='2';
          elsif k.tk in ('4', '5')  then
             tk_:='1';
          end if;

          kol_:=0;

          nls_ := trim(k.nls);
          kv_  := trim(k.kv); 
          p_nbuc_;

          if k.zap_type in (0,2) then
             dd_ := '32';
          elsif k.zap_type=1 then
             dd_ := '34';
          --elsif k.zap_type=2 then
          --   dd_ := '36';
          else
             null;
          end if;

          IF (mfo_=300120 and k.branch_id=branch_id_) or
             (mfo_ not in (300120)) THEN

             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc, comm)
                 VALUES
                 (k.nls, k.kv, k.dat, '1'||dd_||'00000'||tk_, to_char(k.s), nbuc_, k.cl_id);
             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc, comm)
                 VALUES
                 (k.nls, k.kv, k.dat, '3'||dd_||'00000'||tk_, '1', nbuc_, k.cl_id);
          END IF;

          nbuc_ := nbuc1_;
   end loop;

end if;

if dat_ > to_date('30082011','ddmmyyyy') then
   -- ��� 36 
   for k in /*(select substr(trim(r.id),1,15) NLS, 0 KV,
                 nvl(r.zap_date,r.in_date) DAT,
                 r.zap_type ZAP_TYPE, 0 S,
                 '2' TK, '0' NDR, '0' CL_ID 
          from  finmon.request r 
          where trunc(r.in_date)  between Dat1_ and Dat_ -- ������ 
          and r.kl_id is null 
          and r.kl_date is null  )      */       --ing 04/11/2011 �� ������� ���������� ������ ��, � ������ �����\
          (select distinct
                 fi.in_name NLS, 0 KV,
                 nvl(r.zap_date,r.in_date) DAT,
                 r.zap_type ZAP_TYPE, 0 S,
                 '2' TK, '0' NDR, '0' CL_ID 
          from  finmon.request r , 
                finmon.file_in fi
          where trunc(r.in_date)  between Dat1_ and Dat_ -- ������ 
          and   r.file_i_id = fi.id         
          )     

    loop

          tk_:=k.tk;

          if k.tk='2'  then
             tk_:='3';
          elsif k.tk='3'  then
             tk_:='2';
          elsif k.tk in ('4', '5')  then
             tk_:='1';
          end if;

          kol_:=0;

          nls_ := trim(k.nls);
          kv_  := trim(k.kv); 
          p_nbuc_;

          dd_ := '36';

          --insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc, comm)
          --    VALUES
          --    (k.nls, k.kv, k.dat, '1'||dd_||'00000'||tk_, to_char(k.s), nbuc1_, k.nls);   --ing 04/11/2011 ��� 136 �� ��������
          insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc, comm)
              VALUES
              (k.nls, k.kv, k.dat, '3'||dd_||'00000'||tk_, '1', nbuc1_, k.nls);

          nbuc_ := nbuc1_;
   end loop;

end if;

if dat_ > to_date('30082011','ddmmyyyy') then

   -- ��� 29
   for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                 op.branch_id BRANCH_ID,
                 nvl(op.kl_date,op.kl_date_branch_id) DAT,
                 r.zap_type ZAP_TYPE, op.opr_sumg S,
                 p.cl_stp TK, p.doc_nm_r NDR
          from finmon.oper op, finmon.person_oper po, finmon.person p,
               finmon.request r   --,
          where trunc(r.in_date)  between Dat1_ and Dat_
            and op.mod_date is null
            and op.dfile_id is not null
            and op.kl_id=r.kl_id
            and op.kl_date=r.kl_date
            and r.file_i_id is not null
            and r.zap_type  = 1
            and op.status IN (2,4)
            and op.opr_vid2=''  -- ?????
            and op.id=po.oper_id
            and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
            and po.cl_type='1'
            and po.person_id=p.id
            and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
            and p.cl_stp in ('1','2','3','4','5') )

    loop

          tk_:=k.tk;

          if k.tk='2'  then
             tk_:='3';
          elsif k.tk='3'  then
             tk_:='2';
          elsif k.tk in ('4', '5')  then
             tk_:='1';
          end if;

          kol_:=0;

          nls_ := trim(k.nls);
          kv_  := trim(k.kv); 
          p_nbuc_;

          dd_ := '29';

          IF (mfo_=300120 and k.branch_id=branch_id_) or
             (mfo_ not in (300120)) THEN

             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                 VALUES
                 (k.nls, k.kv, k.dat, '1'||dd_||'00000'||tk_, to_char(k.s), nbuc_);
             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                 VALUES
                 (k.nls, k.kv, k.dat, '3'||dd_||'00000'||tk_, '1', nbuc_);
          END IF;

          nbuc_ := nbuc1_;
  end loop;

  -- ��� 30
  for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                 op.branch_id BRANCH_ID,
                 nvl(op.kl_date,op.kl_date_branch_id) DAT,
                 r.zap_type ZAP_TYPE, op.opr_sumg S,
                 p.cl_stp TK, p.doc_nm_r NDR
          from finmon.oper op, finmon.person_oper po, finmon.person p,
               finmon.request r   
          where trunc(r.in_date)  between Dat1_ and Dat_
            and op.mod_date is null
            and op.dfile_id is not null
            and op.kl_id=r.kl_id
            and op.kl_date=r.kl_date
            and r.file_i_id is not null
            and r.zap_type  = 1
            and op.status IN (2,4)
            and op.opr_vid2 <> ''  -- ?????
            and op.id=po.oper_id
            and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
            and po.cl_type='1'
            and po.person_id=p.id
            and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
            and p.cl_stp in ('1','2','3','4','5') )

    loop

          tk_:=k.tk;

          if k.tk='2'  then
             tk_:='3';
          elsif k.tk='3'  then
             tk_:='2';
          elsif k.tk in ('4', '5')  then
             tk_:='1';
          end if;

          kol_:=0;

          nls_ := trim(k.nls);
          kv_  := trim(k.kv); 
          p_nbuc_;

          dd_ := '30';

          IF (mfo_=300120 and k.branch_id=branch_id_) or
             (mfo_ not in (300120)) THEN

             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                 VALUES
                 (k.nls, k.kv, k.dat, '1'||dd_||'00000'||tk_, to_char(k.s), nbuc_);
             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                 VALUES
                 (k.nls, k.kv, k.dat, '3'||dd_||'00000'||tk_, '1', nbuc_);
          END IF;

          nbuc_ := nbuc1_;
   end loop;

end if;

/* �������� ���� ������� "����������� (����������)"
if dat_ > to_date('30082011','ddmmyyyy') then

-- ��� 31
for k in (select substr(trim(po.account),1,15) NLS, op.opr_val KV,
                 op.branch_id BRANCH_ID,
                 nvl(op.kl_date,op.kl_date_branch_id) DAT,
                 op.opr_sumg S,
                 p.cl_stp TK, p.doc_nm_r NDR, p.cl_id CL_ID
          from finmon.oper op, finmon.person_oper po, finmon.person p,
               finmon.request r   
          where trunc(r.in_date)  between Dat1_ and Dat_
            and op.kl_id=r.kl_id
            and op.kl_date=r.kl_date
            and r.file_i_id is not null
            and op.status IN (2,4)
            and op.id=po.oper_id
            and NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
            and po.cl_type='1'
            and po.person_id=p.id
            and NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
            and p.cl_stp in ('1','2','3','4','5') )

    loop

          tk_:=k.tk;

          if k.tk='2'  then
             tk_:='3';
          elsif k.tk='3'  then
             tk_:='2';
          elsif k.tk in ('4', '5')  then
             tk_:='1';
          end if;

          kol_:=0;

          nls_ := trim(k.nls);
          kv_  := trim(k.kv); 
          p_nbuc_;

          IF (mfo_=300120 and k.branch_id=branch_id_) or
             (mfo_ not in (300120)) THEN

             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc, comm)
                 VALUES
                 (k.nls, k.kv, k.dat, '33100000'||tk_, '1', nbuc_, k.cl_id);
          END IF;

          nbuc_ := nbuc1_;
   end loop;

end if;
*/

if dat_ > to_date('30082011','ddmmyyyy') then
   -- ��� 33, 35
   for k in ( select substr(trim(po.account),1,15)           NLS, 
                     op.opr_val                              KV,
                     /*op.branch_id*/ 1                      BRANCH_ID,
                     nvl(op.kl_date,op.kl_date_branch_id)    DAT,
                     r.zap_type                              ZAP_TYPE, 
                     op.opr_sumg                             S,
                     p.cl_stp                                TK, 
                     p.doc_nm_r                              NDR
              from   finmon.oper           op, 
                     finmon.person_oper    po, 
                     finmon.person         p,
                     finmon.request        r, 
                     finmon.file_out       f   
              where  op.kl_id_branch_id=r.kl_id -- ������� ������ �� �������� �� ���� ������� ������� - ������ ��� 
              --ing 04/11/2011 op.kl_id=r.kl_id �� ��������� �������� ���������
              and    op.mod_date is null
              and    f.id=r.dfile_id and trunc(f.out_date) between Dat1_ and Dat_
              and    op.kl_date_branch_id=r.kl_date 
              --ing 04/11/2011 op.kl_date=r.kl_date �� ��������� �������� ���������
              and    r.file_o_id is not null
              and    r.status in (2,4)
              and    op.status IN (2,4)
              and    op.id=po.oper_id
              and    NVL(op.branch_id,'0')=NVL(p.branch_id,'0')
              and    po.cl_type='1'
              and    po.person_id=p.id
              and    NVL(po.branch_id,'-1')=NVL(p.branch_id,'-1')
              and    p. cl_stp in ('1','2','3','4','5') 
            )

    loop

          tk_:=k.tk;

          if k.tk='2'  then
             tk_:='3';
          elsif k.tk='3'  then
             tk_:='2';
          elsif k.tk in ('4', '5')  then
             tk_:='1';
          end if;

          kol_:=0;

          nls_ := trim(k.nls);
          kv_  := trim(k.kv); 
          p_nbuc_;

          if k.zap_type in (0,2) then
             dd_ := '33';
          elsif k.zap_type=1 then
             dd_ := '35';
          --elsif k.zap_type=2 then
          --   dd_ := '37';
          else
             null;
          end if;

          IF (mfo_=300120 and k.branch_id=branch_id_) or
             (mfo_ not in (300120)) THEN

             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                 VALUES
                 (k.nls, k.kv, k.dat, '1'||dd_||'00000'||tk_, to_char(k.s), nbuc_);
             insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
                 VALUES
                 (k.nls, k.kv, k.dat, '3'||dd_||'00000'||tk_, '1', nbuc_);
          END IF;

          nbuc_ := nbuc1_;
   end loop;

end if;

if dat_ > to_date('30082011','ddmmyyyy') then
   -- ��� 37
   for k in
        --(select substr(trim(r.id),1,15) NLS, 0 KV,
        --         nvl(r.zap_date,r.in_date) DAT,
        --         r.zap_type ZAP_TYPE, 0 S,
        --         '2' TK, '0' NDR, '0' CL_ID
        --  from  finmon.request r, finmon.file_out f   
        --  where trunc(f.out_date) between Dat1_ and Dat_
        --    and f.id=r.dfile_id
        --    and r.file_o_id is not null
        --    and r.status >= 0 )      --���� -- �� ��������, �������� ��

          (select distinct f.out_name Nls, 0 kv, 
                 nvl(r.zap_date,r.in_date) DAT,
                 r.zap_type ZAP_TYPE, 0 S,
                 '2' TK, '0' NDR, '0' CL_ID
          from  finmon.request r, 
                finmon.file_out f   
          where trunc(f.out_date) between Dat1_ and Dat_
            and f.id=r.file_o_id
            and r.status >= 0
            and r.zap_type = 0 -- ing �������� ������ �� ����� ��������
          )  
            

    loop

          tk_:=k.tk;

          if k.tk='2'  then
             tk_:='3';
          elsif k.tk='3'  then
             tk_:='2';
          elsif k.tk in ('4', '5')  then
             tk_:='1';
          end if;

          kol_:=0;

          nls_ := trim(k.nls);
          kv_  := trim(k.kv); 
          --p_nbuc_;

          dd_ := '37';

          --insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
          --    VALUES
          --    (k.nls, k.kv, k.dat, '1'||dd_||'00000'||tk_, to_char(k.s), nbuc1_);  --ing ��� 137 �� ��������, ������ 337 04/11/2011
          insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
              VALUES
              (k.nls, k.kv, k.dat, '3'||dd_||'00000'||tk_, '1', nbuc1_);

   end loop;

end if;

-- ���? ���� 71-78
if dat_ > to_date('30082011','ddmmyyyy') then
   for k in (select distinct substr(kodp,2,2) DD, substr(kodp,9,1) TK, comm, nbuc
             from rnbu_trace 
             where kodp like '3%' 
               and substr(kodp,2,2) in ('20','21','23','24','27','31','32','34','36') )
      loop
         if k.dd = '20' then
            dd_ := '72';
         elsif k.dd='21' then
            dd_ := '73';
         elsif k.dd='23' then
            dd_ := '74';
         elsif k.dd='24' then
            dd_ := '75';
         elsif k.dd='31' then
            dd_ := '76';
         elsif k.dd='27' then
            dd_ := '77';
         elsif k.dd in ('32','34','36') then
            dd_ := '78';
         else
            null;
         end if;
   
         insert into bars.rnbu_trace (nls, kv, odate, kodp, znap, nbuc)
             VALUES
             (k.comm, 0, dat_, '3'||dd_||'00000'||k.tk, '1', k.nbuc);
   
      end loop;
end if;
---------------------------------------------------
DELETE FROM tmp_nbu where kodf=kodf_ and datf= dat_;
---------------------------------------------------
INSERT INTO tmp_nbu (kodp, datf, kodf, nbuc, znap)
   SELECT kodp, Dat_, kodf_, nbuc, SUM(to_number(znap))
   FROM rnbu_trace
   WHERE userid=userid_
   GROUP BY kodp, Dat_, kodf_, nbuc;

--- �������� ��������� �������� ���������� ��� ����������
--- ��� DD='01'

select count(*) INTO kol_
from tmp_nbu
where kodf=kodf_ and datf=Dat_ and substr(kodp,2,7)='0100000';

if kol_=0 then
   INSERT INTO tmp_nbu
   (kodp, datf, kodf, znap, nbuc)
   VALUES
   ('101000001',Dat_, kodf_, '0', nbuc_);
   INSERT INTO tmp_nbu
   (kodp, datf, kodf, znap, nbuc)
   VALUES
   ('301000001',Dat_, kodf_, '0', nbuc_);
   INSERT INTO tmp_nbu
   (kodp, datf, kodf, znap, nbuc)
   VALUES
   ('101000002',Dat_, kodf_, '0', nbuc_);
   INSERT INTO tmp_nbu
   (kodp, datf, kodf, znap, nbuc)
   VALUES
   ('301000002',Dat_, kodf_, '0', nbuc_);
   INSERT INTO tmp_nbu
   (kodp, datf, kodf, znap, nbuc)
   VALUES
   ('101000003',Dat_, kodf_, '0', nbuc_);
   INSERT INTO tmp_nbu
   (kodp, datf, kodf, znap, nbuc)
   VALUES
   ('301000003',Dat_, kodf_, '0', nbuc_);
end if;

if dat_ <= to_date('30082011','ddmmyyyy') then 
   --- ��� DD='02'
   select count(*) INTO kol_   
   from tmp_nbu
   where kodf=kodf_ and datf=Dat_ and substr(kodp,2,2)='02';

   if kol_=0 then
   
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('102ZZZZZ1',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('302ZZZZZ1',Dat_, kodf_, '0', nbuc_);
      
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('102ZZZZZ2',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('302ZZZZZ2',Dat_, kodf_, '0', nbuc_);
      
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('102ZZZZZ3',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('302ZZZZZ3',Dat_, kodf_, '0', nbuc_);
   end if;
end if;

if dat_ > to_date('30082011','ddmmyyyy') then 
   --- ��� DD='02'
   select count(*) INTO kol_
   from tmp_nbu
   where kodf=kodf_ and datf=Dat_ and substr(kodp,2,2)='02';
   
   if kol_=0 then
   
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('102000001',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('302000001',Dat_, kodf_, '0', nbuc_);
      
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('102000002',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('302000002',Dat_, kodf_, '0', nbuc_);
      
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('102000003',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('302000003',Dat_, kodf_, '0', nbuc_);
   end if;
end if;


if dat_ <= to_date('30082011','ddmmyyyy') then
   --- ��� DD='03'

   select count(*) INTO kol_
   from tmp_nbu
   where kodf=kodf_ and datf=Dat_ and substr(kodp,2,7)='0300000';

   if kol_=0 then

      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('103000001',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('303000001',Dat_, kodf_, '0', nbuc_);
   
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('103000002',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('303000002',Dat_, kodf_, '0', nbuc_);
   
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('103000003',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('303000003',Dat_, kodf_, '0', nbuc_);
   end if;

   --- ��� DD='04'
   select count(*) INTO kol_
   from tmp_nbu
   where kodf=kodf_ and datf=Dat_ and substr(kodp,2,7)='0400000';

   if kol_=0 then

      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('104000001',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('304000001',Dat_, kodf_, '0', nbuc_);
      
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('104000002',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('304000002',Dat_, kodf_, '0', nbuc_);
      
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('104000003',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('304000003',Dat_, kodf_, '0', nbuc_);
   end if;

   --- ��� DD='05'
   select count(*) INTO kol_
   from tmp_nbu
   where kodf=kodf_ and datf=Dat_ and substr(kodp,2,7)='0500000';

   if kol_=0 then

      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('305000001',Dat_, kodf_, '0', nbuc_);
   
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('305000002',Dat_, kodf_, '0', nbuc_);
   
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('305000003',Dat_, kodf_, '0', nbuc_);
   end if;   -- �?�� �� 31.08.2011
end if;
   
if dat_ <= to_date('30082011','ddmmyyyy') then
   --- ��� DD='06'
   select count(*) INTO kol_
   from tmp_nbu
   where kodf=kodf_ and datf=Dat_ and substr(kodp,2,7)='0600000';
   
   if kol_=0 then

      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('106000001',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('306000001',Dat_, kodf_, '0', nbuc_);
    
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('106000002',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('306000002',Dat_, kodf_, '0', nbuc_);
      
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('106000003',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('306000003',Dat_, kodf_, '0', nbuc_);
   end if;
end if;

--- ��� DD='07'
select count(*) INTO kol_
from tmp_nbu
where kodf=kodf_ and datf=Dat_ and substr(kodp,2,7)='0700000';

if kol_=0 then

   INSERT INTO tmp_nbu
   (kodp, datf, kodf, znap, nbuc)
   VALUES
   ('107000001',Dat_, kodf_, '0', nbuc_);
   INSERT INTO tmp_nbu
   (kodp, datf, kodf, znap, nbuc)
   VALUES
   ('307000001',Dat_, kodf_, '0', nbuc_);
   
   INSERT INTO tmp_nbu
   (kodp, datf, kodf, znap, nbuc)
   VALUES
   ('107000002',Dat_, kodf_, '0', nbuc_);
   INSERT INTO tmp_nbu
   (kodp, datf, kodf, znap, nbuc)
   VALUES
   ('307000002',Dat_, kodf_, '0', nbuc_);
   
   INSERT INTO tmp_nbu
   (kodp, datf, kodf, znap, nbuc)
   VALUES
   ('107000003',Dat_, kodf_, '0', nbuc_);
   INSERT INTO tmp_nbu
   (kodp, datf, kodf, znap, nbuc)
   VALUES
   ('307000003',Dat_, kodf_, '0', nbuc_);
end if;

if dat_ <= to_date('30082011','ddmmyyyy') then
   --- ��� DD='08'
   select count(*) INTO kol_
   from tmp_nbu
   where kodf=kodf_ and datf=Dat_ and substr(kodp,2,7)='0800000';

   if kol_=0 then

      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('108000001',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('308000001',Dat_, kodf_, '0', nbuc_);
      
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('108000002',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('308000002',Dat_, kodf_, '0', nbuc_);
      
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('108000003',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('308000003',Dat_, kodf_, '0', nbuc_);
   end if;

   --- ��� DD='09'
   select count(*) INTO kol_
   from tmp_nbu
   where kodf=kodf_ and datf=Dat_ and substr(kodp,2,7)='0900000';

   if kol_=0 then

      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('109000001',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('309000001',Dat_, kodf_, '0', nbuc_);
      
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('109000002',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('309000002',Dat_, kodf_, '0', nbuc_);
      
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('109000003',Dat_, kodf_, '0', nbuc_);
      INSERT INTO tmp_nbu
      (kodp, datf, kodf, znap, nbuc)
      VALUES
      ('309000003',Dat_, kodf_, '0', nbuc_);
   end if;
end if;  --���� �� 31.08.2011
----------------------------------------
END p_fd0_NN;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FD0_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
