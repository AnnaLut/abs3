

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EBK_PRC_QUALITY.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EBK_PRC_QUALITY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EBK_PRC_QUALITY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EBK_PRC_QUALITY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EBK_PRC_QUALITY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EBK_PRC_QUALITY ***
begin 
  execute immediate '
  CREATE TABLE BARS.EBK_PRC_QUALITY 
   (	ID NUMBER(2,0), 
	PRC_QLY NUMBER(2,0), 
	NAME VARCHAR2(5) GENERATED ALWAYS AS (''> ''||TO_CHAR(PRC_QLY,''FM00'')) VIRTUAL VISIBLE , 
	DESCR VARCHAR2(27) GENERATED ALWAYS AS (''Заповнені більш ніж на ''||TO_CHAR(PRC_QLY,''FM00'')||''%'') VIRTUAL VISIBLE 
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EBK_PRC_QUALITY ***
 exec bpa.alter_policies('EBK_PRC_QUALITY');


COMMENT ON TABLE BARS.EBK_PRC_QUALITY IS 'Таблица диапазона качеств карточки клиента';
COMMENT ON COLUMN BARS.EBK_PRC_QUALITY.ID IS '';
COMMENT ON COLUMN BARS.EBK_PRC_QUALITY.NAME IS '';
COMMENT ON COLUMN BARS.EBK_PRC_QUALITY.DESCR IS '';
COMMENT ON COLUMN BARS.EBK_PRC_QUALITY.PRC_QLY IS '';




PROMPT *** Create  constraint SYS_C0011841 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBK_PRC_QUALITY ADD PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EBKPRCQUALITY_PRCQLY ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBK_PRC_QUALITY ADD CONSTRAINT CC_EBKPRCQUALITY_PRCQLY CHECK ( PRC_QLY >= 0 or PRC_QLY <= 99 ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_EBKPRCQUALITY_PRCQLY ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBK_PRC_QUALITY ADD CONSTRAINT UK_EBKPRCQUALITY_PRCQLY UNIQUE (PRC_QLY)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C0011841 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C0011841 ON BARS.EBK_PRC_QUALITY (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_EBKPRCQUALITY_PRCQLY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_EBKPRCQUALITY_PRCQLY ON BARS.EBK_PRC_QUALITY (PRC_QLY) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EBK_PRC_QUALITY ***
grant SELECT                                                                 on EBK_PRC_QUALITY to BARSREADER_ROLE;
grant SELECT                                                                 on EBK_PRC_QUALITY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EBK_PRC_QUALITY to BARS_DM;
grant SELECT                                                                 on EBK_PRC_QUALITY to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EBK_PRC_QUALITY.sql =========*** End *
PROMPT ===================================================================================== 
