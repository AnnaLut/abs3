

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KP_TOBO.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KP_TOBO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KP_TOBO'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KP_TOBO'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KP_TOBO'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KP_TOBO ***
begin 
  execute immediate '
  CREATE TABLE BARS.KP_TOBO 
   (	ND NUMBER(*,0), 
	TOBO VARCHAR2(30), 
	POS NUMBER DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KP_TOBO ***
 exec bpa.alter_policies('KP_TOBO');


COMMENT ON TABLE BARS.KP_TOBO IS 'КП. Договора по ТОБО';
COMMENT ON COLUMN BARS.KP_TOBO.ND IS 'Реф. договора';
COMMENT ON COLUMN BARS.KP_TOBO.TOBO IS 'Код ТОБО';
COMMENT ON COLUMN BARS.KP_TOBO.POS IS 'Номер по-порядку для данного тобо';




PROMPT *** Create  constraint XPK_KP_TOBO ***
begin   
 execute immediate '
  ALTER TABLE BARS.KP_TOBO ADD CONSTRAINT XPK_KP_TOBO PRIMARY KEY (ND, TOBO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_KP_TOBO_TOBO ***
begin   
 execute immediate '
  ALTER TABLE BARS.KP_TOBO MODIFY (TOBO CONSTRAINT NK_KP_TOBO_TOBO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_KP_TOBO ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_KP_TOBO ON BARS.KP_TOBO (ND, TOBO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KP_TOBO ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KP_TOBO         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KP_TOBO         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KP_TOBO         to R_KP;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KP_TOBO         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KP_TOBO.sql =========*** End *** =====
PROMPT ===================================================================================== 
