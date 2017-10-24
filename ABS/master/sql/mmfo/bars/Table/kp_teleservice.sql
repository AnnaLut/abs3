

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KP_TELESERVICE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KP_TELESERVICE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KP_TELESERVICE ***
begin 
  execute immediate '
  CREATE TABLE BARS.KP_TELESERVICE 
   (	LC VARCHAR2(60), 
	FIO VARCHAR2(30), 
	ADRESS VARCHAR2(60), 
	NA NUMBER, 
	DOLG NUMBER, 
	K_USL NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KP_TELESERVICE ***
 exec bpa.alter_policies('KP_TELESERVICE');


COMMENT ON TABLE BARS.KP_TELESERVICE IS 'ƒÓÔ.ÂÍ‚ËÁËÚ˚ ÍÓÏÏÛÌ‡Î¸Ì˚ı ÔÎ‡ÚÂÊÂÈ  ËÂ‚ “ÂÎÂ—Â‚ËÒ';
COMMENT ON COLUMN BARS.KP_TELESERVICE.LC IS 'À»÷≈¬Œ… —◊≈“';
COMMENT ON COLUMN BARS.KP_TELESERVICE.FIO IS '‘»Œ';
COMMENT ON COLUMN BARS.KP_TELESERVICE.ADRESS IS '¿ƒ–≈——';
COMMENT ON COLUMN BARS.KP_TELESERVICE.NA IS 'Õ¿◊»—À≈ÕŒ';
COMMENT ON COLUMN BARS.KP_TELESERVICE.DOLG IS '«¿ƒŒÀ∆≈ÕŒ—“‹';
COMMENT ON COLUMN BARS.KP_TELESERVICE.K_USL IS ' Œƒ ”—À”√»';




PROMPT *** Create  constraint PK_KP_TELESERVICE ***
begin   
 execute immediate '
  ALTER TABLE BARS.KP_TELESERVICE ADD CONSTRAINT PK_KP_TELESERVICE PRIMARY KEY (LC, K_USL)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_KP_TELESERVICE_LC ***
begin   
 execute immediate '
  ALTER TABLE BARS.KP_TELESERVICE MODIFY (LC CONSTRAINT NK_KP_TELESERVICE_LC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_KP_TELESERVICE_K_USL ***
begin   
 execute immediate '
  ALTER TABLE BARS.KP_TELESERVICE MODIFY (K_USL CONSTRAINT NK_KP_TELESERVICE_K_USL NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KP_TELESERVICE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KP_TELESERVICE ON BARS.KP_TELESERVICE (LC, K_USL) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KP_TELESERVICE ***
grant DELETE,INSERT,UPDATE                                                   on KP_TELESERVICE  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KP_TELESERVICE  to BARS_DM;
grant DELETE,INSERT,UPDATE                                                   on KP_TELESERVICE  to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KP_TELESERVICE  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KP_TELESERVICE.sql =========*** End **
PROMPT ===================================================================================== 
