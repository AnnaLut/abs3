

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/BACKOFFICEUSERS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure BACKOFFICEUSERS ***

  CREATE OR REPLACE PROCEDURE BARS.BACKOFFICEUSERS 
is
BEGIN
  
--==============================================================================--
-- ********** 157 - Калина Інна Анатоліївна ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/02/2016','DD/MM/YYYY'), 
                          adate2=to_date('31/12/2016','DD/MM/YYYY'),
                          grantor=110
 where id=157 and codeapp in ('@PPZ','@OST','BIRG','VALB','DPTU','KODZ','DRU1',
                              'OTCN','KART','VIZA','NACC','@PN2','OPER','KONO',
                              'RKO ','@PKK','KRPF');
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (157, '@NR ', trunc(sysdate), EndOfYear, 0, 110);
   exception when OTHERS then NULL;  
 end;
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (157, 'WDOC', trunc(sysdate), EndOfYear, 0, 110);
   exception when OTHERS then NULL;  
 end;
 update STAFF_TTS set adate1=to_date('01/02/2016','DD/MM/YYYY'), 
                      adate2=to_date('31/12/2016','DD/MM/YYYY'),
                      grantor=110
  where id=157 and TT in ('001','002','010','012','013','014','015','01A','096',
                          '100','101','114','310','445','514','8C2','BR1','BR2',
                          'BR3','BR4','BRK','BRP','C10','CVO','D06','D07','D66',
                          'MM2','PKR','SMO');
 update STAFF_TTS set revoked=1, 
                      grantor=110
  where id=157 and TT in ('00A','00B','00C','00D','00E','00F','00G','00H','027',
                          '03C','066','067','069','072','073','074','075','085',
                          '178','405','406','BM6','BM7');
 update GROUPS_STAFF set adate1=to_date('01/02/2016','DD/MM/YYYY'), 
                         adate2=to_date('31/12/2016','DD/MM/YYYY'), 
                         secg=7,
                         grantor=110
 where idu=157 and IDG in (4);
 update STAFF_CHK set adate1=to_date('01/02/2016','DD/MM/YYYY'), 
                      adate2=to_date('31/12/2016','DD/MM/YYYY'),
                      grantor=110
 where id=157 and CHKID in (5);
 update STAFF_KLF00 
    set adate1=to_date('01/02/2016','DD/MM/YYYY'), 
        adate2=to_date('31/12/2016','DD/MM/YYYY'),
        grantor=110
 where id=157 and KODF in ('D3','E2');
 commit;
--==============================================================================--
-- ********** 66 - Половинко Ірина Олександрівна ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/02/2016','DD/MM/YYYY'), 
                          adate2=to_date('31/12/2016','DD/MM/YYYY'),
                          grantor=110
 where id=66 and codeapp in ('@PPZ','@OST','DPUA','ANKL','ANI1','AUSP','BIRG','W_W4',
                             'AVVV','VALB','@NR ','VNOT','DPTU','DRU1','SEPN','OTCN',
                             'DPAZ','KART','@ILI','KONS','VIZA','CRPC','NACC','@GU1',
                             'KLPA','OVER','OPER','KONO','RKO ','KAZN','@M11','@EGU',
                             'WRCA','@PKK','KRPF');
 update APPLIST_STAFF set revoked=1,
                          grantor=110
 where id=66 and codeapp in ('KREF');
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (66, 'KODZ', trunc(sysdate), EndOfYear, 0, 110);
   exception when OTHERS then NULL;  
 end;
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (66, 'WDOC', trunc(sysdate), EndOfYear, 0, 110);
   exception when OTHERS then NULL;  
 end;
 update STAFF_TTS set adate1=to_date('01/02/2016','DD/MM/YYYY'), 
                      adate2=to_date('31/12/2016','DD/MM/YYYY'),
                      grantor=1
 where id=66 and TT in ('001','002','010','012','013','014','015','01A','096','100',
                        '101','114','310','445','514','8C2','BM6','BM7','BR1','BR2',
                        'BR3','BR4','BRK','BRP','C10','CV0','CV3','CV7','CV8','CV9',
                        'CVO','D06','D07','D66','MM2','PKR','SMO','SNO');
 update STAFF_TTS set revoked=1, 
                      grantor=110
  where id=157 and TT in ('00A','00B','00C','00D','00E','00F','00G','00H',
                          '03C','066','067','069','072','073','074','075','085',
                          '178','405','406');
 update GROUPS_STAFF set adate1=to_date('01/02/2016','DD/MM/YYYY'), 
                         adate2=to_date('31/12/2016','DD/MM/YYYY'), 
                         secg=7,
                         grantor=110
 where idu=66 and IDG in (4);
 update STAFF_CHK set adate1=to_date('01/02/2016','DD/MM/YYYY'), 
                      adate2=to_date('31/12/2016','DD/MM/YYYY'),
                      grantor=110
 where id=66 and CHKID in (2,3,5,11,17,20,22,35,62,70);
 update STAFF_KLF00 set adate1=to_date('01/02/2016','DD/MM/YYYY'), 
                        adate2=to_date('31/12/2016','DD/MM/YYYY'),
                        grantor=110
 where id=66 and KODF in ('27','2E','C9','D3','E2','E8');
 update STAFF_KLF00 set revoked=1, 
                        grantor=110
 where id=66 and KODF in ('1A');
 commit;
