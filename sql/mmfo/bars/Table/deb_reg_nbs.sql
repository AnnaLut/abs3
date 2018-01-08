

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DEB_REG_NBS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DEB_REG_NBS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DEB_REG_NBS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DEB_REG_NBS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DEB_REG_NBS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DEB_REG_NBS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DEB_REG_NBS 
   (	NBS CHAR(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DEB_REG_NBS ***
 exec bpa.alter_policies('DEB_REG_NBS');


COMMENT ON TABLE BARS.DEB_REG_NBS IS 'Балансовые счета для отбора задолженности';
COMMENT ON COLUMN BARS.DEB_REG_NBS.NBS IS '';




PROMPT *** Create  constraint SYS_C009265 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEB_REG_NBS MODIFY (NBS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_DEB_REG_NBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEB_REG_NBS ADD CONSTRAINT XPK_DEB_REG_NBS PRIMARY KEY (NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_DEB_REG_NBS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_DEB_REG_NBS ON BARS.DEB_REG_NBS (NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DEB_REG_NBS ***
grant SELECT                                                                 on DEB_REG_NBS     to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DEB_REG_NBS     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DEB_REG_NBS     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DEB_REG_NBS     to RCC_DEAL;
grant SELECT                                                                 on DEB_REG_NBS     to UPLD;
grant FLASHBACK,SELECT                                                       on DEB_REG_NBS     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DEB_REG_NBS.sql =========*** End *** =
PROMPT ===================================================================================== 
