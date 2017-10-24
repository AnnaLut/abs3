

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F27_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F27_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_F27_NN (Dat_ DATE ,
                                      sheme_ varchar2 default 'G')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	��������� ������������ #27 ��� �� (�������������)
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 30.05.2014 (10.04.2014,17.02.2014,14.02.2014,13.02.2014)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ���������: Dat_ - �������� ����
               sheme_ - ����� ������������
30.05.2014 - ��� mfou_=300465 � ���������� 7290900VVV ����� ��������
             �������� �� 2909 (OB22=55,56,75 ��������� �������� 55) �
             �� 2900 (OB22=01 ��� 2900 ����� OB22=04)
10.04.2014 - ��� 300465 �� 2900 �������� OB22 in ('01','04') ����� ����
             ������ '01' (��������� �� �����)
17.02.2014 - �������� �� 1919 �� 3800 ������ ��� 300465
             �������� �� 1919 �� 3640 ������ ��� 380764
14.02.2014 - ��� 380764 ������� ��������
             �� 1919  �� 2900 OB22 in ('02','08') (��������� �������)
13.02.2014 - ����� ���������� �������� �� 1919,2909 �� 2900,3800,3640
12.02.2014 - c 11.02.2014 ��������� ������������ ����� �����������
             7191900VVV, 7290900VVV
14.03.2013 - ���������� kl_f3_29 �� ������������, ������ ����������� ��
             ���� �������, ����� (980,958,961,962,964)
28.11.2012 - ������������� ������������ ���.�������� D#27 � ���� ��������
             01 �� ��������� ���������� 7BBBB00VVV
             (�� ������� �������������)
26.11.2012 - �_�������� ����� �� ����������� �������
23.11.2012 - ��� ��������� � ��� 7BBBB00VVV �������� ��������
             �� 2603  �� 2900 � OB22='04'
22.11.2012 - ��������� ������������ ���� 7BBBB00VVV ����'������� ������
19.09.2012 - �������������� ���������
� 01.03.2006 �������� �� D020 �� ������������ (D020='00')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='27';
typ_ number;

acc_     Number;
nbs_     Varchar2(4);
nls_     Varchar2(15);
mfo_     number;
mfou_    number;
nbuc1_   Varchar2(12);
nbuc_    Varchar2(12);
data_    Date;
kv_      SMALLINT;
d020_    Varchar2(2);
sDos_    DECIMAL(24);
sKos_    DECIMAL(24);
kodp_    Varchar2(10);
znap_    Varchar2(30);
userid_  Number;

---  �������  �� � �� (�������� � ���������� �� 2603)
CURSOR SALDO IS
   SELECT a.acc, a.nls, a.kv, a.fdat, a.nbs, a.dos, a.kos
   FROM sal a
   WHERE a.fdat= Dat_    AND
         a.dos+a.kos<>0  AND
         a.nbs = '2603'  AND
         a.kv NOT IN (980,959,961,962,964);

CURSOR BaseL IS
    SELECT kodp, nbuc, SUM (znap)
    FROM rnbu_trace
        WHERE userid=userid_
    GROUP BY kodp, nbuc;

BEGIN
-------------------------------------------------------------------
--SELECT id INTO userid_ FROM staff WHERE upper(logname)=upper(USER);
--DELETE FROM RNBU_TRACE WHERE userid = userid_;
userid_ := user_id;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
mfo_ := f_ourmfo;

-- ��� "��������"
BEGIN
   SELECT mfou
     INTO mfou_
     FROM BANKS
    WHERE mfo = mfo_;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      mfou_ := mfo_;
END;

-- ����������� ��������� ����������
p_proc_set(kodf_,sheme_,nbuc1_,typ_);

