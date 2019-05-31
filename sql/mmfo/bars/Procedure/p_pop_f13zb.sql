CREATE OR REPLACE PROCEDURE BARS.P_POP_F13ZB(datb_ IN DATE, date_ IN DATE,
                                        nmode_ IN NUMBER) IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    ��������� ���������� �������������� �������� � ����.
%             :    OTCN_F13_ZBSK ��� ����� #13 (��)
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     :    03/05/2019 (17/04/2019)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ���������: Datb_  - ��������� ����
               Date_  - �������� ����
               nmode_ - ������� ���������� (0-� ���������, 1-����������, 2 - ��������)
                        � ���������� - ���������� � nmode_ = 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
03.05.2019 ��� �������� ����� 2924  ������ 2620/36 ������ ��������� ������ 88
17.04.2019 ���������� ������� 2625 �������� �� 2620 � ������� ���� ����� ������� 
           � ���������� �������� 2625
26.12.2018 �� ������� 95 ��������� ������� ������� 2620 � OB22='36'
21.11.2017 ��������� ��������� ����������� ����� ��� �����������
21.09.2017 ���� SK_ZB (�������������� ������) �� ����� ���������� ��� ���������
           ���������� ����� �� �������� ����������������� ��������
02.08.2017 �������� ��������� ������� ��� ������ ���������� �� OPLDOK
11.07.2017 ��� ������������ ������� 97 �������  p.NLSB like '2600%' �� OPER
10.07.2017 ��� ������������ ������� 97 ����� ������� nazn like '%����%'
           � �������  p.NLSB like '2650%' �� OPER
07.07.2017 ��� ������������ ������� 97 ��������� ������� ������� ������� REF
           � OTCN_F13_ZBSK (��� ��������� ���������� ���� ��������)
16.06.2017 ������ ������ �������� �� ���� � ��� ����� �������� � ��.
           �������� ���� ��� ���������� ������� 97 (�� 2909 OB22='43' � �������
           ����������� � ������� CUST_PTKC).
11.01.2017 � ����. OTCN_F13_ZBSK ��������� ���� STMT � ��� ������� ���������
           ��� ���� REF � STMT
           ��������� ��������� �� 3739 �� 2620 � ���������� "%������ ��������
           ������%" (������ 87)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
    mfo_    number;
    isp_    number;
    acc_    number;
    sk_zb_  number;
    sk_zb_d number;
    sk_zb_k number;
    sk_zb_o number;
    kol_    number;
    kol1_   number;
    nbsd_   varchar2(15);
    nbsk_   varchar2(15);
    dat1_   Date;
    ko_     integer;
    tobo_   varchar2(12);
    ko_b    integer;
    tobo_b  varchar2(200);
    ob22_   varchar2(2);
    comm_   kl_f13_zbsk.comm%type;
    pref_   number := null;
    
    l_row   otcn_f13_zbsk%rowtype;
    TYPE    otcn_f13_zbsk_t IS TABLE OF otcn_f13_zbsk%rowtype;
    l_otcn_f13_zbsk otcn_f13_zbsk_t := otcn_f13_zbsk_t();    
