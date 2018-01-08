

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIG_REPORTS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIG_REPORTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIG_REPORTS ("ID", "USER_ID", "REP_DATE", "REP_TYPE", "DATA", "LINE_REQ", "REQ_TYPE", "REQ_TYPE2", "FIO") AS 
  select r."ID",
       r."USER_ID",
       r."REP_DATE",
       decode(r.REP_TYPE,
              '200046',
              'BLANK_IND',
              '200045',
              'BLANK_COMP',
              '200000',
              'BASIC_IND',
              '99993',
              'BASIC_COMP',
              '200017',
              'STANDARD_IND',
              '200014',
              'STANDARD_COMP',
              '200019',
              'ADVANCED_IND',
              '200018',
              'ADVANCED_COMP',
              '200049',
              'UNIVERSAL_IND',
              '200048',
              'UNIVERSAL_COMP',
              REP_TYPE) as REP_TYPE,
       r."DATA",
       r."LINE_REQ",
       decode(r.REQ_TYPE,
              '12',
              'Реєстраційний номер',
              '2',
              'TAX ID - первинний ключ для ФО та підприємців',
              '3',
              'Складений ключ (ім''я+прізвище+дата у форматі DDMMYYYY)') as REQ_TYPE,
       decode(r.REQ_TYPE, '12', 'ЮО', '2', 'ФО', '3', 'ФО') as REQ_TYPE2,
       s.fio
  from cig_reports r, STAFF$BASE s
 where r.user_id = s.id;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIG_REPORTS.sql =========*** End *** 
PROMPT ===================================================================================== 
