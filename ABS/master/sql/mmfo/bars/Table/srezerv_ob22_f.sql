

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SREZERV_OB22_F.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SREZERV_OB22_F ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SREZERV_OB22_F'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SREZERV_OB22_F'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SREZERV_OB22_F ***
begin 
  execute immediate '
  CREATE TABLE BARS.SREZERV_OB22_F 
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




PROMPT *** ALTER_POLICIES to SREZERV_OB22_F ***
 exec bpa.alter_policies('SREZERV_OB22_F');


COMMENT ON TABLE BARS.SREZERV_OB22_F IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_F.NBS IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_F.OB22 IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_F.S080 IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_F.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_F.KV IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_F.NBS_REZ IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_F.OB22_REZ IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_F.NBS_7F IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_F.OB22_7F IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_F.NBS_7R IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_F.OB22_7R IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_F.PR IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_F.NAL IS '';
COMMENT ON COLUMN BARS.SREZERV_OB22_F.R013 IS '';




PROMPT *** Create  constraint XPK_SREZERV_OB22_F ***
begin   
 execute immediate '
  ALTER TABLE BARS.SREZERV_OB22_F ADD CONSTRAINT XPK_SREZERV_OB22_F PRIMARY KEY (NBS, OB22, S080, CUSTTYPE, KV, PR, NAL)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_SREZERV_OB22_F ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_SREZERV_OB22_F ON BARS.SREZERV_OB22_F (NBS, OB22, S080, CUSTTYPE, KV, PR, NAL) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SREZERV_OB22_F ***
grant SELECT                                                                 on SREZERV_OB22_F  to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SREZERV_OB22_F  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SREZERV_OB22_F  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SREZERV_OB22_F  to RCC_DEAL;
grant SELECT                                                                 on SREZERV_OB22_F  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SREZERV_OB22_F  to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SREZERV_OB22_F  to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SREZERV_OB22_F.sql =========*** End **
PROMPT ===================================================================================== 
