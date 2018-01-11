

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PKK_SEPKOMIS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PKK_SEPKOMIS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PKK_SEPKOMIS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''PKK_SEPKOMIS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''PKK_SEPKOMIS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PKK_SEPKOMIS ***
begin 
  execute immediate '
  CREATE TABLE BARS.PKK_SEPKOMIS 
   (	REF NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PKK_SEPKOMIS ***
 exec bpa.alter_policies('PKK_SEPKOMIS');


COMMENT ON TABLE BARS.PKK_SEPKOMIS IS '';
COMMENT ON COLUMN BARS.PKK_SEPKOMIS.REF IS '';
COMMENT ON COLUMN BARS.PKK_SEPKOMIS.KF IS '';




PROMPT *** Create  constraint PK_PKKSEPKOMIS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_SEPKOMIS ADD CONSTRAINT PK_PKKSEPKOMIS PRIMARY KEY (REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PKKSEPKOMIS_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_SEPKOMIS MODIFY (REF CONSTRAINT CC_PKKSEPKOMIS_REF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PKKSEPKOMIS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_SEPKOMIS MODIFY (KF CONSTRAINT CC_PKKSEPKOMIS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PKKSEPKOMIS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PKKSEPKOMIS ON BARS.PKK_SEPKOMIS (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PKK_SEPKOMIS ***
grant SELECT                                                                 on PKK_SEPKOMIS    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PKK_SEPKOMIS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PKK_SEPKOMIS    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on PKK_SEPKOMIS    to START1;
grant SELECT                                                                 on PKK_SEPKOMIS    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PKK_SEPKOMIS.sql =========*** End *** 
PROMPT ===================================================================================== 
