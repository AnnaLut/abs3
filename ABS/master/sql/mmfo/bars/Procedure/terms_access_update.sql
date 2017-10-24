

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/TERMS_ACCESS_UPDATE.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  procedure TERMS_ACCESS_UPDATE ***

  CREATE OR REPLACE PROCEDURE BARS.TERMS_ACCESS_UPDATE 
--+===========================================================+
--|                                                           |
--| ***   ��������� ����� ������ ������� � �������� ���   *** |
--|                  01/01/2016 - 31/12/2016                  |
--|                                                           |
--+===========================================================+
is
BEGIN
 
--==============================================================================--
-- ********** 626 - ���������� ǳ���� �������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=626 and codeapp in ('MANY');
-- update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
-- where idu=497 and IDG in (4,31);
 commit;
--==============================================================================--
-- ********** 497 - ����� ����� ���������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=497 and codeapp in ('@PTZ','VALB');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=497 and IDG in (4,31);
 commit;
--==============================================================================--
-- ********** 493 - �������� ���������� �������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=493 and codeapp in ('@INP');
 commit;
--==============================================================================--
-- ********** 318 - ������� ����� ������������ ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=BeginOfYear, adate2=EndOfYear
 where id=318 and codeapp in ('@EGF','@EGG','@IPV','BPKZ','BUHG','BVB ','DRU1','OPER','OWAY','STO1','VIZA');
 update STAFF_TTS set adate1=BeginOfYear, adate2=EndOfYear
 where id=318 and TT in ('013','015','029','060','096','108','109','110','111','420','438','444','805',
                         '806','D07','D66','PKA','PKO','PKR','PKS','PKV','PKX');
 update GROUPS_STAFF set adate1=BeginOfYear, adate2=EndOfYear, secg=7
 where idu=318 and IDG in (172,200);
 update STAFF_CHK set adate1=BeginOfYear, adate2=EndOfYear
 where id=457 and CHKID in (2,5,11);
 commit;
--==============================================================================--
-- ********** 457 - ���� ������ ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=457 and codeapp in ('VNOT','DRU1','OPER','NALS','NALY','@INP');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=457 and TT in ('015','096','825','PO1');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=457 and IDG in (171);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=457 and CHKID in (5,34);
 commit;
--==============================================================================--
-- ********** 108 - ���� ������� ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=108 and codeapp in ('@PPZ','@UDG','@PLD','VNOT','@CP1','OTCN','CRPC','CHIF','TEHA','@ECH');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=108 and IDG in (32);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=108 and KODF in ('01','02','08','11','25','30','3A','42','4A','78','81','8B','A4','A7','C5','D2','F4');
 commit;
--==============================================================================--
-- ********** 509 - ��� ����� ���������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=509 and codeapp in ('@UDG','DRU1');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=509 and IDG in (14);
 commit;
--==============================================================================--
-- ********** 483 - ����� ������� ���������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=483 and codeapp in ('ACBO','WCIG','DPTA','BVBB','AVTO','VIZA','NACC','WREQ','PRVN');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=483 and IDG in (16,20);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=483 and CHKID in (2,23);
--==============================================================================--
-- ********** 81 - ��������� ���� �������  ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=81 and codeapp in ('WCIG','KREA','AUSP','DRU1','OTCN','KREF','KREW','OVER','DROB');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=81 and IDG in (33);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=81 and KODF in ('D5','D8','D9','F6','F7','F8');
 commit;
--==============================================================================--
-- ********** 577 - �������� ����� ������������� ********** --
--==============================================================================--
-- KREW - ��� ���������� i���������
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=577 and codeapp in ('KREW');
--==============================================================================--
-- ********** 539 - �������� ������ ������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=539 and codeapp in ('WCIG','PENS','OWAY','W_W4','BPKB','BPKZ','VNOT','OTCN','KREV','@ILI','KRED',
                              'KRIF','KLPA','OVER','@PN2','OPER','WDOC','WGRT','WINS','@EGF','@PKK','FIN2','MANY');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=539 and TT in ('007','012','013','014','015','114','210','215','301','310','496','497','514',
                         'CVO','D06','D07','MUU','PKD','PKE','PKF','PKG');
--==============================================================================--
-- ********** 201 - ��������� ������  ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=201 and codeapp in ('BIRD','DRU1','SWAP','@UPR','KAZN');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=201 and IDG in (19);
 commit;
--==============================================================================--
-- ********** 118 - �������� ������ ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=118 and codeapp in ('OWAY','BPKZ','BVB ','BUHG','DRU1','OPER','@EGG','@EGF','STO1','@IPV','@PKK');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=118 and TT in ('013','015','029','060','096','108','109','110','111','420','438','444','805','806',
                         '807','830','D07','D66','PKA','PKO','PKR','PKS','PKV','PKX');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=118 and IDG in (172,200);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=118 and CHKID in (5,11);
 commit;
--==============================================================================--
-- ********** 532 - ����� ����� ����������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=532 and codeapp in ('OWAY','VIZA','@PKK','ZAP ');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=532 and TT in ('310','315','514');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=532 and IDG in (52);
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=532 and IDG in (4,16,20);
 commit;
--==============================================================================--
-- ********** 127 - ����� ������ �������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=127 and codeapp in ('ANI1');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=127 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 244 - ������ ��������� �'����������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=244 and codeapp in ('VIZA');
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=244 and CHKID in (42);
 commit;
--==============================================================================--
-- ********** 606 - ��������� ������ �����볿��� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=606 and codeapp in ('OWAY','DPTA','ANKL','ANI1','@PKP','VNOT','AUDI','DRU1','OTCN','CRPC','KRE3',
                              'KRIF','KREW','PRAH','REGK','FIN2','MANY');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=606 and IDG in (14);
 commit;
--==============================================================================--
-- ********** 398 - �������� ����� �������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=398 and codeapp in ('REGK','FMON');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=398 and IDG in (38);
 commit;
--==============================================================================--
-- ********** 116 - ������ ����� ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=116 and codeapp in ('@PPZ','@UDG','@PLD','VNOT','@CP1','OTCN','CRPC','CHIF','TEHA','@ECH');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=116 and IDG in (32);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=116 and KODF in ('01','02','08','11','25','30','3A','42','4A','78','81','8B','A4','A7','C5','D2','F4');
 commit;
--==============================================================================--
-- ********** 255 - ��������  ����� ������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=255 and codeapp in ('BIRV','BIRZ','VALB','WCIM','@PUP','OTCN','VIZA');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=255 and IDG in (4,31);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=255 and CHKID in (7,37);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=255 and KODF in ('1A','27','2C','2D','70','C9','D3','E2');
 commit;
--==============================================================================--
-- ********** 615 - ������ ����� ��������� ********** --
--==============================================================================--
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=615 and IDG in (55);
 commit;
--==============================================================================--
-- ********** 396 - ���������� ����� ������������ ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=396 and codeapp in ('OWAY','OBPC','BIRD','BIRZ','BIRG','@PKP','VALB','OTCN','DPAZ','@BDK','SWAP',
                              '@ILI','VIZA','WOPR','KRES','@PN2','@M11','@EGG','@EGF','@EGB','@EGU','@PKK','ZAP ','MANY');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=396 and IDG in (19);
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=396 and IDG in (4,16);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=396 and CHKID in (2,5,11,16,17,22,23,24,38,39,41,74,75,94);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=396 and KODF in ('C9','D8');
--==============================================================================--
-- ********** 598 - ������ ³���� ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=598 and codeapp in ('@ROP','KREF','KREW','WCSM');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=598 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 746 - ����� ������� ������� ********** --
--==============================================================================--
-- @UDT - ��� ������������ ����������� ������
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=746 and codeapp in ('@UDT');
-- update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
-- where idu=746 and IDG in (32);
--==============================================================================--
-- ********** 584 - �������� ˳�� ����㳿��� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=584 and codeapp in ('@ROP','KREF','KREW','WCSM');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=584 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 90 - ��������� ������ ������� ********** --
--==============================================================================--
-- begin
--   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
--     values (90, 'WCSM', BeginOfYear, EndOfYear, 1, 1);
--   exception when OTHERS then null;
-- end;
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=90 and codeapp in ('AUSP','KRED','KREW','@PKK','MANY');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=90 and IDG in (20);
 commit;
--==============================================================================--
-- ********** 775 - �������� ������� ǳ�������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=775 and codeapp in ('VIZA');
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=775 and CHKID in (40);
 commit;
--==============================================================================--
-- ********** 239 - ����� ������ �����볿��� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=239 and codeapp in ('WCIG','BIRD','DRU1','SWAP','KREW','@UPR','KAZN','MANY');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=239 and IDG in (19);
 commit;
--==============================================================================--
-- ********** 235 - ����������� ����� ������������ ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=235 and codeapp in ('KAZN');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=235 and IDG in (52);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=235 and KODF in ('C6');
 commit;
--==============================================================================--
-- ********** 498 - ���� ������ �������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=498 and codeapp in ('WCAS');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=498 and IDG in (55);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=498 and CHKID in (1,4,5);
 commit;
--==============================================================================--
-- ********** 571 - ��������� ����� ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=571 and codeapp in ('@ROP','KREW');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=571 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 121 - ������� ������� ������������ ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=121 and codeapp in ('WCIG','PENS','ICCK','WIKD','OWAY','OBPC','BIRZ','W_W4','BPKI','@PKP','BPKZ',
                              'VNOT','DRU1','OTCN','KREV','@ILI','KRED','KRIF','WREQ','KLPA','OPER','WDOC',
                              'BPKR','WGRT','REGB','@EGF','@PKK','FIN2');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=121 and TT in ('007','012','013','014','015','060','096','114','210','215','301','310','514','8C2',
                         'C10','CV8','CVO','D06','D07','D66','MUU','PKD','PKG','PKN','PKQ','PKR','PKS','PKU',
                         'PKX','PKY','PKZ','W41','W42','W4E','W4F','W4G');
-- update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
-- where idu=121 and IDG in (4,16,17,20);
-- update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=121 and CHKID in (5);
-- update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=121 and KODF in ('1A','C9','D3','D8','E9');
--==============================================================================--
-- ********** 425 - ��� ����� ������������ ********** --
--==============================================================================--
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (425, 'PRVN', to_date('01/01/2016','DD/MM/YYYY'), to_date('31/12/2016','DD/MM/YYYY'), 1, 1);
   exception when OTHERS then null;
 end;
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=425 and codeapp in ('WCIG','AUSP','KREF','KREW','OVER','PRAH');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=425 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 126 - �������� ���� �����볿��� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=126 and codeapp in ('@BPB','@IN ','ICCK','WIKD','VALB','VNOT','OTCN','@MPS','VIZA','WDOC','@EGG','SKOP','@HEK');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=126 and TT in ('010','012','013','014','015','01A','025','026','036','037','038','039','054',
                         '055','070','093','096','114','118','119','139','148','149','163','177','181',
                         '182','183','187','188','189','192','193','203','211','214','223','225','38X',
                         '38Y','494','807','845','849','854','863','864','8C0','8C2','8C3','8C4','A16',
                         'A17','A18','C00','C02','C10','C14','CV9','CVB','CVO','CVS','D06','D07','D66',
                         'F01','F02','F10','FXV','FXW','I10','SW0','SW4','SWD','SWK','TOG','TOK','TOL',
                         'TOM','TOO','TOP','TOU','TOV','TOW','TOX','TUK','TUL','VM1','VM2','VM3','VM4',
                         'VM5','VM6','Z13','Z16','Z17');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=126 and IDG in (16,55);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=126 and CHKID in (2,5);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=126 and KODF in ('12','13','1A','39','44','73','94','A4','C6','C9','D3','E0');
 commit;
--==============================================================================--
-- ********** 627 - ������� ����� ������������ ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=BeginOfYear, adate2=EndOfYear
 where id=627 and codeapp in ('@BPB','@IN ','@HEK','ICCK','OTCN','SKOP','VALB','VNOT','WDOC','WIKD');
 update STAFF_TTS set adate1=BeginOfYear, adate2=EndOfYear
 where id=627 and TT in ('012','013','014','015','025','026','036','037','038','039',
                         '070','093','096','114','118','119','139','148','149','163',
                         '181','187','188','189','192','193','203','211','214','223',
                         '225','38X','38Y','494','807','845','849','863','864','8C0',
                         '8C2','8C3','8C4','A16','A17','A18','C10','C14','CV9','D06',
                         'D07','D66','F01','F02','F10','FXV','FXW','I10','SW4','TOG',
                         'TOK','TOL','TOM','TOO','TOP','TOU','TOV','TOW','TOX','TUK',
                         'TUL','VM1','VM2','VM3','VM4','VM5','VM6','Z13','Z16','Z17');
 update GROUPS_STAFF set adate1=BeginOfYear, adate2=EndOfYear, secg=7
 where idu=627 and IDG in (16,55);
 update STAFF_CHK set adate1=BeginOfYear, adate2=EndOfYear
 where id=627 and CHKID in (5);
 update STAFF_KLF00 set adate1=BeginOfYear, adate2=EndOfYear
 where id=627 and KODF in ('12','13','39','44','73','94','C6');
 commit;
--==============================================================================--
-- ********** 413 - ����� ����� �������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=413 and codeapp in ('KREW');
 commit;
--==============================================================================--
-- ********** 610 - ����� ������� ����� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=610 and codeapp in ('WCIG','PENS','WIKD','OWAY','OBPC','BIRZ','W_W4','BPKI','@PKP','BPKZ','VNOT',
                              'DRU1','OTCN','KREV','@ILI','KRED','KRIF','WREQ','KLPA','OPER','WDOC','BPKR',
                              'WGRT','REGB','@EGF','@PKK','FIN2');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=610 and TT in ('007','012','013','014','015','060','096','114','210','215','301','310','514','8C2',
                         'C10','CV8','CVO','D06','D07','D66','MUU','PKD','PKG','PKN','PKQ','PKR','PKS','PKU',
                         'PKX','PKY','PKZ','W41','W42','W4E','W4F','W4G');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=610 and IDG in (4,16,17,20);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=610 and CHKID in (5);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=610 and KODF in ('1A','C9','D3','D8','E9');
 commit;
--==============================================================================--
-- ********** 556 - ������ ���� ��������� ********** --
--==============================================================================--
-- ANI1 - ��� �������� �������
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=556 and codeapp in ('ANI1');
-- update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
-- where idu=556 and IDG in (172);
--==============================================================================--
-- ********** 428 - ������ ������ ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=428 and codeapp in ('KREW','WCSM');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=428 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 474 - ��������� ����� �������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=474 and codeapp in ('OWAY','VIZA','@PKK','ZAP ');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=474 and TT in ('310','315','514');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=474 and IDG in (4,16,20);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=474 and CHKID in (2,17);
 commit;
--==============================================================================--
-- ********** 151 - ��������� ��������� ������������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=151 and codeapp in ('WSWI','WCAS','WDOC');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=151 and TT in ('012','089','205','214','401','402','403','404','406','411','412','413','416','417',
                         '418','436','437','AA0','AA5','AA6','AA9','AAC','AAE','AAK','AAM','MUM','TOX');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=151 and IDG in (4);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=151 and CHKID in (1,5);
 commit;
--==============================================================================--
-- ********** 773 - ������ ������� ���������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=773 and codeapp in ('VIZA');
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=773 and CHKID in (40);
 commit;
--==============================================================================--
-- ********** 207 - �������� ���� ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=207 and codeapp in ('DRU1','AN01','VIZA','@UPR','KAZN','UPRA');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=207 and IDG in (32);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=207 and CHKID in (42);
 commit;
