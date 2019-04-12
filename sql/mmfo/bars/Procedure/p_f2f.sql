

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F2F.sql =========*** Run *** ===
PROMPT ===================================================================================== 


  CREATE OR REPLACE PROCEDURE BARS.P_F2F (dat_ IN DATE)
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    ��������� ������������ �����                  MMFO
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
%
% VERSION     :  v.19.001        11.04.2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   ��������� ����������   L DDD N R E KKK �� MMM VVV H

 1     L          1/3  (�����/����������)
 2     DDD        ������ ����������� (101,102,...202,203,...)
 5     N          R014 ��� ���� �������
 6     R          K030 �������������
 7     E          K019 ��� �����������
 8     KKK        ��� ������� �������, kodobl.ko
11     ��         K044 ��� ������
13     MMM        K040 ��� ������
16     VVV        R030 ��� ������
19     H          D110 ��� ��������

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

15.11.2018 �����: �������-�������
17.04.2018 �� ���������� DDD=211 ����������� �������� � �������� H=2  
13.11.2017 ������� �� ����� ���� ������
07.04.2017 DDD=208 ��������� ��������������� �� 2620,2625 -�� 3800
           DDD=211 ������� MMM:  ��� ����� ��=2900 ��� ������ =804
           DDD=���������� ��������: ��������� �������� � ���� ������� � ���� �����
31.03.2017 DDD=201,211 -������ ��������� ����������� ���� ������ �� ���.
                        ���������� ������ (���������� otcn_operw)
12.10.2016 ���������� ��� �������� DDD=220
11.10.2016 ��� ��������� � ���� "������ �����" ��������� ������������� �������
07.10.2016 -��� ���������� (��� 344443): ��� ������ �������� �����������
             ������������ ������ ��������� ����� risk_id =2,3
           -����.DDD=107 -������������ �������� � ��������� ����
07.09.2016 -����.DDD=212 -����������� �� ������� ����� ���������: ���������
              ������� ��������� "����������" ���������� ��� ���������
31.08.2016 -����.DDD=211 -��������� ������� ��������� "����������" ����������
              ��������� �� ��� � ���� ����������
18.08.2016 -����.212 -����������� �� ������� ����� ���������: ���������
              ������� ��������� "�����" ���������� ��� ��
17.08.2016 -����.214 -� ��������������� �� ������� 110% ��������� ����� � OB22=01
04.08.2016 -����������� � ��������� ��������� ��� ���������� (��� 344443)
20/07/2016 -���-�� �������� (���� 101-111) ����� �������� �� �������
            DDD in ('100','101' ����� ���� �������� �� ������� ���� DDD)
15/07/2016 -��������� ������������ ���� 214 �������/������ �������� (������ ��������)
11/07/2016 -��������� ������������ ����� 218, 220
            �������� ���.��������� "RIZIK" = 1 ��� 2 ��� 3
            ����� �������������� � �������� '�������'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
