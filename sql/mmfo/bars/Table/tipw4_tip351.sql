PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TIPW4_TIP351.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TIPW4_TIP351 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TIPW4_TIP351'', ''FILIAL'' , null, null, null, null); 
               bpa.alter_policy_info(''TIPW4_TIP351'', ''WHOLE'' , null, null, null, null);  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TIPW4_TIP351 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TIPW4_TIP351 
   (TIPW4       CHAR(3),
    TIP351      CHAR(3)
   ) 
  TABLESPACE BRSSMLI ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to TIPW4_TIP351 ***
 exec bpa.alter_policies('TIPW4_TIP351');

COMMENT ON TABLE BARS.TIPW4_TIP351 IS 'Соответствие типов W4 <--> 351';
COMMENT ON COLUMN BARS.TIPW4_TIP351.TIPW4  IS 'Тип W4';
COMMENT ON COLUMN BARS.TIPW4_TIP351.TIP351 IS 'Тип 351';

PROMPT *** Create  constraint PK_TIPW4_TIP351 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TIPW4_TIP351 ADD CONSTRAINT PK_TIPW4_TIP351 PRIMARY KEY (TIPW4,TIP351)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  grants  TIPW4_TIP351 ***
grant SELECT                                                                 on TIPW4_TIP351         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TIPW4_TIP351         to RCC_DEAL;
grant SELECT                                                                 on TIPW4_TIP351         to START1;
grant SELECT                                                                 on TIPW4_TIP351         to UPLD;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TIPW4_TIP351.sql =========*** End *** =====
PROMPT ===================================================================================== 
