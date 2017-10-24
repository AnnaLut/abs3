

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/D_KWT_2924.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to D_KWT_2924 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''D_KWT_2924'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''D_KWT_2924'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table D_KWT_2924 ***
begin 
  execute immediate '
  CREATE TABLE BARS.D_KWT_2924 
   (	DAT_SYS DATE, 
	DAT_KWT DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to D_KWT_2924 ***
 exec bpa.alter_policies('D_KWT_2924');


COMMENT ON TABLE BARS.D_KWT_2924 IS '';
COMMENT ON COLUMN BARS.D_KWT_2924.DAT_SYS IS '';
COMMENT ON COLUMN BARS.D_KWT_2924.DAT_KWT IS '';



PROMPT *** Create  grants  D_KWT_2924 ***
grant SELECT                                                                 on D_KWT_2924      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/D_KWT_2924.sql =========*** End *** ==
PROMPT ===================================================================================== 
