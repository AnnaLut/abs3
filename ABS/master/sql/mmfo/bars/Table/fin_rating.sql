

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_RATING.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_RATING ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_RATING'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''FIN_RATING'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_RATING ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_RATING 
   (	TIP_FIN NUMBER(*,0), 
	FIN NUMBER(*,0), 
	RATING NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_RATING ***
 exec bpa.alter_policies('FIN_RATING');


COMMENT ON TABLE BARS.FIN_RATING IS 'Діючі угоди';
COMMENT ON COLUMN BARS.FIN_RATING.TIP_FIN IS 'Тип фін стану: 0 - фін.стан 1-2,  1 - фін.стан 1-5, 0 - фін.стан 1-10';
COMMENT ON COLUMN BARS.FIN_RATING.FIN IS 'Фін.стан';
COMMENT ON COLUMN BARS.FIN_RATING.RATING IS 'Рейтинг';




PROMPT *** Create  constraint PK_FIN_RATING ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_RATING ADD CONSTRAINT PK_FIN_RATING PRIMARY KEY (TIP_FIN, FIN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FIN_RATING ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FIN_RATING ON BARS.FIN_RATING (TIP_FIN, FIN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_RATING ***
grant SELECT                                                                 on FIN_RATING      to BARSREADER_ROLE;
grant SELECT                                                                 on FIN_RATING      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_RATING      to RCC_DEAL;
grant SELECT                                                                 on FIN_RATING      to START1;
grant SELECT                                                                 on FIN_RATING      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_RATING.sql =========*** End *** ==
PROMPT ===================================================================================== 
