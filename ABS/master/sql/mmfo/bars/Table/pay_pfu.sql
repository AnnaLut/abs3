

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PAY_PFU.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PAY_PFU ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PAY_PFU'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PAY_PFU'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PAY_PFU ***
begin 
  execute immediate '
  CREATE TABLE BARS.PAY_PFU 
   (	ID NUMBER(38,0), 
	ND VARCHAR2(10), 
	DATD DATE, 
	NLSA VARCHAR2(14), 
	NMSA VARCHAR2(38), 
	NLSB_ALT VARCHAR2(14), 
	NLSB VARCHAR2(14), 
	NMSB VARCHAR2(38), 
	ID_B VARCHAR2(10), 
	S NUMBER(24,0), 
	NAZN VARCHAR2(160), 
	SK_ZB NUMBER(*,0), 
	ISP NUMBER(38,0), 
	REF NUMBER(38,0), 
	ERR_MSG VARCHAR2(500)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PAY_PFU ***
 exec bpa.alter_policies('PAY_PFU');


COMMENT ON TABLE BARS.PAY_PFU IS '';
COMMENT ON COLUMN BARS.PAY_PFU.ID IS '';
COMMENT ON COLUMN BARS.PAY_PFU.ND IS '';
COMMENT ON COLUMN BARS.PAY_PFU.DATD IS '';
COMMENT ON COLUMN BARS.PAY_PFU.NLSA IS '';
COMMENT ON COLUMN BARS.PAY_PFU.NMSA IS '';
COMMENT ON COLUMN BARS.PAY_PFU.NLSB_ALT IS '';
COMMENT ON COLUMN BARS.PAY_PFU.NLSB IS '';
COMMENT ON COLUMN BARS.PAY_PFU.NMSB IS '';
COMMENT ON COLUMN BARS.PAY_PFU.ID_B IS '';
COMMENT ON COLUMN BARS.PAY_PFU.S IS '';
COMMENT ON COLUMN BARS.PAY_PFU.NAZN IS '';
COMMENT ON COLUMN BARS.PAY_PFU.SK_ZB IS '';
COMMENT ON COLUMN BARS.PAY_PFU.ISP IS '';
COMMENT ON COLUMN BARS.PAY_PFU.REF IS '';
COMMENT ON COLUMN BARS.PAY_PFU.ERR_MSG IS '';




PROMPT *** Create  constraint PK_PAYPFU ***
begin   
 execute immediate '
  ALTER TABLE BARS.PAY_PFU ADD CONSTRAINT PK_PAYPFU PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PAYPFU ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PAYPFU ON BARS.PAY_PFU (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PAY_PFU ***
grant DELETE,INSERT,SELECT,UPDATE                                            on PAY_PFU         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PAY_PFU         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PAY_PFU.sql =========*** End *** =====
PROMPT ===================================================================================== 
