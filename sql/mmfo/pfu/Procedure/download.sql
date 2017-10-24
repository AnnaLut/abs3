

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Procedure/DOWNLOAD.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure DOWNLOAD ***

  CREATE OR REPLACE PROCEDURE PFU.DOWNLOAD IS
  RU_name    VARCHAR2(100);
  DateStart DATE;
  DateEnd   DATE;
  l_res number;


  l_kf00 varchar2(6) := '300465';
  l_kf0 varchar2(6) := '325796';
  l_kf1 varchar2(6) := '351823';
  l_kf2 varchar2(6) := '322669';
  l_kf3 varchar2(6) := '353553';
  l_kf4 varchar2(6) := '356334';
  l_kf5 varchar2(6) := '335106';
  l_kf6 varchar2(6) := '304665';
  l_kf7 varchar2(6) := '305482';
  l_kf8 varchar2(6) := '311647';

/*
  l_kf9 varchar2(6) := '324805';
*/  
  l_kf10 varchar2(6) := '302076';
  l_kf11 varchar2(6) := '303398';
  l_kf12 varchar2(6) := '312356';
  l_kf13 varchar2(6) := '313957';
  l_kf14 varchar2(6) := '336503';
  l_kf15 varchar2(6) := '323475';
  l_kf16 varchar2(6) := '326461';
  l_kf17 varchar2(6) := '328845';
  l_kf18 varchar2(6) := '331467';
  l_kf19 varchar2(6) := '333368';
  l_kf20 varchar2(6) := '337568';
  l_kf21 varchar2(6) := '338545';
  l_kf22 varchar2(6) := '352457';
  l_kf23 varchar2(6) := '315784';
  l_kf24 varchar2(6) := '354507';


begin

