

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SP_S181.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SP_S181 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SP_S181'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SP_S181'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SP_S181 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SP_S181 
   (	S181 VARCHAR2(1), 
	TXT VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SP_S181 ***
 exec bpa.alter_policies('SP_S181');


COMMENT ON TABLE BARS.SP_S181 IS '������������� ����� ��������� (SP_S181)';
COMMENT ON COLUMN BARS.SP_S181.S181 IS '';
COMMENT ON COLUMN BARS.SP_S181.TXT IS '';



PROMPT *** Create  grants  SP_S181 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SP_S181         to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on SP_S181         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SP_S181         to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SP_S181         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SP_S181.sql =========*** End *** =====
PROMPT ===================================================================================== 
