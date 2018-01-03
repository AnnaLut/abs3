CREATE OR REPLACE PROCEDURE BARS.p_f26 (Dat_ DATE )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    ��������� ������������ ����� #26 ��� ��
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
%
% VERSION     :   v.16.005  (28.12.2017, 14.11.2017) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     ���������:  Dat_ - �������� ����

   ��������� ����������    DD MMM HHHHHHHHHH BBBB VVV P

 1     DD           ������ �������� [10,11,20,21,97,98,99]
 3     MMM          K040 ��� ������ �����/�����������
 6     HHHHHHHHHH   rc_bnk.B010 ��� rcukru.glb
16     BBBB         R020 ���������� ����                           
20     R011         �������� R011
21     R013         �������� R013
22     VVV          R030 ������
25     J            ������ ����������� �����
26     S181         ��� ����������� ������ ���������
27     S245         ��� �������� ������ ���������
28     S580         ��� �������� ������ �� ������� ������

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 28/12/2017 -����� ��������� ����������
 14/11/2017 -�������������� ���������
 20/02/2017 -��� ���.����� 1502 ����� ������������� ��������� �������� 
             ���� ���������� "P" (1 ��� 2) 
             (R013='1' �� P='1', R013 in '2','9') �� P='2')                               
 26/10/2016 -��� ������ 1500 ������ �������������� ��������� � "�����������" 
 07/10/2016 -��� ���.����� 1500 ����� ������������� ��������� �������� 
             ���� ���������� "P" (1 ��� 2) 
 05/09/2016 -����� ���� �� ����������� ���.������ 3041, 3351 
 01/07/2016 -��� ������ ������������ ��� ����� �������� �� ALT_BIC
             ������� CUSTBANK
 20/04/2015 -��������� ���������� RB_ ��� �������� ����� � 4 �� 5 ��������
 27/10/2014 -��� ���������� �������� ����� ��������� �� RCUKRU ���� NB
 11/06/2014 -��� ��������������� ������ ����� '1' ����� ����������� ������ 
             ��� ������������
 10/06/2014 -��� ��������� 'BBB','BBB+','BBB-','Baa1','Baa2','Baa3' 
             ����� ����������� ��� ��������������� ������ '1'    
             (��������� ����� �����)
 03/06/2014 -��� ����� ����� �� �������� �� �������� ������� �� 10 ��� ���
             ����� �.�. ������� ��������� � ���. � �� � ������ 
 10/01/2014 -��� ���.������ 1525,1526 �������� ������� �� ������ ���� 
             R013 in ('1','2','3','4','5','6','7') � ��������� � ����������
             R013='1' ���� ������������ R013=2,3,5,7
             R013='2' ���� ������������ R013=1
             R013='4' ���� ������������ R013=4 
             R013='9' ���� ������������ R013=6
 03/01/2014 -��� ���.������ 1525,1526 �������� ������� �� ������ ���� 
             R013 in ('1','2','3','4','5','9') � ��������� � ���������� 
             R013='4' ���� ������������ R013='4' � R013='1' ��� ����
             ��������� �������� ������������� R013  
 24/09/2013 -��� ���.������ 3540,3640 �������� ������� �� ������ ���� 
             R013 in ('4','5','6') � ��������� � ���������� R013='9' 
 12/01/2013 -��� ���.����� 3540 �������� ������ �� ������ ���� 
             R013 in ('4','5','6') � ��������� � ���������� R013 
             � ����� �� ����������
 29/12/2012 -��� ���.����� 3540 �������� ������� �� ������ ���� 
             R013 in ('4','5','6') � ��������� � ���������� R013='9'
 11/06/2012 -��� ���=324485 ��������� glb_= 81 � ��� ���=325569 glb_=93
 21/01/2011 -��� �������� ������� ����� �������� 60 �������� 
             �������� ���������� ��� �� 11.01.2011 N24-618/4  (���� 54)
             ��� ������������ �������� ����� �������� �� ��-�� RC_BNK
             ���� NAME
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
acc_     Number;
l_acc    number;
nbs_     Varchar2(4);
nbs_o    Varchar2(4);
nls_     Varchar2(15);
dat1_    Date;
data_    Date;
kv_      SMALLINT;
dk_      Varchar2(2);
se_      DECIMAL(24);
sn_      DECIMAL(24);
sq_      DECIMAL(24);
sump_    DECIMAL(24);
sumpq_   DECIMAL(24);
mfo_     Varchar2(12);
mfob_    Number;
mfou_    Number;
glb_     Number;
kb_      Varchar2(12);
kb1_     Varchar2(12);
rb_      Varchar2(5);
invk_    Varchar2(1);
nb_      Varchar2(60);
nb1_     Varchar2(60);
kk_      Varchar2(8);
kodp_    Varchar2(35);
kodp1_   Varchar2(35);
znap_    Varchar2(70);
znap1_   Varchar2(70);
ref_     Number;
cs_      Number;
cs1_     Number;
agent_   Number;
r1518_   Number;
r1528_   Number;
den_     Varchar2(2);
tips_    VARCHAR2 (3);
r011_    Varchar2(1);
r011s_   Varchar2(1);
r013_    Varchar2(1);
r013s_   Varchar2(1);
s180_    Varchar2(1);
s180s_    Varchar2(1);
s181_    Varchar2(1);
s240_    Varchar2(1);
s240s_   Varchar2(1);
s245_    Varchar2(1);
s580_    Varchar2(1);
s580s_   Varchar2(1);
s580a_   Varchar2(1);
kod_j_   Varchar2(1);

