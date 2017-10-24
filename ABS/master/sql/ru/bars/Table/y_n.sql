

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/Y_N.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to Y_N ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''Y_N'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''Y_N'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table Y_N ***
begin 
  execute immediate '
  CREATE TABLE BARS.Y_N 
   (	ID NUMBER(*,0), 
	NAME VARCHAR2(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to Y_N ***
 exec bpa.alter_policies('Y_N');


COMMENT ON TABLE BARS.Y_N IS 'Так-Ні';
COMMENT ON COLUMN BARS.Y_N.ID IS 'ID';
COMMENT ON COLUMN BARS.Y_N.NAME IS 'Назва';



PROMPT *** Create  grants  Y_N ***
grant SELECT                                                                 on Y_N             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on Y_N             to RCC_DEAL;
grant SELECT                                                                 on Y_N             to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/Y_N.sql =========*** End *** =========
PROMPT ===================================================================================== 
