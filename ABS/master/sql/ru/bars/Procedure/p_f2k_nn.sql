CREATE OR REPLACE PROCEDURE BARS.P_F2K_NN (dat_ DATE ,
                                      sheme_ varchar2 default '�')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : ��������� ������������ ����� #2K
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
%
% VERSION     : v.17.009     29.12.2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
���������: dat_ - �������� ����
           sheme_ - ����� ������������

   ��������� ����������    DDD ZZZZZZZZZZ A NNNN

  1    DDD           ��� �������� (������ 3-� ������� �����)
  4    ZZZZZZZZZZ    ��� ������/I�����
 14    A             K021 ������� ������������������ ����
 15    NNNN          �������� ����� ������ � �������� �����

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 29.12.2017  ��������� � ��������� ������ �������� �� ���.����������
 12.12.2017  ������� �� ����� �������� � ������� ������ �� ���� ��������
 05.12.2017  ���������� OKPO �� 10-�� ������ ������
 28.11.2017  ��������� "����i���" �� ������ �� ���.����������
 06.11.2017  ��������� �� ������ cobummfo-5348
 01.11.2017  ��������� �������� � ������������ ����� � ��������� RNBOD
 02.10.2017  ��������� ����� ���������� p_391
 21.08.2017  �������� DDD=260 ������������ �� �������� ���������� �����
 14.06.2017  �������� ���������

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_       varchar2(2):='2K';
kodp_       varchar2(30);
znap_       varchar2(50);

userid_     number;
mfo_        number;
mfou_       number;
tobo_       accounts.tobo%TYPE;
nbuc_       accounts.tobo%TYPE;
nbuc1_      accounts.tobo%TYPE;

typ_        number;
dats_       date;

segm_z      varchar2(10);
segm_a      varchar2(1);
segm_n      varchar2(4);
nnnn_       number;
nnno_       number;
flag_acc_   number;
flag_opp_   number;

dat_rnbo_         date;
is_dat_exist_     number;

p_210          number;
p_260          varchar2(10);
p_310          varchar2(1);
p_330          varchar2(20);
p_340          varchar2(70);
p_350          varchar2(10);
p_360          varchar2(70);
p_391          varchar2(10);

--    �������� DDD ������������ � 0..
procedure p_ins_0( p_rnk number, p_kodp varchar2,
                   p_nmk varchar2, p_adr varchar2 )
   is
begin

--    010  ������������
       insert into rnbu_trace
                 ( rnk, kodp, znap )
          values ( p_rnk, '010'||p_kodp, p_nmk );

--    020  �i��������������
       insert into rnbu_trace
                 ( rnk, kodp, znap )
          values ( p_rnk, '020'||p_kodp, p_adr );

--    030  ����i���      ?�����������
--       insert into rnbu_trace
--                 ( rnk, kodp, znap )
--          values ( p_rnk, '030'||p_kodp, '   ' );

end;

--    �������� DDD ������������ � 1..
procedure p_ins_1( p_rnk number, p_kodp varchar2,
                   p_rnbor varchar2, p_rnbou varchar2, p_rnbos varchar2 )
   is
begin

--    110  ����� �����ii
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '110'||p_kodp, p_rnbor );

--    120  ����� �����
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '120'||p_kodp, 
                     (case when p_rnbou is null  then '����� �����'
                          else p_rnbou end)
                    );

--    130  �����i�
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '130'||p_kodp,
                     (case when p_rnbos is null  then '����� �����'
                          else p_rnbos end)
                    );

end;

--    �������� DDD ������������ � 2..
procedure p_ins_2( p_rnk number, p_kodp varchar2,
                   p_210 number, p_nls varchar2, p_kv number,
                   p_daos varchar2, p_dazs varchar2, 
                   p_260 varchar2, p_270 varchar2, p_280 varchar2 )
   is
begin

--    210  ���� �������
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '210'||p_kodp, p_210 );

--    220  ����� �������
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '220'||p_kodp, p_nls );

--    230  ��� ������ �������
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '230'||p_kodp, p_kv );

--    240  ���� �i������� �������
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '240'||p_kodp, p_daos );

--    250  ���� �������� �������
          if p_dazs is not null  then
            insert into rnbu_trace
                      ( rnk, kodp, znap )
               values ( p_rnk, '250'||p_kodp, p_dazs );
          end if;