IS
    kodf_    varchar2(2):='2F';
    sheme_   varchar2(1):='C';
    typ_     number;
    userid_  number;
    kodp_    Varchar2(19);

    dat1_    date;
    mfo_     Varchar2(12);
    mfou_    varchar2(12);
    nbs_k    Varchar2(4);
    nbuc1_   Varchar2(12);
    nbuc_    Varchar2(12);
    ppp_     Varchar2(3);
    kkk_     Varchar2(3);
    d110_    Varchar2(1);
    acc_     Number;
    acc1_    Number;
    acck_    Number;
    nls1_    Varchar2(15);
    ob22_    Varchar2(2);
    ob22_k   Varchar2(2);
    d060_    NUMBER;

    ttd_     Varchar2(3);
    nlsdd_   Varchar2(15);
    d1#E9_   Varchar2(70);
    d2#E9_   Varchar2(70);
    d3#E9_   Varchar2(70);
    d4#E9_   Varchar2(70);
    kod_b_   Varchar2(70);

    kod_g_   Varchar2(3);
    kod_g_pb1 Varchar2(3);

    formOk_  boolean;
    comm_    varchar2 (200);
    k044_    varchar2(2);
    ref_m37  number;
    dat_m37  date;

    is_finmon    integer       default 0;   --������� ������ ��������������

    sql_acc_ clob:='';
    ret_     number;
    obl_     varchar2(10) := lpad(F_Get_Params('KODRU'),3,'0');
    OUR_OKPO_  varchar2(10) := lpad(F_Get_Params('OKPO'),8,'0');

    TYPE temp_rec_t IS TABLE OF OTCN_PROV_TEMP%rowtype;
    l_temp_rec temp_rec_t := temp_rec_t();

    TYPE ref_type_curs IS REF CURSOR;

    cur_temp        ref_type_curs;
    cursor_sql      clob;

    function is_in_country ( p_country varchar2 )
          return integer
      is
          l_country   integer;
    begin

        select count( * )  into l_country
          from country
         where lpad(to_char(country),3,'0') = p_country;

        return l_country;

    end;

    procedure p_form_pok(p_form in number, -- =1 - NBS, =2 - NBS + OB22
                         p_pok in varchar2,
                         p_typ_cust in varchar2,
                         p_typ_ap in number,
                         p_dk in number) is
       l_pok varchar2(200);
       l_country  varchar2(3);

    begin
       EXECUTE IMMEDIATE 'TRUNCATE TABLE OTCN_ACC ';
       EXECUTE IMMEDIATE 'TRUNCATE TABLE OTCN_SALDO ';
       EXECUTE IMMEDIATE 'TRUNCATE TABLE KOR_PROV';
       EXECUTE IMMEDIATE 'TRUNCATE TABLE OTCN_OPERW';

       if l_pok in ('001','002') then
          l_pok := '213';
       else
          l_pok := p_pok;
       end if;

       if l_pok = '202' then
          -- �������, ����� �� ��������
          insert /*+APPEND PARALLEL (8) */
          into OTCN_ACC (ACC, NLS, KV, NBS, RNK, DAOS, DAPP, ISP, NMS,
               LIM, PAP, TIP, VID, MDATE, DAZS, ACCC, TOBO)
          select a.acc, a.nls, a.kv, a.nbs, a.rnk, a.daos, a.dapp, a.isp, a.nms,
                 a.lim, a.pap, a.tip, a.vid, a.mdate, a.dazs, a.accc, a.tobo
          from accounts a
          where a.nbs in (select unique r020
                          from kl_f3_29 k
                          where k.kf = '2F' and
                                k.ddd = p_pok) and
                a.acc in (select c.accs
                          from pawn_acc p, cc_accp c
                          where p.deposit_id is not null and
                                p.acc = c.acc) and
                A.DAOS <= dat_ and
               (a.dazs is null or a.dazs >= dat1_) and
                a.dapp is not null and
                a.pap = p_typ_ap;
           commit;
       else
           if p_typ_cust is null then
               if p_form = 1 then
                   insert /*+APPEND */
                   into OTCN_ACC (ACC, NLS, KV, NBS, RNK, DAOS, DAPP, ISP, NMS,
                        LIM, PAP, TIP, VID, MDATE, DAZS, ACCC, TOBO)
                   select a.acc, a.nls, a.kv, a.nbs, a.rnk, a.daos, a.dapp, a.isp, a.nms,
                        a.lim, a.pap, a.tip, a.vid, a.mdate, a.dazs, a.accc, a.tobo
                   from accounts a
                   where a.nbs in (select unique r020
                                   from kl_f3_29 k
                                   where k.kf = '2F' and
                                         k.ddd = p_pok) and
                         A.DAOS <= dat_ and
                        (a.dazs is null or a.dazs >= dat1_) and
                        a.dapp is not null and
                        a.pap = p_typ_ap;
                   commit;
               else
                   insert /*+APPEND  */
                   into OTCN_ACC (ACC, NLS, KV, NBS, RNK, DAOS, DAPP, ISP, NMS,
                        LIM, PAP, TIP, VID, MDATE, DAZS, ACCC, TOBO)
                   select a.acc, a.nls, a.kv, a.nbs, a.rnk, a.daos, a.dapp, a.isp, a.nms,
                        a.lim, a.pap, a.tip, a.vid, a.mdate, a.dazs, a.accc, a.tobo
                   from accounts a
                   where (a.nbs, a.ob22) in (select unique r020, r050
                                             from kl_f3_29 k
                                             where k.kf = '2F' and
                                                     k.ddd = p_pok) and
                         A.DAOS <= dat_ and
                        (a.dazs is null or a.dazs >= dat1_) and
                        a.dapp is not null and
                        a.pap = p_typ_ap;
                   commit;
               end if;
           else
               if p_form = 1 then
                   insert /*+APPEND */
                   into OTCN_ACC (ACC, NLS, KV, NBS, RNK, DAOS, DAPP, ISP, NMS,
                        LIM, PAP, TIP, VID, MDATE, DAZS, ACCC, TOBO)
                   select a.acc, a.nls, a.kv, a.nbs, a.rnk, a.daos, a.dapp, a.isp, a.nms,
                        a.lim, a.pap, a.tip, a.vid, a.mdate, a.dazs, a.accc, a.tobo
                   from accounts a
                   where a.nbs in (select unique r020
                                   from kl_f3_29 k
                                   where k.kf = '2F' and
                                         k.ddd = p_pok and
                                         k.s240 = p_typ_cust) and
                         A.DAOS <= dat_ and
                        (a.dazs is null or a.dazs >= dat1_) and
                        a.dapp is not null and
                        a.pap = p_typ_ap;
                   commit;
               else
                   insert /*+APPEND  */
                   into OTCN_ACC (ACC, NLS, KV, NBS, RNK, DAOS, DAPP, ISP, NMS,
                        LIM, PAP, TIP, VID, MDATE, DAZS, ACCC, TOBO)
                   select a.acc, a.nls, a.kv, a.nbs, a.rnk, a.daos, a.dapp, a.isp, a.nms,
                        a.lim, a.pap, a.tip, a.vid, a.mdate, a.dazs, a.accc, a.tobo
                   from accounts a
                   where (a.nbs, a.ob22) in (select unique r020, r050
                                             from kl_f3_29 k
                                             where k.kf = '2F' and
                                                     k.ddd = p_pok and
                                                     k.s240 = p_typ_cust) and
                         A.DAOS <= dat_ and
                        (a.dazs is null or a.dazs >= dat1_) and
                        a.dapp is not null and
                        a.pap = p_typ_ap;
                   commit;
               end if;
           end if;
       end if;

       INSERT /*+APPEND PARALLEL  (8) */
       INTO OTCN_SALDO (ODATE, FDAT, ACC, NLS, KV, NBS, RNK,
               VOST, VOSTQ, OST, OSTQ,
               DOS, DOSQ, KOS, KOSQ,
               DOS96, DOSQ96, KOS96, KOSQ96,
               DOS96P, DOSQ96P, KOS96P, KOSQ96P,
               DOS99, DOSQ99, KOS99, KOSQ99, DOSZG, KOSZG, DOS96ZG, KOS96ZG, DOS99ZG, KOS99ZG)
        select dat_, fdat, a.acc, a.NLS,  a.KV, a.NBS, A.RNK,
               nvl(decode(b.fdat, dat1_, b.ostf, 0), 0),
               0,
               nvl(decode(b.fdat, dat_, b.ostf - b.dos + b.kos, 0), 0),
               0,
               nvl(b.dos, 0),
               0,
               nvl(b.Kos, 0),
               0,
               0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
       from saldoa b, OTCN_ACC a
       where b.fdat between dat1_ and dat_ and
             b.ACC = a.acc and
             decode(p_dk, 0, b.dos, b.kos)<>0;
       commit;

       if p_pok not in ('201', '211') then
           if p_typ_cust is null then
               INSERT /*+APPEND PARALLEL (8) */
               INTO  rnbu_trace(recid, kodp, znap, acc, nls, kv, rnk, ref, comm, nbuc)
               select
                    s_rnbu_record.nextval,
                    pok1||(case when segm_H = '2' then '0' else pok2 end)||pok3||segm_E||
                    (case when segm_KKK = '000' then obl_ else segm_KKK end)||
                    '10804'||segm_VVV||segm_H,
                    gl.p_icurval(kv, s, dat_), acc, nls, kv, rnk, ref, comm, nbuc_
               from (select '1'||l_pok pok1,
                        (case when ltrim(c.okpo, '0')=OUR_OKPO_
                                then (case when lower(nazn) like '%�_�%��_�%' then '3'
                                            when lower(nazn) like '%���%' then '2'
                                       else '1' end)
                                else decode(c.custtype, '3', decode(NVL(trim(c.sed),'00'),'91','2','3'), '1')
                        end) pok2,
                        decode(NVL(c.country,'804'),'804','1','2') pok3,
                        decode(substr(decode(p.dk, p_dk, nlsa, nlsb), 1, 3), '100', '2', '1') segm_H,
                        decode((case when mfo_!=344443 and trim(r.risk_id) in (2, 3, 64) then '101'
                                     when mfo_!=344443 and trim(r.risk_id) in (62, 65) then '102'
                                     when mfo_!=344443 and trim(r.risk_id) in (63) then '103'
                                     when mfo_ =344443 and trim(r.risk_id) in (2, 3) then '101'
                                      else 'XXX'
                                 end),'101','1','102','2','103','3','4')  segm_E,
                                 lpad(F_Codobl_branch(p.branch, 4),3,'0') segm_KKK,
                                 lpad(a.kv, 3, '0') segm_VVV,
                                 o.s, a.acc, a.nls, a.kv, a.rnk, p.ref,
                                 p.dk||' '||p.nlsa||' '||p.nlsb||' '||p.nazn comm
                    from opldok o, otcn_acc a, customer c, customer_risk r, oper p
                    where o.fdat between dat1_ and dat_ and
                       (o.fdat, o.acc) in (select fdat, acc from otcn_saldo) and
                        o.acc = a.acc and
                        a.rnk = c.rnk and
                        c.rnk = r.rnk(+) and
                        nvl(trim(r.risk_id(+)),0) in (2, 3, 62, 63, 64, 65) and
                        dat_ between nvl(r.dat_begin(+),dat_) and nvl(r.dat_end(+),dat_) and
                        o.dk = p_dk and
                        p.pdat between dat1_ - 10 and dat_ + 10 and
                        o.sos = 5 and
                        o.ref = p.ref);
               commit;
           else
               INSERT /*+APPEND PARALLEL (8) */
               INTO  rnbu_trace(recid, kodp, znap, acc, nls, kv, rnk, ref, comm, nbuc)
               select s_rnbu_record.nextval, pok1||segm_E||
                    (case when segm_KKK = '000' then obl_ else segm_KKK end)||
                    '10804'||segm_VVV||segm_H,
                    gl.p_icurval(kv, s, dat_), acc, nls, kv, rnk, ref, comm, nbuc_
               from (select '1'||l_pok||decode(c.custtype, '3', decode(NVL(trim(c.sed),'00'),'91','2','3'), '1')||
                        decode(NVL(c.country,'804'),'804','1','2') pok1,
                        decode(substr(decode(p.dk, p_dk, nlsa, nlsb), 1, 3), '100', '2', '1') segm_H,
                        decode((case when mfo_!=344443 and trim(r.risk_id) in (2, 3, 64) then '101'
                                     when mfo_!=344443 and trim(r.risk_id) in (62, 65) then '102'
                                     when mfo_!=344443 and trim(r.risk_id) in (63) then '103'
                                     when mfo_ =344443 and trim(r.risk_id) in (2, 3) then '101'
                                      else 'XXX'
                                 end),'101','1','102','2','103','3','4')  segm_E,
                                 lpad(F_Codobl_branch(p.branch, 4),3,'0') segm_KKK,
                                 lpad(a.kv, 3, '0') segm_VVV,
                                 o.s, a.acc, a.nls, a.kv, a.rnk, p.ref,
                                 p.dk||' '||p.nlsa||' '||p.nlsb||' '||p.nazn comm
                    from opldok o, otcn_acc a, customer c, customer_risk r, oper p
                    where o.fdat between dat1_ and dat_ and
                        (o.fdat, o.acc) in (select fdat, acc from otcn_saldo) and
                        o.acc = a.acc and
                        a.rnk = c.rnk and
                        c.rnk = r.rnk(+) and
                        nvl(trim(r.risk_id(+)),0) in (2, 3, 62, 63, 64, 65) and
                        dat_ between nvl(r.dat_begin(+),dat_) and nvl(r.dat_end(+),dat_) and
                        o.dk = p_dk and
                        o.sos = 5 and
                        o.ref = p.ref and
                        p.pdat between dat1_ - 10 and dat_ + 10);
               commit;
           end if;
       elsif p_pok = '201' then
           insert /*+APPEND */
           into KOR_PROV (REF, DK, ACC, S, FDAT)
           select  /*+ leading(s)*/ o.ref, o.dk, o.acc, o.s, o.fdat
           from opldok o, otcn_saldo s
           where o.fdat between dat1_ and dat_ and
                 o.fdat = s.fdat and
                 o.acc = s.acc and
                 o.sos = 5;
           commit;

