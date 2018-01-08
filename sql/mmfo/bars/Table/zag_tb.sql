

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAG_TB.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAG_TB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAG_TB'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ZAG_TB'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ZAG_TB'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAG_TB ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAG_TB 
   (	FN VARCHAR2(15), 
	DAT DATE, 
	N NUMBER, 
	OTM NUMBER, 
	DATK DATE, 
	ERR VARCHAR2(4), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAG_TB ***
 exec bpa.alter_policies('ZAG_TB');


COMMENT ON TABLE BARS.ZAG_TB IS '';
COMMENT ON COLUMN BARS.ZAG_TB.FN IS '';
COMMENT ON COLUMN BARS.ZAG_TB.DAT IS '';
COMMENT ON COLUMN BARS.ZAG_TB.N IS '';
COMMENT ON COLUMN BARS.ZAG_TB.OTM IS '';
COMMENT ON COLUMN BARS.ZAG_TB.DATK IS '';
COMMENT ON COLUMN BARS.ZAG_TB.ERR IS '';
COMMENT ON COLUMN BARS.ZAG_TB.KF IS '';




PROMPT *** Create  constraint XPK_ZAG_TB ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_TB ADD CONSTRAINT XPK_ZAG_TB PRIMARY KEY (FN, DAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAGTB_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_TB MODIFY (KF CONSTRAINT CC_ZAGTB_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ZAG_TB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ZAG_TB ON BARS.ZAG_TB (FN, DAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAG_TB ***
grant SELECT                                                                 on ZAG_TB          to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAG_TB          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ZAG_TB          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAG_TB          to RPBN002;
grant SELECT                                                                 on ZAG_TB          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAG_TB.sql =========*** End *** ======
PROMPT ===================================================================================== 
