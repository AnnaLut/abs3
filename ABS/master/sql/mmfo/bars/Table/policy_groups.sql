

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/POLICY_GROUPS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to POLICY_GROUPS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table POLICY_GROUPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.POLICY_GROUPS 
   (	POLICY_GROUP VARCHAR2(30), 
	POLICY_GROUP_DESC VARCHAR2(250), 
	 CONSTRAINT PK_POLICYGROUPS PRIMARY KEY (POLICY_GROUP) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to POLICY_GROUPS ***
 exec bpa.alter_policies('POLICY_GROUPS');


COMMENT ON TABLE BARS.POLICY_GROUPS IS 'Группы политик';
COMMENT ON COLUMN BARS.POLICY_GROUPS.POLICY_GROUP IS 'Наименование группы политик';
COMMENT ON COLUMN BARS.POLICY_GROUPS.POLICY_GROUP_DESC IS 'Описание группы политик';




PROMPT *** Create  constraint PK_POLICYGROUPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.POLICY_GROUPS ADD CONSTRAINT PK_POLICYGROUPS PRIMARY KEY (POLICY_GROUP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_POLICYGROUPS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_POLICYGROUPS ON BARS.POLICY_GROUPS (POLICY_GROUP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  POLICY_GROUPS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on POLICY_GROUPS   to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on POLICY_GROUPS   to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on POLICY_GROUPS   to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on POLICY_GROUPS   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/POLICY_GROUPS.sql =========*** End ***
PROMPT ===================================================================================== 
