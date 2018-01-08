

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VIP_MGR_USR_LST.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VIP_MGR_USR_LST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''VIP_MGR_USR_LST'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''VIP_MGR_USR_LST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VIP_MGR_USR_LST ***
begin 
  execute immediate '
  CREATE TABLE BARS.VIP_MGR_USR_LST 
   (	BRANCH VARCHAR2(30), 
	USR_ID NUMBER(38,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to VIP_MGR_USR_LST ***
 exec bpa.alter_policies('VIP_MGR_USR_LST');


COMMENT ON TABLE BARS.VIP_MGR_USR_LST IS 'Довідник користувачів які відкритвають рахунки з обмеженою групою доступу';
COMMENT ON COLUMN BARS.VIP_MGR_USR_LST.BRANCH IS 'Код VIP відділення або відділення з VIP зоною';
COMMENT ON COLUMN BARS.VIP_MGR_USR_LST.USR_ID IS 'Ід. користувача АБС';




PROMPT *** Create  constraint CC_VIPMGRUSRLST_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.VIP_MGR_USR_LST MODIFY (BRANCH CONSTRAINT CC_VIPMGRUSRLST_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_VIPMGRUSRLST ***
begin   
 execute immediate '
  ALTER TABLE BARS.VIP_MGR_USR_LST ADD CONSTRAINT UK_VIPMGRUSRLST UNIQUE (BRANCH, USR_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_VIPMGRUSRLST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_VIPMGRUSRLST ON BARS.VIP_MGR_USR_LST (BRANCH, USR_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  VIP_MGR_USR_LST ***
grant SELECT                                                                 on VIP_MGR_USR_LST to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on VIP_MGR_USR_LST to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on VIP_MGR_USR_LST to START1;
grant SELECT                                                                 on VIP_MGR_USR_LST to UPLD;
grant FLASHBACK,SELECT                                                       on VIP_MGR_USR_LST to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VIP_MGR_USR_LST.sql =========*** End *
PROMPT ===================================================================================== 