--    260  ���� ������������ �����i�
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '260'||p_kodp, p_260 );

--    270  ������� ����i� 1 -�� ���� �������� �����i�
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '270'||p_kodp, p_270 );

--    280  ������� ����i� 2 -�� ��i��� ����
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '280'||p_kodp, p_280 );

end;

--    �������� DDD ������������ � 3..
procedure p_ins_3( p_rnk number, p_kodp varchar2,
                   p_310 varchar2, p_320 varchar2, p_330 varchar2,
                   p_340 varchar2, p_350 varchar2, p_360 varchar2, 
                   p_ostf number, p_kv number, p_390 varchar2, p_391 varchar2 )
   is
begin

--    310  ��� ���� �i�������i ������ii
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '310'||p_kodp, p_310 );

--    320  ���� ������ ���������� �i�������i ������ii
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '320'||p_kodp, p_320 );

--    330  ����� ������� ����������/��������
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '330'||p_kodp, p_330 );
                                                
--    340  ��i��������� ����������/��������
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '340'||p_kodp, p_340 );

--    350  ��� ������/i�� ����������/��������
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '350'||p_kodp, p_350 );

--    360  ��i��������� ����� ����������/��������
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '360'||p_kodp, p_360 );

--    370  ���� �i�������i ������ii
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '370'||p_kodp, to_char(p_ostf) );

--    380  ��� ������ �i�������i ������ii
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '380'||p_kodp, lpad(trim(to_char(p_kv)),3,'0') );

--    390  ����������� ������� �i�������i ������ii
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '390'||p_kodp, p_390 );

--    391  �ii ����� ��� �����i �i�������i ������ii
          insert into rnbu_trace
                    ( rnk, kodp, znap )
             values ( p_rnk, '391'||p_kodp, p_391 );

end;

BEGIN

EXECUTE IMMEDIATE 'alter session set NLS_NUMERIC_CHARACTERS = ''.,'' ';
-------------------------------------------------------------------
logger.info ('P_F2K_NN: Begin for datf = '||to_char(dat_, 'dd/mm/yyyy'));
-------------------------------------------------------------------
userid_ := user_id;
DELETE FROM RNBU_TRACE WHERE userid = userid_;
-------------------------------------------------------------------
   mfo_ := F_OURMFO();

-- ��� "��������"
   BEGIN
      SELECT NVL(trim(mfou), mfo_)
        INTO mfou_
      FROM BANKS
      WHERE mfo = mfo_;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         mfou_ := mfo_;
   END;

   p_proc_set(kodf_,sheme_,nbuc1_,typ_);

   nnnn_ :=0;
   nnno_ := nnnn_;

   dats_ := trunc(dat_, 'mm');
   
   for k in ( select c.okpo, max(c.codcagent) codcagent,
                             max(c.nmk) nmk, max(c.adr) adr, max(c.rnk) rnk,
                             max(re.rnbor) rnbor, max(re.rnbou) rnbou,
                             max(re.rnbos) rnbos, max(re.rnbod) rnbod
                from customer c,
                     ( select *
                         from ( select u.rnk, u.tag, substr(trim(u.value),1,20) value
                                  from customerw u
                                 where exists (select 1 from customerw p
                                                where p.tag like 'RNBOS'
       and instr(p.value,'01')+instr(p.value,'02')+instr(p.value,'03')+
           instr(p.value,'04')+instr(p.value,'05')+instr(p.value,'99') >0
                                                  and p.rnk=u.rnk) 
                              ) pivot
                              ( max(trim(value))
                                for tag in ('RNBOR' as RNBOR, 'RNBOU' as RNBOU,
                                            'RNBOS' as RNBOS, 'RNBOD' as RNBOD)
                              )
                     ) re
               where c.rnk = re.rnk
                 and trim(re.rnbor) is not null
               group by c.okpo
            )
   loop
       if     k.codcagent =1   then    segm_a :='3';
       elsif  k.codcagent =2   then    segm_a :='4';
       elsif  k.codcagent =3   then    segm_a :='1';
       elsif  k.codcagent =5   then    segm_a :='2';
       else
             segm_a := '9';
       end if;
       segm_z := lpad(k.okpo,10);

       is_dat_exist_ := 0;
       begin
         dat_rnbo_ := to_date(k.rnbod,'dd/mm/yyyy');
         is_dat_exist_ := 1;
       exception
           when others  then
              begin
                dat_rnbo_ := to_date(k.rnbod,'dd.mm.yyyy');
                is_dat_exist_ := 1;
              exception
                  when others  then
                           dat_rnbo_ :=dat_;
              end;
       end;
       