-------------------------------------------------------------------------
           for k in ( select /*+ parallel (8) */ref
                      from operw o
                       where o.ref in (select k.ref from kor_prov k)
                         and ( tag LIKE 'n%' or
                               tag LIKE 'D6#7%' or
                               tag = 'KOD_G' or
                               tag = '50F' or
                               tag = '52A' )
                       group by ref
                    )
           loop
              l_country := '   ';

              begin
                SELECT translate(trim(value),'1234567890OP��', '1234567890')
                  into l_country
                  FROM OPERW
                 WHERE REF = k.ref
                   AND TAG like 'n%' and rownum=1;

              exception
                 when others then
                    l_country := '   ';
              end;

              if trim(l_country) is null  then
                    begin
                      SELECT translate(trim(value),'1234567890OP��', '1234567890')
                        into l_country
                        FROM OPERW
                       WHERE REF = k.ref
                         AND TAG = 'KOD_G' and rownum=1;

                    exception
                       when others then
                          l_country := '   ';
                    end;
              end if;

              if trim(l_country) is null  then
                    begin
                      SELECT lpad(translate(trim(value),'1234567890OP��', '1234567890'),3,'0')
                        into l_country
                        FROM OPERW
                       WHERE REF = k.ref
                         AND TAG like 'D6#7%' and rownum=1;

                    exception
                       when others then
                          l_country := '   ';
                    end;
              end if;

              if trim(l_country) is null  then
                    begin
                      select l.k040
                        into l_country
                        from ( SELECT ref, value,
                                      substr(trim(value), instr(UPPER(trim(value)),'3/')+2, 2) swift_k
                                 FROM OPERW
                                WHERE REF = k.ref
                                  AND TAG = '50F' and rownum=1
                             ) o, kl_k040 l
                       where o.swift_k = l.a2;

                    exception
                       when others then
                          l_country := '   ';
                    end;
              end if;

              if trim(l_country) is null  then
                    begin
                      select l.k040
                        into l_country
                        from ( SELECT ref, value,
                                      substr(trim(value), 1, 8) swift_k
                                 FROM OPERW
                                WHERE REF = k.ref
                                  AND TAG = '52A' and rownum=1
                             ) o, rc_bnk l
                         where o.swift_k = l.swift_code
                            or        substr(o.swift_k,1,4)||' '||substr(o.swift_k,5,2)
                               ||' '||substr(o.swift_k,7,2) = l.swift_code;

                    exception
                       when others then l_country :='804';

                    end;
              end if;

              if is_in_country(l_country)!=0 and trim(l_country) is not null then

                  insert into otcn_operw (ref, value)
                       values (k.ref, l_country);
              end if;

           end loop;

            commit;

            INSERT /*+APPEND  parallel(8) */
            INTO  rnbu_trace(recid, kodp, znap, acc, nls, kv, rnk, ref, comm, nbuc, isp)
            select s_rnbu_record.nextval,
                pok1 || pok2  ||
                pok3 || segm_E||
                (case when segm_KKK = '000' and segm_MMM = '804' then obl_
                      when segm_MMM <> '804' then '000'
                      else segm_KKK end)||
                nvl(b.k044, '25')||segm_MMM||segm_VVV||segm_H,
                gl.p_icurval(kv, s, dat_), acc, nls, kv, rnk, ref, comm, nbuc_, p_dk
            from (select /*+ leading(o) hash(o) */
                    '1'||l_pok pok1,
                    (case when ltrim(c.okpo, '0')=OUR_OKPO_
                            then (case when lower(nazn) like '%�_�%��_�%' then '3'
                                       when lower(nazn) like '%���%' then '2'
                                    else '1' end)
                            else decode(c.custtype, '3', decode(NVL(trim(c.sed),'00'),'91','2','3'), '1')
                    end) pok2,
                    decode(NVL(c.country,'804'),'804','1','2') pok3,
                    (case when substr(decode(p.dk, p_dk, nlsa, nlsb), 1, 3) = '100' and
                               NVL(w.value,'804') = '804'
                            then '2'
                            else '1'
                    end) segm_H,
                    decode((case when mfo_!=344443 and trim(r.risk_id) in (2, 3, 64) then '101'
                                 when mfo_!=344443 and trim(r.risk_id) in (62, 65) then '102'
                                 when mfo_!=344443 and trim(r.risk_id) in (63) then '103'
                                 when mfo_ =344443 and trim(r.risk_id) in (2, 3) then '101'
                                  else 'XXX'
                    end),'101','1','102','2','103','3','4')  segm_E,
                    lpad(F_Codobl_branch(p.branch, 4),3,'0') segm_KKK,
                    lpad(a.kv, 3, '0') segm_VVV,
                    decode(substr(p.nlsb,1,4),'2900','804',lpad(NVL(w.value,'804'), 3, '0')) segm_MMM,
                    o.s, a.acc, a.nls, a.kv, a.rnk, p.ref,
                    p.dk||' '||p.nlsa||' '||p.nlsb||' '||p.nazn comm
                from kor_prov o, otcn_acc a, customer c, customer_risk r, oper p, otcn_operw w
                where o.acc = a.acc and
                    a.rnk = c.rnk and
                    c.rnk = r.rnk(+) and
                    nvl(trim(r.risk_id(+)),0) in (2, 3, 62, 63, 64, 65) and
                    dat_ between nvl(r.dat_begin(+),dat_) and nvl(r.dat_end(+),dat_) and
                    o.dk = p_dk and
                    p.sos = 5 and
                    o.ref = p.ref and
                    p.pdat between dat1_ - 10 and dat_ + 10 and
                    o.ref = w.ref(+)) a, KL_K044N b
           where a.segm_MMM = b.k040(+);
           commit;

       elsif p_pok = '211' then
           insert /*+APPEND */
           into KOR_PROV (REF, DK, ACC, S, FDAT)
           select  /*+ leading(s)*/ o.ref, o.dk, o.acc, o.s, o.fdat
           from opldok o, otcn_saldo s
           where o.fdat between dat1_ and dat_ and
                 o.fdat = s.fdat and
                 o.acc = s.acc and
                 o.sos = 5;
           commit;

-------------------------------------------------------------------------
           for k in ( select /*+ parallel (8) */ref from operw o
                       where exists ( select 1 from kor_prov k where k.ref=o.ref)
                         and ( tag LIKE 'n%' or
                               tag LIKE 'D6#7%' or
                               tag = 'KOD_G' or
                               tag = '50F' or
                               tag = '52A' )
                       group by ref
                    )
           loop
              l_country := '   ';

              begin
                SELECT translate(trim(value),'1234567890OP��', '1234567890')
                  into l_country
                  FROM OPERW
                 WHERE REF = k.ref
                   AND TAG like 'n%' and rownum=1;

              exception
                 when others then
                    l_country := '   ';
              end;

              if trim(l_country) is null  then
                    begin
                      SELECT translate(trim(value),'1234567890OP��', '1234567890')
                        into l_country
                        FROM OPERW
                       WHERE REF = k.ref
                         AND TAG = 'KOD_G' and rownum=1;

                    exception
                       when others then
                          l_country := '   ';
                    end;
              end if;

              if trim(l_country) is null  then
                    begin
                      SELECT lpad(translate(trim(value),'1234567890OP��', '1234567890'),3,'0')
                        into l_country
                        FROM OPERW
                       WHERE REF = k.ref
                         AND TAG like 'D6#7%' and rownum=1;

                    exception
                       when others then
                          l_country := '   ';
                    end;
              end if;

              if trim(l_country) is null  then
                    begin
                      select l.k040
                        into l_country
                        from ( SELECT ref, value,
                                      substr(trim(value), instr(UPPER(trim(value)),'3/')+2, 2) swift_k
                                 FROM OPERW
                                WHERE REF = k.ref
                                  AND TAG = '50F' and rownum=1
                             ) o, kl_k040 l
                       where o.swift_k = l.a2;

                    exception
                       when others then
                          l_country := '   ';
                    end;
              end if;

              if trim(l_country) is null  then
                    begin
                      select l.k040
                        into l_country
                        from ( SELECT ref, value,
                                      substr(trim(value), 1, 8) swift_k
                                 FROM OPERW
                                WHERE REF = k.ref
                                  AND TAG = '52A' and rownum=1
                             ) o, rc_bnk l
                         where o.swift_k = l.swift_code
                            or        substr(o.swift_k,1,4)||' '||substr(o.swift_k,5,2)
                               ||' '||substr(o.swift_k,7,2) = l.swift_code;

                    exception
                       when others then l_country :='804';

                    end;
              end if;

              if is_in_country(l_country)!=0 and trim(l_country) is not null then

                  insert into otcn_operw (ref, value)
                       values (k.ref, l_country);
              end if;

           end loop;

            commit;

            INSERT /*+APPEND parallel(8) */
            INTO  rnbu_trace(recid, kodp, znap, acc, nls, kv, rnk, ref, comm, nbuc)
            select s_rnbu_record.nextval,
                pok1||(case when segm_H = '2' then '0' else pok2 end)||pok3||segm_E||
                (case when segm_KKK = '000' and segm_MMM = '804' then obl_
                      when segm_MMM <> '804' then '000'
                      else segm_KKK end)||
                nvl(b.k044, '25')||segm_MMM||segm_VVV||segm_H,
                gl.p_icurval(kv, s, dat_), acc, nls, kv, rnk, ref, comm, nbuc_
            from (select /*+ leading(o) hash(o) */
                    '1'||l_pok pok1,
                    (case when ltrim(c.okpo, '0')=OUR_OKPO_
                            then (case when lower(nazn) like '%�_�%��_�%' then '3'
                                       when lower(nazn) like '%���%' then '2'
                                    else '1' end)
                            else decode(c.custtype, '3', decode(NVL(trim(c.sed),'00'),'91','2','3'), '1')
                    end) pok2,
                    decode(NVL(c.country,'804'),'804','1','2') pok3,
                    (case when substr(decode(p.dk, p_dk, nlsa, nlsb), 1, 3) = '100' and
                               NVL(w.value,'804') = '804'
                            then '2'
                            else '1'
                    end) segm_H,
                    decode((case when mfo_!=344443 and trim(r.risk_id) in (2, 3, 64) then '101'
                                 when mfo_!=344443 and trim(r.risk_id) in (62, 65) then '102'
                                 when mfo_!=344443 and trim(r.risk_id) in (63) then '103'
                                 when mfo_ =344443 and trim(r.risk_id) in (2, 3) then '101'
                                  else 'XXX'
                             end),'101','1','102','2','103','3','4')  segm_E,
                             lpad(F_Codobl_branch(p.branch, 4),3,'0') segm_KKK,
                             lpad(a.kv, 3, '0') segm_VVV,
                    decode(substr(p.nlsb,1,4),'2900','804',lpad(NVL(w.value,'804'), 3, '0')) segm_MMM,
--                                                           lpad(NVL(w.value,'804'), 3, '0') segm_MMM,
                             o.s, a.acc, a.nls, a.kv, a.rnk, p.ref,
                             p.dk||' '||p.nlsa||' '||p.nlsb||' '||p.nazn comm,
                             p.mfoa, p.mfob, p.nlsb, p.tt
                from kor_prov o, otcn_acc a, customer c, customer_risk r, oper p, otcn_operw w
                where o.acc = a.acc and
                    a.rnk = c.rnk and
                    c.rnk = r.rnk(+) and
                    nvl(trim(r.risk_id(+)),0) in (2, 3, 62, 63, 64, 65) and
                    dat_ between nvl(r.dat_begin(+),dat_) and nvl(r.dat_end(+),dat_) and
                    o.dk = p_dk and
                    p.sos = 5 and
                    o.ref = p.ref and
                    p.pdat between dat1_ - 10 and dat_ + 10 and
                    o.ref = w.ref(+)) a, KL_K044N b
           where a.segm_MMM = b.k040(+)
             and (  a.segm_MMM <> '804'
                 or a.mfoa <> a.mfob
                 or mfo_ = 300465 and a.tt like 'IBO%'
                 or mfo_ = 344443 and a.nlsb like '29092000000001%' );
           commit;

--    ���������� ���i������ ������i� � ��������� 211  
           delete from rnbu_trace
            where kodp like '_211%2';

           -- �������� �� ����� ���� ��� 209 ���������
           insert into rnbu_trace(RECID, USERID, NLS, KV, ODATE, KODP, ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO)
           select s_rnbu_record.nextval, USERID, NLS, KV, ODATE, '1209'||substr(KODP, 5), ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO
           from rnbu_trace
           where kodp like '1211%' and
                kodp not like '1211________804%';
       end if;
    end;