--==============================================================================--
-- ********** 377 - Тараненко Світлана Віталіївна ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/02/2016','DD/MM/YYYY'), 
                          adate2=to_date('31/12/2016','DD/MM/YYYY'),
                          grantor=110
 where id=377 and codeapp in ('@PPZ','@OST','BIRG','VALB','DPTU','KODZ','OTCN',
                              'KRET','KART','VIZA','NACC','@PN2','OPER','PRAH',
                              'KONO','RKO ','@PKK','KRPF');
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (377, '@NR ', trunc(sysdate), EndOfYear, 0, 110);
   exception when OTHERS then NULL;  
 end;
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (377, 'W_W4', trunc(sysdate), EndOfYear, 0, 110);
   exception when OTHERS then NULL;  
 end;
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (377, 'DPAZ', trunc(sysdate), EndOfYear, 0, 110);
   exception when OTHERS then NULL;  
 end;
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (377, '@EGU', trunc(sysdate), EndOfYear, 0, 110);
   exception when OTHERS then NULL;  
 end;
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (377, 'WRCA', trunc(sysdate), EndOfYear, 0, 110);
   exception when OTHERS then NULL;  
 end;
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (377, 'CRPC', trunc(sysdate), EndOfYear, 0, 110);
   exception when OTHERS then NULL;  
 end;
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (377, 'DPUA', trunc(sysdate), EndOfYear, 0, 110);
   exception when OTHERS then NULL;  
 end;
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (377, 'ANKL', trunc(sysdate), EndOfYear, 0, 110);
   exception when OTHERS then NULL;  
 end;
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (377, 'ANI1', trunc(sysdate), EndOfYear, 0, 110);
   exception when OTHERS then NULL;  
 end;
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (377, 'AUSP', trunc(sysdate), EndOfYear, 0, 110);
   exception when OTHERS then NULL;  
 end;
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (377, 'WDOC', trunc(sysdate), EndOfYear, 0, 110);
   exception when OTHERS then NULL;  
 end;
 update STAFF_TTS set adate1=to_date('01/02/2016','DD/MM/YYYY'), 
                      adate2=to_date('31/12/2016','DD/MM/YYYY'),
                      grantor=110
 where id=377 and TT in ('001','002','010','012','013','014','015','01A','096',
                         '100','101','114','310','445','514','8C2','BM6','BR1',
                         'BR2','BR3','BR4','BRK','BRP','CVO','D06','D07','D66',
                         'MM2','PKD','PKR','SMO');
 update STAFF_TTS set revoked=1, 
                      grantor=110
  where id=157 and TT in ('00A','00B','00C','00D','00E','00F','00G','00H','027',
                          '03C','066','067','069','072','073','074','075','085',
                          '178','405','BM7');
 update GROUPS_STAFF set adate1=to_date('01/02/2016','DD/MM/YYYY'), 
                         adate2=to_date('31/12/2016','DD/MM/YYYY'), 
                         secg=7,
                         grantor=110
 where idu=377 and IDG in (4);
 update STAFF_CHK set adate1=to_date('01/02/2016','DD/MM/YYYY'), 
                      adate2=to_date('31/12/2016','DD/MM/YYYY'),
                      grantor=110
 where id=377 and CHKID in (5);
 update STAFF_KLF00 set adate1=to_date('01/02/2016','DD/MM/YYYY'), 
                        adate2=to_date('31/12/2016','DD/MM/YYYY'),
                        grantor=110
 where id=377 and KODF in ('27','C9','D3','E2');
 commit;