/*
--------------------
  select substr(name,5,100) into RU_name from pfu_syncru_params where kf=l_kf00;
  insert into TMP_DOWNLOAD (mfo, name) values( l_kf00, RU_name);
  commit; 
--  bars_audit.info('PFU_EXPORT start. Обработка реестра по МФО '||to_char(l_kf00)||' ('||RU_name||').');  
  delete from pfu_pensioner p where p.kf = l_kf00;
  insert into pfu_pensioner(ID,                KF,    BRANCH,    RNK,   NMK,   OKPO,   ADR,   DATE_ON,   DATE_OFF,    PASSP,  SER,    NUMDOC, PDATE,    ORGAN,   BDAY, BPLACE,   CELLPHONE, STATE,  SYS_TIME,COMM,LAST_RU_IDUPD,LAST_RU_CHGDATE,BLOCK_DATE,BLOCK_TYPE,TYPE_PENSIONER)
  select s_pfupens.nextval, t.mfo, t.branch, t.rnk, t.nmk, t.okpo, t.adr, t.date_on, t.date_off, t.passp, t.ser, t.numdoc, t.pdate, t.organ, t.bday, t.bplace, t.cellphone, null, sysdate, null, t.idupd, sysdate, null, null, null from test_cust t 
   where t.mfo = l_kf00;
  
  delete from pfu_pensacc pa where pa.kf = l_kf00;
  insert into pfu_pensacc (id, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, dazs, state, sys_time, last_ru_idupd, last_ru_chgdate, transacc, transkv)
  select s_pfupensacc.nextval, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, null, null, sysdate, idupd, sysdate, null, null from test_acc t 
   where t.kf = l_kf00;
--  bars_audit.info('PFU_EXPORT end. Обработка реестра по МФО '||to_char(l_kf00)||' ('||RU_name||').');  
  update TMP_DOWNLOAD set date_end=(select sysdate from dual) where mfo=l_kf00;
  commit;
--------------------


--------------------
  select substr(name,5,100) into RU_name from pfu_syncru_params where kf=l_kf0;
  insert into TMP_DOWNLOAD (mfo, name) values( l_kf0, RU_name);
  commit; 
--  bars_audit.info('PFU_EXPORT start. Обработка реестра по МФО '||to_char(l_kf0)||' ('||RU_name||').');  
  delete from pfu_pensioner p where p.kf = l_kf0;
  insert into pfu_pensioner(ID,                KF,    BRANCH,    RNK,   NMK,   OKPO,   ADR,   DATE_ON,   DATE_OFF,    PASSP,  SER,    NUMDOC, PDATE,    ORGAN,   BDAY, BPLACE,   CELLPHONE, STATE,  SYS_TIME,COMM,LAST_RU_IDUPD,LAST_RU_CHGDATE,BLOCK_DATE,BLOCK_TYPE,TYPE_PENSIONER)
  select s_pfupens.nextval, t.mfo, t.branch, t.rnk, t.nmk, t.okpo, t.adr, t.date_on, t.date_off, t.passp, t.ser, t.numdoc, t.pdate, t.organ, t.bday, t.bplace, t.cellphone, null, sysdate, null, t.idupd, sysdate, null, null, null from test_cust t 
   where t.mfo = l_kf0;
  
  delete from pfu_pensacc pa where pa.kf = l_kf0;
  insert into pfu_pensacc (id, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, dazs, state, sys_time, last_ru_idupd, last_ru_chgdate, transacc, transkv)
  select s_pfupensacc.nextval, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, null, null, sysdate, idupd, sysdate, null, null from test_acc t 
   where t.kf = l_kf0;
--  bars_audit.info('PFU_EXPORT end. Обработка реестра по МФО '||to_char(l_kf00)||' ('||RU_name||').');  
  update TMP_DOWNLOAD set date_end=(select sysdate from dual) where mfo=l_kf0;
  commit;
--------------------


--------------------
  select substr(name,5,100) into RU_name from pfu_syncru_params where kf=l_kf1;
  insert into TMP_DOWNLOAD (mfo, name) values( l_kf1, RU_name);
  commit; 
--  bars_audit.info('PFU_EXPORT start. Обработка реестра по МФО '||to_char(l_kf1)||' ('||RU_name||').');  
  delete from pfu_pensioner p where p.kf = l_kf1;
  insert into pfu_pensioner(ID,                KF,    BRANCH,    RNK,   NMK,   OKPO,   ADR,   DATE_ON,   DATE_OFF,    PASSP,  SER,    NUMDOC, PDATE,    ORGAN,   BDAY, BPLACE,   CELLPHONE, STATE,  SYS_TIME,COMM,LAST_RU_IDUPD,LAST_RU_CHGDATE,BLOCK_DATE,BLOCK_TYPE,TYPE_PENSIONER)
  select s_pfupens.nextval, t.mfo, t.branch, t.rnk, t.nmk, t.okpo, t.adr, t.date_on, t.date_off, t.passp, t.ser, t.numdoc, t.pdate, t.organ, t.bday, t.bplace, t.cellphone, null, sysdate, null, t.idupd, sysdate, null, null, null from test_cust t 
   where t.mfo = l_kf1;
  
  delete from pfu_pensacc pa where pa.kf = l_kf1;
  insert into pfu_pensacc (id, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, dazs, state, sys_time, last_ru_idupd, last_ru_chgdate, transacc, transkv)
  select s_pfupensacc.nextval, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, null, null, sysdate, idupd, sysdate, null, null from test_acc t 
   where t.kf = l_kf1;
--  bars_audit.info('PFU_EXPORT end. Обработка реестра по МФО '||to_char(l_kf00)||' ('||RU_name||').');  
  update TMP_DOWNLOAD set date_end=(select sysdate from dual) where mfo=l_kf1;
  commit;
--------------------


--------------------
  select substr(name,5,100) into RU_name from pfu_syncru_params where kf=l_kf2;
  insert into TMP_DOWNLOAD (mfo, name) values( l_kf2, RU_name);
  commit; 
--  bars_audit.info('PFU_EXPORT start. Обработка реестра по МФО '||to_char(l_kf2)||' ('||RU_name||').');  
  delete from pfu_pensioner p where p.kf = l_kf2;
  insert into pfu_pensioner(ID,                KF,    BRANCH,    RNK,   NMK,   OKPO,   ADR,   DATE_ON,   DATE_OFF,    PASSP,  SER,    NUMDOC, PDATE,    ORGAN,   BDAY, BPLACE,   CELLPHONE, STATE,  SYS_TIME,COMM,LAST_RU_IDUPD,LAST_RU_CHGDATE,BLOCK_DATE,BLOCK_TYPE,TYPE_PENSIONER)
  select s_pfupens.nextval, t.mfo, t.branch, t.rnk, t.nmk, t.okpo, t.adr, t.date_on, t.date_off, t.passp, t.ser, t.numdoc, t.pdate, t.organ, t.bday, t.bplace, t.cellphone, null, sysdate, null, t.idupd, sysdate, null, null, null from test_cust t 
   where t.mfo = l_kf2;
  
  delete from pfu_pensacc pa where pa.kf = l_kf2;
  insert into pfu_pensacc (id, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, dazs, state, sys_time, last_ru_idupd, last_ru_chgdate, transacc, transkv)
  select s_pfupensacc.nextval, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, null, null, sysdate, idupd, sysdate, null, null from test_acc t 
   where t.kf = l_kf2;
--  bars_audit.info('PFU_EXPORT end. Обработка реестра по МФО '||to_char(l_kf00)||' ('||RU_name||').');  
  update TMP_DOWNLOAD set date_end=(select sysdate from dual) where mfo=l_kf2;
  commit;
--------------------


--------------------
  select substr(name,5,100) into RU_name from pfu_syncru_params where kf=l_kf3;
  insert into TMP_DOWNLOAD (mfo, name) values( l_kf3, RU_name);
  commit; 
--  bars_audit.info('PFU_EXPORT start. Обработка реестра по МФО '||to_char(l_kf3)||' ('||RU_name||').');  
  delete from pfu_pensioner p where p.kf = l_kf3;
  insert into pfu_pensioner(ID,                KF,    BRANCH,    RNK,   NMK,   OKPO,   ADR,   DATE_ON,   DATE_OFF,    PASSP,  SER,    NUMDOC, PDATE,    ORGAN,   BDAY, BPLACE,   CELLPHONE, STATE,  SYS_TIME,COMM,LAST_RU_IDUPD,LAST_RU_CHGDATE,BLOCK_DATE,BLOCK_TYPE,TYPE_PENSIONER)
  select s_pfupens.nextval, t.mfo, t.branch, t.rnk, t.nmk, t.okpo, t.adr, t.date_on, t.date_off, t.passp, t.ser, t.numdoc, t.pdate, t.organ, t.bday, t.bplace, t.cellphone, null, sysdate, null, t.idupd, sysdate, null, null, null from test_cust t 
   where t.mfo = l_kf3;
  
  delete from pfu_pensacc pa where pa.kf = l_kf3;
  insert into pfu_pensacc (id, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, dazs, state, sys_time, last_ru_idupd, last_ru_chgdate, transacc, transkv)
  select s_pfupensacc.nextval, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, null, null, sysdate, idupd, sysdate, null, null from test_acc t 
   where t.kf = l_kf3;
--  bars_audit.info('PFU_EXPORT end. Обработка реестра по МФО '||to_char(l_kf00)||' ('||RU_name||').');  
  update TMP_DOWNLOAD set date_end=(select sysdate from dual) where mfo=l_kf3;
  commit;
--------------------


--------------------
  select substr(name,5,100) into RU_name from pfu_syncru_params where kf=l_kf4;
  insert into TMP_DOWNLOAD (mfo, name) values( l_kf4, RU_name);
  commit; 
--  bars_audit.info('PFU_EXPORT start. Обработка реестра по МФО '||to_char(l_kf4)||' ('||RU_name||').');  
  delete from pfu_pensioner p where p.kf = l_kf4;
  insert into pfu_pensioner(ID,                KF,    BRANCH,    RNK,   NMK,   OKPO,   ADR,   DATE_ON,   DATE_OFF,    PASSP,  SER,    NUMDOC, PDATE,    ORGAN,   BDAY, BPLACE,   CELLPHONE, STATE,  SYS_TIME,COMM,LAST_RU_IDUPD,LAST_RU_CHGDATE,BLOCK_DATE,BLOCK_TYPE,TYPE_PENSIONER)
  select s_pfupens.nextval, t.mfo, t.branch, t.rnk, t.nmk, t.okpo, t.adr, t.date_on, t.date_off, t.passp, t.ser, t.numdoc, t.pdate, t.organ, t.bday, t.bplace, t.cellphone, null, sysdate, null, t.idupd, sysdate, null, null, null from test_cust t 
   where t.mfo = l_kf4;
  
  delete from pfu_pensacc pa where pa.kf = l_kf4;
  insert into pfu_pensacc (id, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, dazs, state, sys_time, last_ru_idupd, last_ru_chgdate, transacc, transkv)
  select s_pfupensacc.nextval, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, null, null, sysdate, idupd, sysdate, null, null from test_acc t 
   where t.kf = l_kf4;
--  bars_audit.info('PFU_EXPORT end. Обработка реестра по МФО '||to_char(l_kf00)||' ('||RU_name||').');  
  update TMP_DOWNLOAD set date_end=(select sysdate from dual) where mfo=l_kf4;
  commit;
--------------------

--------------------
  select substr(name,5,100) into RU_name from pfu_syncru_params where kf=l_kf5;
  insert into TMP_DOWNLOAD (mfo, name) values( l_kf5, RU_name);
  commit; 
--  bars_audit.info('PFU_EXPORT start. Обработка реестра по МФО '||to_char(l_kf5)||' ('||RU_name||').');  
  delete from pfu_pensioner p where p.kf = l_kf5;
  insert into pfu_pensioner(ID,                KF,    BRANCH,    RNK,   NMK,   OKPO,   ADR,   DATE_ON,   DATE_OFF,    PASSP,  SER,    NUMDOC, PDATE,    ORGAN,   BDAY, BPLACE,   CELLPHONE, STATE,  SYS_TIME,COMM,LAST_RU_IDUPD,LAST_RU_CHGDATE,BLOCK_DATE,BLOCK_TYPE,TYPE_PENSIONER)
  select s_pfupens.nextval, t.mfo, t.branch, t.rnk, t.nmk, t.okpo, t.adr, t.date_on, t.date_off, t.passp, t.ser, t.numdoc, t.pdate, t.organ, t.bday, t.bplace, t.cellphone, null, sysdate, null, t.idupd, sysdate, null, null, null from test_cust t 
   where t.mfo = l_kf5;
  
  delete from pfu_pensacc pa where pa.kf = l_kf5;
  insert into pfu_pensacc (id, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, dazs, state, sys_time, last_ru_idupd, last_ru_chgdate, transacc, transkv)
  select s_pfupensacc.nextval, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, null, null, sysdate, idupd, sysdate, null, null from test_acc t 
   where t.kf = l_kf5;
--  bars_audit.info('PFU_EXPORT end. Обработка реестра по МФО '||to_char(l_kf00)||' ('||RU_name||').');  
  update TMP_DOWNLOAD set date_end=(select sysdate from dual) where mfo=l_kf5;
  commit;
--------------------


--------------------
  select substr(name,5,100) into RU_name from pfu_syncru_params where kf=l_kf6;
  insert into TMP_DOWNLOAD (mfo, name) values( l_kf6, RU_name);
  commit; 
--  bars_audit.info('PFU_EXPORT start. Обработка реестра по МФО '||to_char(l_kf6)||' ('||RU_name||').');  
  delete from pfu_pensioner p where p.kf = l_kf6;
  insert into pfu_pensioner(ID,                KF,    BRANCH,    RNK,   NMK,   OKPO,   ADR,   DATE_ON,   DATE_OFF,    PASSP,  SER,    NUMDOC, PDATE,    ORGAN,   BDAY, BPLACE,   CELLPHONE, STATE,  SYS_TIME,COMM,LAST_RU_IDUPD,LAST_RU_CHGDATE,BLOCK_DATE,BLOCK_TYPE,TYPE_PENSIONER)
  select s_pfupens.nextval, t.mfo, t.branch, t.rnk, t.nmk, t.okpo, t.adr, t.date_on, t.date_off, t.passp, t.ser, t.numdoc, t.pdate, t.organ, t.bday, t.bplace, t.cellphone, null, sysdate, null, t.idupd, sysdate, null, null, null from test_cust t 
   where t.mfo = l_kf6;
  
  delete from pfu_pensacc pa where pa.kf = l_kf6;
  insert into pfu_pensacc (id, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, dazs, state, sys_time, last_ru_idupd, last_ru_chgdate, transacc, transkv)
  select s_pfupensacc.nextval, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, null, null, sysdate, idupd, sysdate, null, null from test_acc t 
   where t.kf = l_kf6;
--  bars_audit.info('PFU_EXPORT end. Обработка реестра по МФО '||to_char(l_kf00)||' ('||RU_name||').');  
  update TMP_DOWNLOAD set date_end=(select sysdate from dual) where mfo=l_kf6;
  commit;
--------------------


--------------------
  select substr(name,5,100) into RU_name from pfu_syncru_params where kf=l_kf7;
  insert into TMP_DOWNLOAD (mfo, name) values( l_kf7, RU_name);
  commit; 
--  bars_audit.info('PFU_EXPORT start. Обработка реестра по МФО '||to_char(l_kf7)||' ('||RU_name||').');  
  delete from pfu_pensioner p where p.kf = l_kf7;
  insert into pfu_pensioner(ID,                KF,    BRANCH,    RNK,   NMK,   OKPO,   ADR,   DATE_ON,   DATE_OFF,    PASSP,  SER,    NUMDOC, PDATE,    ORGAN,   BDAY, BPLACE,   CELLPHONE, STATE,  SYS_TIME,COMM,LAST_RU_IDUPD,LAST_RU_CHGDATE,BLOCK_DATE,BLOCK_TYPE,TYPE_PENSIONER)
  select s_pfupens.nextval, t.mfo, t.branch, t.rnk, t.nmk, t.okpo, t.adr, t.date_on, t.date_off, t.passp, t.ser, t.numdoc, t.pdate, t.organ, t.bday, t.bplace, t.cellphone, null, sysdate, null, t.idupd, sysdate, null, null, null from test_cust t 
   where t.mfo = l_kf7;
  
  delete from pfu_pensacc pa where pa.kf = l_kf7;
  insert into pfu_pensacc (id, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, dazs, state, sys_time, last_ru_idupd, last_ru_chgdate, transacc, transkv)
  select s_pfupensacc.nextval, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, null, null, sysdate, idupd, sysdate, null, null from test_acc t 
   where t.kf = l_kf7;
--  bars_audit.info('PFU_EXPORT end. Обработка реестра по МФО '||to_char(l_kf00)||' ('||RU_name||').');  
  update TMP_DOWNLOAD set date_end=(select sysdate from dual) where mfo=l_kf7;
  commit;
--------------------

--------------------
  select substr(name,5,100) into RU_name from pfu_syncru_params where kf=l_kf8;
  insert into TMP_DOWNLOAD (mfo, name) values( l_kf8, RU_name);
  commit; 
--  bars_audit.info('PFU_EXPORT start. Обработка реестра по МФО '||to_char(l_kf8)||' ('||RU_name||').');  
  delete from pfu_pensioner p where p.kf = l_kf8;
  insert into pfu_pensioner(ID,                KF,    BRANCH,    RNK,   NMK,   OKPO,   ADR,   DATE_ON,   DATE_OFF,    PASSP,  SER,    NUMDOC, PDATE,    ORGAN,   BDAY, BPLACE,   CELLPHONE, STATE,  SYS_TIME,COMM,LAST_RU_IDUPD,LAST_RU_CHGDATE,BLOCK_DATE,BLOCK_TYPE,TYPE_PENSIONER)
  select s_pfupens.nextval, t.mfo, t.branch, t.rnk, t.nmk, t.okpo, t.adr, t.date_on, t.date_off, t.passp, t.ser, t.numdoc, t.pdate, t.organ, t.bday, t.bplace, t.cellphone, null, sysdate, null, t.idupd, sysdate, null, null, null from test_cust t 
   where t.mfo = l_kf8;
  
  delete from pfu_pensacc pa where pa.kf = l_kf8;
  insert into pfu_pensacc (id, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, dazs, state, sys_time, last_ru_idupd, last_ru_chgdate, transacc, transkv)
  select s_pfupensacc.nextval, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, null, null, sysdate, idupd, sysdate, null, null from test_acc t 
   where t.kf = l_kf8;
--  bars_audit.info('PFU_EXPORT end. Обработка реестра по МФО '||to_char(l_kf00)||' ('||RU_name||').');  
  update TMP_DOWNLOAD set date_end=(select sysdate from dual) where mfo=l_kf8;
  commit;
--------------------
*/
--------------------
  select substr(name,5,100) into RU_name from pfu_syncru_params where kf=l_kf10;
  insert into TMP_DOWNLOAD (mfo, name) values( l_kf10, RU_name);
  commit; 
