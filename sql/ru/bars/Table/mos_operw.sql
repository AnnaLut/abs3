

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MOS_OPERW.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MOS_OPERW ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MOS_OPERW'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MOS_OPERW'', ''WHOLE'' , null, ''E'', null, ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MOS_OPERW ***
begin 
  execute immediate '
  CREATE TABLE BARS.MOS_OPERW 
   (	ND NUMBER(*,0), 
	TAG VARCHAR2(8), 
	VALUE VARCHAR2(250)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MOS_OPERW ***
 exec bpa.alter_policies('MOS_OPERW');


COMMENT ON TABLE BARS.MOS_OPERW IS '';
COMMENT ON COLUMN BARS.MOS_OPERW.ND IS '';
COMMENT ON COLUMN BARS.MOS_OPERW.TAG IS '';
COMMENT ON COLUMN BARS.MOS_OPERW.VALUE IS '';




PROMPT *** Create  constraint PK_MOS_OPERW ***
begin   
 execute immediate '
  ALTER TABLE BARS.MOS_OPERW ADD CONSTRAINT PK_MOS_OPERW PRIMARY KEY (ND, TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_MOS_OPERW ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_MOS_OPERW ON BARS.MOS_OPERW (ND, TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MOS_OPERW ***
grant DELETE,INSERT,SELECT,UPDATE                                            on MOS_OPERW       to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on MOS_OPERW       to CIG_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MOS_OPERW.sql =========*** End *** ===
PROMPT ===================================================================================== 
