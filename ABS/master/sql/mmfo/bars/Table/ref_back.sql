

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REF_BACK.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REF_BACK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REF_BACK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REF_BACK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REF_BACK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REF_BACK ***
begin 
  execute immediate '
  CREATE TABLE BARS.REF_BACK 
   (	REF NUMBER, 
	DT DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REF_BACK ***
 exec bpa.alter_policies('REF_BACK');


COMMENT ON TABLE BARS.REF_BACK IS 'Сторновані проводки для розрахунку резерва (#B8)';
COMMENT ON COLUMN BARS.REF_BACK.REF IS 'Референс проводки';
COMMENT ON COLUMN BARS.REF_BACK.DT IS 'Дата сторнування';




PROMPT *** Create  constraint PK_BACK_DOK ***
begin   
 execute immediate '
  ALTER TABLE BARS.REF_BACK ADD CONSTRAINT PK_BACK_DOK PRIMARY KEY (REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008561 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REF_BACK MODIFY (REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008562 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REF_BACK MODIFY (DT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BACK_DOK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BACK_DOK ON BARS.REF_BACK (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REF_BACK ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REF_BACK        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REF_BACK        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on REF_BACK        to RCC_DEAL;
grant DELETE,INSERT,SELECT,UPDATE                                            on REF_BACK        to RPBN002;
grant FLASHBACK,SELECT                                                       on REF_BACK        to WR_REFREAD;



PROMPT *** Create SYNONYM  to REF_BACK ***

  CREATE OR REPLACE PUBLIC SYNONYM REF_BACK FOR BARS.REF_BACK;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REF_BACK.sql =========*** End *** ====
PROMPT ===================================================================================== 
