

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOUNTS_CHECKBLK.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_ACCOUNTS_CHECKBLK ***

  CREATE OR REPLACE TRIGGER BARS.TBU_ACCOUNTS_CHECKBLK 
   BEFORE UPDATE OF blkd
   ON accounts
   FOR EACH ROW
DECLARE
   l_acc_blkid   NUMBER;
   l_dpa_blk     NUMBER;
   l_nbs         VARCHAR2 (4);
   l_fnr         lines_f.fn_r%TYPE;
   l_idpr        lines_f.id_pr%TYPE;
   l_err         lines_f.err%TYPE;
   l_dat         lines_f.dat%TYPE;
   i             NUMBER;
BEGIN
   -- "������� �� ������� � ��"
   l_acc_blkid := NVL (TO_NUMBER (getglobaloption ('ACC_BLKID')), 0);
   -- "����������� �� ��������� ����������� ��� ��������� ������� � ���"
   l_dpa_blk := NVL (TO_NUMBER (getglobaloption ('DPA_BLK')), 0);

   -- �������� �� ���������� "������� �� ������� � ��"
   --    (��������������� ������������� ��� �������� ����� ��� �������� ����������).
   --    ���� ���� ������������, � ��� ���������� �� ����������.
   --    �������� ��� ���������� ����� ������������, �������� ��� ����� ������.
   IF l_acc_blkid > 0
   THEN
      -- ��������� ����������
      IF     (:new.blkd <> :old.blkd)
         AND (:new.blkd = l_acc_blkid OR :old.blkd = l_acc_blkid)
      THEN
         -- �������� �� ������������
         -- ���� ������������ ������ �������, ������ ��� ����� ������
         BEGIN
            SELECT 1
              INTO i
              FROM v_mainmenu_list
             WHERE     id = user_id
                   AND UPPER (funcname) LIKE
                          'FUNNSIEDITF%V_ACC_BLK_ACT%P_ACC_UNBLOCKACT%';
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               -- 14_06_17 ��������� ���� �� ������� ��������� ������
               bars_audit.info('DPA before err - user_id: ' || user_id );
               -- ��������� �����������/�������������� ���� ����� '�� ������ � ��������'
               bars_error.raise_nerror ('CAC', 'ACCOUNT_BLK_ACT_ERROR');
         END;

         -- ���� ���� ������������ � ���, ������ ��� ���������� "����������� �� ��������� ����������� ��� ��������� ������� � ���"
         IF l_dpa_blk > 0
         THEN
            IF     :old.blkd = l_acc_blkid
               AND :new.blkd <> l_acc_blkid
               AND NVL (:new.vid, 0) > 0
            THEN
               -- ���������� ����� ������ �� ����. dpa_nbs
               BEGIN
                  SELECT UNIQUE nbs
                    INTO l_nbs
                    FROM dpa_nbs
                   WHERE TYPE IN ('DPA', 'DPK', 'DPP') AND nbs = :new.nbs;

                  :new.blkd := l_dpa_blk;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     NULL;
               END;
            END IF;
         END IF;
      END IF;
   END IF;

   -- �������� �� ���������� "����������� �� ��������� ����������� ��� ��������� ������� � ���"
   --    (��������������� ������������� ��� �������� �����).
   --    ���������� ��������� ������������� ��� ��������� ��������� �� ���.
   --    ��� ������ ��������������� ����� ��������.
   -- ��� ���������� ������
   IF l_dpa_blk > 0
   THEN
      IF :old.blkd >= l_dpa_blk AND :new.blkd < l_dpa_blk AND :new.vid <> 0
      THEN
         -- ���� ���?
         BEGIN
            SELECT 1
              INTO i
              FROM dpa_nbs
             WHERE     TYPE IN ('DPA', 'DPK', 'DPP')
                   AND nbs = :new.nbs
                   AND taxotype IN (1, 6)
                   AND ROWNUM = 1;

            -- ���� �������� � ���?
            BEGIN
               SELECT distinct
			          fn_r,
                      id_pr,
                      err,
                      dat
                 INTO l_fnr,
                      l_idpr,
                      l_err,
                      l_dat
                 FROM lines_f f
                WHERE     nls = :new.nls
                      AND kv = :new.kv
                      AND otype IN (1, 6)
                      AND dat =
                             (SELECT MAX (dat)
                                FROM lines_f
                               WHERE     nls = f.nls
                                     AND kv = f.kv
                                     AND otype = f.otype);

               IF    (                                -- �������� ��������� @R
                       (  l_fnr LIKE '@R%' OR l_fnr LIKE '@I%')
                      AND -- 0-��� �������
                          -- 5-������� ��� �������� �� �����
                          NVL (l_idpr, 0) IN (0, 5)
                      AND --  0000-��� �������
                          NVL (l_err, '0000') = '0000')
                  OR (                               -- �������� ��������� @F2
                      l_fnr LIKE '@F2%' AND -- �� ����� ���������� �������� ��� ��� �������� ��������� @F1 �� @F2 ����������� ������������� �������
                                            TRUNC (l_dat) < bankdate)
               THEN
                  -- ��� ���������
                  NULL;
               ELSE
                  -- 28_09_17 ������� �������� ������ �� ������������, ���� �� ������� ����� �� ���
                  -- � ����� � ������������ ��������� ���������, ������� ������������ �� �����, ��������� ��������� �� ���������� ����������
                  IF :old.blkd = 26 and :new.blkd = 0 THEN
                    bars_audit.info('DPA ������ ������������� ����� �� ��������� �� ���������, ��� �����: ' || :new.nls
                                    || ' ������: ' || :new.kv
                                    || ' �������� ������������: ' || sys_context('userenv', 'session_user')
                                    || ' ���������: ' || sys_context('bars_context','user_branch')
                                    || ' ���������: ' || sys_context('bars_context','user_branch')
                                    || ' ������ ����������: ' || :old.blkd
                                    || ' ����� ����������: ' || :new.blkd
                                    || ' ����: ' || sysdate
                                    );
                  ELSE
                   -- ��������� �������������� ���� �� ��������� ��������� � ���������� ����� �� ���
                   bars_error.raise_nerror ('CAC', 'ACCOUNT_BLK_DPA_ERROR');
                  END IF;
               END IF;
            -- ���� � ��� �� ����������� (�.�. ������ ����)
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  NULL;
            END;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               NULL;
         END;
      END IF;
   END IF;
END;



/
ALTER TRIGGER BARS.TBU_ACCOUNTS_CHECKBLK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOUNTS_CHECKBLK.sql =========*
PROMPT ===================================================================================== 
