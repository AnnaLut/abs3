

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_OBPC_DOR.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_OBPC_DOR ***

  CREATE OR REPLACE PROCEDURE BARS.P_OBPC_DOR 
/* =============================================================================
-- Выборка технических счетов с кодами валют для блокировки в старом ПЦ
-- (для карт, у которых заканчивается срок действия и по счетам
-- выпущены карты в WAY4)
--
-- в поле YMD выбирается последнее число месяца
--
-- ZK001YMD.DOR, где
-- К
--   A - 0-MasterCard
--   B - 4-Visa
--   C - 1-Cirrus Maestro
--   E - 2-Visa Electron
-- Y (две последние цифры года)
--   10 - A
--   11 - B
--   12 - C
--   13 - D
--   14 - E
-- M (месяц)
--   10 - A
--   11 - B
--   12 - C
-- D (число)
--   28 - S
--   29 - T
--   30 - U
--   31 - V
*/
IS
  FileHandle    UTL_FILE.FILE_TYPE;
  BatFileHandle UTL_FILE.FILE_TYPE;
  cPath_        VARCHAR2(100) := 'OBPCD';
  cOpenMode_    VARCHAR2(1) := 'W';
  cFileName_    VARCHAR2(12);
  cCommandFile_ VARCHAR2(11) := 'MAKECOPY.SH';
  CRLF          CONSTANT CHAR(2) := CHR(13)||CHR(10); -- Carriage Return+Line Feed
