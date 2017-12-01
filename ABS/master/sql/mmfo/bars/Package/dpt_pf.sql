
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/dpt_pf.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
CREATE OR REPLACE PACKAGE DPT_PF
IS
   G_HEADER_VERSION   CONSTANT VARCHAR2 (64) := ' version 1.05 22.11.2017';

   --
   --  ������� �������
   --
   FUNCTION header_version
      RETURN VARCHAR2;

   FUNCTION body_version
      RETURN VARCHAR2;

   ----------------------------------------------------------------------------------------------------------
   -- �-�� ������ �������� �� "���������" (������� ���������� �� �� �� ������ ���. 3-�� ������
   ----------------------------------------------------------------------------------------------------------
   PROCEDURE no_transfer_pf (p_rate IN brates.br_id%TYPE DEFAULT NULL -- ��� ������ "�� ���������"
                                                                     );

   ----------------------------------------------------------------------------------------------------------
   -- �-�� ��������� ����� ��� ���������� ��i�� ��� �� "���,�� ���� �� �����.����i�����"
   --
   PROCEDURE not_get_pension ( p_dat   IN  DATE,
                               p_dd    IN  NUMBER DEFAULT 1);
    --==================================================================================================
    -- ���������� ������ ��� ������ ��� �� �� ��������� ������
    --
    procedure not_get_pension_w4 (p_dat in date);
   ----------------------------------------------------------------------------------------------------------
   -- ��������� ��������� �� ������� (����������� ����)
   ----------------------------------------------------------------------------------------------------------
   PROCEDURE CREATE_DOCS_BY_LIST;
END DPT_PF;
/
CREATE OR REPLACE PACKAGE BODY DPT_PF
IS
--============ <Comments> =====================================================
-- 25.10.2011 - BAA ������ ��������� ���� � ����� �������� ������� ���������
-- 14.08.2012 -     ���������� ��������� ������������ � decode ��� ������ ���
-- 18.10.2013 -     ��������� ��������� �� ������� (����������� ����)
-- 13.05.2014 - ing �������� ��������� ������ "not_get_pension"
-- ��������� ������� ��� ������� �������� ������ BRSMAIN-2466
-- and fdos(acc, add_months(:l_dat_beg,-12), :l_dat_beg) > 0
-- (2. �������� ���������� ���������� � ��������� �� ��������� �������: ����� ����� ��������� ����� ����� ��������� ��� ������� ������ ����������  �� ���������� , �� ���� ��������� ���� ��������� ���� �� ��������� ����� ���� ��� �� ��������� ���� ����� ����  ������� � ��������� �����.)
-- lypskykh:
-- 12.04.2017 - ��������� ��������� ���������� �� ������� �� ��� ��� ���� �������� #COBUSUPABS-5267
-- 23.10.2017 - ���������� "����������" ������ �� ����� �� ��� - ��� ������ ora-600
-- 22.11.2017 - ��������� ����������� � start_fill_contracts. ��������� ��������� ��� ���������� ������ ��� ������ � �� �� ��������� ������
--=============================================================================

    --  / constants /
    --
    g_body_version  CONSTANT VARCHAR2(64)  := 'version 1.16 22.11.2017';
    g_modcode       CONSTANT varchar2(6)   := 'DPT_PF';
    g_errmsg        VARCHAR2(4000);

    -- / ������� ����� ��������� ������ /
    function header_version return varchar2 is
    begin
      return 'Package header '||g_modcode||g_header_version;
    end header_version;

    -- / ������� ����� ��� ������ /
    function body_version return varchar2
    is
    begin
      return 'Package body '||g_modcode||g_body_version;
    end body_version;

    -- ������������ �������� ��������
    -- ( ���� ������� / �������� ���������� � ���� �������� )
    procedure start_fill_contracts
    is
    l_ctx_mfo varchar2(30) := sys_context('bars_context', 'user_mfo');
    begin
        bars_audit.info('DPT_PF.start_fill_contracts: ������ DPT');
        for d in (select d.deposit_id, a.dapp
                  from BARS.DPT_DEPOSIT d,
                       BARS.ACCOUNTS    a,
                       ( select v.vidd, v.bsd as nbs_dep, p.val as ob22_dep
                           from BARS.DPT_VIDD v,
                                BARS.DPT_VIDD_PARAMS p
                          where v.bsd  = '2620'
                            and p.vidd = v.vidd
                            and p.tag  = 'DPT_OB22'
                            and p.val in ('20','21','17')
                       ) p
                 where d.vidd = p.vidd
                   and not exists (select 1 from DPT_DEPOSIT_DETAILS w where w.DPT_ID = d.DEPOSIT_ID)
                   and a.nbs  = p.nbs_dep
                   and a.ob22 = p.ob22_dep
                   and a.acc  = d.acc)
        loop
            begin
              Insert into BARS.DPT_DEPOSIT_DETAILS (dpt_id, dat_transfer_pf)
                   values (d.deposit_id, d.dapp);
            exception when OTHERS then null;
            end;
        end loop;
        bars_audit.info('DPT_PF.start_fill_contracts: ������ W4');
        for c in (SELECT distinct w4.nd, a.dapp
                   FROM BARS.ACCOUNTS a, w4_acc w4
                  WHERE w4.acc_pk = a.acc
                    AND W4.CARD_CODE like 'PENS%'
                    and not exists (select 1 from W4_PF_DETAILS w where w.ND = W4.ND))
        loop
        begin
          insert into BARS.W4_PF_DETAILS(ND, dat_transfer_pf)
               values (C.ND, C.dapp);
        exception when OTHERS then null;
        end;
        end loop;
        bars_audit.info('DPT_PF.start_fill_contracts: DPT_PF ����������');
        bc.set_context;
        --������������ ��������-���������� �� �����������
        for rec in (select kf from mv_kf)
        loop
          bc.go(rec.kf);
          merge into bars.dpt_deposit_details ddd
          using (with acclist as (select acc --�����-�����������
                                       from bars.accounts
                                       where nbs = '2909'
                                       and ob22 in ('22', '25')
                                       and (dazs is null or dazs > sysdate)),
                           saldolist as (select saldoa.acc, fdat  --���, �� ������� ���� ������� �� ����. �����
                                         from bars.saldoa
                                         join acclist on saldoa.acc = acclist.acc
                                         where saldoa.fdat >= add_months(bars.gl.bd, -1)),
                           opldoklist as (select ref  --���������, ��� ���� �������� � ������������
                                          from bars.opldok o
                                          join saldolist on o.fdat = saldolist.fdat and o.acc = saldolist.acc
                                          where o.dk = 0  /*��������*/),
                           deplist as (select d.deposit_id, max(o.fdat) vdat --��������, �� ������� ���� ���������� �� ���� ����������
                                       from bars.opldok o
                                       join opldoklist on o.ref = opldoklist.ref
                                       join bars.dpt_deposit d on o.acc = d.acc
                                       where o.dk = 1/*����������*/
                                       and o.sos = 5
                                       group by d.deposit_id)
                      select deposit_id, vdat from deplist) PF
          on (ddd.dpt_id = PF.deposit_id)
          when matched then update set ddd.dat_transfer_pf = PF.vdat
          when not matched then insert (ddd.dpt_id, ddd.dat_transfer_pf) values (PF.deposit_id, PF.vdat);
        end loop;
        bc.go(l_ctx_mfo);
        bc.set_policy_group('WHOLE');
        bars_audit.info('DPT_PF.start_fill_contracts: finish');
    end start_fill_contracts;

    -- ��������� ������ �������� �� "���������"
    -- (������� ���������� �� �� �� ������ ���. 3-�� ������
    PROCEDURE no_transfer_pf (p_rate IN brates.br_id%TYPE DEFAULT NULL) -- ��� ������ "�� ���������"                                                                  )
    IS
      type t_no_transfer_row is record ( dpt_id   dpt_deposit.deposit_id%type,
                                         dpt_acc  dpt_deposit.acc%type,
                                         r_idupd  int_ratn_arc.idupd%type,
                                         br_id    dpt_vidd.br_id%type,
                                         not_pf   char(1)
                                       );

      type t_no_transfer_tab is table of t_no_transfer_row;

      l_no_transfer_list     t_no_transfer_tab;

      l_limit_dat            date;         -- �������� ���� (���� �����.�����. ���� ����� �� ����� ������� "���Ѳ�Ͳ���")
      l_bdate                date;
      l_ir                   int_ratn.ir%type;
      l_br                   int_ratn.br%type;
      title                  varchar(30)  := g_modcode||'.NO_TRANSFER_PF: ';
    BEGIN
      -- ������������ �������� ��������
      start_fill_contracts();

      l_bdate     := gl.bd;

      /*   -  ���������, �� ������� ����  �� ���� ���������� � ��������� ����� �  ������� �����, �� ����      ��������� ���, �� ������ ���������� �� ������;
          ������ �� �� ���� � ���. ID-3036.
          ��������� ������� ̳����� ������ �1596 �� 30.08.1999 �.  ���� ������ ���� ��������� ��.3 ����� ���������� ������ � 734  �� 04.07.1998�.  � � ������ ��������� ���������� ��� � 1016 ��  19.11.2008.
      */
      l_limit_dat := add_months(l_bdate, -1);

      -- �������� � %-� �������� ������ �� ��������� ������
      --
      -- l_br := p_rate;
      --
      -- if (p_rate is not null) then
      --   l_ir := null;
      -- else
      --   l_ir := 0;
      -- end if;

      l_br := null;
      l_ir := 0;

      select d.deposit_id,
             d.acc,
             decode(w.RATE_OLD_ID, null, (select max(IDUPD) from INT_RATN_ARC where ACC = d.acc and ID = 1), w.RATE_OLD_ID),
             dv.br_id,
             decode(w.RATE_OLD_ID, null, 'Y', 'N')
        bulk collect
        into l_no_transfer_list
        from DPT_DEPOSIT d,
             DPT_VIDD dv,
             DPT_DEPOSIT_DETAILS w
       where d.vidd in ( select vidd from dpt_vidd v
                          where v.bsd = '2620' and v.vidd in ( select vidd from dpt_vidd_params
                                                                where tag = 'DPT_OB22' and val in ('20','21','17') ) )
         and d.DEPOSIT_ID = w.DPT_ID
         and dv.vidd = d.vidd
         and ( -- ���. �� ���� �� ���� ����� 3 ��. � ������ �� �� "�� �����."
               (w.DAT_TRANSFER_PF < l_limit_dat and w.RATE_OLD_ID is null    )
      -- and ( ( nvl(w.DAT_TRANSFER_PF, (SELECT max(fdat) FROM saldoa s WHERE s.acc = d.acc and s.kos != 0) ) < l_limit_dat and w.RATE_OLD_ID is null )
                or
               -- ���. �� ���� �������� ����������� � ������ "�� �����."
               (w.DAT_TRANSFER_PF > l_limit_dat and w.RATE_OLD_ID is not null)
             );

      for a in l_no_transfer_list.first .. l_no_transfer_list.last
      loop

        if l_no_transfer_list(a).not_pf = 'Y' then
          begin
            savepoint sp_before;
            -- ������� �������� �������������� ������ � ��������� ������� ������
            update DPT_DEPOSIT_DETAILS
               set RATE_OLD_ID = l_no_transfer_list(a).r_idupd
             where DPT_ID      = l_no_transfer_list(a).dpt_id;
            /*
            if sql%rowcount = 0 then -- ���� ����������� ���� �� ����� ���� �� ������ ���� � �� ����
               Insert into DPT_DEPOSIT_DETAILS
                 (DPT_ID, DAT_TRANSFER_PF, RATE_OLD_ID)
               Values
                 (l_no_transfer_list(a).dpt_id, (l_limit_dat - 1), l_no_transfer_list(a).r_idupd);
            end if;
            */
            -- ������������ ������ �� �������� ����� �� ������� �� ������� � ����� %-� ������ �� ������� �� ������.

            INSERT INTO INT_RATN (acc, id, bdat, ir, br)
                 VALUES (l_no_transfer_list (a).dpt_acc, 1, l_bdate, l_ir, l_br);

          EXCEPTION WHEN OTHERS
                    THEN rollback to sp_before;
                         LOGGER.info( title||'������� ���� ������ (acc => '||to_char(l_no_transfer_list(a).dpt_acc)||', dpt_id => '||to_char(l_no_transfer_list(a).dpt_id)||')' );
          END;

        else
          update DPT_DEPOSIT_DETAILS
             set RATE_OLD_ID = null
           where DPT_ID      = l_no_transfer_list(a).dpt_id;

          -- was: �������� ������ �� �������� ��� ���� �� "������ ���������"
          -- now: ������ ��� ������� ������, ������� ��������� �� ���� ������ �� �������
          begin
           insert into INT_RATN (ACC, ID, BDAT, BR)
           values (l_no_transfer_list(a).dpt_acc, 1, gl.bdate,l_no_transfer_list(a).br_id);
          exception when dup_val_on_index
                    then update INT_RATN
                            set br = l_no_transfer_list(a).br_id,
                                ir = null,
                                op = null
                          where acc = l_no_transfer_list(a).dpt_acc
                            and id = 1
                            and bdat = gl.bdate;
          end;

        end if;

        bars_audit.trace('%s �� ��������� ���� N %s (��� = %s) ������ ������ � %s �� 0', title,
                          to_char(l_no_transfer_list(a).dpt_id), to_char(l_no_transfer_list(a).dpt_acc), 'X');
      end loop;

    exception
      when OTHERS then bars_audit.info(title|| sqlerrm|| 'sqlcode = '|| sqlcode||', btrc='||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
    end no_transfer_pf;

    --==================================================================================================
    -- ���������� ��i�� ��� �� "���,�� ���� �� �����.����i�����"
    --
    PROCEDURE not_get_pension ( p_dat   IN  DATE,
                                p_dd    IN  NUMBER DEFAULT 1)
    IS
       /*
        * 08.07.2011  BAA - �� ������� �������� ��������� (��������� ���� ��������)
        */
       l_datv      opldok.fdat%TYPE;
       l_datd      opldok.fdat%TYPE;
       l_dat_end   DATE := p_dat;
       l_dat_beg   DATE := ADD_MONTHS (p_dat, -p_dd);

       TYPE t_dptrec IS RECORD
       (
          dptid    dpt_deposit.deposit_id%TYPE,
          dptacc   accounts.acc%TYPE,
          rnk      customer.rnk%TYPE,
          okpo     customer.okpo%TYPE,
          pasp     VARCHAR2 (30),
          dos      saldoa.dos%TYPE,
          agrid    dpt_agreements.agrmnt_id%TYPE
       );

       TYPE t_dptlist IS TABLE OF t_dptrec;
       l_dptlist   t_dptlist;

       TYPE t_cardrec IS RECORD
       (
          nd        w4_acc.nd%TYPE,
          w4acc     accounts.acc%TYPE,
          rnk       customer.rnk%TYPE,
          okpo      customer.okpo%TYPE,
          dos       saldoa.dos%TYPE
       );

       TYPE t_cardlist IS TABLE OF t_cardrec;

       l_cardlist   t_cardlist;

    BEGIN

       start_fill_contracts();
       bars_audit.info (
             'DPT_PF.NOT_GET_PENSION: start with params ( dat_beg = '
          || TO_CHAR (l_dat_beg, 'DD/MM/YYYY')
          || ', dat_end = '
          || TO_CHAR (l_dat_end, 'DD/MM/YYYY')
          || ')');

       EXECUTE IMMEDIATE ('truncate table T_OTCH_PF');

       SELECT deposit_id,
              acc,
              rnk,
              (SELECT okpo
                 FROM customer c
                WHERE c.rnk = d.rnk)             POKPO,
              (SELECT ser || ' ' || numdoc
                 FROM person p
                WHERE p.rnk = d.rnk)             PASPN,
              fdos (acc, l_dat_beg, l_dat_end)   DOS,
              (SELECT agrmnt_id
                 FROM dpt_agreements
                WHERE     dpt_id = d.deposit_id
                      AND agrmnt_type = 12
                      AND agrmnt_state = 1
                      AND ROWNUM = 1)
         BULK COLLECT
         INTO l_dptlist
         FROM dpt_deposit d
        WHERE EXISTS
                 (SELECT 1
                    FROM dpt_deposit_details
                   WHERE dpt_id = d.deposit_id
                     AND DAT_TRANSFER_PF >= l_dat_beg) -- ������ ������� �� �� �� ���� ���������� �� �� � ������� ��������� ������
          AND d.DATZ <= l_dat_beg;


        select w4.nd,
               w4.acc_pk,
               a.rnk,
               ( SELECT okpo
                  FROM customer c
                 WHERE c.rnk = a.rnk)               POKPO,
               fdos (a.acc, add_months(l_dat_end,-12), l_dat_end)   DOS
          bulk collect
          into l_cardlist
          from w4_acc w4, accounts a
         where w4.acc_pk = a.acc
           and exists (select 1 from w4_pf_details where nd = w4.nd);

       FOR i IN 1 .. l_dptlist.COUNT
       LOOP
          IF l_dptlist (i).DOS = 0
          THEN
             -- ���� ���.����. �� ������ �������� �� �������� ����� = 0
             INSERT INTO T_OTCH_PF (DPT_ID, ACC, RNK, OKPO, ID)
                  VALUES (l_dptlist (i).dptid,
                          l_dptlist (i).dptacc,
                          l_dptlist (i).rnk,
                          l_dptlist (i).okpo,
                          l_dptlist (i).agrid);
          ELSE
             -- ���� �� ������ �������� � ��������� ��������� �� �������� ����� ����� ������������
             IF l_dptlist (i).agrid IS NOT NULL
             THEN
                BEGIN
                   IF SUBSTR (l_dptlist (i).okpo, 1, 5) in ('99999','00000')
                   THEN
                      -- ���� ���� "������" �� ���������� �����
                      SELECT MAX (fdat_v), MAX (fdat_d)
                        INTO l_datv, l_datd
                        FROM (SELECT DECODE (PASPN,l_dptlist (i).pasp, fdat, TO_DATE (NULL)) AS fdat_v,
                                     DECODE (PASPN,l_dptlist (i).pasp, TO_DATE (NULL),fdat)  AS fdat_d
                                FROM (SELECT o.fdat,
                                             F_DOP (o.REF, 'PASPN') AS PASPN
                                        FROM opldok o
                                       WHERE o.fdat BETWEEN l_dat_beg AND l_dat_end
                                         AND o.acc = l_dptlist (i).dptacc
                                         AND o.dk = 0
                                         AND o.TT = 'DP1')
                             );
                   ELSE
                      -- ����� �� ����
                      SELECT MAX (fdat_v), MAX (fdat_d)
                        INTO l_datv, l_datd
                        FROM (SELECT DECODE (POKPO,l_dptlist (i).okpo, fdat,TO_DATE (NULL))  AS fdat_v,
                                     DECODE (POKPO,l_dptlist (i).okpo, TO_DATE (NULL),fdat)  AS fdat_d
                                FROM (SELECT o.fdat,
                                             F_DOP (o.REF, 'POKPO') AS POKPO
                                        FROM opldok o
                                       WHERE o.fdat BETWEEN l_dat_beg AND l_dat_end
                                         AND o.acc = l_dptlist (i).dptacc
                                         AND o.dk = 0
                                         AND o.TT = 'DP1')
                             );
                   END IF;

                   -- ���� �� �������� ����� �������� ����� ���� �� ��������� �� � ���...
                   IF ( (l_datd IS NOT NULL) AND (l_datv IS NULL))
                   THEN
                      INSERT INTO T_OTCH_PF (DPT_ID, ACC, RNK, OKPO, ID, DAT_OST)
                           VALUES (l_dptlist (i).dptid,
                                   l_dptlist (i).dptacc,
                                   l_dptlist (i).rnk,
                                   l_dptlist (i).okpo,
                                   l_dptlist (i).agrid,
                                   l_datv);
                   END IF;
                EXCEPTION WHEN NO_DATA_FOUND
                          THEN NULL;
                END;
             END IF;
          END IF;
       END LOOP;

         FOR j IN 1 .. l_cardlist.COUNT
           LOOP
              IF l_cardlist (j).DOS = 0
              THEN
                 -- ���� ���.����. �� ������ �������� �� �������� ����� = 0
                 INSERT INTO T_OTCH_PF (DPT_ID, ACC, RNK, OKPO)
                      VALUES (l_cardlist (j).nd,
                              l_cardlist (j).w4acc,
                              l_cardlist (j).rnk,
                              l_cardlist (j).okpo);
              END IF;
          END LOOP;

       bars_audit.info ('DPT_PF.NOT_GET_PENSION: ���� �������� ���������.');

       COMMIT;

       UPDATE T_OTCH_PF pf
          SET (nls,
               ob22,
               kv,
               branch) =
                 (SELECT nls,
                         ob22,
                         kv,
                         branch
                    FROM accounts a
                   WHERE a.acc = pf.acc),
              (nmk, adr) =
                 (SELECT nmk, adr
                    FROM customer c
                   WHERE c.rnk = pf.rnk),
              (dat_reg_d, dat_end_d) =
                 (SELECT date_begin, date_end
                    FROM dpt_agreements da
                   WHERE da.agrmnt_id = pf.id),
              DAT_1 = l_dat_beg,
              DAT_2 = l_dat_end,
              DAT_OST =
                 nvl((SELECT MAX (o.vdat)
                    FROM dpt_payments d, oper o
                   WHERE d.dpt_id = pf.dpt_id
                     AND d.REF = o.REF
                     AND F_DOP (d.REF, 'POKPO') = pf.OKPO),
                    (SELECT dapp
                       FROM accounts
                      WHERE pf.acc = acc)
                     );
       COMMIT;

       UPDATE T_OTCH_PF pf
          SET (nls,
               ob22,
               kv,
               branch) =
                 (SELECT nls,
                         ob22,
                         kv,
                         branch
                    FROM accounts a
                   WHERE a.acc = pf.acc),
              (nmk, adr) =
                 (SELECT nmk, adr
                    FROM customer c
                   WHERE c.rnk = pf.rnk),
              DAT_1 = l_dat_beg,
              DAT_2 = l_dat_end,
              DAT_OST =
                 (SELECT MAX (o.vdat)
                    FROM dpt_payments d, oper o
                   WHERE d.dpt_id = pf.dpt_id
                     AND d.REF = o.REF
                     AND F_DOP (d.REF, 'POKPO') = pf.OKPO);

       bars_audit.info ('DPT_PF.NOT_GET_PENSION: finish (selected ' || SQL%ROWCOUNT || ' rows)');
    EXCEPTION
       WHEN OTHERS
       THEN
          raise_application_error (
             -20001,
                DBMS_UTILITY.format_error_stack ()
             || CHR (10)
             || DBMS_UTILITY.format_error_backtrace ());
    END NOT_GET_PENSION;
    
    --==================================================================================================
    -- ���������� ������ ��� ������ �� ��������� ������
    --
    /*
    TODO: owner="oleksandr.lypskykh" category="Optimize" priority="3 - Low" created="22.11.2017"
    text="��������, ���� ����� ���������� � 296 ������� (not_get_pension) � ������ ���� �������, �� ������� ��� �������� ������ ������ ���������"
    */
    procedure not_get_pension_w4 (p_dat in date)
        is
        l_ctx_mfo varchar2(6) := sys_context('bars_context', 'user_mfo');
    begin
        bars_audit.info('DPT_PF.not_get_pension_w4: start');
        begin
            execute immediate 'alter table T_W4_OTCH_PF truncate partition for ('||l_ctx_mfo||')';
        exception
            when others then
                if sqlcode = -54 then 
                    bars_audit.error('DPT_PF.not_get_pension_w4: error: resource busy');
                    return; 
                else raise; 
                end if;
        end;
        bars_audit.info('DPT_PF.not_get_pension_w4: �������� ���������� ������');
        insert /*+ append parallel(8) */ into T_W4_OTCH_PF (branch, 
                                                            nls, 
                                                            rnk, 
                                                            okpo, 
                                                            nmk, 
                                                            bday, 
                                                            pass_ser, 
                                                            pass_num, 
                                                            indx1, 
                                                            np1, 
                                                            adr1, 
                                                            indx2, 
                                                            np2, 
                                                            adr2, 
                                                            card_code, 
                                                            code, 
                                                            pr, 
                                                            zar_365, 
                                                            zar_n_365, 
                                                            dmin_zar, 
                                                            dmax_zar, 
                                                            spi_365, 
                                                            spi_365_dw, 
                                                            dmax_spi, 
                                                            ost_2625, 
                                                            kf)
        select x.branch, 
               x.nls, 
               x.rnk, 
               x.okpo, 
               x.nmk, 
               x.bday, 
               x.PASS_SER, 
               x.PASS_NUM, 
               ca.zip as indx1,
               ca.locality as np1, 
               ca.address as adr1, 
               cb.zip as indx2, 
               cb.locality as np2, 
               cb.address as adr2, 
               x.CARD_CODE, 
               x.CODE, 
               x.PR, 
               x.ZAR_365, 
               x.ZAR_N_365, 
               x.DMIN_ZAR, 
               x.DMAX_ZAR, 
               x.SPI_365, 
               x.SPI_365_DW, 
               x.DMAX_SPI, 
               fost(x.acc, p_dat)/100 as ost_2625, 
               l_ctx_mfo
        from (
        select /*+ parallel(8) use_hash(wg wc w4 a2) */
        a2.branch,
               a2.acc,
               a2.nls,
               a2.rnk,
               c2.okpo,
               c2.nmk,
               p.bday,
               w4.CARD_CODE,
               wg.CODE,
               substr(w4.CARD_CODE, 6, 3) as PR,
               max(p.SER) as PASS_SER,
               max(p.NUMDOC) as PASS_NUM,
               round(sum(case
                           when o2.dk = 1 and o2.TT in ('PKX') AND
                                (o2.fdat between p_dat - 365 + 1 and
                                p_dat) then
                            nvl(o2.s, 0)
                           else
                            0
                         end) / 100,
                     2) as ZAR_365,
               sum(case
                     when o2.dk = 1 and o2.TT in ('PKX') AND
                          (o2.fdat between p_dat - 365 + 1 and
                          p_dat) then
                      1
                     else
                      0
                   end) as ZAR_N_365,
               round(sum(case
                           when (o2.dk = 0 and o2.TT in ('OW1') and
                                substr(p2.nlsa, 1, 4) = '2625' and
                                substr(p2.nlsb, 1, 4) in ('2920', '2924') AND
                                (o2.fdat between
                                p_dat - 365 + 1 and
                                p_dat)) or
                                (o2.dk = 0 and o2.TT in ('PKF', 'PKD') and
                                substr(p2.nlsa, 1, 4) = '2625' and
                                substr(p2.nlsb, 1, 4) in ('2909', '2924', '1002') AND
                                (o2.fdat between
                                p_dat - 365 + 1 and
                                p_dat)) then
                            nvl(o2.s, 0)
                           else
                            0
                         end) / 100,
                     2) as SPI_365,
               round(sum(case
                           when (o2.dk = 0 and o2.TT in ('PKF') and
                                substr(p2.nlsa, 1, 4) = '2625' and
                                substr(p2.nlsb, 1, 4) in ('2909', '2924', '1002') AND
                                (o2.fdat between
                                p_dat - 365 + 1 and
                                p_dat) and
                                translate(upper(trim(p.ser) || trim(p.numdoc)),
                                           '���Ų�������',
                                           'ABCEIKMHOPTX') <>
                                translate(upper(replace(trim((select ow.value
                                                                from operw ow
                                                               where o2.ref = ow.ref
                                                                 and ow.tag = 'PASPN')),
                                                         ' ',
                                                         '')),
                                           '���Ų�������',
                                           'ABCEIKMHOPTX')
                                
                                ) then
                            nvl(o2.s, 0)
                           else
                            0
                         end) / 100,
                     2) as SPI_365_DW,
               min(case
                     when o2.dk = 1 and o2.TT in ('PKX') AND
                          o2.fdat <= p_dat then
                      o2.fdat
                     else
                      NULL
                   end) as DMIN_ZAR,
               max(case
                     when o2.dk = 1 and o2.TT in ('PKX') AND
                          o2.fdat <= p_dat then
                      o2.fdat
                     else
                      NULL
                   end) as DMAX_ZAR,
               max(case
                     when (o2.dk = 0 and o2.TT in ('OW1') AND
                          o2.fdat <= p_dat and
                          substr(p2.nlsa, 1, 4) = '2625' and
                          substr(p2.nlsb, 1, 4) in ('2920', '2924')) or
                          (o2.dk = 0 and o2.TT in ('PKF', 'PKD') AND
                          o2.fdat <= p_dat and
                          substr(p2.nlsa, 1, 4) = '2625' and
                          substr(p2.nlsb, 1, 4) in ('2909', '2924', '1002')) then
                      o2.fdat
                     else
                      NULL
                   end) as DMAX_SPI

          from accounts          a2,
               opldok            o2,
               w4_acc            w4,
               oper              p2,
               w4_card           wc,
               w4_product        wp,
               w4_product_groups wg,
               customer          c2,
               person            p
         where a2.nbs = '2625'
           and (a2.dazs is NULL or a2.dazs > p_dat)
           and a2.daos <= p_dat - 365 + 1
           and o2.acc = a2.acc
           and o2.sos = 5
           --AND o2.fdat >= a2.daos
           AND o2.fdat <= p_dat
           and w4.acc_pk = a2.acc
           and o2.ref = p2.ref
           and wc.CODE = w4.CARD_CODE
           and wc.product_code = wp.code
           and wg.code = wp.GRP_CODE
           and wg.code = 'PENSION'
           and c2.rnk = a2.rnk
           and c2.rnk = p.rnk

         group by a2.branch,
                  a2.acc,
                  a2.nls,
                  a2.rnk,
                  c2.okpo,
                  c2.nmk,
                  p.bday,
                  w4.CARD_CODE,
                  wg.CODE
        ) x left join customer_address ca on (x.rnk=ca.rnk  and ca.type_id=1)
                 left join customer_address cb on (x.rnk=cb.rnk  and cb.type_id=2)
        where x.ZAR_365>0 /*and x.ZAR_N_365>9*/ and (x.SPI_365=0 or x.SPI_365=x.SPI_365_DW or x.SPI_365_DW>0)
        --  and x.DMAX_SPI >= add_months(p_dat-365+1,-1) -- DELTA
        --  and x.dmin_zar<=p_dat-365+1
          and x.dmax_zar>=add_months(TO_DATE('01.'||to_char(EXTRACT(MONTH FROM p_dat))||'.'||to_char(EXTRACT(YEAR FROM p_dat)),'dd.mm.yyyy'),-1);

        bars_audit.info('DPT_PF.not_get_pension_w4: finish');
    end not_get_pension_w4;
    

    --==================================================================================================
    -- ��������� ��������� �� ������� (����������� ����)
    --
    procedure CREATE_DOCS_BY_LIST
    is
      l_title   constant varchar2(30) := 'DPT_PF.CREATE_DOCS_BY_LIST:';
      l_tt      oper.tt%type;
      l_vob     oper.vob%type;
      l_dk      oper.dk%type;
      l_mfo     oper.MFOA%type;
      l_okpo    oper.ID_A%type;
      l_kv      oper.KV%type;
      l_vdat    oper.vdat%type;
      l_ref     oper.ref%type;
      l_depid   dpt_deposit.deposit_id%type;

      type t_list is table of pay_pfu%rowtype;
      l_list    t_list;
      ---
    begin

      l_vob  := 6;
      l_dk   := 1;
      l_mfo  := gl.aMFO;
      l_kv   := gl.baseval;
      l_vdat := gl.bDATE;
      l_okpo := gl.aOKPO;

      select *
        bulk collect
        into l_list
        from PAY_PFU
       where ISP = user_id
         and REF is Null;

      for k in 1 .. l_list.count
      Loop

        begin

          savepoint SP;

          select a.nms, c.okpo, d.deposit_id, decode(a.nbs, '2625', 'PKX', 'ALT')
            into l_list(k).nmsB, l_list(k).id_B, l_depid, l_tt
            from ACCOUNTS a
           inner join CUSTOMER    c on (c.RNK = a.RNK)
            left join DPT_DEPOSIT d on (d.ACC = a.ACC)
           where a.NLS = l_list(k).nlsB
             and a.KV  = l_kv
             and a.NBS in ('2620','2625')
             and a.DAZS is Null
             and c.CUSTTYPE = 3
             and c.DATE_OFF is Null;

          gl.ref(l_ref);

          gl.in_doc3( ref_   => l_ref,
                      tt_    => l_tt,             dk_    => l_dk,
                      vob_   => l_vob,            nd_    => SubStr(to_char(l_ref),1,10),
                      pdat_  => sysdate,          data_  => l_vdat,
                      vdat_  => l_vdat,           datp_  => l_vdat,
                      kv_    => l_kv,             kv2_   => l_kv,
                      s_     => l_list(k).S,      s2_    => l_list(k).S,
                      mfoa_  => l_mfo,            mfob_  => l_mfo,
                      nlsa_  => l_list(k).nlsA,   nlsb_  => l_list(k).nlsB,
                      nam_a_ => l_list(k).nmsA,   nam_b_ => l_list(k).nmsB,
                      id_a_  => l_okpo,           id_b_  => l_list(k).ID_B,
                      nazn_  => l_list(k).nazn,   uid_   => null,
                      d_rec_ => null,             sk_    => null,
                      id_o_  => null,             sign_  => null,
                      sos_   => null,             prty_  => null);

          paytt( null, l_ref, l_vdat, l_tt, l_dk,
                       l_kv,  l_list(k).nlsA, l_list(k).S,
                       l_kv,  l_list(k).nlsB, l_list(k).S );

          begin
            Insert into OPERW
              ( REF, TAG, VALUE )
            values
              ( l_ref, 'SK_ZB', to_char(l_list(k).SK_ZB) );
          exception
            when DUP_VAL_ON_INDEX then
              null;
          end;

          If (l_list(k).NLSB_ALT is not Null) then
             insert into OPERW
              ( ref, tag, value )
             values
              ( l_ref, 'ALT_K', l_list(k).NLSB_ALT );
          end if;

          update PAY_PFU
             set REF = l_ref
           where ID  = l_list(k).ID;

          -- ������ ������ "���Ѳ����Ҳ" �� �����
          if (l_depid is Not Null) then

            update DPT_DEPOSIT_DETAILS
               set DAT_TRANSFER_PF = gl.bd
             where DPT_ID = l_depid;

            if (sql%rowcount = 0) then
              insert into DPT_DEPOSIT_DETAILS
                ( DPT_ID, DAT_TRANSFER_PF )
              values
                ( l_depid, gl.bd );
            end if;

          end if;

        exception
          when OTHERS then

            bars_audit.info( l_title ||' ERROR: '|| dbms_utility.format_error_stack() ||chr(10)|| dbms_utility.format_error_backtrace() );

            update PAY_PFU
               set ERR_MSG = SubStr(dbms_utility.format_error_backtrace(),1,500)
             where ID = l_list(k).ID;

            rollback to SP;
        end;

      End Loop;

    end CREATE_DOCS_BY_LIST;

END DPT_PF;
/
show err;
 

PROMPT *** Create  grants  DPT_PF ***

grant DEBUG,EXECUTE                                                          on DPT_PF          to BARS_ACCESS_DEFROLE;

grant EXECUTE                                                                on DPT_PF          to DPT_ADMIN;


 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/dpt_pf.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 