

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_RATING.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_RATING ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CCK_RATING'', ''CENTER'' , ''C'', ''C'', ''C'', null);
               bpa.alter_policy_info(''CCK_RATING'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CCK_RATING'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_RATING ***
begin 
  execute immediate '
  CREATE TABLE BARS.CCK_RATING 
   (	CODE VARCHAR2(4), 
	ORD NUMBER(*,0), 
	MIN NUMBER, 
	MAX NUMBER, 
	I_MIN NUMBER, 
	I_MAX NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_RATING ***
 exec bpa.alter_policies('CCK_RATING');


COMMENT ON TABLE BARS.CCK_RATING IS 'Внутрiшнiй кредитний ризик позичальника';
COMMENT ON COLUMN BARS.CCK_RATING.CODE IS 'Код';
COMMENT ON COLUMN BARS.CCK_RATING.ORD IS 'Вага';
COMMENT ON COLUMN BARS.CCK_RATING.MIN IS 'Мінімальне значення балів';
COMMENT ON COLUMN BARS.CCK_RATING.MAX IS 'Махимальне значення балів';
COMMENT ON COLUMN BARS.CCK_RATING.I_MIN IS 'Мінімальне значення балів інвестпроети';
COMMENT ON COLUMN BARS.CCK_RATING.I_MAX IS 'Махимальне значення балів інвестпроети';




PROMPT *** Create  constraint CCK_RATING_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_RATING ADD CONSTRAINT CCK_RATING_PK PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index CCK_RATING_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.CCK_RATING_PK ON BARS.CCK_RATING (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_CCKRATING_ORD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.IDX_CCKRATING_ORD ON BARS.CCK_RATING (ORD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CCK_RATING ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CCK_RATING      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CCK_RATING      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_RATING      to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CCK_RATING      to START1;
grant FLASHBACK,SELECT                                                       on CCK_RATING      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_RATING.sql =========*** End *** ==
PROMPT ===================================================================================== 
