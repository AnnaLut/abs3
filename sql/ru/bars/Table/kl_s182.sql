

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_S182.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_S182 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_S182'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S182'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_S182 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_S182 
   (	S182 CHAR(1), 
	TXT VARCHAR2(48)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_S182 ***
 exec bpa.alter_policies('KL_S182');


COMMENT ON TABLE BARS.KL_S182 IS '������������� ��� (KL_S182)';
COMMENT ON COLUMN BARS.KL_S182.S182 IS '';
COMMENT ON COLUMN BARS.KL_S182.TXT IS '';



PROMPT *** Create  grants  KL_S182 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_S182         to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_S182         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_S182         to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_S182         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_S182.sql =========*** End *** =====
PROMPT ===================================================================================== 