--==============================================================================--
-- ********** 437 - ���������� ����� �����볿��� ********** --
--==============================================================================--
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (437, 'PRVN', to_date('01/01/2016','DD/MM/YYYY'), to_date('31/12/2016','DD/MM/YYYY'), 1, 1);
   exception when OTHERS then null;
 end;
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=437 and codeapp in ('WCIG','AUSP','@ROP','KREF','KREW','OVER','PRAH');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=437 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 450 - �������� �������� ³������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=450 and codeapp in ('BVBB','DPTU','VIZA','KREF','WREQ','REGB','PRVN');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=450 and IDG in (4,16,20);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=450 and CHKID in (2,11,16,23,38,74,75,94);
 commit;
--==============================================================================--
-- ********** 442 - ���������� ������ ����� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=442 and codeapp in ('ANKL','AUSP','@ROP','KREF','KREW','OVER','PRAH','DROB');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=442 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 515 - �������� ����� �������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=515 and codeapp in ('@IN ','ANI1','AUSP','BUHG','DRU1','METO','OPER');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=515 and IDG in (32);
 commit;
--==============================================================================--
-- ********** 82 - ³���� ����� �����������  ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=82 and codeapp in ('WCIG','KREA','AUSP','DRU1','KREF','KREW','OVER','PRAH','DROB');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=82 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 479 - ³����� ����� �������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=479 and codeapp in ('KREW');
 commit;
--==============================================================================--
-- ********** 531 - ������� ����� ���㳿��� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=531 and codeapp in ('OWAY','VIZA','WREQ','OPER','@PKK','ZAP ');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=531 and TT in ('013','015','310','315','514');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=531 and IDG in (4,16,20,23);
--==============================================================================--
-- ********** 135 - ������ ��������� ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=135 and codeapp in ('DRU1','OTCN','@ROP','@UPR','KAZN');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=135 and IDG in (32);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=135 and KODF in ('A7');
 commit;
--==============================================================================--
-- ********** 306 - �������� ����� ������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=306 and codeapp in ('WCIG','DRU1','SWAP','KREW','@UPR','KAZN','MANY');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=306 and IDG in (19);
 commit;
--==============================================================================--
-- ********** 449 - �������� ������ ³��볿��� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=449 and codeapp in ('@ROP','KREF','KREW','WCSM');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=449 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 265 - �������� ����� �������  ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=265 and codeapp in ('KAZN');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=265 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 36 - ������ ��� ���������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=36 and codeapp in ('WCAS');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=36 and IDG in (55);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=36 and CHKID in (1,4,5);
 commit;
--==============================================================================--
-- ********** 588 - ������ ����� ����������� ********** --
--==============================================================================--
-- @UDG - ��� ������ (����������)
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=588 and codeapp in ('@UDG');
-- update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
-- where idu=588 and IDG in (10);
--==============================================================================--
-- ********** 505 - ������� ������ ����㳿��� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=505 and codeapp in ('@BPB','@WF3','@WF1','BVBB','AVVV','@VAL','BAK1','DRU1','SEPN','OTCN',
                              'DPAZ','@BDK','@ONE','@ILI','VIZA','@VPS','@GU1','@PN2','@M11','@EGB','@PKK');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=505 and TT in ('012','013','014','015','060','096','101','114','514','807','824','830','839','854',
                         '8C0','8C2','C00','C02','C06','C10','C11','C12','C14','CLI','CVB','CVE','CVO','CVS',
                         'D06','D07','D66','D90','D91','SMO');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=505 and IDG in (23);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=505 and CHKID in (2,5,11,22,27,50,60,70,71);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=505 and KODF in ('B5','B6','C9','D6','E2','S6','S7');
 commit;
--==============================================================================--
-- ********** 56 - ����������� ͳ�� �������� ********** --
--==============================================================================--
-- STO1 - ��� �������� ������
-- REZR - ��� ��������� ����
-- REZW - ��� ��������� ���� � ����������
-- @PKK - ��� ��� ����� ������ �� ���'�������� ���
-- MANY - ��� ���������� ���������� �����
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (56, 'WRCA', BeginOfYear, EndOfYear, 1, 1);
   exception when OTHERS then null;
 end;
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=56 and codeapp in ('@PPZ','@OST','DPUA','ANKL','ANI1','AUSP','BIRG','AVVV','VALO','@NR ',
                             'AVTO','BAK1','VNOT','BUHG','DPTU','@PUP','SEPN','OTCN','DPAZ','@OBU',
                             'KONS','VIZA','CRPC','KREF','NACC','@GU1','KLPA','OVER','@PN2','OPER',
                             'WDOC','KONO','RKO ','KAZN','@M11','@EGU','@PKK');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=56 and TT in ('001','002','00A','00B','00C','00D','00E','00F','00G','00H','010','012','013','014',
                        '01A','027','066','067','068','069','072','073','074','075','085','096','100','101',
                        '114','178','310','404','405','406','445','514','8C2','BM6','BM7','BR1','BR2','BR3',
                        'BR4','BRK','C00','C10','CFB','CFO','CFS','CV0','CV3','CV7','CV8','CV9','CVO','D06',
                        'D07','D66','MM2','PKR','SMO','SNO');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=56 and IDG in (4);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=56 and CHKID in (2,3,11,20,22,74);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=56 and KODF in ('01','02','27','2E','C9','D3','E2','E8');
--==============================================================================--
-- ********** 595 - ��������� ����� ����������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=595 and codeapp in ('WCIG','ICCK','KREA','AUSP','BVBB','DPTU','DRU1','OTCN','VIZA','KREF',
                              'KREW','OVER','WDOC','PRAH','REGB','MANY','PRVN');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=595 and IDG in (33);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=595 and CHKID in (2,5,11,22,38,94);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=595 and KODF in ('3B','D5','D8','D9','F6','F7','F8');
--==============================================================================--
-- ********** 429 - ������� ������ ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=429 and codeapp in ('KODZ','DRU1');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=429 and IDG in (14);
 commit;
--==============================================================================--
-- ********** 408 - ����� ������� �������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=408 and codeapp in ('OWAY','VIZA','@PKK','ZAP ');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=408 and TT in ('310','315','514');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=408 and IDG in (4,16,20);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=408 and CHKID in (17);
 commit;
--==============================================================================--
-- ********** 32 - ���䳺��� ����� ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=32 and codeapp in ('ANI1','VNOT','VIZA','OPER','NALS','NALY','@EGG','@PKK','@INP');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=32 and TT in ('015','060','096','420','825','PO1');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=32 and IDG in (171);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=32 and CHKID in (2,5,34);
 commit;
--==============================================================================--
-- ********** 342 - �������� ������ ������� ********** --
--==============================================================================--
-- @MET - ��� �������� ������
-- @UDG - ��� ������ (����������)
-- VALB - ��� �������� ��������� 
-- @GU1 - ��� ��������� �����
-- @PN2 - ��� ����������� � ����������
-- OPER - ��� ������������
-- WDOC - ��� ������������ (WEB)
-- @HEK - ��� ����
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=342 and codeapp in ('@MET','@UDG','VALB','@GU1','@PN2','OPER','WDOC','@HEK');
-- update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
-- where idu=342 and IDG in (55);
--==============================================================================--
-- ********** 297 - �������� ���������� ������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=297 and codeapp in ('KREW');
 commit;
--==============================================================================--
-- ********** 431 - ������ ����� ������������ ********** --
--==============================================================================--
-- KREW - ��� ���������� i���������
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=431 and codeapp in ('KREW');
--==============================================================================--
-- ********** 523 - ���������� ����� ������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=523 and codeapp in ('ANI1','@VAL','VALB','DRU1','OTCN','@WKZ','@BDK','SWAP','VIZA',
                              '@GU1','OPER','KAZN','REGB','@EGB','REZR','@PKK','MANY');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=523 and TT in ('012','013','014','015','060','096','807','813','814','817','818',
                         '830','C04','CV7','D06','D07','F01','F02','F10','FX9','FXE','SW0','SW4','V07');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=523 and IDG in (19);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=523 and CHKID in (5,70,75);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=523 and KODF in ('1A','2A','2G','35','6A','70','79','C9','D3','D5','D6','D8','E2','E8','S6');
 commit;
--==============================================================================--
-- ********** 561 - ������ ��� �������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=561 and codeapp in ('DPTA','AUSP','WBPK','W_W4','@PKP','VALO','VALB','BAK1','OTCN',
                              'VIZA','@GU1','@PN2','@EGF','STO1','@PKK');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=561 and IDG in (4,6);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=561 and CHKID in (2,5);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=561 and KODF in ('F1');
 commit;
--==============================================================================--
-- ********** 362 - ���������� ���������� �����볿��� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=362 and codeapp in ('BIRV','BIRZ','VALB','WCIM','@KPK','@PUP','OTCN','VIZA');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=362 and IDG in (31);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=362 and CHKID in (7,37);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=362 and KODF in ('1A','27','2C','2D','70','C9','D3','E2');
 commit;
--==============================================================================--
-- ********** 48 - �������� ������ �����볿��� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=48 and codeapp in ('WCAS','WDOC');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=48 and TT in ('012','025','026','089','150','205','214','401','402','403','404','406','411','412',
                        '413','414','416','417','418','436','437','457','A05','A16','AA0','AA5','AA6','AA9',
                        'AAC','AAE','AAK','AAM','MUM','TOX');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=48 and IDG in (4);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=48 and CHKID in (1,5,16);
 commit;
--==============================================================================--
-- ********** 84 - ������ ����� �����  ********** --
--==============================================================================--
-- WCIG - ��� I�������� � ����I
-- ICCK - ��� ������������i� ��������� ����� � ������i
-- KREA - ��� ��������������� ������i� ��
-- AUSP - ��� ����� ������������i�
-- BVBB - ��� ���-�����
-- DRU1 - ��� ���� ���� 
-- OTCN - ��� ������� ���
-- KREF - ��� ������� ��
-- KREW - ��� ���������� i���������
-- OVER - ��� ����������
-- PRAH - ��� �������� ������ �볺��� � �������
-- MANY - ��� ���������� ���������� �����
-- PRVN - ���-PRVN
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=84 and codeapp in ('WCIG','ICCK','KREA','AUSP','BVBB','DRU1','OTCN','KREF','KREW','OVER','PRAH','MANY','PRVN');
-- update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
-- where idu=84 and IDG in (33);
-- update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=84 and KODF in ('3B','D5','D8','D9','F6','F7','F8');
--==============================================================================--
-- ********** 446 - ����� ������ �������� ********** --
--==============================================================================--
-- KREW - ��� ���������� i���������
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=446 and codeapp in ('KREW');
--==============================================================================--
-- ********** 384 - ����� ³���� ����������  ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=384 and codeapp in ('@ROP','KREW');
 commit;
--==============================================================================--
-- ********** 325 - ������� ����� �������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=325 and codeapp in ('@UDG','DRU1');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=325 and IDG in (14);
 commit;
--==============================================================================--
-- ********** 542 - ������� ������ ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=542 and codeapp in ('@UDG','DRUO');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=542 and IDG in (14);
 commit;
--==============================================================================--
-- ********** 624 - ĳ����� ������ �������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=624 and codeapp in ('BIRV','BIRZ','VALB','WCIM','@KPK','@PUP','OTCN','VIZA');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=624 and IDG in (4,31);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=624 and CHKID in (7,37);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=624 and KODF in ('27','2C','2D','70','C9','D3','E2');
 commit;
--==============================================================================--
-- ********** 324 - ��������� ����� ������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=324 and codeapp in ('VIZA','RZBS');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=324 and IDG in (16);
 commit;
--==============================================================================--
-- ********** 533 - �������� ������� ������������ ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=533 and codeapp in ('@BPB','WLCS','PENS','W_W4','@PKP','WDPT','WNER','@PN2','WDOC','@EGF','WEBP','@PKK');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=533 and TT in ('007','012','013','016','017','021','025','026','027','028','02A','033','045',
                         '048','077','07A','089','207','208','215','310','401','402','403','406','410',
                         '411','412','413','414','827','828','A05','A16','A17','AA3','AA4','AA7','AA8',
                         'AAN','C05','CAA','CAB','CAS','CVB','CVO','CVS','HO1','HO3','HO6','HO9','KR7',
                         'MUJ','MUU','PKD','PKE','PKF','PKG','PKH','PKK','PKN','PKQ','PKR','PKS','PKT',
                         'PKU','PKX','PKY','PKZ','W4E','W4F','W4G');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=533 and IDG in (4,6);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=533 and CHKID in (5);
 commit;
--==============================================================================--
-- ********** 581 - ����� ������ ����������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=581 and codeapp in ('KREW');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=581 and IDG in (10);
 commit;
--==============================================================================--
-- ********** 441 - ������� ����� ³�������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=441 and codeapp in ('ANKL','ANI1','AUSP','BIRZ','VNOT','DPTU','CRPC','@ROP','KREF','KREW',
                              'OVER','OPER','PRAH','RKO ','DROB','REGK','REZR','FIN2','MANY');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=441 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 467 - �������� ������ ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=467 and codeapp in ('@BPB','WLCS','PENS','W_W4','@PKP','WDPT','WNER','@PN2','WDOC','@EGF','WEBP','@PKK');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=467 and TT in ('007','008','012','013','014','016','017','021','025','026','027','028','02A',
                         '033','045','048','049','077','07A','089','096','114','207','215','310','315',
                         '401','402','403','406','410','411','412','413','414','439','827','828','8C2',
                         'A05','A16','A17','AA3','AA4','AA7','AA8','AAN','C00','C05','CAA','CAB','CAS',
                         'CVB','CVO','CVS','D06','D07','HO1','HO3','HO6','HO9','KR7','MUJ','MUU','MUV',
                         'PKD','PKE','PKF','PKG','PKH','PKK','PKN','PKQ','PKR','PKS','PKU','PKX','PKY',
                         'PKZ','W4E','W4F','W4G');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=467 and IDG in (4);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=467 and CHKID in (5);
 commit;
--==============================================================================--
-- ********** 490 - �������� ���� ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=490 and codeapp in ('@IN ','ICCK','ANI1','AUSP','BPKB','@PKP','AVVV','VALB','AVTO','BUHG','DPTU',
                              'DRU1','KREB','KONS','DPKK','KRED','KRIF','KREF','METO','OPER','REGK','STO1',
                              'KRPF','PRVN');
-- update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=490 and TT in ('085');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=490 and IDG in (32);
 commit;
--==============================================================================--
-- ********** 568 - ������ ���"�� ��������  ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=568 and codeapp in ('WCIG','AUSP','KREF','KREW','OVER','PRAH');
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (568, 'PRVN', to_date('01/01/2016','DD/MM/YYYY'), to_date('31/12/2016','DD/MM/YYYY'), 1, 1);
   exception when OTHERS then null;
 end;
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=568 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 564 - ������ ���� ������� ********** --
--==============================================================================--
-- @MET - ��� �������� ������
-- @UDG - ��� ������ (����������)
-- @HEK - ��� ����
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=564 and codeapp in ('@MET','@UDG','@HEK');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=564 and IDG in (55);
 commit;
--==============================================================================--
-- ********** 243 - ���� ������� ������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=243 and codeapp in ('DRU1','OTCN','@ROP','@UPR','PRAH','KAZN','UPRA');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=243 and IDG in (32);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=243 and KODF in ('A7');
--==============================================================================--
-- ********** 67 - ������ ������ ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=67 and codeapp in ('WCIG','PENS','WIKD','OWAY','OBPC','BIRZ','W_W4','BPKI','@PKP','BPKZ','VNOT','DRU1',
                             'OTCN','KREV','@ILI','KRED','KRIF','WREQ','KLPA','OPER','WDOC','BPKR','WGRT','REGB',
                             '@EGF','@PKK','FIN2');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=67 and TT in ('007','012','013','014','015','060','096','114','210','215','301','310','514','8C2','C10',
                        'CV8','CVO','D06','D07','D66','MUU','PKD','PKG','PKN','PKQ','PKR','PKS','PKU','PKX','PKY',
                        'PKZ','W41','W42','W4E','W4F','W4G');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=67 and IDG in (4,16,17,20);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=67 and CHKID in (5);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=67 and KODF in ('1A','C9','D3','D8','E9');
 commit;
