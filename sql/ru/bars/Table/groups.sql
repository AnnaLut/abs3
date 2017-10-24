

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GROUPS.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GROUPS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GROUPS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''GROUPS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GROUPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.GROUPS 
   (	ID NUMBER(38,0), 
	NAME VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GROUPS ***
 exec bpa.alter_policies('GROUPS');


COMMENT ON TABLE BARS.GROUPS IS '������  �������';
COMMENT ON COLUMN BARS.GROUPS.ID IS '������������� ������ �������������';
COMMENT ON COLUMN BARS.GROUPS.NAME IS '������������ ������ �������������';




PROMPT *** Create  constraint PK_GROUPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.GROUPS ADD CONSTRAINT PK_GROUPS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GROUPS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GROUPS MODIFY (NAME CONSTRAINT CC_GROUPS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GROUPS_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GROUPS MODIFY (ID CONSTRAINT CC_GROUPS_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_GROUPS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_GROUPS ON BARS.GROUPS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  GROUPS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on GROUPS          to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on GROUPS          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on GROUPS          to RCC_DEAL;
grant SELECT                                                                 on GROUPS          to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on GROUPS          to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on GROUPS          to WR_REFREAD;
grant SELECT                                                                 on GROUPS          to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GROUPS.sql =========*** End *** ======
PROMPT ===================================================================================== 