--  bars_audit.info('PFU_EXPORT start. Обработка реестра по МФО '||to_char(l_kf10)||' ('||RU_name||').');  
  delete from pfu_pensioner p where p.kf = l_kf10;
  insert into pfu_pensioner(ID,                KF,    BRANCH,    RNK,   NMK,   OKPO,   ADR,   DATE_ON,   DATE_OFF,    PASSP,  SER,    NUMDOC, PDATE,    ORGAN,   BDAY, BPLACE,   CELLPHONE, STATE,  SYS_TIME,COMM,LAST_RU_IDUPD,LAST_RU_CHGDATE,BLOCK_DATE,BLOCK_TYPE,TYPE_PENSIONER)
  select s_pfupens.nextval, t.mfo, t.branch, t.rnk, t.nmk, t.okpo, t.adr, t.date_on, t.date_off, t.passp, t.ser, t.numdoc, t.pdate, t.organ, t.bday, t.bplace, t.cellphone, null, sysdate, null, t.idupd, sysdate, null, null, null from test_cust t 
   where t.mfo = l_kf10;
  
  delete from pfu_pensacc pa where pa.kf = l_kf10;
  insert into pfu_pensacc (id, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, dazs, state, sys_time, last_ru_idupd, last_ru_chgdate, transacc, transkv)
  select s_pfupensacc.nextval, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, null, null, sysdate, idupd, sysdate, null, null from test_acc t 
   where t.kf = l_kf10;