--==============================================================================--
-- ********** 392 - ����� ����� ������������ ********** --
--==============================================================================--
-- KODZ - ��� �������� �����i���
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=392 and codeapp in ('KODZ');
--==============================================================================--
-- ********** 409 - ����� ���� ������������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=409 and codeapp in ('IADM','@CLI','TKLB');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=409 and IDG in (1);
 commit;
--==============================================================================--
-- ********** 774 - ������-��������� ������ ������������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=774 and codeapp in ('VIZA');
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=774 and CHKID in (40);
 commit;
--==============================================================================--
-- ********** 572 - ������� ������ ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=572 and codeapp in ('@ROP','KREW');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=572 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 206 - ���� ����� ������������ ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=206 and codeapp in ('BIRD','@UPR','KAZN');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=206 and IDG in (19);
 commit;
--==============================================================================--
-- ********** 586 - ����� ������ �����볿��� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=586 and codeapp in ('@BPB','BIRV','BIRD','BIRZ','@PTZ','VALB','WCIM','@KPK','@PUP','OTCN','VIZA');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=586 and IDG in (4,31);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=586 and CHKID in (7,37);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=586 and KODF in ('1A','1P','2C','2D','2E','70','C9','D3','E2');
 commit;
--==============================================================================--
-- ********** 592 - ������ ������ ���㳿��� ********** --
--==============================================================================--
-- update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
-- where idu=592 and IDG in (33);
commit;
--==============================================================================--
-- ********** 607 - ������� ������ �����볿��� ********** --
--==============================================================================--
-- OWAY - ��� ��������� � OpenWay
-- DPTA - ��� ������������ ��������� ������� ��
-- ANKL - ��� ����i� ��i���i�
-- ANI1 - ��� �������� �������
-- @PKP - ��� ���. ��������
-- VNOT - ��� �������� ������� �������� �����
-- AUDI - ��� ������-����� �� ��
-- DRU1 - ��� ���� ���� 
-- OTCN - ��� ������� ���
-- CRPC - ��� ����������� �볺���
-- KRE3 - ��� ������� �� (��������)
-- KRIF - ��� ������� �� - I�����������i�
-- KREW - ��� ���������� i���������
-- PRAH - ��� �������� ������ �볺��� � �������
-- REGK - ��� ��������� �볺��� �� �������
-- FIN2 - ��� �i�������� ���� ������������
-- MANY - ��� ���������� ���������� �����
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=607 and codeapp in ('OWAY','DPTA','ANKL','ANI1','@PKP','VNOT','AUDI','DRU1','OTCN','CRPC','KRE3','KRIF','KREW','PRAH','REGK','FIN2','MANY');
-- update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
-- where idu=607 and IDG in (14);
--==============================================================================--
-- ********** 351 - ������ ����� ��������  ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=351 and codeapp in ('WCIG','AUSP','KREF','KREW','OVER','PRAH');
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (351, 'PRVN', to_date('01/01/2016','DD/MM/YYYY'), to_date('31/12/2016','DD/MM/YYYY'), 1, 1);
   exception when OTHERS then null;
 end;
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (351, 'DRU1', to_date('01/01/2016','DD/MM/YYYY'), to_date('31/12/2016','DD/MM/YYYY'), 1, 1);
   exception when OTHERS then null;
 end;
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=351 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 510 - ������ ������� ������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=510 and codeapp in ('AUSP','KRED','KREW','MANY');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=510 and IDG in (20);
 commit;
--==============================================================================--
-- ********** 17 - ���������� ����� ³��볿��� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=17 and codeapp in ('ANI1','AVTO','BAK1','VNOT','BUHG','XOZD','DRU1','KONS','VIZA','METO','@GU1',
                             'OPER','@EGG','REGK','@EGF','@SEP','@PKK','MANY');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=17 and TT in ('013','014','015','060','096','097','101','111','114','210','224','302','310','420',
                        '440','445','496','497','514','820','8C2','CVO','D06','D07','D66','PKA','PKR','PKV','ZG8');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=17 and IDG in (172);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=17 and CHKID in (2,5,10,11,17);
 commit;
--==============================================================================--
-- ********** 454 - ǳ����� ����� ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=454 and codeapp in ('@UDG','DRUO');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=454 and IDG in (14);
 commit;
--==============================================================================--
-- ********** 369 - ���� ����� ������������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=369 and codeapp in ('REGK','FMON');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=369 and IDG in (17,38);
 commit;
--==============================================================================--
-- ********** 137 - ��������� ���� ������������ ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=137 and codeapp in ('WCIG','PENS','ICCK','WIKD','OWAY','OBPC','ARGK','DPTA','AUSP','BIRZ','W_W4',
                              'BPKI','BPKE','BPKB','@PKP','BPKZ','BVBB','AVVV','VALB','AVTO','WDPT','VNOT',
                              'DPTU','DRU1','OTCN','DPAZ','KREV','@ILI','KONS','VIZA','KRED','KRIF','KREF',
                              'KREW','NACC','WNER','WREQ','KLPA','OVER','@PN2','OPER','WDOC','WKBO','BPKR',
                              'WGRT','WINS','REGB','@EGG','@EGF','@EGU','@PKK','FIN2','MANY','PRVN');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=137 and TT in ('007','012','013','014','015','060','096','097','114','210','215','301','310','315',
                         '496','497','514','830','8C2','961','962','963','964','A18','C10','CV8','CVO','D06',
                         'D07','D66','MUU','PKA','PKD','PKE','PKF','PKG','PKH','PKK','PKN','PKQ','PKR','PKS',
                         'PKT','PKU','PKV','PKX','PKY','PKZ','W41','W42','W4E','W4F','W4G','ZG8');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=137 and IDG in (4,16,17,20);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=137 and CHKID in (2,5,11,16,17,22,23,38,94);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=137 and KODF in ('1A','C9','D3','D8','D9');
 commit;
--==============================================================================--
-- ********** 380 - ������ ������ ������������ ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=380 and codeapp in ('KREA','BIRZ','BIRG','VALB','VNOT','DPTU','SEPN','OTCN','KREB','KART',
                              'VIZA','KREF','NACC','KLPA','@PN2','OPER','PRAH','RKO ','REGB','WRCA');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=380 and TT in ('001','002','00A','00B','00C','00D','00E','00F','00G','00H','010','012','013','014',
                         '015','01A','027','060','07A','096','100','101','114','178','310','404','405','406',
                         '409','8C2','BR2','BR4','BRK','C00','C10','CFB','CFO','CFS','CV0','CV3','CV7','CV9',
                         'CVB','CVO','CVS','D06','D07','D66','MM2','SMO','SNO');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=380 and IDG in (4);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=380 and CHKID in (5,38);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=380 and KODF in ('D5','D8','D9','F8');
 commit;
--==============================================================================--
-- ********** 601 - ������� �'������� ������������ ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=601 and codeapp in ('@PPZ','@UDG','@PLD','VNOT','@CP1','OTCN','CRPC','CHIF','TEHA','@ECH');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=601 and IDG in (32);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=601 and KODF in ('01','02','08','11','25','30','3A','42','4A','78','81','8B','A4','A7','C5','D2','F4');
 commit;
--==============================================================================--
-- ********** 312 - �������� ����� ³������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=312 and codeapp in ('@VAL','VALB','DRU1','OTCN','@WKZ','@BDK','SWAP','@UPR',
                              '@PN2','OPER','@EGB','@EGU','@PKK','PRVN');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=312 and TT in ('012','013','014','015','060','096','807','813','814','817','818',
                         '830','C04','CV7','CV9','CVO','D06','D07','F01','F02','F10','FX9',
                         'SW0','SW4','V07','V77');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=312 and IDG in (19);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=312 and CHKID in (5);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=312 and KODF in ('2G','70','C9','D3','D8','E2','E8','S6');
--==============================================================================--
-- ********** 604 - ���������� �������� ³�������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=604 and codeapp in ('@ROP','KREF','KREW','WCSM');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=604 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 375 - ������������� ���� �����������  ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=375 and codeapp in ('WCIG','AUSP','OTCN','KREF','KREW','OVER','PRAH');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=375 and IDG in (33);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=375 and KODF in ('35','36','39','3A','D5','D8','D9','F6','F7','F8');
 commit;
--==============================================================================--
-- ********** 438 - �������� �������� ���㳿��� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=438 and codeapp in ('WCIG','ANKL','ANI1','AUSP','BIRZ','VNOT','DPTU','DRU1','OTCN','CRPC',
                              'KREF','OVER','OPER','PRAH','RKO ','DROB','REGK','REZR','FIN2','MANY');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=438 and IDG in (33);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=438 and KODF in ('30','3A','42','A7','D5','D8','D9','F4','F6','F7','F8');
 commit;
--==============================================================================--
-- ********** 336 - ��� ���� ����������� ********** --
--==============================================================================--
-- @UDT - ��� ������������ ����������� ������
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=336 and codeapp in ('@UDT');
-- update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
-- where idu=336 and IDG in (32);
--==============================================================================--
-- ********** 59 - ʳ���� ������ ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=59 and codeapp in ('KREA','DPTU','DRUO','SEPN','OTCN','KREB','VIZA','KREF','NACC','KLPA',
                             'OVER','@PN2','OPER','REGB','WRCA','@PKK');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=59 and TT in ('001','002','010','012','013','014','015','01A','085','096','097','100','101',
                        '114','310','514','824','8C2','CVO','D06','D07','D66','MM2','SMO','SNO','ZG8');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=59 and IDG in (4);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=59 and CHKID in (5,38);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=59 and KODF in ('D5','D8','D9','F8');
 commit;
--==============================================================================--
-- ********** 157 - ������ ���� �����볿��� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=157 and codeapp in ('@PPZ','@OST','BIRG','VALB','DPTU','KODZ','DRU1','OTCN','KART',
                              'VIZA','NACC','@PN2','OPER','KONO','RKO ','@PKK','KRPF');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=157 and TT in ('001','002','00A','00B','00C','00D','00E','00F','00G','00H','010','012','013',
                         '014','015','01A','027','03C','066','067','069','072','073','074','075','085',
                         '096','100','101','114','178','310','405','406','445','514','8C2','BM6','BM7',
                         'BR1','BR2','BR3','BR4','BRK','C10','CVO','D06','D07','D66','MM2','PKR','SMO','BRP');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=157 and IDG in (4);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=157 and CHKID in (5);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=157 and KODF in ('D3','E2');
 commit;
--==============================================================================--
-- ********** 378 - �������� ���� ������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=378 and codeapp in ('REGK','FMON');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=378 and IDG in (38);
 commit;
--==============================================================================--
-- ********** 602 - ���'������ ������ ³��볿��� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=602 and codeapp in ('BIRG','VALB','DPTU','KODZ','SEPN','OTCN','KART','VIZA','NACC',
                              '@PN2','OPER','KONO','RKO ','@PKK','KRPF');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=602 and TT in ('001','002','00A','00B','00C','00D','00E','00F','00G','00H','010','013',
                         '014','015','01A','027','100','101','114','178','310','405','406','445',
                         'BM6','BM7','BR1','BR2','BR3','BR4','BRK','C00','CV0','CV3','CV7','CV8',
                         'CV9','CVO','D06','D07','MM2','PKR','SMO','SNO');
 begin
   insert into STAFF_TTS (tt,id,adate1,adate2,approve,grantor)
     values ('096', 602, to_date('01/01/2016','DD/MM/YYYY'), to_date('31/12/2016','DD/MM/YYYY'), 1, 1); 
   exception when OTHERS then null;
 end;
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=602 and IDG in (4);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=602 and CHKID in (5);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=602 and KODF in ('27','C9','D3','E2');
 commit;
--==============================================================================--
-- ********** 330 - ���'����� ����� ������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=330 and codeapp in ('REGK','FMON');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=330 and IDG in (38);
 commit;
--==============================================================================--
-- ********** 622 - ����� ����� ������������� ********** --
--==============================================================================--
-- KREW - ��� ���������� i���������
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=622 and codeapp in ('KREW');
--==============================================================================--
-- ********** 91 - ����� ���� ³������� ********** --
--==============================================================================--
-- begin
--   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
--     values (91, 'WCSM', to_date('01/01/2016','DD/MM/YYYY'), to_date('31/12/2016','DD/MM/YYYY'), 1, 1);
--   exception when OTHERS then null;
-- end;
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=91 and codeapp in ('AUSP','DRU1','KRED','KREW','MANY');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=91 and IDG in (20);
 commit;
--==============================================================================--
-- ********** 573 - ���� ������ ��������� ********** --
--==============================================================================--
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (573, 'OTCN', BeginOfYear, EndOfYear, 1, 1);
   exception when OTHERS then null;
 end;
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (573, 'AVTO', BeginOfYear, EndOfYear, 1, 1);
   exception when OTHERS then null;
 end;
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=573 and codeapp in ('@BPB','WLCS','DPTA','BIRG','W_W4','@PKP','WDPT','AUDI','DPKK','VIZA','@D88','WNER','@PN2','WDOC','@EGF','STO1','WEBP','@PKK');
 begin
   insert into STAFF_TTS (id, tt, adate1, adate2, approve, grantor)
     values (573, '015', BeginOfYear, EndOfYear, 1, 1);
   exception when OTHERS then null;
 end;
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=573 and TT in ('007','008','012','013','014','016','021','025','026','027','028','02A','033','045',
                         '048','049','077','07A','089','096','114','177','207','215','310','401','402','403',
                         '406','410','411','412','413','414','827','828','8C0','8C2','A05','A16','A17','AA3',
                         'AA4','AA7','AA8','AAN','C00','C05','CAA','CAB','CAS','CV7','CVB','CVO','CVS','D06',
                         'D07','GM1','GM2','HO1','HO3','HO6','HO9','KR7','MUJ','MUU','PKD','PKE','PKF','PKG',
                         'PKH','PKK','PKN','PKO','PKQ','PKR','PKS','PKU','PKX','PKY','PKZ','SI1','SI2','SI3',
                         'SI4','SI5','SI6','W4E','W4F','W4G');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=573 and IDG in (4,43);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=573 and CHKID in (2,5,11);
 begin
   insert into STAFF_KLF00 (id, kodf, a017, adate1, adate2, approve, grantor)
     values (573, 'F1', 'C', to_date('01/01/2016','DD/MM/YYYY'), to_date('31/12/2016','DD/MM/YYYY'), 1, 1);
 exception when OTHERS then null;
 end;
commit;
--==============================================================================--
-- ********** 227 - ��������� ����� ³������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=227 and codeapp in ('@UPR','KAZN','UPRA');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=227 and IDG in (32);
 commit;
--==============================================================================--
-- ********** 445 - ���� ���� �����볿��� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=445 and codeapp in ('KREW');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=445 and IDG in (10);
 commit;
--==============================================================================--
-- ********** 313 - �������� ����� ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=313 and codeapp in ('KREW');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=313 and IDG in (19);
 commit;
