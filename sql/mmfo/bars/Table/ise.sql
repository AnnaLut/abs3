

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ISE.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ISE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ISE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ISE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ISE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ISE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ISE 
   (	ISE CHAR(5), 
	NAME VARCHAR2(190), 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ISE ***
 exec bpa.alter_policies('ISE');


COMMENT ON TABLE BARS.ISE IS 'Справочник секторов экономики';
COMMENT ON COLUMN BARS.ISE.ISE IS 'Код сектора';
COMMENT ON COLUMN BARS.ISE.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.ISE.D_CLOSE IS '';




PROMPT *** Create  constraint SYS_C005458 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ISE MODIFY (ISE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ISE_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ISE MODIFY (NAME CONSTRAINT CC_ISE_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ISE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ISE ADD CONSTRAINT PK_ISE PRIMARY KEY (ISE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ISE_DCLOSE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ISE ADD CONSTRAINT CC_ISE_DCLOSE CHECK (d_close = trunc(d_close)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ISE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ISE ON BARS.ISE (ISE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ISE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ISE             to ABS_ADMIN;
grant SELECT                                                                 on ISE             to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ISE             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ISE             to BARS_DM;
grant SELECT                                                                 on ISE             to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on ISE             to ISE;
grant SELECT                                                                 on ISE             to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ISE             to WR_ALL_RIGHTS;
grant SELECT                                                                 on ISE             to WR_CUSTREG;
grant FLASHBACK,SELECT                                                       on ISE             to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ISE.sql =========*** End *** =========
PROMPT ===================================================================================== 
