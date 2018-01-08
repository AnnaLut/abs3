

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_ALL.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_ALL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_ALL'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''FIN_ALL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_ALL ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_ALL 
   (	X0 NUMBER(*,0), 
	X1 NUMBER(*,0), 
	X2 NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_ALL ***
 exec bpa.alter_policies('FIN_ALL');


COMMENT ON TABLE BARS.FIN_ALL IS 'Зіставність класів';
COMMENT ON COLUMN BARS.FIN_ALL.X0 IS 'Тип фін стану: 0 - фін.стан 1- 2';
COMMENT ON COLUMN BARS.FIN_ALL.X1 IS 'Тип фін стану: 1 - фін.стан 1- 5';
COMMENT ON COLUMN BARS.FIN_ALL.X2 IS 'Тип фін стану: 2 - фін.стан 1-10';




PROMPT *** Create  constraint PK_FIN_ALL ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_ALL ADD CONSTRAINT PK_FIN_ALL PRIMARY KEY (X2)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FIN_ALL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FIN_ALL ON BARS.FIN_ALL (X2) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_ALL ***
grant SELECT                                                                 on FIN_ALL         to BARSREADER_ROLE;
grant SELECT                                                                 on FIN_ALL         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_ALL         to RCC_DEAL;
grant SELECT                                                                 on FIN_ALL         to START1;
grant SELECT                                                                 on FIN_ALL         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_ALL.sql =========*** End *** =====
PROMPT ===================================================================================== 
