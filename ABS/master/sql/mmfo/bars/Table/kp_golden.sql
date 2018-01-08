

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KP_GOLDEN.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KP_GOLDEN ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KP_GOLDEN ***
begin 
  execute immediate '
  CREATE TABLE BARS.KP_GOLDEN 
   (	LC VARCHAR2(60), 
	FIO VARCHAR2(30), 
	ADRESS VARCHAR2(60), 
	PHONE VARCHAR2(32), 
	NA NUMBER, 
	DOLG NUMBER, 
	K_USL NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KP_GOLDEN ***
 exec bpa.alter_policies('KP_GOLDEN');


COMMENT ON TABLE BARS.KP_GOLDEN IS 'ƒÓÔ.ÂÍ‚ËÁËÚ˚ ÍÓÏÏÛÌ‡Î¸Ì˚ı ÔÎ‡ÚÂÊÂÈ Golden Telecom';
COMMENT ON COLUMN BARS.KP_GOLDEN.LC IS 'À»÷≈¬Œ… —◊≈“';
COMMENT ON COLUMN BARS.KP_GOLDEN.FIO IS '‘»Œ';
COMMENT ON COLUMN BARS.KP_GOLDEN.ADRESS IS '¿ƒ–≈——';
COMMENT ON COLUMN BARS.KP_GOLDEN.PHONE IS '“≈À≈‘ŒÕ';
COMMENT ON COLUMN BARS.KP_GOLDEN.NA IS 'Õ¿◊»—À≈ÕŒ';
COMMENT ON COLUMN BARS.KP_GOLDEN.DOLG IS '«¿ƒŒÀ∆≈ÕŒ—“‹';
COMMENT ON COLUMN BARS.KP_GOLDEN.K_USL IS ' Œƒ ”—À”√»';




PROMPT *** Create  constraint PK_KP_GOLDEN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KP_GOLDEN ADD CONSTRAINT PK_KP_GOLDEN PRIMARY KEY (LC, K_USL)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_KP_GOLDEN_LC ***
begin   
 execute immediate '
  ALTER TABLE BARS.KP_GOLDEN MODIFY (LC CONSTRAINT NK_KP_GOLDEN_LC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_KP_GOLDEN_K_USL ***
begin   
 execute immediate '
  ALTER TABLE BARS.KP_GOLDEN MODIFY (K_USL CONSTRAINT NK_KP_GOLDEN_K_USL NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KP_GOLDEN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KP_GOLDEN ON BARS.KP_GOLDEN (LC, K_USL) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KP_GOLDEN ***
grant DELETE,INSERT,UPDATE                                                   on KP_GOLDEN       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KP_GOLDEN       to BARS_DM;
grant DELETE,INSERT,UPDATE                                                   on KP_GOLDEN       to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KP_GOLDEN       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KP_GOLDEN.sql =========*** End *** ===
PROMPT ===================================================================================== 
