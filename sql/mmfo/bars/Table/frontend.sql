

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FRONTEND.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FRONTEND ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FRONTEND'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FRONTEND'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''FRONTEND'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FRONTEND ***
begin 
  execute immediate '
  CREATE TABLE BARS.FRONTEND 
   (	FID NUMBER(38,0), 
	FNAME VARCHAR2(64)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FRONTEND ***
 exec bpa.alter_policies('FRONTEND');


COMMENT ON TABLE BARS.FRONTEND IS 'Типы фронтальных интерфейсов к БД (Centura,Web,Mobile)';
COMMENT ON COLUMN BARS.FRONTEND.FID IS 'Идентификатор фронтального интерфейса';
COMMENT ON COLUMN BARS.FRONTEND.FNAME IS 'Имя фронтального интерфейса';




PROMPT *** Create  constraint PK_FRONTEND ***
begin   
 execute immediate '
  ALTER TABLE BARS.FRONTEND ADD CONSTRAINT PK_FRONTEND PRIMARY KEY (FID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FRONTEND_FID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FRONTEND MODIFY (FID CONSTRAINT CC_FRONTEND_FID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FRONTEND_FNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FRONTEND MODIFY (FNAME CONSTRAINT CC_FRONTEND_FNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FRONTEND ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FRONTEND ON BARS.FRONTEND (FID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FRONTEND ***
grant DELETE,INSERT,SELECT,UPDATE                                            on FRONTEND        to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FRONTEND        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FRONTEND        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FRONTEND        to FRONTEND;
grant SELECT                                                                 on FRONTEND        to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FRONTEND        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on FRONTEND        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FRONTEND.sql =========*** End *** ====
PROMPT ===================================================================================== 
