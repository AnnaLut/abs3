

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MS_VD_K.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MS_VD_K ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MS_VD_K'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MS_VD_K'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''MS_VD_K'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MS_VD_K ***
begin 
  execute immediate '
  CREATE TABLE BARS.MS_VD_K 
   (	ID NUMBER, 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MS_VD_K ***
 exec bpa.alter_policies('MS_VD_K');


COMMENT ON TABLE BARS.MS_VD_K IS '';
COMMENT ON COLUMN BARS.MS_VD_K.ID IS '';
COMMENT ON COLUMN BARS.MS_VD_K.NAME IS '';




PROMPT *** Create  constraint NK_MS_VD_K_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.MS_VD_K MODIFY (ID CONSTRAINT NK_MS_VD_K_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_MS_VD_K ***
begin   
 execute immediate '
  ALTER TABLE BARS.MS_VD_K ADD CONSTRAINT XPK_MS_VD_K PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_MS_VD_K ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_MS_VD_K ON BARS.MS_VD_K (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MS_VD_K ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on MS_VD_K         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on MS_VD_K         to CC_AIM;
grant DELETE,INSERT,SELECT,UPDATE                                            on MS_VD_K         to RCC_DEAL;
grant SELECT                                                                 on MS_VD_K         to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on MS_VD_K         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on MS_VD_K         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MS_VD_K.sql =========*** End *** =====
PROMPT ===================================================================================== 
