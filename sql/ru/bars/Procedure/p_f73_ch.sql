CREATE OR REPLACE PROCEDURE BARS.P_F73_CH (Dat1_ Date, Dat_ Date) IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : ��������� ������������ ����� "DDD" ��� ����� #73 
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 07/09/2017 (16/06/2017, 26/05/2017)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
���������: Dat1_ - ��������� ���� ������� ������
           Dat_  - ��������  ���� ������� ������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
07.09.2017 ��� �������� �� 2628, 2638 �� 100* ����� ������������� ��� 341 
           ������ ���� 370 
13.06.2017 �� 01.07.2017 ��� ��������� ��� �������� ������� 248, 348
26.05.2017 ������������ ������ 1211 �.�. �� ��������� ���.�������� D#73 
           �� �������� "232" �� "000"
02.08.2016 ��� �� 1101,1102 �� 3800 � ���������� "�������� ������" ��� 
           "�������� � ���" ����� ������������� D#73='000'
17.06.2016 ��� ��������� �������� ������������ ���.��������� D#73 
12.05.2016 ��� ��������� ����� ����������� ��� 270 ������ 261 
28.03.2016 ��� TT = 'VPF' ����� ��������� � OPERW ���� ��� ����� TAG
21.03.2016 � 01.03.2016 ���� 245, 345 ����� ���������� �� 231, 341 
           ����� ���������� ������� ���.����� 1101, 1102 
23.02.2016 ��� �� 2909 (OB22='19') �� 1002 � ���������� "������� ����" 
           ����� ����������� ��� 370
19.02.2016 ��������� ���������� ����� ����� �� 1002 �� 2809 ����������� 
           "�������� ��������� �������" - 270
           �� 2909 �� 1002 ����������� "������ ��������� �������" - 370
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
    mfo_g    Number;
    ob22_    Varchar2(2);
    tt_      Varchar2(3);
    kol_     Number;
    ref1_    Number;
    tag1_    Varchar2 (5);
    ref_m37  Number;
    ref_mmv  Number;
    dat_m37  Date;
    dat_mmv  Date;
    backr_   Number; 

