

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SREZERV_OB22_5.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SREZERV_OB22_5 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SREZERV_OB22_5'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SREZERV_OB22_5'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SREZERV_OB22_5 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SREZERV_OB22_5 
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




PROMPT *** ALTER_POLICIES to SREZERV_OB22_5 ***
 exec bpa.alter_policies('SREZERV_OB22_5');


COMMENT ON TABLE BARS.SREZERV_OB22_5 IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_5.NBS IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_5.OB22 IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_5.S080 IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_5.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_5.KV IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_5.NBS_REZ IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_5.OB22_REZ IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_5.NBS_7F IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_5.OB22_7F IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_5.NBS_7R IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_5.OB22_7R IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_5.PR IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_5.NAL IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_5.R013 IS '';




PROMPT *** Create  index IDX_SREZ_OB22_5 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.IDX_SREZ_OB22_5 ON BARS.SREZERV_OB22_5 (NBS, OB22, S080, CUSTTYPE, KV, NAL) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index XPK_SREZERVOB22_5 ***
begin   
 execute immediate '
    CREATE UNIQUE INDEX BARS.XPK_SREZERVOB22_5 ON BARS.SREZERV_OB22_5 (NBS, OB22, S080, CUSTTYPE, KV, PR, NAL)
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index XPK_SREZERVOB22_5 ***
begin   
 execute immediate '
    ALTER TABLE BARS.SREZERV_OB22_5 ADD (CONSTRAINT XPK_SREZERVOB22_5  PRIMARY KEY  (NBS, OB22, S080, CUSTTYPE, KV, PR, NAL)
    USING INDEX BARS.XPK_SREZERVOB22_5
    ENABLE VALIDATE)';
exception when others then
  if  sqlcode in (-955,-2260,-6512)  then null; else raise; end if;
 end;
/


PROMPT *** Create  grants  SREZERV_OB22_5 ***

grant SELECT                                                                 on SREZERV_OB22_5    to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SREZERV_OB22_5    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SREZERV_OB22_5    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SREZERV_OB22_5    to RCC_DEAL;
grant SELECT                                                                 on SREZERV_OB22_5    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SREZERV_OB22_5    to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SREZERV_OB22_5    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SREZERV_OB22_5.sql =========*** End *** 
PROMPT ===================================================================================== 