rnk_     Number;

comm_           rnbu_trace.comm%TYPE;
l_znak          smallint;
l_o_sum         number;
l_o_kv          number;
l_se            number;
l_sn            number;
dat_izm1     date := to_date('29/12/2017','dd/mm/yyyy');

--- �������
CURSOR SALDO IS
   SELECT a.acc, a.nls, a.kv, a.fdat, a.nbs, c.country, c.codcagent,
          cb.mfo, NVL(rc.glb,0), cb.alt_bic, NVL(cb.rating,' '),
          decode(f_ourmfo, 300205, LTRIM(RTRIM(substr(c.nmkk,1,60))), 
                                   LTRIM(RTRIM(substr(c.nmk,1,60)))), 
          a.ostf-a.dos+a.kos, 
          NVL(trim(sp.r011),'0'),
          NVL(trim(sp.r013),'0'),
          NVL(trim(sp.s180),'0'),
          NVL(trim(sp.s240),'0'),
          NVL(trim(sp.s580),'0'), 
          c.rnk
   FROM (SELECT s.acc, s.nls, s.kv, aa.fdat, s.nbs, aa.ostf,
         aa.dos, aa.kos, s.rnk, s.mdate
         FROM saldoa aa, accounts s
         WHERE aa.acc=s.acc     AND
              (s.acc,aa.fdat) =
               (select c.acc,max(c.fdat)
                from saldoa c
                where s.acc=c.acc and c.fdat <= Dat_
                group by c.acc)) a,    
        customer c, custbank cb, kl_k040 l, kod_r020 k, 
        rcukru rc, specparam sp 
   WHERE a.nbs=k.r020                   AND
         trim(k.prem) = '��'            AND
         k.a010 = '26'                  AND
         (k.d_close is null OR 
          k.d_close > Dat_)             AND
         a.acc = sp.acc(+)              AND 
         a.rnk = c.rnk                  AND
         c.rnk = cb.rnk                 AND
         cb.mfo = rc.mfo(+)             AND 
         c.country = TO_NUMBER(l.k040)  AND
         a.ostf-a.dos+a.kos <> 0 ;

CURSOR BaseL IS
    SELECT kodp, znap
    FROM rnbu_trace