--==============================================================================--
-- ********** 578 - ������ ���������� ������������ ********** --
--==============================================================================--
-- KREW - ��� ���������� i���������
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=578 and codeapp in ('KREW');
--==============================================================================--
-- ********** 567 - ��������� ˳�� ������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=567 and codeapp in ('@BPB','@WF3','@WF2','@WF1','AVVV','@VAL','DRU1','SEPN','OTCN','DPAZ',
                              '@BDK','@ONE','@ILI','VIZA','@VPS','@GU1','@PN2','@M11','@EGB','@PKK');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=567 and TT in ('012','013','014','015','060','096','101','114','514','807','824','830','839',
                         '854','8C0','8C2','C00','C02','C06','C10','C11','C12','C14','CLI','CVB','CVE',
                         'CVO','CVS','D06','D07','D66','D90','D91','SMO');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=567 and IDG in (23);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=567 and CHKID in (2,5,50,60,70,71);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=567 and KODF in ('B5','B6','C9','D6','E2','S6','S7');
 commit;
--==============================================================================--
-- ********** 534 - ��������� ������ �������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=534 and codeapp in ('KODZ');
 commit;
--==============================================================================--
-- ********** 432 - ��������� ������� ������������ ********** --
--==============================================================================--
-- KREW - ��� ���������� i���������
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=432 and codeapp in ('KREW');
--==============================================================================--
-- ********** 458 - ������ ������� ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=458 and codeapp in ('KREW');
 commit;
--==============================================================================--
-- ********** 93 - �������� ��� ����������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=93 and codeapp in ('WCIG','ANKL','ANI1','AUSP','BIRZ','VNOT','DPTU','DRU1','CRPC','@ROP','KREF',
                             'KREW','OVER','OPER','PRAH','RKO ','DROB','REGK','REZR','FIN2','MANY','PRVN');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=93 and IDG in (33);
-- update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=93 and KODF in ('8B','A7','D5','D6','D8','D9','F6','F7','F8');
 commit;
--==============================================================================--
-- ********** 499 - ������� ������� ���㳿��� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=499 and codeapp in ('@ROP','KREW');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=499 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 391 - ���������� ������ �������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=391 and codeapp in ('ANI1','VNOT','XOZD','KONS','OPER','@EGG','@PKK');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=391 and TT in ('012','014','015','060','096','109','110','111','210','224','302','415','420','445','D66','PK7','PKR');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=391 and IDG in (172);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=391 and CHKID in (5);
 commit;
--==============================================================================--
-- ********** 202 - ����쳺�� �����  ���������  ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=202 and codeapp in ('@ROP','@UPR','KAZN','UPRA');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=202 and IDG in (32);
 commit;
--==============================================================================--
-- ********** 254 - ����������� ������ �'����������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=254 and codeapp in ('ICCK','WIKD','BIRZ','@PTZ','VALB','WCAS','LCS1');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=254 and IDG in (55);
 commit;
--==============================================================================--
-- ********** 164 - ���������� ������ ������������ ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=164 and codeapp in ('KAZN','UPRA');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=164 and IDG in (19);
 commit;
--==============================================================================--
-- ********** 7 - ��������� ���� ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=7 and codeapp in ('DRU1','WCAS','WDOC');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=7 and TT in ('012','025','026','089','150','175','205','214','401','402','403','404','406','411',
                       '412','413','414','416','417','418','436','437','457','A05','A16','AA0','AA5','AA6',
                       'AA9','AAC','AAE','AAK','AAL','AAM','TOX');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=7 and IDG in (4);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=7 and CHKID in (1,5,16);
--==============================================================================--
-- ********** 249 - ��������� ������ ������������ ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=249 and codeapp in ('ANI1');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=249 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 463 - �������� ������ ³������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=463 and codeapp in ('ANI1','AUSP','AVVV','XOZD','KONS','OPER');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=463 and TT in ('013','014','015','060','096','097','101','111','114','210','224','302','310','420',
                         '440','445','496','497','514','820','8C2','CVO','D06','D07','D66','PKR','ZG8');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=463 and IDG in (172);
 commit;
--==============================================================================--
-- ********** 246 - ���� ����� ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=246 and codeapp in ('WLCS','BIRV','BIRZ','@PTZ','VALB','WCIM','@PUP','OTCN');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=246 and IDG in (4,31);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=246 and KODF in ('1A','1P','27','2C','2D','35','36','6A','70','C9','D3','E2');
 commit;
--==============================================================================--
-- ********** 228 - ������� ������� ����������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=228 and codeapp in ('@VAL','VALB','DRU1','OTCN','@WKZ','@BDK','SWAP','VIZA','@PN2','OPER','REGB','@EGB','PRVN');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=228 and TT in ('012','013','014','015','060','096','807','813','814','817','818',
                         '830','C04','CV7','CV9','CVO','D06','D07','D66','F01','F02','F10',
                         'FX9','SW0','SW4','V07','V77');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=228 and IDG in (19);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=228 and CHKID in (2,5,17,22,70,74,75);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=228 and KODF in ('2A','35','6A','70','79','C9','D3','D8','E2','E8','S6');
--==============================================================================--
-- ********** 376 - ������ ������� �����볿��� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=376 and codeapp in ('@MET','@UDG','@HEK');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=376 and IDG in (55);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=376 and KODF in ('12');
 commit;
--==============================================================================--
-- ********** 50 - �������� ������ ���������  ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=50 and codeapp in ('BUHG','AN01','KAZN','REGK','UPRA');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=50 and IDG in (32,200);
 commit;
--==============================================================================--
-- ********** 434 - ���������� ������ ���㳿��� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=434 and codeapp in ('@DCP','DRU1','@BDK','NACC','OPER','@EGB','@PKK','@INP');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=434 and TT in ('012','013','014','015','060','096','100','310','807','830','8C3',
                         'C04','D06','D07','F10','F80','PO1','SW4','SW5');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=434 and IDG in (19);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=434 and CHKID in (5);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=434 and KODF in ('07','20','84','E1');
 commit;
--==============================================================================--
-- ********** 464 - ������ ������� ³������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=464 and codeapp in ('@PPZ','@OST','KREA','DPUA','ANKL','BIRG','W_W4','AVVV','VALB','DPTU','KODZ',
                              '@PUP','SEPN','OTCN','DPAZ','KREB','KART','KONS','VIZA','CRPC','KREF','NACC',
                              '@GU1','KLPA','OVER','@PN2','OPER','KONO','RKO ','KAZN','@EGU','WRCA','@PKK','KRPF');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=464 and TT in ('001','002','00A','00B','00C','00D','00E','00F','00G','00H','010','012','013',
                         '014','015','01A','03C','066','067','069','072','073','074','075','085','096',
                         '100','101','114','178','310','405','406','445','514','BM6','BM7','BR1','BR2',
                         'BR3','BR4','BRK','BRP','C10','CV0','CV3','CV7','CV8','CV9','CVO','D06','D07',
                         'D66','MM2','PKR','SMO','SNO');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=464 and IDG in (4);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=464 and CHKID in (2,3,5,11,17,20,22,70);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=464 and KODF in ('1A','27','2E','C9','D3','E2','E8');
 commit;
--==============================================================================--
-- ********** 269 - �������� ����� �����볿��� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=269 and codeapp in ('@BPB','@WF3','@WF2','@WF1','AVVV','@VAL','DRU1','SEPN','OTCN','DPAZ','@BDK',
                              '@ONE','@ILI','VIZA','@VPS','@GU1','@PN2','@M11','@EGB','@PKK');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=269 and TT in ('012','013','014','015','060','096','101','114','514','807','824','830','839','854',
                         '8C0','8C2','C00','C02','C10','C11','C12','C14','CLI','CVB','CVE','CVO','CVS','D06',
                         'D07','D66','D90','D91','SMO');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=269 and IDG in (23);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=269 and CHKID in (2,5,11,22,50,60,70,71);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=269 and KODF in ('26','B5','B6','C9','D4','D6','E2','S6','S7');
 commit;
--==============================================================================--
-- ********** 511 - ����� ����� �������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=511 and codeapp in ('KREW');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=511 and IDG in (10);
 commit;
--==============================================================================--
-- ********** 8 - �������� ����� �������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=8 and codeapp in ('ACBO','WIKD','WCAS','VIZA','@GU1','@PN2','OPER','WDOC');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=8 and TT in ('039','068','069','193','225','TOC','TOH','TOK','TOL','TOO','TOP','TOX');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=8 and IDG in (55);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=8 and CHKID in (1,2,4,5);
 commit;
--==============================================================================--
-- ********** 559 - ��������� ����� ���������� ********** --
--==============================================================================--
-- KODZ - ��� �������� �����i���
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=559 and codeapp in ('KODZ');
--==============================================================================--
-- ********** 385 - �������� ������ ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=385 and codeapp in ('KREW','WCSM');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=385 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 31 - ����� ��� ������� ********** --
--==============================================================================--
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=31 and IDG in (171);
 commit;
--==============================================================================--
-- ********** 154 - ������ ��� ������������ ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=154 and codeapp in ('ANKL','@UDG','DRU1');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=154 and IDG in (14);
 commit;
--==============================================================================--
-- ********** 597 - ��������� ³���� ����������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=597 and codeapp in ('WCIG','AUSP','DRU1','KREF','KREW','OVER','PRAH');
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (597, 'PRVN', to_date('01/01/2016','DD/MM/YYYY'), to_date('31/12/2016','DD/MM/YYYY'), 1, 1);
   exception when OTHERS then null;
 end;
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=597 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 517 - ���������� �������� ���㳿��� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=517 and codeapp in ('BIRG','VALB','DPTU','KODZ','DRUO','SEPN','OTCN','KREB','KART','VIZA','NACC',
                              'KLPA','OVER','@PN2','KONO','RKO ','@EGU','@PKK','KRPF');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=517 and TT in ('001','002','00A','00B','00C','00D','00E','00F','00G','00H','010','012','013','014',
                         '015','01A','027','096','100','101','114','178','310','405','406','445','BM6','BM7',
                         'BR1','BR2','BR3','BR4','BRK','C00','C10','CV0','CV3','CV7','CV8','CV9','D06','D07',
                         'MM2','PKR','SMO');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=517 and IDG in (4);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=517 and CHKID in (5);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=517 and KODF in ('27','C9','D3','E2');
 commit;
--==============================================================================--
-- ********** 614 - ���� ������ ����������� (������� ���) ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=614 and codeapp in ('DRU1','VIZA','@ROP','KRE3','@UPR','PRAH','CPRO');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=614 and IDG in (32);
 commit;
--==============================================================================--
-- ********** 21 - ����������� ����� �������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=21 and codeapp in ('OWAY','OBPC','BPKZ','BVB ','OPER','@EGG','@EGF');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=21 and TT in ('013','015','029','060','096','108','109','110','111','224','302','420','438','444',
                        '445','805','806','807','D07','D66','PKA','PKO','PKR','PKS','PKV','PKX');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=21 and IDG in (172);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=21 and CHKID in (5);
 commit;
--==============================================================================--
-- ********** 309 - ��������� ����� ����� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=309 and codeapp in ('ANI1');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=309 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 41 - ����� ���� �������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=41 and codeapp in ('ANI1','BUHG','XOZD','DRU1','KONS','VIZA','OPER','@EGG','REGK','@EGF','@SEP','@PKK','MANY');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=41 and TT in ('013','014','015','060','096','097','101','111','114','210','224','302','310','420','440',
                        '445','496','497','514','820','8C2','CVO','D06','D07','D66','PKR','ZG8');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=41 and IDG in (172);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=41 and CHKID in (2,5,17);
 commit;
--==============================================================================--
-- ********** 550 - ˳����� ��������� ������������ ********** --
--==============================================================================--
-- SECU - ��� �������
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=550 and codeapp in ('SECU');
--==============================================================================--
-- ********** 623 - ����� ������ �������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=623 and codeapp in ('ANI1','VNOT','VIZA','OPER','NALS','NALY','@EGG','@PKK','@INP');
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (623, 'DRUO', to_date('01/01/2016','DD/MM/YYYY'), to_date('31/12/2016','DD/MM/YYYY'), 1, 1);
   exception when OTHERS then null;
 end;
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=623 and TT in ('015','060','096','420','825','PO1');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=623 and IDG in (171);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=623 and CHKID in (2,5,34);
 commit;
--==============================================================================--
-- ********** 417 - ���� ���� ������������ ********** --
--==============================================================================--
-- KREW - ��� ���������� i���������
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=417 and codeapp in ('KREW');
--==============================================================================--
-- ********** 488 - ���������� ����� ����������� ********** --
--==============================================================================--
-- @IN  - ��� CIN �������i������ i������i�
-- ANI1 - ��� �������� �������
-- AUSP - ��� ����� ������������i�
-- BUHG - ��� �������� ���������
-- XOZD - ��� ���.������. �� ����. �������� �����
-- DRU1 - ��� ���� ���� 
-- METO - ��� ����������
-- OPER - ��� ������������
-- MANY - ��� ���������� ���������� �����
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=488 and codeapp in ('@IN ','ANI1','AUSP','BUHG','XOZD','DRU1','METO','OPER','MANY');
-- update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
-- where idu=488 and IDG in (32);
--==============================================================================--
-- ********** 315 - �������� ��������� ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=315 and codeapp in ('OBPC','@CLI');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=315 and IDG in (1);
 commit;
--==============================================================================--
-- ********** 484 - ����� ������ ���������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=484 and codeapp in ('OWAY','ARGK','VIZA','@PKK','ZAP ');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=484 and TT in ('310','315','514');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=484 and IDG in (4,16,20);
 commit;
--==============================================================================--
-- ********** 44 - �������� ������ ������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=44 and codeapp in ('ANI1','VNOT','XOZD','KONS','OPER','@EGG','@PKK');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=44 and TT in ('014','015','060','096','109','110','111','210','224','302','415','420','445','D66','PK7','PKR');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=44 and IDG in (172);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=44 and CHKID in (5);
 commit;
--==============================================================================--
-- ********** 625 - �������� �������� ���㳿��� ********** --
--==============================================================================--
-- OWAY - ��� ��������� � OpenWay
-- VIZA - ��� ��������� ��������
-- WDOC - ��� ������������ (WEB)
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=625 and codeapp in ('OWAY','VIZA','WDOC');
-- update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
-- where idu=625 and IDG in (16);
-- update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=625 and CHKID in (5);
--==============================================================================--
-- ********** 563 - ���'����� ����� ������������� ********** --
--==============================================================================--
-- KREW - ��� ���������� i���������
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=563 and codeapp in ('KREW');
--==============================================================================--
-- ********** 599 - ���'����� ����� ������������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=599 and codeapp in ('@ROP','KREF','KREW','WCSM');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=599 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 224 - ̳����������� ������ ������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=224 and codeapp in ('OTCN','@ROP','@UPR','KAZN','UPRA');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=224 and IDG in (32);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=224 and KODF in ('A7');
 commit;
--==============================================================================--
-- ********** 79 - ̳����� ³����� ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=79 and codeapp in ('ANKL','ANI1','AUSP','BIRZ','VNOT','DPTU','DRU1','OTCN','CRPC','@ROP','KREF',
                             'OVER','OPER','PRAH','RKO ','DROB','REGK','REZR','FIN2','MANY');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=79 and IDG in (33);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=79 and KODF in ('11','36','39','3A','3B','44','A7','D5','D8','D9','F4','F6','F7','F8');
 commit;
--==============================================================================--
-- ********** 475 - ̳��� ����� �������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=475 and codeapp in ('@TPF','OWAY','BPKB','@ONE','OPER','WDOC','RZBS');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=475 and TT in ('013','015','096','101','301','310','514','8C0','D06','D07','F10');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=475 and IDG in (16,23,52);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=475 and CHKID in (5);
 commit;
--==============================================================================--
-- ********** 460 - ������ ����� ³������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=460 and codeapp in ('BIRV','BIRZ','VALB','WCIM','@KPK','@PUP','OTCN','VIZA');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=460 and IDG in (4,31);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=460 and CHKID in (7,37);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=460 and KODF in ('27','2C','2D','70','C9','D3','E2');
 commit;
