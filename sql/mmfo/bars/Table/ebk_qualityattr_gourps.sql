

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EBK_QUALITYATTR_GOURPS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EBK_QUALITYATTR_GOURPS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EBK_QUALITYATTR_GOURPS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EBK_QUALITYATTR_GOURPS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EBK_QUALITYATTR_GOURPS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EBK_QUALITYATTR_GOURPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.EBK_QUALITYATTR_GOURPS 
   (	BATCHID VARCHAR2(50), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	RNK NUMBER(38,0), 
	NAME VARCHAR2(50), 
	QUALITY NUMBER(6,2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EBK_QUALITYATTR_GOURPS ***
 exec bpa.alter_policies('EBK_QUALITYATTR_GOURPS');


COMMENT ON TABLE BARS.EBK_QUALITYATTR_GOURPS IS 'Таблица групп качеств по клиенту';
COMMENT ON COLUMN BARS.EBK_QUALITYATTR_GOURPS.BATCHID IS '';
COMMENT ON COLUMN BARS.EBK_QUALITYATTR_GOURPS.KF IS '';
COMMENT ON COLUMN BARS.EBK_QUALITYATTR_GOURPS.RNK IS '';
COMMENT ON COLUMN BARS.EBK_QUALITYATTR_GOURPS.NAME IS '';
COMMENT ON COLUMN BARS.EBK_QUALITYATTR_GOURPS.QUALITY IS '';




PROMPT *** Create  index INDX_EQG_U2 ***
begin   
 execute immediate '
  CREATE INDEX BARS.INDX_EQG_U2 ON BARS.EBK_QUALITYATTR_GOURPS (KF, RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index INDX_EQG_N1 ***
begin   
 execute immediate '
  CREATE INDEX BARS.INDX_EQG_N1 ON BARS.EBK_QUALITYATTR_GOURPS (NAME, QUALITY) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EBK_QUALITYATTR_GOURPS ***
grant SELECT                                                                 on EBK_QUALITYATTR_GOURPS to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on EBK_QUALITYATTR_GOURPS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EBK_QUALITYATTR_GOURPS to BARS_DM;
grant SELECT                                                                 on EBK_QUALITYATTR_GOURPS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EBK_QUALITYATTR_GOURPS.sql =========**
PROMPT ===================================================================================== 
