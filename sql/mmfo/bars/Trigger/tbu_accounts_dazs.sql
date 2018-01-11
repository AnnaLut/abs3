

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOUNTS_DAZS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_ACCOUNTS_DAZS ***

  CREATE OR REPLACE TRIGGER BARS.TBU_ACCOUNTS_DAZS 
BEFORE UPDATE OF DAZS ON ACCOUNTS
FOR EACH ROW
DECLARE
  l_active   NUMBER(1);
BEGIN
  /*
   -- 30.11.2017 KHOMIDAVV - ��� ��������� RNK2RNK ��������
  -- 10.02.2015 BAA - ��������� �������� ��� ��� ��������� ���� ��������� ������� (2625)
  --                - ���������� ��������� ������� 2625 �� �������� ������� �� �������� �������� ���
  --
  -- 19.11.2013 BAA - ���������� ����������� ������� ���������� ��������!
  --
  -- 29-08-2011 STA - �.�. ����� ����� ��������������� � ����� dapp, dappQ, dazs
  --                  �� ����� ������� �� �������� �� ��������������
  */

   IF sys_context('USERENV','ACTION') = 'rnk2rnk' THEN
     NULL;
   ELSE
      if ( (:old.dazs IS NULL) AND (:new.dazs IS NOT NULL) )
      then -- �������� �������

        if ( sys_context('USERENV','ACTION') = 'ACCREG.CloseAccount' )
        then -- account was closed by procedure CloseAccount from package ACCREG
          null;
        else

          IF (:new.dapp >= :NEW.dazs)
          THEN
            raise_application_error( -20444, ' ���.'|| :new.nls || ' ���.' || :new.kv ||
                                     ' ���� �����.���� ' || TO_CHAR(:new.dapp, 'dd.mm.yyyy') ||' >=' ||
                                     ' ���i �������� '   || TO_CHAR(:NEW.dazs, 'dd.mm.yyyy') );
          END IF;

          IF (:new.kv <> gl.baseval AND :new.dappQ >= :NEW.dazs)
          THEN
            raise_application_error( -20444, ' ���.' || :new.nls || ' ���.' || :new.kv ||
                                    ' ���� �����.������.'|| TO_CHAR(:new.dappQ,'dd.mm.yyyy') || ' >=' ||
                                    ' ���i �������� '    || TO_CHAR(:new.dazs, 'dd.mm.yyyy') );
          END IF;

          IF (SUBSTR (:new.TIP, 1, 2) = 'W4')
          THEN -- ���������� ��������� ������� 2625, ���� �� �������� ������� ������� �� ��������
              WITH acnt
                   AS (SELECT acc_id
                         FROM ( select ACC_OVR,
                                       ACC_9129,
                                       ACC_3570,
                                       ACC_2208,
                                       ACC_2627,
                                       ACC_2207,
                                       ACC_3579,
                                       ACC_2209,
                                       ACC_2625X,
                                       ACC_2627X,
                                       ACC_2625D,
                                       ACC_2628,
                                       ACC_2203
                                  from W4_ACC
                                 where ACC_PK = :new.acc
                              ) unpivot ( ACC_ID for acc_fild
                                                         IN (ACC_2203  AS '2203',
                                                             ACC_2207  AS '2207',
                                                             ACC_2208  AS '2208',
                                                             ACC_2209  AS '2209',
                                                             ACC_2627  AS '2627',
                                                             ACC_2628  AS '2628',
                                                             ACC_3570  AS '3570',
                                                             ACC_2625X AS '2625X',
                                                             ACC_3579  AS '3739',
                                                             ACC_2625D AS '2625D',
                                                             ACC_9129  AS '9129',
                                                             ACC_2627X AS '2627X',
                                                             ACC_OVR   AS 'OVER')))
              SELECT COUNT (1)
                INTO l_active
                FROM SALDOA s
                   , acnt a
               WHERE s.acc = a.acc_id
                 AND (s.acc, s.fdat) = ( SELECT c.acc, MAX(c.fdat)
                                           FROM saldoa c
                                          WHERE c.acc = a.acc_id
                                          GROUP BY c.acc )
                 AND (s.ostf + s.kos - s.dos) <> 0;

            if (l_active > 0)
            then
               raise_application_error ( -20444, '���������� �������� ������� (����� ������� �� ����� �������� �������� ���)!', TRUE );
            end if;

          END IF;

          -- ������ �� ����������� � 14/2-01/ID-4455 16.11.2015� ���� �������� ������� �� COBUSUPABS-3939
          IF ( :new.daos < TO_DATE('01.09.2015','dd.mm.yyyy') -- ������� �������� �� 01.09.2015 ����
                and
               :new.nbs IN ( -- ������ �������:
                             '2512','2513',
                             '2520','2523','2526',
                             '2530','2531',
                             '2541','2542','2544','2545',
                             '2552','2553','2554','2555',
                             '2560','2561','2562','2565',
                             '2570','2571','2572',
                             '2600','2601','2602','2603','2604',
                             '2640','2641','2642','2643','2644',
                             '2650',
                             -- ������ ������� � ������������� ���:
                             '2605','2655',
                             -- �������� �������:
                             '2525','2546','2610','2651')
             )
          THEN

            update SPECPARAM s
               set s.nkd = COALESCE( s.nkd, to_char(:new.rnk)||'_'||to_char(SYSDATE,'ddmmyyyy')||'_'||to_char(SYSDATE,'HH24MISS'))
             where s.acc = :new.acc;

            if ( sql%rowcount = 0 )
            then
               insert into SPECPARAM ( ACC, NKD )
               values ( :new.acc, to_char(:new.rnk)||'_'||TO_CHAR(SYSDATE,'ddmmyyyy')||'_'||TO_CHAR(SYSDATE,'HH24MISS'));
            end if;

          END IF;

        end if;

      end if;

      if ( (:new.dazs IS NULL) AND (:old.dazs IS NOT NULL) )
      then -- ����������� �������

        if ( sys_context('USERENV','ACTION') = 'ACCREG.RestoreAccount' )
        then -- account was restored by procedure CloseAccount from package ACCREG
          null;
        else

          begin
            select 1
              into l_active
              from PS
             where NBS = :new.NBS
               and D_CLOSE Is Null;
          exception
            when no_data_found then
              raise_application_error( -20444, '���������� ���������� ������� � R020='||:new.NBS, TRUE );
          end;

          if (:new.TIP IN ('DEP','DEN','NL8'))
          then -- ����������� ������� ���������� �������� ����������!

            SELECT CASE
                   WHEN EXISTS ( SELECT 1 -- ���������� �������� ��
                                   FROM DPT_ACCOUNTS a, DPT_DEPOSIT d
                                  WHERE a.accid = :new.acc
                                    AND a.dptid = d.deposit_id)
                   THEN 1
                   WHEN EXISTS ( SELECT 1 -- ���������� �������� ��
                                   FROM DPU_ACCOUNTS a, DPU_DEAL d
                                  WHERE a.ACCID  = :new.acc
                                    AND a.DPUID  = d.dpu_id
                                    AND d.CLOSED = 0 )
                   THEN 1
                   ELSE 0
                   END
              INTO l_active
              FROM DUAL;

            if (l_active = 0)
            then
              raise_application_error( -20444, '���������� ���������� �������, �� �������� ��������� ����������� ��������!', TRUE );
            end if;

          end if;

          if ( substr(:new.TIP,1,2) = 'W4' )
          then -- �������� ������ ��� ����� �������� ��������� ������� 2625
            update W4_ACC
               set DAT_CLOSE = NULL
             where ACC_PK = :new.acc
               and DAT_CLOSE IS NOT NULL;
          end if;

        end if;

      end if;
   end if;

END TBU_ACCOUNTS_DAZS;
/
ALTER TRIGGER BARS.TBU_ACCOUNTS_DAZS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOUNTS_DAZS.sql =========*** E
PROMPT ===================================================================================== 