--  bars_audit.info('PFU_EXPORT end. Обработка реестра по МФО '||to_char(l_kf00)||' ('||RU_name||').');  
  update TMP_DOWNLOAD set date_end=(select sysdate from dual) where mfo=l_kf10;
  commit;
--------------------


--------------------
  select substr(name,5,100) into RU_name from pfu_syncru_params where kf=l_kf11;
  insert into TMP_DOWNLOAD (mfo, name) values( l_kf11, RU_name);
  commit; 
--  bars_audit.info('PFU_EXPORT start. Обработка реестра по МФО '||to_char(l_kf11)||' ('||RU_name||').');  
  delete from pfu_pensioner p where p.kf = l_kf11;
  insert into pfu_pensioner(ID,                KF,    BRANCH,    RNK,   NMK,   OKPO,   ADR,   DATE_ON,   DATE_OFF,    PASSP,  SER,    NUMDOC, PDATE,    ORGAN,   BDAY, BPLACE,   CELLPHONE, STATE,  SYS_TIME,COMM,LAST_RU_IDUPD,LAST_RU_CHGDATE,BLOCK_DATE,BLOCK_TYPE,TYPE_PENSIONER)
  select s_pfupens.nextval, t.mfo, t.branch, t.rnk, t.nmk, t.okpo, t.adr, t.date_on, t.date_off, t.passp, t.ser, t.numdoc, t.pdate, t.organ, t.bday, t.bplace, t.cellphone, null, sysdate, null, t.idupd, sysdate, null, null, null from test_cust t 
   where t.mfo = l_kf11;
  
  delete from pfu_pensacc pa where pa.kf = l_kf11;
  insert into pfu_pensacc (id, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, dazs, state, sys_time, last_ru_idupd, last_ru_chgdate, transacc, transkv)
  select s_pfupensacc.nextval, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, null, null, sysdate, idupd, sysdate, null, null from test_acc t 
   where t.kf = l_kf11;
--  bars_audit.info('PFU_EXPORT end. Обработка реестра по МФО '||to_char(l_kf00)||' ('||RU_name||').');  
  update TMP_DOWNLOAD set date_end=(select sysdate from dual) where mfo=l_kf11;
  commit;
--------------------

--------------------
  select substr(name,5,100) into RU_name from pfu_syncru_params where kf=l_kf12;
  insert into TMP_DOWNLOAD (mfo, name) values( l_kf12, RU_name);
  commit; 
