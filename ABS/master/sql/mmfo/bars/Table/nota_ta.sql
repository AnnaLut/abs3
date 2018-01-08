

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NOTA_TA.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NOTA_TA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NOTA_TA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''NOTA_TA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NOTA_TA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NOTA_TA ***
begin 
  execute immediate '
  CREATE TABLE BARS.NOTA_TA 
   (	ID NUMBER(*,0), 
	TYPA VARCHAR2(64)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NOTA_TA ***
 exec bpa.alter_policies('NOTA_TA');


COMMENT ON TABLE BARS.NOTA_TA IS 'Типи акредитацій нотаріуса';
COMMENT ON COLUMN BARS.NOTA_TA.ID IS 'Iдентифікатор';
COMMENT ON COLUMN BARS.NOTA_TA.TYPA IS 'Тип';



PROMPT *** Create  grants  NOTA_TA ***
grant SELECT                                                                 on NOTA_TA         to BARSREADER_ROLE;
grant SELECT                                                                 on NOTA_TA         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NOTA_TA         to BARS_DM;
grant SELECT                                                                 on NOTA_TA         to START1;
grant SELECT                                                                 on NOTA_TA         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NOTA_TA.sql =========*** End *** =====
PROMPT ===================================================================================== 
