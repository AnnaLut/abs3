

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MS_FS_K.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MS_FS_K ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MS_FS_K'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MS_FS_K'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MS_FS_K'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MS_FS_K ***
begin 
  execute immediate '
  CREATE TABLE BARS.MS_FS_K 
   (	ID NUMBER, 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MS_FS_K ***
 exec bpa.alter_policies('MS_FS_K');


COMMENT ON TABLE BARS.MS_FS_K IS 'Орг-прав. форма клиента';
COMMENT ON COLUMN BARS.MS_FS_K.ID IS 'Код';
COMMENT ON COLUMN BARS.MS_FS_K.NAME IS 'Наименование';




PROMPT *** Create  constraint XPK_MS_FS_K ***
begin   
 execute immediate '
  ALTER TABLE BARS.MS_FS_K ADD CONSTRAINT XPK_MS_FS_K PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_MS_FS_K_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.MS_FS_K MODIFY (ID CONSTRAINT NK_MS_FS_K_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_MS_FS_K ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_MS_FS_K ON BARS.MS_FS_K (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MS_FS_K ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on MS_FS_K         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MS_FS_K         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on MS_FS_K         to CC_AIM;
grant DELETE,INSERT,SELECT,UPDATE                                            on MS_FS_K         to RCC_DEAL;
grant FLASHBACK,SELECT                                                       on MS_FS_K         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MS_FS_K.sql =========*** End *** =====
PROMPT ===================================================================================== 