BEGIN
   commit;

   EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
   EXECUTE IMMEDIATE 'ALTER SESSION SET SORT_AREA_SIZE = 131072';

   -------------------------------------------------------------------
   logger.info ('P_F2F: Begin for '||to_char(dat_,'dd.mm.yyyy'));

   userid_ := user_id;

   EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
   mfo_ := F_OURMFO();
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

   Dat1_ := add_months(TRUNC(Dat_,'MM'),-2); -- ������� ��������
   --Dat1_ := to_date('30052016','ddmmyyyy');

   if mfo_ = 344443 then
      sheme_ := 'D';
--                      ���� ������� �������������� ���������� �� ���  ��
      is_finmon := 1;
   else

      is_finmon := 0;
   end if;

   -- ��������� ������������ �����
   p_proc_set(kodf_,sheme_, nbuc1_, typ_);

   nbuc_ := nbuc1_;

   ------  ����� �������
   -- ������ �����
   -- 20/07/2016 ���������� ���� "DDD" 100 � 101 �� KL_F3_29
   insert /*+APPEND PARALLEL (8) */
   into rnbu_trace(recid, kodp, znap, rnk, comm, nbuc)
   select s_rnbu_record.nextval,
        '3'||pok||'00'||decode(pok,'101','1','102','2','103','3','0')||
        '000000000000' kodp,
        to_char(cnt) znap, rnk, nmk, nbuc_
   from (
       select c.rnk,
            (case when trim(r.risk_id) in (2, 3, 64) then '101'
                  when trim(r.risk_id) in (62, 65) then '102'
                  when trim(r.risk_id) in (63) then '103'
                  else 'XXX'
             end) pok,
            1 cnt,
            trim(c.okpo) || '  ' || trim(c.nmk) nmk
       from customer c
       join (select *
             from customer_risk
             where (   mfo_!=344443 and trim(risk_id) in (2, 3, 62, 63, 64, 65)
                    or mfo_ =344443 and trim(risk_id) in (2, 3) )
               and  dat_ between nvl(dat_begin, dat_) and nvl(dat_end, dat_)) r
       on (c.rnk = r.rnk)
       where nvl(c.date_off, dat_+1) > dat_
         and (   c.country  ='804'  and
                               ( ltrim(c.okpo, '0') is null
                                      or ltrim(c.okpo,'0') is not null
                                       and ltrim(c.okpo,'0') != OUR_OKPO_)
              or c.country !='804' )
         and exists (select 1
                    from accounts a
                    where a.nbs in (select unique r020
                                  from kl_f3_29
                                  where kf='2F' and
                                    ddd in ('100','101'))
                       and a.rnk = c.rnk
                       and a.daos <= dat_
                       and (a.dazs is null or a.dazs > dat_))
       group by c.rnk,
            (case when trim(r.risk_id) in (2, 3, 64) then '101'
                  when trim(r.risk_id) in (62, 65) then '102'
                  when trim(r.risk_id) in (63) then '103'
                  else 'XXX'
             end), trim(c.okpo) || '  ' || trim(c.nmk));

   logger.info ('P_F2F: part 1.1 '||to_char(dat_,'dd.mm.yyyy'));

   -- ������� �� ������
   -- 20/07/2016 ���������� ���� "DDD" 100 � 101 �� Kl_F3_29
   insert /*-+APPPEND PARALLEL (2) */
    into rnbu_trace(recid, kodp, znap, rnk, comm, nbuc)
    select s_rnbu_record.nextval,
           '3' ||
               (case when lower(trim(rizik_value)) like '%�������%' then '104'
                     when lower(trim(rizik_value)) like '%������_�%' then '105'
                     when lower(trim(rizik_value)) like '%�_�����%' then '106'
                     when lower(trim(rizik_value)) like '%�����������%�_�%' then '106'
                      else decode( mfo_, 344443,'108','104' )
                    end) ||
               '000'||
               '000000000000' kodp,
           to_char(1) znap,
           rnk,
           trim(okpo) || '  ' || trim(nmk) nmk,
           nbuc_
    from   (select c.rnk, c.nmk, c.okpo,
                   min(decode(trim(u.value), '1', '�������',
                                             '2', '�������',
                                             '3', '�������',
                       trim(u.value))) keep (dense_rank last order by u.chgdate) rizik_value
            from   customer c
            join   customerw_update u on u.rnk = c.rnk and
                                         u.tag = 'RIZIK' and
                                         u.chgaction in (1, 2) and
                                         trunc(u.chgdate) <= dat_
            where nvl(c.date_off, dat_+1) > dat_
              and (   c.country  ='804'  and
                               ( ltrim(c.okpo, '0') is null
                                      or ltrim(c.okpo,'0') is not null
                                       and ltrim(c.okpo,'0') != OUR_OKPO_)
                   or c.country !='804' )
              and exists (select 1
                         from accounts a
                         where a.nbs in (select unique r020
                                         from   kl_f3_29
                                         where  kf='2F' and
                                                ddd in ('100','101'))
                            and a.rnk = c.rnk
                            and a.daos <= dat_
                            and (a.dazs is null or a.dazs > dat_))
            group by c.rnk, c.okpo, c.nmk);

--   ��������� ������ "����������� �������"
   insert /*-+APPPEND PARALLEL (2) */
      into rnbu_trace(recid, kodp, znap, rnk, comm, nbuc)
    select s_rnbu_record.nextval,
           '3' || '107' || '000'|| '000000000000' kodp,
           to_char(1) znap,
           rnk,
           trim(okpo) || '  ' || trim(nmk) nmk, nbuc_
      from ( select c.rnk, c.nmk, c.okpo,
                    min(decode(trim(u.value), '1', '�������',
                                              '2', '�������',
                                              '3', '�������',
                       trim(u.value))) keep (dense_rank last order by u.chgdate) rizik_value
               from customer c
               join     customerw_update u on
                           u.rnk = c.rnk
                       and u.tag = 'RIZIK'
                       and u.chgaction in (1, 2)
                       and trunc(u.chgdate) <= dat_
              where nvl(c.date_off, dat_+1) > dat_
                and (   c.country  ='804'  and
                               ( ltrim(c.okpo, '0') is null
                                      or ltrim(c.okpo,'0') is not null
                                       and ltrim(c.okpo,'0') != OUR_OKPO_)
                     or c.country !='804' )
                and exists (select 1
                              from accounts a
                             where a.nbs in (select unique r020
                                               from kl_f3_29
                                              where kf='2F'
                                                and ddd in ('100','101'))
                               and a.rnk = c.rnk
                               and a.daos <= dat_
                               and (a.dazs is null or a.dazs > dat_))
              group by c.rnk, c.okpo, c.nmk
           )
     where lower(trim(rizik_value)) like '%�����������%�_�%';

   logger.info ('P_F2F: part 1.2 '||to_char(dat_,'dd.mm.yyyy'));

   -- ������������� RNK �� �������� � ���� 104-108 (��� ��������� RIZIK)
   insert /*+APPEND PARALLEL (8) */
   into rnbu_trace(recid, kodp, znap, rnk, comm, nbuc)
   select s_rnbu_record.nextval,
        '3'||decode( mfo_, 344443,'108','104' )||'000'||
        '000000000000' kodp,
        to_char(cnt) znap, rnk, nmk, nbuc_
   from (
         select c.rnk,
                1 cnt,
                trim(c.okpo) || '  ' || trim(c.nmk) nmk
         from customer c
         where nvl(c.date_off, dat_+1) > dat_
           and (   c.country  ='804'  and
                               ( ltrim(c.okpo, '0') is null
                                      or ltrim(c.okpo,'0') is not null
                                       and ltrim(c.okpo,'0') != OUR_OKPO_)
                or c.country !='804' )
           and c.rnk not in (select rnk from rnbu_trace
                             where substr(kodp, 1, 4) in ('3104','3105','3106',
                                                          '3107','3108')
                            ) and
               exists (select 1
                       from accounts a
                       where a.nbs in ( select unique r020
                                          from kl_f3_29
                                         where kf='2F'
                                           and ddd in ('100','101') )
                         and a.rnk = c.rnk
                         and a.daos <= dat_
                         and (a.dazs is null or a.dazs > dat_)
                      )
        );

   -- ����� ���� �� ������������ ����������� 109, 110, 111
   insert /*+APPEND PARALLEL (8) */
   into rnbu_trace(recid, kodp, znap, rnk, comm, nbuc)
   select s_rnbu_record.nextval,
        '3'||pok||'00'||
        '000000000000' kodp,
        to_char(cnt) znap, rnk, nmk, nbuc_
   from (
       select c.rnk,
            (case when c.custtype in (1,2) then '1091'
                  when c.custtype = 3 and NVL(trim(c.sed), '00') = '91' then '1112'
                  when c.custtype = 3 and NVL(trim(c.sed), '00') <> '91' then '1103'
                  else '1091'
             end) pok,
            1 cnt,
            c.nmk nmk
       from customer c
       where nvl(c.date_off, dat_+1) > dat_
         and (   c.country  ='804'  and
                               ( ltrim(c.okpo, '0') is null
                                      or ltrim(c.okpo,'0') is not null
                                       and ltrim(c.okpo,'0') != OUR_OKPO_)
              or c.country !='804' )
         and exists (select 1
                    from accounts a
                    where a.nbs in ( select unique r020
                                     from kl_f3_29
                                     where kf='2F' and
                                           ddd in ('100','101') )
                       and a.rnk = c.rnk
                       and a.daos <= dat_
                       and (a.dazs is null or a.dazs > dat_))
       group by c.rnk,
            (case when c.custtype in (1,2) then '1091'
                  when c.custtype = 3 and NVL(trim(c.sed), '00') = '91' then '1112'
                  when c.custtype = 3 and NVL(trim(c.sed), '00') <> '91' then '1103'
                  else '1091'
             end), c.nmk);

   delete from tmp_nbu where datf = dat_ and kodf = kodf_;

   INSERT INTO tmp_nbu(datf, kodf, kodp, znap, nbuc)
   select Dat_, kodf_, kodp, to_char(sum(to_number(znap))), nbuc
   from rnbu_trace
   where kodp like '3%'
   group by kodp, nbuc;

   logger.info ('P_F2F: part 1.3 '||to_char(dat_,'dd.mm.yyyy'));

   ------  ����� �������
   -- �������� 201 ����� �������� �������
   p_form_pok(1, '201', null, 2, 1);

   logger.info ('P_F2F: part 1.4 '||to_char(dat_,'dd.mm.yyyy'));

   -- �������� 201 ����� ������� �������
   p_form_pok(1, '201', null, 2, 0);

   logger.info ('P_F2F: part 1.5 '||to_char(dat_,'dd.mm.yyyy'));