OPEN SALDO;
LOOP
   FETCH SALDO INTO acc_, nls_, kv_, data_, nbs_, sDos_, sKos_ ;
   EXIT WHEN SALDO%NOTFOUND;

   kv_ := lpad(kv_,3,'0');

   if typ_>0 then
      nbuc_ := nvl(f_codobl_tobo(acc_,typ_),nbuc1_);
   else
      nbuc_ := nbuc1_;
   end if;

   IF sDos_ >0 THEN
      kodp_:= '5' || nbs_ || '00' || kv_;
      znap_:= TO_CHAR(sDos_) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc) VALUES
                              (nls_, kv_, data_, kodp_, znap_, nbuc_);
   END IF ;

   IF sKos_ >0 THEN
      kodp_:= '6' || nbs_ || '00' || kv_;
      znap_:= TO_CHAR(sKos_) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc) VALUES
                              (nls_, kv_, data_, kodp_, znap_, nbuc_);
   END IF ;

END LOOP;
CLOSE SALDO;
---------------------------------------------------
if dat_ >= to_date('20112012','ddmmyyyy') then

   for k in ( select p.ref, p.fdat, p.tt, p.accd, p.nlsd, p.kv, p.nlsk, substr(p.nlsd,1,4) nbs,
                     p.nazn, p.s*100 s, NVL(substr(trim(w.value),1,2),'00') d020,
                     NVL(sp.ob22,'00') ob22
              from provodki p, operw w, oper o, specparam_int sp
              where p.fdat = Dat_
                and p.ref = o.ref
                and o.sos = 5
                and p.kv not in (980, 959, 961, 962, 964)
                and p.nlsd like '2603%'
                and p.nlsk not like '25%'
                and p.nlsk not like '26%'
                and p.ref = w.ref(+)
                and w.tag(+) like 'D020%'
                and p.acck = sp.acc(+)
            )

      loop

         if typ_>0 then
            nbuc_ := nvl(f_codobl_tobo(k.accd,typ_),nbuc1_);
         else
            nbuc_ := nbuc1_;
         end if;

         d020_ := k.d020;

         if d020_ = '00' then
            BEGIN
               select NVL(substr(trim(value),1,2),'00')
                  into d020_
               from operw
               where ref(+) = k.ref
                 and tag(+) like 'D#27%';
            EXCEPTION WHEN NO_DATA_FOUND THEN
               NULL;
            END;
         end if;

         if (d020_ not in ('01') and  (LOWER(k.nazn) like '%����%����%'             or
                                       LOWER(k.nazn) like '%����_�����__ ������%'   or
                                       LOWER(k.nazn) like '%���������__ ������%'    or
                                       LOWER(k.nazn) like '%����_����__ ������%'    or
                                       LOWER(k.nazn) like '%���������__ �����%'     or
                                       LOWER(k.nazn) like '%����_���. ������%'      or
                                       LOWER(k.nazn) like '%����_���. ����.%'       or
                                       LOWER(k.nazn) like '%�������. ����.%'        or
                                       LOWER(k.nazn) like '%����_�������� �������%' or
                                       LOWER(k.nazn) like '%������������ �������%'  or
                                       LOWER(k.nazn) like '%������������ ������%'   or
                                       LOWER(k.nazn) like '%��_���������� ������%'  or
                                       LOWER(k.nazn) like '%��_���������� �������%' or
                                       LOWER(k.nazn) like '%������������ �������%'  ) ) OR
            (mfou_ = 300465 and k.nlsk like '2900%' and k.ob22 = '04')                  OR
            (mfou_ = 300205 and k.nlsk like '2900%')                                    OR
            (mfou_ = 353575 and k.nlsk like '29003%')                                   OR
             d020_ = '01'
         then

            kodp_ := '7' || k.nbs || '00' || lpad(k.kv,3,'0');
            znap_:= TO_CHAR(k.s) ;
            INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, ref, nbuc) VALUES
                                   (k.nlsd, k.kv, k.fdat, kodp_, znap_, k.ref, nbuc_);

         end if;

      end loop;

