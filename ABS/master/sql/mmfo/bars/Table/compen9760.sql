

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/COMPEN9760.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to COMPEN9760 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''COMPEN9760'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''COMPEN9760'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table COMPEN9760 ***
begin 
  execute immediate '
  CREATE TABLE BARS.COMPEN9760 
   (	NLS VARCHAR2(15), 
	KV NUMBER DEFAULT 980, 
	MFO VARCHAR2(10)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to COMPEN9760 ***
 exec bpa.alter_policies('COMPEN9760');


COMMENT ON TABLE BARS.COMPEN9760 IS '';
COMMENT ON COLUMN BARS.COMPEN9760.NLS IS '';
COMMENT ON COLUMN BARS.COMPEN9760.KV IS '';
COMMENT ON COLUMN BARS.COMPEN9760.MFO IS '';




PROMPT *** Create  constraint CC_COMPEN9760_NLS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.COMPEN9760 MODIFY (NLS CONSTRAINT CC_COMPEN9760_NLS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_COMPEN9760_MFO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.COMPEN9760 MODIFY (MFO CONSTRAINT CC_COMPEN9760_MFO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_COMPEN9760 ***
begin   
 execute immediate '
  ALTER TABLE BARS.COMPEN9760 ADD CONSTRAINT PK_COMPEN9760 PRIMARY KEY (MFO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_COMPEN9760 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_COMPEN9760 ON BARS.COMPEN9760 (MFO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  COMPEN9760 ***
grant SELECT                                                                 on COMPEN9760      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on COMPEN9760      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on COMPEN9760      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/COMPEN9760.sql =========*** End *** ==
PROMPT ===================================================================================== 