--  bars_audit.info('PFU_EXPORT start. Обработка реестра по МФО '||to_char(l_kf12)||' ('||RU_name||').');  
  delete from pfu_pensioner p where p.kf = l_kf12;
  insert into pfu_pensioner(ID,                KF,    BRANCH,    RNK,   NMK,   OKPO,   ADR,   DATE_ON,   DATE_OFF,    PASSP,  SER,    NUMDOC, PDATE,    ORGAN,   BDAY, BPLACE,   CELLPHONE, STATE,  SYS_TIME,COMM,LAST_RU_IDUPD,LAST_RU_CHGDATE,BLOCK_DATE,BLOCK_TYPE,TYPE_PENSIONER)
  select s_pfupens.nextval, t.mfo, t.branch, t.rnk, t.nmk, t.okpo, t.adr, t.date_on, t.date_off, t.passp, t.ser, t.numdoc, t.pdate, t.organ, t.bday, t.bplace, t.cellphone, null, sysdate, null, t.idupd, sysdate, null, null, null from test_cust t 
   where t.mfo = l_kf12;
  
  delete from pfu_pensacc pa where pa.kf = l_kf12;
  insert into pfu_pensacc (id, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, dazs, state, sys_time, last_ru_idupd, last_ru_chgdate, transacc, transkv)
  select s_pfupensacc.nextval, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, null, null, sysdate, idupd, sysdate, null, null from test_acc t 
   where t.kf = l_kf12;
--  bars_audit.info('PFU_EXPORT end. Обработка реестра по МФО '||to_char(l_kf00)||' ('||RU_name||').');  
  update TMP_DOWNLOAD set date_end=(select sysdate from dual) where mfo=l_kf12;
  commit;
--------------------


--------------------
  select substr(name,5,100) into RU_name from pfu_syncru_params where kf=l_kf13;
  insert into TMP_DOWNLOAD (mfo, name) values( l_kf13, RU_name);
  commit; 
--  bars_audit.info('PFU_EXPORT start. Обработка реестра по МФО '||to_char(l_kf13)||' ('||RU_name||').');  
  delete from pfu_pensioner p where p.kf = l_kf13;
  insert into pfu_pensioner(ID,                KF,    BRANCH,    RNK,   NMK,   OKPO,   ADR,   DATE_ON,   DATE_OFF,    PASSP,  SER,    NUMDOC, PDATE,    ORGAN,   BDAY, BPLACE,   CELLPHONE, STATE,  SYS_TIME,COMM,LAST_RU_IDUPD,LAST_RU_CHGDATE,BLOCK_DATE,BLOCK_TYPE,TYPE_PENSIONER)
  select s_pfupens.nextval, t.mfo, t.branch, t.rnk, t.nmk, t.okpo, t.adr, t.date_on, t.date_off, t.passp, t.ser, t.numdoc, t.pdate, t.organ, t.bday, t.bplace, t.cellphone, null, sysdate, null, t.idupd, sysdate, null, null, null from test_cust t 
   where t.mfo = l_kf13;
  
  delete from pfu_pensacc pa where pa.kf = l_kf13;
  insert into pfu_pensacc (id, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, dazs, state, sys_time, last_ru_idupd, last_ru_chgdate, transacc, transkv)
  select s_pfupensacc.nextval, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, null, null, sysdate, idupd, sysdate, null, null from test_acc t 
   where t.kf = l_kf13;
--  bars_audit.info('PFU_EXPORT end. Обработка реестра по МФО '||to_char(l_kf00)||' ('||RU_name||').');  
  update TMP_DOWNLOAD set date_end=(select sysdate from dual) where mfo=l_kf13;
  commit;
--------------------



--------------------
  select substr(name,5,100) into RU_name from pfu_syncru_params where kf=l_kf14;
  insert into TMP_DOWNLOAD (mfo, name) values( l_kf14, RU_name);
  commit; 
--  bars_audit.info('PFU_EXPORT start. Обработка реестра по МФО '||to_char(l_kf14)||' ('||RU_name||').');  
  delete from pfu_pensioner p where p.kf = l_kf14;
  insert into pfu_pensioner(ID,                KF,    BRANCH,    RNK,   NMK,   OKPO,   ADR,   DATE_ON,   DATE_OFF,    PASSP,  SER,    NUMDOC, PDATE,    ORGAN,   BDAY, BPLACE,   CELLPHONE, STATE,  SYS_TIME,COMM,LAST_RU_IDUPD,LAST_RU_CHGDATE,BLOCK_DATE,BLOCK_TYPE,TYPE_PENSIONER)
  select s_pfupens.nextval, t.mfo, t.branch, t.rnk, t.nmk, t.okpo, t.adr, t.date_on, t.date_off, t.passp, t.ser, t.numdoc, t.pdate, t.organ, t.bday, t.bplace, t.cellphone, null, sysdate, null, t.idupd, sysdate, null, null, null from test_cust t 
   where t.mfo = l_kf14;
  
  delete from pfu_pensacc pa where pa.kf = l_kf14;
  insert into pfu_pensacc (id, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, dazs, state, sys_time, last_ru_idupd, last_ru_chgdate, transacc, transkv)
  select s_pfupensacc.nextval, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, null, null, sysdate, idupd, sysdate, null, null from test_acc t 
   where t.kf = l_kf14;
--  bars_audit.info('PFU_EXPORT end. Обработка реестра по МФО '||to_char(l_kf00)||' ('||RU_name||').');  
  update TMP_DOWNLOAD set date_end=(select sysdate from dual) where mfo=l_kf14;
  commit;
--------------------

--------------------
  select substr(name,5,100) into RU_name from pfu_syncru_params where kf=l_kf15;
  insert into TMP_DOWNLOAD (mfo, name) values( l_kf15, RU_name);
  commit; 
