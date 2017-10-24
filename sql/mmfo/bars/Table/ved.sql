

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VED.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VED ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''VED'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''VED'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''VED'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VED ***
begin 
  execute immediate '
  CREATE TABLE BARS.VED 
   (	VED CHAR(5), 
	NAME VARCHAR2(144), 
	OELIST VARCHAR2(110), 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to VED ***
 exec bpa.alter_policies('VED');


COMMENT ON TABLE BARS.VED IS 'Вид экономической деятельности';
COMMENT ON COLUMN BARS.VED.VED IS 'Код';
COMMENT ON COLUMN BARS.VED.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.VED.OELIST IS '';
COMMENT ON COLUMN BARS.VED.D_CLOSE IS 'Дата закрытия';




PROMPT *** Create  constraint PK_VED ***
begin   
 execute immediate '
  ALTER TABLE BARS.VED ADD CONSTRAINT PK_VED PRIMARY KEY (VED)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_VED_DCLOSE ***
begin   
 execute immediate '
  ALTER TABLE BARS.VED ADD CONSTRAINT CC_VED_DCLOSE CHECK (d_close = trunc(d_close)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005142 ***
begin   
 execute immediate '
  ALTER TABLE BARS.VED MODIFY (VED NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_VED_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.VED MODIFY (NAME CONSTRAINT CC_VED_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_VED ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_VED ON BARS.VED (VED) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  VED ***
grant DELETE,INSERT,SELECT,UPDATE                                            on VED             to ABS_ADMIN;
grant SELECT                                                                 on VED             to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on VED             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VED             to BARS_DM;
grant SELECT                                                                 on VED             to CUST001;
grant SELECT                                                                 on VED             to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on VED             to VED;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on VED             to WR_ALL_RIGHTS;
grant SELECT                                                                 on VED             to WR_CUSTREG;
grant FLASHBACK,SELECT                                                       on VED             to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VED.sql =========*** End *** =========
PROMPT ===================================================================================== 