-----------------------------------------
   -- ���� ��� ����� ���� ����� ��� ����������� (��� 201)
    merge into rnbu_trace r
    using ( select /* leading(ad) */
                         od.ref,
                         NVL(substr(trim(w.value),1,3),'804') country,
                         NVL(b.k044,'25') k044
                  from opldok od, accounts ad, opldok ok, accounts ak,
                       zay_debt z, kl_k044N b, operw w
                  where od.fdat between dat1_-3 and dat_ and
                        od.dk = 0 and
                        od.sos = 5 and
                        od.acc = ad.acc and
                        ok.fdat between dat1_-3 and dat_ and
                        od.ref = ok.ref and
                        od.fdat = ok.fdat and
                        od.stmt = ok.stmt and
                        ok.dk = 1 and
                        ok.sos = 5 and
                        ok.acc = ak.acc and
                        ad.nbs like '2603%' and
                        ak.nbs like '2600%' and
                        od.ref = z.refd and
                        z.ref = w.ref(+) and
                        w.tag like 'D6#70%'and
                        substr(trim(w.value), 1, 3) = b.k040(+) and
                        NVL(substr(trim(w.value),1,3),'804') <> '804'
                ) k
    on (r.ref = k.ref)
    when matched then update set r.kodp = substr(r.kodp,1,7) || '000' || k.k044 || k.country || substr(r.kodp,16)
    where r.kodp like '1201%';

   logger.info ('P_F2F: part 1.6 '||to_char(dat_,'dd.mm.yyyy'));

   -- ����������� � ����� ���� ��� 210 ���������
   insert into rnbu_trace(RECID, USERID, NLS, KV, ODATE, KODP, ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO)
   select s_rnbu_record.nextval, USERID, NLS, KV, ODATE, '1210'||substr(KODP, 5), ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO
   from rnbu_trace
   where kodp like '1201%' and
         isp = 1 and  -- (�� �������)
         kodp not like '1201________804%';

   logger.info ('P_F2F: part 1.7 '||to_char(dat_,'dd.mm.yyyy'));

   -- ����������� � ����� ���� ��� 212 ���������
   insert into rnbu_trace(RECID, USERID, NLS, KV, ODATE, KODP, ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO)
   select s_rnbu_record.nextval, USERID, NLS, KV, ODATE, '1212'||substr(KODP, 5, 14)||'1', ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO
   from rnbu_trace
   where kodp like '1201%' and
         isp = 1 and  -- (�� �������)
         kodp not like '1201________804%';

   logger.info ('P_F2F: part 1.8 '||to_char(dat_,'dd.mm.yyyy'));

   -- � ����� ������ ����� ���������� ��� 212 ���������
   insert into rnbu_trace(RECID, USERID, NLS, KV, ODATE, KODP, ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO)
   select /*+ leading(r) index(p, PK_OPER) */
        s_rnbu_record.nextval, r.USERID, r.NLS, r.KV, r.ODATE,
       '1212'||substr(KODP, 5, 14)||'1', r.ZNAP, r.NBUC, r.ISP, r.RNK, r.ACC, r.REF,
        r.COMM, r.ND, r.MDATE, r.TOBO
   from rnbu_trace r, oper p
   where r.kodp like '1201________804%'
     and r.isp = 1        -- (�� �������)
     and r.ref = p.ref
     and p.pdat between dat1_ - 10 and dat_ + 10
     and (    p.mfoa <> p.mfob
           or mfo_ =344443  and  p.nlsa like '1500%'
           or mfo_ =300465  and  p.nlsa like '373980501061%'
         );