--  bars_audit.info('PFU_EXPORT start. Обработка реестра по МФО '||to_char(l_kf15)||' ('||RU_name||').');  
  delete from pfu_pensioner p where p.kf = l_kf15;
  insert into pfu_pensioner(ID,                KF,    BRANCH,    RNK,   NMK,   OKPO,   ADR,   DATE_ON,   DATE_OFF,    PASSP,  SER,    NUMDOC, PDATE,    ORGAN,   BDAY, BPLACE,   CELLPHONE, STATE,  SYS_TIME,COMM,LAST_RU_IDUPD,LAST_RU_CHGDATE,BLOCK_DATE,BLOCK_TYPE,TYPE_PENSIONER)
  select s_pfupens.nextval, t.mfo, t.branch, t.rnk, t.nmk, t.okpo, t.adr, t.date_on, t.date_off, t.passp, t.ser, t.numdoc, t.pdate, t.organ, t.bday, t.bplace, t.cellphone, null, sysdate, null, t.idupd, sysdate, null, null, null from test_cust t 
   where t.mfo = l_kf15;
  
  delete from pfu_pensacc pa where pa.kf = l_kf15;
  insert into pfu_pensacc (id, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, dazs, state, sys_time, last_ru_idupd, last_ru_chgdate, transacc, transkv)
  select s_pfupensacc.nextval, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, null, null, sysdate, idupd, sysdate, null, null from test_acc t 
   where t.kf = l_kf15;
--  bars_audit.info('PFU_EXPORT end. Обработка реестра по МФО '||to_char(l_kf00)||' ('||RU_name||').');  
  update TMP_DOWNLOAD set date_end=(select sysdate from dual) where mfo=l_kf15;
  commit;
--------------------

--------------------
  select substr(name,5,100) into RU_name from pfu_syncru_params where kf=l_kf16;
  insert into TMP_DOWNLOAD (mfo, name) values( l_kf16, RU_name);
  commit; 
--  bars_audit.info('PFU_EXPORT start. Обработка реестра по МФО '||to_char(l_kf16)||' ('||RU_name||').');  
  delete from pfu_pensioner p where p.kf = l_kf16;
  insert into pfu_pensioner(ID,                KF,    BRANCH,    RNK,   NMK,   OKPO,   ADR,   DATE_ON,   DATE_OFF,    PASSP,  SER,    NUMDOC, PDATE,    ORGAN,   BDAY, BPLACE,   CELLPHONE, STATE,  SYS_TIME,COMM,LAST_RU_IDUPD,LAST_RU_CHGDATE,BLOCK_DATE,BLOCK_TYPE,TYPE_PENSIONER)
  select s_pfupens.nextval, t.mfo, t.branch, t.rnk, t.nmk, t.okpo, t.adr, t.date_on, t.date_off, t.passp, t.ser, t.numdoc, t.pdate, t.organ, t.bday, t.bplace, t.cellphone, null, sysdate, null, t.idupd, sysdate, null, null, null from test_cust t 
   where t.mfo = l_kf16;
  
  delete from pfu_pensacc pa where pa.kf = l_kf16;
  insert into pfu_pensacc (id, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, dazs, state, sys_time, last_ru_idupd, last_ru_chgdate, transacc, transkv)
  select s_pfupensacc.nextval, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, null, null, sysdate, idupd, sysdate, null, null from test_acc t 
   where t.kf = l_kf16;
--  bars_audit.info('PFU_EXPORT end. Обработка реестра по МФО '||to_char(l_kf00)||' ('||RU_name||').');  
  update TMP_DOWNLOAD set date_end=(select sysdate from dual) where mfo=l_kf16;
  commit;
--------------------


--------------------
  select substr(name,5,100) into RU_name from pfu_syncru_params where kf=l_kf17;
  insert into TMP_DOWNLOAD (mfo, name) values( l_kf17, RU_name);
  commit; 
--  bars_audit.info('PFU_EXPORT start. Обработка реестра по МФО '||to_char(l_kf17)||' ('||RU_name||').');  
  delete from pfu_pensioner p where p.kf = l_kf17;
  insert into pfu_pensioner(ID,                KF,    BRANCH,    RNK,   NMK,   OKPO,   ADR,   DATE_ON,   DATE_OFF,    PASSP,  SER,    NUMDOC, PDATE,    ORGAN,   BDAY, BPLACE,   CELLPHONE, STATE,  SYS_TIME,COMM,LAST_RU_IDUPD,LAST_RU_CHGDATE,BLOCK_DATE,BLOCK_TYPE,TYPE_PENSIONER)
  select s_pfupens.nextval, t.mfo, t.branch, t.rnk, t.nmk, t.okpo, t.adr, t.date_on, t.date_off, t.passp, t.ser, t.numdoc, t.pdate, t.organ, t.bday, t.bplace, t.cellphone, null, sysdate, null, t.idupd, sysdate, null, null, null from test_cust t 
   where t.mfo = l_kf17;
  
  delete from pfu_pensacc pa where pa.kf = l_kf17;
  insert into pfu_pensacc (id, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, dazs, state, sys_time, last_ru_idupd, last_ru_chgdate, transacc, transkv)
  select s_pfupensacc.nextval, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, null, null, sysdate, idupd, sysdate, null, null from test_acc t 
   where t.kf = l_kf17;
--  bars_audit.info('PFU_EXPORT end. Обработка реестра по МФО '||to_char(l_kf00)||' ('||RU_name||').');  
  update TMP_DOWNLOAD set date_end=(select sysdate from dual) where mfo=l_kf17;
  commit;
--------------------

--------------------
  select substr(name,5,100) into RU_name from pfu_syncru_params where kf=l_kf18;
  insert into TMP_DOWNLOAD (mfo, name) values( l_kf18, RU_name);
  commit; 
--  bars_audit.info('PFU_EXPORT start. Обработка реестра по МФО '||to_char(l_kf18)||' ('||RU_name||').');  
  delete from pfu_pensioner p where p.kf = l_kf18;
  insert into pfu_pensioner(ID,                KF,    BRANCH,    RNK,   NMK,   OKPO,   ADR,   DATE_ON,   DATE_OFF,    PASSP,  SER,    NUMDOC, PDATE,    ORGAN,   BDAY, BPLACE,   CELLPHONE, STATE,  SYS_TIME,COMM,LAST_RU_IDUPD,LAST_RU_CHGDATE,BLOCK_DATE,BLOCK_TYPE,TYPE_PENSIONER)
  select s_pfupens.nextval, t.mfo, t.branch, t.rnk, t.nmk, t.okpo, t.adr, t.date_on, t.date_off, t.passp, t.ser, t.numdoc, t.pdate, t.organ, t.bday, t.bplace, t.cellphone, null, sysdate, null, t.idupd, sysdate, null, null, null from test_cust t 
   where t.mfo = l_kf18;
  
  delete from pfu_pensacc pa where pa.kf = l_kf18;
  insert into pfu_pensacc (id, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, dazs, state, sys_time, last_ru_idupd, last_ru_chgdate, transacc, transkv)
  select s_pfupensacc.nextval, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, null, null, sysdate, idupd, sysdate, null, null from test_acc t 
   where t.kf = l_kf18;