--  ���������� ���� � dat_rnbo_ 
    if is_dat_exist_ =1  then

       flag_acc_ := 0;
       flag_opp_ := 0;

       -----------------------------------------------------------
       for u in ( select a.acc, a.kv, a.nbs, a.nls, a.daos, a.dazs,
                         to_char(a.daos,'ddmmyyyy') c_daos,
                         decode(a.dazs,null,null,to_char(a.dazs,'ddmmyyyy') ) c_dazs,
                         to_char( round(0.01*fost(a.acc,dat_rnbo_)) ) p_270,
                         to_char( round(0.01*fost(a.acc,dat_)) ) p_280,
                         nvl(a.blkd,0)+nvl(a.blkk,0) acc_blk
                    from accounts a
                   where a.rnk = k.rnk 
                     and a.nbs in (
            '2512', '2513', '2520', '2523', '2525', '2530', '2541', '2542',
            '2544', '2545', '2546', '2550', '2551', '2553', '2555', '2556',
            '2560', '2561', '2562', '2565', '2600', '2604', '2605', '2610',
            '2620', '2625', '2630', '2650', '2651', '2655', '3320' )
                     and a.daos < dat_rnbo_
                     and ( a.dazs is null
                        or a.dazs is not null and
                           a.dazs > to_date('20150922','yyyymmdd') )
                )
       loop
          flag_acc_ := 1;
          
          p_210 := 1;
          if u.dazs is not null and u.dazs<dat_  then
              p_210 :=2;
          end if;

          p_260 := '';
          if u.acc_blk !=0  then
             p_260 := '02';
          else
             p_260 := '99';
          end if;
