

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REF_QUEUE_SWT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REF_QUEUE_SWT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REF_QUEUE_SWT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REF_QUEUE_SWT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REF_QUEUE_SWT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REF_QUEUE_SWT ***
begin 
  execute immediate '
  CREATE TABLE BARS.REF_QUEUE_SWT 
   (	REF NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REF_QUEUE_SWT ***
 exec bpa.alter_policies('REF_QUEUE_SWT');


COMMENT ON TABLE BARS.REF_QUEUE_SWT IS '';
COMMENT ON COLUMN BARS.REF_QUEUE_SWT.REF IS '';




PROMPT *** Create  constraint PK_REF_QUEUE_SWT ***
begin   
 execute immediate '
  ALTER TABLE BARS.REF_QUEUE_SWT ADD CONSTRAINT PK_REF_QUEUE_SWT PRIMARY KEY (REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REF_QUEUE_SWT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_REF_QUEUE_SWT ON BARS.REF_QUEUE_SWT (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REF_QUEUE_SWT ***
grant SELECT                                                                 on REF_QUEUE_SWT   to BARSREADER_ROLE;
grant SELECT                                                                 on REF_QUEUE_SWT   to BARS_DM;
grant SELECT                                                                 on REF_QUEUE_SWT   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REF_QUEUE_SWT.sql =========*** End ***
PROMPT ===================================================================================== 