--==============================================================================--
-- ********** 328 - ���������� ĳ�� ������������ ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=328 and codeapp in ('@BPB','BIRV','BIRZ','@PTZ','VALB','WCIM','@KPK','@PUP','OTCN','VIZA');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=328 and IDG in (4,31);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=328 and CHKID in (7,37);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=328 and KODF in ('1A','1P','2C','2D','2E','70','C9','D3','E2');
 commit;
--==============================================================================--
-- ********** 470 - ��������� ����� �����볿��� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=470 and codeapp in ('@BPB','WLCS','WVIP','PENS','BIRG','WBPK','W_W4','@PKP','WDPT','OTCN',
                              'DPKK','WOPR','WNER','@PN2','WDOC','@EGF','STO1','WEBP','@PKK');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=470 and TT in ('007','008','012','013','014','016','017','021','027','028',
                         '02A','033','045','048','077','07A','089','096','114','207','215',
                         '310','401','402','403','404','406','409','410','411','412','413','414',
                         '439','827','828','830','8C2','A05','A16','A17','AA3','AA4','AA7','AA8',
                         'AAB','AAN','C00','C05','CAA','CAB','CAS','CVB','CVO','CVS','D06','D07',
                         'GM1','GM2','HO1','HO3','HO6','HO9','KR7','MUJ','MUR','MUU','MUV','PKD',
                         'PKE','PKF','PKG','PKH','PKK','PKN','PKO','PKQ','PKR','PKS','PKU','PKX',
                         'PKY','PKZ','W4E','W4F','W4G');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=470 and IDG in (4,6);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=470 and CHKID in (5);
 commit;
--==============================================================================--
-- ********** 331 - ��������� ����� �������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=331 and codeapp in ('WCIG','PENS','ICCK','WIKD','OWAY','OBPC','ARGK','AUSP','BIRZ','W_W4','BPKI',
                              'BPKE','BPKB','@PKP','BPKZ','BVBB','AVVV','VALB','AVTO','VNOT','DRU1','OTCN',
                              'DPAZ','KREV','@ILI','KONS','VIZA','KRED','KRIF','KREW','NACC','WREQ','KLPA',
                              'OVER','@PN2','OPER','WDOC','WKBO','BPKR','WGRT','WINS','REGB','@EGG','@EGF',
                              '@EGU','@PKK','FIN2','MANY','PRVN');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=331 and TT in ('007','012','013','014','015','060','096','114','210','215','301','310','496','497',
                         '514','830','8C2','961','962','963','964','A18','C10','CV8','CVO','D06','D07','D66',
                         'MUU','PKD','PKE','PKF','PKG','PKH','PKK','PKN','PKQ','PKR','PKS','PKT','PKU','PKX',
                         'PKY','PKZ','W41','W42','W4E','W4F','W4G');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=331 and IDG in (4,16,17,20);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=331 and CHKID in (2,5,11,16,17,22,23,94);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=331 and KODF in ('1A','C9','D3','D8','E9');
 commit;
--==============================================================================--
-- ********** 240 - �������� ����� ������������ ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=240 and codeapp in ('BIRD','DRU1','@KPK','@UPR','KAZN');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=240 and IDG in (19);
 commit;
--==============================================================================--
-- ********** 159 - �������� ���� ³��������  ********** --
--==============================================================================--
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (159, 'PRVN', to_date('01/01/2016','DD/MM/YYYY'), to_date('31/12/2016','DD/MM/YYYY'), 1, 1);
   exception when OTHERS then null;
 end;
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=159 and codeapp in ('WCIG','AUSP','KREF','KREW','OVER','PRAH');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=159 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 591 - ������� ������ ������� ********** --
--==============================================================================--
-- @UDG - ��� ������ (����������)
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=591 and codeapp in ('@UDG');
-- update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
-- where idu=591 and IDG in (10);
--==============================================================================--
-- ********** 494 - �������� ������ ���������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=494 and codeapp in ('ICCK','WIKD','BIRZ','@PTZ','VALB','WCAS','LCS1');
 commit;
--==============================================================================--
-- ********** 465 - ������� ǳ���� ������������ ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=465 and codeapp in ('ANKL','ANI1','@UDG','DRU1','DRUO');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=465 and IDG in (14);
 commit;
--==============================================================================--
-- ********** 140 - ����� ������� ������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=140 and codeapp in ('REGK','FMON');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=140 and IDG in (17,38);
 commit;
--==============================================================================--
-- ********** 390 - ������ ��������� ³�������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=390 and codeapp in ('@IN ','VIZA');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=390 and IDG in (15);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=390 and CHKID in (46);
 commit;
--==============================================================================--
-- ********** 570 - ������� ����� �'���������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=570 and codeapp in ('@BPB','@WF3','@WF2','@WF1','AVVV','@VAL','DRU1','SEPN','OTCN','DPAZ','@BDK',
                              '@ONE','@ILI','VIZA','@VPS','@GU1','@PN2','@M11','@EGB','@PKK');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=570 and TT in ('012','013','014','015','060','096','101','114','514','807','824','830','839','854',
                         '8C0','8C2','C00','C02','C06','C10','C11','C12','C14','CLI','CVB','CVE','CVO','CVS',
                         'D06','D07','D66','D90','D91','SMO');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=570 and IDG in (23);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=570 and CHKID in (2,5,11,50,60,70,71);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=570 and KODF in ('B5','B6','C9','D6','E2','S6','S7');
 commit;
--==============================================================================--
-- ********** 29 - ������� ͳ�� �������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=29 and codeapp in ('ANI1','AUSP','AVVV','VNOT','BUHG','XOZD','KONS','VIZA','OPER','@EGG','REGK','@EGF','@PKK');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=29 and TT in ('012','014','015','060','096','109','110','210','224','302','415','420','445','806','D66','PK7','PKR');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=29 and IDG in (172);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=29 and CHKID in (2,5,11,17);
 commit;
--==============================================================================--
-- ********** 374 - ����������� ������ �������  ********** --
--==============================================================================--
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (374, 'ICCK', to_date('01/01/2016','DD/MM/YYYY'), to_date('31/12/2016','DD/MM/YYYY'), 1, 1);
   exception when OTHERS then null;
 end;
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (374, 'DRU1', to_date('01/01/2016','DD/MM/YYYY'), to_date('31/12/2016','DD/MM/YYYY'), 1, 1);
   exception when OTHERS then null;
 end;
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (374, 'PRVN', to_date('01/01/2016','DD/MM/YYYY'), to_date('31/12/2016','DD/MM/YYYY'), 1, 1);
   exception when OTHERS then null;
 end; 
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=374 and codeapp in ('WCIG','AUSP','KREF','KREW','OVER','PRAH','MANY');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=374 and IDG in (33);
 commit;
-- update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=374 and KODF in ('D5','D8','D9','F6','F7','F8');
--==============================================================================--
-- ********** 448 - ������� ��� ������������ ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=448 and codeapp in ('@TPF','@IN ','@WF3','@WF2','BVBB','VALB','@ONE','VIZA','@PN2','OPER',
                              '@ASH','@EGG','RZBS','@PKK','ZAP ','PRVN');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=448 and TT in ('013','015','096','101','301','310','514','807','830','839','849',
                         '854','8C0','8C2','C04','C14','D06','D07','F10','SWD','SWK');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=448 and IDG in (32);
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=448 and IDG in (16,23);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=448 and CHKID in (2,5,11,16,17);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=448 and KODF in ('12');
 commit;
--==============================================================================--
-- ********** 344 - ���������� ������ ������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=344 and codeapp in ('KODZ');
 commit;
--==============================================================================--
-- ********** 555 - ����� ������ ����㳿��� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=555 and codeapp in ('@BPB','@IN ','ICCK','WIKD','BVBB','VALB','VNOT','OTCN','VIZA','WDOC',
                              '@ASH','@EGG','@EGU','SKOP','@HEK');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=555 and TT in ('010','012','013','014','015','01A','025','026','036','037','038','039','054',
                         '055','070','093','096','114','118','119','139','148','149','163','177','181',
                         '182','183','187','188','189','192','193','203','211','214','223','225','38X',
                         '38Y','494','807','830','845','849','854','863','864','8C0','8C2','8C3','8C4',
                         'A16','A17','A18','C00','C02','C10','C14','CV9','CVB','CVO','CVS','D06','D07',
                         'D66','F01','F02','F10','FXV','FXW','I10','SW4','SWD','SWK','TOG','TOK','TOL',
                         'TOM','TOO','TOP','TOU','TOV','TOW','TOX','TUK','TUL','VM1','VM2','VM3','VM4',
                         'VM5','VM6','Z13','Z16','Z17');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=555 and IDG in (16,55);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=555 and CHKID in (2,5,16,94);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=555 and KODF in ('12','13','39','44','73','94','A4','C6','C9','D3','E8');
 commit;
--==============================================================================--
-- ********** 723 - ͺ������ ��������� �������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=723 and codeapp in ('AN01');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=723 and IDG in (32);
 commit;
--==============================================================================--
-- ********** 326 - ͳ���� ������� ������������ ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=326 and codeapp in ('ANI1','AVVV','XOZD','KONS','OPER','@EGG','@SEP','@PKK','MANY');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=326 and TT in ('013','014','015','060','096','097','101','111','114','210','224','302','310','420',
                         '440','445','496','497','514','820','8C2','CVO','D06','D07','D66','PKR','ZG8');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=326 and IDG in (172);
 commit;
--==============================================================================--
-- ********** 424 - ��������� ����� ������������ ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=424 and codeapp in ('KREW','WCSM');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=424 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 545 - ���������� ����� ���㳿��� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=545 and codeapp in ('@UDG','DRU1');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=545 and IDG in (14);
 commit;
--==============================================================================--
-- ********** 447 - �������� �������� ������������ ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=447 and codeapp in ('ANKL','@UDG','DRU1');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=447 and IDG in (14);
 commit;
--==============================================================================--
-- ********** 165 - ���������� ������ �������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=165 and codeapp in ('@DCP','DRU1','OTCN','@BDK','VIZA','NACC','OPER','@EGB','@EGU','@PKK','MANY','@INP','PRVN');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=165 and TT in ('012','013','014','015','060','096','100','310','807','830','8C3',
                         'C04','D06','D07','F10','F80','PO1','SW4','SW5');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=165 and IDG in (19);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=165 and CHKID in (2,5,17,24,74,75);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=165 and KODF in ('07','20','84','C9');
 commit;
--==============================================================================--
-- ********** 440 - �������� ³���� ������������� ********** --
--==============================================================================--
-- VNOT - ��� �������� ������� �������� �����
-- OTCN - ��� ������� ���
-- @GU1 - ��� ��������� �����
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=440 and codeapp in ('VNOT','OTCN','@GU1');
-- update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
-- where idu=440 and IDG in (55);
-- update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=440 and KODF in ('12','13','94');
--==============================================================================--
-- ********** 386 - ����������� ������ ������������  ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=386 and codeapp in ('ANKL','@UDG','@ROP','KREF','KREW','OVER','PRAH','DROB','MANY');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=386 and IDG in (33);
--==============================================================================--
-- ********** 593 - ��������� ��� ������������ ********** --
--==============================================================================--
-- OBRZ - ��� ������� ������
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=593 and codeapp in ('OBRZ');
-- update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
-- where idu=593 and IDG in (33);
--==============================================================================--
-- ********** 134 - ���������� ������ ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=134 and codeapp in ('WSWI','WCAS','WDOC');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=134 and TT in ('012','089','205','214','401','402','403','404','406','411','412','413','416','417',
                         '418','436','437','AA0','AA5','AA6','AA9','AAC','AAE','AAK','AAM','MUM','TOX');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=134 and IDG in (4);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=134 and CHKID in (1,5);
 commit;
--==============================================================================--
-- ********** 411 - �������� ����� ������������ ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=411 and codeapp in ('IADM','@CLI','TKLB');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=411 and IDG in (1);
 commit;
--==============================================================================--
-- ********** 541 - �������� ���'� ������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=541 and codeapp in ('WCIG','ANKL','ANI1','AUSP','BIRZ','VNOT','DPTU','DRU1','OTCN','CRPC','@ROP','KREF','OVER','OPER','PRAH','RKO ','DROB','REGK','REZR','FIN2','MANY','PRVN');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=541 and IDG in (33);
-- update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=541 and KODF in ('3B','A7');
 commit;
--==============================================================================--
-- ********** 131 - �������� ������ ������������ ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=131 and codeapp in ('BIRD','@VAL','KONS','VIZA','KRES','NACC','@PN2','@EGB','@EGU','@PKK');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=131 and TT in ('013','014','096','310','807','817','818','830','8C0','C04','D06','D07','F01','F10','FXE');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=131 and IDG in (19);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=131 and CHKID in (5,74,75);
 commit;
--==============================================================================--
-- ********** 402 - �������� ������ �������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=402 and codeapp in ('@BPB','WLCS','PENS','DPTA','BIRG','WBPK','W_W4','@PKP','AVTO','WDPT','AUDI',
                              'OTCN','VIZA','WNER','@PN2','WDOC','@EGF','STO1','WEBP','@PKK');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=402 and TT in ('007','012','013','014','016','017','021','025','026','027','028','02A','033',
                         '045','048','049','077','07A','089','096','114','207','215','310','401','402',
                         '403','406','410','411','412','413','414','827','828','8C2','A05','A16','A17',
                         'AA3','AA4','AA7','AA8','AAN','C00','C05','CAA','CAB','CAS','D06','D07','GM1',
                         'GM2','HO1','HO3','HO6','HO9','KR7','MUJ','MUU','PKD','PKE','PKF','PKG','PKH',
                         'PKK','PKN','PKO','PKQ','PKR','PKS','PKU','PKX','PKY','PKZ','SI1','SI2','SI3',
                         'SI4','SI5','SI6','W4E','W4F','W4G');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=402 and IDG in (4,16);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=402 and CHKID in (2,5,11);
 commit;
--==============================================================================--
-- ********** 416 - ���������� ��������� ������������� ********** --
--==============================================================================--
-- KREW - ��� ���������� i���������
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=416 and codeapp in ('KREW');
--==============================================================================--
-- ********** 399 - ������� ���� ³������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=399 and codeapp in ('@PPZ','@OST','BIRG','VALB','DPTU','KODZ','SEPN','OTCN','KREB','KART','VIZA',
                              'NACC','@PN2','OPER','KONO','RKO ','@PKK','KRPF');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=399 and TT in ('001','002','00A','00B','00C','00D','00E','00F','00G','00H','010','012','013','014',
                         '015','01A','027','066','067','069','072','073','074','075','085','096','097','100',
                         '101','114','178','310','405','406','445','514','8C2','BM6','BM7','BR1','BR2','BR3',
                         'BR4','BRK','BRP','C00','C10','CV0','CV3','CV7','CV8','CV9','CVO','D06','D07','MM2',
                         'PKR','SMO');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=399 and IDG in (4);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=399 and CHKID in (5);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=399 and KODF in ('27','C9','D3','E2');
--==============================================================================--
-- ********** 367 - ������ ��������� ������������ ********** --
--==============================================================================--
-- KODZ - ��� �������� �����i���
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=367 and codeapp in ('KODZ');
--==============================================================================--
-- ********** 347 - ������ ������ ���������� ********** --
--==============================================================================--
-- KODZ - ��� �������� �����i���
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=347 and codeapp in ('KODZ');
--==============================================================================--
-- ********** 745 - ��������� ��������� �������� ********** --
--==============================================================================--
-- @UDT - ��� ������������ ����������� ������
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=745 and codeapp in ('@UDT');
-- update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
-- where idu=745 and IDG in (32);
--==============================================================================--
-- ********** 576 - ��������� ����� �������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=576 and codeapp in ('ICCK','WIKD','BIRZ','@PTZ','VALB','WCAS','LCS1');
 commit;
