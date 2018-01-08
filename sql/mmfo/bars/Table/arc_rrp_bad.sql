

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ARC_RRP_BAD.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ARC_RRP_BAD ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ARC_RRP_BAD ***
begin 
  execute immediate '
  CREATE TABLE BARS.ARC_RRP_BAD 
   (	REC NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ARC_RRP_BAD ***
 exec bpa.alter_policies('ARC_RRP_BAD');


COMMENT ON TABLE BARS.ARC_RRP_BAD IS '';
COMMENT ON COLUMN BARS.ARC_RRP_BAD.REC IS '';



PROMPT *** Create  grants  ARC_RRP_BAD ***
grant SELECT                                                                 on ARC_RRP_BAD     to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ARC_RRP_BAD.sql =========*** End *** =
PROMPT ===================================================================================== 