BEGIN
   logger.info ('P_F73_CH: Begin for '||to_char(dat_,'dd.mm.yyyy'));
   
   mfo_g:=F_OURMFO();

   for k in (select a.*, w1.ref ref1, w1.d020 val1, w2.d020 val2, w3.d020 val3
                from (
                    select o.pdat, p.fdat, p.ref, p.tt, p.accd, p.nlsd, p.kv, p.acck, 
                          p.nlsk, p.nazn, o.sos, 
                          NVL(p.ob22d,'00') ob22d, NVL(p.ob22k,'00') ob22k  
                   from provodki_otc p, oper o  
                   where p.fdat BETWEEN Dat1_ and Dat_ 
                     and p.kv<>980 
                     and ( (p.nbsd LIKE '100%' and p.nbsk NOT LIKE '1007%') OR
                           (p.nbsd NOT LIKE '1007%' and p.nbsk LIKE '100%') OR
                           (p.nlsd LIKE '1101%' or p.nlsd LIKE '1102%') OR 
                           (p.nlsk LIKE '1101%' or p.nlsk LIKE '1102%')
                         )
                     and p.ref=o.ref
                    order by 1,2,3) a
                left outer join
                (select ref, tag, trim(substr(value,1,3)) d020
                 from operw) w1
                on (a.ref = w1.ref and
                    w1.tag like 'D#73%')
                left outer join
                (select ref, tag, trim(substr(value,1,3)) d020
                 from operw) w2
                on (a.ref = w2.ref and
                    w2.tag like '73'||a.tt||'%')
                left outer join
                (select ref, tag, trim(substr(value,1,3)) d020
                 from operw) w3
                on (a.ref = w3.ref and
                    regexp_like(W3.TAG,'^((73VPF)|(73MVQ)|(73MUQ)|(73CCD))')
                   )
              )
   loop
      if k.ref1 is null then  
         begin
            insert into operw 
               (ref,   tag,    value) VALUES
               (k.ref, 'D#73', '000');
         exception when others then 
            null;
         end;
      end if; 

      BEGIN
         select count(*) 
            INTO backr_
         from operw 
         where ref=k.ref 
           and tag like 'BACKR%';
      EXCEPTION WHEN NO_DATA_FOUND THEN
         backr_ := 0;
      END;

      BEGIN
         select tt 
            INTO tt_
         from op_rules
         where k.tt=substr(tag,-3)
           and tag LIKE '73%'
           and  tt in (select tt from provodki_otc where ref=k.ref and tt <> substr(tag,-3))  -- ������� 29.10.2012 
           and ROWNUM=1;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         tt_ := NULL;
      END; 
                         
      IF tt_ is not null and k.tt <> 'VPF' then
         if k.val2 is null then
            insert into operw (ref, tag, value) 
            VALUES (k.ref, '73'||k.tt, '000');
         end if;
      END IF;

      if k.tt = 'VPF' then
         BEGIN
            select ref, tag
               into ref1_, tag1_
            from operw  
            where ref = k.ref
              and tag = '73VPF';
         EXCEPTION WHEN NO_DATA_FOUND THEN
            --if k.val3 is null then
               insert into operw(ref, tag, value) 
               VALUES (k.ref, '73VPF', '261');
            --end if;
         END;
      end if;

      if k.tt = 'MVQ' then
         if k.val3 is null then
            insert into operw(ref, tag, value) 
            VALUES (k.ref, '73MVQ', '261');
         end if;
      end if;

      if k.nlsd not like '100%' then
         ob22_ := k.ob22d;
      else
         ob22_ := k.ob22k;
      end if;

      -- �������� I� �� ������i �� ���.���. �� �� ������������� �������.
      if (k.nlsd like '100%' or k.nlsd like '110%') and 
         substr(k.nlsk,1,4) IN ('2520','2600','2602','2603','2604','2605','2610','2615') then

         update operw a set a.value='220'
         where a.tag LIKE 'D#73%' 
           and (a.value is null or a.value NOT LIKE '220%') 
           and a.ref=k.ref
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 
                                  
           update operw a set a.value='220'
           where a.tag='73'||k.tt 
           and (a.value is null or a.value NOT LIKE '220%') 
           and a.ref=k.ref; 
      end if;

      -- ������� I� � i����� �����-���������
      if  (k.nlsd LIKE '100%' or k.nlsd like '110%') and k.nlsk LIKE '1811%' then 
       
          update operw a set a.value='223'
          where a.tag LIKE 'D#73%'  
            and (a.value is null or a.value NOT LIKE '223%') 
            and a.ref=k.ref
            and k.tt <> '188'
            and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                             WHERE tag LIKE '73%'); 
                                   
          update operw a set a.value='223'
          where a.tag='73'||k.tt 
            and k.tt <> '188'
            and (a.value is null or a.value NOT LIKE '223%') 
            and a.ref=k.ref; 
      end if;

      -- ������� I� � i����� �����-���������
      if (k.nlsd LIKE '100%' or k.nlsd like '110%') and 
          k.nlsk LIKE '1911%' and ob22_ in ('00', '01') 
      then 
       
          update operw a set a.value='223'
          where a.tag LIKE 'D#73%'  
            and (a.value is null or a.value NOT LIKE '223%') 
            and a.ref=k.ref
            and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                             WHERE tag LIKE '73%'); 
                                   
          update operw a set a.value='223'
          where a.tag='73'||k.tt 
            and (a.value is null or a.value NOT LIKE '223%') 
            and a.ref=k.ref; 
      end if;

      -- �������� �� ����� 
      if (k.nlsd LIKE '100%' or k.nlsd like '110%') and 
         (substr(k.nlsk,1,4) IN ('2620','2630','2635') OR 
          k.nlsk LIKE '2909____000000%') then

         update operw a set a.value='231'
         where a.tag LIKE 'D#73%'   
           and (a.value is null or a.value NOT LIKE '231%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 
                                   
         update operw a set a.value='231'
         where a.tag='73'||k.tt 
           and (a.value is null or a.value NOT LIKE '231%') 
           and a.ref=k.ref; 

      end if;

      if (k.nlsd LIKE '100%' or k.nlsd like '110%') and k.nlsk LIKE '2809%' and 
         ob22_ in ('09') and LOWER(k.nazn) like '%�������� ��������%' 
      then

         update operw a set a.value='231'
         where a.tag LIKE 'D#73%'   
           and (a.value is null or a.value NOT LIKE '231%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 
                                   
         update operw a set a.value='231'
         where a.tag='73'||k.tt 
           and (a.value is null or a.value NOT LIKE '231%') 
           and a.ref=k.ref; 

      end if;

      if k.nlsd LIKE '100%' and k.nlsk LIKE '2809%' and 
         LOWER(k.nazn) like '%�������� ���������%���_����%' 
      then

         update operw a set a.value='270'
         where a.tag LIKE 'D#73%'   
           and (a.value is null or a.value NOT LIKE '270%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 
                                   
         update operw a set a.value='270'
         where a.tag='73'||k.tt 
           and (a.value is null or a.value NOT LIKE '270%') 
           and a.ref=k.ref; 

      end if;

      if (k.nlsd LIKE '100%' or k.nlsd like '110%') and k.nlsk LIKE '2909%' and 
        ob22_ in ('18') and LOWER(k.nazn) like '%���������� �����%' 
      then

         update operw a set a.value='231'
         where a.tag LIKE 'D#73%'   
           and (a.value is null or a.value NOT LIKE '231%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 
                                   
         update operw a set a.value='231'
         where a.tag='73'||k.tt 
           and (a.value is null or a.value NOT LIKE '231%') 
           and a.ref=k.ref; 

      end if;

      -- i��i �����������i ����������� 
      if k.nlsd LIKE '100%' and k.nlsk LIKE '2901%' and ob22_='13' then

         update operw a set a.value='247' 
         where a.tag like 'D#73%' 
           and (trim(a.value) is null OR a.value NOT LIKE '247%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 
                                   
         update operw a set a.value='247'
         where a.tag='73'||k.tt 
           and (a.value is null or a.value NOT LIKE '247%') 
           and a.ref=k.ref; 

      end if;

      -- �������� i������� �i� �� ��� �������� �� ���i ������ 
      -- �������� ����� ��� �������� "������" OB22='76' ������ � ������ 2013
      -- �������� ����� ��� �������� "�����" OB22='72' ������ � ������ 2012
      -- �������� ����� ��� �������� "�����" OB22='73' ������ � ���� 2012
      -- �������� ����� ��� �������� "�������������" OB22='74' ������ � ���� 2012
      -- �������� ����� ��� �������� OB22='75' ������ � ������� 2012
      -- (OB22='75' - ����� ��� ������� �� ���������� ���������� �i������ ��i� � i������i� �����i)
      if (k.nlsd LIKE '100%' and k.nlsk LIKE '2909%' and 
         ob22_ in ('24','27','31','35','40','46','56','58','60','64','65','69','70','72','73','74','75','76') )
      then 

         update operw a set a.value='232'
         where a.tag LIKE 'D#73%'  
           and (a.value is null or a.value NOT LIKE '232%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 
                                   
         update operw a set a.value='232'
         where a.tag='73'||k.tt 
           and (a.value is null or a.value NOT LIKE '232%') 
           and a.ref=k.ref; 

      end if;

      -- �������� i������� �i� �� ��� �������� �� ���i ������ ������ ��� ��������
      if k.nlsd LIKE '100%' and k.nlsk LIKE '2909%' and 
         ob22_ in ('09') and mfo_g = 312356 then 

         update operw a set a.value='232'
         where a.tag LIKE 'D#73%' 
           and (a.value is null or a.value NOT LIKE '232%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 
                                   
         update operw a set a.value='232'
         where a.tag='73'||k.tt 
           and (a.value is null or a.value NOT LIKE '232%') 
           and a.ref=k.ref; 

      end if;

      -- �������� I� �i� �� �� ������i ���� 
      if k.nlsd LIKE '100%' and k.nlsk LIKE '1919%' then

         update operw a set a.value='233'
         where a.tag LIKE 'D#73%'  
           and (a.value is null or a.value NOT LIKE '233%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 
                                   
         update operw a set a.value='233'
         where a.tag='73'||k.tt 
           and (a.value is null or a.value NOT LIKE '233%') 
           and a.ref=k.ref; 

      end if;

      -- �������� �� �������� ������� 
      if k.nlsd LIKE '100%' and k.nlsk LIKE '2625%'  then

         update operw a set a.value='245'
         where a.tag LIKE 'D#73%'   
           and (a.value is null or a.value NOT LIKE '245%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 
                                   
         update operw a set a.value='245'
         where a.tag='73'||k.tt 
           and (a.value is null or a.value NOT LIKE '245%') 
           and a.ref=k.ref; 

         if Dat_ > to_date('29022016','ddmmyyyy')
         then
            update operw a set a.value='231'
            where a.tag LIKE 'D#73%'   
              and (a.value is null or a.value NOT LIKE '231%') 
              and a.ref=k.ref
              and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                               WHERE tag LIKE '73%'); 
                                      
            update operw a set a.value='231'
            where a.tag='73'||k.tt 
              and (a.value is null or a.value NOT LIKE '231%') 
              and a.ref=k.ref; 
          end if;

      end if;

      -- �������� I� �i� �� ��� ����������� �� ����.�������
      if k.nlsd LIKE '100%' and k.nlsk LIKE '2924%' then

         update operw a set a.value='245'
         where a.tag LIKE 'D#73%'   
           and (a.value is null or a.value NOT LIKE '245%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 
                                   
         update operw a set a.value='245'
         where a.tag='73'||k.tt 
           and (a.value is null or a.value NOT LIKE '245%') 
           and a.ref=k.ref; 

         if Dat_ > to_date('29022016','ddmmyyyy')
         then
            update operw a set a.value='231'
            where a.tag LIKE 'D#73%'   
              and (a.value is null or a.value NOT LIKE '231%') 
              and a.ref=k.ref
              and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                               WHERE tag LIKE '73%'); 
                                      
            update operw a set a.value='231'
            where a.tag='73'||k.tt 
              and (a.value is null or a.value NOT LIKE '231%') 
              and a.ref=k.ref; 
         end if;

      end if;

      -- �������� I� �i� �� ��� ��������� ������� �� �i�����i�
      if k.nlsd LIKE '100%'  and (k.nlsk LIKE '206%'  OR k.nlsk LIKE '207%'  OR 
                                  k.nlsk LIKE '220%'  OR k.nlsk LIKE '221%'  OR 
                                  k.nlsk LIKE '223%'  OR k.nlsk LIKE '2290%' OR 
                                  k.nlsk LIKE '2480%' OR k.nlsk LIKE '3578%' OR 
                                  k.nlsk LIKE '3579%' OR k.nlsk LIKE '3600%' OR 
                                  k.nlsk LIKE '3739%' OR 
                                  k.nlsk LIKE '2902%' and LOWER(k.nazn) like '%������%���%') then 

         if k.tt in ('024','���','BAK') and k.nlsk LIKE '3739%' then
            update operw a set a.value='000'
            where a.tag='D#73' 
              and (a.value is null or a.value NOT LIKE '000%') 
              and a.ref=k.ref
              and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                               WHERE tag LIKE '73%'); 
         else    
            if k.tt in ('���') and (LOWER(k.nazn) like '�����%' OR 
                                    LOWER(k.nazn) like '�����%') and 
               k.nlsk LIKE '3739%' then
               update operw a set a.value='000'
               where a.tag='D#73' 
                 and (a.value is null or a.value NOT LIKE '000%') 
                 and a.ref=k.ref
                 and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                                  WHERE tag LIKE '73%'); 
            else  
               if k.tt not in ('���') and (LOWER(k.nazn) like '�����%' OR 
                                           LOWER(k.nazn) like '�����%') and 
                  k.nlsk LIKE '3739%' then
                  update operw a set a.value='000'
                  where a.tag='D#73' 
                    and (a.value is null or a.value NOT LIKE '000%') 
                    and a.ref=k.ref
                    and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                                     WHERE tag LIKE '73%');
               else
                  if (LOWER(k.nazn) like '%�����%' OR LOWER(k.nazn) like '%�����%') and 
                      k.nlsk LIKE '3739%' then  
                      update operw a set a.value='232'
                      where a.tag='D#73' 
                        and (a.value is null or a.value NOT LIKE '232%') 
                        and a.ref=k.ref
                        and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                                         WHERE tag LIKE '73%'); 
                  else 
                     update operw a set a.value='246'
                     where a.tag='D#73' 
                       and (a.value is null or a.value NOT LIKE '246%') 
                       and a.ref=k.ref
                       and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                                        WHERE tag LIKE '73%'); 
                  end if;
               end if;
            end if;
         end if;

         update operw a set a.value='246'
         where a.tag='73'||k.tt 
           and (a.value is null or a.value NOT LIKE '246%') 
           and a.ref=k.ref;

      end if;

      -- �������� I� �i� �� ��� ��������� ������� �� �i�����i�
      if k.nlsd LIKE '100%' and substr(k.nlsk,1,4) in ('2628','2638') then

         update operw a set a.value='246'
         where a.tag='D#73'  
           and (a.value is null or a.value NOT LIKE '246%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 

         update operw a set a.value='246'
         where a.tag='73'||k.tt 
           and (a.value is null or a.value NOT LIKE '246%') 
           and a.ref=k.ref;

      end if;

      -- ������� I� � �� ��� ���i���� ������i�� � ���i �����
      if (k.nlsd LIKE '100%' or k.nlsd like '110%') and k.nlsk LIKE '3800%' and
         ob22_ in ('07','09','10') 
      then

         if k.tt in ('024','���','BAK') OR backr_ <> 0 then
            update operw a set a.value='000'
            where a.tag='D#73' 
              and (a.value is null or a.value NOT LIKE '000%') 
              and a.ref=k.ref
              and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                               WHERE tag LIKE '73%'); 

            update operw a set a.value='000'
            where a.tag='73'||k.tt
              and (a.value is null or a.value NOT LIKE '000%') 
              and a.ref=k.ref;
         else
            update operw a set a.value='261'
            where a.tag='D#73'  
              and (a.value is null or a.value NOT LIKE '261%') 
              and a.ref=k.ref 
              and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                               WHERE tag LIKE '73%'); 

            update operw a set a.value='261'
            where a.tag='73'||k.tt
              and (a.value is null or a.value NOT LIKE '261%') 
              and a.ref=k.ref;
         end if;
      end if;
      
      if (k.nlsd LIKE '100%' or k.nlsd like '110%') and k.nlsk LIKE '3800%' and
         ob22_ in ('07','09','10') and ( LOWER(k.nazn) like '�������� ������%' OR
                                         LOWER(k.nazn) like '�������� � ���%' OR
                                         LOWER(k.nazn) like '�_���_������%'  OR 
                                         LOWER(k.nazn) like '�_���_��.%' )
            then
               update operw a set a.value='000'
               where a.tag='D#73' 
                 and (a.value is null or a.value NOT LIKE '000%') 
                 and a.ref=k.ref
                 and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                                  WHERE tag LIKE '73%');
      end if;
     
      -- �������i� ������
      if k.nlsd LIKE '100%' and k.nlsk LIKE '3800%' and 
         ob22_ in ('03','07','09','10') and 
         (LOWER(k.nazn) like '%���������_�%')
      then
    
         --12.05.2016 
         --13.06.2017
         update operw a set a.value='248'   --'270'
         where a.tag='D#73'   
           and (a.value is null or a.value NOT LIKE '248%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 

         update operw a set a.value='248'
         where a.tag='73'||k.tt  
           and (a.value is null or a.value NOT LIKE '261%') 
           and a.ref=k.ref;
         
      end if;

      -- ���������� �� I� �������� �� ������ i����� �� �� i�����, �������i �� ��� 
      if k.nlsd LIKE '100%' and k.nlsk LIKE '2909%' and ob22_ in ('19','34') 
         and k.nlsk NOT LIKE '2909____000000%' then

         update operw a set a.value='270'
         where a.tag='D#73'  
           and (a.value is null or a.value NOT LIKE '270%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 

         update operw a set a.value='270'
         where a.tag='73'||k.tt 
           and (a.value is null or a.value NOT LIKE '270%') 
           and a.ref=k.ref;

      end if;

      -- �������� IB �i� �� �� i����i ���� 
      if k.nlsd LIKE '100%' and k.nlsk LIKE '2909%' and ob22_ ='36' then

         update operw a set a.value='233'
         where a.tag='D#73'  
           and (a.value is null or a.value NOT LIKE '233%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 

         update operw a set a.value='233'
         where a.tag='73'||k.tt 
           and (a.value is null or a.value NOT LIKE '233%') 
           and a.ref=k.ref;

      end if;

      -- ���i�i� ���
      if k.nlsd LIKE '100%' and k.nlsk LIKE '3800%' and ob22_='03' and 
              (LOWER(k.nazn) like '%���_�_�%' OR
               LOWER(k.nazn) like '%��������' OR
               LOWER(k.nazn) like '%�������' )
      then
    
         --01.02.2012 
         update operw a set a.value='270'
         where a.tag='D#73'   
           and (a.value is null or a.value NOT LIKE '261%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 

         update operw a set a.value='270'
         where a.tag='73'||k.tt  
           and (a.value is null or a.value NOT LIKE '261%') 
           and a.ref=k.ref;
         
      end if; 

      -- ����� ������i����� �������
      if k.nlsd LIKE '100%' and k.nlsk LIKE '3800%' and ob22_='03' 
         and (LOWER(k.nazn) like '%����� ���_��_����� �������%' OR
              LOWER(k.nazn) like '%����� ���_��_���_ �������%') 
      then
    
         --01.02.2012 ����� ���� ����
         update operw a set a.value='261'
         where a.tag='D#73'   
           and (a.value is null or a.value NOT LIKE '261%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 

         update operw a set a.value='261'
         where a.tag='73'||k.tt  
           and (a.value is null or a.value NOT LIKE '261%') 
           and a.ref=k.ref;

      end if;

      -- ������� I� i����� �����-���������
      if k.nlsd LIKE '1911%' and 
        (k.nlsk LIKE '100%' or k.nlsk LIKE '110%') and 
         ob22_='01' 
      then 

         update operw a set a.value='321'
         where a.tag='D#73'   
           and (a.value is null or a.value NOT LIKE '321%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 

         update operw a set a.value='321'
         where a.tag='73'||k.tt  
           and (a.value is null or a.value NOT LIKE '321%') 
           and a.ref=k.ref;

      end if;

      -- ������� I� i����� �����-���������
      if  k.nlsd LIKE '1811%' and (k.nlsk LIKE '100%' or k.nlsk LIKE '110%')
          and LOWER(k.nazn) not like '%���_�%'
      then 
       
         update operw a set a.value='323'
         where a.tag='D#73'   
           and (a.value is null or a.value NOT LIKE '323%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 

         update operw a set a.value='323'
         where a.tag='73'||k.tt  
           and (a.value is null or a.value NOT LIKE '323%') 
           and a.ref=k.ref;

      end if;

      -- ������� I� i����� �����-���������
      if k.nlsd LIKE '1911%' and 
         (k.nlsk LIKE '100%'  or k.nlsk LIKE '110%') and 
         ob22_='00' 
      then 

         update operw a set a.value='323'
         where a.tag='D#73'   
           and (a.value is null or a.value NOT LIKE '323%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 

         update operw a set a.value='323'
         where a.tag='73'||k.tt  
           and (a.value is null or a.value NOT LIKE '323%') 
           and a.ref=k.ref;

      end if;

      -- ������ I� � �������� ��� ���.���. �� �� ������������� �������.
      if substr(k.nlsd,1,4) IN ('2600','2602','2603','2604','2605','2610','2615') and 
         (k.nlsk LIKE '100%' or k.nlsk LIKE '110%') 
      then

         update operw a set a.value='325'
         where a.tag='D#73'   
           and (a.value is null or a.value NOT LIKE '325%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 

         update operw a set a.value='325'
         where a.tag='73'||k.tt  
           and (a.value is null or a.value NOT LIKE '325%') 
           and a.ref=k.ref;

      end if;        

      -- ������ I� �i������� � �� ������i�
      if substr(k.nlsd,1,4) IN ('2620','2630','2635') and 
         (k.nlsk LIKE '100%' or k.nlsk LIKE '110%') 
         --and LOWER(k.nazn) not like '%claim%'
      then

         update operw a set a.value='341'
         where a.tag='D#73'   
           and (a.value is null or a.value NOT LIKE '341%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 

         update operw a set a.value='341'
         where a.tag='73'||k.tt  
           and (a.value is null or a.value NOT LIKE '341%') 
           and a.ref=k.ref;

      end if;

      if k.nlsd LIKE '2809%' and (k.nlsk LIKE '100%' or k.nlsk LIKE '110%') and 
         ob22_ in ('09') then 

         update operw a set a.value='341'
         where a.tag='D#73'   
           and (a.value is null or a.value NOT LIKE '341%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 

         update operw a set a.value='341'
         where a.tag='73'||k.tt  
           and (a.value is null or a.value NOT LIKE '341%') 
           and a.ref=k.ref;

      end if;

      -- ������ i������� �� �� ���������� 
      -- �������� ����� ��� �������� "������" OB22='35' ������ � ������ 2013
      -- �������� ����� ��� �������� "�����" OB22='32' ������ � ������ 2012
      -- �������� ����� ��� �������� "�����" OB22='33' ������ � ���� 2012
      -- �������� ����� ��� �������� "�������������" OB22='34' ������ � ���� 2012
      if k.nlsd LIKE '2809%' and k.nlsk LIKE '100%' and 
         ob22_ in ('15','16','17','18','19','20','23','24','27','28','29','30','31','32','33','34','35') and
         LOWER(k.nazn) not like '%������%'
      then 
         update operw a set a.value='342'
         where a.tag='D#73'   
           and (a.value is null or a.value NOT LIKE '342%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 

         update operw a set a.value='342'
         where a.tag='73'||k.tt  
           and (a.value is null or a.value NOT LIKE '342%') 
           and a.ref=k.ref;

      end if;         

      -- �������� i������� �?� �� �� ���������� 
      -- �������� ����� ��� �������� "������" OB22='35' ������ � ������ 2013
      -- �������� ����� ��� �������� "�����" OB22='32' ������ � ������ 2012
      -- �������� ����� ��� �������� "�����" OB22='33' ������ � ���� 2012
      -- �������� ����� ��� �������� "�������������" OB22='34' ������ � ���� 2012
      if k.nlsd LIKE '100%' and k.nlsk LIKE '2809%' and 
         ob22_ in ('15','16','17','18','19','20','23','24','27','28','29','30','31','32','33','34','35') then 

         update operw a set a.value='232'
         where a.tag='D#73'   
           and (a.value is null or a.value NOT LIKE '232%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 

         update operw a set a.value='232'
         where a.tag='73'||k.tt  
           and (a.value is null or a.value NOT LIKE '232%') 
           and a.ref=k.ref;

      end if;         

      -- �������� ����� ��� �������� "������" OB22='76' ������ � ������ 2013
      -- �������� ����� ��� �������� "�����" OB22='72' ������ � ������ 2012
      -- �������� ����� ��� �������� "�����" OB22='73' ������ � ���� 2012
      -- �������� ����� ��� �������� "�������������" OB22='74' ������ � ���� 2012
      -- 03.12.2012 �� ����� 2909 � OB22='19' ����� ����������� ��� 342
      -- 02.01.2013 �� ����� 2909 � OB22='75' ����� ����������� ��� 342 
      -- ����� ��� ������� �� ���������� ���������� �i������ ��i� � i������i� �����i
      if k.nlsd LIKE '2909%' and k.nlsk LIKE '100%' and 
         ob22_ in ('11','19','24','27','31','35','40','42','46','55','56','58','60','64','65','69','70','72','73','74','75','76') then 

         update operw a set a.value='342'
         where a.tag='D#73'   
           and (a.value is null or a.value NOT LIKE '342%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 

         update operw a set a.value='342'
         where a.tag='73'||k.tt  
           and (a.value is null or a.value NOT LIKE '342%') 
           and a.ref=k.ref;

      end if;          

      -- ��� ������������� �������� (��������� ��������)
      if k.nlsd LIKE '2809%' and k.nlsk LIKE '100%' and 
         (LOWER(k.nazn) like '%����������%' OR  
          LOWER(k.nazn) like '%�����������%') 
      then 

         update operw a set a.value='370'
         where a.tag='D#73'   
           and (a.value is null or a.value NOT LIKE '370%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 

         update operw a set a.value='370'
         where a.tag='73'||k.tt  
           and (a.value is null or a.value NOT LIKE '370%') 
           and a.ref=k.ref;

      end if;          

      --������ I� �� �� ������
      if k.nlsd LIKE '1819%' and k.nlsk LIKE '100%' then

         update operw a set a.value='344'
         where a.tag='D#73'   
           and (a.value is null or a.value NOT LIKE '344%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 

         update operw a set a.value='344'
         where a.tag='73'||k.tt  
           and (a.value is null or a.value NOT LIKE '344%') 
           and a.ref=k.ref;

      end if;

      -- ������ I� �� �� ����i������� ��������
      if k.nlsd LIKE '2924%' and (k.nlsk LIKE '100%' or k.nlsk LIKE '110%') 
      then

         update operw a set a.value='345'
         where a.tag='D#73'   
           and (a.value is null or a.value NOT LIKE '345%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 

         update operw a set a.value='345'
         where a.tag='73'||k.tt  
           and (a.value is null or a.value NOT LIKE '345%') 
           and a.ref=k.ref;

         if Dat_ > to_date('29022016','ddmmyyyy')
         then           
            update operw a set a.value='341'
            where a.tag='D#73'   
              and (a.value is null or a.value NOT LIKE '341%') 
              and a.ref=k.ref
              and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                               WHERE tag LIKE '73%'); 
   
            update operw a set a.value='341'
            where a.tag='73'||k.tt  
              and (a.value is null or a.value NOT LIKE '341%') 
              and a.ref=k.ref;
         end if; 

      end if;

      -- ������ I� �i������� � �� ������i� �� ���
      if substr(k.nlsd,1,4) IN ('2625') and 
         (k.nlsk LIKE '100%' or k.nlsk LIKE '110%') 
      then

         update operw a set a.value='345'
         where a.tag='D#73'   
           and (a.value is null or a.value NOT LIKE '345%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 

         update operw a set a.value='345'
         where a.tag='73'||k.tt  
           and (a.value is null or a.value NOT LIKE '345%') 
           and a.ref=k.ref;

         if Dat_ > to_date('29022016','ddmmyyyy')
         then
            update operw a set a.value='341'
            where a.tag='D#73'   
              and (a.value is null or a.value NOT LIKE '341%') 
              and a.ref=k.ref
              and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                               WHERE tag LIKE '73%'); 
   
            update operw a set a.value='341'
            where a.tag='73'||k.tt  
              and (a.value is null or a.value NOT LIKE '341%') 
              and a.ref=k.ref;
         end if;

      end if;

      -- ������ I� �� � ���� ����� �� ������
      if (k.nlsd LIKE '206%'  OR k.nlsd LIKE '220%' OR 
          k.nlsd LIKE '221%'  OR k.nlsd LIKE '223%' OR 
          k.nlsd LIKE '2480%' OR k.nlsd LIKE '3739%' OR 
          k.nlsd LIKE '3600%' OR k.nlsd LIKE '3578%' OR 
          k.nlsd LIKE '3579%') and k.nlsk LIKE '100%' then

         if k.tt in ('024','���','BAK') and k.nlsd LIKE '3739%' then
            update operw a set a.value='000'
            where a.tag='D#73' 
              and (a.value is null or a.value NOT LIKE '000%') 
              and a.ref=k.ref
              and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                               WHERE tag LIKE '73%'); 
         else    
            if k.tt in ('���') and LOWER(k.nazn) like '�����%' and k.nlsd LIKE '3739%' then
               update operw a set a.value='000'
               where a.tag='D#73' 
                 and (a.value is null or a.value NOT LIKE '000%') 
                 and a.ref=k.ref
                 and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                                  WHERE tag LIKE '73%'); 
            else  
               update operw a set a.value='346'
               where a.tag='D#73' 
                 and (a.value is null or a.value NOT LIKE '346%') 
                 and a.ref=k.ref
                 and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                                  WHERE tag LIKE '73%'); 
            end if;
         end if;

         update operw a set a.value='346'
         where a.tag='73'||k.tt 
           and (a.value is null or a.value NOT LIKE '346%') 
           and a.ref=k.ref;

      end if;

      -- i��i �����������i ����������� ���������
      if k.nlsd LIKE '2801%' and k.nlsk LIKE '100%' and ob22_ in ('02','03','04') then

         update operw a set a.value='347' 
         where a.tag like 'D#73%' 
           and (trim(a.value) is null OR a.value NOT LIKE '347%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 
                                   
         update operw a set a.value='347'
         where a.tag='73'||k.tt 
           and (a.value is null or a.value NOT LIKE '347%') 
           and a.ref=k.ref; 

      end if;
              
      -- ������� I� �� ��� ���i���� ������i�� ����� ���� �����
      if k.nlsd LIKE '3800%' and (k.nlsk LIKE '100%' or k.nlsk like '110%') and 
         ob22_ in ('07','09','10') and 
         (LOWER(k.nazn) not like '%���������_�%')
      then

         if k.tt in ('024','���','BAK') OR backr_ <> 0 then
            update operw a set a.value='000'
            where a.tag='D#73' 
              and (a.value is null or a.value NOT LIKE '000%') 
              and a.ref=k.ref
              and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                               WHERE tag LIKE '73%'); 

            update operw a set a.value='000'
            where a.tag='73'||k.tt 
              and (a.value is null or a.value NOT LIKE '000%') 
              and a.ref=k.ref;
         else 
            if k.tt in ('���') and (LOWER(k.nazn) like '�����%' or 
                                    LOWER(k.nazn) like '���. �_���%') 
               and k.nlsd LIKE '3800%' 
            then
               update operw a set a.value='370'
               where a.tag='D#73' 
                 and (a.value is null or a.value NOT LIKE '370%') 
                 and a.ref=k.ref
                 and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                                  WHERE tag LIKE '73%');
            else 
               update operw a set a.value='361'
               where a.tag='D#73' 
                 and (a.value is null or a.value NOT LIKE '361%') 
                 and a.ref=k.ref
                 and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                                  WHERE tag LIKE '73%'); 

               update operw a set a.value='361'
               where a.tag='73'||k.tt 
                 and (a.value is null or a.value NOT LIKE '361%') 
                 and a.ref=k.ref;
            end if;
            if k.tt in ('���') and LOWER(k.nazn) like '�������%'
               and k.nlsd LIKE '3800%' 
            then
               update operw a set a.value='000'
               where a.tag='D#73' 
                 and (a.value is null or a.value NOT LIKE '000%') 
                 and a.ref=k.ref
                 and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                                  WHERE tag LIKE '73%');
            end if;
            if k.tt not in ('���') and ( LOWER(k.nazn) like '�������%' OR
                                         LOWER(k.nazn) like '�_���_������%' OR 
                                         LOWER(k.nazn) like '�����_%' OR 
                                         LOWER(k.nazn) like '�_�������%' OR
                                         LOWER(k.nazn) like '���. _��%'  OR
                                         LOWER(k.nazn) like '�_���_��.%' )
               and k.nlsd LIKE '3800%' 
            then
               update operw a set a.value='370'
               where a.tag='D#73' 
                 and (a.value is null or a.value NOT LIKE '370%') 
                 and a.ref=k.ref
                 and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                                  WHERE tag LIKE '73%');
            end if;
         end if;
      end if;
            
      -- �������i� ������
      if k.nlsd LIKE '3800%' and k.nlsk LIKE '100%' and 
         ob22_ in ('03','07','09','10') and 
         (LOWER(k.nazn) like '%���������_�%')
      then
    
         --12.05.2016 
         --13.06.2017 ��� 348
         update operw a set a.value='348'   --'370'
         where a.tag='D#73'   
           and (a.value is null or (a.value NOT LIKE '348%' and a.value NOT LIKE '248%')) 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 

         update operw a set a.value='348'   --'370'
         where a.tag='73'||k.tt  
           and (a.value is null or a.value NOT LIKE '361%') 
           and a.ref=k.ref;
       
      end if;
 
      -- ���������� �� I� �������� �� ������ i����� �� �� i�����, �������i �� ��� 
      -- 03.12.2012 �� ����� 2909 � OB22='19' ����� ����������� ��� 342 ������� ����� ������� 19
      if k.nlsd LIKE '2909%' and (k.nlsk LIKE '100%' or k.nlsk LIKE '110%') and  
         ob22_ in ('34') 
      then  

         update operw a set a.value='370'
         where a.tag='D#73'   
           and (a.value is null or a.value NOT LIKE '370%') 
           and trim(a.value)<>'370' 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 

           update operw a set a.value='370'
           where a.tag='73'||k.tt 
             and (a.value is null or a.value NOT LIKE '370%') 
             and trim(a.value)<>'370' 
             and a.ref=k.ref;

      end if;

      if k.nlsd LIKE '2909%' and k.nlsk LIKE '100%' and  
         ob22_ in ('19') and LOWER(k.nazn) like '%���%' then  

         update operw a set a.value='344'
         where a.tag='D#73'   
           and (a.value is null or a.value NOT LIKE '344%') 
           and trim(a.value)<>'344' 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 

           update operw a set a.value='344'
           where a.tag='73'||k.tt 
             and (a.value is null or a.value NOT LIKE '344%') 
             and trim(a.value)<>'344' 
             and a.ref=k.ref;

      end if;

      -- 23.02.2016 �� ����� 2909 � OB22='19' ����� ����������� ��� 370 
      if k.nlsd LIKE '2909%' and k.nlsk LIKE '100%' and  
         ob22_ in ('19') and LOWER(k.nazn) like '%������� ����%' then  

         update operw a set a.value='370'
         where a.tag='D#73'   
           and (a.value is null or a.value NOT LIKE '370%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 

           update operw a set a.value='370'
           where a.tag='73'||k.tt 
             and (a.value is null or a.value NOT LIKE '370%') 
             and a.ref=k.ref;
      end if;

      -- ������ I� �� �� ������ 
      if k.nlsd LIKE '2909%' and k.nlsk LIKE '100%' and ob22_ = '36' then  

         update operw a set a.value='344'
         where a.tag='D#73'   
           and (a.value is null or a.value NOT LIKE '344%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 

           update operw a set a.value='344'
           where a.tag='73'||k.tt 
             and (a.value is null or a.value NOT LIKE '344%') 
             and a.ref=k.ref;

      end if;

      if k.nlsd LIKE '2909%' and k.nlsk LIKE '100%' and 
         LOWER(k.nazn) like '%������ ���������%���_����%' 
      then

         update operw a set a.value='370'
         where a.tag LIKE 'D#73%'   
           and (a.value is null or a.value NOT LIKE '370%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 
                                   
         update operw a set a.value='370'
         where a.tag='73'||k.tt 
           and (a.value is null or a.value NOT LIKE '370%') 
           and a.ref=k.ref; 

      end if;

      -- ������ I� �� i��i �i�i
      if substr(k.nlsd,1,4) IN ('2628','2638','3500') and k.nlsk LIKE '100%' then 

         -- 07/09/2017 ����� ��� 370 �� ��� 341 (�������� ��� ������) 
         update operw a set a.value='341'
         where a.tag='D#73'   
           and (a.value is null or a.value NOT LIKE '341%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 

         update operw a set a.value='341'
         where a.tag='73'||k.tt 
           and (a.value is null or a.value NOT LIKE '341%') 
           and a.ref=k.ref; 

      end if;

      -- �������� ���������� �� ����i����i�
      if k.nlsd LIKE '100%' and k.nlsk LIKE '3552%' then 

         update operw a set a.value='270'
         where a.tag='D#73'   
           and (a.value is null or a.value NOT LIKE '270%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 

         update operw a set a.value='270'
         where a.tag='73'||k.tt 
           and (a.value is null or a.value NOT LIKE '270%') 
           and a.ref=k.ref; 

      end if;

      -- ����������� �� ����i����i�
      if k.nlsd LIKE '3552%' and k.nlsk LIKE '100%' then 

         update operw a set a.value='370'
         where a.tag='D#73'   
           and (a.value is null or a.value NOT LIKE '370%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 

         update operw a set a.value='370'
         where a.tag='73'||k.tt 
           and (a.value is null or a.value NOT LIKE '370%') 
           and a.ref=k.ref; 

      end if;

      -- ���������� ���������� �������� � I�
      if (k.nlsd LIKE '2809%' OR k.nlsd LIKE '2909%') and k.nlsk LIKE '100%' 
         and k.tt in ('M37','MMV','CN3','CN4')
         --and LOWER(k.nazn) not like '%��������%' 
      then 

         update operw a set a.value='370'
         where a.tag='D#73'   
           and (a.value is null or a.value NOT LIKE '370%') 
           and a.ref=k.ref
           and k.tt not in (SELECT substr(tag,-3) FROM op_rules 
                            WHERE tag LIKE '73%'); 

         update operw a set a.value='370'
         where a.tag='73'||k.tt 
           and (a.value is null or a.value NOT LIKE '370%') 
           and a.ref=k.ref; 

         begin
            select trim(w.value), 
               to_date(substr(replace(replace(trim(w1.value), ',','/'),'.','/'),1,10), 'dd/mm/yyyy')
               into ref_m37, dat_m37
            from operw w, operw w1
            where w.ref = k.ref
              and (w.tag like 'D_REF%' or w.tag like 'REFT%')
              and w1.ref = k.ref
              and (w1.tag like 'D_1PB%' or w1.tag like 'DATT%');
           
            begin
               select ref, fdat 
                  into ref_mmv, dat_mmv
               from provodki_otc 
               where ref = ref_m37
                 and kv = k.kv 
                 and nlsd = k.nlsk 
                 and rownum = 1;

               if to_char(k.fdat,'MM') = to_char(dat_mmv,'MM') then
                  update operw set value = '000' 
                  where ref = ref_m37 
                    and (tag like 'D#73%' or tag like '73%');

                  update operw set value = '000' 
                  where ref = k.ref 
                    and (tag like 'D#73%' or tag like '73%');
               end if;
            exception when no_data_found then
               null;
            end;
         EXCEPTION 
            WHEN NO_DATA_FOUND THEN
                null;
            when others then 
                raise_application_error(-20000, '������� ��� ��� = '||to_char(k.ref)||
                                        ': �������� ���.�������� D_1PB(DATT) �� D_REF(REFT)! '||sqlerrm);
         end;
 
      end if;  

      if k.sos != 5 then
         update operw 
         set value='000' 
         where ref=k.ref  
           and (tag='D#73' or tag='73'||k.tt);
      end if;

   end loop;
   ------------------------------------------------------------------------------ 
   
   logger.info ('P_F73_CH: End for '||to_char(dat_,'dd.mm.yyyy'));
end p_f73_ch;
/

