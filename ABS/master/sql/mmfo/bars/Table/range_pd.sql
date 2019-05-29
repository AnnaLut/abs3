PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RANGE_PD.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RANGE_PD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RANGE_PD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''RANGE_PD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RANGE_PD ***                    
begin 
  execute immediate '
  CREATE TABLE BARS.RANGE_PD 
   (    tip     NUMBER,
   	fin     NUMBER, 
        tip_fin NUMBER, 
	rz      NUMBER, 
	min     NUMBER,
        max     NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to RANGE_PD ***
 exec bpa.alter_policies('RANGE_PD');

COMMENT ON TABLE BARS.RANGE_PD IS 'Таблица диапазонов PD';
COMMENT ON COLUMN BARS.RANGE_PD.TIP IS 'Тип актива';
COMMENT ON COLUMN BARS.RANGE_PD.FIN IS 'Фин.клас';
COMMENT ON COLUMN BARS.RANGE_PD.TIP_FIN IS 'Тип фин.стана 0-(1,2); 1-(1-5); 2-(1-10)';
COMMENT ON COLUMN BARS.RANGE_PD.RZ IS 'Резидентность';
COMMENT ON COLUMN BARS.RANGE_PD.MIN IS 'Минимальное значение';
COMMENT ON COLUMN BARS.RANGE_PD.MAX IS 'Максимальное значение';

PROMPT *** Create  constraint PK_RANGE_PD ***
begin   
 execute immediate '
  ALTER TABLE BARS.RANGE_PD ADD CONSTRAINT PK_RANGE_PD PRIMARY KEY (TIP, FIN, tip_fin, RZ)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  index PK_RANGE_PD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_RANGE_PD ON BARS.RANGE_PD (TIP, FIN, tip_fin, RZ) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RANGE_PD ***
grant SELECT                                                                 on RANGE_PD    to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on RANGE_PD    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on RANGE_PD    to RCC_DEAL;
grant DELETE,INSERT,SELECT,UPDATE                                            on RANGE_PD    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RANGE_PD.sql =========*** End *** 
PROMPT ===================================================================================== 