BEGIN
   commit;

   EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
   EXECUTE IMMEDIATE 'ALTER SESSION SET SORT_AREA_SIZE = 131072';

   -------------------------------------------------------------------
   logger.info ('P_POPF13: Begin for '||to_char(datb_,'dd.mm.yyyy')||' '||
        to_char(date_,'dd.mm.yyyy')||' mode = '||to_char(nmode_));

   mfo_ := F_OURMFO();
   dat1_ := TRUNC(date_,'MM');

   select trim(val)
      into tobo_b
   from params
   where par = 'OUR_TOBO';

   if length(tobo_b) = 20
   then
      tobo_b := substr(tobo_b, 9, 12);
   elsif length(tobo_b) <> 12 then
      tobo_b := substr(tobo_b, 1, 12);
   end if;

   ko_b := substr(tobo_b,2,2);

   if nmode_ = 0
   then
      delete from otcn_f13_zbsk o where fdat between datb_ and date_ ;
      kol1_ := 0;
   elsif nmode_ = 2 then
      select count(*)
         into kol1_
      from otcn_f13_zbsk o where fdat between datb_ and date_;
   end if;

    if kol1_ > 0
    then
       delete from otcn_f13_zbsk z
       where z.ref in (select a.ref
                       from otcn_f13_zbsk a, oper b
                       where a.fdat between dat1_ and date_
                         and a.ref = b.ref
                         and b.sos <> 5);
    end if;

    if nmode_ <> 2 or (nmode_ = 2 and kol1_ = 0)
    then
       for f in (select fdat from fdat where fdat BETWEEN datb_ AND date_) 
       loop
           for k in (SELECT UNIQUE 
                           o.fdat,
                           o.ref,
                           o.tt,
                           (case when o.dk = 0 then o.acc else o1.acc end) accd,
                           (case when o.dk = 0 then a.nls else a1.nls end) nlsd,
                           a.kv,
                           (case when o.dk = 1 then o.acc else o1.acc end) acck,
                           (case when o.dk = 1 then a.nls else a1.nls end) nlsk,
                           o.s, o.sq,
                           p.nazn,
                       p.userid isp,
                       o.stmt,
                       o.kf,
                       z.ref as refz, 
                       a.ob22 ob22d,
                       a1.ob22 ob22k 
                  FROM opldok o,
                       accounts a,
                       opldok o1,
                       accounts a1,
                       oper p,
                       otcn_f13_zbsk z
                 WHERE     O.FDAT = f.fdat
                       AND o.tt NOT IN ('���', 'KB8')
                       AND o.acc = a.acc
                       AND a.kv = 980
                       AND REGEXP_LIKE (a.NLS, '^(26(2|3))')
                       AND o.REF = o1.REF
                       AND o.stmt = o1.stmt
                       AND o.dk <> o1.dk
                       AND o1.acc = a1.acc
                       and o.ref = p.ref
                       and p.vob not in (96, 99)
                       and p.sos = 5
                       and o.kf = z.kf(+)
                       and o.ref = z.ref(+)
                       and o.stmt = z.stmt(+)
                       and o.tt = z.tt(+)
                    )
            loop
               if substr(k.nlsd,1,4) not in ('1001','1002','1003','1004') and
                  substr(k.nlsk,1,4) not in ('1001','1002','1003','1004')
               then

                  acc_ := k.accd;

                  IF substr(k.nlsd,1,3) not in ('262','263') and k.nlsd not like '2909%'
                  THEN
                    acc_ := k.acck;
                  END IF;

                  tobo_ := NVL(substr(F_Codobl_Tobo(acc_,5),3,12),tobo_b);

                  if tobo_ = tobo_b
                  then
                    ko_ := ko_b;
                  ELSE
                    ko_ := substr(tobo_,7,2);
                  END IF;

                  sk_zb_ := 0;
                  comm_ := null;

                  BEGIN
                     select sk_zb, comm
                        into sk_zb_, comm_
                     from (
                         select sk_zb, trim(comm) comm
                         from (
                            select z.SK_ZB, Z.COMM,
                               (case when trim(z.nbsd) = trim(k.nlsd) and trim(z.nbsk) = trim(k.nlsk) then 1 else 0 end) p1,
                               (case when trim(z.nbsd) = trim(k.nlsd) and trim(z.nbsk) = trim(substr(k.nlsk,1,4)) then 1 else 0 end) p2,
                               (case when trim(z.nbsd) = trim(substr(k.nlsd,1,4)) and trim(z.nbsk) = trim(k.nlsk) then 1 else 0 end) p3,
                               (case when trim(z.nbsd) = trim(substr(k.nlsd,1,4)) and trim(z.nbsk) = trim(substr(k.nlsk,1,4)) then 1 else 0 end) p4,
                               (case when trim(z.tt) = k.tt then 1 else 0 end) p5
                            from kl_f13_zbsk z
                            where trim(k.nlsd) like trim(z.nbsd) ||'%'
                              and trim(k.nlsk) like trim(z.nbsk) ||'%'
                              and NVL(trim(z.tt),k.tt)=k.tt
                            )
                        order by p1+p2+p3+p4+p5 desc, p1 desc, p2 desc, p3 desc, p4 desc, p5 desc)
                     where rownum=1;
                  EXCEPTION WHEN NO_DATA_FOUND THEN
                       sk_zb_ := 0;
                       comm_ := null;
                  END;

                  isp_:=k.isp;

                  if sk_zb_ >= 0
                  then
                     sk_zb_k := sk_zb_;

                     acc_ := k.accd;

                     IF substr(k.nlsd,1,3) not in ('262','263')
                     THEN
                        acc_ := k.acck;
                     END IF;

                     tobo_ := NVL(substr(F_Codobl_Tobo(acc_,5),3,12),tobo_b);

                     if tobo_=tobo_b
                     then
                        ko_:=ko_b;
                     ELSE
                        ko_:= substr(tobo_,7,2);
                     END IF;

                     BEGIN
                        select o.sk, substr(trim(w.value),1,2)
                           into sk_zb_o, sk_zb_d
                        from oper o, operw w
                        where o.ref = k.ref
                          and o.ref = w.ref(+)
                          and w.tag(+) = 'SK_ZB';

                        if sk_zb_d in ('84','86','87','88','93','94','95','96')
                        then
                           sk_zb_ := sk_zb_d;
                        end if;

                        if sk_zb_o in ('84','86','87','88','93','94','95','96')
                        then
                           sk_zb_ := sk_zb_o;
                        end if;
                     EXCEPTION WHEN OTHERS THEN
                        sk_zb_d := null;
                     END;

                     if k.nazn like '���������� ������ ���_���%' OR
                        k.nazn like '������ ������ ��������%' OR
                        k.nazn like '%������ �����_ ��������%' OR
                        k.nazn like '���������� ���_��_%' OR
                        k.nazn like '���������� ���_��_%' OR
                        k.nazn like '%������� �������%' OR
                        k.nazn like '%������ �������%' OR
                        k.nazn like '������ �������%' OR
                        k.nazn like '�_��_�� ������ ���%' OR
                        k.nazn like '_�������� ����_ �����%'
                     then
                        sk_zb_ := 0;
                     end if;

                     if k.nlsd like '2909%' and k.nlsk like '2620%' and
                        (k.nazn like '%�_���������%') and sk_zb_ <> 88
                     then
                         sk_zb_ := 88;
                     end if;

                     if k.nlsd like '2909%' and k.nlsk like '2620%' and
                        ( LOWER(k.nazn) like '%���������� �� �����%' or
                          LOWER(k.nazn) like '%���������� �� �����%' or
                          LOWER(k.nazn) like '%����������� �� �����%' or
                          LOWER(k.nazn) like '%�����������  �� �����%' or
                          LOWER(k.nazn) like '%����������� �� �����_%' or
                          LOWER(k.nazn) like '%�����_�� �����_%' or
                          LOWER(k.nazn) like '%��������� �� ����_%'
                        ) and sk_zb_ <> 88
                     then
                         sk_zb_ := 88;
                     end if;

                     if k.nlsd like '2909%' and k.nlsk like '2620%' and
                        (k.nazn like '%_����_�%') and sk_zb_ <> 86
                     then
                         sk_zb_ := 86;
                     end if;

                     if k.nlsd like '2924%' and k.nlsk like '2620%'
                        and ( LOWER(k.nazn) like '%�����������%�������_ �� �_�������%' or
                              LOWER(k.nazn) like '%����������� �_��������%' or
                              LOWER(k.nazn) like '%�������%�_������_%' or
                              LOWER(k.nazn) like '%�������%������������%' or
                              LOWER(k.nazn) like '%�����_������� �_��������%' or
                              LOWER(k.nazn) like '%������� ����������%' or
                              LOWER(k.nazn) like '%�����_��� �����%' or
                              LOWER(k.nazn) like '%����_�%' or
                              LOWER(k.nazn) like '%�����������%��%' or
                              LOWER(k.nazn) like '%�������_%' or
                              LOWER(k.nazn) like '%zarplata%' or
                              LOWER(k.nazn) like '%�/�%' or
                              LOWER(k.nazn) like '%�\�%' or
                              LOWER(k.nazn) like '%_�_����_%' or
                              LOWER(k.nazn) like '%�����%' or
                              LOWER(k.nazn) like '%���_� �_����_���%' or
                              LOWER(k.nazn) like '%����� ���������������%'
                            )
                        and sk_zb_ <> 84
                     then
                         sk_zb_ := 84;
                     end if;

                     if k.nlsd like '2909%' and k.nlsk like '2620%' and
                        (LOWER(k.nazn) like '%����%' or
                         LOWER(k.nazn) like '%����__%' or
                         LOWER(k.nazn) like '%�������_%' or
                         LOWER(k.nazn) like '%�����%'  or
                         LOWER(k.nazn) like '%������_%') and sk_zb_ <> 87
                     then
                         sk_zb_ := 87;
                     end if;

                     if k.nlsd like '2909%' and k.nlsk like '2620%'
                        and ( LOWER(k.nazn) like '%�����������%�������_ �� �_�������%' or
                              LOWER(k.nazn) like '%����������� �_��������%'
                            )
                        and sk_zb_ <> 84
                     then
                         sk_zb_ := 84;
                     end if;

                     if k.nlsd like '2909%' and k.nlsk like '2620%' and
                        ( LOWER(k.nazn) like '%�������_%' or k.nazn like '%�/�%' or k.nazn like '%�\�%' or
                          LOWER(k.nazn) like '%_�_����_%' or k.nazn like '%�\�%' or
                          LOWER(k.nazn) like '%�����%'
                        ) and sk_zb_ <> 84
                     then
                         sk_zb_ := 84;
                     end if;

                     if k.nlsd like '2909%' and k.nlsk like '2620%' and
                        (k.nazn like '%_��.����_%' or k.nazn like '%�-�%' or k.nazn like '%�-�%' or
                         k.nazn like '%_-��%' or     -- (�-�� ��� �-��)
                         k.nazn like '%__������_%' or  -- (�_������_)
                         k.nazn like '%_������_%' or   -- (�������)
                         k.nazn like '%_�������� ����������%') and sk_zb_ <> 84
                     then
                         sk_zb_ := 84;
                     end if;

                     if k.nlsd like '3739%' and k.nlsk like '2620%' and
                        ( LOWER(k.nazn) like '%������ ����_���� ��_���_�%'
                        ) and sk_zb_ <> 87
                     then
                         sk_zb_ := 87;
                     end if;

                     if k.nlsd like '3739%' and (k.nlsk like '2620%' or
                                                 k.nlsk like '2628%' or
                                                 k.nlsk like '2630%' or
                                                 k.nlsk like '2635%' or
                                                 k.nlsk like '2638%') and
                        (LOWER(k.nazn) like '%_���������� �������%') and sk_zb_ <> 0
                     then
                         sk_zb_ := 0;
                     end if;

                     if k.nlsd like '2620%' and k.nlsk like '2924%' and
                        (LOWER(k.nazn) like '%_���������� �������%' or
                         LOWER(k.nazn) like '%_���������� �������%') and
                        sk_zb_ <> 0
                     then
                         sk_zb_ := 0;
                     end if;

                     if k.nlsd like '2924%' and k.nlsk like '2620%' and
                        (LOWER(k.nazn) like '%�������%' or
                         LOWER(k.nazn) like '%�������� ���%' or
                         LOWER(k.nazn) like '%������ �������%' or
                         LOWER(k.nazn) like '%����������%' or
                         LOWER(k.nazn) like '%_��_ ������_%' ) and sk_zb_ <> 88
                     then
                         sk_zb_ := 88;
                     end if;

                     if k.nlsd like '2909%' and k.nlsk like '2620%' and
                        (LOWER(k.nazn) like '%�������%') and sk_zb_ <> 88
                     then
                         sk_zb_ := 88;
                     end if;

                     -- ��� �����������
                     if k.nlsd like '2924%' and k.nlsk like '2620%' and
                        LOWER(k.nazn) like '%w%' and sk_zb_ <> 88
                     then
                         sk_zb_ := 88;
                     end if;

                     if k.nlsd like '2924%' and k.nlsk like '2620%'
                        and (LOWER(k.nazn) like '%������_� �����%' or
                             LOWER(k.nazn) like '%_���������� �������%' or
                             LOWER(k.nazn) like '%_���������� �������%')
                        and sk_zb_ <> 0
                     then
                         sk_zb_ := 0;
                     end if;

                     -- �������� ����������. ������ ��� �������� �� 262 �� 263
                     if ( (k.nlsd like '2924%' and k.nlsk like '2620%') or
                          (k.nlsd like '2620%' and k.nlsk like '2924%')
                        )
                        and (k.tt like 'PK%' OR k.tt like 'W43%')
                        and sk_zb_ <> 0
                     then
                        BEGIN
                           select 0
                              into sk_zb_
                           from oper o
                           where o.ref = k.ref
                             and (o.nlsa like '262%' or o.nlsa like '263%')
                             and (o.nlsb like '262%' or o.nlsb like '263%');
                        EXCEPTION WHEN NO_DATA_FOUND THEN
                           null;
                        END;
                     end if;

                     -- ��� ������
                     if mfo_ = 303398 and k.nlsd like '2620%' and k.nlsk like '6110%' and
                        LOWER(k.nazn) like '%���_�_�%' and sk_zb_ <> 95
                     then
                         sk_zb_ := 95;
                     end if;

                     if mfo_ = 322669 and k.nlsd like '2620%' and k.nlsk like '3739%' and k.ob22d <> '07'
                     then
                        sk_zb_ := 0;
                     end if;

                     -- �� ������� 95 ��������� ������� ������� 2620 � OB22='36'
                     if k.nlsd like '2620%' and k.ob22d = '36' and sk_zb_ = 95
                     then
                         sk_zb_ := 0;
                     end if;

                     -- ����� 3801/33  ������ 2620/36    ������ 88 
                     if k.nlsd like '3801%' and k.ob22d = '33' and 
                        k.nlsk like '2620%' and k.ob22k = '36' and sk_zb_ <> 88
                     then
                         sk_zb_ := 88;
                     end if;

                     -- ����� 2924  ������ 2620/36    ������ 88
                     if k.nlsd like '2924%' and k.nlsk like '2620%' and
                        k.ob22k = '36' and sk_zb_ <> 88
                     then
                         sk_zb_ := 88;
                     end if;

                     if k.refz is null then
                         l_row.recid := s_zbsk_record.nextval;
                         l_row.fdat := k.fdat;
                         l_row.ref := k.ref;
                         l_row.tt := k.tt;
                         l_row.accd := k.accd;
                         l_row.nlsd := k.nlsd;
                         l_row.kv := k.kv;
                         l_row.acck := k.acck;
                         l_row.nlsk := k.nlsk;
                         l_row.s := k.s;
                         l_row.sq := k.sq;
                         l_row.isp := isp_;
                         l_row.sk_zb := sk_zb_;
                         l_row.ko := ko_;
                         l_row.tobo := tobo_;                 
                         l_row.kf := k.kf;                 
                         l_row.stmt := k.stmt;
                         
                         l_otcn_f13_zbsk.Extend;
                         l_otcn_f13_zbsk(l_otcn_f13_zbsk.last) := l_row;

                         if l_otcn_f13_zbsk.COUNT >= 10000 then
                            FORALL i IN 1 .. l_otcn_f13_zbsk.COUNT
                                insert /*+ append */ into otcn_f13_zbsk values l_otcn_f13_zbsk(i);

                            l_otcn_f13_zbsk.delete;
                            
                            commit;
                         end if;
                     end if;    
                  else
                     if comm_ = '*' then
                         delete
                         from otcn_f13_zbsk
                         where  kf = k.kf 
                            and ref = k.ref
                            and stmt = k.stmt;
                     END IF;
                  end if;
               end if;
            end loop;
            
            FORALL i IN 1 .. l_otcn_f13_zbsk.COUNT
               insert /*+ append */  into otcn_f13_zbsk values l_otcn_f13_zbsk(i);
               
            l_otcn_f13_zbsk.delete;
            
            commit;        
       
            -- ����� ���� ���������� ������� 97
           insert into otcn_f13_zbsk
               (recid, fdat, ref, tt, accd, nlsd, kv, acck, nlsk, s, sq, nazn, isp,
                sk_zb, ko, tobo, stmt )
               SELECT /*+ leading(a) */
                      s_zbsk_record.nextval, 
                      o.fdat,
                      o.ref,
                      o.tt,
                      (case when o.dk = 0 then o.acc else o1.acc end) accd,
                      (case when o.dk = 0 then a.nls else a1.nls end) nlsd,
                      a.kv,
                      (case when o.dk = 1 then o.acc else o1.acc end) acck,
                      (case when o.dk = 1 then a.nls else a1.nls end) nlsk,
                      o.s, o.sq,
                      p.nazn,
                      p.userid isp,
                      97,
                      ko_b,
                      tobo_b,
                      o.stmt
                 FROM opldok o,
                      accounts a,
                      opldok o1,
                      accounts a1,
                      oper p,
                      cust_ptkc c
                 WHERE    o.fdat = f.fdat
                      AND o.acc = a.acc
                      AND a.kv = 980
                      AND REGEXP_LIKE (a.NLS, '^(2909)|(1911)')
                      AND (a.nbs = '2909' and a.ob22 = '43' or a.nbs = '1911' and a.ob22 = '01')
                      AND a.ob22 = '43'
                      AND o.dk = 0
                      AND o.REF = o1.REF
                      AND o.stmt = o1.stmt
                      AND o.dk <> o1.dk
                      AND o1.acc = a1.acc
                      and o.ref = p.ref
                      and REGEXP_LIKE (p.nlsb, '^(26(00|50|54))|(2606)|(1811)|(1911)') 
                      and p.vob not in (96, 99)
                      and p.sos = 5
                      and a.rnk = c.rnk
                      and (o.ref, o.stmt) not in (select ref, stmt
                                                  from otcn_f13_zbsk
                                                  where sk_zb = 97
                                                    and fdat = f.fdat);
                                                    
            merge into otcn_f13_zbsk a
            using (select z.recid, z.ref, z.stmt
                      from otcn_f13_zbsk z, oper p
                             where z.fdat = f.fdat
                              and z.sk_zb <> 0
                              and z.ref = p.ref
                              and p.sos = 5 and
                              p.sk > 0 and p.sk < 75 ) b
            on (a.recid = b.recid)
             WHEN MATCHED THEN
                    UPDATE SET sk_zb = 0;
                    
           commit;
       end loop;
    end if;

   logger.info ('P_POPF13: End for '||to_char(datb_,'dd.mm.yyyy')||' '||
        to_char(date_,'dd.mm.yyyy')||' mode = '||to_char(nmode_));

   commit;
END;
/