--  bars_audit.info('PFU_EXPORT end. Обработка реестра по МФО '||to_char(l_kf00)||' ('||RU_name||').');  
  update TMP_DOWNLOAD set date_end=(select sysdate from dual) where mfo=l_kf18;
  commit;
--------------------

--------------------
  select substr(name,5,100) into RU_name from pfu_syncru_params where kf=l_kf19;
  insert into TMP_DOWNLOAD (mfo, name) values( l_kf19, RU_name);
  commit; 
--  bars_audit.info('PFU_EXPORT start. Обработка реестра по МФО '||to_char(l_kf19)||' ('||RU_name||').');  
  delete from pfu_pensioner p where p.kf = l_kf19;
  insert into pfu_pensioner(ID,                KF,    BRANCH,    RNK,   NMK,   OKPO,   ADR,   DATE_ON,   DATE_OFF,    PASSP,  SER,    NUMDOC, PDATE,    ORGAN,   BDAY, BPLACE,   CELLPHONE, STATE,  SYS_TIME,COMM,LAST_RU_IDUPD,LAST_RU_CHGDATE,BLOCK_DATE,BLOCK_TYPE,TYPE_PENSIONER)
  select s_pfupens.nextval, t.mfo, t.branch, t.rnk, t.nmk, t.okpo, t.adr, t.date_on, t.date_off, t.passp, t.ser, t.numdoc, t.pdate, t.organ, t.bday, t.bplace, t.cellphone, null, sysdate, null, t.idupd, sysdate, null, null, null from test_cust t 
   where t.mfo = l_kf19;
  
  delete from pfu_pensacc pa where pa.kf = l_kf19;
  insert into pfu_pensacc (id, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, dazs, state, sys_time, last_ru_idupd, last_ru_chgdate, transacc, transkv)
  select s_pfupensacc.nextval, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, null, null, sysdate, idupd, sysdate, null, null from test_acc t 
   where t.kf = l_kf19;
--  bars_audit.info('PFU_EXPORT end. Обработка реестра по МФО '||to_char(l_kf00)||' ('||RU_name||').');  
  update TMP_DOWNLOAD set date_end=(select sysdate from dual) where mfo=l_kf19;
  commit;
--------------------

--------------------
  select substr(name,5,100) into RU_name from pfu_syncru_params where kf=l_kf20;
  insert into TMP_DOWNLOAD (mfo, name) values( l_kf20, RU_name);
  commit; 
--  bars_audit.info('PFU_EXPORT start. Обработка реестра по МФО '||to_char(l_kf20)||' ('||RU_name||').');  
  delete from pfu_pensioner p where p.kf = l_kf20;
  insert into pfu_pensioner(ID,                KF,    BRANCH,    RNK,   NMK,   OKPO,   ADR,   DATE_ON,   DATE_OFF,    PASSP,  SER,    NUMDOC, PDATE,    ORGAN,   BDAY, BPLACE,   CELLPHONE, STATE,  SYS_TIME,COMM,LAST_RU_IDUPD,LAST_RU_CHGDATE,BLOCK_DATE,BLOCK_TYPE,TYPE_PENSIONER)
  select s_pfupens.nextval, t.mfo, t.branch, t.rnk, t.nmk, t.okpo, t.adr, t.date_on, t.date_off, t.passp, t.ser, t.numdoc, t.pdate, t.organ, t.bday, t.bplace, t.cellphone, null, sysdate, null, t.idupd, sysdate, null, null, null from test_cust t 
   where t.mfo = l_kf20;
  
  delete from pfu_pensacc pa where pa.kf = l_kf20;
  insert into pfu_pensacc (id, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, dazs, state, sys_time, last_ru_idupd, last_ru_chgdate, transacc, transkv)
  select s_pfupensacc.nextval, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, null, null, sysdate, idupd, sysdate, null, null from test_acc t 
   where t.kf = l_kf20;
--  bars_audit.info('PFU_EXPORT end. Обработка реестра по МФО '||to_char(l_kf00)||' ('||RU_name||').');  
  update TMP_DOWNLOAD set date_end=(select sysdate from dual) where mfo=l_kf20;
  commit;
--------------------



--------------------
  select substr(name,5,100) into RU_name from pfu_syncru_params where kf=l_kf21;
  insert into TMP_DOWNLOAD (mfo, name) values( l_kf21, RU_name);
  commit; 
--  bars_audit.info('PFU_EXPORT start. Обработка реестра по МФО '||to_char(l_kf21)||' ('||RU_name||').');  
  delete from pfu_pensioner p where p.kf = l_kf21;
  insert into pfu_pensioner(ID,                KF,    BRANCH,    RNK,   NMK,   OKPO,   ADR,   DATE_ON,   DATE_OFF,    PASSP,  SER,    NUMDOC, PDATE,    ORGAN,   BDAY, BPLACE,   CELLPHONE, STATE,  SYS_TIME,COMM,LAST_RU_IDUPD,LAST_RU_CHGDATE,BLOCK_DATE,BLOCK_TYPE,TYPE_PENSIONER)
  select s_pfupens.nextval, t.mfo, t.branch, t.rnk, t.nmk, t.okpo, t.adr, t.date_on, t.date_off, t.passp, t.ser, t.numdoc, t.pdate, t.organ, t.bday, t.bplace, t.cellphone, null, sysdate, null, t.idupd, sysdate, null, null, null from test_cust t 
   where t.mfo = l_kf21;
  
  delete from pfu_pensacc pa where pa.kf = l_kf21;
  insert into pfu_pensacc (id, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, dazs, state, sys_time, last_ru_idupd, last_ru_chgdate, transacc, transkv)
  select s_pfupensacc.nextval, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, null, null, sysdate, idupd, sysdate, null, null from test_acc t 
   where t.kf = l_kf21;
