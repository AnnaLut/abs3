

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_EXTENSION_METHOD.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_EXTENSION_METHOD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_EXTENSION_METHOD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_EXTENSION_METHOD'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_EXTENSION_METHOD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_EXTENSION_METHOD ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_EXTENSION_METHOD 
   (	METHOD NUMBER(38,0), 
	NAME VARCHAR2(250)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_EXTENSION_METHOD ***
 exec bpa.alter_policies('DPT_EXTENSION_METHOD');


COMMENT ON TABLE BARS.DPT_EXTENSION_METHOD IS 'Метод вычисления значения баз.%%-ной ставки при автопереоформлении вкладов';
COMMENT ON COLUMN BARS.DPT_EXTENSION_METHOD.METHOD IS 'Код метода';
COMMENT ON COLUMN BARS.DPT_EXTENSION_METHOD.NAME IS 'Наименование метода';




PROMPT *** Create  constraint PK_DPTEXTMETHOD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTENSION_METHOD ADD CONSTRAINT PK_DPTEXTMETHOD PRIMARY KEY (METHOD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTEXTMETHOD_METHOD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTENSION_METHOD MODIFY (METHOD CONSTRAINT CC_DPTEXTMETHOD_METHOD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTEXTMETHOD_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTENSION_METHOD MODIFY (NAME CONSTRAINT CC_DPTEXTMETHOD_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTEXTMETHOD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTEXTMETHOD ON BARS.DPT_EXTENSION_METHOD (METHOD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_EXTENSION_METHOD ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_EXTENSION_METHOD to ABS_ADMIN;
grant SELECT                                                                 on DPT_EXTENSION_METHOD to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_EXTENSION_METHOD to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_EXTENSION_METHOD to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_EXTENSION_METHOD to DPT_ADMIN;
grant SELECT                                                                 on DPT_EXTENSION_METHOD to START1;
grant SELECT                                                                 on DPT_EXTENSION_METHOD to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_EXTENSION_METHOD to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DPT_EXTENSION_METHOD to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_EXTENSION_METHOD.sql =========*** 
PROMPT ===================================================================================== 
