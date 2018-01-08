

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BIZNESPR_NAZN.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BIZNESPR_NAZN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BIZNESPR_NAZN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BIZNESPR_NAZN'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''BIZNESPR_NAZN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BIZNESPR_NAZN ***
begin 
  execute immediate '
  CREATE TABLE BARS.BIZNESPR_NAZN 
   (	SLOVO VARCHAR2(29), 
	COMM VARCHAR2(48), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BIZNESPR_NAZN ***
 exec bpa.alter_policies('BIZNESPR_NAZN');


COMMENT ON TABLE BARS.BIZNESPR_NAZN IS '';
COMMENT ON COLUMN BARS.BIZNESPR_NAZN.SLOVO IS '';
COMMENT ON COLUMN BARS.BIZNESPR_NAZN.COMM IS '';
COMMENT ON COLUMN BARS.BIZNESPR_NAZN.KF IS '';




PROMPT *** Create  constraint SYS_C00139340 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BIZNESPR_NAZN MODIFY (SLOVO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BIZNESPRNAZN_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BIZNESPR_NAZN MODIFY (KF CONSTRAINT CC_BIZNESPRNAZN_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BIZNESPRNAZN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BIZNESPR_NAZN ADD CONSTRAINT PK_BIZNESPRNAZN PRIMARY KEY (SLOVO, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BIZNESPRNAZN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BIZNESPRNAZN ON BARS.BIZNESPR_NAZN (SLOVO, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BIZNESPR_NAZN ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BIZNESPR_NAZN   to ABS_ADMIN;
grant SELECT                                                                 on BIZNESPR_NAZN   to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on BIZNESPR_NAZN   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BIZNESPR_NAZN   to BARS_DM;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on BIZNESPR_NAZN   to START1;
grant SELECT                                                                 on BIZNESPR_NAZN   to UPLD;
grant FLASHBACK,SELECT                                                       on BIZNESPR_NAZN   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BIZNESPR_NAZN.sql =========*** End ***
PROMPT ===================================================================================== 
