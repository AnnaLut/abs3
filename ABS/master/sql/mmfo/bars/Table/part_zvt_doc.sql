

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PART_ZVT_DOC.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PART_ZVT_DOC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PART_ZVT_DOC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PART_ZVT_DOC'', ''FILIAL'' , ''F'', ''F'', ''F'', ''F'');
               bpa.alter_policy_info(''PART_ZVT_DOC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PART_ZVT_DOC ***
begin 
  execute immediate '
  CREATE TABLE BARS.PART_ZVT_DOC 
   (	FDAT DATE, 
	BRANCH VARCHAR2(30), 
	TEMA NUMBER(*,0), 
	ISP NUMBER(*,0), 
	KV NUMBER(*,0), 
	TT CHAR(3), 
	REF NUMBER, 
	STMT NUMBER, 
	NLSD VARCHAR2(15), 
	NLSK VARCHAR2(15), 
	S NUMBER, 
	SQ NUMBER, 
	KF VARCHAR2(6)
   ) PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS 
  TABLESPACE BRSBIGD 
  PARTITION BY RANGE (FDAT) INTERVAL (NUMTODSINTERVAL(1,''DAY'')) 
 (PARTITION SYS_P12507  VALUES LESS THAN (TO_DATE('' 2012-11-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PART_ZVT_DOC ***
 exec bpa.alter_policies('PART_ZVT_DOC');


COMMENT ON TABLE BARS.PART_ZVT_DOC IS 'Реєстр проводок. Вик в бух.звед док дня. Можна вокористовувати в iнш звiтах';
COMMENT ON COLUMN BARS.PART_ZVT_DOC.KF IS '';
COMMENT ON COLUMN BARS.PART_ZVT_DOC.FDAT IS '';
COMMENT ON COLUMN BARS.PART_ZVT_DOC.BRANCH IS '';
COMMENT ON COLUMN BARS.PART_ZVT_DOC.TEMA IS '';
COMMENT ON COLUMN BARS.PART_ZVT_DOC.ISP IS 'Виконавець проводки';
COMMENT ON COLUMN BARS.PART_ZVT_DOC.KV IS 'Код вал';
COMMENT ON COLUMN BARS.PART_ZVT_DOC.TT IS 'Код опер';
COMMENT ON COLUMN BARS.PART_ZVT_DOC.REF IS 'Реф опер';
COMMENT ON COLUMN BARS.PART_ZVT_DOC.STMT IS 'код проводки';
COMMENT ON COLUMN BARS.PART_ZVT_DOC.NLSD IS 'Сч.дебет';
COMMENT ON COLUMN BARS.PART_ZVT_DOC.NLSK IS 'Сч Кредит';
COMMENT ON COLUMN BARS.PART_ZVT_DOC.S IS 'Ном в коп';
COMMENT ON COLUMN BARS.PART_ZVT_DOC.SQ IS 'Екв в коп';



PROMPT *** Create  grants  PART_ZVT_DOC ***
grant SELECT                                                                 on PART_ZVT_DOC    to BARSREADER_ROLE;
grant SELECT                                                                 on PART_ZVT_DOC    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PART_ZVT_DOC    to RPBN001;
grant SELECT                                                                 on PART_ZVT_DOC    to RPBN002;
grant SELECT                                                                 on PART_ZVT_DOC    to UPLD;



PROMPT *** Create SYNONYM  to PART_ZVT_DOC ***

  CREATE OR REPLACE PUBLIC SYNONYM ZVT_DOC FOR BARS.PART_ZVT_DOC;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PART_ZVT_DOC.sql =========*** End *** 
PROMPT ===================================================================================== 