-----------------------------------------

   logger.info ('P_F2F: part 2.1 '||to_char(dat_,'dd.mm.yyyy'));

   -- �������� 202 ����� ������� �������
   p_form_pok(1, '202', null, 1, 0);

   logger.info ('P_F2F: part 2.2 '||to_char(dat_,'dd.mm.yyyy'));

   -- �������� 204 ����� �������� �������
   p_form_pok(2, '204', null, 2, 1);

   logger.info ('P_F2F: part 2.3 '||to_char(dat_,'dd.mm.yyyy'));

   -- �������� 205 ����� ������� �������
   p_form_pok(2, '205', null, 2, 1);

   logger.info ('P_F2F: part 2.4 '||to_char(dat_,'dd.mm.yyyy'));

   -- �������� 206 ����� ������� �������
   p_form_pok(2, '206', null, 1, 0);

   logger.info ('P_F2F: part 2.5 '||to_char(dat_,'dd.mm.yyyy'));

   -- ������ - ������ �������� ������
   INSERT /*+APPEND */
   INTO  rnbu_trace(recid, kodp, znap, acc, nls, kv, rnk, ref, comm, nbuc)
   select s_rnbu_record.nextval, pok1||segm_E||
        (case when segm_KKK = '000' then obl_ else segm_KKK end)||
        '10804'||segm_VVV||segm_H,
        gl.p_icurval(kv, s, dat_), acc, nls, kv, rnk, ref,
        comm, nbuc_
   from (
    select /*+ordered*/
        '1207'||'3'||
        decode(NVL(c.country,'804'),'804','1','2')  pok1,
        '2' segm_H,
        decode((case when mfo_!=344443 and trim(r.risk_id) in (2, 3, 64) then '101'
                     when mfo_!=344443 and trim(r.risk_id) in (62, 65) then '102'
                     when mfo_!=344443 and trim(r.risk_id) in (63) then '103'
                     when mfo_ =344443 and trim(r.risk_id) in (2, 3) then '101'
                      else 'XXX'
                 end),'101','1','102','2','103','3','4')  segm_E,
                 lpad(F_Codobl_branch(p.branch, 4),3,'0') segm_KKK,
                 lpad(a.kv, 3, '0') segm_VVV,
                                  o.s, a1.acc, a1.nls, a1.kv, a1.rnk, p.ref,
                 p.dk||' '||p.nlsa||' '||p.nlsb||' '||p.nazn comm
    from opldok o, accounts a, opldok o1, accounts a1, customer c, customer_risk r, oper p
    where o.fdat between dat1_ and dat_ and
        o.ref in (select ref from OTCN_TRACE_39 where datf between dat1_ and dat_) and
        o.acc = a.acc and
        a.nls like '3800%' and
        a1.rnk = c.rnk and
        c.rnk = r.rnk(+) and
        nvl(trim(r.risk_id(+)),0) in (2, 3, 62, 63, 64, 65) and
        o.ref = p.ref and
        p.pdat between dat1_ - 10 and dat_ + 10 and
        o1.fdat between dat1_ and dat_ and
        o.ref = o1.ref and
        o.fdat = o1.fdat and
        o.stmt = o1.stmt and
        o.dk <> o1.dk and
        o1.acc = a1.acc);
   commit;

   logger.info ('P_F2F: part 2.6.1 '||to_char(dat_,'dd.mm.yyyy'));

   -- ������ ����������� ������
   INSERT /*+APPEND */
   INTO  rnbu_trace(recid, kodp, znap, acc, nls, kv, rnk, ref, comm, nbuc)
   select s_rnbu_record.nextval,
        pok1||segm_E||
        (case when segm_KKK = '000' then obl_ else segm_KKK end)||
        '10804'||segm_VVV||segm_H,
        decode(kv, 980, s, gl.p_icurval(kv, s, dat_)),
        acc, nls, kv, rnk, ref, comm, nbuc_
    from (
    select '1208'||decode(c.custtype, 3, decode(NVL(trim(c.sed),'00'),'91','2','3'), '1')||
        decode(NVL(c.country,'804'),'804','1','2')  pok1,
        '1' segm_H,
        decode((case when mfo_!=344443 and trim(r.risk_id) in (2, 3, 64) then '101'
                     when mfo_!=344443 and trim(r.risk_id) in (62, 65) then '102'
                     when mfo_!=344443 and trim(r.risk_id) in (63) then '103'
                     when mfo_ =344443 and trim(r.risk_id) in (2, 3) then '101'
                      else 'XXX'
                 end),'101','1','102','2','103','3','4')  segm_E,
                 lpad(F_Codobl_branch(a.branch, 4),3,'0') segm_KKK,
                 lpad(a.kv_doc, 3, '0') segm_VVV,
                 a.s, a.acc, a.nls, a.kv, a.rnk, a.ref, a.comm
    from (
    select /* leading(ad) index(od,IDX_OPLDOK_KF_FDAT_ACC)  */
        od.ref, od.s, ak.acc, ak.nls, ak.kv, ak.rnk,
        p.kv kv_doc, p.branch,
        p.dk||' '||p.nlsa||' '||p.nlsb||' '||p.kv||' '||p.kv2||' '||p.nazn comm
    from opldok od, accounts ad, opldok ok, accounts ak, oper p
    where od.fdat between dat1_ and dat_ and
        od.dk = 0 and
        od.sos = 5 and
        od.acc = ad.acc and
        ok.fdat between dat1_ and dat_ and
        od.ref = ok.ref and
        od.fdat = ok.fdat and
        od.stmt = ok.stmt and
        ok.dk = 1 and
        ok.sos = 5 and
        ok.acc = ak.acc and
        od.ref = p.ref and
        ad.nbs = '2900' and
        ak.nbs in ('1600', '1602', '2520', '2530',
                   '2541', '2542', '2544', '2545',
                   '2600', '2602', '2620', '2650') and
        p.kv not in (959, 961, 962, 964, 980) and
        p.pdat between dat1_ - 10 and dat_ + 10 and
        p.sos = 5 and
        LOWER (TRIM (p.nazn)) not like '%�������%' and
        LOWER (TRIM (p.nazn)) not like '%�������%' and
        LOWER (TRIM (p.nazn)) not like '%�� ������� _���_%'
    ) a,
        customer c, customer_risk r
   where a.rnk = c.rnk and
         c.rnk = r.rnk(+) and
         nvl(trim(r.risk_id(+)),0) in (2, 3, 62, 63, 64, 65)
        );

   logger.info ('P_F2F: part 2.6.2 '||to_char(dat_,'dd.mm.yyyy'));

   -- ������ ����������� ������
   INSERT /*+APPEND */
   INTO  rnbu_trace(recid, kodp, znap, acc, nls, kv, rnk, ref, comm, nbuc)
   select s_rnbu_record.nextval,
        pok1||segm_E||
        (case when segm_KKK = '000' then obl_ else segm_KKK end)||
        '10804'||segm_VVV||segm_H,
        decode(kv, 980, s, gl.p_icurval(kv, s, dat_)),
        acc, nls, kv, rnk, ref, comm, nbuc_
    from (
    select '1208'||decode(c.custtype, 3, decode(NVL(trim(c.sed),'00'),'91','2','3'), '1')||
        decode(NVL(c.country,'804'),'804','1','2')  pok1,
        '1' segm_H,
        decode((case when mfo_!=344443 and trim(r.risk_id) in (2, 3, 64) then '101'
                     when mfo_!=344443 and trim(r.risk_id) in (62, 65) then '102'
                     when mfo_!=344443 and trim(r.risk_id) in (63) then '103'
                     when mfo_ =344443 and trim(r.risk_id) in (2, 3) then '101'
                      else 'XXX'
                 end),'101','1','102','2','103','3','4')  segm_E,
                 lpad(F_Codobl_branch(a.branch, 4),3,'0') segm_KKK,
                 lpad(a.kv_doc, 3, '0') segm_VVV,
                 a.s, a.acc, a.nls, a.kv, a.rnk, a.ref, a.comm
    from (select od.ref, od.s, ad.acc, ad.nls, p.kv, ad.rnk,
                p.kv kv_doc, p.branch,
                p.dk||' '||p.nlsa||' '||p.nlsb||' '||p.kv||' '||p.kv2||' '||p.nazn comm
            from opldok od, accounts ad, opldok ok, accounts ak, oper p
            where od.fdat between dat1_ and dat_ and
                od.dk = 0 and
                od.sos = 5 and
                od.acc = ad.acc and
                ok.fdat between dat1_ and dat_ and
                od.ref = ok.ref and
                od.fdat = ok.fdat and
                od.stmt = ok.stmt and
                ok.dk = 1 and
                ok.sos = 5 and
                ok.acc = ak.acc and
                od.ref = p.ref and
                (ad.nbs in ('1600', '1602', '2520', '2530',
                            '2541', '2544', '2600', '2603',
                            '2620', '2650', '3640',
                            '2043','2063','2301','2303','2390' )
                                      --'2062','2063','2072','2073')
                  and  ak.nbs = '2900' or
                ad.nbs = '2610'
                  and  ak.nbs = '3800') and
                p.kv not in (959, 961, 962, 964, 980) and
                p.pdat between dat1_ - 10 and dat_ + 10 and
                p.sos = 5 and
                LOWER (TRIM (p.nazn)) not like '%�������%' and
                LOWER (TRIM (p.nazn)) not like '%�������%' and
                LOWER (TRIM (p.nazn)) not like '%�� ������� _���_%') a,
                customer c, customer_risk r
           where a.rnk = c.rnk and
                 c.rnk = r.rnk(+) and
                 nvl(trim(r.risk_id(+)),0) in (2, 3, 62, 63, 64, 65)
                );

   logger.info ('P_F2F: part 2.7 '||to_char(dat_,'dd.mm.yyyy'));

   -- �������� 211 ����� ������� �������
   p_form_pok(1, '211', null, 2, 0);

   logger.info ('P_F2F: part 2.8.1 '||to_char(dat_,'dd.mm.yyyy'));

   -- �������� 213 ����� ������� �������
   p_form_pok(2, '001', null, 2, 1);

   logger.info ('P_F2F: part 2.8.2 '||to_char(dat_,'dd.mm.yyyy'));

   p_form_pok(2, '002', null, 1, 0);

   logger.info ('P_F2F: part 2.8.3 '||to_char(dat_,'dd.mm.yyyy'));

   -- ������ ��������� ������
   INSERT /*+APPEND NOPARALLEL*/
   INTO  rnbu_trace(recid, kodp, znap, acc, nls, kv, rnk, ref, comm, nbuc)
   select s_rnbu_record.nextval, pok1||segm_E||
        (case when segm_KKK = '000' then obl_ else segm_KKK end)||
        '10804'||segm_VVV||segm_H,
        gl.p_icurval(kv, s*100, dat_), acc, nls, kv, rnk, ref,
        comm, nbuc_
   from (
    select '1214'||'3'||
        '1'  pok1,   -- �������������
        '2' segm_H,
        '4' segm_E,
        lpad(F_Codobl_branch(p.branch, 4),3,'0') segm_KKK,
        lpad(o.kv, 3, '0') segm_VVV,
        o.s, o.accd acc, o.nlsd nls, o.kv, o.rnkd rnk, p.ref,
        p.dk||' '||p.nlsa||' '||p.nlsb||' '||p.nazn comm
    from provodki_otc o, oper p
    where o.fdat between dat1_ and dat_
      and o.ref = any (select o.ref
                       from opldok o, accounts a
                       where o.fdat between dat1_ and dat_ and
                          o.dk = 0 and
                          o.acc = a.acc and
                          a.nls like '110%'   and
                          a.ob22 ='01'      )
      and o.nlsd like '110%' and o.ob22d ='01'
      and o.nlsk like '3800%'
      and o.ref = p.ref
      and substr(p.nlsa,1,3) in ('100','110')
      and substr(p.nlsb,1,3) in ('100','110')
      and p.pdat between dat1_ - 10 and dat_ + 10);
   commit;

   logger.info ('P_F2F: part 2.8.4 '||to_char(dat_,'dd.mm.yyyy'));

   -- ������ ��������� ������
   INSERT /*+APPEND NOPARALLEL*/
   INTO  rnbu_trace(recid, kodp, znap, acc, nls, kv, rnk, ref, comm, nbuc)
   select s_rnbu_record.nextval, pok1||segm_E||
        (case when segm_KKK = '000' then obl_ else segm_KKK end)||
        '10804'||segm_VVV||segm_H,
        gl.p_icurval(kv, s*100, dat_), acc, nls, kv, rnk, ref,
        comm, nbuc_
   from (
    select '1214'||'3'||
        '1'  pok1,   -- �������������
        '2' segm_H,
        '4' segm_E,
        lpad(F_Codobl_branch(p.branch, 4),3,'0') segm_KKK,
        lpad(o.kv, 3, '0') segm_VVV,
        o.s, o.accd acc, o.nlsd nls, o.kv, o.rnkd rnk, p.ref,
        p.dk||' '||p.nlsa||' '||p.nlsb||' '||p.nazn comm
    from provodki_otc o, oper p
    where o.fdat between dat1_ and dat_
      and o.nlsd like '3800%'
      and o.nlsk like '110%' and o.ob22k ='01'
      and o.ref = any (select o.ref
                       from opldok o, accounts a
                       where o.fdat between dat1_ and dat_ and
                          o.dk = 1 and
                          o.acc = a.acc and
                          a.nls like '110%'   and
                          a.ob22 ='01'      )
      and o.ref = p.ref
      and substr(p.nlsa,1,3) in ('100','110')
      and substr(p.nlsb,1,3) in ('100','110')
      and p.pdat between dat1_ - 10 and dat_ + 10);
   commit;

   logger.info ('P_F2F: part 2.8.5 '||to_char(dat_,'dd.mm.yyyy'));

   -- ��������� ���� 201 �� 215 (�� �������) ��� 216 (�� �������)
   update rnbu_trace set kodp = '1' || '215' || substr(kodp,5)
   where kodp like '1201%' and isp = 1;

   update rnbu_trace set kodp = '1' || '216' || substr(kodp,5)
   where kodp like '1201%' and isp = 0;

   logger.info ('P_F2F: part 2.8.6 '||to_char(dat_,'dd.mm.yyyy'));
