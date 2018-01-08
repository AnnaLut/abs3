

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SPR_MON.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SPR_MON ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SPR_MON'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SPR_MON'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SPR_MON'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SPR_MON ***
begin 
  execute immediate '
  CREATE TABLE BARS.SPR_MON 
   (	KOD_MONEY VARCHAR2(11), 
	NAMEMONEY VARCHAR2(100), 
	NAMEMETAL VARCHAR2(50), 
	NOMINAL NUMBER(14,2), 
	PRICE NUMBER(12,2), 
	PR_KUPON NUMBER(9,0), 
	PR_NO NUMBER(9,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SPR_MON ***
 exec bpa.alter_policies('SPR_MON');


COMMENT ON TABLE BARS.SPR_MON IS '';
COMMENT ON COLUMN BARS.SPR_MON.KOD_MONEY IS '';
COMMENT ON COLUMN BARS.SPR_MON.NAMEMONEY IS '';
COMMENT ON COLUMN BARS.SPR_MON.NAMEMETAL IS '';
COMMENT ON COLUMN BARS.SPR_MON.NOMINAL IS '';
COMMENT ON COLUMN BARS.SPR_MON.PRICE IS '';
COMMENT ON COLUMN BARS.SPR_MON.PR_KUPON IS '';
COMMENT ON COLUMN BARS.SPR_MON.PR_NO IS '';




PROMPT *** Create  constraint PK_SPRMON ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPR_MON ADD CONSTRAINT PK_SPRMON PRIMARY KEY (KOD_MONEY)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SPRMON ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SPRMON ON BARS.SPR_MON (KOD_MONEY) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SPR_MON ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SPR_MON         to ABS_ADMIN;
grant SELECT                                                                 on SPR_MON         to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on SPR_MON         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SPR_MON         to PYOD001;
grant INSERT,SELECT,UPDATE                                                   on SPR_MON         to TECH005;
grant SELECT                                                                 on SPR_MON         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SPR_MON.sql =========*** End *** =====
PROMPT ===================================================================================== 