--==============================================================================--
-- ********** 78 - Юрковська Ольга Володимирівна ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/02/2016','DD/MM/YYYY'), 
                      adate2=to_date('31/12/2016','DD/MM/YYYY'),
                      grantor=110
 where id=78 and codeapp in ('KREA','BIRG','W_W4','VALB','AVTO','VNOT','DPTU','OTCN',
                             'DPAZ','KREB','KART','@OBU','VIZA','CRPC','NACC','@GU1',
                             '@PN2','OPER','WDOC','RKO ','@EGU','WRCA','@PKK','KRPF');
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (78, '@PPZ', trunc(sysdate), EndOfYear, 0, 110);
   exception when OTHERS then NULL;  
 end;
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (78, 'DPUA', trunc(sysdate), EndOfYear, 0, 110);
   exception when OTHERS then NULL;  
 end;
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (78, 'ANKL', trunc(sysdate), EndOfYear, 0, 110);
   exception when OTHERS then NULL;  
 end;
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (78, 'ANI1', trunc(sysdate), EndOfYear, 0, 110);
   exception when OTHERS then NULL;  
 end;
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (78, 'AUSP', trunc(sysdate), EndOfYear, 0, 110);
   exception when OTHERS then NULL;  
 end;
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (78, 'AVVV', trunc(sysdate), EndOfYear, 0, 110);
   exception when OTHERS then NULL;  
 end;
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (78, 'SEPN', trunc(sysdate), EndOfYear, 0, 110);
   exception when OTHERS then NULL;  
 end;
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (78, 'OVER', trunc(sysdate), EndOfYear, 0, 110);
   exception when OTHERS then NULL;  
 end;
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (78, 'KONS', trunc(sysdate), EndOfYear, 0, 110);
   exception when OTHERS then NULL;  
 end;
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (78, 'KONO', trunc(sysdate), EndOfYear, 0, 110);
   exception when OTHERS then NULL;  
 end;
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (78, '@M11', trunc(sysdate), EndOfYear, 0, 110);
   exception when OTHERS then NULL;  
 end;
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (78, '@NR ', trunc(sysdate), EndOfYear, 0, 110);
   exception when OTHERS then NULL;  
 end;
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (78, 'KODZ', trunc(sysdate), EndOfYear, 0, 110);
   exception when OTHERS then NULL;  
 end;
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (78, 'DPUA', trunc(sysdate), EndOfYear, 0, 110);
   exception when OTHERS then NULL;  
 end;
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (78, 'DPUA', trunc(sysdate), EndOfYear, 0, 110);
   exception when OTHERS then NULL;  
 end;
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (78, 'DPUA', trunc(sysdate), EndOfYear, 0, 110);
   exception when OTHERS then NULL;  
 end;
 update STAFF_TTS set adate1=to_date('01/02/2016','DD/MM/YYYY'), 
                      adate2=to_date('31/12/2016','DD/MM/YYYY'),
                      grantor=110
 where id=78 and TT in ('001','002','012','013','014','015','01A','096','100','101',
                        '114','310','8C2','BR1','BR2','BR3','BR4','BRK','BRP','C00',
                        'C10','CV0','CV3','CV7','CV8','CV9','CVB','CVO','CVS','D06',
                        'D07','D66','MM2','PKD','PKR','SMO');
 begin
   insert into STAFF_TTS (id, tt, adate1, adate2, approve, grantor)
     values (78, '010', trunc(sysdate), EndOfYear, 0, 110);
 end;
 update STAFF_TTS set revoked=1, 
                      grantor=110
 where id=78 and TT in ('008','00A','00B','00C','00D','00E','00F','00G','00H','027',
                        '07A','178','404','405','406','409','DUM');
 update GROUPS_STAFF set adate1=to_date('01/02/2016','DD/MM/YYYY'), 
                         adate2=to_date('31/12/2016','DD/MM/YYYY'),
                         secg=7,
                         grantor=110
 where idu=78 and IDG in (4);
 update STAFF_CHK set adate1=to_date('01/02/2016','DD/MM/YYYY'), 
                      adate2=to_date('31/12/2016','DD/MM/YYYY'),
                      grantor=110
 where id=78 and CHKID in (2,3,5,11,17,22);
 update STAFF_KLF00 set adate1=to_date('01/02/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=78 and KODF in ('27','','C9','D1','D3','E2','E8');
 update STAFF_KLF00 set revoked=1, 
                        grantor=110
 where id=78 and KODF in ('2E');
 commit;
--==============================================================================
 
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/BACKOFFICEUSERS.sql =========*** E
PROMPT ===================================================================================== 