BEGIN

  BatFileHandle := UTL_FILE.FOPEN (location  => cPath_,
                                   filename  => cCommandFile_,
                                   open_mode => cOpenMode_);

  -- MasterCard --
  SELECT 'ZA001' || decode(substr(trim(to_char(extract(YEAR from sysdate),'9999')),3,2),'10','A',
                                                                                        '11','B',
                                                                                        '12','C',
                                                                                        '13','D',
                                                                                        '14','E',
                                                                                        '15','F',
                                                                                        '16','G',
                                    substr(trim(to_char(extract(YEAR from sysdate),'9999')),3,2))
                 || decode(trim(to_char(extract(MONTH from sysdate),'99')),'10','A',
                                                                           '11','B',
                                                                           '12','C',
                                    trim(to_char(extract(MONTH from sysdate),'99')))
                 || decode(trim(to_char(extract(DAY from LAST_DAY(trunc(sysdate))),'99')),'28','S',
                                                                                          '29','T',
                                                                                          '30','U',
                                                                                          '31','V',
                                    trim(to_char(extract(DAY from LAST_DAY(trunc(sysdate))),'99')))
                 || '.DOR' INTO cFileName_ FROM DUAL;
  FileHandle := UTL_FILE.FOPEN (location  => cPath_,
                                filename  => cFileName_,
                                open_mode => cOpenMode_);

  FOR i IN (SELECT o.card_acct || ' ' || o.currency as InfoLine
              FROM accounts a, obpc_acct o, bpk_acc b, accounts a2
             WHERE ( o.expiry = LAST_DAY(trunc(sysdate)) -- карточка кончается в этом месяце
                OR                                       -- или карточка кончилась в прошлом месяце
                     o.expiry = LAST_DAY(to_date('10/'||to_char(extract(MONTH from sysdate)-1)||'/'||to_char(extract(YEAR from sysdate)),'DD/MM/YYYY'))
                   )
               AND a.nls = o.lacct
               AND a.dazs is null
               AND substr(o.card_acct,3,1) = '0'
               AND a.acc = b.acc_pk
               AND b.acc_w4 is not null
               AND a2.acc = b.acc_w4
               -- выборка с предыдущего понедельника
               AND a2.daos >= to_date(to_char(extract(day   from trunc(NEXT_DAY(sysdate,'MONDAY')-7)))||
                                      '/'||
                                      to_char(extract(month from trunc(NEXT_DAY(sysdate,'MONDAY')-7)))||
                                      '/'||
                                      to_char(extract(year  from trunc(NEXT_DAY(sysdate,'MONDAY')-7))),'DD/MM/YYYY')
             ORDER BY 1)
  LOOP
     UTL_FILE.PUT(FileHandle, i.InfoLine||CRLF);
  END LOOP;
  UTL_FILE.PUT(BatFileHandle, 'cp '||cFileName_|| ' \\S-25-01\GOU_ALL\NETORGI\IGOR\'||CRLF);
  UTL_FILE.FCLOSE(FileHandle);

  -- Visa --
  SELECT 'ZB001' || decode(substr(trim(to_char(extract(YEAR from sysdate),'9999')),3,2),'10','A',
                                                                                        '11','B',
                                                                                        '12','C',
                                                                                        '13','D',
                                                                                        '14','E',
                                                                                        '15','F',
                                                                                        '16','G',
                                    substr(trim(to_char(extract(YEAR from sysdate),'9999')),3,2))
                 || decode(trim(to_char(extract(MONTH from sysdate),'99')),'10','A',
                                                                           '11','B',
                                                                           '12','C',
                                    trim(to_char(extract(MONTH from sysdate),'99')))
                 || decode(trim(to_char(extract(DAY from LAST_DAY(trunc(sysdate))),'99')),'28','S',
                                                                                          '29','T',
                                                                                          '30','U',
                                                                                          '31','V',
                                    trim(to_char(extract(DAY from LAST_DAY(trunc(sysdate))),'99')))
                || '.DOR' INTO cFileName_ FROM DUAL;
  FileHandle := UTL_FILE.FOPEN (location  => cPath_,
                                filename  => cFileName_,
                                open_mode => cOpenMode_);
  FOR i IN (SELECT o.card_acct || ' ' || o.currency as InfoLine
              FROM accounts a, obpc_acct o, bpk_acc b, accounts a2
             WHERE ( o.expiry = LAST_DAY(trunc(sysdate)) -- карточка кончается в этом месяце
                OR                                       -- или карточка кончилась в прошлом месяце
                     o.expiry = LAST_DAY(to_date('10/'||to_char(extract(MONTH from sysdate)-1)||'/'||to_char(extract(YEAR from sysdate)),'DD/MM/YYYY'))
                   )
               AND a.nls = o.lacct
               AND a.dazs is null
               AND substr(o.card_acct,3,1) = '4'
               AND a.acc = b.acc_pk
               AND b.acc_w4 is not null
               AND a2.acc = b.acc_w4
               -- выборка с предыдущего понедельника
               AND a2.daos >= to_date(to_char(extract(day   from trunc(NEXT_DAY(sysdate,'MONDAY')-7)))||
                                      '/'||
                                      to_char(extract(month from trunc(NEXT_DAY(sysdate,'MONDAY')-7)))||
                                      '/'||
                                      to_char(extract(year  from trunc(NEXT_DAY(sysdate,'MONDAY')-7))),'DD/MM/YYYY')
             ORDER BY 1)
  LOOP
     UTL_FILE.PUT(FileHandle, i.InfoLine||CRLF);
  END LOOP;
  UTL_FILE.PUT(BatFileHandle, 'cp '||cFileName_|| ' \\S-25-01\GOU_ALL\NETORGI\IGOR\'||CRLF);
  UTL_FILE.FCLOSE(FileHandle);

  -- Cirrus Maestro
  SELECT 'ZC001' || decode(substr(trim(to_char(extract(YEAR from sysdate),'9999')),3,2),'10','A',
                                                                                        '11','B',
                                                                                        '12','C',
                                                                                        '13','D',
                                                                                        '14','E',
                                                                                        '15','F',
                                                                                        '16','G',
                                    substr(trim(to_char(extract(YEAR from sysdate),'9999')),3,2))
                 || decode(trim(to_char(extract(MONTH from sysdate),'99')),'10','A',
                                                                           '11','B',
                                                                           '12','C',
                                    trim(to_char(extract(MONTH from sysdate),'99')))
                 || decode(trim(to_char(extract(DAY from LAST_DAY(trunc(sysdate))),'99')),'28','S',
                                                                                          '29','T',
                                                                                          '30','U',
                                                                                          '31','V',
                                    trim(to_char(extract(DAY from LAST_DAY(trunc(sysdate))),'99')))
                || '.DOR' INTO cFileName_ FROM DUAL;
  FileHandle := UTL_FILE.FOPEN (location  => cPath_,
                                filename  => cFileName_,
                                open_mode => cOpenMode_);
  FOR i IN (SELECT o.card_acct || ' ' || o.currency as InfoLine
              FROM accounts a, obpc_acct o, bpk_acc b, accounts a2
             WHERE ( o.expiry = LAST_DAY(trunc(sysdate)) -- карточка кончается в этом месяце
                OR                                       -- или карточка кончилась в прошлом месяце
                     o.expiry = LAST_DAY(to_date('10/'||to_char(extract(MONTH from sysdate)-1)||'/'||to_char(extract(YEAR from sysdate)),'DD/MM/YYYY'))
                   )
               AND a.nls = o.lacct
               AND a.dazs is null
               AND substr(o.card_acct,3,1) = '1'
               AND a.acc = b.acc_pk
               AND b.acc_w4 is not null
               AND a2.acc = b.acc_w4
               -- выборка с предыдущего понедельника
               AND a2.daos >= to_date(to_char(extract(day   from trunc(NEXT_DAY(sysdate,'MONDAY')-7)))||
                                      '/'||
                                      to_char(extract(month from trunc(NEXT_DAY(sysdate,'MONDAY')-7)))||
                                      '/'||
                                      to_char(extract(year  from trunc(NEXT_DAY(sysdate,'MONDAY')-7))),'DD/MM/YYYY')
             ORDER BY 1)
  LOOP
     UTL_FILE.PUT(FileHandle, i.InfoLine||CRLF);
  END LOOP;
  UTL_FILE.PUT(BatFileHandle, 'cp '||cFileName_|| ' \\S-25-01\GOU_ALL\NETORGI\IGOR\'||CRLF);
  UTL_FILE.FCLOSE(FileHandle);

  -- Visa Electron
  SELECT 'ZE001' || decode(substr(trim(to_char(extract(YEAR from sysdate),'9999')),3,2),'10','A',
                                                                                        '11','B',
                                                                                        '12','C',
                                                                                        '13','D',
                                                                                        '14','E',
                                                                                        '15','F',
                                                                                        '16','G',
                                    substr(trim(to_char(extract(YEAR from sysdate),'9999')),3,2))
                 || decode(trim(to_char(extract(MONTH from sysdate),'99')),'10','A',
                                                                           '11','B',
                                                                           '12','C',
                                    trim(to_char(extract(MONTH from sysdate),'99')))
                 || decode(trim(to_char(extract(DAY from LAST_DAY(trunc(sysdate))),'99')),'28','S',
                                                                                          '29','T',
                                                                                          '30','U',
                                                                                          '31','V',
                                    trim(to_char(extract(DAY from LAST_DAY(trunc(sysdate))),'99')))
                || '.DOR' INTO cFileName_ FROM DUAL;
  FileHandle := UTL_FILE.FOPEN (location  => cPath_,
                                filename  => cFileName_,
                                open_mode => cOpenMode_);
  FOR i IN (SELECT o.card_acct || ' ' || o.currency as InfoLine
              FROM accounts a, obpc_acct o, bpk_acc b, accounts a2
             WHERE ( o.expiry = LAST_DAY(trunc(sysdate)) -- карточка кончается в этом месяце
                OR                                       -- или карточка кончилась в прошлом месяце
                     o.expiry = LAST_DAY(to_date('10/'||to_char(extract(MONTH from sysdate)-1)||'/'||to_char(extract(YEAR from sysdate)),'DD/MM/YYYY'))
                   )
               AND a.nls = o.lacct
               AND a.dazs is null
               AND substr(o.card_acct,3,1) = '2'
               AND a.acc = b.acc_pk
               AND b.acc_w4 is not null
               AND a2.acc = b.acc_w4
               -- выборка с предыдущего понедельника
               AND a2.daos >= to_date(to_char(extract(day   from trunc(NEXT_DAY(sysdate,'MONDAY')-7)))||
                                      '/'||
                                      to_char(extract(month from trunc(NEXT_DAY(sysdate,'MONDAY')-7)))||
                                      '/'||
                                      to_char(extract(year  from trunc(NEXT_DAY(sysdate,'MONDAY')-7))),'DD/MM/YYYY')
             ORDER BY 1)
  LOOP
     UTL_FILE.PUT(FileHandle, i.InfoLine||CRLF);
  END LOOP;
  UTL_FILE.PUT(BatFileHandle, 'cp '||cFileName_|| ' \\S-25-01\GOU_ALL\NETORGI\IGOR\'||CRLF);

  UTL_FILE.FCLOSE(FileHandle);
  UTL_FILE.FCLOSE(BatFileHandle);

/*
  BEGIN
    dbms_scheduler.create_job(
        job_name   => 'OBPC_DOR_COPY',
        job_type   => 'EXECUTABLE',
        job_action => '/oracle/upl/obpc/MAKECOPY.SH',
        enabled    => FALSE,
        comments   => 'Copying DOR-files to Novell Network resource');
    dbms_scheduler.enable('OBPC_DOR_COPY');
  END;
*/

END P_OBPC_DOR;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_OBPC_DOR.sql =========*** End **
PROMPT ===================================================================================== 
