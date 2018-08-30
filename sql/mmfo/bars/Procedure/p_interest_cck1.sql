
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/procedure/p_interest_cck1.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PROCEDURE BARS.P_INTEREST_CCK1 
 (
   p_type    IN NUMBER DEFAULT 0
  ,p_date_to IN DATE
 ) IS

   /*
     26/02/2018  Pogoda   ������ ���������� ���� �� ������ "������� �� �������"
     05/11/2017  Pivanova ������ ����� ��� ����������� basey=2 i basem=0
     18/07/2017  Pivanova ������ �������� ����� ��� ���������� �� �������
     27/05/2017  Pivanova ������ ����� �� ����������� % � ���������
     20/03/2017  Pivanova �������� ����������� �� ������� � �� ����� �������� �� ��
     19/03/2017  Pivanova ������ ���������� ������� ���� ��� ������� �����
     16/03/2017  Pivanova ������ ����������� ������� ��� ���������� �����������

    25.01.2017 Sta ������ ���������� � �� �� � ��

           ��   ��
     p_type = 1 , 11 �� ������ - �� �Ѳ� - ���i����� ���. %%  �� ����
     p_type = 2 , 12 �� ������ - � ��������� �� SG
     p_type=  5,15  ������   �������   - �� ��. �����
     p_type = 3 , 13 �������   - �� ��. �����
     p_type = 4 , 14 �������   - �� ������������ ���.
     p_type = 17   ��� ���� ���������

     p_type < 0 �� ������ - �� 1 ��
   */
   nint_  NUMBER;
   ddat2_ DATE; -- ��.���� �� ��� -1 ��� �������� ����  = ��
   d_prev DATE; -- ����.����-�� ��
   d_next DATE; -- ����.����-����
   l_nazn VARCHAR2(160);
   dd     cc_deal%ROWTYPE;
   k1     SYS_REFCURSOR;
   l_mode INT := 1;

   l_bdat_real DATE;
   l_bdat_next DATE;
   l_num  integer;

 BEGIN

   IF p_type >= 0
      AND p_type NOT IN (1, 2, 3, 4, 5, 11, 12, 13, 14, 15, 17) THEN
     RETURN;
   END IF;
   interest_utl.start_reckoning;
   IF p_date_to IS NULL and p_type not in(5,15) THEN
     l_bdat_real := nvl(p_date_to, gl.bdate);
     l_bdat_next := dat_next_u(l_bdat_real, 1);

     IF to_number(to_char(l_bdat_next, 'YYMM')) >
        to_number(to_char(l_bdat_real, 'YYMM')) THEN
       ddat2_ := trunc(l_bdat_next, 'MM') - 1;
     END IF;
   else
    ddat2_ := nvl(p_date_to, gl.bd);
   END IF;
    --ddat2_ := nvl(p_date_to, gl.bd);
   d_prev := dat_next_u(ddat2_, -1);
   d_next := ddat2_ + 1;

   IF p_type < 0 AND p_type <> -999 THEN
     -- �� ������- �� 1 ��
     OPEN k1 FOR
       SELECT nd, cc_id, sdate, wdate,ndg
         FROM cc_deal d
        WHERE nd = (-p_type)
          AND sos >= 10
          AND sos < 14
          AND vidd IN (1, 2, 3, 11, 12, 13);
     -- RAISE_APPLICATION_ERROR(-20008,p_type);
     pul.put('ND', substr(p_type, 2)); --��� ���������� ����������� view
   elsif p_type = 17 then
     OPEN k1 FOR
       SELECT d.nd, d.cc_id, d.sdate, d.wdate,ndg
         FROM cc_deal d, accounts a8, int_accn ia, nd_acc n, nd_txt tz
        WHERE p_type = 17
          AND vidd IN (11, 12, 13)
      AND ia.acc = a8.acc
      and ia.stp_dat is null
      AND n.acc = a8.acc
      AND n.nd = d.nd
      and tz.nd = d.nd
          AND ia.id in (0, 1)
      and tz.tag = 'FLAGS'
      and ia.s = 25
      and substr(tz.txt, 2, 1) = '0'
          and d.sos <> 15;
  ELSIF p_type = -999 THEN
     -- �� ������- �� 1 ��
     OPEN k1 FOR
       SELECT nd, cc_id, sdate, wdate, ndg
         FROM cc_deal d
        WHERE nd = (to_number(pul.get_mas_ini_val('ND')))
          AND sos >= 10
          AND sos < 14
          AND vidd IN (1, 2, 3, 11, 12, 13);

   ELSIF p_type IN (1, 11) THEN

     -- �� ������- �� �Ѳ�
     OPEN k1 FOR
       SELECT nd, cc_id, sdate, wdate,ndg
         FROM cc_deal d
        WHERE sos >= 10
          AND sos < 14
          AND (p_type = 1 AND vidd IN (1, 2, 3) OR
              p_type = 11 AND vidd IN (11, 12, 13));

   ELSIF p_type IN (2, 12) THEN
     -- �� ������- � ��������� �� SG
     OPEN k1 FOR
       SELECT nd, cc_id, sdate, wdate,ndg
         FROM cc_deal d
        WHERE sos >= 10
          AND sos < 14
          AND (p_type = 2 AND vidd IN (1, 2, 3) OR
              p_type = 12 AND vidd IN (11, 12, 13))
          AND EXISTS (SELECT 1
                 FROM accounts a, nd_acc n
                WHERE a.ostc > 0
                  AND a.tip = 'SG '
                  AND a.acc = n.acc
                  AND n.nd = d.nd);

   ELSIF p_type IN (3, 13) THEN
     -- �������   - �� ��. �����
     OPEN k1 FOR
       SELECT nd, cc_id, sdate, wdate,ndg
         FROM cc_deal d
        WHERE sos >= 10
          AND sos < 14
          AND (p_type = 3 AND vidd IN (1, 2, 3) OR
              p_type = 13 AND vidd IN (11, 12, 13))
          AND EXISTS (SELECT 1
                 FROM cc_lim
                WHERE nd = d.nd
                  AND fdat > d_prev
                  AND fdat < d_next);
   ELSIF p_type IN (5, 15) THEN
     -- �������   - �� ��. ����� ��ӯ���
     OPEN k1 FOR
       SELECT UNIQUE d.nd, d.cc_id, d.sdate, d.wdate,ndg
         FROM cc_deal d, accounts a8, int_accn ia, nd_acc n
        WHERE sos >= 10
          AND sos < 14
          AND (p_type = 5 AND vidd IN (1, 2, 3) OR
              p_type = 15 AND vidd IN (11, 12, 13))
          AND ia.acc = a8.acc
             --and ia.stp_dat is null
          AND ia.id = 0
          AND n.acc = a8.acc
          AND n.nd = d.nd
          AND ia.basey = 2
          AND ia.basem = 1
          AND ia.id = 0
          AND EXISTS (SELECT 1
                 FROM cc_lim
                WHERE nd = d.nd
                  AND fdat > d_prev
                  AND fdat < d_next);

   ELSIF p_type IN (3, 13) THEN
     -- �������   - �� ��. �����
     OPEN k1 FOR
       SELECT nd, cc_id, sdate, wdate,ndg
         FROM cc_deal d
        WHERE sos >= 10
          AND sos < 14
          AND (p_type = 3 AND vidd IN (1, 2, 3) OR
              p_type = 13 AND vidd IN (11, 12, 13))
          AND EXISTS (SELECT 1
                 FROM cc_lim
                WHERE nd = d.nd
                  AND fdat > d_prev
                  AND fdat < d_next);

   ELSIF p_type IN (4, 14) THEN
     -- �������  - �� ������������ ���.
     OPEN k1 FOR
       SELECT nd, cc_id, sdate, wdate,ndg
         FROM cc_deal d
        WHERE sos = 13
          AND d.wdate < ddat2_
          AND (p_type = 4 AND vidd IN (1, 2, 3) OR
              p_type = 14 AND vidd IN (11, 12, 13));

   END IF;

   IF NOT k1%ISOPEN THEN
     RETURN;
   END IF;



   LOOP
     FETCH k1
       INTO dd.nd, dd.cc_id, dd.sdate, dd.wdate,dd.ndg;
     EXIT WHEN k1%NOTFOUND;
     --------------------------------------------

     IF p_type IN (3, 13, 5, 15) THEN
       SELECT MAX(fdat) - 1
         INTO ddat2_
         FROM cc_lim
        WHERE nd = dd.nd
          AND fdat > d_prev
          AND fdat < d_next;
     END IF;

     FOR p IN (SELECT a.nls
                     ,a.accc
                     ,a.acc
                     ,a.tip
                     ,i.basem
                     ,i.basey
                     ,greatest(nvl(i.acr_dat, a.daos - 1), dd.sdate - 1) + 1 ddat1
                     ,i.metr
                     ,i.id
                     ,n.nd

                 FROM accounts a, int_accn i, nd_acc n
                   WHERE n.nd = dd.nd
                     AND n.acc = a.acc
                     AND a.acc = i.acc
                     AND (i.stp_dat IS NULL or i.stp_dat >=ddat2_)
                     AND (a.tip IN ('SS ', 'SP ', 'LIM', 'SPN', 'SK9','CR9') AND
                          i.id IN (0, 2) OR i.metr = 4 AND i.id = 1)
                     AND i.acra IS NOT NULL
                     AND i.acrb IS NOT NULL
                     AND i.acr_dat < ddat2_
               union
               SELECT a.nls,
                      a.accc,
                      a.acc,
                      a.tip,
                      i.basem,
                      i.basey,
                      greatest(nvl(i.acr_dat, a.daos - 1), dd.sdate - 1) + 1 ddat1,
                      i.metr,
                      i.id,
                      n.nd
                 FROM accounts a, int_accn i, nd_acc n,cc_deal d
                   WHERE n.acc = a.acc
                     and d.nd=n.nd
                     AND d.ndg=dd.nd
                     AND a.acc = i.acc
                     AND (i.stp_dat IS NULL or i.stp_dat >= ddat2_)
                     AND (a.tip IN ('SS ', 'SP ', 'LIM', 'SPN', 'SK9', 'CR9') AND
                         i.id IN (0, 2) OR i.metr = 4 AND i.id = 1)
                     AND i.acra IS NOT NULL
                     AND i.acrb IS NOT NULL
                     AND i.acr_dat < ddat2_)
     LOOP
       if p.ddat1 >= ddat2_ then
         logger.info('P_INTEREST_CCK1: ND = '||p.nd||', acc = '||p.acc||', ddat1 = '||p.ddat1||', ������� ��� ���������');
         continue;
       end if;
       DELETE FROM acr_intn;

       l_nazn := NULL;

       if p.tip in('SS ', 'SP ') and
          p.nd =dd.nd and
          p.id =0 and
          p.basey<>2
          and p.basem<>1 then

         acrn.p_int(p.acc, p.id, p.ddat1, ddat2_, nint_, NULL, l_mode);
       elsif p.tip in('SS ', 'SP ') and
             p.nd =dd.nd and
             p.id =0 and
             p.basey<>2 and
             p.basem is null then

          acrn.p_int(p.acc, p.id, p.ddat1, ddat2_, nint_, NULL, l_mode);
       elsif p.tip IN ('SS ')
         AND p.accc IS NOT NULL
         AND p.basey = 2
         AND p.basem = 1
         AND p.id = 0 THEN

           cck.int_metr_a(p.accc
                         ,p.acc
                         ,p.id
                         ,p.ddat1
                         ,ddat2_
                         ,nint_
                         ,NULL
                         ,l_mode); ------ ���������� �� ��������
       elsif p.tip IN ('SS ')
         AND p.accc IS NOT NULL
         AND p.basey = 2
         AND p.basem = 0
         AND p.id = 0 THEN

           cck.int_metr_a(p.accc
                         ,p.acc
                         ,p.id
                         ,p.ddat1
                         ,ddat2_
                         ,nint_
                         ,NULL
                         ,l_mode); ------ ���������� �� ��������
       ELSIF p.tip IN ('SS ', 'SP ')
         AND p.accc IS NOT NULL
         AND p.id = 0
         AND p.basey <> 2
         AND p.basem <> 1 THEN

           acrn.p_int(p.acc, p.id, p.ddat1, ddat2_, nint_, NULL, l_mode); ------ ���������� ����������
       ELSIF p.id = 1
         AND p.metr = 4
         AND p.tip IN ('S36') THEN

     -- add by VPogoda 2018-01-16, COBUMMFO-6039
     -- ����������� �������� ����������� ������ �� ��� ���������, �� ������� ���� ������.
     -- add by VPogoda 2018-01-16, COBUMMFO-6039
     -- ����������� �������� ����������� ������ �� ��� ���������, �� ������� ���� ������.
             select count(1) into l_num
               from (select 1 from accounts ac, nd_acc n, cc_deal cd
               where nvl(cd.ndg,cd.nd) = nvl(dd.ndg,dd.nd)
                 and n.nd = cd.nd
                 and n.acc = ac.acc
                 and ac.tip = 'SS '
                 and ac.dapp is not null
     --            and ac.ostb != 0
                 and exists (select 1 from cc_deal cd
                               where cd.nd = dd.nd
                                 and cd.vidd in (1,2,3,4))
             union select 1 from cc_deal cd where cd.nd = dd.nd and cd.vidd not in (1,2,3,4));
             if l_num != 0 then
               begin
                 acrn.p_int(p.acc, p.id, p.ddat1, ddat2_, nint_, NULL, l_mode); ------ ���������� ���������� */
  
                 l_nazn := substr('����������� ���.(�������.) ' || p.nls /*||
                                  '. �����: � ' || to_char(p.ddat1, 'dd.mm.yyyy') ||
                                  ' �� ' || to_char(ddat2_, 'dd.mm.yyyy') || ' ���.'*/
                                 ,1
                                 ,160);
  
               exception when others  then
                IF SQLCODE = -01476 THEN
                  logger.info('P_INTEREST_CCK1: ������� '||p.nd||', acc = '||p.acc||', ������: '||sqlerrm);
                  continue;
                else RAISE;    
                end if;
               end;

             else
               bars_audit.info('������� [ref = '||dd.nd||'] �� �� ������� �� �������� ������� �������������, ����������� �������� �� ����������!');
             end if;
       ELSIF p.id = 1
         AND p.metr = 4
         AND p.tip IN ('SDI')
         and 1=0    -- cobuprvnix-161 ���������� ����������� ��������
         THEN


             acrn.p_int(p.acc, p.id, p.ddat1, ddat2_, nint_, NULL, l_mode); ------ ���������� ���������� */
             l_nazn := substr('�����. �������� �� ���.' || p.nls /*||
                              '. �����: � ' || to_char(p.ddat1, 'dd.mm.yyyy') ||
                              ' �� ' || to_char(ddat2_, 'dd.mm.yyyy') || ' ���.'*/
                             ,1
                             ,160);
       ELSIF p.tip IN ('SP ', 'SPN', 'SK9')
         AND p.id = 2  THEN

             acrn.p_int(p.acc, p.id, p.ddat1, ddat2_, nint_, NULL, l_mode); ------ ���������� ����
             l_nazn := substr('����������� ���. �� � ' || dd.cc_id || ' ��  ' ||
                              to_char(dd.sdate, 'dd.mm.yyyy') || ', ���.' ||
                              p.nls /*|| '. �����: � ' ||
                              to_char(p.ddat1, 'dd.mm.yyyy') || ' �� ' ||
                              to_char(ddat2_, 'dd.mm.yyyy')*/
                             ,1
                             ,160);

     -- add by VPogoda 2018-02-26
         ELSIF p.tip IN ('LIM')
           AND p.id = 2
           and p.metr = 0 THEN

             acrn.p_int(p.acc, p.id, p.ddat1, ddat2_, nint_, NULL, l_mode); ------ ���������� �������� �� ������ "% �� �������"

             l_nazn := substr('����������� ����. �� � ' || dd.cc_id || ' ��  ' ||
                              to_char(dd.sdate, 'dd.mm.yyyy') || ', ���.' ||
                              p.nls /*|| '. �����: � ' ||
                              to_char(p.ddat1, 'dd.mm.yyyy') || ' �� ' ||
                              to_char(ddat2_, 'dd.mm.yyyy')*/
                             ,1
                             ,160);

           ELSIF p.tip IN ('CR9')
                 AND p.id = 0 THEN
             acrn.p_int(p.acc, p.id, p.ddat1, ddat2_, nint_, NULL, l_mode); ------ ���������� ����

             l_nazn := substr('���.�� �������.��� �� ���. ' ||
                              p.nls /*|| '. �����: � ' ||
                              to_char(p.ddat1, 'dd.mm.yyyy') || ' �� ' ||
                              to_char(ddat2_, 'dd.mm.yyyy')||' ���. '*/
                             ,1
                             ,160);
           ELSIF p.metr > 90
                 AND p.id = 2
                 AND p.tip = 'LIM' THEN
             cc_komissia(p.metr
                        ,p.acc
                        ,p.id
                        ,p.ddat1
                        ,ddat2_
                        ,nint_
                        ,NULL
                        ,l_mode); -------- ���������� ��������

             l_nazn := substr('����������� ����. �� � ' || dd.cc_id ||
                              ' ��  ' || to_char(dd.sdate, 'dd.mm.yyyy') /*||
                              '. �����: � ' || to_char(p.ddat1, 'dd.mm.yyyy') ||
                              ' �� ' || to_char(ddat2_, 'dd.mm.yyyy')*/
                             ,1
                             ,160);
           END IF;

           ------------------
           interest_utl.take_reckoning_data(p_base_year => p.basey
                                           ,p_purpose   => l_nazn
                                           ,p_deal_id   => dd.nd);


         END LOOP; -- p\
              update INT_RECKONING t set t.purpose =
            t.purpose || ' �����: � ' || to_char(t.date_from, 'dd.mm.yyyy') ||
            ' �� ' || to_char(t.DATE_TO, 'dd.mm.yyyy') || ' ���.'
              where t.deal_id =dd.nd;
   END LOOP; --k1


   CLOSE k1;

 END p_interest_cck1;
/
 show err;
 
PROMPT *** Create  grants  P_INTEREST_CCK1 ***
grant EXECUTE                                                                on P_INTEREST_CCK1 to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/procedure/p_interest_cck1.sql =========*** E
 PROMPT ===================================================================================== 
 