----------------------------------------------------------------------------
-- ����� ���� 217, 219
-- ����� ��������, ��������������� �������
   -- ������� ����i� �� �i�������i� ������i �������� ����i� ��� ��������� ��������
   -- ������� ����i� ������������ (��������� ����i� �i� ����������i�)
   INSERT INTO OTCN_PROV_TEMP
   (ko, rnk, fdat, REF, tt, accd, nlsd, kv, acck, nlsk, s_nom, s_eqv, s_kom, nazn, branch)
   select /* FULL(k) LEADING(k ad) */
           k.d060, 1, od.fdat, od.ref, od.tt,
           ad.acc accd, ad.nls nlsd, ad.kv, ak.acc acck, ak.nls nlsk, od.s  s_nom,
           gl.p_icurval (ad.kv, od.s, od.fdat) s_eqv,
           0 S_KOM, p.nazn, p.branch
    from opldok od, accounts ad, kl_fe9 k, opldok ok, accounts ak, oper p
    where od.fdat between dat1_ and dat_ and
          od.acc = ad.acc and
          od.DK = 0 and
          ad.nls LIKE k.nlsd || '%' and
          od.ref = ok.ref and
          od.stmt = ok.stmt and
          ok.fdat between dat1_ and dat_ and
          ok.acc = ak.acc and
          ok.DK = 1 and
          ak.nls LIKE k.nlsk || '%' and
          (regexp_like(ad.NLS,'^((2809)|(2909))') and ad.OB22 = k.ob22 or
           regexp_like(ak.NLS,'^((2809)|(2909))') and ak.OB22 = k.ob22) and
          od.tt NOT IN ('C55', 'C56', 'C57', 'CNC') and
          nvl(K.PR_DEL, 1) <> 0 and
          not (ad.NLS like '2909%' and ak.NLS like '2909%' and ak.ob22 <> '60') and
          not (ad.NLS  like '29091030046500%' and ak.NLS  like '29094030046530%') and
          not (substr(ad.NLS,1,4) = substr(ak.NLS,1,4) and ad.ob22 = ak.ob22 and lower(p.nazn) like '%�������%') and
          od.ref = p.ref and
          lower(p.nazn) not like '%western%' and
          p.sos = 5;

   -- ������� ����i� �� �i�������i� ������i �������� ����i� ��� ��������� ��������
   for z in ( SELECT t.ko, t.fdat, t.REF, t.TT, t.accd, t.nlsd, t.kv,
                     t.acck, t.nlsk, max(t.s_nom) sum0, max(t.s_eqv) sum1,
                     t.nazn, t.branch
              FROM OTCN_PROV_TEMP t
              WHERE t.nlsd is not null
                and t.nlsk is not null
              GROUP BY t.ko, t.fdat, t.REF, t.TT, t.accd, t.nlsd, t.kv,
                       t.acck, t.nlsk, t.nazn, t.branch
            )

      loop

      kod_b_ := null;

      kod_g_ := null;
      kod_g_pb1 := null;

      d060_ := z.ko;

      IF z.sum1 <> 0 THEN

         formOk_ := true;

         if (z.nlsd like '2809%' or z.nlsd like '2909%') then
            acc1_ := z.accd;
            nls1_ := z.nlsd;
         else
            acc1_ := z.acck;
            nls1_ := z.nlsk;
         end if;

         if d060_ = '11' and z.nlsd like '2909%' then
            BEGIN
               select ob22
                  into ob22_
               from specparam_int
               where acc = z.accd;
             EXCEPTION WHEN NO_DATA_FOUND THEN
                ob22_ := null;
             END;
         end if;

         if d060_ = '11' and z.nlsd like '2909%' and ob22_ = '75' then
            BEGIN
               select substr(nlsd,1,4), NVL(ob22d,'00')
                 into  nbs_k, ob22_k
               from provodki_otc
               where ref = z.ref
                 and fdat = z.fdat
                 and acck = z.accd
                 and nlsd LIKE '2809%'
                 and rownum = 1;

               BEGIN
                  select kl.d060
                     into d060_
                  from kl_fe9 kl
                  where trim(kl.nlsd) = nbs_k
                    and kl.ob22 = ob22_k
                    and rownum = 1;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  d060_ := '99';
               END;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               null;
            END;
         end if;

         -- �� 01.04.2014 ���� ����� ����������������
         -- �� � ���������� �������� ��� ������� (��� KKK)
         nbuc_ := nbuc1_;
         kkk_ := NVL (lpad (f_codobl_tobo (acc1_, 4), 3, '0'),'000');

         if formOk_ then --and d060_ <> '99' then
            -- ��������i ���������
            --n_ := 2;

            for k in (select *
                      from operw k
                      where k.ref = z.ref and
                         (k.tag like 'n%' or k.tag like 'D6#7%' or k.tag like 'D6#E2%' or k.tag like 'F1%')
                     )
               loop
                  -- � 01.08.2012 ����������� ��� ������ ����������� ��� ���������� ��������
                  if k.tag like 'n%' and substr(trim(k.value),1,1) in ('O','P','�','�') then
                     kod_g_ := substr(trim(k.value),2,3);
                     --exit;
                  end if;

                  if kod_g_ is null and k.tag like 'n%' and substr(trim(k.value),1,1) not in ('O','P','�','�') then
                     kod_g_ := substr(trim(k.value),1,3);
                     --exit;
                  end if;

                  if kod_g_ is null and k.tag like 'D6#7%' and substr(trim(k.value),1,1) in ('O','P','�','�') then
                     kod_g_ := substr(trim(k.value),2,3);
                     --exit;
                  end if;

                  if kod_g_ is null and k.tag like 'D6#7%' and substr(trim(k.value),1,1) not in ('O','P','�','�') then
                     kod_g_ := substr(trim(k.value),1,3);
                     --exit;
                  end if;

                  if kod_g_ is null and k.tag like 'D6#E2%' and substr(trim(k.value),1,1) in ('O','P','�','�') then
                     kod_g_ := substr(trim(k.value),2,3);
                     --exit;
                  end if;

                  if kod_g_ is null and k.tag like 'D6#E2%' and substr(trim(k.value),1,1) not in ('O','P','�','�') then
                     kod_g_ := substr(trim(k.value),1,3);
                     --exit;
                  end if;

                  if kod_g_ is null and k.tag like 'D1#E9%' and substr(trim(k.value),1,1) in ('O','P','�','�') then
                     kod_g_ := substr(trim(k.value),2,3);
                     --exit;
                  end if;

                  if kod_g_ is null and k.tag like 'D1#E9%' and substr(trim(k.value),1,1) not in ('O','P','�','�') then
                     kod_g_ := substr(trim(k.value),1,3);
                     --exit;
                  end if;

                  if kod_g_ is null and k.tag like 'F1%' then
                     kod_g_ := substr(trim(k.value),8,3);
                  end if;

               end loop;

            if (kod_g_ is null or kod_g_ = '804') then
               begin
                  select max(substr(trim(k.value),1,3))
                  into kod_g_pb1
                  from operw k
                  where ref = z.ref
                    and tag = 'KOD_G';
               exception
                  when others then kod_g_pb1 := null;
               end;
            end if;

            if (kod_g_ is null or kod_g_ = '804') and kod_g_pb1 is not null then
               kod_g_ := kod_g_pb1;
            end if;

            if kod_g_ is null then
               D1#E9_ := '000';
            else
               D1#E9_ := LPAD (kod_g_, 3, '0');
            end if;

            if d060_ = '42' AND D1#E9_ ='000'
            then
               D1#E9_ := '804';
            end if;

            comm_ := '��� ����� ����������(�i���������) '||d1#e9_;
            d2#e9_ := '804';

            begin
               select NVL(k044, '25')
                  into k044_
               from KL_K044N
               where k040 = D1#E9_;
            exception when no_data_found then
               k044_ := '25';
            end;

            if (z.nlsd like '2809%' or z.nlsd like '2909%') then
               ppp_ := D1#E9_;

               if D1#E9_ <> '804'
               then
                  kkk_ := '000';
               end if;

               if z.nlsk like '100%'
               then
                  d110_ := '2';
               else
                  d110_ := '1';
               end if;

               kodp_ := '1'|| '219' || '3' || '1' || '4' || kkk_ || K044_ ||
                        ppp_ || lpad(to_char(z.kv),3,'0') || d110_;
            else
               if (z.nlsd like '100%' or z.nlsd like '262%') and
                  (z.nlsk like '2809%' or z.nlsk like '2909%')
               then
                  d2#e9_ := '804';
               end if;
               ppp_ := D1#E9_;

               if D1#E9_ <> '804'
               then
                  kkk_ := '000';
               end if;

               if z.nlsd like '100%'
               then
                  d110_ := '2';
               else
                  d110_ := '1';
               end if;

               if z.nlsd like '100%'
               then
                  kodp_ := '1'|| '217' || '3' || '1' || '4' || kkk_ || K044_ ||
                           ppp_ || lpad(to_char(z.kv),3,'0') || d110_;
               end if;
            end if;

            -- ����� ��������� ����
            INSERT INTO rnbu_trace
               (recid, nls, kv, odate, kodp, znap, nbuc, ref, comm)
            VALUES
               (s_rnbu_record.nextval, nls1_, z.kv, z.fdat, kodp_, to_char(z.sum1), nbuc_, z.ref, comm_);

         end if;

      END IF;

   end loop;
   commit;

   ---------
   logger.info ('P_F2F: part 2.10 '||to_char(dat_,'dd.mm.yyyy'));

    ------------------------------------------------------------------
    if mfo_ = 300465
    then

       EXECUTE IMMEDIATE 'TRUNCATE TABLE KOR_PROV';

    -- ������������� ����� 218, 220
       insert into KOR_PROV (REF, DK, ACC, S, FDAT)
               select ref, dk, acc, s, fdat
               from opldok o
               where o.fdat between dat1_ and dat_
                 and o.acc in ( select a.acc
                                from accounts a, customer c
                                where a.nls like '1600%'
                                  and a.rnk = c.rnk
                                  and c.codcagent = '2'
                              ) and
                     o.sos = 5;
               commit;

               delete from kor_prov k1
               where k1.ref in
                       ( select ref from kor_prov k2
                          where 0 = ( select count( * )
                                        from provodki_otc
                                       where fdat= k2.fdat
                                         and ref = k2.ref
                                         and (  k2.dk =0 and nlsk like '3739%'
                                                         and nlsd like '26%'
                                            or  k2.dk =1 and nlsd like '3720%' )
                                    )
                       );


               insert into OTCN_OPERW
               select *
               from (select ref, max(trim(translate(
                           (case when instr(upper(value), 'UKRAINE') > 0 or
                                       instr(upper(value), 'UKR') > 0 or
                                       substr (trim (value), 1, 3) = '/UA'
                                  then '804'
                                  else trim(value)
                            end), '1234567890OP��', '1234567890'))) country
                    from operw
                    where ref in (select ref from KOR_PROV) and
                        (tag LIKE 'n%' or
                         tag LIKE 'D6#7%' or
                         tag LIKE 'D6#E2%' or
                         tag LIKE 'D1#E9%' or
                         tag LIKE 'F1%' or
                         tag = 'KOD_G' or
                         tag LIKE '59%')
                        group by ref)
                where country in (select to_char(country) from country);
                commit;

                INSERT INTO rnbu_trace(recid, kodp, znap, acc, nls, kv, rnk, ref, comm, nbuc, isp)
                select /*+leading(a.o)*/
                    s_rnbu_record.nextval,
                    pok1 || pok2  ||
                    pok3 || segm_E||
                    (case when segm_KKK = '000' and segm_MMM = '804' then obl_
                          when segm_MMM <> '804' then '000'
                          else segm_KKK end)||
                    nvl(b.k044, '25')||segm_MMM||segm_VVV||segm_H,
                    gl.p_icurval(kv, s, dat_), acc, nls, kv, rnk, ref, comm, nbuc_, 1
                from (select '1'||'218' pok1,
                        '1' pok2,
                        '1' pok3,
                        (case when substr(decode(p.dk, '1', nlsa, nlsb), 1, 3) = '100' and
                                   NVL(w.value,'804') = '804'
                                then '2'
                                else '1'
                        end) segm_H,
                        '4' segm_E,
                        lpad(F_Codobl_branch(p.branch, 4),3,'0') segm_KKK,
                        lpad(a.kv, 3, '0') segm_VVV,
                        decode(substr(p.nlsb,1,4),'2900','804',lpad(NVL(w.value,'804'), 3, '0')) segm_MMM,
                        o.s, a.acc, a.nls, a.kv, a.rnk, p.ref,
                        p.dk||' '||p.nlsa||' '||p.nlsb||' '||p.nazn comm
                    from kor_prov o, accounts a, customer c, oper p, otcn_operw w
                    where o.acc = a.acc and
                        o.dk = 1 and
                        a.rnk = c.rnk and
                        --o.dk = p_dk and
                        p.sos = 5 and
                        o.ref = p.ref and
                        p.pdat between dat1_ - 10 and dat_ + 10 and
                        o.ref = w.ref(+)) a, KL_K044N b
               where a.segm_MMM = b.k040(+);
               commit;

                INSERT INTO  rnbu_trace(recid, kodp, znap, acc, nls, kv, rnk, ref, comm, nbuc, isp)
                select /*+ leading(a.o)*/
                    s_rnbu_record.nextval,
                    pok1 || pok2  ||
                    pok3 || segm_E||
                    (case when segm_KKK = '000' and segm_MMM = '804' then obl_
                          when segm_MMM <> '804' then '000'
                          else segm_KKK end)||
                    nvl(b.k044, '25')||segm_MMM||segm_VVV||segm_H,
                    gl.p_icurval(kv, s, dat_), acc, nls, kv, rnk, ref, comm, nbuc_, 0
                from (select '1'||'220' pok1,
                        (case when lower(p.nam_b) like '%���%���%' then '2'
                                      else '1' end) pok2,
                        '1' pok3,
                        (case when substr(decode(p.dk, 0, nlsa, nlsb), 1, 3) = '100' and
                                   NVL(w.value,'804') = '804'
                                then '2'
                                else '1'
                        end) segm_H,
                        '4' segm_E,
                        lpad(F_Codobl_branch(p.branch, 4),3,'0') segm_KKK,
                        lpad(a.kv, 3, '0') segm_VVV,
                        decode(substr(p.nlsb,1,4),'2900','804',lpad(NVL(w.value,'804'), 3, '0')) segm_MMM,
                        o.s, a.acc, a.nls, a.kv, a.rnk, p.ref,
                        p.dk||' '||p.nlsa||' '||p.nlsb||' '||p.nazn comm
                    from kor_prov o, accounts a, customer c, oper p, otcn_operw w
                    where o.acc = a.acc and
                        o.dk = 0 and
                        a.rnk = c.rnk and
                        --o.dk = p_dk and
                        p.sos = 5 and
                        o.ref = p.ref and
                        p.pdat between dat1_ - 10 and dat_ + 10 and
                        o.ref = w.ref(+)) a, KL_K044N b
               where a.segm_MMM = b.k040(+);
               commit;

               --     ��� 220 - ������� �� ��������
               INSERT  INTO  rnbu_trace(recid, kodp, znap, acc, nls, kv, rnk, ref, comm, nbuc, isp)
               select s_rnbu_record.nextval,
                      pok1 || pok2  || pok3 || segm_E||
                     (case when segm_KKK = '000' and segm_MMM = '804' then obl_
                           when segm_MMM <> '804' then '000'
                            else segm_KKK end)||
                      nvl(b.k044, '25')||segm_MMM||segm_VVV||segm_H,
                      gl.p_icurval(kv, s, dat_), acc, nls, kv, rnk, ref, comm, nbuc_, 0
                 from ( select '1'||'220' pok1,
                               '1' pok2, '1' pok3, '1' segm_H, '4' segm_E,
                               lpad(F_Codobl_branch(op.branch, 4),3,'0') segm_KKK,
                               lpad(a.kv, 3, '0') segm_VVV,
                               lpad(NVL(op.kod_g,'804'), 3, '0') segm_MMM,
                               o.s, a.acc, a.nls, a.kv, a.rnk, op.ref,
                               op.dk||' '||op.nlsa||' '||op.nlsb||' '||op.nazn comm
                          from accounts a, customer c, opldok o,
                               (select substr(v1.value,1,3) kod_g,
                                        o.ref, o.tt, o.nd, o.pdat, o.kv, o.dk, o.s, o.sq,
                                        o.nam_a, o.nlsa, o.mfoa, o.id_a, o.nam_b, o.nlsb, o.mfob, o.id_b,
                                        o.nazn, o.id_o, o.sos, o.s2, o.kv2, o.branch
                                  from operw v1, operw v2, operw v3, oper o
                                 where o.ref in (select o.ref
                                                 from opldok o, accounts a
                                                 where o.fdat between dat1_ and dat_ and
                                                       o.acc = a.acc and
                                                       a.nbs in ('1500', '1600'))
                                   and o.nlsa like '1500%'
                                   and o.nlsb like '1600%'
                                   and o.sos = '5'
                                   and o.mfoa = o.mfob
                                     and o.pdat between dat1_ and dat_
                                     and v1.tag(+) = 'KOD_G'
                                     and v1.value(+) != '804'
                                     and trim(v1.value(+)) is not null
                                     and v1.ref (+)= o.ref
                                   and v2.tag = 'KOD_N'
                                   and v2.value not in ( '8424010','8442001' )
                                   and v2.value not like '8445%'
                                   and v2.value not like '8443%'
                                   and trim(v2.value) is not null
                                   and v2.ref = o.ref
                                     and v3.tag(+) = 'KOD_B'
                                     and v3.value(+) != '6'
                                     and trim(v3.value(+)) is not null
                                     and v3.ref(+) = o.ref
                               ) op
                         where op.ref = o.ref
                           and o.dk = 0
                           and o.acc = a.acc
                           and a.rnk = c.rnk
                      ) a, kl_k044N b
                where a.segm_MMM = b.k040(+);
                commit;


    end if;

   logger.info ('P_F2F: part 2.11 '||to_char(dat_,'dd.mm.yyyy'));
