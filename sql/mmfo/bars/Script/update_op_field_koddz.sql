begin
update op_field o set o.name = 'Код державної закупiвлi' where o.tag = 'KODDZ';
commit;
end;
/