/*          if instr(k.rnbos,'01')>0  then
             p_260 := p_260||'01;';
          end if;
          if     instr(k.rnbos,'02')>0 or instr(k.rnbos,'03')>0
              or instr(k.rnbos,'04')>0 or instr(k.rnbos,'05')>0  then
             p_260 := p_260||'02;';
          end if;
          if instr(k.rnbos,'99')>0  then
             p_260 := p_260||'99;';
          end if;
          p_260 := substr(p_260,1,instr(p_260,';',-1,1)-1);
*/
          flag_opp_ := 0;
          ------------------------------------------------------
          for v in ( select to_char(p.pdat,'ddmmyyyy') pdat,
                            p.mfoa, r1.nb namb_a, r1.k040 k040b_a,
                            p.accd, p.nlsa nlsd, p.nam_a, p.id_a okpo_a,
                            p.mfob, r2.nb namb_b, r2.k040 k040b_b,
                            p.acck, p.nlsb nlsk, p.nam_b, p.id_b okpo_b,
                            p.kv, 100*p.s ostf, 100*p.sq ostq, p.ref, p.nazn
                       from rcukru r1, rcukru r2,
                            ( SELECT p.userid isp, p.branch, p.mfoa, p.mfob, p.nam_a, p.nam_b, p.sos soso,
                                     DECODE (o.tt, p.tt, p.nazn, DECODE (o.tt, 'PO3', p.nazn, t.NAME)) nazn,
                                     o.tt, o.REF, ad.kv,
                                     o.s / 100 s,  o.sq / 100 sq, o.fdat, o.stmt, o.txt,
                                     o.accd, ad.nls nlsd, ad.NBS nbsd, ad.branch branch_a, ad.rnk rnkd, ad.ob22 ob22d,
                                     o.acck, ak.nls nlsk, ak.NBS nbsk, ak.branch branch_b, ak.rnk rnkk, ak.ob22 ob22k,
                                     p.vob, p.nlsa, p.nlsb, p.kv kv_o, p.kv2 kv2_o, p.dk dk_o,
                                     p.pdat, p.datd pdatd, p.nazn pnazn, p.tt ptt, p.s ps, p.id_a, p.id_b
                                FROM oper p,
                                     tts t,
                                     accounts ad, accounts ak,
                                     (SELECT o1.fdat, o1.REF, o1.stmt, o1.tt, o1.s,
                                             o1.sq, o1.txt,
                                             (case when o1.dk = 0 then o1.acc else o2.acc end) accd, 
                                             (case when o1.dk = 1 then o1.acc else o2.acc end) acck
                                      FROM opldok o1
                                      JOIN opldok o2
                                          ON (    o1.KF  = o2.kf
                                              AND o1.REF = o2.REF
                                              AND o1.stmt= o2.stmt
                                              AND o1.dk <> o2.dk)
                                      WHERE o1.fdat between dats_ and dat_ AND
                                            o1.acc = u.acc 
                                       ) o
                               WHERE p.REF = o.REF
                                 AND t.tt = o.tt
                                 AND o.accd = ad.acc
                                 AND o.acck = ak.acc
                            ) p
                      where p.mfoa = r1.mfo
                        and p.mfob = r2.mfo
                   )
          loop
             flag_opp_ := 1;
             
             nnnn_ :=nnnn_+1;

             if u.acc = v.accd  then
                p_310 :='1';
                p_330 := v.nlsk;
                p_340 := substr(trim(v.nam_b),1,70);
                p_350 := lpad(v.okpo_b,10,'0');
                p_360 := substr(trim(v.namb_b),1,70);
             else
                p_310 :='2';
                p_330 := v.nlsd;
                p_340 := substr(trim(v.nam_a),1,70);
                p_350 := lpad(v.okpo_a,10,'0');
                p_360 := substr(trim(v.namb_a),1,70);
             end if;
             
             p_391 := p_260;

             segm_n := lpad(to_char(nnnn_),4,'0');
             kodp_ := segm_z||segm_a||segm_n;

             p_ins_0( k.rnk, kodp_, k.nmk, k.adr );
   
             p_ins_1( k.rnk, kodp_, k.rnbor, k.rnbou, k.rnbos );

             p_ins_2( k.rnk, kodp_, p_210, u.nls, u.kv,
                      u.c_daos, u.c_dazs,
                      p_260, u.p_270, u.p_280 );

             p_ins_3( k.rnk, kodp_, p_310, v.pdat, p_330, p_340,
                      p_350, p_360, v.ostq, v.kv, substr(v.nazn,1,70), p_391 );

          end loop;                --���� �� ���������

          if flag_opp_ = 0  then             --��� ��������
             nnnn_ :=nnnn_+1;
             nnno_ :=nnnn_;

             segm_n := lpad(to_char(nnnn_),4,'0');
             kodp_ := segm_z||segm_a||segm_n;

             p_ins_0( k.rnk, kodp_, k.nmk, k.adr );
   
             p_ins_1( k.rnk, kodp_, k.rnbor, k.rnbou, k.rnbos );

             p_ins_2( k.rnk, kodp_, p_210, u.nls, u.kv,
                      u.c_daos, u.c_dazs,
                      p_260, u.p_270, u.p_280 );

--    380  ��� ������ �i�������i ������ii ��� �i��������i ������i�
             insert into rnbu_trace
                       ( rnk, kodp, znap )
                values ( k.rnk, '380'||kodp_, '000' );

          end if;
       end loop;                   --���� �� ������

       if flag_acc_ = 0 then             --��� ������
          nnnn_ :=nnnn_+1;
          nnno_ :=nnnn_;

          segm_n := lpad(to_char(nnnn_),4,'0');
          kodp_ := segm_z||segm_a||segm_n;

          p_ins_0( k.rnk, kodp_, k.nmk, k.adr );
    
          p_ins_1( k.rnk, kodp_, k.rnbor, k.rnbou, k.rnbos );
       end if;

   end if;

   end loop;                       --���� �� ��������

------------------------------------------------------
   DELETE FROM tmp_nbu
    where kodf=kodf_ and datf=dat_;

   INSERT INTO tmp_nbu
             ( kodf, datf, kodp, znap )
        select kodf_, dat_, kodp, znap
          from rnbu_trace;

   logger.info ('P_F2K_NN: END ');

END P_F2K_NN;
/
