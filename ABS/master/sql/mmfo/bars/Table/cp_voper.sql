

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_VOPER.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_VOPER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_VOPER'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_VOPER'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_VOPER'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_VOPER ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_VOPER 
   (	ID VARCHAR2(2), 
	TITLE VARCHAR2(255)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_VOPER ***
 exec bpa.alter_policies('CP_VOPER');


COMMENT ON TABLE BARS.CP_VOPER IS 'Вид операції(ЦП)';
COMMENT ON COLUMN BARS.CP_VOPER.ID IS '';
COMMENT ON COLUMN BARS.CP_VOPER.TITLE IS '';




PROMPT *** Create  constraint PK_CP_VOPER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_VOPER ADD CONSTRAINT PK_CP_VOPER PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index U_CP_VOPER ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.U_CP_VOPER ON BARS.CP_VOPER (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_VOPER ***
grant SELECT                                                                 on CP_VOPER        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_VOPER        to CP_ROLE;
grant SELECT                                                                 on CP_VOPER        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_VOPER.sql =========*** End *** ====
PROMPT ===================================================================================== 