end if;
--------------------------------------------------------------------------------
if dat_ >= to_date('11022014','ddmmyyyy') then

   for k in ( select p.ref, p.fdat, p.tt, p.accd, p.nlsd, p.kv, p.nlsk, substr(p.nlsd,1,4) nbs,
                     p.nazn, p.s*100 s, NVL(substr(trim(w.value),1,2),'00') d020,
                     NVL(sp1.ob22,'00') ob22d, NVL(sp.ob22,'00') ob22k
              from provodki p, operw w, oper o, specparam_int sp, specparam_int sp1
              where p.fdat = Dat_
                and p.ref = o.ref
                and o.sos = 5
                and p.kv not in (980, 959, 961, 962, 964)
                and ( (p.nlsd like '2909%' and p.nlsk like '2900%') or
                      (p.nlsd like '1919%' and p.nlsk like '2900%') or
                      (p.nlsd like '1919%' and p.nlsk like '3800%' and mfo_ = 300465) or
                      (p.nlsd like '1919%' and p.nlsk like '3640%' and mfo_ = 380764)
                    )
                and p.ref = w.ref(+)
                and w.tag(+) like 'D020%'
                and p.accd = sp1.acc(+)
                and p.acck = sp.acc(+)
            )

      loop

         if typ_>0 then
            nbuc_ := nvl(f_codobl_tobo(k.accd,typ_),nbuc1_);
         else
            nbuc_ := nbuc1_;
         end if;

         d020_ := k.d020;

         if d020_ = '00' then
            BEGIN
               select NVL(substr(trim(value),1,2),'00')
                  into d020_
               from operw
               where ref(+) = k.ref
                 and tag(+) like 'D#27%';
            EXCEPTION WHEN NO_DATA_FOUND THEN
               NULL;
            END;
         end if;

         if mfou_ = 300465
         then
            if ( (k.nlsd like '2909%' and k.ob22d in ('55','56','75') and
                  k.nlsk like '2900%' and k.ob22k in ('01') ) OR
                 (k.nlsd like '1919%' and k.ob22d = '02' and
                  k.nlsk like '3800%' and k.ob22k = '10')
               )
            then
               kodp_ := '7' || k.nbs || '00' || lpad(k.kv,3,'0');
               znap_:= TO_CHAR(k.s) ;
               INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, ref, nbuc) VALUES
                                      (k.nlsd, k.kv, k.fdat, kodp_, znap_, k.ref, nbuc_);
            end if;
         else
            if (d020_ not in ('01') and  (LOWER(k.nazn) like '%����%����%'             or
                                          LOWER(k.nazn) like '%��%����%'               or
                                          LOWER(k.nazn) like '%����_�����__ ������%'   or
                                          LOWER(k.nazn) like '%���������__ ������%'    or
                                          LOWER(k.nazn) like '%����_����__ ������%'    or
                                          LOWER(k.nazn) like '%���������__ �����%'     or
                                          LOWER(k.nazn) like '%����_���. ������%'      or
                                          LOWER(k.nazn) like '%����_���. ����.%'       or
                                          LOWER(k.nazn) like '%�������. ����.%'        or
                                          LOWER(k.nazn) like '%����_�������� �������%' or
                                          LOWER(k.nazn) like '%������������ �������%'  or
                                          LOWER(k.nazn) like '%������������ ������%'   or
                                          LOWER(k.nazn) like '%��_���������� ������%'  or
                                          LOWER(k.nazn) like '%��_���������� �������%' or
                                          LOWER(k.nazn) like '%������������ �������%'  ) ) OR
                d020_ = '01'
            then

               kodp_ := '7' || k.nbs || '00' || lpad(k.kv,3,'0');
               znap_:= TO_CHAR(k.s) ;
               INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, ref, nbuc) VALUES
                                      (k.nlsd, k.kv, k.fdat, kodp_, znap_, k.ref, nbuc_);

            end if;

         end if;

         if mfou_ = 380764
         then

            delete from rnbu_trace
            where ref=k.ref and k.nlsd like '1919%' and k.nlsk like '2900%'
              and k.ob22k in ('02','08');

         end if;

      end loop;

end if;
---------------------------------------------------
DELETE FROM tmp_nbu where kodf=kodf_ and datf= dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, nbuc_, znap_;
   EXIT WHEN BaseL%NOTFOUND;

   INSERT INTO tmp_nbu
        (kodf, datf, kodp, znap, nbuc)
   VALUES
        (kodf_, Dat_, kodp_, znap_, nbuc_);
END LOOP;
CLOSE BaseL;
-------------------------------------------------
END p_f27_NN;
/
show err;

PROMPT *** Create  grants  P_F27_NN ***
grant EXECUTE                                                                on P_F27_NN        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F27_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
