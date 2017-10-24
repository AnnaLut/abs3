

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
	NAME VARCHAR2(10), 
	DESCR VARCHAR2(50)
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


COMMENT ON TABLE BARS.EBK_PRC_QUALITY IS '“аблица диапазона качеств карточки клиента';
COMMENT ON COLUMN BARS.EBK_PRC_QUALITY.ID IS '';
COMMENT ON COLUMN BARS.EBK_PRC_QUALITY.NAME IS '';
COMMENT ON COLUMN BARS.EBK_PRC_QUALITY.DESCR IS '';




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



PROMPT *** Create  grants  EBK_PRC_QUALITY ***
grant SELECT                                                                 on EBK_PRC_QUALITY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EBK_PRC_QUALITY to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EBK_PRC_QUALITY.sql =========*** End *
PROMPT ===================================================================================== 