order by kodp;


    procedure P_Set_S580_Def(r020_ in varchar2, r013_ in varchar2) is
       invk_ varchar2(1);
    begin
       if r020_ = '9500' then
          if r013_ in ('1','3') then
             s580_ := '5';
          end if;

          if r013_ = '9' then
             s580_ := '9';
          end if;
       end if;

       if r020_ in ('3570','3578')  then
          if r013_ in ('3','4')  then   s580_ :='5';  end if;
          if r013_ in ('5','6')  then   s580_ :='1';  end if;
       end if;

       if mfou_ = 353575 and r020_ in ('1518', '1520', '1521') or
          mfou_ <> 353575 and r020_ in ('1500','1502','1508','1509',
                                        '1510','1512','1513','1515','1516','1517','1518','1519',
                                        '1520','1521','1523','1524','1525','1526','1528')
       then
           begin
             select nvl(trim(VALUE), '2')
             into invk_
             from customerw
             where rnk = rnk_ and
                   tag = 'INVCL';
           exception
                when no_data_found then
                    invk_:= null;
           end;
       else
           invk_:= null;
       end if;

       invk_:= nvl(invk_, '2');

       s580_ := (case
                   when r020_||invk_ in ('15003','15083','15103','15123') then '1'
                   when r020_||invk_ in ('15001','15081','15101','15121') then '3'
                   when r020_||invk_ in ('15002','15082','15102','15122') then '4'
                   ---
                   when r020_||r013_ in ('15023') then '1'
                   when r020_||r013_ in ('15021','15022','15029') and invk_ ='3'  then '1'
                   when r020_||r013_ in ('15021')         and invk_ in ('1','2')  then '4'
                   when r020_||r013_ in ('15022','15029') and invk_ in ('1','2')  then '5'
                   ---
                   when r020_||invk_ in ('15133') then '1'
                   when r020_||invk_ in ('15131','15132') then '5'
                   ---
                   when r020_||r013_ in ('15185','15186','15187','15188') and invk_ ='3'  then '1'
                   when r020_||r013_ in ('15185','15187') and invk_ ='1'  then '3'
                   when r020_||r013_ in ('15186','15188') and invk_ ='2'  then '5'
                   when r020_||invk_ in ('15182') then '5'
                   when r020_ in ('1509','1519')  then '5'
                   ---
                   when r020_||r013_ in ('15151','15154','15161','15164') and invk_ ='3'  then '1'
                   when r020_||r013_ in ('15151','15154','15161','15164') and invk_ ='1'  then '3'
                   when r020_||r013_ in ('15151','15154','15161','15164') and invk_ ='2'  then '4'
                   when r020_||r013_ in ('15152','15162')  and invk_ ='3'          then '1'
                   when r020_||r013_ in ('15152','15162')  and invk_ in ('1','2')  then '5'
                   ---
                   when r020_||invk_ in ('15203', '15213', '15223','15233') then '1'
                   when r020_||invk_ in ('15201', '15202', '15221', '15222') then '5'
                   when r020_||invk_ in ('15211', '15231') then '3'
                   when r020_||invk_ in ('15212') then '4'
                   when r020_||invk_ in ('15232') then '5'
                   ---
                   when r020_||r013_||invk_ in ('152433') then '1'
                   when r020_||r013_||invk_ in ('152411', '152412') then '5'
                   ---
                   when r020_||invk_ in ('15253') and r013_ in ('1','2','3','4','5','7') then '1'
                   when r020_||invk_ in ('15251') and r013_ in ('1','4') then '3'
                   when r020_||invk_ in ('15251') and r013_ in ('2','3','5','7') then '5'
                   when r020_||r013_ in ('15254') then '4'
                   when r020_||r013_ in ('15251','15252','15253','15255','15257') and invk_ = '2' then '5'
                   ---
                   when r020_||invk_ in ('15263') and r013_ in ('1','2','3','4','5','7')  then '1'
                   when r020_||invk_ in ('15261') and r013_ in ('1','4') then '3'
                   when r020_||invk_ in ('15261') and r013_ in ('2','3','5','7')  then '5'
                   when r020_||r013_ in ('15264') then '4'
                   when r020_||r013_ in ('15261','15262','15263','15265','15267') and invk_ = '2' then '5'
                   ---
                   when r020_||invk_ in ('15283') then '1'
                   when r020_||invk_ in ('15281') then '3'
                   when r020_||r013_ in ('15285','15287') then '4'
                   when r020_||r013_ in ('15286','15288') and invk_ = '2' then '5'
                     else
                         s580_
                   end);
    end;

