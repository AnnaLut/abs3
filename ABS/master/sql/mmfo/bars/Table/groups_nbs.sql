

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GROUPS_NBS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GROUPS_NBS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GROUPS_NBS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''GROUPS_NBS'', ''FILIAL'' , ''F'', ''F'', ''F'', ''F'');
               bpa.alter_policy_info(''GROUPS_NBS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GROUPS_NBS ***
begin 
  execute immediate '
  CREATE TABLE BARS.GROUPS_NBS 
   (	ID NUMBER(38,0), 
	NBS CHAR(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GROUPS_NBS ***
 exec bpa.alter_policies('GROUPS_NBS');


COMMENT ON TABLE BARS.GROUPS_NBS IS 'Группы счетов и счета';
COMMENT ON COLUMN BARS.GROUPS_NBS.ID IS 'Идентификатор группы счетов';
COMMENT ON COLUMN BARS.GROUPS_NBS.NBS IS 'Маска балансового счета';




PROMPT *** Create  constraint PK_GROUPSNBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.GROUPS_NBS ADD CONSTRAINT PK_GROUPSNBS PRIMARY KEY (ID, NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GROUPSNBS_GROUPSACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.GROUPS_NBS ADD CONSTRAINT FK_GROUPSNBS_GROUPSACC FOREIGN KEY (ID)
	  REFERENCES BARS.GROUPS_ACC (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GROUPSNBS_PS ***
begin   
 execute immediate '
  ALTER TABLE BARS.GROUPS_NBS ADD CONSTRAINT FK_GROUPSNBS_PS FOREIGN KEY (NBS)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GROUPSNBS_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GROUPS_NBS MODIFY (ID CONSTRAINT CC_GROUPSNBS_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GROUPSNBS_NBS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GROUPS_NBS MODIFY (NBS CONSTRAINT CC_GROUPSNBS_NBS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_GROUPSNBS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_GROUPSNBS ON BARS.GROUPS_NBS (ID, NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  GROUPS_NBS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on GROUPS_NBS      to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on GROUPS_NBS      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on GROUPS_NBS      to BARS_DM;
grant SELECT                                                                 on GROUPS_NBS      to CUST001;
grant SELECT                                                                 on GROUPS_NBS      to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on GROUPS_NBS      to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on GROUPS_NBS      to WR_REFREAD;
grant SELECT                                                                 on GROUPS_NBS      to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GROUPS_NBS.sql =========*** End *** ==
PROMPT ===================================================================================== 
