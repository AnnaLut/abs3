----------------------- Таблица дат квитовки

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KWT_D_2924.sql =========*** Run *** ==
PROMPT ===================================================================================== 



PROMPT *** ALTER_POLICY_INFO to KWT_D_2924 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KWT_D_2924'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KWT_D_2924'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KWT_D_2924 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KWT_D_2924 
   (	DAT_SYS DATE, 
	DAT_KWT DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KWT_D_2924 ***
 exec bpa.alter_policies('KWT_D_2924');


COMMENT ON TABLE BARS.KWT_D_2924 IS '';
COMMENT ON COLUMN BARS.KWT_D_2924.DAT_SYS IS '';
COMMENT ON COLUMN BARS.KWT_D_2924.DAT_KWT IS '';


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KWT_D_2924.sql =========*** End *** ==
PROMPT ===================================================================================== 