BEGIN
-------------------------------------------------------------------
EXECUTE IMMEDIATE 'truncate table rnbu_trace';
-------------------------------------------------------------------
EXECUTE IMMEDIATE 'alter session set NLS_NUMERIC_CHARACTERS=''.,''';

-- ���� ���
mfob_:=f_ourmfo();

-- ��� "��������"
BEGIN
   SELECT NVL(trim(mfou), mfob_)
      INTO mfou_
   FROM BANKS
   WHERE mfo = mfob_;
EXCEPTION WHEN NO_DATA_FOUND THEN
   mfou_ := mfob_;
END;

den_ := to_char(Dat_,'DD');

if to_number(den_) <=10 then
   Dat1_ := to_date('01'||to_char(Dat_,'MM')||to_char(Dat_,'YYYY'),'ddmmyyyy');
elsif to_number(den_)<=20 then
   Dat1_ := to_date('11'||to_char(Dat_,'MM')||to_char(Dat_,'YYYY'),'ddmmyyyy');
else
   Dat1_ := to_date('21'||to_char(Dat_,'MM')||to_char(Dat_,'YYYY'),'ddmmyyyy');
end if;

sump_ := 0 ;
znap1_ := '0' ;
kodp1_ := '0' ;

OPEN SALDO;
LOOP
   FETCH SALDO INTO acc_, nls_, kv_, data_, nbs_, cs_, agent_, mfo_,
                    glb_, kb_, rb_, nb_, sn_, r011s_, r013s_, 
                    s180s_, s240s_,  s580s_, rnk_ ;
   EXIT WHEN SALDO%NOTFOUND;

   r1518_ := 0;
   r1528_ := 0;
   r013_ :='0';
   comm_ := NULL;
   
   if mfo_ = 324485 then
      glb_ := 81;
   end if;
   
   if mfo_ = 325569 then
      glb_ := 93;
   end if;

   IF nbs_ = '1502' and Dat_ < dat_izm1 
   THEN
      if r013s_ = '1' then
         r013_ := '1';
      end if;
      if r013s_ in ('2','9') then
         r013_ := '2';
      end if;
   END IF;

   IF nbs_ in ('1518','1528') and Dat_ < dat_izm1
   THEN
      if r013s_ in ('2','5','7') then
         r013_ := '1';
      end if;
      if r013s_ in ('3','6','8') then
         r013_ := '2';
      end if;
   END IF;

   IF nbs_ in ('1518','1528') and Dat_ < dat_izm1
   THEN
      BEGIN
         select substr(a.nls,1,4) 
            into nbs_o 
         from int_accn i, accounts a
         where i.acra = acc_ 
           and i.acc = a.acc
           and rownum = 1 ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         nbs_o := null;
      END;

      if nbs_o in ('1510','1512') then
         r013_ := '1';
      end if;
 
      if nbs_o in ('1511','1513','1514','1515','1516','1517') then
         r013_ := '2';
      end if;

      if nbs_o in ('1520','1521','1523') then
          r013_ := '1';
      end if;
 
      if nbs_o in ('1522','1524','1525','1526','1527') then
         r013_ := '2';
      end if;

   END IF;

   IF Dat_ >= to_date('10012014','ddmmyyyy') and 
      Dat_ < dat_izm1 and 
      nbs_ in ('1525','1526') then
      if r013s_ in ('2','3','5','7') then
         r013_ := '1';
      elsif r013s_ = '1' then
         r013_ := '2';
      elsif r013s_ = '4' then
         r013_ := '4';
      elsif r013s_ = '6' then
         r013_ := '9';
      else 
         null;
      end if;
   END IF;

   IF nbs_  in ('3540','3640','9100') and Dat_ < dat_izm1
   THEN
      r013_ := r013s_;
   END IF;

   IF nbs_ not in ('1502','1518','1528','1525','1526','3540','3640','9100') and 
      Dat_ < dat_izm1
   THEN
      r013_ := '0';
   END IF;

   IF Dat_ >= dat_izm1
   THEN
      r011_ := r011s_;
      r013_ := r013s_;
      s180_ := s180s_;
      s181_ := '0';
      if s180_ < 'C'
      then
         s181_ := '1';
      end if;

      if s180_ >= 'C'
      then
         s181_ := '2';
      end if;

      s240_ := s240s_;
      s580_ := s580s_;

      begin
         select S580
            into s580a_
         from otc_risk_s580
         where s580 <> 'R' and
               R020 = nbs_ and
               T020 in ('1', '3') and
               (r013 = r013_ or r013 = '0');
      exception
        when no_data_found then
         s580a_ := '0';
      end;

      if s580a_ = '0' then
         s580_ := null;

         p_set_s580_def(substr(nls_, 1, 4), r013_);

         if s580_ is not null then
            s580a_ := s580_;
         else
            s580a_ := '9';
         end if;
      end if;

      kod_j_ := '0';

      s245_ :='1';
      if tips_ in ('SK9','SP ','SPN','OFR','KSP','KK9','KPN')
      then
         s245_ :='2';
      elsif  nbs_ like '150_'
         or  nbs_ like '34__' or  nbs_ like '36__'
         or  nbs_ like '44__' or  nbs_ like '45__'
         or  nbs_ like '9___'
         or  nbs_ in ('2920','3500')
      then
         s245_ :='0';
      end if;
   END IF;
      
   IF (SN_ <> 0 and ( nbs_ not in ('1525','1526','3540','3640') or 
                     (nbs_ in ('1525','1526') and r013_ in ('1','2','3','4','5','6','7')) or 
                     (nbs_ in ('3540','3640') and r013_ in ('4','5','6'))  
                    ) and Dat_ < dat_izm1) 
           OR
      (SN_ <> 0 and Dat_ >= dat_izm1) 
   THEN

      IF kv_<> 980 THEN
         se_ := GL.P_ICURVAL(kv_, sn_, Dat_) ;
      ELSE
         se_ := sn_ ;
      END IF;
   
      IF Dat_ >= to_date('30092013','ddmmyyyy') and 
         Dat_ < dat_izm1 and 
         nbs_ in ('3540','3640') and 
         r013s_ in ('4','5','6') 
      THEN
         r013_ := '9';
      END IF;   

      IF MOD(agent_,2)=0 THEN
         IF kb_ IS NULL OR kb_=' ' THEN
            kb_ := '0000000000' ;
         ELSE
            kb_ := lpad(kb_,10,'0') ;
         END IF;
      ELSE
         IF mfo_ IS NULL OR mfo_=' ' THEN
            kb_ := '0000000000' ;
         ELSE
            if dat_ < to_date('09072010','ddmmyyyy') then
               kb_ := lpad(mfo_,10,'0') ;
            else 
               kb_ := lpad(glb_,10,'0') ;
            end if;
         END IF;
      END IF;

      IF nbs_ = '1500' THEN

        if se_ < 0 then
          l_o_sum := 0;
          l_o_kv  := 0;

          begin
              select   acc, sum(lie_sum), sum(lie_val)
                into l_acc, l_o_sum,      l_o_kv
                from ( select acc, nvl(to_number(value),0) lie_sum, 0 lie_val
                         from accountsw
                        where acc = acc_
                          and tag = 'LIE_SUM'
                       union
                       select acc, 0 lie_sum, nvl(to_number(value),0) lie_val
                         from accountsw
                        where acc = acc_
                          and tag = 'LIE_VAL' )
               group by acc;

          exception
             when others  then l_o_sum :=0;
                               l_o_kv  :=0;
          end;

          if l_o_sum !=0  then

             comm_ := 'acc '||to_char(acc_)|| ' ���������' ;

             l_znak :=  IIF_N(se_,0,-1,1,1);
             se_ := abs(se_);
             sn_ := abs(sn_);
  
             if l_o_kv = kv_  or l_o_kv =0  then

                l_se := least(se_,gl.p_icurval(kv_,l_o_sum,dat_));
                l_sn := least(sn_,l_o_sum);
             else

                l_se := least(se_,gl.p_icurval(l_o_kv,l_o_sum,dat_));
                l_sn := least(sn_,gl.p_ncurval(kv_,l_se,dat_));
             end if;

             dk_ := IIF_N(l_znak*se_,0,'10','20','20');
             
             -- �� 29/12/2017 (�� 01/01/2018) ����� ��������� ���������� 
             IF Dat_ < dat_izm1
             THEN
                kodp_:= dk_ || LPAD(to_char(cs_),3,'0') || kb_ || nbs_ ||
                               LPAD(to_char(kv_),3,'0') || '2' ;
             ELSE
                kodp_:= dk_ || LPAD(to_char(cs_),3,'0') || kb_ || nbs_ ||
                        r011_ || r013_ || LPAD(to_char(kv_),3,'0') || '2' ||
                        s181_ || s245_ || s580a_;
             END IF;

             znap_ := TO_CHAR(ABS(l_se)) ;

             INSERT INTO rnbu_trace
                      (nls, kv, odate, kodp, znap, acc, rnk, comm)
               VALUES (nls_, kv_, data_, kodp_, znap_, acc_, rnk_, comm_);

             if kv_ != 980  then

                dk_ := IIF_N(l_znak*se_,0,'11','21','21');
                IF Dat_ < dat_izm1
                THEN
                   kodp_ := dk_ || LPAD(to_char(cs_),3,'0') || kb_ || nbs_ ||
                                  LPAD(to_char(kv_),3,'0') || '2' ;
                ELSE
                   kodp_:= dk_ || LPAD(to_char(cs_),3,'0') || kb_ || nbs_ ||
                           r011_ || r013_ || LPAD(to_char(kv_),3,'0') || '2' ||
                           s181_ || s245_ || s580a_;
                END IF;

                znap_ := TO_CHAR(ABS(l_sn)) ;

                INSERT INTO rnbu_trace
                         (nls, kv, odate, kodp, znap, acc, rnk, comm)
                  VALUES (nls_, kv_, data_, kodp_, znap_, acc_, rnk_, comm_);

             end if;

             se_ := l_znak *greatest(least(se_, l_se),0);
             sn_ := l_znak *greatest(least(sn_, l_sn),0);

          end if;

        end if;
        
        IF Dat_ < dat_izm1
        THEN
           r013_ := '1';
        ELSE
           kod_j_ := '1';
        END IF;

      END IF;          

      if se_ <> 0 then
         dk_ := IIF_N(se_,0,'10','20','20');
         if nbs_ = '1500'  and  dk_='20' and Dat_ < dat_izm1  
         then
            r013_ := '0';
         end if;

         IF Dat_ < dat_izm1
         THEN
            kodp_ := dk_ || LPAD(to_char(cs_),3,'0') || kb_ || nbs_ ||
                     LPAD(to_char(kv_),3,'0') || r013_ ;
         ELSE
            kodp_:= dk_ || LPAD(to_char(cs_),3,'0') || kb_ || nbs_ ||
                    r011_ || r013_ || LPAD(to_char(kv_),3,'0') || kod_j_ ||
                    s181_ || s245_ || s580a_;
         END IF;

         znap_ := TO_CHAR(ABS(se_)) ;

         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, acc, rnk) VALUES
                                (nls_, kv_, data_, kodp_, znap_, acc_, rnk_);
      end if;

      IF kv_<> 980 and sn_ <> 0 
      THEN
         dk_ := IIF_N(sn_,0,'11','21','21');
         if nbs_ = '1500'  and  dk_ = '21'  then
            r013_ := '0';
         end if;

         IF Dat_ < dat_izm1
         THEN
         kodp_ := dk_ || LPAD(to_char(cs_),3,'0') || kb_ || nbs_ ||
                 LPAD(to_char(kv_),3,'0') || r013_ ;
         ELSE
            kodp_:= dk_ || LPAD(to_char(cs_),3,'0') || kb_ || nbs_ ||
                    r011_ || r013_ || LPAD(to_char(kv_),3,'0') || kod_j_ ||
                    s181_ || s245_ || s580a_;
         END IF;

         if kv_ in (959, 961, 962) and mfou_ not in (300465, 380764) then
            znap_ := TO_CHAR(round(ABS(sn_)/10,0));
         else 
            znap_ := TO_CHAR(ABS(sn_)) ;
         end if;

         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, acc, rnk) VALUES
                                (nls_, kv_, data_, kodp_, znap_, acc_, rnk_);
      END IF;

      -- �������������� ����� ������ ��� ������ ������������
      if se_ <> 0 or (kv_<> 980 and sn_ <> 0) then

         IF agent_ in (2,4) and (substr(rb_,1,1) = 'A' or substr(rb_,1,1) = 'T' or 
                                 substr(rb_,1,1) = 'F' or 
                                 rb_ in ('BBB','BBB+','BBB-','Baa1','Baa2','Baa3'))
         THEN
            invk_ := '1';
         ELSE
            invk_ := '2';
         END IF;

         IF Dat_ < dat_izm1 
         THEN
            kodp_ := '97' || LPAD(to_char(cs_),3,'0') || kb_ || '00000000' ;
         ELSE
            kodp_ := '97' || LPAD(to_char(cs_),3,'0') || kb_ || '0000000000009' ;
         END IF;
            INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, acc, rnk) VALUES
                                (nls_, kv_, data_, kodp_, invk_, acc_, rnk_);

         IF MOD(agent_,2)=0 THEN
            BEGIN
               select name 
                  into nb_
               from rc_bnk
               where b010 = kb_;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               null;
            END;
         ELSE 
            BEGIN
               select nb 
                  into nb_
               from rcukru
               where mfo = mfo_;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               null;
            END;
         END IF;

         IF Dat_ < dat_izm1
         THEN
            kodp_ := '98' || LPAD(to_char(cs_),3,'0') || kb_ || '00000000' ;
         ELSE
            kodp_ := '98' || LPAD(to_char(cs_),3,'0') || kb_ || '0000000000009' ;
         END IF;

         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, acc, rnk) VALUES
                                (nls_, kv_, data_, kodp_, nb_, acc_, rnk_);

         IF Dat_ < dat_izm1
         THEN
            kodp_ := '99' || LPAD(to_char(cs_),3,'0') || kb_ || '00000000' ;
         ELSE
            kodp_ := '99' || LPAD(to_char(cs_),3,'0') || kb_ || '0000000000009' ;
         END IF;

         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, acc, rnk) VALUES
                                (nls_, kv_, data_, kodp_, rb_, acc_, rnk_);
      end if;

   END IF;
