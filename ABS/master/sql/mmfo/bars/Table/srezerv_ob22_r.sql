

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SREZERV_OB22_R.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SREZERV_OB22_R ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SREZERV_OB22_R'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SREZERV_OB22_R'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SREZERV_OB22_R ***
begin 
  execute immediate '
  CREATE TABLE BARS.SREZERV_OB22_R 
   (	NBS CHAR(4), 
	OB22 VARCHAR2(2), 
	S080 VARCHAR2(1), 
	CUSTTYPE VARCHAR2(2), 
	KV VARCHAR2(3), 
	NBS_REZ CHAR(4), 
	OB22_REZ VARCHAR2(2), 
	NBS_7F CHAR(4), 
	OB22_7F VARCHAR2(2), 
	NBS_7R CHAR(4), 
	OB22_7R VARCHAR2(2), 
	PR NUMBER(1,0), 
	NAL VARCHAR2(1), 
	R013 NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SREZERV_OB22_R ***
 exec bpa.alter_policies('SREZERV_OB22_R');


COMMENT ON TABLE BARS.SREZERV_OB22_R IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_R.NBS IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_R.OB22 IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_R.S080 IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_R.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_R.KV IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_R.NBS_REZ IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_R.OB22_REZ IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_R.NBS_7F IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_R.OB22_7F IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_R.NBS_7R IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_R.OB22_7R IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_R.PR IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_R.NAL IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_R.R013 IS '';




PROMPT *** Create  constraint XPK_SREZERV_OB22_R ***
begin   
 execute immediate '
  ALTER TABLE BARS.SREZERV_OB22_R ADD CONSTRAINT XPK_SREZERV_OB22_R PRIMARY KEY (NBS, OB22, S080, CUSTTYPE, KV, PR, NAL)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_SREZERV_OB22_R ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_SREZERV_OB22_R ON BARS.SREZERV_OB22_R (NBS, OB22, S080, CUSTTYPE, KV, PR, NAL) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SREZERV_OB22_R ***
grant SELECT                                                                 on SREZERV_OB22_R  to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SREZERV_OB22_R  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SREZERV_OB22_R  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SREZERV_OB22_R  to RCC_DEAL;
grant SELECT                                                                 on SREZERV_OB22_R  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SREZERV_OB22_R  to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SREZERV_OB22_R  to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SREZERV_OB22_R.sql =========*** End **
PROMPT ===================================================================================== 