--==============================================================================--
-- ********** 181 - �������� ������� �������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=181 and codeapp in ('DRU1','OTCN','MANY','@INP','PRVN');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=181 and IDG in (19);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=181 and KODF in ('07','20','48','84','95','E1');
 commit;
--==============================================================================--
-- ********** 293 - ϳ������ ������� ������������ ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=293 and codeapp in ('@UPR','REGK','FMON');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=293 and IDG in (17,38);
 commit;
--==============================================================================--
-- ********** 600 - ϳ��� ����� ������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=600 and codeapp in ('@ROP','KREF','KREW','WCSM');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=600 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 529 - ������� ������ ����� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=529 and codeapp in ('@BPB','@WF3','@WF2','@WF1','BVBB','AVVV','@VAL','DRU1','SEPN','OTCN','DPAZ',
                              '@BDK','@ONE','@ILI','VIZA','@VPS','@GU1','@PN2','@M11','@EGB','@PKK');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=529 and TT in ('012','013','014','015','060','096','101','114','514','807','824','830','839',
                         '854','8C0','8C2','C00','C02','C06','C10','C11','C12','C14','CLI','CVB','CVE',
                         'CVO','CVS','D06','D07','D66','D90','D91','SMO');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=529 and IDG in (23);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=529 and CHKID in (2,5,11,22,27,50,60,70,71);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=529 and KODF in ('26','B5','B6','C9','D4','D6','E2','S6','S7');
 commit;
--==============================================================================--
-- ********** 407 - �������� ������ ������������ ********** --
--==============================================================================--
-- begin
--   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
--     values (407, 'WCSM', to_date('01/01/2016','DD/MM/YYYY'), to_date('31/12/2016','DD/MM/YYYY'), 1, 1);
--   exception when OTHERS then null;
-- end;
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=407 and codeapp in ('AUSP','KRED','KREW','MANY');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=407 and IDG in (20);
 commit;
--==============================================================================--
-- ********** 102 - �������� ���� ������������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=102 and codeapp in ('@PPZ','@UDG','@PLD','VNOT','@CP1','OTCN','CRPC','CHIF','TEHA','@ECH');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=102 and IDG in (32);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=102 and KODF in ('01','02','05','06','08','09','10','11','12','14','15','16','17','18','19','21','22','25','28','29','30','31','32','33','37','38','3A','40','41','42','43','45','46','47','49','4A','54','71','72','74','75','76','77','78','80','81','83','85','88','89','8B','90','93','96','97','A0','A4','A7','A8','A9','B0','C5','D2','F4','S6','S7');
 commit;
--==============================================================================--
-- ********** 503 - ���������� ��������� ������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=503 and codeapp in ('BIRD','@VAL','DRUO','@BDK','KONS','VIZA','KRES','NACC','@PN2','OPER','@ERI','@EGB','@PKK');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=503 and TT in ('013','014','015','096','310','807','817','818','830','8C0','C04','D06','D07','F01','F10','FXE');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=503 and IDG in (19);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=503 and CHKID in (2,5,11,17,20,74,75);
 commit;
--==============================================================================--
-- ********** 211 - ��������� ������ �����볿��� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=211 and codeapp in ('BIRD','DRU1','@UPR','KAZN');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=211 and IDG in (19);
 commit;
--==============================================================================--
-- ********** 248 - ������� ���� ��������� ********** --
--==============================================================================--
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=248 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 459 - ��������� ���� �������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=459 and codeapp in ('ACBO','WIKD','WCAS','VIZA','@GU1','@PN2','OPER','WDOC');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=459 and TT in ('039','068','069','193','225','TOC','TOH','TOK','TOL','TOO','TOP','TOX');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=459 and IDG in (55);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=459 and CHKID in (1,2,4,5);
 commit;
--==============================================================================--
-- ********** 777 - ������ ����� ���������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=777 and codeapp in ('VIZA');
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=777 and CHKID in (40);
 commit;
--==============================================================================--
-- ********** 618 - ������ ������ ����������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=618 and codeapp in ('OWAY','BPKB','WDOC');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=618 and IDG in (16);
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=618 and IDG in (52);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=618 and CHKID in (5);
--==============================================================================--                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
-- ********** 357 - ��������� ˳�� �����  ********** --                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
--==============================================================================--                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
 where id=357 and codeapp in ('ANKL','AUSP','@ROP','KREF','KREW','OVER','PRAH','DROB');                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
 where idu=357 and IDG in (33);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
 commit;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
--==============================================================================--
-- ********** 350 - ��������� ������ ������������ ********** --
--==============================================================================--
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (350, 'PRVN', BeginOfYear, EndOfYear, 1, 1);
   exception when OTHERS then null;
 end;
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=350 and codeapp in ('WCIG','ANKL','ANI1','AUSP','BIRZ','VNOT','DPTU','DRU1','CRPC','@ROP','KREF','OVER','OPER','PRAH','RKO ','DROB','REGK','REZR','FIN2','MANY');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=350 and IDG in (33);
-- update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=350 and KODF in ('3B','A7');
 commit;
--==============================================================================--
-- ********** 253 - ����������� �������  �������  ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=253 and codeapp in ('DRU1','DRUO');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=253 and IDG in (19);
 commit;
--==============================================================================--
-- ********** 513 - �������� ǳ���� �������� ********** --
--==============================================================================--
-- AUSP - ��� ����� ������������i�
-- DRU1 - ��� ���� ���� 
-- METO - ��� ����������
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=513 and codeapp in ('AUSP','DRU1','METO');
-- update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
-- where idu=513 and IDG in (10,171);
--==============================================================================--
-- ********** 66 - ��������� ����� ������������ ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=66 and codeapp in ('@PPZ','@OST','DPUA','ANKL','ANI1','AUSP','BIRG','W_W4','AVVV','VALB','@NR ',
                             'VNOT','DPTU','DRU1','SEPN','OTCN','DPAZ','KART','@ILI','KONS','VIZA','CRPC',
                             'KREF','NACC','@GU1','KLPA','OVER','OPER','KONO','RKO ','KAZN','@M11','@EGU',
                             'WRCA','@PKK','KRPF');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=66 and TT in ('001','002','00A','00B','00C','00D','00E','00F','00G','00H','010','012','013','014',
                        '015','01A','03C','066','067','069','072','073','074','075','085','096','100','101',
                        '114','178','310','405','406','445','514','8C2','BM6','BM7','BR1','BR2','BR3','BR4',
                        'BRK','BRP','C10','CV0','CV3','CV7','CV8','CV9','CVO','D06','D07','D66','MM2','PKR',
                        'SMO','SNO');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=66 and IDG in (4);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=66 and CHKID in (2,3,5,11,17,20,22,35,62,70);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=66 and KODF in ('1A','27','2E','C9','D3','E2','E8');
 commit;
--==============================================================================--
-- ********** 538 - ��������� ������ ����� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=538 and codeapp in ('@BPB','WLCS','W_W4','@PKP','WDPT','DPAZ','WNER','@PN2','WDOC','@EGF','WEBP','@PKK');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=538 and TT in ('007','012','013','014','021','025','026','027','028','02A','033','045','048','077',
                         '07A','096','114','207','215','310','406','410','411','412','413','414','439','827',
                         '828','A05','A16','A17','AA3','AA4','AA7','AA8','AAN','C05','CAA','CAB','CAS','CVB',
                         'CVO','CVS','D06','D07','HO1','HO3','HO6','HO9','KR7','MUJ','MUU','PKD','PKE','PKF',
                         'PKG','PKH','PKK','PKN','PKQ','PKR','PKU','PKX','PKY','PKZ','W4E','W4F','W4G');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=538 and IDG in (4,6);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=538 and CHKID in (5);
 commit;
--==============================================================================--
-- ********** 711 - ��������� ��� �������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=711 and codeapp in ('@BPB','WLCS','WVIP','BIRG','W_W4','@PKP','WDPT','AUDI','OTCN','DPKK',
                              'WNER','@PN2','WDOC','@EGF','STO1','WEBP','@PKK');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=711 and TT in ('007','008','012','013','014','015','016','017','021','027','028',
                         '02A','033','045','048','077','07A','096','206','207','215','310','401',
                         '402','403','404','406','409','410','411','412','413','414','439','827','8C0',
                         '8C2','AA3','AA4','AA7','AA8','AAB','AAN','C05','CAA','CAB','CAS','CVB','CVO',
                         'CVS','D06','D07','HO1','HO3','HO6','HO9','KR7','MUJ','MUU','PKD','PKE','PKF',
                         'PKG','PKH','PKK','PKN','PKQ','PKR','PKS','PKT','PKU','PKX','PKY','PKZ','W4E','W4F','W4G');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=711 and IDG in (6);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=711 and CHKID in (2,5,11);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=711 and KODF in ('C9','E2');
 begin
 insert into STAFF_KLF00 (id, kodf, a017, adate1, adate2, approve, grantor)
   values (711, 'F1', 'C', to_date('01/01/2016','DD/MM/YYYY'), to_date('31/12/2016','DD/MM/YYYY'), 1, 1);
   exception when OTHERS then null;
 end;
commit;
--==============================================================================--
-- ********** 451 - �������� ���� ���������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=451 and codeapp in ('OWAY','BPKB','WDOC');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=451 and IDG in (16);
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=451 and IDG in (52);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=451 and CHKID in (5);
 commit;
--==============================================================================--
-- ********** 62 - ��������� ������� �������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=62 and codeapp in ('KREA','DPUA','BIRG','W_W4','AVVV','VALB','DPTU','SEPN','OTCN','DPAZ',
                             'VIZA','CRPC','NACC','@GU1','KLPA','OPER','RKO ','@EGU','WRCA');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=62 and TT in ('001','002','00A','00B','00C','00D','00E','00F','00G','00H','013','014','015',
                        '01A','027','096','097','100','101','114','178','404','405','406','409','8C2',
                        'BR1','BR2','BR3','BR4','BRK','C00','C10','CFB','CFO','CFS','CV0','CV3','CV7',
                        'CV8','CV9','CVB','CVO','CVS'/*,'D06','D07','D66','MM2','PKR','SMO'*/);
-- update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
-- where idu=62 and IDG in (4);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=62 and CHKID in (2,3,5,11,17,22);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=62 and KODF in ('1A','27','2E','C9','D1','D3','E2','E8');
 commit;
--==============================================================================--
-- ********** 60 - ������ ��� ����������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=60 and codeapp in ('ICCK','ANI1','AUSP','AVVV','VALB','@NR ','AVTO','BAK1','VNOT','BUHG',
                             'DRU1','OTCN','@MPS','VIZA','METO','NALS','NALY','REGK','REZR','REZW',
                             '@PKK','MANY','PRVN');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=60 and IDG in (32,200);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=60 and CHKID in (2,10,11,16,17,24,34,94);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=60 and KODF in ('01','11','25','30','78','A7','E0');
 commit;
--==============================================================================--
-- ********** 295 - �������� ������ ������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=295 and codeapp in ('ANI1','KAZN');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=295 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 611 - ���� �������� ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=611 and codeapp in ('KREW');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=611 and IDG in (10);
 commit;
--==============================================================================--
-- ********** 397 - ����� ³����� ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=397 and codeapp in ('OWAY','OBPC','ARGK','BIRZ','BPKI','BPKE','BPKB','@PKP','BVBB','AVVV',
                              'VALB','BAK1','WDPT','VNOT','OTCN','DPAZ','@BDK','VIZA','WOPR','KRED',
                              'KRIF','OVER','OPER','BPKR','@M11','@EGF','@PKK','ZAP ','FIN2','MANY');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=397 and IDG in (19);
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=397 and IDG in (32);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=397 and CHKID in (2,5,11,16,17,22,23,24,38,39,41,74,75,94);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=397 and KODF in ('C9','D3','D8');
--==============================================================================--
-- ********** 18 - �������� ���� ������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=18 and codeapp in ('OWAY','BPKZ','BVB ','BUHG','DRU1','VIZA','OPER','@EGG','@EGF','STO1','@IPV');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=18 and TT in ('013','015','029','060','096','108','109','110','111','420','438','444','805','806',
                        'D07','D66','PKA','PKO','PKR','PKS','PKV','PKX');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=18 and IDG in (172,200);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=18 and CHKID in (2,5,11);
 commit;
--==============================================================================--
-- ********** 65 - �������� ������� ������� ********** --
--==============================================================================--
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (65, 'BIRG', BeginOfYear, EndOfYear, 1, 1);
   exception when OTHERS then null;
 end;
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=65 and codeapp in ('WLCS','PENS','OBPC','AUSP','W_W4','@PKP','WDPT','DPKK','VIZA','WOPR','WNER',
                             '@PN2','WDOC','@EGF','STO1','WEBP','@PKK');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=65 and TT in ('007','012','013','014','016','017','021','025','026','027','028','02A','033','045',
                        '048','077','07A','089','096','114','207','215','310','401','402','403','406','407',
                        '409','410','411','412','413','414','807','827','828','830','8C0','8C2','A05','A16',
                        'A17','AA3','AA4','AA7','AA8','AAN','B27','B28','C00','C05','CAA','CAB','CVB','CVO',
                        'CVS','D06','D07','HO1','HO3','HO6','HO9','KR7','MUJ','MUU','PKD','PKE','PKF','PKG',
                        'PKH','PKK','PKN','PKO','PKQ','PKR','PKS','PKU','PKX','PKY','PKZ','W4E','W4F','W4G');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=65 and IDG in (4);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=65 and CHKID in (2,5);
 commit;
--==============================================================================--
-- ********** 526 - ������� ����� �������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=526 and codeapp in ('RZBS');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=526 and IDG in (15);
 commit;
--==============================================================================--
-- ********** 502 - ������ ����� ����������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=502 and codeapp in ('DRU1','OTCN','@UPR','KAZN');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=502 and IDG in (32);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=502 and KODF in ('A7');
 commit;
--==============================================================================--
-- ********** 609 - ��������� ������� ³������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=609 and codeapp in ('ANI1');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=609 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 349 - ��������� ��� �����������  ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=349 and codeapp in ('WCIG','AUSP','KREF','KREW','OVER','PRAH');
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (349, 'PRVN', to_date('01/01/2016','DD/MM/YYYY'), to_date('31/12/2016','DD/MM/YYYY'), 1, 1);
   exception when OTHERS then null;
 end;
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=349 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 444 - ������� ����� ����������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=444 and codeapp in ('@UDG','KREW');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=444 and IDG in (10);
 commit;
--==============================================================================--
-- ********** 252 - ������ ��������� ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
  where id=252 and codeapp in ('BIRV','BIRZ','@PTZ','VALB','WCIM','@PUP','OTCN','AN01','VIZA');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=252 and IDG in (4,31);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=252 and CHKID in (2,7,37);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=252 and KODF in ('1A','27','2D','70','C9','D3','E2');
 commit;
--==============================================================================--
-- ********** 368 - ����� ���������� ������������ ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=368 and codeapp in ('ANI1');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=368 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 466 - ������� ����� ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=466 and codeapp in ('WCIG','KREA','AUSP','OTCN','KREF','KREW','OVER','PRAH','DROB','MANY','PRVN');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=466 and IDG in (33);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=466 and KODF in ('3B');
 commit;
--==============================================================================--
-- ********** 348 - ������� ����� ���������  ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=348 and codeapp in ('ANKL','AUSP','@ROP','KREF','KREW','OVER','PRAH','DROB');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=348 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 167 - �������� ����� �������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=167 and codeapp in ('@UPR','KAZN');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=167 and IDG in (19);
 commit;