END LOOP;
CLOSE SALDO;

---------------------------------------------------
DELETE FROM tmp_nbu where kodf='26' and datf= dat_;
---------------------------------------------------
sump_ := 0;
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   IF kodp1_ = '0' THEN
      kodp1_ := kodp_ ;
   END IF ;
   IF kodp1_ <> kodp_ THEN
      IF TO_NUMBER(SUBSTR(kodp1_,1,2))<97 THEN
         INSERT INTO tmp_nbu (kodf, datf, kodp, znap)
                      VALUES ('26', Dat_, kodp1_, TO_CHAR(sump_));
      END IF ;

      IF TO_NUMBER(SUBSTR(kodp1_,1,2))>96 THEN
         INSERT INTO tmp_nbu (kodf, datf, kodp, znap)
                      VALUES ('26', Dat_, kodp1_, LTRIM(RTRIM(znap1_)));
      END IF ;

      sump_ := 0 ;
      znap1_ := ' ' ;
      kodp1_ := kodp_ ;

   END IF ;
   IF kodp1_ = kodp_ AND TO_NUMBER(SUBSTR(kodp1_,1,2)) < 97 THEN
      sump_ := sump_+TO_NUMBER(znap_) ;
   END IF ;
   IF kodp1_ = kodp_ AND TO_NUMBER(SUBSTR(kodp1_,1,2)) > 96 THEN
      znap1_ := znap_ ;
   END IF ;

END LOOP;
CLOSE BaseL;

IF kodp1_ IS NOT NULL  AND  TO_NUMBER(SUBSTR(kodp1_,1,2))>96 THEN
   INSERT INTO tmp_nbu (kodf, datf, kodp, znap)
                VALUES ('26', Dat_, kodp1_, znap1_);
END IF ;
---------------------------------------------------
END p_f26;
/