---------------------------------------------------------------------------
   INSERT INTO tmp_nbu(datf, kodf, kodp, znap, nbuc)
   select Dat_, kodf_, kodp, to_char(sum(to_number(znap))), nbuc
   from rnbu_trace
   where kodp like '1%'
   group by kodp, nbuc;

--   ���������� � ����� ��� ������ ��� ��������������
--      ��� ������ ������������ ������ ����� -��� �������� �� #
   if is_finmon =0  then

      otc_del_arch(kodf_, dat_, 0);
      OTC_SAVE_ARCH(kodf_, dat_, 0);
      commit;

   end if;

   logger.info ('P_F2F: part 3.1 '||to_char(dat_,'dd.mm.yyyy'));

   -- ����� �������
   -- �������� ������� ���������� ��������
   INSERT INTO tmp_nbu(datf, kodf, kodp, znap, nbuc)
   select dat_, kodf_, '3301000000000000000' kodp,
        sum(znap), nbuc_
   from (select /*+ parallel(8) */
                count(distinct p.ref) znap
         from opldok o, oper p
         where o.fdat between dat1_ and dat_ and
               o.ref = p.ref and
               p.pdat between dat1_ - 10 and dat_ + 10 and
               p.sos = 5 and
               (o.fdat, o.acc) in (SELECT S.FDAT, S.ACC
                                            FROM SALDOA S, accounts a
                                           WHERE     S.FDAT BETWEEN dat1_ AND dat_
                                                 AND S.ACC = a.acc
                                                 and a.nbs in  (SELECT k.r020
                                                                 FROM KL_F3_29 K
                                                                WHERE     K.KF =
                                                                             '2F'
                                                                      AND K.DDD =
                                                                             '102')
                                                 AND S.DOS + S.KOS <> 0));

   logger.info ('P_F2F: part 3.2 '||to_char(dat_,'dd.mm.yyyy'));

   -- ���������, �� ��������� �� ��������� ��������� 3-�� ������
   --              (��� �������� ����� - � ����� D0 [p_f2f_pok_unit3.sql],
   --                 � ��� �� - � ������������� [p_f2f_pok_unit3.prc])
   p_f2f_pok_unit3(dat_, dat1_, nbuc_);

--   ���������� � ����� ��� �� (c ���������������)
   if is_finmon =1  then

      otc_del_arch(kodf_, dat_, 0);
      OTC_SAVE_ARCH(kodf_, dat_, 0);
      commit;

   end if;

   logger.info ('P_F2F: End for '||to_char(dat_,'dd.mm.yyyy'));

   commit;
--exception
--    when others then
--        logger.info ('P_F2F: Error '||sqlerrm||' '||to_char(dat_,'dd.mm.yyyy'));
END;
/
show err;

PROMPT *** Create  grants  P_F2F ***
grant EXECUTE          on P_F2F           to BARS_ACCESS_DEFROLE;
grant EXECUTE          on P_F2F           to RPBN002;
grant EXECUTE          on P_F2F           to START1;
grant EXECUTE          on P_F2F           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F2F.sql =========*** End *** ===
PROMPT ===================================================================================== 
