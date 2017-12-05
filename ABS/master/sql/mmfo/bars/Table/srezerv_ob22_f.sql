PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SREZERV_OB22_F.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SREZERV_OB22_F ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SREZERV_OB22_F'', ''CENTER'' , null, null, null, null);
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

PROMPT *** Create  index XPK_SREZ_OB22_F ***

begin
  EXECUTE IMMEDIATE 
 'ALTER TABLE SREZERV_OB22_F ADD CONSTRAINT XPK_SREZERV_OB22_F PRIMARY KEY (NBS, OB22, S080, CUSTTYPE, KV, PR, NAL)';
exception when others then
  -- ORA-02260: table can have only one primary key
  if SQLCODE = -02260 then null;   else raise; end if; 
end;
/

PROMPT *** Create  grants  SREZERV_OB22_F ***
grant SELECT                                                                 on SREZERV_OB22_F    to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SREZERV_OB22_F    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SREZERV_OB22_F    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SREZERV_OB22_F    to RCC_DEAL;
grant SELECT                                                                 on SREZERV_OB22_F    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SREZERV_OB22_F    to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SREZERV_OB22_F    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SREZERV_OB22_F.sql =========*** End *** 
PROMPT ===================================================================================== 