--  bars_audit.info('PFU_EXPORT end. Обработка реестра по МФО '||to_char(l_kf00)||' ('||RU_name||').');  
  update TMP_DOWNLOAD set date_end=(select sysdate from dual) where mfo=l_kf21;
  commit;
--------------------

--------------------
  select substr(name,5,100) into RU_name from pfu_syncru_params where kf=l_kf22;
  insert into TMP_DOWNLOAD (mfo, name) values( l_kf22, RU_name);
  commit; 
--  bars_audit.info('PFU_EXPORT start. Обработка реестра по МФО '||to_char(l_kf22)||' ('||RU_name||').');  
  delete from pfu_pensioner p where p.kf = l_kf22;
  insert into pfu_pensioner(ID,                KF,    BRANCH,    RNK,   NMK,   OKPO,   ADR,   DATE_ON,   DATE_OFF,    PASSP,  SER,    NUMDOC, PDATE,    ORGAN,   BDAY, BPLACE,   CELLPHONE, STATE,  SYS_TIME,COMM,LAST_RU_IDUPD,LAST_RU_CHGDATE,BLOCK_DATE,BLOCK_TYPE,TYPE_PENSIONER)
  select s_pfupens.nextval, t.mfo, t.branch, t.rnk, t.nmk, t.okpo, t.adr, t.date_on, t.date_off, t.passp, t.ser, t.numdoc, t.pdate, t.organ, t.bday, t.bplace, t.cellphone, null, sysdate, null, t.idupd, sysdate, null, null, null from test_cust t 
   where t.mfo = l_kf22;
  
  delete from pfu_pensacc pa where pa.kf = l_kf22;
  insert into pfu_pensacc (id, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, dazs, state, sys_time, last_ru_idupd, last_ru_chgdate, transacc, transkv)
  select s_pfupensacc.nextval, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, null, null, sysdate, idupd, sysdate, null, null from test_acc t 
   where t.kf = l_kf22;
--  bars_audit.info('PFU_EXPORT end. Обработка реестра по МФО '||to_char(l_kf00)||' ('||RU_name||').');  
  update TMP_DOWNLOAD set date_end=(select sysdate from dual) where mfo=l_kf22;
  commit;
--------------------


--------------------
  select substr(name,5,100) into RU_name from pfu_syncru_params where kf=l_kf23;
  insert into TMP_DOWNLOAD (mfo, name) values( l_kf23, RU_name);
  commit; 
--  bars_audit.info('PFU_EXPORT start. Обработка реестра по МФО '||to_char(l_kf23)||' ('||RU_name||').');  
  delete from pfu_pensioner p where p.kf = l_kf23;
  insert into pfu_pensioner(ID,                KF,    BRANCH,    RNK,   NMK,   OKPO,   ADR,   DATE_ON,   DATE_OFF,    PASSP,  SER,    NUMDOC, PDATE,    ORGAN,   BDAY, BPLACE,   CELLPHONE, STATE,  SYS_TIME,COMM,LAST_RU_IDUPD,LAST_RU_CHGDATE,BLOCK_DATE,BLOCK_TYPE,TYPE_PENSIONER)
  select s_pfupens.nextval, t.mfo, t.branch, t.rnk, t.nmk, t.okpo, t.adr, t.date_on, t.date_off, t.passp, t.ser, t.numdoc, t.pdate, t.organ, t.bday, t.bplace, t.cellphone, null, sysdate, null, t.idupd, sysdate, null, null, null from test_cust t 
   where t.mfo = l_kf23;
  
  delete from pfu_pensacc pa where pa.kf = l_kf23;
  insert into pfu_pensacc (id, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, dazs, state, sys_time, last_ru_idupd, last_ru_chgdate, transacc, transkv)
  select s_pfupensacc.nextval, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, null, null, sysdate, idupd, sysdate, null, null from test_acc t 
   where t.kf = l_kf23;
--  bars_audit.info('PFU_EXPORT end. Обработка реестра по МФО '||to_char(l_kf00)||' ('||RU_name||').');  
  update TMP_DOWNLOAD set date_end=(select sysdate from dual) where mfo=l_kf23;
  commit;
--------------------

--------------------
  select substr(name,5,100) into RU_name from pfu_syncru_params where kf=l_kf24;
  insert into TMP_DOWNLOAD (mfo, name) values( l_kf24, RU_name);
  commit; 
--  bars_audit.info('PFU_EXPORT start. Обработка реестра по МФО '||to_char(l_kf24)||' ('||RU_name||').');  
  delete from pfu_pensioner p where p.kf = l_kf24;
  insert into pfu_pensioner(ID,                KF,    BRANCH,    RNK,   NMK,   OKPO,   ADR,   DATE_ON,   DATE_OFF,    PASSP,  SER,    NUMDOC, PDATE,    ORGAN,   BDAY, BPLACE,   CELLPHONE, STATE,  SYS_TIME,COMM,LAST_RU_IDUPD,LAST_RU_CHGDATE,BLOCK_DATE,BLOCK_TYPE,TYPE_PENSIONER)
  select s_pfupens.nextval, t.mfo, t.branch, t.rnk, t.nmk, t.okpo, t.adr, t.date_on, t.date_off, t.passp, t.ser, t.numdoc, t.pdate, t.organ, t.bday, t.bplace, t.cellphone, null, sysdate, null, t.idupd, sysdate, null, null, null from test_cust t 
   where t.mfo = l_kf24;
  
  delete from pfu_pensacc pa where pa.kf = l_kf24;
  insert into pfu_pensacc (id, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, dazs, state, sys_time, last_ru_idupd, last_ru_chgdate, transacc, transkv)
  select s_pfupensacc.nextval, kf, branch, rnk, acc, nls, kv, ob22, daos, dapp, null, null, sysdate, idupd, sysdate, null, null from test_acc t 
   where t.kf = l_kf24;
--  bars_audit.info('PFU_EXPORT end. Обработка реестра по МФО '||to_char(l_kf00)||' ('||RU_name||').');  
  update TMP_DOWNLOAD set date_end=(select sysdate from dual) where mfo=l_kf24;
  commit;
--------------------



/*
 execute immediate 'truncate table test_cust';
 execute immediate 'truncate table test_acc';
 commit;
 */
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Procedure/DOWNLOAD.sql =========*** End *** =
PROMPT ===================================================================================== 
