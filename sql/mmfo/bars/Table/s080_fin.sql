

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S080_FIN.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S080_FIN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''S080_FIN'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''S080_FIN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S080_FIN ***
begin 
  execute immediate '
  CREATE TABLE BARS.S080_FIN 
   (	S080 VARCHAR2(1), 
	TIP_FIN NUMBER(*,0), 
	FIN NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S080_FIN ***
 exec bpa.alter_policies('S080_FIN');


COMMENT ON TABLE BARS.S080_FIN IS 'Таблица определения s080 по фин.стану';
COMMENT ON COLUMN BARS.S080_FIN.S080 IS 'S080';
COMMENT ON COLUMN BARS.S080_FIN.TIP_FIN IS 'Тип фин.стана';
COMMENT ON COLUMN BARS.S080_FIN.FIN IS 'Фин.стан';




PROMPT *** Create  constraint PK_S080_FIN ***
begin   
 execute immediate '
  ALTER TABLE BARS.S080_FIN ADD CONSTRAINT PK_S080_FIN PRIMARY KEY (FIN, TIP_FIN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_S080_FIN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_S080_FIN ON BARS.S080_FIN (FIN, TIP_FIN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  S080_FIN ***
grant SELECT                                                                 on S080_FIN        to BARSREADER_ROLE;
grant SELECT                                                                 on S080_FIN        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S080_FIN        to RCC_DEAL;
grant SELECT                                                                 on S080_FIN        to START1;
grant SELECT                                                                 on S080_FIN        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S080_FIN.sql =========*** End *** ====
PROMPT ===================================================================================== 