--==============================================================================--
-- ********** 557 - �������� ����� ����������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=557 and codeapp in ('@BPB','WLCS','PENS','DPTA','AUSP','BIRG','WBPK','W_W4','AVTO','WDPT','AUDI',
                              'OTCN','DPAZ','@ILI','VIZA','WOPR','@D88','@GU1','WNER','@PN2','OPER','WDOC',
                              '@EGF','STO1','WEBP','@PKK');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=557 and TT in ('007','008','009','012','013','014','015','016','017','021','025','026','027',
                         '028','02A','033','045','048','077','079','07A','089','096','114',
                         '205','207','215','310','401','402','403','404','406','407',
                         '409','410','411','412','413','414','439','827','828','A05','A16','A17','AA3',
                         'AA4','AA7','AA8','AAN','C05','CAA','CAS','CVB','CVO','CVS','D06','D07','GM1',
                         'GM2','HO1','HO3','HO6','HO9','KR7','M37','MUJ','MUU','PKD','PKE','PKF','PKG',
                         'PKH','PKK','PKN','PKQ','PKR','PKS','PKU','PKX','PKY','PKZ','SI1','SI2','SI3',
                         'SI4','SI5','SI6','W4E','W4F','W4G');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=557 and IDG in (4);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=557 and CHKID in (2,5);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=557 and KODF in ('F1');
 commit;
--==============================================================================--
-- ********** 616 - ������ ������ ������������ ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=616 and codeapp in ('BVBB','@VAL','VALB','DRU1','SEPN','OTCN','@WKZ','@BDK','SWAP','VIZA',
                              'OPER','KAZN','REGB','@EGB','@EGU','@PKK','MANY','PRVN');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=616 and TT in ('010','012','013','014','015','060','096','807','813','814','817','818',
                         '830','C04','CV6','CV7','CV9','D06','D07','D66','F01','F02','F10','FX9',
                         'FXE','FXV','FXW','SW0','SW4','V07');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=616 and IDG in (19);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=616 and CHKID in (2,5,17,22,74,75);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=616 and KODF in ('2A','2G','35','6A','70','79','C9','D3','D5','D6','D8','E2','E8','S6');
 commit;
--==============================================================================--
-- ********** 169 - ������� ��������� ����������� ********** --
--==============================================================================--
-- ANI1 - ��� �������� �������
-- @UPR - ��� ����+FOREX (��������)
-- KAZN - ��� ����������� ������������
-- CPRO - ��� ֳ�� ������ (��������)
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=169 and codeapp in ('ANI1','@UPR','KAZN','CPRO');
-- update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
-- where idu=169 and IDG in (14);
--==============================================================================--
-- ********** 521 - ���� ���������� ������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=521 and codeapp in ('WLCS','PENS','OBPC','AUSP','WBPK','W_W4','@PKP','WDPT','@ILI','DPKK',
                              'VIZA','WOPR','WNER','@PN2','WDOC','@EGG','@EGF','@EGU','STO1','WEBP','@PKK');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=521 and TT in ('007','012','013','014','016','017','021','025','026','027','028','02A','033','045',
                         '048','049','077','079','07A','089','096','114','207','215','310','401','402','403',
                         '406','407','410','411','412','413','414','439','827','828','A05','A16','A17','AA3',
                         'AA4','AA7','AA8','AAN','C05','CAS','CVB','CVO','CVS','D06','D07','HO1','HO3','HO6',
                         'HO9','KR7','MUJ','MUU','PKD','PKE','PKF','PKG','PKH','PKK','PKN','PKO','PKQ','PKR',
                         'PKS','PKU','PKX','PKY','PKZ','W4E','W4F','W4G');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=521 and IDG in (4,6);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=521 and CHKID in (2,5);
 commit;
