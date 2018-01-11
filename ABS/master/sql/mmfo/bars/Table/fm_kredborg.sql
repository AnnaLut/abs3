

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FM_KREDBORG.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FM_KREDBORG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FM_KREDBORG'', ''CENTER'' , ''C'', ''C'', ''C'', null);
               bpa.alter_policy_info(''FM_KREDBORG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FM_KREDBORG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FM_KREDBORG ***
begin 
  execute immediate '
  CREATE TABLE BARS.FM_KREDBORG 
   (	CODE NUMBER, 
	NAME VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FM_KREDBORG ***
 exec bpa.alter_policies('FM_KREDBORG');


COMMENT ON TABLE BARS.FM_KREDBORG IS 'ФМ. Обсяг кредитного боргу';
COMMENT ON COLUMN BARS.FM_KREDBORG.CODE IS 'Код';
COMMENT ON COLUMN BARS.FM_KREDBORG.NAME IS 'Назва';




PROMPT *** Create  index PK_FMKREDBORG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FMKREDBORG ON BARS.FM_KREDBORG (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FM_KREDBORG ***
grant SELECT                                                                 on FM_KREDBORG     to BARSREADER_ROLE;
grant SELECT                                                                 on FM_KREDBORG     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FM_KREDBORG     to BARS_DM;
grant SELECT                                                                 on FM_KREDBORG     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FM_KREDBORG.sql =========*** End *** =
PROMPT ===================================================================================== 
