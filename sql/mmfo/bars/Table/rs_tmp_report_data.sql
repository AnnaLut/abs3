

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RS_TMP_REPORT_DATA.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RS_TMP_REPORT_DATA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RS_TMP_REPORT_DATA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''RS_TMP_REPORT_DATA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''RS_TMP_REPORT_DATA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RS_TMP_REPORT_DATA ***
begin 
  execute immediate '
  CREATE TABLE BARS.RS_TMP_REPORT_DATA 
   (	ID NUMBER, 
	SESSION_ID NUMBER, 
	DATE_OF_INSERTION DATE DEFAULT sysdate, 
	CHAR00 VARCHAR2(254), 
	CHAR01 VARCHAR2(254), 
	CHAR02 VARCHAR2(254), 
	CHAR03 VARCHAR2(254), 
	CHAR04 VARCHAR2(254), 
	CHAR05 VARCHAR2(254), 
	CHAR06 VARCHAR2(254), 
	CHAR07 VARCHAR2(254), 
	CHAR08 VARCHAR2(254), 
	CHAR09 VARCHAR2(254), 
	CHAR10 VARCHAR2(254), 
	CHAR11 VARCHAR2(254), 
	CHAR12 VARCHAR2(254), 
	CHAR13 VARCHAR2(254), 
	CHAR14 VARCHAR2(254), 
	CHAR15 VARCHAR2(254), 
	CHAR16 VARCHAR2(254), 
	CHAR17 VARCHAR2(254), 
	CHAR18 VARCHAR2(254), 
	CHAR19 VARCHAR2(254), 
	CHAR20 VARCHAR2(254), 
	CHAR21 VARCHAR2(254), 
	CHAR22 VARCHAR2(254), 
	CHAR23 VARCHAR2(254), 
	CHAR24 VARCHAR2(254), 
	CHAR25 VARCHAR2(254), 
	CHAR26 VARCHAR2(254), 
	CHAR27 VARCHAR2(254), 
	CHAR28 VARCHAR2(254), 
	CHAR29 VARCHAR2(254), 
	CHAR30 VARCHAR2(254), 
	CHAR31 VARCHAR2(254), 
	CHAR32 VARCHAR2(254), 
	CHAR33 VARCHAR2(254), 
	CHAR34 VARCHAR2(254), 
	CHAR35 VARCHAR2(254), 
	CHAR36 VARCHAR2(254), 
	CHAR37 VARCHAR2(254), 
	CHAR38 VARCHAR2(254), 
	CHAR39 VARCHAR2(254), 
	CHAR40 VARCHAR2(254), 
	CHAR41 VARCHAR2(254), 
	CHAR42 VARCHAR2(254), 
	CHAR43 VARCHAR2(254), 
	CHAR44 VARCHAR2(254), 
	CHAR45 VARCHAR2(254), 
	CHAR46 VARCHAR2(254), 
	CHAR47 VARCHAR2(254), 
	CHAR48 VARCHAR2(254), 
	CHAR49 VARCHAR2(254), 
	NUM00 NUMBER(36,10), 
	NUM01 NUMBER(36,10), 
	NUM02 NUMBER(36,10), 
	NUM03 NUMBER(36,10), 
	NUM04 NUMBER(36,10), 
	NUM05 NUMBER(36,10), 
	NUM06 NUMBER(36,10), 
	NUM07 NUMBER(36,10), 
	NUM08 NUMBER(36,10), 
	NUM09 NUMBER(36,10), 
	NUM10 NUMBER(36,10), 
	NUM11 NUMBER(36,10), 
	NUM12 NUMBER(36,10), 
	NUM13 NUMBER(36,10), 
	NUM14 NUMBER(36,10), 
	NUM15 NUMBER(36,10), 
	NUM16 NUMBER(36,10), 
	NUM17 NUMBER(36,10), 
	NUM18 NUMBER(36,10), 
	NUM19 NUMBER(36,10), 
	NUM20 NUMBER(36,10), 
	NUM21 NUMBER(36,10), 
	NUM22 NUMBER(36,10), 
	NUM23 NUMBER(36,10), 
	NUM24 NUMBER(36,10), 
	NUM25 NUMBER(36,10), 
	NUM26 NUMBER(36,10), 
	NUM27 NUMBER(36,10), 
	NUM28 NUMBER(36,10), 
	NUM29 NUMBER(36,10), 
	NUM30 NUMBER(36,10), 
	NUM31 NUMBER(36,10), 
	NUM32 NUMBER(36,10), 
	NUM33 NUMBER(36,10), 
	NUM34 NUMBER(36,10), 
	NUM35 NUMBER(36,10), 
	NUM36 NUMBER(36,10), 
	NUM37 NUMBER(36,10), 
	NUM38 NUMBER(36,10), 
	NUM39 NUMBER(36,10), 
	NUM40 NUMBER(36,10), 
	NUM41 NUMBER(36,10), 
	NUM42 NUMBER(36,10), 
	NUM43 NUMBER(36,10), 
	NUM44 NUMBER(36,10), 
	NUM45 NUMBER(36,10), 
	NUM46 NUMBER(36,10), 
	NUM47 NUMBER(36,10), 
	NUM48 NUMBER(36,10), 
	NUM49 NUMBER(36,10), 
	DAT00 DATE, 
	DAT01 DATE, 
	DAT02 DATE, 
	DAT03 DATE, 
	DAT04 DATE, 
	DAT05 DATE, 
	DAT06 DATE, 
	DAT07 DATE, 
	DAT08 DATE, 
	DAT09 DATE, 
	DAT10 DATE, 
	DAT11 DATE, 
	DAT12 DATE, 
	DAT13 DATE, 
	DAT14 DATE, 
	DAT15 DATE, 
	DAT16 DATE, 
	DAT17 DATE, 
	DAT18 DATE, 
	DAT19 DATE, 
	DAT20 DATE, 
	DAT21 DATE, 
	DAT22 DATE, 
	DAT23 DATE, 
	DAT24 DATE, 
	DAT25 DATE, 
	DAT26 DATE, 
	DAT27 DATE, 
	DAT28 DATE, 
	DAT29 DATE, 
	DAT30 DATE, 
	DAT31 DATE, 
	DAT32 DATE, 
	DAT33 DATE, 
	DAT34 DATE, 
	DAT35 DATE, 
	DAT36 DATE, 
	DAT37 DATE, 
	DAT38 DATE, 
	DAT39 DATE, 
	DAT40 DATE, 
	DAT41 DATE, 
	DAT42 DATE, 
	DAT43 DATE, 
	DAT44 DATE, 
	DAT45 DATE, 
	DAT46 DATE, 
	DAT47 DATE, 
	DAT48 DATE, 
	DAT49 DATE, 
	CHAR50 VARCHAR2(254), 
	NUM50 NUMBER(36,10), 
	DAT50 DATE, 
	CHAR51 VARCHAR2(254), 
	NUM51 NUMBER(36,10), 
	DAT51 DATE, 
	CHAR52 VARCHAR2(254), 
	NUM52 NUMBER(36,10), 
	DAT52 DATE, 
	CHAR53 VARCHAR2(254), 
	NUM53 NUMBER(36,10), 
	DAT53 DATE, 
	CHAR54 VARCHAR2(254), 
	NUM54 NUMBER(36,10), 
	DAT54 DATE, 
	CHAR55 VARCHAR2(254), 
	NUM55 NUMBER(36,10), 
	DAT55 DATE, 
	CHAR56 VARCHAR2(254), 
	NUM56 NUMBER(36,10), 
	DAT56 DATE, 
	CHAR57 VARCHAR2(254), 
	NUM57 NUMBER(36,10), 
	DAT57 DATE, 
	CHAR58 VARCHAR2(254), 
	NUM58 NUMBER(36,10), 
	DAT58 DATE, 
	CHAR59 VARCHAR2(254), 
	NUM59 NUMBER(36,10), 
	DAT59 DATE, 
	CHAR60 VARCHAR2(254), 
	NUM60 NUMBER(36,10), 
	DAT60 DATE, 
	CHAR61 VARCHAR2(254), 
	NUM61 NUMBER(36,10), 
	DAT61 DATE, 
	CHAR62 VARCHAR2(254), 
	NUM62 NUMBER(36,10), 
	DAT62 DATE, 
	CHAR63 VARCHAR2(254), 
	NUM63 NUMBER(36,10), 
	DAT63 DATE, 
	CHAR64 VARCHAR2(254), 
	NUM64 NUMBER(36,10), 
	DAT64 DATE, 
	CHAR65 VARCHAR2(254), 
	NUM65 NUMBER(36,10), 
	DAT65 DATE, 
	CHAR66 VARCHAR2(254), 
	NUM66 NUMBER(36,10), 
	DAT66 DATE, 
	CHAR67 VARCHAR2(254), 
	NUM67 NUMBER(36,10), 
	DAT67 DATE, 
	CHAR68 VARCHAR2(254), 
	NUM68 NUMBER(36,10), 
	DAT68 DATE, 
	CHAR69 VARCHAR2(254), 
	NUM69 NUMBER(36,10), 
	DAT69 DATE, 
	CHAR70 VARCHAR2(254), 
	NUM70 NUMBER(36,10), 
	DAT70 DATE, 
	CHAR71 VARCHAR2(254), 
	NUM71 NUMBER(36,10), 
	DAT71 DATE, 
	CHAR72 VARCHAR2(254), 
	NUM72 NUMBER(36,10), 
	DAT72 DATE, 
	CHAR73 VARCHAR2(254), 
	NUM73 NUMBER(36,10), 
	DAT73 DATE, 
	CHAR74 VARCHAR2(254), 
	NUM74 NUMBER(36,10), 
	DAT74 DATE, 
	CHAR75 VARCHAR2(254), 
	NUM75 NUMBER(36,10), 
	DAT75 DATE, 
	CHAR76 VARCHAR2(254), 
	NUM76 NUMBER(36,10), 
	DAT76 DATE, 
	CHAR77 VARCHAR2(254), 
	NUM77 NUMBER(36,10), 
	DAT77 DATE, 
	CHAR78 VARCHAR2(254), 
	NUM78 NUMBER(36,10), 
	DAT78 DATE, 
	CHAR79 VARCHAR2(254), 
	NUM79 NUMBER(36,10), 
	DAT79 DATE, 
	CHAR80 VARCHAR2(254), 
	NUM80 NUMBER(36,10), 
	DAT80 DATE, 
	CHAR81 VARCHAR2(254), 
	NUM81 NUMBER(36,10), 
	DAT81 DATE, 
	CHAR82 VARCHAR2(254), 
	NUM82 NUMBER(36,10), 
	DAT82 DATE, 
	CHAR83 VARCHAR2(254), 
	NUM83 NUMBER(36,10), 
	DAT83 DATE, 
	CHAR84 VARCHAR2(254), 
	NUM84 NUMBER(36,10), 
	DAT84 DATE, 
	CHAR85 VARCHAR2(254), 
	NUM85 NUMBER(36,10), 
	DAT85 DATE, 
	CHAR86 VARCHAR2(254), 
	NUM86 NUMBER(36,10), 
	DAT86 DATE, 
	CHAR87 VARCHAR2(254), 
	NUM87 NUMBER(36,10), 
	DAT87 DATE, 
	CHAR88 VARCHAR2(254), 
	NUM88 NUMBER(36,10), 
	DAT88 DATE, 
	CHAR89 VARCHAR2(254), 
	NUM89 NUMBER(36,10), 
	DAT89 DATE, 
	CHAR90 VARCHAR2(254), 
	NUM90 NUMBER(36,10), 
	DAT90 DATE, 
	CHAR91 VARCHAR2(254), 
	NUM91 NUMBER(36,10), 
	DAT91 DATE, 
	CHAR92 VARCHAR2(254), 
	NUM92 NUMBER(36,10), 
	DAT92 DATE, 
	CHAR93 VARCHAR2(254), 
	NUM93 NUMBER(36,10), 
	DAT93 DATE, 
	CHAR94 VARCHAR2(254), 
	NUM94 NUMBER(36,10), 
	DAT94 DATE, 
	CHAR95 VARCHAR2(254), 
	NUM95 NUMBER(36,10), 
	DAT95 DATE, 
	CHAR96 VARCHAR2(254), 
	NUM96 NUMBER(36,10), 
	DAT96 DATE, 
	CHAR97 VARCHAR2(254), 
	NUM97 NUMBER(36,10), 
	DAT97 DATE, 
	CHAR98 VARCHAR2(254), 
	NUM98 NUMBER(36,10), 
	DAT98 DATE, 
	CHAR99 VARCHAR2(254), 
	NUM99 NUMBER(36,10), 
	DAT99 DATE
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255  NOLOGGING 
  TABLESPACE BRSDYND 
  PARTITION BY RANGE (DATE_OF_INSERTION) INTERVAL (NUMTODSINTERVAL(1,''DAY'')) 
 (PARTITION P_FIRST  VALUES LESS THAN (TO_DATE('' 2015-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING 
  TABLESPACE BRSDYND ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RS_TMP_REPORT_DATA ***
 exec bpa.alter_policies('RS_TMP_REPORT_DATA');


COMMENT ON TABLE BARS.RS_TMP_REPORT_DATA IS '������� ��� �������� ��������� ������ ������';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR34 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR35 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR36 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR37 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR38 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR39 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR40 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR41 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR42 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR43 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR44 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR45 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR46 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR47 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR48 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR49 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM00 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM01 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM02 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM03 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM04 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM05 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM06 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM07 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM08 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM09 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM10 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM11 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM12 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM13 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM14 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM15 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM16 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM17 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM18 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM19 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM20 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM21 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM22 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM23 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM24 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM25 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM26 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM27 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM28 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM29 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM30 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM31 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM32 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM33 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM34 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM35 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM36 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM37 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM38 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM39 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM40 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM41 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM42 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM43 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM44 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM45 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM46 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM47 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM48 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM49 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT00 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT01 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT02 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT03 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT04 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT05 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT06 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT07 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT08 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT09 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT10 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT11 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT12 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT13 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT14 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT15 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT16 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT17 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT18 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT19 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT20 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT21 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT22 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT23 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT24 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT25 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT26 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT27 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT28 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT29 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT30 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT31 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT32 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT33 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT34 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT35 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT36 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT37 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT38 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT39 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT40 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT41 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT42 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT43 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT44 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT45 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT46 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT47 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT48 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT49 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR50 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM50 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT50 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR51 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM51 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT51 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR52 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM52 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT52 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR53 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM53 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT53 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR54 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM54 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT54 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR55 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM55 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT55 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.ID IS '������������� ������';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.SESSION_ID IS '������������� ������';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DATE_OF_INSERTION IS '���� ������� ������ (��� ���������������)';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR00 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR01 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR02 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR03 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR04 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR05 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR06 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR07 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR08 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR09 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR10 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR11 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR12 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR13 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR14 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR15 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR16 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR17 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR18 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR19 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR20 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR21 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR22 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR23 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR24 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR25 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR26 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR27 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR28 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR29 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR30 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR31 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR32 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR33 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR99 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM99 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT99 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR56 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM56 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT56 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR57 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM57 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT57 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR58 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM58 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT58 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR59 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM59 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT59 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR60 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM60 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT60 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR61 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM61 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT61 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR62 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM62 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT62 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR63 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM63 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT63 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR64 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM64 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT64 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR65 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM65 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT65 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR66 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM66 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT66 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR67 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM67 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT67 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR68 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM68 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT68 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR69 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM69 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT69 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR70 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM70 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT70 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR71 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM71 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT71 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR72 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM72 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT72 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR73 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM73 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT73 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR74 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM74 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT74 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR75 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM75 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT75 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR76 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM76 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT76 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR77 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM77 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT77 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR78 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM78 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT78 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR79 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM79 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT79 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR80 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM80 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT80 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR81 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM81 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT81 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR82 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM82 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT82 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR83 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM83 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT83 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR84 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM84 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT84 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR85 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM85 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT85 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR86 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM86 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT86 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR87 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM87 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT87 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR88 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM88 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT88 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR89 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM89 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT89 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR90 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM90 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT90 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR91 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM91 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT91 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR92 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM92 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT92 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR93 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM93 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT93 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR94 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM94 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT94 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR95 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM95 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT95 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR96 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM96 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT96 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR97 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM97 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT97 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.CHAR98 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.NUM98 IS '';
COMMENT ON COLUMN BARS.RS_TMP_REPORT_DATA.DAT98 IS '';




PROMPT *** Create  constraint CC_RSTMPRPTDATA_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RS_TMP_REPORT_DATA MODIFY (ID CONSTRAINT CC_RSTMPRPTDATA_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RSTMPRPTDATA_SID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RS_TMP_REPORT_DATA MODIFY (SESSION_ID CONSTRAINT CC_RSTMPRPTDATA_SID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RSTMPRPTDATA_DATINS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RS_TMP_REPORT_DATA MODIFY (DATE_OF_INSERTION CONSTRAINT CC_RSTMPRPTDATA_DATINS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_RSTMPREPORTDATA_ID ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_RSTMPREPORTDATA_ID ON BARS.RS_TMP_REPORT_DATA (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255  LOCAL
 (PARTITION P_FIRST 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSDYND ) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_RSTMPRPTDATA_SID ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_RSTMPRPTDATA_SID ON BARS.RS_TMP_REPORT_DATA (SESSION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255  LOCAL
 (PARTITION P_FIRST 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSDYND ) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RS_TMP_REPORT_DATA ***
grant SELECT                                                                 on RS_TMP_REPORT_DATA to BARSREADER_ROLE;
grant SELECT                                                                 on RS_TMP_REPORT_DATA to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RS_TMP_REPORT_DATA to RS;
grant SELECT                                                                 on RS_TMP_REPORT_DATA to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on RS_TMP_REPORT_DATA to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RS_TMP_REPORT_DATA.sql =========*** En
PROMPT ===================================================================================== 