--==============================================================================--
-- ********** 590 - ����� ������ ��������� ********** --
--==============================================================================--
-- WLCS - ��� Limit Control System
-- WADM - ��� ������������ BarsWeb (WEB)
-- MAIN - ��� ������������ ���
-- @PLD - ��� ������������ �����
-- DRU1 - ��� ���� ���� 
-- DPAZ - ��� ������� �� ���  @F
-- CTRV - ��� ������ ������ (�������� ��'���� � ��������)
-- @PKK - ��� ��� ����� ������ �� ���'�������� ���
-- ZAP  - ��� ���. ����������� ������ (WEB)
-- @CLI - ��� �������� �볺��-����
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=590 and codeapp in ('WLCS','WADM','MAIN','@PLD','DRU1','DPAZ','CTRV','@PKK','ZAP ','@CLI');
-- update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
-- where idu=590 and IDG in (4,14,15,19,20,23,24,31,32,33,43);
--==============================================================================--
-- ********** 461 - �������� ���� �������� ********** --
--==============================================================================--
-- KREW - ��� ���������� i���������
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=461 and codeapp in ('KREW');
--==============================================================================--
-- ********** 536 - ��������� ������ ����� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=536 and codeapp in ('ANI1');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=536 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 307 - ������� ����� ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=307 and codeapp in ('@UDG','@UPR','PRAH','KAZN');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=307 and IDG in (19);
 commit;
--==============================================================================--
-- ********** 547 - �������� ������ ³��볿��� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=547 and codeapp in ('@BPB','WLCS','WVIP','ANI1','AUSP','BIRG','WBPK','W_W4','@PKP','@MET','AVVV',
                              'VALO','VALB','AVTO','WDPT','WRUK','@ILI','KONS','DPKK','VIZA','WOPR','@GU1',
                              'WNER','@PN2','OPER','WDOC','@EGF','STO1','WEBP','@PKK','@HEK');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=547 and TT in ('007','008','009','012','013','014','015','016','017','021','025','026','027','028',
                         '02A','033','038','045','048','056','057','077','07A','096','107','112','113','114',
                         '115','116','121','123','125','127','130','132','133','136','140','142','175','201',
                         '202','207','214','215','310','401','402','403','404','406','407','409','410','411',
                         '412','413','414','827','830','A05','A16','A17','A18','AA0','AA3','AA4','AA7','AA8',
                         'AAB','AAN','B27','B28','BM6','BM7','C05','CAA','CAB','CAS','CV7','CV8','CV9','CVB',
                         'CVO','CVS','D06','D07','HO1','HO3','HO6','HO9','KR7','MOA','MOB','MOF','MON','MUJ',
                         'MUU','PKD','PKE','PKF','PKG','PKH','PKK','PKN','PKQ','PKR','PKS','PKU','PKX','PKY',
                         'PKZ','SI1','SI2','SI3','SI6','SMO','TOA','TOB','TOL','TOX','TUJ','TUL','TUT','W4E','W4F','W4G');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=547 and IDG in (4,6);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=547 and CHKID in (2,5,17);
-- update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=547 and KODF in ('C9','E2');
 commit;
--==============================================================================--
-- ********** 64 - ������� ������� ³��볿��� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=64 and codeapp in ('KAZN','UPRA');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=64 and IDG in (19);
 commit;
--==============================================================================--
-- ********** 101 - ����� ����� ����������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=101 and codeapp in ('OBPC','IADM','@CLI');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=101 and IDG in (1);
 commit;
--==============================================================================--
-- ********** 173 - ������� �������� ����� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=173 and codeapp in ('DRU1','DRUO','@EGB');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=173 and IDG in (19);
 commit;
--==============================================================================--
-- ********** 320 - ��������� ������ ³�������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=320 and codeapp in ('REGK','FMON');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=320 and IDG in (38);
 commit;
--==============================================================================--
-- ********** 198 - ��������� ������� ������������ ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=198 and codeapp in ('ANKL','@UDG','DRU1');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=198 and IDG in (14);
 commit;
--==============================================================================--
-- ********** 389 - �������� ������ ������� ********** --
--==============================================================================--
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (389, 'PRVN', to_date('01/01/2016','DD/MM/YYYY'), to_date('31/12/2016','DD/MM/YYYY'), 1, 1);
   exception when OTHERS then null;
 end;
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=389 and codeapp in ('WCIG','ANKL','ANI1','AUSP','BIRZ','VNOT','DPTU','DRU1','CRPC','@ROP','KREF',
                              'OVER','OPER','PRAH','RKO ','DROB','REGK','REZR','FIN2','MANY');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=389 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 114 - �������� ������ ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=114 and codeapp in ('IADM','@CLI','TKLB');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=114 and IDG in (1);
 commit;
--==============================================================================--
-- ********** 735 - ��������� ³���� ������� ********** --
--==============================================================================--
-- @UDT - ��� ������������ ����������� ������
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=735 and codeapp in ('@UDT');
-- update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
-- where idu=735 and IDG in (32);
--==============================================================================--
-- ********** 585 - ������� ������ �������� ********** --
--==============================================================================--
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (585, 'PRVN', to_date('01/01/2016','DD/MM/YYYY'), to_date('31/12/2016','DD/MM/YYYY'), 1, 1);
   exception when OTHERS then null;
 end;
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (585, 'DRU1', to_date('01/01/2016','DD/MM/YYYY'), to_date('31/12/2016','DD/MM/YYYY'), 1, 1);
   exception when OTHERS then null;
 end;
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=585 and codeapp in ('WCIG','AUSP','KREF','KREW','OVER','PRAH','MANY');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=585 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 359 - ������� ��� �������  ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=359 and codeapp in ('WCIG','AUSP','DRU1','KREF','KREW','OVER','PRAH','MANY');
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (359, 'ICCK', to_date('01/01/2016','DD/MM/YYYY'), to_date('31/12/2016','DD/MM/YYYY'), 1, 1);
   exception when OTHERS then null;
 end;
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (359, 'PRVN', to_date('01/01/2016','DD/MM/YYYY'), to_date('31/12/2016','DD/MM/YYYY'), 1, 1);
   exception when OTHERS then null;
 end;
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=359 and IDG in (33);
--==============================================================================--
-- ********** 338 - ������ ������� ���������  ********** --
--==============================================================================--
-- WCIG - ��� I�������� � ����I
-- AUSP - ��� ����� ������������i�
-- DRU1 - ��� ���� ���� 
-- OTCN - ��� ������� ���
-- KREF - ��� ������� ��
-- KREW - ��� ���������� i���������
-- OVER - ��� ����������
-- PRAH - ��� �������� ������ �볺��� � �������
-- MANY - ��� ���������� ���������� �����
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=338 and codeapp in ('WCIG','AUSP','DRU1','OTCN','KREF','KREW','OVER','PRAH','MANY');
-- update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
-- where idu=338 and IDG in (171);
-- update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
-- where idu=338 and IDG in (33);
-- update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=338 and KODF in ('D5','D8','D9','F6','F7','F8','F9');
--==============================================================================--
-- ********** 549 - �������� ���� ������������ ********** --
--==============================================================================--
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (65, 'BIRG', BeginOfYear, EndOfYear, 1, 1);
   exception when OTHERS then null;
 end;
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=549 and codeapp in ('WLCS','PENS','AUSP','W_W4','@PKP','WDPT','DPKK','WNER','@PN2','WDOC','@EGF','STO1','WEBP','@PKK');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=549 and TT in ('007','008','009','012','013','014','016','017','021','025','026','027','028','02A',
                         '033','045','048','077','07A','089','096','114','207','215','310','401','402','403',
                         '406','410','411','412','413','414','827','828','830','A05','A16','A17','AA3','AA4',
                         'AA7','AA8','AAN','C05','CAA','CVB','CVO','CVS','D06','D07','HO1','HO3','HO6','HO9',
                         'KR7','MUJ','MUU','PKD','PKE','PKF','PKG','PKH','PKK','PKN','PKO','PKQ','PKR','PKS',
                         'PKU','PKX','PKY','PKZ','W4E','W4F','W4G');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=549 and IDG in (4);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=549 and CHKID in (5);
 commit;
--==============================================================================--
-- ********** 594 - ������� ������ ³������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=594 and codeapp in ('WCIG','AUSP','DRU1','KREF','KREW','OVER','PRAH');
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (594, 'PRVN', to_date('01/01/2016','DD/MM/YYYY'), to_date('31/12/2016','DD/MM/YYYY'), 1, 1);
   exception when OTHERS then null;
 end;
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=594 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 377 - ��������� ������� ³��볿��� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=377 and codeapp in ('@PPZ','@OST','BIRG','VALB','DPTU','KODZ','OTCN','KRET','KART','VIZA','NACC',
                              '@PN2','OPER','PRAH','KONO','RKO ','@PKK','KRPF');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=377 and TT in ('001','002','00A','00B','00C','00D','00E','00F','00G','00H','010','012','013','014',
                         '015','01A','027','03C','066','067','069','072','073','074','075','085','096','100',
                         '101','114','178','310','405','445','514','8C2','BM6','BM7','BR1','BR2','BR3','BR4',
                         'BRK','CVO','D06','D07','D66','MM2','PKD','PKR','SMO','BRP');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=377 and IDG in (4);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=377 and CHKID in (5);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=377 and KODF in ('27','C9','D3','E2');
 commit;
--==============================================================================--
-- ********** 360 - ��������� ������ ³������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=360 and codeapp in ('@ROP','KREF','KREW','WCSM');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=360 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 267 - ��������� ������� �������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=267 and codeapp in ('WCIG','ICCK','WIKD','KREA','AUSP','KREF','KREW','OVER','PRAH');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=267 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 289 - ��������� ������ ³������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=289 and codeapp in ('ANKL','ANI1','@UDG','DRU1');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=289 and IDG in (14);
 commit;
--==============================================================================--
-- ********** 88 - ��������� ��������� �������  ********** --
--==============================================================================--
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (88, 'DRU1', BeginOfYear, EndOfYear, 1, 1);
   exception when OTHERS then null;
 end;
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (88, 'PRVN', BeginOfYear, EndOfYear, 1, 1);
   exception when OTHERS then null;
 end;
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=88 and codeapp in ('WCIG','ICCK','AUSP','KREF','KREW','OVER','PRAH','MANY');
-- update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
-- where idu=88 and IDG in (171);
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=88 and IDG in (33);
-- update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=88 and KODF in ('D5','D8','D9','F6','F7','F8');
--==============================================================================--
-- ********** 406 - �������� ����� ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=406 and codeapp in ('VNOT','OPER','@EGG','@EGF','@PKK');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=406 and TT in ('013','015','029','060','096','108','109','110','111','224','302','420','438','444',
                         '445','805','806','D07','D66','PKA','PKO','PKR','PKS','PKV');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=406 and IDG in (172);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=406 and CHKID in (5);
 commit;
--==============================================================================--
-- ********** 183 - ������ ���� ���������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=183 and codeapp in ('ANI1');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=183 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 343 - ��������� ����� ������� ********** --
--==============================================================================--
-- update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
-- where idu=343 and IDG in (55);
--==============================================================================--
-- ********** 469 - ����� ��������� ����������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=469 and codeapp in ('@ROP','KREW');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=469 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 373 - ���������� ������ �������������  ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=373 and codeapp in ('@UDG','KRED','KREF','MANY');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=373 and IDG in (14);
 commit;
--==============================================================================--
-- ********** 184 - ����������� ˳�� ������������ ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=184 and codeapp in ('@UDG','KRED','KREF','MANY');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=184 and IDG in (14);
 commit;
--==============================================================================--
-- ********** 619 - ��������� ����� ������������ ********** --
--==============================================================================--
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (619, 'PRVN', BeginOfYear, EndOfYear, 1, 1);
   exception when OTHERS then null;
 end;
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (619, 'DRU1', BeginOfYear, EndOfYear, 1, 1);
   exception when OTHERS then null;
 end;
 begin
   insert into APPLIST_STAFF (id, codeapp, adate1, adate2, approve, grantor)
     values (619, 'MANY', BeginOfYear, EndOfYear, 1, 1);
   exception when OTHERS then null;
 end;
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=619 and codeapp in ('WCIG','AUSP','KREF','KREW','OVER','PRAH');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=619 and IDG in (33);
 commit;
-- update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=619 and KODF in ('3B');
--==============================================================================--
-- ********** 155 - Գ������� ����� �����볿��� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=155 and codeapp in ('BVBB','@DCP','DRU1','OTCN','@BDK','VIZA','NACC','OPER','@EGB','@EGU','@PKK','UPRA','MANY','@INP','PRVN');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=155 and TT in ('012','013','014','015','060','096','100','114','310','807','830','8C3','C04','D06',
                         'D07','F10','F80','PO1','SW4','SW5');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=155 and IDG in (19);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=155 and CHKID in (2,5,17,24,39,41,74,75);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=155 and KODF in ('07','20','84','E1');
--==============================================================================--
-- ********** 6 - ������ ³�� ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=6 and codeapp in ('ANI1','BIRD','BIRZ','BIRG','BVBB','@VAL','DRU1','DRUO','@BDK',
                            'KONS','VIZA','KRES','CRES','NACC','@PN2','OPER','@EGB','@EGU','@PKK');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=6 and TT in ('013','014','015','096','310','807','817','818','830','8C0','C04','D06',
                       'D07','F01','F10','FXE');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=6 and IDG in (19);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=6 and CHKID in (2,5,11,17,20,24,39,41,74,75);
 commit;
--==============================================================================--
-- ********** 504 - ��������� ������ ���������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=504 and codeapp in ('IADM','@CLI','TKLB');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=504 and IDG in (1);
 commit;
--==============================================================================--
-- ********** 540 - ����������� ĳ�� ����������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=540 and codeapp in ('WLCS','BIRV','BIRZ','@PTZ','VALB','WCIM','@PUP','OTCN','AN01','VIZA');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=540 and IDG in (4,31);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=540 and CHKID in (2,7,37);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=540 and KODF in ('1A','27','2C','2D','35','36','6A','70','C9','D3','E2');
 commit;
--==============================================================================--
-- ********** 473 - ����� ˳�� �������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=473 and codeapp in ('OWAY');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=473 and IDG in (16);
 commit;
--==============================================================================--
-- ********** 486 - �������� ������ �������� ********** --
--==============================================================================--
-- KREW - ��� ���������� i���������
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=486 and codeapp in ('KREW');
-- update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
-- where idu=486 and IDG in (33);
--==============================================================================--
-- ********** 482 - �������� ������ ������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=482 and codeapp in ('@UDG');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=482 and IDG in (14);
 commit;
--==============================================================================--
-- ********** 462 - �������� ���� �������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=462 and codeapp in ('@BPB','WLCS','WVIP','BIRG','W_W4','@PKP','WDPT','OTCN','DPKK','WOPR','WNER',
                              '@PN2','WDOC','@EGF','STO1','WEBP','@PKK');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=462 and TT in ('007','012','013','014','016','017','021','027','028','02A',
                         '033','045','048','049','077','07A','096','207','215','310','401','402',
                         '403','404','406','407','409','410','411','412','413','414','827','AA3',
                         'AA4','AA7','AA8','AAB','AAN','C05','CAA','CAB','CAS','CVB','CVO','CVS',
                         'D06','D07','HO1','HO3','HO6','HO9','KR7','MUJ','MUU','PKD','PKE','PKF',
                         'PKG','PKH','PKK','PKN','PKQ','PKR','PKS','PKU','PKX','PKY','PKZ','W4E','W4F','W4G');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=462 and IDG in (6);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=462 and CHKID in (2,5,11);
 commit;
--==============================================================================--
-- ********** 613 - ������ ����� ���������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=613 and codeapp in ('ANKL','ANI1','BIRZ','DPTU','CRPC','@ROP','KREF','KREW','OVER','OPER','PRAH','RKO ','DROB','REGK','FIN2');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=613 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 37 - ������ ��������� ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=37 and codeapp in ('WCIG','PENS','ICCK','WIKD','OWAY','OBPC','ARGK','DPTA','AUSP','BIRZ',
                             'W_W4','BPKI','BPKE','BPKB','@PKP','BPKZ','BVBB','AVVV','VALB','AVTO',
                             'WDPT','VNOT','DPTU','DRU1','OTCN','DPAZ','KREV','@ILI','KONS','VIZA',
                             'KRED','KRIF','KREF','KREW','NACC','WNER','WREQ','KLPA','OVER','@PN2',
                             'OPER','WDOC','WKBO','BPKR','WGRT','WINS','REGB','@EGG','@EGF','@EGU',
                             '@PKK','FIN2','MANY','PRVN');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=37 and TT in ('007','010','012','013','014','015','060','096','114','210','215','301','310','315',
                        '496','497','514','830','8C2','961','962','963','964','A18','C10','CFB','CFO','CFS',
                        'CV8','D06','D07','D66','MUU','PKA','PKD','PKE','PKF','PKG','PKH','PKK','PKN','PKQ',
                        'PKR','PKS','PKT','PKU','PKV','PKX','PKY','PKZ','W41','W42','W4E','W4F','W4G');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=37 and IDG in (4,16,17,20);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=37 and CHKID in (2,5,11,16,17,22,23,38,94);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=37 and KODF in ('1A','C9','D3','D8','E9');
 commit;
--==============================================================================--
-- ********** 176 - ���������� ������ ������������ ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=176 and codeapp in ('ANI1');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=176 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 310 - ������� ���� ���㳿��� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=310 and codeapp in ('@BPB','BIRV','BIRZ','VALB','WCIM','@KPK','@PUP','OTCN','VIZA');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=310 and IDG in (4,31);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=310 and CHKID in (2,7,37);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=310 and KODF in ('1A','2D','70','C9','D3','E2');
 commit;
--==============================================================================--
-- ********** 217 - ���������� ����� ³������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=217 and codeapp in ('@VAL','VALB','DRU1','OTCN','@WKZ','@BDK','SWAP','@PN2','OPER','KAZN','REGB','@EGB','@PKK','PRVN');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=217 and TT in ('012','013','014','015','060','096','807','813','814','817','818','830','C04','CV7',
                         'CV9','D06','D07','F01','F02','F10','FX9','FXV','FXW','SW0','SW4','V07','V77');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=217 and IDG in (19);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=217 and CHKID in (5);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=217 and KODF in ('2A','35','6A','70','79','C9','D3','E2','E8','S6');
 commit;
--==============================================================================--
-- ********** 574 - ����� ����� ���������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=574 and codeapp in ('@ROP','KREW');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=574 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 554 - ���� ������� ������������ ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=554 and codeapp in ('KAZN','UPRA');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=554 and IDG in (19);
 commit;
--==============================================================================--
-- ********** 436 - ������� ������ ������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=436 and codeapp in ('WCIG','KREA','AUSP','KREF','KREW','OVER','PRAH');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=436 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 569 - ������ ³����� ����� ********** --
--==============================================================================--
-- KREW - ��� ���������� i���������
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=569 and codeapp in ('KREW');
--==============================================================================--
-- ********** 400 - �������� ��������� �������� ********** --
--==============================================================================--
-- ANI1 - ��� �������� �������
-- VNOT - ��� �������� ������� �������� �����
-- OTCN - ��� ������� ���
-- KRED - ��� ������� ��
-- KRIF - ��� ������� �� - I�����������i�
-- KREF - ��� ������� ��
-- PRAH - ��� �������� ������ �볺��� � �������
-- WGRT - ��� �������� �������� ������������
-- WINS - ��� �������� ��������� ��������
-- PA   - ��� �������� ������ (��������)
-- DROB - ��� ����� �����������i�
-- WASA - ��� ������ �� ���������� ������� �� (WEB)
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=400 and codeapp in ('ANI1','VNOT','OTCN','KRED','KRIF','KREF','PRAH','WGRT','WINS','PA  ','DROB','WASA');
-- update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
-- where idu=400 and IDG in (24);
-- update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=400 and KODF in ('4A');
--==============================================================================--
-- ********** 491 - �������� ������� ������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=491 and codeapp in ('@IN ','ICCK','ANI1','AUSP','BPKB','@PKP','AVVV','VALB','AVTO','BUHG','XOZD','DPTU','DRU1','KREB','KONS','DPKK','KRED','KRIF','KREF','METO','OPER','REGK','STO1','KRPF');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=491 and IDG in (32);
 commit;
--==============================================================================--
-- ********** 468 - ������� ����� ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=468 and codeapp in ('@IN ','VIZA');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=468 and IDG in (15);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=468 and CHKID in (46);
 commit;
--==============================================================================--
-- ********** 188 - ������� ³����� ��������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=188 and codeapp in ('@TPF','@WF3','@WF2','VALB','@ONE','VIZA','@PN2','OPER','@ASH','RZBS','@PKK','ZAP ');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=188 and TT in ('013','015','101','301','310','514','807','830','839','849','854',
                         '8C0','8C2','C04','C14','D06','D07','F10','SWD','SWK');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=188 and IDG in (16,23);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=188 and CHKID in (5,16);
 commit;
--==============================================================================--
-- ********** 394 - ������ ��������� ����������� ********** --
--==============================================================================--
-- ANI1 - ��� �������� �������
-- VNOT - ��� �������� ������� �������� �����
-- OTCN - ��� ������� ���
-- KRED - ��� ������� ��
-- KRIF - ��� ������� �� - I�����������i�
-- KREF - ��� ������� ��
-- PRAH - ��� �������� ������ �볺��� � �������
-- WGRT - ��� �������� �������� ������������
-- WINS - ��� �������� ��������� ��������
-- PA   - ��� �������� ������ (��������)
-- DROB - ��� ����� �����������i�
-- WASA - ��� ������ �� ���������� ������� �� (WEB)
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=394 and codeapp in ('ANI1','VNOT','OTCN','KRED','KRIF','KREF','PRAH','WGRT','WINS','PA  ','DROB','WASA');
-- update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
-- where idu=394 and IDG in (24);
-- update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=394 and KODF in ('4A');
--==============================================================================--                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
-- ********** 627 - ������� ����� ������������ ********** --                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
--==============================================================================--                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
 where id=627 and codeapp in ('@BPB','@IN ','ICCK','WIKD','VALB','VNOT','OTCN','WDOC','SKOP','@HEK');                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
 where id=627 and TT in ('012','013','014','015','025','026','036','037','038','039','070','093','096',
                         '114','118','119','139','148','149','163','181','187','188','189','192','193',
                         '203','211','214','223','225','38X','38Y','494','807','845','849','863','864',
                         '8C0','8C2','8C3','8C4','A16','A17','A18','C10','C14','CV9','D06','D07','D66',
                         'F01','F02','F10','FXV','FXW','I10','SW4','TOG','TOK','TOL','TOM','TOO','TOP',
                         'TOU','TOV','TOW','TOX','TUK','TUL','VM1','VM2','VM3','VM4','VM5','VM6','Z13','Z16','Z17');                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
 where idu=627 and IDG in (16,55);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
 where id=627 and CHKID in (5);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
 where id=627 and KODF in ('12','13','39','44','73','94','C6');                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
 commit;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
--==============================================================================--
-- ********** 180 - ����� ����� ���������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=180 and codeapp in ('@ROP','KREW');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=180 and IDG in (33);
 commit;
--==============================================================================--
-- ********** 589 - ���� ����� ������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=589 and codeapp in ('REGK','FMON');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=589 and IDG in (38);
 commit;
--==============================================================================--
-- ********** 700 - ������ ������ ������������ ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=700 and codeapp in ('WIKD','WBPK','WCIM','@NR ','BAK1','VNOT','BUHG','DPTU','@MPS','VIZA',
                              'WOPR','@ROP','WDOC','KAZN','WGRT','WINS','REGK','WRCA','WEBP','@PKK');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=700 and IDG in (6,32);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=700 and CHKID in (40,70,71,74,75);
 commit;
--==============================================================================--
-- ********** 750 - ��������� ����� �����볿��� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=750 and codeapp in ('DRU1','@ROP','@UPR','CPRO');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=750 and IDG in (19);
 commit;
--==============================================================================--
-- ********** 78 - ��������� ����� ������������ ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=78 and codeapp in ('KREA','BIRG','W_W4','VALB','AVTO','VNOT','DPTU','OTCN','DPAZ','KREB','KART',
                             '@OBU','VIZA','CRPC','NACC','@GU1','@PN2','OPER','WDOC','RKO ','@EGU','WRCA','@PKK','KRPF');
 update STAFF_TTS set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=78 and TT in ('001','002','008','00A','00B','00C','00D','00E','00F','00G',
                        '00H','012','013','014','015','01A','027','07A','096','100',
                        '101','114','178','310','404','405','406','409','8C2','BR1',
                        'BR2','BR3','BR4','BRK','BRP','C00','C10','CV0','CV3','CV7',
                        'CV8','CV9','CVB','CVO','CVS','D06','D07','D66','MM2','PKD',
                        'PKR','SMO','BRP');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=7
 where idu=78 and IDG in (4);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=78 and CHKID in (2,3,5,11,17,22);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=78 and KODF in ('27','2E','C9','D1','D3','E2','E8');
 commit;
--==============================================================================--
-- ********** 196 - ������� ������ ������������ ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=196 and codeapp in ('ANI1','DRU1','OTCN','@ROP','@UPR','KAZN','UPRA');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=196 and IDG in (32);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=196 and KODF in ('A7');
 commit;
--==============================================================================--
-- ********** 1013 - ������� ����� ������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=1013 and codeapp in ('PENS','ANI1','AUSP','BIRZ','VALB','@UDT','DPTU','DRU1','OTCN','SWAP','KART',
                               'KONS','KREF','KRES','RKO ','@EGG','TEHA','WEBP','DEVR');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=1013 and IDG in (32);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=1013 and KODF in ('44');
--==============================================================================--
-- ********** 485 - ������ ͳ�� ����� ********** --
--==============================================================================--
-- KREW - ��� ���������� i���������
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=485 and codeapp in ('KREW');
--==============================================================================--
-- ********** 412 - �������� ������ ������������ ********** --
--==============================================================================--
-- KREW - ��� ���������� i���������
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=412 and codeapp in ('KREW');
--==============================================================================--
-- ********** 543 - ������� ����� ������������ ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=543 and codeapp in ('@IN ','VIZA');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=543 and IDG in (15);
 update STAFF_CHK set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=543 and CHKID in (46);
 commit;
--==============================================================================--
-- ********** 105 - ���� ����� ³�������� ********** --
--==============================================================================--
 update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=105 and codeapp in ('@PPZ','@UDG','@PLD','VNOT','@CP1','OTCN','CRPC','CHIF','TEHA','@ECH');
 update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
 where idu=105 and IDG in (32);
 update STAFF_KLF00 set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
 where id=105 and KODF in ('01','02','08','11','25','30','3A','42','4A','78','81','8B','A4','A7','C5','D2','F4');
 commit;
--==============================================================================--
-- ********** 748 - ������ �������� ������������ ********** --
--==============================================================================--
-- @UDT - ��� ������������ ����������� ������
-- update APPLIST_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY')
-- where id=748 and codeapp in ('@UDT');
-- update GROUPS_STAFF set adate1=to_date('01/01/2016','DD/MM/YYYY'), adate2=to_date('31/12/2016','DD/MM/YYYY'), secg=4
-- where idu=748 and IDG in (32);
--==============================================================================
 
COMMIT;
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/TERMS_ACCESS_UPDATE.sql =========*
PROMPT ===================================================================================== 
